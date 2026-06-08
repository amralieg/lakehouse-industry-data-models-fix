-- Schema for Domain: workforce | Business: Pharmaceuticals | Version: v1_ecm
-- Generated on: 2026-05-05 17:50:38

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `pharmaceuticals_ecm`.`workforce` COMMENT 'Manages human resources data including employee master data, organizational structure, talent acquisition, performance management, compensation, benefits, payroll, and training. Tracks GCP, GMP, and GLP training records for regulated personnel, certifications, competencies, and role-based access for quality-critical functions. Supports workforce planning and audit readiness for FDA/EMA inspections.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record. Primary key for the employee master data product. Serves as the single source of truth for workforce identity across all domains including clinical trials, manufacturing, quality, and regulatory functions.',
    `created_by_user_employee_id` BIGINT COMMENT 'User identifier of the person or system that created this employee record. Required for complete audit trail per 21 CFR Part 11 and GDPR accountability principle.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Employment contracts are with specific legal entities - required for tax reporting, statutory compliance, labor law jurisdiction, and corporate structure reporting. Creates new FK as no existing colum',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person or system that last modified this employee record. Part of the complete audit trail for regulatory compliance and data governance.',
    `manager_employee_id` BIGINT COMMENT 'Reference to the employee record of the direct manager or supervisor. Establishes reporting hierarchy for approval workflows, performance management, and training assignment escalation.',
    `plant_id` BIGINT COMMENT 'Reference to the primary physical site or facility where the employee is based. Critical for site-specific GMP training, emergency response planning, and regulatory inspection readiness. Links to manufacturing plants, R&D labs, clinical sites, or corporate offices.',
    `background_check_date` DATE COMMENT 'Date of the most recent background check completion. Used to determine when periodic re-screening is due per company policy and regulatory requirements.',
    `background_check_status` STRING COMMENT 'Status of pre-employment or periodic background screening. Cleared status is required for roles with access to controlled substances, financial systems (SOX), or patient data (HIPAA). Failed status prevents hiring or triggers termination.. Valid values are `not_required|pending|cleared|failed|expired`',
    `citizenship_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the employees citizenship. Used for work authorization verification, export control compliance (ITAR, EAR), and visa/immigration tracking for international assignments.. Valid values are `^[A-Z]{3}$`',
    `cost_center` STRING COMMENT 'Financial cost center code for charging employee compensation and expenses. Used for P&L reporting, project costing, and SOX financial controls. Sourced from SAP FI Controlling module.. Valid values are `^[0-9]{6,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was first created in the system. Part of the audit trail required for 21 CFR Part 11 electronic records compliance and SOX internal controls.',
    `date_of_birth` DATE COMMENT 'Employees date of birth. Used for age verification, benefits eligibility, retirement planning, and identity verification in electronic signature workflows. Highly sensitive personal data requiring restricted access.',
    `email_address` STRING COMMENT 'Primary corporate email address for business communications, system access notifications, training assignments, and electronic signature workflows. Serves as unique identifier in many enterprise systems.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employee_number` STRING COMMENT 'Human-readable business identifier assigned to the employee by HR systems. Used for payroll, timekeeping, and external reporting. Typically sourced from SAP HR Personnel Number field.. Valid values are `^[A-Z0-9]{6,12}$`',
    `employment_status` STRING COMMENT 'Current lifecycle status of the employee within the organization. Active employees have full system access and training obligations. Inactive or terminated employees trigger access revocation workflows per SOX and GxP requirements.. Valid values are `active|inactive|leave_of_absence|suspended|terminated`',
    `employment_type` STRING COMMENT 'Classification of employment arrangement. CRO-seconded staff are Contract Research Organization personnel working on-site who require GCP training and system access but remain employed by the CRO. Critical for determining training requirements, access levels, and regulatory accountability.. Valid values are `full_time|part_time|contract|temporary|intern|cro_seconded`',
    `first_name` STRING COMMENT 'Legal first name (given name) of the employee as recorded in official identity documents. Required for regulatory submissions, audit trails, and GCP/GMP/GLP training records.',
    `hire_date` DATE COMMENT 'Date the employee officially started employment with the organization. Used to calculate tenure, benefits eligibility, and training recertification cycles. Critical for audit trail and employment verification.',
    `is_gcp_qualified` BOOLEAN COMMENT 'Indicates whether the employee is currently qualified to perform GCP-regulated clinical trial activities per ICH E6(R2) guidelines. True if all required GCP training is current and documented. Used to control access to clinical trial systems (CTMS, EDC, eTMF) and determine eligibility for clinical roles.',
    `is_glp_qualified` BOOLEAN COMMENT 'Indicates whether the employee is currently qualified to perform GLP-regulated nonclinical laboratory studies per FDA 21 CFR Part 58 and OECD GLP principles. True if all required GLP training is current. Used to determine eligibility for preclinical study roles and LIMS access.',
    `is_gmp_qualified` BOOLEAN COMMENT 'Indicates whether the employee is currently qualified to perform GMP-regulated manufacturing and quality activities per 21 CFR Parts 210/211 and EU GMP Annex 11. True if all required cGMP training is current. Controls access to manufacturing execution systems (MES), batch records, and quality systems.',
    `is_people_manager` BOOLEAN COMMENT 'Indicates whether the employee has direct reports and managerial responsibilities. True if the employee manages one or more subordinates. Used to determine eligibility for management training programs and approval authority levels.',
    `is_quality_critical_role` BOOLEAN COMMENT 'Indicates whether the employee holds a quality-critical function requiring enhanced training documentation, competency assessment, and audit readiness per ICH Q10 and ISO 9001. Includes QA/QC personnel, Qualified Persons, and individuals with batch release authority.',
    `job_code` STRING COMMENT 'Standardized job classification code from HR system. Maps to compensation bands, competency frameworks, and training matrices. Typically sourced from SAP Organizational Management job catalog.. Valid values are `^[A-Z0-9]{4,10}$`',
    `job_family` STRING COMMENT 'Broad occupational category grouping similar roles (e.g., Research & Development, Quality Assurance, Manufacturing Operations, Clinical Operations, Regulatory Affairs). Used for workforce planning and skills gap analysis.',
    `job_title` STRING COMMENT 'Official job title assigned to the employee. Used for organizational charts, role-based access control (RBAC), and determining applicable GxP training curricula.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this employee record. Used to track data currency and support change control processes required for GxP systems.',
    `last_name` STRING COMMENT 'Legal last name (family name or surname) of the employee. Critical for identity verification, regulatory audit trails, and electronic signature validation per 21 CFR Part 11.',
    `last_performance_review_date` DATE COMMENT 'Date of the employees most recent formal performance review. Used to schedule upcoming reviews and ensure compliance with performance management cycles.',
    `last_promotion_date` DATE COMMENT 'Date of the employees most recent promotion or job grade increase. Used for career progression analytics, retention risk modeling, and compensation planning.',
    `last_transfer_date` DATE COMMENT 'Date of the employees most recent lateral transfer to a different department, site, or role. Used to track internal mobility and trigger site-specific training reassessments.',
    `middle_name` STRING COMMENT 'Middle name or initial of the employee. Optional field used for complete legal name representation in regulatory documentation.',
    `mobile_phone_number` STRING COMMENT 'Personal or corporate mobile phone number. Used for emergency notifications, on-call schedules, and multi-factor authentication for system access.',
    `national_id_number` STRING COMMENT 'Government-issued national identification number (e.g., Social Security Number in US, National Insurance Number in UK). Used for tax reporting, benefits administration, and background checks. Highly restricted access per data privacy regulations.',
    `performance_rating` STRING COMMENT 'Most recent annual performance appraisal rating. Used for compensation decisions, promotion eligibility, and identifying training needs. Confidential data with restricted access per HR policy.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_rated`',
    `preferred_name` STRING COMMENT 'Name the employee prefers to be called in day-to-day business interactions. Used for internal communications, badges, and non-regulatory systems.',
    `regulatory_role_flag` STRING COMMENT 'Identifies employees holding specific regulatory-defined roles with legal accountability. Qualified Person (EU) and Authorized Person (US) have batch release authority. Study Director oversees GLP studies. Principal Investigator leads clinical trials. Used for regulatory submissions and inspection readiness.. Valid values are `none|qualified_person|authorized_person|responsible_pharmacist|study_director|principal_investigator`',
    `security_clearance_level` STRING COMMENT 'Highest level of security clearance granted to the employee for access to classified or highly sensitive information. Relevant for employees working on government contracts, controlled substances (DEA schedules), or proprietary research with national security implications.. Valid values are `none|basic|confidential|secret|top_secret`',
    `termination_date` DATE COMMENT 'Date the employees employment ended. Triggers immediate system access revocation per 21 CFR Part 11 and SOX requirements. Null for active employees. Used for retention period calculations and audit history.',
    `termination_reason_code` STRING COMMENT 'Standardized code indicating the reason for employment termination. Used for workforce analytics, turnover reporting, and compliance with labor regulations. Null for active employees.. Valid values are `voluntary_resignation|retirement|involuntary_termination|end_of_contract|layoff|death`',
    `work_authorization_expiry_date` DATE COMMENT 'Date when the employees work authorization (visa, permit) expires. Null for citizens and permanent residents. Used to trigger renewal workflows and prevent unauthorized work.',
    `work_authorization_status` STRING COMMENT 'Current status of the employees legal authorization to work in the work country. Critical for compliance with immigration laws and export control regulations. Expired status triggers HR review and potential access suspension.. Valid values are `citizen|permanent_resident|work_visa|pending|expired`',
    `work_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the employee primarily works. Determines applicable labor laws, tax jurisdictions, and regulatory training requirements (FDA vs EMA vs PMDA). Used for global workforce reporting and compliance.. Valid values are `^[A-Z]{3}$`',
    `work_phone_number` STRING COMMENT 'Primary business telephone number for the employee. Used for internal directory, emergency contact during business hours, and audit communication.',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Master record for all personnel at Pharmaceuticals including full-time, part-time, contract, and CRO-seconded staff. Captures personal details, employment status, job classification, department assignment, site location, hire date, termination date, employment type, regulatory role flags (GCP/GMP/GLP-qualified), manager reference, HR system identifiers, and complete lifecycle movement history (promotions, transfers, site relocations, secondments, role changes, organizational restructuring events with effective dates, reason codes, and approver audit trail). Serves as the SSOT for workforce identity and career history across all domains and the anchor entity for training compliance, access control, and regulatory inspection queries.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`department` (
    `department_id` BIGINT COMMENT 'Unique identifier for the department. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is the head or manager of the department. Supports organizational hierarchy and reporting structure.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Departments map to organizational units for enterprise structure alignment, cross-functional reporting, and consolidation hierarchies. Creates new FK to link workforce departments to masterdata organi',
    `parent_department_id` BIGINT COMMENT 'Reference to the parent department in the organizational hierarchy. Enables multi-level organizational structure representation.',
    `budget_amount_annual` DECIMAL(18,2) COMMENT 'Total annual operating budget allocated to the department in the companys reporting currency. Includes personnel, operational, and capital expenses.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the departments budget amount.. Valid values are `^[A-Z]{3}$`',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity to which the department belongs. Supports multi-entity financial consolidation.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_code` STRING COMMENT 'Financial cost center code associated with the department for budgeting, expense tracking, and financial reporting. Aligns with SAP Controlling (CO) module.. Valid values are `^[A-Z0-9]{4,12}$`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the department is primarily located. Supports geographic reporting and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the department record was first created in the system. Supports audit trail and data lineage.',
    `csv_scope_flag` BOOLEAN COMMENT 'Indicates whether the department uses computerized systems that require validation under 21 CFR Part 11 and CSV guidelines. Drives system qualification and audit requirements.',
    `department_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the department within the organizational structure. Used for reporting and system integration.. Valid values are `^[A-Z0-9]{2,10}$`',
    `department_description` STRING COMMENT 'Detailed description of the departments purpose, responsibilities, and scope of work. Provides business context for organizational understanding.',
    `department_name` STRING COMMENT 'Full official name of the department, division, or functional unit.',
    `department_status` STRING COMMENT 'Current operational status of the department. Tracks lifecycle from planning through active operation to closure.. Valid values are `active|inactive|planned|closed|suspended`',
    `department_type` STRING COMMENT 'Classification of the organizational unit type. Distinguishes between departments, divisions, functional groups, sites, cost centers, and business units.. Valid values are `department|division|function|site|cost_center|business_unit`',
    `effective_end_date` DATE COMMENT 'Date when the department ceased or will cease operations. Null for currently active departments. Supports organizational history tracking.',
    `effective_start_date` DATE COMMENT 'Date when the department became or will become operational. Supports time-based organizational reporting and historical analysis.',
    `functional_area` STRING COMMENT 'Primary business function or domain that the department supports. Aligns with core pharmaceutical business processes.. Valid values are `research_discovery|clinical_development|regulatory_affairs|manufacturing|quality|supply_chain|[ENUM-REF-CANDIDATE: research_discovery|clinical_development|regulatory_affairs|manufacturing|quality|supply_chain|commercial|pharmacovigilance|medical_affairs|finance|procurement|human_resources|intellectual_property|market_access — promote to reference product]`',
    `gmp_critical_flag` BOOLEAN COMMENT 'Indicates whether the department performs GMP-critical manufacturing or quality control functions subject to regulatory inspection and validation requirements.',
    `gxp_regulated_flag` BOOLEAN COMMENT 'Indicates whether the department performs GxP-regulated activities requiring compliance with Good Manufacturing Practice (GMP), Good Clinical Practice (GCP), or Good Laboratory Practice (GLP). Drives training, audit, and qualification requirements.',
    `headcount_actual` STRING COMMENT 'Current actual number of full-time equivalent (FTE) employees assigned to the department. Updated as employees join or leave.',
    `headcount_planned` STRING COMMENT 'Planned or budgeted number of full-time equivalent (FTE) employees for the department. Used for workforce planning and budget allocation.',
    `profit_center_code` STRING COMMENT 'Profit center code for departments that are treated as independent profit-generating units. Used for Profit and Loss (P&L) reporting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `region_code` STRING COMMENT 'Geographic region code for the department. Supports regional organizational structures and reporting (e.g., NORAM, EMEA, APAC, LATAM).. Valid values are `^[A-Z]{2,6}$`',
    `short_name` STRING COMMENT 'Abbreviated name of the department for display in reports and user interfaces.',
    `site_location_code` STRING COMMENT 'Code identifying the physical site or facility where the department is located. Supports multi-site organizational structures.. Valid values are `^[A-Z]{3}[0-9]{2,4}$`',
    `sox_scope_flag` BOOLEAN COMMENT 'Indicates whether the department is in scope for Sarbanes-Oxley Act compliance and internal controls over financial reporting. Drives audit and control testing requirements.',
    `therapeutic_area` STRING COMMENT 'Primary therapeutic area alignment for departments involved in research, clinical development, or commercial operations. Supports portfolio and pipeline management.. Valid values are `oncology|immunology|rare_diseases|cardiovascular|neuroscience|infectious_diseases|[ENUM-REF-CANDIDATE: oncology|immunology|rare_diseases|cardiovascular|neuroscience|infectious_diseases|respiratory|metabolic|dermatology|ophthalmology — promote to reference product]`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the department record was last modified. Supports change tracking and audit trail.',
    CONSTRAINT pk_department PRIMARY KEY(`department_id`)
) COMMENT 'Organizational unit hierarchy master representing departments, divisions, cost centers, and functional groups within Pharmaceuticals. Captures unit name, unit type (department, division, function, site), parent unit, cost center code, site location, therapeutic area alignment, and effective dates. Supports organizational reporting and workforce planning. Aligns with SAP S/4HANA organizational management.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the authorized position. Primary key. This represents a headcount slot in the organizational structure, distinct from the employee who may fill it.',
    `employee_id` BIGINT COMMENT 'Reference to the employee (typically senior management or HR leadership) who approved the creation or modification of this position. Used for accountability and audit trail.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Positions are budgeted to specific cost centers for financial planning, headcount cost allocation, and budget variance analysis. Creates new FK to replace denormalized cost_center_code with proper ref',
    `department_id` BIGINT COMMENT 'Reference to the department or organizational unit to which this position is assigned. Links to organizational hierarchy for reporting structure and cost center allocation.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Position should reference its job profile definition. Position currently has job_profile_reference as a STRING, but this should be a proper FK for referential integrity. This is a core normalization o',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Positions exist within organizational units for organizational design, reporting structure definition, and workforce planning. Creates new FK to establish org unit context for position management.',
    `reports_to_position_id` BIGINT COMMENT 'Reference to the supervisory position to which this position reports. Defines the reporting line in the organizational hierarchy. Nullable for top-level executive positions.',
    `site_id` BIGINT COMMENT 'Reference to the physical site, facility, or location where the position is based. Critical for Good Manufacturing Practice (GMP) site-specific training and access control requirements.',
    `applicable_sop_list` STRING COMMENT 'Comma-separated list of Standard Operating Procedure (SOP) document numbers or identifiers applicable to the position. Defines the controlled procedures the position holder must be trained on and follow. Critical for quality-critical and regulated roles subject to audit.',
    `approval_date` DATE COMMENT 'Date when the position was formally approved by management and budget authority. Used for audit trail and organizational governance documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the position record was first created in the system. Used for audit trail and data lineage tracking.',
    `effective_end_date` DATE COMMENT 'Date when the position is scheduled to be closed or eliminated. Nullable for ongoing positions. Used for temporary positions, project-based roles, or organizational restructuring planning.',
    `effective_start_date` DATE COMMENT 'Date when the position becomes active and available for assignment or recruitment. Used for organizational planning and budget cycle alignment.',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Full-time equivalent allocation for the position. 1.00 represents full-time; 0.50 represents half-time. Used for headcount planning and budget calculations. Supports fractional positions and job-sharing arrangements.',
    `grade_band` STRING COMMENT 'Compensation grade or pay band assigned to the position, determining salary range and benefits eligibility. Business-confidential classification used for compensation planning and budgeting.',
    `is_gcp_regulated` BOOLEAN COMMENT 'Indicates whether the position performs Good Clinical Practice (GCP)-regulated activities requiring International Council for Harmonisation (ICH) GCP training and compliance per ICH E6(R2). True for clinical research, clinical operations, and medical affairs roles.',
    `is_glp_regulated` BOOLEAN COMMENT 'Indicates whether the position performs Good Laboratory Practice (GLP)-regulated activities requiring GLP training and compliance per 21 CFR Part 58. True for preclinical research and toxicology roles.',
    `is_gmp_regulated` BOOLEAN COMMENT 'Indicates whether the position performs GMP-regulated activities requiring Current Good Manufacturing Practice (cGMP) training, qualification, and audit trail documentation per 21 CFR Part 211. True for manufacturing, quality control, and quality assurance roles.',
    `is_quality_critical` BOOLEAN COMMENT 'Indicates whether the position is designated as quality-critical, requiring enhanced qualification, training documentation, and role-based access controls per Quality Management System (QMS) requirements. Subject to stricter audit scrutiny by Food and Drug Administration (FDA) and European Medicines Agency (EMA).',
    `job_family` STRING COMMENT 'Broad occupational category grouping similar roles (e.g., Research and Development, Quality Assurance, Regulatory Affairs, Manufacturing Operations, Clinical Development). Used for workforce planning and career pathing.',
    `job_level` STRING COMMENT 'Hierarchical level or seniority tier within the organization (e.g., Entry, Mid, Senior, Principal, Director, Vice President, Executive). Determines scope of responsibility and decision-making authority.',
    `last_modified_by_user` STRING COMMENT 'User identifier or username of the person who last modified the position record. Used for audit trail and accountability per 21 CFR Part 11 electronic records requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the position record was last updated. Used for change tracking and audit trail. Critical for maintaining compliance documentation history for FDA/EMA inspections.',
    `mandatory_training_curricula` STRING COMMENT 'Comma-separated list of mandatory training course codes or curricula identifiers required for the position. Includes GMP, GCP, GLP, safety, compliance, and role-specific technical training. Used to auto-assign training upon position assignment and track compliance for FDA/EMA inspections.',
    `position_code` STRING COMMENT 'Externally-known unique business identifier for the position, used in requisitions, organizational charts, and Human Resources Information System (HRIS) integrations. Typically alphanumeric code assigned by HR.. Valid values are `^[A-Z0-9]{6,12}$`',
    `position_description` STRING COMMENT 'Detailed narrative description of the positions purpose, key responsibilities, and scope of work. Used for recruitment job postings, performance management, and organizational documentation.',
    `position_status` STRING COMMENT 'Current lifecycle state of the position. Active indicates the position is approved and available; vacant means unfilled; filled means occupied by an employee; frozen means temporarily unavailable for hiring; closed means permanently eliminated; pending_approval means awaiting budget or organizational approval.. Valid values are `active|vacant|filled|frozen|closed|pending_approval`',
    `position_type` STRING COMMENT 'Classification of the position by employment arrangement. Permanent indicates regular full-time or part-time employment; temporary indicates fixed-term employment; contract indicates external contractor; intern indicates trainee or student; consultant indicates professional services engagement.. Valid values are `permanent|temporary|contract|intern|consultant`',
    `required_certifications` STRING COMMENT 'Comma-separated list of professional certifications, licenses, or credentials required for the position (e.g., Certified Quality Auditor, Project Management Professional, Registered Pharmacist, Clinical Research Associate certification). Used for compliance verification and recruitment screening.',
    `required_competencies` STRING COMMENT 'Comma-separated list of competency codes or descriptors defining the skills, knowledge, and behaviors required for successful performance in the position. Used for talent assessment, development planning, and succession planning.',
    `required_education_level` STRING COMMENT 'Minimum educational qualification required for the position. Used for recruitment screening and competency verification. Critical for roles requiring scientific or technical expertise in pharmaceutical development and manufacturing.. Valid values are `high_school|associate|bachelor|master|doctorate|professional_degree`',
    `required_experience_years` STRING COMMENT 'Minimum number of years of relevant professional experience required for the position. Used for recruitment qualification and career progression planning.',
    `requires_csv_training` BOOLEAN COMMENT 'Indicates whether the position requires Computer System Validation (CSV) training per 21 CFR Part 11 for roles that create, modify, or approve electronic records in validated systems. True for IT, quality, and regulated system users.',
    `requires_data_integrity_training` BOOLEAN COMMENT 'Indicates whether the position requires data integrity training covering ALCOA+ principles (Attributable, Legible, Contemporaneous, Original, Accurate, Complete, Consistent, Enduring, Available) per FDA and EMA data integrity guidance. Critical for laboratory, manufacturing, and quality roles.',
    `security_clearance_level` STRING COMMENT 'Required security clearance or access level for the position. Defines physical access rights, system access privileges, and data classification access. Critical for roles handling Intellectual Property (IP), controlled substances per Drug Enforcement Administration (DEA) regulations, or confidential clinical data.',
    `title` STRING COMMENT 'Official job title for the position as it appears in organizational charts, job postings, and employee records. Human-readable label for the role.',
    `travel_requirement_percentage` STRING COMMENT 'Expected percentage of work time requiring business travel. Used for recruitment transparency and workforce planning. Common for clinical research, sales, and regulatory affairs roles.',
    `work_schedule` STRING COMMENT 'Standard work schedule pattern for the position. Standard indicates regular business hours; shift indicates rotating or fixed shift work (common in manufacturing); flexible indicates flexible hours; remote indicates fully remote work; hybrid indicates combination of on-site and remote.. Valid values are `standard|shift|flexible|remote|hybrid`',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Authorized position master and job profile catalog defining all approved roles, headcount slots, and standardized role requirements within the organizational structure. Captures position title, job family, job level, grade band, FTE allocation, reporting line, site, department, GMP/GCP/GLP qualification requirement flags, regulated role indicator, position status (filled, vacant, frozen), required competencies, mandatory training curricula, applicable SOPs, and job profile reference data including competency expectations, required qualifications, and regulatory role classifications. Serves as the single template for recruitment requisitions, training compliance determination, performance evaluation criteria, and organizational design. Distinct from employee — a position can be vacant or shared.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Unique identifier for the job profile. Primary key. This is the standardized template defining role requirements, competencies, and regulatory training mandates. Distinct from position (headcount slot) and employee (person filling it).',
    `competency_framework_id` BIGINT COMMENT 'Reference to the competency framework defining the skills, behaviors, and knowledge areas required for this role. Used in performance evaluation, training needs analysis, and talent development.',
    `job_family_id` BIGINT COMMENT 'Reference to the job family grouping that this profile belongs to (e.g., Research & Development, Quality Assurance, Manufacturing Operations, Clinical Development). Used for workforce planning and career pathing.',
    `employee_id` BIGINT COMMENT 'Reference to the user (typically HR Director or Quality Head) who approved this job profile. Required for audit trail and accountability per 21 CFR Part 11 and ICH Q10.',
    `approval_date` DATE COMMENT 'Date when this job profile was formally approved by HR leadership and quality assurance (for GxP roles). Required for audit trail and change control compliance per ICH Q10.',
    `compensation_grade` STRING COMMENT 'Compensation grade or band assigned to this role, defining the salary range and bonus eligibility. Used in budgeting, offer generation, and pay equity analysis. Confidential business data.. Valid values are `^[A-Z0-9]{2,6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this job profile record was first created in the system. Part of the audit trail required for regulatory compliance and data lineage.',
    `effective_end_date` DATE COMMENT 'Date when this job profile version was superseded or retired. Null for currently active profiles. Used for historical analysis and regulatory audit trail.',
    `effective_start_date` DATE COMMENT 'Date when this job profile version became effective and available for use in position creation and workforce planning. Supports temporal tracking and audit compliance.',
    `flsa_classification` STRING COMMENT 'Classification under the U.S. Fair Labor Standards Act indicating whether the role is exempt or non-exempt from overtime pay requirements. Drives payroll processing and labor cost planning.. Valid values are `exempt|non_exempt`',
    `gcp_training_required_flag` BOOLEAN COMMENT 'Indicates whether this role requires mandatory Good Clinical Practice training per ICH E6 guidelines. True for clinical trial personnel (CRAs, clinical monitors, data managers). Drives training assignment and audit readiness.',
    `glp_training_required_flag` BOOLEAN COMMENT 'Indicates whether this role requires mandatory Good Laboratory Practice training per FDA GLP regulations. True for preclinical research and toxicology study personnel. Drives GLP curriculum assignment and regulatory compliance.',
    `gmp_training_required_flag` BOOLEAN COMMENT 'Indicates whether this role requires mandatory Good Manufacturing Practice training per 21 CFR Part 211. True for manufacturing, quality control, and quality assurance personnel. Drives cGMP curriculum assignment and FDA inspection readiness.',
    `job_level` STRING COMMENT 'Hierarchical level of the role within the organization, used for compensation banding, career progression, and span-of-control analysis. [ENUM-REF-CANDIDATE: entry|intermediate|senior|lead|principal|director|executive — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this job profile record was last updated. Supports change tracking, audit trail, and data quality monitoring per 21 CFR Part 11 and ICH Q10.',
    `last_review_date` DATE COMMENT 'Date when this job profile was last reviewed for accuracy, relevance, and regulatory compliance. Used to trigger periodic review cycles (typically annual for GxP roles) and ensure alignment with evolving business needs.',
    `minimum_education_level` STRING COMMENT 'Minimum formal education credential required for this role (e.g., Bachelor of Science in Chemistry for QC Analyst, Doctorate in Pharmacy for Medical Affairs). Used in candidate screening and qualification verification.. Valid values are `high_school|associate|bachelor|master|doctorate|professional_degree`',
    `minimum_experience_years` STRING COMMENT 'Minimum number of years of relevant professional experience required for this role. Used in candidate screening, internal mobility decisions, and compensation benchmarking.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next periodic review of this job profile. Drives proactive review workflows and ensures continuous alignment with regulatory requirements and business strategy.',
    `physical_requirements` STRING COMMENT 'Description of physical demands and working conditions for this role (e.g., standing for extended periods, lifting up to 50 lbs, cleanroom environment, laboratory safety protocols). Used for ADA compliance and workplace safety planning.',
    `preferred_education_field` STRING COMMENT 'Preferred academic discipline or field of study for this role (e.g., Chemistry, Biochemistry, Pharmacology, Life Sciences, Engineering). Used in talent acquisition and succession planning.',
    `profile_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying this job profile across HR systems, used in position requisitions, performance evaluations, and regulatory submissions.. Valid values are `^[A-Z0-9]{4,12}$`',
    `profile_description` STRING COMMENT 'Comprehensive narrative describing the purpose, scope, and key responsibilities of the role. Includes regulatory context for GxP-critical roles and quality-critical functions.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the job profile. Active profiles are used for position creation and hiring. Inactive or obsolete profiles are retained for historical reference and audit trail. Draft profiles are under development.. Valid values are `active|inactive|draft|under_review|obsolete`',
    `profile_title` STRING COMMENT 'Official title of the job profile as it appears in organizational charts, position postings, and regulatory documentation (e.g., Senior Quality Control Analyst, Clinical Research Associate II, Manufacturing Technician III).',
    `quality_critical_flag` BOOLEAN COMMENT 'Indicates whether this role performs quality-critical activities that directly impact product quality, patient safety, or data integrity. True for roles requiring heightened qualification, training documentation, and audit scrutiny per ICH Q10.',
    `regulatory_role_classification` STRING COMMENT 'Classification indicating whether the role performs GxP-critical activities (GCP, GMP, GLP), quality-critical functions requiring heightened training and qualification, or non-regulated administrative functions. Drives training curriculum and audit scope.. Valid values are `gxp_critical|quality_critical|non_gxp|administrative`',
    `remote_work_eligible_flag` BOOLEAN COMMENT 'Indicates whether this role is eligible for remote or hybrid work arrangements. False for roles requiring on-site presence (manufacturing, laboratory, clinical site personnel). Used in workforce flexibility planning and talent attraction.',
    `required_certifications` STRING COMMENT 'Comma-separated list of mandatory professional certifications or licenses required for this role (e.g., Certified Quality Auditor, Registered Pharmacist, Project Management Professional). Drives qualification tracking and audit compliance.',
    `role_based_access_level` STRING COMMENT 'Default system access level assigned to this role for regulated systems (LIMS, MES, QMS, CTMS). Drives 21 CFR Part 11 compliance for electronic records and signatures, and supports least-privilege access control.. Valid values are `read_only|standard_user|power_user|administrator|validator`',
    `safety_training_required_flag` BOOLEAN COMMENT 'Indicates whether this role requires mandatory occupational health and safety training (e.g., hazardous materials handling, biosafety, radiation safety, ergonomics). True for laboratory, manufacturing, and clinical roles. Drives OSHA compliance.',
    `sop_list` STRING COMMENT 'Comma-separated list of SOP identifiers that personnel in this role must be trained on and qualified to execute. Critical for GxP roles and quality-critical functions. Drives training curriculum and audit trail.',
    `succession_planning_tier` STRING COMMENT 'Priority tier for succession planning and talent pipeline development. Critical for roles with high business impact, specialized expertise, or regulatory accountability (e.g., Qualified Person, Head of Quality). Used in talent review and development planning.. Valid values are `critical|high|medium|low|not_applicable`',
    `supervisory_flag` BOOLEAN COMMENT 'Indicates whether this role has direct supervisory or managerial responsibilities over other employees. Used in organizational structure modeling, span-of-control analysis, and leadership development planning.',
    `travel_requirement_percentage` STRING COMMENT 'Expected percentage of work time requiring business travel (0-100). Used in candidate screening, expense budgeting, and work-life balance planning. High for field-based roles (CRAs, sales reps, auditors).',
    `typical_span_of_control` STRING COMMENT 'Typical number of direct reports for supervisory roles. Used in organizational design, workforce planning, and management capacity analysis. Null for non-supervisory roles.',
    `version_number` STRING COMMENT 'Sequential version number of this job profile. Incremented with each approved revision. Supports change control, audit trail, and regulatory compliance per ICH Q10 and 21 CFR Part 11.',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Reference catalog of standardized job profiles defining role requirements, competency expectations, required qualifications, GCP/GMP/GLP training mandates, and regulatory role classifications. Each job profile maps to a job family, job level, and applicable SOPs. Used as the template for position creation and performance evaluation. Distinct from position (which is a headcount slot) and employee (who fills it).';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` (
    `employment_contract_id` BIGINT COMMENT 'Unique identifier for the employment contract record. Primary key for the employment contract entity.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Contracts are executed by specific legal entities - essential for legal validity, governing jurisdiction determination, and contract enforceability. Creates new FK to establish which legal entity is t',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is party to this employment contract. Links to the employee master record.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Employment contracts are typically written for a specific authorized position slot. The contract currently has job_title and job_family as strings, but these should reference the position master for c',
    `amendment_count` STRING COMMENT 'Number of amendments or modifications made to the original employment contract. Incremented each time a contract amendment is executed. Used for audit readiness and contract version control.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'Annual base salary amount in the contract currency. Excludes bonuses, allowances, and benefits. Used for payroll processing, compensation analysis, and financial planning.',
    `confidentiality_clause` BOOLEAN COMMENT 'Indicates whether the employment contract includes a confidentiality or non-disclosure agreement (NDA) clause. True if confidentiality obligations are contractually binding; False otherwise. Critical for intellectual property (IP) protection and regulatory compliance.',
    `contract_document_reference` STRING COMMENT 'Reference identifier or URI to the signed employment contract document stored in the document management system (e.g., Veeva Vault, SharePoint). Used for audit readiness, regulatory inspections, and legal documentation retrieval.',
    `contract_number` STRING COMMENT 'Externally visible unique business identifier for the employment contract. Used for audit trails, regulatory inspections, and HR documentation.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `contract_status` STRING COMMENT 'Current lifecycle state of the employment contract. Draft indicates pending approval; active is in force; suspended is temporarily paused; terminated is ended by either party; expired indicates natural end of fixed-term; amended indicates contract has been modified.. Valid values are `draft|active|suspended|terminated|expired|amended`',
    `contract_type` STRING COMMENT 'Classification of the employment contract. Permanent indicates indefinite employment; fixed-term has a defined end date; temporary is short-term; CRO (Contract Research Organization) secondment indicates assignment from external research partner; consultant and intern are specialized arrangements.. Valid values are `permanent|fixed_term|temporary|cro_secondment|consultant|intern`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the employment contract record was first created in the system. Used for audit trails, data lineage, and regulatory compliance documentation.',
    `end_date` DATE COMMENT 'The date on which the employment contract terminates. Nullable for permanent contracts. Mandatory for fixed-term, temporary, and CRO secondment contracts. Used for workforce planning and compliance reporting.',
    `fte` DECIMAL(18,2) COMMENT 'Full-time equivalency ratio representing the proportion of a full-time workload. 1.000 indicates full-time; 0.500 indicates half-time. Used for headcount reporting, budget planning, and resource allocation.',
    `governing_jurisdiction` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the legal jurisdiction under which the employment contract is governed. Determines applicable labor laws, tax regulations, and dispute resolution mechanisms. Examples: USA, GBR, DEU, JPN, CHE.. Valid values are `^[A-Z]{3}$`',
    `gxp_role_flag` BOOLEAN COMMENT 'Indicates whether the employee holds a quality-critical role requiring Good Clinical Practice (GCP), Good Manufacturing Practice (GMP), or Good Laboratory Practice (GLP) training and certification. True for roles subject to FDA/EMA inspection and audit requirements.',
    `gxp_training_required` STRING COMMENT 'Specifies which Good Practice training certifications are mandatory for this role. GCP (Good Clinical Practice) for clinical trial personnel; GMP (Good Manufacturing Practice) for manufacturing and quality personnel; GLP (Good Laboratory Practice) for laboratory and preclinical personnel. Combinations indicate multi-domain roles. [ENUM-REF-CANDIDATE: gcp|gmp|glp|gcp_gmp|gcp_glp|gmp_glp|gcp_gmp_glp|none — 8 candidates stripped; promote to reference product]',
    `ip_assignment_clause` BOOLEAN COMMENT 'Indicates whether the employment contract includes an intellectual property assignment clause transferring ownership of employee-created inventions, patents, and discoveries to Pharmaceuticals. True if IP assignment is contractually binding; False otherwise. Critical for patent filing and drug development.',
    `last_amendment_date` DATE COMMENT 'The date of the most recent amendment to the employment contract. Nullable if no amendments have been made. Used for tracking contract change history and audit documentation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the employment contract record was last updated in the system. Used for audit trails, change tracking, and data quality monitoring.',
    `non_compete_clause` BOOLEAN COMMENT 'Indicates whether the employment contract includes a non-compete or restrictive covenant clause limiting the employees ability to work for competitors after termination. True if non-compete obligations exist; False otherwise. Subject to jurisdiction-specific enforceability.',
    `notice_period_days` STRING COMMENT 'Number of days of advance notice required by either party to terminate the employment contract. Varies by jurisdiction, role seniority, and contract type. Critical for workforce planning and compliance.',
    `payment_frequency` STRING COMMENT 'Frequency at which salary payments are made to the employee. Monthly is most common for salaried employees; bi-weekly and weekly are common for hourly workers; quarterly may apply to certain consultant arrangements.. Valid values are `monthly|bi_weekly|weekly|quarterly`',
    `probation_end_date` DATE COMMENT 'The calculated or actual date on which the probationary period concludes. Used for HR workflow triggers and performance review scheduling.',
    `probation_period_days` STRING COMMENT 'Duration of the probationary period in days during which the employees performance is evaluated before full employment confirmation. Typically ranges from 30 to 180 days depending on role and jurisdiction.',
    `rehire_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible for rehire by Pharmaceuticals after contract termination. True if eligible; False if ineligible due to performance, conduct, or policy violations. Used for talent acquisition and background screening.',
    `remote_work_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible for remote or hybrid work arrangements under this contract. True if remote work is permitted; False if on-site presence is required. Relevant for post-pandemic workforce policies.',
    `salary_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the base salary amount. Examples: USD, EUR, GBP, JPY, CHF. Required for multi-currency payroll processing and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `salary_grade` STRING COMMENT 'Compensation band or grade assigned to the employee within the organizations salary structure. Used for pay equity analysis, compensation planning, and internal benchmarking. Format typically alphanumeric (e.g., E5, M3, S12).. Valid values are `^[A-Z]{1,2}[0-9]{1,2}$`',
    `signing_date` DATE COMMENT 'The date on which the employment contract was signed by both parties. Used for legal documentation, audit trails, and contract lifecycle tracking.',
    `start_date` DATE COMMENT 'The date on which the employment contract becomes effective and the employee begins their employment relationship with Pharmaceuticals. Critical for tenure calculations, benefits eligibility, and regulatory compliance.',
    `termination_date` DATE COMMENT 'The actual date on which the employment contract was terminated. Nullable for active contracts. Populated when contract status transitions to terminated or expired. Used for offboarding workflows and compliance reporting.',
    `termination_reason` STRING COMMENT 'Reason for employment contract termination. Resignation indicates employee-initiated departure; retirement is age-related exit; redundancy is role elimination; dismissal is employer-initiated for cause; mutual agreement is consensual separation; contract expiry is natural end of fixed-term. Used for turnover analysis and regulatory reporting. [ENUM-REF-CANDIDATE: resignation|retirement|redundancy|dismissal|mutual_agreement|contract_expiry|other — 7 candidates stripped; promote to reference product]',
    `work_location` STRING COMMENT 'Primary work location or site where the employee is based. May reference a facility, office, or indicate remote work. Used for workforce planning, compliance with local labor laws, and emergency response.',
    `working_hours_per_week` DECIMAL(18,2) COMMENT 'Standard number of working hours per week as defined in the employment contract. Used for full-time equivalency (FTE) calculations, payroll processing, and compliance with labor regulations. Typical values: 40.00 for full-time, 20.00 for part-time.',
    CONSTRAINT pk_employment_contract PRIMARY KEY(`employment_contract_id`)
) COMMENT 'Transactional record of employment agreements between Pharmaceuticals and individual employees. Captures contract type (permanent, fixed-term, CRO secondment), start date, end date, notice period, probation period, working hours, salary grade, contract status, governing jurisdiction, and amendment history reference. Supports HR compliance, audit readiness, and regulatory inspection documentation.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` (
    `gxp_training_record_id` BIGINT COMMENT 'Unique identifier for the GxP training record. Primary key for the training record entity.',
    `employee_id` BIGINT COMMENT 'Reference to the quality assurance officer or authorized personnel who approved and verified this training record for regulatory compliance. Null if not yet approved.',
    `primary_gxp_employee_id` BIGINT COMMENT 'Reference to the employee who is assigned or has completed this training. Links to the employee master data.',
    `quaternary_gxp_created_by_employee_id` BIGINT COMMENT 'Reference to the employee who created this training record in the system. Part of the audit trail required by 21 CFR Part 11.',
    `quinary_gxp_last_modified_by_employee_id` BIGINT COMMENT 'Reference to the employee who last modified this training record. Part of the audit trail required by 21 CFR Part 11.',
    `sop_id` BIGINT COMMENT 'Reference to the specific SOP that this training covers. Null if training is not SOP-specific.',
    `tertiary_gxp_trainer_employee_id` BIGINT COMMENT 'Reference to the employee who conducted or facilitated the training session. Null for self-paced e-learning.',
    `training_course_id` BIGINT COMMENT 'Reference to the training course or curriculum that this record tracks. Links to the training course master data.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this training record was approved by quality assurance or authorized personnel. Null if not yet approved.',
    `assessment_result` STRING COMMENT 'Outcome of the training assessment: pass (met or exceeded threshold), fail (did not meet threshold), waived (assessment requirement waived by authorized personnel), or not applicable (no assessment required).. Valid values are `pass|fail|waived|not_applicable`',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numeric score achieved by the employee on the training assessment or examination, typically expressed as a percentage (0.00 to 100.00). Null if no assessment was required.',
    `assignment_date` DATE COMMENT 'Date when the training was assigned to the employee.',
    `assignment_reason` STRING COMMENT 'Business reason for assigning this training: new hire onboarding, role change, SOP update, periodic requalification, Corrective and Preventive Action (CAPA), audit finding, regulatory requirement, or identified competency gap. [ENUM-REF-CANDIDATE: new_hire|role_change|sop_update|periodic_requalification|capa|audit_finding|regulatory_requirement|competency_gap — 8 candidates stripped; promote to reference product]',
    `attendance_status` STRING COMMENT 'Attendance status for scheduled training sessions: attended (full participation), absent (did not attend), partially attended (incomplete participation), or excused (authorized absence).. Valid values are `attended|absent|partially_attended|excused`',
    `certificate_issued_date` DATE COMMENT 'Date when the training certificate was issued to the employee. Null if no certificate was issued.',
    `certificate_number` STRING COMMENT 'Unique certificate number issued upon successful completion of the training. Used for audit and verification purposes. Null if no certificate was issued.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or special circumstances related to the training event (e.g., accommodations provided, remedial actions required, audit findings).',
    `completion_date` DATE COMMENT 'Date when the employee successfully completed the training. Null if training is not yet completed.',
    `completion_method` STRING COMMENT 'Method by which the training was delivered and completed: classroom (in-person), e-learning (online module), on-the-job (practical demonstration), webinar (live virtual), self-study (reading assignment), or blended (combination).. Valid values are `classroom|e_learning|on_the_job|webinar|self_study|blended`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training record was first created in the system. Part of the audit trail required by 21 CFR Part 11.',
    `due_date` DATE COMMENT 'Target date by which the training must be completed to maintain compliance and qualification status.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this training assignment has been escalated due to overdue status or repeated non-completion. True if escalated, False otherwise.',
    `gxp_category` STRING COMMENT 'The regulatory category of the training: Good Clinical Practice (GCP), Good Manufacturing Practice (GMP), Good Laboratory Practice (GLP), Good Distribution Practice (GDP), Good Pharmacovigilance Practice (GVP), or Good Automated Manufacturing Practice (GAMP).. Valid values are `GCP|GMP|GLP|GDP|GVP|GAMP`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training record was last modified. Part of the audit trail required by 21 CFR Part 11.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the training assessment, typically expressed as a percentage (0.00 to 100.00). Null if no assessment was required.',
    `qualification_effective_date` DATE COMMENT 'Date from which the employee is qualified to perform the role or task covered by this training. Typically the completion date for initial training.',
    `qualification_expiry_date` DATE COMMENT 'Date when the qualification expires and requalification training is required. Null for qualifications that do not expire.',
    `qualification_status` STRING COMMENT 'Current qualification status of the employee for the role or task covered by this training: qualified (authorized to perform), not qualified (not authorized), pending (training in progress), expired (requalification required), or suspended (temporarily revoked).. Valid values are `qualified|not_qualified|pending|expired|suspended`',
    `record_status` STRING COMMENT 'Current lifecycle status of the training record: draft (being prepared), active (assigned and in progress), completed (training finished and documented), cancelled (training assignment voided), or archived (historical record).. Valid values are `draft|active|completed|cancelled|archived`',
    `regulatory_inspection_ready_flag` BOOLEAN COMMENT 'Indicates whether this training record is complete, verified, and ready for presentation during FDA, EMA, or other regulatory inspections. True if inspection-ready, False otherwise.',
    `requalification_interval_months` STRING COMMENT 'Number of months between required requalification training cycles. Null if requalification is not periodic.',
    `sop_version` STRING COMMENT 'Version number or identifier of the SOP that was covered in this training. Critical for change control and audit trail. Null if training is not SOP-specific.',
    `training_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training session in hours, including instruction, assessment, and practical exercises.',
    `training_location` STRING COMMENT 'Physical or virtual location where the training was conducted (e.g., site name, building, room number, or online platform).',
    `training_material_version` STRING COMMENT 'Version number or identifier of the training materials (slides, videos, documents) used for this training session. Ensures traceability and compliance with 21 CFR Part 11.',
    `training_record_number` STRING COMMENT 'Business-facing unique identifier for the training record, often used in audit trails and regulatory submissions.',
    `training_type` STRING COMMENT 'Classification of the training event: initial (new hire or new role), refresher (periodic update), requalification (competency renewal), ad hoc (unscheduled), remedial (corrective), or change control (triggered by SOP revision).. Valid values are `initial|refresher|requalification|ad_hoc|remedial|change_control`',
    CONSTRAINT pk_gxp_training_record PRIMARY KEY(`gxp_training_record_id`)
) COMMENT 'Transactional record managing the full GxP training lifecycle for regulated personnel — from assignment through completion and requalification. Captures training assignments (due dates, assignment reasons such as role change, SOP update, new hire, periodic requalification, assigned-by reference, escalation flags), completion records (date, method, assessment score, pass/fail, trainer, SOP version), expiry dates, and qualification status. Covers GCP, GMP, and GLP training for FDA/EMA inspection readiness and 21 CFR Part 11 compliance. Sourced from MasterControl or TrackWise QMS.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` (
    `training_course_id` BIGINT COMMENT 'Unique identifier for the training course record. Primary key.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Training courses are designed for specific job profiles/roles. The training_course currently has target_audience as a STRING, but this should be a structured FK to job_profile for systematic curriculu',
    `department_id` BIGINT COMMENT 'Identifier of the department responsible for maintaining and updating the training course content (e.g., Quality Assurance, Clinical Operations, Manufacturing, Human Resources).',
    `employee_id` BIGINT COMMENT 'User identifier of the person who created the training course record. Part of audit trail for regulatory compliance and accountability.',
    `assessment_required_flag` BOOLEAN COMMENT 'Indicates whether a formal assessment (test, quiz, practical demonstration) is required to complete the training course. True if assessment is mandatory, False if completion is based on attendance only.',
    `certification_issued_flag` BOOLEAN COMMENT 'Indicates whether a formal certification or certificate of completion is issued upon successful completion of the training course. True if certification is issued, False otherwise.',
    `ceu_credits` DECIMAL(18,2) COMMENT 'Number of Continuing Education Unit credits awarded upon successful completion of the training course. Used for professional development tracking and external certification maintenance. Null if no CEU credits are awarded.',
    `content_owner_name` STRING COMMENT 'Name of the individual or role responsible for the accuracy and currency of the training course content (e.g., Quality Assurance Manager, Clinical Training Lead). Point of contact for content-related questions.',
    `course_code` STRING COMMENT 'Unique alphanumeric business identifier for the training course used across systems (e.g., GMP-101, GCP-ADV-205). Externally-known code used in training records and compliance documentation.. Valid values are `^[A-Z0-9]{4,20}$`',
    `course_description` STRING COMMENT 'Detailed description of the training course content, learning objectives, target audience, and prerequisites. Provides comprehensive information for employees and managers to understand course scope and applicability.',
    `course_language` STRING COMMENT 'Primary language in which the training course content is delivered, using ISO 639-2 three-letter language codes (e.g., ENG for English, SPA for Spanish, DEU for German). Critical for global workforce training management.. Valid values are `^[A-Z]{3}$`',
    `course_status` STRING COMMENT 'Current lifecycle status of the training course: draft (under development), active (available for enrollment), under_review (being updated or reviewed), retired (no longer offered but historical records maintained), or archived (historical record only).. Valid values are `draft|active|under_review|retired|archived`',
    `course_title` STRING COMMENT 'Full descriptive title of the training course as displayed to employees and in training catalogs (e.g., Good Manufacturing Practice Fundamentals, Clinical Trial Protocol Design).',
    `course_type` STRING COMMENT 'Classification of the training course by requirement type: mandatory (required for all), elective (optional), role_based (required for specific roles), compliance (regulatory requirement), technical (job-specific skills), leadership (management development), or safety (workplace safety). [ENUM-REF-CANDIDATE: mandatory|elective|role_based|compliance|technical|leadership|safety — 7 candidates stripped; promote to reference product]',
    `course_version` STRING COMMENT 'Version number of the training course content following semantic versioning (e.g., 1.0, 2.1, 3.5). Incremented when course content is updated. Essential for tracking which version employees completed for audit purposes.. Valid values are `^[0-9]+.[0-9]+$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the training course record was first created in the system. Part of audit trail for regulatory compliance and data lineage tracking.',
    `delivery_method` STRING COMMENT 'Method by which the training course is delivered: classroom (in-person instructor-led), elearning (online self-paced), blended (combination of classroom and online), on_the_job (practical training at workstation), virtual_instructor_led (live online with instructor), or self_paced (independent study).. Valid values are `classroom|elearning|blended|on_the_job|virtual_instructor_led|self_paced`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training course measured in hours (e.g., 2.5, 8.0, 16.0). Used for scheduling, resource planning, and training hour tracking for compliance reporting.',
    `effective_end_date` DATE COMMENT 'Date after which this version of the training course is no longer available for new enrollments. Null if the course is currently active with no planned retirement date.',
    `effective_start_date` DATE COMMENT 'Date from which this version of the training course becomes available for enrollment and delivery. Used for version control and compliance tracking.',
    `last_content_review_date` DATE COMMENT 'Date when the training course content was last reviewed for accuracy, currency, and regulatory compliance. Used to ensure training materials remain current and compliant.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the training course record was last updated. Part of audit trail for regulatory compliance and change tracking.',
    `learning_objectives` STRING COMMENT 'Specific, measurable learning outcomes that participants will achieve upon successful completion of the training course. Defines competencies and knowledge gained.',
    `max_enrollment_capacity` STRING COMMENT 'Maximum number of participants that can enroll in a single session of the training course. Null if no capacity limit exists (e.g., for self-paced eLearning courses).',
    `next_scheduled_review_date` DATE COMMENT 'Date when the training course content is scheduled for its next periodic review. Ensures proactive maintenance of training materials and compliance with quality management system requirements.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score (percentage or points) required to successfully complete the training course and achieve certification (e.g., 80.00 for 80% passing threshold). Null if no assessment is required.',
    `prerequisites` STRING COMMENT 'List of prerequisite courses, certifications, or qualifications that must be completed before enrolling in this training course. Null if no prerequisites exist.',
    `regulatory_authority_approval_required_flag` BOOLEAN COMMENT 'Indicates whether the training course content or curriculum requires approval or review by regulatory authorities (FDA, EMA, etc.) before deployment. True if regulatory approval is required, False otherwise.',
    `regulatory_classification` STRING COMMENT 'Regulatory framework classification indicating whether the course is GxP-related (Good Practice): gxp (general Good Practice), gmp (Good Manufacturing Practice), gcp (Good Clinical Practice), glp (Good Laboratory Practice), gdp (Good Distribution Practice), or non_gxp (non-regulated training). Critical for audit trail and compliance reporting to FDA/EMA.. Valid values are `gxp|gmp|gcp|glp|gdp|non_gxp`',
    `requalification_frequency_months` STRING COMMENT 'Number of months after which employees must retake the training course to maintain qualification (e.g., 12 for annual requalification, 24 for biennial). Null if no requalification is required. Critical for GxP compliance and audit readiness.',
    `sop_reference_numbers` STRING COMMENT 'Comma-separated list of SOP document numbers that this training course covers or is based upon (e.g., SOP-QA-001, SOP-MFG-045). Links training to controlled documentation for audit trail purposes.',
    CONSTRAINT pk_training_course PRIMARY KEY(`training_course_id`)
) COMMENT 'Master catalog of all training courses available to Pharmaceuticals employees including GMP, GCP, GLP, SOPs, safety, and professional development courses. Captures course code, title, course type, regulatory classification (GxP/non-GxP), delivery method, duration, passing score threshold, requalification frequency, owning department, and version. Serves as the SSOT for training curriculum definitions used in MasterControl or TrackWise.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` (
    `training_assignment_id` BIGINT COMMENT 'Unique identifier for the training assignment record. Primary key for the training assignment entity.',
    `job_profile_id` BIGINT COMMENT 'Unique identifier of the job profile or role that triggered this training assignment. Links training requirements to specific job functions.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee to whom the training is assigned. Links to the employee master record.',
    `quaternary_training_waiver_approved_by_employee_id` BIGINT COMMENT 'Unique identifier of the employee who approved the training waiver. Typically a quality assurance manager or training director. Null if no waiver was granted.',
    `site_id` BIGINT COMMENT 'Unique identifier of the site or facility where the employee is assigned and where the training is applicable. Supports site-specific training compliance tracking.',
    `sop_id` BIGINT COMMENT 'Unique identifier of the Standard Operating Procedure (SOP) that this training covers. Null if training is not SOP-specific.',
    `tertiary_training_approved_by_employee_id` BIGINT COMMENT 'Unique identifier of the employee who approved or verified the training completion. Required for GxP-regulated training records. Null if approval is not yet completed.',
    `training_course_id` BIGINT COMMENT 'Unique identifier of the training course being assigned. Links to the training course master record.',
    `approval_date` DATE COMMENT 'The date on which the training completion was approved or verified by a qualified reviewer. Required for GxP training records. Null if not yet approved.',
    `assignment_date` DATE COMMENT 'The date on which the training was assigned to the employee. Represents the business event timestamp when the assignment was created.',
    `assignment_number` STRING COMMENT 'Business-facing unique identifier for the training assignment, typically used in training management systems and audit documentation. Format: TA-NNNNNNNN.. Valid values are `^TA-[0-9]{8}$`',
    `assignment_reason` STRING COMMENT 'The business reason or trigger for assigning this training to the employee. Supports root cause analysis for training compliance and audit trail requirements. [ENUM-REF-CANDIDATE: new_hire|role_change|sop_update|periodic_requalification|regulatory_requirement|site_transfer|audit_finding|capa_action|product_launch|system_implementation — 10 candidates stripped; promote to reference product]',
    `assignment_type` STRING COMMENT 'Classification of the training assignment indicating whether it is mandatory (required for role or compliance), elective (optional for development), or recommended (suggested but not required).. Valid values are `mandatory|elective|recommended`',
    `attempts_count` STRING COMMENT 'The number of times the employee has attempted to complete the training. Tracks retakes and supports analysis of training effectiveness.',
    `certificate_issued_date` DATE COMMENT 'The date on which the training certificate was issued. Null if no certificate is issued or training is not yet completed.',
    `certificate_number` STRING COMMENT 'The unique certificate or credential number issued upon successful completion of the training. Used for external certifications and audit verification. Null if no certificate is issued.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or special instructions related to the training assignment. May include feedback from trainers, managers, or the employee.',
    `completion_date` DATE COMMENT 'The date on which the employee successfully completed the assigned training. Null if training is not yet completed.',
    `completion_score` DECIMAL(18,2) COMMENT 'The score or grade achieved by the employee upon completion of the training, expressed as a percentage (0.00 to 100.00). Null if training does not include assessment or is not yet completed.',
    `completion_status` STRING COMMENT 'Current status of the training assignment in its lifecycle. Tracks whether the employee has started, completed, failed, or is overdue on the assigned training. [ENUM-REF-CANDIDATE: not_started|in_progress|completed|failed|waived|expired|overdue — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this training assignment record was first created in the system. Part of the audit trail required for 21 CFR Part 11 compliance.',
    `due_date` DATE COMMENT 'The date by which the employee must complete the assigned training. Used for compliance tracking and escalation workflows.',
    `escalation_date` DATE COMMENT 'The date on which the training assignment was escalated to management due to non-completion or overdue status. Null if not escalated.',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) that the training assignment is overdue or at risk and has been escalated to management for intervention. Used in compliance dashboards and audit readiness reporting.',
    `expiration_date` DATE COMMENT 'The date on which the completed training expires and requires requalification. Used for periodic requalification tracking. Null if training does not expire.',
    `gxp_regulated_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) that the training is subject to GxP regulations (GCP, GMP, GLP) and requires enhanced documentation and audit trail for FDA/EMA inspections.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this training assignment record was last modified. Part of the audit trail required for 21 CFR Part 11 compliance.',
    `max_attempts_allowed` STRING COMMENT 'The maximum number of attempts permitted for this training assignment. Null if unlimited attempts are allowed.',
    `passing_score_required` DECIMAL(18,2) COMMENT 'The minimum score required to pass the training, expressed as a percentage (0.00 to 100.00). Used to determine if completion_status should be marked as completed or failed.',
    `regulatory_framework` STRING COMMENT 'The specific regulatory framework or standard that governs this training assignment. Critical for audit readiness and compliance reporting. [ENUM-REF-CANDIDATE: GCP|GMP|GLP|GDP|CSV|21_CFR_Part_11|ISO_9001|ISO_13485|not_applicable — 9 candidates stripped; promote to reference product]',
    `requalification_required_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) that the training requires periodic requalification. Drives automated reassignment workflows when expiration_date is reached.',
    `sop_version` STRING COMMENT 'The version number of the SOP that this training covers. Ensures employees are trained on the current version of procedures. Null if training is not SOP-specific.',
    `training_cost` DECIMAL(18,2) COMMENT 'The cost incurred for this training assignment, including course fees, materials, instructor costs, and employee time. Used for training budget analysis and ROI calculations. Expressed in the organizations reporting currency.',
    `training_delivery_method` STRING COMMENT 'The method by which the training is delivered to the employee. Supports analysis of training effectiveness by delivery channel.. Valid values are `classroom|online|on_the_job|blended|self_paced|virtual_instructor_led`',
    `training_duration_hours` DECIMAL(18,2) COMMENT 'The expected or actual duration of the training in hours. Used for workforce planning and training cost analysis.',
    `training_provider` STRING COMMENT 'The name of the organization or vendor that provided the training. May be internal (company name) or external (Contract Research Organization, training vendor). Supports vendor management and training quality analysis.',
    `waiver_approval_date` DATE COMMENT 'The date on which the training waiver was approved. Null if no waiver was granted.',
    `waiver_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) that the training requirement has been waived for this employee due to prior experience, equivalent training, or other documented justification.',
    `waiver_reason` STRING COMMENT 'Detailed explanation of why the training requirement was waived, including reference to prior training, certifications, or experience. Required when waiver_flag is True.',
    CONSTRAINT pk_training_assignment PRIMARY KEY(`training_assignment_id`)
) COMMENT 'Transactional record linking employees to mandatory or elective training courses based on their role, job profile, site, or regulatory requirement. Captures assignment date, due date, assignment reason (role change, SOP update, new hire, periodic requalification), completion status, escalation flag, and assigned-by reference. Enables training compliance tracking and overdue training reporting for GxP-regulated roles.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` (
    `qualification_id` BIGINT COMMENT 'Unique identifier for the qualification record. Primary key for the qualification entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the qualification assignment. Links to the employee master record for audit trail purposes.',
    `qualification_employee_id` BIGINT COMMENT 'Identifier of the employee who holds this qualification. Links to the employee master record.',
    `training_course_id` BIGINT COMMENT 'Foreign key linking to workforce.training_course. Business justification: Qualifications are often earned through completion of training courses. The qualification record should link to the course that granted it (when applicable). This enables traceability from qualificati',
    `access_level` STRING COMMENT 'Level of access or permission granted within the system. Read-only allows viewing; read-write allows data entry; approve allows electronic signature and approval; admin allows configuration; super-user allows full control.. Valid values are `read_only|read_write|approve|admin|super_user`',
    `approval_date` DATE COMMENT 'Date on which the qualification assignment or system access was formally approved by the authorized approver.',
    `approver_name` STRING COMMENT 'Full name of the manager, quality assurance representative, or authorized personnel who approved the qualification assignment or system access grant.',
    `assessment_result` STRING COMMENT 'Outcome of the qualification assessment or examination. Pass indicates successful completion; fail indicates unsuccessful attempt; conditional_pass indicates pass with remediation required; not_assessed indicates no formal assessment was conducted.. Valid values are `pass|fail|conditional_pass|not_assessed`',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numerical score or grade achieved by the employee on the qualification assessment or examination. Null if no formal assessment was required.',
    `assignment_date` DATE COMMENT 'Date on which the qualification was formally assigned or recorded in the system for the employee. May differ from issue_date if there is a delay in administrative recording.',
    `audit_trail_flag` BOOLEAN COMMENT 'Indicates whether this qualification record is subject to electronic audit trail requirements under 21 CFR Part 11. True if audit trail is required; false otherwise.',
    `business_justification` STRING COMMENT 'Detailed explanation of why the qualification or system access is required for the employees role. Supports audit trails and access review processes for SOX and 21 CFR Part 11 compliance.',
    `certificate_number` STRING COMMENT 'Unique certificate or credential number issued by the certifying body. Enables verification of authenticity with the issuing organization.',
    `competency_area` STRING COMMENT 'Functional or technical area of competency covered by this qualification (e.g., Aseptic Processing, Clinical Monitoring, Analytical Chemistry, Quality Auditing, Controlled Substance Handling). Supports skills matrix and workforce planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this qualification record was first created in the system. Supports audit trail and data lineage requirements.',
    `effective_date` DATE COMMENT 'Date from which the qualification becomes valid and the employee is authorized to perform the associated activities or access systems.',
    `expiry_date` DATE COMMENT 'Date on which the qualification expires and must be renewed or re-qualified. Null if the qualification does not expire (e.g., permanent certifications).',
    `issue_date` DATE COMMENT 'Date on which the qualification, certification, or authorization was originally issued or granted to the employee.',
    `issuing_body` STRING COMMENT 'Name of the organization, regulatory authority, or internal department that issued or granted the qualification. Examples: FDA, EMA, Internal Quality Assurance, Society of Clinical Research Associates, DEA.',
    `last_access_review_date` DATE COMMENT 'Date of the most recent periodic access review for system access qualifications. Supports SOX compliance and segregation of duties controls.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this qualification record was last modified or updated. Tracks the most recent change for audit trail purposes.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or assessment of the qualification. Supports proactive compliance management and audit readiness.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special conditions, or contextual information related to the qualification. Supports documentation of exceptions, remediation plans, or audit observations.',
    `qualification_code` STRING COMMENT 'Short alphanumeric code or identifier for the qualification used in internal systems and training records. Enables quick lookup and reporting.',
    `qualification_name` STRING COMMENT 'Full descriptive name of the qualification, certification, or authorization. Examples: GMP Aseptic Processing Qualification, ICH-GCP Clinical Monitor Certification, HPLC Method Qualification for Product X.',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the qualification. Active indicates the employee is currently qualified; expired indicates renewal is required; suspended indicates temporary hold; pending_renewal indicates renewal process is underway; revoked indicates permanent withdrawal; under_review indicates periodic assessment in progress.. Valid values are `active|expired|suspended|pending_renewal|revoked|under_review`',
    `qualification_type` STRING COMMENT 'Category of qualification held by the employee. Distinguishes between regulatory competencies (GMP, GCP, GLP), technical qualifications (analytical method), audit certifications, and controlled substance authorizations (DEA handler).. Valid values are `gmp_qualification|gcp_certification|glp_certification|analytical_method_qualification|auditor_certification|dea_handler_authorization`',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this qualification is mandated by regulatory authorities (FDA, EMA, DEA) or industry standards (GMP, GCP, GLP). True if regulatory-required; false if voluntary or internal.',
    `renewal_date` DATE COMMENT 'Date on which the qualification was last renewed or re-certified. Tracks the most recent renewal event for qualifications requiring periodic revalidation.',
    `revocation_date` DATE COMMENT 'Date on which the qualification or system access was revoked or withdrawn. Null if the qualification has never been revoked.',
    `revocation_reason` STRING COMMENT 'Explanation of why the qualification or system access was revoked (e.g., Employee termination, Role change, Compliance violation, Failed re-certification). Supports audit trails and access control reviews.',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or file path to the supporting documentation for this qualification (e.g., certificate scan, training transcript, approval memo). Enables retrieval of evidence for audits and inspections.',
    `system_name` STRING COMMENT 'Name of the IT system or application for which access authorization is granted (e.g., SAP QM, LIMS LabWare, Veeva Vault QualityDocs, Medidata Rave, MES). Applicable only for system access qualifications; null for professional certifications.',
    `system_role_name` STRING COMMENT 'Name of the role or permission set assigned to the employee within the system (e.g., QC Analyst, Manufacturing Operator, Clinical Data Manager, Quality Reviewer). Defines the scope of system access.',
    `training_completion_date` DATE COMMENT 'Date on which the employee completed the required training associated with this qualification. Supports GMP, GCP, and GLP training record requirements for FDA/EMA inspections.',
    `training_hours` DECIMAL(18,2) COMMENT 'Total number of training hours completed by the employee to achieve this qualification. Tracks continuing education and professional development requirements.',
    CONSTRAINT pk_qualification PRIMARY KEY(`qualification_id`)
) COMMENT 'Master record of professional qualifications, certifications, regulatory competencies, and system access authorizations held by employees. Captures qualification type (GMP qualification, GCP certification, analytical method qualification, auditor certification, DEA handler authorization), system role assignments (SAP, LIMS, MES, Veeva, EDC access with role name, access level, system name), issuing body, assignment/issue date, expiry date, renewal/review status, business justification, approver, and supporting document reference. Serves as the single source of truth for all personnel authorizations — both professional and system-level. Supports 21 CFR Part 11 electronic records compliance, SOX access controls, periodic access review, and personnel qualification packages for FDA/EMA inspections.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique identifier for the performance review record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the performance review (typically HR Business Partner or senior manager).',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Performance reviews should be tied to the position the employee held during the review period. This enables: (1) evaluating performance against position-specific competency requirements and expectatio',
    `primary_performance_employee_id` BIGINT COMMENT 'Identifier of the employee being reviewed. Links to the employee master record.',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the employee conducting the review (typically the direct manager or supervisor).',
    `approval_date` DATE COMMENT 'Date when the performance review was formally approved by the appropriate authority (e.g., HR, senior management).',
    `calibration_session_date` DATE COMMENT 'Date when the review was discussed and calibrated in a management calibration session to ensure consistency across the organization.',
    `calibration_status` STRING COMMENT 'Status of the calibration process for this review (not required, pending, completed, rating adjusted, or rating confirmed).. Valid values are `not_required|pending|completed|rating_adjusted|rating_confirmed`',
    `compensation_impact_flag` BOOLEAN COMMENT 'Indicates whether this review will impact compensation decisions such as merit increases or bonuses (True/False).',
    `competency_collaboration_rating` STRING COMMENT 'Rating for teamwork, cross-functional collaboration, and communication competencies.. Valid values are `exceeds|meets|needs_improvement|unsatisfactory|not_applicable`',
    `competency_compliance_rating` STRING COMMENT 'Rating for adherence to Good Clinical Practice (GCP), Good Manufacturing Practice (GMP), Good Laboratory Practice (GLP), and other regulatory compliance standards.. Valid values are `exceeds|meets|needs_improvement|unsatisfactory|not_applicable`',
    `competency_leadership_rating` STRING COMMENT 'Rating for leadership and people management competencies.. Valid values are `exceeds|meets|needs_improvement|unsatisfactory|not_applicable`',
    `competency_technical_rating` STRING COMMENT 'Rating for technical competencies specific to the employees role (e.g., GMP knowledge, laboratory techniques, regulatory expertise).. Valid values are `exceeds|meets|needs_improvement|unsatisfactory|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was first created in the system.',
    `development_areas_summary` STRING COMMENT 'Narrative summary of areas where the employee needs improvement or further development.',
    `development_plan` STRING COMMENT 'Detailed development plan outlining specific actions, training, or experiences to support the employees growth and address development areas.',
    `employee_acknowledgement_date` DATE COMMENT 'Date when the employee acknowledged the performance review.',
    `employee_acknowledgement_flag` BOOLEAN COMMENT 'Indicates whether the employee has acknowledged receipt and review of their performance evaluation (True/False).',
    `employee_self_assessment` STRING COMMENT 'Employees self-assessment narrative reflecting on their own performance, achievements, and development needs.',
    `goal_achievement_score` DECIMAL(18,2) COMMENT 'Weighted average score of all individual and team goals achieved during the review period (typically 0-100 or 0-5 scale).',
    `gxp_training_compliance_flag` BOOLEAN COMMENT 'Indicates whether the employee maintained compliance with required Good Clinical Practice (GCP), Good Manufacturing Practice (GMP), and Good Laboratory Practice (GLP) training during the review period (True/False). Critical for FDA and EMA audit readiness.',
    `individual_goals_count` STRING COMMENT 'Number of individual goals defined for the employee during the review period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was last modified.',
    `merit_increase_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for a merit-based salary increase based on this review (True/False).',
    `overall_rating` STRING COMMENT 'The overall performance rating assigned to the employee for the review period. [ENUM-REF-CANDIDATE: exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding|developing|not_rated — promote to reference product]. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding|developing`',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric score representing the overall performance rating (e.g., 1.0 to 5.0 scale). Used for quantitative analysis and compensation planning.',
    `performance_improvement_plan_flag` BOOLEAN COMMENT 'Indicates whether the employee has been placed on a Performance Improvement Plan (PIP) as a result of this review (True/False).',
    `promotion_readiness_flag` BOOLEAN COMMENT 'Indicates whether the employee is considered ready for promotion based on this review (True/False).',
    `review_completion_date` DATE COMMENT 'Date when the performance review process was fully completed, including all approvals and employee acknowledgement.',
    `review_cycle_type` STRING COMMENT 'The type of review cycle (annual, mid-year, probationary, project-based, quarterly, or ad-hoc).. Valid values are `annual|mid_year|probationary|project_based|quarterly|ad_hoc`',
    `review_period_end_date` DATE COMMENT 'The end date of the performance period being evaluated (e.g., December 31 for annual review).',
    `review_period_start_date` DATE COMMENT 'The start date of the performance period being evaluated (e.g., January 1 for annual review).',
    `review_status` STRING COMMENT 'Current lifecycle status of the performance review (draft, submitted, in calibration, calibrated, approved, completed, or cancelled). [ENUM-REF-CANDIDATE: draft|submitted|in_calibration|calibrated|approved|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `reviewer_comments` STRING COMMENT 'Detailed comments and feedback provided by the reviewer regarding the employees performance.',
    `strengths_summary` STRING COMMENT 'Narrative summary of the employees key strengths and positive contributions during the review period.',
    `succession_candidate_flag` BOOLEAN COMMENT 'Indicates whether the employee is identified as a succession candidate for critical roles (True/False).',
    `team_goals_count` STRING COMMENT 'Number of team or departmental goals assigned to the employee during the review period.',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Transactional record of formal employee performance evaluations conducted on annual or mid-year cycles. Captures review period, overall rating, competency ratings, individual and team goal definitions with weights and achievement scores, development feedback, reviewer identity, calibration status, and final approval date. Includes cascaded goal-setting from corporate strategy to individual contributors. Supports talent management, promotion decisions, compensation planning, and succession readiness assessment.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` (
    `compensation_plan_id` BIGINT COMMENT 'Unique identifier for the compensation plan record. Primary key for the compensation plan entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee enrolled in this compensation plan. Links to employee master data for individual enrollment tracking.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Compensation plans are designed for job profiles/families, not individual positions. The compensation_plan currently has job_grade_band as a STRING, but should also link to job_profile for systematic ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Compensation structures vary by legal entity for local labor law compliance, tax optimization, and benefit regulations. Creates new FK to link plans to governing legal entities for compliance manageme',
    `approval_status` STRING COMMENT 'Approval workflow status for the compensation plan. Plans must be approved before activation.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or compensation committee member who approved this compensation plan.',
    `approved_date` DATE COMMENT 'Date when the compensation plan was formally approved by the compensation committee or authorized executive.',
    `base_salary_maximum` DECIMAL(18,2) COMMENT 'Maximum base salary amount for the applicable job grade band within this compensation plan. Defines upper limit for salary progression.',
    `base_salary_midpoint` DECIMAL(18,2) COMMENT 'Target or midpoint base salary amount for the applicable job grade band. Represents market-competitive pay level.',
    `base_salary_minimum` DECIMAL(18,2) COMMENT 'Minimum base salary amount for the applicable job grade band within this compensation plan. Used for pay equity analysis and salary range management.',
    `benefit_package_code` STRING COMMENT 'Identifier for the standard benefit package associated with this compensation plan (e.g., health, dental, vision, life insurance, pension/401k, FSA, EAP).',
    `bonus_target_percentage` DECIMAL(18,2) COMMENT 'Target annual bonus as a percentage of base salary for employees enrolled in this plan. Used for total compensation calculations.',
    `compliance_review_date` DATE COMMENT 'Date of the most recent compliance review for this compensation plan. Required for audit readiness.',
    `compliance_review_flag` BOOLEAN COMMENT 'Indicates whether this compensation plan has undergone compliance review for pay equity, regulatory requirements, and internal policy adherence.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compensation plan record was first created in the system. Used for audit and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for monetary amounts in this compensation plan (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when the compensation plan expires or is no longer available for new enrollments. Nullable for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the compensation plan becomes active and available for employee participation. Aligns with annual compensation cycle or plan year start.',
    `eligibility_criteria` STRING COMMENT 'Business rules defining which employees qualify for this compensation plan (e.g., job grade, tenure, performance rating, geographic location).',
    `enrollment_date` DATE COMMENT 'Date when the employee enrolled in this compensation plan. Used for eligibility and vesting calculations.',
    `enrollment_status` STRING COMMENT 'Current enrollment status of the employee in this compensation plan. Tracks individual participation lifecycle.. Valid values are `enrolled|pending|declined|terminated`',
    `geographic_scope` STRING COMMENT 'Geographic applicability of the compensation plan using ISO 3166-1 alpha-3 country codes or region identifiers (e.g., USA, EUR, Global). Supports market-based pay differentiation.',
    `health_insurance_employer_contribution` DECIMAL(18,2) COMMENT 'Standard employer contribution amount toward health insurance premiums for employees enrolled in this plan. May vary by coverage tier.',
    `job_grade_band` STRING COMMENT 'Job grade or band range applicable to this compensation plan (e.g., Grade 10-12, Executive Band). Links to organizational job architecture.',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified the compensation plan record. Required for audit trail and SOX compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the compensation plan record was last updated. Supports change tracking and audit requirements.',
    `lti_eligibility_flag` BOOLEAN COMMENT 'Indicates whether employees in this compensation plan are eligible for long-term incentive programs (e.g., stock options, restricted stock units, performance shares).',
    `lti_target_percentage` DECIMAL(18,2) COMMENT 'Target long-term incentive award as a percentage of base salary. Applicable only when LTI eligibility flag is true.',
    `merit_increase_budget_percentage` DECIMAL(18,2) COMMENT 'Annual merit increase budget as a percentage of current base salary for this compensation plan. Used during annual compensation review cycles.',
    `open_enrollment_end_date` DATE COMMENT 'End date of the annual open enrollment period. Benefit elections must be completed by this date.',
    `open_enrollment_start_date` DATE COMMENT 'Start date of the annual open enrollment period when employees can enroll or modify their benefit elections for this compensation plan.',
    `pay_equity_analysis_flag` BOOLEAN COMMENT 'Indicates whether this compensation plan has been analyzed for pay equity across gender, ethnicity, and other protected classes.',
    `plan_administrator_email` STRING COMMENT 'Email address of the plan administrator for employee inquiries and escalations.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `plan_administrator_name` STRING COMMENT 'Name of the HR or compensation team member responsible for administering this compensation plan. Used for audit and governance purposes.',
    `plan_code` STRING COMMENT 'Externally-known unique business identifier for the compensation plan. Used for cross-system integration and reporting.. Valid values are `^[A-Z0-9]{6,12}$`',
    `plan_description` STRING COMMENT 'Detailed description of the compensation plan including eligibility criteria, calculation methodology, and key terms. Used for employee communication and HR reference.',
    `plan_name` STRING COMMENT 'Human-readable name of the compensation plan (e.g., Executive Long-Term Incentive Plan 2024, Global Base Salary Structure).',
    `plan_status` STRING COMMENT 'Current lifecycle status of the compensation plan. Active plans are available for employee enrollment and payroll processing.. Valid values are `draft|active|suspended|closed|archived`',
    `plan_type` STRING COMMENT 'Classification of the compensation plan by reward category. Determines the structure and rules applied.. Valid values are `base_salary|annual_bonus|long_term_incentive|commission|benefits|total_rewards`',
    `retirement_plan_employer_match_percentage` DECIMAL(18,2) COMMENT 'Employer matching contribution percentage for retirement plans (401k, pension) associated with this compensation plan.',
    `version_number` STRING COMMENT 'Version number of the compensation plan. Incremented with each amendment or update to maintain audit trail.',
    CONSTRAINT pk_compensation_plan PRIMARY KEY(`compensation_plan_id`)
) COMMENT 'Master and transactional record defining total rewards structures and tracking employee benefit enrollments at Pharmaceuticals. Covers base salary bands, bonus targets, long-term incentive (LTI) eligibility, merit increase parameters by grade band, and comprehensive benefit program enrollments (health, dental, vision, life insurance, pension/401k, FSA, employee assistance programs). Captures plan definitions, geographic market differentials, individual employee enrollment records including coverage tier, effective dates, dependent count, employee/employer contribution amounts, enrollment status, and open enrollment lifecycle. Supports workforce cost planning, annual compensation cycles, open enrollment, pay equity analysis, and benefits administration in SAP SuccessFactors.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Unique identifier for the payroll processing cycle. Primary key for the payroll run entity.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Payroll is processed per legal entity for tax withholding, statutory reporting, and financial consolidation. Creates new FK as payroll runs must be segregated by legal entity for compliance and accoun',
    `payroll_period_id` BIGINT COMMENT 'Foreign key linking to workforce.payroll_period. Business justification: Payroll runs occur within defined payroll periods. Currently payroll_run has period dates as attributes but no FK to the payroll_period master table. The start and end dates can be derived from payrol',
    `employee_id` BIGINT COMMENT 'Employee identifier of the payroll specialist or HR administrator who executed this payroll run. Used for audit trail and accountability per SOX (Sarbanes-Oxley Act) compliance requirements.',
    `accounting_period` STRING COMMENT 'Fiscal period to which this payroll run is posted in SAP FI (format: YYYY-MM, e.g., 2024-01). Used for general ledger reconciliation and financial statement preparation.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the payroll run was approved for posting. Part of the audit trail for financial controls and regulatory compliance.',
    `company_code` STRING COMMENT 'Four-character code representing the legal entity for financial reporting and consolidation in SAP S/4HANA FI module. Links payroll costs to the general ledger.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_default` STRING COMMENT 'Default cost center for payroll cost allocation when employee-specific cost centers are not provided. Used for SAP CO (Controlling) module integration and departmental expense tracking.. Valid values are `^[A-Z0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run record was first created in the system. Part of the audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this payroll run (e.g., USD, GBP, EUR, JPY). Ensures consistent financial reporting and multi-currency consolidation.. Valid values are `^[A-Z]{3}$`',
    `fi_document_number` STRING COMMENT 'SAP FI document number generated when payroll costs are posted to the general ledger. Provides audit trail linking payroll transactions to financial statements. Ten-digit numeric identifier.. Valid values are `^[0-9]{10}$`',
    `notes` STRING COMMENT 'Free-text field for payroll administrators to document special circumstances, processing exceptions, or other relevant information about this payroll run (e.g., holiday adjustments, system issues, manual corrections).',
    `payment_date` DATE COMMENT 'Scheduled date when net pay is disbursed to employees via bank transfer, check, or other payment method. Critical for cash flow planning and employee communication.',
    `payroll_area` STRING COMMENT 'Organizational unit representing the country, legal entity, or payroll processing group (e.g., US01, UK01, DE01). Determines payroll calendar, payment frequency, and regulatory jurisdiction. Maps to SAP Payroll Area configuration.. Valid values are `^[A-Z0-9]{2,10}$`',
    `payroll_frequency` STRING COMMENT 'Frequency of payroll processing for this run (monthly, semi-monthly, bi-weekly, weekly, quarterly, annual). Determines the cadence of payroll cycles and employee payment schedules.. Valid values are `monthly|semi-monthly|bi-weekly|weekly|quarterly|annual`',
    `payroll_run_number` STRING COMMENT 'Business identifier for the payroll run, typically formatted as a human-readable code used in SAP S/4HANA HCM Payroll module for tracking and reconciliation purposes.. Valid values are `^[A-Z0-9]{6,20}$`',
    `payroll_schema` STRING COMMENT 'Technical identifier for the payroll calculation logic and rules applied in this run (e.g., US01, UK01). Defines wage types, tax rules, and deduction sequences per jurisdiction in SAP HCM.. Valid values are `^[A-Z0-9]{2,10}$`',
    `posting_date` DATE COMMENT 'Date when payroll costs were posted to the general ledger in SAP FI. May differ from payment date due to accounting cutoff rules. Critical for period-end close and financial reporting.',
    `profit_center_default` STRING COMMENT 'Default profit center for payroll cost allocation when employee-specific profit centers are not provided. Used for SAP CO profitability analysis and segment reporting.. Valid values are `^[A-Z0-9]{10}$`',
    `reversal_reason` STRING COMMENT 'Free-text explanation for why this payroll run was reversed or cancelled. Required for audit documentation and root cause analysis of payroll errors. Null if run was not reversed.',
    `reversal_timestamp` TIMESTAMP COMMENT 'Date and time when the payroll run was reversed. Null if run was not reversed. Used for audit trail and financial reconciliation.',
    `run_status` STRING COMMENT 'Current lifecycle status of the payroll run. Draft = initial creation; Simulated = test run for validation; Released = approved for processing; Posted = finalized and integrated to FI; Reversed = corrected/voided; Cancelled = aborted before completion.. Valid values are `draft|simulated|released|posted|reversed|cancelled`',
    `run_type` STRING COMMENT 'Classification of the payroll run purpose. Regular = standard periodic payroll; Off-cycle = unscheduled payment (e.g., new hire, termination); Correction = adjustment to prior run; Bonus = incentive/commission payment; Final = termination settlement; Advance = early payment.. Valid values are `regular|off-cycle|correction|bonus|final|advance`',
    `sox_scope_flag` BOOLEAN COMMENT 'Indicates whether this payroll run is within the scope of SOX financial controls and audit requirements. True for payroll runs affecting publicly reported financial statements.',
    `total_employees_processed` STRING COMMENT 'Count of employees included in this payroll run. Used for reconciliation and audit purposes to ensure all eligible employees received payslips.',
    `total_gross_pay_amount` DECIMAL(18,2) COMMENT 'Aggregate gross pay across all employees in this run before any deductions (base salary + overtime + bonuses + allowances). Used for financial reconciliation with SAP FI Cost of Goods Sold (COGS) and Profit and Loss (P&L) reporting.',
    `total_net_pay_amount` DECIMAL(18,2) COMMENT 'Aggregate net pay across all employees in this run after all deductions (gross pay - taxes - social security - pension - other deductions). Represents the total cash disbursement required for this payroll cycle.',
    `total_other_deductions_amount` DECIMAL(18,2) COMMENT 'Aggregate of all other deductions not classified as tax, social security, or pension (e.g., health insurance premiums, union dues, garnishments, loan repayments). Used for detailed payroll reconciliation.',
    `total_pension_contribution_amount` DECIMAL(18,2) COMMENT 'Aggregate retirement plan contributions (employee + employer portions) for this run. Includes 401(k), pension schemes, or equivalent per jurisdiction. Must be remitted to pension administrators.',
    `total_social_security_amount` DECIMAL(18,2) COMMENT 'Aggregate social security contributions (employee + employer portions) for this run. Includes FICA (US), National Insurance (UK), or equivalent per jurisdiction. Must be remitted to government agencies.',
    `total_tax_withheld_amount` DECIMAL(18,2) COMMENT 'Aggregate income tax withheld from all employees in this run (federal, state, local). Must be remitted to tax authorities per statutory deadlines. Critical for compliance with IRS, HMRC, and other tax agencies.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run record was last modified. Used for change tracking and audit trail per 21 CFR Part 11 electronic records requirements.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Transactional record of payroll processing cycles and individual employee payslips for Pharmaceuticals. Captures payroll period, run date, payroll area (country/entity), run status (simulated, posted, reversed), total gross/net pay aggregates, and individual employee-level pay details (payslips) including base salary, overtime, bonuses, allowances, tax deductions, social security, pension contributions, net pay, and payment method. Supports financial reconciliation with SAP S/4HANA FI module, employee self-service pay statements, statutory reporting, and payroll audit per jurisdiction.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` (
    `payslip_id` BIGINT COMMENT 'Unique identifier for the payslip record. Primary key for the payslip entity.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Workforce payslips should link to finance journal entries for payroll accounting and financial reporting. This enables integrated payroll processing with proper financial controls and GL posting.',
    `payroll_run_id` BIGINT COMMENT 'Reference to the payroll period for which this payslip was generated. Links to the payroll period master data.',
    `employee_id` BIGINT COMMENT 'User identifier of the payroll administrator or manager who approved this payslip for payment. Required for SOX compliance and audit trail.',
    `payslip_employee_id` BIGINT COMMENT 'Reference to the employee who received this payslip. Links to the employee master data record.',
    `allowances` DECIMAL(18,2) COMMENT 'Sum of all allowances paid in this period, including housing, transportation, meal, shift, and other statutory or contractual allowances.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this payslip was approved for payment. Part of the payroll approval workflow audit trail.',
    `bank_account_number` STRING COMMENT 'The masked or tokenized bank account number to which net pay was transferred. Full account number is stored in secure vault per PCI DSS requirements.',
    `bank_name` STRING COMMENT 'Name of the financial institution where the employee bank account is held, used for payment reconciliation.',
    `base_salary` DECIMAL(18,2) COMMENT 'The regular base salary amount for the payroll period, excluding overtime, bonuses, and allowances.',
    `bonus_payment` DECIMAL(18,2) COMMENT 'Discretionary or performance-based bonus payments included in this payslip, such as annual bonuses, spot awards, or incentive payments.',
    `company_code` STRING COMMENT 'The legal entity or company code under which this payslip was processed. Used for multi-entity payroll consolidation and statutory reporting.',
    `cost_center_code` STRING COMMENT 'The cost center to which this employees payroll costs are allocated for financial reporting and budgeting purposes.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the jurisdiction under which this payslip was processed. Determines applicable tax and labor laws.. Valid values are `^[A-Z]{3}$`',
    `generated_timestamp` TIMESTAMP COMMENT 'The date and time when this payslip record was generated by the payroll system. Represents the payroll calculation event timestamp.',
    `gross_pay` DECIMAL(18,2) COMMENT 'Total gross earnings before any deductions. Sum of base salary, overtime, bonuses, and allowances.',
    `health_insurance_deduction` DECIMAL(18,2) COMMENT 'Employee portion of health insurance premiums deducted from gross pay for medical, dental, and vision coverage.',
    `hours_worked` DECIMAL(18,2) COMMENT 'Total number of regular hours worked during the payroll period, excluding overtime hours. Used for hourly wage calculations.',
    `leave_balance` DECIMAL(18,2) COMMENT 'Remaining leave balance available to the employee as of the end of this payroll period, expressed in days.',
    `leave_days_taken` DECIMAL(18,2) COMMENT 'Number of paid leave days taken during the payroll period, including vacation, sick leave, and other paid time off.',
    `net_pay` DECIMAL(18,2) COMMENT 'Final take-home pay amount after all deductions. Calculated as gross pay minus total deductions. This is the amount disbursed to the employee.',
    `other_deductions` DECIMAL(18,2) COMMENT 'Sum of all other deductions not categorized above, including union dues, garnishments, loan repayments, and voluntary deductions.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Total number of overtime hours worked during the payroll period, including regular overtime and premium overtime.',
    `overtime_pay` DECIMAL(18,2) COMMENT 'Total overtime compensation for the payroll period, including regular overtime and premium overtime rates.',
    `payment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this payslip (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `payment_date` DATE COMMENT 'The date on which the net pay was disbursed to the employee. Represents the actual payment event date.',
    `payment_method` STRING COMMENT 'The method by which net pay was disbursed to the employee. Supports multiple payment instruments per jurisdiction.. Valid values are `bank_transfer|check|cash|payroll_card|mobile_payment`',
    `payroll_area` STRING COMMENT 'Payroll processing area or grouping that defines the payroll frequency and processing schedule (e.g., monthly salaried, bi-weekly hourly).',
    `payslip_number` STRING COMMENT 'Externally visible unique payslip document number assigned by the payroll system. Used for employee self-service and audit trail.',
    `payslip_status` STRING COMMENT 'Current lifecycle status of the payslip record. Tracks progression from draft through approval, payment, and any subsequent corrections or voids.. Valid values are `draft|approved|paid|voided|corrected`',
    `pension_contribution` DECIMAL(18,2) COMMENT 'Employee pension or retirement plan contributions deducted from gross pay, including mandatory and voluntary contributions.',
    `period_end_date` DATE COMMENT 'The last day of the payroll period covered by this payslip.',
    `period_start_date` DATE COMMENT 'The first day of the payroll period covered by this payslip.',
    `social_security_contribution` DECIMAL(18,2) COMMENT 'Employee portion of social security or national insurance contributions deducted from gross pay, as required by jurisdiction.',
    `tax_deduction` DECIMAL(18,2) COMMENT 'Total income tax withheld from gross pay for the payroll period, including federal, state, and local taxes as applicable by jurisdiction.',
    `total_deductions` DECIMAL(18,2) COMMENT 'Sum of all deductions from gross pay, including tax, social security, pension, health insurance, and other deductions.',
    `year_to_date_gross` DECIMAL(18,2) COMMENT 'Cumulative gross pay from the beginning of the calendar or fiscal year through the end of this payroll period. Used for tax reporting and compliance.',
    `year_to_date_net` DECIMAL(18,2) COMMENT 'Cumulative net pay from the beginning of the calendar or fiscal year through the end of this payroll period.',
    `year_to_date_tax` DECIMAL(18,2) COMMENT 'Cumulative income tax withheld from the beginning of the calendar or fiscal year through the end of this payroll period. Used for tax reporting and W-2/T4 preparation.',
    CONSTRAINT pk_payslip PRIMARY KEY(`payslip_id`)
) COMMENT 'Transactional record of individual employee payslips generated per payroll cycle. Captures employee reference, payroll period, gross pay, net pay, base salary, overtime pay, bonus payment, allowances, tax deductions, social security contributions, pension contributions, and payment method. Supports employee self-service, payroll audit, and statutory compliance reporting per jurisdiction.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Unique identifier for the benefit enrollment record. Primary key for the benefit enrollment transaction.',
    `plan_id` BIGINT COMMENT 'Unique identifier of the benefit plan in which the employee is enrolling. References the benefit plan master data.',
    `compensation_plan_id` BIGINT COMMENT 'Foreign key linking to workforce.compensation_plan. Business justification: Benefit enrollments are part of compensation plans. Currently benefit_enrollment has plan_type as string but no FK to the authoritative compensation plan that defines the benefit structure. The plan_t',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee enrolling in the benefit program. Links to the employee master record in SAP HCM.',
    `annual_election_amount` DECIMAL(18,2) COMMENT 'Total annual amount elected by employee for FSA, HSA, or 401k contributions. Used for payroll deduction calculation and IRS compliance reporting.',
    `approval_status` STRING COMMENT 'Status of HR or benefits administrator approval for this enrollment. Certain enrollments (life events, COBRA) require manual review before activation.. Valid values are `pending|approved|rejected|review_required`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the enrollment was approved by HR or benefits administrator. Nullable if not yet approved.',
    `beneficiary_designation` STRING COMMENT 'Name(s) of designated beneficiaries for life insurance or pension benefits. Confidential information used for claims processing. Nullable for non-applicable benefit types.',
    `carrier_member_number` STRING COMMENT 'Unique member identifier assigned by the insurance carrier to the employee. Used on insurance cards and for claims processing. Restricted PII.',
    `carrier_policy_number` STRING COMMENT 'Insurance carriers policy or certificate number assigned to this enrollment. Used for claims processing and carrier reconciliation.',
    `cobra_continuation_flag` BOOLEAN COMMENT 'Indicates whether this enrollment is a COBRA continuation coverage following termination of employment. True for COBRA enrollments, False for active employee enrollments.',
    `company_code` STRING COMMENT 'Legal entity or company code in SAP S/4HANA to which this enrollment belongs. Used for multi-entity financial and compliance reporting.',
    `contribution_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for employee and employer contribution amounts. Supports multi-country payroll operations.. Valid values are `^[A-Z]{3}$`',
    `contribution_frequency` STRING COMMENT 'Frequency at which employee and employer contributions are deducted or paid: weekly, biweekly, semi-monthly, monthly, or annual.. Valid values are `weekly|biweekly|semimonthly|monthly|annual`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the employee is enrolled. Supports multi-country benefit plan administration and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `coverage_tier` STRING COMMENT 'Level of coverage elected by the employee: employee only, employee plus spouse, employee plus children, or full family coverage. Determines premium rates and contribution amounts.. Valid values are `employee_only|employee_spouse|employee_children|family`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this enrollment record was first created in the system. Audit trail field for data lineage and compliance.',
    `csv_scope_flag` BOOLEAN COMMENT 'Indicates whether this enrollment record is within the scope of computer system validation per 21 CFR Part 11. True for GxP-regulated personnel benefit records requiring validation.',
    `dependent_count` STRING COMMENT 'Number of dependents covered under this enrollment. Used for premium calculation and compliance reporting.',
    `effective_end_date` DATE COMMENT 'Date when the benefit coverage ends. Nullable for open-ended enrollments. Populated upon termination, cancellation, or plan year end.',
    `effective_start_date` DATE COMMENT 'Date when the benefit coverage becomes active and the employee is eligible to use the benefit. May differ from enrollment date due to waiting periods or plan year start dates.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Amount deducted from employee paycheck per pay period for this benefit. Represents the employees share of the premium or contribution.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Amount contributed by the employer per pay period for this benefit. Represents the employers share of the premium or contribution for financial and compliance reporting.',
    `enrollment_date` DATE COMMENT 'Date when the employee submitted the benefit enrollment election. Represents the business event timestamp of the enrollment transaction.',
    `enrollment_event_type` STRING COMMENT 'Type of qualifying event that triggered the enrollment: new hire enrollment, annual open enrollment period, qualifying life event (marriage, birth, etc.), COBRA continuation, or rehire enrollment.. Valid values are `new_hire|annual_open|life_event|cobra|rehire`',
    `enrollment_method` STRING COMMENT 'Channel through which the employee completed the enrollment: online self-service portal, paper form, phone enrollment, HR-assisted enrollment, or automatic enrollment.. Valid values are `online_portal|paper_form|phone|hr_assisted|auto_enrollment`',
    `enrollment_number` STRING COMMENT 'Business-facing enrollment confirmation number provided to the employee. Used for tracking and reference in HR communications.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the benefit enrollment. Tracks whether the enrollment is pending approval, active, suspended due to leave, terminated, cancelled by employee, or waived.. Valid values are `pending|active|suspended|terminated|cancelled|waived`',
    `qualifying_life_event_date` DATE COMMENT 'Date of the qualifying life event (marriage, birth, adoption, divorce, etc.) that allowed mid-year enrollment change. Nullable if not applicable.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this enrollment record originated: SAP HCM Benefits module, Workday, Oracle HCM, ADP, or manual entry.. Valid values are `SAP_HCM|WORKDAY|ORACLE_HCM|ADP|MANUAL`',
    `termination_reason` STRING COMMENT 'Reason for termination of benefit coverage: employment termination, voluntary cancellation, plan discontinuation, loss of eligibility, etc. Nullable if enrollment is active.',
    `termination_timestamp` TIMESTAMP COMMENT 'Date and time when the benefit enrollment was terminated in the system. Nullable if enrollment is active.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this enrollment record was last modified in the system. Audit trail field for change tracking and compliance.',
    `waiver_flag` BOOLEAN COMMENT 'Indicates whether the employee actively waived this benefit coverage. True if waived, False if enrolled.',
    `waiver_reason` STRING COMMENT 'Free-text explanation provided by employee if they waived coverage. Common reasons include coverage through spouse, Medicare, or other insurance. Nullable if not waived.',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Transactional record of employee enrollment in benefit programs including health insurance, dental, vision, life insurance, pension/401k, employee assistance programs, and flexible spending accounts. Captures benefit plan type, coverage tier, enrollment date, effective date, dependent count, employee contribution amount, employer contribution amount, and enrollment status. Sourced from SAP HCM Benefits module.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique identifier for the leave request transaction. Primary key for the leave request record.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or authorized person who approved or rejected the leave request. Links to the employee master record. Null if request is not yet processed.',
    `primary_leave_employee_id` BIGINT COMMENT 'Identifier of the employee submitting the leave request. Links to the employee master record in the workforce domain.',
    `tertiary_leave_updated_by_user_employee_id` BIGINT COMMENT 'System user identifier of the person who last modified the leave request record. Used for audit trail and compliance with 21 CFR Part 11 electronic records requirements.',
    `approval_comments` STRING COMMENT 'Free-text comments provided by the approver during the approval or rejection decision. May include conditions, alternative arrangements, or reasons for rejection.',
    `approval_date` DATE COMMENT 'Date when the leave request was approved or rejected by the authorized approver. Null if request is still pending or in draft status.',
    `attachment_count` STRING COMMENT 'Number of supporting documents attached to the leave request (e.g., medical certificates, travel itineraries, legal notices). Used for compliance verification and audit readiness.',
    `balance_after` DECIMAL(18,2) COMMENT 'Employee leave balance in days for the applicable leave type after this request was approved and deducted. Calculated as balance_before minus duration_days. Used for entitlement tracking and compliance.',
    `balance_before` DECIMAL(18,2) COMMENT 'Employee leave balance in days for the applicable leave type immediately before this request was approved. Snapshot value for audit trail and balance reconciliation.',
    `company_code` STRING COMMENT 'Four-character code identifying the legal entity or company within the Pharmaceuticals corporate structure where the employee is employed. Used for multi-entity reporting and compliance with local labor regulations.. Valid values are `^[A-Z0-9]{4}$`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the employee is employed. Determines applicable labor law, leave entitlement rules, and regulatory reporting requirements.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the leave request record was first created in the system. Used for audit trail and data lineage tracking.',
    `duration_days` DECIMAL(18,2) COMMENT 'Total number of working days requested for leave, excluding weekends and public holidays. Supports fractional days for partial-day absences (e.g., 0.5 for half-day leave). Used for leave balance deduction and workforce capacity planning.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total number of working hours requested for leave. Calculated based on employee work schedule and used for hourly leave tracking and payroll deduction calculations.',
    `emergency_contact_notified_flag` BOOLEAN COMMENT 'Indicates whether the employees emergency contact was notified about the leave (True) or not (False). Typically True for extended medical or emergency leave situations.',
    `end_date` DATE COMMENT 'Last calendar date of the requested leave period. Employee is expected to return to work the following business day.',
    `gxp_critical_role_flag` BOOLEAN COMMENT 'Indicates whether the employee holds a GxP-critical role (GMP, GCP, GLP) requiring special absence management and substitute qualification verification (True) or not (False). Used for regulatory compliance and audit readiness for FDA/EMA inspections.',
    `half_day_flag` BOOLEAN COMMENT 'Indicates whether the leave request is for a half-day absence (True) or full-day absence (False). Used for precise leave balance calculation and workforce scheduling.',
    `half_day_period` STRING COMMENT 'Specifies which half of the day is requested for leave when half_day_flag is True. AM=morning absence, PM=afternoon absence. Null for full-day leave requests.. Valid values are `AM|PM`',
    `handover_completed_flag` BOOLEAN COMMENT 'Indicates whether the employee has completed the work handover process to the substitute or team before starting leave (True) or not (False). Used for operational readiness tracking in GxP-regulated functions.',
    `leave_type_code` STRING COMMENT 'Classification of the leave request type. Determines entitlement rules, approval workflows, and payroll treatment. ANNUAL=paid annual vacation, SICK=illness absence, PARENTAL=family care leave, MATERNITY=maternity leave, PATERNITY=paternity leave, STUDY=educational leave, BEREAVEMENT=compassionate leave, UNPAID=unpaid time off, SABBATICAL=extended career break, JURY_DUTY=civic duty, MILITARY=military service. [ENUM-REF-CANDIDATE: ANNUAL|SICK|PARENTAL|MATERNITY|PATERNITY|STUDY|BEREAVEMENT|UNPAID|SABBATICAL|JURY_DUTY|MILITARY — 11 candidates stripped; promote to reference product]',
    `medical_certificate_received_flag` BOOLEAN COMMENT 'Indicates whether the required medical certificate has been received and verified (True) or is still outstanding (False). Null if medical certificate is not required for this request.',
    `medical_certificate_required_flag` BOOLEAN COMMENT 'Indicates whether a medical certificate or doctors note is required for this leave request (True) or not (False). Typically True for sick leave exceeding a threshold duration as per company policy or local labor law.',
    `paid_flag` BOOLEAN COMMENT 'Indicates whether the leave period is paid (True) or unpaid (False). Determines payroll treatment and salary deduction requirements. Derived from leave type and employee entitlement rules.',
    `payroll_period` STRING COMMENT 'Payroll period (YYYY-MM format) in which the leave impact was processed for salary calculation. Used for payroll reconciliation and financial reporting.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `payroll_processed_flag` BOOLEAN COMMENT 'Indicates whether the leave request has been processed in the payroll system for salary adjustment or deduction (True) or is pending payroll processing (False). Used for payroll reconciliation and audit trail.',
    `reason_code` STRING COMMENT 'Standardized reason category for the leave request. Used for workforce analytics, absence pattern analysis, and compliance reporting. VACATION=planned time off, ILLNESS=health-related absence, FAMILY_CARE=dependent care, MEDICAL_APPOINTMENT=healthcare visit, PERSONAL=personal matters, EMERGENCY=unplanned urgent situation, TRAINING=educational activity, OTHER=miscellaneous. [ENUM-REF-CANDIDATE: VACATION|ILLNESS|FAMILY_CARE|MEDICAL_APPOINTMENT|PERSONAL|EMERGENCY|TRAINING|OTHER — 8 candidates stripped; promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text explanation provided by the employee describing the reason for the leave request. Optional field for additional context beyond the standardized reason code.',
    `request_date` DATE COMMENT 'Date when the employee submitted the leave request. Represents the business event timestamp for the transaction initiation.',
    `request_number` STRING COMMENT 'Business-facing unique identifier for the leave request, typically system-generated in format LR-YYYYNNNN for external reference and employee communication.. Valid values are `^LR-[0-9]{8}$`',
    `request_status` STRING COMMENT 'Current lifecycle status of the leave request. DRAFT=saved but not submitted, SUBMITTED=awaiting manager review, PENDING_APPROVAL=in approval workflow, APPROVED=authorized and confirmed, REJECTED=denied by approver, WITHDRAWN=retracted by employee before approval, CANCELLED=revoked after approval. [ENUM-REF-CANDIDATE: DRAFT|SUBMITTED|PENDING_APPROVAL|APPROVED|REJECTED|WITHDRAWN|CANCELLED — 7 candidates stripped; promote to reference product]',
    `return_to_work_confirmed_flag` BOOLEAN COMMENT 'Indicates whether the employees return to work has been confirmed by the manager or HR (True) or is pending confirmation (False). Used for attendance tracking and workforce availability updates.',
    `return_to_work_date` DATE COMMENT 'Actual date when the employee returned to work after the leave period. May differ from the planned end_date if leave was extended or curtailed. Used for attendance reconciliation and workforce planning accuracy.',
    `site_location_code` STRING COMMENT 'Code identifying the physical site or facility where the employee is based. Used for site-level workforce availability planning and local labor law compliance.. Valid values are `^[A-Z]{3}[0-9]{2}$`',
    `start_date` DATE COMMENT 'First calendar date of the requested leave period. Employee is expected to be absent starting from this date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the leave request record was last modified. Used for audit trail, change tracking, and data quality monitoring.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Transactional record of employee leave requests and absences including annual leave, sick leave, parental leave, study leave, and unpaid leave. Captures leave type, requested start date, end date, duration in days, approval status, approver identity, reason code, and balance impact. Supports workforce availability planning, payroll deductions, and compliance with local labor regulations across Pharmaceuticals global sites.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` (
    `recruitment_requisition_id` BIGINT COMMENT 'Unique identifier for the recruitment requisition record. Primary key for the recruitment requisition entity.',
    `department_id` BIGINT COMMENT 'Reference to the department organizational unit where the position will be assigned. Links to department master data for cost center, functional area, and GxP scope.',
    `job_profile_id` BIGINT COMMENT 'Reference to the standardized job profile defining role responsibilities, required competencies, qualifications, and career level for this requisition.',
    `position_id` BIGINT COMMENT 'Reference to the position master record that defines the job profile, organizational assignment, and role specifications for this requisition.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the hiring manager responsible for the requisition approval, candidate selection, and final hiring decision.',
    `quaternary_recruitment_recruiter_employee_id` BIGINT COMMENT 'Employee identifier of the talent acquisition specialist or recruiter assigned to manage the recruitment process for this requisition.',
    `site_id` BIGINT COMMENT 'Reference to the physical site or facility location where the hired employee will be based. Critical for GMP, GLP, and GCP site-specific training and compliance requirements.',
    `tertiary_recruitment_approved_by_employee_id` BIGINT COMMENT 'Employee identifier of the approver who authorized the requisition (typically HR Director, Finance Controller, or senior executive with budget authority).',
    `approval_date` DATE COMMENT 'Date when the requisition received final approval and was authorized to proceed with recruitment activities.',
    `approved_salary_range_max` DECIMAL(18,2) COMMENT 'Maximum approved annual salary or hourly rate for the position, as authorized by compensation and budget approval process.',
    `approved_salary_range_min` DECIMAL(18,2) COMMENT 'Minimum approved annual salary or hourly rate for the position, as authorized by compensation and budget approval process.',
    `budget_approval_reference` STRING COMMENT 'Reference number or identifier of the budget approval document or internal order authorizing the headcount and associated compensation costs.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the requisition was cancelled or withdrawn (e.g., budget cuts, organizational restructuring, position eliminated, internal fill).',
    `comments` STRING COMMENT 'Free-text field for additional notes, special instructions, or context relevant to the requisition that does not fit structured fields.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity that will employ the hired candidate. Critical for payroll, tax, and legal compliance.',
    `cost_center_code` STRING COMMENT 'SAP cost center code to which the hired employee salary and benefits costs will be charged. Used for financial planning and budget tracking.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the work location country. Determines applicable labor laws, tax regulations, and employment standards.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the recruitment requisition record was first created in the system. Used for audit trail and process timeline tracking.',
    `employment_type` STRING COMMENT 'Type of employment relationship being recruited for: full-time permanent, part-time, fixed-term temporary, contractor, or internship.. Valid values are `full_time|part_time|temporary|contract|intern`',
    `gmp_critical_flag` BOOLEAN COMMENT 'Indicates whether the position is GMP-critical, requiring specific cGMP training, qualification, and audit trail documentation per FDA 21 CFR Part 211 and EMA GMP guidelines.',
    `gxp_regulated_flag` BOOLEAN COMMENT 'Indicates whether the position requires GxP (GMP, GLP, GCP) compliance training and certification. True for roles in regulated manufacturing, laboratory, or clinical operations subject to FDA, EMA, or ICH requirements.',
    `headcount_quantity` STRING COMMENT 'Number of positions to be filled under this requisition. Typically 1 for individual roles, may be greater for bulk hiring initiatives.',
    `job_description` STRING COMMENT 'Comprehensive description of the role responsibilities, key accountabilities, reporting relationships, and success criteria. Used in job postings and candidate communications.',
    `job_posting_title` STRING COMMENT 'External-facing job title used in job postings and advertisements. May differ from internal position title for market competitiveness and candidate attraction.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to the recruitment requisition record. Used for change tracking and audit compliance.',
    `minimum_experience_years` STRING COMMENT 'Minimum number of years of relevant professional experience required for the position.',
    `preferred_qualifications` STRING COMMENT 'Desired but not mandatory qualifications, skills, and experience that would make a candidate more competitive (e.g., experience with Veeva Vault, knowledge of ICH guidelines).',
    `priority_level` STRING COMMENT 'Business priority assigned to the requisition indicating urgency of fill: critical (business-critical role, immediate need), high (important role, fill within 30 days), medium (standard priority), low (opportunistic hire).. Valid values are `critical|high|medium|low`',
    `required_qualifications` STRING COMMENT 'Detailed description of mandatory educational qualifications, certifications, licenses, and professional credentials required for the position (e.g., PhD in Chemistry, PharmD license, CQA certification).',
    `requisition_close_date` DATE COMMENT 'Date when the requisition was closed, either due to successful fill, cancellation, or other closure reason.',
    `requisition_number` STRING COMMENT 'Business identifier for the recruitment requisition, externally visible and used for tracking and reference in talent acquisition workflows.. Valid values are `^REQ-[0-9]{8}$`',
    `requisition_open_date` DATE COMMENT 'Date when the requisition was approved and opened for active recruitment, marking the start of the talent acquisition process.',
    `requisition_status` STRING COMMENT 'Current lifecycle state of the recruitment requisition: draft (being prepared), pending approval (awaiting budget/manager approval), approved (ready to post), open (actively recruiting), in progress (candidates in pipeline), filled (position accepted), cancelled (requisition withdrawn), or on hold (temporarily paused). [ENUM-REF-CANDIDATE: draft|pending_approval|approved|open|in_progress|filled|cancelled|on_hold — 8 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Classification of the requisition purpose: new headcount creation, replacement for departed employee, temporary coverage, contractor engagement, or internship program.. Valid values are `new_position|replacement|backfill|temporary|contractor|intern`',
    `salary_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the approved salary range (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `sourcing_channel` STRING COMMENT 'Primary recruitment sourcing strategy for this requisition: internal mobility, external job boards, employee referral program, recruitment agency, campus recruiting, LinkedIn, or other job posting platforms. [ENUM-REF-CANDIDATE: internal|external|referral|agency|campus|linkedin|job_board — 7 candidates stripped; promote to reference product]',
    `target_start_date` DATE COMMENT 'Desired date by which the hired candidate should commence employment. Used for workforce planning and recruitment timeline management.',
    CONSTRAINT pk_recruitment_requisition PRIMARY KEY(`recruitment_requisition_id`)
) COMMENT 'Transactional record of approved headcount requisitions initiating the talent acquisition process. Captures requisition number, position reference, hiring manager, department, site, job profile, required qualifications, GxP role flag, target start date, requisition status (draft, approved, open, filled, cancelled), sourcing channel, and budget approval reference. Supports workforce planning and talent pipeline management.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` (
    `candidate_id` BIGINT COMMENT 'Unique identifier for the candidate record in the talent acquisition system. Primary key.',
    `employee_id` BIGINT COMMENT 'Employee ID of the internal recruiter or talent acquisition specialist assigned to manage this candidate.',
    `candidate_referral_employee_id` BIGINT COMMENT 'Employee ID of the internal employee who referred this candidate, if applicable.',
    `background_check_completion_date` DATE COMMENT 'Date on which the candidates background check was completed.',
    `background_check_status` STRING COMMENT 'Current status of the candidates pre-employment background verification process.. Valid values are `not_initiated|in_progress|clear|flagged|failed`',
    `candidate_number` STRING COMMENT 'Human-readable business identifier for the candidate, typically system-generated and used in communications and reporting.. Valid values are `^CAN-[0-9]{8}$`',
    `candidate_status` STRING COMMENT 'Current overall status of the candidate in the talent acquisition pipeline across all applications.. Valid values are `new|active|screening|interviewing|offer_extended|hired`',
    `city` STRING COMMENT 'City or municipality of the candidates current residence.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the candidates current country of residence.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the candidate record was first created in the system.',
    `current_employer` STRING COMMENT 'Name of the candidates current employer organization, if disclosed.',
    `current_job_title` STRING COMMENT 'Candidates current job title or role at their present employer.',
    `degree_field` STRING COMMENT 'Primary field of study or major for the candidates highest degree (e.g., Chemistry, Pharmacology, Biochemistry, Engineering).',
    `diversity_self_identification` STRING COMMENT 'Candidates voluntary self-identification for diversity and inclusion tracking purposes, collected in compliance with equal employment opportunity regulations.',
    `email_address` STRING COMMENT 'Primary email address for candidate communication throughout the recruitment process.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `expected_salary_amount` DECIMAL(18,2) COMMENT 'Candidates expected or desired annual salary amount.',
    `expected_salary_currency` STRING COMMENT 'Three-letter ISO currency code for the candidates expected salary amount.. Valid values are `^[A-Z]{3}$`',
    `first_name` STRING COMMENT 'Legal first name of the candidate as provided in application materials.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether the candidate has provided explicit consent for processing of personal data under GDPR. True if consent given, False otherwise.',
    `gxp_experience_flag` BOOLEAN COMMENT 'Indicates whether the candidate has prior experience working in GxP-regulated environments (GMP, GLP, GCP, GDP). True if candidate has GxP experience, False otherwise.',
    `gxp_experience_years` DECIMAL(18,2) COMMENT 'Number of years the candidate has worked in GxP-regulated roles or environments.',
    `highest_education_level` STRING COMMENT 'Highest level of formal education attained by the candidate.. Valid values are `high_school|associate|bachelor|master|doctorate|professional`',
    `initial_contact_date` DATE COMMENT 'Date on which the candidate was first contacted or entered the talent acquisition system.',
    `last_name` STRING COMMENT 'Legal last name (surname) of the candidate as provided in application materials.',
    `linkedin_profile_url` STRING COMMENT 'URL to the candidates LinkedIn professional profile, if provided.',
    `medical_clearance_status` STRING COMMENT 'Status of pre-employment medical clearance for candidates being hired into GxP-regulated or safety-critical roles.. Valid values are `not_required|pending|cleared|conditional|failed`',
    `notice_period_days` STRING COMMENT 'Number of days of notice the candidate must provide to their current employer before resignation, if applicable.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the candidate, including country code where applicable.',
    `preferred_locations` STRING COMMENT 'Candidates preferred geographic locations for employment, pipe-delimited if multiple.',
    `resume_file_path` STRING COMMENT 'File system or cloud storage path to the candidates uploaded resume or curriculum vitae document.',
    `source_channel` STRING COMMENT 'Primary channel through which the candidate was sourced or entered the talent acquisition pipeline.. Valid values are `job_board|employee_referral|agency|campus_recruitment|social_media|career_site`',
    `source_detail` STRING COMMENT 'Detailed source information such as specific job board name, referrer employee ID, agency name, or university name.',
    `state_province` STRING COMMENT 'State, province, or region of the candidates current residence.',
    `therapeutic_area_expertise` STRING COMMENT 'Primary therapeutic area(s) in which the candidate has specialized experience (e.g., Oncology, Immunology, Rare Diseases, Cardiovascular). Pipe-delimited for multiple areas.',
    `total_years_experience` DECIMAL(18,2) COMMENT 'Total number of years of relevant professional work experience as declared by the candidate.',
    `veteran_status` STRING COMMENT 'Candidates veteran status, voluntarily disclosed for compliance with veteran employment regulations.',
    `willing_to_relocate_flag` BOOLEAN COMMENT 'Indicates whether the candidate is willing to relocate for employment opportunities. True if willing, False otherwise.',
    `work_authorization_status` STRING COMMENT 'Current work authorization status of the candidate for the target country of employment.. Valid values are `citizen|permanent_resident|work_visa|requires_sponsorship|not_authorized`',
    CONSTRAINT pk_candidate PRIMARY KEY(`candidate_id`)
) COMMENT 'Master record for job applicants in the talent acquisition pipeline, including their complete application history to specific requisitions. Captures candidate identity, contact details, source channel, qualifications, therapeutic area expertise, GxP experience flag, visa/work authorization, and per-application transactional details including application date, application source, screening status, interview stage, assessment scores, offer status, rejection reason, background check status, pre-employment medical clearance for GxP roles, and hiring decision. Supports end-to-end recruitment tracking from sourcing through offer acceptance across multiple requisitions.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` (
    `job_application_id` BIGINT COMMENT 'Unique identifier for the job application record. Primary key for the job application entity.',
    `candidate_id` BIGINT COMMENT 'Reference to the candidate who submitted this application. Links to the candidate master record in the talent acquisition system.',
    `employee_id` BIGINT COMMENT 'Reference to the recruiter or talent acquisition specialist managing this application. Links to the employee master record.',
    `recruitment_requisition_id` BIGINT COMMENT 'Reference to the recruitment requisition for which this application was submitted. Links to the job requisition master record.',
    `tertiary_job_referral_employee_id` BIGINT COMMENT 'Reference to the employee who referred this candidate, if the application source is employee referral. Links to the employee master record.',
    `actual_start_date` DATE COMMENT 'Actual start date when the candidate joined the organization after accepting the offer. Format: yyyy-MM-dd.',
    `application_date` DATE COMMENT 'Date when the candidate submitted the application for the requisition. Format: yyyy-MM-dd.',
    `application_number` STRING COMMENT 'Human-readable unique application number assigned to this job application for tracking and reference purposes.',
    `application_source` STRING COMMENT 'Channel or source through which the candidate submitted the application (e.g., career site, employee referral, recruitment agency, job board). [ENUM-REF-CANDIDATE: career_site|employee_referral|recruitment_agency|job_board|social_media|campus_recruitment|internal_posting|direct_application|other — 9 candidates stripped; promote to reference product]',
    `application_status` STRING COMMENT 'Current status of the application in the recruitment workflow (e.g., submitted, under review, screening, interview, assessment, offer, rejected, withdrawn, hired). [ENUM-REF-CANDIDATE: submitted|under_review|screening|interview|assessment|offer|rejected|withdrawn|hired — 9 candidates stripped; promote to reference product]',
    `assessment_result` STRING COMMENT 'Overall result of candidate assessments (e.g., not assessed, passed, failed, pending).. Valid values are `not_assessed|passed|failed|pending`',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numerical score from candidate assessments (e.g., technical tests, psychometric evaluations, competency assessments). Scale and interpretation vary by assessment type.',
    `background_check_date` DATE COMMENT 'Date when the background check was completed. Format: yyyy-MM-dd.',
    `background_check_status` STRING COMMENT 'Status of the background check for the candidate (e.g., not initiated, in progress, cleared, flagged, failed). Critical for GxP roles requiring regulatory compliance.. Valid values are `not_initiated|in_progress|cleared|flagged|failed`',
    `comments` STRING COMMENT 'Free-text comments or notes about the application, candidate performance, interview feedback, or other relevant information for audit and decision-making purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the application record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `expected_start_date` DATE COMMENT 'Expected or proposed start date for the candidate if hired. Format: yyyy-MM-dd.',
    `gxp_role_flag` BOOLEAN COMMENT 'Indicates whether the requisition is for a GxP-regulated role requiring compliance with GMP, GLP, or GCP standards. True if the role requires GxP training and certification.',
    `hiring_decision` STRING COMMENT 'Final hiring decision for this application (e.g., pending, hire, no hire).. Valid values are `pending|hire|no_hire`',
    `hiring_decision_date` DATE COMMENT 'Date when the final hiring decision was made for this application. Format: yyyy-MM-dd.',
    `interview_date` DATE COMMENT 'Date of the most recent or scheduled interview for this application. Format: yyyy-MM-dd.',
    `interview_stage` STRING COMMENT 'Current interview stage for the application (e.g., not scheduled, phone screen, first round, second round, panel interview, final round, completed). [ENUM-REF-CANDIDATE: not_scheduled|phone_screen|first_round|second_round|panel_interview|final_round|completed — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the application record was last modified or updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `medical_clearance_date` DATE COMMENT 'Date when pre-employment medical clearance was obtained. Format: yyyy-MM-dd.',
    `medical_clearance_status` STRING COMMENT 'Status of pre-employment medical clearance for GxP roles requiring health screening (e.g., not required, pending, cleared, conditional, failed). Required for roles in GMP manufacturing and laboratory environments.. Valid values are `not_required|pending|cleared|conditional|failed`',
    `offer_acceptance_date` DATE COMMENT 'Date when the candidate accepted the job offer. Format: yyyy-MM-dd.',
    `offer_date` DATE COMMENT 'Date when the job offer was extended to the candidate. Format: yyyy-MM-dd.',
    `offer_status` STRING COMMENT 'Status of the job offer for this application (e.g., not extended, pending, accepted, declined, withdrawn, expired).. Valid values are `not_extended|pending|accepted|declined|withdrawn|expired`',
    `referral_bonus_eligible_flag` BOOLEAN COMMENT 'Indicates whether the referring employee is eligible for a referral bonus if this candidate is hired. True if eligible per company referral program rules.',
    `regulatory_framework` STRING COMMENT 'Applicable regulatory framework for the role (e.g., GMP, GLP, GCP, GDP). Relevant for GxP roles requiring specific compliance training and certifications. [ENUM-REF-CANDIDATE: GMP|GLP|GCP|GDP|GVP|GAMP|None — promote to reference product]',
    `rejection_date` DATE COMMENT 'Date when the application was rejected. Format: yyyy-MM-dd.',
    `rejection_reason` STRING COMMENT 'Reason for rejecting the application (e.g., qualifications not met, better candidate selected, position filled, candidate withdrew). Free-text field for detailed explanation.',
    `screening_date` DATE COMMENT 'Date when the initial screening was completed for this application. Format: yyyy-MM-dd.',
    `screening_status` STRING COMMENT 'Status of the initial screening phase for the application (e.g., not started, in progress, passed, failed, on hold).. Valid values are `not_started|in_progress|passed|failed|on_hold`',
    `withdrawal_date` DATE COMMENT 'Date when the candidate withdrew their application. Format: yyyy-MM-dd.',
    `withdrawal_reason` STRING COMMENT 'Reason provided by the candidate for withdrawing their application (e.g., accepted another offer, personal reasons, relocation issues). Free-text field.',
    CONSTRAINT pk_job_application PRIMARY KEY(`job_application_id`)
) COMMENT 'Transactional record of a candidates application to a specific recruitment requisition. Captures application date, application source, screening status, interview stage, assessment scores, offer status, rejection reason, and hiring decision. Links candidate to requisition and tracks the full selection workflow including background check status and pre-employment medical clearance for GxP roles.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` (
    `headcount_plan_id` BIGINT COMMENT 'Primary key for headcount_plan',
    `department_id` BIGINT COMMENT 'Reference to the organizational department or unit for which this headcount plan applies. Links to the department master data.',
    `job_profile_id` BIGINT COMMENT 'Reference to the job profile or role for which headcount is being planned. Used for role-specific workforce planning and succession planning.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Headcount plans should link to specific position slots in the position master. The headcount_plan currently has target_position_title as a STRING, but this should be a FK to position for structured wo',
    `employee_id` BIGINT COMMENT 'Reference to the current employee holding the target position for succession planning. Links to employee master data.',
    `quaternary_headcount_created_by_employee_id` BIGINT COMMENT 'Reference to the employee who created this headcount plan record. Used for audit trail and accountability.',
    `quinary_headcount_last_modified_by_employee_id` BIGINT COMMENT 'Reference to the employee who most recently modified this headcount plan record. Used for audit trail and accountability.',
    `tertiary_headcount_approved_by_employee_id` BIGINT COMMENT 'Reference to the employee who approved this headcount plan. Typically a senior leader or HR executive with workforce planning authority.',
    `approval_date` DATE COMMENT 'Date when this headcount plan was formally approved and authorized for execution.',
    `approved_fte_count` DECIMAL(18,2) COMMENT 'Authorized full-time equivalent headcount for the planning period. Represents the approved workforce capacity including full-time and part-time employees normalized to FTE basis.',
    `attrition_assumption_rate` DECIMAL(18,2) COMMENT 'Assumed attrition rate (as percentage) used in workforce planning calculations. Represents expected voluntary and involuntary turnover during the planning period.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total budget envelope allocated for workforce costs during the planning period, including salaries, benefits, and related expenses.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `business_continuity_priority` STRING COMMENT 'Priority level for business continuity planning: critical (role essential for regulatory compliance or patient safety), high (significant business impact if vacant), medium (moderate impact), low (minimal immediate impact).. Valid values are `critical|high|medium|low`',
    `comments` STRING COMMENT 'Free-text comments, notes, or additional context regarding the headcount plan, succession strategy, or planning assumptions. Used for qualitative information not captured in structured fields.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this headcount plan record was first created in the system. Used for audit trail and data lineage.',
    `current_fte_count` DECIMAL(18,2) COMMENT 'Current actual full-time equivalent headcount as of the plan snapshot date. Used to calculate the gap between current state and approved target.',
    `development_gap_assessment` STRING COMMENT 'Detailed assessment of competency gaps and development needs for the successor candidate to be fully prepared for the target position. Includes technical skills, leadership capabilities, and regulatory qualifications.',
    `expected_attrition_count` STRING COMMENT 'Projected number of employee departures during the planning period based on attrition assumptions. Used to calculate replacement hiring needs.',
    `gxp_qualification_readiness` STRING COMMENT 'Status of GxP (GMP/GLP/GCP) qualification readiness for the successor candidate: qualified (meets all regulatory requirements), in_progress (undergoing qualification training), not_started (qualification not yet initiated), not_applicable (role does not require GxP qualification).. Valid values are `qualified|in_progress|not_started|not_applicable`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this headcount plan record was most recently updated. Used for audit trail and change tracking.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next mandatory review of this headcount or succession plan. Ensures regular updates to workforce planning assumptions and succession readiness.',
    `open_positions_count` STRING COMMENT 'Number of approved but unfilled positions included in this headcount plan. Represents active recruitment needs.',
    `plan_name` STRING COMMENT 'Descriptive name of the headcount plan, typically indicating the planning cycle, organizational scope, or strategic initiative (e.g., FY2024 Clinical Operations Scale-Up, 2024 Q1 Manufacturing Expansion).',
    `plan_number` STRING COMMENT 'Business identifier for the headcount plan, typically following format HCP-YYYY-NNNNNN where YYYY is year and NNNNNN is sequence number.. Valid values are `^HCP-[0-9]{4}-[0-9]{6}$`',
    `plan_review_date` DATE COMMENT 'Date when this headcount or succession plan was last reviewed and validated. Used to ensure plans remain current and aligned with business needs.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the headcount plan: draft (in preparation), submitted (awaiting review), under_review (being evaluated), approved (authorized for execution), active (currently executing), closed (completed), cancelled (terminated before completion). [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|active|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `plan_type` STRING COMMENT 'Classification of the headcount plan indicating planning horizon and purpose: annual (yearly workforce planning), quarterly (short-term adjustments), strategic (multi-year transformation), tactical (operational adjustments), scenario (what-if modeling), contingency (business continuity planning).. Valid values are `annual|quarterly|strategic|tactical|scenario|contingency`',
    `planned_hires_count` STRING COMMENT 'Number of new hires planned during the planning period to meet approved headcount targets, including backfills and net new positions.',
    `planning_period_end_date` DATE COMMENT 'End date of the planning period covered by this headcount plan. Defines the conclusion of the workforce planning horizon.',
    `planning_period_start_date` DATE COMMENT 'Start date of the planning period covered by this headcount plan. Defines the beginning of the workforce planning horizon.',
    `regulatory_continuity_required_flag` BOOLEAN COMMENT 'Indicates whether this position requires regulatory continuity planning due to FDA/EMA inspection readiness or GxP compliance requirements (True/False). True for Qualified Persons, Responsible Pharmacists, and other regulatory-critical roles.',
    `retention_risk_rating` STRING COMMENT 'Assessment of flight risk for the incumbent or successor: low (stable, unlikely to leave), medium (some risk factors present), high (significant risk of departure), critical (imminent departure risk or key person dependency).. Valid values are `low|medium|high|critical`',
    `scenario_name` STRING COMMENT 'Name of the planning scenario for what-if modeling (e.g., Base Case, Aggressive Growth, Cost Optimization, Clinical Trial Scale-Up). Supports multiple scenario planning for strategic workforce decisions.',
    `scenario_probability` DECIMAL(18,2) COMMENT 'Estimated probability (as percentage) that this planning scenario will materialize. Used in probabilistic workforce planning and risk assessment.',
    `succession_plan_flag` BOOLEAN COMMENT 'Indicates whether this headcount plan includes succession planning elements for critical or regulated roles (True/False). When True, succession-specific attributes are populated.',
    `successor_readiness_level` STRING COMMENT 'Assessment of the successor candidates readiness to assume the target position: ready_now (can assume role immediately), 1_2_years (ready within 1-2 years with development), 3_5_years (ready within 3-5 years with development), not_ready (significant development required).. Valid values are `ready_now|1_2_years|3_5_years|not_ready`',
    `therapeutic_area_criticality` STRING COMMENT 'Primary therapeutic area for which this succession plan is critical, reflecting specialized expertise requirements in pharmaceutical development and commercialization.. Valid values are `oncology|immunology|rare_disease|vaccines|general|multiple`',
    CONSTRAINT pk_headcount_plan PRIMARY KEY(`headcount_plan_id`)
) COMMENT 'Master record of strategic workforce planning, headcount management, and succession planning for Pharmaceuticals. Captures planning period, org unit, approved FTE count, current FTE count, open positions, attrition assumptions, hiring plans, budget envelopes, plan status, and scenario modeling for clinical/manufacturing/commercial scale-up. Also captures detailed succession plans for critical and regulated roles (Qualified Person, Responsible Pharmacist) including target position, incumbent, successor candidates with readiness levels (ready now, 1-2 years, 3-5 years), development gap assessments, retention risk ratings, GxP qualification readiness, therapeutic area criticality, and plan review dates. Supports annual workforce planning cycles, business continuity for regulated roles, and regulatory continuity planning.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` (
    `system_access_id` BIGINT COMMENT 'Primary key for system_access',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who approved the access assignment. Must be an authorized approver with appropriate segregation of duties.',
    `part11_system_id` BIGINT COMMENT 'Foreign key linking to compliance.part11_system. Business justification: System access provisioning in pharma must reference the validated Part 11 system registry for GxP compliance. Access control is a core Part 11 requirement; linking access records to the system master ',
    `primary_system_employee_id` BIGINT COMMENT 'Unique identifier of the employee to whom the system access is assigned. Links to the employee master data in the workforce domain.',
    `quaternary_system_reviewed_by_employee_id` BIGINT COMMENT 'Unique identifier of the employee who performed the most recent periodic access review, typically a manager or compliance officer.',
    `quinary_system_revoked_by_employee_id` BIGINT COMMENT 'Unique identifier of the employee who revoked the access, typically a manager, compliance officer, or IT administrator.',
    `tertiary_system_provisioned_by_employee_id` BIGINT COMMENT 'Unique identifier of the IT or system administrator who provisioned the access in the target system. Supports segregation of duties between approval and execution.',
    `access_level` STRING COMMENT 'Level of access granted within the role. Defines the scope of permissions such as read-only, read-write, administrative, or approval authority.. Valid values are `Read Only|Read Write|Admin|Super User|Approver|Reviewer`',
    `approval_date` DATE COMMENT 'Date on which the access assignment was approved by the authorized approver. Critical for audit trail and compliance documentation.',
    `assignment_date` DATE COMMENT 'Date on which the system access was assigned to the employee. Marks the start of the access lifecycle for audit and compliance tracking.',
    `assignment_number` STRING COMMENT 'Business-readable unique identifier for the access assignment, typically used for audit trail and reference purposes in access review documentation.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the access assignment. Tracks whether the access is pending approval, active, suspended, revoked, expired, or under periodic review.. Valid values are `Pending Approval|Active|Suspended|Revoked|Expired|Under Review`',
    `business_justification` STRING COMMENT 'Detailed business reason for granting the access. Required for SOX compliance and audit readiness. Explains why the employee requires this specific system role and access level.',
    `comments` STRING COMMENT 'Additional notes or comments related to the access assignment. Used for documenting special circumstances, exceptions, or audit observations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this access assignment record was first created in the system. Part of the audit trail for 21 CFR Part 11 compliance.',
    `csv_scope_flag` BOOLEAN COMMENT 'Indicates whether this access assignment is for a system within Computer System Validation (CSV) scope. True for validated systems requiring documented access control procedures.',
    `effective_start_date` DATE COMMENT 'Date from which the access rights become active and the employee is authorized to use the system role. May differ from assignment date if access is scheduled for future activation.',
    `emergency_access_flag` BOOLEAN COMMENT 'Indicates whether this is an emergency or temporary access assignment granted outside normal approval workflows. Requires enhanced monitoring and post-event review.',
    `expiry_date` DATE COMMENT 'Date on which the access rights expire and must be reviewed or renewed. Supports periodic access review requirements for SOX and GxP compliance. Null indicates indefinite access subject to periodic review.',
    `gxp_regulated_flag` BOOLEAN COMMENT 'Indicates whether this access assignment is for a GxP-regulated system (GMP, GCP, GLP). True for quality-critical systems subject to FDA/EMA inspection and 21 CFR Part 11 compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this access assignment record was last modified. Tracks all changes to the access record for audit trail and compliance purposes.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic access review for this assignment. Required for SOX compliance and regulatory inspections to demonstrate ongoing access governance.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic access review. Typically set based on risk classification (e.g., quarterly for high-risk systems, annually for standard systems).',
    `privileged_access_flag` BOOLEAN COMMENT 'Indicates whether this access assignment includes privileged or administrative rights. True for super user, admin, or elevated access requiring enhanced controls and monitoring.',
    `provisioning_date` DATE COMMENT 'Date on which the access was actually provisioned in the target system. May differ from approval date due to processing time or scheduled activation.',
    `request_date` DATE COMMENT 'Date on which the access request was submitted for approval. Used to track request-to-fulfillment cycle time and SLA compliance.',
    `review_frequency_months` STRING COMMENT 'Number of months between required periodic access reviews. Determined by system risk classification and regulatory requirements (e.g., 3, 6, or 12 months).',
    `review_outcome` STRING COMMENT 'Result of the most recent periodic access review. Indicates whether the access was approved for continuation, revoked, modified, or is pending decision.. Valid values are `Approved|Revoked|Modified|Pending`',
    `revocation_date` DATE COMMENT 'Date on which the access was revoked or deactivated. Null if access is still active. Critical for audit trail and compliance reporting.',
    `revocation_reason` STRING COMMENT 'Detailed reason for revoking the access. Examples include role change, termination, transfer, security incident, or periodic review decision.',
    `risk_classification` STRING COMMENT 'Risk level associated with this access assignment based on system criticality, data sensitivity, and regulatory impact. Determines review frequency and control requirements.. Valid values are `High|Medium|Low`',
    `role_code` STRING COMMENT 'System-specific technical code or identifier for the role. Used for system integration and automated provisioning workflows.',
    `role_name` STRING COMMENT 'Name of the system role or permission set assigned to the employee. Examples include Quality Manager, Manufacturing Operator, Clinical Data Manager, Regulatory Affairs Specialist.',
    `segregation_of_duties_flag` BOOLEAN COMMENT 'Indicates whether this access assignment has been evaluated for segregation of duties conflicts. True if SOD analysis has been performed and no conflicts exist.',
    `sox_scope_flag` BOOLEAN COMMENT 'Indicates whether this access assignment is within the scope of Sarbanes-Oxley Act compliance. True for systems that impact financial reporting and require segregation of duties controls.',
    CONSTRAINT pk_system_access PRIMARY KEY(`system_access_id`)
) COMMENT 'Transactional record of system role and access rights assignments for employees in quality-critical and regulated functions. Captures system name (SAP, LIMS, MES, Veeva, EDC), role name, access level, assignment date, expiry date, business justification, approver, and review status. Supports 21 CFR Part 11 electronic records compliance, SOX access controls, and periodic access review for GxP systems.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` (
    `employee_movement_id` BIGINT COMMENT 'Unique identifier for the employee movement transaction record. Primary key for the employee movement entity.',
    `site_id` BIGINT COMMENT 'Identifier of the physical site or location where the employee will be based after the movement. Important for GxP training and facility access.',
    `plant_id` BIGINT COMMENT 'Identifier of the physical site or location where the employee was based before the movement.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee undergoing the movement. Links to the employee master record.',
    `department_id` BIGINT COMMENT 'Identifier of the organizational department the employee was assigned to before the movement.',
    `position_id` BIGINT COMMENT 'Identifier of the position the employee held before the movement. Provides historical context for the transition.',
    `tertiary_new_manager_employee_id` BIGINT COMMENT 'Identifier of the manager or supervisor the employee will report to after the movement. Establishes new reporting relationship.',
    `tertiary_quinary_approved_by_employee_id` BIGINT COMMENT 'Identifier of the manager, HR business partner, or executive who approved the movement. Required for audit trail and compliance.',
    `approval_date` DATE COMMENT 'The date on which the movement was formally approved by the authorized approver. Critical for audit and compliance documentation.',
    `cancellation_date` DATE COMMENT 'The date on which the movement was cancelled, if applicable. Null for completed or active movements.',
    `cancellation_reason` STRING COMMENT 'Textual explanation of why the movement was cancelled. Provides context for audit and workforce planning analysis.',
    `comments` STRING COMMENT 'Free-text field for additional notes, special instructions, or contextual information about the movement that does not fit structured fields.',
    `completion_date` DATE COMMENT 'The date on which the movement transaction was fully completed and all administrative actions finalized.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the movement record was first created in the system. Used for audit trail and data lineage.',
    `effective_date` DATE COMMENT 'The date on which the employee movement becomes effective and the new assignment begins. Critical for payroll, benefits, and compliance reporting.',
    `gxp_regulated_flag` BOOLEAN COMMENT 'Indicates whether the new position is subject to GxP regulations (GMP, GCP, GLP). Triggers mandatory training and qualification requirements for FDA/EMA compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the movement record was last updated. Tracks the most recent change for audit and version control purposes.',
    `movement_number` STRING COMMENT 'Business-facing unique transaction number for the employee movement event, used for tracking and audit purposes.',
    `movement_reason_code` STRING COMMENT 'Standardized code indicating the business reason for the movement (e.g., performance, business need, employee request, restructuring, succession planning).',
    `movement_reason_description` STRING COMMENT 'Detailed textual explanation of the reason for the employee movement, providing context beyond the reason code.',
    `movement_status` STRING COMMENT 'Current lifecycle status of the movement transaction. Tracks the approval and execution workflow state. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|in_progress|completed|cancelled|rejected — 7 candidates stripped; promote to reference product]',
    `movement_type` STRING COMMENT 'Classification of the employee movement event. Defines the nature of the organizational change being recorded. [ENUM-REF-CANDIDATE: promotion|lateral_transfer|demotion|site_relocation|secondment|role_change|organizational_restructure|grade_change|temporary_assignment|repatriation — 10 candidates stripped; promote to reference product]',
    `new_cost_center_code` STRING COMMENT 'The cost center code to which the employees costs will be allocated after the movement. Impacts financial planning and variance analysis.',
    `new_grade_band` STRING COMMENT 'The salary grade or job level the employee will hold after the movement. Impacts compensation, benefits eligibility, and organizational hierarchy.',
    `new_job_family` STRING COMMENT 'The job family or functional area the employee is moving into. Critical for skills assessment and training requirements.',
    `previous_cost_center_code` STRING COMMENT 'The cost center code to which the employees costs were allocated before the movement. Used for financial reporting and budget tracking.',
    `previous_grade_band` STRING COMMENT 'The salary grade or job level the employee held before the movement. Used for compensation analysis and career progression tracking.',
    `previous_job_family` STRING COMMENT 'The job family or functional area the employee belonged to before the movement (e.g., Research, Manufacturing, Quality, Regulatory).',
    `quality_critical_flag` BOOLEAN COMMENT 'Indicates whether the new position performs quality-critical functions requiring enhanced training, qualification, and audit trail documentation.',
    `secondment_end_date` DATE COMMENT 'The planned or actual date on which a secondment assignment ends and the employee returns to the home organization.',
    `secondment_organization_name` STRING COMMENT 'Name of the external organization (CRO, CMO, CDMO, partner company) to which the employee is being seconded, if applicable. Null for internal movements.',
    `secondment_start_date` DATE COMMENT 'The date on which a secondment assignment begins. Applicable only for secondment movement types.',
    `training_requalification_required_flag` BOOLEAN COMMENT 'Indicates whether the movement triggers mandatory requalification or new training requirements due to role change, site change, or regulatory scope change.',
    CONSTRAINT pk_employee_movement PRIMARY KEY(`employee_movement_id`)
) COMMENT 'Transactional record of all employee lifecycle movements including promotions, lateral transfers, site relocations, secondments to CROs/CMOs, role changes, and organizational restructuring events. Captures movement type, effective date, previous position, new position, previous org unit, new org unit, previous grade, new grade, reason code, and approver. Provides a complete audit trail of workforce changes for HR and regulatory inspection readiness.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` (
    `succession_plan_id` BIGINT COMMENT 'Unique identifier for the succession plan record. Primary key for the succession plan entity.',
    `department_id` BIGINT COMMENT 'Reference to the department to which the target position belongs. Links to department master data. Used for organizational succession planning analysis and reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the employee responsible for maintaining and executing this succession plan. Typically the hiring manager, department head, or HR business partner. Links to employee master data.',
    `primary_succession_incumbent_employee_id` BIGINT COMMENT 'Reference to the current employee holding the target position. May be null if position is vacant. Links to employee master data.',
    `quaternary_succession_created_by_employee_id` BIGINT COMMENT 'Reference to the employee who created this succession plan record. Links to employee master data. Used for audit trails and accountability.',
    `quinary_succession_last_modified_by_employee_id` BIGINT COMMENT 'Reference to the employee who last modified this succession plan record. Links to employee master data. Used for audit trails and accountability.',
    `site_id` BIGINT COMMENT 'Reference to the site or facility where the target position is located. Links to site master data. Used for multi-site succession planning and regulatory reporting by location.',
    `position_id` BIGINT COMMENT 'Reference to the critical position for which succession planning is being performed. Links to the position master record.',
    `tertiary_succession_approved_by_employee_id` BIGINT COMMENT 'Reference to the employee who approved this succession plan. Typically senior leadership or executive responsible for talent management. Links to employee master data. Null if plan not yet approved.',
    `actual_transition_date` DATE COMMENT 'Actual date when the successor assumed the target position. Null if transition has not yet occurred. Used to measure succession planning effectiveness and close out completed plans.',
    `approval_date` DATE COMMENT 'Date when the succession plan was formally approved. Null if plan is still in draft status. Used for audit trails and governance reporting.',
    `business_continuity_priority` STRING COMMENT 'Priority tier assigned to this succession plan based on the target positions criticality to business operations and regulatory compliance. Tier 1 indicates highest priority requiring immediate succession readiness (e.g., Qualified Person, Responsible Pharmacist); Tier 2 indicates high priority; Tier 3 indicates moderate priority; Tier 4 indicates standard priority.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `comments` STRING COMMENT 'Free-text field for additional notes, context, or special considerations related to the succession plan. May include information about unique circumstances, external factors, or stakeholder feedback.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the succession plan record was first created in the system. Used for audit trails and data lineage tracking. Immutable after initial creation.',
    `development_gap_summary` STRING COMMENT 'Narrative summary of the competency, experience, and qualification gaps that must be addressed before the successor is ready to assume the target position. Informs individual development plan creation.',
    `estimated_transition_date` DATE COMMENT 'Projected date when the successor is expected to assume the target position. May be based on incumbent retirement date, readiness timeline, or business planning. Null if transition timing is uncertain.',
    `gxp_qualification_date` DATE COMMENT 'Date when the successor achieved full GxP qualification for the target position. Null if qualification is not yet complete. Used for regulatory audit trails and requalification scheduling.',
    `gxp_qualification_status` STRING COMMENT 'Status of the successors qualification for Good Manufacturing Practice (GMP), Good Clinical Practice (GCP), or Good Laboratory Practice (GLP) requirements applicable to the target position. Qualified indicates all required GxP training and assessments are current; In Progress indicates qualification activities underway; Not Started indicates qualification not yet initiated; Expired indicates requalification required; Waived indicates regulatory exemption granted.. Valid values are `qualified|in_progress|not_started|expired|waived`',
    `gxp_requalification_due_date` DATE COMMENT 'Date by which the successor must complete GxP requalification activities to maintain qualification status for the target position. Null if initial qualification not yet achieved or if position does not require periodic requalification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the succession plan record was last updated. Used for audit trails, change tracking, and data currency assessment. Updated automatically on each modification.',
    `next_review_due_date` DATE COMMENT 'Date by which the succession plan must be reviewed and updated. Typically set based on organizational policy (e.g., annual review) or triggered by significant business changes.',
    `plan_number` STRING COMMENT 'Business-facing unique identifier for the succession plan, formatted as SP-YYYYNNNN where YYYY is year and NNNN is sequence number. Used for audit trails and regulatory documentation.. Valid values are `^SP-[0-9]{8}$`',
    `plan_review_date` DATE COMMENT 'Date when the succession plan was last reviewed and updated. Used to ensure succession plans remain current and aligned with business needs and regulatory requirements.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the succession plan. Draft indicates plan is under development; Active indicates plan is approved and being executed; On Hold indicates temporary suspension; Completed indicates successor has assumed role; Cancelled indicates plan was terminated; Archived indicates historical record retention.. Valid values are `draft|active|on_hold|completed|cancelled|archived`',
    `qualified_person_flag` BOOLEAN COMMENT 'Indicates whether the target position is a Qualified Person role as defined by EU GMP regulations. True if position requires QP designation; False otherwise. QP roles have heightened succession planning requirements due to regulatory mandate for batch release authority.',
    `readiness_assessment_date` DATE COMMENT 'Date when the successor readiness level was last assessed. Used to track currency of succession planning data and trigger periodic reassessments.',
    `readiness_level` STRING COMMENT 'Assessment of the successors readiness to assume the target position. Ready Now indicates candidate can assume role immediately; 1-2 Years indicates near-term readiness with minor development; 3-5 Years indicates longer-term development required; Not Ready indicates significant gaps exist.. Valid values are `ready_now|1_to_2_years|3_to_5_years|not_ready`',
    `regulatory_inspection_ready_flag` BOOLEAN COMMENT 'Indicates whether this succession plan record is complete and audit-ready for FDA, EMA, or other regulatory authority inspections. True if all required documentation, assessments, and approvals are in place; False if gaps exist that must be addressed before inspection.',
    `responsible_pharmacist_flag` BOOLEAN COMMENT 'Indicates whether the target position is a Responsible Pharmacist role as defined by regulatory authorities. True if position requires Responsible Pharmacist designation; False otherwise. These roles have specific succession planning requirements for pharmacy operations continuity.',
    `retention_risk_rating` STRING COMMENT 'Assessment of the risk that the successor candidate may leave the organization before assuming the target role. Low indicates stable retention; Medium indicates some flight risk; High indicates significant retention concerns; Critical indicates imminent departure risk requiring immediate intervention.. Valid values are `low|medium|high|critical`',
    `therapeutic_area_criticality` STRING COMMENT 'Assessment of the strategic importance of the target positions therapeutic area to the organizations business continuity and regulatory compliance. Critical indicates essential therapeutic area with high regulatory scrutiny or revenue impact; High indicates important therapeutic area; Medium indicates moderate importance; Low indicates limited business impact.. Valid values are `critical|high|medium|low`',
    CONSTRAINT pk_succession_plan PRIMARY KEY(`succession_plan_id`)
) COMMENT 'Master record of succession planning for critical and regulated roles at Pharmaceuticals. Captures target position, incumbent employee, successor candidates (multiple per position), readiness level (ready now, 1-2 years, 3-5 years), development gap assessment, retention risk rating, GxP qualification readiness, therapeutic area criticality, and plan review date. Supports talent pipeline management, business continuity for Qualified Person and Responsible Pharmacist roles, and regulatory continuity planning.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` (
    `time_attendance_id` BIGINT COMMENT 'Unique identifier for the time and attendance record. Primary key for the time_attendance product.',
    `employee_id` BIGINT COMMENT 'Identifier of the supervisor or manager who approved this time and attendance record. Required for audit trails and SOX compliance.',
    `payroll_period_id` BIGINT COMMENT 'Identifier of the payroll period to which this time and attendance record belongs. Links time records to payroll processing cycles.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Time tracking at plant level enables GMP batch record traceability, labor cost allocation to manufacturing sites, and site-specific attendance compliance. Creates new FK to replace denormalized work_l',
    `primary_time_employee_id` BIGINT COMMENT 'Identifier of the employee for whom this time and attendance record is captured. Links to the employee master data.',
    `adjusted_time_attendance_id` BIGINT COMMENT 'Self-referencing FK on time_attendance (adjusted_time_attendance_id)',
    `absence_code` STRING COMMENT 'Code indicating the type of absence if the employee did not work (e.g., SICK, VAC, PTO, FMLA, UNPAID). Used for leave balance tracking and payroll processing.. Valid values are `^[A-Z0-9]{2,6}$`',
    `absence_reason` STRING COMMENT 'Descriptive explanation of the absence reason. Provides additional context for HR and compliance reporting.',
    `actual_hours_worked` DECIMAL(18,2) COMMENT 'The actual number of hours the employee worked, calculated from clock-in and clock-out timestamps minus break periods. Used for payroll processing and labor cost allocation.',
    `approval_status` STRING COMMENT 'Current approval status of the time and attendance record in the workflow. Determines whether the record can be processed for payroll.. Valid values are `pending|approved|rejected|submitted|draft`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the time and attendance record was approved. Used for audit trails and payroll cutoff validation.',
    `attendance_date` DATE COMMENT 'The calendar date on which the employees time and attendance was recorded. Principal business event date for this transaction.',
    `attendance_record_number` STRING COMMENT 'Externally-known unique business identifier for this time and attendance record, used for audit trails and payroll reconciliation.. Valid values are `^TA-[0-9]{10}$`',
    `attendance_status` STRING COMMENT 'Current status of the attendance record indicating whether the employee was present, absent, or partially present. Used for attendance tracking and performance management. [ENUM-REF-CANDIDATE: present|absent|partial|late|early_departure|no_show|excused|unexcused — 8 candidates stripped; promote to reference product]',
    `batch_number` STRING COMMENT 'Batch or lot number of the pharmaceutical product being manufactured during this shift. Critical for GMP traceability and batch record documentation.. Valid values are `^[A-Z0-9]{6,15}$`',
    `break_duration_minutes` STRING COMMENT 'Total duration of break periods taken during the shift, measured in minutes. Deducted from gross time to calculate actual hours worked.',
    `clock_in_timestamp` TIMESTAMP COMMENT 'The exact date and time when the employee clocked in or started their shift. Critical for GMP batch production documentation where personnel presence must be timestamped.',
    `clock_out_timestamp` TIMESTAMP COMMENT 'The exact date and time when the employee clocked out or ended their shift. Used to calculate actual hours worked and for GMP compliance documentation.',
    `comments` STRING COMMENT 'Free-text comments or notes related to this time and attendance record, such as explanations for late arrivals, early departures, or overtime justifications.',
    `cost_center_code` STRING COMMENT 'Cost center to which the labor hours and costs for this attendance record are allocated. Used for financial reporting and production order costing in SAP S/4HANA.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this time and attendance record was first created in the system. Required for audit trails and data lineage.',
    `early_departure_minutes` STRING COMMENT 'Number of minutes the employee left early compared to their scheduled end time. Used for attendance policy enforcement and performance tracking.',
    `gmp_critical_flag` BOOLEAN COMMENT 'Indicates whether this time record is for GMP-critical manufacturing operations where personnel presence must be documented for regulatory compliance and FDA/EMA inspections.',
    `gxp_regulated_flag` BOOLEAN COMMENT 'Indicates whether this time record is for GxP-regulated activities (GMP, GCP, GLP) requiring documented personnel presence for regulatory compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this time and attendance record was last updated. Required for audit trails and change tracking.',
    `late_arrival_minutes` STRING COMMENT 'Number of minutes the employee arrived late compared to their scheduled start time. Used for attendance policy enforcement and performance tracking.',
    `overtime_category` STRING COMMENT 'Classification of overtime hours by compensation rate (e.g., time and half, double time, holiday premium). Determines the overtime multiplier for payroll. [ENUM-REF-CANDIDATE: standard|time_and_half|double_time|holiday|weekend|night_differential|none — 7 candidates stripped; promote to reference product]',
    `overtime_hours` DECIMAL(18,2) COMMENT 'The number of hours worked beyond the standard work schedule that qualify for overtime compensation. Critical for labor cost management and compliance with labor laws.',
    `paid_break_minutes` STRING COMMENT 'The portion of break time that is compensated according to company policy or labor agreements. Included in payroll calculations.',
    `payroll_processed_flag` BOOLEAN COMMENT 'Indicates whether this time and attendance record has been processed in a payroll run. Prevents duplicate processing and supports reconciliation.',
    `production_order_number` STRING COMMENT 'Production order number to which the employees time is allocated for GMP batch manufacturing. Links labor hours to specific batch production for cost accounting and compliance documentation.. Valid values are `^[A-Z0-9]{8,12}$`',
    `regular_hours` DECIMAL(18,2) COMMENT 'The portion of actual hours worked that are classified as regular hours (non-overtime). Used for standard payroll calculations.',
    `scheduled_hours` DECIMAL(18,2) COMMENT 'The number of hours the employee was scheduled to work on this date according to their shift assignment. Used for variance analysis and labor planning.',
    `shift_code` STRING COMMENT 'Code identifying the shift pattern assigned to the employee for this attendance record (e.g., DAY, NIGHT, SWING, ROTATING). Used for shift differential calculations and manufacturing scheduling.. Valid values are `^[A-Z0-9]{2,10}$`',
    `shift_pattern` STRING COMMENT 'Descriptive name of the shift pattern (e.g., Morning Shift 6AM-2PM, Night Shift 10PM-6AM). Provides human-readable context for the shift assignment.',
    `time_clock_device_code` STRING COMMENT 'Identifier of the physical time clock or biometric device used to capture the attendance record. Used for device audit trails and validation.. Valid values are `^[A-Z0-9]{6,20}$`',
    `time_entry_method` STRING COMMENT 'Method by which the time and attendance data was captured (e.g., biometric scanner, badge swipe, manual entry). Important for audit trails and data quality assessment. [ENUM-REF-CANDIDATE: biometric|badge_swipe|manual|mobile_app|web_portal|supervisor_entry|system_generated — 7 candidates stripped; promote to reference product]',
    `unpaid_break_minutes` STRING COMMENT 'The portion of break time that is not compensated (e.g., meal breaks). Excluded from payroll calculations.',
    CONSTRAINT pk_time_attendance PRIMARY KEY(`time_attendance_id`)
) COMMENT 'Transactional record of employee time and attendance entries including clock-in/clock-out, shift assignments, overtime hours, break periods, and absence codes for manufacturing, laboratory, and clinical operations staff. Captures date, shift pattern, scheduled hours, actual hours, overtime category, cost center allocation, and approval status. Critical for GMP manufacturing compliance where personnel presence during batch production must be documented, and for labor cost allocation to production orders in SAP S/4HANA.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`job_family` (
    `job_family_id` BIGINT COMMENT 'Primary key for job_family',
    `competency_framework_id` BIGINT COMMENT 'Reference to the competency framework or model that defines required skills, knowledge, and behaviors for this job family.',
    `parent_job_family_id` BIGINT COMMENT 'Reference to a parent job family if this job family is part of a hierarchical job family structure.',
    `approval_status` STRING COMMENT 'Current approval status of this job family definition in the governance workflow.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this job family definition.',
    `approved_date` DATE COMMENT 'Date when this job family definition was formally approved.',
    `career_level_range_max` STRING COMMENT 'Maximum career level or grade associated with roles in this job family.',
    `career_level_range_min` STRING COMMENT 'Minimum career level or grade associated with roles in this job family.',
    `job_family_category` STRING COMMENT 'High-level category grouping job families by functional area within the pharmaceutical organization.',
    `job_family_code` STRING COMMENT 'Unique alphanumeric code assigned to the job family for external reference and system integration.',
    `compensation_grade_max` STRING COMMENT 'Maximum compensation grade or band applicable to roles within this job family.',
    `compensation_grade_min` STRING COMMENT 'Minimum compensation grade or band applicable to roles within this job family.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this job family record was first created in the system.',
    `critical_role_indicator` BOOLEAN COMMENT 'Indicates whether this job family contains roles that are business-critical or quality-critical requiring enhanced succession planning and talent management.',
    `job_family_description` STRING COMMENT 'Detailed description of the job family including scope, purpose, and types of roles included.',
    `effective_end_date` DATE COMMENT 'Date when this job family definition is no longer effective. Null indicates the job family is currently active.',
    `effective_start_date` DATE COMMENT 'Date when this job family definition became effective and available for use in workforce management systems.',
    `flsa_classification` STRING COMMENT 'Classification under the Fair Labor Standards Act indicating whether roles in this job family are exempt or non-exempt from overtime pay requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this job family record was last updated or modified.',
    `last_reviewed_date` DATE COMMENT 'Date when this job family definition was last reviewed for accuracy and relevance by human resources or organizational design teams.',
    `job_family_name` STRING COMMENT 'The official name of the job family grouping related roles and positions.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this job family definition to ensure continued alignment with business needs.',
    `occupational_group` STRING COMMENT 'Standard occupational classification group aligned with national or international labor statistics frameworks.',
    `owner_department` STRING COMMENT 'Department or functional area that owns and maintains the definition and standards for this job family.',
    `regulatory_oversight_level` STRING COMMENT 'Level of regulatory oversight and compliance requirements applicable to roles in this job family for FDA and EMA audit readiness.',
    `remote_work_eligibility` STRING COMMENT 'Standard remote work or flexible work arrangement eligibility for roles within this job family.',
    `requires_gxp_training` BOOLEAN COMMENT 'Indicates whether roles in this job family require Good Clinical Practice (GCP), Good Manufacturing Practice (GMP), or Good Laboratory Practice (GLP) training for regulatory compliance.',
    `requires_professional_license` BOOLEAN COMMENT 'Indicates whether roles in this job family require professional licensure such as pharmacist license, medical license, or engineering license.',
    `requires_quality_certification` BOOLEAN COMMENT 'Indicates whether roles in this job family require formal quality management system certifications such as Six Sigma, Lean, or ASQ certifications.',
    `job_family_status` STRING COMMENT 'Current lifecycle status of the job family indicating whether it is actively used for workforce planning and role assignment.',
    `succession_planning_priority` STRING COMMENT 'Priority level for succession planning activities for roles within this job family.',
    `talent_pool_strategy` STRING COMMENT 'Strategic approach for building and maintaining talent pipeline for this job family including internal development and external sourcing.',
    `travel_requirement_percentage` STRING COMMENT 'Typical percentage of time roles in this job family are expected to travel for business purposes.',
    `typical_education_level` STRING COMMENT 'Typical minimum education level required for roles within this job family.',
    `typical_experience_years_max` STRING COMMENT 'Maximum number of years of relevant professional experience typically associated with roles in this job family.',
    `typical_experience_years_min` STRING COMMENT 'Minimum number of years of relevant professional experience typically required for roles in this job family.',
    `union_eligibility` STRING COMMENT 'Indicates whether roles in this job family are eligible for union membership or collective bargaining representation.',
    `workforce_planning_category` STRING COMMENT 'Category used for workforce planning and headcount forecasting indicating the strategic importance and employment model for this job family.',
    CONSTRAINT pk_job_family PRIMARY KEY(`job_family_id`)
) COMMENT 'Master reference table for job_family. Referenced by job_family_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`competency_framework` (
    `competency_framework_id` BIGINT COMMENT 'Primary key for competency_framework',
    `employee_id` BIGINT COMMENT 'Employee identifier of the person who formally approved this competency framework version.',
    `owner_employee_id` BIGINT COMMENT 'Employee identifier of the framework owner responsible for maintenance and updates.',
    `predecessor_framework_id` BIGINT COMMENT 'Reference to the previous version of this competency framework, if this is a revision. Null for initial versions.',
    `parent_competency_framework_id` BIGINT COMMENT 'Self-referencing FK on competency_framework (parent_competency_framework_id)',
    `applicable_regions` STRING COMMENT 'Geographic regions where this framework applies (e.g., North America, Europe, Asia-Pacific). Null indicates global applicability.',
    `applicable_sites` STRING COMMENT 'Comma-separated list of site codes or locations where this competency framework is applicable. Null indicates global applicability.',
    `approval_date` DATE COMMENT 'Date when this competency framework version was formally approved for use.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether formal approval is required before this framework can be used for assessments and training assignments.',
    `assessment_method` STRING COMMENT 'Primary method used to assess competencies within this framework (e.g., Written Test, Practical Demonstration, Observation, 360-Degree Feedback, Portfolio Review).',
    `audit_trail_required` BOOLEAN COMMENT 'Indicates whether a complete audit trail of competency assessments and certifications must be maintained for regulatory inspection readiness.',
    `business_justification` STRING COMMENT 'Business rationale for establishing this competency framework, including regulatory requirements, quality objectives, or strategic workforce development goals.',
    `certification_required` BOOLEAN COMMENT 'Indicates whether formal certification is required upon successful completion of all competencies in this framework.',
    `competency_count` STRING COMMENT 'Total number of individual competencies defined within this framework.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this competency framework record was first created in the system.',
    `competency_framework_description` STRING COMMENT 'Detailed description of the competency framework including its purpose, scope, and intended use within the organization.',
    `effective_date` DATE COMMENT 'Date when this competency framework version becomes effective and can be used for assessments and training.',
    `expiration_date` DATE COMMENT 'Date when this competency framework version expires or is scheduled for review. Null for frameworks without scheduled expiration.',
    `framework_code` STRING COMMENT 'Unique business identifier code for the competency framework used in regulatory documentation and training systems.',
    `framework_name` STRING COMMENT 'Official name of the competency framework (e.g., GMP Manufacturing Competencies, Clinical Research Associate Framework).',
    `framework_type` STRING COMMENT 'Classification of the competency framework by primary focus area.',
    `framework_version` STRING COMMENT 'Version number of the competency framework following semantic versioning (e.g., 1.0, 2.1, 3.0.1).',
    `job_family` STRING COMMENT 'Job family or functional area this framework applies to (e.g., Quality Assurance, Manufacturing Operations, Clinical Development, Regulatory Affairs).',
    `language_code` STRING COMMENT 'Primary language of the framework documentation using ISO 639-1 two-letter code, optionally followed by ISO 3166-1 country code (e.g., en, en-US, de-DE).',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of this competency framework.',
    `linked_training_programs` STRING COMMENT 'Comma-separated list of training program codes that support competency development within this framework.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this competency framework record was last modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this competency framework.',
    `owning_department` STRING COMMENT 'Department or organizational unit responsible for maintaining this competency framework (e.g., Quality Assurance, Learning & Development, Clinical Operations).',
    `proficiency_levels` STRING COMMENT 'Number of proficiency levels defined in this framework (e.g., 3 for Basic/Intermediate/Advanced, 5 for detailed progression scales).',
    `recertification_period_months` STRING COMMENT 'Number of months after which recertification is required for competencies in this framework. Null if recertification is not required.',
    `regulatory_category` STRING COMMENT 'Regulatory domain this framework supports: Good Clinical Practice (GCP), Good Manufacturing Practice (GMP), Good Laboratory Practice (GLP), Good Distribution Practice (GDP), Good Pharmacovigilance Practice (GVP), or non-regulated functions.',
    `regulatory_reference` STRING COMMENT 'Citation of specific regulatory requirements or guidelines that this framework addresses (e.g., FDA 21 CFR 211.25, ICH E6 Section 4.1, EMA GMP Annex 11).',
    `review_frequency_months` STRING COMMENT 'Scheduled review frequency in months for this framework to ensure continued relevance and regulatory compliance (e.g., 12, 24, 36).',
    `competency_framework_status` STRING COMMENT 'Current lifecycle status of the competency framework.',
    `therapeutic_area` STRING COMMENT 'Therapeutic area or disease category this framework applies to (e.g., Oncology, Immunology, Rare Diseases), if applicable. Null for cross-functional frameworks.',
    CONSTRAINT pk_competency_framework PRIMARY KEY(`competency_framework_id`)
) COMMENT 'Master reference table for competency_framework. Referenced by competency_framework_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_period` (
    `payroll_period_id` BIGINT COMMENT 'Primary key for payroll_period',
    `prior_payroll_period_id` BIGINT COMMENT 'Self-referencing FK on payroll_period (prior_payroll_period_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll period was approved for processing, supporting audit requirements and SOX compliance.',
    `approved_by` STRING COMMENT 'The user ID or name of the payroll manager or authorized person who approved this payroll period for processing.',
    `calendar_year` STRING COMMENT 'The calendar year in which this payroll period falls, used for tax reporting and compliance.',
    `closed_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll period was officially closed, preventing further changes and locking the period for compliance.',
    `country_code` STRING COMMENT 'Three-letter ISO country code indicating the country jurisdiction for this payroll period, supporting multi-country payroll operations.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll period record was first created in the system.',
    `cutoff_date` DATE COMMENT 'The deadline date by which time entries, adjustments, and payroll inputs must be submitted for this period.',
    `end_date` DATE COMMENT 'The last calendar date included in this payroll period. Defines the end of the pay period for time and attendance tracking.',
    `fiscal_month` STRING COMMENT 'The fiscal month (1-12) to which this payroll period belongs, used for monthly financial reporting.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter (1-4) to which this payroll period belongs, used for quarterly reporting and analysis.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this payroll period belongs, used for financial reporting and budgeting.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this payroll period is currently active and available for use in payroll processing and time entry.',
    `is_adjustment_period` BOOLEAN COMMENT 'Indicates whether this is a special adjustment period used for corrections, retroactive payments, or year-end adjustments.',
    `is_year_end_period` BOOLEAN COMMENT 'Indicates whether this is the final payroll period of the fiscal or calendar year, requiring special year-end processing.',
    `legal_entity_code` STRING COMMENT 'Code identifying the legal entity or subsidiary for which this payroll period is defined, supporting multi-entity payroll processing.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll period record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text notes or comments about this payroll period, such as special processing instructions, holiday impacts, or adjustment explanations.',
    `payment_date` DATE COMMENT 'The date on which employees are paid for this payroll period. This is the check date or direct deposit date.',
    `payroll_group` STRING COMMENT 'The payroll group or category this period applies to (e.g., Hourly, Salaried, Executive, Contract), enabling different pay schedules for different employee populations.',
    `period_code` STRING COMMENT 'Business identifier code for the payroll period, used in external reporting and payroll system integration.',
    `period_name` STRING COMMENT 'Human-readable name or label for the payroll period (e.g., January 2024 - Period 1, Q1 2024 Bi-Weekly 3).',
    `period_number` STRING COMMENT 'Sequential number of this payroll period within the fiscal or calendar year (e.g., 1-26 for bi-weekly, 1-12 for monthly).',
    `period_type` STRING COMMENT 'Classification of the payroll period frequency (weekly, bi-weekly, semi-monthly, monthly, quarterly, annual).',
    `processing_timestamp` TIMESTAMP COMMENT 'The date and time when payroll processing was completed for this period, used for audit trail and compliance verification.',
    `start_date` DATE COMMENT 'The first calendar date included in this payroll period. Defines the beginning of the pay period for time and attendance tracking.',
    `payroll_period_status` STRING COMMENT 'Current lifecycle status of the payroll period indicating whether it is open for time entry, being processed, or closed.',
    `tax_year` STRING COMMENT 'The tax year to which this payroll period belongs, used for tax withholding calculations and year-end tax reporting (W-2, 1099).',
    `total_days` STRING COMMENT 'The total number of calendar days in this payroll period, calculated from start_date to end_date inclusive.',
    `working_days` STRING COMMENT 'The number of standard working days within this payroll period, excluding weekends and holidays.',
    CONSTRAINT pk_payroll_period PRIMARY KEY(`payroll_period_id`)
) COMMENT 'Master reference table for payroll_period. Referenced by payroll_period_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ADD CONSTRAINT `fk_workforce_department_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ADD CONSTRAINT `fk_workforce_department_parent_department_id` FOREIGN KEY (`parent_department_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_department_id` FOREIGN KEY (`department_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ADD CONSTRAINT `fk_workforce_job_profile_competency_framework_id` FOREIGN KEY (`competency_framework_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`competency_framework`(`competency_framework_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ADD CONSTRAINT `fk_workforce_job_profile_job_family_id` FOREIGN KEY (`job_family_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`job_family`(`job_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ADD CONSTRAINT `fk_workforce_job_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_position_id` FOREIGN KEY (`position_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ADD CONSTRAINT `fk_workforce_gxp_training_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ADD CONSTRAINT `fk_workforce_gxp_training_record_primary_gxp_employee_id` FOREIGN KEY (`primary_gxp_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ADD CONSTRAINT `fk_workforce_gxp_training_record_quaternary_gxp_created_by_employee_id` FOREIGN KEY (`quaternary_gxp_created_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ADD CONSTRAINT `fk_workforce_gxp_training_record_quinary_gxp_last_modified_by_employee_id` FOREIGN KEY (`quinary_gxp_last_modified_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ADD CONSTRAINT `fk_workforce_gxp_training_record_tertiary_gxp_trainer_employee_id` FOREIGN KEY (`tertiary_gxp_trainer_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ADD CONSTRAINT `fk_workforce_gxp_training_record_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_department_id` FOREIGN KEY (`department_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ADD CONSTRAINT `fk_workforce_training_assignment_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ADD CONSTRAINT `fk_workforce_training_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ADD CONSTRAINT `fk_workforce_training_assignment_quaternary_training_waiver_approved_by_employee_id` FOREIGN KEY (`quaternary_training_waiver_approved_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ADD CONSTRAINT `fk_workforce_training_assignment_tertiary_training_approved_by_employee_id` FOREIGN KEY (`tertiary_training_approved_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ADD CONSTRAINT `fk_workforce_training_assignment_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ADD CONSTRAINT `fk_workforce_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ADD CONSTRAINT `fk_workforce_qualification_qualification_employee_id` FOREIGN KEY (`qualification_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ADD CONSTRAINT `fk_workforce_qualification_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_position_id` FOREIGN KEY (`position_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_primary_performance_employee_id` FOREIGN KEY (`primary_performance_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_payroll_period_id` FOREIGN KEY (`payroll_period_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_payslip_employee_id` FOREIGN KEY (`payslip_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_compensation_plan_id` FOREIGN KEY (`compensation_plan_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_primary_leave_employee_id` FOREIGN KEY (`primary_leave_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_tertiary_leave_updated_by_user_employee_id` FOREIGN KEY (`tertiary_leave_updated_by_user_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_department_id` FOREIGN KEY (`department_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_position_id` FOREIGN KEY (`position_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_quaternary_recruitment_recruiter_employee_id` FOREIGN KEY (`quaternary_recruitment_recruiter_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_tertiary_recruitment_approved_by_employee_id` FOREIGN KEY (`tertiary_recruitment_approved_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_candidate_referral_employee_id` FOREIGN KEY (`candidate_referral_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_candidate_id` FOREIGN KEY (`candidate_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`candidate`(`candidate_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_recruitment_requisition_id` FOREIGN KEY (`recruitment_requisition_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition`(`recruitment_requisition_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_tertiary_job_referral_employee_id` FOREIGN KEY (`tertiary_job_referral_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_department_id` FOREIGN KEY (`department_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_position_id` FOREIGN KEY (`position_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_quaternary_headcount_created_by_employee_id` FOREIGN KEY (`quaternary_headcount_created_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_quinary_headcount_last_modified_by_employee_id` FOREIGN KEY (`quinary_headcount_last_modified_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_tertiary_headcount_approved_by_employee_id` FOREIGN KEY (`tertiary_headcount_approved_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ADD CONSTRAINT `fk_workforce_system_access_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ADD CONSTRAINT `fk_workforce_system_access_primary_system_employee_id` FOREIGN KEY (`primary_system_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ADD CONSTRAINT `fk_workforce_system_access_quaternary_system_reviewed_by_employee_id` FOREIGN KEY (`quaternary_system_reviewed_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ADD CONSTRAINT `fk_workforce_system_access_quinary_system_revoked_by_employee_id` FOREIGN KEY (`quinary_system_revoked_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ADD CONSTRAINT `fk_workforce_system_access_tertiary_system_provisioned_by_employee_id` FOREIGN KEY (`tertiary_system_provisioned_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ADD CONSTRAINT `fk_workforce_employee_movement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ADD CONSTRAINT `fk_workforce_employee_movement_department_id` FOREIGN KEY (`department_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ADD CONSTRAINT `fk_workforce_employee_movement_position_id` FOREIGN KEY (`position_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ADD CONSTRAINT `fk_workforce_employee_movement_tertiary_new_manager_employee_id` FOREIGN KEY (`tertiary_new_manager_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ADD CONSTRAINT `fk_workforce_employee_movement_tertiary_quinary_approved_by_employee_id` FOREIGN KEY (`tertiary_quinary_approved_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_department_id` FOREIGN KEY (`department_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_primary_succession_incumbent_employee_id` FOREIGN KEY (`primary_succession_incumbent_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_quaternary_succession_created_by_employee_id` FOREIGN KEY (`quaternary_succession_created_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_quinary_succession_last_modified_by_employee_id` FOREIGN KEY (`quinary_succession_last_modified_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_position_id` FOREIGN KEY (`position_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_tertiary_succession_approved_by_employee_id` FOREIGN KEY (`tertiary_succession_approved_by_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_payroll_period_id` FOREIGN KEY (`payroll_period_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_primary_time_employee_id` FOREIGN KEY (`primary_time_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_adjusted_time_attendance_id` FOREIGN KEY (`adjusted_time_attendance_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`time_attendance`(`time_attendance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_family` ADD CONSTRAINT `fk_workforce_job_family_competency_framework_id` FOREIGN KEY (`competency_framework_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`competency_framework`(`competency_framework_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_family` ADD CONSTRAINT `fk_workforce_job_family_parent_job_family_id` FOREIGN KEY (`parent_job_family_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`job_family`(`job_family_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`competency_framework` ADD CONSTRAINT `fk_workforce_competency_framework_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`competency_framework` ADD CONSTRAINT `fk_workforce_competency_framework_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`competency_framework` ADD CONSTRAINT `fk_workforce_competency_framework_predecessor_framework_id` FOREIGN KEY (`predecessor_framework_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`competency_framework`(`competency_framework_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`competency_framework` ADD CONSTRAINT `fk_workforce_competency_framework_parent_competency_framework_id` FOREIGN KEY (`parent_competency_framework_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`competency_framework`(`competency_framework_id`);
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_period` ADD CONSTRAINT `fk_workforce_payroll_period_prior_payroll_period_id` FOREIGN KEY (`prior_payroll_period_id`) REFERENCES `pharmaceuticals_ecm`.`workforce`.`payroll_period`(`payroll_period_id`);

-- ========= TAGS =========
ALTER SCHEMA `pharmaceuticals_ecm`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `pharmaceuticals_ecm`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Employing Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Site Location Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|cleared|failed|expired');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `citizenship_country_code` SET TAGS ('dbx_business_glossary_term' = 'Citizenship Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `citizenship_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `citizenship_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Corporate Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|leave_of_absence|suspended|terminated');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temporary|intern|cro_seconded');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Employee First Name');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `is_gcp_qualified` SET TAGS ('dbx_business_glossary_term' = 'Good Clinical Practice (GCP) Qualified Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `is_glp_qualified` SET TAGS ('dbx_business_glossary_term' = 'Good Laboratory Practice (GLP) Qualified Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `is_gmp_qualified` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Qualified Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `is_people_manager` SET TAGS ('dbx_business_glossary_term' = 'People Manager Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `is_quality_critical_role` SET TAGS ('dbx_business_glossary_term' = 'Quality Critical Role Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Last Name');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `last_promotion_date` SET TAGS ('dbx_business_glossary_term' = 'Last Promotion Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `last_transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transfer Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Middle Name');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `mobile_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `mobile_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `mobile_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_business_glossary_term' = 'National Identification Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_rated');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `performance_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `regulatory_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Role Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `regulatory_role_flag` SET TAGS ('dbx_value_regex' = 'none|qualified_person|authorized_person|responsible_pharmacist|study_director|principal_investigator');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_value_regex' = 'none|basic|confidential|secret|top_secret');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_value_regex' = 'voluntary_resignation|retirement|involuntary_termination|end_of_contract|layoff|death');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `work_authorization_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `work_authorization_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_value_regex' = 'citizen|permanent_resident|work_visa|pending|expired');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `work_country_code` SET TAGS ('dbx_business_glossary_term' = 'Work Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `work_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `work_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `work_phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee` ALTER COLUMN `work_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Department Head Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `parent_department_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Department Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `budget_amount_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `budget_amount_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `csv_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Computer System Validation (CSV) Scope Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `department_description` SET TAGS ('dbx_business_glossary_term' = 'Department Description');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `department_status` SET TAGS ('dbx_business_glossary_term' = 'Department Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `department_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed|suspended');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `department_type` SET TAGS ('dbx_business_glossary_term' = 'Department Type');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `department_type` SET TAGS ('dbx_value_regex' = 'department|division|function|site|cost_center|business_unit');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `functional_area` SET TAGS ('dbx_value_regex' = 'research_discovery|clinical_development|regulatory_affairs|manufacturing|quality|supply_chain|[ENUM-REF-CANDIDATE: research_discovery|clinical_development|regulatory_affairs|manufacturing|quality|supply_chain|commercial|pharmacovigilance|medical_a...');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `gmp_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Critical Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `gxp_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Regulated Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `headcount_actual` SET TAGS ('dbx_business_glossary_term' = 'Headcount Actual');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `headcount_planned` SET TAGS ('dbx_business_glossary_term' = 'Headcount Planned');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Department Short Name');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `site_location_code` SET TAGS ('dbx_business_glossary_term' = 'Site Location Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `site_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{2,4}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `sox_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Scope Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area (TA)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_value_regex' = 'oncology|immunology|rare_diseases|cardiovascular|neuroscience|infectious_diseases|[ENUM-REF-CANDIDATE: oncology|immunology|rare_diseases|cardiovascular|neuroscience|infectious_diseases|respiratory|metabolic|dermatology|ophthalmology — promote to r...');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`department` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Position Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `reports_to_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Position Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `applicable_sop_list` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standard Operating Procedure (SOP) List');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Position Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `grade_band` SET TAGS ('dbx_business_glossary_term' = 'Grade Band');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `grade_band` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `is_gcp_regulated` SET TAGS ('dbx_business_glossary_term' = 'Good Clinical Practice (GCP) Regulated Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `is_glp_regulated` SET TAGS ('dbx_business_glossary_term' = 'Good Laboratory Practice (GLP) Regulated Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `is_gmp_regulated` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Regulated Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `is_quality_critical` SET TAGS ('dbx_business_glossary_term' = 'Quality-Critical Role Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `mandatory_training_curricula` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Training Curricula');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'active|vacant|filled|frozen|closed|pending_approval');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'permanent|temporary|contract|intern|consultant');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `required_competencies` SET TAGS ('dbx_business_glossary_term' = 'Required Competencies');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `required_education_level` SET TAGS ('dbx_business_glossary_term' = 'Required Education Level');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `required_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate|professional_degree');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `required_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Required Experience Years');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `requires_csv_training` SET TAGS ('dbx_business_glossary_term' = 'Computer System Validation (CSV) Training Required Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `requires_data_integrity_training` SET TAGS ('dbx_business_glossary_term' = 'Data Integrity Training Required Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `work_schedule` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Type');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`position` ALTER COLUMN `work_schedule` SET TAGS ('dbx_value_regex' = 'standard|shift|flexible|remote|hybrid');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `competency_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Framework Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_family_id` SET TAGS ('dbx_business_glossary_term' = 'Job Family Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_business_glossary_term' = 'Compensation Grade');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `gcp_training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Clinical Practice (GCP) Training Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `glp_training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Laboratory Practice (GLP) Training Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `gmp_training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Training Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate|professional_degree');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `minimum_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience Years');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `physical_requirements` SET TAGS ('dbx_business_glossary_term' = 'Physical Requirements');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `preferred_education_field` SET TAGS ('dbx_business_glossary_term' = 'Preferred Education Field');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_description` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Description');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|under_review|obsolete');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_title` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Title');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `quality_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Critical Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `regulatory_role_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Role Classification');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `regulatory_role_classification` SET TAGS ('dbx_value_regex' = 'gxp_critical|quality_critical|non_gxp|administrative');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `remote_work_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `role_based_access_level` SET TAGS ('dbx_business_glossary_term' = 'Role-Based Access Level');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `role_based_access_level` SET TAGS ('dbx_value_regex' = 'read_only|standard_user|power_user|administrator|validator');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `safety_training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `sop_list` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) List');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `succession_planning_tier` SET TAGS ('dbx_business_glossary_term' = 'Succession Planning Tier');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `succession_planning_tier` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `supervisory_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `typical_span_of_control` SET TAGS ('dbx_business_glossary_term' = 'Typical Span of Control');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_profile` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `employment_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Contracting Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `confidentiality_clause` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|amended');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'permanent|fixed_term|temporary|cro_secondment|consultant|intern');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `fte` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalency (FTE)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `governing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Jurisdiction');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `governing_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `gxp_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Role Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `gxp_training_required` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Training Required');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `ip_assignment_clause` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Assignment Clause');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `non_compete_clause` SET TAGS ('dbx_business_glossary_term' = 'Non-Compete Clause');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period (Days)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|bi_weekly|weekly|quarterly');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `probation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Probation End Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `probation_period_days` SET TAGS ('dbx_business_glossary_term' = 'Probation Period (Days)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `rehire_eligible` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligible');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `remote_work_eligible` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_grade` SET TAGS ('dbx_business_glossary_term' = 'Salary Grade');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_grade` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,2}[0-9]{1,2}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `signing_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signing Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `work_location` SET TAGS ('dbx_business_glossary_term' = 'Work Location');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employment_contract` ALTER COLUMN `working_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Working Hours Per Week');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` SET TAGS ('dbx_subdomain' = 'learning_compliance');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `gxp_training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Training Record Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Approved By Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `primary_gxp_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `primary_gxp_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `primary_gxp_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `quaternary_gxp_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `quaternary_gxp_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `quaternary_gxp_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `quinary_gxp_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `quinary_gxp_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `quinary_gxp_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `sop_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `tertiary_gxp_trainer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trainer Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `tertiary_gxp_trainer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `tertiary_gxp_trainer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Approved Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Training Assessment Result');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `assessment_result` SET TAGS ('dbx_value_regex' = 'pass|fail|waived|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Training Assessment Score');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Training Assignment Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Training Assignment Reason');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `attendance_status` SET TAGS ('dbx_business_glossary_term' = 'Training Attendance Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `attendance_status` SET TAGS ('dbx_value_regex' = 'attended|absent|partially_attended|excused');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `certificate_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Training Certificate Issued Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Training Certificate Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Training Record Comments');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `completion_method` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Method');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `completion_method` SET TAGS ('dbx_value_regex' = 'classroom|e_learning|on_the_job|webinar|self_study|blended');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Training Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Escalation Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `gxp_category` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Category');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `gxp_category` SET TAGS ('dbx_value_regex' = 'GCP|GMP|GLP|GDP|GVP|GAMP');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `qualification_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `qualification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Employee Qualification Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|not_qualified|pending|expired|suspended');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Training Record Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'draft|active|completed|cancelled|archived');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `regulatory_inspection_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Ready Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `requalification_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Requalification Interval in Months');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `sop_version` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Version');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `training_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration in Hours');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `training_material_version` SET TAGS ('dbx_business_glossary_term' = 'Training Material Version');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `training_record_number` SET TAGS ('dbx_business_glossary_term' = 'Training Record Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`gxp_training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = 'initial|refresher|requalification|ad_hoc|remedial|change_control');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` SET TAGS ('dbx_subdomain' = 'learning_compliance');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Owning Department Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `assessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Assessment Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `certification_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `ceu_credits` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Unit (CEU) Credits');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `content_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Content Owner Name');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `course_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `course_description` SET TAGS ('dbx_business_glossary_term' = 'Course Description');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `course_language` SET TAGS ('dbx_business_glossary_term' = 'Course Language');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `course_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `course_status` SET TAGS ('dbx_business_glossary_term' = 'Course Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `course_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|retired|archived');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `course_title` SET TAGS ('dbx_business_glossary_term' = 'Course Title');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `course_type` SET TAGS ('dbx_business_glossary_term' = 'Course Type');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `course_version` SET TAGS ('dbx_business_glossary_term' = 'Course Version');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `course_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'classroom|elearning|blended|on_the_job|virtual_instructor_led|self_paced');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration in Hours');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `last_content_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Content Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `learning_objectives` SET TAGS ('dbx_business_glossary_term' = 'Learning Objectives');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `max_enrollment_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Enrollment Capacity');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `next_scheduled_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `prerequisites` SET TAGS ('dbx_business_glossary_term' = 'Course Prerequisites');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `regulatory_authority_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Approval Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'gxp|gmp|gcp|glp|gdp|non_gxp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `requalification_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Requalification Frequency in Months');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_course` ALTER COLUMN `sop_reference_numbers` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Reference Numbers');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` SET TAGS ('dbx_subdomain' = 'learning_compliance');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `training_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Training Assignment Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `quaternary_training_waiver_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `quaternary_training_waiver_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `quaternary_training_waiver_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `sop_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `tertiary_training_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `tertiary_training_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `tertiary_training_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Training Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Training Assignment Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Training Assignment Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_value_regex' = '^TA-[0-9]{8}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Training Assignment Reason');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Training Assignment Type');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'mandatory|elective|recommended');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `attempts_count` SET TAGS ('dbx_business_glossary_term' = 'Training Attempts Count');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `certificate_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Training Certificate Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Training Assignment Comments');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `completion_score` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Score');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Training Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Training Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `gxp_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Regulated Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `max_attempts_allowed` SET TAGS ('dbx_business_glossary_term' = 'Maximum Attempts Allowed');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `passing_score_required` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Required');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `requalification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Requalification Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `sop_version` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Version');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `training_cost` SET TAGS ('dbx_business_glossary_term' = 'Training Cost');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `training_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `training_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `training_delivery_method` SET TAGS ('dbx_value_regex' = 'classroom|online|on_the_job|blended|self_paced|virtual_instructor_led');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `training_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration in Hours');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `waiver_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Waiver Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`training_assignment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Training Waiver Reason');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `qualification_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `qualification_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `qualification_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'read_only|read_write|approve|admin|super_user');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Assessment Result');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `assessment_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|not_assessed');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `audit_trail_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `competency_area` SET TAGS ('dbx_business_glossary_term' = 'Competency Area');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `last_access_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Access Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `qualification_code` SET TAGS ('dbx_business_glossary_term' = 'Qualification Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `qualification_name` SET TAGS ('dbx_business_glossary_term' = 'Qualification Name');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|pending_renewal|revoked|under_review');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'gmp_qualification|gcp_certification|glp_certification|analytical_method_qualification|auditor_certification|dea_handler_authorization');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `system_name` SET TAGS ('dbx_business_glossary_term' = 'System Name');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `system_role_name` SET TAGS ('dbx_business_glossary_term' = 'System Role Name');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`qualification` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_session_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Session Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|completed|rating_adjusted|rating_confirmed');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Impact Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_impact_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_impact_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_collaboration_rating` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Competency Rating');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_collaboration_rating` SET TAGS ('dbx_value_regex' = 'exceeds|meets|needs_improvement|unsatisfactory|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_compliance_rating` SET TAGS ('dbx_business_glossary_term' = 'Compliance Competency Rating');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_compliance_rating` SET TAGS ('dbx_value_regex' = 'exceeds|meets|needs_improvement|unsatisfactory|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_leadership_rating` SET TAGS ('dbx_business_glossary_term' = 'Leadership Competency Rating');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_leadership_rating` SET TAGS ('dbx_value_regex' = 'exceeds|meets|needs_improvement|unsatisfactory|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_technical_rating` SET TAGS ('dbx_business_glossary_term' = 'Technical Competency Rating');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_technical_rating` SET TAGS ('dbx_value_regex' = 'exceeds|meets|needs_improvement|unsatisfactory|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `development_areas_summary` SET TAGS ('dbx_business_glossary_term' = 'Development Areas Summary');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `development_plan` SET TAGS ('dbx_business_glossary_term' = 'Development Plan');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgement_flag` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_self_assessment` SET TAGS ('dbx_business_glossary_term' = 'Employee Self-Assessment');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `goal_achievement_score` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Score');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `gxp_training_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Training Compliance Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `individual_goals_count` SET TAGS ('dbx_business_glossary_term' = 'Individual Goals Count');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Eligibility Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding|developing');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating Score');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `performance_improvement_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `promotion_readiness_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Readiness Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Type');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_cycle_type` SET TAGS ('dbx_value_regex' = 'annual|mid_year|probationary|project_based|quarterly|ad_hoc');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `strengths_summary` SET TAGS ('dbx_business_glossary_term' = 'Strengths Summary');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `succession_candidate_flag` SET TAGS ('dbx_business_glossary_term' = 'Succession Candidate Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`performance_review` ALTER COLUMN `team_goals_count` SET TAGS ('dbx_business_glossary_term' = 'Team Goals Count');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` SET TAGS ('dbx_subdomain' = 'rewards_operations');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `base_salary_maximum` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Maximum Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `base_salary_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `base_salary_midpoint` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Midpoint Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `base_salary_midpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `base_salary_minimum` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Minimum Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `base_salary_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `benefit_package_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Bonus Target Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_target_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `compliance_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|pending|declined|terminated');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `health_insurance_employer_contribution` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Employer Contribution Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `health_insurance_employer_contribution` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `job_grade_band` SET TAGS ('dbx_business_glossary_term' = 'Job Grade Band');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `lti_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Long-Term Incentive (LTI) Eligibility Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `lti_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Long-Term Incentive (LTI) Target Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `lti_target_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `merit_increase_budget_percentage` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Budget Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `merit_increase_budget_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `open_enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment End Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `open_enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `pay_equity_analysis_flag` SET TAGS ('dbx_business_glossary_term' = 'Pay Equity Analysis Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_administrator_email` SET TAGS ('dbx_business_glossary_term' = 'Plan Administrator Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_administrator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_administrator_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_administrator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_administrator_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Administrator Name');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Description');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Name');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|closed|archived');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Type');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'base_salary|annual_bonus|long_term_incentive|commission|benefits|total_rewards');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `retirement_plan_employer_match_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retirement Plan Employer Match Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `retirement_plan_employer_match_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`compensation_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` SET TAGS ('dbx_subdomain' = 'rewards_operations');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Administrator Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `accounting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `cost_center_default` SET TAGS ('dbx_business_glossary_term' = 'Default Cost Center');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `cost_center_default` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `fi_document_number` SET TAGS ('dbx_business_glossary_term' = 'Financial Accounting (FI) Document Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `fi_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Notes');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_area` SET TAGS ('dbx_business_glossary_term' = 'Payroll Area');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payroll Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_frequency` SET TAGS ('dbx_value_regex' = 'monthly|semi-monthly|bi-weekly|weekly|quarterly|annual');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_number` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_schema` SET TAGS ('dbx_business_glossary_term' = 'Payroll Schema');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_schema` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `profit_center_default` SET TAGS ('dbx_business_glossary_term' = 'Default Profit Center');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `profit_center_default` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversal Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'draft|simulated|released|posted|reversed|cancelled');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Type');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'regular|off-cycle|correction|bonus|final|advance');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `sox_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Scope Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_employees_processed` SET TAGS ('dbx_business_glossary_term' = 'Total Employees Processed');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Pay Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Net Pay Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_other_deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Other Deductions Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_pension_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Pension Contribution Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_social_security_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Social Security Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_social_security_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_social_security_amount` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_tax_withheld_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Withheld Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` SET TAGS ('dbx_subdomain' = 'rewards_operations');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `payslip_id` SET TAGS ('dbx_business_glossary_term' = 'Payslip Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Journal Entry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `payslip_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `payslip_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `payslip_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `allowances` SET TAGS ('dbx_business_glossary_term' = 'Total Allowances Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `allowances` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payslip Approved Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `base_salary` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `base_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `bonus_payment` SET TAGS ('dbx_business_glossary_term' = 'Bonus Payment Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `bonus_payment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payslip Generated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `gross_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `health_insurance_deduction` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Deduction Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `health_insurance_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Worked');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `leave_balance` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance Remaining');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `leave_days_taken` SET TAGS ('dbx_business_glossary_term' = 'Leave Days Taken');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `net_pay` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `net_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `other_deductions` SET TAGS ('dbx_business_glossary_term' = 'Other Deductions Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `other_deductions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours Worked');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `overtime_pay` SET TAGS ('dbx_business_glossary_term' = 'Overtime Pay Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `overtime_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|check|cash|payroll_card|mobile_payment');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `payroll_area` SET TAGS ('dbx_business_glossary_term' = 'Payroll Area');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `payslip_number` SET TAGS ('dbx_business_glossary_term' = 'Payslip Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `payslip_status` SET TAGS ('dbx_business_glossary_term' = 'Payslip Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `payslip_status` SET TAGS ('dbx_value_regex' = 'draft|approved|paid|voided|corrected');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `pension_contribution` SET TAGS ('dbx_business_glossary_term' = 'Pension Contribution Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `pension_contribution` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period End Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `social_security_contribution` SET TAGS ('dbx_business_glossary_term' = 'Social Security Contribution Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `social_security_contribution` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `tax_deduction` SET TAGS ('dbx_business_glossary_term' = 'Income Tax Deduction Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `tax_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `total_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Deductions Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `total_deductions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `year_to_date_gross` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Gross Pay');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `year_to_date_gross` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `year_to_date_net` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Net Pay');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `year_to_date_net` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `year_to_date_tax` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Tax Deduction');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payslip` ALTER COLUMN `year_to_date_tax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_subdomain' = 'rewards_operations');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `annual_election_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Election Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|review_required');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_designation` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Designation');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_designation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Member Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Policy Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_continuation_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Continuation Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Contribution Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly|annual');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|family');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `csv_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Computer System Validation (CSV) Scope Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Dependent Count');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Type');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_value_regex' = 'new_hire|annual_open|life_event|cobra|rehire');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Method');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_value_regex' = 'online_portal|paper_form|phone|hr_assisted|auto_enrollment');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'pending|active|suspended|terminated|cancelled|waived');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `qualifying_life_event_date` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_HCM|WORKDAY|ORACLE_HCM|ADP|MANUAL');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `termination_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Termination Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `tertiary_leave_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `tertiary_leave_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `tertiary_leave_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `approval_comments` SET TAGS ('dbx_business_glossary_term' = 'Approval Comments');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `balance_after` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance After Request');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `balance_before` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance Before Request');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Leave Duration in Days');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Leave Duration in Hours');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `emergency_contact_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Notified Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Leave End Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `gxp_critical_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Critical Role Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `half_day_flag` SET TAGS ('dbx_business_glossary_term' = 'Half Day Leave Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `half_day_period` SET TAGS ('dbx_business_glossary_term' = 'Half Day Period');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `half_day_period` SET TAGS ('dbx_value_regex' = 'AM|PM');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `handover_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Handover Completed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_type_code` SET TAGS ('dbx_business_glossary_term' = 'Leave Type Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Received Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_received_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_received_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_required_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_required_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Paid Leave Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `payroll_period` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `payroll_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `payroll_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Leave Reason Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Leave Reason Description');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^LR-[0-9]{8}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `return_to_work_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Confirmed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `site_location_code` SET TAGS ('dbx_business_glossary_term' = 'Site Location Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `site_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`leave_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Requisition ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `quaternary_recruitment_recruiter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `quaternary_recruitment_recruiter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `quaternary_recruitment_recruiter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `approved_salary_range_max` SET TAGS ('dbx_business_glossary_term' = 'Approved Salary Range Maximum');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `approved_salary_range_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `approved_salary_range_min` SET TAGS ('dbx_business_glossary_term' = 'Approved Salary Range Minimum');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `approved_salary_range_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `budget_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Reference');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|temporary|contract|intern');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `gmp_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'GMP (Good Manufacturing Practice) Critical Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `gxp_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'GxP (Good Practice) Regulated Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `headcount_quantity` SET TAGS ('dbx_business_glossary_term' = 'Headcount Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `job_posting_title` SET TAGS ('dbx_business_glossary_term' = 'Job Posting Title');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `minimum_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience Years');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `preferred_qualifications` SET TAGS ('dbx_business_glossary_term' = 'Preferred Qualifications');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `required_qualifications` SET TAGS ('dbx_business_glossary_term' = 'Required Qualifications');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_close_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Close Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{8}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_open_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Open Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'new_position|replacement|backfill|temporary|contractor|intern');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `sourcing_channel` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Channel');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Employee Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_referral_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Employee Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_referral_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_referral_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `background_check_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_initiated|in_progress|clear|flagged|failed');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_number` SET TAGS ('dbx_business_glossary_term' = 'Candidate Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_number` SET TAGS ('dbx_value_regex' = '^CAN-[0-9]{8}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_status` SET TAGS ('dbx_business_glossary_term' = 'Candidate Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_status` SET TAGS ('dbx_value_regex' = 'new|active|screening|interviewing|offer_extended|hired');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Candidate City');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Candidate Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `current_employer` SET TAGS ('dbx_business_glossary_term' = 'Current Employer Name');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `current_employer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `current_job_title` SET TAGS ('dbx_business_glossary_term' = 'Current Job Title');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `current_job_title` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `degree_field` SET TAGS ('dbx_business_glossary_term' = 'Degree Field of Study');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `diversity_self_identification` SET TAGS ('dbx_business_glossary_term' = 'Diversity Self-Identification');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `diversity_self_identification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Candidate Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `expected_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Salary Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `expected_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `expected_salary_currency` SET TAGS ('dbx_business_glossary_term' = 'Expected Salary Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `expected_salary_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `expected_salary_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `expected_salary_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate First Name');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `gxp_experience_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Experience Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `gxp_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Experience Years');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `highest_education_level` SET TAGS ('dbx_business_glossary_term' = 'Highest Education Level');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `highest_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate|professional');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `initial_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Contact Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate Last Name');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `linkedin_profile_url` SET TAGS ('dbx_business_glossary_term' = 'LinkedIn Profile Uniform Resource Locator (URL)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `medical_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Pre-Employment Medical Clearance Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `medical_clearance_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|cleared|conditional|failed');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `medical_clearance_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `medical_clearance_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period in Days');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Candidate Phone Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `preferred_locations` SET TAGS ('dbx_business_glossary_term' = 'Preferred Work Locations');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `resume_file_path` SET TAGS ('dbx_business_glossary_term' = 'Resume File Path');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `resume_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Candidate Source Channel');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'job_board|employee_referral|agency|campus_recruitment|social_media|career_site');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `source_detail` SET TAGS ('dbx_business_glossary_term' = 'Candidate Source Detail');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Candidate State or Province');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `therapeutic_area_expertise` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Expertise');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `total_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Total Years of Professional Experience');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `veteran_status` SET TAGS ('dbx_business_glossary_term' = 'Veteran Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `veteran_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `willing_to_relocate_flag` SET TAGS ('dbx_business_glossary_term' = 'Willing to Relocate Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`candidate` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_value_regex' = 'citizen|permanent_resident|work_visa|requires_sponsorship|not_authorized');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `job_application_id` SET TAGS ('dbx_business_glossary_term' = 'Job Application Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `candidate_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Requisition Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `tertiary_job_referral_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `tertiary_job_referral_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `tertiary_job_referral_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `application_source` SET TAGS ('dbx_business_glossary_term' = 'Application Source Channel');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Assessment Result');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `assessment_result` SET TAGS ('dbx_value_regex' = 'not_assessed|passed|failed|pending');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_initiated|in_progress|cleared|flagged|failed');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Application Comments');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `expected_start_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `gxp_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Role Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `hiring_decision` SET TAGS ('dbx_business_glossary_term' = 'Hiring Decision');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `hiring_decision` SET TAGS ('dbx_value_regex' = 'pending|hire|no_hire');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `hiring_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Hiring Decision Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `interview_date` SET TAGS ('dbx_business_glossary_term' = 'Interview Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `interview_stage` SET TAGS ('dbx_business_glossary_term' = 'Interview Stage');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `medical_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Clearance Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `medical_clearance_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `medical_clearance_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `medical_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Pre-Employment Medical Clearance Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `medical_clearance_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|cleared|conditional|failed');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `medical_clearance_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `medical_clearance_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `offer_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Acceptance Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Extended Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `offer_status` SET TAGS ('dbx_value_regex' = 'not_extended|pending|accepted|declined|withdrawn|expired');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `referral_bonus_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Bonus Eligible Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `screening_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `screening_status` SET TAGS ('dbx_business_glossary_term' = 'Screening Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `screening_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed|on_hold');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Application Withdrawal Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_application` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Candidate Withdrawal Reason');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Incumbent Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `quaternary_headcount_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `quaternary_headcount_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `quaternary_headcount_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `quinary_headcount_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `quinary_headcount_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `quinary_headcount_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `tertiary_headcount_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `tertiary_headcount_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `tertiary_headcount_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `approved_fte_count` SET TAGS ('dbx_business_glossary_term' = 'Approved Full-Time Equivalent (FTE) Count');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `attrition_assumption_rate` SET TAGS ('dbx_business_glossary_term' = 'Attrition Assumption Rate');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Headcount Budget Amount');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `business_continuity_priority` SET TAGS ('dbx_business_glossary_term' = 'Business Continuity Priority');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `business_continuity_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Plan Comments');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `current_fte_count` SET TAGS ('dbx_business_glossary_term' = 'Current Full-Time Equivalent (FTE) Count');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `development_gap_assessment` SET TAGS ('dbx_business_glossary_term' = 'Development Gap Assessment');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `expected_attrition_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Attrition Count');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `gxp_qualification_readiness` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Qualification Readiness');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `gxp_qualification_readiness` SET TAGS ('dbx_value_regex' = 'qualified|in_progress|not_started|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `open_positions_count` SET TAGS ('dbx_business_glossary_term' = 'Open Positions Count');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Name');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^HCP-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_review_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Type');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|strategic|tactical|scenario|contingency');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planned_hires_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Hires Count');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `regulatory_continuity_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Continuity Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `retention_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Retention Risk Rating');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `retention_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Planning Scenario Name');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `scenario_probability` SET TAGS ('dbx_business_glossary_term' = 'Scenario Probability Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `succession_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `successor_readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Successor Readiness Level');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `successor_readiness_level` SET TAGS ('dbx_value_regex' = 'ready_now|1_2_years|3_5_years|not_ready');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `therapeutic_area_criticality` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Criticality');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`headcount_plan` ALTER COLUMN `therapeutic_area_criticality` SET TAGS ('dbx_value_regex' = 'oncology|immunology|rare_disease|vaccines|general|multiple');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` SET TAGS ('dbx_subdomain' = 'learning_compliance');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `system_access_id` SET TAGS ('dbx_business_glossary_term' = 'System Access Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `part11_system_id` SET TAGS ('dbx_business_glossary_term' = 'Part11 System Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `primary_system_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `primary_system_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `primary_system_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `quaternary_system_reviewed_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `quaternary_system_reviewed_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `quaternary_system_reviewed_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `quinary_system_revoked_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Revoked By Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `quinary_system_revoked_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `quinary_system_revoked_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `tertiary_system_provisioned_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Provisioned By Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `tertiary_system_provisioned_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `tertiary_system_provisioned_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'Read Only|Read Write|Admin|Super User|Approver|Reviewer');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'Pending Approval|Active|Suspended|Revoked|Expired|Under Review');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `csv_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'CSV Scope Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `emergency_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Access Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `gxp_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'GxP Regulated Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `privileged_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Privileged Access Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `provisioning_date` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Review Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `review_outcome` SET TAGS ('dbx_value_regex' = 'Approved|Revoked|Modified|Pending');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Risk Classification');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `risk_classification` SET TAGS ('dbx_value_regex' = 'High|Medium|Low');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `role_code` SET TAGS ('dbx_business_glossary_term' = 'Role Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `role_name` SET TAGS ('dbx_business_glossary_term' = 'Role Name');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `segregation_of_duties_flag` SET TAGS ('dbx_business_glossary_term' = 'Segregation of Duties (SOD) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`system_access` ALTER COLUMN `sox_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'SOX Scope Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `employee_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Movement Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'New Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Department Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Position Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `tertiary_new_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'New Manager Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `tertiary_new_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `tertiary_new_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `tertiary_quinary_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Movement Approved By Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `tertiary_quinary_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `tertiary_quinary_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Movement Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Movement Cancellation Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Movement Cancellation Reason');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Movement Comments');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Movement Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Movement Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `gxp_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Regulated Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `movement_number` SET TAGS ('dbx_business_glossary_term' = 'Movement Transaction Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `movement_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `movement_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason Description');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `movement_status` SET TAGS ('dbx_business_glossary_term' = 'Movement Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `new_cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'New Cost Center Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `new_grade_band` SET TAGS ('dbx_business_glossary_term' = 'New Grade Band');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `new_job_family` SET TAGS ('dbx_business_glossary_term' = 'New Job Family');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `previous_cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Previous Cost Center Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `previous_grade_band` SET TAGS ('dbx_business_glossary_term' = 'Previous Grade Band');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `previous_job_family` SET TAGS ('dbx_business_glossary_term' = 'Previous Job Family');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `quality_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Critical Function Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `secondment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Secondment End Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `secondment_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Secondment Organization Name');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `secondment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Secondment Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`employee_movement` ALTER COLUMN `training_requalification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Requalification Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `succession_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `primary_succession_incumbent_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Incumbent Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `primary_succession_incumbent_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `primary_succession_incumbent_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `quaternary_succession_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `quaternary_succession_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `quaternary_succession_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `quinary_succession_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `quinary_succession_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `quinary_succession_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Target Position Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `tertiary_succession_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `tertiary_succession_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `tertiary_succession_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `actual_transition_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Transition Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `business_continuity_priority` SET TAGS ('dbx_business_glossary_term' = 'Business Continuity Priority');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `business_continuity_priority` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `development_gap_summary` SET TAGS ('dbx_business_glossary_term' = 'Development Gap Summary');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `estimated_transition_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Transition Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `gxp_qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Qualification Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `gxp_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Qualification Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `gxp_qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|in_progress|not_started|expired|waived');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `gxp_requalification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Requalification Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^SP-[0-9]{8}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_review_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|on_hold|completed|cancelled|archived');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `qualified_person_flag` SET TAGS ('dbx_business_glossary_term' = 'Qualified Person (QP) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `readiness_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Readiness Assessment Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `readiness_level` SET TAGS ('dbx_business_glossary_term' = 'Successor Readiness Level');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `readiness_level` SET TAGS ('dbx_value_regex' = 'ready_now|1_to_2_years|3_to_5_years|not_ready');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `regulatory_inspection_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Ready Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `responsible_pharmacist_flag` SET TAGS ('dbx_business_glossary_term' = 'Responsible Pharmacist Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `retention_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Retention Risk Rating');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `retention_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `therapeutic_area_criticality` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Criticality');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`succession_plan` ALTER COLUMN `therapeutic_area_criticality` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `time_attendance_id` SET TAGS ('dbx_business_glossary_term' = 'Time Attendance ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `adjusted_time_attendance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `absence_code` SET TAGS ('dbx_business_glossary_term' = 'Absence Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `absence_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `absence_reason` SET TAGS ('dbx_business_glossary_term' = 'Absence Reason Description');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `actual_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Worked');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|submitted|draft');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `attendance_date` SET TAGS ('dbx_business_glossary_term' = 'Attendance Date');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `attendance_record_number` SET TAGS ('dbx_business_glossary_term' = 'Attendance Record Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `attendance_record_number` SET TAGS ('dbx_value_regex' = '^TA-[0-9]{10}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `attendance_status` SET TAGS ('dbx_business_glossary_term' = 'Attendance Status');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration Minutes');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `clock_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock-In Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `clock_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock-Out Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `early_departure_minutes` SET TAGS ('dbx_business_glossary_term' = 'Early Departure Minutes');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `gmp_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Critical Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `gxp_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Regulated Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `late_arrival_minutes` SET TAGS ('dbx_business_glossary_term' = 'Late Arrival Minutes');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `overtime_category` SET TAGS ('dbx_business_glossary_term' = 'Overtime Category');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `paid_break_minutes` SET TAGS ('dbx_business_glossary_term' = 'Paid Break Minutes');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `payroll_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `production_order_number` SET TAGS ('dbx_business_glossary_term' = 'Production Order Number');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `production_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Hours');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern Description');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `time_clock_device_code` SET TAGS ('dbx_business_glossary_term' = 'Time Clock Device ID');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `time_clock_device_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `time_clock_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `time_clock_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `time_entry_method` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Method');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`time_attendance` ALTER COLUMN `unpaid_break_minutes` SET TAGS ('dbx_business_glossary_term' = 'Unpaid Break Minutes');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_family` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_family` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`job_family` ALTER COLUMN `job_family_id` SET TAGS ('dbx_business_glossary_term' = 'Job Family Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`competency_framework` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`competency_framework` SET TAGS ('dbx_subdomain' = 'learning_compliance');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`competency_framework` ALTER COLUMN `competency_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Framework Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`competency_framework` ALTER COLUMN `parent_competency_framework_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_period` SET TAGS ('dbx_subdomain' = 'rewards_operations');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_period` ALTER COLUMN `payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`workforce`.`payroll_period` ALTER COLUMN `prior_payroll_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
