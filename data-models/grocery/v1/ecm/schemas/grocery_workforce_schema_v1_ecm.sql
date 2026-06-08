-- Schema for Domain: workforce | Business: Grocery | Version: v1_ecm
-- Generated on: 2026-05-04 18:35:00

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `grocery_ecm`.`workforce` COMMENT 'Employee lifecycle management including hiring, scheduling, time and attendance, labor analytics, payroll, benefits, and talent development. Manages store associates, pharmacists, DC workers, and corporate staff. Tracks OSHA safety incidents, certifications, and labor compliance. Integrates with Kronos Workforce Central and Workday HCM systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`associate` (
    `associate_id` BIGINT COMMENT 'Unique system-generated identifier for each Grocery employee (associate). Serves as the primary key and enterprise-wide reference for all workforce-related records across Workday HCM, Kronos Workforce Central, and downstream analytics systems.',
    `manager_associate_id` BIGINT COMMENT 'Associate ID of the direct manager (supervisor) of this associate, enabling the organizational hierarchy to be traversed. Used for approval workflows, performance reviews, and org chart reporting in Workday HCM.',
    `store_location_id` BIGINT COMMENT 'Identifier for the primary work location (store, distribution center, pharmacy, fuel center, or corporate office) where the associate is assigned. Used for scheduling, OSHA incident reporting, and same-store sales labor analytics.',
    `compensation_band` STRING COMMENT 'The compensation grade or band assigned to the associates job code (e.g., Band 1, Band 2, Grade A, Grade B). Defines the salary range minimum and maximum for the role. Used for pay equity analysis, merit increase eligibility, and internal mobility decisions.',
    `cost_center_code` STRING COMMENT 'SAP Controlling (CO) cost center code to which the associates labor costs are charged. Enables granular labor cost reporting by store, department, or function. Critical for EBITDA analysis and store-level P&L reporting.',
    `date_of_birth` DATE COMMENT 'Date of birth of the associate. Required for age verification (e.g., alcohol/tobacco sales eligibility), benefits eligibility determination, and compliance with child labor laws under FLSA. Stored per CCPA and GDPR data minimization.',
    `department_code` STRING COMMENT 'Organizational department code to which the associate is assigned (e.g., Produce, Pharmacy, Distribution Center, Corporate Finance). Sourced from Workday HCM organizational hierarchy and used for labor cost allocation in SAP FI/CO.',
    `disability_status` STRING COMMENT 'Self-reported disability status of the associate per Section 503 of the Rehabilitation Act and ADA requirements. Required for OFCCP Section 503 affirmative action reporting. Classified as confidential. Collected voluntarily.. Valid values are `yes|no|prefer_not_to_say`',
    `eeo_category` STRING COMMENT 'EEO-1 job category assigned to the associate per EEOC reporting requirements. Required for annual EEO-1 Component 1 filing submitted to the Equal Employment Opportunity Commission. Classified as confidential to protect workforce demographic data. [ENUM-REF-CANDIDATE: exec_senior_mgr|first_mid_mgr|professionals|technicians|sales_workers|admin_support|craft_workers|operatives|laborers|service_workers — promote to reference product]',
    `emergency_contact_name` STRING COMMENT 'Full name of the associates designated emergency contact person. Used by store management and HR in the event of a workplace injury, OSHA incident, or medical emergency. Sourced from Workday HCM Core HR.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the associates designated emergency contact. Used by store management and HR in the event of a workplace injury, OSHA incident, or medical emergency.. Valid values are `^+?[1-9]d{1,14}$`',
    `employee_number` STRING COMMENT 'Human-readable, externally-known employee badge number used on store floors, scheduling systems (Kronos Workforce Central), and payroll. Printed on associate ID badges and referenced in HR correspondence.',
    `employment_status` STRING COMMENT 'Current lifecycle status of the associates employment at Grocery. Drives access control, payroll processing eligibility, benefits enrollment windows, and workforce analytics. on_leave covers FMLA, medical, and personal leave. [ENUM-REF-CANDIDATE: active|on_leave|terminated|suspended|retired|pending_hire — promote to reference product if additional statuses are needed]. Valid values are `active|on_leave|terminated|suspended|retired`',
    `ethnicity` STRING COMMENT 'Self-reported race/ethnicity of the associate per EEOC EEO-1 categories. Required for annual EEO-1 Component 1 filing. Classified as confidential. Collected voluntarily. [ENUM-REF-CANDIDATE: hispanic_latino|white|black_african_american|asian|native_hawaiian_pacific_islander|american_indian_alaska_native|two_or_more_races — promote to reference product]. Valid values are `hispanic_latino|white|black_african_american|asian|native_hawaiian_pacific_islander|american_indian_alaska_native`',
    `first_name` STRING COMMENT 'Legal given name of the associate as recorded in Workday HCM. Used for payroll, benefits administration, associate self-service, and compliance reporting.',
    `flsa_classification` STRING COMMENT 'Indicates whether the associate is classified as exempt or non-exempt under the Fair Labor Standards Act (FLSA). Non-exempt associates are entitled to overtime pay at 1.5x for hours worked beyond 40 per week. Critical for payroll compliance and wage-and-hour litigation defense.. Valid values are `exempt|non_exempt`',
    `gender` STRING COMMENT 'Self-reported gender of the associate. Collected for EEO-1 reporting, pay equity analysis, and diversity, equity, and inclusion (DEI) analytics. Classified as confidential. Collected voluntarily per EEOC guidelines.. Valid values are `male|female|non_binary|prefer_not_to_say`',
    `hire_date` DATE COMMENT 'The official date the associate was hired by Grocery. Used to calculate tenure, benefits eligibility waiting periods, vesting schedules, and service anniversary milestones. Sourced from Workday HCM Core HR.',
    `is_rehire_eligible` BOOLEAN COMMENT 'Indicates whether a terminated associate is eligible for rehire at Grocery. Set by HR during the offboarding process based on termination reason and disciplinary history. Used to screen applicants in the recruiting workflow.',
    `job_code` STRING COMMENT 'Standardized job classification code from the Workday HCM job catalog. Used for compensation benchmarking, EEO-1 reporting, labor cost allocation to cost centers, and integration with Kronos Workforce Central for scheduling rule assignment.',
    `job_title` STRING COMMENT 'Official job title of the associate as defined in Workday HCM job catalog (e.g., Store Associate, Pharmacist, Distribution Center Picker, Department Manager, Corporate Analyst). Used in org charts, compliance reporting, and associate self-service.',
    `last_disciplinary_action_date` DATE COMMENT 'Date of the most recent disciplinary action taken against the associate (verbal warning, written warning, suspension, or termination). Used to track progressive discipline timelines and support wrongful termination defense. Null if no disciplinary history.',
    `last_disciplinary_action_type` STRING COMMENT 'Type of the most recent disciplinary action in the associates progressive discipline record. Used alongside last_disciplinary_action_date to determine the next step in the progressive discipline process. Null if no disciplinary history.. Valid values are `verbal_warning|written_warning|suspension|final_warning`',
    `last_name` STRING COMMENT 'Legal surname of the associate as recorded in Workday HCM. Used for payroll, benefits administration, associate self-service, and compliance reporting.',
    `mobile_phone` STRING COMMENT 'Primary mobile phone number for the associate. Used for shift notifications, emergency contact, two-factor authentication for Workday self-service, and Kronos scheduling alerts.. Valid values are `^+?[1-9]d{1,14}$`',
    `national_id_last4` STRING COMMENT 'Last four digits of the associates Social Security Number (SSN). Stored as a partial identifier for identity verification in associate self-service and payroll inquiries. Full SSN is stored only in the Workday HCM source system under PCI/PII controls and is NOT replicated to the lakehouse.. Valid values are `^[0-9]{4}$`',
    `pay_rate` DECIMAL(18,2) COMMENT 'Current compensation rate for the associate. For hourly associates, this is the hourly wage in USD. For salaried associates, this is the annual salary in USD. Used for payroll processing, pay equity audits, and compensation band analysis. Classified as confidential business data.',
    `pay_rate_effective_date` DATE COMMENT 'The date on which the current pay_rate became effective. Used to track compensation history, calculate retroactive pay adjustments, and support pay equity audit trails. Together with pay_rate, forms the current compensation record.',
    `pay_type` STRING COMMENT 'Indicates whether the associate is compensated on an hourly, salaried, or commission basis. Drives payroll calculation logic in Workday HCM Payroll and determines overtime eligibility in conjunction with FLSA classification.. Valid values are `hourly|salary|commission`',
    `personal_email` STRING COMMENT 'Personal email address of the associate used for pre-hire communications, offboarding notifications, and W-2 delivery after separation. Stored per CCPA and GDPR data minimization principles.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `preferred_name` STRING COMMENT 'The name the associate prefers to be called in the workplace, which may differ from their legal name. Used on scheduling displays, store communications, and associate self-service portals to support an inclusive work environment.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the associate record was first created in the Workday HCM system. Used for data lineage, audit trails, and SOX compliance. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX per Grocery data standards.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the associate record in the source Workday HCM system. Used for incremental data pipeline processing, change data capture (CDC), and audit trail maintenance in the Databricks lakehouse silver layer.',
    `rehire_date` DATE COMMENT 'Date the associate was rehired following a prior termination. When populated, tenure calculations and benefits eligibility may use this date instead of the original hire date per Grocerys rehire policy. Null for associates who have never been rehired.',
    `termination_date` DATE COMMENT 'The effective date on which the associates employment ended. Null for currently active associates. Used for final pay calculations, benefits termination, COBRA notification timelines, and wrongful termination defense documentation.',
    `termination_reason` STRING COMMENT 'Categorized reason for the associates separation from Grocery. Used for turnover analytics, unemployment insurance claims, and wrongful termination defense. Null for active associates. [ENUM-REF-CANDIDATE: voluntary|involuntary|retirement|layoff|job_abandonment|end_of_contract|deceased — promote to reference product]. Valid values are `voluntary|involuntary|retirement|layoff|job_abandonment`',
    `union_code` STRING COMMENT 'Code identifying the specific labor union or collective bargaining unit the associate belongs to (e.g., UFCW Local 400). Null for non-union associates. Used to apply the correct CBA rules in scheduling and payroll.',
    `union_member` BOOLEAN COMMENT 'Indicates whether the associate is a member of a labor union. Drives application of collective bargaining agreement (CBA) rules for scheduling, overtime, pay rates, and grievance procedures. Critical for labor relations compliance.',
    `veteran_status` STRING COMMENT 'Self-reported veteran status of the associate per VEVRAA (Vietnam Era Veterans Readjustment Assistance Act) requirements. Required for VETS-4212 federal contractor reporting. Classified as confidential. Collected voluntarily.. Valid values are `protected_veteran|not_protected_veteran|prefer_not_to_say`',
    `work_email` STRING COMMENT 'Company-issued email address for the associate. Primary channel for HR communications, benefits enrollment notifications, scheduling alerts, and associate self-service access via Workday.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `workday_worker_code` STRING COMMENT 'The unique worker identifier assigned by Workday HCM Core HR module. Used for cross-system reconciliation between the lakehouse silver layer and the Workday source system. Distinct from the internal associate_id surrogate key.',
    `worker_type` STRING COMMENT 'Classification of the associates employment arrangement. Determines benefits eligibility thresholds (ACA 30-hour rule), overtime rules, and scheduling constraints in Kronos Workforce Central. Seasonal workers are tracked separately for peak-period labor analytics.. Valid values are `full_time|part_time|seasonal|temporary|contractor`',
    CONSTRAINT pk_associate PRIMARY KEY(`associate_id`)
) COMMENT 'Master record for all Grocery employees including store associates, pharmacists, DC workers, and corporate staff. Serves as the single source of truth for employee identity, employment status, job classification, compensation band and history (current and prior rates with effective dates), hire date, termination date, work location, FLSA classification (exempt/non-exempt), union membership status, EEO category, disciplinary action history (verbal/written warnings, suspensions, terminations with dates and reasons for progressive discipline documentation), and emergency contact information. Supports pay equity audits, wrongful termination defense, and associate self-service inquiries. Sourced from Workday HCM Core HR module.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique surrogate identifier for an authorized headcount position or job profile definition within the Grocery organization. Primary key for this entity. Sourced from Workday HCM Position Management.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Labor cost allocation reports require each position to be tied to a cost center for expense roll‑up and budgeting.',
    `node_id` BIGINT COMMENT 'Foreign key linking to fulfillment.node. Business justification: Supports Position Staffing Allocation process, linking each position to its fulfillment node for headcount budgeting.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: A Position represents a specific headcount slot that must be tied to a Job Profile defining its duties, pay grade, and qualifications. Adding Position.job_profile_id creates the required 1:N relations',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Positions are organized within the organizational hierarchy. Linking Position.org_unit_id to Org_Unit provides clear reporting and budgeting context without creating a cycle, as Org_Unit does not refe',
    `store_location_id` BIGINT COMMENT 'Identifier of the physical location (store, Distribution Center (DC), pharmacy, fuel center, or corporate office) where this position is assigned. Supports store-level headcount planning and labor scheduling in Kronos Workforce Central.',
    `supervisor_position_id` BIGINT COMMENT 'Self-referencing identifier of the parent position in the reporting hierarchy. Defines the organizational reporting chain (e.g., Store Associate reports to Department Manager position). Enables org chart generation and span-of-control analytics.',
    `bargaining_unit_code` STRING COMMENT 'Code identifying the specific union bargaining unit associated with this position (e.g., UFCW Local 400 for store associates, Teamsters for DC drivers). Applicable only when union_eligible is true. Governs wage rates, scheduling rules, and grievance procedures.',
    `budgeted_headcount` STRING COMMENT 'Number of approved headcount slots authorized for this position definition within the associated cost center or department. Supports annual headcount planning and variance reporting against actual filled positions.',
    `career_ladder_next_position_code` STRING COMMENT 'Job code of the next position in the defined career progression path for this role. Supports internal mobility programs, succession planning, and associate development conversations. Sourced from Workday HCM career framework.',
    `competency_profile_code` STRING COMMENT 'Code referencing the standardized competency framework profile assigned to this position, defining required skills, behaviors, and performance expectations. Used in performance reviews and talent assessments in Workday HCM.',
    `department_code` STRING COMMENT 'Code identifying the organizational department to which this position belongs (e.g., store department, pharmacy, DC operations, corporate finance). Aligns with SAP CO cost center hierarchy and Workday HCM supervisory organization.',
    `effective_end_date` DATE COMMENT 'Date on which this position is no longer active (eliminated or restructured). Null for currently active positions. Supports bi-temporal workforce planning and position lifecycle history.',
    `effective_start_date` DATE COMMENT 'Date on which this position becomes active and authorized for staffing or recruiting. Supports bi-temporal data modeling for workforce planning and position history tracking in the Silver Layer.',
    `flsa_classification` STRING COMMENT 'Federal FLSA overtime eligibility classification for the position: exempt (salaried, not eligible for overtime), non_exempt (hourly, eligible for overtime pay), or exempt_highly_compensated. Critical for payroll compliance and labor law reporting. Sourced from Workday HCM job profile.. Valid values are `exempt|non_exempt|exempt_highly_compensated`',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Budgeted Full-Time Equivalent (FTE) value for this position, where 1.0 represents a full-time role and 0.5 represents a half-time role. Used for headcount planning, labor cost budgeting, and workforce analytics. Aligns with SAP CO cost center FTE budgets.',
    `headcount_plan_year` STRING COMMENT 'Fiscal year for which this positions budgeted headcount was approved. Enables year-over-year headcount variance analysis and annual workforce planning cycle tracking.',
    `is_food_handler` BOOLEAN COMMENT 'Indicates whether this position requires a food handler certification per FDA Food Safety Modernization Act (FSMA) and local health department regulations. Applicable to deli, bakery, produce, and meat department associates.',
    `is_pharmacy_position` BOOLEAN COMMENT 'Indicates whether this position is classified as a pharmacy role subject to State Board of Pharmacy licensing requirements, DEA controlled substance handling regulations, and HIPAA (Health Insurance Portability and Accountability Act) patient data privacy obligations.',
    `is_safety_sensitive` BOOLEAN COMMENT 'Indicates whether this position is classified as safety-sensitive, requiring pre-employment and random drug testing (e.g., forklift operators, fuel center attendants, pharmacy staff). Drives DOT and OSHA compliance program enrollment.',
    `job_code` STRING COMMENT 'Standardized job classification code assigned to the position, linking it to the job profile template in Workday HCM. Used for compensation benchmarking, labor analytics in Kronos Workforce Central, and FLSA classification reporting.. Valid values are `^JC-[A-Z0-9]{3,10}$`',
    `job_family` STRING COMMENT 'Grouping of related job profiles that share common competencies and career progression paths (e.g., Store Operations, Pharmacy, Supply Chain, Finance, Technology). Supports workforce planning and talent development analytics.',
    `job_level` STRING COMMENT 'Hierarchical level of the position within the job family career ladder (e.g., entry, associate, mid, senior, lead, manager, director, executive). Drives pay grade assignment and career progression planning. [ENUM-REF-CANDIDATE: entry|associate|mid|senior|lead|manager|director|executive — 8 candidates stripped; promote to reference product]',
    `last_filled_date` DATE COMMENT 'Most recent date on which this position was filled by an active associate. Used to calculate vacancy duration and time-to-fill metrics for talent acquisition reporting.',
    `management_level` STRING COMMENT 'Organizational management tier of the position indicating people management responsibility (individual_contributor, team_lead, manager, senior_manager, director, vp, c_suite). Used for span-of-control reporting and leadership development programs. [ENUM-REF-CANDIDATE: individual_contributor|team_lead|manager|senior_manager|director|vp|c_suite — 7 candidates stripped; promote to reference product]',
    `min_education_level` STRING COMMENT 'Minimum educational qualification required for this position. [ENUM-REF-CANDIDATE: none|high_school_diploma|associate_degree|bachelor_degree|master_degree|doctorate|professional_license — promote to reference product]',
    `min_experience_years` DECIMAL(18,2) COMMENT 'Minimum number of years of relevant work experience required for this position. Used in recruiting requisition screening criteria and candidate qualification assessments.',
    `pay_frequency` STRING COMMENT 'Frequency at which compensation is paid for this position (hourly, weekly, biweekly, semimonthly, monthly, annual). Determines whether pay_rate_min/mid/max represent hourly or annual figures. Drives payroll processing in Workday HCM.. Valid values are `hourly|weekly|biweekly|semimonthly|monthly|annual`',
    `pay_grade` STRING COMMENT 'Compensation pay grade band assigned to the position, linking it to the salary range structure (e.g., PG-G1, PG-M3). Confidential business data used for compensation equity analysis and benchmarking. Sourced from Workday HCM compensation framework.. Valid values are `^PG-[A-Z0-9]{1,5}$`',
    `pay_rate_max` DECIMAL(18,2) COMMENT 'Maximum budgeted hourly or annual pay rate for this positions pay grade range. Used for compensation ceiling enforcement, offer approvals, and pay equity compliance. Currency is USD.',
    `pay_rate_mid` DECIMAL(18,2) COMMENT 'Midpoint of the budgeted pay rate range for this positions pay grade. Represents the market-competitive target compensation. Used for compa-ratio analysis and compensation benchmarking. Currency is USD.',
    `pay_rate_min` DECIMAL(18,2) COMMENT 'Minimum budgeted hourly or annual pay rate for this positions pay grade range. Used for compensation planning, offer generation, and pay equity compliance. Confidential compensation data. Currency is USD.',
    `physical_demands_level` STRING COMMENT 'DOL physical exertion classification for the position based on lifting, standing, and mobility requirements (sedentary, light, medium, heavy, very_heavy). Required for ADA (Americans with Disabilities Act) reasonable accommodation assessments and OSHA safety compliance.. Valid values are `sedentary|light|medium|heavy|very_heavy`',
    `position_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the position or job profile slot within Workday HCM and downstream HR systems. Used for cross-system reconciliation with Kronos Workforce Central and SAP CO cost center assignments.. Valid values are `^POS-[A-Z0-9]{4,12}$`',
    `position_status` STRING COMMENT 'Current lifecycle state of the authorized headcount position: open (vacant and approved for hire), filled (occupied by an active associate), frozen (approved but hiring suspended), eliminated (decommissioned), or pending_approval (awaiting budget authorization). Drives recruiting requisition creation.. Valid values are `open|filled|frozen|eliminated|pending_approval`',
    `position_type` STRING COMMENT 'Classification of the position by employment arrangement (regular, temporary, seasonal, contract, intern). Seasonal positions are common in grocery retail for holiday and harvest periods. Drives benefits eligibility and labor cost planning.. Valid values are `regular|temporary|seasonal|contract|intern`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this position record was first created in the Databricks Silver Layer lakehouse. Supports data lineage, audit trails, and SLA monitoring for HR data pipeline processing.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this position record was most recently updated in the Databricks Silver Layer lakehouse. Used for incremental data pipeline processing, change detection, and audit compliance.',
    `required_certifications` STRING COMMENT 'Pipe-delimited list of mandatory certifications required for this position (e.g., pharmacy_license|food_handler_card|forklift_certification|dea_handler_registration|servsafe). Drives compliance tracking and hiring eligibility checks. DEA handler registration required for pharmacy positions per DEA regulations. [ENUM-REF-CANDIDATE: pharmacy_license|food_handler_card|forklift_certification|dea_handler_registration|servsafe|haccp_certification — promote to reference product]',
    `source_system_code` STRING COMMENT 'Native identifier of this position record in the originating system of record (Workday HCM). Enables lineage tracing and reconciliation between the Silver Layer lakehouse and the upstream HR system.',
    `time_type` STRING COMMENT 'Indicates whether the position is designated as full-time or part-time based on scheduled hours. Drives benefits eligibility thresholds under the Affordable Care Act (ACA) and union contract provisions.. Valid values are `full_time|part_time`',
    `title` STRING COMMENT 'Human-readable job title for the position as displayed on offer letters, org charts, and scheduling systems (e.g., Pharmacy Technician, Store Associate, DC Forklift Operator, Category Manager). Aligns with Workday HCM job profile title.',
    `union_eligible` BOOLEAN COMMENT 'Indicates whether this position is eligible for union membership under a collective bargaining agreement. Grocery retail positions (store associates, DC workers) are frequently unionized. Drives labor relations compliance and contract administration.',
    `vacancy_reason` STRING COMMENT 'Reason code explaining why the position is currently vacant (new_position, resignation, termination, transfer, retirement, leave_of_absence). Drives recruiting requisition creation and workforce planning analytics.. Valid values are `new_position|resignation|termination|transfer|retirement|leave_of_absence`',
    `worker_type` STRING COMMENT 'Classification of the worker category associated with this position (employee, contingent_worker, intern, volunteer). Determines benefits eligibility, payroll processing rules, and labor law applicability in Workday HCM.. Valid values are `employee|contingent_worker|intern|volunteer`',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Authorized headcount positions and standardized job profile definitions within the Grocery organization. Represents approved job slots tied to a cost center, store, DC, or corporate department. At the position level: tracks position title, job code, department, FTE allocation, budgeted headcount, filled/vacant status, reporting hierarchy (supervisor position), and effective dates. As the job profile template: defines job family, job level, FLSA classification (exempt/non-exempt), pay grade range (min/mid/max), required certifications (pharmacy license, food handler card, forklift, DEA handler), union eligibility by bargaining unit, competency framework, physical requirements, minimum qualifications, and career ladder progression. Serves as the single source of truth for both structural headcount planning and standardized role definitions used for associate assignments and recruiting requisitions. Sourced from Workday HCM Position Management.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Unique surrogate identifier for the job profile record in the Grocery workforce data platform. Primary key for the job_profile entity. Sourced from Workday HCM Job Profile object.',
    `approval_date` DATE COMMENT 'The date on which this job profile was formally approved by the authorized HR or compensation governance body. Required for SOX internal controls and compensation change audit trails.',
    `approved_by` STRING COMMENT 'The name or identifier of the HR leader or compensation committee member who approved this job profile definition. Supports governance, audit trail, and SOX internal controls for compensation structure changes.',
    `competency_framework_code` STRING COMMENT 'The identifier for the competency framework model assigned to this job profile in Workday HCM. Links to the set of required skills, behaviors, and proficiency levels used in performance reviews, talent assessments, and succession planning.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this job profile record was first created in the Grocery workforce data platform (Silver Layer). Represents the audit trail creation event for data lineage and SOX compliance.',
    `critical_role` BOOLEAN COMMENT 'Indicates whether this job profile is designated as a critical role for succession planning purposes. Critical roles are those where vacancy would significantly impact business operations (e.g., Pharmacist-in-Charge, DC Operations Manager). Used in Workday HCM talent management.',
    `eeoc_job_category` STRING COMMENT 'The EEO-1 job category assigned to this profile for federal workforce diversity reporting (e.g., Professionals, Sales Workers, Operatives, Service Workers). Required for annual EEO-1 Component 1 filing with the EEOC. [ENUM-REF-CANDIDATE: exec_senior_officials|first_mid_officials|professionals|technicians|sales_workers|admin_support|craft_workers|operatives|laborers|service_workers — promote to reference product]',
    `effective_date` DATE COMMENT 'The date on which this job profile version became effective and available for use in position creation and associate assignments. Supports point-in-time reporting and historical job profile analysis.',
    `flsa_classification` STRING COMMENT 'Indicates whether the job profile is classified as exempt or non-exempt under the Fair Labor Standards Act (FLSA). Non-exempt roles are eligible for overtime pay. Critical for labor compliance, payroll processing, and DOL audit readiness.. Valid values are `exempt|non_exempt|highly_compensated_exempt`',
    `full_time_equivalent` DECIMAL(18,2) COMMENT 'The standard full-time equivalent value assigned to this job profile (e.g., 1.0 for full-time, 0.5 for part-time). Used in headcount planning, labor budget modeling, and workforce analytics in Kronos Workforce Central.',
    `inactive_date` DATE COMMENT 'The date on which this job profile was retired or deactivated and is no longer available for new position assignments. Null for currently active profiles. Used in workforce planning and historical reporting.',
    `job_category` STRING COMMENT 'Broad employment category indicating the nature of the roles compensation structure (e.g., hourly, salaried, contract, seasonal). Used in payroll processing, benefits eligibility, and labor cost reporting.. Valid values are `hourly|salaried|contract|seasonal`',
    `job_description` STRING COMMENT 'The full narrative description of the job profile including primary responsibilities, duties, and scope of work. Used in job postings, offer letters, and performance management. Sourced from Workday HCM job profile definition.',
    `job_family` STRING COMMENT 'The broad grouping of related job profiles that share common competencies and career paths (e.g., Store Operations, Pharmacy, Supply Chain, Finance, Technology). Used for workforce planning and compensation benchmarking.',
    `job_family_group` STRING COMMENT 'The higher-level grouping above job family that clusters related families under a major business function (e.g., Retail Operations, Corporate Functions, Distribution & Logistics). Supports enterprise-wide workforce analytics and reporting.',
    `job_level` STRING COMMENT 'The hierarchical level of the job profile within the organizations career framework (e.g., entry, associate, senior, lead, manager, director, vp, executive). Drives compensation banding and career progression planning. [ENUM-REF-CANDIDATE: entry|associate|senior|lead|manager|director|vp|executive — 8 candidates stripped; promote to reference product]',
    `job_profile_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the job profile across Grocery locations and systems. Used in scheduling, payroll, and labor analytics integrations with Kronos Workforce Central and SAP CO.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this job profile record was most recently updated in the Grocery workforce data platform. Used for change data capture (CDC), incremental ETL processing, and audit trail maintenance.',
    `management_level` STRING COMMENT 'Indicates whether the job profile is an individual contributor or carries people management responsibilities. Used for span-of-control analysis, succession planning, and leadership development programs.. Valid values are `individual_contributor|team_lead|manager|senior_manager|director|executive`',
    `osha_job_hazard_level` STRING COMMENT 'The OSHA-assessed occupational hazard level for this job profile based on physical demands, chemical exposure, equipment operation, and environmental risks. Used in safety training assignment, PPE requirements, and OSHA 300 log incident analysis.. Valid values are `low|medium|high|very_high`',
    `pay_grade` STRING COMMENT 'The compensation grade band assigned to this job profile (e.g., G01, G10, M05). Determines the salary or hourly wage range applicable to associates in this role. Confidential business data used in compensation planning and equity analysis.. Valid values are `^[A-Z]{1,3}[0-9]{1,3}$`',
    `pay_rate_max` DECIMAL(18,2) COMMENT 'The maximum hourly rate or annual salary (in USD) defined for this job profiles pay grade band. Used in compensation planning, offer generation, and pay equity analysis. Confidential business data.',
    `pay_rate_min` DECIMAL(18,2) COMMENT 'The minimum hourly rate or annual salary (in USD) defined for this job profiles pay grade band. Used in compensation planning, offer generation, and pay equity analysis. Confidential business data.',
    `pay_rate_type` STRING COMMENT 'Indicates whether the pay rate range (min/max) is expressed as an hourly wage, annual salary, or daily rate. Determines how compensation is calculated and reported in payroll and labor analytics.. Valid values are `hourly|annual|daily`',
    `profile_status` STRING COMMENT 'Current lifecycle status of the job profile record. active profiles are available for position creation and associate assignment. retired profiles are no longer used for new hires but may exist on legacy positions. Sourced from Workday HCM.. Valid values are `active|inactive|draft|pending_approval|retired`',
    `public_sector_reporting_code` STRING COMMENT 'The Standard Occupational Classification (SOC) code assigned to this job profile by the Bureau of Labor Statistics. Used for government labor market reporting, EEO-1 filings, and workforce analytics benchmarking.',
    `requires_alcohol_cert` BOOLEAN COMMENT 'Indicates whether this job profile requires a state-mandated responsible alcohol sales certification (e.g., TIPS, ServSafe Alcohol). Applicable to cashier, customer service, and liquor department roles per state ABC regulations.',
    `requires_background_check` BOOLEAN COMMENT 'Indicates whether a pre-employment background check is mandatory for this job profile. Typically required for pharmacy, finance, and management roles. Supports FCRA-compliant hiring workflows.',
    `requires_drug_test` BOOLEAN COMMENT 'Indicates whether pre-employment or random drug testing is required for this job profile. Mandatory for safety-sensitive roles (e.g., forklift operators, pharmacy staff, fuel center workers) per DOT and DEA regulations.',
    `requires_food_handler_cert` BOOLEAN COMMENT 'Indicates whether associates in this job profile are required to hold a valid food handler certification. Mandatory for roles involving food preparation, handling, or service per FDA Food Safety Modernization Act (FSMA) and local health department requirements.',
    `requires_forklift_cert` BOOLEAN COMMENT 'Indicates whether associates in this job profile must hold a valid OSHA-compliant forklift operator certification. Applicable to DC and backroom roles operating powered industrial trucks. Drives safety compliance and training tracking.',
    `requires_pharmacy_license` BOOLEAN COMMENT 'Indicates whether this job profile requires a valid state pharmacy license (e.g., Pharmacist-in-Charge, Staff Pharmacist). Drives compliance tracking with State Boards of Pharmacy and DEA controlled substance dispensing requirements.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this job profile was sourced (e.g., workday for Workday HCM, kronos for Kronos Workforce Central). Used for data lineage tracking and reconciliation in the Databricks Silver Layer.. Valid values are `workday|kronos|sap_hcm|manual`',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'The standard number of scheduled hours per week for this job profile (e.g., 40.0 for full-time, 20.0 for part-time). Used in scheduling templates, benefits eligibility determination, and ACA compliance tracking.',
    `summary` STRING COMMENT 'A concise summary (typically 1-3 sentences) of the job profiles purpose and key accountabilities. Used in internal job postings, career site listings, and employee self-service portals.',
    `title` STRING COMMENT 'The official, human-readable job title associated with this job profile (e.g., Pharmacy Technician, Store Associate, DC Forklift Operator, Category Manager). Displayed on offer letters, org charts, and scheduling systems.',
    `union_code` STRING COMMENT 'The identifier for the labor union or collective bargaining unit associated with this job profile (e.g., UFCW-1500 for United Food and Commercial Workers). Populated only when union_eligible is true. Used for CBA compliance and dues reporting.',
    `union_eligible` BOOLEAN COMMENT 'Indicates whether associates in this job profile are eligible for union membership or covered under a collective bargaining agreement (CBA). Drives labor relations tracking, CBA compliance, and union dues processing.',
    `work_location_type` STRING COMMENT 'The primary work environment type for this job profile. Distinguishes roles based on operational context (e.g., in_store for store associates, distribution_center for DC workers, pharmacy for licensed pharmacy staff, fuel_center for fuel attendants). [ENUM-REF-CANDIDATE: in_store|distribution_center|corporate|remote|hybrid|pharmacy|fuel_center — promote to reference product]',
    `work_shift_type` STRING COMMENT 'The standard shift pattern associated with this job profile (e.g., day, evening, overnight, rotating, flexible). Used in Kronos Workforce Central scheduling templates and shift differential pay calculations.. Valid values are `day|evening|overnight|rotating|flexible`',
    `workday_job_profile_code` STRING COMMENT 'The native system identifier for the job profile as assigned by Workday HCM. Used for cross-system reconciliation and integration with upstream HR source of record.',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Standardized job role definitions used across Grocery locations including job title, job family, job level, required certifications (e.g., pharmacy license, food handler card, forklift certification), pay grade range, FLSA classification, union eligibility, and competency framework. Acts as the template for positions and associate assignments. Sourced from Workday HCM.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique surrogate identifier for the organizational unit record in the Workday HCM system. Serves as the primary key for the org_unit data product in the Silver Layer lakehouse.',
    `associate_id` BIGINT COMMENT 'Identifier of the employee designated as the manager or supervisor responsible for this organizational unit. Used for span-of-control reporting, labor analytics, and escalation routing. References the employee master in Workday HCM.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Org units are budgeted to a primary cost center; the FK replaces the denormalized cost_center_code for accurate budgeting.',
    `dc_facility_id` BIGINT COMMENT 'Identifier of the distribution center to which this organizational unit belongs. Applicable for DC functional areas (e.g., Receiving, Putaway, Picking, Shipping, Cold Chain). Null for store departments and corporate divisions. Supports DC labor cost allocation and WMS integration.',
    `parent_org_unit_id` BIGINT COMMENT 'Self-referencing identifier pointing to the immediate parent organizational unit in the enterprise hierarchy. Enables traversal of the full organizational tree from store department up through district, region, and corporate division. Null for the root-level corporate entity.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Required for Pricing Strategy Assignment report: each org unit (store) is assigned a pricing zone to apply zone‑specific price rules and promotions.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Store‑level org units report P&L to a profit center; linking enables consolidated profit‑center financial statements.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Required for Org Unit Compliance Program Assignment report, linking each org unit to its governing compliance program for audit scheduling.',
    `store_location_id` BIGINT COMMENT 'Identifier of the retail store location to which this organizational unit belongs. Applicable for store-level departments (e.g., Produce, Deli, Pharmacy, Fuel Center). Null for DC functional areas and corporate divisions. Supports store-level labor cost allocation and same-store sales reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this organizational unit record was first created in the Workday HCM system. Serves as the RECORD_AUDIT_CREATED field for this MASTER_RESOURCE entity. Used for data lineage, audit trails, and SOX compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the labor budget and financial amounts associated with this organizational unit. Primarily USD for domestic operations; CAD or MXN for international locations.. Valid values are `USD|CAD|MXN`',
    `district_code` STRING COMMENT 'Alphanumeric code identifying the district within a region to which this organizational unit belongs. Used for district-level labor analytics, scheduling oversight, and management reporting in Kronos Workforce Central.',
    `effective_end_date` DATE COMMENT 'The date on which this organizational unit ceased or will cease to be operationally effective. Null for currently active units with no planned end date. Used for historical org hierarchy reporting and labor cost period allocation.',
    `effective_start_date` DATE COMMENT 'The date on which this organizational unit became or becomes operationally effective within the enterprise hierarchy. Used for point-in-time reporting, labor cost allocation by period, and SOX audit trails. Supports bi-temporal modeling of the org hierarchy.',
    `external_reference_code` STRING COMMENT 'An external or legacy system reference code for this organizational unit, used for EDI integration, third-party vendor reporting, or migration from legacy ERP systems. Supports cross-system reconciliation during system transitions.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which the labor budget and headcount budget figures are applicable. Grocerys fiscal year may differ from the calendar year. Used for period-specific financial reporting and SOX compliance.',
    `gl_account_code` STRING COMMENT 'The SAP FI General Ledger account code associated with this organizational unit for labor expense posting. Maps payroll and labor costs to the correct GL account for financial reporting and SOX compliance. Supports EBITDA and comp sales financial analysis.',
    `headcount_budget` STRING COMMENT 'The approved budgeted number of full-time equivalent (FTE) positions authorized for this organizational unit. Used for workforce planning, labor analytics, and variance reporting against actual headcount. Sourced from Workday HCM position management.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this organizational unit within the enterprise hierarchy tree. Level 1 represents the top-level corporate entity; higher numbers represent deeper levels (e.g., region=2, district=3, store=4, department=5). Used for hierarchical rollup reporting and labor cost allocation.',
    `hierarchy_path` STRING COMMENT 'Materialized path string representing the full ancestry chain of the organizational unit from root to current node (e.g., /Corporate/Southeast Region/District 7/Store 1042/Pharmacy). Enables efficient subtree queries for labor cost rollup and reporting hierarchies without recursive joins.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this organizational unit is currently active and operational. Derived from the status field for simplified filtering in reporting and analytics queries. True when status is active; False for all other statuses.',
    `is_food_safety_unit` BOOLEAN COMMENT 'Indicates whether this organizational unit handles food products subject to FDA food safety and labeling requirements, USDA organic certification and meat/poultry inspection, and HACCP (Hazard Analysis Critical Control Points) compliance. Drives food safety audit scoping and HACCP plan assignment.',
    `is_fuel_center_unit` BOOLEAN COMMENT 'Indicates whether this organizational unit is a fuel center subject to EPA refrigerant management and fuel center emissions regulations, as well as specialized fuel pricing and operations management. Drives EPA compliance reporting and fuel operations analytics.',
    `is_pharmacy_unit` BOOLEAN COMMENT 'Indicates whether this organizational unit is a pharmacy department subject to DEA controlled substance regulations, State Board of Pharmacy licensing, HIPAA patient data privacy requirements, and McKesson Pharmacy Systems integration. Drives compliance reporting and regulatory audit scoping.',
    `kronos_org_code` STRING COMMENT 'The organizational unit identifier as defined in Kronos Workforce Central scheduling and time-and-attendance system. Used for labor scheduling, time tracking, and attendance management integration. Enables reconciliation between Workday HCM org structure and Kronos labor data.',
    `labor_agreement_type` STRING COMMENT 'Classification of the labor agreement type governing associates in this organizational unit. Determines applicable scheduling rules, overtime policies, and payroll processing logic in Kronos Workforce Central and Workday HCM.. Valid values are `union|non_union|management|contractor`',
    `labor_budget_amount` DECIMAL(18,2) COMMENT 'The approved annual labor cost budget (in USD) allocated to this organizational unit. Used for labor cost variance analysis, EBITDA reporting, and financial controlling. Represents the principal quantitative financial fact for this resource. Sourced from SAP CO Controlling and Workday HCM.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this organizational unit record was most recently updated in the Workday HCM system. Used for change data capture (CDC), data lineage, and SOX audit trails to track org structure changes.',
    `max_headcount` STRING COMMENT 'The maximum number of associates that can be simultaneously scheduled or physically accommodated in this organizational unit. Used for labor scheduling constraints in Kronos Workforce Central and OSHA safety compliance (occupancy limits).',
    `operating_hours_end` STRING COMMENT 'The standard daily closing or end time for this organizational unit in HH:MM (24-hour) format. Used for labor scheduling in Kronos Workforce Central and store operations planning. Applicable to store departments and DC functional areas with defined operating windows.. Valid values are `^([01]d|2[0-3]):[0-5]d$`',
    `operating_hours_start` STRING COMMENT 'The standard daily opening or start time for this organizational unit in HH:MM (24-hour) format. Used for labor scheduling in Kronos Workforce Central and store operations planning. Applicable to store departments and DC functional areas with defined operating windows.. Valid values are `^([01]d|2[0-3]):[0-5]d$`',
    `org_unit_description` STRING COMMENT 'Free-text description of the organizational units business purpose, scope of operations, and key responsibilities. Provides context for business users beyond the unit name and type classification. Sourced from Workday HCM Org Management.',
    `org_unit_name` STRING COMMENT 'Human-readable name of the organizational unit (e.g., Produce Department, Pharmacy, Fuel Center, Distribution Center - Atlanta, Corporate Finance). Serves as the IDENTITY_LABEL for this MASTER_RESOURCE entity.',
    `org_unit_status` STRING COMMENT 'Current lifecycle state of the organizational unit within the enterprise hierarchy. active indicates the unit is currently operational; inactive indicates it has been decommissioned; pending indicates it is being set up; dissolved indicates it has been permanently closed; on_hold indicates temporarily suspended operations. Serves as the LIFECYCLE_STATUS for this MASTER_RESOURCE entity.. Valid values are `active|inactive|pending|dissolved|on_hold`',
    `osha_establishment_number` STRING COMMENT 'The OSHA establishment identifier assigned to this organizational unit for workplace safety incident reporting (OSHA 300 Log). Required for OSHA 29 CFR 1904 recordkeeping compliance. Applicable to store departments, DC functional areas, and fuel centers with distinct safety profiles.',
    `planogram_zone` STRING COMMENT 'The planogram zone designation for store department organizational units, indicating the physical area of the store floor (e.g., Zone A - Perimeter, Zone B - Center Aisle, Endcap Row 3). Used for merchandise planning, assortment management, and labor allocation to specific store zones.',
    `region_code` STRING COMMENT 'Alphanumeric code identifying the geographic or operational region to which this organizational unit belongs. Used for regional labor analytics, comp sales reporting, and district management. Aligns with Grocerys internal regional hierarchy.',
    `sap_org_unit_code` STRING COMMENT 'The organizational unit code as defined in SAP HCM or SAP CO for cross-system reconciliation. Used to map Workday HCM org units to SAP cost objects for financial posting and ERP integration.',
    `square_footage` DECIMAL(18,2) COMMENT 'The physical floor area in square feet allocated to this organizational unit within the store or distribution center. Used for labor productivity analysis (sales per square foot), planogram planning, and facility management. Applicable to store departments and DC functional areas.',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'The standard scheduled labor hours per week for this organizational unit as defined in Kronos Workforce Central. Used as the baseline for labor scheduling, overtime calculation, and labor budget variance analysis. Reflects the operational capacity of the unit.',
    `union_code` STRING COMMENT 'Code identifying the labor union or collective bargaining agreement (CBA) applicable to associates in this organizational unit. Grocery retail commonly involves UFCW (United Food and Commercial Workers) and Teamsters agreements. Drives labor compliance, scheduling rules, and payroll processing.',
    `unit_subtype` STRING COMMENT 'Further classification of the organizational unit within its type. For store departments, identifies specialty areas such as Fresh Produce, Deli, Bakery, Pharmacy, Fuel Center, Floral, Meat, Seafood, or General Merchandise. For DC functional areas, identifies Receiving, Putaway, Picking, Shipping, or Cold Chain. [ENUM-REF-CANDIDATE: fresh_produce|deli|bakery|pharmacy|fuel_center|floral|meat|seafood|general_merchandise|receiving|putaway|picking|shipping|cold_chain|hr|finance|it|marketing|operations — promote to reference product]',
    `unit_type` STRING COMMENT 'Categorical classification of the organizational unit indicating its role in the enterprise hierarchy. Segments the population into store departments (e.g., Produce, Deli, Pharmacy, Fuel), DC functional areas, corporate divisions, cost centers, regions, and districts. Serves as the CLASSIFICATION_OR_TYPE for this MASTER_RESOURCE entity.. Valid values are `store_department|dc_functional_area|corporate_division|cost_center|region|district`',
    `workday_org_unit_code` STRING COMMENT 'The externally-known unique alphanumeric code assigned to the organizational unit in Workday HCM. Used for cross-system integration with SAP CO (Controlling) cost center mapping and Kronos Workforce Central labor allocation. Serves as the BUSINESS_IDENTIFIER for this MASTER_RESOURCE entity.',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational hierarchy units representing departments, cost centers, store departments (e.g., Produce, Deli, Pharmacy, Fuel), DC functional areas, and corporate divisions. Tracks unit name, unit type, parent unit, cost center code, GL account mapping, manager, and effective dates. Supports labor cost allocation and reporting hierarchies. Sourced from Workday HCM Org Management.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`shift` (
    `shift_id` BIGINT COMMENT 'Unique system-generated identifier for a scheduled work shift record in Kronos Workforce Central. Primary key for the shift entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Shift‑level labor cost tracking (overtime, premium pay) is allocated to cost centers for detailed expense analysis.',
    `department_id` BIGINT COMMENT 'Reference to the department within the store or DC to which this shift is assigned (e.g., Produce, Pharmacy, Bakery, Front End, Receiving).',
    `node_id` BIGINT COMMENT 'Foreign key linking to fulfillment.node. Business justification: Enables Shift Scheduling in fulfillment centers, used by Kronos to schedule associates per node.',
    `position_id` BIGINT COMMENT 'Reference to the job position or role associated with this shift (e.g., Cashier, Stock Associate, Pharmacist, DC Picker). Sourced from Workday HCM position management.',
    `associate_id` BIGINT COMMENT 'Reference to the manager or supervisor employee record who approved this shift in Kronos. Supports management accountability and schedule audit trails.',
    `shift_associate_id` BIGINT COMMENT 'Reference to the employee assigned to this shift. Links to the workforce employee master record in Workday HCM.',
    `shift_original_employee_associate_id` BIGINT COMMENT 'Reference to the employee originally assigned to this shift before a swap or reassignment occurred. Populated only when a shift swap or coverage change has taken place.',
    `store_location_id` BIGINT COMMENT 'Reference to the store, Distribution Center (DC), pharmacy, or fuel center where this shift is scheduled to be worked.',
    `acknowledgement_timestamp` TIMESTAMP COMMENT 'The date and time when the employee acknowledged or confirmed this shift in Kronos. Populated only when employee_acknowledgement is True.',
    `advance_notice_days` STRING COMMENT 'Number of calendar days in advance the shift was published to the employee prior to the shift date. Used to monitor compliance with predictive scheduling and fair workweek regulations.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the shift was approved by a manager or supervisor in Kronos. Marks the transition from draft or pending state to approved status in the scheduling workflow.',
    `cancellation_reason` STRING COMMENT 'The reason code for shift cancellation when schedule_status is cancelled. Used for labor analytics, predictive scheduling compliance reporting, and workforce planning. [ENUM-REF-CANDIDATE: no_show|voluntary|manager_cancelled|low_volume|weather|other — promote to reference product if additional values are needed]. Valid values are `no_show|voluntary|manager_cancelled|low_volume|weather|other`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the shift record was first created in Kronos Workforce Central. Serves as the record audit creation timestamp for data lineage and compliance purposes.',
    `employee_acknowledgement` BOOLEAN COMMENT 'Indicates whether the employee has acknowledged or confirmed receipt of this scheduled shift via Kronos self-service or mobile app. Supports predictive scheduling compliance documentation.',
    `is_holiday` BOOLEAN COMMENT 'Indicates whether this shift falls on a company-designated holiday, triggering holiday pay rules and premium pay calculations in Kronos and Workday HCM payroll.',
    `is_on_call` BOOLEAN COMMENT 'Indicates whether this shift is designated as an on-call shift, where the employee may be required to report to work on short notice based on operational demand.',
    `is_open_shift` BOOLEAN COMMENT 'Indicates whether this shift is an open (unassigned) shift available for employees to claim or pick up. Open shifts are published to eligible employees for voluntary coverage in Kronos.',
    `is_overtime` BOOLEAN COMMENT 'Indicates whether this shift is expected to result in overtime hours based on the employees weekly scheduled hours at the time of scheduling. Used for proactive overtime management and labor budget control.',
    `kronos_shift_code` STRING COMMENT 'The externally-known unique shift identifier as assigned by Kronos Workforce Central. Used for cross-system reconciliation and audit traceability between the lakehouse and the system of record.',
    `label` STRING COMMENT 'Human-readable name or code assigned to the shift template in Kronos (e.g., AM-6-2, PM-2-10, PHARM-OPEN). Used by store managers for quick identification and schedule communication.',
    `labor_category` STRING COMMENT 'Classification of the labor type for this shift used in labor cost accounting and GMROI (Gross Margin Return on Investment) analysis. Determines how labor hours are allocated to cost centers in SAP Retail CO.. Valid values are `regular|overtime|holiday|on_call|training`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the shift record was most recently updated in Kronos Workforce Central. Used for change detection, incremental data loading, and audit trail maintenance.',
    `location_type` STRING COMMENT 'Categorization of the work location where the shift is performed. Distinguishes between retail store, Distribution Center (DC), pharmacy, fuel center, and corporate office assignments for labor analytics segmentation.. Valid values are `store|dc|pharmacy|fuel_center|corporate`',
    `meal_break_minutes` STRING COMMENT 'Total scheduled unpaid meal break duration in minutes for this shift. Used to calculate net paid hours and ensure compliance with state labor law meal break requirements.',
    `minimum_rest_hours` DECIMAL(18,2) COMMENT 'The minimum number of hours of rest required between this shift and the preceding shift for the same employee, as defined by company policy or applicable labor regulations. Used to flag clopening shifts (close followed by open).',
    `pay_rule_code` STRING COMMENT 'The Kronos pay rule applied to this shift, governing how hours are calculated for payroll purposes (e.g., regular, overtime, holiday, premium). Drives downstream payroll processing in Workday HCM.',
    `published_timestamp` TIMESTAMP COMMENT 'The date and time when the shift was published and made visible to the assigned employee in Kronos. Used to measure schedule advance notice compliance with predictive scheduling laws.',
    `rest_break_minutes` STRING COMMENT 'Total scheduled paid rest break duration in minutes for this shift. Used to ensure compliance with state labor law rest break requirements and accurate paid hours calculation.',
    `schedule_week_start_date` DATE COMMENT 'The start date of the scheduling week (typically Sunday) to which this shift belongs. Used for weekly hour aggregation, overtime threshold monitoring, and schedule period reporting.',
    `scheduled_end_time` TIMESTAMP COMMENT 'The planned date and time the employee is scheduled to end their shift, including timezone offset. For overnight shifts, this timestamp will fall on the following calendar date.',
    `scheduled_hours` DECIMAL(18,2) COMMENT 'Total number of hours the employee is scheduled to work for this shift, calculated as the difference between scheduled end time and scheduled start time. Used for weekly hour tracking, overtime monitoring, and labor budget compliance.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The planned date and time the employee is scheduled to begin their shift, including timezone offset. Used for store coverage planning and labor cost forecasting.',
    `shift_date` DATE COMMENT 'The calendar date on which the shift is scheduled to occur. For overnight shifts spanning midnight, this is the date the shift begins. Used for daily labor planning and store coverage analysis.',
    `shift_type` STRING COMMENT 'Classification of the shift based on its time-of-day position within the store operating day. Open shifts cover store opening, mid shifts cover peak daytime hours, close shifts cover store closing, overnight shifts span midnight, and split shifts have a significant unpaid break between two work segments.. Valid values are `open|mid|close|overnight|split`',
    `source_system` STRING COMMENT 'Identifies the originating system that created or last updated this shift record. Kronos Workforce Central is the primary system of record; Workday HCM may contribute position data; manual indicates direct data entry.. Valid values are `kronos|workday|manual`',
    `swap_status` STRING COMMENT 'Indicates whether a shift swap has been requested or processed for this shift. Tracks the lifecycle of employee-initiated shift exchanges managed through Kronos self-service.. Valid values are `none|requested|approved|denied`',
    `workload_budget_hours` DECIMAL(18,2) COMMENT 'The budgeted labor hours allocated to this shift based on the stores labor model and forecasted customer demand from Blue Yonder Demand Planning. Used for variance analysis between scheduled and budgeted hours.',
    CONSTRAINT pk_shift PRIMARY KEY(`shift_id`)
) COMMENT 'Scheduled work shifts for store associates, DC workers, and pharmacy staff generated by Kronos Workforce Central. Captures shift date, start time, end time, scheduled hours, shift type (open/mid/close/overnight), department assignment, store or DC location, and schedule status (published/draft/approved). Core operational entity for labor scheduling and store coverage planning.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`schedule` (
    `schedule_id` BIGINT COMMENT 'Unique surrogate identifier for the labor schedule record in the Databricks Silver Layer. Primary key generated by the Kronos Workforce Central scheduling system.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Scheduling tools assign planned labor hours to cost centers to support labor budgeting and variance reporting.',
    `department_id` BIGINT COMMENT 'Reference to the store department or work area covered by this schedule (e.g., Produce, Pharmacy, Deli, DC Receiving). Drives department-level labor coverage targets.',
    `associate_id` BIGINT COMMENT 'Reference to the store manager or department manager who owns and is accountable for this schedule. Used for approval workflow and labor accountability reporting.',
    `schedule_employee_associate_id` BIGINT COMMENT 'Reference to the store associate, pharmacist, DC worker, or corporate staff member assigned to this shift. Links to the workforce employee master for seniority, role, and wage data.',
    `schedule_replacement_employee_associate_id` BIGINT COMMENT 'Reference to the associate who covered this shift in the event of a call-off or swap. Populated only when call_off_flag is True or shift_swap_status is completed. Supports coverage gap resolution tracking.',
    `shift_id` BIGINT COMMENT 'Unique surrogate identifier for an individual shift assignment within the schedule. Represents a single associates scheduled work block on a specific date. Acts as the line-item primary key within the schedule.',
    `store_location_id` BIGINT COMMENT 'Reference to the store or facility location for which this schedule was generated. Covers supermarkets, pharmacies, distribution centers, and fuel centers.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the schedule was formally approved by the store director or authorized manager. Marks the schedule as finalized for operational execution.',
    `auto_scheduled_flag` BOOLEAN COMMENT 'Indicates whether this schedule was generated by the Kronos auto-scheduler engine (True) or manually built by a manager (False). Used to measure auto-scheduler adoption and quality.',
    `break_minutes` STRING COMMENT 'Total scheduled unpaid break time in minutes for this shift. Includes meal breaks and rest periods as required by state labor law and collective bargaining agreements. Used for net hours calculation.',
    `call_off_flag` BOOLEAN COMMENT 'Indicates whether the assigned associate called off (was absent) for this scheduled shift (True) or worked as scheduled (False). Drives call-off rate reporting and attendance policy enforcement.',
    `coverage_target_pct` DECIMAL(18,2) COMMENT 'Target percentage of required labor coverage positions that must be filled for each operating hour in the schedule period. Expressed as a percentage (e.g., 95.00 = 95%). Supports store operations and replenishment coverage planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the schedule record was first created in Kronos Workforce Central. Serves as the audit trail anchor for schedule lifecycle tracking.',
    `job_code` STRING COMMENT 'Kronos/Workday job code identifying the role or position the associate is scheduled to perform during this shift (e.g., CASHIER, PRODUCE_CLERK, PHARMACIST, DC_PICKER). Drives wage rate application and skill-based scheduling.',
    `kronos_schedule_code` STRING COMMENT 'Native schedule identifier assigned by Kronos Workforce Central. Used for cross-system reconciliation between the Silver Layer and the source scheduling system.',
    `labor_budget_amount` DECIMAL(18,2) COMMENT 'Approved labor cost budget in USD for this schedule period and department. Derived from labor budget hours multiplied by blended wage rates. Used for financial labor cost control and EBITDA (Earnings Before Interest Taxes Depreciation and Amortization) reporting.',
    `labor_budget_hours` DECIMAL(18,2) COMMENT 'Approved labor budget expressed in hours for this schedule period and department, sourced from the stores labor model. Enables budget vs. scheduled vs. actual labor variance analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the schedule header record. Used for change detection, incremental ETL processing, and audit compliance.',
    `locked_timestamp` TIMESTAMP COMMENT 'Date and time when the schedule was locked for payroll processing. After this point, no further shift modifications are permitted without a payroll adjustment workflow.',
    `minor_work_restriction_flag` BOOLEAN COMMENT 'Indicates whether this shift was scheduled subject to minor labor law restrictions (True), applicable to associates under 18 years of age. Ensures compliance with FLSA child labor provisions and state minor work permit requirements.',
    `overtime_flag` BOOLEAN COMMENT 'Indicates whether this shift is projected to contribute to overtime hours for the associate (True) based on weekly hours accumulation at schedule build time. Used for proactive overtime cost management.',
    `paid_break_minutes` STRING COMMENT 'Total scheduled paid break time in minutes for this shift (e.g., 15-minute paid rest breaks). Distinct from unpaid meal breaks. Included in total compensable hours per FLSA and CBA requirements.',
    `period_end_date` DATE COMMENT 'Last calendar date of the schedule period. Defines the closing boundary of the scheduling window. Must be 6 days after period_start_date for weekly or 13 days after for bi-weekly schedules.',
    `period_start_date` DATE COMMENT 'First calendar date of the schedule period. Combined with period_end_date defines the full scheduling window for labor coverage planning.',
    `period_type` STRING COMMENT 'Defines whether the schedule covers a weekly (7-day) or bi-weekly (14-day) labor period. Aligns with the stores payroll cycle configuration in Workday HCM.. Valid values are `weekly|bi_weekly`',
    `predictive_scheduling_notice_days` STRING COMMENT 'Number of calendar days of advance notice provided to the associate before this shift, measured from published_timestamp to shift_date. Used to verify compliance with predictive scheduling ordinances (e.g., Fair Workweek laws) in applicable jurisdictions.',
    `premium_pay_flag` BOOLEAN COMMENT 'Indicates whether this shift qualifies for premium pay (True), such as holiday pay, weekend differential, or predictive scheduling penalty pay for late-notice schedule changes. Triggers payroll premium calculation in Workday HCM.',
    `published_timestamp` TIMESTAMP COMMENT 'Date and time when the schedule was published and made visible to associates. Supports advance notice compliance measurement (many CBAs require 7–14 days advance notice).',
    `schedule_number` STRING COMMENT 'Human-readable business identifier for the schedule, typically formatted as STORE-DEPT-PERIOD (e.g., STR001-PROD-2024W23). Used in operational communications and printed schedule reports.',
    `schedule_source` STRING COMMENT 'Identifies the origination method of this schedule or shift. Kronos_auto: generated by Kronos auto-scheduler. Manager_manual: manually entered by manager. Self_service: associate-initiated via self-service portal. Imported: loaded from external system.. Valid values are `kronos_auto|manager_manual|self_service|imported`',
    `schedule_status` STRING COMMENT 'Current lifecycle state of the schedule. Draft: initial build by manager or Kronos auto-scheduler. Published: released to associates. Approved: authorized by store director. Locked: finalized for payroll processing. Cancelled: voided schedule.. Valid values are `draft|published|approved|locked|cancelled`',
    `scheduled_headcount` STRING COMMENT 'Total number of distinct associates assigned at least one shift within this schedule period. Used for coverage planning and minimum staffing compliance.',
    `scheduled_shift_hours` DECIMAL(18,2) COMMENT 'Total number of hours scheduled for this individual shift, net of unpaid break time. Used for daily labor hour tracking, overtime risk flagging, and payroll pre-calculation.',
    `shift_end_time` TIMESTAMP COMMENT 'Scheduled end date and time for the shift. Combined with shift_start_time determines scheduled shift duration. Used for overtime pre-screening and labor cost projection.',
    `shift_start_time` TIMESTAMP COMMENT 'Scheduled start date and time for the shift. Includes timezone context for multi-timezone store operations. Used for schedule adherence and time-and-attendance comparison.',
    `total_scheduled_hours` DECIMAL(18,2) COMMENT 'Sum of all shift hours across all associates assigned to this schedule for the period. Used for labor budget vs. actual analysis and schedule adherence measurement.',
    `union_seniority_applied_flag` BOOLEAN COMMENT 'Indicates whether union seniority-based shift bidding rules were applied during schedule generation (True) or not (False). Required for union contract compliance and grievance defense.',
    `workday_pay_period_code` STRING COMMENT 'Identifier of the corresponding pay period in Workday HCM to which this schedules labor hours will be applied. Enables reconciliation between scheduled hours and payroll processing.',
    CONSTRAINT pk_schedule PRIMARY KEY(`schedule_id`)
) COMMENT 'Labor schedules and individual shift assignments for store associates, DC workers, and pharmacy staff generated by Kronos Workforce Central. At the schedule level: captures schedule period (weekly/bi-weekly), total scheduled hours, labor budget hours, schedule status (draft/published/approved), store/department coverage targets, and schedule owner (manager). At the shift level (line items): captures shift date, start/end times, scheduled hours, shift type (open/mid/close/overnight), department assignment, break rules, assigned associate, shift swap status, and call-off/replacement tracking. Supports labor coverage planning, schedule adherence measurement, labor budget vs. actual analysis, union seniority-based shift bidding, and Kronos auto-scheduler output.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`time_entry` (
    `time_entry_id` BIGINT COMMENT 'Unique system-generated identifier for each individual time entry record (clock-in/clock-out event) captured by Kronos Workforce Central or mobile punch device.',
    `cost_center_id` BIGINT COMMENT 'SAP Controlling (CO) cost center to which the labor hours and associated costs for this time entry are allocated for financial reporting and EBITDA analysis.',
    `associate_id` BIGINT COMMENT 'Unique identifier for the employee associated with this time entry. Links to the employee master record in Workday HCM.',
    `schedule_id` BIGINT COMMENT 'Reference to the scheduled shift that this time entry is associated with, enabling variance analysis between scheduled and actual hours worked.',
    `store_location_id` BIGINT COMMENT 'Identifier for the store, distribution center, pharmacy, or fuel center location where the employee clocked in. Supports labor cost allocation by location.',
    `actual_hours_worked` DECIMAL(18,2) COMMENT 'Total number of hours the employee actually worked during this time entry, calculated as the difference between punch-out and punch-in minus approved break durations. Foundation for payroll computation.',
    `approval_status` STRING COMMENT 'Manager approval status for this time entry. Unapproved entries cannot be processed for payroll. Supports dual-control compliance and SOX internal controls for labor cost authorization.. Valid values are `unapproved|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the manager approved or rejected this time entry. Provides audit trail for payroll authorization and labor compliance.',
    `break_duration_minutes` STRING COMMENT 'Total duration in minutes of all rest breaks taken during this time entry. Used for meal and rest period compliance tracking under applicable state labor laws (e.g., California IWC Wage Orders).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this time entry record was first created in the Kronos Workforce Central system, whether by automatic punch capture or manual entry.',
    `department_code` STRING COMMENT 'Store or facility department code where the employee worked during this time entry (e.g., produce, pharmacy, deli, DC receiving). Supports department-level labor cost allocation and scheduling analytics.',
    `double_time_hours` DECIMAL(18,2) COMMENT 'Number of hours qualifying for double-time pay rate, applicable in states such as California where hours beyond 12 in a day or 8 on the seventh consecutive day trigger double-time compensation.',
    `edit_reason` STRING COMMENT 'Free-text or coded reason provided by the manager when manually creating or modifying a time entry. Required for audit trail integrity and SOX internal controls compliance.',
    `entry_status` STRING COMMENT 'Current workflow status of the time entry record. Pending entries await manager review; approved entries are eligible for payroll processing; locked entries have been submitted to payroll; voided entries are cancelled.. Valid values are `pending|approved|rejected|locked|voided`',
    `exception_code` STRING COMMENT 'Kronos exception code identifying the specific type of time entry exception flagged by the system (e.g., missed punch, unscheduled overtime, consecutive day violation). Used for exception-based management reporting. [ENUM-REF-CANDIDATE: MISSED_PUNCH|UNSCHEDULED_OT|CONSEC_DAY|EARLY_IN|LATE_IN|EARLY_OUT|LATE_OUT|MEAL_VIOLATION|REST_VIOLATION — promote to reference product]',
    `is_early_punch_in` BOOLEAN COMMENT 'Indicates whether the employee clocked in earlier than the scheduled start time, beyond the configured grace period. Used for schedule adherence monitoring and unauthorized overtime prevention.',
    `is_early_punch_out` BOOLEAN COMMENT 'Indicates whether the employee clocked out earlier than the scheduled end time, beyond the configured grace period. Supports schedule adherence and store coverage gap analysis.',
    `is_late_punch_in` BOOLEAN COMMENT 'Indicates whether the employee clocked in later than the scheduled start time, beyond the configured grace period. Used for attendance management, coaching, and store operations reliability reporting.',
    `is_late_punch_out` BOOLEAN COMMENT 'Indicates whether the employee clocked out later than the scheduled end time, beyond the configured grace period. Used to identify unauthorized overtime and schedule overrun situations.',
    `is_manual_edit` BOOLEAN COMMENT 'Indicates whether this time entry was manually created or edited by a manager or HR administrator, as opposed to being captured automatically by a time clock or mobile device. Manual entries require heightened audit scrutiny.',
    `is_missed_punch` BOOLEAN COMMENT 'Indicates whether this time entry has a missing punch-in or punch-out record. Missed punches require manager correction before payroll processing and are tracked for compliance and exception reporting.',
    `job_code` STRING COMMENT 'Kronos/Workday job code identifying the role or position the employee was performing during this time entry (e.g., cashier, stocker, pharmacist, DC picker). Enables labor cost analysis by job function.',
    `kronos_entry_number` STRING COMMENT 'Externally-known business identifier assigned by Kronos Workforce Central to this time entry record. Used for cross-system reconciliation and audit trail.',
    `labor_category` STRING COMMENT 'High-level classification of the employees labor category for this time entry. Used for workforce analytics, labor budget reporting, and GMROI-related labor cost analysis.. Valid values are `store_associate|pharmacist|dc_worker|corporate|fuel_center|management`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this time entry record was most recently updated, including manager edits, approval actions, or system corrections. Supports audit trail and change detection.',
    `meal_period_minutes` STRING COMMENT 'Total duration in minutes of the unpaid meal period taken during this shift. Tracked separately from rest breaks for compliance with meal period mandates (e.g., 30-minute unpaid meal after 5 hours worked).',
    `meal_period_violation` BOOLEAN COMMENT 'Indicates whether a meal period compliance violation occurred for this time entry (e.g., meal period not taken within required timeframe). Triggers premium pay obligation under California Labor Code and similar state laws.',
    `meal_period_waived` BOOLEAN COMMENT 'Indicates whether the employee formally waived their meal period for this shift, as permitted under applicable state labor law for shifts of 6 hours or less. Required for meal period compliance documentation.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of hours worked beyond the standard threshold (typically 8 hours/day or 40 hours/week) that qualify for overtime pay under FLSA or applicable state labor law. Used for payroll and labor cost management.',
    `pay_code` STRING COMMENT 'Kronos pay code classifying the type of compensation applicable to this time entry. Drives payroll rate calculation in Workday HCM. [ENUM-REF-CANDIDATE: REG|OT|DT|HOL|SICK|VAC|PTO|BEREAVEMENT|JURY|TRAINING — promote to reference product]',
    `pay_period_code` BIGINT COMMENT 'Reference to the payroll pay period within which this time entry falls, used for payroll processing and labor cost aggregation.',
    `payroll_export_status` STRING COMMENT 'Status of this time entrys export to the Workday HCM payroll system. Tracks whether the record has been successfully transmitted for payroll processing or if an error occurred during the interface.. Valid values are `not_exported|exported|error`',
    `payroll_export_timestamp` TIMESTAMP COMMENT 'Date and time when this time entry was successfully exported to the Workday HCM payroll system for processing. Null if not yet exported.',
    `punch_in_timestamp` TIMESTAMP COMMENT 'The exact date and time the employee clocked in, as recorded by the Kronos time clock or mobile punch device. This is the principal real-world event time for the start of the work period.',
    `punch_out_timestamp` TIMESTAMP COMMENT 'The exact date and time the employee clocked out, as recorded by the Kronos time clock or mobile punch device. Null if the employee has not yet punched out or if a missed punch exception exists.',
    `punch_source` STRING COMMENT 'The device or method used to record the punch-in and punch-out. Supports audit integrity and exception analysis; manual entries require additional approval scrutiny.. Valid values are `time_clock|mobile|web|manual|biometric|badge`',
    `rest_break_violation` BOOLEAN COMMENT 'Indicates whether a rest break compliance violation occurred for this time entry (e.g., required 10-minute rest break not provided). Triggers premium pay obligation under applicable state labor laws.',
    `scheduled_hours` DECIMAL(18,2) COMMENT 'Number of hours the employee was originally scheduled to work for this shift, as defined in Kronos scheduling. Enables variance analysis between planned and actual labor.',
    `work_date` DATE COMMENT 'The calendar date on which the work shift began. Used for daily labor reporting, scheduling variance, and compliance with daily overtime rules under applicable state labor laws.',
    CONSTRAINT pk_time_entry PRIMARY KEY(`time_entry_id`)
) COMMENT 'Individual clock-in/clock-out records captured by Kronos Workforce Central time clocks and mobile punch devices. Tracks punch-in timestamp, punch-out timestamp, actual hours worked, break duration, meal period compliance, overtime hours, pay code (regular/OT/holiday/sick), approval status, and exception flags (missed punch, early/late). Foundation for payroll processing and labor law compliance.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Unique surrogate identifier for each payroll run record in the Workday HCM Payroll system. Serves as the primary key for the payroll_run data product in the Databricks Silver Layer.',
    `cost_center_id` BIGINT COMMENT 'Reference to the primary SAP CO cost center associated with this payroll run for labor cost allocation. Enables EBITDA analysis and store-level labor cost reporting. Individual associate-level cost center splits may vary.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity (company code in SAP FI) under which this payroll run is processed. Determines tax jurisdiction, employer identification number (EIN), and GL posting rules for SOX financial controls.',
    `pay_calendar_id` BIGINT COMMENT 'Reference to the Workday HCM pay calendar that governs the schedule of this payroll run, including pay period dates, check dates, and processing deadlines. Determines the annual payroll schedule for the associated pay group.',
    `pay_group_id` BIGINT COMMENT 'Reference to the Workday HCM pay group that defines the population of associates included in this payroll run (e.g., store hourly, pharmacy salaried, DC associates, corporate staff). Determines pay frequency, pay calendar, and processing rules.',
    `associate_id` BIGINT COMMENT 'Reference to the Workday HCM user (payroll administrator) who initiated and submitted this payroll run for processing. Required for SOX segregation of duties controls and payroll audit trail.',
    `prior_run_payroll_run_id` BIGINT COMMENT 'Reference to the preceding payroll run that this run corrects or supersedes. Populated only for run_type = correction or off_cycle. Enables audit trail linking between original and corrected payroll runs for SOX compliance.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the payroll run received final approval in Workday HCM before processing. Captures the approval event in the payroll lifecycle for SOX audit trail and segregation of duties documentation.',
    `associate_count` STRING COMMENT 'Total number of associates included and processed in this payroll run. Used for payroll audit validation, headcount reconciliation, and detecting anomalies (e.g., unexpected count changes between runs).',
    `check_date` DATE COMMENT 'Scheduled date on which associates receive payment via direct deposit or physical check. This is the principal business event date for the payroll run and is used for GL posting dates in SAP FI and tax deposit timing per IRS schedules.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run record was first created in Workday HCM. Serves as the audit record creation timestamp for SOX internal controls and data lineage tracking in the Databricks Silver Layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this payroll run (e.g., USD). Grocery operates primarily in USD; this field supports multi-entity reporting and potential international expansion.. Valid values are `^[A-Z]{3}$`',
    `direct_deposit_file_reference` STRING COMMENT 'Identifier of the ACH (Automated Clearing House) NACHA-format direct deposit file generated for this payroll run and transmitted to the bank. Used for payment reconciliation and resolving associate pay inquiry cases.',
    `gl_document_number` STRING COMMENT 'SAP FI document number generated when payroll journal entries are posted to the General Ledger. Provides the cross-reference between Workday HCM payroll records and SAP FI accounting documents for SOX audit and reconciliation.',
    `gl_posting_date` DATE COMMENT 'Date on which payroll journal entries are posted to the SAP FI General Ledger. May differ from check_date due to accounting period cutoffs. Critical for period-end close, EBITDA reporting, and SOX financial controls.',
    `is_final` BOOLEAN COMMENT 'Indicates whether this payroll run has been finalized and locked in Workday HCM, preventing further modifications. Final runs trigger GL posting to SAP FI and ACH direct deposit file generation. Non-final runs are still in preview or correction mode.',
    `is_off_cycle` BOOLEAN COMMENT 'Indicates whether this payroll run is an off-cycle run executed outside the standard pay calendar schedule (e.g., termination pay, correction payments, bonus disbursements). Off-cycle runs require additional SOX approval controls.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run record was most recently modified in Workday HCM or the Databricks Silver Layer. Tracks the latest state change for audit trail completeness and incremental data pipeline processing.',
    `pay_frequency` STRING COMMENT 'Frequency at which associates are paid for this payroll run. Determines the pay period cadence and aligns with Workday HCM pay group configurations. Common frequencies include weekly for hourly store associates and bi-weekly for salaried staff.. Valid values are `weekly|bi_weekly|semi_monthly|monthly`',
    `pay_period_end_date` DATE COMMENT 'Last calendar date of the pay period covered by this payroll run. Defines the closing boundary of the earnings window. Must align with Kronos Workforce Central time and attendance cutoff for accurate hours capture.',
    `pay_period_start_date` DATE COMMENT 'First calendar date of the pay period covered by this payroll run. Defines the beginning of the earnings window for all associates included in the run. Used for W-2 reconciliation and labor cost reporting.',
    `processing_end_timestamp` TIMESTAMP COMMENT 'Date and time when Workday HCM completed the payroll calculation and finalized the run. Marks the principal business event completion time. Used for payroll SLA compliance and downstream GL posting scheduling in SAP FI.',
    `processing_start_timestamp` TIMESTAMP COMMENT 'Date and time when Workday HCM began executing the payroll calculation engine for this run. Used for SLA monitoring of payroll processing windows and operational performance tracking.',
    `run_number` STRING COMMENT 'Externally-known business identifier for the payroll run as assigned by Workday HCM (e.g., PR-2024-001). Used for audit trails, SOX financial controls, and payroll reconciliation references.',
    `run_status` STRING COMMENT 'Current lifecycle state of the payroll run within the Workday HCM processing workflow. Tracks progression from initiation through completion or cancellation. Supports SOX audit controls and payroll operations monitoring.. Valid values are `draft|in_progress|completed|cancelled|on_hold`',
    `run_type` STRING COMMENT 'Classification of the payroll run indicating whether it is a standard scheduled run, an off-cycle adjustment, a correction to a prior run, a supplemental payment, or a bonus payout. Drives processing rules and GL posting in SAP FI.. Valid values are `regular|off_cycle|correction|supplemental|bonus`',
    `tax_year` STRING COMMENT 'Calendar tax year (e.g., 2024) to which this payroll run belongs. Determines applicable tax rates, wage bases, and W-2 reporting period. Essential for year-end W-2 reconciliation and IRS Form 941 annual filing.',
    `total_check_amount` DECIMAL(18,2) COMMENT 'Total dollar amount disbursed via physical payroll checks for associates not enrolled in direct deposit. Together with total_direct_deposit_amount, reconciles to total_net_pay. Supports treasury and accounts payable reconciliation.',
    `total_deductions` DECIMAL(18,2) COMMENT 'Aggregate of all pre-tax and post-tax deductions across all associates in this payroll run, including 401(k), HSA, FSA, medical premiums, garnishments, union dues, and Roth contributions. Supports benefits reconciliation and garnishment compliance reporting.',
    `total_direct_deposit_amount` DECIMAL(18,2) COMMENT 'Total dollar amount transmitted via ACH direct deposit for this payroll run. Should reconcile to total_net_pay minus any physical check amounts. Used for bank reconciliation and treasury cash management.',
    `total_employer_taxes` DECIMAL(18,2) COMMENT 'Aggregate employer-side tax obligations for this payroll run, including employer FICA (Social Security and Medicare match), federal unemployment tax (FUTA), and state unemployment insurance (SUI). Required for accurate labor cost accounting and IRS Form 941 filing.',
    `total_garnishment_amount` DECIMAL(18,2) COMMENT 'Aggregate of all court-ordered wage garnishments, child support withholdings, and creditor garnishments deducted across all associates in this payroll run. Required for garnishment compliance reporting and remittance to issuing agencies per Consumer Credit Protection Act limits.',
    `total_gross_pay` DECIMAL(18,2) COMMENT 'Sum of all gross earnings for all associates included in this payroll run before any tax withholdings or deductions. Includes regular pay, overtime, holiday pay, and premium pay. Key metric for SOX financial controls and payroll audit reconciliation.',
    `total_net_pay` DECIMAL(18,2) COMMENT 'Total amount disbursed to all associates after all tax withholdings and deductions. Equals total_gross_pay minus total_tax_withholdings minus total_deductions. Primary cash outflow figure for treasury and GL posting in SAP FI.',
    `total_posttax_deductions` DECIMAL(18,2) COMMENT 'Aggregate of all post-tax deductions across all associates in this payroll run, including Roth 401(k) contributions, union dues, and voluntary post-tax benefit elections. Does not reduce taxable wages but reduces net pay.',
    `total_pretax_deductions` DECIMAL(18,2) COMMENT 'Aggregate of all pre-tax benefit deductions across all associates in this payroll run, including 401(k) contributions, HSA contributions, FSA contributions, and medical/dental/vision premiums under Section 125 cafeteria plans. Reduces taxable wages for W-2 reporting.',
    `total_tax_withholdings` DECIMAL(18,2) COMMENT 'Aggregate of all federal, state, local, and FICA (Social Security and Medicare) tax withholdings across all associates in this payroll run. Used for IRS tax deposit scheduling and W-2 reconciliation.',
    `workday_run_code` STRING COMMENT 'Native identifier of this payroll run in the Workday HCM source system. Enables cross-reference between the Databricks Silver Layer record and the operational system of record for audit, reconciliation, and support inquiry resolution.',
    `ytd_gross_pay` DECIMAL(18,2) COMMENT 'Cumulative gross pay for all associates in this pay group from the start of the tax year through this payroll run. Used for W-2 reconciliation, Social Security wage base tracking, and annual compensation reporting.',
    `ytd_tax_withholdings` DECIMAL(18,2) COMMENT 'Cumulative tax withholdings for all associates in this pay group from the start of the tax year through this payroll run. Critical for W-2 Box 2 (federal income tax withheld) reconciliation and IRS Form 941 quarterly reporting.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Payroll processing records from Workday HCM Payroll capturing each payroll cycle execution and associate-level pay detail. At the run level: tracks pay period start/end dates, pay frequency (weekly/bi-weekly), run type (regular/off-cycle/correction), run status, total gross pay, total net pay, total tax withholdings, total deductions, employee count processed, and payroll completion timestamp. At the associate level: tracks individual gross earnings by pay code (regular/OT/holiday/premium), tax withholdings (federal/state/local/FICA), pre-tax deductions (401k/HSA/FSA/medical), post-tax deductions (garnishments/union dues/Roth), net pay, direct deposit allocations, and YTD accumulators. Supports SOX financial controls, payroll audit, W-2 reconciliation, garnishment compliance, and associate pay inquiry resolution.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` (
    `workforce_benefit_enrollment_id` BIGINT COMMENT 'Unique surrogate identifier for each benefit enrollment record in the Workday HCM Benefits Administration module. Serves as the primary key for this data product.',
    `associate_id` BIGINT COMMENT 'Reference to the associate enrolled in the benefit plan. Links to the workforce employee master record in Workday HCM. Covers store associates, pharmacists, distribution center workers, and corporate staff.',
    `benefit_plan_id` BIGINT COMMENT 'Reference to the specific benefit plan in which the associate is enrolled. Links to the benefit plan master record maintained in Workday HCM Benefits Administration.',
    `open_enrollment_period_id` BIGINT COMMENT 'Reference to the open enrollment period during which this enrollment was submitted. Populated for enrollments sourced from open enrollment events; null for qualifying life event or new hire enrollments. Supports open enrollment administration and participation rate analytics.',
    `aca_affordability_safe_harbor` STRING COMMENT 'The IRS-approved safe harbor method used to determine whether the employees required contribution for self-only coverage is affordable under ACA Section 4980H(b). Drives 1095-C Line 16 coding. W2 uses Box 1 wages; rate_of_pay uses hourly rate; federal_poverty_line uses FPL threshold.. Valid values are `W2|rate_of_pay|federal_poverty_line|none`',
    `aca_coverage_indicator` BOOLEAN COMMENT 'Indicates whether this benefit enrollment constitutes minimum essential coverage (MEC) under the Affordable Care Act. True means the plan qualifies as ACA-compliant MEC. Drives 1095-C Line 14 offer-of-coverage code determination and employer shared responsibility payment (ESRP) calculations.',
    `aca_minimum_value_indicator` BOOLEAN COMMENT 'Indicates whether the enrolled health plan meets the ACA minimum value standard (covers at least 60% of total allowed costs). Required for 1095-C reporting and employer shared responsibility compliance under ACA Section 4980H(b).',
    `aca_offer_of_coverage_code` STRING COMMENT 'IRS-defined code for 1095-C Line 14 indicating the type of health coverage offered to the employee and their dependents/spouse. Codes 1A-1F correspond to specific offer scenarios defined by the IRS for employer shared responsibility reporting.. Valid values are `1A|1B|1C|1D|1E|1F`',
    `aca_safe_harbor_code` STRING COMMENT 'IRS-defined code for 1095-C Line 16 indicating the applicable safe harbor or relief provision for each month. Codes 2A-2F correspond to specific relief scenarios (e.g., 2C = enrolled in coverage, 2F = W-2 safe harbor). Required for ACA employer shared responsibility reporting.. Valid values are `2A|2B|2C|2D|2E|2F`',
    `annual_employee_contribution` DECIMAL(18,2) COMMENT 'Total annualized employee contribution amount for the benefit plan, calculated as the per-pay-period contribution multiplied by the number of pay periods. Used directly in ACA affordability safe harbor calculations (W-2, Rate of Pay, Federal Poverty Line methods) for 1095-C Line 16 coding.',
    `annual_employer_contribution` DECIMAL(18,2) COMMENT 'Total annualized employer contribution amount for the benefit plan. Used in total benefits cost analysis, EBITDA reporting, and financial planning. Expressed in USD.',
    `carrier_confirmation_number` STRING COMMENT 'Confirmation or member ID number issued by the insurance carrier or benefit provider upon enrollment confirmation. Used for carrier reconciliation, EDI 834 transaction matching, and associate ID card issuance tracking.',
    `carrier_enrollment_sent_date` DATE COMMENT 'Date on which the enrollment data was transmitted to the insurance carrier via EDI 834 or carrier feed. Used for carrier reconciliation, enrollment lag analysis, and compliance with carrier enrollment submission deadlines.',
    `cobra_election_date` DATE COMMENT 'Date on which the associate elected COBRA continuation coverage following termination of active enrollment. Nullable; populated only when COBRA is elected. Used for COBRA compliance tracking and carrier notification.',
    `cobra_eligible_indicator` BOOLEAN COMMENT 'Indicates whether the associate is eligible for COBRA continuation coverage upon termination of this enrollment. Drives COBRA election notice generation and compliance tracking under 29 U.S.C. § 1161. Applicable to medical, dental, and vision plan types.',
    `coverage_tier` STRING COMMENT 'Coverage level selected by the associate, determining the scope of dependents covered and the applicable premium contribution rates. Drives both employee and employer contribution calculations and ACA affordability analysis.. Valid values are `employee_only|employee_spouse|employee_children|family`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit enrollment record was first created in Workday HCM Benefits Administration. Establishes the audit trail origin for the enrollment lifecycle and supports ERISA record retention compliance.',
    `dependent_count` STRING COMMENT 'Number of dependents enrolled under this benefit plan enrollment. Used to validate coverage tier selection, support ACA dependent coverage reporting on 1095-C Part III, and drive carrier enrollment file generation.',
    `disability_benefit_type` STRING COMMENT 'Indicates whether the disability plan enrollment is for short-term disability (STD) or long-term disability (LTD) coverage. Applicable only when plan_type is disability. Drives benefit duration, elimination period, and OSHA/FMLA integration for leave management.. Valid values are `short_term|long_term`',
    `effective_date` DATE COMMENT 'Date on which the benefit coverage becomes active for the associate. Determines the start of the coverage period for ACA 1095-C reporting, carrier billing, and payroll deduction initiation.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Per-pay-period pre-tax payroll deduction amount contributed by the associate toward the benefit plan premium. Used in benefits cost analysis, payroll reconciliation, and ACA affordability safe harbor calculations. Expressed in USD.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Per-pay-period amount contributed by Grocery toward the associates benefit plan premium. Used in total compensation reporting, benefits cost analysis, EBITDA impact modeling, and ACA minimum value determination. Expressed in USD.',
    `employer_match_rate` DECIMAL(18,2) COMMENT 'Percentage of the associates eligible compensation that Grocery matches in the 401(k) plan, up to the match cap. Applicable only when plan_type is 401k. Used in total compensation reporting and ERISA plan administration. Expressed as a percentage (e.g., 3.00 = 3%).',
    `enrollment_confirmation_date` DATE COMMENT 'Date on which the associates benefit enrollment was confirmed and finalized in Workday HCM Benefits Administration. Distinct from the effective_date (when coverage starts). Used for enrollment audit trails and open enrollment completion tracking.',
    `enrollment_number` STRING COMMENT 'Externally-known business identifier for the benefit enrollment event, generated by Workday HCM Benefits Administration. Used for cross-system reconciliation with payroll, carrier feeds, and ACA reporting.. Valid values are `^ENR-[0-9]{10}$`',
    `enrollment_source` STRING COMMENT 'The event or process that triggered the benefit enrollment or change. Drives eligibility validation rules, enrollment window enforcement, and ACA special enrollment period tracking in Workday HCM.. Valid values are `open_enrollment|qualifying_life_event|new_hire|rehire|court_order`',
    `enrollment_status` STRING COMMENT 'Current lifecycle state of the benefit enrollment record. Active indicates coverage is in force; terminated indicates coverage has ended; pending indicates awaiting carrier confirmation; waived indicates the associate declined coverage; suspended indicates coverage is temporarily paused.. Valid values are `active|terminated|pending|waived|suspended`',
    `fsa_annual_election_amount` DECIMAL(18,2) COMMENT 'Annual dollar amount elected by the associate for a Flexible Spending Account (FSA) plan. Applicable only when plan_type is FSA. Subject to IRS annual contribution limits. Used in payroll deduction scheduling and benefits cost analysis. Expressed in USD.',
    `hsa_annual_election_amount` DECIMAL(18,2) COMMENT 'Annual dollar amount elected by the associate for a Health Savings Account (HSA). Applicable only when plan_type is HSA. Subject to IRS annual contribution limits (self-only vs. family). Used in payroll deduction scheduling and ACA HDHP compliance tracking. Expressed in USD.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this benefit enrollment record in Workday HCM. Used for change data capture (CDC), audit trail maintenance, and downstream data pipeline incremental load processing.',
    `life_insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Face value of the life insurance coverage elected by the associate. Applicable only when plan_type is life_insurance. May be a flat amount or a multiple of annual salary. Used in benefits cost analysis and imputed income calculations for IRS Section 79 compliance. Expressed in USD.',
    `payroll_deduction_code` STRING COMMENT 'Payroll system deduction code associated with this benefit enrollment, used to route the employee contribution to the correct benefit deduction bucket in SAP Payroll or Workday Payroll. Ensures accurate pre-tax and post-tax deduction classification.',
    `plan_name` STRING COMMENT 'Human-readable name of the specific benefit plan as defined in Workday HCM (e.g., Grocery PPO Gold 2024, Grocery HSA Bronze 2024). Used in associate-facing communications, open enrollment portals, and benefits cost analysis reporting.',
    `plan_type` STRING COMMENT 'Category of benefit plan in which the associate is enrolled. Drives ACA reporting obligations, payroll deduction codes, and carrier EDI file routing. [ENUM-REF-CANDIDATE: medical|dental|vision|401k|FSA|HSA|life_insurance|disability — promote to reference product]',
    `plan_year` STRING COMMENT 'The calendar or fiscal plan year (e.g., 2024) to which this enrollment applies. Used to segment benefit enrollments by open enrollment cycle, support year-over-year benefits cost analysis, and align with ACA 1095-C reporting periods.',
    `pre_tax_indicator` BOOLEAN COMMENT 'Indicates whether the employee contribution for this benefit plan is deducted on a pre-tax basis under IRS Section 125 (Cafeteria Plan). True for pre-tax deductions (medical, dental, vision, FSA, HSA); False for post-tax deductions (certain life insurance, disability). Drives payroll tax calculation.',
    `qualifying_life_event_type` STRING COMMENT 'Specific type of qualifying life event (QLE) that triggered a mid-year enrollment change outside of open enrollment. Populated only when enrollment_source is qualifying_life_event. Required for ERISA and ACA special enrollment period compliance documentation. [ENUM-REF-CANDIDATE: marriage|divorce|birth|adoption|death|loss_of_coverage|relocation — promote to reference product]',
    `retirement_contribution_rate` DECIMAL(18,2) COMMENT 'Percentage of the associates eligible compensation contributed to the 401(k) or retirement plan per pay period. Applicable only when plan_type is 401k. Used in payroll deduction calculations, employer match determination, and ERISA compliance reporting. Expressed as a percentage (e.g., 6.00 = 6%).',
    `termination_date` DATE COMMENT 'Date on which the benefit coverage ends for the associate. Nullable for active enrollments. Populated upon voluntary termination, qualifying life event, employment separation, or plan year end. Used in ACA 1095-C line-level reporting.',
    `waiver_reason` STRING COMMENT 'Reason provided by the associate for declining (waiving) benefit coverage. Populated only when enrollment_status is waived. Used for ACA reporting, benefits participation analysis, and workforce analytics. [ENUM-REF-CANDIDATE: covered_by_spouse|covered_by_parent|covered_by_other_employer|medicare|medicaid|other — promote to reference product]. Valid values are `covered_by_spouse|covered_by_parent|covered_by_other_employer|medicare|medicaid|other`',
    `workday_enrollment_event_code` STRING COMMENT 'Source system event identifier from Workday HCM Benefits Administration corresponding to the enrollment business process event. Used for source system traceability, audit reconciliation, and support case resolution.',
    CONSTRAINT pk_workforce_benefit_enrollment PRIMARY KEY(`workforce_benefit_enrollment_id`)
) COMMENT 'Associate benefit plan enrollments managed through Workday HCM Benefits Administration. Tracks benefit plan type (medical/dental/vision/401k/FSA/HSA/life insurance/disability), plan name, coverage tier (employee only/employee+spouse/family), enrollment effective date, termination date, employee contribution amount, employer contribution amount, enrollment source (open enrollment/qualifying life event/new hire), dependent information, ACA coverage indicator, and ACA affordability safe harbor method. Supports ACA 1095-C reporting, benefits cost analysis, and open enrollment administration.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique system-generated identifier for each leave of absence or time-off request record in Workday HCM. Serves as the primary key for the leave_request data product.',
    `leave_plan_id` BIGINT COMMENT 'Reference to the company leave plan or policy under which this request is processed (e.g., FMLA plan, state-specific paid leave plan, company PTO plan). Determines eligibility rules, accrual rates, and pay continuation rules.',
    `position_id` BIGINT COMMENT 'Reference to the employees position at the time of the leave request. Used for workforce planning, backfill scheduling, and labor compliance reporting.',
    `associate_id` BIGINT COMMENT 'Reference to the associate (store, pharmacy, distribution center, or corporate) who submitted the leave request. Links to the employee master record in Workday HCM.',
    `store_location_id` BIGINT COMMENT 'Reference to the store, distribution center, pharmacy, or corporate location where the employee is assigned. Supports store-level labor planning and absence reporting.',
    `tertiary_leave_hr_business_partner_associate_id` BIGINT COMMENT 'Reference to the HR Business Partner assigned to review and process this leave request. Supports HR workload tracking, escalation routing, and compliance audit trails.',
    `ada_accommodation` BOOLEAN COMMENT 'Indicates whether this leave request is associated with an ADA reasonable accommodation determination. Triggers separate ADA interactive process documentation requirements and legal review workflows.',
    `approval_date` DATE COMMENT 'The date on which the manager or HR representative formally approved the leave request in Workday HCM. Used for SLA tracking of approval turnaround time and audit trail.',
    `approved_hours` DECIMAL(18,2) COMMENT 'Total number of hours approved for the leave request. Used for intermittent FMLA tracking, partial-day absences, and payroll deduction calculations. Particularly important for part-time associates and intermittent leave scenarios.',
    `benefits_continuation` BOOLEAN COMMENT 'Indicates whether the employees group health benefits are continued during the leave period. FMLA requires maintenance of group health coverage on the same terms as if the employee had continued working.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the leave request record was first created in the Workday HCM system. Serves as the audit trail creation marker for the Silver Layer lakehouse record.',
    `denial_reason` STRING COMMENT 'Free-text or coded reason provided when a leave request is denied. Required for legal defensibility, employee communication, and HR audit purposes. Populated only when request_status is denied.',
    `fmla_designation_notice_date` DATE COMMENT 'Date on which the employer provided the FMLA Designation Notice (WH-382) to the employee, confirming whether the leave is designated as FMLA-qualifying. Must be provided within 5 business days of receiving sufficient information. Critical for FMLA compliance.',
    `fmla_eligible` BOOLEAN COMMENT 'Indicates whether the employee meets FMLA eligibility criteria at the time of the leave request: employed for at least 12 months, worked 1,250 hours in the past 12 months, and works at a location with 50+ employees within 75 miles. Critical for FMLA compliance reporting.',
    `fmla_hours_remaining` DECIMAL(18,2) COMMENT 'Remaining FMLA entitlement hours available to the employee in the current 12-month FMLA period after accounting for this request. Supports real-time FMLA balance visibility for HR and managers.',
    `fmla_hours_used` DECIMAL(18,2) COMMENT 'Number of hours counted against the employees annual FMLA entitlement (maximum 480 hours per 12-month period) for this specific leave request. Critical for FMLA compliance tracking and preventing entitlement overuse.',
    `fmla_qualifying` BOOLEAN COMMENT 'Indicates whether the specific leave reason qualifies under FMLA provisions (serious health condition, childbirth/adoption, military family leave, etc.). Distinct from fmla_eligible which tracks employee eligibility; this tracks whether the leave reason itself qualifies.',
    `fmla_rights_notice_date` DATE COMMENT 'Date on which the employer provided the FMLA Notice of Eligibility and Rights (WH-381) to the employee. Must be provided within 5 business days of the leave request. Tracks compliance with DOL notice requirements.',
    `intermittent_leave` BOOLEAN COMMENT 'Indicates whether the leave is taken intermittently (in separate blocks of time or by reducing the normal work schedule) rather than as a single continuous absence. Intermittent FMLA requires separate tracking of each absence episode against the annual entitlement.',
    `kronos_schedule_adjusted` BOOLEAN COMMENT 'Indicates whether the employees schedule in Kronos Workforce Central has been updated to reflect the approved leave period. Supports store operations and labor planning by confirming scheduling system synchronization.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the leave request record in Workday HCM. Tracks status changes, approval actions, date amendments, and certification updates for audit and change management purposes.',
    `leave_balance_hours_used` DECIMAL(18,2) COMMENT 'Number of hours deducted from the employees applicable leave accrual balance (PTO, sick, vacation) for this request. Used for accrual balance reconciliation and FMLA entitlement tracking.',
    `leave_end_date` DATE COMMENT 'The last calendar date of the employees leave of absence as requested or approved. Nullable for open-ended leaves pending medical certification. Used for return-to-work planning and FMLA entitlement balance calculations.',
    `leave_reason` STRING COMMENT 'Descriptive reason provided by the employee for the leave request (e.g., serious health condition, childbirth, military deployment, family care). Sensitive business data used for FMLA and ADA compliance determination. Stored as free text or coded reason from Workday HCM.',
    `leave_start_date` DATE COMMENT 'The first calendar date on which the employees approved leave of absence begins. Used for payroll processing, scheduling, and FMLA entitlement period tracking.',
    `leave_type` STRING COMMENT 'Classification of the leave request indicating the legal or policy basis for the absence. Drives eligibility rules, pay treatment, and compliance reporting. [ENUM-REF-CANDIDATE: FMLA|ADA|personal|vacation|sick|bereavement|jury_duty|military — promote to reference product]',
    `medical_certification_date` DATE COMMENT 'Date on which the medical certification was received from the healthcare provider. Used to verify timely submission within the 15-calendar-day FMLA requirement and to track certification expiration.',
    `medical_certification_received` BOOLEAN COMMENT 'Indicates whether the required medical certification from a healthcare provider has been received and accepted. Tracks compliance with the 15-calendar-day FMLA certification submission deadline.',
    `medical_certification_required` BOOLEAN COMMENT 'Indicates whether a healthcare providers medical certification is required to support this leave request. Required for FMLA serious health condition leaves and ADA accommodation requests.',
    `military_leave_type` STRING COMMENT 'Specifies the category of military service for leaves classified as military type. Determines USERRA reinstatement rights, pay differential obligations, and benefits continuation requirements. Null or none for non-military leaves.. Valid values are `active_duty|training|funeral_honors|none`',
    `osha_recordable` BOOLEAN COMMENT 'Indicates whether the leave is associated with an OSHA-recordable workplace injury or illness. When true, triggers OSHA 300 log entry requirements and workers compensation reporting workflows.',
    `paid_leave` BOOLEAN COMMENT 'Indicates whether the leave is fully or partially paid under company policy or applicable state law. Drives payroll processing rules in Workday HCM Payroll and determines whether accrued PTO/sick time is substituted for unpaid FMLA leave.',
    `pay_continuation_type` STRING COMMENT 'Specifies the pay treatment applied during the leave period. Determines how payroll processes the absence and which accrual balances are drawn down. Aligns with company leave policy and applicable state paid leave mandates.. Valid values are `full_pay|partial_pay|unpaid|pto_substitution|short_term_disability`',
    `request_date` DATE COMMENT 'The calendar date on which the employee formally submitted the leave request in Workday HCM. Used to calculate notice period compliance and FMLA eligibility timelines.',
    `request_status` STRING COMMENT 'Current workflow state of the leave request within the Workday HCM approval process. Drives downstream payroll processing, scheduling adjustments in Kronos, and compliance reporting.. Valid values are `pending|approved|denied|cancelled|withdrawn`',
    `requested_hours` DECIMAL(18,2) COMMENT 'Total number of hours the employee originally requested for the leave. Compared against approved_hours to identify partial approvals or adjustments made during the review process.',
    `return_to_work_date` DATE COMMENT 'The actual or anticipated date on which the employee is expected to or did return to active work status. May differ from leave_end_date if early return or extension occurs. Critical for workforce scheduling and FMLA reinstatement rights tracking.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this leave request originated. Supports data lineage tracking in the Databricks Silver Layer and cross-system reconciliation.. Valid values are `Workday|Kronos|manual`',
    `workday_leave_request_number` STRING COMMENT 'Externally-known business identifier assigned by Workday HCM to uniquely identify the leave request across HR systems and employee-facing portals. Used for cross-system reconciliation and employee communications.',
    `workday_worker_code` STRING COMMENT 'The Workday-assigned worker identifier for the employee, used as the cross-system reference key between Workday HCM and downstream analytics platforms. Confidential as it is a system-level personal identifier.',
    `workers_comp_claim_number` STRING COMMENT 'The workers compensation claim number associated with this leave request when the absence is due to a work-related injury or illness. Links leave management to the workers compensation insurance claim for coordinated benefits administration.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Associate leave of absence and time-off requests managed in Workday HCM. Captures leave type (FMLA/ADA/personal/vacation/sick/bereavement/jury duty/military), request date, leave start date, leave end date, approved hours, leave status (pending/approved/denied/cancelled), FMLA eligibility flag, intermittent leave indicator, return-to-work date, and manager approval details. Supports FMLA compliance tracking.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`safety_incident` (
    `safety_incident_id` BIGINT COMMENT 'Unique system-generated identifier for each workplace safety incident record. Primary key for the safety_incident data product.',
    `associate_id` BIGINT COMMENT 'Identifier of the associate involved in the safety incident. Links to the employee master record in Workday HCM. Used for OSHA 300/301 log reporting and workers compensation claim association.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store, distribution center, pharmacy, or fuel center location where the incident occurred. Used for location-based safety trend analysis and OSHA establishment-level reporting.',
    `body_part_affected` STRING COMMENT 'The specific body part injured or affected by the workplace incident (e.g., lower back, right hand, left knee, eye, shoulder). Required field on OSHA Form 301 and used for ergonomic risk analysis and targeted safety training programs. [ENUM-REF-CANDIDATE: lower_back|hand|knee|eye|shoulder|foot|head|neck|wrist|ankle — promote to reference product]',
    `claim_status` STRING COMMENT 'Current status of the workers compensation claim associated with this incident. Drives financial reserve management, claim closure workflows, and insurance carrier reporting. Values: not_filed (no claim opened), open (active claim), closed (claim resolved), denied (carrier denied compensability), appealed (denial under appeal), settled (lump-sum settlement reached).. Valid values are `not_filed|open|closed|denied|appealed|settled`',
    `claim_type` STRING COMMENT 'Classification of the workers compensation claim by benefit type. Medical_only claims involve only medical treatment costs with no wage replacement. Lost_time claims include wage replacement benefits for days away from work. No_claim indicates no workers compensation claim was filed (e.g., first-aid-only incidents). Drives premium calculation and experience modification rate (EMR) impact.. Valid values are `medical_only|lost_time|no_claim`',
    `corrective_action_completed_date` DATE COMMENT 'Actual date the corrective and preventive actions were fully implemented and verified. Used to close out incident investigations, measure corrective action cycle time, and confirm OSHA compliance program completion.',
    `corrective_action_description` STRING COMMENT 'Narrative description of the corrective and preventive actions taken or planned to address the root cause and prevent recurrence of the incident. Required for OSHA 300/301 compliance documentation and safety management system audits.',
    `corrective_action_due_date` DATE COMMENT 'Target completion date for the corrective and preventive actions identified during the incident investigation. Used to track open action items, escalate overdue corrective actions, and demonstrate OSHA compliance program effectiveness.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the safety incident record was first created in the system of record (Workday HCM or Kronos Workforce Central). Used for audit trail and data lineage tracking.',
    `days_away_from_work` STRING COMMENT 'Number of calendar days the associate was away from work due to the injury or illness, excluding the day of injury. Required for OSHA 300 Log Column K and used to calculate Days Away, Restricted, or Transferred (DART) rate for safety benchmarking.',
    `days_restricted_duty` STRING COMMENT 'Number of calendar days the associate was on restricted work or job transfer due to the injury or illness, excluding the day of injury. Required for OSHA 300 Log Column L and used in DART rate calculation.',
    `department_name` STRING COMMENT 'Name of the store or DC department where the incident occurred (e.g., Produce, Deli, Backroom, Receiving Dock, Pharmacy, Fuel Center Forecourt). Used for department-level safety trend analysis and targeted corrective action programs.',
    `emergency_services_called` BOOLEAN COMMENT 'Indicates whether emergency services (911, ambulance, fire department) were called in response to the incident. True = emergency services were dispatched. Used to identify high-severity incidents requiring OSHA severe injury reporting and for insurance carrier notification protocols.',
    `incident_description` STRING COMMENT 'Narrative description of how the workplace safety incident occurred, including the sequence of events, environmental conditions, and equipment involved. Required for OSHA 301 Incident Report (Form 301) and workers compensation first notice of loss documentation.',
    `incident_number` STRING COMMENT 'Externally-known, human-readable reference number assigned to the safety incident at the time of reporting. Used for cross-referencing with OSHA 300/301 logs, workers compensation carriers, and insurance documentation. Format: INC-YYYY-NNNNNN.. Valid values are `^INC-[0-9]{4}-[0-9]{6}$`',
    `incident_status` STRING COMMENT 'Current workflow status of the safety incident record. Drives case management actions, OSHA log finalization, and workers compensation claim lifecycle. Values: open (newly reported), under_investigation (root cause analysis in progress), closed (fully resolved), pending_review (awaiting OSHA recordability determination), appealed (recordability determination under appeal).. Valid values are `open|under_investigation|closed|pending_review|appealed`',
    `incident_timestamp` TIMESTAMP COMMENT 'The exact date and time the workplace safety incident occurred. This is the principal real-world event timestamp used for OSHA 300 log entry, workers compensation first notice of loss, and regulatory reporting timelines.',
    `incident_type` STRING COMMENT 'Classification of the nature of the workplace safety incident. Drives OSHA recordability rules, root cause analysis categories, and corrective action protocols. [ENUM-REF-CANDIDATE: slip_and_fall|equipment_injury|chemical_exposure|robbery|near_miss|struck_by_object|overexertion|repetitive_motion|vehicle_accident|fire_or_explosion — promote to reference product]',
    `indemnity_cost` DECIMAL(18,2) COMMENT 'Total wage replacement (indemnity) payments made to the associate for days away from work under the workers compensation claim. Subset of total_incurred_cost. Used for lost-time cost analysis and return-to-work program financial justification.',
    `injury_severity` STRING COMMENT 'Severity classification of the injury or illness outcome. Determines OSHA recordability, workers compensation claim type, and return-to-work program eligibility. Values align with OSHA 300 Log column classifications: first_aid_only (non-recordable), medical_treatment (recordable, no lost time), restricted_duty (recordable, restricted work), days_away (recordable, days away from work), hospitalization (OSHA severe injury — 24-hour reporting required), fatality (OSHA fatality — 8-hour reporting required).. Valid values are `first_aid_only|medical_treatment|restricted_duty|days_away|hospitalization|fatality`',
    `injury_type` STRING COMMENT 'Classification of the type of injury or illness sustained (e.g., laceration, sprain/strain, fracture, burn, contusion, chemical burn, hearing loss, COVID-19). Populates OSHA 300 Log Column M and OSHA 301 Form field. [ENUM-REF-CANDIDATE: laceration|sprain_strain|fracture|burn|contusion|chemical_burn|hearing_loss|illness|puncture|amputation — promote to reference product]',
    `insurance_carrier_name` STRING COMMENT 'Name of the workers compensation insurance carrier or third-party administrator (TPA) handling the claim. Used for carrier performance tracking, claim routing, and financial reconciliation of incurred costs.',
    `is_near_miss` BOOLEAN COMMENT 'Indicates whether the incident was a near-miss event (an unplanned event that did not result in injury, illness, or damage but had the potential to do so). Near-miss tracking is a leading safety indicator used in proactive hazard identification programs. Near-miss events are not OSHA recordable.',
    `is_osha_recordable` BOOLEAN COMMENT 'Indicates whether the incident meets OSHA recordability criteria under 29 CFR 1904.7 (i.e., results in days away from work, restricted duty, medical treatment beyond first aid, loss of consciousness, or diagnosis of a significant injury). True = must be entered on OSHA 300 Log. False = first-aid-only or non-recordable near-miss.',
    `job_title` STRING COMMENT 'Job title or position of the associate at the time the incident occurred. Captured as a point-in-time snapshot since the associates role may change after the incident. Used for job-classification-based safety risk analysis and OSHA 300 Log documentation.',
    `location_type` STRING COMMENT 'Type of Grocery facility where the incident occurred. Used to segment safety performance by operational environment (store floor, DC warehouse, pharmacy dispensing area, fuel center forecourt, or corporate office). Supports OSHA establishment-level reporting.. Valid values are `store|distribution_center|pharmacy|fuel_center|corporate_office`',
    `medical_cost` DECIMAL(18,2) COMMENT 'Total medical treatment costs incurred for the injury or illness, including emergency care, physician visits, physical therapy, and prescription medications. Subset of total_incurred_cost. Used for medical cost benchmarking and managed care program effectiveness analysis.',
    `medical_provider_name` STRING COMMENT 'Name of the physician, clinic, hospital, or medical facility that provided treatment for the injury or illness. Required for OSHA Form 301 completion and workers compensation managed care network compliance tracking.',
    `osha_300_log_entry_date` DATE COMMENT 'Date the recordable incident was entered onto the OSHA 300 Log of Work-Related Injuries and Illnesses. OSHA requires recordable incidents to be logged within 7 calendar days of receiving information that a recordable case occurred. Used for OSHA compliance audit tracking.',
    `osha_301_form_completed` BOOLEAN COMMENT 'Indicates whether the OSHA Form 301 (Injury and Illness Incident Report) has been completed for this recordable incident. OSHA requires Form 301 to be completed within 7 calendar days of receiving information that a recordable case occurred. True = Form 301 completed and on file.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time the incident was formally reported by the associate or supervisor. Used to measure reporting lag compliance and supports OSHA 24-hour severe injury reporting requirements.',
    `return_to_work_date` DATE COMMENT 'Date the associate returned to full or modified duty following the injury or illness. Used to calculate total lost-time duration, close workers compensation lost-time claims, and track return-to-work program effectiveness.',
    `return_to_work_type` STRING COMMENT 'Classification of the return-to-work status when the associate resumed employment. Distinguishes between full duty (no restrictions), modified duty (temporary accommodations), restricted duty (permanent or long-term limitations), or not returned (still on leave or separated). Supports return-to-work program management and workers compensation claim closure.. Valid values are `full_duty|modified_duty|restricted_duty|not_returned`',
    `root_cause` STRING COMMENT 'Identified root cause of the safety incident based on investigation findings. Captures the underlying systemic or behavioral factor that allowed the incident to occur (e.g., inadequate training, equipment malfunction, wet floor not marked, improper lifting technique, inadequate PPE). Used to drive corrective action programs and prevent recurrence.',
    `root_cause_category` STRING COMMENT 'Standardized category of the root cause to enable trend analysis across incidents. Supports safety program prioritization and corrective action resource allocation. Values align with ANSI/ASSP Z10 safety management system categories. Note: 7 values — borderline for enum; retained as inline enum given closed, stable set. [ENUM-REF-CANDIDATE: human_error|equipment_failure|environmental_hazard|process_deficiency|inadequate_training|inadequate_ppe|management_system — 7 candidates stripped; promote to reference product]',
    `shift_type` STRING COMMENT 'The work shift during which the incident occurred. Used for shift-based safety trend analysis to identify higher-risk shift patterns (e.g., overnight stocking shifts with reduced supervision). Sourced from Kronos Workforce Central scheduling data.. Valid values are `day|evening|overnight|split`',
    `tenure_days_at_incident` STRING COMMENT 'Number of days the associate had been employed at Grocery at the time of the incident. Used to analyze the relationship between associate tenure and injury risk, supporting new-hire safety orientation program effectiveness measurement.',
    `total_incurred_cost` DECIMAL(18,2) COMMENT 'Total incurred cost of the workers compensation claim in USD, including medical payments, indemnity (wage replacement) payments, and reserves for future payments. Used for financial reporting, experience modification rate (EMR) calculation, and safety program ROI analysis. Confidential financial data.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the safety incident record was most recently modified. Tracks updates to OSHA recordability determination, claim status changes, corrective action completion, and return-to-work dates.',
    `witness_names` STRING COMMENT 'Names of associates or individuals who witnessed the safety incident. Stored as a delimited string for OSHA 301 Form documentation and incident investigation purposes. Confidential as it identifies individuals involved in a workplace incident.',
    `workers_comp_claim_number` STRING COMMENT 'Externally-assigned claim number issued by the workers compensation insurance carrier for this incident. Used to cross-reference claim records with the insurance carrier, track claim status, and reconcile incurred costs. Confidential business financial data.',
    CONSTRAINT pk_safety_incident PRIMARY KEY(`safety_incident_id`)
) COMMENT 'OSHA recordable and non-recordable workplace safety incidents and associated workers compensation claim tracking for store, DC, pharmacy, and fuel center associates. Captures incident date/time, location (store/DC/department), incident type (slip-and-fall/equipment injury/chemical exposure/robbery/near-miss), body part affected, injury severity, OSHA recordability determination, days away from work, restricted duty days, workers comp claim number, claim status, claim type (medical only/lost time), insurance carrier, total incurred cost, root cause, corrective actions, and return-to-work date. Required for OSHA 300/301 log compliance and workers compensation management.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`certification` (
    `certification_id` BIGINT COMMENT 'Unique system-generated identifier for each associate certification, license, or compliance training record. Primary key for the certification data product.',
    `associate_id` BIGINT COMMENT 'Reference to the associate (store, pharmacy, DC, or corporate) who holds this certification or completed this training. Links to the employee master record in Workday HCM.',
    `department_id` BIGINT COMMENT 'Reference to the department (e.g., Pharmacy, Deli, Produce, DC Operations) associated with this certification requirement. Supports department-level compliance tracking and ensures certifications are mapped to the correct operational unit.',
    `job_profile_id` BIGINT COMMENT 'Reference to the job profile or role for which this certification is required or associated (e.g., Pharmacist, Pharmacy Technician, Forklift Operator, Food Handler). Enables role-based certification compliance gap analysis across the workforce.',
    `store_location_id` BIGINT COMMENT 'Reference to the store or facility location where this certification is applicable or where the associate was working when the certification was obtained. Supports location-based compliance reporting and store-level certification gap analysis.',
    `certification_type_id` BIGINT COMMENT 'Reference to the certification or training type reference record (e.g., pharmacy license, food handler card, forklift operator, ServSafe, DEA handler, HACCP, alcohol sales, anti-harassment, PCI DSS, HIPAA). Links to the certification type reference product.',
    `attempt_number` STRING COMMENT 'Sequential attempt number for this certification examination or training assessment (e.g., 1 = first attempt, 2 = retake). Tracks retake history for associates who did not pass on the first attempt. Supports training effectiveness and compliance risk analytics.',
    `certification_category` STRING COMMENT 'High-level category classifying the certification or training record. license = state/federal professional license; compliance_training = mandatory regulatory training (HIPAA, PCI DSS, anti-harassment); food_safety = HACCP, ServSafe, food handler; safety_operations = forklift, OSHA, equipment; professional_certification = industry credential. [ENUM-REF-CANDIDATE: license|compliance_training|food_safety|safety_operations|professional_certification|pharmacy|alcohol_sales — promote to reference product if additional values needed]. Valid values are `license|compliance_training|food_safety|safety_operations|professional_certification`',
    `certification_name` STRING COMMENT 'Human-readable name of the certification, license, or training program (e.g., Pharmacist License - State of California, ServSafe Food Handler, HACCP Certification, Forklift Operator Safety, DEA Controlled Substance Handler).',
    `certification_number` STRING COMMENT 'Externally-issued certificate or license number assigned by the issuing authority or training provider (e.g., state pharmacy board license number, ServSafe certificate number, DEA registration number). Used for regulatory verification and audit purposes.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification or license. active = valid and in good standing; expired = past expiration date; suspended = temporarily invalidated by issuing authority; revoked = permanently cancelled; pending = submitted/in-progress awaiting issuance. Drives compliance dashboards and workforce eligibility checks.. Valid values are `active|expired|suspended|revoked|pending`',
    `completion_date` DATE COMMENT 'Date the associate completed the training course or examination. Applicable primarily to training-based certifications (e.g., ServSafe, HIPAA, PCI DSS, anti-harassment). May differ from issue_date if there is a processing delay before the credential is formally issued.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the data platform (Silver layer ingestion). Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports data lineage, audit trails, and SOX compliance for workforce data.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Number of continuing education (CE) credit hours awarded upon completion of this certification or training. Relevant for pharmacists (state CE requirements), pharmacy technicians, and other licensed professionals who must accumulate CE hours for license renewal.',
    `dea_schedule` STRING COMMENT 'DEA controlled substance schedule authorization level associated with this certification (CI through CV). Applicable only to DEA handler certifications and pharmacy licenses that authorize handling of controlled substances. Null for non-pharmacy certifications. Critical for DEA compliance reporting.. Valid values are `CI|CII|CIII|CIV|CV`',
    `delivery_method` STRING COMMENT 'Method by which the training or certification was delivered or obtained. in_person = classroom/instructor-led at store or DC; lms = Learning Management System (e.g., Workday Learning); on_the_job = supervised practical training; virtual_instructor_led = live online session; external_provider = third-party training organization. Supports training program analytics and compliance evidence.. Valid values are `in_person|lms|on_the_job|virtual_instructor_led|external_provider`',
    `document_reference` STRING COMMENT 'Reference identifier or URL path to the scanned certificate, license document, or training completion record stored in the document management system. Enables retrieval of physical evidence for regulatory audits and inspections.',
    `expiration_date` DATE COMMENT 'Date on which the certification, license, or training record expires and must be renewed. Null for non-expiring credentials. Used to trigger renewal reminders and flag associates with lapsed compliance requirements. Critical for DEA, pharmacy license, and food safety compliance.',
    `governing_regulation` STRING COMMENT 'Name or citation of the primary regulatory framework or law that mandates or governs this certification (e.g., DEA 21 CFR Part 1301, FDA 21 CFR Part 110, OSHA 29 CFR 1910.178, HIPAA 45 CFR Part 164, State Pharmacy Practice Act). Supports regulatory audit evidence and compliance reporting.',
    `issue_date` DATE COMMENT 'Date the certification, license, or training completion was officially issued or awarded by the issuing authority or training provider. Represents the effective start of the credentials validity period.',
    `issuing_authority` STRING COMMENT 'Name of the regulatory body, government agency, or accredited training provider that issued or awarded the certification (e.g., California State Board of Pharmacy, National Restaurant Association - ServSafe, DEA, OSHA, NSF International). Critical for regulatory compliance verification.',
    `issuing_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the country under which the certification was issued. Defaults to USA for domestic certifications. Relevant for associates with internationally-issued professional credentials.. Valid values are `^[A-Z]{3}$`',
    `issuing_state` STRING COMMENT 'Two-letter US state code for the jurisdiction under which the certification or license was issued. Critical for pharmacy licenses and alcohol sales permits which are state-specific. Null for federal or non-jurisdictional certifications.. Valid values are `^[A-Z]{2}$`',
    `notes` STRING COMMENT 'Free-text field for additional context, conditions, restrictions, or remarks associated with the certification record (e.g., License restricted to non-controlled substances, Renewal pending state board review, Completed as part of new hire onboarding). Supports case-by-case compliance documentation.',
    `passed` BOOLEAN COMMENT 'Indicates whether the associate passed the certification examination or training assessment (True = passed, False = failed). For attendance-based certifications with no exam, this is set to True upon completion. Drives compliance eligibility and role assignment rules.',
    `passing_score` DECIMAL(18,2) COMMENT 'Minimum score required to pass the certification examination or training assessment (e.g., 75.00). Used to determine pass/fail outcome and validate compliance with training standards. Null for attendance-based or non-scored certifications.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this certification is mandated by a federal or state regulatory body (True = regulatory mandate, False = internal/voluntary). Distinguishes legally required credentials (DEA handler, pharmacy license, HACCP, food handler card) from internal training programs (customer service, product knowledge).',
    `reminder_days_before_expiry` STRING COMMENT 'Number of days before the expiration_date that the renewal reminder notification should be triggered (e.g., 90, 60, 30 days). Configurable per certification type to allow adequate lead time for renewal processing, especially for state pharmacy licenses requiring advance application.',
    `renewal_date` DATE COMMENT 'Date on which the associate last renewed this certification or license. Tracks the renewal history cycle and supports compliance audit trails showing continuous credential maintenance.',
    `renewal_reminder_flag` BOOLEAN COMMENT 'Indicates whether automated renewal reminder notifications are enabled for this certification record (True = reminders active, False = reminders suppressed). Drives the renewal notification workflow in Workday HCM to alert associates and managers before expiration.',
    `role_requirement_flag` BOOLEAN COMMENT 'Indicates whether this certification is a mandatory requirement for the associates current job role (True = required for role, False = voluntary or supplemental). Used in workforce compliance reporting to identify associates who are non-compliant with role-based certification requirements.',
    `score` DECIMAL(18,2) COMMENT 'Numeric score achieved by the associate on the certification examination or training assessment (e.g., 85.50 out of 100). Null for pass/fail-only or attendance-based certifications. Used for training effectiveness analytics and minimum score compliance requirements.',
    `source_system` STRING COMMENT 'Operational system of record from which this certification record originated. workday = Workday HCM; kronos = Kronos Workforce Central; mckesson = McKesson Pharmacy Systems; manual = manually entered by HR/compliance team; external = imported from external training provider. Supports data lineage and reconciliation.. Valid values are `workday|kronos|mckesson|manual|external`',
    `source_system_record_code` STRING COMMENT 'Unique identifier of this certification record in the originating operational system (e.g., Workday Worker Certification ID, Kronos Training Record ID, McKesson License Record ID). Enables cross-system reconciliation and data lineage tracing in the Silver layer.',
    `training_provider` STRING COMMENT 'Name of the external or internal organization that delivered the training program (e.g., National Restaurant Association, OSHA Training Institute, Grocery Internal L&D, McKesson Pharmacy Training). Distinct from issuing_authority — the provider delivers the training while the authority issues the credential.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was last modified in the data platform. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Tracks changes to certification status, expiration dates, and verification outcomes for compliance audit purposes.',
    `verification_date` DATE COMMENT 'Date on which the certification was last verified against the issuing authoritys primary source records. Supports audit trails for regulatory compliance and demonstrates due diligence in credential verification for pharmacy and DEA-regulated roles.',
    `verification_source` STRING COMMENT 'Name of the system, database, or method used to verify the certification (e.g., State Board of Pharmacy Online Lookup, DEA Diversion Control Division, NABP e-Profile, Manual Document Review). Provides audit evidence for primary source verification processes.',
    `verified_flag` BOOLEAN COMMENT 'Indicates whether the certification has been independently verified against the issuing authoritys records (True = verified, False = self-reported or pending verification). Critical for pharmacy licenses and DEA registrations where primary source verification is required.',
    CONSTRAINT pk_certification PRIMARY KEY(`certification_id`)
) COMMENT 'Associate professional certifications, licenses, compliance training completions, and recurring training records required for specific roles. Tracks certification/training type (pharmacy license, food handler card, forklift operator, ServSafe, DEA handler, HACCP, alcohol sales, anti-harassment, PCI DSS, HIPAA), issuing authority or training provider, completion/issue date, expiration date, status (active/expired/suspended), score/pass-fail for training, delivery method (in-person/LMS/on-the-job), renewal reminder flag, and state jurisdiction. Critical for pharmacy DEA compliance, food safety HACCP requirements, and mandatory compliance training evidence.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique system-generated identifier for each formal associate performance evaluation record in Workday HCM Talent Management.',
    `position_id` BIGINT COMMENT 'Reference to the job position held by the associate at the time of the review, capturing role context for the evaluation period.',
    `associate_id` BIGINT COMMENT 'Reference to the associate (store, pharmacy, DC, or corporate) whose performance is being evaluated. Sourced from Workday HCM Core HR.',
    `quaternary_performance_second_level_manager_associate_id` BIGINT COMMENT 'Reference to the skip-level manager who reviewed and approved the performance evaluation, providing an additional layer of oversight for rating consistency.',
    `store_location_id` BIGINT COMMENT 'Reference to the store, distribution center, pharmacy, or corporate location where the associate was assigned during the review period.',
    `tertiary_performance_hr_business_partner_associate_id` BIGINT COMMENT 'Reference to the HR Business Partner responsible for overseeing the calibration and approval of this performance review, ensuring process compliance and consistency.',
    `acknowledgement_date` DATE COMMENT 'The date on which the associate electronically acknowledged their performance review in Workday HCM. Null if associate_acknowledged is false.',
    `associate_acknowledged` BOOLEAN COMMENT 'Indicates whether the associate has electronically acknowledged receipt and review of their completed performance evaluation in Workday HCM.',
    `calibrated_rating` STRING COMMENT 'The final overall rating assigned after the HR calibration session, which may differ from the managers initial overall_rating. This is the authoritative rating used for compensation and talent decisions.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `calibration_status` STRING COMMENT 'Indicates the current state of the HR calibration process for this review, ensuring rating consistency and fairness across the associate population. Overridden status indicates a post-calibration rating adjustment by HR leadership.. Valid values are `not_required|pending|in_progress|completed|overridden`',
    `competency_rating` STRING COMMENT 'Aggregate rating reflecting the associates demonstration of required behavioral competencies (e.g., customer focus, teamwork, safety compliance) as defined in the Workday competency framework.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `competency_rating_score` DECIMAL(18,2) COMMENT 'Numeric score for competency assessment on a standardized scale (e.g., 1.00–5.00), used in weighted overall rating calculations.',
    `completion_date` DATE COMMENT 'The actual date on which the performance review was finalized, acknowledged by the associate, and marked as completed in Workday HCM.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the performance review record was first created in Workday HCM, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and SOX compliance.',
    `department_code` STRING COMMENT 'The organizational department code (from SAP CO or Workday HCM) to which the associate belonged during the review period, used for departmental performance analytics and labor cost allocation.',
    `development_plan_comments` STRING COMMENT 'Free-text narrative capturing agreed-upon development actions, training recommendations, and career growth objectives for the associate following the review. Drives talent development decisions.',
    `employment_type` STRING COMMENT 'The associates employment classification at the time of the review, used to apply appropriate review templates and merit eligibility rules.. Valid values are `full_time|part_time|seasonal|temporary`',
    `flight_risk` BOOLEAN COMMENT 'Indicates whether the associate has been identified as a retention risk during the calibration or review process, triggering targeted retention actions by HR and management.',
    `goal_rating` STRING COMMENT 'Aggregate rating reflecting the associates performance against individually assigned business goals and objectives for the review period, as evaluated in Workday HCM.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `goal_rating_score` DECIMAL(18,2) COMMENT 'Numeric score for goal achievement on a standardized scale (e.g., 1.00–5.00), used in weighted overall rating calculations and compensation planning.',
    `job_classification` STRING COMMENT 'The FLSA (Fair Labor Standards Act) job classification of the associate at the time of review: exempt (salaried) or non-exempt (hourly). Impacts merit increase calculation methodology and compliance reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the performance review record was most recently updated in Workday HCM, in ISO 8601 format. Tracks the latest change for audit and data lineage purposes.',
    `manager_comments` STRING COMMENT 'Free-text narrative provided by the manager summarizing the associates performance, strengths, development areas, and behavioral observations during the review period. Classified confidential as it contains sensitive HR evaluation content.',
    `merit_increase_pct` DECIMAL(18,2) COMMENT 'Recommended merit salary increase expressed as a percentage of the associates current base pay, as proposed by the manager during the review. Subject to HR and finance approval in the compensation planning cycle.',
    `merit_increase_recommended` BOOLEAN COMMENT 'Indicates whether the manager has recommended a merit-based salary increase for the associate based on the performance review outcome. Feeds into the annual compensation planning cycle.',
    `overall_rating` STRING COMMENT 'The final holistic performance rating assigned to the associate for the review period, reflecting the managers assessment of overall contribution. Drives merit increase eligibility and talent calibration. [ENUM-REF-CANDIDATE: exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory — promote to reference product if rating scale changes]. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric score corresponding to the overall performance rating on a standardized scale (e.g., 1.00–5.00), enabling quantitative ranking and calibration analytics across the associate population.',
    `pip_required` BOOLEAN COMMENT 'Indicates whether a formal Performance Improvement Plan (PIP) has been initiated or is required as a result of this performance review, typically for associates rated needs_improvement or unsatisfactory.',
    `promotion_recommended` BOOLEAN COMMENT 'Indicates whether the manager has recommended the associate for a promotion to a higher job level or position as an outcome of the performance review.',
    `promotion_target_position` STRING COMMENT 'The job title or position name being recommended for promotion, if promotion_recommended is true. Used in succession planning and talent pipeline management.',
    `review_cycle_year` STRING COMMENT 'The fiscal or calendar year of the performance review cycle (e.g., 2024), used for year-over-year performance trending and compensation planning alignment.',
    `review_due_date` DATE COMMENT 'The target completion date by which the manager must finalize and submit the performance review, as set by HR policy or the Workday review cycle configuration.',
    `review_number` STRING COMMENT 'Externally-known business identifier for the performance review record, used in HR correspondence, calibration sessions, and compensation planning workflows. Format: PR-YYYY-NNNNNN.. Valid values are `^PR-[0-9]{4}-[0-9]{6}$`',
    `review_period_end_date` DATE COMMENT 'The last day of the performance evaluation period being assessed. Defines the boundary of performance data considered in the review.',
    `review_period_start_date` DATE COMMENT 'The first day of the performance evaluation period being assessed. Used to align the review with the fiscal or calendar year cycle.',
    `review_status` STRING COMMENT 'Current lifecycle state of the performance review record within the Workday HCM workflow: draft (initiated), in_progress (manager actively editing), pending_approval (submitted for HR/calibration approval), calibrated (post-calibration session), completed (finalized and acknowledged), cancelled (voided).. Valid values are `draft|in_progress|pending_approval|calibrated|completed|cancelled`',
    `review_template_name` STRING COMMENT 'The name of the Workday HCM performance review template used for this evaluation (e.g., Store Associate Annual Review, Pharmacist Annual Review, DC Hourly Annual Review), which determines the goal and competency sections included.',
    `review_type` STRING COMMENT 'Classification of the review cycle: annual (year-end), mid_year (mid-cycle check-in), 90_day (new hire 90-day evaluation), probationary (extended probation review), or pip (Performance Improvement Plan review). [ENUM-REF-CANDIDATE: annual|mid_year|90_day|probationary|pip|off_cycle — promote to reference product if additional types are added]. Valid values are `annual|mid_year|90_day|probationary|pip`',
    `self_assessment_comments` STRING COMMENT 'Free-text narrative submitted by the associate reflecting on their own performance, accomplishments, and development goals during the review period. Classified confidential as it contains sensitive HR self-evaluation content.',
    `talent_segment` STRING COMMENT 'HR-assigned talent classification derived from the calibration process, used for succession planning and targeted development investment. Classified confidential as it contains sensitive talent strategy data. [ENUM-REF-CANDIDATE: high_potential|key_contributor|solid_performer|developing|at_risk — promote to reference product]. Valid values are `high_potential|key_contributor|solid_performer|developing|at_risk`',
    `tenure_at_review_months` STRING COMMENT 'The number of complete months the associate had been employed at Grocery as of the review period end date. Used to contextualize performance expectations and merit eligibility thresholds.',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Formal associate performance evaluations conducted through Workday HCM Talent Management. Captures review period, review type (annual/mid-year/90-day/probationary), overall performance rating, individual goal ratings, competency ratings, manager comments, associate self-assessment, calibration status, merit increase recommendation, promotion recommendation, and review completion date. Drives compensation planning and talent development decisions.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`labor_budget` (
    `labor_budget_id` BIGINT COMMENT 'Unique surrogate identifier for each labor budget record in the Databricks Silver Layer. Primary key for the labor_budget data product.',
    `associate_id` BIGINT COMMENT 'Reference to the employee (store manager, district manager, or finance controller) who approved this labor budget version. Supports SOX internal controls audit trail.',
    `cost_center_id` BIGINT COMMENT 'Reference to the SAP Controlling (CO) cost center to which this labor budget is financially allocated, enabling EBITDA and COGS labor cost tracking.',
    `department_id` BIGINT COMMENT 'Reference to the store or DC department (e.g., Produce, Pharmacy, Deli, Bakery, Front End, Fuel Center) for which this labor budget is scoped.',
    `fiscal_period_id` BIGINT COMMENT 'Reference to the pay period (weekly, bi-weekly, etc.) that this labor budget covers, aligning with Kronos Workforce Central scheduling cycles and Workday HCM payroll periods.',
    `store_location_id` BIGINT COMMENT 'Reference to the store or Distribution Center (DC) location for which this labor budget is defined. Covers supermarkets, pharmacies, fuel centers, and DC facilities.',
    `approval_status` STRING COMMENT 'Current workflow state of the labor budget record. Approved budgets are released to Kronos for schedule generation guardrails. Superseded records are replaced by a newer version. Supports SOX internal controls.. Valid values are `draft|pending_approval|approved|rejected|superseded`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the labor budget was formally approved by the authorized manager or finance controller. Critical for SOX audit trail and budget lifecycle tracking.',
    `average_wage_rate` DECIMAL(18,2) COMMENT 'Blended average hourly wage rate (USD) used to calculate budgeted labor dollars from budgeted hours. Reflects the expected mix of full-time, part-time, and department-specific pay grades for the period.',
    `benefits_load_percent` DECIMAL(18,2) COMMENT 'Percentage applied to base wage costs to account for employer-paid benefits (health insurance, retirement contributions, FICA, etc.) when calculating total budgeted labor dollars. Expressed as a decimal (e.g., 0.2500 = 25%).',
    `budget_end_date` DATE COMMENT 'Last calendar date of the labor budget period. For weekly budgets, this is typically the end of the work week as configured in Kronos Workforce Central.',
    `budget_notes` STRING COMMENT 'Free-text notes or justification comments entered by the budget preparer or approver, documenting assumptions, special events (e.g., holiday week, store remodel), or reasons for revision. Supports audit trail and SOX documentation requirements.',
    `budget_number` STRING COMMENT 'Externally-known business identifier for the labor budget record, used for cross-system reference between Kronos Workforce Central and Workday HCM (e.g., LB-2024-STR001-WK01). Serves as the BUSINESS_IDENTIFIER for this transaction.',
    `budget_period_type` STRING COMMENT 'Granularity of the labor budget period. Weekly budgets drive Kronos schedule generation guardrails; quarterly and annual budgets support financial planning and EBITDA reporting.. Valid values are `weekly|monthly|quarterly|annual`',
    `budget_start_date` DATE COMMENT 'First calendar date of the labor budget period. For weekly budgets, this is typically the start of the work week as configured in Kronos Workforce Central.',
    `budget_version_type` STRING COMMENT 'Indicates whether this record represents the original approved budget, a mid-period revision, a rolling forecast, or a reforecast. Enables budget vs. actual variance analysis across versions.. Valid values are `original|revised|forecast|reforecast`',
    `budgeted_fte_count` DECIMAL(18,2) COMMENT 'Approved Full-Time Equivalent (FTE) count for the budget period, calculated as total budgeted hours divided by standard full-time hours. Distinct from headcount as it normalizes part-time associates into FTE units for financial planning.',
    `budgeted_headcount` STRING COMMENT 'Approved number of full-time equivalent (FTE) and part-time associates budgeted for the store/department during the budget period. Drives hiring targets and workforce planning in Workday HCM.',
    `budgeted_hours_friday` DECIMAL(18,2) COMMENT 'Approved labor hours allocated for Friday within the budget period. Enables day-of-week labor distribution planning and daily schedule generation targets in Kronos.',
    `budgeted_hours_monday` DECIMAL(18,2) COMMENT 'Approved labor hours allocated for Monday within the budget period. Enables day-of-week labor distribution planning and daily schedule generation targets in Kronos.',
    `budgeted_hours_saturday` DECIMAL(18,2) COMMENT 'Approved labor hours allocated for Saturday within the budget period. Weekend days typically carry higher traffic and labor demand in retail-grocery operations.',
    `budgeted_hours_sunday` DECIMAL(18,2) COMMENT 'Approved labor hours allocated for Sunday within the budget period. Weekend days typically carry higher traffic and labor demand in retail-grocery operations.',
    `budgeted_hours_thursday` DECIMAL(18,2) COMMENT 'Approved labor hours allocated for Thursday within the budget period. Enables day-of-week labor distribution planning and daily schedule generation targets in Kronos.',
    `budgeted_hours_total` DECIMAL(18,2) COMMENT 'Total approved labor hours for the budget period across all days for the store/department combination. Used as the primary guardrail for Kronos schedule generation and labor cost control.',
    `budgeted_hours_tuesday` DECIMAL(18,2) COMMENT 'Approved labor hours allocated for Tuesday within the budget period. Enables day-of-week labor distribution planning and daily schedule generation targets in Kronos.',
    `budgeted_hours_wednesday` DECIMAL(18,2) COMMENT 'Approved labor hours allocated for Wednesday within the budget period. Enables day-of-week labor distribution planning and daily schedule generation targets in Kronos.',
    `budgeted_labor_dollars` DECIMAL(18,2) COMMENT 'Total approved labor cost in USD for the budget period, inclusive of regular wages, overtime estimates, and applicable benefits load. Used for EBITDA and COGS labor cost reporting. Classified confidential as it reflects internal financial planning data.',
    `budgeted_overtime_hours` DECIMAL(18,2) COMMENT 'Portion of total budgeted labor hours designated as overtime (hours exceeding 40 per week per FLSA). Enables overtime cost projection and compliance monitoring.',
    `budgeted_regular_hours` DECIMAL(18,2) COMMENT 'Portion of total budgeted labor hours designated as straight-time (non-overtime) hours. Used to separate regular pay from overtime cost projections in labor analytics.',
    `comp_sales_assumption` DECIMAL(18,2) COMMENT 'Projected comparable store sales (Comp Sales) in USD used as the demand driver assumption when building this labor budget. Comp Sales represent revenue comparison for existing store locations year-over-year, linking labor investment to expected sales volume.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this labor budget record was first created in the system. Supports audit trail and data lineage requirements per SOX.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter number) within the fiscal year to which this labor budget belongs. Supports period-level budget vs. actual variance analysis and financial reporting.',
    `fiscal_week` STRING COMMENT 'The fiscal week number within the fiscal year (1–52 or 1–53 for 53-week years) to which this labor budget applies. Aligns with Kronos weekly scheduling cycles and retail fiscal calendar conventions.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this labor budget belongs, aligned with the companys retail fiscal calendar (typically a 52/53-week year). Used for annual budget rollup and Same-Store Sales (comp sales) year-over-year comparisons.',
    `gmroi_labor_target` DECIMAL(18,2) COMMENT 'Target Gross Margin Return on Investment (GMROI) metric used to optimize labor allocation relative to gross margin contribution for the department/store. Drives GMROI-driven labor optimization analytics.',
    `is_current_version` BOOLEAN COMMENT 'Indicates whether this record is the active/current version of the labor budget for the store/department/period combination. Only one record per store/department/period should have this flag set to True at any time.',
    `kronos_schedule_group_code` STRING COMMENT 'Kronos Workforce Central schedule group code that this labor budget is associated with, used to push approved budget guardrails directly into Kronos scheduling engine for automated schedule generation.',
    `labor_cost_percent_target` DECIMAL(18,2) COMMENT 'Target labor cost as a percentage of net sales for the budget period (e.g., 0.1250 = 12.50%). A primary KPI for store operations and financial performance management. Classified confidential as it reflects internal margin strategy.',
    `sales_per_labor_hour_target` DECIMAL(18,2) COMMENT 'Target sales revenue generated per labor hour for the budget period, a key labor productivity metric in retail-grocery. Used for GMROI-driven labor optimization and schedule generation guardrails in Kronos.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this labor budget record was last modified. Tracks revisions and reforecasts throughout the budget lifecycle.',
    `version_number` STRING COMMENT 'Sequential version number for this budget record within the same store/department/period combination. Version 1 is the original budget; subsequent versions represent revisions or reforecasts. Enables version history tracking.',
    `workday_budget_reference_code` STRING COMMENT 'External reference identifier from Workday HCM corresponding to this labor budget record, enabling cross-system reconciliation between the Databricks Silver Layer and Workday HCM financial planning modules.',
    CONSTRAINT pk_labor_budget PRIMARY KEY(`labor_budget_id`)
) COMMENT 'Approved labor hour and dollar budgets by store, department, and pay period used for scheduling and labor cost control. Captures budget period (weekly/quarterly/annual), store/DC location, department, budgeted hours by day-of-week, budgeted labor dollars, budgeted headcount, budget version (original/revised/forecast), approval status, comp sales assumption, sales-per-labor-hour target, and labor cost percentage target. Enables labor budget vs. actual variance analysis, daily schedule generation targets, and GMROI-driven labor optimization. Integrates with Kronos for schedule generation guardrails.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`union_contract` (
    `union_contract_id` BIGINT COMMENT 'Unique surrogate identifier for the union collective bargaining agreement (CBA) record in the Grocery workforce data platform. Primary key for the union_contract entity.',
    `primary_successor_contract_union_contract_id` BIGINT COMMENT 'Reference to the union_contract_id of the successor collective bargaining agreement that replaced this contract upon expiration or renegotiation. Enables contract lineage tracking and historical analysis of CBA evolution over time.',
    `arbitration_provider` STRING COMMENT 'Name of the arbitration organization or panel designated in the CBA to resolve unresolved grievances (e.g., American Arbitration Association (AAA), Federal Mediation and Conciliation Service (FMCS)). Used by labor relations for dispute escalation.',
    `bargaining_unit_description` STRING COMMENT 'Narrative description of the bargaining unit covered by the collective bargaining agreement, defining the scope of employees included (e.g., All full-time and part-time store associates employed at retail locations in the greater Washington DC metro area, excluding pharmacists, managers, and supervisors).',
    `bargaining_unit_type` STRING COMMENT 'Classification of the operational segment covered by the bargaining unit. Drives routing of labor rules to the appropriate workforce management system configuration in Kronos and Workday. store covers retail store associates; distribution_center covers DC workers; pharmacy covers licensed pharmacy staff; corporate covers office-based union employees; fuel_center covers fuel center attendants.. Valid values are `store|distribution_center|pharmacy|corporate|fuel_center`',
    `base_wage_rate` DECIMAL(18,2) COMMENT 'The minimum or entry-level hourly wage rate established by the collective bargaining agreement for covered associates, expressed in USD per hour. Used as the floor for pay rate configuration in Workday HCM Payroll.',
    `cba_number` STRING COMMENT 'Externally-known reference number assigned to the collective bargaining agreement by the union or labor relations department. Used for cross-referencing with Workday HCM and Kronos Workforce Central labor rule configurations.. Valid values are `^[A-Z0-9-]{3,30}$`',
    `contract_document_reference` STRING COMMENT 'Reference path, URL, or document management system identifier pointing to the full executed collective bargaining agreement document (e.g., SharePoint path, Workday document ID). Enables direct access to the authoritative contract text.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the collective bargaining agreement. active indicates the contract is in force; expired indicates the term has lapsed; pending_ratification indicates the agreement has been reached but not yet ratified by members; under_negotiation indicates active bargaining is in progress; terminated indicates the contract was ended prior to expiration.. Valid values are `active|expired|pending_ratification|under_negotiation|terminated`',
    `contract_title` STRING COMMENT 'Descriptive title of the collective bargaining agreement, typically including the union name, local number, and bargaining unit (e.g., UFCW Local 400 Store Associates CBA 2023-2026). Used for display and reporting purposes.',
    `covered_job_classifications` STRING COMMENT 'Comma-delimited list or narrative description of the job titles and classifications explicitly covered under this collective bargaining agreement (e.g., Cashier, Grocery Clerk, Deli Associate, Bakery Associate, Night Crew). Used to determine which Workday HCM positions are subject to CBA terms.',
    `dues_checkoff_authorized` BOOLEAN COMMENT 'Indicates whether the collective bargaining agreement authorizes the employer to deduct union dues directly from covered associates paychecks and remit to the union (dues checkoff). Drives payroll deduction configuration in Workday HCM Payroll.',
    `effective_date` DATE COMMENT 'The date on which the collective bargaining agreement becomes legally binding and operative. Drives activation of union-specific scheduling rules, pay rates, and benefit eligibility in Kronos Workforce Central and Workday HCM.',
    `excluded_job_classifications` STRING COMMENT 'Comma-delimited list or narrative description of job titles and classifications explicitly excluded from coverage under this collective bargaining agreement (e.g., Store Manager, Assistant Store Manager, Department Manager, Pharmacist-in-Charge). Ensures correct application of union vs. non-union pay and scheduling rules.',
    `expiration_date` DATE COMMENT 'The date on which the collective bargaining agreement expires and is no longer in force unless extended or renegotiated. Used to trigger renegotiation workflows and alert labor relations teams in Workday HCM.',
    `geographic_coverage` STRING COMMENT 'Description of the geographic region or list of states/markets covered by this collective bargaining agreement (e.g., Virginia, Maryland, Washington DC). Used to associate the contract with specific store locations and distribution centers in the workforce system.',
    `grievance_procedure_reference` STRING COMMENT 'Reference identifier or document citation for the grievance and arbitration procedure defined in the collective bargaining agreement (e.g., Article 12 - Grievance and Arbitration Procedure). Used by labor relations teams to locate and apply the correct dispute resolution process.',
    `health_benefit_plan_description` STRING COMMENT 'Description of the health insurance and medical benefit provisions negotiated in the CBA, including plan type, employer contribution rates, eligibility waiting periods, and any union-administered trust fund arrangements. Drives benefit eligibility configuration in Workday HCM Benefits.',
    `kronos_labor_rule_group` STRING COMMENT 'The labor rule group identifier in Kronos Workforce Central that corresponds to this collective bargaining agreement. Associates the CBA with the specific scheduling, overtime, and break rules configured in Kronos for covered associates.',
    `management_rights_clause` BOOLEAN COMMENT 'Indicates whether the collective bargaining agreement contains a management rights clause explicitly reserving certain operational decisions (e.g., scheduling, staffing levels, technology adoption) to management discretion. Relevant for store operations and DC management.',
    `maximum_hours_per_week` DECIMAL(18,2) COMMENT 'Maximum number of hours per week that covered associates may be scheduled under the CBA before overtime provisions are triggered, expressed as a decimal. Used to enforce scheduling caps in Kronos Workforce Central.',
    `minimum_hours_guarantee` DECIMAL(18,2) COMMENT 'Minimum number of hours per week guaranteed to covered associates under the CBA, expressed as a decimal (e.g., 24.00 hours). Used to enforce scheduling minimums in Kronos Workforce Central and protect associate eligibility for benefits.',
    `negotiation_start_date` DATE COMMENT 'The date on which formal collective bargaining negotiations commenced for this contract cycle. Used to track negotiation timelines and labor relations planning.',
    `no_strike_clause` BOOLEAN COMMENT 'Indicates whether the collective bargaining agreement contains a no-strike/no-lockout clause prohibiting work stoppages during the contract term. Critical for labor relations risk assessment and business continuity planning.',
    `overtime_rule_description` STRING COMMENT 'Description of overtime eligibility and calculation rules as defined in the CBA, including daily and weekly overtime thresholds, premium pay multipliers, and any union-specific overtime provisions that differ from FLSA minimums. Drives Kronos Workforce Central overtime rule configuration.',
    `paid_time_off_provisions` STRING COMMENT 'Description of paid time off entitlements defined in the CBA, including vacation accrual schedules by seniority, sick leave provisions, personal days, and holiday pay eligibility. Drives PTO accrual rule configuration in Kronos Workforce Central and Workday HCM.',
    `pension_plan_description` STRING COMMENT 'Description of the retirement and pension benefit provisions in the CBA, including defined benefit or defined contribution plan type, employer contribution rates, vesting schedules, and any multi-employer pension fund participation (e.g., UFCW Industry Pension Fund). Drives retirement benefit configuration in Workday HCM.',
    `ratification_date` DATE COMMENT 'The date on which union members voted to ratify and formally approve the collective bargaining agreement. Marks the transition from pending_ratification to active status.',
    `reopener_clause` BOOLEAN COMMENT 'Indicates whether the collective bargaining agreement contains a reopener clause allowing either party to renegotiate specific provisions (typically wages or benefits) during the contract term without full renegotiation. Used to flag contracts requiring mid-term attention.',
    `reopener_trigger_date` DATE COMMENT 'The specific date on which a reopener clause becomes eligible to be invoked, if applicable. Null if no reopener clause exists. Used by labor relations teams to plan mid-term negotiation timelines.',
    `rest_period_rule_description` STRING COMMENT 'Description of mandatory rest and break period requirements defined in the CBA, including minimum time between shifts, paid rest breaks, and meal period provisions. Drives break rule configuration in Kronos Workforce Central to ensure compliance.',
    `seniority_rule_description` STRING COMMENT 'Description of seniority-based rules governing scheduling preference, shift bidding, layoff order, recall rights, and promotion eligibility as defined in the collective bargaining agreement. Drives seniority-based scheduling logic in Kronos Workforce Central.',
    `shift_differential_description` STRING COMMENT 'Description of shift differential pay provisions in the CBA, including premium pay rates for evening, overnight, weekend, and holiday shifts. Drives shift premium configuration in Kronos Workforce Central and Workday HCM Payroll.',
    `top_of_scale_wage_rate` DECIMAL(18,2) COMMENT 'The maximum hourly wage rate achievable under the CBA wage progression schedule for covered associates, expressed in USD per hour. Used for labor cost modeling and budget planning.',
    `union_local_number` STRING COMMENT 'The local chapter number of the union representing the bargaining unit (e.g., Local 400, Local 1776). Identifies the specific regional or functional union local that negotiated and administers the contract.. Valid values are `^[A-Z0-9-]{1,20}$`',
    `union_name` STRING COMMENT 'Full legal name of the labor union that is party to the collective bargaining agreement (e.g., United Food and Commercial Workers International Union, International Brotherhood of Teamsters). Used for labor relations reporting and compliance.',
    `union_security_clause` STRING COMMENT 'Type of union security provision in the CBA governing membership requirements for covered associates. union_shop requires all employees to join the union; agency_shop requires payment of dues but not membership; open_shop has no membership requirement; maintenance_of_membership requires members to remain members; none indicates no union security clause.. Valid values are `union_shop|agency_shop|open_shop|maintenance_of_membership|none`',
    `wage_progression_steps` STRING COMMENT 'Total number of wage progression steps defined in the CBA wage scale from entry-level to top-of-scale pay rate. Used to configure step-based compensation progression in Workday HCM.',
    `wage_scale_description` STRING COMMENT 'Narrative description of the wage scale provisions defined in the collective bargaining agreement, including step progression schedules, longevity increases, and classification-based pay differentials. Drives pay rate configuration in Workday HCM Payroll and Kronos Workforce Central.',
    `workday_cba_code` STRING COMMENT 'The system-generated identifier for this collective bargaining agreement record in Workday HCM, used for integration and reconciliation between the Grocery data lakehouse and the Workday HCM source system.. Valid values are `^[A-Z0-9-_]{1,50}$`',
    CONSTRAINT pk_union_contract PRIMARY KEY(`union_contract_id`)
) COMMENT 'Collective bargaining agreement (CBA) records governing union-represented associates across store, DC, and pharmacy bargaining units. Tracks union name, local number, contract effective date, contract expiration date, bargaining unit description, covered job classifications, wage scale provisions, seniority rules, grievance procedure reference, and ratification date. Drives union-specific scheduling rules, pay rates, and benefit eligibility in Kronos and Workday.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`talent_acquisition` (
    `talent_acquisition_id` BIGINT COMMENT 'Unique surrogate key for each talent acquisition record.',
    `associate_id` BIGINT COMMENT 'Identifier of the manager responsible for the requisition.',
    `candidate_id` BIGINT COMMENT 'Unique identifier for the candidate.',
    `department_id` BIGINT COMMENT 'Identifier of the department requesting the hire.',
    `position_id` BIGINT COMMENT 'Identifier of the position being filled.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store or distribution center where the position is located.',
    `reposted_from_talent_acquisition_id` BIGINT COMMENT 'Self-referencing FK on talent_acquisition (reposted_from_talent_acquisition_id)',
    `application_date` DATE COMMENT 'Date the candidate submitted the application.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Score from candidate assessment tests.',
    `background_check_completed_date` DATE COMMENT 'Date when the background check was completed.',
    `background_check_status` STRING COMMENT 'Status of the candidates background check.. Valid values are `pending|cleared|failed|exempt`',
    `candidate_certifications` STRING COMMENT 'List of relevant certifications held by the candidate.',
    `candidate_disability_status` STRING COMMENT 'Disability status of the candidate for EEO reporting.. Valid values are `disabled|non_disabled|prefer_not_to_answer`',
    `candidate_education_level` STRING COMMENT 'Highest education level attained by the candidate.',
    `candidate_email` STRING COMMENT 'Primary email address of the candidate.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `candidate_ethnicity` STRING COMMENT 'Ethnicity of the candidate for EEO reporting. [ENUM-REF-CANDIDATE: Hispanic|Non-Hispanic|Asian|Black|White|Other — promote to reference product]',
    `candidate_gender` STRING COMMENT 'Gender of the candidate for EEO reporting.. Valid values are `male|female|non_binary|prefer_not_to_answer`',
    `candidate_name` STRING COMMENT 'Legal full name of the candidate.',
    `candidate_phone` STRING COMMENT 'Contact phone number of the candidate.',
    `candidate_source_channel` STRING COMMENT 'Channel through which the candidate applied.. Valid values are `referral|career_site|job_board|social_media|recruiter|internal`',
    `candidate_veteran_status` STRING COMMENT 'Veteran status of the candidate for EEO reporting.. Valid values are `veteran|non_veteran|prefer_not_to_answer`',
    `candidate_years_experience` STRING COMMENT 'Total years of relevant work experience reported by the candidate.',
    `interview_stage` STRING COMMENT 'Current stage of the interview process.. Valid values are `phone|onsite|virtual|final|offer`',
    `ofccp_reportable_flag` BOOLEAN COMMENT 'Indicates if the requisition is subject to OFCCP reporting requirements.',
    `offer_acceptance_date` DATE COMMENT 'Date when the candidate accepted the offer.',
    `offer_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the salary or compensation offer.',
    `offer_currency` STRING COMMENT 'Currency code (ISO 4217) for the offer amount.',
    `offer_decline_reason` STRING COMMENT 'Reason provided by the candidate for declining the offer.',
    `offer_status` STRING COMMENT 'Current status of the job offer.. Valid values are `extended|accepted|declined|withdrawn`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this talent acquisition record was first created in the data lake.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this record.',
    `requisition_age_days` STRING COMMENT 'Number of days the requisition has been open.',
    `requisition_approval_date` DATE COMMENT 'Date when the requisition was approved.',
    `requisition_creation_timestamp` TIMESTAMP COMMENT 'Timestamp when the requisition was created in the system.',
    `requisition_number` STRING COMMENT 'External identifier for the job requisition.',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the requisition.. Valid values are `open|closed|cancelled|on_hold|filled|rejected`',
    `screening_status` STRING COMMENT 'Result of the initial screening process.. Valid values are `pending|passed|failed|withdrawn`',
    `start_date` DATE COMMENT 'Actual start date of the employee after acceptance.',
    `target_start_date` DATE COMMENT 'Planned start date for the hired employee.',
    `time_to_fill_days` STRING COMMENT 'Number of days between requisition creation and candidate start date.',
    CONSTRAINT pk_talent_acquisition PRIMARY KEY(`talent_acquisition_id`)
) COMMENT 'Recruiting pipeline management from job requisition creation through candidate offer acceptance. Tracks requisitions (position requested, department, store/DC location, hiring manager, requisition status, approval date, target start date), candidate applications (source channel, application date, screening status, interview stage, assessment scores, background check status, offer details, offer acceptance/decline, start date). Supports time-to-fill metrics, requisition aging, source effectiveness analysis, and OFCCP/EEO compliance reporting for affirmative action plans. Sourced from Workday HCM Recruiting.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`associate_availability` (
    `associate_availability_id` BIGINT COMMENT 'System-generated unique identifier for each associate availability record.',
    `associate_id` BIGINT COMMENT 'Unique identifier of the associate to whom this availability applies.',
    `superseded_associate_availability_id` BIGINT COMMENT 'Self-referencing FK on associate_availability (superseded_associate_availability_id)',
    `availability_status` STRING COMMENT 'Current lifecycle status of the availability record.. Valid values are `active|inactive|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the availability record was initially created.',
    `cross_training_flag` BOOLEAN COMMENT 'Indicates if the associate is willing to work in cross‑trained roles.',
    `day_of_week` STRING COMMENT 'Day of the week the availability window applies. [ENUM-REF-CANDIDATE: Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday — promote to reference product]',
    `effective_end_date` DATE COMMENT 'Last date the availability record is valid; null indicates open-ended.',
    `effective_start_date` DATE COMMENT 'First date the availability record becomes effective for scheduling.',
    `end_time` TIMESTAMP COMMENT 'Latest end time (HH:mm) the associate is willing to work on the specified day.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the availability record.',
    `max_hours_per_week` DECIMAL(18,2) COMMENT 'Maximum total hours the associate prefers to work in a week.',
    `minor_work_restriction_flag` BOOLEAN COMMENT 'True if the associate is under 18 and subject to minor work‑hour limits.',
    `notes` STRING COMMENT 'Free‑form comments or special instructions related to the associates availability.',
    `overtime_preference_flag` BOOLEAN COMMENT 'Indicates if the associate is willing to accept overtime assignments.',
    `preferred_department_code` STRING COMMENT 'Department code(s) where the associate prefers to be scheduled.',
    `recurring_unavailability_pattern` STRING COMMENT 'Textual pattern describing recurring unavailability (e.g., every first Monday of month).',
    `shift_preference` STRING COMMENT 'Preferred shift timing category for the associate.. Valid values are `early|mid|late`',
    `source_system` STRING COMMENT 'Name of the source system that supplied the availability data (e.g., Kronos, Workday).',
    `start_time` TIMESTAMP COMMENT 'Earliest start time (HH:mm) the associate is willing to work on the specified day.',
    `unavailable_date` DATE COMMENT 'A calendar date on which the associate is unavailable (e.g., vacation, personal day).',
    `union_seniority_preference_flag` BOOLEAN COMMENT 'True if the associate prefers shifts based on union seniority rules.',
    CONSTRAINT pk_associate_availability PRIMARY KEY(`associate_availability_id`)
) COMMENT 'Associate work availability windows, scheduling preferences, and constraint declarations used by Kronos Workforce Central for automated schedule generation. Tracks available days of week, available time windows (earliest start, latest end), maximum hours per week preference, unavailable dates, recurring unavailability patterns, preferred departments, cross-training availability flags, minor work-hour restrictions (for associates under 18), and effective date ranges. Critical input for Kronos auto-scheduler and union seniority-based shift bidding processes.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`certification_type` (
    `certification_type_id` BIGINT COMMENT 'Primary key for certification_type',
    `parent_certification_type_id` BIGINT COMMENT 'Self-referencing FK on certification_type (parent_certification_type_id)',
    `certification_type_category` STRING COMMENT 'Broad classification of the certification type.',
    `certification_type_code` STRING COMMENT 'Short alphanumeric code used to reference the certification in systems.',
    `compliance_status` STRING COMMENT 'Current compliance status of the certification type within the organization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification type record was first created in the system.',
    `certification_type_description` STRING COMMENT 'Detailed description of the certification purpose, scope, and requirements.',
    `effective_date` DATE COMMENT 'Date when the certification type becomes effective for new hires.',
    `expiration_date` DATE COMMENT 'Date when the certification type is scheduled to be retired or superseded.',
    `external_reference_code` STRING COMMENT 'Identifier linking to the certification record in external regulatory or vendor systems.',
    `is_mandatory` BOOLEAN COMMENT 'Flag indicating if the certification is mandatory for the associated role.',
    `issuing_authority` STRING COMMENT 'Organization or body that issues the certification.',
    `certification_type_name` STRING COMMENT 'Human‑readable name of the certification (e.g., "OSHA Forklift Operator").',
    `notes` STRING COMMENT 'Free‑form notes or comments about the certification type.',
    `recurring_interval_days` STRING COMMENT 'If recurring training is required, the number of days between required renewals.',
    `required_for_role` STRING COMMENT 'Job role(s) that must hold this certification (e.g., "Store Associate", "Pharmacist").',
    `requires_recurring_training` BOOLEAN COMMENT 'Indicates whether the certification must be renewed through periodic training.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification type record.',
    `validity_period_days` STRING COMMENT 'Number of days the certification remains valid from the effective date.',
    `version_number` STRING COMMENT 'Incremental version number for changes to the certification definition.',
    CONSTRAINT pk_certification_type PRIMARY KEY(`certification_type_id`)
) COMMENT 'Master reference table for certification_type. Referenced by type_id.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`leave_plan` (
    `leave_plan_id` BIGINT COMMENT 'Primary key for leave_plan',
    `superseded_leave_plan_id` BIGINT COMMENT 'Self-referencing FK on leave_plan (superseded_leave_plan_id)',
    `accrual_frequency` STRING COMMENT 'How often accruals are applied to employee balances.',
    `accrual_method` STRING COMMENT 'Method used to calculate accruals.',
    `accrual_rate` DECIMAL(18,2) COMMENT 'Rate at which leave accrues per accrual unit (e.g., 1.25 hours per month).',
    `accrual_unit` STRING COMMENT 'Time unit used for accrual calculations.',
    `balance` DECIMAL(18,2) COMMENT 'Current accrued leave balance for the plan (as of balance_as_of_date).',
    `balance_as_of_date` DATE COMMENT 'Date for which the current balance is reported.',
    `carryover_allowed` BOOLEAN COMMENT 'Indicates whether unused leave can be carried over to the next period.',
    `carryover_limit` DECIMAL(18,2) COMMENT 'Maximum amount of leave that may be carried over.',
    `compliance_flsa` BOOLEAN COMMENT 'Indicates whether the leave plan complies with the Fair Labor Standards Act.',
    `compliance_osha` BOOLEAN COMMENT 'Indicates whether the leave plan complies with OSHA regulations for safety‑related leave.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the leave plan record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the leave plan becomes effective for eligible employees.',
    `effective_until` DATE COMMENT 'Date when the leave plan expires or is superseded (null for open‑ended).',
    `eligibility_department` STRING COMMENT 'Department(s) whose employees are eligible for this leave plan.',
    `eligibility_job_role` STRING COMMENT 'Job role(s) eligible for the leave plan.',
    `eligibility_service_years_max` STRING COMMENT 'Maximum years of service for eligibility (if any).',
    `eligibility_service_years_min` STRING COMMENT 'Minimum years of service required for eligibility.',
    `expiration_policy` STRING COMMENT 'Rules governing when accrued leave expires if not used.',
    `external_reference_code` STRING COMMENT 'Identifier used in external HR systems to reference this leave plan.',
    `is_flexible` BOOLEAN COMMENT 'Indicates whether employees can flexibly schedule this leave.',
    `is_maternity_leave` BOOLEAN COMMENT 'True if the plan provides maternity leave.',
    `is_paid_leave` BOOLEAN COMMENT 'Indicates whether the leave is paid.',
    `is_sick_leave` BOOLEAN COMMENT 'True if the plan provides sick leave.',
    `is_vacation_leave` BOOLEAN COMMENT 'True if the plan provides vacation leave.',
    `max_accrual` DECIMAL(18,2) COMMENT 'Upper limit on total leave that can be accrued under the plan.',
    `max_accrual_per_year` DECIMAL(18,2) COMMENT 'Maximum amount of leave that can be accrued in a calendar year.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or special conditions.',
    `plan_category` STRING COMMENT 'Higher‑level classification of the plan for reporting (e.g., standard, premium).',
    `plan_code` STRING COMMENT 'External business identifier or code for the leave plan, used in payroll and scheduling systems.',
    `plan_name` STRING COMMENT 'Descriptive name of the leave plan as used in HR communications.',
    `plan_owner` STRING COMMENT 'Business unit or department responsible for the leave plan.',
    `plan_type` STRING COMMENT 'Category of leave the plan provides (e.g., vacation, sick, maternity).',
    `plan_version` STRING COMMENT 'Version identifier for the leave plan definition.',
    `rollover_policy` STRING COMMENT 'Textual description of how unused leave rolls over to the next period.',
    `leave_plan_status` STRING COMMENT 'Current lifecycle status of the leave plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the leave plan record.',
    `usage_policy` STRING COMMENT 'Business rules governing how and when leave may be taken (e.g., approval workflow).',
    `version_effective_date` DATE COMMENT 'Date when this version of the leave plan became effective.',
    CONSTRAINT pk_leave_plan PRIMARY KEY(`leave_plan_id`)
) COMMENT 'Master reference table for leave_plan. Referenced by leave_plan_id.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`pay_group` (
    `pay_group_id` BIGINT COMMENT 'Primary key for pay_group',
    `parent_pay_group_id` BIGINT COMMENT 'Self-referencing FK on pay_group (parent_pay_group_id)',
    `pay_group_code` STRING COMMENT 'Short alphanumeric code used to reference the pay group in payroll systems.',
    `cost_center` STRING COMMENT 'Cost center identifier to which payroll costs for this group are charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pay group record was first created in the system.',
    `pay_group_description` STRING COMMENT 'Detailed description of the pay group purpose and usage.',
    `effective_from` DATE COMMENT 'Date when the pay group becomes effective for payroll processing.',
    `effective_until` DATE COMMENT 'Date when the pay group ceases to be effective (null if open‑ended).',
    `eligibility_criteria` STRING COMMENT 'Business rules or conditions that determine employee eligibility for this pay group.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this pay group is the default for new hires (true) or not (false).',
    `pay_group_name` STRING COMMENT 'Descriptive name of the pay group (e.g., Hourly, Salary, Shift Differential).',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or administrative comments.',
    `overtime_eligible` BOOLEAN COMMENT 'True if employees in this pay group are eligible for overtime pay.',
    `pay_frequency` STRING COMMENT 'Standard payroll frequency associated with the pay group.',
    `payroll_account_code` STRING COMMENT 'Financial account code used for posting payroll expenses for this group.',
    `pay_group_status` STRING COMMENT 'Current lifecycle status of the pay group.',
    `tax_exempt` BOOLEAN COMMENT 'Indicates whether payroll taxes are exempt for this pay group.',
    `pay_group_type` STRING COMMENT 'Classification of the pay group by compensation model.',
    `union_eligible` BOOLEAN COMMENT 'True if the pay group is covered by a collective bargaining agreement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the pay group record.',
    CONSTRAINT pk_pay_group PRIMARY KEY(`pay_group_id`)
) COMMENT 'Master reference table for pay_group. Referenced by pay_group_id.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`pay_calendar` (
    `pay_calendar_id` BIGINT COMMENT 'Primary key for pay_calendar',
    `prior_pay_calendar_id` BIGINT COMMENT 'Self-referencing FK on pay_calendar (prior_pay_calendar_id)',
    `pay_calendar_code` STRING COMMENT 'Business code used to reference the calendar in payroll systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pay calendar record was first created.',
    `cutoff_date` DATE COMMENT 'Last date employees may submit time entries for the period.',
    `pay_calendar_description` STRING COMMENT 'Free‑form description providing additional context about the calendar.',
    `effective_end_date` DATE COMMENT 'Date when the calendar ceases to be effective (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the calendar becomes effective for payroll processing.',
    `frequency` STRING COMMENT 'How often payroll periods occur for this calendar.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this calendar is the default for the organization.',
    `pay_calendar_name` STRING COMMENT 'Human‑readable name of the pay calendar (e.g., "Bi‑Weekly Payroll").',
    `pay_period_end_day` STRING COMMENT 'Numeric day of the month or week that a pay period ends.',
    `pay_period_start_day` STRING COMMENT 'Numeric day of the month or week that a pay period starts.',
    `payroll_run_date` DATE COMMENT 'Scheduled date on which payroll is processed for the period.',
    `period_length_days` STRING COMMENT 'Number of calendar days in each pay period.',
    `pay_calendar_status` STRING COMMENT 'Current lifecycle status of the calendar.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the pay calendar record.',
    CONSTRAINT pk_pay_calendar PRIMARY KEY(`pay_calendar_id`)
) COMMENT 'Master reference table for pay_calendar. Referenced by pay_calendar_id.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`candidate` (
    `candidate_id` BIGINT COMMENT 'Primary key for candidate',
    `associate_id` BIGINT COMMENT 'Identifier of the manager responsible for the hiring decision.',
    `referred_by_candidate_id` BIGINT COMMENT 'Self-referencing FK on candidate (referred_by_candidate_id)',
    `availability_date` DATE COMMENT 'Earliest date the candidate is available to start work.',
    `background_check_status` STRING COMMENT 'Current status of the candidates background screening.',
    `candidate_type` STRING COMMENT 'Classification of the candidate based on source or relationship to the company.',
    `certifications` STRING COMMENT 'Comma-separated list of professional certifications held by the candidate.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the candidate record was first created.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the expected salary.',
    `department` STRING COMMENT 'Department within Grocery where the candidate is being considered.',
    `education_level` STRING COMMENT 'Highest level of formal education attained by the candidate.',
    `email` STRING COMMENT 'Primary email address for candidate communications.',
    `expected_salary` DECIMAL(18,2) COMMENT 'Candidates expected annual salary in the specified currency.',
    `full_name` STRING COMMENT 'Legal full name of the candidate.',
    `hire_date` DATE COMMENT 'Date the candidate officially started employment.',
    `interview_score` DECIMAL(18,2) COMMENT 'Aggregated score from candidate interviews, on a 0.00–10.00 scale.',
    `location_preference` STRING COMMENT 'Geographic location(s) the candidate prefers to work in.',
    `notes` STRING COMMENT 'Free-text field for additional remarks about the candidate.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the candidate.',
    `position_applied` STRING COMMENT 'Job title or position the candidate applied for.',
    `primary_contact_method` STRING COMMENT 'Preferred channel for contacting the candidate.',
    `resume_text` STRING COMMENT 'Full text of the candidates resume or CV.',
    `source` STRING COMMENT 'Origin channel through which the candidate was sourced.',
    `candidate_status` STRING COMMENT 'Current lifecycle status of the candidate within the hiring process.',
    `termination_date` DATE COMMENT 'Date the candidates employment ended, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the candidate record.',
    `visa_status` STRING COMMENT 'Candidates work authorization status for employment.',
    `years_experience` STRING COMMENT 'Total number of years of relevant professional experience.',
    CONSTRAINT pk_candidate PRIMARY KEY(`candidate_id`)
) COMMENT 'Master reference table for candidate. Referenced by candidate_id.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'Primary key for benefit_plan',
    `superseded_benefit_plan_id` BIGINT COMMENT 'Self-referencing FK on benefit_plan (superseded_benefit_plan_id)',
    `compliance_code` STRING COMMENT 'Code indicating the regulatory framework the plan complies with (e.g., ACA, ERISA).',
    `coverage_level` STRING COMMENT 'Scope of coverage offered by the plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the benefit plan record was first created.',
    `dependent_eligibility` STRING COMMENT 'Whether dependents are eligible for coverage under the plan.',
    `effective_from` DATE COMMENT 'Date when the benefit plan becomes binding.',
    `effective_until` DATE COMMENT 'Date when the benefit plan ends; null for open‑ended plans.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Monetary amount the employee contributes per pay period.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Monetary amount the employer contributes per pay period.',
    `enrollment_end_date` DATE COMMENT 'Last date employees may enroll in the plan.',
    `enrollment_start_date` DATE COMMENT 'First date employees may enroll in the plan.',
    `is_default` BOOLEAN COMMENT 'True if this plan is the default option for new hires.',
    `is_mandatory` BOOLEAN COMMENT 'True if enrollment in this plan is mandatory for eligible employees.',
    `max_coverage_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount the plan will pay for covered services.',
    `plan_category` STRING COMMENT 'Higher‑level grouping of the plan for reporting and analytics.',
    `plan_code` STRING COMMENT 'External business identifier or code used to reference the benefit plan.',
    `plan_description` STRING COMMENT 'Detailed textual description of the benefit plan.',
    `plan_name` STRING COMMENT 'Human‑readable name of the benefit plan.',
    `plan_status_reason` STRING COMMENT 'Free‑text explanation for the current status of the plan.',
    `plan_type` STRING COMMENT 'Category of benefit provided by the plan.',
    `plan_url` STRING COMMENT 'Web address where plan details are published for employees.',
    `plan_version` STRING COMMENT 'Version identifier for the plan, used for change management.',
    `premium_frequency` STRING COMMENT 'How often the premium is paid.',
    `provider_code` BIGINT COMMENT 'Surrogate key referencing the benefit provider entity.',
    `provider_name` STRING COMMENT 'Name of the external vendor or insurer providing the benefit.',
    `benefit_plan_status` STRING COMMENT 'Current lifecycle status of the benefit plan.',
    `termination_date` DATE COMMENT 'Date the plan was terminated, if applicable.',
    `total_premium_amount` DECIMAL(18,2) COMMENT 'Combined employee and employer premium for the plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the benefit plan record.',
    `waiting_period_days` STRING COMMENT 'Number of days after enrollment before benefits become active.',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Master reference table for benefit_plan. Referenced by benefit_plan_id.';

CREATE OR REPLACE TABLE `grocery_ecm`.`workforce`.`open_enrollment_period` (
    `open_enrollment_period_id` BIGINT COMMENT 'Primary key for open_enrollment_period',
    `prior_open_enrollment_period_id` BIGINT COMMENT 'Self-referencing FK on open_enrollment_period (prior_open_enrollment_period_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment period record was first created in the system.',
    `open_enrollment_period_description` STRING COMMENT 'Free‑form text describing the purpose, scope, and any special instructions for the period.',
    `effective_end_date` DATE COMMENT 'Date when the enrollment period ends; null for open‑ended periods.',
    `effective_start_date` DATE COMMENT 'Date when the enrollment period becomes effective for eligibility calculations.',
    `eligibility_criteria` STRING COMMENT 'Business rules that determine which employees are eligible to enroll during this period.',
    `enrollment_close_timestamp` TIMESTAMP COMMENT 'Exact moment when the enrollment window closes.',
    `enrollment_open_timestamp` TIMESTAMP COMMENT 'Exact moment when employees may begin submitting enrollment selections.',
    `enrollment_type` STRING COMMENT 'Classification of the enrollment period (e.g., benefits, health, retirement).',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether enrollment during this period is mandatory for eligible employees.',
    `max_participants` STRING COMMENT 'Upper limit on the number of participants allowed for this enrollment period, if applicable.',
    `notes` STRING COMMENT 'Any supplemental information or comments relevant to the enrollment period.',
    `period_code` STRING COMMENT 'Business identifier code used in HR systems and communications.',
    `period_name` STRING COMMENT 'Human‑readable name of the enrollment period (e.g., "2024 Benefits Open Enrollment").',
    `open_enrollment_period_status` STRING COMMENT 'Current lifecycle status of the enrollment period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment period record.',
    CONSTRAINT pk_open_enrollment_period PRIMARY KEY(`open_enrollment_period_id`)
) COMMENT 'Master reference table for open_enrollment_period. Referenced by open_enrollment_period_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ADD CONSTRAINT `fk_workforce_associate_manager_associate_id` FOREIGN KEY (`manager_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `grocery_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `grocery_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_supervisor_position_id` FOREIGN KEY (`supervisor_position_id`) REFERENCES `grocery_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `grocery_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_position_id` FOREIGN KEY (`position_id`) REFERENCES `grocery_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_shift_associate_id` FOREIGN KEY (`shift_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_shift_original_employee_associate_id` FOREIGN KEY (`shift_original_employee_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_schedule_employee_associate_id` FOREIGN KEY (`schedule_employee_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_schedule_replacement_employee_associate_id` FOREIGN KEY (`schedule_replacement_employee_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `grocery_ecm`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `grocery_ecm`.`workforce`.`schedule`(`schedule_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_pay_calendar_id` FOREIGN KEY (`pay_calendar_id`) REFERENCES `grocery_ecm`.`workforce`.`pay_calendar`(`pay_calendar_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_pay_group_id` FOREIGN KEY (`pay_group_id`) REFERENCES `grocery_ecm`.`workforce`.`pay_group`(`pay_group_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_prior_run_payroll_run_id` FOREIGN KEY (`prior_run_payroll_run_id`) REFERENCES `grocery_ecm`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ADD CONSTRAINT `fk_workforce_workforce_benefit_enrollment_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ADD CONSTRAINT `fk_workforce_workforce_benefit_enrollment_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `grocery_ecm`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ADD CONSTRAINT `fk_workforce_workforce_benefit_enrollment_open_enrollment_period_id` FOREIGN KEY (`open_enrollment_period_id`) REFERENCES `grocery_ecm`.`workforce`.`open_enrollment_period`(`open_enrollment_period_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_leave_plan_id` FOREIGN KEY (`leave_plan_id`) REFERENCES `grocery_ecm`.`workforce`.`leave_plan`(`leave_plan_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_position_id` FOREIGN KEY (`position_id`) REFERENCES `grocery_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_tertiary_leave_hr_business_partner_associate_id` FOREIGN KEY (`tertiary_leave_hr_business_partner_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `grocery_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_certification_type_id` FOREIGN KEY (`certification_type_id`) REFERENCES `grocery_ecm`.`workforce`.`certification_type`(`certification_type_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_position_id` FOREIGN KEY (`position_id`) REFERENCES `grocery_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_quaternary_performance_second_level_manager_associate_id` FOREIGN KEY (`quaternary_performance_second_level_manager_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_tertiary_performance_hr_business_partner_associate_id` FOREIGN KEY (`tertiary_performance_hr_business_partner_associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ADD CONSTRAINT `fk_workforce_labor_budget_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ADD CONSTRAINT `fk_workforce_union_contract_primary_successor_contract_union_contract_id` FOREIGN KEY (`primary_successor_contract_union_contract_id`) REFERENCES `grocery_ecm`.`workforce`.`union_contract`(`union_contract_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ADD CONSTRAINT `fk_workforce_talent_acquisition_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ADD CONSTRAINT `fk_workforce_talent_acquisition_candidate_id` FOREIGN KEY (`candidate_id`) REFERENCES `grocery_ecm`.`workforce`.`candidate`(`candidate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ADD CONSTRAINT `fk_workforce_talent_acquisition_position_id` FOREIGN KEY (`position_id`) REFERENCES `grocery_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ADD CONSTRAINT `fk_workforce_talent_acquisition_reposted_from_talent_acquisition_id` FOREIGN KEY (`reposted_from_talent_acquisition_id`) REFERENCES `grocery_ecm`.`workforce`.`talent_acquisition`(`talent_acquisition_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ADD CONSTRAINT `fk_workforce_associate_availability_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ADD CONSTRAINT `fk_workforce_associate_availability_superseded_associate_availability_id` FOREIGN KEY (`superseded_associate_availability_id`) REFERENCES `grocery_ecm`.`workforce`.`associate_availability`(`associate_availability_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`certification_type` ADD CONSTRAINT `fk_workforce_certification_type_parent_certification_type_id` FOREIGN KEY (`parent_certification_type_id`) REFERENCES `grocery_ecm`.`workforce`.`certification_type`(`certification_type_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`leave_plan` ADD CONSTRAINT `fk_workforce_leave_plan_superseded_leave_plan_id` FOREIGN KEY (`superseded_leave_plan_id`) REFERENCES `grocery_ecm`.`workforce`.`leave_plan`(`leave_plan_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`pay_group` ADD CONSTRAINT `fk_workforce_pay_group_parent_pay_group_id` FOREIGN KEY (`parent_pay_group_id`) REFERENCES `grocery_ecm`.`workforce`.`pay_group`(`pay_group_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`pay_calendar` ADD CONSTRAINT `fk_workforce_pay_calendar_prior_pay_calendar_id` FOREIGN KEY (`prior_pay_calendar_id`) REFERENCES `grocery_ecm`.`workforce`.`pay_calendar`(`pay_calendar_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_associate_id` FOREIGN KEY (`associate_id`) REFERENCES `grocery_ecm`.`workforce`.`associate`(`associate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_referred_by_candidate_id` FOREIGN KEY (`referred_by_candidate_id`) REFERENCES `grocery_ecm`.`workforce`.`candidate`(`candidate_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`benefit_plan` ADD CONSTRAINT `fk_workforce_benefit_plan_superseded_benefit_plan_id` FOREIGN KEY (`superseded_benefit_plan_id`) REFERENCES `grocery_ecm`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `grocery_ecm`.`workforce`.`open_enrollment_period` ADD CONSTRAINT `fk_workforce_open_enrollment_period_prior_open_enrollment_period_id` FOREIGN KEY (`prior_open_enrollment_period_id`) REFERENCES `grocery_ecm`.`workforce`.`open_enrollment_period`(`open_enrollment_period_id`);

-- ========= TAGS =========
ALTER SCHEMA `grocery_ecm`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `grocery_ecm`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Associate ID');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `manager_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Associate ID');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location ID');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `compensation_band` SET TAGS ('dbx_business_glossary_term' = 'Compensation Band');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `compensation_band` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Associate Date of Birth');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `disability_status` SET TAGS ('dbx_value_regex' = 'yes|no|prefer_not_to_say');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `disability_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `eeo_category` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Category');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `eeo_category` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `employee_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Number');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|terminated|suspended|retired');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Ethnicity');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `ethnicity` SET TAGS ('dbx_value_regex' = 'hispanic_latino|white|black_african_american|asian|native_hawaiian_pacific_islander|american_indian_alaska_native');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Associate First Name');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `is_rehire_eligible` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligibility Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `last_disciplinary_action_date` SET TAGS ('dbx_business_glossary_term' = 'Last Disciplinary Action Date');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `last_disciplinary_action_type` SET TAGS ('dbx_business_glossary_term' = 'Last Disciplinary Action Type');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `last_disciplinary_action_type` SET TAGS ('dbx_value_regex' = 'verbal_warning|written_warning|suspension|final_warning');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Associate Last Name');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Associate Mobile Phone Number');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `national_id_last4` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number Last 4 Digits');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `national_id_last4` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `national_id_last4` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `national_id_last4` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `pay_rate_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate Effective Date');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `pay_type` SET TAGS ('dbx_business_glossary_term' = 'Pay Type');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `pay_type` SET TAGS ('dbx_value_regex' = 'hourly|salary|commission');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `personal_email` SET TAGS ('dbx_business_glossary_term' = 'Associate Personal Email Address');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `personal_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `personal_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `personal_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Associate Preferred Name');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `rehire_date` SET TAGS ('dbx_business_glossary_term' = 'Rehire Date');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'voluntary|involuntary|retirement|layoff|job_abandonment');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `union_member` SET TAGS ('dbx_business_glossary_term' = 'Union Member Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `veteran_status` SET TAGS ('dbx_business_glossary_term' = 'Veteran Status');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `veteran_status` SET TAGS ('dbx_value_regex' = 'protected_veteran|not_protected_veteran|prefer_not_to_say');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `veteran_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `work_email` SET TAGS ('dbx_business_glossary_term' = 'Associate Work Email Address');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `work_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `work_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `work_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `workday_worker_code` SET TAGS ('dbx_business_glossary_term' = 'Workday Worker ID');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `worker_type` SET TAGS ('dbx_business_glossary_term' = 'Worker Type');
ALTER TABLE `grocery_ecm`.`workforce`.`associate` ALTER COLUMN `worker_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|seasonal|temporary|contractor');
ALTER TABLE `grocery_ecm`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `supervisor_position_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Position ID');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `bargaining_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Bargaining Unit Code');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `budgeted_headcount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Headcount');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `career_ladder_next_position_code` SET TAGS ('dbx_business_glossary_term' = 'Career Ladder Next Position Code');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `competency_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Competency Profile Code');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt|exempt_highly_compensated');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `headcount_plan_year` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Year');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `is_food_handler` SET TAGS ('dbx_business_glossary_term' = 'Food Handler Position Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `is_pharmacy_position` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Position Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `is_safety_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Safety-Sensitive Position Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^JC-[A-Z0-9]{3,10}$');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `last_filled_date` SET TAGS ('dbx_business_glossary_term' = 'Last Filled Date');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `management_level` SET TAGS ('dbx_business_glossary_term' = 'Management Level');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `min_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `min_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience Years');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'hourly|weekly|biweekly|semimonthly|monthly|annual');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^PG-[A-Z0-9]{1,5}$');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `pay_rate_max` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate Maximum');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `pay_rate_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `pay_rate_mid` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate Midpoint');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `pay_rate_mid` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `pay_rate_min` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate Minimum');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `pay_rate_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `physical_demands_level` SET TAGS ('dbx_business_glossary_term' = 'Physical Demands Level');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `physical_demands_level` SET TAGS ('dbx_value_regex' = 'sedentary|light|medium|heavy|very_heavy');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^POS-[A-Z0-9]{4,12}$');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'open|filled|frozen|eliminated|pending_approval');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'regular|temporary|seasonal|contract|intern');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `time_type` SET TAGS ('dbx_business_glossary_term' = 'Time Type');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `time_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `union_eligible` SET TAGS ('dbx_business_glossary_term' = 'Union Eligibility Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `vacancy_reason` SET TAGS ('dbx_business_glossary_term' = 'Vacancy Reason');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `vacancy_reason` SET TAGS ('dbx_value_regex' = 'new_position|resignation|termination|transfer|retirement|leave_of_absence');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `worker_type` SET TAGS ('dbx_business_glossary_term' = 'Worker Type');
ALTER TABLE `grocery_ecm`.`workforce`.`position` ALTER COLUMN `worker_type` SET TAGS ('dbx_value_regex' = 'employee|contingent_worker|intern|volunteer');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `competency_framework_code` SET TAGS ('dbx_business_glossary_term' = 'Competency Framework Code');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `critical_role` SET TAGS ('dbx_business_glossary_term' = 'Critical Role Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `eeoc_job_category` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity Commission (EEOC) Job Category');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt|highly_compensated_exempt');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `full_time_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE)');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `inactive_date` SET TAGS ('dbx_business_glossary_term' = 'Inactive Date');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_category` SET TAGS ('dbx_business_glossary_term' = 'Job Category');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_category` SET TAGS ('dbx_value_regex' = 'hourly|salaried|contract|seasonal');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_family_group` SET TAGS ('dbx_business_glossary_term' = 'Job Family Group');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Code');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `management_level` SET TAGS ('dbx_business_glossary_term' = 'Management Level');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `management_level` SET TAGS ('dbx_value_regex' = 'individual_contributor|team_lead|manager|senior_manager|director|executive');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `osha_job_hazard_level` SET TAGS ('dbx_business_glossary_term' = 'OSHA Job Hazard Level');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `osha_job_hazard_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,3}[0-9]{1,3}$');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_rate_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Pay Rate');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_rate_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_rate_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Pay Rate');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_rate_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate Type');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_rate_type` SET TAGS ('dbx_value_regex' = 'hourly|annual|daily');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Status');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|pending_approval|retired');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `public_sector_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'Public Sector Reporting Code (SOC Code)');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `requires_alcohol_cert` SET TAGS ('dbx_business_glossary_term' = 'Alcohol Sales Certification Required Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `requires_background_check` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `requires_drug_test` SET TAGS ('dbx_business_glossary_term' = 'Drug Test Required Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `requires_food_handler_cert` SET TAGS ('dbx_business_glossary_term' = 'Food Handler Certification Required Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `requires_forklift_cert` SET TAGS ('dbx_business_glossary_term' = 'Forklift Certification Required Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `requires_pharmacy_license` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy License Required Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'workday|kronos|sap_hcm|manual');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `standard_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Standard Hours Per Week');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `summary` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Summary');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `union_eligible` SET TAGS ('dbx_business_glossary_term' = 'Union Eligibility Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `work_shift_type` SET TAGS ('dbx_business_glossary_term' = 'Work Shift Type');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `work_shift_type` SET TAGS ('dbx_value_regex' = 'day|evening|overnight|rotating|flexible');
ALTER TABLE `grocery_ecm`.`workforce`.`job_profile` ALTER COLUMN `workday_job_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Workday Job Profile ID');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `district_code` SET TAGS ('dbx_business_glossary_term' = 'District Code');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `headcount_budget` SET TAGS ('dbx_business_glossary_term' = 'Headcount Budget');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Organizational Hierarchy Level');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Organizational Hierarchy Path');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `is_food_safety_unit` SET TAGS ('dbx_business_glossary_term' = 'Is Food Safety Unit Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `is_fuel_center_unit` SET TAGS ('dbx_business_glossary_term' = 'Is Fuel Center Unit Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `is_pharmacy_unit` SET TAGS ('dbx_business_glossary_term' = 'Is Pharmacy Unit Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `kronos_org_code` SET TAGS ('dbx_business_glossary_term' = 'Kronos Workforce Central Organizational ID');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `labor_agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Labor Agreement Type');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `labor_agreement_type` SET TAGS ('dbx_value_regex' = 'union|non_union|management|contractor');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `labor_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Amount');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `labor_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `max_headcount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Headcount');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours End Time');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Start Time');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Description');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|dissolved|on_hold');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `osha_establishment_number` SET TAGS ('dbx_business_glossary_term' = 'OSHA Establishment ID');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `planogram_zone` SET TAGS ('dbx_business_glossary_term' = 'Planogram Zone');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `sap_org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Organizational Unit Code');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `standard_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Standard Hours Per Week');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_subtype` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Subtype');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_value_regex' = 'store_department|dc_functional_area|corporate_division|cost_center|region|district');
ALTER TABLE `grocery_ecm`.`workforce`.`org_unit` ALTER COLUMN `workday_org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Workday Organizational Unit Code');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` SET TAGS ('dbx_subdomain' = 'labor_scheduling');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `shift_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `shift_original_employee_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Original Employee ID');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `acknowledgement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `advance_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Notice Days');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'no_show|voluntary|manager_cancelled|low_volume|weather|other');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `employee_acknowledgement` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `is_holiday` SET TAGS ('dbx_business_glossary_term' = 'Is Holiday Shift Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `is_on_call` SET TAGS ('dbx_business_glossary_term' = 'Is On-Call Shift Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `is_open_shift` SET TAGS ('dbx_business_glossary_term' = 'Is Open Shift Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `is_overtime` SET TAGS ('dbx_business_glossary_term' = 'Is Overtime Shift Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `kronos_shift_code` SET TAGS ('dbx_business_glossary_term' = 'Kronos Shift ID');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `label` SET TAGS ('dbx_business_glossary_term' = 'Shift Label');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `labor_category` SET TAGS ('dbx_business_glossary_term' = 'Labor Category');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `labor_category` SET TAGS ('dbx_value_regex' = 'regular|overtime|holiday|on_call|training');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'store|dc|pharmacy|fuel_center|corporate');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `meal_break_minutes` SET TAGS ('dbx_business_glossary_term' = 'Meal Break Minutes');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `minimum_rest_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Rest Hours');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `pay_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Rule Code');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `rest_break_minutes` SET TAGS ('dbx_business_glossary_term' = 'Rest Break Minutes');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `schedule_week_start_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Week Start Date');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Hours');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'open|mid|close|overnight|split');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'kronos|workday|manual');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `swap_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Swap Status');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `swap_status` SET TAGS ('dbx_value_regex' = 'none|requested|approved|denied');
ALTER TABLE `grocery_ecm`.`workforce`.`shift` ALTER COLUMN `workload_budget_hours` SET TAGS ('dbx_business_glossary_term' = 'Workload Budget Hours');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` SET TAGS ('dbx_subdomain' = 'labor_scheduling');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule ID');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Owner Manager Employee ID');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `schedule_employee_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `schedule_replacement_employee_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Employee ID');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Approved Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `auto_scheduled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Scheduled Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `break_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Minutes');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `call_off_flag` SET TAGS ('dbx_business_glossary_term' = 'Call-Off Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `coverage_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Coverage Target Percentage');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Created Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `kronos_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Kronos Schedule ID');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `labor_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Amount');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `labor_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `labor_budget_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Hours');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `locked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Locked Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `minor_work_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Minor Work Restriction Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `overtime_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `paid_break_minutes` SET TAGS ('dbx_business_glossary_term' = 'Paid Break Minutes');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Period End Date');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Period Start Date');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Period Type');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'weekly|bi_weekly');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `predictive_scheduling_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Predictive Scheduling Advance Notice Days');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `premium_pay_flag` SET TAGS ('dbx_business_glossary_term' = 'Premium Pay Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Published Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `schedule_source` SET TAGS ('dbx_business_glossary_term' = 'Schedule Source');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `schedule_source` SET TAGS ('dbx_value_regex' = 'kronos_auto|manager_manual|self_service|imported');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|published|approved|locked|cancelled');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `scheduled_headcount` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Headcount');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `scheduled_shift_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Shift Hours');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `total_scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Scheduled Hours');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `union_seniority_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Seniority Applied Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`schedule` ALTER COLUMN `workday_pay_period_code` SET TAGS ('dbx_business_glossary_term' = 'Workday Pay Period ID');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` SET TAGS ('dbx_subdomain' = 'labor_scheduling');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Time Entry ID');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `associate_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `associate_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule ID');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `actual_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Worked');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'unapproved|approved|rejected');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration (Minutes)');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `double_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Double Time Hours');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `edit_reason` SET TAGS ('dbx_business_glossary_term' = 'Edit Reason');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Status');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|locked|voided');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `is_early_punch_in` SET TAGS ('dbx_business_glossary_term' = 'Early Punch-In Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `is_early_punch_out` SET TAGS ('dbx_business_glossary_term' = 'Early Punch-Out Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `is_late_punch_in` SET TAGS ('dbx_business_glossary_term' = 'Late Punch-In Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `is_late_punch_out` SET TAGS ('dbx_business_glossary_term' = 'Late Punch-Out Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `is_manual_edit` SET TAGS ('dbx_business_glossary_term' = 'Manual Edit Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `is_missed_punch` SET TAGS ('dbx_business_glossary_term' = 'Missed Punch Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `kronos_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Kronos Entry Number');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `labor_category` SET TAGS ('dbx_business_glossary_term' = 'Labor Category');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `labor_category` SET TAGS ('dbx_value_regex' = 'store_associate|pharmacist|dc_worker|corporate|fuel_center|management');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `meal_period_minutes` SET TAGS ('dbx_business_glossary_term' = 'Meal Period Duration (Minutes)');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `meal_period_violation` SET TAGS ('dbx_business_glossary_term' = 'Meal Period Violation Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `meal_period_waived` SET TAGS ('dbx_business_glossary_term' = 'Meal Period Waived Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `pay_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Code');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `pay_period_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Period ID');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `payroll_export_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Export Status');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `payroll_export_status` SET TAGS ('dbx_value_regex' = 'not_exported|exported|error');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `payroll_export_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payroll Export Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `punch_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Punch-In Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `punch_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Punch-Out Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `punch_source` SET TAGS ('dbx_business_glossary_term' = 'Punch Source');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `punch_source` SET TAGS ('dbx_value_regex' = 'time_clock|mobile|web|manual|biometric|badge');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `rest_break_violation` SET TAGS ('dbx_business_glossary_term' = 'Rest Break Violation Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Hours');
ALTER TABLE `grocery_ecm`.`workforce`.`time_entry` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `pay_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Pay Calendar ID');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `pay_group_id` SET TAGS ('dbx_business_glossary_term' = 'Pay Group ID');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Processed By User ID');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `prior_run_payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Payroll Run ID');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payroll Approval Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `associate_count` SET TAGS ('dbx_business_glossary_term' = 'Associate Count Processed');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `check_date` SET TAGS ('dbx_business_glossary_term' = 'Payroll Check Date');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `direct_deposit_file_reference` SET TAGS ('dbx_business_glossary_term' = 'Direct Deposit ACH File ID');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `gl_document_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Document Number');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `is_final` SET TAGS ('dbx_business_glossary_term' = 'Final Payroll Run Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `is_off_cycle` SET TAGS ('dbx_business_glossary_term' = 'Off-Cycle Payroll Run Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|bi_weekly|semi_monthly|monthly');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `processing_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processing Completion Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `processing_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processing Start Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Number');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Status');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|cancelled|on_hold');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Type');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'regular|off_cycle|correction|supplemental|bonus');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Payroll Tax Year');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_check_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Physical Check Amount');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_check_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Deductions');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_deductions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_direct_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Direct Deposit Amount');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_direct_deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_employer_taxes` SET TAGS ('dbx_business_glossary_term' = 'Total Employer Taxes');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_employer_taxes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_garnishment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Garnishment Amount');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_garnishment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Pay');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Net Pay');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_posttax_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Post-Tax Deductions');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_posttax_deductions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_pretax_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Pre-Tax Deductions');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_pretax_deductions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_tax_withholdings` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Withholdings');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_tax_withholdings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `workday_run_code` SET TAGS ('dbx_business_glossary_term' = 'Workday HCM Payroll Run ID');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `ytd_gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Gross Pay');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `ytd_gross_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `ytd_tax_withholdings` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Tax Withholdings');
ALTER TABLE `grocery_ecm`.`workforce`.`payroll_run` ALTER COLUMN `ytd_tax_withholdings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `workforce_benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Benefit Enrollment ID');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period ID');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `aca_affordability_safe_harbor` SET TAGS ('dbx_business_glossary_term' = 'Affordable Care Act (ACA) Affordability Safe Harbor Method');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `aca_affordability_safe_harbor` SET TAGS ('dbx_value_regex' = 'W2|rate_of_pay|federal_poverty_line|none');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `aca_coverage_indicator` SET TAGS ('dbx_business_glossary_term' = 'Affordable Care Act (ACA) Coverage Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `aca_minimum_value_indicator` SET TAGS ('dbx_business_glossary_term' = 'Affordable Care Act (ACA) Minimum Value Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `aca_offer_of_coverage_code` SET TAGS ('dbx_business_glossary_term' = 'Affordable Care Act (ACA) Offer of Coverage Code');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `aca_offer_of_coverage_code` SET TAGS ('dbx_value_regex' = '1A|1B|1C|1D|1E|1F');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `aca_safe_harbor_code` SET TAGS ('dbx_business_glossary_term' = 'Affordable Care Act (ACA) Safe Harbor Code');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `aca_safe_harbor_code` SET TAGS ('dbx_value_regex' = '2A|2B|2C|2D|2E|2F');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `annual_employee_contribution` SET TAGS ('dbx_business_glossary_term' = 'Annual Employee Contribution Amount');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `annual_employee_contribution` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `annual_employer_contribution` SET TAGS ('dbx_business_glossary_term' = 'Annual Employer Contribution Amount');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `annual_employer_contribution` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `carrier_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Confirmation Number');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `carrier_enrollment_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Enrollment Sent Date');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `cobra_election_date` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Election Date');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `cobra_eligible_indicator` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Eligible Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|family');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Dependent Count');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `disability_benefit_type` SET TAGS ('dbx_business_glossary_term' = 'Disability Benefit Type');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `disability_benefit_type` SET TAGS ('dbx_value_regex' = 'short_term|long_term');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `disability_benefit_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `disability_benefit_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Date');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `employer_match_rate` SET TAGS ('dbx_business_glossary_term' = 'Employer 401(k) Match Rate');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `employer_match_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `enrollment_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Confirmation Date');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_value_regex' = '^ENR-[0-9]{10}$');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'open_enrollment|qualifying_life_event|new_hire|rehire|court_order');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|terminated|pending|waived|suspended');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `fsa_annual_election_amount` SET TAGS ('dbx_business_glossary_term' = 'Flexible Spending Account (FSA) Annual Election Amount');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `fsa_annual_election_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `hsa_annual_election_amount` SET TAGS ('dbx_business_glossary_term' = 'Health Savings Account (HSA) Annual Election Amount');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `hsa_annual_election_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `life_insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Life Insurance Coverage Amount');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `life_insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `payroll_deduction_code` SET TAGS ('dbx_business_glossary_term' = 'Payroll Deduction Code');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Name');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Type');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Year');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `pre_tax_indicator` SET TAGS ('dbx_business_glossary_term' = 'Pre-Tax Deduction Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `qualifying_life_event_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event (QLE) Type');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `retirement_contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Retirement Plan Contribution Rate');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `retirement_contribution_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Termination Date');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Coverage Waiver Reason');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_value_regex' = 'covered_by_spouse|covered_by_parent|covered_by_other_employer|medicare|medicaid|other');
ALTER TABLE `grocery_ecm`.`workforce`.`workforce_benefit_enrollment` ALTER COLUMN `workday_enrollment_event_code` SET TAGS ('dbx_business_glossary_term' = 'Workday Enrollment Event ID');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request ID');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Plan ID');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `tertiary_leave_hr_business_partner_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Business Partner ID');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `ada_accommodation` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Accommodation Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Approval Date');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `approved_hours` SET TAGS ('dbx_business_glossary_term' = 'Approved Leave Hours');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `benefits_continuation` SET TAGS ('dbx_business_glossary_term' = 'Benefits Continuation Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Leave Denial Reason');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `fmla_designation_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Designation Notice Date');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `fmla_eligible` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Eligible Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `fmla_hours_remaining` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Hours Remaining');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `fmla_hours_used` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Hours Used');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `fmla_qualifying` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Qualifying Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `fmla_rights_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Rights Notice Date');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `intermittent_leave` SET TAGS ('dbx_business_glossary_term' = 'Intermittent Leave Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `kronos_schedule_adjusted` SET TAGS ('dbx_business_glossary_term' = 'Kronos Schedule Adjusted Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_balance_hours_used` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance Hours Used');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_end_date` SET TAGS ('dbx_business_glossary_term' = 'Leave End Date');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_reason` SET TAGS ('dbx_business_glossary_term' = 'Leave Reason');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_start_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Start Date');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Date');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Received Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Required Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `military_leave_type` SET TAGS ('dbx_business_glossary_term' = 'Military Leave Type');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `military_leave_type` SET TAGS ('dbx_value_regex' = 'active_duty|training|funeral_honors|none');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `osha_recordable` SET TAGS ('dbx_business_glossary_term' = 'OSHA Recordable Incident Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `paid_leave` SET TAGS ('dbx_business_glossary_term' = 'Paid Leave Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `pay_continuation_type` SET TAGS ('dbx_business_glossary_term' = 'Pay Continuation Type');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `pay_continuation_type` SET TAGS ('dbx_value_regex' = 'full_pay|partial_pay|unpaid|pto_substitution|short_term_disability');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Date');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Status');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|cancelled|withdrawn');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `requested_hours` SET TAGS ('dbx_business_glossary_term' = 'Requested Leave Hours');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Workday|Kronos|manual');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `workday_leave_request_number` SET TAGS ('dbx_business_glossary_term' = 'Workday Leave Request Number');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `workday_worker_code` SET TAGS ('dbx_business_glossary_term' = 'Workday Worker ID');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `workday_worker_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `workday_worker_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `workers_comp_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Claim Number');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_request` ALTER COLUMN `workers_comp_claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` SET TAGS ('dbx_subdomain' = 'labor_scheduling');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident ID');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `associate_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `associate_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `body_part_affected` SET TAGS ('dbx_business_glossary_term' = 'Body Part Affected');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Claim Status');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'not_filed|open|closed|denied|appealed|settled');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Claim Type');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'medical_only|lost_time|no_claim');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `corrective_action_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completed Date');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `days_away_from_work` SET TAGS ('dbx_business_glossary_term' = 'Days Away From Work');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `days_restricted_duty` SET TAGS ('dbx_business_glossary_term' = 'Days on Restricted Duty');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `emergency_services_called` SET TAGS ('dbx_business_glossary_term' = 'Emergency Services Called Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^INC-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|closed|pending_review|appealed');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Date and Time');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `indemnity_cost` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Cost');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `indemnity_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `injury_severity` SET TAGS ('dbx_business_glossary_term' = 'Injury Severity Level');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `injury_severity` SET TAGS ('dbx_value_regex' = 'first_aid_only|medical_treatment|restricted_duty|days_away|hospitalization|fatality');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `injury_type` SET TAGS ('dbx_business_glossary_term' = 'Injury or Illness Type');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `insurance_carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Carrier Name');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `is_near_miss` SET TAGS ('dbx_business_glossary_term' = 'Near Miss Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `is_osha_recordable` SET TAGS ('dbx_business_glossary_term' = 'OSHA Recordable Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title at Time of Incident');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'store|distribution_center|pharmacy|fuel_center|corporate_office');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `medical_cost` SET TAGS ('dbx_business_glossary_term' = 'Medical Cost');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `medical_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `medical_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Medical Provider Name');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `medical_provider_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `medical_provider_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `osha_300_log_entry_date` SET TAGS ('dbx_business_glossary_term' = 'OSHA 300 Log Entry Date');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `osha_301_form_completed` SET TAGS ('dbx_business_glossary_term' = 'OSHA 301 Incident Report Completed Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Reported Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `return_to_work_type` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Type');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `return_to_work_type` SET TAGS ('dbx_value_regex' = 'full_duty|modified_duty|restricted_duty|not_returned');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|evening|overnight|split');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `tenure_days_at_incident` SET TAGS ('dbx_business_glossary_term' = 'Associate Tenure Days at Incident');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `total_incurred_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Incurred Cost');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `total_incurred_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `witness_names` SET TAGS ('dbx_business_glossary_term' = 'Witness Names');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `witness_names` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `workers_comp_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Claim Number');
ALTER TABLE `grocery_ecm`.`workforce`.`safety_incident` ALTER COLUMN `workers_comp_claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification ID');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `certification_type_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Type ID');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Attempt Number');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `certification_category` SET TAGS ('dbx_business_glossary_term' = 'Certification Category');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `certification_category` SET TAGS ('dbx_value_regex' = 'license|compliance_training|food_safety|safety_operations|professional_certification');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Credit Hours');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'DEA (Drug Enforcement Administration) Controlled Substance Schedule');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'CI|CII|CIII|CIV|CV');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'in_person|lms|on_the_job|virtual_instructor_led|external_provider');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `governing_regulation` SET TAGS ('dbx_business_glossary_term' = 'Governing Regulation');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `issuing_country` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `issuing_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `issuing_state` SET TAGS ('dbx_business_glossary_term' = 'Issuing State');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `issuing_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `passed` SET TAGS ('dbx_business_glossary_term' = 'Passed Indicator');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `passing_score` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `reminder_days_before_expiry` SET TAGS ('dbx_business_glossary_term' = 'Reminder Days Before Expiry');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `renewal_reminder_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Reminder Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `role_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Role Requirement Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'workday|kronos|mckesson|manual|external');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `verification_source` SET TAGS ('dbx_business_glossary_term' = 'Verification Source');
ALTER TABLE `grocery_ecm`.`workforce`.`certification` ALTER COLUMN `verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Verification Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `quaternary_performance_second_level_manager_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Second-Level Manager ID');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `tertiary_performance_hr_business_partner_associate_id` SET TAGS ('dbx_business_glossary_term' = 'HR Business Partner ID');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Associate Acknowledgement Date');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `associate_acknowledged` SET TAGS ('dbx_business_glossary_term' = 'Associate Acknowledgement Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibrated_rating` SET TAGS ('dbx_business_glossary_term' = 'Calibrated Overall Rating');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibrated_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|overridden');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_rating` SET TAGS ('dbx_business_glossary_term' = 'Competency Rating');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Competency Rating Score');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `development_plan_comments` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Comments');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `development_plan_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|seasonal|temporary');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `flight_risk` SET TAGS ('dbx_business_glossary_term' = 'Flight Risk Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `flight_risk` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `goal_rating` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Rating');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `goal_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `goal_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Rating Score');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `job_classification` SET TAGS ('dbx_business_glossary_term' = 'Job Classification');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `manager_comments` SET TAGS ('dbx_business_glossary_term' = 'Manager Performance Comments');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `manager_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_pct` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Percentage');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_recommended` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Recommended Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating Score');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `pip_required` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Required Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `promotion_recommended` SET TAGS ('dbx_business_glossary_term' = 'Promotion Recommended Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `promotion_target_position` SET TAGS ('dbx_business_glossary_term' = 'Promotion Target Position');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_cycle_year` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Year');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Number');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_number` SET TAGS ('dbx_value_regex' = '^PR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Status');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|pending_approval|calibrated|completed|cancelled');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_template_name` SET TAGS ('dbx_business_glossary_term' = 'Review Template Name');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Type');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|mid_year|90_day|probationary|pip');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `self_assessment_comments` SET TAGS ('dbx_business_glossary_term' = 'Associate Self-Assessment Comments');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `self_assessment_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `talent_segment` SET TAGS ('dbx_business_glossary_term' = 'Talent Segment');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `talent_segment` SET TAGS ('dbx_value_regex' = 'high_potential|key_contributor|solid_performer|developing|at_risk');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `talent_segment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`performance_review` ALTER COLUMN `tenure_at_review_months` SET TAGS ('dbx_business_glossary_term' = 'Tenure at Review (Months)');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` SET TAGS ('dbx_subdomain' = 'labor_scheduling');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `labor_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget ID');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Pay Period ID');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Status');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|superseded');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Approved Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `average_wage_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Wage Rate');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `average_wage_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `benefits_load_percent` SET TAGS ('dbx_business_glossary_term' = 'Benefits Load Percentage');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `benefits_load_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budget_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget End Date');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budget_notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Number');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budget_period_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Type');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budget_period_type` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|annual');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budget_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Start Date');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budget_version_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Type');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budget_version_type` SET TAGS ('dbx_value_regex' = 'original|revised|forecast|reforecast');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budgeted_fte_count` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Full-Time Equivalent (FTE) Count');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budgeted_headcount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Headcount');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budgeted_hours_friday` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Labor Hours Friday');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budgeted_hours_monday` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Labor Hours Monday');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budgeted_hours_saturday` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Labor Hours Saturday');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budgeted_hours_sunday` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Labor Hours Sunday');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budgeted_hours_thursday` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Labor Hours Thursday');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budgeted_hours_total` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Labor Hours Total');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budgeted_hours_tuesday` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Labor Hours Tuesday');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budgeted_hours_wednesday` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Labor Hours Wednesday');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budgeted_labor_dollars` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Labor Dollars');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budgeted_labor_dollars` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budgeted_overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Overtime Hours');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budgeted_regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Regular Hours');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `comp_sales_assumption` SET TAGS ('dbx_business_glossary_term' = 'Comparable Store Sales (Comp Sales) Assumption');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `comp_sales_assumption` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `fiscal_week` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Week Number');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `gmroi_labor_target` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Return on Investment (GMROI) Labor Target');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `gmroi_labor_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `is_current_version` SET TAGS ('dbx_business_glossary_term' = 'Is Current Version Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `kronos_schedule_group_code` SET TAGS ('dbx_business_glossary_term' = 'Kronos Schedule Group Code');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `labor_cost_percent_target` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Percentage Target');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `labor_cost_percent_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `sales_per_labor_hour_target` SET TAGS ('dbx_business_glossary_term' = 'Sales Per Labor Hour (SPLH) Target');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `sales_per_labor_hour_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `grocery_ecm`.`workforce`.`labor_budget` ALTER COLUMN `workday_budget_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Workday HCM Budget Reference ID');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `union_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Union Contract ID');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `primary_successor_contract_union_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Successor Contract ID');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `arbitration_provider` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Provider');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `bargaining_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Bargaining Unit Description');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `bargaining_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Bargaining Unit Type');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `bargaining_unit_type` SET TAGS ('dbx_value_regex' = 'store|distribution_center|pharmacy|corporate|fuel_center');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `base_wage_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Wage Rate');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `base_wage_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `cba_number` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Number');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `cba_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,30}$');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending_ratification|under_negotiation|terminated');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `contract_title` SET TAGS ('dbx_business_glossary_term' = 'Contract Title');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `covered_job_classifications` SET TAGS ('dbx_business_glossary_term' = 'Covered Job Classifications');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `dues_checkoff_authorized` SET TAGS ('dbx_business_glossary_term' = 'Dues Checkoff Authorized');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `excluded_job_classifications` SET TAGS ('dbx_business_glossary_term' = 'Excluded Job Classifications');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `grievance_procedure_reference` SET TAGS ('dbx_business_glossary_term' = 'Grievance Procedure Reference');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `health_benefit_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Health Benefit Plan Description');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `health_benefit_plan_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `health_benefit_plan_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `kronos_labor_rule_group` SET TAGS ('dbx_business_glossary_term' = 'Kronos Labor Rule Group');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `management_rights_clause` SET TAGS ('dbx_business_glossary_term' = 'Management Rights Clause');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `maximum_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Maximum Hours Per Week');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `minimum_hours_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Minimum Hours Guarantee');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `negotiation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Start Date');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `no_strike_clause` SET TAGS ('dbx_business_glossary_term' = 'No-Strike Clause');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `overtime_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Overtime Rule Description');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `paid_time_off_provisions` SET TAGS ('dbx_business_glossary_term' = 'Paid Time Off (PTO) Provisions');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `pension_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Pension Plan Description');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `ratification_date` SET TAGS ('dbx_business_glossary_term' = 'Ratification Date');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `reopener_clause` SET TAGS ('dbx_business_glossary_term' = 'Reopener Clause');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `reopener_trigger_date` SET TAGS ('dbx_business_glossary_term' = 'Reopener Trigger Date');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `rest_period_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rest Period Rule Description');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `seniority_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Seniority Rule Description');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `shift_differential_description` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Description');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `shift_differential_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `top_of_scale_wage_rate` SET TAGS ('dbx_business_glossary_term' = 'Top-of-Scale Wage Rate');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `top_of_scale_wage_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `union_local_number` SET TAGS ('dbx_business_glossary_term' = 'Union Local Number');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `union_local_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `union_name` SET TAGS ('dbx_business_glossary_term' = 'Union Name');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `union_security_clause` SET TAGS ('dbx_business_glossary_term' = 'Union Security Clause');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `union_security_clause` SET TAGS ('dbx_value_regex' = 'union_shop|agency_shop|open_shop|maintenance_of_membership|none');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `wage_progression_steps` SET TAGS ('dbx_business_glossary_term' = 'Wage Progression Steps');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `wage_progression_steps` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `wage_progression_steps` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `wage_scale_description` SET TAGS ('dbx_business_glossary_term' = 'Wage Scale Description');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `wage_scale_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `workday_cba_code` SET TAGS ('dbx_business_glossary_term' = 'Workday Collective Bargaining Agreement (CBA) ID');
ALTER TABLE `grocery_ecm`.`workforce`.`union_contract` ALTER COLUMN `workday_cba_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-_]{1,50}$');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `talent_acquisition_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Acquisition ID');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager ID');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `reposted_from_talent_acquisition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `background_check_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completed Date');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|failed|exempt');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_certifications` SET TAGS ('dbx_business_glossary_term' = 'Candidate Certifications');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_disability_status` SET TAGS ('dbx_business_glossary_term' = 'Candidate Disability Status');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_disability_status` SET TAGS ('dbx_value_regex' = 'disabled|non_disabled|prefer_not_to_answer');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_education_level` SET TAGS ('dbx_business_glossary_term' = 'Candidate Education Level');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_email` SET TAGS ('dbx_business_glossary_term' = 'Candidate Email Address');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Candidate Ethnicity');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_ethnicity` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_gender` SET TAGS ('dbx_business_glossary_term' = 'Candidate Gender');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_answer');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate Full Name');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_phone` SET TAGS ('dbx_business_glossary_term' = 'Candidate Phone Number');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_source_channel` SET TAGS ('dbx_business_glossary_term' = 'Candidate Source Channel');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_source_channel` SET TAGS ('dbx_value_regex' = 'referral|career_site|job_board|social_media|recruiter|internal');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_veteran_status` SET TAGS ('dbx_business_glossary_term' = 'Candidate Veteran Status');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_veteran_status` SET TAGS ('dbx_value_regex' = 'veteran|non_veteran|prefer_not_to_answer');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `candidate_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Candidate Years of Experience');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `interview_stage` SET TAGS ('dbx_business_glossary_term' = 'Interview Stage');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `interview_stage` SET TAGS ('dbx_value_regex' = 'phone|onsite|virtual|final|offer');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `ofccp_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'OFCCP Reportable Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `offer_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Acceptance Date');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `offer_amount` SET TAGS ('dbx_business_glossary_term' = 'Offer Amount');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `offer_currency` SET TAGS ('dbx_business_glossary_term' = 'Offer Currency');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `offer_decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Offer Decline Reason');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `offer_status` SET TAGS ('dbx_value_regex' = 'extended|accepted|declined|withdrawn');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `requisition_age_days` SET TAGS ('dbx_business_glossary_term' = 'Requisition Age (Days)');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `requisition_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Approval Date');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `requisition_creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Requisition Creation Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_value_regex' = 'open|closed|cancelled|on_hold|filled|rejected');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `screening_status` SET TAGS ('dbx_business_glossary_term' = 'Screening Status');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `screening_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|withdrawn');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `grocery_ecm`.`workforce`.`talent_acquisition` ALTER COLUMN `time_to_fill_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (Days)');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` SET TAGS ('dbx_subdomain' = 'labor_scheduling');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `associate_availability_id` SET TAGS ('dbx_business_glossary_term' = 'Associate Availability ID');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Associate ID');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `superseded_associate_availability_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `cross_training_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Training Availability Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Day of Week');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'End Time');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `max_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Maximum Hours Per Week');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `minor_work_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Minor Work‑Hour Restriction Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `overtime_preference_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Preference Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `preferred_department_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Department Code');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `recurring_unavailability_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurring Unavailability Pattern');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `shift_preference` SET TAGS ('dbx_business_glossary_term' = 'Shift Preference');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `shift_preference` SET TAGS ('dbx_value_regex' = 'early|mid|late');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Start Time');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `unavailable_date` SET TAGS ('dbx_business_glossary_term' = 'Specific Unavailable Date');
ALTER TABLE `grocery_ecm`.`workforce`.`associate_availability` ALTER COLUMN `union_seniority_preference_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Seniority Preference Flag');
ALTER TABLE `grocery_ecm`.`workforce`.`certification_type` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`workforce`.`certification_type` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `grocery_ecm`.`workforce`.`certification_type` ALTER COLUMN `certification_type_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Type Identifier');
ALTER TABLE `grocery_ecm`.`workforce`.`certification_type` ALTER COLUMN `parent_certification_type_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_plan` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_plan` ALTER COLUMN `leave_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Plan Identifier');
ALTER TABLE `grocery_ecm`.`workforce`.`leave_plan` ALTER COLUMN `superseded_leave_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`pay_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`workforce`.`pay_group` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `grocery_ecm`.`workforce`.`pay_group` ALTER COLUMN `pay_group_id` SET TAGS ('dbx_business_glossary_term' = 'Pay Group Identifier');
ALTER TABLE `grocery_ecm`.`workforce`.`pay_group` ALTER COLUMN `parent_pay_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`pay_group` ALTER COLUMN `cost_center` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`pay_group` ALTER COLUMN `payroll_account_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`pay_group` ALTER COLUMN `payroll_account_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`pay_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`workforce`.`pay_calendar` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `grocery_ecm`.`workforce`.`pay_calendar` ALTER COLUMN `pay_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Pay Calendar Identifier');
ALTER TABLE `grocery_ecm`.`workforce`.`pay_calendar` ALTER COLUMN `prior_pay_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`candidate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`workforce`.`candidate` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `grocery_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate Identifier');
ALTER TABLE `grocery_ecm`.`workforce`.`candidate` ALTER COLUMN `referred_by_candidate_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`candidate` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`candidate` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`candidate` ALTER COLUMN `expected_salary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`candidate` ALTER COLUMN `expected_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`candidate` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`candidate` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`benefit_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`workforce`.`benefit_plan` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `grocery_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier');
ALTER TABLE `grocery_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `superseded_benefit_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `grocery_ecm`.`workforce`.`open_enrollment_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`workforce`.`open_enrollment_period` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `grocery_ecm`.`workforce`.`open_enrollment_period` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Identifier');
ALTER TABLE `grocery_ecm`.`workforce`.`open_enrollment_period` ALTER COLUMN `prior_open_enrollment_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
