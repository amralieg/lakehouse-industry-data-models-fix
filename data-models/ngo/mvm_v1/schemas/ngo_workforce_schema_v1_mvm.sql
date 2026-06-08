-- Schema for Domain: workforce | Business: Ngo | Version: v1_mvm
-- Generated on: 2026-05-07 03:36:32

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ngo_ecm`.`workforce` COMMENT 'SSOT for all staff and human resources data including employee records, payroll, benefits, talent acquisition, performance management, learning and development, and talent retention in Workday HCM. Covers national and international staff, expatriate management, field personnel, HRIS data, and RACI role assignments across programs.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ngo_ecm`.`workforce`.`staff_member` (
    `staff_member_id` BIGINT COMMENT 'Unique surrogate identifier for each staff member record in the Ngo workforce system. Primary key for the staff_member data product, serving as the anchor entity for all workforce transactions across HR sub-domains.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: staff_member is the core HR master record and currently stores job_title and job_grade as free-text strings. job_profile is the SSOT for standardized role definitions including job family, level, comp',
    `supervisor_staff_member_id` BIGINT COMMENT 'Reference to the staff_member_id of this staff members direct line manager. Enables organizational hierarchy traversal, RACI reporting, performance management workflows, and approval chain configuration in Workday HCM.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'The gross annual base salary of the staff member in the contract currency, as recorded in Workday HCM. Used for payroll processing, Budget versus Actual (BvA) reporting, and grant cost allocation under OMB Uniform Guidance 2 CFR 200.',
    `contract_end_date` DATE COMMENT 'The scheduled expiry date of the staff members current employment contract. Null for permanent/open-ended contracts. Used for contract renewal alerts, workforce planning, and grant-funded position management.',
    `contract_start_date` DATE COMMENT 'The effective start date of the staff members current employment contract. May differ from hire_date for staff on renewed or amended contracts. Used for contract lifecycle management and compliance tracking.',
    `contract_type` STRING COMMENT 'The legal nature of the employment arrangement. Determines statutory entitlements, benefits eligibility, payroll treatment, and compliance obligations under local labor law. [ENUM-REF-CANDIDATE: permanent|fixed_term|consultancy|secondment|internship|volunteer_staff — promote to reference product]. Valid values are `permanent|fixed_term|consultancy|secondment|internship|volunteer_staff`',
    `cost_center_code` STRING COMMENT 'The financial cost center code from the Chart of Accounts (CoA) to which the staff members salary and benefits are charged. Enables Budget versus Actual (BvA) reporting and grant fund accounting per OMB Uniform Guidance 2 CFR 200 cost allocation requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the staff member record was first created in the Ngo data platform, in ISO 8601 format with timezone offset (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for data governance and compliance purposes.',
    `date_of_birth` DATE COMMENT 'The staff members date of birth in ISO 8601 format (yyyy-MM-dd). Used for age verification, retirement planning, benefits eligibility, and visa/travel documentation.',
    `department` STRING COMMENT 'The organizational department or division to which the staff member is assigned (e.g., Programs, Finance, MEAL, Logistics, HR, Communications). Used for organizational reporting, budget allocation, and RACI assignments.',
    `duty_station` STRING COMMENT 'The official location where the staff member is assigned to work, typically expressed as a city and country (e.g., Nairobi, KEN; Kabul, AFG). Used for hardship allowance calculation, security risk management, and field operations coordination per OCHA duty station classifications.',
    `duty_station_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the staff members duty station country. Used for geographic workforce analytics, country-level headcount reporting, and compliance with host-country labor laws.. Valid values are `^[A-Z]{3}$`',
    `emergency_contact_name` STRING COMMENT 'The full name of the staff members designated next-of-kin or emergency contact person. Used for critical incident notification, medical emergencies, and death-in-service protocols in field operations.',
    `emergency_contact_phone` STRING COMMENT 'The telephone number of the staff members designated emergency contact in E.164 international format. Used for critical incident notification and next-of-kin communication in field operations.. Valid values are `^+?[1-9]d{1,14}$`',
    `emergency_contact_relationship` STRING COMMENT 'The relationship of the emergency contact to the staff member (e.g., spouse, parent, sibling). Used to contextualize next-of-kin notifications and legal next-of-kin determinations in death-in-service cases.. Valid values are `spouse|parent|sibling|child|friend|other`',
    `employee_number` STRING COMMENT 'The human-readable, organization-assigned employee identification number used in payroll, HR correspondence, and access control systems. Distinct from the surrogate staff_member_id.',
    `employment_status` STRING COMMENT 'Current lifecycle state of the staff members employment at Ngo. Drives access control, payroll processing, and workforce headcount reporting. active = currently employed and working; on_leave = approved absence; suspended = temporarily not working pending investigation; separated = employment ended; probation = within initial probationary period.. Valid values are `active|on_leave|suspended|separated|probation`',
    `employment_type` STRING COMMENT 'Classification of the staff member by geographic and operational deployment category. National staff are locally hired; international staff are deployed from another country; expatriates are on international assignment; field personnel are based in program delivery locations. Drives compensation bands, benefits packages, and NICRA cost allocation.. Valid values are `national_staff|international_staff|expatriate|field_personnel|headquarters`',
    `exit_interview_completed` BOOLEAN COMMENT 'Indicates whether the staff member completed an exit interview prior to or at separation. Used to track organizational learning compliance and ensure knowledge transfer processes are followed per CHS Core Humanitarian Standard accountability requirements.',
    `final_settlement_amount` DECIMAL(18,2) COMMENT 'The total monetary amount paid to the staff member as final settlement upon separation, including any outstanding salary, accrued leave payout, severance, and gratuity as applicable under local labor law and contract terms.',
    `fte_percentage` DECIMAL(18,2) COMMENT 'The proportion of full-time hours this staff member is contracted to work, expressed as a percentage (e.g., 100.00 for full-time, 50.00 for half-time). Used for headcount reporting, grant effort allocation, and Indirect Cost Rate (ICR/NICRA) calculations.',
    `gender` STRING COMMENT 'The staff members self-identified gender. Used for workforce diversity reporting, gender-disaggregated MEL indicators, and compliance with donor reporting requirements (e.g., USAID, DFID gender equity mandates).. Valid values are `male|female|non_binary|prefer_not_to_say`',
    `hire_date` DATE COMMENT 'The official date on which the staff member commenced employment with Ngo, as recorded in Workday HCM. Used for service length calculations, benefits vesting schedules, probation period tracking, and anniversary-based entitlements.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent update to the staff member record in the Ngo data platform, in ISO 8601 format with timezone offset (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture, data freshness monitoring, and audit compliance.',
    `legal_first_name` STRING COMMENT 'The staff members legal given name as it appears on official government-issued identification documents. Used for payroll, visa, and compliance documentation.',
    `legal_last_name` STRING COMMENT 'The staff members legal family/surname as it appears on official government-issued identification documents. Used for payroll, visa, and compliance documentation.',
    `nationality` STRING COMMENT 'The staff members nationality represented as an ISO 3166-1 alpha-3 country code (e.g., USA, GBR, KEN). Used for expatriate management, work permit tracking, and national vs. international staff classification.. Valid values are `^[A-Z]{3}$`',
    `passport_expiry_date` DATE COMMENT 'The expiry date of the staff members passport. Used to trigger renewal alerts and ensure compliance with international travel and visa requirements for field deployments.',
    `passport_number` STRING COMMENT 'The staff members passport number, required for international travel, visa applications, and expatriate deployment documentation. Stored securely in compliance with data protection regulations.',
    `pay_frequency` STRING COMMENT 'The frequency at which the staff member is paid (e.g., monthly, bi-weekly). Drives payroll cycle scheduling in Workday HCM and cash flow planning for field operations.. Valid values are `monthly|bi_weekly|weekly|semi_monthly`',
    `preferred_name` STRING COMMENT 'The name the staff member prefers to be addressed by in day-to-day operations, which may differ from their legal name. Used in internal communications, email display names, and staff directories.',
    `probation_end_date` DATE COMMENT 'The date on which the staff members probationary period is scheduled to end. Used to trigger performance review workflows and confirm or terminate employment within the probation window.',
    `rehire_eligible` BOOLEAN COMMENT 'Indicates whether the staff member is eligible for rehire at Ngo following separation. Set to false for staff separated due to gross misconduct, fraud, or serious policy violations. Used during talent acquisition screening.',
    `salary_currency` STRING COMMENT 'The ISO 4217 three-letter currency code in which the staff members base salary is denominated (e.g., USD, EUR, KES). Required for multi-currency payroll consolidation and grant financial reporting.. Valid values are `^[A-Z]{3}$`',
    `separation_date` DATE COMMENT 'The effective date on which the staff members employment with Ngo ended. Used for final payroll processing, benefits termination, access revocation, and workforce attrition reporting.',
    `separation_reason` STRING COMMENT 'A free-text narrative describing the specific reason for the staff members separation from Ngo. Complements the separation_type categorical field with contextual detail for HR records, exit documentation, and workforce analytics.',
    `separation_type` STRING COMMENT 'The category of employment separation event for staff members whose employment has ended. Drives final settlement calculations, rehire eligibility determination, and statutory reporting. Values: resignation (voluntary), end_of_contract (fixed-term expiry), redundancy (position eliminated), termination (involuntary dismissal), retirement (age/service-based), death_in_service.. Valid values are `resignation|end_of_contract|redundancy|termination|retirement|death_in_service`',
    `work_email` STRING COMMENT 'The official organizational email address assigned to the staff member. Primary digital contact channel for HR communications, system access provisioning, and donor/partner correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `work_permit_expiry_date` DATE COMMENT 'The expiry date of the staff members work permit or visa authorization. Used to trigger renewal workflows and ensure continuous legal authorization to work in the duty station country.',
    `work_permit_number` STRING COMMENT 'The work permit or visa authorization number for staff members who require legal authorization to work in their duty station country. Null for staff working in their country of nationality.',
    `work_phone` STRING COMMENT 'The staff members official work telephone number in E.164 international format. Used for operational communications, field coordination, and emergency contact protocols.. Valid values are `^+?[1-9]d{1,14}$`',
    `workday_worker_reference` STRING COMMENT 'The unique worker identifier assigned by Workday HCM, used to cross-reference this record with the source system of record for all HR transactions, payroll, and benefits data.',
    CONSTRAINT pk_staff_member PRIMARY KEY(`staff_member_id`)
) COMMENT 'Core master record for all paid staff at Ngo, including national staff, international staff, expatriates, and field personnel. Captures full employee identity (name, date of birth, nationality, gender), employment classification, contract type, duty station, cost center assignment, emergency contact/next-of-kin details, and HRIS identifiers sourced from Workday HCM. Includes separation lifecycle attributes: separation type (resignation, end of contract, redundancy, termination, retirement, death in service), effective date, exit interview completion, final settlement amount, rehire eligibility, and separation reason narrative. Serves as the SSOT for workforce identity across all HR sub-domains, the anchor entity for all workforce transactions, and the single record of employment lifecycle from hire to separation.';

CREATE OR REPLACE TABLE `ngo_ecm`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique system-generated identifier for an authorized organizational position (headcount slot) within Ngos structure. This is the primary key for the position entity in Workday HCM.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Positions have mandatory compliance obligations (safeguarding-designated roles require specific certifications, field positions require security clearances). Enables role-based compliance tracking and',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budgeted positions are assigned to cost centers for headcount budgeting and functional expense planning; FK enables position-level cost center reporting essential for NGO organizational budget managem',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Grant-funded positions require fund-level tracking for donor compliance and position budget management; FK enables fund-level headcount reporting and supports donor requirements for personnel cost tra',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: NGOs create joint or co-funded positions hosted by partner organizations (embedded technical advisors, joint program coordinators). Linking positions to the host partner org enables tracking of partne',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project to which this position is assigned. Enables grant-funded headcount tracking per program and supports RACI role assignments across programs.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Positions represent authorized headcount slots that should be defined by standardized job profiles. Currently position has job_family, job_function, and job_level as standalone attributes, but these s',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational department or cost center to which this position belongs. Used in organizational design, Chart of Accounts (CoA) mapping, and headcount reporting.',
    `reports_to_position_id` BIGINT COMMENT 'Reference to the parent position in the organizational hierarchy to which this position reports. Enables organizational chart construction, span-of-control analysis, and RACI role assignment across programs.',
    `staff_member_id` BIGINT COMMENT 'Reference to the current worker (employee or contractor) filling this position. Null when the position is vacant. Links the position slot to the person record in the workforce domain.',
    `availability_date` DATE COMMENT 'Date from which the position is authorized and available for filling, either through recruitment or internal transfer. Marks the effective start of the headcount slot in the organizational plan.',
    `budgeted_annual_cost` DECIMAL(18,2) COMMENT 'Total budgeted annual cost of the position including salary, benefits, and applicable indirect cost rate (ICR/NICRA), in the salary currency. Used in grant budget justifications, Budget versus Actual (BvA) reporting, and workforce cost planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this position record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `duty_station` STRING COMMENT 'Geographic location where the position is based, typically expressed as city and country (e.g., Nairobi, KEN). Critical for expatriate management, hardship allowance determination, and field operations staffing.',
    `duty_station_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the position is based. Used for expatriate management, tax compliance, and geographic workforce analytics.. Valid values are `^[A-Z]{3}$`',
    `end_date` DATE COMMENT 'Date on which the position authorization expires or is eliminated. Nullable for permanent positions. For grant-funded positions, typically aligned with the grant period of performance end date.',
    `filled_date` DATE COMMENT 'Date on which the position was most recently filled by an incumbent. Used to calculate time-to-fill metrics and vacancy duration reporting.',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Authorized Full-Time Equivalent (FTE) percentage allocated to this position, expressed as a decimal (e.g., 1.00 = full-time, 0.50 = half-time). Used in workforce planning, grant budget justifications, and headcount reporting.',
    `funding_source_type` STRING COMMENT 'Classification of the primary funding source for this position. Grant indicates the position is funded by a specific donor award; core indicates unrestricted organizational funding; split indicates funding from multiple sources; in-kind indicates a contributed position; cost-share indicates a position partially funded as match on a grant.. Valid values are `grant|core|split|in-kind|cost-share`',
    `headcount_plan_year` STRING COMMENT 'Fiscal or calendar year for which this position is authorized in the organizational headcount plan. Used in annual workforce planning cycles and grant budget period alignment.',
    `icr_applicable` BOOLEAN COMMENT 'Indicates whether the Negotiated Indirect Cost Rate Agreement (NICRA) / Indirect Cost Rate (ICR) applies to this positions costs when charged to federal grants. Drives Facilities and Administration (F&A) cost calculations in grant financial management.',
    `is_field_position` BOOLEAN COMMENT 'Indicates whether this position is classified as a field operations position (True) versus a headquarters or support office position (False). Drives hardship allowance eligibility, security protocols, and field operations staffing analytics.',
    `is_supervisory` BOOLEAN COMMENT 'Indicates whether this position carries supervisory or managerial responsibility over other positions (True = supervisory). Used in organizational design, RACI role assignments, and span-of-control analytics.',
    `is_vacant` BOOLEAN COMMENT 'Indicates whether the position currently has no active incumbent (True = vacant, False = filled). Drives recruitment requisition creation and vacancy reporting to donors and boards.',
    `job_description_url` STRING COMMENT 'URL or document management system reference to the official job description document for this position. Provides access to the full scope of work, responsibilities, and qualifications for recruitment and performance management purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this position record was most recently updated, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports change tracking, audit compliance, and incremental data pipeline processing.',
    `max_salary` DECIMAL(18,2) COMMENT 'Maximum base salary authorized for this positions pay grade band, in the local or organizational currency. Used in budget ceiling planning and compensation equity analysis.',
    `min_education_level` STRING COMMENT 'Minimum academic qualification required for this position as defined in the job profile. Used in recruitment requisition creation and candidate screening. [ENUM-REF-CANDIDATE: none|secondary|diploma|bachelor|master|doctorate|professional — promote to reference product]',
    `min_salary` DECIMAL(18,2) COMMENT 'Minimum base salary authorized for this positions pay grade band, in the local or organizational currency. Used in budget planning, grant budget justifications, and compensation equity analysis.',
    `min_years_experience` STRING COMMENT 'Minimum number of years of relevant professional experience required for this position as defined in the job profile. Used in recruitment requisition creation and candidate screening.',
    `pay_grade_band` STRING COMMENT 'Compensation grade band assigned to this position as defined in the organizations salary scale (e.g., G5, P3, NB4). Determines the salary range applicable to the position. Classified as confidential business data.. Valid values are `^[A-Z]{1,3}[0-9]{1,3}$`',
    `position_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the position within the organizations headcount plan and Workday HCM job catalog. Used in grant proposals, budget submissions, and organizational charts.. Valid values are `^POS-[A-Z0-9]{4,12}$`',
    `position_status` STRING COMMENT 'Current lifecycle state of the position headcount slot. Open indicates a vacancy available for recruitment; filled indicates an active incumbent; frozen indicates a position on hold due to budget constraints; eliminated indicates the position has been removed from the headcount plan; proposed indicates pending organizational approval.. Valid values are `open|filled|frozen|eliminated|proposed`',
    `position_type` STRING COMMENT 'Classification of the position by employment arrangement. Permanent indicates an indefinite contract; fixed-term indicates a time-bound contract; temporary indicates a short-term assignment; secondment indicates a position filled by staff from a partner organization; volunteer indicates an unpaid position.. Valid values are `permanent|fixed-term|temporary|secondment|volunteer`',
    `raci_role` STRING COMMENT 'Primary Responsible Accountable Consulted Informed (RACI) role designation for this position within program delivery processes. Supports organizational design and program accountability frameworks.. Valid values are `responsible|accountable|consulted|informed`',
    `required_competencies` STRING COMMENT 'Comma-separated list of core competencies required for this position as defined in the Workday HCM competency framework (e.g., Results Orientation, Teamwork, Communication, WASH Technical Skills). Used in performance management and talent acquisition.',
    `required_languages` STRING COMMENT 'Comma-separated list of language proficiency requirements for this position (e.g., English (fluent), French (working), Swahili (basic)). Critical for field operations positions in multilingual humanitarian contexts.',
    `salary_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the salary values associated with this position (e.g., USD, KES, EUR). Required for multi-currency workforce cost reporting and grant budget submissions.. Valid values are `^[A-Z]{3}$`',
    `security_clearance_required` BOOLEAN COMMENT 'Indicates whether this position requires a formal security clearance or background check (True = required). Relevant for positions handling restricted donor data, financial systems, or operating in high-risk field environments.',
    `staff_category` STRING COMMENT 'Classification of the position by staff type. National refers to locally-hired staff; international refers to internationally-recruited staff; expatriate refers to staff deployed from another country; consultant refers to contracted technical advisors; intern refers to learning positions. Drives compensation frameworks, benefits eligibility, and visa/work permit requirements.. Valid values are `national|international|expatriate|consultant|intern`',
    `title` STRING COMMENT 'Official job title of the position as defined in the organizational structure and Workday HCM job catalog. Used in recruitment requisitions, offer letters, and donor/grant reporting.',
    `vacancy_reason` STRING COMMENT 'Reason why the position is currently vacant. Used in workforce analytics, turnover reporting, and recruitment planning. [ENUM-REF-CANDIDATE: new_position|resignation|termination|transfer|promotion|retirement|contract_end — promote to reference product]',
    `workday_position_reference` STRING COMMENT 'Native position identifier from the Workday HCM source system. Used for data lineage, system reconciliation, and integration with Workday HCM APIs.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Authorized organizational position (headcount slot) within Ngos structure, distinct from the person filling it. Tracks position title, grade level, FTE allocation, funding source (grant or core), duty station, department, and whether the position is filled or vacant. Includes embedded job profile catalog: job family, job level, job function, competency requirements, minimum qualifications, pay grade band, and career progression path aligned with Workday HCM job catalog. Supports workforce planning, grant-funded headcount tracking, recruitment requisition creation, RACI role assignments, and organizational design.';

CREATE OR REPLACE TABLE `ngo_ecm`.`workforce`.`employment_contract` (
    `employment_contract_id` BIGINT COMMENT 'Unique system-generated identifier for each employment contract record in Workday HCM. Serves as the primary key for the employment_contract data product in the workforce domain.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: NGOs must track which grant funds each employment contract for cost allocation, donor compliance, and personnel cost charging. Critical for grant-funded position management, financial reporting, and d',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: Employment contracts consume specific budget lines for personnel costs; FK enables direct linkage between contracted salary costs and approved budget lines, supporting grant budget management and dono',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: NGO employment contracts are charged to cost centers for budgeted headcount cost tracking and grant compliance; FK enables personnel cost planning by cost center and supports functional expense classi',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Employment contracts for field staff are issued under a specific country offices legal entity and labor jurisdiction. Contract management, legal compliance audits, and payroll processing all require ',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Employment contracts funded by specific grants require fund linkage for donor-required personnel cost reporting and budget vs. actual tracking; FK enables fund-level contract cost monitoring essential',
    `funding_source_id` BIGINT COMMENT 'Foreign key linking to grant.funding_source. Business justification: Donor-funded employment contracts must be traceable to the funding source for compliance with donor staffing requirements, key personnel approvals, and budget accountability. funding_source_code is ',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Employment contracts should reference the standardized job profile catalog to ensure consistency in role definitions, competency requirements, and pay grade alignment. The job_family, job_function, an',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: An employment contract is issued within the context of a specific organizational unit (country office, department, or division). Linking employment_contract to org_unit enables org-level contract anal',
    `position_id` BIGINT COMMENT 'Reference to the organizational position associated with this contract, defining the role, job profile, and reporting structure within the NGOs workforce hierarchy.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: NGOs regularly second staff to or receive seconded staff from partner organizations. The employment contract for a seconded staff member must reference the partner org for HR administration, cost reco',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member (worker) to whom this employment contract applies. Links to the worker/employee master record in Workday HCM.',
    `amendment_effective_date` DATE COMMENT 'The date from which the most recent contract amendment takes effect. Null for original contracts with no amendments. Used in conjunction with amendment_number to track the timeline of contract changes.',
    `amendment_number` STRING COMMENT 'Sequential integer tracking the number of amendments made to the original employment contract. Zero indicates the original contract; each amendment increments this counter. Enables tracking of contract renewals, salary revisions, duty station changes, and other modifications over the contract lifecycle.',
    `amendment_reason` STRING COMMENT 'The business reason for the most recent contract amendment. Used for HR analytics, audit trails, and workforce planning. [ENUM-REF-CANDIDATE: renewal|salary_revision|duty_station_change|promotion|contract_type_change|scope_change|other — promote to reference product]',
    `approval_date` DATE COMMENT 'The date on which the employment contract was formally approved by the authorized signatory. Used in audit trails and compliance reporting.',
    `approved_by` STRING COMMENT 'The name or identifier of the authorized signatory or approving authority who approved this employment contract. Typically the Country Director, HR Director, or delegated authority per the organizations RACI (Responsible Accountable Consulted Informed) framework.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'The gross base salary payable to the staff member per the contract terms, expressed in the contract currency. Excludes allowances, benefits, and other compensation components. Used in payroll processing, BvA (Budget versus Actual) reporting, and grant cost allocation.',
    `contract_number` STRING COMMENT 'Externally-known unique alphanumeric reference number assigned to the employment contract, used in HR correspondence, legal documentation, and audit trails. Typically formatted as ORG-YEAR-SEQUENCE (e.g., NGO-2024-EMP0042).. Valid values are `^[A-Z]{2,4}-[0-9]{4}-[A-Z0-9]{4,10}$`',
    `contract_status` STRING COMMENT 'Current lifecycle state of the employment contract. Draft indicates pending approval; active indicates a currently binding agreement; on_hold covers suspension; terminated covers early cessation; expired covers contracts that reached their end date without renewal; amended covers contracts under revision.. Valid values are `draft|active|on_hold|terminated|expired|amended`',
    `contract_type` STRING COMMENT 'Classification of the employment arrangement defining the legal nature of the engagement. Fixed-term contracts have defined end dates; open-ended are indefinite; consultancy covers independent contractors; secondment covers staff loaned from/to partner organizations. [ENUM-REF-CANDIDATE: fixed_term|open_ended|consultancy|secondment|internship|volunteer — promote to reference product]. Valid values are `fixed_term|open_ended|consultancy|secondment|internship|volunteer`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this employment contract record was first created in the system. Corresponds to the MASTER_AGREEMENT RECORD_AUDIT_CREATED category. Used for data lineage, audit trails, and compliance reporting.',
    `duty_station` STRING COMMENT 'The official location (city and country) where the staff member is assigned to perform their duties under this contract. Determines applicable hardship classification, housing allowance, cost-of-living adjustments, and applicable labor law jurisdiction. Standard OCHA/UN terminology for field deployment location.',
    `duty_station_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country of the duty station (e.g., ETH for Ethiopia, SSD for South Sudan, COD for Democratic Republic of Congo). Used for geographic reporting, compliance, and multi-country workforce analytics.. Valid values are `^[A-Z]{3}$`',
    `education_allowance_amount` DECIMAL(18,2) COMMENT 'The annual monetary amount of education allowance provided for dependent children of expatriate staff members. Covers school fees and related educational expenses at the duty station or in the home country. Expressed in the contract currency. Null for non-expatriate staff or staff without eligible dependents.',
    `end_date` DATE COMMENT 'The date on which the employment contract expires or is scheduled to terminate. Null for open-ended contracts. Corresponds to the MASTER_AGREEMENT EFFECTIVE_UNTIL category. Used for contract renewal tracking and workforce planning.',
    `hardship_allowance_amount` DECIMAL(18,2) COMMENT 'The monthly monetary amount of hardship allowance payable to the expatriate staff member based on their hardship tier and salary grade. Expressed in the contract currency. Null for non-expatriate staff or H-classified duty stations.',
    `hardship_tier` STRING COMMENT 'The UN/ICSC hardship classification tier assigned to the duty station, determining the hardship allowance percentage applicable to the staff members salary. H = headquarters (no hardship); A through E represent increasing levels of hardship, with E being the most difficult duty stations (e.g., active conflict zones). Null for non-expatriate staff.. Valid values are `H|A|B|C|D|E`',
    `home_leave_frequency_months` STRING COMMENT 'The number of months between home leave entitlements for expatriate staff, defining how frequently the staff member is entitled to travel to their home country at organizational expense. Typically 12 or 24 months depending on duty station hardship classification. Null for non-expatriate staff.',
    `housing_allowance_amount` DECIMAL(18,2) COMMENT 'The monthly monetary amount of housing allowance provided to the expatriate staff member at the duty station. Reflects local rental market rates and organizational housing policy. Expressed in the contract currency. Null for non-expatriate staff or staff in NGO-provided accommodation.',
    `icr_rate` DECIMAL(18,2) COMMENT 'The Indirect Cost Rate (ICR) or Facilities and Administration (F&A) rate applicable to this staff members contract for grant cost recovery purposes. Expressed as a decimal (e.g., 0.1500 = 15%). Derived from the organizations NICRA (Negotiated Indirect Cost Rate Agreement) with the US government or equivalent donor agreement.',
    `ingo_salary_scale` STRING COMMENT 'The salary scale framework applied to this contract, particularly relevant for internationally-recruited staff. UN common system applies UN salary tables; organizational_scale uses the NGOs internal scale; national_scale applies host-country national staff scales. Determines applicable grade tables and allowance structures.. Valid values are `un_common_system|organizational_scale|national_scale|icsc_scale|other`',
    `is_expatriate` BOOLEAN COMMENT 'Indicates whether the staff member under this contract is classified as an expatriate (internationally-recruited staff deployed outside their home country). Triggers eligibility for expatriate compensation package components including hardship allowance, housing allowance, education allowance, home leave, and R&R.',
    `labor_law_jurisdiction` STRING COMMENT 'The legal jurisdiction whose labor laws and employment regulations govern this contract (e.g., Kenya, Ethiopia, United Kingdom, United States). Determines statutory entitlements, termination procedures, and compliance obligations. Critical for multi-country NGO operations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this employment contract record was most recently updated in the system. Used for change data capture (CDC) in the Databricks Silver Layer pipeline and audit compliance.',
    `medevac_coverage_level` STRING COMMENT 'The tier of medical evacuation coverage provided under this contract, determining the scope of emergency medical transport and treatment entitlements. Full coverage includes international evacuation to a tertiary care facility; basic covers regional evacuation only. Critical for field staff safety and duty of care compliance.. Valid values are `basic|standard|enhanced|full`',
    `notes` STRING COMMENT 'Free-text field for HR staff to record additional context, special conditions, or exceptions applicable to this employment contract that are not captured in structured fields (e.g., special security arrangements, unique compensation agreements, donor-specific staffing conditions).',
    `notice_period_days` STRING COMMENT 'The number of calendar days of advance notice required by either party to terminate the employment contract. Varies by contract type, seniority, and applicable labor law jurisdiction. Used in workforce planning and HR compliance.',
    `probation_end_date` DATE COMMENT 'The date on which the staff members probationary period concludes. During probation, different notice periods and performance review requirements typically apply. Null if no probation period is applicable (e.g., for short-term consultancies).',
    `relocation_allowance_amount` DECIMAL(18,2) COMMENT 'The one-time monetary amount provided to cover relocation costs when the staff member moves to the duty station at the start of the contract. Expressed in the contract currency. Null for locally-recruited national staff or contract renewals without relocation.',
    `rnr_cycle_weeks` STRING COMMENT 'The number of weeks between Rest and Recuperation (R&R) breaks for staff deployed to high-hardship or non-family duty stations. R&R is a mandatory welfare entitlement for staff in difficult operating environments (e.g., every 6, 8, or 12 weeks). Null for staff at H or A hardship-classified duty stations.',
    `salary_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the base salary and allowances are denominated (e.g., USD, EUR, GBP, KES, ETB). Supports multi-currency compensation management across 50+ country operations.. Valid values are `^[A-Z]{3}$`',
    `salary_frequency` STRING COMMENT 'The frequency at which the base salary is paid to the staff member. Determines payroll cycle alignment and annualization calculations for budget planning and grant reporting.. Valid values are `monthly|bi_weekly|weekly|annual`',
    `salary_grade` STRING COMMENT 'The compensation band or grade level assigned to the position under this contract, as defined in the NGOs salary scale (e.g., UN common system grade G5, P3, or organizational scale Band C). Determines the salary range and step progression applicable to the staff member.',
    `salary_step` STRING COMMENT 'The incremental step within the salary grade assigned to the staff member, reflecting years of experience or merit progression within the grade band (e.g., Step 1, Step 2, Step III). Used in conjunction with salary_grade to determine exact base pay.',
    `staff_category` STRING COMMENT 'Classification of the staff members recruitment category under this contract. International staff are recruited internationally and typically receive expatriate packages; national staff are locally recruited; third-country nationals are neither from the HQ country nor the duty station country. Determines applicable compensation package and entitlements.. Valid values are `international|national|third_country_national|consultant|secondee`',
    `start_date` DATE COMMENT 'The date on which the employment contract becomes effective and the staff members obligations and entitlements commence. Corresponds to the MASTER_AGREEMENT EFFECTIVE_FROM category.',
    `termination_date` DATE COMMENT 'The actual date on which the employment contract was terminated, if applicable. Distinct from end_date (scheduled expiry); this captures early terminations, resignations, and dismissals. Null for active contracts.',
    `termination_reason` STRING COMMENT 'The reason for contract termination, used in workforce analytics, exit reporting, and compliance with labor law notification requirements. [ENUM-REF-CANDIDATE: resignation|end_of_contract|redundancy|dismissal|mutual_agreement|death|other — promote to reference product]',
    `workday_contract_reference` STRING COMMENT 'The native contract or worker agreement identifier from Workday HCM, the system of record for this data product. Used for data lineage, source system reconciliation, and integration with Workday payroll and benefits modules.',
    CONSTRAINT pk_employment_contract PRIMARY KEY(`employment_contract_id`)
) COMMENT 'Formal employment agreement record for each staff member, capturing contract type (fixed-term, open-ended, consultancy, secondment), start and end dates, probation period, notice period, salary grade, base salary, currency, duty station, and applicable labor law jurisdiction. Tracks contract renewals and amendments over time. For internationally-recruited staff, includes full expatriate compensation package: hardship allowance tier and amount, housing allowance, education allowance for dependents, home leave entitlement and frequency, relocation allowance, medical evacuation coverage level, R&R cycle, and applicable INGO salary scale (e.g., UN common system, organizational scale). Supports multi-currency compensation across 50+ country operations. Sourced from Workday HCM.';

CREATE OR REPLACE TABLE `ngo_ecm`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique surrogate identifier for each organizational unit record in the Ngo hierarchy. Primary key for the org_unit data product in Workday HCM.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Org units map directly to cost centers in NGO financial systems; FK is fundamental for organizational budget reporting, cost allocation, and financial accountability. Replaces denormalized cost_center',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Org units post financial transactions to specific GL accounts; FK enables automated financial reporting by organizational unit and supports chart of accounts alignment with organizational structure. R',
    `parent_org_unit_id` BIGINT COMMENT 'Self-referencing identifier pointing to the immediate parent organizational unit, enabling recursive parent-child hierarchy traversal for headcount, payroll, and program staffing rollups. Null for the root/top-level unit.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member designated as the responsible manager or head of this organizational unit, used for accountability and RACI role assignments across programs.',
    `annual_budget_usd` DECIMAL(18,2) COMMENT 'Total approved annual operating budget allocated to this organizational unit in US Dollars, covering both core and grant-funded expenditures. Used for BvA reporting, fund accounting, and financial stewardship in SAP S/4HANA and Unit4 ERP.',
    `city_name` STRING COMMENT 'Name of the city or locality where the organizational units primary office is situated. Used for operational logistics, staff deployment planning, and field operations coordination.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code indicating the country where this organizational unit is physically located or registered (e.g., KEN for Kenya, SDN for Sudan, USA for United States). Used for geographic reporting and IATI disclosure.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this organizational unit record was first created in the source system (Workday HCM) and ingested into the Databricks Lakehouse Silver Layer. Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the primary operating currency of this organizational unit (e.g., USD, EUR, KES). Used for multi-currency financial reporting and fund accounting.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date on which this organizational unit ceased to be operationally effective (dissolution, merger, or restructuring). Null for currently active units. Used for historical headcount and grant financial reporting.',
    `effective_start_date` DATE COMMENT 'Date on which this organizational unit became operationally effective and began appearing in headcount, payroll, and program staffing reports. Supports point-in-time historical analysis.',
    `funding_model` STRING COMMENT 'Indicates how the organizational unit is financially sustained. core = funded from unrestricted/core organizational budget; grant_funded = funded entirely by restricted donor grants; mixed = combination of core and grant funding; self_funded = generates own revenue. Critical for fund accounting and BvA reporting.. Valid values are `core|grant_funded|mixed|self_funded`',
    `headcount_actual` STRING COMMENT 'Current number of active staff members assigned to this organizational unit as recorded in Workday HCM. Used for real-time workforce reporting, MEL dashboards, and BvA staffing analysis.',
    `headcount_authorized` STRING COMMENT 'Maximum number of staff positions (both national and international) authorized for this organizational unit as per the approved organizational structure and donor-approved staffing plans. Used for workforce planning and grant compliance.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this organizational unit within the global hierarchy tree (e.g., 1 = Global HQ, 2 = Regional Office, 3 = Country Office, 4 = Area/Field Office, 5 = Program Unit). Enables efficient hierarchical queries and rollup reporting.',
    `hierarchy_path` STRING COMMENT 'Materialized path string representing the full ancestry chain of the organizational unit from root to current node (e.g., /1/5/12/34/). Enables fast subtree queries for headcount and payroll rollups without recursive joins.',
    `iati_org_identifier` STRING COMMENT 'Unique International Aid Transparency Initiative (IATI) organization identifier assigned to this unit for transparent aid reporting and donor disclosure. Required for IATI-compliant activity reporting by USAID, DFID, and other ODA donors.',
    `icr_rate` DECIMAL(18,2) COMMENT 'Negotiated Indirect Cost Rate (NICRA) applicable to this organizational unit, expressed as a decimal (e.g., 0.1500 = 15%). Used for Facilities and Administration (F&A) cost recovery calculations on federal grants and donor-funded projects per OMB Uniform Guidance.',
    `international_staff_count` STRING COMMENT 'Number of international (expatriate) staff currently assigned to this organizational unit. Used for expatriate management reporting, visa/work permit tracking, and INGO staffing ratio compliance.',
    `is_field_office` BOOLEAN COMMENT 'Indicates whether this organizational unit is classified as a field office operating in a humanitarian or development program context (True) versus a non-field administrative or HQ unit (False). Used to apply field-specific HR policies, allowances, and security protocols.',
    `is_hq` BOOLEAN COMMENT 'Indicates whether this organizational unit is the global or regional headquarters (True). Used to distinguish HQ administrative units from field and country offices in hierarchical reporting and governance structures.',
    `mandate_description` STRING COMMENT 'Narrative description of the organizational units mandate, scope of work (SoW), and primary responsibilities within the Ngos Theory of Change (ToC). Used for onboarding, stakeholder engagement, and compliance reporting.',
    `national_staff_count` STRING COMMENT 'Number of national (locally-hired) staff currently assigned to this organizational unit. Supports localization reporting, donor compliance requirements, and INGO staffing ratio analysis.',
    `office_address` STRING COMMENT 'Physical street address of the organizational units primary office location. Classified as confidential organizational contact data used for operational correspondence, audit, and regulatory filings.',
    `office_email` STRING COMMENT 'Primary email address for the organizational unit used for official correspondence, donor communications, and regulatory filings. Classified as confidential organizational contact data.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `office_phone` STRING COMMENT 'Primary telephone number for the organizational units office. Classified as confidential organizational contact data used for inter-office communications, emergency coordination, and stakeholder engagement.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `org_unit_status` STRING COMMENT 'Current lifecycle status of the organizational unit. active = operational; inactive = temporarily suspended; pending = awaiting activation; dissolved = permanently closed; merged = absorbed into another unit.. Valid values are `active|inactive|pending|dissolved|merged`',
    `program_code` STRING COMMENT 'Code identifying the primary humanitarian or development program this organizational unit is aligned to (e.g., WASH, GBV, PSS, Nutrition). Enables program-level staffing and cost reporting in MEL dashboards and donor reports. Applicable primarily to program_unit type org units.',
    `region_name` STRING COMMENT 'Name of the geographic region or sub-national administrative area where this unit operates (e.g., East Africa, West Africa, Middle East and North Africa, South Asia). Supports regional rollup reporting for MEL dashboards and donor reports.',
    `sap_company_code` STRING COMMENT 'SAP S/4HANA company code associated with this organizational unit for General Ledger (GL), Accounts Payable (AP), Accounts Receivable (AR), and fund accounting integration. Enables cross-system financial reconciliation.. Valid values are `^[A-Z0-9]{1,6}$`',
    `security_level` STRING COMMENT 'UN/UNDSS security phase classification applicable to the location of this organizational unit (Phase 1 = Minimal, Phase 5 = Emergency). Drives staff deployment decisions, field operations protocols, and duty-of-care obligations for expatriate and national staff.. Valid values are `phase1|phase2|phase3|phase4|phase5`',
    `unit_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the organizational unit across systems (Workday HCM, SAP S/4HANA Chart of Accounts, Unit4 ERP). Used as the business identifier in cross-system integrations and financial reporting.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `unit_mission_statement` STRING COMMENT 'Formal mission statement specific to this organizational unit, articulating its contribution to the Ngos overall mission and SDG alignment. Used in annual reports, donor communications, and regulatory filings.',
    `unit_name` STRING COMMENT 'Full human-readable name of the organizational unit (e.g., East Africa Regional Office, WASH Program Unit – South Sudan, Finance and Administration Department – HQ). Used in all reporting, dashboards, and donor communications.',
    `unit_short_name` STRING COMMENT 'Abbreviated or shortened display name for the organizational unit used in dashboards, SitRep headers, and space-constrained reporting contexts (e.g., EA Regional, WASH-SSD).',
    `unit_type` STRING COMMENT 'Classification of the organizational unit within the global Ngo structure. Drives hierarchical reporting logic and determines applicable governance rules. [ENUM-REF-CANDIDATE: hq_department|regional_office|country_office|area_office|field_office|program_unit|cost_center — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this organizational unit record in the source system (Workday HCM). Used for change data capture (CDC), incremental loads, and audit compliance in the Databricks Lakehouse Silver Layer.',
    `volunteer_count` STRING COMMENT 'Number of active volunteers currently assigned to or managed by this organizational unit, as tracked in Microsoft Dynamics 365 Volunteer Coordination. Used for workforce capacity reporting and donor impact metrics.',
    `workday_org_reference` STRING COMMENT 'Native organization identifier assigned by Workday HCM to this organizational unit. Used as the source system key for data integration, reconciliation, and lineage tracking between Workday HCM and the Databricks Lakehouse Silver Layer.',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational unit hierarchy for Ngo, representing departments, divisions, country offices, area/field offices, program units, and cost centers in a recursive parent-child structure. Captures unit name, unit type (HQ department, regional office, country office, field office, program unit), parent unit reference, geographic location, responsible manager, funding model (core vs grant), and active status. Enables hierarchical reporting of headcount, payroll costs, and program staffing across the global organization.';

CREATE OR REPLACE TABLE `ngo_ecm`.`workforce`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Unique surrogate identifier for the job profile record in the Ngo HRIS. Primary key for the job_profile data product in the Workday HCM job catalog.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Job profiles define mandatory compliance requirements (background check levels, safeguarding training, professional certifications). Enables compliance matrix by role type and ensures recruitment requ',
    `approval_date` DATE COMMENT 'Date on which this job profile was formally approved by the designated HR authority. Required for governance documentation and audit compliance in donor-funded programs.',
    `approved_by` STRING COMMENT 'Name or identifier of the HR authority (e.g., HR Director, Country Director) who approved this job profile for use in Workday HCM. Supports governance, audit trail, and compliance with organizational HR policies.',
    `background_check_level` STRING COMMENT 'Required level of pre-employment background screening for this job profile. child_protection and enhanced checks are mandatory for safeguarding-designated roles and roles with access to vulnerable beneficiaries, per CHS and donor requirements.. Valid values are `standard|enhanced|criminal_record|child_protection|not_required`',
    `competency_framework_code` STRING COMMENT 'Reference code identifying the competency framework applied to this job profile (e.g., CHS competency framework, Ngo internal framework, IASC humanitarian competencies). Links to the competency library in Workday HCM for performance management and talent development.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `core_competencies` STRING COMMENT 'Comma-separated list of core behavioral and technical competencies required for this job profile as defined in the Workday HCM competency library (e.g., Accountability, Communication, Collaboration, Results Orientation, MEAL Proficiency). Used in performance reviews and talent assessments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this job profile record was first created in the Workday HCM system. Supports audit trail, data lineage, and compliance reporting requirements under OMB Uniform Guidance and FASB ASC 958.',
    `duty_station_type` STRING COMMENT 'Classification of the expected duty station for this job profile. roving indicates the role covers multiple field locations. Drives hardship allowance eligibility, security protocols, and benefits packages for field personnel.. Valid values are `headquarters|country_office|field_office|remote|roving`',
    `effective_date` DATE COMMENT 'Date from which this job profile version became active and available for use in position creation and recruitment in Workday HCM. Supports versioning and historical tracking of job profile changes.',
    `employment_type` STRING COMMENT 'Standard employment type associated with this job profile, indicating the expected contractual arrangement (e.g., full-time permanent, part-time, fixed-term contract, casual, secondment). Drives benefits eligibility and contract template selection in Workday HCM.. Valid values are `full_time|part_time|fixed_term|casual|secondment`',
    `end_date` DATE COMMENT 'Date on which this job profile version was retired or superseded. Null for currently active profiles. Supports effective-dated versioning in Workday HCM and historical workforce analytics.',
    `field_experience_required` BOOLEAN COMMENT 'Indicates whether prior humanitarian field experience (e.g., deployment in conflict zones, disaster response, IDP (Internally Displaced Person) settings) is a mandatory requirement for this job profile. Critical for operational roles in Ngos field programs.',
    `flsa_exemption_status` STRING COMMENT 'Indicates whether the job profile is classified as exempt or non-exempt under the US Fair Labor Standards Act (FLSA) for overtime eligibility purposes. not_applicable for roles outside US jurisdiction. Required for US-based payroll compliance.. Valid values are `exempt|non_exempt|not_applicable`',
    `icr_cost_category` STRING COMMENT 'Classification of the job profiles cost as direct, indirect, or shared for purposes of grant budget allocation and NICRA (Negotiated Indirect Cost Rate Agreement) compliance. Determines how staff costs are charged to grants and reported to donors such as USAID and BHA.. Valid values are `direct|indirect|shared`',
    `is_critical_role` BOOLEAN COMMENT 'Indicates whether this job profile is designated as a critical or key position within Ngos organizational structure. Critical roles are prioritized in succession planning, talent retention programs, and emergency staffing protocols.',
    `is_safeguarding_designated` BOOLEAN COMMENT 'Indicates whether this job profile is designated as a safeguarding role requiring enhanced background checks, child protection clearances, and mandatory safeguarding training. Mandatory for roles working directly with beneficiaries, children, or vulnerable populations.',
    `job_category` STRING COMMENT 'Classification of the job profile by employment category as used in Ngo HR and payroll systems. Distinguishes national staff, international staff (INGO), expatriates, consultants, volunteers, and interns. Drives benefits eligibility, tax treatment, and regulatory compliance reporting.. Valid values are `national_staff|international_staff|expatriate|consultant|volunteer|intern`',
    `job_family_group_name` STRING COMMENT 'The broader job family group that clusters related job families in the Workday HCM hierarchy (e.g., Operations, Finance, Technical Specialists, Leadership). Enables enterprise-level workforce analytics and organizational design.',
    `job_family_name` STRING COMMENT 'The job family grouping to which this profile belongs within the Workday HCM job architecture (e.g., Program Management, Finance and Accounting, Monitoring Evaluation and Learning (MEL), Logistics and Supply Chain, Human Resources). Supports workforce planning and compensation benchmarking.',
    `job_level` STRING COMMENT 'Standardized job level designation indicating seniority and scope of responsibility within the Ngo grading structure (e.g., Entry, Junior, Mid, Senior, Lead, Manager, Director, Executive). Drives pay grade assignment and career pathing. [ENUM-REF-CANDIDATE: entry|junior|mid|senior|lead|manager|director|executive — promote to reference product]',
    `key_responsibilities` STRING COMMENT 'Structured narrative of the primary duties and accountabilities for this job profile. Serves as the basis for position descriptions, performance agreements, and RACI (Responsible Accountable Consulted Informed) role mapping across programs.',
    `language_requirements` STRING COMMENT 'Comma-separated list of language proficiency requirements for this job profile (e.g., English:Fluent, French:Working, Arabic:Basic). Particularly relevant for international and field-based roles in Ngos multi-country operations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this job profile record was most recently updated in the Workday HCM system. Used to detect changes, trigger downstream data pipeline refreshes, and support audit compliance.',
    `leadership_competencies` STRING COMMENT 'Comma-separated list of leadership-specific competencies required for managerial and senior roles in this job profile (e.g., Strategic Thinking, People Development, Change Management, Stakeholder Engagement). Populated only for management-level profiles.',
    `management_level` STRING COMMENT 'Indicates whether the job profile is for an individual contributor or a people manager role, and at what management tier. Used in organizational design, RACI (Responsible Accountable Consulted Informed) role assignments, and leadership development programs.. Valid values are `individual_contributor|team_lead|manager|senior_manager|director|executive`',
    `min_education_level` STRING COMMENT 'Minimum academic qualification required for this job profile (e.g., Bachelors degree, Masters degree). Used as a screening criterion in recruitment and talent acquisition workflows in Workday HCM and Microsoft Dynamics 365. [ENUM-REF-CANDIDATE: none|secondary|diploma|bachelor|master|doctorate|professional_certification — 7 candidates stripped; promote to reference product]',
    `min_years_experience` STRING COMMENT 'Minimum number of years of relevant professional experience required for this job profile. Used as a screening criterion in recruitment and for determining eligibility for internal mobility and promotions.',
    `pay_grade` STRING COMMENT 'The compensation pay grade band assigned to this job profile (e.g., G5, P3, M2). Defines the salary range applicable to positions created from this profile. Confidential as it reveals internal compensation structure. Aligned with Ngos compensation framework and NICRA (Negotiated Indirect Cost Rate Agreement) requirements.. Valid values are `^[A-Z]{1,3}[0-9]{1,3}$`',
    `pay_grade_max_usd` DECIMAL(18,2) COMMENT 'Maximum base salary in US Dollars for the pay grade band associated with this job profile. Used in compensation benchmarking, offer approvals, and grant budget ceiling calculations. Confidential as it reveals internal compensation structure.',
    `pay_grade_midpoint_usd` DECIMAL(18,2) COMMENT 'Midpoint salary in US Dollars for the pay grade band, representing the market reference point for fully competent performance in this job profile. Used in compensation equity analysis and salary benchmarking against sector surveys (e.g., Birches Group, Hay Group).',
    `pay_grade_min_usd` DECIMAL(18,2) COMMENT 'Minimum base salary in US Dollars for the pay grade band associated with this job profile. Used in budget planning, compensation benchmarking, and grant budget preparation. Confidential as it reveals internal compensation structure.',
    `preferred_certifications` STRING COMMENT 'Comma-separated list of desirable but non-mandatory professional certifications for this job profile. Used to differentiate candidates during recruitment and to guide learning and development (L&D) planning in Workday HCM LMS.',
    `profile_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the job profile within the Workday HCM job catalog and HRIS classification system. Used in position creation, recruitment requisitions, and cross-system integration (e.g., Unit4 ERP, payroll).. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `profile_name` STRING COMMENT 'Human-readable title of the job profile as defined in the Workday HCM job catalog (e.g., Field Program Officer, MEAL Coordinator, Finance Manager). Used in recruitment postings, organizational charts, and staff communications.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the job profile within the Workday HCM job catalog. active profiles are available for position creation and recruitment; inactive or archived profiles are retired from use.. Valid values are `active|inactive|draft|under_review|archived`',
    `program_area` STRING COMMENT 'Primary humanitarian or development program area associated with this job profile (e.g., WASH (Water Sanitation and Hygiene), GBV (Gender-Based Violence), Health, Education, Livelihoods, Nutrition, PSS (Psychosocial Support)). Used for workforce planning and program staffing analytics.',
    `required_certifications` STRING COMMENT 'Comma-separated list of mandatory professional certifications or licenses required for this job profile (e.g., CPA, PMP, CIPS, HEAT Training, SPHERE Certification). Used in recruitment screening and compliance tracking in Workday HCM.',
    `sdg_alignment` STRING COMMENT 'Comma-separated list of UN Sustainable Development Goal (SDG) numbers that this job profile primarily contributes to (e.g., 3,4,6 for Health, Education, WASH roles). Used in donor reporting and IATI (International Aid Transparency Initiative) disclosures.',
    `succession_eligibility` BOOLEAN COMMENT 'Indicates whether this job profile is included in Ngos formal succession planning program in Workday HCM. Profiles marked as succession-eligible are tracked for talent pipeline development and leadership continuity.',
    `summary` STRING COMMENT 'Concise narrative summary of the job profiles purpose, primary accountabilities, and organizational context. Used as the opening paragraph in job postings and position descriptions. Aligned with Workday HCM job profile description field.',
    `travel_requirement` STRING COMMENT 'Expected level of travel associated with this job profile. field_based indicates deployment to humanitarian field operations (e.g., IDP camps, disaster response zones). Used in recruitment communications and duty of care planning.. Valid values are `none|occasional|frequent|extensive|field_based`',
    `version_number` STRING COMMENT 'Sequential version number of the job profile, incremented each time the profile is substantively revised (e.g., competency updates, pay grade changes, qualification changes). Supports audit trail and change management in Workday HCM.',
    `workday_job_profile_reference` STRING COMMENT 'The native identifier of this job profile record in the Workday HCM source system. Used for system-of-record traceability, data lineage, and integration with Workday payroll, talent, and learning modules.. Valid values are `^[A-Za-z0-9_-]{1,50}$`',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Standardized job profile catalog defining roles within Ngo, including job family, job level, competency requirements, minimum qualifications, and pay grade band. Used as the template for position creation and recruitment. Aligned with Workday HCM job catalog and HRIS classification standards.';

CREATE OR REPLACE TABLE `ngo_ecm`.`workforce`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Unique system-generated identifier for each payroll run record in Workday HCM. Serves as the primary key for the payroll_run entity.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: NGO payroll disbursements are made from specific bank accounts; linking enables treasury reconciliation, restricted fund compliance, and audit trail from payroll run to bank transaction. Replaces deno',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: NGO payroll runs are allocated to cost centers for functional expense reporting, indirect cost rate calculation, and grant compliance. Finance teams track payroll costs by cost center for NICRA and do',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Payroll runs in NGOs are executed per country office — each office has its own legal entity, currency, and banking arrangements. Donor financial reporting, audit trails, and statutory compliance all r',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: NGO payroll is often funded by specific restricted grants or funds; FK enables fund-level burn rate tracking, donor reporting compliance, and restricted fund payroll cost monitoring. Replaces denormal',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: NGO payroll runs must be posted to the correct fiscal period for financial reporting, grant burn-rate tracking, and audit compliance. Finance teams reconcile payroll costs by fiscal period. Replaces d',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Payroll runs post salary expenses to specific GL accounts; FK enables automated journal entry generation, financial statement accuracy, and audit trail for salary expense classification. Replaces deno',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Each payroll run generates a corresponding journal entry batch posting salary expenses to the GL; FK provides direct audit trail from payroll run to financial posting, essential for NGO financial audi',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: A payroll run is executed for a specific organizational unit (country office, legal entity, or department group). Linking payroll_run to org_unit enables payroll cost reporting by org hierarchy and su',
    `program_id` BIGINT COMMENT 'Foreign key linking to program.program. Business justification: NGO donor financial reporting and grant compliance require allocating payroll costs to specific programs. program_code is a denormalized string; linking payroll_run to program enables program-level ',
    `statutory_registration_id` BIGINT COMMENT 'Foreign key linking to compliance.statutory_registration. Business justification: Payroll runs are executed under a specific legal entitys statutory registration (tax ID, employer registration). Payroll tax remittance and statutory reporting require tracing each run to the registe',
    `approval_status` STRING COMMENT 'The authorization status of the payroll run within the organizations approval workflow. Tracks whether the run has been reviewed and approved by the designated approver (e.g., Finance Director, Country Director) before disbursement. Distinct from run_status which tracks the processing lifecycle.. Valid values are `pending|approved|rejected|on_hold`',
    `approved_by` STRING COMMENT 'The name or employee identifier of the individual who authorized this payroll run. Captured for audit trail and segregation of duties compliance. Required for internal controls and external audit purposes.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time at which the payroll run received final authorization. Provides an immutable audit record of when approval was granted, supporting segregation of duties controls and compliance with OMB Uniform Guidance internal control requirements.',
    `calculation_timestamp` TIMESTAMP COMMENT 'The date and time when the payroll calculation was executed in Workday HCM. Marks the business event of gross-to-net computation. Distinct from approved_timestamp and created_timestamp, this captures when the financial figures were computed.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code identifying the country of operation for which this payroll run was executed (e.g., KEN, UGA, SSD). Determines applicable labor law, tax regime, and statutory deduction rules. Essential for multi-country NGO payroll operations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll run record was first created in the system. Serves as the audit creation timestamp for data lineage, compliance, and Silver layer ingestion tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which this payroll run is denominated (e.g., USD, EUR, KES, NGN). Critical for multi-currency NGO operations where national staff may be paid in local currency while international staff are paid in USD or EUR.. Valid values are `^[A-Z]{3}$`',
    `employee_count` STRING COMMENT 'The total number of employees included in this payroll run. Used for headcount reporting, per-capita cost analysis, and validation that all eligible staff were processed. Reconciled against HRIS (Human Resource Information System) active headcount.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the payroll run amounts from the local currency to the organizations functional reporting currency (typically USD). Sourced from the organizations treasury or ERP at the time of payroll processing. Required for consolidated financial reporting and BvA (Budget versus Actual) analysis.',
    `functional_currency_code` STRING COMMENT 'ISO 4217 three-letter code for the organizations functional reporting currency (e.g., USD). Used alongside exchange_rate to express payroll costs in a consistent currency for consolidated financial statements and donor reporting.. Valid values are `^[A-Z]{3}$`',
    `grant_code` STRING COMMENT 'The grant identifier to which a portion or all of this payroll runs costs are charged. Enables grant-level labor cost tracking and compliance with donor reporting requirements. May be null for unrestricted payroll runs not tied to a specific grant.',
    `icr_rate` DECIMAL(18,2) COMMENT 'The Indirect Cost Rate (ICR) or F&A (Facilities and Administration) rate applied to direct labor costs in this payroll run, as defined in the organizations NICRA (Negotiated Indirect Cost Rate Agreement). Used to calculate indirect cost recovery charges against grants.',
    `is_retroactive` BOOLEAN COMMENT 'Indicates whether this payroll run includes retroactive pay adjustments for prior pay periods (e.g., backdated salary increases, correction of underpayments). Retroactive runs require special grant cost allocation treatment under OMB Uniform Guidance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll run record was most recently modified. Tracks corrections, status changes, and amendments to the payroll run. Essential for data lineage and change management in the Databricks Silver layer.',
    `notes` STRING COMMENT 'Free-text field for payroll officers to document special circumstances, exceptions, or explanatory remarks about this payroll run (e.g., reason for off-cycle run, description of corrections made, emergency payment context). Supports audit trail and knowledge transfer.',
    `pay_frequency` STRING COMMENT 'The cadence at which employees in this payroll group are paid. Determines the number of pay periods per year and affects annualized salary calculations, benefit proration, and grant budget reporting.. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `pay_period_end_date` DATE COMMENT 'The last calendar date of the pay period covered by this payroll run. Defines the closing boundary of the earnings window. Together with pay_period_start_date, determines the scope of labor costs chargeable to grants and programs.',
    `pay_period_start_date` DATE COMMENT 'The first calendar date of the pay period covered by this payroll run. Defines the beginning of the earnings window for all employees included in the run. Used for time-and-attendance reconciliation and grant cost allocation.',
    `payment_date` DATE COMMENT 'The scheduled or actual date on which net pay is disbursed to employees bank accounts or via alternative payment methods. Used for cash flow planning, bank reconciliation, and compliance with local labor law payment deadlines.',
    `payment_method` STRING COMMENT 'The disbursement method used to pay employees in this payroll run. In humanitarian contexts, mobile money (e.g., M-Pesa) is common for field staff in remote areas. Determines the payment processing channel and reconciliation approach.. Valid values are `bank_transfer|mobile_money|check|cash|prepaid_card`',
    `payroll_group` STRING COMMENT 'Classification of the staff population covered by this payroll run. Distinguishes between national staff (locally hired), international staff (globally mobile), expatriates (expat), volunteers with stipends, and consultants. Drives applicable tax regimes, benefit structures, and compliance reporting requirements.. Valid values are `national_staff|international_staff|expat|volunteer|consultant`',
    `processed_by` STRING COMMENT 'The name or employee identifier of the payroll officer who initiated and processed this payroll run in Workday HCM. Supports RACI (Responsible Accountable Consulted Informed) accountability tracking and audit trail requirements.',
    `retroactive_period_start_date` DATE COMMENT 'The start date of the prior period for which retroactive pay adjustments are being made in this payroll run. Populated only when is_retroactive is True. Used to correctly allocate retroactive costs to the appropriate grant and fiscal period.',
    `run_number` STRING COMMENT 'Externally-known business identifier for the payroll run, typically formatted as PR-YYYY-MM-NNNN (e.g., PR-2024-03-0012). Used in audit trails, finance reconciliation, and donor/grant reporting to reference a specific payroll cycle.. Valid values are `^PR-[0-9]{4}-[0-9]{2}-[0-9]{4}$`',
    `run_status` STRING COMMENT 'Current lifecycle state of the payroll run within Workday HCM. Progresses from draft through calculation, approval, and payment. Cancelled status indicates the run was voided before disbursement. Used for workflow control and audit compliance.. Valid values are `draft|in_progress|calculated|approved|paid|cancelled`',
    `run_type` STRING COMMENT 'Categorizes the nature of the payroll run. Regular runs follow the standard pay schedule; off-cycle runs address missed payments; supplemental runs cover bonuses or allowances; correction runs fix prior errors; final runs process termination pay. Determines processing rules and audit requirements.. Valid values are `regular|off_cycle|supplemental|correction|final`',
    `total_deductions` DECIMAL(18,2) COMMENT 'The aggregate of all deductions applied across employees in this payroll run, including statutory taxes, social security contributions, health insurance premiums, pension contributions, and voluntary deductions. Reconciled against payroll liabilities in the General Ledger (GL).',
    `total_employer_contributions` DECIMAL(18,2) COMMENT 'The aggregate employer-side payroll costs for this run, including employer social security, pension matching, health insurance, and other statutory employer contributions. Represents the full labor cost burden beyond gross pay, critical for grant budget management and F&A (Facilities and Administration) cost allocation.',
    `total_gross_pay` DECIMAL(18,2) COMMENT 'The aggregate gross earnings for all employees included in this payroll run before any deductions. Includes base salary, allowances, overtime, and other earnings components. Used for BvA (Budget versus Actual) reporting, grant cost allocation, and financial stewardship.',
    `total_net_pay` DECIMAL(18,2) COMMENT 'The aggregate net amount disbursed to all employees in this payroll run after all deductions. Equals total_gross_pay minus total_deductions. Used for cash disbursement planning, bank transfer reconciliation, and treasury management.',
    `total_tax_withheld` DECIMAL(18,2) COMMENT 'The aggregate income tax and statutory levies withheld from employee earnings in this payroll run. Reported to tax authorities and reconciled against payroll tax liability accounts in the CoA (Chart of Accounts). Supports compliance with IRS and local tax authority reporting.',
    `workday_run_reference` STRING COMMENT 'The native identifier assigned to this payroll run by Workday HCM, the system of record. Enables traceability back to the source system for audit, reconciliation, and support purposes. Distinct from the Silver layer surrogate key payroll_run_id.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Payroll processing cycle record capturing each payroll run executed in Workday HCM, including pay period start and end dates, payroll group (national staff, international staff, expat), run status, total gross pay, total deductions, total net pay, currency, and approval status. Serves as the header record for payroll transactions.';

CREATE OR REPLACE TABLE `ngo_ecm`.`workforce`.`payslip` (
    `payslip_id` BIGINT COMMENT 'Unique surrogate identifier for each individual payslip record in the Workday HCM payroll system. Serves as the primary key for the payslip data product in the Databricks Silver Layer.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Effort certification and grant expenditure reporting (2 CFR 200, USAID ADS) require linking payslips to the funding award. grant_code is a denormalized plain-text award reference. This FK enables ac',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual payslips are charged to cost centers for functional expense allocation and grant compliance; FK enables direct cost reporting per cost center and supports effort certification requirements.',
    `employment_contract_id` BIGINT COMMENT 'Foreign key linking to workforce.employment_contract. Business justification: A payslip is generated based on the terms of an employment contract (base salary, allowances, deductions, salary grade). Linking payslip to employment_contract enables audit trails showing which contr',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Payslips funded by specific grants require fund-level tracking for donor reporting and effort certification compliance; FK enables fund-level personnel cost reporting required by USAID, EU, and other ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Payslip salary components (gross pay, benefits, taxes) post to specific GL accounts; FK enables automated journal generation, financial statement accuracy, and direct audit trail from individual paysl',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Individual payslips are posted via journal entries; FK replaces the denormalized gl_journal_reference text field and provides direct audit trail from payslip to GL posting, essential for NGO financial',
    `original_payslip_id` BIGINT COMMENT 'Reference to the original payslip record that this corrected or reversed payslip supersedes. Null for standard payslips; populated only when is_correction is True, enabling full audit trail of payroll corrections.',
    `payroll_run_id` BIGINT COMMENT 'Reference to the payroll run batch under which this payslip was processed. Enables traceability of individual payslips back to the parent payroll run for audit and reconciliation purposes.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member for whom this payslip was generated. Links to the employee master record in Workday HCM HRIS.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the payroll run containing this payslip was formally approved in the Workday HCM approval workflow. Provides an auditable approval event timestamp for statutory and donor compliance.',
    `approved_by` STRING COMMENT 'Name or identifier of the authorising manager or finance officer who approved this payroll run in the Workday HCM approval chain. Supports RACI accountability documentation and donor audit requirements.',
    `bank_account_reference` STRING COMMENT 'Masked or tokenised reference to the employees bank account details used for payment disbursement. Full account details are stored securely in Workday HCM; only a reference token is retained in the Silver Layer for audit traceability without exposing PCI-sensitive data.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the duty station where the employee is based and where payroll is processed. Determines applicable labour law, tax jurisdiction, statutory deduction rules, and local currency for multi-country NGO operations across 50+ countries.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payslip record was first created in the Workday HCM system and ingested into the Databricks Silver Layer. Provides the audit creation timestamp for data lineage and compliance tracking.',
    `employer_pension_contribution` DECIMAL(18,2) COMMENT 'Employers contribution to the employees pension or provident fund for the pay period. Recorded separately from employee deductions for total employment cost reporting and grant cost allocation under OMB Uniform Guidance.',
    `employer_social_security` DECIMAL(18,2) COMMENT 'Employers statutory social security or national insurance contribution associated with this payslip. Not deducted from employee pay but recorded for total employment cost reporting, BvA grant cost allocation, and NICRA indirect cost rate calculations.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied to convert local currency salary amounts to the payment currency at the time of payroll processing. Critical for multi-currency reconciliation and donor financial reporting.',
    `expat_allowance` DECIMAL(18,2) COMMENT 'Allowance specific to internationally-recruited expatriate staff, covering relocation, cost-of-living differentials, and international assignment premiums. Applicable only to staff in the expat payroll group.',
    `field_allowance` DECIMAL(18,2) COMMENT 'Allowance paid to staff working in active field operations, remote areas, or humanitarian response zones. Distinct from hardship allowance; compensates for operational field conditions and mobility requirements.',
    `gross_salary` DECIMAL(18,2) COMMENT 'Total gross salary amount in local currency before any deductions, representing the employees base contractual pay for the pay period. Forms the basis for all statutory deduction calculations and BvA payroll cost reporting.',
    `hardship_allowance` DECIMAL(18,2) COMMENT 'Additional allowance paid to staff deployed in hardship or non-family duty stations as classified by UN/INGO hardship classification frameworks. Compensates for difficult living conditions in humanitarian field operations.',
    `housing_allowance` DECIMAL(18,2) COMMENT 'Monetary allowance paid to the employee to cover accommodation costs, commonly provided to international and expat staff in high-cost or insecure duty stations. Taxability varies by country and employment contract type.',
    `income_tax_deduction` DECIMAL(18,2) COMMENT 'Statutory income tax withheld from the employees gross pay in accordance with the applicable national tax legislation of the duty station country. Reported to tax authorities and included in statutory payroll filings.',
    `is_correction` BOOLEAN COMMENT 'Indicates whether this payslip is a corrected reissue of a previously reversed payslip. When True, the original_payslip_id field references the superseded payslip for audit trail continuity.',
    `is_off_cycle` BOOLEAN COMMENT 'Indicates whether this payslip was generated as part of an off-cycle payroll run (e.g., for a new hire mid-period, a termination payment, or a correction) rather than the standard scheduled payroll cycle.',
    `local_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code of the local currency in which the employees salary components are denominated and calculated. Supports multi-currency payroll operations across 50+ countries.. Valid values are `^[A-Z]{3}$`',
    `net_pay_local` DECIMAL(18,2) COMMENT 'Final take-home pay amount in local currency after all statutory and voluntary deductions have been subtracted from gross pay and allowances. Represents the amount the employee is entitled to receive for the pay period.',
    `net_pay_payment_currency` DECIMAL(18,2) COMMENT 'Net pay amount converted to the payment currency using the applicable exchange rate. Represents the actual amount disbursed to the employees bank account. May equal net_pay_local when local and payment currencies are the same.',
    `pay_period_end_date` DATE COMMENT 'The last calendar date of the payroll period covered by this payslip. Together with pay_period_start_date defines the exact payroll cycle window for statutory and donor reporting.',
    `pay_period_start_date` DATE COMMENT 'The first calendar date of the payroll period covered by this payslip. Used for Budget vs Actual (BvA) payroll cost allocation to grants and programs.',
    `payment_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code of the currency in which net pay is actually disbursed to the employee. May differ from local_currency_code for expatriate staff paid in USD or EUR regardless of duty station.. Valid values are `^[A-Z]{3}$`',
    `payment_date` DATE COMMENT 'The actual date on which net pay was disbursed to the employees bank account or via the designated payment method. Represents the principal business event date for this transaction.',
    `payment_method` STRING COMMENT 'Method by which net pay is disbursed to the employee. Bank transfer is standard for most staff; cash and mobile money are used in remote field locations with limited banking infrastructure, common in humanitarian operations.. Valid values are `bank_transfer|cash|mobile_money|cheque`',
    `payroll_group` STRING COMMENT 'Classification of the staff members employment category for payroll processing purposes. Determines applicable pay scales, allowances, tax treatment, and statutory deduction rules. National staff follow local labour law; international and expat staff follow INGO compensation frameworks.. Valid values are `national|international|expat|consultant`',
    `payroll_run_sequence` STRING COMMENT 'Sequential run number within the payroll period (e.g., 1 for the primary run, 2 for a supplemental or correction run). Distinguishes regular payroll runs from off-cycle or adjustment runs.',
    `payslip_number` STRING COMMENT 'Externally-visible, human-readable unique reference number for this payslip, typically formatted as PSL-{COUNTRY}-{YEAR}-{MONTH}-{SEQUENCE}. Used in employee communications, statutory filings, and donor audit documentation.. Valid values are `^PSL-[A-Z]{2,4}-[0-9]{4}-[0-9]{2}-[0-9]{6}$`',
    `payslip_status` STRING COMMENT 'Current lifecycle state of this individual payslip record. Distinguishes between payslips that have been generated and issued to the employee versus those that have been reversed or superseded by a corrected payslip.. Valid values are `generated|issued|reversed|corrected`',
    `pension_deduction` DECIMAL(18,2) COMMENT 'Employee contribution to pension or provident fund deducted from gross pay. Includes both mandatory statutory pension contributions and voluntary supplementary pension scheme contributions where applicable.',
    `program_code` STRING COMMENT 'Identifier of the humanitarian or development program to which this payroll cost is allocated. Supports program-level cost tracking for MEL reporting, LogFrame financial monitoring, and donor accountability.',
    `run_status` STRING COMMENT 'Current lifecycle state of the payroll run associated with this payslip. Tracks the workflow from initial calculation through approval, payment disbursement, and any reversals required for corrections.. Valid values are `draft|calculated|approved|paid|reversed|cancelled`',
    `social_security_deduction` DECIMAL(18,2) COMMENT 'Statutory social security or national insurance contribution deducted from the employees pay as required by local labour law. Varies by country and employment type; may be zero for certain expat staff under bilateral social security agreements.',
    `total_allowances` DECIMAL(18,2) COMMENT 'Sum of all allowance components (housing, hardship, field, expat, transport, and any other applicable allowances) for the pay period in local currency. Used as a subtotal in payslip presentation and BvA reporting.',
    `total_statutory_deductions` DECIMAL(18,2) COMMENT 'Sum of all mandatory statutory deductions (income tax, social security, pension) for the pay period. Used as a subtotal in payslip presentation and for statutory remittance reconciliation.',
    `transport_allowance` DECIMAL(18,2) COMMENT 'Allowance paid to cover employee commuting or field transportation costs. Commonly provided to national staff in urban and peri-urban duty stations as part of the total compensation package.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this payslip record was last modified in the source system or Silver Layer. Tracks corrections, status changes, and reprocessing events for data lineage and audit purposes.',
    `voluntary_deductions` DECIMAL(18,2) COMMENT 'Total of all employee-elected voluntary deductions for the pay period, including staff association fees, health insurance premiums, loan repayments, savings scheme contributions, and other authorised deductions.',
    CONSTRAINT pk_payslip PRIMARY KEY(`payslip_id`)
) COMMENT 'Individual payslip record for each staff member per payroll cycle, serving as SSOT for both payroll run processing (pay period start/end dates, payroll group — national/international/expat, run sequence number, run status, batch approval, total run aggregates) and individual pay details (gross salary, allowances — housing/hardship/field/expat, statutory deductions — income tax/social security/pension, voluntary deductions, net pay in local and payment currencies). Multi-currency supported for international operations across 50+ countries. Includes payment method, bank details reference, and payroll run approval chain. Supports BvA (Budget vs Actual) payroll cost allocation to grants and programs, donor audit requirements, and statutory payroll reporting.';

CREATE OR REPLACE TABLE `ngo_ecm`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique system-generated identifier for the performance review record. Primary key for the performance_review data product in the Workday HCM-sourced workforce domain.',
    `award_id` BIGINT COMMENT 'Reference to the primary grant funding the employees position during the review period. Supports donor-funded staff performance reporting requirements under USAID, DFID, CERF, and OMB Uniform Guidance 2 CFR 200.',
    `intervention_id` BIGINT COMMENT 'Reference to the primary humanitarian or development program to which the employee was assigned during the review period. Links performance outcomes to program results for RBM and donor reporting.',
    `position_id` BIGINT COMMENT 'Reference to the organizational position held by the employee at the time of the review, capturing role context for benchmarking and talent analytics.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member (reviewee) who is the subject of this performance review. Links to the employee master record in Workday HCM.',
    `reviewer_staff_member_id` BIGINT COMMENT 'Reference to the staff member (manager or designated reviewer) who conducted and submitted this performance review. Supports Results-Based Management (RBM) accountability chains.',
    `accountability_rating` STRING COMMENT 'Rating assessing the employees demonstrated accountability to affected populations and beneficiaries, a core CHS and HAP requirement for all humanitarian staff. Reflects adherence to feedback mechanisms and complaint handling.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `collaboration_rating` STRING COMMENT 'Rating for the collaboration and partnership competency, assessing the employees effectiveness in working across teams, with partner organizations (CSOs, CBOs, INGOs), and with beneficiary communities.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `competency_rating_score` DECIMAL(18,2) COMMENT 'Composite numeric score reflecting the employees average rating across all behavioral competencies assessed in the review (e.g., leadership, collaboration, accountability, humanitarian principles). Supports talent development analytics.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the performance review record was first created in the system (Workday HCM or the Databricks Silver Layer ingestion). Supports audit trail and data lineage requirements.',
    `development_recommendations` STRING COMMENT 'Structured recommendations from the reviewer for the employees professional development, including suggested training, mentoring, stretch assignments, or Learning Management System (LMS) courses to address identified gaps.',
    `duty_station` STRING COMMENT 'The geographic location (country, city, or field base) where the employee was deployed during the review period. Critical for field operations context, hardship allowance eligibility, and OCHA/USAID/BHA donor reporting.',
    `duty_station_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the employee was stationed during the review period. Enables geographic workforce analytics and cross-country performance benchmarking.. Valid values are `^[A-Z]{3}$`',
    `employee_acknowledged` BOOLEAN COMMENT 'Indicates whether the employee has formally acknowledged the performance review in Workday HCM. Required for HR audit compliance and CHS accountability to affected populations standards.',
    `employee_acknowledged_date` DATE COMMENT 'The date on which the reviewed employee formally acknowledged receipt and review of their performance appraisal in Workday HCM. Required for HAP and CHS accountability compliance.',
    `employee_comments` STRING COMMENT 'Free-text comments submitted by the employee at the time of acknowledgment, capturing their response to the review outcome, including any disagreements, additional context, or commitments for the next period.',
    `employee_disagreement_flag` BOOLEAN COMMENT 'Indicates whether the employee formally disputed or disagreed with the performance review outcome. Triggers the HR grievance and appeals process in accordance with organizational HR policy and CHS accountability standards.',
    `employee_self_assessment` STRING COMMENT 'Free-text self-assessment narrative submitted by the employee prior to the review meeting, documenting their own perspective on achievements, challenges, and development needs during the review period.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when the performance review record was most recently modified in the system. Tracks the full edit history for audit compliance and data quality monitoring in the Databricks Silver Layer.',
    `leadership_rating` STRING COMMENT 'Rating for the leadership competency dimension, assessing the employees ability to guide teams, make decisions under pressure, and drive program outcomes in humanitarian field contexts.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `next_review_date` DATE COMMENT 'The planned date for the employees next performance review or check-in, as agreed during the current review meeting. Supports proactive HR scheduling and talent management planning.',
    `objective_achievement_score` DECIMAL(18,2) COMMENT 'Composite percentage score (0–100) reflecting the degree to which the employee achieved their defined performance objectives during the review period. Derived from individual objective ratings in Workday HCM and used in RBM and LogFrame reporting.',
    `overall_rating` STRING COMMENT 'The holistic performance rating assigned to the employee for the review period, reflecting the reviewers consolidated assessment across all competencies and objectives. Drives talent retention, promotion, and RBM reporting decisions.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric score corresponding to the overall performance rating on the configured rating scale (e.g., 1.00–5.00). Enables quantitative talent analytics, benchmarking, and Results-Based Management (RBM) reporting.',
    `pip_required` BOOLEAN COMMENT 'Indicates whether a formal Performance Improvement Plan (PIP) has been recommended or initiated as a result of this review, typically triggered by an unsatisfactory or needs_improvement overall rating.',
    `promotion_recommendation` BOOLEAN COMMENT 'Indicates whether the reviewer recommends the employee for promotion or advancement to a higher grade or responsibility level based on this review cycles performance outcomes.',
    `rating_scale_version` STRING COMMENT 'Version identifier of the performance rating scale applied in this review (e.g., v2.1-2024). Ensures historical comparability as rating scales evolve over time.',
    `retention_risk_flag` BOOLEAN COMMENT 'Indicates whether the reviewer or HR has flagged this employee as at risk of leaving the organization, enabling proactive talent retention interventions. Supports NGO workforce stability in high-turnover humanitarian contexts.',
    `review_cycle_type` STRING COMMENT 'Classification of the performance review cycle that this appraisal belongs to. Distinguishes annual appraisals, mid-year check-ins, probationary reviews, end-of-contract assessments, and ad hoc reviews triggered by specific events.. Valid values are `annual|mid_year|probation|end_of_contract|ad_hoc`',
    `review_due_date` DATE COMMENT 'The deadline by which the performance review must be completed and submitted by the reviewer. Used for HR compliance tracking and manager accountability reporting.',
    `review_meeting_date` DATE COMMENT 'The date on which the formal performance review discussion meeting took place between the reviewer and the employee. Distinct from the submission date; required for CHS accountability documentation.',
    `review_number` STRING COMMENT 'Externally-visible, human-readable business identifier for the performance review record (e.g., PR-2024-000123). Used in HR correspondence, audit trails, and donor-funded program compliance reporting.. Valid values are `^PR-[0-9]{4}-[0-9]{6}$`',
    `review_period_end_date` DATE COMMENT 'The last day of the performance period being evaluated in this review. Together with review_period_start_date, defines the full appraisal window.',
    `review_period_start_date` DATE COMMENT 'The first day of the performance period being evaluated in this review. Defines the temporal boundary for objective achievement and behavioral observation.',
    `review_status` STRING COMMENT 'Current lifecycle state of the performance review workflow in Workday HCM. Tracks progression from draft through manager completion to employee acknowledgment and final closure.. Valid values are `draft|in_progress|pending_acknowledgment|completed|cancelled`',
    `review_submitted_date` DATE COMMENT 'The date on which the reviewer formally submitted the completed performance review in Workday HCM. Used to measure timeliness compliance against the review due date.',
    `reviewer_narrative` STRING COMMENT 'Free-text qualitative narrative provided by the reviewer summarizing the employees performance, key achievements, areas for improvement, and behavioral observations during the review period. Confidential HR record.',
    `staff_category` STRING COMMENT 'Classification of the employees staff category at the time of the review. Distinguishes national staff, international staff, expatriates, consultants, and volunteers, which affects applicable HR policies, review templates, and donor reporting requirements.. Valid values are `national_staff|international_staff|expatriate|consultant|volunteer`',
    `technical_skills_rating` STRING COMMENT 'Rating for the employees technical competency relevant to their functional role (e.g., MEAL methodology, WASH engineering, GBV case management, financial stewardship, ICT4D). Supports targeted learning and development planning.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `values_alignment_rating` STRING COMMENT 'Rating assessing the degree to which the employee demonstrates alignment with the NGOs core organizational values and humanitarian principles (e.g., humanity, neutrality, impartiality, accountability). Critical for CHS compliance and organizational culture.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Formal performance appraisal record for a staff member covering a defined review period. Captures review cycle (annual, mid-year, probation), overall rating, competency ratings, objective achievement scores, reviewer identity, reviewee acknowledgment, and development recommendations. Supports Ngos talent retention and results-based management (RBM) culture.';

CREATE OR REPLACE TABLE `ngo_ecm`.`workforce`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique system-generated identifier for each leave request record in the Workday HCM system. Serves as the primary key for the leave_request data product.',
    `staff_member_id` BIGINT COMMENT 'Reference to the manager or HR officer responsible for approving or rejecting this leave request. Supports RACI role assignments and delegation of authority tracking.',
    `employment_contract_id` BIGINT COMMENT 'Foreign key linking to workforce.employment_contract. Business justification: A leave request is governed by the terms of a specific employment contract — leave entitlements, RnR cycle eligibility, and carry-forward rules are all defined at the contract level. Adding employment',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Leave requests are associated with the staff members organizational unit for headcount planning, leave coverage management, and cost allocation. Adding org_unit_id normalizes the cost_center_code den',
    `primary_leave_staff_member_id` BIGINT COMMENT 'Reference to the staff member submitting the leave request. Links to the employee master record in Workday HCM covering national staff, international staff, and expatriate personnel.',
    `actual_days_taken` DECIMAL(18,2) COMMENT 'Number of working days actually taken by the staff member. Populated upon return from leave and used to update leave balance entitlements. Supports half-day precision.',
    `actual_end_date` DATE COMMENT 'The actual date on which the staff member returned from leave. May differ from requested_end_date due to early return, extension, or operational recall.',
    `actual_start_date` DATE COMMENT 'The actual date on which the staff member commenced their approved leave. May differ from requested_start_date due to operational adjustments or late approvals.',
    `approval_status` STRING COMMENT 'Current workflow state of the leave request lifecycle in Workday HCM. Tracks progression from initial submission through managerial review to final decision or cancellation.. Valid values are `draft|pending|approved|rejected|cancelled|withdrawn`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the approver made the final approval or rejection decision on the leave request. Null if the request is still pending or in draft state.',
    `approver_comments` STRING COMMENT 'Free-text notes entered by the approving manager or HR officer when approving, rejecting, or modifying the leave request. Supports audit trail and communication.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the leave request was cancelled or withdrawn, either by the employee or by HR. Null if the request was not cancelled.',
    `carry_forward_days` DECIMAL(18,2) COMMENT 'Number of unused leave days carried forward from the previous leave year that are being applied to this request. Subject to organizational carry-forward policy limits.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the leave request record was first created in the data platform. Used for audit trail and data lineage tracking.',
    `duty_station_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the staff members duty station at the time of the leave request. Determines applicable leave policy, public holiday calendar, and R&R eligibility for field staff.. Valid values are `^[A-Z]{3}$`',
    `emergency_contact_available` BOOLEAN COMMENT 'Indicates whether the staff member has confirmed they can be reached in an emergency during their leave period. Particularly relevant for field staff and humanitarian response contexts.',
    `entitlement_days` DECIMAL(18,2) COMMENT 'Total number of days the staff member is entitled to for the applicable leave type in the current leave year, as defined by their contract, grade, and duty station policy.',
    `handover_completed` BOOLEAN COMMENT 'Indicates whether the staff member has completed a formal handover of duties and responsibilities before commencing leave. Critical for field operations continuity and program delivery.',
    `is_retroactive` BOOLEAN COMMENT 'Indicates whether this leave request was submitted after the leave period had already commenced or concluded (retroactive entry). Flags exceptions for HR compliance review and audit.',
    `is_rnr_eligible` BOOLEAN COMMENT 'Indicates whether the staff member is eligible for Rest and Recuperation (R&R) leave based on their duty station hardship classification. True for staff posted to hardship or non-family duty stations per OCHA/UNDSS security phase criteria.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the leave request record, including status changes, date amendments, or approver updates.',
    `leave_balance_after` DECIMAL(18,2) COMMENT 'The staff members remaining leave balance (in days) for the applicable leave type after the leave has been taken and confirmed. Updated upon return from leave.',
    `leave_balance_before` DECIMAL(18,2) COMMENT 'The staff members available leave balance (in days) for the applicable leave type at the time the request was submitted. Enables entitlement validation and balance tracking.',
    `leave_destination_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the staff member will spend their leave. Required for R&R and annual leave for international/expatriate staff for security tracking and travel authorization.. Valid values are `^[A-Z]{3}$`',
    `leave_reason` STRING COMMENT 'Free-text description of the reason provided by the staff member for the leave request. May contain sensitive personal information (e.g., medical, family). Classified as confidential.',
    `leave_type` STRING COMMENT 'Classification of the leave being requested. Covers standard humanitarian workforce leave categories: Annual (vacation), Sick, Maternity/Paternity, Rest and Recuperation (R&R) for field staff, Compassionate (bereavement/family emergency), and Time Off In Lieu (TOIL) for overtime compensation.. Valid values are `annual|sick|maternity_paternity|rest_and_recuperation|compassionate|time_off_in_lieu`',
    `leave_year` STRING COMMENT 'The calendar or fiscal year to which this leave request applies (e.g., 2024). Used for annual entitlement tracking, carry-forward calculations, and year-end reporting.',
    `medical_certificate_received` BOOLEAN COMMENT 'Indicates whether the required medical certificate has been received and verified by HR. Relevant for sick leave requests where documentation is mandatory per organizational policy.',
    `medical_certificate_required` BOOLEAN COMMENT 'Indicates whether a medical certificate is required for this leave request based on leave type and duration policy (e.g., sick leave exceeding 3 consecutive days). Drives compliance workflow in Workday HCM.',
    `program_code` STRING COMMENT 'Code identifying the program or project to which the staff members time is allocated during the leave period. Supports grant financial management and indirect cost rate (ICR/NICRA) calculations.',
    `rejection_reason` STRING COMMENT 'Structured or free-text reason provided by the approver when rejecting a leave request. Required for rejected requests to support employee relations and grievance management.',
    `request_number` STRING COMMENT 'Externally visible, human-readable reference number assigned to the leave request (e.g., LR-2024-000123). Used in correspondence, approvals, and audit trails.. Valid values are `^LR-[0-9]{4}-[0-9]{6}$`',
    `requested_days` DECIMAL(18,2) COMMENT 'Number of working days requested for the leave period, as submitted by the employee. Supports half-day increments (e.g., 0.5). Excludes weekends and public holidays per the applicable country calendar.',
    `requested_end_date` DATE COMMENT 'The date the staff member has requested their leave to end (inclusive). Combined with requested_start_date to determine the requested duration.',
    `requested_start_date` DATE COMMENT 'The date the staff member has requested their leave to begin. Used for scheduling, coverage planning, and field rotation management.',
    `rnr_cycle_days` STRING COMMENT 'The number of days between R&R breaks applicable to the staff members duty station (e.g., 42 days, 56 days, 84 days). Determined by the hardship classification of the duty station.',
    `security_clearance_confirmed` BOOLEAN COMMENT 'Indicates whether the staff members travel to the leave destination has been cleared by the security team. Required for international staff and field personnel traveling to or from high-risk areas.',
    `staff_category` STRING COMMENT 'Classification of the staff members employment category at the time of the leave request. Determines applicable leave policy, entitlement rules, and R&R eligibility. National staff, international staff, and expatriates may have different leave frameworks.. Valid values are `national|international|expatriate|consultant|volunteer`',
    `submission_timestamp` TIMESTAMP COMMENT 'The date and time when the staff member formally submitted the leave request in Workday HCM. Serves as the principal business event timestamp for the transaction lifecycle.',
    `supporting_document_ref` STRING COMMENT 'Reference number or file path to supporting documentation attached to the leave request (e.g., medical certificate for sick leave, death certificate for compassionate leave). Stored in the document management system.',
    `toil_hours_accrued` DECIMAL(18,2) COMMENT 'Number of overtime hours accrued by the staff member that are being converted to Time Off In Lieu (TOIL). Applicable only for TOIL leave type requests. Supports overtime compensation tracking.',
    `workday_leave_request_reference` STRING COMMENT 'The native leave request identifier from the Workday HCM source system. Enables traceability back to the system of record for reconciliation and audit purposes.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Staff leave request and approval record capturing leave type (annual, sick, maternity/paternity, R&R, compassionate, TOIL), requested start date, end date, number of days, approval status, approver, and actual dates taken. Tracks leave balances and entitlements per staff member and supports field rotation and R&R scheduling for humanitarian staff.';

CREATE OR REPLACE TABLE `ngo_ecm`.`workforce`.`staff_assignment` (
    `staff_assignment_id` BIGINT COMMENT 'Unique system-generated identifier for each staff assignment record in Workday HCM. Serves as the primary key for the staff_assignment data product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Staff costs charged under partnership agreements must be traceable to the specific agreement for donor reporting, effort certification, and audit compliance. This direct link supports IATI reporting a',
    `award_id` BIGINT COMMENT 'Reference to the grant funding this assignment. Used for donor-compliant effort reporting and payroll cost allocation to the correct funding source per OMB Uniform Guidance 2 CFR 200.',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: Staff assignments consume specific budget lines for personnel costs; FK enables effort certification, budget vs. actual personnel cost tracking, and NICRA compliance reporting — fundamental for NGO gr',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Staff assignments drive cost center charges for effort certification and NICRA compliance; FK enables direct linkage between staff effort allocation and cost center financial reporting, a core NGO gra',
    `country_office_id` BIGINT COMMENT 'Reference to the geographic duty station or field office where the staff member is deployed for this assignment. Supports field operations tracking and hardship/hazard pay calculations.',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Donor agreements include key personnel clauses and nationality/qualification requirements for assigned staff. NGO grants management requires verifying each staff assignment satisfies applicable donor ',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Surge and emergency response staff assignments are made against specific declared emergencies. Donor accountability reports, emergency response plans, and HR surge capacity tracking all require linkin',
    `employment_contract_id` BIGINT COMMENT 'Foreign key linking to workforce.employment_contract. Business justification: A staff assignment is governed by a specific employment contract — the contract defines the terms under which the staff member is deployed (salary, allowances, contract type). Adding employment_contra',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Staff assignments are funded by specific grants/funds; FK enables fund-level effort tracking and donor-required effort certification reporting, critical for USAID and other institutional donor complia',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian or development program to which the staff member is assigned. Enables program-level workforce planning and MEL accountability mapping.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: A staff assignment captures the role being performed during the assignment period. job_profile is the SSOT for role definitions including competencies, pay grade, and responsibilities. Adding job_prof',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Staff assignments to programs, projects, or grants should reference the organizational unit for proper cost allocation, reporting hierarchy, and matrix management visibility. While staff_assignment ha',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: NGOs regularly deploy staff to partner organizations (technical assistance, secondments, embedded advisors). Linking staff assignments to the partner org enables tracking of partner-deployed staff, lo',
    `position_id` BIGINT COMMENT 'Reference to the organizational position or job profile associated with this assignment in Workday HCM. Determines the role title, grade, and compensation band applicable to the assignment.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member record in the workforce master data. Links the assignment to the individual employee or contractor being assigned.',
    `project_site_id` BIGINT COMMENT 'Reference to the specific project or sub-component within a program to which the staff member is assigned. Supports project-level cost allocation and effort reporting.',
    `tertiary_workforce_approved_by_staff_member_id` BIGINT COMMENT 'Reference to the staff member (typically HR manager or program director) who approved this assignment in Workday HCM. Supports authorization audit trails and accountability documentation.',
    `approved_date` DATE COMMENT 'The date on which the staff assignment was formally approved through the Workday HCM business process workflow. Marks the transition from draft to active status and establishes the authorization audit trail.',
    `assignment_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this staff assignment, used in donor reports, effort certification forms, and cross-system references (e.g., ASN-2024-WASH-001). Sourced from Workday HCM assignment reference number.. Valid values are `^ASN-[A-Z0-9]{4,12}$`',
    `assignment_notes` STRING COMMENT 'Free-text field for additional context, special conditions, or operational notes related to this staff assignment. May include information on acting capacity, special donor conditions, or field-specific requirements not captured in structured fields.',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the staff assignment record. draft indicates pending approval; active indicates currently deployed; on_hold indicates temporarily suspended; completed indicates successfully concluded; cancelled indicates terminated before completion.. Valid values are `draft|active|on_hold|completed|cancelled`',
    `assignment_type` STRING COMMENT 'Classification of the nature of the staff assignment. primary indicates the main assignment; secondary indicates a concurrent partial assignment; surge_deployment indicates emergency response deployment; tdy (Temporary Duty) indicates short-term field deployment; secondment indicates inter-agency placement; consultant indicates contracted technical assistance.. Valid values are `primary|secondary|surge_deployment|tdy|secondment|consultant`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this staff assignment record was first created in the data platform (Silver Layer). Supports audit trail, data lineage, and compliance with record-keeping requirements under OMB Uniform Guidance and IATI transparency standards.',
    `duty_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the staff member is deployed for this assignment (e.g., SSD for South Sudan, HTI for Haiti). Used for hardship classification, tax treaty application, and OCHA country-level reporting.. Valid values are `^[A-Z]{3}$`',
    `effort_certification_required` BOOLEAN COMMENT 'Indicates whether this assignment requires periodic effort certification by the staff member or supervisor (True), as mandated for federally-funded grants under OMB Uniform Guidance 2 CFR 200 §200.430. Drives the effort certification workflow in the GMS.',
    `effort_percent` DECIMAL(18,2) COMMENT 'The percentage of the staff members total working time allocated to this specific assignment, expressed as a decimal percentage (e.g., 50.00 for 50%). Must sum to 100% across all active assignments for a staff member. Critical for donor-compliant effort reporting and payroll cost allocation to grants per OMB Uniform Guidance 2 CFR 200 §200.430.',
    `end_date` DATE COMMENT 'The date on which the staff members assignment concludes. Nullable for open-ended assignments. Used to determine assignment duration, payroll allocation periods, and grant charge eligibility windows.',
    `fte_equivalent` DECIMAL(18,2) COMMENT 'The full-time equivalent value of this assignment, calculated as effort_percent / 100. For example, a 50% assignment equals 0.50 FTE. Used for workforce capacity planning, budget forecasting, and donor reporting on staffing levels.',
    `funding_source_type` STRING COMMENT 'Classification of the funding source underwriting this assignment. Determines applicable compliance requirements: federal_grant triggers OMB Uniform Guidance; bilateral_donor (e.g., USAID, DFID) triggers donor-specific reporting; cost_share indicates matching contribution. [ENUM-REF-CANDIDATE: federal_grant|private_grant|bilateral_donor|multilateral_donor|unrestricted_funds|cost_share — promote to reference product]. Valid values are `federal_grant|private_grant|bilateral_donor|multilateral_donor|unrestricted_funds|cost_share`',
    `grant_code` STRING COMMENT 'The donor-assigned grant or award code to which payroll costs for this assignment are charged. Used in the Chart of Accounts (CoA) for fund accounting and donor financial reporting. Aligns with the grant identifier in SAP S/4HANA and Unit4 ERP.. Valid values are `^[A-Z0-9-]{3,30}$`',
    `hardship_level` STRING COMMENT 'The UN/ICSC hardship classification level for the duty station of this assignment (A=normal; B=some hardship; C=hardship; D=extreme hardship; E=unaccompanied). Determines hardship allowance entitlements and R&R (Rest and Recuperation) schedules for international and expatriate staff.. Valid values are `A|B|C|D|E`',
    `is_cost_shared` BOOLEAN COMMENT 'Indicates whether the payroll costs for this assignment are shared across multiple grants or funding sources (True). When True, the effort_percent and grant_code fields define the primary allocation, and supplementary cost-share records exist for the remaining allocation.',
    `is_field_deployment` BOOLEAN COMMENT 'Indicates whether this assignment involves deployment to a field or humanitarian response location (True) as opposed to a headquarters or regional office posting (False). Used to trigger field-specific HR policies, security protocols, and allowance calculations.',
    `is_surge_deployment` BOOLEAN COMMENT 'Indicates whether this assignment is classified as a surge deployment in response to an acute humanitarian emergency (True). Surge deployments trigger expedited onboarding, emergency per diem rates, and OCHA SitRep staffing reporting.',
    `last_effort_certified_date` DATE COMMENT 'The date on which the most recent effort certification was completed and approved for this assignment. Used to track compliance with periodic effort reporting requirements under OMB Uniform Guidance and donor agreements.',
    `raci_role` STRING COMMENT 'The RACI role assigned to the staff member for this program or project assignment. responsible indicates the person doing the work; accountable indicates the person ultimately answerable for outcomes; consulted indicates subject matter experts providing input; informed indicates stakeholders kept up to date. Supports accountability matrices and governance documentation.. Valid values are `responsible|accountable|consulted|informed`',
    `safeguarding_training_completed` BOOLEAN COMMENT 'Indicates whether the staff member has completed mandatory safeguarding and protection training prior to or during this assignment (True). Required by CHS Alliance Core Humanitarian Standard and donor compliance frameworks for all field deployments.',
    `security_clearance_level` STRING COMMENT 'The security clearance level required and held by the staff member for this assignment. Relevant for assignments in conflict-affected or high-security environments. classified indicates government-level clearance for assignments with bilateral donors such as USAID or DFID.. Valid values are `none|basic|enhanced|classified`',
    `staff_category` STRING COMMENT 'Classification of the staff members employment category for this assignment. Determines applicable HR policies, compensation structures, tax treatment, and donor reporting requirements. expatriate indicates internationally-recruited staff deployed outside home country; national_staff indicates locally-recruited personnel.. Valid values are `national_staff|international_staff|expatriate|consultant|volunteer|intern`',
    `start_date` DATE COMMENT 'The date on which the staff members assignment to the program, project, or field operation begins. Used for payroll cost allocation period calculations and effort reporting compliance.',
    `tdy_purpose` STRING COMMENT 'Description of the business purpose for a Temporary Duty (TDY) assignment, such as emergency response support, capacity building mission, or program assessment. Required for TDY travel authorization and donor reporting. Applicable only when assignment_type = tdy.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this staff assignment record was most recently modified in the data platform. Used for change tracking, incremental data loads, and audit compliance.',
    `workday_assignment_ref` STRING COMMENT 'The source system reference identifier for this assignment record in Workday HCM. Enables traceability back to the system of record for reconciliation, audit, and data lineage purposes.',
    CONSTRAINT pk_staff_assignment PRIMARY KEY(`staff_assignment_id`)
) COMMENT 'Record of a staff members assignment to a specific program, project, grant, or field operation, capturing assignment type (primary, secondary, surge deployment, TDY/temporary duty), percentage of time allocated, funding source (grant code), duty station, start date, end date, and RACI role (Responsible, Accountable, Consulted, Informed). Enables time-based payroll cost allocation to grants, supports donor-compliant effort reporting, and tracks RACI role assignments across programs for accountability matrices.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ADD CONSTRAINT `fk_workforce_staff_member_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `ngo_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ADD CONSTRAINT `fk_workforce_staff_member_supervisor_staff_member_id` FOREIGN KEY (`supervisor_staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `ngo_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `ngo_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `ngo_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_position_id` FOREIGN KEY (`position_id`) REFERENCES `ngo_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_employment_contract_id` FOREIGN KEY (`employment_contract_id`) REFERENCES `ngo_ecm`.`workforce`.`employment_contract`(`employment_contract_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_original_payslip_id` FOREIGN KEY (`original_payslip_id`) REFERENCES `ngo_ecm`.`workforce`.`payslip`(`payslip_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `ngo_ecm`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_position_id` FOREIGN KEY (`position_id`) REFERENCES `ngo_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_reviewer_staff_member_id` FOREIGN KEY (`reviewer_staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_employment_contract_id` FOREIGN KEY (`employment_contract_id`) REFERENCES `ngo_ecm`.`workforce`.`employment_contract`(`employment_contract_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_primary_leave_staff_member_id` FOREIGN KEY (`primary_leave_staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ADD CONSTRAINT `fk_workforce_staff_assignment_employment_contract_id` FOREIGN KEY (`employment_contract_id`) REFERENCES `ngo_ecm`.`workforce`.`employment_contract`(`employment_contract_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ADD CONSTRAINT `fk_workforce_staff_assignment_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `ngo_ecm`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ADD CONSTRAINT `fk_workforce_staff_assignment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `ngo_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ADD CONSTRAINT `fk_workforce_staff_assignment_position_id` FOREIGN KEY (`position_id`) REFERENCES `ngo_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ADD CONSTRAINT `fk_workforce_staff_assignment_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ADD CONSTRAINT `fk_workforce_staff_assignment_tertiary_workforce_approved_by_staff_member_id` FOREIGN KEY (`tertiary_workforce_approved_by_staff_member_id`) REFERENCES `ngo_ecm`.`workforce`.`staff_member`(`staff_member_id`);

-- ========= TAGS =========
ALTER SCHEMA `ngo_ecm`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `ngo_ecm`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` SET TAGS ('dbx_subdomain' = 'staff_records');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Member ID');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `supervisor_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Staff Member ID');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `supervisor_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `supervisor_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'permanent|fixed_term|consultancy|secondment|internship|volunteer_staff');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `duty_station` SET TAGS ('dbx_business_glossary_term' = 'Duty Station');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `duty_station_country` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Country (ISO 3166-1 Alpha-3)');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `duty_station_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Full Name');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_value_regex' = 'spouse|parent|sibling|child|friend|other');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `employee_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Number');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `employee_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `employee_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|suspended|separated|probation');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'national_staff|international_staff|expatriate|field_personnel|headquarters');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `exit_interview_completed` SET TAGS ('dbx_business_glossary_term' = 'Exit Interview Completed Flag');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `final_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Settlement Amount');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `final_settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `gender` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Legal First Name');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Nationality (ISO 3166-1 Alpha-3 Country Code)');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `nationality` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `nationality` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `passport_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Passport Expiry Date');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `passport_expiry_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `passport_expiry_date` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `passport_number` SET TAGS ('dbx_business_glossary_term' = 'Passport Number');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `passport_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `passport_number` SET TAGS ('dbx_pii_passport' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'monthly|bi_weekly|weekly|semi_monthly');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `probation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Probation End Date');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `rehire_eligible` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligibility Flag');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `salary_currency` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency (ISO 4217)');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `salary_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `salary_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `salary_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `separation_date` SET TAGS ('dbx_business_glossary_term' = 'Separation Effective Date');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `separation_reason` SET TAGS ('dbx_business_glossary_term' = 'Separation Reason Narrative');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `separation_type` SET TAGS ('dbx_business_glossary_term' = 'Separation Type');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `separation_type` SET TAGS ('dbx_value_regex' = 'resignation|end_of_contract|redundancy|termination|retirement|death_in_service');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `work_email` SET TAGS ('dbx_business_glossary_term' = 'Work Email Address');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `work_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `work_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `work_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `work_permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Expiry Date');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Number');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `work_phone` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number (E.164 Format)');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `work_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `work_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `workday_worker_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Human Resource Information System (HRIS) Worker ID');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `workday_worker_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_member` ALTER COLUMN `workday_worker_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'staff_records');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Host Partner Org Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `reports_to_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reports-To Position ID');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Incumbent Worker ID');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `availability_date` SET TAGS ('dbx_business_glossary_term' = 'Position Availability Date');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `budgeted_annual_cost` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Annual Cost');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `budgeted_annual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `duty_station` SET TAGS ('dbx_business_glossary_term' = 'Duty Station');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `duty_station_country_code` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Country Code');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `duty_station_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Position End Date');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `filled_date` SET TAGS ('dbx_business_glossary_term' = 'Position Filled Date');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `funding_source_type` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Type');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `funding_source_type` SET TAGS ('dbx_value_regex' = 'grant|core|split|in-kind|cost-share');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `headcount_plan_year` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Year');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `icr_applicable` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR) Applicable Indicator');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `is_field_position` SET TAGS ('dbx_business_glossary_term' = 'Field Position Indicator');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `is_supervisory` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Position Indicator');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `is_vacant` SET TAGS ('dbx_business_glossary_term' = 'Position Vacancy Indicator');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `job_description_url` SET TAGS ('dbx_business_glossary_term' = 'Job Description URL');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `max_salary` SET TAGS ('dbx_business_glossary_term' = 'Maximum Salary');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `max_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `min_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `min_salary` SET TAGS ('dbx_business_glossary_term' = 'Minimum Salary');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `min_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `min_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years of Experience');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `pay_grade_band` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Band');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `pay_grade_band` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,3}[0-9]{1,3}$');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `pay_grade_band` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^POS-[A-Z0-9]{4,12}$');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'open|filled|frozen|eliminated|proposed');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'permanent|fixed-term|temporary|secondment|volunteer');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `raci_role` SET TAGS ('dbx_business_glossary_term' = 'Responsible Accountable Consulted Informed (RACI) Role');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `raci_role` SET TAGS ('dbx_value_regex' = 'responsible|accountable|consulted|informed');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `required_competencies` SET TAGS ('dbx_business_glossary_term' = 'Required Competencies');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `required_languages` SET TAGS ('dbx_business_glossary_term' = 'Required Languages');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `security_clearance_required` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Required Indicator');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `staff_category` SET TAGS ('dbx_business_glossary_term' = 'Staff Category');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `staff_category` SET TAGS ('dbx_value_regex' = 'national|international|expatriate|consultant|intern');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `vacancy_reason` SET TAGS ('dbx_business_glossary_term' = 'Vacancy Reason');
ALTER TABLE `ngo_ecm`.`workforce`.`position` ALTER COLUMN `workday_position_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday HCM Position ID');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` SET TAGS ('dbx_subdomain' = 'staff_records');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `employment_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract ID');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Secondment Partner Org Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `amendment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment Effective Date');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment Number');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment Reason');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Date');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Contract Approved By');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract Number');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4}-[A-Z0-9]{4,10}$');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract Status');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|on_hold|terminated|expired|amended');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract Type');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'fixed_term|open_ended|consultancy|secondment|internship|volunteer');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `duty_station` SET TAGS ('dbx_business_glossary_term' = 'Duty Station');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `duty_station_country_code` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Country Code');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `duty_station_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `education_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Education Allowance Amount');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `education_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `education_allowance_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `hardship_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Hardship Allowance Amount');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `hardship_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `hardship_allowance_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `hardship_tier` SET TAGS ('dbx_business_glossary_term' = 'Hardship Allowance Tier');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `hardship_tier` SET TAGS ('dbx_value_regex' = 'H|A|B|C|D|E');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `home_leave_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Home Leave Frequency (Months)');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `housing_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Housing Allowance Amount');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `housing_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `housing_allowance_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `icr_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `icr_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `ingo_salary_scale` SET TAGS ('dbx_business_glossary_term' = 'International Non-Governmental Organization (INGO) Salary Scale');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `ingo_salary_scale` SET TAGS ('dbx_value_regex' = 'un_common_system|organizational_scale|national_scale|icsc_scale|other');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `ingo_salary_scale` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `ingo_salary_scale` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `is_expatriate` SET TAGS ('dbx_business_glossary_term' = 'Expatriate Staff Indicator');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `labor_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Labor Law Jurisdiction');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `medevac_coverage_level` SET TAGS ('dbx_business_glossary_term' = 'Medical Evacuation (MEDEVAC) Coverage Level');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `medevac_coverage_level` SET TAGS ('dbx_value_regex' = 'basic|standard|enhanced|full');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period (Days)');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `probation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Probation Period End Date');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `relocation_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Relocation Allowance Amount');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `relocation_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `relocation_allowance_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `rnr_cycle_weeks` SET TAGS ('dbx_business_glossary_term' = 'Rest and Recuperation (R&R) Cycle (Weeks)');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_frequency` SET TAGS ('dbx_business_glossary_term' = 'Salary Payment Frequency');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_frequency` SET TAGS ('dbx_value_regex' = 'monthly|bi_weekly|weekly|annual');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_frequency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_frequency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_grade` SET TAGS ('dbx_business_glossary_term' = 'Salary Grade');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_step` SET TAGS ('dbx_business_glossary_term' = 'Salary Step');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_step` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `staff_category` SET TAGS ('dbx_business_glossary_term' = 'Staff Category');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `staff_category` SET TAGS ('dbx_value_regex' = 'international|national|third_country_national|consultant|secondee');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Reason');
ALTER TABLE `ngo_ecm`.`workforce`.`employment_contract` ALTER COLUMN `workday_contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday HCM Contract Reference ID');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'staff_records');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager ID');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `annual_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget (USD)');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `annual_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `city_name` SET TAGS ('dbx_business_glossary_term' = 'City Name');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `funding_model` SET TAGS ('dbx_business_glossary_term' = 'Funding Model');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `funding_model` SET TAGS ('dbx_value_regex' = 'core|grant_funded|mixed|self_funded');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `headcount_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Headcount');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `headcount_authorized` SET TAGS ('dbx_business_glossary_term' = 'Authorized Headcount');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `iati_org_identifier` SET TAGS ('dbx_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Organization Identifier');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `icr_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `icr_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `international_staff_count` SET TAGS ('dbx_business_glossary_term' = 'International Staff Count');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `is_field_office` SET TAGS ('dbx_business_glossary_term' = 'Is Field Office Flag');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `is_hq` SET TAGS ('dbx_business_glossary_term' = 'Is Headquarters Flag');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `mandate_description` SET TAGS ('dbx_business_glossary_term' = 'Mandate Description');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `national_staff_count` SET TAGS ('dbx_business_glossary_term' = 'National Staff Count');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `office_address` SET TAGS ('dbx_business_glossary_term' = 'Office Address');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `office_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `office_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `office_email` SET TAGS ('dbx_business_glossary_term' = 'Office Email Address');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `office_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `office_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `office_email` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `office_phone` SET TAGS ('dbx_business_glossary_term' = 'Office Phone Number');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `office_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `office_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `office_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|dissolved|merged');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `region_name` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Name');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `sap_company_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Company Code');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `sap_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Phase Level');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'phase1|phase2|phase3|phase4|phase5');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_mission_statement` SET TAGS ('dbx_business_glossary_term' = 'Unit Mission Statement');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_short_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Short Name');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `volunteer_count` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Count');
ALTER TABLE `ngo_ecm`.`workforce`.`org_unit` ALTER COLUMN `workday_org_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Organization ID');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` SET TAGS ('dbx_subdomain' = 'staff_records');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `background_check_level` SET TAGS ('dbx_business_glossary_term' = 'Background Check Level');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `background_check_level` SET TAGS ('dbx_value_regex' = 'standard|enhanced|criminal_record|child_protection|not_required');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `competency_framework_code` SET TAGS ('dbx_business_glossary_term' = 'Competency Framework Code');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `competency_framework_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `core_competencies` SET TAGS ('dbx_business_glossary_term' = 'Core Competencies');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `duty_station_type` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Type');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `duty_station_type` SET TAGS ('dbx_value_regex' = 'headquarters|country_office|field_office|remote|roving');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|fixed_term|casual|secondment');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `field_experience_required` SET TAGS ('dbx_business_glossary_term' = 'Field Experience Required');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `flsa_exemption_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Exemption Status');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `flsa_exemption_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt|not_applicable');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `icr_cost_category` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR) Cost Category');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `icr_cost_category` SET TAGS ('dbx_value_regex' = 'direct|indirect|shared');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `is_critical_role` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Role');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `is_safeguarding_designated` SET TAGS ('dbx_business_glossary_term' = 'Is Safeguarding Designated Role');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_category` SET TAGS ('dbx_business_glossary_term' = 'Job Category');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_category` SET TAGS ('dbx_value_regex' = 'national_staff|international_staff|expatriate|consultant|volunteer|intern');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_family_group_name` SET TAGS ('dbx_business_glossary_term' = 'Job Family Group Name');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_family_name` SET TAGS ('dbx_business_glossary_term' = 'Job Family Name');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_family_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_family_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `key_responsibilities` SET TAGS ('dbx_business_glossary_term' = 'Key Responsibilities');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `language_requirements` SET TAGS ('dbx_business_glossary_term' = 'Language Requirements');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `leadership_competencies` SET TAGS ('dbx_business_glossary_term' = 'Leadership Competencies');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `management_level` SET TAGS ('dbx_business_glossary_term' = 'Management Level');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `management_level` SET TAGS ('dbx_value_regex' = 'individual_contributor|team_lead|manager|senior_manager|director|executive');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `min_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `min_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years of Experience');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,3}[0-9]{1,3}$');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade_max_usd` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Maximum (USD)');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade_max_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade_midpoint_usd` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Midpoint (USD)');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade_midpoint_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade_min_usd` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Minimum (USD)');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `pay_grade_min_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `preferred_certifications` SET TAGS ('dbx_business_glossary_term' = 'Preferred Certifications');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Code');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Name');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Status');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|under_review|archived');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `program_area` SET TAGS ('dbx_business_glossary_term' = 'Program Area');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `succession_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Succession Eligibility');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `summary` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Summary');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `travel_requirement` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `travel_requirement` SET TAGS ('dbx_value_regex' = 'none|occasional|frequent|extensive|field_based');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `workday_job_profile_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday HCM Job Profile ID');
ALTER TABLE `ngo_ecm`.`workforce`.`job_profile` ALTER COLUMN `workday_job_profile_reference` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9_-]{1,50}$');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` SET TAGS ('dbx_subdomain' = 'payroll_operations');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `statutory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Registration Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|on_hold');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Count');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `grant_code` SET TAGS ('dbx_business_glossary_term' = 'Grant Code');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `icr_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `is_retroactive` SET TAGS ('dbx_business_glossary_term' = 'Is Retroactive Flag');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Notes');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|mobile_money|check|cash|prepaid_card');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_group` SET TAGS ('dbx_business_glossary_term' = 'Payroll Group');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_group` SET TAGS ('dbx_value_regex' = 'national_staff|international_staff|expat|volunteer|consultant');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `processed_by` SET TAGS ('dbx_business_glossary_term' = 'Processed By');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `retroactive_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Period Start Date');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Number');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_number` SET TAGS ('dbx_value_regex' = '^PR-[0-9]{4}-[0-9]{2}-[0-9]{4}$');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Status');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|calculated|approved|paid|cancelled');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Type');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'regular|off_cycle|supplemental|correction|final');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Deductions');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_deductions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_employer_contributions` SET TAGS ('dbx_business_glossary_term' = 'Total Employer Contributions');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_employer_contributions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Pay');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Net Pay');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Withheld');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payroll_run` ALTER COLUMN `workday_run_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Run ID');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` SET TAGS ('dbx_subdomain' = 'payroll_operations');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `payslip_id` SET TAGS ('dbx_business_glossary_term' = 'Payslip ID');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `employment_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `original_payslip_id` SET TAGS ('dbx_business_glossary_term' = 'Original Payslip ID');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Reference');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `employer_pension_contribution` SET TAGS ('dbx_business_glossary_term' = 'Employer Pension Contribution');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `employer_pension_contribution` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `employer_social_security` SET TAGS ('dbx_business_glossary_term' = 'Employer Social Security Contribution');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `employer_social_security` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `expat_allowance` SET TAGS ('dbx_business_glossary_term' = 'Expatriate (Expat) Allowance');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `expat_allowance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `expat_allowance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `field_allowance` SET TAGS ('dbx_business_glossary_term' = 'Field Allowance');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `field_allowance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `field_allowance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `gross_salary` SET TAGS ('dbx_business_glossary_term' = 'Gross Salary');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `gross_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `gross_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `hardship_allowance` SET TAGS ('dbx_business_glossary_term' = 'Hardship Allowance');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `hardship_allowance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `hardship_allowance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `housing_allowance` SET TAGS ('dbx_business_glossary_term' = 'Housing Allowance');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `housing_allowance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `housing_allowance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `income_tax_deduction` SET TAGS ('dbx_business_glossary_term' = 'Income Tax Deduction');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `income_tax_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `income_tax_deduction` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `is_correction` SET TAGS ('dbx_business_glossary_term' = 'Payslip Correction Flag');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `is_off_cycle` SET TAGS ('dbx_business_glossary_term' = 'Off-Cycle Payroll Flag');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `net_pay_local` SET TAGS ('dbx_business_glossary_term' = 'Net Pay (Local Currency)');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `net_pay_local` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `net_pay_local` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `net_pay_payment_currency` SET TAGS ('dbx_business_glossary_term' = 'Net Pay (Payment Currency)');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `net_pay_payment_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `net_pay_payment_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|cash|mobile_money|cheque');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `payroll_group` SET TAGS ('dbx_business_glossary_term' = 'Payroll Group');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `payroll_group` SET TAGS ('dbx_value_regex' = 'national|international|expat|consultant');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `payroll_run_sequence` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Sequence Number');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `payslip_number` SET TAGS ('dbx_business_glossary_term' = 'Payslip Number');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `payslip_number` SET TAGS ('dbx_value_regex' = '^PSL-[A-Z]{2,4}-[0-9]{4}-[0-9]{2}-[0-9]{6}$');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `payslip_status` SET TAGS ('dbx_business_glossary_term' = 'Payslip Status');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `payslip_status` SET TAGS ('dbx_value_regex' = 'generated|issued|reversed|corrected');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `pension_deduction` SET TAGS ('dbx_business_glossary_term' = 'Pension Deduction');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `pension_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `pension_deduction` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Status');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'draft|calculated|approved|paid|reversed|cancelled');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `social_security_deduction` SET TAGS ('dbx_business_glossary_term' = 'Social Security Deduction');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `social_security_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `social_security_deduction` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `total_allowances` SET TAGS ('dbx_business_glossary_term' = 'Total Allowances');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `total_allowances` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `total_allowances` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `total_statutory_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Statutory Deductions');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `total_statutory_deductions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `total_statutory_deductions` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `transport_allowance` SET TAGS ('dbx_business_glossary_term' = 'Transport Allowance');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `transport_allowance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `transport_allowance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `voluntary_deductions` SET TAGS ('dbx_business_glossary_term' = 'Voluntary Deductions');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `voluntary_deductions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`payslip` ALTER COLUMN `voluntary_deductions` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'payroll_operations');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `accountability_rating` SET TAGS ('dbx_business_glossary_term' = 'Accountability to Affected Populations Rating');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `accountability_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `collaboration_rating` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Competency Rating');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `collaboration_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Competency Rating Score');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `development_recommendations` SET TAGS ('dbx_business_glossary_term' = 'Development Recommendations');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `development_recommendations` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `duty_station` SET TAGS ('dbx_business_glossary_term' = 'Duty Station');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `duty_station_country_code` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Country Code');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `duty_station_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledged` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Flag');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledged_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Date');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Review Comments');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_disagreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Employee Disagreement Flag');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_disagreement_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_self_assessment` SET TAGS ('dbx_business_glossary_term' = 'Employee Self-Assessment Narrative');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_self_assessment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `leadership_rating` SET TAGS ('dbx_business_glossary_term' = 'Leadership Competency Rating');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `leadership_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `objective_achievement_score` SET TAGS ('dbx_business_glossary_term' = 'Objective Achievement Score');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating Score');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `pip_required` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Required Flag');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `pip_required` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `promotion_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Promotion Recommendation Flag');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `promotion_recommendation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `rating_scale_version` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale Version');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `retention_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Retention Risk Flag');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `retention_risk_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Type');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_cycle_type` SET TAGS ('dbx_value_regex' = 'annual|mid_year|probation|end_of_contract|ad_hoc');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Review Meeting Date');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Number');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_number` SET TAGS ('dbx_value_regex' = '^PR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Status');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|pending_acknowledgment|completed|cancelled');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Review Submitted Date');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_narrative` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Narrative Comments');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_narrative` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `staff_category` SET TAGS ('dbx_business_glossary_term' = 'Staff Category');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `staff_category` SET TAGS ('dbx_value_regex' = 'national_staff|international_staff|expatriate|consultant|volunteer');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `technical_skills_rating` SET TAGS ('dbx_business_glossary_term' = 'Technical Skills Competency Rating');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `technical_skills_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `values_alignment_rating` SET TAGS ('dbx_business_glossary_term' = 'Organizational Values Alignment Rating');
ALTER TABLE `ngo_ecm`.`workforce`.`performance_review` ALTER COLUMN `values_alignment_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` SET TAGS ('dbx_subdomain' = 'payroll_operations');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request ID');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `employment_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `actual_days_taken` SET TAGS ('dbx_business_glossary_term' = 'Actual Leave Days Taken');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Leave End Date');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Leave Start Date');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Approval Status');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected|cancelled|withdrawn');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Leave Approval Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `approver_comments` SET TAGS ('dbx_business_glossary_term' = 'Approver Comments');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Leave Cancellation Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `carry_forward_days` SET TAGS ('dbx_business_glossary_term' = 'Carry Forward Leave Days');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `duty_station_country` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Country Code');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `duty_station_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `emergency_contact_available` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Available Flag');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `entitlement_days` SET TAGS ('dbx_business_glossary_term' = 'Annual Leave Entitlement Days');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `handover_completed` SET TAGS ('dbx_business_glossary_term' = 'Handover Completed Flag');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `is_retroactive` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Leave Request Flag');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `is_rnr_eligible` SET TAGS ('dbx_business_glossary_term' = 'Rest and Recuperation (R&R) Eligibility Flag');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance After Request');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance Before Request');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_destination_country` SET TAGS ('dbx_business_glossary_term' = 'Leave Destination Country Code');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_destination_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_reason` SET TAGS ('dbx_business_glossary_term' = 'Leave Reason');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_value_regex' = 'annual|sick|maternity_paternity|rest_and_recuperation|compassionate|time_off_in_lieu');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_year` SET TAGS ('dbx_business_glossary_term' = 'Leave Year');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_received` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Received Flag');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_received` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_received` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Required Flag');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Leave Rejection Reason');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Number');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^LR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `requested_days` SET TAGS ('dbx_business_glossary_term' = 'Requested Leave Days');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `requested_end_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Leave End Date');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `requested_start_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Leave Start Date');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `rnr_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Rest and Recuperation (R&R) Cycle Days');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `security_clearance_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Confirmed Flag');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `staff_category` SET TAGS ('dbx_business_glossary_term' = 'Staff Category');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `staff_category` SET TAGS ('dbx_value_regex' = 'national|international|expatriate|consultant|volunteer');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Submission Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `supporting_document_ref` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `toil_hours_accrued` SET TAGS ('dbx_business_glossary_term' = 'Time Off In Lieu (TOIL) Hours Accrued');
ALTER TABLE `ngo_ecm`.`workforce`.`leave_request` ALTER COLUMN `workday_leave_request_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Leave Request System ID');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` SET TAGS ('dbx_subdomain' = 'payroll_operations');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `staff_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Assignment ID');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Duty Station ID');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `employment_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Staff ID');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `tertiary_workforce_approved_by_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Staff ID');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `tertiary_workforce_approved_by_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `tertiary_workforce_approved_by_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Approved Date');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `assignment_code` SET TAGS ('dbx_business_glossary_term' = 'Assignment Code');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `assignment_code` SET TAGS ('dbx_value_regex' = '^ASN-[A-Z0-9]{4,12}$');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'draft|active|on_hold|completed|cancelled');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|surge_deployment|tdy|secondment|consultant');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `duty_country_code` SET TAGS ('dbx_business_glossary_term' = 'Duty Country Code');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `duty_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `effort_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Effort Certification Required Indicator');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `effort_percent` SET TAGS ('dbx_business_glossary_term' = 'Effort Percentage');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `fte_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE)');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `funding_source_type` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Type');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `funding_source_type` SET TAGS ('dbx_value_regex' = 'federal_grant|private_grant|bilateral_donor|multilateral_donor|unrestricted_funds|cost_share');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `grant_code` SET TAGS ('dbx_business_glossary_term' = 'Grant Code');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `grant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,30}$');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `hardship_level` SET TAGS ('dbx_business_glossary_term' = 'Hardship Level');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `hardship_level` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `is_cost_shared` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Indicator');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `is_field_deployment` SET TAGS ('dbx_business_glossary_term' = 'Field Deployment Indicator');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `is_surge_deployment` SET TAGS ('dbx_business_glossary_term' = 'Surge Deployment Indicator');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `last_effort_certified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Effort Certification Date');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `raci_role` SET TAGS ('dbx_business_glossary_term' = 'RACI (Responsible Accountable Consulted Informed) Role');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `raci_role` SET TAGS ('dbx_value_regex' = 'responsible|accountable|consulted|informed');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `safeguarding_training_completed` SET TAGS ('dbx_business_glossary_term' = 'Safeguarding Training Completed Indicator');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_value_regex' = 'none|basic|enhanced|classified');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `staff_category` SET TAGS ('dbx_business_glossary_term' = 'Staff Category');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `staff_category` SET TAGS ('dbx_value_regex' = 'national_staff|international_staff|expatriate|consultant|volunteer|intern');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `tdy_purpose` SET TAGS ('dbx_business_glossary_term' = 'Temporary Duty (TDY) Purpose');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ngo_ecm`.`workforce`.`staff_assignment` ALTER COLUMN `workday_assignment_ref` SET TAGS ('dbx_business_glossary_term' = 'Workday HCM Assignment Reference');
