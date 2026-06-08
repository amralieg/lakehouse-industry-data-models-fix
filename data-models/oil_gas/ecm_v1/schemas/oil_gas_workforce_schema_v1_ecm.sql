-- Schema for Domain: workforce | Business: Oil Gas | Version: v1_ecm
-- Generated on: 2026-05-04 05:08:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`workforce` COMMENT 'Manages the full employee and contractor lifecycle including recruitment, onboarding, competency management, crew scheduling, rig personnel tracking, training, performance evaluation, payroll, benefits, workforce planning, and OSHA-mandated training records. Owns employee profiles, organizational hierarchy, certifications, labor cost allocation, and HSE certification tracking. Supports SIMOPS crew coordination, offshore manning requirements, and labor regulations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique system identifier for the employee record. Primary key for the employee master data product.',
    `job_role_id` BIGINT COMMENT 'Foreign key linking to workforce.job_role. Business justification: Employee performs a standardized job_role. While position also links to job_role, employee may have a job_role assignment independent of position (e.g., acting roles, cross-functional assignments). Th',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Employee fills an authorized position (headcount slot). Position is the authoritative source for job_code, job_title, and grade_band. Adding position_id FK normalizes these attributes to the position ',
    `supervisor_employee_id` BIGINT COMMENT 'Employee ID of the direct supervisor or manager. Used for organizational hierarchy, reporting relationships, and approval workflows.',
    `competency_level` STRING COMMENT 'Overall competency or skill level of the employee in their primary role: entry (junior), intermediate (developing), advanced (proficient), expert (highly skilled), or master (subject matter expert).. Valid values are `entry|intermediate|advanced|expert|master`',
    `cost_center` STRING COMMENT 'Financial cost center to which the employees labor costs are allocated. Used for OPEX tracking, AFE allocation, and joint interest billing.. Valid values are `^[0-9]{6,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was first created in the system. Used for audit trail and data lineage.',
    `date_of_birth` DATE COMMENT 'Date of birth of the employee. Used for age verification, benefits eligibility, retirement planning, and OSHA age-related safety requirements.',
    `department` STRING COMMENT 'Organizational department or functional unit to which the employee is assigned (e.g., Exploration, Drilling, Production, Refining, HSE, Finance).',
    `division` STRING COMMENT 'Business division or segment to which the employee belongs (e.g., Upstream, Midstream, Downstream, Petrochemicals).',
    `email_address` STRING COMMENT 'Primary corporate email address for the employee. Used for business communication, system access, and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Full name of the employees designated emergency contact person. Critical for offshore operations, remote sites, and HSE incident response.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the employees designated emergency contact. Used for emergency notifications and incident response.',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact to the employee (e.g., spouse, parent, sibling).. Valid values are `spouse|parent|sibling|child|friend|other`',
    `employee_number` STRING COMMENT 'Business-assigned unique employee number used across HR systems and payroll. This is the externally-known identifier for the employee.. Valid values are `^[A-Z0-9]{6,12}$`',
    `employment_status` STRING COMMENT 'Current lifecycle status of the employee: active (currently working), inactive (not currently working but employed), suspended (temporarily barred), leave (on approved leave), or terminated (employment ended).. Valid values are `active|inactive|suspended|leave|terminated`',
    `employment_type` STRING COMMENT 'Classification of employment relationship: staff (permanent employee), contract (contractor), secondee (assigned from partner company), temporary (fixed-term), or intern.. Valid values are `staff|contract|secondee|temporary|intern`',
    `first_name` STRING COMMENT 'Legal first name (given name) of the employee as recorded in official employment documents.',
    `full_name` STRING COMMENT 'Complete legal name of the employee, typically concatenated as first middle last name for display and reporting purposes.',
    `hire_date` DATE COMMENT 'Date the employee was hired or commenced employment with Oil Gas. Used for seniority calculations, benefits eligibility, and tenure reporting.',
    `home_country` STRING COMMENT 'Three-letter ISO country code representing the employees home country or country of origin. Used for expatriate management, tax compliance, and workforce demographics.. Valid values are `^[A-Z]{3}$`',
    `hse_certification_status` STRING COMMENT 'Current status of the employees HSE certifications required for their role: current (all certifications valid), expired (one or more expired), pending (awaiting certification), or not_required.. Valid values are `current|expired|pending|not_required`',
    `last_hse_training_date` DATE COMMENT 'Date of the most recent HSE training completed by the employee. Used for OSHA compliance tracking and recertification scheduling.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was last updated. Used for audit trail, change tracking, and data quality monitoring.',
    `last_name` STRING COMMENT 'Legal last name (surname/family name) of the employee as recorded in official employment documents.',
    `middle_name` STRING COMMENT 'Middle name or initial of the employee, if applicable.',
    `mobile_number` STRING COMMENT 'Mobile phone number for the employee. Critical for offshore and remote site communication, emergency response, and SIMOPS coordination.',
    `national_code` STRING COMMENT 'Government-issued national identification number (e.g., Social Security Number in USA, National Insurance Number in UK). Used for tax reporting, payroll, and regulatory compliance.',
    `next_hse_training_due_date` DATE COMMENT 'Date by which the employee must complete their next mandatory HSE training or recertification. Used for compliance monitoring and training scheduling.',
    `offshore_qualified_flag` BOOLEAN COMMENT 'Indicates whether the employee is qualified and certified for offshore operations (platforms, FPSO, drilling rigs). Critical for crew scheduling and HSE compliance.',
    `passport_number` STRING COMMENT 'Passport number for employees requiring international travel for offshore operations, expatriate assignments, or cross-border projects.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the employee. Used for emergency contact, crew scheduling, and operational communication.',
    `preferred_name` STRING COMMENT 'Preferred or commonly used name for the employee in day-to-day business interactions, if different from legal name.',
    `rig_rotation_schedule` STRING COMMENT 'Work rotation schedule for employees assigned to offshore rigs or remote sites (e.g., 14-on/14-off, 28-on/28-off). Used for crew scheduling and SIMOPS coordination.',
    `sap_personnel_number` STRING COMMENT 'Eight-digit personnel number from SAP S/4HANA HR module. Used for integration with SAP FI, CO, and payroll modules.. Valid values are `^[0-9]{8}$`',
    `security_clearance_level` STRING COMMENT 'Security clearance level granted to the employee for access to sensitive facilities, data, or operations. Used for access control and compliance with government contracts.. Valid values are `none|basic|confidential|secret|top_secret`',
    `termination_date` DATE COMMENT 'Date the employees employment was terminated or ended. Null for active employees. Used for offboarding, final payroll, and compliance reporting.',
    `termination_reason` STRING COMMENT 'Reason for employment termination: resignation (voluntary), retirement, layoff (workforce reduction), dismissal (performance or conduct), contract_end (fixed-term expiry), or mutual_agreement.. Valid values are `resignation|retirement|layoff|dismissal|contract_end|mutual_agreement`',
    `union_code` STRING COMMENT 'Code identifying the specific labor union to which the employee belongs, if applicable. Used for union dues processing and labor agreement compliance.',
    `union_membership_flag` BOOLEAN COMMENT 'Indicates whether the employee is a member of a labor union. Used for collective bargaining compliance, labor relations, and payroll processing.',
    `work_country` STRING COMMENT 'Three-letter ISO country code representing the country where the employee currently works. May differ from home country for expatriate assignments.. Valid values are `^[A-Z]{3}$`',
    `work_location` STRING COMMENT 'Primary work location or site where the employee is based (e.g., Houston Office, North Sea Platform, Permian Basin Field, Singapore Refinery).',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Master record for all employees of Oil Gas, capturing full personal and employment profile including employee number, legal name, date of birth, national ID, employment type (staff/contract/secondee), hire date, termination date, employment status, job title, grade level, cost center, home country, work location, union membership flag, and SAP HR personnel number. Serves as the SSOT for employee identity across all workforce sub-domains.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`contractor` (
    `contractor_id` BIGINT COMMENT 'Unique identifier for the contractor record. Primary key for the contractor entity.',
    `afe_number` STRING COMMENT 'AFE number to which the contractors labor costs are charged for capital projects. Used for CAPEX tracking and joint venture billing.',
    `background_check_completion_date` DATE COMMENT 'Date when the contractors security background check was completed and cleared. Used to track compliance with facility security requirements.',
    `background_check_status` STRING COMMENT 'Status of the contractors security background check. Required for access to critical infrastructure and offshore facilities per CFATS and MTSA regulations.. Valid values are `not_started|in_progress|cleared|flagged|expired`',
    `badge_number` STRING COMMENT 'Unique badge or access control identifier issued to the contractor for facility access and tracking. Used for SIMOPS coordination and site security.',
    `company_name` STRING COMMENT 'Legal name of the third-party contractor or service company providing personnel to Oil Gas facilities, rigs, and plants.',
    `competency_level` STRING COMMENT 'Assessed skill and experience level of the contractor. Determines work authorization scope, supervision requirements, and rate classification per COPAS standards.. Valid values are `trainee|competent|advanced|expert|supervisor|lead`',
    `contract_end_date` DATE COMMENT 'Scheduled end date of the contractors service agreement. Null for open-ended contracts or evergreen agreements.',
    `contract_reference_number` STRING COMMENT 'Reference identifier linking the contractor to the master service agreement or purchase order managed in the procurement domain. Enables traceability to contract terms, rates, and scope of work.',
    `contract_start_date` DATE COMMENT 'Effective start date of the contractors service agreement with Oil Gas. Defines the beginning of the contractual relationship.',
    `cost_center_code` STRING COMMENT 'SAP cost center code to which the contractors labor costs are allocated. Used for OPEX tracking and financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contractor record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for contractor billing rates. Supports multi-currency operations for international contractors. [ENUM-REF-CANDIDATE: USD|CAD|GBP|EUR|AUD|NOK|BRL|MXN — 8 candidates stripped; promote to reference product]',
    `demobilization_date` DATE COMMENT 'Date when the contractor was demobilized from the site assignment. Null if contractor is currently mobilized.',
    `drug_alcohol_test_date` DATE COMMENT 'Date of the contractors most recent drug and alcohol screening test. Used to track compliance with random testing programs and pre-mobilization requirements.',
    `drug_alcohol_test_status` STRING COMMENT 'Status of the contractors most recent drug and alcohol screening test. Required for safety-sensitive positions per DOT and company HSE policies.. Valid values are `passed|failed|pending|not_required`',
    `email_address` STRING COMMENT 'Primary email address for contractor communication and HSE training notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Full name of the contractors designated emergency contact person. Required for offshore and remote site deployments per HSE protocols.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the contractors designated emergency contact person. Used for notification in case of incidents or medical emergencies.',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact person to the contractor (e.g., spouse, parent, sibling, friend).',
    `first_name` STRING COMMENT 'Given name of the contractor individual.',
    `h2s_exposure_category` STRING COMMENT 'Classification of the contractors potential exposure to H2S gas during operations. Determines required H2S training, monitoring equipment, and emergency response procedures per API RP 55.. Valid values are `none|low|medium|high`',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Standard hourly billing rate for the contractor as defined in the service agreement. Used for labor cost allocation to AFE, cost center, or JIB.',
    `hse_induction_completion_date` DATE COMMENT 'Date when the contractor successfully completed the mandatory HSE induction training. Used to track compliance and determine re-certification requirements.',
    `hse_induction_expiry_date` DATE COMMENT 'Date when the contractors HSE induction certification expires and re-training is required. Typically valid for 1-2 years depending on facility requirements.',
    `hse_induction_status` STRING COMMENT 'Status of the contractors mandatory HSE induction training in Enablon HSE Management system. Must be completed before site access is granted.. Valid values are `not_started|in_progress|completed|expired`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the contractor record was last updated. Used for audit trail and change tracking.',
    `last_name` STRING COMMENT 'Family name or surname of the contractor individual.',
    `medical_fitness_expiry_date` DATE COMMENT 'Date when the contractors medical fitness certification expires and re-examination is required. Typically annual for offshore personnel.',
    `medical_fitness_status` STRING COMMENT 'Current medical fitness status of the contractor for offshore or hazardous duty. Based on periodic medical examinations per OSHA and offshore regulatory requirements.. Valid values are `fit|fit_with_restrictions|temporarily_unfit|permanently_unfit|pending`',
    `mobilization_date` DATE COMMENT 'Date when the contractor was mobilized to the current site assignment. Used to track deployment duration and rotation schedules.',
    `mobilization_status` STRING COMMENT 'Current deployment status of the contractor. Tracks whether the contractor is actively deployed at a facility, awaiting mobilization, or has been demobilized.. Valid values are `pending|mobilized|demobilized|on_leave|suspended`',
    `norm_exposure_category` STRING COMMENT 'Classification of the contractors potential exposure to NORM during operations. Determines required monitoring, PPE, and health surveillance per EPA and OSHA regulations.. Valid values are `none|low|medium|high`',
    `offshore_survival_training_expiry_date` DATE COMMENT 'Date when the contractors offshore survival training certification expires. Typically valid for 4 years with 2-year refresher requirements.',
    `offshore_survival_training_status` STRING COMMENT 'Status of the contractors offshore survival and emergency response training (BOSIET, HUET, or equivalent). Required for personnel deployed to offshore platforms and FPSO vessels.. Valid values are `not_required|current|expired|pending`',
    `overtime_rate` DECIMAL(18,2) COMMENT 'Overtime hourly billing rate for the contractor, typically 1.5x or 2x the standard rate depending on contract terms and labor regulations.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the contractor, used for emergency contact and crew coordination.',
    `ptw_authorization_level` STRING COMMENT 'Level of authority the contractor has in the Permit to Work system. Determines whether the contractor can request, approve, or issue work permits for hazardous operations.. Valid values are `none|requester|approver|issuer`',
    `role_classification` STRING COMMENT 'Functional role or job classification of the contractor. Determines competency requirements, PTW authorization level, and labor cost allocation category. [ENUM-REF-CANDIDATE: drilling_crew|completion_crew|production_operator|maintenance_technician|hse_advisor|geologist|instrumentation_technician|electrical_technician|mechanical_technician|scaffolder|rigger|crane_operator|welder|inspector|engineer|supervisor|medic|catering_staff|security_personnel — promote to reference product]. Valid values are `drilling_crew|completion_crew|production_operator|maintenance_technician|hse_advisor|geologist`',
    `twic_card_expiry_date` DATE COMMENT 'Expiration date of the contractors TWIC card. TWIC cards are valid for 5 years and must be renewed for continued access to maritime facilities.',
    `twic_card_number` STRING COMMENT 'TWIC card number issued by TSA for contractors requiring unescorted access to secure maritime facilities and offshore platforms. Required per MTSA regulations.',
    `work_schedule_pattern` STRING COMMENT 'Standard work rotation schedule for the contractor (e.g., 14-days-on/14-days-off, 28-days-on/28-days-off). Common for offshore and remote site personnel.',
    CONSTRAINT pk_contractor PRIMARY KEY(`contractor_id`)
) COMMENT 'Master record for third-party contractors and service company personnel deployed at Oil Gas facilities, rigs, and plants. Captures contractor company name, contract reference, badge number, role classification, competency level, mobilization status, site assignment, NORM/H2S exposure category, and Enablon HSE induction status. Distinct from employee as contractors are not on payroll and are governed by service agreements managed in procurement domain.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the organizational position. Primary key.',
    `job_role_id` BIGINT COMMENT 'Foreign key linking to workforce.job_role. Business justification: Position is an instance of a standardized job_role. Job_role defines the role catalog with competency requirements, compensation grade, and job family. Adding job_role_id FK normalizes job_code and jo',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Position belongs to an organizational unit. Org_unit defines the management hierarchy and cost center structure. Adding org_unit_id FK normalizes organizational_unit_code to the org_unit master.',
    `reports_to_position_id` BIGINT COMMENT 'Identifier of the supervisory position to which this position reports in the organizational hierarchy. Null for top-level positions (e.g., CEO).',
    `budgeted_flag` BOOLEAN COMMENT 'Indicates whether the position has approved budget allocation for the current fiscal year. True if budgeted, False if not.',
    `cost_center_code` STRING COMMENT 'Financial cost center to which labor costs for this position are allocated. Used for budgeting, variance analysis, and financial reporting.. Valid values are `^[A-Z0-9]{6,10}$`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the positions primary work location. Used for labor law compliance and tax reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the position record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when the position was officially created or became active in the organizational structure.',
    `employment_type` STRING COMMENT 'Standard employment classification for the position (full-time, part-time, contractor, temporary, seasonal, intern).. Valid values are `full_time|part_time|contractor|temporary|seasonal|intern`',
    `end_date` DATE COMMENT 'Date when the position was or will be eliminated or frozen. Null for active ongoing positions.',
    `filled_flag` BOOLEAN COMMENT 'Indicates whether the position is currently occupied by an employee or contractor. True if filled, False if vacant.',
    `flsa_classification` STRING COMMENT 'Classification under the U.S. Fair Labor Standards Act indicating whether the position is exempt or non-exempt from overtime pay requirements.. Valid values are `exempt|non_exempt`',
    `fte_count` DECIMAL(18,2) COMMENT 'Number of full-time equivalent headcount allocated to this position. May be fractional for part-time or shared positions (e.g., 1.0 for full-time, 0.5 for half-time).',
    `grade_band` STRING COMMENT 'Compensation grade or band assigned to the position, determining salary range and benefits eligibility (e.g., G01-G15 for general staff, E01-E10 for executives).. Valid values are `^(G[0-9]{1,2}|E[0-9]{1,2}|M[0-9]{1,2}|S[0-9]{1,2})$`',
    `last_modified_by` STRING COMMENT 'User identifier of the HR or system administrator who last modified the position record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the position record was last updated in the system.',
    `last_review_date` DATE COMMENT 'Date when the position description, competency requirements, or organizational placement was last reviewed and validated.',
    `minimum_education_level` STRING COMMENT 'Minimum formal education level required for the position (e.g., high school, bachelor, master, professional certification). [ENUM-REF-CANDIDATE: high_school|associate|bachelor|master|doctorate|professional_certification|none — 7 candidates stripped; promote to reference product]',
    `minimum_years_experience` STRING COMMENT 'Minimum number of years of relevant industry or functional experience required for the position.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the position to ensure alignment with business needs and organizational structure.',
    `offshore_manning_requirement_flag` BOOLEAN COMMENT 'Indicates whether the position is subject to regulatory offshore manning requirements (minimum crew levels mandated by BSEE or other authorities). True if subject to manning requirements, False otherwise.',
    `position_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the position within the organizational structure. Used for budgeting, reporting, and workforce planning.. Valid values are `^[A-Z0-9]{6,12}$`',
    `position_status` STRING COMMENT 'Current lifecycle state of the position indicating whether it is active, vacant, frozen (budget hold), eliminated, pending approval, or filled.. Valid values are `active|vacant|frozen|eliminated|pending_approval|filled`',
    `required_certifications` STRING COMMENT 'Comma-separated list of mandatory professional certifications or licenses required for the position (e.g., API 510, IADC WellSharp, NEBOSH, OSHA 30-Hour, Professional Engineer (PE) license).',
    `rotation_schedule_type` STRING COMMENT 'Work rotation pattern for the position, common in offshore and remote operations (e.g., 14 days on / 14 days off, 21/21, 28/28). None for standard office positions. [ENUM-REF-CANDIDATE: standard|14_14|21_21|28_28|offshore_rotation|onshore_rotation|none — 7 candidates stripped; promote to reference product]',
    `safety_critical_flag` BOOLEAN COMMENT 'Indicates whether the position is designated as safety-critical under HSE regulations, requiring enhanced competency verification and medical fitness (e.g., Offshore Installation Manager (OIM), Toolpusher, HSE Officer, Blowout Preventer (BOP) Operator). True if safety-critical, False otherwise.',
    `shift_pattern` STRING COMMENT 'Standard work shift pattern for the position (day, night, rotating, 12-hour, 8-hour, flexible, on-call). Critical for 24/7 operations in refineries, plants, and offshore platforms. [ENUM-REF-CANDIDATE: day|night|rotating|12_hour|8_hour|flexible|on_call — 7 candidates stripped; promote to reference product]',
    `simops_role_flag` BOOLEAN COMMENT 'Indicates whether the position plays a role in Simultaneous Operations (SIMOPS) coordination, requiring specialized training and communication protocols. True if SIMOPS role, False otherwise.',
    `succession_plan_priority` STRING COMMENT 'Priority level for succession planning, indicating the business criticality of having a ready replacement (critical, high, medium, low, none).. Valid values are `critical|high|medium|low|none`',
    `title` STRING COMMENT 'Official job title for the position as it appears in organizational charts and job postings.',
    `union_affiliation_code` STRING COMMENT 'Code identifying the labor union or collective bargaining unit to which the position belongs, if applicable. Empty for non-union positions.. Valid values are `^[A-Z0-9]{0,10}$`',
    `work_location_code` STRING COMMENT 'Code identifying the primary physical work location for the position (office, rig, plant, field location, remote).. Valid values are `^[A-Z0-9]{4,10}$`',
    `work_location_type` STRING COMMENT 'Classification of the work environment for the position, critical for HSE planning and crew scheduling (e.g., offshore platform, onshore rig, refinery, office). [ENUM-REF-CANDIDATE: office|offshore_platform|onshore_rig|refinery|petrochemical_plant|field_location|remote|rotational — 8 candidates stripped; promote to reference product]',
    `created_by` STRING COMMENT 'User identifier of the HR or system administrator who created the position record.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Organizational position master defining each authorized headcount slot within the Oil Gas org structure. Captures position code, position title, job family, grade band, FTE count, budgeted vs filled status, reporting line, cost center, location, required competency profile, and whether the position is safety-critical (e.g., OIM, Toolpusher, HSE Officer). Supports workforce planning and org design.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the organizational unit. Primary key.',
    `parent_org_unit_id` BIGINT COMMENT 'Reference to the parent organizational unit in the corporate hierarchy. Null for top-level units.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual operating budget allocated to this organizational unit in USD. Includes labor costs, operating expenses, and allocated overhead.',
    `budget_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the budget amount. Typically USD for multinational operations but may vary by subsidiary.. Valid values are `^[A-Z]{3}$`',
    `business_segment` STRING COMMENT 'Primary business segment or operational area that this organizational unit supports within the oil and gas value chain. [ENUM-REF-CANDIDATE: exploration_production|drilling|refining|petrochemicals|marketing_sales|supply_chain|corporate — 7 candidates stripped; promote to reference product]',
    `company_code` STRING COMMENT 'SAP Financial Accounting (FI) company code representing the legal entity to which this organizational unit belongs. Used for statutory reporting and consolidation.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_code` STRING COMMENT 'SAP Controlling (CO) cost center code mapped to this organizational unit for financial tracking and labor cost allocation. Used for CAPEX and OPEX allocation.. Valid values are `^[A-Z0-9]{6,10}$`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary country of operation for this organizational unit. Used for jurisdiction-specific compliance and labor regulations.. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'User ID or system account that created this organizational unit record. Used for accountability and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was first created in the system. Used for audit trail and data lineage tracking.',
    `current_headcount` STRING COMMENT 'Current number of employees and contractors assigned to this organizational unit. Used for variance analysis against manning requirements.',
    `effective_end_date` DATE COMMENT 'Date when this organizational unit ceased or will cease operations. Null for currently active units. Used for historical organizational analysis and restructuring tracking.',
    `effective_start_date` DATE COMMENT 'Date when this organizational unit became or will become operational and active in the corporate structure. Used for time-dependent organizational reporting.',
    `fiscal_year` STRING COMMENT 'Fiscal year for which the budget and manning requirements are defined. Used for year-over-year performance comparison.',
    `geographic_region` STRING COMMENT 'Primary geographic region where this organizational unit operates. Used for regional performance reporting and regulatory compliance tracking.. Valid values are `north_america|south_america|europe|middle_east|africa|asia_pacific`',
    `hse_jurisdiction` STRING COMMENT 'Regulatory jurisdiction governing HSE compliance for this organizational unit. Determines applicable OSHA, BSEE, EPA, or equivalent international standards.',
    `is_joint_venture` BOOLEAN COMMENT 'Indicates whether this organizational unit operates under a Joint Operating Agreement (JOA) or Production Sharing Agreement (PSA) with partner companies. Affects cost allocation and reporting requirements.',
    `jv_operator_flag` BOOLEAN COMMENT 'Indicates whether Oil Gas is the operator for this joint venture organizational unit. Operator status determines operational control and billing responsibilities.',
    `manning_requirement_count` STRING COMMENT 'Approved headcount or manning level for this organizational unit. Used for workforce planning, budgeting, and SIMOPS crew coordination.',
    `modified_by_user` STRING COMMENT 'User ID or system account that last modified this organizational unit record. Used for change management and audit compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was last modified. Used for change tracking and audit compliance.',
    `operational_area` STRING COMMENT 'Classification of the operational environment where this organizational unit primarily functions within the oil and gas value chain.. Valid values are `offshore|onshore|midstream|downstream|corporate_office`',
    `org_unit_code` STRING COMMENT 'Business identifier code for the organizational unit used across enterprise systems. Typically alphanumeric code assigned by corporate standards.. Valid values are `^[A-Z0-9]{4,12}$`',
    `org_unit_description` STRING COMMENT 'Detailed description of the organizational units purpose, scope of operations, and key responsibilities within the corporate structure.',
    `org_unit_name` STRING COMMENT 'Full name of the organizational unit as it appears in corporate hierarchy and reporting structures.',
    `org_unit_status` STRING COMMENT 'Current lifecycle status of the organizational unit. Active units are operational and can have employees assigned. Planned units are approved but not yet operational. Closed units are historical.. Valid values are `active|inactive|planned|closed`',
    `org_unit_type` STRING COMMENT 'Classification of the organizational unit within the corporate structure hierarchy. Defines the level and function of the unit.. Valid values are `business_unit|division|department|cost_center|region|district`',
    `profit_center_code` STRING COMMENT 'SAP profit center code for units that are managed as independent profit and loss centers. Used for internal management accounting and performance evaluation.. Valid values are `^[A-Z0-9]{6,10}$`',
    `safety_performance_tier` STRING COMMENT 'HSE safety performance classification based on incident rates, near-miss reporting, and compliance audit results. Tier 1 represents highest safety performance.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `short_name` STRING COMMENT 'Abbreviated name of the organizational unit used in reports and user interfaces where space is limited.',
    `union_representation_flag` BOOLEAN COMMENT 'Indicates whether employees in this organizational unit are represented by a labor union. Affects labor relations, collective bargaining, and workforce scheduling.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'Oil Gas working interest percentage in this organizational unit if it operates under a joint venture structure. Used for cost and revenue allocation.',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational unit hierarchy master representing the management structure of Oil Gas, including business units (E&P, Refining, Petrochemicals), divisions, departments, and cost centers. Captures org unit code, name, type, parent org unit, responsible manager, effective date, and SAP cost center mapping. Enables hierarchical rollup of headcount, labor cost, and HSE metrics.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`job_role` (
    `job_role_id` BIGINT COMMENT 'Unique identifier for the job role. Primary key for the job role reference catalog.',
    `afe_approval_limit_usd` DECIMAL(18,2) COMMENT 'Maximum dollar amount the role is authorized to approve for capital expenditure AFEs without escalation, used in financial controls and delegation of authority matrices.',
    `api_occupational_classification` STRING COMMENT 'Industry-standard occupational classification code as defined by the American Petroleum Institute for oil and gas workforce categorization and benchmarking.',
    `compensation_grade` STRING COMMENT 'Salary grade or pay band assigned to the role, determining the compensation range and benefits eligibility. Used for payroll and compensation planning.. Valid values are `^[A-Z]{1,2}[0-9]{1,2}$`',
    `confined_space_entry_flag` BOOLEAN COMMENT 'Indicates whether the role requires entry into confined spaces (vessels, tanks, pits), requiring confined space entry training and medical clearance per OSHA 1910.146.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this job role record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this job role definition was retired or superseded. Null for currently active roles.',
    `effective_start_date` DATE COMMENT 'Date when this job role definition became effective and available for use in the organization.',
    `environmental_conditions_description` STRING COMMENT 'Description of typical work environment conditions (e.g., offshore platform, refinery unit, office, field site, exposure to H2S, extreme temperatures, noise), used for HSE risk assessment and PPE requirements.',
    `flsa_classification` STRING COMMENT 'Classification under the U.S. Fair Labor Standards Act determining overtime eligibility. Exempt roles are salaried and not eligible for overtime; Non-Exempt roles are eligible for overtime pay.. Valid values are `Exempt|Non-Exempt`',
    `h2s_exposure_flag` BOOLEAN COMMENT 'Indicates whether the role involves potential exposure to hydrogen sulfide gas, requiring H2S safety training and specialized respiratory protection per OSHA standards.',
    `hot_work_authorization_flag` BOOLEAN COMMENT 'Indicates whether the role is authorized to perform or supervise hot work operations (welding, cutting, grinding) in hazardous areas, requiring hot work training and fire watch certification.',
    `job_family` STRING COMMENT 'Broad occupational category grouping similar roles together for career pathing, compensation benchmarking, and workforce planning. Aligned with Oil Gas business domains. [ENUM-REF-CANDIDATE: Drilling|Reservoir|Production|Refining|Petrochemicals|HSE|Finance|Supply Chain|Engineering|Maintenance|Operations|Geoscience|Land|Legal|IT|HR|Procurement|Marketing|Sales|Logistics|Quality|Planning|Project Management|Asset Management — 24 candidates stripped; promote to reference product]',
    `job_level` STRING COMMENT 'Hierarchical level of the role within the organizational structure, used for compensation grading, reporting relationships, and career progression planning. [ENUM-REF-CANDIDATE: Entry|Intermediate|Senior|Lead|Principal|Manager|Senior Manager|Director|Senior Director|Vice President|Senior Vice President|Executive Vice President|C-Level — 13 candidates stripped; promote to reference product]',
    `job_role_status` STRING COMMENT 'Current lifecycle status of the job role in the reference catalog. Active roles are available for assignment; Inactive roles are temporarily suspended; Obsolete roles are retired and no longer used.. Valid values are `Active|Inactive|Obsolete|Under Review|Pending Approval|Archived`',
    `job_sub_family` STRING COMMENT 'More granular classification within the job family, providing additional segmentation for specialized roles (e.g., within Drilling: Directional Drilling, Drilling Engineering, Rig Operations).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this job role record was last modified, used for change tracking and audit trail.',
    `minimum_education_level` STRING COMMENT 'Minimum formal education requirement for the role, used in recruitment screening and competency assessment. [ENUM-REF-CANDIDATE: High School|Associate Degree|Bachelor Degree|Master Degree|Doctorate|Professional Certification|Trade School|None — 8 candidates stripped; promote to reference product]',
    `minimum_years_experience` STRING COMMENT 'Minimum number of years of relevant work experience required for the role, used in recruitment screening and competency validation.',
    `moc_approval_authority_flag` BOOLEAN COMMENT 'Indicates whether the role has authority to approve Management of Change requests for operational, equipment, or procedural modifications per API RP 75 and OSHA PSM requirements.',
    `norm_exposure_flag` BOOLEAN COMMENT 'Indicates whether the role involves potential exposure to naturally occurring radioactive materials in oilfield operations, requiring NORM awareness training and radiation safety protocols.',
    `offshore_applicable_flag` BOOLEAN COMMENT 'Indicates whether the role is applicable to offshore operations (platforms, FPSO, drilling rigs), requiring offshore survival training, BOSIET certification, and compliance with BSEE offshore manning requirements.',
    `onshore_applicable_flag` BOOLEAN COMMENT 'Indicates whether the role is applicable to onshore operations (refineries, petrochemical plants, land drilling, production facilities).',
    `opex_approval_limit_usd` DECIMAL(18,2) COMMENT 'Maximum dollar amount the role is authorized to approve for operating expenditures without escalation, used in financial controls and procurement workflows.',
    `physical_demands_description` STRING COMMENT 'Description of physical requirements for the role (e.g., lifting, climbing, confined space entry, extended standing), used for medical fitness assessments and ADA compliance.',
    `preferred_certifications` STRING COMMENT 'Comma-separated list of preferred but not mandatory professional certifications or credentials that enhance candidate suitability for the role.',
    `preferred_education_level` STRING COMMENT 'Preferred or ideal education level for candidates, used in job postings and candidate evaluation to identify best-fit applicants. [ENUM-REF-CANDIDATE: High School|Associate Degree|Bachelor Degree|Master Degree|Doctorate|Professional Certification|Trade School|None — 8 candidates stripped; promote to reference product]',
    `preferred_years_experience` STRING COMMENT 'Preferred or ideal number of years of relevant work experience for candidates, used in job postings and candidate ranking.',
    `ptw_authority_level` STRING COMMENT 'Level of authority the role holds in the Permit to Work system, defining whether the role can request, approve, or issue work permits for hazardous operations.. Valid values are `None|Requester|Approver|Issuer|Area Authority`',
    `required_certifications` STRING COMMENT 'Comma-separated list of mandatory professional certifications, licenses, or credentials required to perform the role (e.g., PE License, API Certification, OSHA 30-Hour, Well Control Certification).',
    `role_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the job role across Oil Gas. Used for HR system integration and reporting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `role_detailed_description` STRING COMMENT 'Comprehensive description of the role including key responsibilities, accountabilities, decision-making authority, and scope of work.',
    `role_short_description` STRING COMMENT 'Brief summary of the roles primary purpose and responsibilities, typically used in job postings and internal directories.',
    `role_title` STRING COMMENT 'Official job title for the role as used in employment contracts, job postings, and organizational charts.',
    `rotation_schedule_type` STRING COMMENT 'Standard rotation schedule for offshore or remote site roles (e.g., 14 days on / 14 days off), used for crew scheduling and labor cost allocation.. Valid values are `None|14/14|21/21|28/28|Custom|Variable`',
    `safety_critical_flag` BOOLEAN COMMENT 'Indicates whether the role is designated as safety-critical under HSE regulations, requiring enhanced training, medical surveillance, and competency verification per OSHA and BSEE standards.',
    `simops_coordination_required_flag` BOOLEAN COMMENT 'Indicates whether the role requires coordination of simultaneous operations, a critical HSE competency for managing concurrent drilling, production, and maintenance activities on shared facilities.',
    `soc_code` STRING COMMENT 'U.S. Bureau of Labor Statistics Standard Occupational Classification code used for regulatory reporting, labor market analysis, and compliance with federal workforce reporting requirements.. Valid values are `^[0-9]{2}-[0-9]{4}$`',
    `supervisory_role_flag` BOOLEAN COMMENT 'Indicates whether the role has direct supervisory responsibility for other employees or contractors, requiring leadership competencies and performance management training.',
    `travel_requirement_percentage` STRING COMMENT 'Estimated percentage of work time requiring travel (domestic or international), used in job postings and workforce planning for field-based and multi-site roles.',
    `typical_direct_reports_count` STRING COMMENT 'Typical number of direct reports for supervisory roles, used for span-of-control analysis and organizational design.',
    CONSTRAINT pk_job_role PRIMARY KEY(`job_role_id`)
) COMMENT 'Reference catalog of standardized job roles and job families used across Oil Gas, including role code, role title, job family (Drilling, Reservoir, Refining, HSE, Finance, etc.), API occupational classification, minimum qualification requirements, required certifications, safety-critical designation flag, and offshore/onshore applicability. Used to standardize position definitions and competency requirements.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`competency` (
    `competency_id` BIGINT COMMENT 'Unique identifier for the competency definition. Primary key for the competency master catalog.',
    `applicable_job_roles` STRING COMMENT 'Comma-separated or pipe-separated list of job roles or position titles for which this competency is required or recommended. Examples: Drilling Engineer, Rig Supervisor, Production Operator, HSE Coordinator, Subsea Engineer.',
    `assessment_method` STRING COMMENT 'The primary method used to assess and verify competency attainment. Written exams test theoretical knowledge. Practical assessments and simulator exercises evaluate hands-on skills. On-the-job evaluations assess performance in real operational contexts.. Valid values are `Written Exam|Practical Assessment|Simulator|On-the-Job Evaluation|Interview|Portfolio Review`',
    `certification_body` STRING COMMENT 'The name of the external organization or accredited training provider authorized to issue certification for this competency. Examples include IADC, OPITO, IWCF, National Association of Corrosion Engineers (NACE), American Welding Society (AWS).',
    `competency_category` STRING COMMENT 'High-level classification of the competency type. Technical competencies relate to job-specific skills (drilling, reservoir engineering, process operations). Safety competencies cover HSE and emergency response. Leadership competencies address supervisory and management capabilities. Regulatory competencies ensure compliance with legal and industry standards. [ENUM-REF-CANDIDATE: Technical|Safety|Leadership|Regulatory|Operational|HSE|Management — 7 candidates stripped; promote to reference product]',
    `competency_code` STRING COMMENT 'Unique business identifier code for the competency, used for external reference and integration with training systems. Typically follows organizational or industry standard coding schemes.. Valid values are `^[A-Z0-9]{4,12}$`',
    `competency_description` STRING COMMENT 'Detailed narrative description of the competency, including the knowledge, skills, and abilities required. Defines what successful demonstration of the competency entails and the context in which it is applied.',
    `competency_name` STRING COMMENT 'Full descriptive name of the competency as recognized across the organization and industry. Examples include Well Control, H2S Safety Awareness, Blowout Preventer (BOP) Operations, Permit to Work (PTW) Authorization.',
    `competency_status` STRING COMMENT 'Current lifecycle status of the competency definition. Active competencies are in use. Inactive competencies are temporarily suspended. Deprecated competencies have been replaced or retired. Under Review indicates pending updates. Draft indicates the competency is being developed.. Valid values are `Active|Inactive|Deprecated|Under Review|Draft`',
    `competency_type` STRING COMMENT 'Classification indicating whether the competency is core (required for all personnel in a role), specialized (required for specific tasks or equipment), mandatory (legally or contractually required), optional (recommended but not required), or certification-based (requires formal external certification).. Valid values are `Core|Specialized|Mandatory|Optional|Certification`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this competency definition record was first created in the system. Used for audit trail and data lineage.',
    `effective_date` DATE COMMENT 'The date on which this competency definition became or will become effective and enforceable. Used to manage competency framework versioning and transition periods.',
    `expiration_date` DATE COMMENT 'The date on which this competency definition expires or is scheduled for retirement. Null indicates no planned expiration. Used to manage competency lifecycle and ensure timely updates.',
    `governing_body_standard` STRING COMMENT 'The external industry body, regulatory agency, or standards organization that defines or certifies this competency. Examples include IADC, OPITO, BOSIET, HUET, IWCF, API, OSHA, BSEE. Multiple standards may be listed if applicable.',
    `hse_critical_flag` BOOLEAN COMMENT 'Indicates whether this competency is classified as HSE-critical, meaning failure to maintain competency could result in serious injury, environmental harm, or major incident. HSE-critical competencies typically have stricter assessment and revalidation requirements.',
    `last_review_date` DATE COMMENT 'The date on which this competency definition was last reviewed and validated by the competency owner or governance body. Used to ensure competency definitions remain current and aligned with industry standards.',
    `modified_by` STRING COMMENT 'The user ID, name, or system identifier of the person or process that last modified this competency definition record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this competency definition record was last modified. Used for audit trail, change tracking, and data lineage.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next review and validation of this competency definition. Ensures periodic updates to reflect changes in technology, regulations, or operational practices.',
    `offshore_manning_requirement_flag` BOOLEAN COMMENT 'Indicates whether this competency is a mandatory requirement for offshore manning and crew certification under OPITO, BOSIET, HUET, or other offshore safety standards. Offshore manning requirements are typically enforced by flag state or host country regulations.',
    `owner` STRING COMMENT 'The organizational unit, department, or role responsible for defining, maintaining, and updating this competency definition. Typically the HSE department, Training department, or a specific technical discipline (Drilling, Production, Engineering).',
    `prerequisite_competencies` STRING COMMENT 'Comma-separated or pipe-separated list of competency codes or names that must be achieved before this competency can be pursued. Defines competency dependencies and learning pathways.',
    `proficiency_level_required` STRING COMMENT 'The minimum proficiency level required for the competency. Awareness indicates basic understanding. Practitioner indicates ability to perform tasks with supervision. Expert indicates independent mastery and ability to train others. Master indicates industry-recognized authority and innovation capability.. Valid values are `Awareness|Practitioner|Expert|Master`',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Indicates whether this competency is mandated by law, regulation, or contractual obligation (True) or is an internal organizational requirement (False). Regulatory mandates typically come from OSHA, BSEE, EPA, or host country regulations.',
    `simops_applicable_flag` BOOLEAN COMMENT 'Indicates whether this competency is required or relevant for personnel involved in Simultaneous Operations (SIMOPS), where multiple high-risk activities occur concurrently on a facility or rig. SIMOPS competencies emphasize coordination, communication, and risk management.',
    `training_duration_hours` DECIMAL(18,2) COMMENT 'The typical or minimum number of training hours required to achieve initial competency. Used for workforce planning, training scheduling, and cost estimation. May include classroom, simulator, and on-the-job training time.',
    `validity_period_months` STRING COMMENT 'The number of months for which the competency certification or assessment remains valid before re-assessment or refresher training is required. Null or zero indicates no expiration. Common values include 12, 24, 36, or 48 months depending on regulatory and operational requirements.',
    `version_number` STRING COMMENT 'Version identifier for the competency definition, following semantic versioning (e.g., 1.0, 2.1). Incremented when competency requirements, assessment methods, or standards are updated.. Valid values are `^[0-9]+.[0-9]+$`',
    `created_by` STRING COMMENT 'The user ID, name, or system identifier of the person or process that created this competency definition record. Used for audit trail and accountability.',
    CONSTRAINT pk_competency PRIMARY KEY(`competency_id`)
) COMMENT 'Master catalog of competency definitions required across Oil Gas operations, including competency code, competency name, competency category (Technical, Safety, Leadership, Regulatory), applicable job roles, assessment method (written exam, practical, simulator), proficiency levels (Awareness/Practitioner/Expert), validity period, and governing body standard (IADC, OPITO, BOSIET, HUET, IWCF). Supports competency framework management and offshore manning compliance by defining the competency requirements that must be assessed and maintained for each role.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` (
    `competency_assessment_id` BIGINT COMMENT 'Unique identifier for the competency assessment event. Primary key for the competency assessment transaction.',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the facility or operational site where the assessment was conducted, particularly relevant for offshore or remote location assessments.',
    `competency_id` BIGINT COMMENT 'Identifier of the specific competency being assessed, such as well control, H2S safety, confined space entry, or equipment operation.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or contractor being assessed for competency. Links to the person being evaluated.',
    `training_program_id` BIGINT COMMENT 'Identifier of the training program or curriculum that this assessment is associated with, linking assessment to formal training activities.',
    `assessment_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting the competency assessment, including assessor fees, materials, facility rental, and administrative overhead, used for labor cost allocation.',
    `assessment_date` DATE COMMENT 'The date on which the competency assessment was conducted. Used for compliance tracking and certification validity periods.',
    `assessment_duration_minutes` STRING COMMENT 'Total duration of the assessment event in minutes, from start to completion, used for scheduling and resource planning.',
    `assessment_language` STRING COMMENT 'Language in which the competency assessment was conducted, using 3-letter ISO 639-2 language codes, important for multinational workforce compliance. [ENUM-REF-CANDIDATE: ENG|SPA|FRA|POR|ARA|RUS|CHI — 7 candidates stripped; promote to reference product]',
    `assessment_location` STRING COMMENT 'Physical or virtual location where the competency assessment was conducted, such as training center, rig site, office, or online platform.',
    `assessment_method` STRING COMMENT 'The method or technique used to evaluate the competency, such as written exam, practical demonstration, simulation, direct observation, oral examination, or portfolio review.. Valid values are `written_exam|practical_demonstration|simulation|observation|oral_examination|portfolio_review`',
    `assessment_notes` STRING COMMENT 'Free-text notes or comments recorded by the assessor regarding the assessment event, including observations, strengths, weaknesses, or areas for improvement.',
    `assessment_number` STRING COMMENT 'Externally-known unique business identifier for the competency assessment event, typically formatted as CA-YYYYMMDD or similar pattern for tracking and audit purposes.. Valid values are `^CA-[0-9]{8}$`',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the assessment event indicating whether it is scheduled, in progress, completed, cancelled, or the assessee did not show.. Valid values are `scheduled|in_progress|completed|cancelled|no_show`',
    `assessment_type` STRING COMMENT 'Classification of the assessment event indicating whether it is an initial certification, recertification, refresher, remedial assessment, spot check, or annual review.. Valid values are `initial|recertification|refresher|remedial|spot_check|annual`',
    `assessment_vendor` STRING COMMENT 'Name of the external vendor or third-party organization that provided the assessment service, if not conducted internally.',
    `assessor_qualification` STRING COMMENT 'Qualification or certification held by the assessor that authorizes them to conduct this specific competency assessment, ensuring assessor competency.',
    `certification_expiry_date` DATE COMMENT 'Expiration date of the issued certification or competency credential, after which recertification or reassessment is required.',
    `certification_issued` BOOLEAN COMMENT 'Boolean flag indicating whether a formal certification or credential was issued to the assessee as a result of passing this assessment.',
    `certification_number` STRING COMMENT 'Unique certification or credential number issued upon successful completion of the competency assessment, used for verification and audit purposes.. Valid values are `^CERT-[A-Z0-9]{10}$`',
    `certification_valid_from_date` DATE COMMENT 'Start date from which the issued certification or competency credential becomes valid and effective.',
    `cost_center` STRING COMMENT 'Cost center or organizational unit to which the assessment cost is allocated, supporting labor cost tracking and budgeting.. Valid values are `^[0-9]{6}$`',
    `created_by_user` STRING COMMENT 'User ID or name of the system user who created this competency assessment record, supporting accountability and audit requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this competency assessment record was first created in the system, supporting audit trail and data lineage.',
    `hse_critical_competency` BOOLEAN COMMENT 'Boolean flag indicating whether this competency is classified as HSE-critical, requiring heightened verification and more frequent reassessment due to safety implications.',
    `modified_by_user` STRING COMMENT 'User ID or name of the system user who last modified this competency assessment record, supporting accountability and audit requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this competency assessment record was last modified or updated, supporting audit trail and change tracking.',
    `next_assessment_due_date` DATE COMMENT 'Scheduled date for the next required competency assessment or recertification event, calculated based on certification validity period and regulatory requirements.',
    `offshore_manning_compliant` BOOLEAN COMMENT 'Boolean flag indicating whether this assessment satisfies offshore manning requirements as mandated by BSEE or other offshore regulatory authorities.',
    `pass_fail_outcome` STRING COMMENT 'Binary or categorical outcome of the assessment indicating whether the assessee passed, failed, conditionally passed, or the assessment was incomplete.. Valid values are `pass|fail|conditional_pass|incomplete`',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to achieve a passing outcome for this specific competency assessment, as defined by the competency standard or regulatory requirement.',
    `proficiency_level` STRING COMMENT 'Qualitative proficiency level achieved by the assessee, categorized as novice, competent, proficient, expert, or master based on demonstrated capability.. Valid values are `novice|competent|proficient|expert|master`',
    `regulatory_reference` STRING COMMENT 'Citation or reference to the specific regulatory requirement, OSHA standard, API recommended practice, or industry guideline that this assessment addresses.',
    `regulatory_requirement_met` BOOLEAN COMMENT 'Boolean flag indicating whether this assessment satisfies a specific regulatory or compliance requirement such as OSHA-mandated training verification or offshore manning certification.',
    `remedial_action_description` STRING COMMENT 'Description of the specific remedial training, coaching, or corrective actions required to address competency gaps identified during the assessment.',
    `remedial_action_required` BOOLEAN COMMENT 'Boolean flag indicating whether remedial training or corrective action is required before the assessee can be reassessed or certified.',
    `score_achieved` DECIMAL(18,2) COMMENT 'Numerical score or percentage achieved by the assessee in the competency assessment, typically on a 0-100 scale or other defined scoring system.',
    `simops_qualified` BOOLEAN COMMENT 'Boolean flag indicating whether this assessment qualifies the assessee for SIMOPS crew coordination roles, critical for offshore and complex operational environments.',
    CONSTRAINT pk_competency_assessment PRIMARY KEY(`competency_assessment_id`)
) COMMENT 'Transactional record of each competency assessment event for an employee or contractor, capturing assessor ID, assessee ID, competency assessed, assessment date, assessment method, score or proficiency level achieved, pass/fail outcome, next assessment due date, and assessor qualification. Supports OSHA-mandated competency verification and offshore manning compliance.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` (
    `workforce_certification_id` BIGINT COMMENT 'Unique identifier for the workforce certification record. Primary key.',
    `competency_id` BIGINT COMMENT 'Foreign key linking to workforce.competency. Business justification: Professional certifications often prove specific competencies from the competency catalog (e.g., BOSIET certification proves offshore survival competency). Adding competency_id FK (nullable) links cer',
    `employee_id` BIGINT COMMENT 'Reference to the employee or contractor who holds this certification. Links to the workforce employee master record.',
    `certificate_number` STRING COMMENT 'The unique certificate or license number issued by the certifying body. This is the externally-known identifier for the certification.',
    `certification_name` STRING COMMENT 'The full descriptive name of the certification or license as it appears on the certificate document.',
    `certification_type` STRING COMMENT 'The type or category of certification held. Examples include BOSIET (Basic Offshore Safety Induction and Emergency Training), HUET (Helicopter Underwater Escape Training), H2S (Hydrogen Sulfide) Awareness, IWCF (International Well Control Forum), IADC (International Association of Drilling Contractors) WellCAP, OSHA (Occupational Safety and Health Administration) 30-Hour, First Aid, Confined Space Entry, Crane Operator, Forklift Operator, Blowout Preventer (BOP) Operator, Measurement While Drilling (MWD) Specialist, Logging While Drilling (LWD) Specialist, Directional Drilling, Well Control, Rig Pass, SafeGulf, SafeLand, Permit to Work (PTW) Authorized, NORM (Naturally Occurring Radioactive Material) Handling, LDAR (Leak Detection and Repair) Technician, Process Safety Management (PSM), Management of Change (MOC) Coordinator, Incident Commander, Emergency Response Team Member, Firefighting, Hazmat Response, Confined Space Rescue, Rigging and Lifting, Scaffolding, Electrical Safety, Lockout/Tagout (LOTO), Fall Protection, Respiratory Protection Fit Test, Defensive Driving, CDL (Commercial Driver License) Class A/B, Tanker Endorsement, TWIC (Transportation Worker Identification Credential), Passport, Visa, Medical Fitness Certificate, Drug and Alcohol Testing Certification. [ENUM-REF-CANDIDATE: BOSIET|HUET|H2S Awareness|IWCF|IADC WellCAP|OSHA 30-Hour|First Aid|Confined Space Entry|Crane Operator|Forklift Operator|BOP Operator|MWD Specialist|LWD Specialist|Directional Drilling|Well Control|Rig Pass|SafeGulf|SafeLand|PTW Authorized|NORM Handling|LDAR Technician|PSM|MOC Coordinator|Incident Commander|ERT Member|Firefighting|Hazmat Response|Confined Space Rescue|Rigging and Lifting|Scaffolding|Electrical Safety|LOTO|Fall Protection|Respiratory Protection|Defensive Driving|CDL Class A|CDL Class B|Tanker Endorsement|TWIC|Passport|Visa|Medical Fitness|Drug and Alcohol Testing — promote to reference product]. Valid values are `BOSIET|HUET|H2S Awareness|IWCF|IADC WellCAP|OSHA 30-Hour`',
    `competency_level` STRING COMMENT 'The proficiency or competency level associated with this certification. Basic indicates foundational knowledge. Intermediate indicates working proficiency. Advanced indicates expert-level skills. Expert indicates mastery and ability to handle complex scenarios. Instructor indicates qualification to train others.. Valid values are `Basic|Intermediate|Advanced|Expert|Instructor`',
    `cost_amount` DECIMAL(18,2) COMMENT 'The total cost incurred to obtain or renew this certification, including training fees, examination fees, travel expenses, and administrative costs. Expressed in the companys reporting currency.',
    `cost_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the cost amount (e.g., USD, GBP, EUR, CAD).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this certification record was first created in the system. Used for audit trail and data lineage tracking.',
    `document_reference` STRING COMMENT 'Reference identifier or file path to the scanned or digital copy of the certification document stored in the document management system.',
    `endorsement_details` STRING COMMENT 'Additional endorsements, specializations, or restrictions associated with the certification. For example, a CDL (Commercial Driver License) may have Tanker or Hazmat endorsements; a Well Control certification may specify pressure rating or equipment type.',
    `expiry_date` DATE COMMENT 'The date on which the certification expires and is no longer valid. Null if the certification does not expire or is valid indefinitely.',
    `facility_applicability` STRING COMMENT 'Comma-separated list or description of facility types or specific facilities where this certification is required. Examples include Offshore Platform, Drilling Rig, FPSO (Floating Production Storage and Offloading), Onshore Production Facility, Refinery, Petrochemical Plant, Pipeline, Terminal, Warehouse, Office.',
    `grace_period_days` STRING COMMENT 'The number of days after the expiry date during which the certification is still considered valid or during which renewal can occur without penalty, as specified by the issuing body or company policy.',
    `hse_critical_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this certification is critical for Health, Safety, and Environment (HSE) compliance and risk management. HSE-critical certifications are prioritized for tracking and renewal.',
    `issue_date` DATE COMMENT 'The date on which the certification was originally issued to the employee or contractor.',
    `issuing_body` STRING COMMENT 'The organization, agency, or institution that issued the certification. Examples include OPITO (Offshore Petroleum Industry Training Organisation), IADC (International Association of Drilling Contractors), IWCF (International Well Control Forum), OSHA (Occupational Safety and Health Administration), American Red Cross, National Safety Council, API (American Petroleum Institute), SPE (Society of Petroleum Engineers), state licensing boards, or accredited training providers.',
    `job_role_applicability` STRING COMMENT 'Comma-separated list or description of job roles, positions, or work assignments for which this certification is required or applicable. Examples include Driller, Derrickhand, Roustabout, Toolpusher, Rig Manager, Production Operator, Maintenance Technician, HSE Coordinator, Well Control Specialist, MWD Engineer, Directional Driller, Crane Operator, Scaffolder, Electrician, Instrumentation Technician, Process Engineer, Refinery Operator, Pipeline Inspector, Truck Driver, Helicopter Pilot, Medic, Emergency Response Team Member.',
    `modified_by` STRING COMMENT 'The user ID or system identifier of the person or process that last modified this certification record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this certification record was last updated. Used for audit trail and change tracking.',
    `next_renewal_due_date` DATE COMMENT 'The date by which the certification must be renewed to maintain continuous validity. Used for proactive renewal planning and compliance tracking.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special conditions, or contextual information about the certification that does not fit into structured fields.',
    `offshore_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this certification is required for offshore operations, including platform, rig, or Floating Production Storage and Offloading (FPSO) assignments.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this certification is mandated by federal, state, or local regulatory authorities (True) or is a voluntary company-required or industry best-practice certification (False).',
    `renewal_date` DATE COMMENT 'The date on which the certification was last renewed or recertified. Null if the certification has never been renewed.',
    `simops_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this certification is required for personnel involved in Simultaneous Operations (SIMOPS), where multiple high-risk activities occur concurrently on the same site or facility.',
    `training_completion_date` DATE COMMENT 'The date on which the employee successfully completed the training program and passed any required examinations or assessments.',
    `training_hours` DECIMAL(18,2) COMMENT 'The total number of training hours required to obtain or maintain this certification, as specified by the issuing body or regulatory authority.',
    `training_location` STRING COMMENT 'The city, state, or facility where the training was conducted. Relevant for tracking training delivery and travel logistics.',
    `training_provider` STRING COMMENT 'The name of the organization or institution that delivered the training program leading to this certification. May be the same as the issuing body or a separate accredited training provider.',
    `verification_date` DATE COMMENT 'The date on which the certification was verified by the employer or third-party verification service.',
    `verification_method` STRING COMMENT 'The method used to verify the authenticity of the certification. Document Review indicates physical or digital certificate inspection. Issuing Body Confirmation indicates direct contact with the certifying organization. Third-Party Service indicates use of a credential verification service. Self-Attestation indicates employee declaration without independent verification. Database Lookup indicates verification through an online registry or database maintained by the issuing body.. Valid values are `Document Review|Issuing Body Confirmation|Third-Party Service|Self-Attestation|Database Lookup`',
    `verification_status` STRING COMMENT 'Indicates whether the certification has been verified with the issuing body or through document review. Verified means the certification authenticity has been confirmed. Pending Verification means verification is in progress. Not Verified means no verification attempt has been made. Verification Failed means the certification could not be authenticated.. Valid values are `Verified|Pending Verification|Not Verified|Verification Failed`',
    `workforce_certification_status` STRING COMMENT 'The current lifecycle status of the certification. Active indicates the certification is valid and current. Expired indicates the certification has passed its expiry date. Suspended indicates temporary suspension by the issuing body or employer. Revoked indicates permanent revocation. Pending Renewal indicates the certification is approaching expiry and renewal is in process. In Progress indicates the employee is currently undergoing training or testing to obtain the certification.. Valid values are `Active|Expired|Suspended|Revoked|Pending Renewal|In Progress`',
    `created_by` STRING COMMENT 'The user ID or system identifier of the person or process that created this certification record.',
    CONSTRAINT pk_workforce_certification PRIMARY KEY(`workforce_certification_id`)
) COMMENT 'Master record of each professional certification, license, or regulatory qualification held by an employee or contractor. Captures certificate type (BOSIET, HUET, H2S Awareness, IWCF, IADC WellCAP, OSHA 30-Hour, First Aid), issuing body, certificate number, issue date, expiry date, renewal status, and verification document reference. Critical for offshore manning compliance and BSEE/OSHA regulatory requirements.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`training_course` (
    `training_course_id` BIGINT COMMENT 'Unique identifier for the training course record. Primary key.',
    `approved_training_provider` STRING COMMENT 'Name of the authorized organization or vendor approved to deliver this training course. May be internal training department or external certified training provider.',
    `assessment_method` STRING COMMENT 'Description of how learner competency is evaluated, including written exams, practical demonstrations, simulator exercises, skills assessments, or observation checklists.',
    `certificate_type` STRING COMMENT 'Type or name of the certificate or credential awarded upon successful completion (e.g., Well Control Certificate, H2S Safety Card, Confined Space Entry Permit, Forklift Operator License).',
    `certification_issued` BOOLEAN COMMENT 'Indicates whether a formal certificate or credential is issued upon successful completion of the training course. True indicates certificate is issued, False indicates completion record only.',
    `competency_level` STRING COMMENT 'The skill or knowledge level that this training course is designed to develop. Awareness provides basic familiarity, Foundation establishes core knowledge, Intermediate builds practical skills, Advanced develops specialized expertise, Expert certifies mastery.. Valid values are `Awareness|Foundation|Intermediate|Advanced|Expert`',
    `continuing_education_credits` DECIMAL(18,2) COMMENT 'Number of continuing education units or professional development hours awarded for completing this training course. Used for professional license maintenance and career development tracking.',
    `cost_per_participant` DECIMAL(18,2) COMMENT 'Standard cost to deliver the training course per participant, including instructor fees, materials, facility rental, and equipment. Used for training budget planning and cost allocation.',
    `course_category` STRING COMMENT 'Primary classification of the training course by subject area. HSE covers Health Safety and Environment training, Technical covers job-specific skills, Leadership covers management development, Regulatory covers mandatory compliance training, Operational covers process and equipment training, Compliance covers legal and policy requirements.. Valid values are `HSE|Technical|Leadership|Regulatory|Operational|Compliance`',
    `course_code` STRING COMMENT 'Unique alphanumeric code assigned to the training course for identification and registration purposes. Used in training management systems and employee records.. Valid values are `^[A-Z0-9]{4,12}$`',
    `course_description` STRING COMMENT 'Detailed description of the training course content, learning objectives, target audience, and prerequisites.',
    `course_materials` STRING COMMENT 'Description of training materials provided to participants, including manuals, workbooks, reference guides, job aids, personal protective equipment, or digital resources.',
    `course_owner` STRING COMMENT 'Name or identifier of the department, functional area, or individual responsible for maintaining the training course content and ensuring its accuracy and relevance.',
    `course_status` STRING COMMENT 'Current lifecycle status of the training course in the catalog. Active indicates available for enrollment, Inactive indicates temporarily unavailable, Under Review indicates content is being updated or audited, Retired indicates no longer offered, Pending Approval indicates awaiting authorization.. Valid values are `Active|Inactive|Under Review|Retired|Pending Approval`',
    `course_subcategory` STRING COMMENT 'Secondary classification providing more granular categorization within the primary course category (e.g., Well Control, Confined Space Entry, Drilling Operations, Emergency Response).',
    `course_title` STRING COMMENT 'Full official title of the training course as it appears in the training catalog and on certificates.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this training course record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost per participant (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `delivery_mode` STRING COMMENT 'Method by which the training course is delivered. Classroom indicates in-person instructor-led training, E-Learning indicates online self-paced modules, Simulator indicates hands-on equipment simulation, OJT (On-the-Job Training) indicates supervised workplace training, Blended indicates combination of methods, Virtual indicates live remote instruction.. Valid values are `Classroom|E-Learning|Simulator|OJT|Blended|Virtual`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total instructional time required to complete the training course, measured in hours. Includes classroom time, practical exercises, and assessments but excludes breaks and travel time.',
    `effective_date` DATE COMMENT 'Date when this training course version became active and available for enrollment in the training catalog.',
    `expiration_date` DATE COMMENT 'Date when this training course version will be retired or replaced. Null indicates no planned expiration.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the training course is mandatory for specific job roles or all employees. True indicates required training, False indicates optional or elective training.',
    `language_offered` STRING COMMENT 'Primary language in which the training course is delivered. Multiple languages may be listed if course is available in multiple languages.',
    `last_review_date` DATE COMMENT 'Date when the training course content was last reviewed for accuracy, regulatory compliance, and alignment with current practices.',
    `learning_management_system_code` STRING COMMENT 'Unique identifier for this training course in the Learning Management System used for enrollment, tracking, and reporting.',
    `maximum_class_size` STRING COMMENT 'Maximum number of participants allowed in a single training session to maintain instructional quality and safety. Null indicates no limit or not applicable for self-paced courses.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this training course record was last updated or modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the training course content to ensure continued accuracy and compliance.',
    `offshore_required` BOOLEAN COMMENT 'Indicates whether this training course is mandatory for personnel working on offshore platforms, rigs, or vessels. True indicates offshore requirement.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to successfully complete the training course, expressed as a percentage (0-100). Learners must achieve this score or higher on assessments to receive certification.',
    `prerequisites` STRING COMMENT 'Required prior training, certifications, experience, or qualifications that participants must have before enrolling in this course. Null indicates no prerequisites.',
    `provider_accreditation` STRING COMMENT 'Accreditation or certification held by the training provider that qualifies them to deliver this course. Examples include IADC accreditation for well control, OPITO approval for offshore training, API certification for technical training.',
    `recertification_required` BOOLEAN COMMENT 'Indicates whether periodic recertification or refresher training is required to maintain competency and compliance. True indicates recertification is mandatory, False indicates one-time training.',
    `regulatory_authority` STRING COMMENT 'The governing body or regulatory agency that mandates or oversees this training requirement. OSHA (Occupational Safety and Health Administration), BSEE (Bureau of Safety and Environmental Enforcement), EPA (Environmental Protection Agency), API (American Petroleum Institute), PHMSA (Pipeline and Hazardous Materials Safety Administration), DOT (Department of Transportation), FERC (Federal Energy Regulatory Commission), State indicates state-level requirements, Internal indicates company policy requirements. [ENUM-REF-CANDIDATE: OSHA|BSEE|EPA|API|PHMSA|DOT|FERC|State|Internal — 9 candidates stripped; promote to reference product]',
    `regulatory_requirement` STRING COMMENT 'Citation of the specific regulatory standard, law, or industry requirement that mandates this training. Examples include OSHA 1910.146 for Confined Space, BSEE SEMS for offshore safety, API RP 54 for well control, EPA SPCC for spill prevention.',
    `simops_applicable` BOOLEAN COMMENT 'Indicates whether this training course is required or recommended for personnel involved in Simultaneous Operations where multiple activities occur concurrently on the same site or facility. True indicates SIMOPS relevance.',
    `subject_matter_expert` STRING COMMENT 'Name or identifier of the technical expert who provides content expertise and validates the accuracy of the training course materials.',
    `target_audience` STRING COMMENT 'Description of the intended participants for this training course, including job roles, experience levels, and functional areas (e.g., Drilling Crew, Production Operators, HSE Coordinators, New Hires, Supervisors).',
    `validity_period_months` STRING COMMENT 'Number of months that the training certification remains valid before recertification or refresher training is required. Null indicates no expiration or one-time training.',
    `version_number` STRING COMMENT 'Version identifier for the training course content, following semantic versioning (e.g., 1.0, 2.1). Incremented when course content, assessments, or requirements are updated.. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_training_course PRIMARY KEY(`training_course_id`)
) COMMENT 'Master catalog of training courses offered or mandated at Oil Gas, including course code, course title, course category (HSE, Technical, Leadership, Regulatory), delivery mode (classroom, e-learning, simulator, OJT), duration hours, mandatory flag, regulatory requirement reference (OSHA, BSEE, EPA), passing score threshold, validity period, and approved training provider. Supports OSHA-mandated training records management.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` (
    `workforce_training_record_id` BIGINT COMMENT 'Unique identifier for the workforce training or HSE site induction record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the facility, rig, plant, or site where the training or site-specific induction was conducted. Null for online or classroom training not tied to a specific operational site.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or contractor who completed the training or induction.',
    `training_course_id` BIGINT COMMENT 'Identifier of the training course or HSE induction program completed.',
    `afe_number` STRING COMMENT 'AFE number authorizing the training expenditure, particularly for project-specific or capital training programs (e.g., new rig commissioning, major turnaround training).',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numeric score achieved by the trainee on the training assessment or competency test, typically expressed as a percentage (0-100). Null if no formal assessment was conducted.',
    `attendance_status` STRING COMMENT 'Attendance status of the trainee for the scheduled training session: Attended (full participation), Absent (did not attend), Partial (attended part of session), Excused (absence approved), Rescheduled (moved to another session).. Valid values are `Attended|Absent|Partial|Excused|Rescheduled`',
    `bsee_site_access_verified_flag` BOOLEAN COMMENT 'Indicates whether this training record has been verified and approved for BSEE offshore site access authorization. True if verified for offshore access, False otherwise.',
    `certificate_issued_flag` BOOLEAN COMMENT 'Indicates whether a training certificate or completion credential was issued to the trainee. True if certificate issued, False otherwise.',
    `certificate_number` STRING COMMENT 'Unique certificate or credential number issued upon successful completion of the training. Null if no certificate was issued.',
    `comments` STRING COMMENT 'Free-text comments or notes regarding the training session, trainee performance, special accommodations, or follow-up actions required.',
    `competency_level_achieved` STRING COMMENT 'Level of competency or proficiency achieved by the trainee upon completion: Awareness (introductory understanding), Basic (foundational skills), Intermediate (working proficiency), Advanced (expert-level skills), Expert (mastery and ability to train others), Certified (formal credential granted).. Valid values are `Awareness|Basic|Intermediate|Advanced|Expert|Certified`',
    `cost_center` STRING COMMENT 'Cost center or business unit to which the training expense is allocated for financial reporting and labor cost tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training record was first created in the system.',
    `delivery_location` STRING COMMENT 'Physical or virtual location where the training was delivered (e.g., Houston Training Center, Offshore Platform A, Online Portal, Refinery Control Room).',
    `delivery_method` STRING COMMENT 'Mode of training delivery: Classroom (in-person lecture), Online (e-learning platform), On-Site (conducted at operational facility), Simulator (rig simulator or process control simulator), Field Demonstration (hands-on at work location), Blended (combination of methods).. Valid values are `Classroom|Online|On-Site|Simulator|Field Demonstration|Blended`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training session in hours, including classroom time, practical exercises, and assessments.',
    `enablon_record_reference` STRING COMMENT 'Reference identifier linking this training record to the corresponding entry in the Enablon HSE Management system for audit trail and compliance reporting.',
    `expiry_date` DATE COMMENT 'Date on which the training certification or competency expires and requires renewal or refresher training. Null for training that does not expire.',
    `instructor_name` STRING COMMENT 'Name of the instructor, induction officer, or HSE coordinator who conducted the training or site induction.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training record was last updated or modified.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this training is mandatory for the employees role or site access. True if mandatory (e.g., OSHA-required, BSEE offshore access, H2S certification for sour gas operations), False if optional or developmental.',
    `osha_record_reference` STRING COMMENT 'Reference number or identifier linking this training record to the OSHA-mandated training log or regulatory filing. Required for OSHA 29 CFR 1910 compliance.',
    `pass_fail_status` STRING COMMENT 'Outcome of the training assessment: Pass (trainee met minimum competency requirements), Fail (trainee did not meet requirements), Incomplete (training not finished), Waived (requirement waived by authority), Not Assessed (no formal assessment conducted).. Valid values are `Pass|Fail|Incomplete|Waived|Not Assessed`',
    `record_status` STRING COMMENT 'Current status of the training record: Active (current and valid), Archived (historical record retained for audit), Superseded (replaced by a newer training record), Voided (invalidated due to error or policy change).. Valid values are `Active|Archived|Superseded|Voided`',
    `refresher_due_date` DATE COMMENT 'Date by which the trainee must complete refresher training to maintain competency or certification. Calculated based on training type and regulatory requirements (e.g., annual H2S refresher, biennial well control recertification).',
    `regulatory_requirement` STRING COMMENT 'Specific regulatory standard or requirement that mandates this training (e.g., OSHA 29 CFR 1910.146 Confined Space Entry, BSEE 30 CFR 250 Subpart O Well Control, API RP 75 SEMS, EPA 40 CFR 68 Process Safety Management). Null if not regulatory-driven.',
    `supervisor_approval_flag` BOOLEAN COMMENT 'Indicates whether the trainees supervisor or line manager has approved and acknowledged the training completion. True if approved, False if pending or not required.',
    `topics_covered` STRING COMMENT 'Comma-separated list or narrative description of topics covered in the training or induction. For HSE inductions: H2S (Hydrogen Sulfide) awareness, NORM (Naturally Occurring Radioactive Material) handling, PTW (Permit to Work) procedures, emergency response, SIMOPS (Simultaneous Operations) protocols, LDAR (Leak Detection and Repair), BOP (Blowout Preventer) operations, confined space entry, fall protection, etc.',
    `training_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for the training session, including instructor fees, materials, facility rental, travel, and per-trainee charges. Expressed in USD.',
    `training_date` DATE COMMENT 'Date on which the training session or induction was completed.',
    `training_language` STRING COMMENT 'Primary language in which the training was delivered (e.g., English, Spanish, Portuguese). Important for multinational operations and contractor workforce compliance.',
    `training_materials_provided` STRING COMMENT 'Description of training materials provided to the trainee (e.g., participant manual, safety data sheets, emergency response guide, online access credentials, USB drive with course content).',
    `training_provider` STRING COMMENT 'Name of the organization or vendor that delivered the training (e.g., external training company, internal HSE department, contractor safety team).',
    `training_type` STRING COMMENT 'Category of training or induction event: HSE Induction (site-specific safety orientation), Technical Competency (job-specific skills), OSHA Mandatory (regulatory-required training), Certification (credential-granting program), Refresher (periodic recertification), SIMOPS (Simultaneous Operations coordination training).. Valid values are `HSE Induction|Technical Competency|OSHA Mandatory|Certification|Refresher|SIMOPS`',
    CONSTRAINT pk_workforce_training_record PRIMARY KEY(`workforce_training_record_id`)
) COMMENT 'Transactional record of each training completion or HSE site induction event for an employee or contractor. Captures course or induction type, training/induction date, training provider or induction officer, delivery location (rig, plant, classroom, online), facility ID for site-specific inductions, topics covered (for inductions: H2S awareness, NORM, PTW, emergency procedures, SIMOPS), score achieved, pass/fail status, certificate issued flag, expiry date, OSHA training record reference number, and Enablon record reference. Serves as the SSOT for OSHA-mandated training records, HSE induction compliance, and BSEE site access verification.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` (
    `crew_schedule_id` BIGINT COMMENT 'Unique identifier for the crew rotation schedule record. Primary key for the crew schedule entity.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the facility where this crew schedule is assigned (offshore platform, FPSO, onshore processing plant, refinery, or drilling rig).',
    `joint_venture_id` BIGINT COMMENT 'Reference to the joint venture or joint operating agreement under which this crew schedule operates. Nullable for wholly-owned operations.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Offshore crew mobilization requires logistics coordinator for helicopter scheduling, vessel transport, helideck manifests, and POB management. Critical link between workforce planning and logistics ex',
    `crew_id` BIGINT COMMENT 'Reference to the relief crew schedule that alternates with this schedule in the rotation pattern. Enables tracking of crew changeover coordination.',
    `rig_id` BIGINT COMMENT 'Reference to the drilling rig or mobile offshore drilling unit (MODU) to which this crew schedule applies. Nullable if schedule is for a fixed facility.',
    `approval_status` STRING COMMENT 'Current approval status of the crew schedule in the workflow process. Indicates whether the schedule has been reviewed and authorized for operational use.. Valid values are `pending|approved|rejected|under_review`',
    `approved_by_user` STRING COMMENT 'User identifier or employee ID of the manager or supervisor who approved this crew schedule. Nullable if schedule is not yet approved.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this crew schedule was approved. Nullable if schedule is not yet approved. Audit trail for approval event.',
    `bed_down_capacity` STRING COMMENT 'Maximum number of personnel that can be accommodated overnight at the facility or rig. Constrains the crew complement size for this schedule.',
    `budget_afe_number` STRING COMMENT 'The AFE number under which crew labor costs for this schedule are authorized and budgeted. Links crew costs to capital or operating expenditure authorization.',
    `created_by_user` STRING COMMENT 'User identifier or employee ID of the person who created this crew schedule record. Supports accountability and audit requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this crew schedule record was first created in the system. Audit trail for record creation.',
    `crew_complement_size` STRING COMMENT 'The total number of personnel positions in the crew complement for this rotation schedule. Represents the full manning requirement for one rotation cycle.',
    `effective_end_date` DATE COMMENT 'The date when this crew rotation schedule ceases to be effective. Nullable for open-ended schedules with no planned termination.',
    `effective_start_date` DATE COMMENT 'The date when this crew rotation schedule becomes effective and operational. Marks the beginning of the schedules validity period.',
    `emergency_response_team_flag` BOOLEAN COMMENT 'Boolean indicator whether this crew schedule includes designated emergency response team members with specialized training for incident response.',
    `hse_certification_required_flag` BOOLEAN COMMENT 'Boolean indicator whether crew members on this schedule must hold current HSE certifications (e.g., BOSIET, HUET, H2S training) as mandated by regulatory requirements.',
    `labor_cost_center` STRING COMMENT 'The cost center code to which labor costs for this crew schedule are allocated for financial tracking and reporting purposes.',
    `last_modified_by_user` STRING COMMENT 'User identifier or employee ID of the person who last modified this crew schedule record. Supports change tracking and audit requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this crew schedule record was last updated. Audit trail for record modification tracking.',
    `minimum_offshore_experience_days` STRING COMMENT 'Minimum number of days of offshore experience required for personnel assigned to this crew schedule. Used to ensure competency requirements are met.',
    `mobilization_location` STRING COMMENT 'The onshore base or heliport location from which crew members mobilize to the offshore facility or rig (e.g., Lafayette Heliport, Aberdeen Base).',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or operational notes related to this crew schedule (e.g., special mobilization requirements, temporary modifications).',
    `operator_company_code` STRING COMMENT 'The company code of the operator responsible for managing this crew schedule. Relevant in joint venture or multi-operator environments.',
    `regulatory_jurisdiction` STRING COMMENT 'The regulatory jurisdiction governing this crew schedule (e.g., US Gulf of Mexico - BSEE, UK North Sea - HSE, Norway - PSA). Determines applicable labor and safety regulations.',
    `rest_days_per_cycle` STRING COMMENT 'Number of consecutive days off in one rotation cycle following the work period (e.g., 28 days off in a 28/28 rotation).',
    `rotation_pattern` STRING COMMENT 'The work-rest rotation pattern expressed in days on/days off format (e.g., 28/28 for 28 days on followed by 28 days off, 14/14, 7/7, 21/21). Defines the cyclical crew rotation schedule.',
    `schedule_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the crew schedule for operational reference and system integration.',
    `schedule_name` STRING COMMENT 'Business name or designation for the crew rotation schedule (e.g., Platform Alpha 28/28 Rotation, FPSO Beta 14/14 Schedule).',
    `schedule_priority` STRING COMMENT 'Numeric priority ranking for this crew schedule used in resource allocation and crew assignment decisions. Lower numbers indicate higher priority.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the crew schedule indicating whether it is actively in use, temporarily suspended, or archived.. Valid values are `active|inactive|draft|suspended|archived`',
    `schedule_type` STRING COMMENT 'Classification of the crew schedule based on the type of operation or facility it supports.. Valid values are `offshore_platform|fpso|drilling_rig|onshore_plant|refinery|construction`',
    `shift_pattern` STRING COMMENT 'Daily shift structure within the rotation (e.g., 12-hour shifts, day/night rotation, 8-hour three-shift). Defines the work schedule within each 24-hour period.',
    `simops_coordination_flag` BOOLEAN COMMENT 'Boolean indicator whether this crew schedule requires SIMOPS coordination due to simultaneous operations at the facility (e.g., drilling and production activities occurring concurrently).',
    `transportation_mode` STRING COMMENT 'Primary mode of transportation used for crew changeover between onshore base and the facility or rig.. Valid values are `helicopter|crew_boat|fixed_wing|road_transport|combination`',
    `union_agreement_code` STRING COMMENT 'Code identifying the collective bargaining agreement or union contract governing labor terms for this crew schedule. Nullable for non-union operations.',
    `weather_contingency_days` STRING COMMENT 'Number of additional days built into the schedule to accommodate weather-related delays in crew changeover transportation.',
    `work_days_per_cycle` STRING COMMENT 'Number of consecutive days worked in one rotation cycle before rest period begins (e.g., 28 days in a 28/28 rotation).',
    CONSTRAINT pk_crew_schedule PRIMARY KEY(`crew_schedule_id`)
) COMMENT 'Master record for crew rotation schedules at offshore platforms, FPSOs, drilling rigs, and onshore processing plants. Captures schedule name, rotation pattern (e.g., 28/28, 14/14, 7/7), start date, end date, facility or rig assignment, crew complement size, relief crew assignment, and SIMOPS coordination flag. Supports offshore manning requirements and SIMOPS crew coordination.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` (
    `crew_assignment_id` BIGINT COMMENT 'Unique identifier for each crew member assignment to a rotation slot on a rig, FPSO, platform, or plant. Primary key for crew assignment tracking and POB reporting.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the rig, FPSO, platform, refinery, or plant where the crew member is assigned. Links to asset master data.',
    `crew_schedule_id` BIGINT COMMENT 'Reference to the crew schedule defining the rotation pattern, shift duration, and manning requirements for this assignment.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or contractor being assigned to the crew rotation. Links to workforce master data for personnel details.',
    `actual_rotation_days` STRING COMMENT 'The actual number of days the crew member spent on the facility during this rotation. May differ from planned due to operational needs or early relief.',
    `assignment_priority` STRING COMMENT 'The priority level of this crew assignment. Critical assignments are for essential personnel; standby assignments are for backup crew members.. Valid values are `CRITICAL|HIGH|NORMAL|STANDBY`',
    `assignment_remarks` STRING COMMENT 'Free-text field for additional notes, special instructions, or operational comments related to this crew assignment. Used for handover information and special considerations.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the crew assignment. Tracks progression from scheduled through mobilization, on-board duty, to demobilization or relief.. Valid values are `SCHEDULED|MOBILIZED|ON_BOARD|DEMOBILIZED|CANCELLED|RELIEVED`',
    `cabin_number` STRING COMMENT 'The accommodation cabin or quarters assigned to the crew member during their rotation. Used for facility management and emergency accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this crew assignment record was first created in the system. Used for audit trail and data lineage tracking.',
    `crew_role_code` STRING COMMENT 'The specific role or position the crew member holds during this assignment. OIM (Offshore Installation Manager), Driller, Toolpusher, Medic, HSE Officer, and other operational roles. [ENUM-REF-CANDIDATE: OIM|DRILLER|TOOLPUSHER|MEDIC|HSE_OFFICER|ROUSTABOUT|DERRICKMAN|MOTORMAN|CRANE_OPERATOR|ELECTRICIAN|MECHANIC|WELDER — 12 candidates stripped; promote to reference product]',
    `demobilization_date` DATE COMMENT 'The date when the crew member is scheduled to demobilize from the facility and return to shore. Used for rotation planning and relief crew coordination.',
    `demobilization_timestamp` TIMESTAMP COMMENT 'The precise date and time when the crew member physically departed the facility. Marks the end of POB status and completion of rotation.',
    `emergency_contact_name` STRING COMMENT 'Full name of the primary emergency contact person to be notified in case of incident or emergency involving the crew member.',
    `emergency_contact_phone` STRING COMMENT 'Primary phone number of the emergency contact person. Must be current and verified for emergency notification purposes.',
    `emergency_contact_relationship` STRING COMMENT 'The relationship of the emergency contact to the crew member (e.g., spouse, parent, sibling). Provides context for emergency communications.',
    `h2s_certification_expiry_date` DATE COMMENT 'The expiration date of the H2S safety certification. Must be renewed before expiry to maintain assignment eligibility in H2S environments.',
    `h2s_certification_flag` BOOLEAN COMMENT 'Indicates whether the crew member holds valid H2S safety certification. Mandatory for assignments in sour gas environments.',
    `helideck_manifest_reference` STRING COMMENT 'Reference number linking this crew assignment to the helicopter flight manifest for mobilization or demobilization. Critical for aviation safety compliance.',
    `hse_induction_completed_flag` BOOLEAN COMMENT 'Indicates whether the crew member has completed the mandatory HSE induction training for the specific facility. Required before starting work.',
    `hse_induction_date` DATE COMMENT 'The date when the crew member completed the HSE induction training for this facility. Used to track training currency and compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this crew assignment record was last updated. Tracks the most recent change for audit and synchronization purposes.',
    `medical_fitness_clearance_date` DATE COMMENT 'The date when the crew member received medical fitness clearance for offshore duty. Must be current and valid before mobilization.',
    `medical_fitness_expiry_date` DATE COMMENT 'The expiration date of the medical fitness certification. Crew member must renew certification before this date to maintain offshore work eligibility.',
    `mobilization_date` DATE COMMENT 'The date when the crew member is scheduled to mobilize to the offshore facility or plant. Used for logistics planning and POB forecasting.',
    `mobilization_timestamp` TIMESTAMP COMMENT 'The precise date and time when the crew member physically arrived and checked in at the facility. Marks the start of POB status.',
    `muster_station_code` STRING COMMENT 'The designated emergency muster station assigned to this crew member on the facility. Critical for emergency response and evacuation procedures.',
    `origin_location` STRING COMMENT 'The departure point or base location from which the crew member mobilizes (e.g., heliport, supply base, airport). Used for logistics coordination.',
    `planned_rotation_days` STRING COMMENT 'The planned duration of this rotation in days (e.g., 14 days on, 21 days on). Defines the expected length of the assignment.',
    `pob_status` STRING COMMENT 'Current POB status indicating whether the crew member is physically on the facility, off-board, or in transit. Critical for emergency muster and regulatory reporting.. Valid values are `ON_BOARD|OFF_BOARD|IN_TRANSIT`',
    `rotation_number` STRING COMMENT 'Sequential number identifying which rotation cycle this assignment represents for the crew member at this facility. Used for tracking rotation history.',
    `simops_clearance_flag` BOOLEAN COMMENT 'Indicates whether the crew member has received clearance and training for SIMOPS activities. Required when multiple operations occur concurrently on the facility.',
    `transport_mode` STRING COMMENT 'The primary mode of transportation used for mobilization and demobilization. Critical for logistics planning and safety compliance.. Valid values are `HELICOPTER|VESSEL|COMMERCIAL_FLIGHT|CREW_BOAT|COMPANY_VEHICLE`',
    `visa_expiry_date` DATE COMMENT 'The expiration date of the work visa or permit required for this assignment. Monitored to ensure continuous legal work authorization.',
    `visa_work_permit_cleared_flag` BOOLEAN COMMENT 'Indicates whether all required visa and work permit clearances have been obtained for this assignment. Must be true before mobilization for international operations.',
    CONSTRAINT pk_crew_assignment PRIMARY KEY(`crew_assignment_id`)
) COMMENT 'Transactional record of each individual crew member assignment to a specific rotation slot on a rig, FPSO, platform, or plant, including mobilization and demobilization lifecycle. Captures employee or contractor ID, crew schedule reference, role on crew (OIM, Driller, Toolpusher, Medic, HSE Officer), mobilization date and time, demobilization date, origin location, transport mode (helicopter, vessel, commercial flight), relief personnel ID, POB (Personnel on Board) status, muster station assignment, emergency contact details, helideck manifest reference, visa/work permit clearance flag, and medical fitness clearance date. Serves as the SSOT for offshore personnel tracking, POB reporting, emergency muster, and BSEE offshore safety compliance. Subsumes mobilization event and POB record tracking.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`pob_record` (
    `pob_record_id` BIGINT COMMENT 'Unique identifier for the Personnel on Board record. Primary key for the POB record entity.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the offshore facility, FPSO (Floating Production Storage and Offloading), drilling rig, or platform where personnel are located.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who recorded or certified this POB count, typically the offshore installation manager or designated safety officer.',
    `bop_certified_count` STRING COMMENT 'Number of personnel certified to operate BOP (Blowout Preventer) systems. Mandatory for drilling operations.',
    `catering_crew_count` STRING COMMENT 'Number of catering, housekeeping, and support services personnel on board.',
    `comments` STRING COMMENT 'Free-text comments or notes regarding this POB record, including explanations for unusual headcount, operational changes, or safety incidents.',
    `contractor_count` STRING COMMENT 'Number of third-party contractor personnel on board. Critical for joint venture billing and HSE (Health Safety and Environment) compliance tracking.',
    `created_by_user` STRING COMMENT 'User identifier or system account that created this POB record. Audit trail field for data governance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this POB record was first created in the system. Audit trail field for data governance and compliance.',
    `drilling_crew_count` STRING COMMENT 'Number of personnel assigned to drilling operations, including drillers, roughnecks, and drilling supervisors.',
    `emergency_contact_verified_flag` BOOLEAN COMMENT 'Indicates whether emergency contact details for all personnel on board have been verified and are current.',
    `employee_count` STRING COMMENT 'Number of direct company employees on board, excluding contractors and visitors.',
    `h2s_qualified_count` STRING COMMENT 'Number of personnel on board who hold current H2S (Hydrogen Sulfide) safety certification. Critical for sour gas operations.',
    `helideck_manifest_reference` STRING COMMENT 'Reference number or identifier linking this POB record to the helideck flight manifest for personnel transport tracking.',
    `hse_personnel_count` STRING COMMENT 'Number of dedicated HSE personnel, safety officers, and medics on board.',
    `joint_venture_partner_count` STRING COMMENT 'Number of personnel representing joint venture partners or non-operating interest holders. Relevant for JOA (Joint Operating Agreement) cost allocation.',
    `lifeboat_capacity` STRING COMMENT 'Total lifeboat and life raft capacity available on the facility. Must meet or exceed total POB count per SOLAS regulations.',
    `maintenance_crew_count` STRING COMMENT 'Number of personnel assigned to maintenance, inspection, and repair activities.',
    `management_count` STRING COMMENT 'Number of management, supervisory, and administrative personnel on board.',
    `max_pob_capacity` STRING COMMENT 'Maximum authorized personnel capacity for the facility as defined in the safety case and facility design specifications.',
    `medical_personnel_on_board_flag` BOOLEAN COMMENT 'Indicates whether qualified medical personnel (medic, paramedic, or physician) are present on the facility.',
    `modified_by_user` STRING COMMENT 'User identifier or system account that last modified this POB record. Audit trail field for tracking changes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this POB record was last modified. Audit trail field for tracking amendments and corrections.',
    `muster_station_assignments` STRING COMMENT 'Comma-separated list or structured reference to muster station assignments for emergency evacuation. Critical for emergency response and BSEE compliance.',
    `offshore_survival_certified_count` STRING COMMENT 'Number of personnel with current offshore survival and sea safety training (BOSIET, HUET, or equivalent).',
    `operational_mode` STRING COMMENT 'Current operational mode of the facility at the time of POB recording. Determines manning requirements and safety protocols. [ENUM-REF-CANDIDATE: normal|drilling|completion|workover|maintenance|shutdown|emergency — 7 candidates stripped; promote to reference product]',
    `pob_date` DATE COMMENT 'The calendar date for which this POB count and manifest is recorded. Critical for daily compliance reporting and emergency response planning.',
    `pob_record_status` STRING COMMENT 'Current lifecycle status of the POB record. Active records represent current headcount; archived records are historical; amended records have been corrected; cancelled records are voided.. Valid values are `active|archived|amended|cancelled`',
    `production_crew_count` STRING COMMENT 'Number of personnel assigned to production operations, including operators, technicians, and production supervisors.',
    `recording_timestamp` TIMESTAMP COMMENT 'The precise date and time when this POB record was captured or submitted. Represents the business event time for compliance audit trails.',
    `regulatory_inspector_present_flag` BOOLEAN COMMENT 'Indicates whether BSEE, BOEM, or other regulatory inspectors are present on the facility during this POB period.',
    `shift_code` STRING COMMENT 'The work shift or rotation schedule during which this POB count was recorded. Supports SIMOPS (Simultaneous Operations) crew coordination and offshore manning requirements.. Valid values are `day|night|swing|rotation_a|rotation_b`',
    `simops_flag` BOOLEAN COMMENT 'Indicates whether SIMOPS (Simultaneous Operations) are being conducted, requiring enhanced crew coordination and safety measures.',
    `total_pob_count` STRING COMMENT 'Total headcount of all personnel present on the facility at the time of recording. Mandatory for BSEE offshore safety compliance and emergency muster verification.',
    `visitor_count` STRING COMMENT 'Number of visitors, auditors, inspectors, or other non-operational personnel on board.',
    `weather_condition` STRING COMMENT 'Weather condition at the time of POB recording. Impacts evacuation planning and personnel safety protocols.. Valid values are `normal|adverse|storm|hurricane`',
    `well_control_certified_count` STRING COMMENT 'Number of personnel holding current well control certification (IWCF or equivalent).',
    CONSTRAINT pk_pob_record PRIMARY KEY(`pob_record_id`)
) COMMENT 'Transactional Personnel on Board (POB) record capturing the real-time and historical headcount at each offshore facility, FPSO, or drilling rig. Records facility ID, date, shift, total POB count, breakdown by role category, muster station assignments, emergency contact details, and helideck manifest reference. Mandatory for BSEE offshore safety compliance and emergency response.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique identifier for the performance review record. Primary key for the performance review entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee being reviewed (reviewee). Links to the employee master record.',
    `reviewer_employee_id` BIGINT COMMENT 'Unique identifier of the employee conducting the review (typically direct supervisor or manager). Links to the employee master record.',
    `bonus_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for performance bonus or incentive compensation based on review results. True if eligible, False otherwise.',
    `collaboration_rating` STRING COMMENT 'Assessment of the employees ability to work effectively with cross-functional teams, support SIMOPS coordination, contribute to joint venture partnerships, and foster collaborative work environment.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding`',
    `collaboration_score` DECIMAL(18,2) COMMENT 'Numeric score for collaboration and teamwork assessment.',
    `created_by_user` STRING COMMENT 'User ID or username of the system user who created the performance review record. Audit trail field for accountability and compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was initially created in the system. Audit trail field for data governance.',
    `development_goals` STRING COMMENT 'Narrative description of professional development goals and objectives established for the employee for the upcoming review period. May include training requirements, skill development targets, certification goals, and career progression milestones.',
    `employee_acknowledgement_date` DATE COMMENT 'Date when the employee acknowledged receipt and review of their performance evaluation. Required for compliance and documentation purposes.',
    `employee_comments` STRING COMMENT 'Self-assessment comments and feedback provided by the employee regarding their own performance, accomplishments, challenges faced, and development needs.',
    `goals_achieved_count` STRING COMMENT 'Number of individual performance goals or objectives successfully achieved during the review period. Used to calculate goal attainment percentage.',
    `goals_total_count` STRING COMMENT 'Total number of individual performance goals or objectives set for the employee during the review period.',
    `hr_approval_date` DATE COMMENT 'Date when the HR department reviewed and approved the performance review. Part of the review governance and quality assurance process.',
    `hse_performance_rating` STRING COMMENT 'Assessment of the employees adherence to HSE policies, safety protocols, incident prevention, environmental stewardship, and contribution to safety culture. Critical metric in oil and gas operations.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding`',
    `hse_performance_score` DECIMAL(18,2) COMMENT 'Numeric score for HSE performance assessment. Weighted heavily in oil and gas performance evaluations due to industry safety criticality.',
    `improvement_areas_summary` STRING COMMENT 'Narrative summary of areas where the employee needs improvement, skill gaps identified, and constructive feedback for performance enhancement.',
    `leadership_rating` STRING COMMENT 'Assessment of the employees leadership capabilities, including team management, decision-making, strategic thinking, and ability to influence and develop others. Not applicable for individual contributor roles without leadership responsibilities.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding|not_applicable`',
    `leadership_score` DECIMAL(18,2) COMMENT 'Numeric score for leadership competency assessment. Null for roles without leadership responsibilities.',
    `merit_increase_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for a merit-based salary increase based on performance rating. True if eligible, False otherwise. Drives compensation planning decisions.',
    `merit_increase_percentage` DECIMAL(18,2) COMMENT 'Recommended percentage increase in base salary as a merit award based on performance. Null if no merit increase is recommended. Confidential compensation data.',
    `modified_by_user` STRING COMMENT 'User ID or username of the system user who last modified the performance review record. Audit trail field for change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was last modified. Audit trail field for tracking changes and data lineage.',
    `operational_excellence_rating` STRING COMMENT 'Assessment of the employees contribution to operational efficiency, process optimization, cost management, production targets, and continuous improvement initiatives.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding`',
    `operational_excellence_score` DECIMAL(18,2) COMMENT 'Numeric score for operational excellence assessment. Reflects contribution to OPEX reduction, production optimization, and operational KPIs.',
    `overall_rating` STRING COMMENT 'Summary performance rating assigned to the employee for the review period. Represents the holistic assessment of employee performance against expectations and objectives.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding`',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric score representing the overall performance rating on a standardized scale (typically 1.00 to 5.00). Used for quantitative analysis and compensation decisions.',
    `pip_required_flag` BOOLEAN COMMENT 'Indicates whether a formal Performance Improvement Plan is required due to unsatisfactory performance. True if PIP is mandated, False otherwise.',
    `promotion_recommended_flag` BOOLEAN COMMENT 'Indicates whether the reviewer recommends the employee for promotion based on performance during the review period. True if promotion is recommended, False otherwise.',
    `review_completion_date` DATE COMMENT 'Date when the performance review was finalized and all approvals were obtained. Marks the official completion of the review cycle.',
    `review_period_end_date` DATE COMMENT 'End date of the performance evaluation period being assessed. Marks the conclusion of the review cycle.',
    `review_period_start_date` DATE COMMENT 'Start date of the performance evaluation period being assessed. Typically the beginning of the fiscal year or the date following the previous review.',
    `review_status` STRING COMMENT 'Current workflow status of the performance review. Tracks the review through its lifecycle from draft creation to final completion and approval.. Valid values are `draft|submitted|manager_review|hr_review|completed|cancelled`',
    `review_type` STRING COMMENT 'Classification of the performance review cycle. Indicates whether this is an annual review, mid-year check-in, probationary period assessment, project-based evaluation, ad-hoc review, or promotion evaluation.. Valid values are `annual|mid_year|probationary|project_based|ad_hoc|promotion`',
    `reviewer_comments` STRING COMMENT 'Detailed narrative comments and observations provided by the reviewer regarding the employees performance, achievements, challenges, and overall contribution during the review period.',
    `strengths_summary` STRING COMMENT 'Narrative summary of the employees key strengths, exceptional contributions, and areas of excellence demonstrated during the review period.',
    `succession_planning_flag` BOOLEAN COMMENT 'Indicates whether the employee has been identified as a candidate for succession planning and leadership pipeline development. True if identified for succession planning, False otherwise.',
    `technical_competency_rating` STRING COMMENT 'Assessment of the employees technical skills and job-specific competencies relevant to their role (e.g., drilling operations, reservoir engineering, process safety, refinery operations).. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding`',
    `technical_competency_score` DECIMAL(18,2) COMMENT 'Numeric score for technical competency assessment on a standardized scale. Supports weighted performance calculations.',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Transactional record of each formal employee performance evaluation cycle, capturing review period, reviewer ID, reviewee ID, overall performance rating, individual KPI scores, competency ratings, development goals, promotion recommendation flag, merit increase eligibility, and review completion date. Supports annual performance management and succession planning processes.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`payroll_record` (
    `payroll_record_id` BIGINT COMMENT 'Unique identifier for each payroll record. Primary key for the payroll transaction.',
    `employee_id` BIGINT COMMENT 'Reference to the employee receiving this payroll payment.',
    `payroll_run_id` BIGINT COMMENT 'Identifier for the batch payroll run that generated this record, used for grouping and reconciliation.. Valid values are `^[A-Z0-9_-]{8,30}$`',
    `bank_account_reference` STRING COMMENT 'Masked or tokenized reference to the employee bank account used for direct deposit. Full account number stored in secure vault.. Valid values are `^[A-Z0-9]{8,34}$`',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'The base salary or hourly wage component for the pay period, excluding overtime and allowances.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Performance-based bonus, safety bonus, production incentive, or other discretionary payments included in this payroll cycle.',
    `cost_center_code` STRING COMMENT 'SAP Controlling (CO) cost center to which this payroll expense is allocated for financial reporting and OPEX tracking.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll record was initially created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this payroll record.. Valid values are `^[A-Z]{3}$`',
    `disability_insurance_premium_amount` DECIMAL(18,2) COMMENT 'Employee portion of short-term or long-term disability insurance premium deducted from gross pay.',
    `expatriate_allowance_amount` DECIMAL(18,2) COMMENT 'Special allowance for employees on international assignments covering cost-of-living adjustments, hardship, and relocation support.',
    `federal_tax_withheld_amount` DECIMAL(18,2) COMMENT 'Federal income tax withheld from gross pay per IRS withholding tables and employee W-4 elections.',
    `garnishment_amount` DECIMAL(18,2) COMMENT 'Court-ordered wage garnishment for child support, tax liens, or other legal obligations deducted from gross pay.',
    `gross_pay_amount` DECIMAL(18,2) COMMENT 'Total gross compensation before any deductions, including base salary, overtime, allowances, and bonuses.',
    `hazard_pay_amount` DECIMAL(18,2) COMMENT 'Additional compensation for employees working in hazardous environments such as H2S zones, high-pressure operations, or SIMOPS scenarios.',
    `health_insurance_premium_amount` DECIMAL(18,2) COMMENT 'Employee portion of health insurance premium deducted from gross pay for medical, dental, and vision coverage.',
    `housing_allowance_amount` DECIMAL(18,2) COMMENT 'Allowance provided to employees for housing expenses, common for expatriate assignments or remote field locations.',
    `job_code` STRING COMMENT 'Standardized job classification code for the employee role during this pay period, used for labor cost analysis and workforce planning.. Valid values are `^[A-Z0-9_-]{4,12}$`',
    `life_insurance_premium_amount` DECIMAL(18,2) COMMENT 'Employee portion of life insurance premium deducted from gross pay.',
    `medicare_tax_amount` DECIMAL(18,2) COMMENT 'Employee portion of Medicare tax withheld from gross pay.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll record was last modified or updated.',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'Final take-home pay after all deductions, representing the amount deposited to employee bank account or issued as check.',
    `offshore_allowance_amount` DECIMAL(18,2) COMMENT 'Allowance paid to employees working on offshore platforms, rigs, or FPSO vessels to compensate for remote and hazardous working conditions.',
    `other_deductions_amount` DECIMAL(18,2) COMMENT 'Miscellaneous deductions including charitable contributions, loan repayments, or other voluntary withholdings.',
    `overtime_hours_worked` DECIMAL(18,2) COMMENT 'Total number of overtime hours worked during the pay period, subject to premium pay rates.',
    `overtime_pay_amount` DECIMAL(18,2) COMMENT 'Total overtime compensation paid for hours worked beyond standard work schedule.',
    `payment_date` DATE COMMENT 'The date on which the payroll payment was issued or deposited to the employee.',
    `payment_method` STRING COMMENT 'Method by which net pay is disbursed to the employee.. Valid values are `direct_deposit|check|cash|wire_transfer`',
    `payroll_document_number` STRING COMMENT 'SAP payroll document number or external payroll system reference identifier for traceability and audit.. Valid values are `^[A-Z0-9]{10,20}$`',
    `payroll_period_end_date` DATE COMMENT 'The last day of the pay period covered by this payroll record.',
    `payroll_period_start_date` DATE COMMENT 'The first day of the pay period covered by this payroll record.',
    `payroll_status` STRING COMMENT 'Current processing status of this payroll record in the payroll workflow lifecycle.. Valid values are `draft|approved|paid|voided|reversed`',
    `pension_contribution_amount` DECIMAL(18,2) COMMENT 'Employee contribution to defined benefit pension plan or 401(k) retirement savings plan deducted from gross pay.',
    `regular_hours_worked` DECIMAL(18,2) COMMENT 'Total number of regular (non-overtime) hours worked during the pay period.',
    `shift_differential_amount` DECIMAL(18,2) COMMENT 'Premium pay for employees working non-standard shifts such as night shifts, rotating shifts, or 24/7 operations common in refining and production facilities.',
    `social_security_tax_amount` DECIMAL(18,2) COMMENT 'Employee portion of Social Security (FICA) tax withheld from gross pay.',
    `state_tax_withheld_amount` DECIMAL(18,2) COMMENT 'State income tax withheld from gross pay per state tax regulations.',
    `total_deductions_amount` DECIMAL(18,2) COMMENT 'Sum of all deductions including taxes, benefits, and other withholdings subtracted from gross pay.',
    `transport_allowance_amount` DECIMAL(18,2) COMMENT 'Allowance for transportation costs including commuting, helicopter transport to offshore rigs, or company vehicle usage.',
    `union_dues_amount` DECIMAL(18,2) COMMENT 'Union membership dues deducted from gross pay per collective bargaining agreement.',
    `work_location_code` STRING COMMENT 'Code identifying the primary work location for this pay period such as offshore platform, refinery, field office, or drilling rig.. Valid values are `^[A-Z0-9_-]{3,15}$`',
    `year_to_date_gross_pay` DECIMAL(18,2) COMMENT 'Cumulative gross pay for the employee from the beginning of the calendar or fiscal year through this pay period, used for tax reporting.',
    `year_to_date_tax_withheld` DECIMAL(18,2) COMMENT 'Cumulative federal and state tax withheld for the employee from the beginning of the calendar or fiscal year through this pay period.',
    CONSTRAINT pk_payroll_record PRIMARY KEY(`payroll_record_id`)
) COMMENT 'Transactional payroll and compensation record for each employee pay period, capturing gross pay, net pay, base salary, overtime hours and pay, shift differentials (offshore allowance, hazard pay), deductions (tax, pension, health insurance), allowances (housing, transport, expatriate), payroll period, payment date, bank account reference, and SAP payroll document number. Includes benefit enrollment details: benefit plan type (medical, dental, vision, pension, life insurance, disability), coverage tier, premium amount, employer and employee contributions, effective and termination dates, and benefit provider reference. Serves as the SSOT for total compensation, labor cost actuals, and benefits administration.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` (
    `labor_cost_allocation_id` BIGINT COMMENT 'Unique identifier for the labor cost allocation record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the facility (platform, plant, terminal) for which labor costs are allocated. Used for facility operations and maintenance.',
    `contractor_id` BIGINT COMMENT 'Reference to the contractor whose labor cost is being allocated. Nullable when allocation is for an employee.',
    `employee_id` BIGINT COMMENT 'Reference to the employee whose labor cost is being allocated. Links to the employee master record.',
    `original_allocation_labor_cost_allocation_id` BIGINT COMMENT 'Reference to the original labor cost allocation record that this record reverses or adjusts. Nullable for original allocations.',
    `psa_id` BIGINT COMMENT 'Reference to the production sharing agreement under which labor costs are allocated. Used for international operations with host governments.',
    `well_asset_id` BIGINT COMMENT 'Reference to the well asset for which labor costs are being allocated. Used for production operations and well maintenance activities.',
    `activity_type` STRING COMMENT 'Type of work activity performed during the allocated hours. Used for activity-based costing and operational analysis. [ENUM-REF-CANDIDATE: Drilling|Completion|Production|Maintenance|Construction|Engineering|HSE|Administrative — 8 candidates stripped; promote to reference product]',
    `afe_number` STRING COMMENT 'AFE number for well or drilling project to which labor costs are allocated. Primary cost tracking mechanism for capital drilling and completion activities.',
    `allocated_cost_amount` DECIMAL(18,2) COMMENT 'Portion of the total labor cost allocated to this cost object, calculated as total cost multiplied by allocation percentage.',
    `allocation_date` DATE COMMENT 'Date when the labor cost allocation was posted to the accounting system. Represents the business event timestamp for this transaction.',
    `allocation_number` STRING COMMENT 'Business identifier for the labor cost allocation transaction. Externally visible reference number used in reporting and reconciliation.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total labor cost allocated to this specific cost object. Used when labor is split across multiple cost objects.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the labor cost allocation record. Tracks the approval and posting workflow.. Valid values are `Draft|Posted|Approved|Reversed|Cancelled`',
    `approval_date` DATE COMMENT 'Date when the labor cost allocation was approved by the authorized manager or cost controller.',
    `approved_by_user` STRING COMMENT 'User ID of the person who approved the labor cost allocation. Used for audit trail and SOX compliance.',
    `business_area` STRING COMMENT 'Business area or segment (e.g., Upstream, Midstream, Downstream) to which the labor cost is allocated. Used for segment reporting.',
    `capitalized_flag` BOOLEAN COMMENT 'Indicates whether the labor cost is capitalized (CAPEX) or expensed (OPEX). Determines financial statement treatment and depreciation.',
    `co_document_number` STRING COMMENT 'SAP CO document number generated when the allocation was posted. Provides audit trail to source financial transaction.',
    `comments` STRING COMMENT 'Free-text comments or notes regarding the labor cost allocation. Used for explanations, justifications, or special instructions.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity incurring the labor cost. Used for statutory reporting and intercompany reconciliation.',
    `cost_center_code` STRING COMMENT 'Cost center code to which labor costs are allocated. Used for operational expense (OPEX) tracking and departmental cost management.',
    `cost_object_type` STRING COMMENT 'Type of cost object to which labor costs are being allocated. Determines the accounting treatment and reporting structure.. Valid values are `AFE|WBS|Cost Center|Internal Order|Project|Production Sharing Agreement`',
    `cost_rate` DECIMAL(18,2) COMMENT 'Hourly cost rate applied to calculate the total labor cost. Includes base wage plus burden (benefits, taxes, overhead).',
    `created_by_user` STRING COMMENT 'User ID of the person who created the labor cost allocation record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the labor cost allocation record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amount (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the labor cost allocation belongs. Used for annual budgeting and financial reporting.',
    `hours_worked` DECIMAL(18,2) COMMENT 'Total number of hours worked by the employee or contractor during the pay period that are being allocated to the cost object.',
    `internal_order_number` STRING COMMENT 'Internal order number for specific work orders or maintenance activities. Used for tracking discrete operational tasks.',
    `jv_partner_code` STRING COMMENT 'Code identifying the joint venture partner to whom a portion of labor costs should be billed. Used in Joint Interest Billing (JIB) processes.',
    `jv_share_percentage` DECIMAL(18,2) COMMENT 'Percentage share of labor costs allocated to the joint venture partner based on working interest or production sharing agreement terms.',
    `loe_category` STRING COMMENT 'Classification of labor cost within lease operating expense structure. Used for production cost analysis and SEC reporting.. Valid values are `Direct|Indirect|Overhead|G&A`',
    `modified_by_user` STRING COMMENT 'User ID of the person who last modified the labor cost allocation record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the labor cost allocation record was last modified. Used for audit trail and change tracking.',
    `offshore_flag` BOOLEAN COMMENT 'Indicates whether the work was performed at an offshore location. Used for premium pay calculations and regulatory reporting.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours worked during the pay period, typically hours exceeding standard work schedule.',
    `pay_period_end_date` DATE COMMENT 'End date of the pay period for which labor costs are being allocated.',
    `pay_period_start_date` DATE COMMENT 'Start date of the pay period for which labor costs are being allocated.',
    `posting_period` STRING COMMENT 'Fiscal period (YYYYMM format) to which the labor cost allocation is posted. Used for period-based financial reporting.. Valid values are `^[0-9]{6}$`',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of regular hours worked during the pay period, excluding overtime and premium hours.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this allocation record is a reversal of a previous allocation. Used for correction and adjustment tracking.',
    `total_cost_amount` DECIMAL(18,2) COMMENT 'Total labor cost amount being allocated. Calculated as hours worked multiplied by cost rate.',
    `wbs_element` STRING COMMENT 'WBS element code for project-based cost allocation. Used for capital projects and major initiatives tracked in SAP PS module.',
    `work_location` STRING COMMENT 'Physical location where the work was performed (e.g., rig name, platform, office, field). Used for geographic cost tracking and SIMOPS coordination.',
    CONSTRAINT pk_labor_cost_allocation PRIMARY KEY(`labor_cost_allocation_id`)
) COMMENT 'Transactional record allocating employee and contractor labor costs to specific cost objects including wells (AFE), projects, cost centers, joint venture partners (JIB), and production sharing agreements. Captures employee or contractor ID, pay period, hours worked, cost rate, total cost, allocation percentage, WBS element, AFE number, JV partner share, and SAP CO document reference. Supports LOE tracking and JIB cost allocation per COPAS standards.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Unique identifier for each benefit enrollment record. Primary key for the benefit enrollment transaction.',
    `plan_id` BIGINT COMMENT 'Reference to the specific benefit plan in which the employee is enrolling. Links to the benefit plan master record.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is enrolling in the benefit plan. Links to the employee master record.',
    `approval_status` STRING COMMENT 'Administrative approval status for the enrollment, particularly for special enrollments or qualifying life events that require HR review and documentation.. Valid values are `pending_approval|approved|rejected|requires_documentation`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the enrollment was approved by HR or the system. Nullable if approval is not required or still pending.',
    `approved_by_user` STRING COMMENT 'User ID or name of the HR representative or system user who approved the enrollment. Nullable if approval is not required or still pending.',
    `benefit_plan_type` STRING COMMENT 'Category of benefit plan being enrolled in. Classifies the type of coverage or benefit provided to the employee. [ENUM-REF-CANDIDATE: medical|dental|vision|life_insurance|disability|pension|retirement_401k|hsa|fsa — 9 candidates stripped; promote to reference product]',
    `benefit_provider_name` STRING COMMENT 'Name of the insurance carrier or benefit provider administering the plan. Used for claims processing and provider coordination.',
    `certificate_number` STRING COMMENT 'Individual certificate of coverage number issued to the employee by the benefit provider. Unique identifier for the employees coverage under the group policy.',
    `cobra_eligible_flag` BOOLEAN COMMENT 'Indicates whether this enrollment is eligible for COBRA continuation coverage upon termination of employment. True if eligible, False otherwise.',
    `cobra_start_date` DATE COMMENT 'Date when COBRA continuation coverage begins if the employee elects to continue coverage after employment termination. Nullable if not applicable.',
    `contribution_frequency` STRING COMMENT 'Frequency at which premium contributions are deducted from employee pay and remitted to the benefit provider. Aligns with payroll cycle.. Valid values are `weekly|biweekly|semimonthly|monthly|quarterly|annual`',
    `cost_center_code` STRING COMMENT 'Cost center to which the employer benefit contribution expense is allocated. Used for financial reporting and labor cost allocation.',
    `coverage_tier` STRING COMMENT 'Level of coverage elected by the employee, indicating who is covered under the benefit plan (employee only, employee plus dependents, or full family).. Valid values are `employee_only|employee_spouse|employee_children|employee_family`',
    `created_by_user` STRING COMMENT 'User ID or name of the person or system process that created this enrollment record. Audit trail for accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this enrollment record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this enrollment record. Supports multi-currency payroll operations.. Valid values are `USD|CAD|MXN|EUR|GBP|AUD`',
    `dependent_count` STRING COMMENT 'Number of dependents covered under this benefit enrollment. Used for premium calculation and coverage tier validation.',
    `effective_end_date` DATE COMMENT 'Date when the benefit coverage terminates or expires. Nullable for ongoing enrollments. Marks the end of the coverage period.',
    `effective_start_date` DATE COMMENT 'Date when the benefit coverage becomes active and the employee is eligible to use the benefit. Marks the beginning of the coverage period.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Amount deducted from the employee paycheck for the benefit premium per pay period. Represents the employee-funded portion of the benefit cost.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Amount contributed by the employer toward the benefit premium per pay period. Represents the company-funded portion of the benefit cost.',
    `enrollment_date` DATE COMMENT 'Date when the employee submitted the benefit enrollment election. Represents the business event timestamp for this enrollment transaction.',
    `enrollment_method` STRING COMMENT 'Channel or method through which the employee submitted the benefit enrollment election. Tracks enrollment process efficiency.. Valid values are `online_portal|paper_form|phone|hr_representative|open_enrollment|new_hire`',
    `enrollment_number` STRING COMMENT 'Business-facing unique enrollment confirmation number provided to the employee for reference and tracking purposes.',
    `enrollment_period_type` STRING COMMENT 'Type of enrollment period during which the employee made the election. Determines eligibility and timing rules for the enrollment.. Valid values are `open_enrollment|new_hire|qualifying_life_event|special_enrollment|annual_enrollment`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the benefit enrollment. Tracks the enrollment from initial submission through active coverage to termination.. Valid values are `pending|active|suspended|terminated|cancelled|expired`',
    `modified_by_user` STRING COMMENT 'User ID or name of the person or system process that last modified this enrollment record. Audit trail for accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this enrollment record was last modified. Audit trail for record updates and changes.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the enrollment, including special circumstances, documentation requirements, or administrative actions taken.',
    `policy_number` STRING COMMENT 'Insurance policy or contract number assigned by the benefit provider for this enrollment. Used for claims submission and provider communication.',
    `premium_amount` DECIMAL(18,2) COMMENT 'Total premium amount for the benefit plan coverage per pay period. Represents the full cost of the benefit before employer and employee contribution split.',
    `qualifying_event_date` DATE COMMENT 'Date when the qualifying life event occurred that allowed the employee to enroll outside the standard enrollment period. Nullable if not applicable.',
    `qualifying_event_type` STRING COMMENT 'Type of qualifying life event that triggered a special enrollment period outside of the standard open enrollment window. Nullable if not applicable. [ENUM-REF-CANDIDATE: marriage|birth|adoption|divorce|death|loss_of_coverage|employment_change — 7 candidates stripped; promote to reference product]',
    `termination_date` DATE COMMENT 'Date when the enrollment was formally terminated, either by employee action, employment termination, or administrative action. May differ from effective_end_date.',
    `termination_reason` STRING COMMENT 'Reason code explaining why the benefit enrollment was terminated. Used for benefits administration analysis and compliance reporting. [ENUM-REF-CANDIDATE: employee_resignation|employment_termination|plan_change|life_event|cost|retirement|death — 7 candidates stripped; promote to reference product]',
    `waiver_flag` BOOLEAN COMMENT 'Indicates whether the employee explicitly waived or declined this benefit offering. True if waived, False if enrolled.',
    `waiver_reason` STRING COMMENT 'Reason provided by the employee for waiving or declining the benefit. Nullable if waiver_flag is False. Used for benefits strategy analysis.. Valid values are `spouse_coverage|other_insurance|cost|not_needed|medicare|medicaid`',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Transactional record of each employee benefit plan enrollment, capturing benefit plan type (medical, dental, vision, pension, life insurance, disability), enrollment date, coverage tier (employee only, employee+spouse, family), premium amount, employer contribution, employee contribution, effective date, termination date, and benefit provider reference. Supports HR benefits administration.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique identifier for the leave request record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or supervisor who approved or rejected the leave request. Links to the employee master record.',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the facility, rig, or offshore platform from which the employee is taking leave. Relevant for offshore rotation leave and manning gap analysis. Null for onshore employees.',
    `primary_leave_employee_id` BIGINT COMMENT 'Identifier of the employee submitting the leave request. Links to the employee master record.',
    `actual_days_taken` DECIMAL(18,2) COMMENT 'The actual number of leave days taken, which may differ from the requested number due to early return, extension, or partial-day adjustments.',
    `actual_end_date` DATE COMMENT 'The actual last date the employee was absent, which may differ from the requested end date due to early return or extended leave.',
    `actual_start_date` DATE COMMENT 'The actual first date the employee was absent, which may differ from the requested start date due to operational changes or early departure.',
    `afe_number` STRING COMMENT 'The AFE number to which labor costs during the leave period are charged, particularly relevant for project-based or joint venture operations.. Valid values are `^AFE-[A-Z0-9]{8,12}$`',
    `approval_date` DATE COMMENT 'The date on which the leave request was approved or rejected by the approver.',
    `comments` STRING COMMENT 'Additional free-text comments or notes related to the leave request, entered by the employee, approver, or HR administrator.',
    `cost_center_code` STRING COMMENT 'The cost center to which the employees leave time and any associated costs (e.g., replacement labor) are allocated for financial reporting.. Valid values are `^[A-Z0-9]{6,10}$`',
    `created_by_user` STRING COMMENT 'The username or user ID of the person who created the leave request record (typically the employee or an HR administrator acting on their behalf).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the leave request record was first created in the system.',
    `hse_clearance_date` DATE COMMENT 'The date on which the employee received HSE medical clearance to return to work following leave. Null if clearance is not required or not yet obtained.',
    `hse_clearance_required_flag` BOOLEAN COMMENT 'Indicates whether HSE medical clearance or fitness-for-duty assessment is required before the employee returns from leave (True) or not (False). Typically required for extended sick leave or offshore rotation leave.',
    `leave_balance_after` DECIMAL(18,2) COMMENT 'The employees remaining leave balance (in days) for the specified leave type after this request is approved and deducted. Used for balance tracking and future leave eligibility checks.',
    `leave_balance_before` DECIMAL(18,2) COMMENT 'The employees available leave balance (in days) for the specified leave type immediately before this request was approved. Used for audit trail and balance reconciliation.',
    `leave_type` STRING COMMENT 'Classification of the leave request: annual leave, sick leave, maternity/paternity leave, offshore rotation leave, rest and recuperation (R&R), emergency leave, unpaid leave, Family and Medical Leave Act (FMLA) leave, or bereavement leave. [ENUM-REF-CANDIDATE: annual|sick|maternity|paternity|offshore_rotation|r_and_r|emergency|unpaid|fmla|bereavement — 10 candidates stripped; promote to reference product]',
    `modified_by_user` STRING COMMENT 'The username or user ID of the person who last modified the leave request record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the leave request record was last modified or updated.',
    `number_of_days` DECIMAL(18,2) COMMENT 'Total number of leave days requested, including partial days (e.g., 5.5 days for half-day leave). Calculated based on working days excluding weekends and public holidays.',
    `offshore_rotation_flag` BOOLEAN COMMENT 'Indicates whether this leave request is part of a scheduled offshore rotation cycle (True) or ad-hoc leave (False). Used for crew rotation planning and SIMOPS coordination.',
    `pay_impact_flag` BOOLEAN COMMENT 'Indicates whether this leave request impacts the employees pay (True for unpaid leave or leave without sufficient balance) or is fully paid (False).',
    `rejection_reason` STRING COMMENT 'Free-text explanation provided by the approver when rejecting a leave request. Null if the request was approved.',
    `replacement_required_flag` BOOLEAN COMMENT 'Indicates whether a temporary replacement or backfill is required to maintain minimum manning levels during the leave period (True) or not (False). Critical for offshore operations and HSE compliance.',
    `request_date` DATE COMMENT 'The date on which the employee submitted the leave request.',
    `request_reason` STRING COMMENT 'Optional free-text explanation provided by the employee describing the reason for the leave request (e.g., personal travel, medical appointment, family emergency).',
    `request_status` STRING COMMENT 'Current lifecycle status of the leave request: draft (not yet submitted), submitted (awaiting review), pending approval (under manager review), approved (granted), rejected (denied), cancelled (system cancelled), or withdrawn (employee retracted). [ENUM-REF-CANDIDATE: draft|submitted|pending_approval|approved|rejected|cancelled|withdrawn — 7 candidates stripped; promote to reference product]',
    `requested_end_date` DATE COMMENT 'The last date of the requested leave period.',
    `requested_start_date` DATE COMMENT 'The first date of the requested leave period.',
    `sap_absence_document_number` STRING COMMENT 'The SAP HR absence document reference number generated upon leave request submission or approval in SAP S/4HANA HCM.. Valid values are `^[A-Z0-9]{10}$`',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Transactional record of each employee leave request and approval, capturing leave type (annual, sick, maternity/paternity, offshore rotation leave, R&R, emergency, unpaid, FMLA), requested start date, end date, number of days, approval status, approver ID, leave balance before and after, and SAP absence document reference. Supports crew rotation planning, offshore manning gap analysis, and ensures minimum manning levels are maintained during leave periods.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` (
    `mobilization_event_id` BIGINT COMMENT 'Unique identifier for each personnel mobilization or demobilization event. Primary key for the mobilization event record.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the target facility where personnel is being deployed. May be a rig, Floating Production Storage and Offloading (FPSO) vessel, offshore platform, onshore plant, refinery, or remote field location.',
    `contractor_id` BIGINT COMMENT 'Reference to the contractor being mobilized or demobilized. Links to the contractor master record for contingent workforce.',
    `employee_id` BIGINT COMMENT 'Reference to the employee being mobilized or demobilized. Links to the employee master record for permanent workforce.',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time of arrival at the destination facility. Marks the official start of the work assignment for time tracking and labor cost allocation purposes.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual date and time of departure from the origin location. Captured for operational tracking, delay analysis, and Non-Productive Time (NPT) reporting.',
    `afe_number` STRING COMMENT 'Authorization for Expenditure (AFE) number under which the mobilization and assignment costs are authorized and tracked. Used for Joint Interest Billing (JIB) and partner cost allocation in joint ventures.',
    `assignment_duration_days` STRING COMMENT 'Planned or actual number of days the personnel is assigned to the destination facility. Common rotation schedules include 14/14, 21/21, 28/28 (days on/days off) for offshore operations.',
    `cost_center_code` STRING COMMENT 'Cost center to which the mobilization event costs and subsequent labor costs will be charged. Used for Lease Operating Expense (LOE) tracking and Capital Expenditure (CAPEX) versus Operating Expenditure (OPEX) allocation.',
    `created_by_user` STRING COMMENT 'User identifier or system account that created the mobilization event record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the mobilization event record was first created in the system. Used for audit trail and data lineage tracking.',
    `demobilization_date` DATE COMMENT 'Planned or actual date when the personnel is scheduled to or did depart from the work assignment and return to origin. Used for rotation planning and crew replacement scheduling.',
    `destination_facility_name` STRING COMMENT 'Human-readable name of the destination facility. Includes rig name, platform designation, FPSO vessel name, or plant name for operational reference.',
    `destination_facility_type` STRING COMMENT 'Classification of the destination facility type. Determines applicable Health Safety and Environment (HSE) requirements, manning standards, and logistical protocols. [ENUM-REF-CANDIDATE: offshore_platform|fpso|drilling_rig|onshore_plant|refinery|petrochemical_plant|pipeline_station|remote_field_site|support_vessel — 9 candidates stripped; promote to reference product]',
    `event_status` STRING COMMENT 'Current lifecycle status of the mobilization event. Tracks the progression from planning through execution to completion or cancellation. [ENUM-REF-CANDIDATE: planned|confirmed|in_transit|completed|cancelled|delayed|aborted — 7 candidates stripped; promote to reference product]',
    `event_type` STRING COMMENT 'Classification of the personnel movement event. Mobilization indicates deployment to a work location; demobilization indicates return from assignment; rotation change indicates scheduled crew rotation; emergency evacuation indicates unplanned removal due to safety incident; medical evacuation indicates removal for health reasons; crew change indicates routine personnel swap during Simultaneous Operations (SIMOPS).. Valid values are `mobilization|demobilization|rotation_change|emergency_evacuation|medical_evacuation|crew_change`',
    `flight_vessel_number` STRING COMMENT 'Flight number, vessel name, or helicopter tail number used for the transport leg. Enables tracking and coordination with transport operations.',
    `h2s_training_expiry_date` DATE COMMENT 'Date when the H2S training certification expires. Typically valid for 2-3 years depending on jurisdiction and company policy.',
    `h2s_training_status` STRING COMMENT 'Current status of Hydrogen Sulfide (H2S) awareness and safety training certification. Required for personnel working in sour gas environments where H2S exposure risk exists.. Valid values are `valid|expired|not_required|pending`',
    `hse_induction_completion_date` DATE COMMENT 'Date when the site-specific HSE induction training was completed. Recorded in Enablon HSE Management system for compliance audit trail.',
    `hse_induction_completion_flag` BOOLEAN COMMENT 'Boolean indicator whether the personnel has completed the mandatory Health Safety and Environment (HSE) site-specific induction training for the destination facility. Required before personnel can commence work.',
    `medical_clearance_date` DATE COMMENT 'Date when medical fitness clearance was granted by occupational health physician. Establishes the baseline for fitness validity period.',
    `medical_clearance_expiry_date` DATE COMMENT 'Date when the medical fitness clearance expires and re-examination is required. Typically annual or biennial depending on age, role, and jurisdiction.',
    `medical_fitness_status` STRING COMMENT 'Current medical fitness clearance status for the work assignment. Offshore and remote assignments typically require medical examination to ensure personnel can safely perform duties and respond to emergencies.. Valid values are `fit|fit_with_restrictions|unfit|pending|expired`',
    `mobilization_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for the mobilization event, including transportation, accommodation, per diem, and administrative costs. Captured for cost tracking and Joint Interest Billing (JIB) allocation.',
    `mobilization_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the mobilization cost amount. Required for multi-currency operations and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `modified_by_user` STRING COMMENT 'User identifier or system account that last modified the mobilization event record. Used for audit trail and change accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the mobilization event record was last modified. Used for audit trail, change tracking, and data quality monitoring.',
    `offshore_survival_training_expiry_date` DATE COMMENT 'Date when the offshore survival training certification expires. Typically valid for 4 years; personnel cannot mobilize offshore with expired certification.',
    `offshore_survival_training_status` STRING COMMENT 'Current status of offshore survival and emergency response training certification. Mandatory for personnel mobilizing to offshore platforms, rigs, and Floating Production Storage and Offloading (FPSO) vessels. Includes Basic Offshore Safety Induction and Emergency Training (BOSIET) or equivalent.. Valid values are `valid|expired|not_required|pending`',
    `origin_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the origin location. Used for visa, work permit, and cross-border labor regulation compliance.. Valid values are `^[A-Z]{3}$`',
    `origin_location` STRING COMMENT 'Departure location for the mobilization event. May be a city, airport code, heliport, or facility name from which the personnel is departing.',
    `ptw_authorization_level` STRING COMMENT 'Level of Permit to Work (PTW) authorization granted to the personnel for the destination facility. Determines what types of work permits the individual can request, issue, or approve. Critical for Management of Change (MOC) and safe work execution.. Valid values are `none|basic|advanced|issuing_authority|approving_authority`',
    `rotation_schedule_pattern` STRING COMMENT 'Standard rotation pattern for the assignment, expressed as days-on/days-off (e.g., 14/14, 21/21, 28/28). Determines crew change frequency and manning requirements.',
    `scheduled_arrival_timestamp` TIMESTAMP COMMENT 'Planned date and time of arrival at the destination facility. Used for crew handover planning and facility manning coordination.',
    `scheduled_departure_timestamp` TIMESTAMP COMMENT 'Planned date and time of departure from the origin location. Used for crew scheduling, transport coordination, and Simultaneous Operations (SIMOPS) planning.',
    `transport_mode` STRING COMMENT 'Primary method of transportation used for the mobilization event. Helicopter and crew boat are common for offshore; commercial and charter flights for international; ground transport for onshore; multi-modal indicates combination of methods. [ENUM-REF-CANDIDATE: helicopter|crew_boat|supply_vessel|commercial_flight|charter_flight|ground_transport|multi_modal — 7 candidates stripped; promote to reference product]',
    `transport_provider` STRING COMMENT 'Name of the transportation service provider or carrier executing the mobilization. May be helicopter operator, vessel operator, airline, or ground transport contractor.',
    `visa_expiry_date` DATE COMMENT 'Date when the visa authorization expires. Monitored to ensure personnel do not work beyond authorized period and to trigger renewal processes.',
    `visa_number` STRING COMMENT 'Visa document number issued by the destination country immigration authority. Required for audit trail and regulatory compliance for international workforce movements.',
    `visa_status` STRING COMMENT 'Current status of visa authorization for cross-border mobilization. Critical for international assignments and compliance with immigration regulations.. Valid values are `not_required|valid|pending|expired|denied`',
    `work_permit_expiry_date` DATE COMMENT 'Date when the work permit authorization expires. Critical for ensuring legal compliance and avoiding penalties for unauthorized work.',
    `work_permit_number` STRING COMMENT 'Work permit or authorization document number issued by the destination country labor authority. Required for compliance with local labor regulations.',
    `work_permit_status` STRING COMMENT 'Current status of work permit or work authorization for the destination jurisdiction. Separate from visa; required for legal right to work in many jurisdictions.. Valid values are `not_required|valid|pending|expired|denied`',
    CONSTRAINT pk_mobilization_event PRIMARY KEY(`mobilization_event_id`)
) COMMENT 'Transactional record of each personnel mobilization or demobilization event for offshore, remote, or international assignments. Captures employee or contractor ID, origin location, destination facility (rig, FPSO, platform, plant), transport mode (helicopter, vessel, commercial flight), mobilization date and time, demobilization date, visa and work permit status, medical fitness clearance date, and Enablon HSE induction completion flag.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`hse_induction` (
    `hse_induction_id` BIGINT COMMENT 'Unique identifier for the HSE induction record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the facility, rig, plant, or site for which this induction authorizes access.',
    `contractor_id` BIGINT COMMENT 'Reference to the contractor who completed the induction. Null if inductee is an employee.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who conducted the induction. Must be a qualified HSE trainer or site safety officer.',
    `primary_hse_employee_id` BIGINT COMMENT 'Reference to the employee who completed the induction. Null if inductee is a contractor.',
    `assessment_method` STRING COMMENT 'Method used to assess inductee comprehension and competency at conclusion of induction.. Valid values are `written_test|verbal_assessment|practical_demonstration|online_quiz|combined`',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numerical score achieved by inductee on the induction assessment, typically expressed as percentage (0.00 to 100.00).',
    `certification_issued` BOOLEAN COMMENT 'Flag indicating whether a formal HSE induction certificate was issued to the inductee upon successful completion.',
    `certification_number` STRING COMMENT 'Unique certificate number issued for this induction, used for verification and audit purposes.',
    `created_by_user` STRING COMMENT 'User ID or username of the system user who created this induction record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this induction record was first created in the system.',
    `emergency_procedures_covered` BOOLEAN COMMENT 'Flag indicating whether emergency response, evacuation, and muster procedures were covered in this induction.',
    `enablon_record_code` STRING COMMENT 'Reference identifier to the corresponding record in Enablon HSE Management system for cross-system traceability.',
    `escort_required` BOOLEAN COMMENT 'Flag indicating whether the inductee requires escort during site access despite completing induction. May apply to visitors or conditional passes.',
    `expiry_date` DATE COMMENT 'Date on which the induction certification expires and re-induction is required. Typically 12-24 months from completion date depending on facility type and regulatory requirements.',
    `facility_name` STRING COMMENT 'Name of the facility at time of induction, captured for audit trail and reporting purposes.',
    `facility_type` STRING COMMENT 'Classification of the facility for which induction was completed, determines applicable HSE protocols and regulatory requirements. [ENUM-REF-CANDIDATE: offshore_platform|onshore_drilling_rig|refinery|petrochemical_plant|pipeline_station|lng_terminal|fpso|processing_facility — 8 candidates stripped; promote to reference product]',
    `h2s_awareness_covered` BOOLEAN COMMENT 'Flag indicating whether H2S awareness training was included in this induction. Mandatory for sour gas facilities.',
    `inductee_badge_number` STRING COMMENT 'Site access badge or identification number assigned to the inductee for facility entry tracking.',
    `inductee_name` STRING COMMENT 'Full name of the person who completed the induction, captured at time of induction for audit trail purposes.',
    `induction_date` DATE COMMENT 'Date on which the HSE induction was completed. This is the principal business event timestamp for site access authorization.',
    `induction_duration_minutes` STRING COMMENT 'Total duration of the induction session in minutes. Regulatory minimum durations apply based on facility type.',
    `induction_end_time` TIMESTAMP COMMENT 'Timestamp when the induction session concluded, used for duration tracking and compliance audit.',
    `induction_notes` STRING COMMENT 'Free-text notes or observations recorded by the induction officer regarding inductee performance, special conditions, or follow-up actions required.',
    `induction_number` STRING COMMENT 'Business identifier for the induction record, typically generated by Enablon HSE Management system or facility-specific numbering scheme.',
    `induction_officer_certification` STRING COMMENT 'Certification or qualification number of the induction officer, verifying their authority to conduct HSE training.',
    `induction_officer_name` STRING COMMENT 'Name of the HSE officer or trainer who conducted the induction, captured for audit trail.',
    `induction_start_time` TIMESTAMP COMMENT 'Timestamp when the induction session began, used for duration tracking and compliance audit.',
    `induction_type` STRING COMMENT 'Category of HSE induction based on facility type and operational environment. Determines topics covered and certification requirements.. Valid values are `site_specific|offshore_platform|refinery|petrochemical_plant|drilling_rig|pipeline_facility`',
    `interpreter_used` BOOLEAN COMMENT 'Flag indicating whether a language interpreter was used during the induction to ensure inductee comprehension.',
    `language` STRING COMMENT 'Language in which the induction was conducted. Critical for multinational workforce compliance and comprehension verification.',
    `modified_by_user` STRING COMMENT 'User ID or username of the system user who last modified this induction record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this induction record was last modified in the system.',
    `next_induction_due_date` DATE COMMENT 'Scheduled date for the next required induction or refresher training to maintain site access authorization.',
    `norm_awareness_covered` BOOLEAN COMMENT 'Flag indicating whether NORM handling and exposure awareness was included in this induction. Required for upstream and midstream operations.',
    `outcome` STRING COMMENT 'Final outcome of the induction assessment determining site access authorization.. Valid values are `pass|fail|conditional_pass|retest_required`',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the induction assessment, typically 80.00 or higher for HSE-critical facilities.',
    `ptw_procedures_covered` BOOLEAN COMMENT 'Flag indicating whether Permit to Work system and procedures were covered in this induction. Critical for operational safety.',
    `regulatory_reference` STRING COMMENT 'Citation of specific regulatory requirement(s) satisfied by this induction (e.g., OSHA 29 CFR 1910.120, BSEE 30 CFR 250.1911).',
    `regulatory_requirement_met` BOOLEAN COMMENT 'Flag indicating whether this induction satisfies applicable OSHA, BSEE, or other regulatory training requirements for the facility type.',
    `simops_procedures_covered` BOOLEAN COMMENT 'Flag indicating whether SIMOPS coordination and safety protocols were covered. Required for multi-activity offshore platforms and complex facilities.',
    `site_access_authorized` BOOLEAN COMMENT 'Flag indicating whether this induction authorizes the inductee for unescorted site access. False if outcome is fail or conditional.',
    `topics_covered` STRING COMMENT 'Comma-separated list or structured text describing HSE topics covered during induction (e.g., H2S awareness, NORM, PTW, emergency procedures, SIMOPS, confined space entry, LDAR, BOP operations).',
    `valid_from_date` DATE COMMENT 'Date from which the induction certification becomes effective for site access authorization.',
    CONSTRAINT pk_hse_induction PRIMARY KEY(`hse_induction_id`)
) COMMENT 'Transactional record of each HSE site induction completed by an employee or contractor prior to accessing a facility, rig, or plant. Captures induction type (site-specific, offshore platform, refinery, petrochemical plant), induction date, facility ID, induction officer, topics covered (H2S awareness, NORM, PTW, emergency procedures, SIMOPS), pass/fail outcome, and Enablon record reference. Mandatory for OSHA and BSEE site access compliance.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` (
    `medical_fitness_id` BIGINT COMMENT 'Unique identifier for the medical fitness assessment record. Primary key for the medical fitness entity.',
    `contractor_id` BIGINT COMMENT 'Foreign key linking to workforce.contractor. Business justification: Medical fitness assessments apply to both employees and contractors. Adding contractor_id FK (nullable) parallel to employee_id enables tracking contractor medical clearances for offshore and hazardou',
    `employee_id` BIGINT COMMENT 'Reference to the employee or contractor undergoing the medical fitness assessment. Links to the workforce employee or contractor master record.',
    `afe_number` STRING COMMENT 'Authorization for Expenditure number for capital projects where the medical assessment cost is charged. Used for project-based cost tracking.',
    `assessment_cost` DECIMAL(18,2) COMMENT 'Total cost of the medical fitness assessment including examination fees, laboratory tests, and certificate issuance. Used for cost center allocation and vendor management.',
    `assessment_date` DATE COMMENT 'Date when the medical fitness assessment was conducted. Principal business event timestamp for the assessment.',
    `assessment_number` STRING COMMENT 'Business identifier for the medical fitness assessment. Externally-known reference number used for tracking and audit purposes.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the medical fitness assessment. Tracks the assessment from scheduling through completion and certificate expiry.. Valid values are `scheduled|in-progress|completed|cancelled|expired`',
    `assessment_type` STRING COMMENT 'Classification of the medical fitness assessment based on the triggering event or regulatory requirement. Determines the scope and depth of medical examination required. [ENUM-REF-CANDIDATE: pre-employment|periodic|post-incident|return-to-work|fitness-for-duty|offshore-rotation|hazmat-exposure — 7 candidates stripped; promote to reference product]',
    `blood_pressure_diastolic` STRING COMMENT 'Diastolic blood pressure measurement in millimeters of mercury (mmHg). Key cardiovascular health indicator for offshore fitness determination.',
    `blood_pressure_systolic` STRING COMMENT 'Systolic blood pressure measurement in millimeters of mercury (mmHg). Key cardiovascular health indicator for offshore fitness determination.',
    `body_mass_index` DECIMAL(18,2) COMMENT 'Body mass index calculated from height and weight measurements. Used to assess fitness for confined space work and emergency egress capability.',
    `certificate_expiry_date` DATE COMMENT 'Date when the medical fitness certificate expires and a new assessment is required. Critical for workforce planning and compliance monitoring.',
    `certificate_issue_date` DATE COMMENT 'Date when the medical fitness certificate was officially issued. Marks the start of the certificate validity period.',
    `confined_space_cleared` BOOLEAN COMMENT 'Flag indicating medical clearance for confined space entry work. Requires assessment of claustrophobia, respiratory function, and cardiovascular fitness.',
    `cost_center_code` STRING COMMENT 'Cost center to which the medical assessment expense is allocated. Supports financial reporting and budget tracking by organizational unit.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the assessment cost. Supports multi-currency financial reporting.. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'User ID of the system user who created the medical fitness assessment record. Supports audit trail and data governance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the medical fitness assessment record was first created in the system. Audit trail for record creation.',
    `drug_alcohol_test_completed` BOOLEAN COMMENT 'Flag indicating whether drug and alcohol screening was completed as part of the medical fitness assessment.',
    `drug_alcohol_test_result` STRING COMMENT 'Outcome of the drug and alcohol screening test. Protected health information with strict confidentiality requirements.. Valid values are `negative|positive|refused|invalid`',
    `examining_physician_license_number` STRING COMMENT 'Medical license number of the examining physician. Validates the credentials of the medical professional conducting the assessment.',
    `examining_physician_name` STRING COMMENT 'Full name of the licensed physician who conducted the medical fitness assessment. Required for audit trail and medical record validation.',
    `fitness_category` STRING COMMENT 'Overall medical fitness determination for offshore or hazardous duty assignments. Core classification outcome of the assessment that determines work eligibility.. Valid values are `fit|fit-with-restrictions|temporarily-unfit|permanently-unfit`',
    `h2s_exposure_cleared` BOOLEAN COMMENT 'Flag indicating medical clearance for work in hydrogen sulfide environments. Requires specific respiratory and cardiovascular fitness criteria.',
    `hazardous_duty_approved` BOOLEAN COMMENT 'Flag indicating whether the individual is medically cleared for hazardous duty assignments including H2S exposure, confined space entry, and NORM handling.',
    `hearing_protection_required` BOOLEAN COMMENT 'Flag indicating whether hearing protection is mandated based on audiometric test results and noise exposure assessment.',
    `hr_review_completed_date` DATE COMMENT 'Date when HR review of the medical fitness assessment was completed. Tracks compliance with accommodation review timelines.',
    `hr_review_required` BOOLEAN COMMENT 'Flag indicating whether HR review is required for fitness determinations with restrictions or special accommodations. Triggers workflow for reasonable accommodation assessment.',
    `immunization_status` STRING COMMENT 'Status of required immunizations for offshore or international assignments including hepatitis, tetanus, and region-specific vaccines.. Valid values are `current|overdue|incomplete|not-required`',
    `medical_certificate_number` STRING COMMENT 'Unique reference number of the medical certificate issued upon successful completion of the fitness assessment. Required for BSEE offshore manning compliance verification.',
    `medical_facility_name` STRING COMMENT 'Name of the medical facility or clinic where the assessment was performed. Supports vendor management and quality assurance tracking.',
    `modified_by_user` STRING COMMENT 'User ID of the system user who last modified the medical fitness assessment record. Supports audit trail and data governance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the medical fitness assessment record was last modified. Audit trail for record updates.',
    `next_assessment_due_date` DATE COMMENT 'Scheduled date for the next periodic medical fitness assessment. Used for proactive scheduling and compliance tracking.',
    `offshore_fitness_standard` STRING COMMENT 'Industry or regulatory standard applied for the offshore medical fitness assessment. Defines the medical criteria and examination protocols used.. Valid values are `OGUK|UKOOA|NOGEPA|API-RP-75|BSEE|company-specific`',
    `offshore_work_approved` BOOLEAN COMMENT 'Flag indicating whether the individual is medically cleared for offshore assignments. Derived from fitness category and used for crew assignment eligibility.',
    `physician_comments` STRING COMMENT 'Additional comments or observations from the examining physician regarding the medical fitness assessment. Protected health information requiring confidential handling.',
    `regulatory_compliance_met` BOOLEAN COMMENT 'Flag indicating whether the assessment meets all applicable regulatory requirements for the intended work assignment. Used for compliance reporting and audit readiness.',
    `respirator_use_cleared` BOOLEAN COMMENT 'Flag indicating medical clearance for respirator use. Required for personnel working in environments requiring respiratory protection equipment.',
    `restrictions_noted` STRING COMMENT 'Detailed description of any work restrictions or limitations identified during the medical assessment. Protected health information requiring confidential handling.',
    `vision_corrective_required` BOOLEAN COMMENT 'Flag indicating whether corrective lenses or vision aids are required for safe work performance based on vision screening results.',
    CONSTRAINT pk_medical_fitness PRIMARY KEY(`medical_fitness_id`)
) COMMENT 'Master record of each employee or contractor medical fitness assessment required for offshore or hazardous duty assignments. Captures assessment date, examining physician, fitness category (Fit/Fit with Restrictions/Temporarily Unfit/Permanently Unfit), offshore fitness standard (OGUK/UKOOA Medical Fitness), restrictions noted, next assessment due date, and medical certificate reference number. Required for BSEE offshore manning compliance.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`plan` (
    `plan_id` BIGINT COMMENT 'Unique identifier for the workforce planning cycle record. Primary key for the workforce plan entity.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who approved this workforce plan, typically the Business Unit Manager, VP of Operations, or Chief Human Resources Officer (CHRO).',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (business unit, department, or cost center) for which this workforce plan applies.',
    `owner_employee_id` BIGINT COMMENT 'Reference to the employee responsible for creating and maintaining this workforce plan, typically the HR Business Partner or Workforce Planning Manager for the organizational unit.',
    `activation_date` DATE COMMENT 'Date on which this workforce plan became active and execution began. Typically aligns with the planning period start date.',
    `approval_date` DATE COMMENT 'Date on which this workforce plan was formally approved by the designated approver. Marks the transition from Under Review to Approved status.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the labor budget amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `business_segment` STRING COMMENT 'Primary business segment for which this workforce plan is prepared: Upstream E&P (Exploration and Production), Midstream (transportation and storage), Downstream Refining, Petrochemicals, Marketing and Sales, or Corporate (shared services).. Valid values are `Upstream E&P|Midstream|Downstream Refining|Petrochemicals|Marketing and Sales|Corporate`',
    `capex_labor_budget` DECIMAL(18,2) COMMENT 'Portion of labor budget allocated to capital projects (CAPEX) during the planning period. Includes labor costs for drilling campaigns, facility construction, major turnarounds, and capital improvement projects.',
    `closure_date` DATE COMMENT 'Date on which this workforce plan was closed after the planning period ended. Marks the completion of the planning cycle and triggers post-plan review.',
    `created_by_user` STRING COMMENT 'User ID or system account that created this workforce plan record. Audit trail for accountability and data lineage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this workforce plan record was first created in the system. Audit trail for data lineage and compliance.',
    `critical_positions_count` STRING COMMENT 'Number of safety-critical or business-critical positions identified in this workforce plan requiring succession planning. Examples include Offshore Installation Manager (OIM), Plant Manager, Chief Drilling Engineer, HSE Manager, and key technical specialists.',
    `current_headcount` STRING COMMENT 'Current total headcount (employees and contractors) in the organizational unit at the time of plan creation. Baseline for gap analysis.',
    `diversity_hiring_target_percentage` DECIMAL(18,2) COMMENT 'Target percentage of planned hires from underrepresented groups (women, minorities, veterans) to support diversity and inclusion goals. Expressed as a percentage (e.g., 30.00 for 30%).',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this workforce plan applies, represented as a four-digit year (e.g., 2024).',
    `headcount_gap` STRING COMMENT 'Difference between planned headcount and current headcount (planned minus current). Positive values indicate hiring need (deficit); negative values indicate surplus requiring redeployment or attrition management.',
    `high_potential_talent_count` STRING COMMENT 'Number of employees identified as high-potential talent (HiPo) within this organizational unit. HiPo employees demonstrate exceptional performance and leadership potential for accelerated development.',
    `hse_certified_personnel_required` STRING COMMENT 'Number of personnel required to hold current HSE certifications (e.g., BOSIET, HUET, H2S awareness, confined space entry) to meet regulatory and operational safety requirements.',
    `labor_budget_amount` DECIMAL(18,2) COMMENT 'Total labor budget allocated for this organizational unit during the planning period, including salaries, wages, benefits, contractor costs, and allowances. Expressed in the budget currency.',
    `modified_by_user` STRING COMMENT 'User ID or system account that last modified this workforce plan record. Audit trail for change accountability and compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this workforce plan record was last modified. Audit trail for change tracking and data quality monitoring.',
    `offshore_manning_requirement` STRING COMMENT 'Total offshore personnel manning requirement for platforms, FPSOs, and drilling rigs under this organizational unit. Represents the number of personnel on board (POB) required to maintain safe operations.',
    `operational_area` STRING COMMENT 'Operational area classification for workforce planning: Offshore (platforms, FPSO, drilling rigs), Onshore (land-based production), Refinery, Petrochemical Plant, Terminal (storage and distribution), Pipeline, Office (administrative), or Field Services (mobile crews). [ENUM-REF-CANDIDATE: Offshore|Onshore|Refinery|Petrochemical Plant|Terminal|Pipeline|Office|Field Services — 8 candidates stripped; promote to reference product]',
    `opex_labor_budget` DECIMAL(18,2) COMMENT 'Portion of labor budget allocated to operating expenses (OPEX) during the planning period. Includes labor costs for routine operations, maintenance, and administrative functions.',
    `plan_number` STRING COMMENT 'Business identifier for the workforce plan, typically formatted as WFP-YYYY-NNNNNN where YYYY is fiscal year and NNNNNN is sequence number.. Valid values are `^WFP-[0-9]{4}-[0-9]{6}$`',
    `plan_status` STRING COMMENT 'Current lifecycle status of the workforce plan: Draft (initial preparation), Under Review (submitted for approval), Approved (authorized for execution), Active (currently in execution), Closed (planning period completed), or Cancelled (plan abandoned).. Valid values are `Draft|Under Review|Approved|Active|Closed|Cancelled`',
    `plan_type` STRING COMMENT 'Classification of the workforce planning cycle: Strategic (3-5 year), Annual (fiscal year), Quarterly (rolling quarter), Project-Based (specific CAPEX project or drilling campaign), Succession (leadership pipeline), Rig Manning (offshore crew planning), SIMOPS Crew (simultaneous operations coordination), or Emergency Response (contingency staffing). [ENUM-REF-CANDIDATE: Strategic|Annual|Quarterly|Project-Based|Succession|Rig Manning|SIMOPS Crew|Emergency Response — 8 candidates stripped; promote to reference product]',
    `planned_attrition` STRING COMMENT 'Expected number of departures (retirements, resignations, terminations) during the planning period based on historical attrition rates and known retirements.',
    `planned_headcount` STRING COMMENT 'Target total headcount (employees and contractors) for the organizational unit at the end of the planning period. Represents the desired workforce size after all planned hires, attrition, and transfers.',
    `planned_hires` STRING COMMENT 'Number of new hires (employees and contractors) planned during the planning period to address headcount gaps, growth initiatives, or replacement needs.',
    `planned_internal_transfers_in` STRING COMMENT 'Number of employees expected to transfer into this organizational unit from other parts of the organization during the planning period.',
    `planned_internal_transfers_out` STRING COMMENT 'Number of employees expected to transfer out of this organizational unit to other parts of the organization during the planning period.',
    `planning_period_end_date` DATE COMMENT 'End date of the workforce planning period covered by this plan. For annual plans, typically the fiscal year end date; for quarterly plans, the quarter end date.',
    `planning_period_start_date` DATE COMMENT 'Start date of the workforce planning period covered by this plan. For annual plans, typically the fiscal year start date; for quarterly plans, the quarter start date.',
    `planning_quarter` STRING COMMENT 'Fiscal quarter to which this workforce plan applies (Q1, Q2, Q3, Q4). Applicable for quarterly planning cycles; null for annual or strategic plans.. Valid values are `Q1|Q2|Q3|Q4`',
    `remarks` STRING COMMENT 'Free-text field for additional notes, assumptions, constraints, or context relevant to this workforce plan. May include notes on market conditions, project dependencies, regulatory changes, or strategic initiatives impacting workforce requirements.',
    `simops_qualified_personnel_required` STRING COMMENT 'Number of personnel required to be qualified for simultaneous operations (SIMOPS) coordination, critical for managing concurrent drilling, production, and maintenance activities on offshore installations.',
    `submission_date` DATE COMMENT 'Date on which this workforce plan was submitted for approval review. Marks the transition from Draft to Under Review status.',
    `succession_ready_1_2_years_count` STRING COMMENT 'Number of identified successors rated as Ready in 1-2 Years for critical positions. Indicates near-term pipeline requiring targeted development.',
    `succession_ready_3_5_years_count` STRING COMMENT 'Number of identified successors rated as Ready in 3-5 Years for critical positions. Indicates long-term talent pipeline requiring sustained development.',
    `succession_ready_now_count` STRING COMMENT 'Number of identified successors rated as Ready Now for critical positions within this organizational unit. Indicates immediate bench strength for leadership continuity.',
    `training_budget_amount` DECIMAL(18,2) COMMENT 'Budget allocated for workforce training and development during the planning period, including technical competency training, HSE certifications, leadership development, and regulatory compliance training.',
    `union_representation_flag` BOOLEAN COMMENT 'Indicates whether the workforce covered by this plan includes union-represented employees requiring collective bargaining agreement (CBA) compliance in workforce planning decisions.',
    `veteran_hiring_target_count` STRING COMMENT 'Target number of military veterans to be hired during the planning period, supporting corporate veteran employment commitments and leveraging transferable skills for safety-critical roles.',
    CONSTRAINT pk_plan PRIMARY KEY(`plan_id`)
) COMMENT 'Master record for workforce planning and succession planning cycles at the business unit or department level. Captures planning period (annual/quarterly), org unit, planned headcount by job family and grade, current headcount, gap analysis (surplus/deficit), planned hires, planned attrition, CAPEX/OPEX labor budget, and plan approval status. Includes succession planning for critical positions: target position, incumbent employee, identified successors (primary and secondary), succession readiness rating (Ready Now / Ready in 1-2 Years / Ready in 3-5 Years), development actions required, and talent pool category. Supports strategic workforce planning, rig manning forecasts, and leadership pipeline management for safety-critical roles (OIM, Plant Manager, Chief Drilling Engineer).';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` (
    `recruitment_requisition_id` BIGINT COMMENT 'Unique identifier for the recruitment requisition record. Primary key for the recruitment requisition entity.',
    `job_role_id` BIGINT COMMENT 'Foreign key linking to workforce.job_role. Business justification: Recruitment requisition targets a standardized job_role. Job_role defines required competencies, certifications, and experience levels needed for candidate screening. Adding job_role_id FK normalizes ',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (department, division, or operational area) where the position will be placed.',
    `position_id` BIGINT COMMENT 'Reference to the organizational position being filled. Links to the position master data defining job role, grade, and organizational placement.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the hiring manager responsible for the recruitment decision and candidate selection.',
    `tertiary_recruitment_recruiter_employee_id` BIGINT COMMENT 'Employee identifier of the HR recruiter assigned to manage the requisition and candidate pipeline.',
    `afe_number` STRING COMMENT 'AFE number for project-specific hires where labor costs are capitalized to a drilling, completion, or facility construction project rather than expensed to operations.. Valid values are `^AFE-[0-9]{6,10}$`',
    `approval_date` DATE COMMENT 'Date when the requisition received final approval and was released for active recruitment.',
    `approval_workflow_status` STRING COMMENT 'Current stage in the multi-level approval workflow, tracking progression through hiring manager, HR, finance, and executive approvals. [ENUM-REF-CANDIDATE: not_submitted|pending_manager|pending_hr|pending_finance|pending_executive|approved|rejected — 7 candidates stripped; promote to reference product]',
    `approved_headcount` STRING COMMENT 'Number of positions approved for this requisition, typically 1 but may be multiple for bulk hiring campaigns.',
    `background_check_clearance_date` DATE COMMENT 'Date when the candidate successfully cleared all background verification requirements and was approved for hire.',
    `background_check_status` STRING COMMENT 'Status of pre-employment background verification, including criminal record check, employment history verification, and security clearance for sensitive facilities.. Valid values are `not_initiated|in_progress|cleared|flagged|failed`',
    `candidate_name` STRING COMMENT 'Full name of the candidate being considered for the position. Populated once a candidate enters the interview pipeline.',
    `candidate_source_channel` STRING COMMENT 'Specific channel through which the candidate was sourced, used for recruitment effectiveness analysis and cost-per-hire tracking. [ENUM-REF-CANDIDATE: job_board|linkedin|agency|referral|campus|career_fair|rehire|internal_application — 8 candidates stripped; promote to reference product]',
    `cost_center_code` STRING COMMENT 'SAP Controlling (CO) cost center to which the positions labor costs will be charged for financial reporting and budget tracking.. Valid values are `^[0-9]{10}$`',
    `created_by_user` STRING COMMENT 'User ID of the system user who created the recruitment requisition record, typically the hiring manager or HR coordinator.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the recruitment requisition record was first created in the HR system.',
    `employment_type` STRING COMMENT 'Type of employment relationship: permanent full-time, temporary, fixed-term contract, intern, or rotational offshore assignment.. Valid values are `permanent|temporary|contract|intern|rotational`',
    `hse_certification_required_flag` BOOLEAN COMMENT 'Indicates whether the position requires HSE certifications such as H2S awareness, offshore survival training, or OSHA safety training prior to start date.',
    `interview_stage` STRING COMMENT 'Current stage of the candidate in the interview process, tracking progression from initial screening through offer acceptance or rejection. [ENUM-REF-CANDIDATE: screening|phone_interview|technical_interview|panel_interview|final_interview|offer_stage|declined|withdrawn — 8 candidates stripped; promote to reference product]',
    `job_title` STRING COMMENT 'The official job title for the position being recruited, such as Drilling Engineer, Production Supervisor, HSE Manager, or Reservoir Geologist.',
    `justification` STRING COMMENT 'Business justification for the hire, including operational need, project requirement, attrition replacement, or strategic capability build.',
    `modified_by_user` STRING COMMENT 'User ID of the system user who last modified the recruitment requisition record, supporting audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the recruitment requisition record was last updated, tracking changes to status, candidate information, or approval workflow.',
    `offer_acceptance_date` DATE COMMENT 'Date when the candidate formally accepted the employment offer, triggering onboarding preparation and employee record creation.',
    `offer_date` DATE COMMENT 'Date when the formal employment offer was extended to the candidate.',
    `offer_status` STRING COMMENT 'Status of the employment offer for the candidate, tracking from offer preparation through acceptance or decline.. Valid values are `no_offer|offer_pending|offer_extended|offer_accepted|offer_declined|offer_withdrawn`',
    `offshore_assignment_flag` BOOLEAN COMMENT 'Indicates whether the position requires offshore platform or FPSO assignment with rotational crew scheduling.',
    `recruitment_channel` STRING COMMENT 'Primary sourcing channel for candidates: internal job posting, external job boards, recruitment agency, campus hiring, employee referral, or former employee rehire.. Valid values are `internal|external|agency|campus|referral|rehire`',
    `rejection_reason` STRING COMMENT 'Explanation provided when a requisition is rejected during the approval workflow, such as budget constraints, headcount freeze, or insufficient justification.',
    `required_start_date` DATE COMMENT 'Target date by which the position must be filled to meet operational or project timeline requirements.',
    `requisition_close_date` DATE COMMENT 'Date when the requisition was closed, either due to successful hire, cancellation, or position elimination.',
    `requisition_number` STRING COMMENT 'Business identifier for the recruitment requisition, externally visible and used for tracking and reference across HR systems and approval workflows.. Valid values are `^REQ-[0-9]{8}$`',
    `requisition_open_date` DATE COMMENT 'Date when the requisition was opened for active candidate sourcing and recruitment activities.',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the recruitment requisition in the approval and hiring workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|open|in_progress|on_hold|filled|cancelled|closed — 9 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Classification of the recruitment need: new headcount addition, replacement for departed employee, project-specific temporary hire, contractor-to-employee conversion, internal transfer, or temporary assignment.. Valid values are `new_hire|backfill|project_specific|contractor_conversion|internal_transfer|temporary`',
    `rotation_schedule` STRING COMMENT 'Offshore rotation pattern for the position, such as 14/14, 21/21, 28/28 days on/off, or SIMOPS crew coordination schedule.',
    `sap_ps_project_code` STRING COMMENT 'SAP PS project reference for capital project hires, linking the requisition to EPC, FEED, or major facility expansion projects.. Valid values are `^[A-Z0-9-]{8,15}$`',
    `security_clearance_level` STRING COMMENT 'Required security clearance level for positions with access to sensitive operational data, critical infrastructure, or government-regulated facilities.. Valid values are `none|basic|confidential|secret|top_secret`',
    `technical_screening_score` DECIMAL(18,2) COMMENT 'Numerical score from technical competency assessment, evaluating candidate proficiency in job-specific skills such as reservoir simulation, drilling engineering, or process safety.',
    `time_to_fill_days` STRING COMMENT 'Number of calendar days from requisition approval to offer acceptance, used as a key recruitment efficiency metric.',
    `work_authorization_status` STRING COMMENT 'Status of the candidates legal authorization to work in the jurisdiction where the position is located, critical for offshore and international assignments.. Valid values are `verified|pending_verification|visa_required|visa_in_process|not_authorized`',
    `work_location` STRING COMMENT 'Primary work location for the position, such as corporate office, refinery, offshore platform, drilling rig, or field operations base.',
    CONSTRAINT pk_recruitment_requisition PRIMARY KEY(`recruitment_requisition_id`)
) COMMENT 'Transactional record managing the full recruitment lifecycle from headcount requisition through candidate pipeline to offer acceptance. Captures requisition number, position ID, job role, hiring manager, org unit, justification (new hire, backfill, project-specific), required start date, approved headcount, recruitment channel (internal, external, agency), AFE or cost center charge, approval workflow status, and SAP PS project reference. Also tracks candidate details including candidate name, source channel, technical screening score, interview stage, offer status, work authorization status, and background check clearance. Candidates convert to employee records upon hire.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`candidate` (
    `candidate_id` BIGINT COMMENT 'Unique identifier for the candidate record in the recruitment system. Primary key.',
    `recruitment_requisition_id` BIGINT COMMENT 'Identifier of the job requisition or posting that the candidate applied to. Links candidate to specific hiring need.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the referring employee if candidate was sourced through employee referral program. Used for referral bonus tracking.',
    `application_date` DATE COMMENT 'Date when the candidate submitted their application. Used for time-to-hire metrics and application aging analysis.',
    `application_number` STRING COMMENT 'Externally visible unique application reference number assigned when candidate applies. Used for candidate communication and tracking.',
    `application_status` STRING COMMENT 'Current stage of the candidate in the recruitment pipeline. Tracks progression from application through hire or rejection. [ENUM-REF-CANDIDATE: new|screening|interview|assessment|offer|hired|rejected|withdrawn — 8 candidates stripped; promote to reference product]',
    `applied_position_title` STRING COMMENT 'Job title or position name that the candidate applied for. May differ from eventual offer position.',
    `background_check_completion_date` DATE COMMENT 'Date when background check was completed and results received.',
    `background_check_status` STRING COMMENT 'Status of pre-employment background verification check. Required clearance before hire finalization.. Valid values are `not_initiated|in_progress|cleared|flagged|failed`',
    `cover_letter_reference` STRING COMMENT 'Document management system reference to the candidates cover letter if provided.',
    `created_by_user` STRING COMMENT 'User identifier or system account that created the candidate record. Used for audit and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the candidate record was first created in the system. Used for audit trail and data lineage.',
    `cv_document_reference` STRING COMMENT 'Document management system reference or URI to the candidates resume or CV file. Used for document retrieval and review.',
    `degree_field` STRING COMMENT 'Primary field or major of the candidates highest degree (e.g., Petroleum Engineering, Mechanical Engineering, Geology).',
    `drug_test_date` DATE COMMENT 'Date when pre-employment drug and alcohol test was conducted.',
    `drug_test_status` STRING COMMENT 'Status of pre-employment drug and alcohol screening test. Mandatory for safety-sensitive positions per OSHA and company HSE policy.. Valid values are `not_required|scheduled|passed|failed|pending`',
    `email_address` STRING COMMENT 'Primary email address for candidate communication, interview scheduling, and offer delivery.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `expected_start_date` DATE COMMENT 'Anticipated date when candidate would be available to commence employment if offer is accepted.',
    `first_name` STRING COMMENT 'Legal first name of the candidate as provided in application documents.',
    `full_name` STRING COMMENT 'Complete concatenated name of the candidate for display and reporting purposes.',
    `highest_education_level` STRING COMMENT 'Highest level of formal education completed by the candidate. Used for minimum qualification screening.. Valid values are `high_school|associate|bachelor|master|doctorate|professional_certification`',
    `hse_certification_status` STRING COMMENT 'Verification status of required HSE certifications and training for the target role. Critical for operational and offshore positions.. Valid values are `not_required|pending|verified|expired|insufficient`',
    `interview_stage` STRING COMMENT 'Current interview stage in the multi-round interview process. Tracks candidate progression through interview funnel. [ENUM-REF-CANDIDATE: not_scheduled|phone_screen|first_round|technical_interview|panel_interview|final_interview|completed — 7 candidates stripped; promote to reference product]',
    `interviewer_feedback_summary` STRING COMMENT 'Consolidated summary of interviewer feedback and assessment notes. Used for hiring decision review.',
    `last_interview_date` DATE COMMENT 'Date of the most recent interview conducted with the candidate.',
    `last_name` STRING COMMENT 'Legal last name or surname of the candidate as provided in application documents.',
    `middle_name` STRING COMMENT 'Middle name or initial of the candidate if provided.',
    `mobile_number` STRING COMMENT 'Mobile phone number for urgent candidate contact and SMS notifications.',
    `modified_by_user` STRING COMMENT 'User identifier or system account that last modified the candidate record. Used for audit and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the candidate record was last updated. Used for audit trail and change tracking.',
    `nationality` STRING COMMENT 'Country of citizenship using ISO 3166-1 alpha-3 country code. Critical for work authorization and visa requirements.. Valid values are `^[A-Z]{3}$`',
    `offer_date` DATE COMMENT 'Date when formal employment offer was extended to the candidate.',
    `offer_expiry_date` DATE COMMENT 'Date by which candidate must accept or decline the offer. Used for offer tracking and candidate follow-up.',
    `offer_status` STRING COMMENT 'Current status of employment offer for this candidate. Tracks offer lifecycle from generation through acceptance or decline.. Valid values are `no_offer|offer_pending|offer_extended|offer_accepted|offer_declined|offer_withdrawn`',
    `offered_salary_amount` DECIMAL(18,2) COMMENT 'Annual salary amount offered to the candidate. Business-confidential compensation data.',
    `offshore_experience_flag` BOOLEAN COMMENT 'Indicates whether candidate has prior offshore platform or FPSO work experience. Critical for offshore manning requirements.',
    `oil_gas_experience_years` DECIMAL(18,2) COMMENT 'Years of experience specifically in the oil and gas industry. Critical qualifier for technical and operational roles.',
    `overall_interview_rating` STRING COMMENT 'Aggregated interview rating recommendation from all interviewers. Primary input to hiring decision.. Valid values are `strong_hire|hire|maybe|no_hire|strong_no_hire`',
    `phone_number` STRING COMMENT 'Primary contact phone number for candidate communication and interview coordination.',
    `rejection_date` DATE COMMENT 'Date when candidate was formally rejected or removed from consideration.',
    `rejection_reason` STRING COMMENT 'Reason code or description for candidate rejection. Used for recruitment process improvement and compliance documentation.',
    `salary_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the offered salary amount.. Valid values are `^[A-Z]{3}$`',
    `source_channel` STRING COMMENT 'Channel or method through which the candidate was sourced or applied. Used for recruitment effectiveness analysis and source optimization. [ENUM-REF-CANDIDATE: job_board|company_website|employee_referral|recruiter|social_media|career_fair|campus_recruitment|agency — 8 candidates stripped; promote to reference product]',
    `technical_screening_date` DATE COMMENT 'Date when technical screening or assessment was completed.',
    `technical_screening_score` DECIMAL(18,2) COMMENT 'Numerical score from technical skills assessment or screening test. Used to rank candidates and determine interview eligibility.',
    `visa_expiry_date` DATE COMMENT 'Expiration date of current work visa if applicable. Critical for workforce planning and visa renewal tracking.',
    `visa_type` STRING COMMENT 'Type of work visa held by candidate if applicable (e.g., H-1B, L-1, TN). Relevant for international hiring and offshore assignments.',
    `work_authorization_status` STRING COMMENT 'Current legal authorization status to work in the hiring jurisdiction. Determines visa sponsorship requirements and hiring eligibility.. Valid values are `citizen|permanent_resident|work_visa|requires_sponsorship|not_authorized`',
    `years_of_experience` DECIMAL(18,2) COMMENT 'Total years of relevant professional experience as stated by candidate or assessed during screening. Used for qualification matching.',
    CONSTRAINT pk_candidate PRIMARY KEY(`candidate_id`)
) COMMENT 'Master record for each job applicant or candidate in the Oil Gas recruitment pipeline, capturing candidate name, contact details, source channel, applied position, CV reference, nationality, work authorization status, technical screening score, interview stage, offer status, and background check clearance. Distinct from employee — becomes an employee record only upon hire.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` (
    `work_permit_visa_id` BIGINT COMMENT 'Unique identifier for the work permit or visa record. Primary key for the work permit visa master data product.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the specific Oil Gas facility, rig, platform, or office location where the employee is authorized to work. Links to the facility master record.',
    `contractor_id` BIGINT COMMENT 'Foreign key linking to workforce.contractor. Business justification: Work permits and visas apply to both employees and contractors, especially for international assignments and offshore work. Adding contractor_id FK (nullable) parallel to employee_id enables tracking ',
    `employee_id` BIGINT COMMENT 'Reference to the employee or contractor to whom this work permit or visa is issued. Links to the employee or contractor master record.',
    `afe_number` STRING COMMENT 'Authorization for Expenditure number to which immigration-related costs are charged. Used for project-based cost allocation in exploration and production operations.',
    `alert_reason` STRING COMMENT 'Description of the reason for the compliance alert, such as expiry within 90 days, missing renewal documentation, or regulatory change impact.',
    `application_reference_number` STRING COMMENT 'Reference number or case number assigned by the immigration authority during the application process. Used for tracking application status and correspondence.',
    `application_submission_date` DATE COMMENT 'Date on which the work permit or visa application was submitted to the immigration authority. Used for processing timeline tracking.',
    `approval_date` DATE COMMENT 'Date on which the work permit or visa application was officially approved by the immigration authority. May differ from issue date.',
    `attorney_contact_email` STRING COMMENT 'Email address of the immigration attorney or legal representative handling this permit. Used for case coordination and compliance communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `compliance_alert_flag` BOOLEAN COMMENT 'Indicates whether this permit record has triggered a compliance alert due to pending expiry, missing documentation, or other risk factors. Used for proactive compliance management.',
    `cost_center_code` STRING COMMENT 'SAP cost center code to which immigration processing costs and permit fees are allocated. Used for labor cost tracking and financial reporting.',
    `created_by_user` STRING COMMENT 'User ID or name of the system user who created this work permit visa record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this work permit visa record was first created in the system. Used for audit trail and data lineage tracking.',
    `days_until_expiry` STRING COMMENT 'Calculated number of days remaining until the work permit or visa expires. Used for automated compliance alerts and renewal workflow triggers.',
    `dependent_count` STRING COMMENT 'Number of dependent family members covered under this work permit or visa authorization. Used for relocation planning and benefits administration.',
    `dependents_allowed_flag` BOOLEAN COMMENT 'Indicates whether the work permit or visa allows the employee to bring dependent family members to the work location country.',
    `document_storage_location` STRING COMMENT 'File path, document management system reference, or physical storage location where the original work permit or visa documentation is maintained.',
    `effective_start_date` DATE COMMENT 'Date from which the work permit or visa becomes valid for employment purposes. May differ from issue date if there is a future effective date.',
    `employment_type_authorized` STRING COMMENT 'Type of employment relationship authorized under this work permit or visa. Specifies whether full-time, part-time, contract, or other employment arrangement is permitted.. Valid values are `full_time|part_time|contract|temporary|permanent|seasonal`',
    `expiry_date` DATE COMMENT 'Date on which the work permit or visa expires and is no longer valid for employment authorization. Critical for compliance tracking and renewal planning.',
    `immigration_attorney` STRING COMMENT 'Name of the immigration attorney or legal firm handling the work permit or visa application and compliance matters.',
    `issue_date` DATE COMMENT 'Date on which the work permit or visa was officially issued by the immigration authority. Marks the start of document validity.',
    `issuing_authority` STRING COMMENT 'Name of the government agency or immigration authority that issued the permit (e.g., U.S. Citizenship and Immigration Services, UK Home Office, Department of Immigration and Border Protection).',
    `issuing_country_code` STRING COMMENT 'Three-letter ISO country code of the nation that issued the work permit or visa. Identifies the jurisdiction governing this authorization.. Valid values are `^[A-Z]{3}$`',
    `job_title_authorized` STRING COMMENT 'Job title or occupation for which the work permit or visa was granted. Must match the role specified in the immigration application and employment contract.',
    `modified_by_user` STRING COMMENT 'User ID or name of the system user who last modified this work permit visa record. Used for change tracking and audit compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this work permit visa record was last modified. Used for change tracking and audit compliance.',
    `multiple_entry_flag` BOOLEAN COMMENT 'Indicates whether the visa permits multiple entries into the issuing country or is restricted to single entry. Relevant for rotation schedules and international travel planning.',
    `notes` STRING COMMENT 'Free-text field for additional information, special conditions, restrictions, or comments related to the work permit or visa. Captures case-specific details not covered by structured fields.',
    `occupation_code` STRING COMMENT 'Standard occupational classification code (e.g., SOC, ISCO) associated with the authorized employment. Used for immigration compliance and labor market analysis.',
    `offshore_work_authorized_flag` BOOLEAN COMMENT 'Indicates whether this permit authorizes the employee to work on offshore platforms, rigs, or vessels. Critical for SIMOPS crew coordination and offshore manning compliance.',
    `permit_number` STRING COMMENT 'Official government-issued permit or visa number as printed on the authorization document. Unique identifier assigned by the issuing immigration authority.',
    `permit_subtype` STRING COMMENT 'Detailed classification or category code specific to the issuing countrys immigration system (e.g., H-1B, L-1, Tier 2, 457 visa). Captures jurisdiction-specific permit classifications.',
    `permit_type` STRING COMMENT 'Classification of the immigration authorization document. Distinguishes between work visas, residency permits, offshore work permits, and other authorization types. [ENUM-REF-CANDIDATE: work_visa|residency_permit|offshore_work_permit|temporary_work_authorization|permanent_residency|business_visa|dependent_visa — 7 candidates stripped; promote to reference product]',
    `rejection_date` DATE COMMENT 'Date on which the work permit or visa application was rejected by the immigration authority, if applicable.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the immigration authority for rejecting the work permit or visa application. Used for remediation planning and reapplication strategy.',
    `renewal_due_date` DATE COMMENT 'Target date by which the work permit or visa renewal application should be submitted to ensure continuity of employment authorization. Typically set 90-180 days before expiry.',
    `renewal_status` STRING COMMENT 'Status of the permit renewal process. Tracks whether renewal application has been submitted, is under review, or has been approved or rejected.. Valid values are `not_required|pending_submission|submitted|approved|rejected|in_review`',
    `sponsoring_company_code` STRING COMMENT 'SAP company code or legal entity identifier of the sponsoring organization. Links the permit to the specific Oil Gas subsidiary or joint venture entity.',
    `sponsoring_entity` STRING COMMENT 'Legal name of the Oil Gas entity or subsidiary that is sponsoring the work permit or visa. Identifies the employer of record for immigration purposes.',
    `work_location_country_code` STRING COMMENT 'Three-letter ISO country code of the nation where the employee is authorized to work under this permit. May differ from issuing country for certain visa types.. Valid values are `^[A-Z]{3}$`',
    `work_permit_visa_status` STRING COMMENT 'Current lifecycle status of the work permit or visa. Tracks whether the authorization is active, expired, pending approval, or undergoing renewal. [ENUM-REF-CANDIDATE: active|expired|pending|approved|rejected|suspended|cancelled|renewal_in_progress — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_work_permit_visa PRIMARY KEY(`work_permit_visa_id`)
) COMMENT 'Master record tracking work permits, visas, and immigration authorizations for expatriate employees and international contractors deployed at Oil Gas operations globally. Captures permit type (work visa, residency permit, offshore work permit), issuing country, permit number, issue date, expiry date, renewal status, sponsoring entity, and compliance alert flag. Critical for international workforce deployment and immigration compliance.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`succession_plan` (
    `succession_plan_id` BIGINT COMMENT 'Unique identifier for the succession plan record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the specific facility, rig, platform, refinery, or plant where the target position is located, particularly relevant for operational and safety-critical roles.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit or business segment that owns the target position and succession plan.',
    `employee_id` BIGINT COMMENT 'Reference to the senior leader or executive responsible for overseeing and approving the succession plan, typically the hiring manager or division head.',
    `primary_successor_employee_id` BIGINT COMMENT 'Reference to the employee identified as the primary successor for the target position.',
    `quaternary_succession_approved_by_employee_id` BIGINT COMMENT 'Reference to the executive or senior leader who formally approved the succession plan.',
    `position_id` BIGINT COMMENT 'Reference to the critical or key position for which succession planning is being performed.',
    `tertiary_succession_hr_business_partner_employee_id` BIGINT COMMENT 'Reference to the HR business partner responsible for facilitating the succession planning process and coordinating development activities.',
    `approval_date` DATE COMMENT 'Date when the succession plan was formally approved by senior management.',
    `approval_status` STRING COMMENT 'Current approval status of the succession plan by senior management and human resources leadership.. Valid values are `pending|approved|rejected|revision_required`',
    `business_segment` STRING COMMENT 'Primary business segment or division to which the target position belongs, such as Exploration and Production (E&P), Drilling and Completion (D&C), Refining, Petrochemicals, or Marketing. [ENUM-REF-CANDIDATE: exploration|drilling|production|refining|petrochemicals|marketing|corporate — 7 candidates stripped; promote to reference product]',
    `created_by_user` STRING COMMENT 'User identifier or username of the person who created the succession plan record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the succession plan record was first created in the system.',
    `development_actions_required` STRING COMMENT 'Detailed description of the training, certifications, competency assessments, job rotations, mentoring, and other development activities required to prepare successors for the target role. May include HSE (Health Safety and Environment) certifications, technical competencies, and leadership development.',
    `development_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated development cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `estimated_development_cost` DECIMAL(18,2) COMMENT 'Projected total cost for developing the successor candidates through training, certifications, rotational assignments, and other development activities.',
    `hse_certification_requirements` STRING COMMENT 'Specific HSE certifications and safety training required for the target position, critical for safety-critical roles in oil and gas operations such as H2S (Hydrogen Sulfide) awareness, well control, BOP (Blowout Preventer) operations, and offshore survival training.',
    `incumbent_planned_departure_date` DATE COMMENT 'Expected or planned date when the incumbent will vacate the position, such as retirement date or end of assignment.',
    `joa_position_flag` BOOLEAN COMMENT 'Indicates whether the target position operates under a Joint Operating Agreement (JOA) or Production Sharing Agreement (PSA), requiring coordination with joint venture partners.',
    `last_review_date` DATE COMMENT 'Date when the succession plan was most recently reviewed and updated by management and human resources.',
    `leadership_competency_gaps` STRING COMMENT 'Identified gaps in leadership and management capabilities that successors must develop, including decision-making, team leadership, crisis management, and stakeholder management skills.',
    `modified_by_user` STRING COMMENT 'User identifier or username of the person who last modified the succession plan record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the succession plan record was last modified or updated.',
    `notes` STRING COMMENT 'Additional comments, observations, or context regarding the succession plan, development progress, or special considerations.',
    `offshore_position_flag` BOOLEAN COMMENT 'Indicates whether the target position is an offshore role requiring offshore survival training, SIMOPS (Simultaneous Operations) coordination, and specialized HSE certifications.',
    `plan_effective_date` DATE COMMENT 'Date when the succession plan becomes active and development actions are initiated.',
    `plan_number` STRING COMMENT 'Business-facing unique identifier or reference number for the succession plan, used for tracking and reporting purposes.',
    `plan_review_date` DATE COMMENT 'Scheduled date for the next formal review and update of the succession plan to assess progress, adjust readiness ratings, and modify development actions.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the succession plan indicating its approval and execution state.. Valid values are `active|under_review|approved|on_hold|completed|cancelled`',
    `position_criticality_level` STRING COMMENT 'Classification of the positions importance to business operations and safety. Critical positions include safety-critical roles such as OIM (Offshore Installation Manager), Plant Manager, and Chief Drilling Engineer.. Valid values are `critical|key|strategic|standard`',
    `primary_successor_readiness_rating` STRING COMMENT 'Assessment of the primary successors readiness to assume the target position. Values indicate timeframe: Ready Now, Ready in 1-2 Years, Ready in 3-5 Years, or Not Ready.. Valid values are `ready_now|ready_1_2_years|ready_3_5_years|not_ready`',
    `review_frequency_months` STRING COMMENT 'Standard interval in months between formal succession plan reviews, typically 6, 12, or 24 months depending on position criticality.',
    `risk_of_loss` STRING COMMENT 'Assessment of the risk that the incumbent may leave the position due to retirement, resignation, promotion, or other factors, creating an immediate succession need.. Valid values are `high|medium|low`',
    `safety_critical_position_flag` BOOLEAN COMMENT 'Indicates whether the target position is classified as safety-critical under HSE regulations, requiring enhanced competency verification and succession planning rigor.',
    `secondary_successor_readiness_rating` STRING COMMENT 'Assessment of the secondary successors readiness to assume the target position. Values indicate timeframe: Ready Now, Ready in 1-2 Years, Ready in 3-5 Years, or Not Ready.. Valid values are `ready_now|ready_1_2_years|ready_3_5_years|not_ready`',
    `talent_pool_category` STRING COMMENT 'Classification of the successor candidates within the organizations talent segmentation framework, identifying their development track and potential.. Valid values are `high_potential|emerging_leader|technical_expert|operational_leader|specialist`',
    `technical_competency_gaps` STRING COMMENT 'Identified gaps in technical skills and competencies that successors must address before assuming the target position, such as reservoir engineering, drilling operations, process safety management, or refinery operations expertise.',
    CONSTRAINT pk_succession_plan PRIMARY KEY(`succession_plan_id`)
) COMMENT 'Master record for succession planning for critical and key positions at Oil Gas, capturing target position, incumbent employee, identified successor employees (primary and secondary), succession readiness rating (Ready Now / Ready in 1-2 Years / Ready in 3-5 Years), development actions required, talent pool category, and plan review date. Supports leadership pipeline management for safety-critical roles such as OIM, Plant Manager, and Chief Drilling Engineer.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`timesheet` (
    `timesheet_id` BIGINT COMMENT 'Unique identifier for the timesheet record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the supervisor or manager who approved this timesheet. Required for audit trail and labor cost validation.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the facility or operational site where the work was performed (e.g., offshore platform, drilling rig, refinery, processing plant, pipeline station).',
    `contractor_id` BIGINT COMMENT 'Reference to the contractor who submitted this timesheet. Links to workforce.contractor for contingent labor. Mutually exclusive with employee_id.',
    `timesheet_employee_id` BIGINT COMMENT 'Reference to the employee who submitted this timesheet. Links to workforce.employee for permanent staff.',
    `well_asset_id` BIGINT COMMENT 'Reference to the specific well where work was performed. Used for drilling, completion, workover, and production operations labor allocation.',
    `amended_timesheet_id` BIGINT COMMENT 'Self-referencing FK on timesheet (amended_timesheet_id)',
    `activity_type` STRING COMMENT 'Classification of the work activity performed (drilling, completion, workover, production operations, maintenance, inspection, Health Safety and Environment activities, administrative, training, standby, travel). [ENUM-REF-CANDIDATE: drilling|completion|workover|production|maintenance|inspection|HSE|administrative|training|standby|travel — 11 candidates stripped; promote to reference product]',
    `afe_number` STRING COMMENT 'Authorization for Expenditure (AFE) number to which labor costs are charged. Primary cost control mechanism for capital projects in oil and gas joint ventures.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the timesheet (draft, submitted, pending approval, approved by supervisor, rejected, revised, posted to payroll and accounting). [ENUM-REF-CANDIDATE: draft|submitted|pending approval|approved|rejected|revised|posted — 7 candidates stripped; promote to reference product]',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the timesheet was approved by the supervisor. Critical for payroll cutoff and period-end close.',
    `business_area` STRING COMMENT 'SAP business area code for segment reporting (e.g., Exploration and Production, Refining, Petrochemicals, Marketing). Enables profitability analysis by business segment.',
    `capitalized_flag` BOOLEAN COMMENT 'Indicates whether the labor hours are capitalized as part of asset construction or development (true) or expensed as operating costs (false). Critical for financial reporting under GAAP and IFRS.',
    `comments` STRING COMMENT 'Free-text comments or notes entered by the employee, contractor, or approver regarding the timesheet. May include work descriptions, exceptions, or clarifications.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity employing the worker or contracting the labor. Required for multi-entity financial consolidation.',
    `cost_center_code` STRING COMMENT 'Cost center code for operational expense (OPEX) allocation. Used when labor is charged to ongoing operations rather than capital projects.',
    `cost_object_type` STRING COMMENT 'Classification of the cost object to which labor hours are allocated (Authorization for Expenditure, Work Breakdown Structure element, cost center, internal order, project, asset).. Valid values are `AFE|WBS|cost center|internal order|project|asset`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the timesheet record was first created in the data platform. Audit trail field.',
    `double_time_hours` DECIMAL(18,2) COMMENT 'Number of hours worked at double-time premium rate, typically for holidays, extended overtime, or hazardous duty conditions.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the timesheet belongs. Used for annual budgeting, forecasting, and financial reporting.',
    `hse_incident_flag` BOOLEAN COMMENT 'Indicates whether a Health Safety and Environment incident occurred during this work shift (true) or not (false). Triggers linkage to incident reporting systems.',
    `internal_order_number` STRING COMMENT 'SAP internal order number for tracking labor costs against specific maintenance, turnaround, or operational campaigns.',
    `jv_partner_code` STRING COMMENT 'Joint Venture partner code for COPAS-compliant labor cost allocation. Used when labor is charged to joint interest billing arrangements.',
    `jv_share_percentage` DECIMAL(18,2) COMMENT 'Percentage share of labor cost allocated to the joint venture partner based on working interest or production sharing agreement terms.',
    `loe_category` STRING COMMENT 'Classification of labor cost within Lease Operating Expense structure (direct field labor, indirect support, overhead allocation, general and administrative). Used for COPAS reporting and SEC reserves disclosure.. Valid values are `direct|indirect|overhead|G&A`',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the timesheet record was last modified. Audit trail field for change tracking.',
    `npt_hours` DECIMAL(18,2) COMMENT 'Number of hours classified as Non-Productive Time (NPT) due to equipment downtime, weather delays, waiting on equipment, or other non-operational activities. Critical for drilling and production efficiency analysis.',
    `offshore_rotation_day` STRING COMMENT 'Day number within the offshore rotation cycle (e.g., day 7 of a 14-day rotation). Used for offshore manning compliance and crew scheduling validation.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours worked beyond the regular threshold. Subject to premium pay rates per FLSA and union agreements.',
    `payroll_period_end_date` DATE COMMENT 'End date of the payroll period to which this timesheet belongs. Determines payroll cutoff and payment date.',
    `payroll_period_start_date` DATE COMMENT 'Start date of the payroll period to which this timesheet belongs. Used for payroll processing and period-end reconciliation.',
    `posting_period` STRING COMMENT 'Financial posting period (YYYYMM format) to which the labor costs are posted in the general ledger. May differ from work_date due to period-end cutoffs.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of regular hours worked during the shift, typically up to standard daily or weekly threshold (e.g., 8 hours per day, 40 hours per week). Basis for base pay calculation.',
    `rejection_reason` STRING COMMENT 'Free-text explanation provided by the approver when rejecting a timesheet. Supports audit trail and employee communication.',
    `sap_cats_reference` STRING COMMENT 'SAP CATS document reference number linking this timesheet to the source system record. Enables traceability to SAP HR and Controlling modules.',
    `shift_type` STRING COMMENT 'Classification of the work shift performed (day shift, night shift, 12-hour tour, swing shift, graveyard shift, split shift). Critical for offshore rotation compliance and shift differential calculation.. Valid values are `day|night|12-hour tour|swing|graveyard|split`',
    `simops_flag` BOOLEAN COMMENT 'Indicates whether the work was performed during Simultaneous Operations (SIMOPS) requiring enhanced coordination and safety protocols (true) or normal operations (false).',
    `standby_hours` DECIMAL(18,2) COMMENT 'Number of hours the worker was on standby or on-call status, available for immediate mobilization. Common in offshore and emergency response roles.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the employee or contractor submitted the timesheet for approval.',
    `timesheet_number` STRING COMMENT 'Human-readable business identifier for the timesheet, often generated by SAP CATS (Cross-Application Time Sheet) or equivalent time recording system.',
    `wbs_element` STRING COMMENT 'SAP Project System (PS) Work Breakdown Structure element code for project-based labor allocation. Used for Engineering, Procurement, and Construction (EPC) and Front-End Engineering Design (FEED) projects.',
    `work_date` DATE COMMENT 'The calendar date on which the work was performed. Primary business event timestamp for labor allocation.',
    `work_location_type` STRING COMMENT 'Classification of the physical work location (offshore platform, onshore field, office, remote site, field location, processing plant, drilling rig, marine vessel). Impacts allowances and labor regulations. [ENUM-REF-CANDIDATE: offshore|onshore|office|remote|field|plant|rig|vessel — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_timesheet PRIMARY KEY(`timesheet_id`)
) COMMENT 'Transactional record of daily or shift-level hours worked by each employee or contractor, capturing work date, shift type (day/night/12-hour tour), regular hours, overtime hours, standby hours, facility or well assignment, cost object (AFE, WBS element, cost center), approval status, approver ID, and SAP CATS timesheet reference. Serves as the upstream source for payroll calculation, offshore rotation compliance, and COPAS-standard labor cost allocation to joint venture partners.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`role_competency_requirement` (
    `role_competency_requirement_id` BIGINT COMMENT 'Unique identifier for this role competency requirement record. Primary key.',
    `competency_id` BIGINT COMMENT 'Foreign key to competency. Identifies the competency that is required for this role.',
    `job_role_id` BIGINT COMMENT 'Foreign key to job_role. Identifies the role for which this competency is required.',
    `assessment_method` STRING COMMENT 'The specific assessment method required to verify competency attainment for this role-competency combination. May override or supplement the default assessment method defined in the competency catalog based on role-specific requirements.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether formal external certification is required for this competency in the context of this role, even if the competency itself does not universally require certification. Used for roles with heightened regulatory or safety requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this role competency requirement record was created.',
    `effective_date` DATE COMMENT 'The date on which this competency requirement became effective for this role. Supports versioning of role competency profiles over time.',
    `expiration_date` DATE COMMENT 'The date on which this competency requirement expires or is scheduled to be removed from this role. Null indicates an ongoing requirement.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this competency is mandatory for the role (must be achieved before assignment) or preferred (desirable but not blocking). Used in recruitment screening and role qualification decisions.',
    `minimum_years_experience` STRING COMMENT 'Minimum number of years of practical experience required with this specific competency for this role. May differ from the roles overall experience requirement as it pertains to this specific competency domain.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this role competency requirement record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this role competency requirement record was last modified.',
    `offshore_critical_flag` BOOLEAN COMMENT 'Indicates whether this competency is critical for offshore operations in this role. Used to enforce offshore manning requirements and ensure compliance with platform safety regulations.',
    `required_proficiency_level` STRING COMMENT 'The minimum proficiency level required for this competency in the context of this specific job role. Awareness indicates basic understanding, Practitioner indicates operational capability, Expert indicates mastery and ability to train others. Drives assessment criteria and training curriculum design.',
    `requirement_status` STRING COMMENT 'Current lifecycle status of this role competency requirement. Active requirements are enforced in recruitment and training. Pending requirements are scheduled for future implementation. Deprecated requirements are being phased out.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this role competency requirement record.',
    CONSTRAINT pk_role_competency_requirement PRIMARY KEY(`role_competency_requirement_id`)
) COMMENT 'This association product represents the competency requirements defined for each job role within Oil Gas. It captures the specific proficiency levels, assessment methods, and criticality flags that govern which competencies are required for personnel to qualify for and maintain each role. Each record links one job role to one competency with attributes that define the requirement parameters used in recruitment screening, training curriculum design, competency assessments, and offshore manning compliance verification.. Existence Justification: In Oil & Gas workforce management, job roles require multiple competencies (e.g., a Drilling Supervisor requires IWCF well control, BOSIET offshore survival, leadership, and HSE competencies), and each competency is required by multiple job roles (e.g., BOSIET is required for all offshore roles across drilling, production, and maintenance). The business actively manages role competency requirements as a foundational framework that drives job descriptions, recruitment screening criteria, training curriculum design, competency assessments, and offshore manning compliance verification.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`position_competency_requirement` (
    `position_competency_requirement_id` BIGINT COMMENT 'Unique identifier for this position-competency requirement record. Primary key.',
    `competency_id` BIGINT COMMENT 'Foreign key linking to the competency definition that is required for this position',
    `position_id` BIGINT COMMENT 'Foreign key linking to the organizational position that has this competency requirement',
    `assessment_frequency_months` STRING COMMENT 'The number of months between required reassessments or recertifications for this competency in the context of this position. May differ from the competencys general validity period based on position risk profile.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this competency requirement record was created.',
    `effective_date` DATE COMMENT 'The date when this competency requirement became or will become effective for this position. Supports versioning of competency requirements as job roles evolve or regulations change.',
    `expiry_date` DATE COMMENT 'The date when this competency requirement expires or is no longer applicable for this position. Null for ongoing requirements. Supports historical tracking of competency matrix changes.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this competency is mandatory for the position (must be met before hire or assignment) or preferred (desirable but not required). This is relationship-specific because a competency may be mandatory for some positions and optional for others.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this competency requirement record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this competency requirement record was last modified.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this specific position-competency pairing is mandated by regulation, contractual obligation, or industry standard (e.g., offshore manning requirements, SIMOPS roles). This is relationship-specific because regulatory mandates apply to specific role-competency combinations.',
    `required_competency_profile_code` STRING COMMENT 'Code linking to the competency profile that defines the skills, certifications, and experience required for this position. Used for recruitment, training planning, and succession management. [Moved from position: This attribute in position currently references a competency profile code as a single value. In a true M:N model, the position-to-competency relationships are captured individually in the association table with specific proficiency levels and mandatory flags. The required_competency_profile_code becomes redundant or should be refactored to reference a profile definition table if profiles are managed as bundles. However, if this code is used for grouping/classification purposes (e.g., Offshore Drilling Profile as a label), it may remain on position. Given the ambiguity, I am flagging it for review but not definitively moving it.]. Valid values are `^[A-Z0-9]{6,12}$`',
    `required_proficiency_level` STRING COMMENT 'The minimum proficiency level required for this competency in the context of this specific position. Values: Awareness, Practitioner, Expert. This attribute exists at the relationship level because the same competency may require different proficiency levels for different positions.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this competency requirement record in the matrix.',
    CONSTRAINT pk_position_competency_requirement PRIMARY KEY(`position_competency_requirement_id`)
) COMMENT 'This association product represents the competency requirements matrix between organizational positions and competency definitions. It captures which competencies are required for each position, at what proficiency level, whether they are mandatory, and the assessment schedule. Each record links one position to one competency with attributes that exist only in the context of this requirement relationship. This is the operational artifact that drives recruitment screening, training needs analysis, succession planning, and offshore manning compliance verification.. Existence Justification: In Oil & Gas workforce management, positions require multiple competencies (e.g., an Offshore Installation Manager position requires BOSIET, HUET, Leadership, SIMOPS coordination, HSE management competencies), and each competency is required by multiple positions (e.g., BOSIET is required for all offshore roles). HR and Workforce Planning teams actively manage the competency requirements matrix, defining which competencies are mandatory for each position, at what proficiency level, and with what assessment frequency. This matrix drives recruitment screening, training planning, succession planning, and regulatory compliance verification for offshore manning.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`training_program` (
    `training_program_id` BIGINT COMMENT 'Primary key for training_program',
    `prerequisite_program_id` BIGINT COMMENT 'Identifier of a prerequisite training program, if any.',
    `parent_training_program_id` BIGINT COMMENT 'Self-referencing FK on training_program (parent_training_program_id)',
    `assessment_type` STRING COMMENT 'Method used to evaluate participant competence.',
    `certification_awarded` STRING COMMENT 'Name of the certification granted upon successful completion.',
    `certification_expiry_months` STRING COMMENT 'Validity period of the certification in months.',
    `compliance_requirement` STRING COMMENT 'Regulatory or internal compliance standards the program satisfies (e.g., OSHA, ISO 45001).',
    `cost` DECIMAL(18,2) COMMENT 'Monetary cost to enroll in the program.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Accredited credit hours awarded upon completion.',
    `currency` STRING COMMENT 'Three‑letter ISO currency code for the program cost.',
    `delivery_method` STRING COMMENT 'Mode through which the training is delivered.',
    `training_program_description` STRING COMMENT 'Detailed description of the program content and objectives.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total length of the program in hours.',
    `effective_end_date` DATE COMMENT 'Date when the program is retired or no longer offered (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the program becomes valid for enrollment.',
    `enrollment_cap` STRING COMMENT 'Maximum number of participants allowed per session.',
    `evaluation_method` STRING COMMENT 'Method used to evaluate the effectiveness of the training program.',
    `feedback_deadline_days` STRING COMMENT 'Number of days after completion by which feedback must be submitted.',
    `feedback_required` BOOLEAN COMMENT 'Indicates whether participant feedback is collected after completion.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the program is required for the assigned roles.',
    `language` STRING COMMENT 'Primary language of instruction.',
    `last_offered_date` DATE COMMENT 'Most recent date the program was delivered.',
    `location` STRING COMMENT 'Physical location where onsite training occurs (if applicable).',
    `mandatory_for_roles` STRING COMMENT 'Roles for which the program is mandatory (comma‑separated).',
    `material_url` STRING COMMENT 'Link to downloadable training materials or resources.',
    `max_attempts` STRING COMMENT 'Maximum number of times a participant may attempt the assessment.',
    `training_program_name` STRING COMMENT 'Human‑readable name of the training program.',
    `online_access_url` STRING COMMENT 'Web address where participants can access the online version of the program.',
    `owner_department` STRING COMMENT 'Department responsible for maintaining the program.',
    `pass_score_percent` DECIMAL(18,2) COMMENT 'Minimum percentage required to pass the assessment.',
    `program_code` STRING COMMENT 'External code used to reference the program in corporate systems.',
    `program_type` STRING COMMENT 'Category of the training program.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the training program record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the training program record.',
    `revision_date` DATE COMMENT 'Date of the latest revision to the program content.',
    `skill_level` STRING COMMENT 'Proficiency level the program addresses.',
    `training_program_status` STRING COMMENT 'Current lifecycle state of the program.',
    `target_audience` STRING COMMENT 'Intended audience of the program (e.g., field crew, engineers).',
    `training_provider` STRING COMMENT 'Organization or vendor delivering the training.',
    `version_number` STRING COMMENT 'Version identifier for the program definition.',
    CONSTRAINT pk_training_program PRIMARY KEY(`training_program_id`)
) COMMENT 'Master reference table for training_program. Referenced by training_program_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`crew` (
    `crew_id` BIGINT COMMENT 'Primary key for crew',
    `crew_leader_employee_id` BIGINT COMMENT 'Internal employee identifier for the crew leader.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager responsible for the crew.',
    `relief_crew_id` BIGINT COMMENT 'Self-referencing FK on crew (relief_crew_id)',
    `base_address` STRING COMMENT 'Physical address of the crews home base or office.',
    `contact_email` STRING COMMENT 'Primary email address for crew communications.',
    `contact_phone` STRING COMMENT 'Primary telephone number for crew communications.',
    `cost_center_code` STRING COMMENT 'Financial cost‑center to which crew labor costs are allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the crew record was first created in the system.',
    `crew_availability_status` STRING COMMENT 'Current availability of the crew for assignment.',
    `crew_average_experience_years` DECIMAL(18,2) COMMENT 'Mean years of experience across all crew members.',
    `crew_capacity` STRING COMMENT 'Maximum number of personnel the crew can accommodate.',
    `crew_certifications` STRING COMMENT 'Comma‑separated list of industry certifications held by the crew.',
    `crew_code` STRING COMMENT 'External business code or tag that uniquely identifies the crew across systems.',
    `crew_contract_end_date` DATE COMMENT 'Date when the crews current contract ends (null if open‑ended).',
    `crew_contract_start_date` DATE COMMENT 'Date when the crews current contract began.',
    `crew_contract_type` STRING COMMENT 'Nature of the crews employment agreement.',
    `crew_created_by` STRING COMMENT 'User or system that originally created the crew record.',
    `crew_is_overtime_allowed` BOOLEAN COMMENT 'Indicates whether the crew is permitted to work overtime.',
    `crew_language` STRING COMMENT 'Primary language spoken by the crew members.',
    `crew_last_modified_by` STRING COMMENT 'User or system that performed the most recent update.',
    `crew_leader_name` STRING COMMENT 'Legal full name of the crew leader.',
    `crew_name` STRING COMMENT 'Human‑readable name of the crew used for scheduling and reporting.',
    `crew_operating_company` STRING COMMENT 'Legal entity within Oil Gas that employs or contracts the crew.',
    `crew_region` STRING COMMENT 'Geographic region (e.g., North America, Middle East) where the crew primarily operates.',
    `crew_safety_score` DECIMAL(18,2) COMMENT 'Aggregated safety performance metric for the crew (0‑100 scale).',
    `crew_size` STRING COMMENT 'Number of personnel assigned to the crew.',
    `crew_time_zone` STRING COMMENT 'Time zone identifier (e.g., America/Chicago) for crew scheduling.',
    `crew_type` STRING COMMENT 'Category of crew based on primary function (e.g., drilling, maintenance).',
    `crew_union_affiliation` STRING COMMENT 'Labor union to which the crew belongs, if any.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary values associated with the crew.',
    `effective_end_date` DATE COMMENT 'Date when the crew ceased to be operationally active (null if still active).',
    `effective_start_date` DATE COMMENT 'Date when the crew became operationally active.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Standard hourly labor rate for the crew (currency defined by currency_code).',
    `hse_certified` BOOLEAN COMMENT 'Indicates whether the crew holds current Health, Safety, and Environment certification.',
    `last_training_date` DATE COMMENT 'Date of the most recent mandatory safety or technical training for the crew.',
    `location` STRING COMMENT 'Primary geographic location or site where the crew is based.',
    `notes` STRING COMMENT 'Free‑form notes or remarks about the crew.',
    `primary_skill` STRING COMMENT 'Core competency or trade skill of the crew (e.g., rigging, welding).',
    `shift_type` STRING COMMENT 'Standard shift pattern for the crew.',
    `crew_status` STRING COMMENT 'Current lifecycle state of the crew.',
    `training_status` STRING COMMENT 'Current compliance status of required crew training.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the crew record.',
    CONSTRAINT pk_crew PRIMARY KEY(`crew_id`)
) COMMENT 'Master reference table for crew. Referenced by relief_crew_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`workforce`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Primary key for payroll_run',
    `employee_id` BIGINT COMMENT 'Identifier of the employee (or primary party) for whom the payroll run is executed.',
    `processed_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user who executed the payroll run.',
    `parent_payroll_run_id` BIGINT COMMENT 'Self-referencing FK on payroll_run (parent_payroll_run_id)',
    `adjustment_reason` STRING COMMENT 'Narrative explaining why the payroll run is an adjustment.',
    `approval_status` STRING COMMENT 'Current approval state of the payroll run.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the payroll run was approved or rejected.',
    `benefits_total` DECIMAL(18,2) COMMENT 'Aggregate cost of employer‑provided benefits for the payroll run.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the payroll amounts.',
    `deductions_total` DECIMAL(18,2) COMMENT 'Sum of all pre‑tax and post‑tax deductions applied in the payroll run.',
    `fiscal_year` STRING COMMENT 'Company fiscal year associated with the payroll run.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross earnings before taxes, deductions, and benefits.',
    `is_adjustment` BOOLEAN COMMENT 'True if the payroll run represents a correction or retroactive adjustment.',
    `is_manual_run` BOOLEAN COMMENT 'Flag indicating whether the payroll run was entered manually (true) or generated automatically (false).',
    `net_amount` DECIMAL(18,2) COMMENT 'Net pay after taxes, deductions, and benefits are applied.',
    `number_of_employees` STRING COMMENT 'Count of distinct employees included in this payroll run.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Aggregate overtime hours worked for all employees in the run.',
    `pay_cycle` STRING COMMENT 'Frequency at which employees are paid for this run.',
    `pay_period_end_date` DATE COMMENT 'Last calendar date of the pay period covered by this run.',
    `pay_period_start_date` DATE COMMENT 'First calendar date of the pay period covered by this run.',
    `payroll_run_description` STRING COMMENT 'Free‑form text describing the purpose or notes for the payroll run.',
    `payroll_run_version` STRING COMMENT 'Version number for the payroll run record to support optimistic concurrency.',
    `payroll_type` STRING COMMENT 'Classification of the payroll run (e.g., regular salary, overtime, bonus).',
    `run_number` STRING COMMENT 'Human‑readable sequential number assigned to each payroll run.',
    `run_timestamp` TIMESTAMP COMMENT 'Date‑time when the payroll run was initiated.',
    `source_system` STRING COMMENT 'Originating system that generated the payroll run record.',
    `payroll_run_status` STRING COMMENT 'Current processing state of the payroll run.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Aggregate tax withheld for the payroll run.',
    `tax_year` STRING COMMENT 'Fiscal year used for tax reporting of this payroll run.',
    `total_hours` DECIMAL(18,2) COMMENT 'Aggregate regular hours worked for all employees in the run.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the payroll run record.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Master reference table for payroll_run. Referenced by payroll_run_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_job_role_id` FOREIGN KEY (`job_role_id`) REFERENCES `oil_gas_ecm`.`workforce`.`job_role`(`job_role_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_position_id` FOREIGN KEY (`position_id`) REFERENCES `oil_gas_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_supervisor_employee_id` FOREIGN KEY (`supervisor_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_role_id` FOREIGN KEY (`job_role_id`) REFERENCES `oil_gas_ecm`.`workforce`.`job_role`(`job_role_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `oil_gas_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `oil_gas_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `oil_gas_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_competency_id` FOREIGN KEY (`competency_id`) REFERENCES `oil_gas_ecm`.`workforce`.`competency`(`competency_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `oil_gas_ecm`.`workforce`.`training_program`(`training_program_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_competency_id` FOREIGN KEY (`competency_id`) REFERENCES `oil_gas_ecm`.`workforce`.`competency`(`competency_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ADD CONSTRAINT `fk_workforce_workforce_training_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ADD CONSTRAINT `fk_workforce_workforce_training_record_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `oil_gas_ecm`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ADD CONSTRAINT `fk_workforce_crew_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ADD CONSTRAINT `fk_workforce_crew_schedule_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `oil_gas_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_crew_schedule_id` FOREIGN KEY (`crew_schedule_id`) REFERENCES `oil_gas_ecm`.`workforce`.`crew_schedule`(`crew_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ADD CONSTRAINT `fk_workforce_pob_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `oil_gas_ecm`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `oil_gas_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_original_allocation_labor_cost_allocation_id` FOREIGN KEY (`original_allocation_labor_cost_allocation_id`) REFERENCES `oil_gas_ecm`.`workforce`.`labor_cost_allocation`(`labor_cost_allocation_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `oil_gas_ecm`.`workforce`.`plan`(`plan_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_primary_leave_employee_id` FOREIGN KEY (`primary_leave_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ADD CONSTRAINT `fk_workforce_mobilization_event_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `oil_gas_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ADD CONSTRAINT `fk_workforce_mobilization_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ADD CONSTRAINT `fk_workforce_hse_induction_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `oil_gas_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ADD CONSTRAINT `fk_workforce_hse_induction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ADD CONSTRAINT `fk_workforce_hse_induction_primary_hse_employee_id` FOREIGN KEY (`primary_hse_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ADD CONSTRAINT `fk_workforce_medical_fitness_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `oil_gas_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ADD CONSTRAINT `fk_workforce_medical_fitness_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ADD CONSTRAINT `fk_workforce_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ADD CONSTRAINT `fk_workforce_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `oil_gas_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ADD CONSTRAINT `fk_workforce_plan_owner_employee_id` FOREIGN KEY (`owner_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_job_role_id` FOREIGN KEY (`job_role_id`) REFERENCES `oil_gas_ecm`.`workforce`.`job_role`(`job_role_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `oil_gas_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_position_id` FOREIGN KEY (`position_id`) REFERENCES `oil_gas_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_tertiary_recruitment_recruiter_employee_id` FOREIGN KEY (`tertiary_recruitment_recruiter_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_recruitment_requisition_id` FOREIGN KEY (`recruitment_requisition_id`) REFERENCES `oil_gas_ecm`.`workforce`.`recruitment_requisition`(`recruitment_requisition_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ADD CONSTRAINT `fk_workforce_work_permit_visa_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `oil_gas_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ADD CONSTRAINT `fk_workforce_work_permit_visa_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `oil_gas_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_primary_successor_employee_id` FOREIGN KEY (`primary_successor_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_quaternary_succession_approved_by_employee_id` FOREIGN KEY (`quaternary_succession_approved_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_position_id` FOREIGN KEY (`position_id`) REFERENCES `oil_gas_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_tertiary_succession_hr_business_partner_employee_id` FOREIGN KEY (`tertiary_succession_hr_business_partner_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `oil_gas_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_timesheet_employee_id` FOREIGN KEY (`timesheet_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_amended_timesheet_id` FOREIGN KEY (`amended_timesheet_id`) REFERENCES `oil_gas_ecm`.`workforce`.`timesheet`(`timesheet_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`role_competency_requirement` ADD CONSTRAINT `fk_workforce_role_competency_requirement_competency_id` FOREIGN KEY (`competency_id`) REFERENCES `oil_gas_ecm`.`workforce`.`competency`(`competency_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`role_competency_requirement` ADD CONSTRAINT `fk_workforce_role_competency_requirement_job_role_id` FOREIGN KEY (`job_role_id`) REFERENCES `oil_gas_ecm`.`workforce`.`job_role`(`job_role_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`position_competency_requirement` ADD CONSTRAINT `fk_workforce_position_competency_requirement_competency_id` FOREIGN KEY (`competency_id`) REFERENCES `oil_gas_ecm`.`workforce`.`competency`(`competency_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`position_competency_requirement` ADD CONSTRAINT `fk_workforce_position_competency_requirement_position_id` FOREIGN KEY (`position_id`) REFERENCES `oil_gas_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_program` ADD CONSTRAINT `fk_workforce_training_program_prerequisite_program_id` FOREIGN KEY (`prerequisite_program_id`) REFERENCES `oil_gas_ecm`.`workforce`.`training_program`(`training_program_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_program` ADD CONSTRAINT `fk_workforce_training_program_parent_training_program_id` FOREIGN KEY (`parent_training_program_id`) REFERENCES `oil_gas_ecm`.`workforce`.`training_program`(`training_program_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_crew_leader_employee_id` FOREIGN KEY (`crew_leader_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_relief_crew_id` FOREIGN KEY (`relief_crew_id`) REFERENCES `oil_gas_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_processed_by_user_employee_id` FOREIGN KEY (`processed_by_user_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_parent_payroll_run_id` FOREIGN KEY (`parent_payroll_run_id`) REFERENCES `oil_gas_ecm`.`workforce`.`payroll_run`(`payroll_run_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `oil_gas_ecm`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `job_role_id` SET TAGS ('dbx_business_glossary_term' = 'Job Role Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Identifier');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `competency_level` SET TAGS ('dbx_business_glossary_term' = 'Competency Level');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `competency_level` SET TAGS ('dbx_value_regex' = 'entry|intermediate|advanced|expert|master');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Employee Date of Birth');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Employee Email Address');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_value_regex' = 'spouse|parent|sibling|child|friend|other');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|leave|terminated');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'staff|contract|secondee|temporary|intern');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Employee First Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Full Legal Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `home_country` SET TAGS ('dbx_business_glossary_term' = 'Home Country');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `home_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `hse_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Certification Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `hse_certification_status` SET TAGS ('dbx_value_regex' = 'current|expired|pending|not_required');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `last_hse_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Health Safety and Environment (HSE) Training Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Last Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Middle Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Mobile Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `national_code` SET TAGS ('dbx_business_glossary_term' = 'National Identification Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `national_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `national_code` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `next_hse_training_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Health Safety and Environment (HSE) Training Due Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `offshore_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'Offshore Qualified Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `passport_number` SET TAGS ('dbx_business_glossary_term' = 'Passport Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `passport_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `passport_number` SET TAGS ('dbx_pii_passport' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Phone Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Preferred Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `rig_rotation_schedule` SET TAGS ('dbx_business_glossary_term' = 'Rig Rotation Schedule');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `sap_personnel_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Human Resources (HR) Personnel Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `sap_personnel_number` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_value_regex' = 'none|basic|confidential|secret|top_secret');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'resignation|retirement|layoff|dismissal|contract_end|mutual_agreement');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `union_membership_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `work_country` SET TAGS ('dbx_business_glossary_term' = 'Work Country');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `work_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`employee` ALTER COLUMN `work_location` SET TAGS ('dbx_business_glossary_term' = 'Work Location');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Identifier');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `background_check_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|cleared|flagged|expired');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `badge_number` SET TAGS ('dbx_business_glossary_term' = 'Contractor Badge Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `badge_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `badge_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `company_name` SET TAGS ('dbx_business_glossary_term' = 'Contractor Company Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `competency_level` SET TAGS ('dbx_business_glossary_term' = 'Contractor Competency Level');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `competency_level` SET TAGS ('dbx_value_regex' = 'trainee|competent|advanced|expert|supervisor|lead');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `demobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Contractor Demobilization Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `drug_alcohol_test_date` SET TAGS ('dbx_business_glossary_term' = 'Drug and Alcohol Test Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `drug_alcohol_test_status` SET TAGS ('dbx_business_glossary_term' = 'Drug and Alcohol Test Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `drug_alcohol_test_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_required');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Contractor Email Address');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contractor First Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `h2s_exposure_category` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Exposure Category');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `h2s_exposure_category` SET TAGS ('dbx_value_regex' = 'none|low|medium|high');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Contractor Hourly Rate');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `hse_induction_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Induction Completion Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `hse_induction_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Induction Expiry Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `hse_induction_status` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Induction Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `hse_induction_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|expired');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contractor Last Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `medical_fitness_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Fitness Expiry Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `medical_fitness_expiry_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `medical_fitness_expiry_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `medical_fitness_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Fitness Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `medical_fitness_status` SET TAGS ('dbx_value_regex' = 'fit|fit_with_restrictions|temporarily_unfit|permanently_unfit|pending');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `medical_fitness_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `medical_fitness_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `mobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Contractor Mobilization Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `mobilization_status` SET TAGS ('dbx_business_glossary_term' = 'Contractor Mobilization Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `mobilization_status` SET TAGS ('dbx_value_regex' = 'pending|mobilized|demobilized|on_leave|suspended');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `norm_exposure_category` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Exposure Category');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `norm_exposure_category` SET TAGS ('dbx_value_regex' = 'none|low|medium|high');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `offshore_survival_training_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Offshore Survival Training Expiry Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `offshore_survival_training_status` SET TAGS ('dbx_business_glossary_term' = 'Offshore Survival Training Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `offshore_survival_training_status` SET TAGS ('dbx_value_regex' = 'not_required|current|expired|pending');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `overtime_rate` SET TAGS ('dbx_business_glossary_term' = 'Contractor Overtime Rate');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `overtime_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contractor Phone Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `ptw_authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Authorization Level');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `ptw_authorization_level` SET TAGS ('dbx_value_regex' = 'none|requester|approver|issuer');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `role_classification` SET TAGS ('dbx_business_glossary_term' = 'Contractor Role Classification');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `role_classification` SET TAGS ('dbx_value_regex' = 'drilling_crew|completion_crew|production_operator|maintenance_technician|hse_advisor|geologist');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `twic_card_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Transportation Worker Identification Credential (TWIC) Card Expiry Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `twic_card_number` SET TAGS ('dbx_business_glossary_term' = 'Transportation Worker Identification Credential (TWIC) Card Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `twic_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `twic_card_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`contractor` ALTER COLUMN `work_schedule_pattern` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Pattern');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'crew_operations');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `job_role_id` SET TAGS ('dbx_business_glossary_term' = 'Job Role Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `reports_to_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Position Identifier');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `budgeted_flag` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Position Effective Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temporary|seasonal|intern');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Position End Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `filled_flag` SET TAGS ('dbx_business_glossary_term' = 'Filled Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `fte_count` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `grade_band` SET TAGS ('dbx_business_glossary_term' = 'Grade Band');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `grade_band` SET TAGS ('dbx_value_regex' = '^(G[0-9]{1,2}|E[0-9]{1,2}|M[0-9]{1,2}|S[0-9]{1,2})$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `minimum_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years of Experience');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `offshore_manning_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Offshore Manning Requirement Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'active|vacant|frozen|eliminated|pending_approval|filled');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `rotation_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Rotation Schedule Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `safety_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety-Critical Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `simops_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Role Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `succession_plan_priority` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Priority');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `succession_plan_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|none');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `union_affiliation_code` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `union_affiliation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{0,10}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `work_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'crew_operations');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `business_segment` SET TAGS ('dbx_business_glossary_term' = 'Business Segment');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `current_headcount` SET TAGS ('dbx_business_glossary_term' = 'Current Headcount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = 'north_america|south_america|europe|middle_east|africa|asia_pacific');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `hse_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Jurisdiction');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `is_joint_venture` SET TAGS ('dbx_business_glossary_term' = 'Is Joint Venture Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `jv_operator_flag` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Operator Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `manning_requirement_count` SET TAGS ('dbx_business_glossary_term' = 'Manning Requirement Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `operational_area` SET TAGS ('dbx_business_glossary_term' = 'Operational Area');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `operational_area` SET TAGS ('dbx_value_regex' = 'offshore|onshore|midstream|downstream|corporate_office');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Description');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_value_regex' = 'business_unit|division|department|cost_center|region|district');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `safety_performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Safety Performance Tier');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `safety_performance_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Short Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `union_representation_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Representation Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`org_unit` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `job_role_id` SET TAGS ('dbx_business_glossary_term' = 'Job Role Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `afe_approval_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Approval Limit (USD)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `afe_approval_limit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `api_occupational_classification` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Occupational Classification');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_business_glossary_term' = 'Compensation Grade');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,2}[0-9]{1,2}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `confined_space_entry_flag` SET TAGS ('dbx_business_glossary_term' = 'Confined Space Entry Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `environmental_conditions_description` SET TAGS ('dbx_business_glossary_term' = 'Environmental Conditions Description');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'Exempt|Non-Exempt');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `h2s_exposure_flag` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Exposure Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `hot_work_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Hot Work Authorization Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `job_role_status` SET TAGS ('dbx_business_glossary_term' = 'Role Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `job_role_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Obsolete|Under Review|Pending Approval|Archived');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `job_sub_family` SET TAGS ('dbx_business_glossary_term' = 'Job Sub-Family');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `minimum_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years of Experience');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `moc_approval_authority_flag` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Approval Authority Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `norm_exposure_flag` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Exposure Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `offshore_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Offshore Applicable Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `onshore_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Onshore Applicable Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `opex_approval_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Approval Limit (USD)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `opex_approval_limit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `physical_demands_description` SET TAGS ('dbx_business_glossary_term' = 'Physical Demands Description');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `preferred_certifications` SET TAGS ('dbx_business_glossary_term' = 'Preferred Certifications');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `preferred_education_level` SET TAGS ('dbx_business_glossary_term' = 'Preferred Education Level');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `preferred_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Preferred Years of Experience');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `ptw_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Authority Level');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `ptw_authority_level` SET TAGS ('dbx_value_regex' = 'None|Requester|Approver|Issuer|Area Authority');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `role_code` SET TAGS ('dbx_business_glossary_term' = 'Role Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `role_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `role_detailed_description` SET TAGS ('dbx_business_glossary_term' = 'Role Detailed Description');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `role_short_description` SET TAGS ('dbx_business_glossary_term' = 'Role Short Description');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `role_title` SET TAGS ('dbx_business_glossary_term' = 'Role Title');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `rotation_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Rotation Schedule Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `rotation_schedule_type` SET TAGS ('dbx_value_regex' = 'None|14/14|21/21|28/28|Custom|Variable');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `safety_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety-Critical Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `simops_coordination_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Coordination Required Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `soc_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Occupational Classification (SOC) Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `soc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `supervisory_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Role Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `oil_gas_ecm`.`workforce`.`job_role` ALTER COLUMN `typical_direct_reports_count` SET TAGS ('dbx_business_glossary_term' = 'Typical Direct Reports Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` SET TAGS ('dbx_subdomain' = 'workforce_development');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `competency_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `applicable_job_roles` SET TAGS ('dbx_business_glossary_term' = 'Applicable Job Roles');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'Written Exam|Practical Assessment|Simulator|On-the-Job Evaluation|Interview|Portfolio Review');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `competency_category` SET TAGS ('dbx_business_glossary_term' = 'Competency Category');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `competency_code` SET TAGS ('dbx_business_glossary_term' = 'Competency Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `competency_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `competency_description` SET TAGS ('dbx_business_glossary_term' = 'Competency Description');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `competency_name` SET TAGS ('dbx_business_glossary_term' = 'Competency Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `competency_status` SET TAGS ('dbx_business_glossary_term' = 'Competency Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `competency_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Deprecated|Under Review|Draft');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `competency_type` SET TAGS ('dbx_business_glossary_term' = 'Competency Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `competency_type` SET TAGS ('dbx_value_regex' = 'Core|Specialized|Mandatory|Optional|Certification');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `governing_body_standard` SET TAGS ('dbx_business_glossary_term' = 'Governing Body Standard');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `hse_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Critical Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `offshore_manning_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Offshore Manning Requirement Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Competency Owner');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `prerequisite_competencies` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Competencies');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `proficiency_level_required` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level Required');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `proficiency_level_required` SET TAGS ('dbx_value_regex' = 'Awareness|Practitioner|Expert|Master');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `simops_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Applicable Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `training_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration (Hours)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `validity_period_months` SET TAGS ('dbx_business_glossary_term' = 'Validity Period (Months)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` SET TAGS ('dbx_subdomain' = 'workforce_development');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `competency_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Assessment ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `competency_id` SET TAGS ('dbx_business_glossary_term' = 'Competency ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessee ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `training_program_id` SET TAGS ('dbx_business_glossary_term' = 'Training Program ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_cost` SET TAGS ('dbx_business_glossary_term' = 'Assessment Cost');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Duration Minutes');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_language` SET TAGS ('dbx_business_glossary_term' = 'Assessment Language');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_location` SET TAGS ('dbx_business_glossary_term' = 'Assessment Location');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'written_exam|practical_demonstration|simulation|observation|oral_examination|portfolio_review');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_value_regex' = '^CA-[0-9]{8}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|no_show');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'initial|recertification|refresher|remedial|spot_check|annual');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_vendor` SET TAGS ('dbx_business_glossary_term' = 'Assessment Vendor');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `assessor_qualification` SET TAGS ('dbx_business_glossary_term' = 'Assessor Qualification');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `certification_issued` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `certification_number` SET TAGS ('dbx_value_regex' = '^CERT-[A-Z0-9]{10}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `certification_valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Valid From Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `hse_critical_competency` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Critical Competency');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `offshore_manning_compliant` SET TAGS ('dbx_business_glossary_term' = 'Offshore Manning Compliant');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `pass_fail_outcome` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Outcome');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `pass_fail_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|incomplete');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_value_regex' = 'novice|competent|proficient|expert|master');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `regulatory_requirement_met` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Met');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `remedial_action_description` SET TAGS ('dbx_business_glossary_term' = 'Remedial Action Description');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `remedial_action_required` SET TAGS ('dbx_business_glossary_term' = 'Remedial Action Required');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `score_achieved` SET TAGS ('dbx_business_glossary_term' = 'Score Achieved');
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ALTER COLUMN `simops_qualified` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Qualified');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` SET TAGS ('dbx_subdomain' = 'workforce_development');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `workforce_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Certification Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `competency_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'BOSIET|HUET|H2S Awareness|IWCF|IADC WellCAP|OSHA 30-Hour');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `competency_level` SET TAGS ('dbx_business_glossary_term' = 'Competency Level');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `competency_level` SET TAGS ('dbx_value_regex' = 'Basic|Intermediate|Advanced|Expert|Instructor');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `endorsement_details` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Details');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `facility_applicability` SET TAGS ('dbx_business_glossary_term' = 'Facility Applicability');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `hse_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Critical Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `job_role_applicability` SET TAGS ('dbx_business_glossary_term' = 'Job Role Applicability');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `next_renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Due Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `offshore_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Offshore Required Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `simops_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Required Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'Document Review|Issuing Body Confirmation|Third-Party Service|Self-Attestation|Database Lookup');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'Verified|Pending Verification|Not Verified|Verification Failed');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `workforce_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `workforce_certification_status` SET TAGS ('dbx_value_regex' = 'Active|Expired|Suspended|Revoked|Pending Renewal|In Progress');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_certification` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` SET TAGS ('dbx_subdomain' = 'workforce_development');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `approved_training_provider` SET TAGS ('dbx_business_glossary_term' = 'Approved Training Provider');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `certification_issued` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `competency_level` SET TAGS ('dbx_business_glossary_term' = 'Competency Level');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `competency_level` SET TAGS ('dbx_value_regex' = 'Awareness|Foundation|Intermediate|Advanced|Expert');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `continuing_education_credits` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Credits');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Participant');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `course_category` SET TAGS ('dbx_business_glossary_term' = 'Course Category');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `course_category` SET TAGS ('dbx_value_regex' = 'HSE|Technical|Leadership|Regulatory|Operational|Compliance');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `course_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `course_description` SET TAGS ('dbx_business_glossary_term' = 'Course Description');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `course_materials` SET TAGS ('dbx_business_glossary_term' = 'Course Materials');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `course_owner` SET TAGS ('dbx_business_glossary_term' = 'Course Owner');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `course_status` SET TAGS ('dbx_business_glossary_term' = 'Course Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `course_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Under Review|Retired|Pending Approval');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `course_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Course Subcategory');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `course_title` SET TAGS ('dbx_business_glossary_term' = 'Course Title');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Delivery Mode');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_value_regex' = 'Classroom|E-Learning|Simulator|OJT|Blended|Virtual');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `language_offered` SET TAGS ('dbx_business_glossary_term' = 'Language Offered');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `learning_management_system_code` SET TAGS ('dbx_business_glossary_term' = 'Learning Management System (LMS) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `maximum_class_size` SET TAGS ('dbx_business_glossary_term' = 'Maximum Class Size');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `offshore_required` SET TAGS ('dbx_business_glossary_term' = 'Offshore Required Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `prerequisites` SET TAGS ('dbx_business_glossary_term' = 'Course Prerequisites');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `provider_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Provider Accreditation');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `recertification_required` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `simops_applicable` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Applicable Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `subject_matter_expert` SET TAGS ('dbx_business_glossary_term' = 'Subject Matter Expert (SME)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `validity_period_months` SET TAGS ('dbx_business_glossary_term' = 'Validity Period Months');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_course` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` SET TAGS ('dbx_subdomain' = 'workforce_development');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `workforce_training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Training Record ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `attendance_status` SET TAGS ('dbx_business_glossary_term' = 'Attendance Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `attendance_status` SET TAGS ('dbx_value_regex' = 'Attended|Absent|Partial|Excused|Rescheduled');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `bsee_site_access_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Bureau of Safety and Environmental Enforcement (BSEE) Site Access Verified Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `competency_level_achieved` SET TAGS ('dbx_business_glossary_term' = 'Competency Level Achieved');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `competency_level_achieved` SET TAGS ('dbx_value_regex' = 'Awareness|Basic|Intermediate|Advanced|Expert|Certified');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'Classroom|Online|On-Site|Simulator|Field Demonstration|Blended');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `enablon_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Enablon Record Reference');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `osha_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Record Reference');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'Pass|Fail|Incomplete|Waived|Not Assessed');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'Active|Archived|Superseded|Voided');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `refresher_due_date` SET TAGS ('dbx_business_glossary_term' = 'Refresher Due Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `supervisor_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Approval Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `topics_covered` SET TAGS ('dbx_business_glossary_term' = 'Topics Covered');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `training_cost` SET TAGS ('dbx_business_glossary_term' = 'Training Cost');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `training_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `training_date` SET TAGS ('dbx_business_glossary_term' = 'Training Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `training_language` SET TAGS ('dbx_business_glossary_term' = 'Training Language');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `training_materials_provided` SET TAGS ('dbx_business_glossary_term' = 'Training Materials Provided');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = 'HSE Induction|Technical Competency|OSHA Mandatory|Certification|Refresher|SIMOPS');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` SET TAGS ('dbx_subdomain' = 'crew_operations');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `crew_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Schedule Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `joint_venture_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Coordinator Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Relief Crew Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `bed_down_capacity` SET TAGS ('dbx_business_glossary_term' = 'Bed Down Capacity');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `budget_afe_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `crew_complement_size` SET TAGS ('dbx_business_glossary_term' = 'Crew Complement Size');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `emergency_response_team_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Team Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `hse_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Certification Required Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `labor_cost_center` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Center');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `minimum_offshore_experience_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Offshore Experience Days');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `mobilization_location` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Location');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `operator_company_code` SET TAGS ('dbx_business_glossary_term' = 'Operator Company Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `rest_days_per_cycle` SET TAGS ('dbx_business_glossary_term' = 'Rest Days Per Cycle');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `rotation_pattern` SET TAGS ('dbx_business_glossary_term' = 'Rotation Pattern');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Schedule Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `schedule_priority` SET TAGS ('dbx_business_glossary_term' = 'Schedule Priority');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|suspended|archived');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'offshore_platform|fpso|drilling_rig|onshore_plant|refinery|construction');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `simops_coordination_flag` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Coordination Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'helicopter|crew_boat|fixed_wing|road_transport|combination');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `union_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `weather_contingency_days` SET TAGS ('dbx_business_glossary_term' = 'Weather Contingency Days');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ALTER COLUMN `work_days_per_cycle` SET TAGS ('dbx_business_glossary_term' = 'Work Days Per Cycle');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` SET TAGS ('dbx_subdomain' = 'crew_operations');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `crew_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `crew_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Schedule Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `actual_rotation_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Rotation Days');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_value_regex' = 'CRITICAL|HIGH|NORMAL|STANDBY');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_remarks` SET TAGS ('dbx_business_glossary_term' = 'Assignment Remarks');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'SCHEDULED|MOBILIZED|ON_BOARD|DEMOBILIZED|CANCELLED|RELIEVED');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `cabin_number` SET TAGS ('dbx_business_glossary_term' = 'Cabin Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `crew_role_code` SET TAGS ('dbx_business_glossary_term' = 'Crew Role Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `demobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `demobilization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `h2s_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Certification Expiry Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `h2s_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Certification Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `helideck_manifest_reference` SET TAGS ('dbx_business_glossary_term' = 'Helideck Manifest Reference');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `hse_induction_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Induction Completed Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `hse_induction_date` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Induction Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `medical_fitness_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Fitness Clearance Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `medical_fitness_clearance_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `medical_fitness_clearance_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `medical_fitness_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Fitness Expiry Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `medical_fitness_expiry_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `medical_fitness_expiry_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `mobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `mobilization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `muster_station_code` SET TAGS ('dbx_business_glossary_term' = 'Muster Station Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `origin_location` SET TAGS ('dbx_business_glossary_term' = 'Origin Location');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `planned_rotation_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Rotation Days');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `pob_status` SET TAGS ('dbx_business_glossary_term' = 'Personnel On Board (POB) Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `pob_status` SET TAGS ('dbx_value_regex' = 'ON_BOARD|OFF_BOARD|IN_TRANSIT');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `rotation_number` SET TAGS ('dbx_business_glossary_term' = 'Rotation Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `simops_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Clearance Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'HELICOPTER|VESSEL|COMMERCIAL_FLIGHT|CREW_BOAT|COMPANY_VEHICLE');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `visa_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Visa Expiry Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ALTER COLUMN `visa_work_permit_cleared_flag` SET TAGS ('dbx_business_glossary_term' = 'Visa Work Permit Cleared Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` SET TAGS ('dbx_subdomain' = 'crew_operations');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `pob_record_id` SET TAGS ('dbx_business_glossary_term' = 'Personnel on Board (POB) Record Identifier');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By Employee Identifier');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `bop_certified_count` SET TAGS ('dbx_business_glossary_term' = 'Blowout Preventer (BOP) Certified Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `catering_crew_count` SET TAGS ('dbx_business_glossary_term' = 'Catering Crew Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Personnel on Board (POB) Comments');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `contractor_count` SET TAGS ('dbx_business_glossary_term' = 'Contractor Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `drilling_crew_count` SET TAGS ('dbx_business_glossary_term' = 'Drilling Crew Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `emergency_contact_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Verified Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `h2s_qualified_count` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Qualified Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `helideck_manifest_reference` SET TAGS ('dbx_business_glossary_term' = 'Helideck Manifest Reference');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `hse_personnel_count` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Personnel Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `joint_venture_partner_count` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Partner Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `lifeboat_capacity` SET TAGS ('dbx_business_glossary_term' = 'Lifeboat Capacity');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `maintenance_crew_count` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Crew Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `management_count` SET TAGS ('dbx_business_glossary_term' = 'Management Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `max_pob_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Personnel on Board (POB) Capacity');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `medical_personnel_on_board_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Personnel on Board Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `medical_personnel_on_board_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `medical_personnel_on_board_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `muster_station_assignments` SET TAGS ('dbx_business_glossary_term' = 'Muster Station Assignments');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `offshore_survival_certified_count` SET TAGS ('dbx_business_glossary_term' = 'Offshore Survival Certified Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `operational_mode` SET TAGS ('dbx_business_glossary_term' = 'Operational Mode');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `pob_date` SET TAGS ('dbx_business_glossary_term' = 'Personnel on Board (POB) Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `pob_record_status` SET TAGS ('dbx_business_glossary_term' = 'Personnel on Board (POB) Record Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `pob_record_status` SET TAGS ('dbx_value_regex' = 'active|archived|amended|cancelled');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `production_crew_count` SET TAGS ('dbx_business_glossary_term' = 'Production Crew Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `recording_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recording Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `regulatory_inspector_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspector Present Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = 'day|night|swing|rotation_a|rotation_b');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `simops_flag` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `total_pob_count` SET TAGS ('dbx_business_glossary_term' = 'Total Personnel on Board (POB) Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `visitor_count` SET TAGS ('dbx_business_glossary_term' = 'Visitor Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `weather_condition` SET TAGS ('dbx_value_regex' = 'normal|adverse|storm|hurricane');
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ALTER COLUMN `well_control_certified_count` SET TAGS ('dbx_business_glossary_term' = 'Well Control Certified Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `bonus_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligible Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `collaboration_rating` SET TAGS ('dbx_business_glossary_term' = 'Collaboration and Teamwork Rating');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `collaboration_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `collaboration_score` SET TAGS ('dbx_business_glossary_term' = 'Collaboration and Teamwork Score');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `development_goals` SET TAGS ('dbx_business_glossary_term' = 'Development Goals');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Comments');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `goals_achieved_count` SET TAGS ('dbx_business_glossary_term' = 'Goals Achieved Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `goals_total_count` SET TAGS ('dbx_business_glossary_term' = 'Total Goals Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `hr_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Approval Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `hse_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Performance Rating');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `hse_performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `hse_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Performance Score');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `improvement_areas_summary` SET TAGS ('dbx_business_glossary_term' = 'Improvement Areas Summary');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `leadership_rating` SET TAGS ('dbx_business_glossary_term' = 'Leadership Rating');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `leadership_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding|not_applicable');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `leadership_score` SET TAGS ('dbx_business_glossary_term' = 'Leadership Score');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Eligible Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_percentage` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Percentage');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `operational_excellence_rating` SET TAGS ('dbx_business_glossary_term' = 'Operational Excellence Rating');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `operational_excellence_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `operational_excellence_score` SET TAGS ('dbx_business_glossary_term' = 'Operational Excellence Score');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating Score');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `pip_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Required Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `promotion_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Recommended Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|manager_review|hr_review|completed|cancelled');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|mid_year|probationary|project_based|ad_hoc|promotion');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `strengths_summary` SET TAGS ('dbx_business_glossary_term' = 'Strengths Summary');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `succession_planning_flag` SET TAGS ('dbx_business_glossary_term' = 'Succession Planning Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `technical_competency_rating` SET TAGS ('dbx_business_glossary_term' = 'Technical Competency Rating');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `technical_competency_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|outstanding');
ALTER TABLE `oil_gas_ecm`.`workforce`.`performance_review` ALTER COLUMN `technical_competency_score` SET TAGS ('dbx_business_glossary_term' = 'Technical Competency Score');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{8,30}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Reference');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,34}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `disability_insurance_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Disability Insurance Premium Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `disability_insurance_premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `expatriate_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Expatriate Allowance Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `expatriate_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `federal_tax_withheld_amount` SET TAGS ('dbx_business_glossary_term' = 'Federal Tax Withheld Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `federal_tax_withheld_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `garnishment_amount` SET TAGS ('dbx_business_glossary_term' = 'Garnishment Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `garnishment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `hazard_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Hazard Pay Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `hazard_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `health_insurance_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Premium Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `health_insurance_premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `housing_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Housing Allowance Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `housing_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,12}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `life_insurance_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Life Insurance Premium Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `life_insurance_premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `medicare_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Medicare Tax Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `medicare_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `offshore_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Offshore Allowance Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `offshore_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `other_deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Deductions Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `other_deductions_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overtime_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Hours Worked');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overtime_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Pay Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overtime_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'direct_deposit|check|cash|wire_transfer');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_document_number` SET TAGS ('dbx_business_glossary_term' = 'Payroll Document Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period End Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Start Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_status` SET TAGS ('dbx_value_regex' = 'draft|approved|paid|voided|reversed');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pension_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Pension Contribution Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pension_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `regular_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours Worked');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `shift_differential_amount` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `shift_differential_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `social_security_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Social Security Tax Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `social_security_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `state_tax_withheld_amount` SET TAGS ('dbx_business_glossary_term' = 'State Tax Withheld Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `state_tax_withheld_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `total_deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Deductions Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `total_deductions_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `transport_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Transport Allowance Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `transport_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `union_dues_amount` SET TAGS ('dbx_business_glossary_term' = 'Union Dues Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `union_dues_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `work_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,15}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Gross Pay');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_gross_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Tax Withheld');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_record` ALTER COLUMN `year_to_date_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `labor_cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Allocation ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `original_allocation_labor_cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Original Allocation ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocated_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Cost Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocated_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'Draft|Posted|Approved|Reversed|Cancelled');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `capitalized_flag` SET TAGS ('dbx_business_glossary_term' = 'Capitalized Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `co_document_number` SET TAGS ('dbx_business_glossary_term' = 'Controlling (CO) Document Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `cost_object_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Object Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `cost_object_type` SET TAGS ('dbx_value_regex' = 'AFE|WBS|Cost Center|Internal Order|Project|Production Sharing Agreement');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Rate');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `cost_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `jv_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Partner Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `jv_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Share Percentage');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `loe_category` SET TAGS ('dbx_business_glossary_term' = 'Lease Operating Expense (LOE) Category');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `loe_category` SET TAGS ('dbx_value_regex' = 'Direct|Indirect|Overhead|G&A');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `offshore_flag` SET TAGS ('dbx_business_glossary_term' = 'Offshore Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `posting_period` SET TAGS ('dbx_business_glossary_term' = 'Posting Period');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `posting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `total_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Cost Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `total_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `work_location` SET TAGS ('dbx_business_glossary_term' = 'Work Location');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected|requires_documentation');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_plan_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Provider Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Eligible Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_start_date` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Start Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly|quarterly|annual');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|employee_family');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN|EUR|GBP|AUD');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Dependent Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Method');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_value_regex' = 'online_portal|paper_form|phone|hr_representative|open_enrollment|new_hire');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_period_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Period Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_period_type` SET TAGS ('dbx_value_regex' = 'open_enrollment|new_hire|qualifying_life_event|special_enrollment|annual_enrollment');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'pending|active|suspended|terminated|cancelled|expired');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `qualifying_event_date` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Event Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `qualifying_event_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Event Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `oil_gas_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_value_regex' = 'spouse_coverage|other_insurance|cost|not_needed|medicare|medicaid');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `actual_days_taken` SET TAGS ('dbx_business_glossary_term' = 'Actual Days Taken');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `afe_number` SET TAGS ('dbx_value_regex' = '^AFE-[A-Z0-9]{8,12}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `hse_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Clearance Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `hse_clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Clearance Required Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance After');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance Before');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `number_of_days` SET TAGS ('dbx_business_glossary_term' = 'Number of Days');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `offshore_rotation_flag` SET TAGS ('dbx_business_glossary_term' = 'Offshore Rotation Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `pay_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Pay Impact Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `replacement_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Replacement Required Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_reason` SET TAGS ('dbx_business_glossary_term' = 'Request Reason');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `requested_end_date` SET TAGS ('dbx_business_glossary_term' = 'Requested End Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `requested_start_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Start Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `sap_absence_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Absence Document Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ALTER COLUMN `sap_absence_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` SET TAGS ('dbx_subdomain' = 'crew_operations');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `mobilization_event_id` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Event Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `assignment_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Assignment Duration in Days');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `demobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `destination_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `destination_facility_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Event Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Event Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'mobilization|demobilization|rotation_change|emergency_evacuation|medical_evacuation|crew_change');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `flight_vessel_number` SET TAGS ('dbx_business_glossary_term' = 'Flight or Vessel Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `h2s_training_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Training Expiry Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `h2s_training_status` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Training Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `h2s_training_status` SET TAGS ('dbx_value_regex' = 'valid|expired|not_required|pending');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `hse_induction_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Induction Completion Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `hse_induction_completion_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Induction Completion Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `medical_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Clearance Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `medical_clearance_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `medical_clearance_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `medical_clearance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Clearance Expiry Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `medical_clearance_expiry_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `medical_clearance_expiry_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `medical_fitness_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Fitness Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `medical_fitness_status` SET TAGS ('dbx_value_regex' = 'fit|fit_with_restrictions|unfit|pending|expired');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `medical_fitness_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `medical_fitness_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `mobilization_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Cost Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `mobilization_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Cost Currency Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `mobilization_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `offshore_survival_training_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Offshore Survival Training Expiry Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `offshore_survival_training_status` SET TAGS ('dbx_business_glossary_term' = 'Offshore Survival Training Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `offshore_survival_training_status` SET TAGS ('dbx_value_regex' = 'valid|expired|not_required|pending');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `origin_location` SET TAGS ('dbx_business_glossary_term' = 'Origin Location');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `ptw_authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Authorization Level');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `ptw_authorization_level` SET TAGS ('dbx_value_regex' = 'none|basic|advanced|issuing_authority|approving_authority');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `rotation_schedule_pattern` SET TAGS ('dbx_business_glossary_term' = 'Rotation Schedule Pattern');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `scheduled_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `scheduled_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Departure Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `transport_provider` SET TAGS ('dbx_business_glossary_term' = 'Transport Provider');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `visa_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Visa Expiry Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `visa_number` SET TAGS ('dbx_business_glossary_term' = 'Visa Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `visa_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `visa_status` SET TAGS ('dbx_business_glossary_term' = 'Visa Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `visa_status` SET TAGS ('dbx_value_regex' = 'not_required|valid|pending|expired|denied');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `work_permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Expiry Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `work_permit_status` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ALTER COLUMN `work_permit_status` SET TAGS ('dbx_value_regex' = 'not_required|valid|pending|expired|denied');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` SET TAGS ('dbx_subdomain' = 'workforce_development');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `hse_induction_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Induction ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Induction Officer Employee ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `primary_hse_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `primary_hse_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `primary_hse_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'written_test|verbal_assessment|practical_demonstration|online_quiz|combined');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `certification_issued` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `emergency_procedures_covered` SET TAGS ('dbx_business_glossary_term' = 'Emergency Procedures Covered');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `enablon_record_code` SET TAGS ('dbx_business_glossary_term' = 'Enablon Record ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `escort_required` SET TAGS ('dbx_business_glossary_term' = 'Escort Required');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `h2s_awareness_covered` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Awareness Covered');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `inductee_badge_number` SET TAGS ('dbx_business_glossary_term' = 'Inductee Badge Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `inductee_badge_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `inductee_badge_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `inductee_name` SET TAGS ('dbx_business_glossary_term' = 'Inductee Full Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `inductee_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `inductee_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `induction_date` SET TAGS ('dbx_business_glossary_term' = 'Induction Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `induction_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Induction Duration Minutes');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `induction_end_time` SET TAGS ('dbx_business_glossary_term' = 'Induction End Time');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `induction_notes` SET TAGS ('dbx_business_glossary_term' = 'Induction Notes');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `induction_number` SET TAGS ('dbx_business_glossary_term' = 'Induction Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `induction_officer_certification` SET TAGS ('dbx_business_glossary_term' = 'Induction Officer Certification Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `induction_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Induction Officer Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `induction_start_time` SET TAGS ('dbx_business_glossary_term' = 'Induction Start Time');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `induction_type` SET TAGS ('dbx_business_glossary_term' = 'Induction Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `induction_type` SET TAGS ('dbx_value_regex' = 'site_specific|offshore_platform|refinery|petrochemical_plant|drilling_rig|pipeline_facility');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `interpreter_used` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Used');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Induction Language');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `next_induction_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Induction Due Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `norm_awareness_covered` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Awareness Covered');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Induction Outcome');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|retest_required');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `ptw_procedures_covered` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Procedures Covered');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `regulatory_requirement_met` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Met');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `simops_procedures_covered` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Procedures Covered');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `site_access_authorized` SET TAGS ('dbx_business_glossary_term' = 'Site Access Authorized');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `topics_covered` SET TAGS ('dbx_business_glossary_term' = 'Topics Covered');
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` SET TAGS ('dbx_subdomain' = 'workforce_development');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `medical_fitness_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Fitness ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `medical_fitness_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `medical_fitness_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `assessment_cost` SET TAGS ('dbx_business_glossary_term' = 'Assessment Cost');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `assessment_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'scheduled|in-progress|completed|cancelled|expired');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `blood_pressure_diastolic` SET TAGS ('dbx_business_glossary_term' = 'Blood Pressure Diastolic');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `blood_pressure_diastolic` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `blood_pressure_diastolic` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `blood_pressure_systolic` SET TAGS ('dbx_business_glossary_term' = 'Blood Pressure Systolic');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `blood_pressure_systolic` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `blood_pressure_systolic` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `body_mass_index` SET TAGS ('dbx_business_glossary_term' = 'Body Mass Index (BMI)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `body_mass_index` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `body_mass_index` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `confined_space_cleared` SET TAGS ('dbx_business_glossary_term' = 'Confined Space Cleared');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `drug_alcohol_test_completed` SET TAGS ('dbx_business_glossary_term' = 'Drug and Alcohol Test Completed');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `drug_alcohol_test_result` SET TAGS ('dbx_business_glossary_term' = 'Drug and Alcohol Test Result');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `drug_alcohol_test_result` SET TAGS ('dbx_value_regex' = 'negative|positive|refused|invalid');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `drug_alcohol_test_result` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `drug_alcohol_test_result` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `examining_physician_license_number` SET TAGS ('dbx_business_glossary_term' = 'Examining Physician License Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `examining_physician_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `examining_physician_name` SET TAGS ('dbx_business_glossary_term' = 'Examining Physician Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `examining_physician_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `fitness_category` SET TAGS ('dbx_business_glossary_term' = 'Fitness Category');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `fitness_category` SET TAGS ('dbx_value_regex' = 'fit|fit-with-restrictions|temporarily-unfit|permanently-unfit');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `h2s_exposure_cleared` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Exposure Cleared');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `hazardous_duty_approved` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Duty Approved');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `hearing_protection_required` SET TAGS ('dbx_business_glossary_term' = 'Hearing Protection Required');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `hr_review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Review Completed Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `hr_review_required` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Review Required');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `immunization_status` SET TAGS ('dbx_business_glossary_term' = 'Immunization Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `immunization_status` SET TAGS ('dbx_value_regex' = 'current|overdue|incomplete|not-required');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `immunization_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `immunization_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `medical_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `medical_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `medical_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Medical Facility Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `medical_facility_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `medical_facility_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `offshore_fitness_standard` SET TAGS ('dbx_business_glossary_term' = 'Offshore Fitness Standard');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `offshore_fitness_standard` SET TAGS ('dbx_value_regex' = 'OGUK|UKOOA|NOGEPA|API-RP-75|BSEE|company-specific');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `offshore_work_approved` SET TAGS ('dbx_business_glossary_term' = 'Offshore Work Approved');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `physician_comments` SET TAGS ('dbx_business_glossary_term' = 'Physician Comments');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `physician_comments` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `physician_comments` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `regulatory_compliance_met` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Met');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `respirator_use_cleared` SET TAGS ('dbx_business_glossary_term' = 'Respirator Use Cleared');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `restrictions_noted` SET TAGS ('dbx_business_glossary_term' = 'Restrictions Noted');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `restrictions_noted` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `restrictions_noted` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`medical_fitness` ALTER COLUMN `vision_corrective_required` SET TAGS ('dbx_business_glossary_term' = 'Vision Corrective Required');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` SET TAGS ('dbx_subdomain' = 'workforce_development');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Plan ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit (Org Unit) ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner Employee ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Activation Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `business_segment` SET TAGS ('dbx_business_glossary_term' = 'Business Segment');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `business_segment` SET TAGS ('dbx_value_regex' = 'Upstream E&P|Midstream|Downstream Refining|Petrochemicals|Marketing and Sales|Corporate');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `capex_labor_budget` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Labor Budget');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `capex_labor_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Closure Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `critical_positions_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Positions Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `current_headcount` SET TAGS ('dbx_business_glossary_term' = 'Current Headcount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `diversity_hiring_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Diversity Hiring Target Percentage');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `headcount_gap` SET TAGS ('dbx_business_glossary_term' = 'Headcount Gap');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `high_potential_talent_count` SET TAGS ('dbx_business_glossary_term' = 'High Potential (HiPo) Talent Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `hse_certified_personnel_required` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Certified Personnel Required');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `labor_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `labor_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `offshore_manning_requirement` SET TAGS ('dbx_business_glossary_term' = 'Offshore Manning Requirement');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `operational_area` SET TAGS ('dbx_business_glossary_term' = 'Operational Area');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `opex_labor_budget` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Labor Budget');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `opex_labor_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Workforce Plan Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^WFP-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Workforce Plan Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'Draft|Under Review|Approved|Active|Closed|Cancelled');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Workforce Plan Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `planned_attrition` SET TAGS ('dbx_business_glossary_term' = 'Planned Attrition');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `planned_headcount` SET TAGS ('dbx_business_glossary_term' = 'Planned Headcount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `planned_hires` SET TAGS ('dbx_business_glossary_term' = 'Planned Hires');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `planned_internal_transfers_in` SET TAGS ('dbx_business_glossary_term' = 'Planned Internal Transfers In');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `planned_internal_transfers_out` SET TAGS ('dbx_business_glossary_term' = 'Planned Internal Transfers Out');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `planning_quarter` SET TAGS ('dbx_business_glossary_term' = 'Planning Quarter');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `planning_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Workforce Plan Remarks');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `simops_qualified_personnel_required` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Qualified Personnel Required');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Submission Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `succession_ready_1_2_years_count` SET TAGS ('dbx_business_glossary_term' = 'Succession Ready in 1-2 Years Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `succession_ready_3_5_years_count` SET TAGS ('dbx_business_glossary_term' = 'Succession Ready in 3-5 Years Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `succession_ready_now_count` SET TAGS ('dbx_business_glossary_term' = 'Succession Ready Now Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `training_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Training Budget Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `training_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `union_representation_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Representation Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`plan` ALTER COLUMN `veteran_hiring_target_count` SET TAGS ('dbx_business_glossary_term' = 'Veteran Hiring Target Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Requisition ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `job_role_id` SET TAGS ('dbx_business_glossary_term' = 'Job Role Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit (Org Unit) ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Employee ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_recruiter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Employee ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_recruiter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_recruiter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `afe_number` SET TAGS ('dbx_value_regex' = '^AFE-[0-9]{6,10}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `approval_workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `approved_headcount` SET TAGS ('dbx_business_glossary_term' = 'Approved Headcount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `background_check_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Clearance Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_initiated|in_progress|cleared|flagged|failed');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `candidate_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `candidate_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `candidate_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `candidate_source_channel` SET TAGS ('dbx_business_glossary_term' = 'Candidate Source Channel');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'permanent|temporary|contract|intern|rotational');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `hse_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Certification Required Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `interview_stage` SET TAGS ('dbx_business_glossary_term' = 'Interview Stage');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Requisition Justification');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `offer_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Acceptance Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `offer_status` SET TAGS ('dbx_value_regex' = 'no_offer|offer_pending|offer_extended|offer_accepted|offer_declined|offer_withdrawn');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `offshore_assignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Offshore Assignment Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `recruitment_channel` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Channel');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `recruitment_channel` SET TAGS ('dbx_value_regex' = 'internal|external|agency|campus|referral|rehire');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `required_start_date` SET TAGS ('dbx_business_glossary_term' = 'Required Start Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_close_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Close Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{8}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_open_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Open Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'new_hire|backfill|project_specific|contractor_conversion|internal_transfer|temporary');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `rotation_schedule` SET TAGS ('dbx_business_glossary_term' = 'Rotation Schedule');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `sap_ps_project_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Project System (PS) Project ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `sap_ps_project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,15}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_value_regex' = 'none|basic|confidential|secret|top_secret');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `technical_screening_score` SET TAGS ('dbx_business_glossary_term' = 'Technical Screening Score');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `time_to_fill_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (Days)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|visa_required|visa_in_process|not_authorized');
ALTER TABLE `oil_gas_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `work_location` SET TAGS ('dbx_business_glossary_term' = 'Work Location');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate Identifier');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Job Requisition Identifier');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Employee Identifier');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `applied_position_title` SET TAGS ('dbx_business_glossary_term' = 'Applied Position Title');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `background_check_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_initiated|in_progress|cleared|flagged|failed');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `cover_letter_reference` SET TAGS ('dbx_business_glossary_term' = 'Cover Letter Document Reference');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `cv_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Vitae (CV) Document Reference');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `degree_field` SET TAGS ('dbx_business_glossary_term' = 'Degree Field of Study');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `drug_test_date` SET TAGS ('dbx_business_glossary_term' = 'Drug and Alcohol Test Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `drug_test_status` SET TAGS ('dbx_business_glossary_term' = 'Drug and Alcohol Test Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `drug_test_status` SET TAGS ('dbx_value_regex' = 'not_required|scheduled|passed|failed|pending');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Candidate Email Address');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `expected_start_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Start Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate First Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate Full Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `highest_education_level` SET TAGS ('dbx_business_glossary_term' = 'Highest Education Level');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `highest_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate|professional_certification');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `hse_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Certification Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `hse_certification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|verified|expired|insufficient');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `interview_stage` SET TAGS ('dbx_business_glossary_term' = 'Interview Stage');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `interviewer_feedback_summary` SET TAGS ('dbx_business_glossary_term' = 'Interviewer Feedback Summary');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `last_interview_date` SET TAGS ('dbx_business_glossary_term' = 'Last Interview Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate Last Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate Middle Name');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Candidate Mobile Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Candidate Nationality');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `nationality` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Extended Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `offer_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Expiry Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `offer_status` SET TAGS ('dbx_value_regex' = 'no_offer|offer_pending|offer_extended|offer_accepted|offer_declined|offer_withdrawn');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `offered_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Offered Salary Amount');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `offered_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `offshore_experience_flag` SET TAGS ('dbx_business_glossary_term' = 'Offshore Experience Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `oil_gas_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Oil and Gas Industry Experience Years');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `overall_interview_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Interview Rating');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `overall_interview_rating` SET TAGS ('dbx_value_regex' = 'strong_hire|hire|maybe|no_hire|strong_no_hire');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Candidate Phone Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Candidate Source Channel');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `technical_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Technical Screening Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `technical_screening_score` SET TAGS ('dbx_business_glossary_term' = 'Technical Screening Score');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `visa_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Visa Expiry Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `visa_type` SET TAGS ('dbx_business_glossary_term' = 'Visa Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_value_regex' = 'citizen|permanent_resident|work_visa|requires_sponsorship|not_authorized');
ALTER TABLE `oil_gas_ecm`.`workforce`.`candidate` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Professional Experience');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `work_permit_visa_id` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Visa Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `alert_reason` SET TAGS ('dbx_business_glossary_term' = 'Alert Reason');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `application_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Application Reference Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `application_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `application_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `attorney_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Attorney Contact Email');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `attorney_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `attorney_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `attorney_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `compliance_alert_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Alert Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `days_until_expiry` SET TAGS ('dbx_business_glossary_term' = 'Days Until Expiry');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Dependent Count');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `dependents_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Dependents Allowed Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `document_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Location');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `employment_type_authorized` SET TAGS ('dbx_business_glossary_term' = 'Employment Type Authorized');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `employment_type_authorized` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temporary|permanent|seasonal');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `immigration_attorney` SET TAGS ('dbx_business_glossary_term' = 'Immigration Attorney');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `job_title_authorized` SET TAGS ('dbx_business_glossary_term' = 'Job Title Authorized');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `multiple_entry_flag` SET TAGS ('dbx_business_glossary_term' = 'Multiple Entry Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `occupation_code` SET TAGS ('dbx_business_glossary_term' = 'Occupation Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `offshore_work_authorized_flag` SET TAGS ('dbx_business_glossary_term' = 'Offshore Work Authorized Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `permit_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `permit_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `permit_subtype` SET TAGS ('dbx_business_glossary_term' = 'Permit Subtype');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'not_required|pending_submission|submitted|approved|rejected|in_review');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `sponsoring_company_code` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Company Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `sponsoring_entity` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Entity');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `work_location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Country Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `work_location_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ALTER COLUMN `work_permit_visa_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `succession_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner Employee Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `primary_successor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Successor Employee Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `primary_successor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `primary_successor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `quaternary_succession_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `quaternary_succession_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `quaternary_succession_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Target Position Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `tertiary_succession_hr_business_partner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Business Partner Employee Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `tertiary_succession_hr_business_partner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `tertiary_succession_hr_business_partner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_required');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `business_segment` SET TAGS ('dbx_business_glossary_term' = 'Business Segment');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `development_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Development Actions Required');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `development_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Development Cost Currency Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `development_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `estimated_development_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Development Cost');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `hse_certification_requirements` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Certification Requirements');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `incumbent_planned_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Incumbent Planned Departure Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `joa_position_flag` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Position Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `leadership_competency_gaps` SET TAGS ('dbx_business_glossary_term' = 'Leadership Competency Gaps');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Notes');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `offshore_position_flag` SET TAGS ('dbx_business_glossary_term' = 'Offshore Position Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_review_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Review Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|under_review|approved|on_hold|completed|cancelled');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `position_criticality_level` SET TAGS ('dbx_business_glossary_term' = 'Position Criticality Level');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `position_criticality_level` SET TAGS ('dbx_value_regex' = 'critical|key|strategic|standard');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `primary_successor_readiness_rating` SET TAGS ('dbx_business_glossary_term' = 'Primary Successor Readiness Rating');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `primary_successor_readiness_rating` SET TAGS ('dbx_value_regex' = 'ready_now|ready_1_2_years|ready_3_5_years|not_ready');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency in Months');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `risk_of_loss` SET TAGS ('dbx_business_glossary_term' = 'Risk of Loss');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `risk_of_loss` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `safety_critical_position_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical Position Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `secondary_successor_readiness_rating` SET TAGS ('dbx_business_glossary_term' = 'Secondary Successor Readiness Rating');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `secondary_successor_readiness_rating` SET TAGS ('dbx_value_regex' = 'ready_now|ready_1_2_years|ready_3_5_years|not_ready');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `talent_pool_category` SET TAGS ('dbx_business_glossary_term' = 'Talent Pool Category');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `talent_pool_category` SET TAGS ('dbx_value_regex' = 'high_potential|emerging_leader|technical_expert|operational_leader|specialist');
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ALTER COLUMN `technical_competency_gaps` SET TAGS ('dbx_business_glossary_term' = 'Technical Competency Gaps');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `timesheet_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `timesheet_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `timesheet_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `amended_timesheet_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `capitalized_flag` SET TAGS ('dbx_business_glossary_term' = 'Capitalized Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Comments');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `cost_object_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Object Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `cost_object_type` SET TAGS ('dbx_value_regex' = 'AFE|WBS|cost center|internal order|project|asset');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `double_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Double Time Hours Worked');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `hse_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incident Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `jv_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Partner Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `jv_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Share Percentage');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `loe_category` SET TAGS ('dbx_business_glossary_term' = 'Lease Operating Expense (LOE) Category');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `loe_category` SET TAGS ('dbx_value_regex' = 'direct|indirect|overhead|G&A');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `npt_hours` SET TAGS ('dbx_business_glossary_term' = 'Non-Productive Time (NPT) Hours');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `offshore_rotation_day` SET TAGS ('dbx_business_glossary_term' = 'Offshore Rotation Day Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours Worked');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `payroll_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period End Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `payroll_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Start Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `posting_period` SET TAGS ('dbx_business_glossary_term' = 'Posting Period');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours Worked');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `sap_cats_reference` SET TAGS ('dbx_business_glossary_term' = 'SAP Cross-Application Time Sheet (CATS) Reference');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|12-hour tour|swing|graveyard|split');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `simops_flag` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous Operations (SIMOPS) Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `standby_hours` SET TAGS ('dbx_business_glossary_term' = 'Standby Hours');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `timesheet_number` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Document Number');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `oil_gas_ecm`.`workforce`.`role_competency_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`role_competency_requirement` SET TAGS ('dbx_subdomain' = 'workforce_development');
ALTER TABLE `oil_gas_ecm`.`workforce`.`role_competency_requirement` SET TAGS ('dbx_association_edges' = 'workforce.job_role,workforce.competency');
ALTER TABLE `oil_gas_ecm`.`workforce`.`role_competency_requirement` ALTER COLUMN `role_competency_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Role Competency Requirement ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`role_competency_requirement` ALTER COLUMN `competency_id` SET TAGS ('dbx_business_glossary_term' = 'Competency ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`role_competency_requirement` ALTER COLUMN `job_role_id` SET TAGS ('dbx_business_glossary_term' = 'Job Role ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`role_competency_requirement` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `oil_gas_ecm`.`workforce`.`role_competency_requirement` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`role_competency_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`role_competency_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`role_competency_requirement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`role_competency_requirement` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`role_competency_requirement` ALTER COLUMN `minimum_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years Experience');
ALTER TABLE `oil_gas_ecm`.`workforce`.`role_competency_requirement` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `oil_gas_ecm`.`workforce`.`role_competency_requirement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`role_competency_requirement` ALTER COLUMN `offshore_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Offshore Critical Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`role_competency_requirement` ALTER COLUMN `required_proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Required Proficiency Level');
ALTER TABLE `oil_gas_ecm`.`workforce`.`role_competency_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Status');
ALTER TABLE `oil_gas_ecm`.`workforce`.`role_competency_requirement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position_competency_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position_competency_requirement` SET TAGS ('dbx_subdomain' = 'workforce_development');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position_competency_requirement` SET TAGS ('dbx_association_edges' = 'workforce.position,workforce.competency');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `position_competency_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Position Competency Requirement ID');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `competency_id` SET TAGS ('dbx_business_glossary_term' = 'Position Competency Requirement - Competency Id');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Competency Requirement - Position Id');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `assessment_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Assessment Frequency Months');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Effective Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Expiry Date');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `required_competency_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Required Competency Profile Code');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `required_competency_profile_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `required_proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Required Proficiency Level');
ALTER TABLE `oil_gas_ecm`.`workforce`.`position_competency_requirement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_program` SET TAGS ('dbx_subdomain' = 'workforce_development');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_program` ALTER COLUMN `training_program_id` SET TAGS ('dbx_business_glossary_term' = 'Training Program Identifier');
ALTER TABLE `oil_gas_ecm`.`workforce`.`training_program` ALTER COLUMN `parent_training_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew` SET TAGS ('dbx_subdomain' = 'crew_operations');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Identifier');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew` ALTER COLUMN `relief_crew_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew` ALTER COLUMN `base_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew` ALTER COLUMN `base_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew` ALTER COLUMN `crew_leader_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew` ALTER COLUMN `crew_leader_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_run` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Identifier');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_run` ALTER COLUMN `processed_by_user_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_run` ALTER COLUMN `processed_by_user_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`workforce`.`payroll_run` ALTER COLUMN `parent_payroll_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
