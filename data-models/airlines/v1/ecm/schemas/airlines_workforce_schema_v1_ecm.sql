-- Schema for Domain: workforce | Business: Airlines | Version: v1_ecm
-- Generated on: 2026-05-07 12:58:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `airlines_ecm`.`workforce` COMMENT 'Human resources and workforce management including employee master records, organisational hierarchy, payroll, benefits administration, training certifications (type ratings, recurrent training), performance management, recruitment, union agreements, labor relations, headcount planning, and organisational structure. Manages all airline staff including pilots, cabin crew, ground staff, and corporate employees. Aligns with SAP S/4HANA HR module.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee. Primary key. System of record: SAP S/4HANA HR PA master (Infotype 0001).',
    `job_classification_id` BIGINT COMMENT 'Foreign key linking to workforce.job_classification. Business justification: Employees job classification should reference the master job_classification table for grade structure, pay bands, and job family. The STRING job_classification attribute should be replaced by FK to t',
    `union_agreement_id` BIGINT COMMENT 'Foreign key linking to workforce.union_agreement. Business justification: Employees union membership should reference the master union_agreement for CBA terms, pay scales, and labor relations. The union_code is an attribute of union_agreement and should be retrieved via JO',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Employee should reference their authorized position in the organizational structure. The job_title is an attribute of position and should be retrieved via JOIN. This links employees to the position ma',
    `cost_center_code` STRING COMMENT 'Cost center to which the employees salary and benefits are charged. Used for financial reporting and budget allocation.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was first created in the HR system.',
    `date_of_birth` DATE COMMENT 'Date of birth of the employee. Used for age verification, retirement planning, and benefits eligibility.',
    `department_code` STRING COMMENT 'Code representing the organizational department or division to which the employee is assigned.. Valid values are `^[A-Z0-9]{2,8}$`',
    `email_address` STRING COMMENT 'Primary corporate email address for the employee. Used for official communication and system access.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Full name of the employees designated emergency contact person.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the employees designated emergency contact person.',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact to the employee (e.g., spouse, parent, sibling, friend).',
    `employee_number` STRING COMMENT 'Externally-known unique employee number assigned by HR system. Business identifier used on badges, payroll, and HR documents.. Valid values are `^[A-Z0-9]{6,12}$`',
    `employment_status` STRING COMMENT 'Current lifecycle status of the employees employment relationship with the airline.. Valid values are `active|inactive|suspended|leave|terminated|retired`',
    `employment_type` STRING COMMENT 'Type of employment contract. ACMI indicates crew leased under Aircraft Crew Maintenance Insurance agreements.. Valid values are `permanent|contract|temporary|seasonal|acmi|intern`',
    `first_name` STRING COMMENT 'Legal first name of the employee as recorded in HR master data.',
    `hire_date` DATE COMMENT 'Date the employee was hired or commenced employment with the airline. Used for seniority calculations, benefits eligibility, and tenure reporting.',
    `home_base_airport_code` STRING COMMENT 'IATA 3-letter code of the employees home base airport. Critical for crew scheduling, commute planning, and operational assignments.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was last updated in the HR system.',
    `last_name` STRING COMMENT 'Legal last name (surname) of the employee as recorded in HR master data.',
    `last_performance_review_date` DATE COMMENT 'Date of the employees most recent performance review or appraisal.',
    `medical_certificate_expiry_date` DATE COMMENT 'Expiration date of the employees aviation medical certificate. Monitored to ensure crew remain medically qualified for flight duties.',
    `medical_certificate_status` STRING COMMENT 'Current status of the employees aviation medical certificate. Required for pilots and cabin crew per FAA/EASA regulations.. Valid values are `valid|expired|suspended|pending|not_required`',
    `middle_name` STRING COMMENT 'Middle name or initial of the employee, if applicable.',
    `nationality` STRING COMMENT 'Nationality of the employee represented as ISO 3166-1 alpha-3 country code. Critical for visa, work permit, and crew scheduling compliance.. Valid values are `^[A-Z]{3}$`',
    `passport_expiry_date` DATE COMMENT 'Expiration date of the employees passport. Monitored to ensure crew remain travel-eligible for international operations.',
    `passport_number` STRING COMMENT 'Passport number of the employee. Required for international crew operations and travel authorization.',
    `performance_rating` STRING COMMENT 'Most recent performance appraisal rating for the employee. Used for promotion decisions, compensation adjustments, and talent management.. Valid values are `outstanding|exceeds|meets|needs_improvement|unsatisfactory`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the employee. May be mobile or landline.',
    `salary_grade` STRING COMMENT 'Salary grade or pay band assigned to the employee. Used for compensation planning and equity analysis.',
    `seniority_date` DATE COMMENT 'Date used to calculate employee seniority for bidding, scheduling, and union contract purposes. May differ from hire date due to transfers or breaks in service.',
    `termination_date` DATE COMMENT 'Date the employees employment was terminated or ended. Null for active employees.',
    `union_membership_flag` BOOLEAN COMMENT 'Indicates whether the employee is a member of a labor union. Critical for labor relations, collective bargaining, and contract compliance.',
    `work_permit_expiry_date` DATE COMMENT 'Expiration date of the employees work permit or visa. Monitored to ensure continuous legal employment status.',
    `work_permit_status` STRING COMMENT 'Current status of the employees work permit or visa authorization. Critical for legal employment compliance.. Valid values are `not_required|valid|expired|pending|revoked`',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Core master entity representing all airline staff — pilots, cabin crew, ground staff, maintenance technicians, and corporate employees. SSOT for employee identity, employment status, job classification, cost centre assignment, and HR master data. Captures employee number, hire date, employment type (permanent, contract, ACMI), home base airport (IATA code), union membership flag, nationality, visa/work permit status, and emergency contact. Aligns with SAP S/4HANA HR PA master (Infotype 0001/0002).';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the organizational unit. Primary key.',
    `parent_org_unit_id` BIGINT COMMENT 'Reference to the parent organizational unit in the hierarchy, enabling multi-level organizational structure representation.',
    `address_line1` STRING COMMENT 'Primary street address line for the organizational units physical location.',
    `address_line2` STRING COMMENT 'Secondary street address line (suite, floor, building) for the organizational units physical location.',
    `city` STRING COMMENT 'City where the organizational unit is physically located.',
    `contact_email` STRING COMMENT 'Primary email address for organizational unit correspondence and communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for organizational unit contact.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the organizational unit is domiciled.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was first created in the system.',
    `effective_from_date` DATE COMMENT 'Date when this organizational unit became or will become active, supporting organizational restructuring and time-dependent hierarchy.',
    `effective_to_date` DATE COMMENT 'Date when this organizational unit was or will be dissolved or restructured. Null for currently active units with no planned end date.',
    `functional_area` STRING COMMENT 'Primary business function or operational domain of the organizational unit, aligned with IATA functional area classifications. [ENUM-REF-CANDIDATE: flight_operations|cabin_services|mro|ground_handling|cargo|revenue_management|network_planning|corporate|finance|hr|it|safety|compliance — 13 candidates stripped; promote to reference product]',
    `headcount_actual` STRING COMMENT 'Current actual full-time equivalent headcount assigned to this organizational unit.',
    `headcount_planned` STRING COMMENT 'Planned or budgeted full-time equivalent headcount for this organizational unit.',
    `iata_functional_code` STRING COMMENT 'IATA standard functional area code for airline organizational classification and industry benchmarking.. Valid values are `^[A-Z]{2,4}$`',
    `is_hub` BOOLEAN COMMENT 'Flag indicating whether this organizational unit is located at or supports a hub airport in the airlines network.',
    `is_revenue_generating` BOOLEAN COMMENT 'Flag indicating whether this organizational unit directly generates revenue (e.g., flight operations, cargo) versus support functions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was last updated.',
    `location_code` STRING COMMENT 'IATA three-letter airport or city code representing the primary geographic location of this organizational unit.. Valid values are `^[A-Z]{3}$`',
    `org_level` STRING COMMENT 'Hierarchical level of the organizational unit within the overall structure (e.g., 1=corporate, 2=division, 3=department, 4=section).',
    `org_unit_code` STRING COMMENT 'Business identifier code for the organizational unit, used across systems and reporting. May align with IATA functional area codes or internal cost center codes.. Valid values are `^[A-Z0-9]{2,20}$`',
    `org_unit_description` STRING COMMENT 'Detailed description of the organizational units purpose, responsibilities, and scope of operations.',
    `org_unit_name` STRING COMMENT 'Full business name of the organizational unit (e.g., Flight Operations Division, Cabin Services Department, MRO Engineering).',
    `org_unit_status` STRING COMMENT 'Current lifecycle status of the organizational unit.. Valid values are `active|inactive|planned|dissolved|suspended`',
    `org_unit_type` STRING COMMENT 'Classification of the organizational unit by structural type within the airline hierarchy. [ENUM-REF-CANDIDATE: division|department|cost_center|functional_unit|station|hub|regional_office|corporate — 8 candidates stripped; promote to reference product]',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the organizational units physical location.',
    `profit_center_code` STRING COMMENT 'Profit center code for revenue-generating organizational units, used in management accounting and profitability analysis.. Valid values are `^[A-Z0-9]{4,12}$`',
    `region` STRING COMMENT 'Geographic region or area classification for the organizational unit (e.g., North America, Europe, Asia Pacific).',
    `regulatory_oversight_authority` STRING COMMENT 'Primary regulatory authority with jurisdiction over this organizational units operations (e.g., FAA, EASA, national CAA).',
    `safety_critical_flag` BOOLEAN COMMENT 'Indicates whether this organizational unit performs safety-critical functions requiring SMS (Safety Management System) oversight and regulatory compliance.',
    `short_name` STRING COMMENT 'Abbreviated name or acronym for the organizational unit, used in reports and displays.',
    `state_province` STRING COMMENT 'State or province where the organizational unit is physically located.',
    `union_representation_flag` BOOLEAN COMMENT 'Indicates whether employees in this organizational unit are covered by collective bargaining agreements or union representation.',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organisational hierarchy master defining all departments, divisions, cost centres, and functional units within the airline. Supports the full SAP S/4HANA HR organisational management structure including parent-child relationships, org unit type (flight ops, cabin services, MRO, ground handling, corporate), effective dates for restructuring, and IATA functional area codes. Enables headcount planning and workforce analytics by organisational node.';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Primary key for position',
    `job_classification_id` BIGINT COMMENT 'Foreign key linking to workforce.job_classification. Business justification: Positions job code should reference the master job_classification table for job family, pay grade, and FLSA status. The job_code STRING attribute should be replaced by FK to the authoritative master.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Position should reference its organizational unit for hierarchy and cost allocation. The organizational_unit_code and cost_center are attributes of org_unit and should be retrieved via JOIN. This link',
    `reports_to_position_id` BIGINT COMMENT 'Foreign key reference to the position that this position reports to in the organizational hierarchy. Null for top-level executive positions.',
    `union_agreement_id` BIGINT COMMENT 'Foreign key linking to workforce.union_agreement. Business justification: Position should reference the union agreement that governs the bargaining unit for labor relations and CBA compliance. The union_bargaining_unit is an attribute of union_agreement and should be retrie',
    `base_station_code` STRING COMMENT 'IATA three-letter airport code for the crew base or work location assigned to this position. Determines domicile for crew scheduling and commuting eligibility.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the position record was first created in the system. Used for audit trail and data lineage.',
    `crew_category` STRING COMMENT 'Classification of the position within airline operational crew structure. Determines regulatory training requirements, duty time limitations, and operational authority. [ENUM-REF-CANDIDATE: captain|first_officer|cabin_crew|flight_dispatcher|ground_staff|maintenance_engineer|corporate|not_applicable — 8 candidates stripped; promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date when the position was retired or made obsolete. Null for active positions. Used for historical analysis and organizational restructuring tracking.',
    `effective_start_date` DATE COMMENT 'Date when the position became active in the organizational structure. Used for historical tracking and organizational change management.',
    `exempt_status` BOOLEAN COMMENT 'Indicates whether the position is exempt from overtime pay regulations under labor law (True) or non-exempt and eligible for overtime (False).',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Full-time equivalent allocation for the position. 1.00 represents a full-time position; fractional values represent part-time or shared positions.',
    `grade_band` STRING COMMENT 'Compensation grade or pay band assigned to the position. Determines salary range, benefits eligibility, and career progression path.. Valid values are `^[A-Z0-9]{1,5}$`',
    `icao_licence_category` STRING COMMENT 'ICAO-defined licence category required for the position (e.g., ATPL, CPL, cabin crew attestation). Applicable to flight crew and safety-critical operational positions.',
    `language_requirements` STRING COMMENT 'Language proficiency requirements for the position (e.g., English ICAO Level 4, Mandarin fluent). Critical for flight crew and customer-facing positions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the position record was last updated. Used for change tracking and audit purposes.',
    `medical_class_required` STRING COMMENT 'Aviation medical certificate class required for the position per regulatory standards. Class 1 for airline transport pilots, Class 2 for commercial pilots, Class 3 for air traffic controllers.. Valid values are `class_1|class_2|class_3|not_required`',
    `minimum_education_level` STRING COMMENT 'Minimum educational qualification required for the position. Used for recruitment screening and succession planning. [ENUM-REF-CANDIDATE: high_school|associate|bachelor|master|doctorate|professional_certification|not_specified — 7 candidates stripped; promote to reference product]',
    `minimum_flight_hours` STRING COMMENT 'Minimum total flight hours required for the position. Applicable to flight crew positions. Used for recruitment and internal promotion eligibility.',
    `modified_by_user` STRING COMMENT 'User identifier of the person who last modified the position record. Used for audit trail and accountability.',
    `position_code` STRING COMMENT 'Unique business identifier for the position within the organizational structure. Used for HR reporting and organizational planning.. Valid values are `^[A-Z0-9]{6,12}$`',
    `position_description` STRING COMMENT 'Detailed description of the positions responsibilities, duties, and scope of authority. Used for recruitment, performance management, and organizational planning.',
    `position_status` STRING COMMENT 'Current lifecycle status of the position within the organizational structure. Active positions can be filled; frozen positions are temporarily unavailable; obsolete positions are retired.. Valid values are `active|frozen|obsolete|planned|pending_approval`',
    `required_certifications` STRING COMMENT 'Professional certifications or qualifications required for the position (e.g., A&P licence, dispatch licence, safety auditor certification). Multiple certifications separated by semicolon.',
    `safety_critical_flag` BOOLEAN COMMENT 'Indicates whether the position is designated as safety-critical per regulatory requirements. Safety-critical positions require enhanced background checks, medical certification, and recurrent training.',
    `security_clearance_level` STRING COMMENT 'Security clearance or background check level required for the position. Determines access to secure areas, sensitive information, and critical systems.. Valid values are `none|basic|enhanced|top_secret`',
    `seniority_list_code` STRING COMMENT 'Code identifying the seniority list or bidding group for the position. Used in crew scheduling, vacation bidding, and base assignment processes.. Valid values are `^[A-Z0-9]{2,8}$`',
    `shift_pattern` STRING COMMENT 'Standard shift or duty pattern for the position (e.g., day shift, rotating shifts, reserve duty, line holder). Applicable to operational and crew positions.',
    `title` STRING COMMENT 'Official job title for the position as it appears in organizational charts and HR systems.',
    `type_rating_required` STRING COMMENT 'Aircraft type rating(s) required for the position (e.g., B737, A320, B777). Applicable to pilot and flight engineer positions. Multiple ratings separated by semicolon.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Master entity defining all authorised positions (posts) within the airline organisational structure. Each position is a slot in the org chart that can be filled by an employee. Captures position title, job code, grade band, FTE allocation, required qualifications, crew category (Captain, First Officer, Cabin Crew, Dispatcher, etc.), ICAO licence category requirement, union bargaining unit, and whether the position is safety-critical per regulatory requirements.';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`job_classification` (
    `job_classification_id` BIGINT COMMENT 'Unique identifier for the job classification record. Primary key.',
    `union_agreement_id` BIGINT COMMENT 'Foreign key linking to workforce.union_agreement. Business justification: Job classification should reference the union agreement that governs the bargaining unit. The bargaining_unit is an attribute of union_agreement and should be retrieved via JOIN. This links job classi',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this job classification record was first created in the HR system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the pay grade amounts. Typically the airlines reporting currency or local currency for regional operations.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this job classification was or will be retired or superseded. Null for currently active classifications. Used for temporal validity and historical analysis of organizational structure evolution.',
    `effective_start_date` DATE COMMENT 'Date when this job classification became or will become effective and available for use in the HR system. Used for temporal validity and historical tracking of job structure changes.',
    `eligible_for_bonus` BOOLEAN COMMENT 'Indicates whether employees in this job classification are eligible for annual performance bonus or incentive compensation. Used for compensation planning and total rewards calculations.',
    `eligible_for_stock` BOOLEAN COMMENT 'Indicates whether employees in this job classification are eligible for equity compensation such as stock options, restricted stock units, or employee stock purchase plans. Typically limited to management and executive positions.',
    `flsa_status` STRING COMMENT 'Classification under the US Fair Labor Standards Act indicating whether the position is exempt from overtime pay requirements (exempt) or eligible for overtime (non-exempt). Critical for payroll processing and labor law compliance.. Valid values are `exempt|non_exempt`',
    `iata_job_category` STRING COMMENT 'IATA standardized job category code used for industry benchmarking, salary surveys, and workforce analytics across airlines. Enables comparison with industry peers.',
    `icao_occupational_category` STRING COMMENT 'ICAO standardized occupational category code for aviation-specific roles. Used for international regulatory reporting and workforce statistics submitted to ICAO.',
    `is_executive` BOOLEAN COMMENT 'Indicates whether this job classification is an executive-level position (C-suite, senior vice president, or equivalent). Used for executive compensation programs, board reporting, and regulatory disclosures.',
    `is_management` BOOLEAN COMMENT 'Indicates whether this job classification is a management or supervisory position with direct reports. Used for leadership development programs, management training, and organizational structure analysis.',
    `job_classification_status` STRING COMMENT 'Current lifecycle status of this job classification. Active classifications are available for hiring and assignment. Inactive classifications are temporarily suspended. Obsolete classifications are retired and no longer used. Pending classifications are under review before activation.. Valid values are `active|inactive|obsolete|pending`',
    `job_code` STRING COMMENT 'Unique alphanumeric code identifying the job classification within the airlines human resources system. Used for position identification, payroll processing, and workforce planning.. Valid values are `^[A-Z0-9]{4,12}$`',
    `job_description` STRING COMMENT 'Detailed narrative description of the job responsibilities, duties, and accountabilities. Used for job postings, performance management, and organizational documentation.',
    `job_family` STRING COMMENT 'High-level grouping of related jobs within the airline. Categories include Flight Deck (pilots), Cabin Crew (flight attendants), Technical/MRO (Maintenance Repair and Overhaul), Ground Operations, Commercial (sales, revenue management), Corporate (finance, HR, IT), Cargo, and Customer Service. [ENUM-REF-CANDIDATE: flight_deck|cabin_crew|technical_mro|ground_operations|commercial|corporate|cargo|customer_service — 8 candidates stripped; promote to reference product]',
    `job_subfamily` STRING COMMENT 'Secondary classification within the job family providing more granular segmentation. For example, within Flight Deck: Captain, First Officer, Second Officer; within Technical/MRO: Line Maintenance, Base Maintenance, Component Repair.',
    `job_title` STRING COMMENT 'Official job title as used in employment contracts, organizational charts, and external job postings. Human-readable name for the position.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this job classification record was last updated. Used for change tracking, audit trail, and data synchronization with downstream systems.',
    `license_type_required` STRING COMMENT 'Specific type of aviation license required for this position if applicable. Examples: ATPL (Airline Transport Pilot License), CPL (Commercial Pilot License), AME (Aircraft Maintenance Engineer), cabin crew attestation. Null if no license required.',
    `medical_class_required` STRING COMMENT 'Class of aviation medical certificate required for this position. Class 1 for airline pilots, Class 2 for commercial pilots, Class 3 for private pilots, Cabin Crew for flight attendants, Not Required for non-safety-sensitive roles.. Valid values are `class_1|class_2|class_3|cabin_crew|not_required`',
    `minimum_education_level` STRING COMMENT 'Minimum educational qualification required for this job classification. Used for recruitment, job posting, and candidate screening. Examples: high school diploma, bachelors degree, vocational certification. [ENUM-REF-CANDIDATE: high_school|associate|bachelor|master|doctorate|vocational|none — 7 candidates stripped; promote to reference product]',
    `minimum_experience_years` STRING COMMENT 'Minimum number of years of relevant work experience required for this job classification. Used for recruitment qualification screening and career progression planning.',
    `organizational_level` STRING COMMENT 'Numeric indicator of the positions level in the organizational hierarchy. Lower numbers represent higher levels (e.g., 1 = CEO, 2 = Executive VP, 3 = VP, etc.). Used for organizational charting and span-of-control analysis.',
    `pay_grade` STRING COMMENT 'Compensation grade or band assigned to this job classification. Used for salary benchmarking, compensation planning, and pay equity analysis. Links to the airlines compensation structure.. Valid values are `^[A-Z0-9]{1,6}$`',
    `pay_grade_maximum` DECIMAL(18,2) COMMENT 'Maximum annual base salary for this pay grade. Represents the ceiling for compensation within this classification without promotion.',
    `pay_grade_midpoint` DECIMAL(18,2) COMMENT 'Midpoint annual base salary for this pay grade representing the target compensation for fully competent performance. Used for market benchmarking and compa-ratio calculations.',
    `pay_grade_minimum` DECIMAL(18,2) COMMENT 'Minimum annual base salary for this pay grade in the airlines base currency. Used for compensation planning and offer letter generation.',
    `reports_to_job_code` STRING COMMENT 'Job code of the supervisory position to which this job classification typically reports. Defines the standard reporting relationship in the organizational hierarchy. Null for executive positions.',
    `requires_aviation_license` BOOLEAN COMMENT 'Indicates whether this job classification requires a valid aviation license issued by a civil aviation authority (e.g., pilot license, aircraft maintenance engineer license). True for flight deck crew, licensed aircraft maintenance engineers, and certain technical roles.',
    `requires_medical_certificate` BOOLEAN COMMENT 'Indicates whether this job classification requires a valid aviation medical certificate. True for flight deck crew, cabin crew, and certain safety-sensitive positions. Medical certificate class and validity period vary by role.',
    `requires_security_clearance` BOOLEAN COMMENT 'Indicates whether this job classification requires airport security clearance or background check per TSA or equivalent national aviation security authority. True for roles with access to secure areas, aircraft, or sensitive systems.',
    `requires_type_rating` BOOLEAN COMMENT 'Indicates whether this job classification requires aircraft type rating certification. True for pilots and flight engineers who must be certified on specific aircraft types (e.g., B737, A320, B777). Type ratings are aircraft-specific endorsements on pilot licenses.',
    `safety_sensitive` BOOLEAN COMMENT 'Indicates whether this job classification is designated as safety-sensitive under FAA or EASA regulations, requiring compliance with drug and alcohol testing programs, fatigue risk management, and enhanced safety oversight.',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'Standard number of work hours per week for this job classification. Used for full-time equivalency (FTE) calculations, workforce planning, and labor cost modeling. May be null for variable schedules.',
    `standard_work_schedule` STRING COMMENT 'Typical work schedule pattern for this job classification. Full-time (40 hours/week), part-time, variable (pilots, cabin crew with monthly schedules), shift work (ground operations, maintenance), or on-call (reserve crew).. Valid values are `full_time|part_time|variable|shift_work|on_call`',
    `union_eligible` BOOLEAN COMMENT 'Indicates whether employees in this job classification are eligible for union membership or collective bargaining representation. Varies by jurisdiction and airline labor agreements.',
    CONSTRAINT pk_job_classification PRIMARY KEY(`job_classification_id`)
) COMMENT 'Reference master defining the airlines job families, job codes, and grade structures used to classify all positions and employees. Captures job family (Flight Deck, Cabin Crew, Technical/MRO, Ground Operations, Commercial, Corporate), job code, pay grade band, ICAO/IATA occupational category, exempt/non-exempt status, and whether the role requires an aviation licence or medical certificate. Used for compensation benchmarking, headcount planning, and regulatory reporting.';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`employment_contract` (
    `employment_contract_id` BIGINT COMMENT 'Unique identifier for the employment contract record. Primary key.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Employment contract should reference the organizational unit for work location and cost center. The work_location_code is an attribute of org_unit and should be retrieved via JOIN. This normalizes wor',
    `previous_contract_employment_contract_id` BIGINT COMMENT 'Reference to the previous employment contract record if this contract supersedes or replaces an earlier contract for the same employee. Nullable for initial contracts.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is party to this employment contract.',
    `union_agreement_id` BIGINT COMMENT 'Foreign key linking to workforce.union_agreement. Business justification: Employment contract should reference the applicable union agreement for terms and conditions. The collective_bargaining_agreement_reference is an attribute of union_agreement and should be retrieved v',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Employment contract should reference the authorized position being filled. The job_title is an attribute of position and should be retrieved via JOIN. This links contracts to the position master and s',
    `base_salary` DECIMAL(18,2) COMMENT 'The fixed annual or monthly base compensation amount for the employee, excluding bonuses, allowances, and variable pay. For flight crew, this is the guaranteed minimum before flight pay.',
    `benefits_package_code` STRING COMMENT 'Code or identifier representing the benefits package assigned to this contract, including health insurance, retirement plans, travel privileges, and other perquisites. Different packages may apply to different employee categories.',
    `contract_document_url` STRING COMMENT 'URL or file path to the digitally stored employment contract document (PDF or electronic signature platform link). Confidential business data.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the employment contract, used in HR systems and legal documentation.',
    `contract_signed_date` DATE COMMENT 'Date when the employment contract was formally signed by both the employee and the airlines authorized representative.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the employment contract. Draft indicates contract is being prepared; active means contract is in force; suspended indicates temporary hold; terminated means contract ended before expiry; expired indicates natural end of fixed-term contract; pending approval awaits management or legal sign-off.. Valid values are `draft|active|suspended|terminated|expired|pending_approval`',
    `contract_type` STRING COMMENT 'Classification of the employment contract. Permanent indicates indefinite employment; fixed-term has a defined end date; zero-hours provides no guaranteed hours; ACMI (Aircraft Crew Maintenance Insurance) wet-lease crew are contracted for specific aircraft operations; agency workers are supplied by third-party agencies; seasonal contracts cover peak periods; probationary indicates trial period employment. [ENUM-REF-CANDIDATE: permanent|fixed_term|zero_hours|acmi_wet_lease|agency|seasonal|probationary — 7 candidates stripped; promote to reference product]',
    `contract_version` STRING COMMENT 'Version number of the contract document, incremented when contract terms are amended or renegotiated. Supports contract change history and audit trail.',
    `contracted_hours_per_week` DECIMAL(18,2) COMMENT 'Number of hours per week the employee is contracted to work. For flight crew, this may represent block hours or duty hours depending on airline policy. Zero-hours contracts will have 0.00.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this employment contract record was first created in the HR system. Supports audit trail and data lineage.',
    `employment_category` STRING COMMENT 'High-level classification of the employees role within the airline. Flight crew includes pilots; cabin crew includes flight attendants; ground staff includes airport and customer service personnel; maintenance includes MRO (Maintenance Repair and Overhaul) technicians; corporate includes office-based roles; management includes leadership positions.. Valid values are `flight_crew|cabin_crew|ground_staff|maintenance|corporate|management`',
    `end_date` DATE COMMENT 'Date when the employment contract expires or terminates. Nullable for permanent contracts with no defined end date.',
    `full_time_equivalent` DECIMAL(18,2) COMMENT 'Ratio representing the employees contracted hours as a proportion of full-time hours. 1.000 indicates full-time; 0.500 indicates half-time; 0.000 for zero-hours contracts.',
    `governing_jurisdiction` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the legal jurisdiction whose labor laws govern this employment contract (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `is_union_member` BOOLEAN COMMENT 'Boolean flag indicating whether the employee is a member of a labor union. True if union member; False if not. Relevant for collective bargaining coverage and labor relations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this employment contract record was last updated in the HR system. Supports audit trail and change tracking.',
    `notice_period_days` STRING COMMENT 'Number of days of advance notice required by either party to terminate the employment contract. Varies by seniority, role, and jurisdiction.',
    `pay_frequency` STRING COMMENT 'Frequency at which the employee receives salary payments. Monthly is standard for salaried staff; biweekly or weekly may apply to hourly or ground staff.. Valid values are `weekly|biweekly|monthly|quarterly|annual`',
    `probation_period_months` STRING COMMENT 'Duration of the probationary period in months during which the employees performance is evaluated before permanent status is confirmed. Nullable if no probation applies.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special conditions, or exceptions related to the employment contract (e.g., secondment details, special allowances, visa sponsorship notes).',
    `salary_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the base salary is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `start_date` DATE COMMENT 'Date when the employment contract becomes effective and the employee begins their employment relationship with the airline.',
    `termination_date` DATE COMMENT 'Actual date when the employment contract was terminated, either by resignation, dismissal, or mutual agreement. Nullable for active contracts.',
    `termination_reason` STRING COMMENT 'Reason for contract termination. Resignation indicates employee-initiated departure; dismissal indicates employer-initiated termination for cause; redundancy indicates position elimination; retirement indicates age or service-based exit; mutual agreement indicates negotiated separation; contract expiry indicates natural end of fixed-term contract.. Valid values are `resignation|dismissal|redundancy|retirement|mutual_agreement|contract_expiry`',
    `travel_privileges_tier` STRING COMMENT 'Classification tier for employee travel benefits (e.g., standby travel, confirmed seats, companion passes). Higher tiers typically apply to longer-tenured employees and flight crew. Airline-specific tier codes.',
    CONSTRAINT pk_employment_contract PRIMARY KEY(`employment_contract_id`)
) COMMENT 'Transactional master entity representing the formal employment agreement between the airline and an employee. Captures contract type (permanent, fixed-term, zero-hours, ACMI wet-lease crew, agency), start and end dates, contracted hours per week, base salary, currency, pay frequency, probation period, notice period, governing jurisdiction, applicable collective bargaining agreement (CBA) reference, and contract status. Aligns with SAP PA Infotype 0016 (Contract Elements).';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Unique identifier for the payroll processing cycle. Primary key for the payroll run entity.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Payroll runs must post to cost centers for labor cost allocation, financial reporting, and budget variance analysis. Essential for airline CASK calculation and operational cost management.',
    `employee_id` BIGINT COMMENT 'System user identifier of the payroll manager or authorized approver who approved this payroll run for payment. Required for segregation of duties and audit compliance.',
    `accounting_period` STRING COMMENT 'Fiscal period in YYYYPPP format where YYYY is fiscal year and PPP is period number (001-012 or 001-013 for special periods). Aligns payroll costs with financial reporting periods.. Valid values are `^[0-9]{4}[0-9]{3}$`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run received management approval to proceed to payment and posting. Critical control point in payroll workflow.',
    `calculation_end_timestamp` TIMESTAMP COMMENT 'Date and time when payroll calculation processing completed for this run. Used for performance monitoring and audit trail.',
    `calculation_start_timestamp` TIMESTAMP COMMENT 'Date and time when payroll calculation processing began for this run. Used for performance monitoring and audit trail.',
    `co_document_number` STRING COMMENT 'SAP Controlling document number generated when payroll costs were allocated to cost centers and internal orders. Links payroll run to management accounting for cost analysis.. Valid values are `^[0-9]{10}$`',
    `company_code` STRING COMMENT 'SAP organizational unit representing the legal entity for which this payroll run is executed. Used for financial reporting and statutory compliance at the legal entity level.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this payroll run. Typically matches the payroll areas local currency.. Valid values are `^[A-Z]{3}$`',
    `employee_count` STRING COMMENT 'Total number of employees included in this payroll run. Used for reconciliation and validation of payroll completeness.',
    `fi_document_number` STRING COMMENT 'SAP Financial Accounting document number generated when payroll was posted to General Ledger (GL). Links payroll run to accounting entries for reconciliation and audit.. Valid values are `^[0-9]{10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run record was last updated. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for payroll administrators to document special circumstances, processing exceptions, or other relevant information about this payroll run.',
    `off_cycle_reason` STRING COMMENT 'Business justification for executing an off-cycle payroll run outside the regular payroll schedule. Common reasons include termination settlements, bonus payments, or correction of prior period errors. Populated only when run_type is off_cycle.',
    `pay_date` DATE COMMENT 'Scheduled date when net pay will be disbursed to employees via bank transfer or other payment method. Typically follows payroll approval and posting.',
    `pay_period_end_date` DATE COMMENT 'Last day of the pay period covered by this payroll run. Defines the end of the earnings and deductions calculation window.',
    `pay_period_start_date` DATE COMMENT 'First day of the pay period covered by this payroll run. Defines the beginning of the earnings and deductions calculation window.',
    `payroll_area` STRING COMMENT 'Organizational grouping that defines payroll processing frequency and rules. Typically represents a country, region, or employee group with common payroll characteristics. Maps to SAP HR Payroll Area.. Valid values are `^[A-Z0-9]{2,4}$`',
    `payroll_period_identifier` STRING COMMENT 'Standardized period code in YYYYMM format representing the calendar month and year of the payroll run. Used for period-based reporting and reconciliation.. Valid values are `^[0-9]{6}$`',
    `payroll_schema` STRING COMMENT 'SAP Payroll calculation schema that defines the sequence of payroll rules and wage types processed in this run. Different schemas apply to different employee groups (pilots, cabin crew, ground staff).. Valid values are `^[A-Z0-9]{4}$`',
    `personnel_area` STRING COMMENT 'SAP HR organizational unit representing a geographic or operational division within the company. Typically aligns with airports, hubs, or regional offices for airline workforce segmentation.. Valid values are `^[A-Z0-9]{4}$`',
    `personnel_subarea` STRING COMMENT 'SAP HR organizational subdivision within a personnel area. Used for more granular workforce segmentation such as terminal, department, or crew base.. Valid values are `^[A-Z0-9]{4}$`',
    `posted_timestamp` TIMESTAMP COMMENT 'Date and time when payroll financial transactions were posted to SAP FI/CO. Marks the point when payroll costs are recognized in the General Ledger (GL).',
    `posting_date` DATE COMMENT 'Date when payroll financial transactions were posted to SAP Financial Accounting (FI) and Controlling (CO) modules. Establishes the accounting period for General Ledger (GL) entries.',
    `processing_status` STRING COMMENT 'Current lifecycle state of the payroll run. Draft indicates initial setup; in_progress indicates active calculation; calculated indicates computation complete pending approval; approved indicates management sign-off; posted indicates financial posting to General Ledger (GL); reversed indicates payroll reversal; cancelled indicates abandoned run. [ENUM-REF-CANDIDATE: draft|in_progress|calculated|approved|posted|reversed|cancelled — 7 candidates stripped; promote to reference product]',
    `reversal_reason` STRING COMMENT 'Business justification for reversing this payroll run. Populated only when processing_status is reversed. Common reasons include calculation errors, incorrect period selection, or regulatory compliance issues.',
    `reversal_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run was reversed. Populated only when processing_status is reversed. Used for audit trail and financial reconciliation.',
    `run_type` STRING COMMENT 'Classification of the payroll processing cycle. Regular runs are scheduled periodic payroll; off-cycle runs handle unscheduled payments; correction runs fix prior period errors; advance runs provide early payments; bonus runs process incentive compensation; final runs handle termination settlements.. Valid values are `regular|off_cycle|correction|advance|bonus|final`',
    `total_employee_tax` DECIMAL(18,2) COMMENT 'Aggregate employee tax withholdings including income tax, National Insurance (NI) employee portion, and other statutory deductions withheld from employee gross pay.',
    `total_employer_tax` DECIMAL(18,2) COMMENT 'Aggregate employer-borne tax obligations including National Insurance (NI), social security contributions, unemployment insurance, and other statutory employer charges for this payroll run.',
    `total_gross_pay` DECIMAL(18,2) COMMENT 'Aggregate gross earnings for all employees processed in this payroll run before any deductions. Includes base salary, overtime, allowances, bonuses, and other earnings components.',
    `total_net_pay` DECIMAL(18,2) COMMENT 'Aggregate net pay disbursed to all employees in this payroll run after all statutory and voluntary deductions. Represents the actual amount paid to employees.',
    `total_voluntary_deductions` DECIMAL(18,2) COMMENT 'Aggregate voluntary deductions including pension contributions, health insurance premiums, union dues, savings plans, and other employee-elected deductions.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Transactional entity representing a payroll processing cycle executed for a defined pay group and period. Captures payroll area, pay period start/end dates, run type (regular, off-cycle, correction), processing status, total gross pay, total net pay, total employer NI/social charges, currency, number of employees processed, and posting date to SAP FI/CO. Aligns with SAP Payroll (PY) module payroll run control records.';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`payslip` (
    `payslip_id` BIGINT COMMENT 'Unique identifier for the payslip record. Primary key for the payslip entity representing a single employees payroll result for a specific pay period.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Individual payslips must attribute to cost centers for detailed labor cost tracking, departmental budget monitoring, and crew cost analysis per flight/route for airline profitability reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who received this payslip. Links to the employee master record in the workforce domain.',
    `payroll_run_id` BIGINT COMMENT 'Reference to the payroll run batch that generated this payslip. Links to the payroll execution cycle.',
    `allowances` DECIMAL(18,2) COMMENT 'Sum of miscellaneous allowances including housing, transportation, uniform, meal, and other special allowances applicable to the employee.',
    `approved_by` STRING COMMENT 'User ID or name of the payroll manager or system user who approved this payslip for payment. Audit trail for approval authority.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this payslip was approved by payroll manager or automated approval workflow. Required before payment disbursement.',
    `bank_account_number` STRING COMMENT 'Employees bank account number for direct deposit of net pay. Masked for security except last 4 digits in employee-facing systems.',
    `bank_routing_number` STRING COMMENT 'Bank routing number for direct deposit. Identifies the financial institution receiving the payment.',
    `base_salary` DECIMAL(18,2) COMMENT 'The fixed base salary component for the pay period. Core compensation before allowances, overtime, or deductions.',
    `block_hours` DECIMAL(18,2) COMMENT 'Total block hours (gate departure to gate arrival time) flown by crew during the pay period. Used to calculate flying pay and per diem.',
    `bonus` DECIMAL(18,2) COMMENT 'Performance-based or discretionary bonus paid during this pay period. Includes annual bonuses, spot awards, and incentive payments.',
    `commission` DECIMAL(18,2) COMMENT 'Sales commission or variable compensation earned during the pay period. Applicable to sales and revenue-generating roles.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payslip record was first created in the payroll system. Audit trail for payroll processing.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts on this payslip. Supports multi-currency payroll for international operations.. Valid values are `^[A-Z]{3}$`',
    `employee_type` STRING COMMENT 'Classification of the employee receiving this payslip. Determines applicable pay rules, allowances, and union agreements. [ENUM-REF-CANDIDATE: pilot|cabin_crew|ground_staff|maintenance|corporate|contract|temporary — 7 candidates stripped; promote to reference product]',
    `employer_health_contribution` DECIMAL(18,2) COMMENT 'Employer portion of health insurance premium. Not deducted from employee pay but recorded for total compensation and benefits cost tracking.',
    `employer_payroll_tax` DECIMAL(18,2) COMMENT 'Employer portion of payroll taxes including social security, medicare, unemployment insurance, and other statutory employer taxes.',
    `employer_pension_contribution` DECIMAL(18,2) COMMENT 'Employer matching or non-elective contribution to employee pension plan. Not deducted from employee pay but recorded for total compensation tracking.',
    `flying_pay` DECIMAL(18,2) COMMENT 'Additional compensation for flight crew based on block hours flown during the pay period. Aviation-specific allowance for pilots and cabin crew.',
    `garnishments` DECIMAL(18,2) COMMENT 'Court-ordered wage garnishments for child support, alimony, tax liens, or other legal obligations deducted from gross pay.',
    `gross_pay` DECIMAL(18,2) COMMENT 'Total earnings before any deductions. Sum of base salary, flying pay, overtime, allowances, bonuses, and all other earnings components.',
    `health_insurance_premium` DECIMAL(18,2) COMMENT 'Employee portion of health insurance premium deducted from gross pay. Covers medical, dental, and vision insurance.',
    `income_tax` DECIMAL(18,2) COMMENT 'Federal, state, and local income tax withheld from gross pay. Statutory deduction remitted to tax authorities on behalf of employee.',
    `medicare_tax` DECIMAL(18,2) COMMENT 'Medicare tax withheld from gross pay. Statutory payroll tax for healthcare benefits for retirees.',
    `net_pay` DECIMAL(18,2) COMMENT 'Take-home pay after all deductions. Amount disbursed to employees bank account. Calculated as gross pay minus total deductions.',
    `other_deductions` DECIMAL(18,2) COMMENT 'Sum of miscellaneous deductions including life insurance, disability insurance, flexible spending accounts, loan repayments, and other voluntary deductions.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Total overtime hours worked during the pay period. Used to calculate overtime pay at applicable premium rates.',
    `overtime_pay` DECIMAL(18,2) COMMENT 'Additional compensation for hours worked beyond standard duty hours. Calculated based on overtime rate and hours worked.',
    `pay_period_end_date` DATE COMMENT 'The last day of the pay period covered by this payslip. Defines the end of the earnings and deductions calculation window.',
    `pay_period_start_date` DATE COMMENT 'The first day of the pay period covered by this payslip. Defines the beginning of the earnings and deductions calculation window.',
    `payment_date` DATE COMMENT 'The date on which the net pay was or will be disbursed to the employees bank account. Actual payment execution date.',
    `payment_method` STRING COMMENT 'Method used to disburse net pay to the employee. Direct deposit is standard for most airlines.. Valid values are `direct_deposit|check|cash|wire_transfer`',
    `payslip_number` STRING COMMENT 'Human-readable unique payslip number assigned to this payroll result. Used for employee reference and audit trail.',
    `payslip_status` STRING COMMENT 'Current lifecycle status of the payslip. Tracks progression from calculation through approval to payment disbursement.. Valid values are `draft|calculated|approved|paid|voided|corrected`',
    `pension_contribution` DECIMAL(18,2) COMMENT 'Employee contribution to pension or retirement plan deducted from gross pay. Voluntary or mandatory retirement savings.',
    `per_diem` DECIMAL(18,2) COMMENT 'Daily allowance paid to crew for meals and incidental expenses during layovers and duty periods away from base. Aviation-specific travel allowance.',
    `shift_differential` DECIMAL(18,2) COMMENT 'Additional compensation for working non-standard shifts such as nights, weekends, or holidays. Premium pay for undesirable work hours.',
    `social_security_tax` DECIMAL(18,2) COMMENT 'Social security or national insurance tax withheld from gross pay. Statutory payroll tax for retirement and disability benefits.',
    `total_deductions` DECIMAL(18,2) COMMENT 'Sum of all deductions from gross pay including taxes, pension, insurance premiums, union dues, garnishments, and other deductions.',
    `union_dues` DECIMAL(18,2) COMMENT 'Union membership dues deducted from gross pay. Mandatory for unionized employees per collective bargaining agreement.',
    `year_to_date_gross` DECIMAL(18,2) COMMENT 'Cumulative gross pay from the beginning of the calendar or fiscal year through this pay period. Used for tax reporting and annual compensation tracking.',
    `year_to_date_tax` DECIMAL(18,2) COMMENT 'Cumulative income tax withheld from the beginning of the calendar or fiscal year through this pay period. Used for tax reporting and reconciliation.',
    CONSTRAINT pk_payslip PRIMARY KEY(`payslip_id`)
) COMMENT 'Transactional entity representing the individual payroll result for a single employee in a specific pay period. Captures gross pay, net pay, all earnings components (base salary, flying pay, per diem, overtime, allowances), all deductions (tax, pension, union dues, benefit premiums), employer contributions, bank account details for payment, and payroll run reference. Aligns with SAP PY payroll results cluster (RT table). SSOT for individual employee pay outcomes.';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'Unique identifier for the benefit plan. Primary key for the benefit plan master data.',
    `union_agreement_id` BIGINT COMMENT 'Foreign key linking to workforce.union_agreement. Business justification: Benefit plan should reference the union agreement that defines eligibility and terms. The union_agreement_reference is an attribute of union_agreement and should be retrieved via JOIN. This ensures be',
    `coverage_tier_structure` STRING COMMENT 'Defines the available coverage tiers for the plan, determining who can be covered (employee only, employee plus dependents, family coverage).. Valid values are `employee_only|employee_spouse|employee_children|employee_family|tiered_custom`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit plan record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this plan (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dependent_coverage_allowed_flag` BOOLEAN COMMENT 'Indicates whether the plan allows employees to enroll eligible dependents (spouse, domestic partner, children).',
    `eligibility_employment_type` STRING COMMENT 'Comma-separated list of employment types eligible for this plan (e.g., full_time, part_time, contract, pilot, cabin_crew, ground_staff). Aligns with workforce employment classifications.',
    `eligibility_grade_range` STRING COMMENT 'Employee grade or pay band range eligible for this plan (e.g., G1-G5, Executive, Management). Used to differentiate benefit offerings by organizational level.',
    `eligibility_minimum_tenure_months` STRING COMMENT 'Minimum number of months an employee must be employed before becoming eligible for this benefit plan. Zero indicates immediate eligibility.',
    `employee_contribution_rate` DECIMAL(18,2) COMMENT 'Percentage or fixed amount that the employee contributes toward the benefit plan premium or cost. Expressed as a decimal (e.g., 0.2500 for 25%).',
    `employer_contribution_rate` DECIMAL(18,2) COMMENT 'Percentage or fixed amount that the employer contributes toward the benefit plan premium or cost. Expressed as a decimal (e.g., 0.7500 for 75%).',
    `enrollment_window_end_date` DATE COMMENT 'Date when the annual open enrollment period ends for this benefit plan. Elections must be submitted before this date.',
    `enrollment_window_start_date` DATE COMMENT 'Date when the annual open enrollment period begins for this benefit plan. Employees can make elections during this window.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit plan record was last updated. Tracks changes to plan configuration, rates, or eligibility rules.',
    `maximum_dependent_age` STRING COMMENT 'Maximum age for dependent children to remain eligible under the plan. Typically 26 in the US under ACA, varies by jurisdiction.',
    `modified_by_user` STRING COMMENT 'User ID or name of the HR administrator who last modified this benefit plan record. Used for change tracking and accountability.',
    `monthly_premium_amount` DECIMAL(18,2) COMMENT 'Total monthly premium cost for the benefit plan per coverage tier. Used for payroll deduction calculations and budget planning.',
    `plan_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the benefit plan across HR systems and communications. Used in payroll integration and employee self-service portals.. Valid values are `^[A-Z0-9]{4,12}$`',
    `plan_description_summary` STRING COMMENT 'Brief summary of the benefit plan features, coverage highlights, and key terms. Used in employee communications and benefits guides.',
    `plan_document_url` STRING COMMENT 'URL link to the full plan document, Summary Plan Description (SPD), or benefits handbook stored in the document management system.. Valid values are `^https?://.*`',
    `plan_effective_date` DATE COMMENT 'Date when the benefit plan becomes active and coverage begins for enrolled participants. Aligns with plan year start.',
    `plan_expiration_date` DATE COMMENT 'Date when the benefit plan expires or is scheduled for renewal. Null for evergreen plans without fixed end dates.',
    `plan_name` STRING COMMENT 'Full descriptive name of the benefit plan as presented to employees and used in official documentation.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the benefit plan. Active plans are available for enrollment; inactive plans are no longer offered but may have legacy participants.. Valid values are `active|inactive|suspended|pending_approval|closed`',
    `plan_type` STRING COMMENT 'Classification of the benefit plan by category. Determines eligibility rules, contribution structures, and regulatory compliance requirements. [ENUM-REF-CANDIDATE: health|dental|vision|life_insurance|disability|retirement|pension|travel_concession|employee_assistance — 9 candidates stripped; promote to reference product]',
    `plan_year` STRING COMMENT 'Calendar or fiscal year for which this plan configuration applies. Used for year-over-year plan comparison and historical tracking.',
    `provider_name` STRING COMMENT 'Name of the external insurance carrier or benefits provider administering the plan (e.g., Aetna, Blue Cross, Fidelity).',
    `provider_policy_number` STRING COMMENT 'External policy or contract number assigned by the benefit provider for this plan. Used for claims reconciliation and provider communication.',
    `regulatory_compliance_framework` STRING COMMENT 'Comma-separated list of regulatory frameworks this plan must comply with (e.g., ERISA, ACA, HIPAA, GDPR, local labor laws). Determines reporting and governance requirements.',
    `travel_concession_class_entitlement` STRING COMMENT 'Highest cabin class the employee is entitled to under travel concession benefits. Varies by employee grade and plan tier.. Valid values are `economy|premium_economy|business|first|mixed`',
    `travel_concession_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this plan includes airline employee travel concession benefits (standby travel, discounted tickets for employee and dependents). Aviation industry-specific benefit.',
    `waiting_period_days` STRING COMMENT 'Number of days an employee must wait after enrollment before coverage becomes effective. Common for health and insurance plans.',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Reference master defining all employee benefit plans offered by the airline including health insurance, dental, vision, life insurance, pension/retirement schemes, travel concession programmes, and employee assistance programmes. Captures plan name, plan type, provider, coverage tiers, employee contribution rates, employer contribution rates, eligibility rules (employment type, tenure, grade), enrolment window dates, and plan status. Aligns with SAP Benefits (BN) module plan definitions.';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` (
    `benefit_enrolment_id` BIGINT COMMENT 'Unique identifier for the benefit enrolment record. Primary key for the benefit enrolment entity.',
    `benefit_plan_id` BIGINT COMMENT 'Identifier of the benefit plan in which the employee is enrolled. Links to the benefit plan catalog.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee enrolled in the benefit plan. Links to the employee master record.',
    `annual_election_amount` DECIMAL(18,2) COMMENT 'Total annual amount elected by employee for this benefit plan. Applicable for flexible spending accounts (FSA), health savings accounts (HSA), and similar contribution-based benefits.',
    `beneficiary_designation` STRING COMMENT 'Identifier or reference to the designated beneficiary for this benefit plan (applicable for life insurance, retirement plans). May reference dependent or external party.',
    `carrier_policy_number` STRING COMMENT 'Policy or certificate number assigned by the insurance carrier or benefit provider for this enrolment. Used for claims processing and carrier coordination.',
    `cobra_election_deadline_date` DATE COMMENT 'Deadline date by which terminated employee must elect COBRA continuation coverage. Typically 60 days from termination or notice date. Null if not COBRA eligible.',
    `cobra_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for COBRA continuation coverage upon termination of employment. Applicable for US-based health benefit plans.',
    `contribution_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for employee and employer contribution amounts. Supports multi-currency operations for international airline workforce.. Valid values are `^[A-Z]{3}$`',
    `contribution_frequency` STRING COMMENT 'Frequency at which employee and employer contributions are deducted and paid. Aligns with payroll cycle.. Valid values are `weekly|biweekly|semimonthly|monthly|quarterly|annual`',
    `coverage_end_date` DATE COMMENT 'Effective end date when benefit coverage terminates for the employee. Null for active ongoing coverage.',
    `coverage_start_date` DATE COMMENT 'Effective start date when benefit coverage begins for the employee. May differ from enrolment date due to waiting periods or plan year alignment.',
    `coverage_tier` STRING COMMENT 'Level of coverage selected by the employee. Determines who is covered under the benefit plan (employee only, employee plus spouse, employee plus children, or full family).. Valid values are `employee_only|employee_spouse|employee_children|employee_family`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit enrolment record was first created in the system. Audit trail for record creation.',
    `dependents_enrolled_count` STRING COMMENT 'Number of dependents (spouse, children, domestic partner) enrolled under this benefit plan coverage. Zero for employee-only coverage.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Monetary amount contributed by the employee per pay period for this benefit plan. Represents the employees share of the benefit cost.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Monetary amount contributed by the employer per pay period for this benefit plan. Represents the employers share of the benefit cost.',
    `enrolment_confirmation_number` STRING COMMENT 'Confirmation or transaction number generated when the enrolment was processed. Provides audit trail and reference for employee inquiries.',
    `enrolment_date` DATE COMMENT 'Date when the employee enrolled in the benefit plan. Represents the business event timestamp of enrolment action.',
    `enrolment_method` STRING COMMENT 'Method or channel through which the employee completed the benefit enrolment. Tracks whether enrolment was done via self-service portal, paper form, phone, HR representative, or automated system.. Valid values are `online_portal|paper_form|phone|hr_representative|automated`',
    `enrolment_source` STRING COMMENT 'Source or trigger event that initiated this benefit enrolment. Indicates whether enrolment occurred during open enrolment period, new hire onboarding, qualifying life event, annual renewal, or administrative action.. Valid values are `open_enrolment|new_hire|life_event|annual_renewal|qualifying_event|administrative`',
    `enrolment_status` STRING COMMENT 'Current lifecycle status of the benefit enrolment. Indicates whether the enrolment is active, terminated, suspended, pending approval, waived by employee, or cancelled.. Valid values are `active|terminated|suspended|pending|waived|cancelled`',
    `evidence_of_insurability_required_flag` BOOLEAN COMMENT 'Indicates whether the employee is required to provide evidence of insurability (medical underwriting) for this benefit enrolment. Typically required for late enrolments or coverage above guaranteed issue limits.',
    `evidence_of_insurability_status` STRING COMMENT 'Status of evidence of insurability review process. Tracks whether medical underwriting has been completed and approved. Not_required if evidence_of_insurability_required_flag is False.. Valid values are `not_required|pending|approved|denied|waived`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit enrolment record was last modified. Audit trail for record updates.',
    `life_event_date` DATE COMMENT 'Date when the qualifying life event occurred. Used to validate enrolment change eligibility and timing. Null if not applicable.',
    `life_event_type` STRING COMMENT 'Type of qualifying life event that triggered mid-year enrolment change. Applicable when enrolment_source is life_event. Null for standard enrolment periods. [ENUM-REF-CANDIDATE: marriage|birth|adoption|divorce|death|loss_of_coverage|employment_change — 7 candidates stripped; promote to reference product]',
    `pre_tax_election_flag` BOOLEAN COMMENT 'Indicates whether employee contributions are deducted on a pre-tax basis under Section 125 cafeteria plan. True for pre-tax, False for post-tax contributions.',
    `termination_date` DATE COMMENT 'Date when the benefit enrolment was terminated. Distinct from coverage_end_date; represents the administrative termination action date. Null for active enrolments.',
    `termination_reason` STRING COMMENT 'Reason for benefit enrolment termination. Indicates whether termination was due to employment end, employee request, plan discontinuation, non-payment, loss of eligibility, retirement, or death. [ENUM-REF-CANDIDATE: employment_termination|employee_request|plan_discontinuation|non_payment|ineligibility|retirement|death — 7 candidates stripped; promote to reference product]',
    `tobacco_user_flag` BOOLEAN COMMENT 'Indicates whether the employee declared tobacco use during enrolment. Affects premium rates for health and life insurance plans. Protected health information.',
    `waiver_flag` BOOLEAN COMMENT 'Indicates whether the employee explicitly waived (opted out of) this benefit plan. True if waived, False if enrolled.',
    `waiver_reason` STRING COMMENT 'Reason provided by employee for waiving the benefit plan. Applicable only when waiver_flag is True.. Valid values are `coverage_elsewhere|cost|not_needed|other`',
    CONSTRAINT pk_benefit_enrolment PRIMARY KEY(`benefit_enrolment_id`)
) COMMENT 'Transactional master entity recording an employees active enrolment in a specific benefit plan. Captures enrolment date, coverage start and end dates, selected coverage tier, employee contribution amount, employer contribution amount, dependants enrolled, waiver flag (if employee opted out), and enrolment source (open enrolment, life event, new hire). Aligns with SAP BN Participation records. SSOT for which benefits each employee is enrolled in.';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`type_rating` (
    `type_rating_id` BIGINT COMMENT 'Unique identifier for the type rating qualification record. Primary key.',
    `aircraft_type_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft_type. Business justification: Type rating certification requires reference to fleet aircraft type specifications for training syllabus requirements, simulator qualification level, and crew scheduling eligibility determination. Rep',
    `employee_id` BIGINT COMMENT 'Reference to the pilot or maintenance engineer who holds this type rating qualification.',
    `certificate_number` STRING COMMENT 'The unique certificate or license number issued by the regulatory authority for this type rating qualification.',
    `checkride_date` DATE COMMENT 'The date when the practical test or skill test (checkride) for the type rating was successfully completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this type rating record was first created in the system.',
    `crew_scheduling_eligible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this type rating is currently valid and eligible for crew scheduling and pairing assignment (True) or not (False).',
    `current_validity_start_date` DATE COMMENT 'The start date of the current validity period for this type rating, typically following the most recent revalidation or renewal.',
    `endorsements` STRING COMMENT 'Additional endorsements or authorizations associated with the type rating (e.g., ETOPS, CAT II/III, RVSM, RNP).',
    `examiner_name` STRING COMMENT 'Name of the designated pilot examiner (DPE) or type rating examiner (TRE) who conducted the checkride.',
    `expiry_date` DATE COMMENT 'The date when the current type rating validity expires and requires revalidation or renewal. Null if the rating has no expiry (rare).',
    `fleet_transition_source_type` STRING COMMENT 'The aircraft type from which the employee transitioned when obtaining this type rating, if applicable (used for fleet transition planning).',
    `initial_issue_date` DATE COMMENT 'The date when the type rating was first issued to the employee.',
    `issuing_authority` STRING COMMENT 'The national or regional aviation authority that issued this type rating certificate (e.g., FAA, EASA, CAAC, TCCA, CASA, DGCA).. Valid values are `FAA|EASA|CAAC|TCCA|CASA|DGCA`',
    `issuing_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the authority that issued the type rating (e.g., USA, DEU, CHN, CAN, AUS, IND).. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this type rating record was most recently updated or modified.',
    `last_revalidation_date` DATE COMMENT 'The date of the most recent revalidation or proficiency check that extended the validity of this type rating.',
    `line_check_date` DATE COMMENT 'Date of the most recent line check or line operational evaluation conducted on this aircraft type.',
    `next_revalidation_due_date` DATE COMMENT 'The date by which the next revalidation or proficiency check must be completed to maintain currency.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special circumstances related to this type rating qualification.',
    `pic_hours_on_type` DECIMAL(18,2) COMMENT 'Total flight hours logged as Pilot in Command on this specific aircraft type.',
    `proficiency_check_date` DATE COMMENT 'Date of the most recent operator proficiency check (OPC) or competency check for this type rating.',
    `rating_category` STRING COMMENT 'Category of type rating qualification: PIC (Pilot in Command), SIC (Second in Command), TRI (Type Rating Instructor), TRE (Type Rating Examiner), FE (Flight Engineer), AME (Aircraft Maintenance Engineer).. Valid values are `PIC|SIC|TRI|TRE|FE|AME`',
    `recency_check_date` DATE COMMENT 'Date of the most recent recency or currency check (e.g., three takeoffs and landings within 90 days) for this type rating.',
    `restrictions` STRING COMMENT 'Any operational restrictions or limitations placed on the type rating (e.g., VFR only, co-pilot only, specific equipment limitations).',
    `simulator_qualification_level` STRING COMMENT 'The qualification level of the flight simulator used for type rating training and testing (Level A/B/C/D, FTD - Flight Training Device, FFS - Full Flight Simulator).. Valid values are `Level A|Level B|Level C|Level D|FTD|FFS`',
    `total_flight_hours_on_type` DECIMAL(18,2) COMMENT 'Cumulative total flight hours logged by the employee on this specific aircraft type since initial type rating.',
    `training_completion_date` DATE COMMENT 'The date when the initial type rating training course was successfully completed.',
    `training_organization_code` STRING COMMENT 'Code or identifier of the approved training organization (ATO) where the initial type rating training was completed.',
    `transition_training_hours` DECIMAL(18,2) COMMENT 'Total training hours required or completed for transition to this aircraft type from a previous type rating.',
    `validity_status` STRING COMMENT 'Current validity status of the type rating: valid (current and usable), expired (past expiry date), suspended (temporarily invalid), revoked (permanently invalid), pending (awaiting issuance or revalidation).. Valid values are `valid|expired|suspended|revoked|pending`',
    CONSTRAINT pk_type_rating PRIMARY KEY(`type_rating_id`)
) COMMENT 'Master entity representing an individual pilots or maintenance engineers ICAO/EASA/FAA type rating qualification for a specific aircraft type. Captures aircraft type designator (e.g., B737NG, A320neo, B777), rating category (PIC, SIC, TRI, TRE, FE), issuing authority, certificate number, initial issue date, expiry/revalidation date, and current validity status. Critical for crew scheduling legality checks, fleet transition planning, and regulatory compliance. Note: operational crew pairing assignment uses the crew domain; this entity is the HR qualification SSOT.';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`training_record` (
    `training_record_id` BIGINT COMMENT 'Primary key for training_record',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Training costs must post to cost centers for budget tracking, regulatory compliance reporting (FAA/EASA training requirements), and crew development cost analysis per airline training policies.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who completed this training event. Links to the employee master record in the workforce domain.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Training centers are airport stations. Normalize code to FK for training logistics, travel cost allocation, simulator facility management, and training capacity planning.',
    `training_course_id` BIGINT COMMENT 'Foreign key linking to workforce.training_course. Business justification: Training record should reference the master training_course for course details, duration, regulatory mandate, and certification type. The training_course_code STRING attribute should be replaced by FK',
    `actual_start_date` DATE COMMENT 'Actual date when the training event commenced. May differ from scheduled start date due to operational changes or employee availability.',
    `aircraft_type_code` STRING COMMENT 'ICAO aircraft type designator for the aircraft type covered by this training. Examples: B737, A320, B77W. Applicable for type rating training, differences training, and aircraft-specific recurrent training.. Valid values are `^[A-Z0-9]{3,6}$`',
    `approval_authority_code` STRING COMMENT 'Code identifying the regulatory authority or internal approval body that approved or certified this training event. Used for compliance tracking and audit trails.. Valid values are `^[A-Z0-9]{4,12}$`',
    `certificate_issued_date` DATE COMMENT 'Date when the training certificate or qualification was officially issued by the regulatory authority or training organization.',
    `certificate_number` STRING COMMENT 'Official certificate or qualification number issued upon successful completion of the training. Used for regulatory compliance verification and audit trails.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `completion_date` DATE COMMENT 'Date when the training event was completed. This is the official date of record for training currency and compliance tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training record was first created in the system. Used for audit trails and data lineage tracking.',
    `delivery_method` STRING COMMENT 'Method by which the training was delivered. Includes simulator sessions, classroom instruction, computer-based training (CBT), e-learning, on-the-job training (OJT), line training, and blended approaches. [ENUM-REF-CANDIDATE: simulator|classroom|cbt|elearning|ojt|line_training|blended|virtual_classroom — 8 candidates stripped; promote to reference product]',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training event in hours. Includes classroom time, simulator time, or e-learning time as applicable. Used for training cost allocation and resource planning.',
    `expiry_date` DATE COMMENT 'Date when this training qualification expires and recurrent training is required. Applicable for time-limited certifications such as type ratings, proficiency checks, and recurrent training items. Null for one-time training events.',
    `external_provider_flag` BOOLEAN COMMENT 'Indicates whether the training was conducted by an external training provider or approved training organization (ATO) rather than internal airline training resources. True for external providers, false for internal training.',
    `external_provider_name` STRING COMMENT 'Name of the external training organization or approved training organization (ATO) that conducted the training. Null for internal training events.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training record was last updated. Used for audit trails and change tracking.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this training is mandatory for regulatory compliance or operational qualification. True for required training such as proficiency checks, dangerous goods, security, and type ratings. False for optional or developmental training.',
    `next_due_date` DATE COMMENT 'Date when the next recurrent training event is due. Used for proactive scheduling and compliance monitoring. Calculated based on regulatory recurrency intervals (e.g., 12 months for proficiency checks, 24 months for dangerous goods training).',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the training event, expressed as a percentage (0.00 to 100.00). Defines the pass/fail boundary for graded assessments.',
    `recurrency_interval_months` STRING COMMENT 'Number of months between required recurrent training events. Common values: 12 months for proficiency checks, 24 months for dangerous goods training, 36 months for security training. Null for non-recurrent training.',
    `recurrent_flag` BOOLEAN COMMENT 'Indicates whether this training is recurrent (requires periodic renewal) or one-time. True for recurrent training such as annual proficiency checks, biennial dangerous goods training, and periodic emergency procedures training.',
    `recurrent_training_due_date` DATE COMMENT 'Date by which the employee must complete mandatory recurrent training (e.g., annual safety training, CRM, emergency procedures). Critical for regulatory compliance. [Moved from employee: This attribute represents the next due date for recurrent training, which is specific to each employee-course combination, not to the employee globally. Different courses have different recurrence intervals, so this belongs in the training_record association as next_due_date.]',
    `regulatory_authority` STRING COMMENT 'Aviation regulatory authority under whose jurisdiction this training was conducted and certified. Examples: FAA (Federal Aviation Administration), EASA (European Union Aviation Safety Agency), CAAC (Civil Aviation Administration of China). [ENUM-REF-CANDIDATE: FAA|EASA|CAAC|TCCA|CASA|DGCA|ANAC|other — 8 candidates stripped; promote to reference product]',
    `remarks` STRING COMMENT 'Free-text field for additional notes, observations, or special circumstances related to the training event. May include instructor comments, performance observations, or administrative notes.',
    `scheduled_start_date` DATE COMMENT 'Planned start date for the training event. Used for training scheduling and resource planning.',
    `score` DECIMAL(18,2) COMMENT 'Numerical score or grade achieved in the training event, expressed as a percentage (0.00 to 100.00). Applicable for assessments and examinations. Null for non-graded training such as briefings or awareness sessions.',
    `simulator_device_code` STRING COMMENT 'Identifier for the flight simulator or training device used for the training event. Applicable only for simulator-based training. References the specific Full Flight Simulator (FFS), Flight Training Device (FTD), or other approved training device.. Valid values are `^[A-Z0-9]{4,10}$`',
    `training_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for this training event, including instructor fees, facility costs, simulator rental, and materials. Expressed in the airlines reporting currency. Used for training budget management and cost allocation.',
    `training_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the training cost amount. Examples: USD, EUR, GBP.. Valid values are `^[A-Z]{3}$`',
    `training_result` STRING COMMENT 'Outcome of the training event. Indicates whether the employee successfully passed, failed, did not complete, or withdrew from the training.. Valid values are `pass|fail|incomplete|withdrawn|deferred|no_show`',
    `training_status` STRING COMMENT 'Current lifecycle status of the training record. Tracks the training event from scheduling through completion and expiry.. Valid values are `scheduled|in_progress|completed|cancelled|expired|pending_approval`',
    `training_type` STRING COMMENT 'Classification of the training event. Distinguishes between initial type rating, recurrent training, line checks, simulator sessions, ground school, and other training categories. [ENUM-REF-CANDIDATE: initial_type_rating|recurrent|differences|conversion|ground_school|simulator|line_check|proficiency_check|emergency_procedures|dangerous_goods|crm|security|regulatory_compliance|ojtother — 14 candidates stripped; promote to reference product]',
    CONSTRAINT pk_training_record PRIMARY KEY(`training_record_id`)
) COMMENT 'Transactional entity capturing the completion of a specific training event by an employee. Covers recurrent training (simulator checks, line checks, SEP/HUET, CRM, RVSM, ETOPS, DG awareness), initial type rating training, ground school, and mandatory regulatory training. Captures training course code, training type, delivery method (simulator, classroom, CBT, OJT), training centre, instructor, start date, completion date, result (pass/fail/incomplete), score, and next due date for recurrent items.';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`training_course` (
    `training_course_id` BIGINT COMMENT 'Unique identifier for the training course. Primary key.',
    `approved_training_organisation` STRING COMMENT 'Name of the EASA/FAA/ICAO-approved training organisation or internal training department authorized to deliver this course.',
    `assessment_method` STRING COMMENT 'Method used to evaluate participant competency and determine pass/fail. Simulator check refers to proficiency evaluation in a flight training device or full flight simulator.. Valid values are `written_exam|practical_test|simulator_check|observation|portfolio|none`',
    `ato_approval_number` STRING COMMENT 'Regulatory approval or certification number issued by the civil aviation authority to the training organisation for this course.',
    `certification_issued_flag` BOOLEAN COMMENT 'Indicates whether successful completion of this course results in a formal certification, license endorsement, or type rating. True if certification is issued, False if course is for awareness or development only.',
    `certification_type` STRING COMMENT 'Type of certification or credential awarded upon successful completion. Examples: Type Rating A320, Dangerous Goods Certification, CRM Certificate, Safety Management System Certification. Null if no certification is issued.',
    `cost_per_participant` DECIMAL(18,2) COMMENT 'Standard cost to deliver the training course per participant, including instructor fees, materials, simulator time, and facility costs. Used for training budget planning and cost allocation.',
    `course_category` STRING COMMENT 'Classification of the training course by functional area. Type rating refers to aircraft-specific pilot certification, recurrent refers to periodic refresher training, regulatory refers to mandated compliance training. [ENUM-REF-CANDIDATE: type_rating|recurrent|regulatory|leadership|safety|ground_ops|cabin_crew|technical|customer_service|security — 10 candidates stripped; promote to reference product]',
    `course_code` STRING COMMENT 'Unique alphanumeric code identifying the training course in the airlines training management system. Used for scheduling and compliance tracking.. Valid values are `^[A-Z0-9]{4,12}$`',
    `course_description` STRING COMMENT 'Detailed narrative description of the course content, learning objectives, and outcomes. Used for course catalogue and employee self-service portals.',
    `course_name` STRING COMMENT 'Full descriptive name of the training course or programme.',
    `course_status` STRING COMMENT 'Current lifecycle status of the training course. Active courses are available for scheduling. Retired courses are no longer offered but retained for historical compliance records.. Valid values are `active|inactive|under_development|retired|suspended`',
    `course_version` STRING COMMENT 'Version number of the course curriculum. Incremented when course content, duration, or regulatory requirements change. Format: major.minor (e.g., 2.1).. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training course record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost per participant. Examples: USD, EUR, GBP.. Valid values are `^[A-Z]{3}$`',
    `delivery_method` STRING COMMENT 'Mode of instruction for the training course. Simulator refers to flight training device or full flight simulator sessions.. Valid values are `classroom|simulator|elearning|on_the_job|blended|practical`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total instructional time required to complete the course, measured in hours. Includes classroom, simulator, and practical training time.',
    `effective_date` DATE COMMENT 'Date from which this course version became active and available for scheduling. Used to track curriculum changes and regulatory updates.',
    `expiry_date` DATE COMMENT 'Date on which this course version is retired or superseded. Null if the course is currently active with no planned retirement.',
    `language_of_instruction` STRING COMMENT 'Two-letter ISO 639-1 language code for the primary language in which the course is delivered. Examples: EN (English), FR (French), DE (German).. Valid values are `^[A-Z]{2}$`',
    `maximum_participants` STRING COMMENT 'Maximum number of participants allowed per training session. Driven by classroom capacity, simulator availability, or instructor-to-student ratio requirements.',
    `minimum_pass_score` DECIMAL(18,2) COMMENT 'Minimum score or percentage required to successfully complete the course. Typically expressed as a percentage (e.g., 80.00 for 80%).',
    `modified_by` STRING COMMENT 'User ID or name of the training administrator who last modified this course record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training course record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `prerequisite_courses` STRING COMMENT 'Comma-separated list of course codes that must be completed before enrolling in this course. Null if no prerequisites exist.',
    `recurrence_interval_months` STRING COMMENT 'Number of months between required recurrent training sessions. Null if the course is not recurrent. Common values: 12 (annual), 24 (biennial), 6 (semi-annual).',
    `regulation_reference` STRING COMMENT 'Citation of the specific ICAO, EASA, FAA, or national civil aviation authority regulation that mandates this training course. Examples: ICAO Annex 6, EASA Part-ORO, FAA 14 CFR Part 121.427.',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Indicates whether the course is mandated by aviation regulatory authorities (ICAO, EASA, FAA, national CAA). True if required by regulation, False if voluntary or internal development.',
    `sms_integration_flag` BOOLEAN COMMENT 'Indicates whether this course is part of the airlines Safety Management System (SMS) training programme as required by ICAO Annex 19. True if SMS-related, False otherwise.',
    `target_audience` STRING COMMENT 'Primary employee group or role for which this training course is designed. Pilots include flight deck crew, cabin crew include flight attendants, ground staff include airport and customer service personnel.. Valid values are `pilots|cabin_crew|ground_staff|maintenance|management|all_staff`',
    `created_by` STRING COMMENT 'User ID or name of the training administrator who created this course record in the system.',
    CONSTRAINT pk_training_course PRIMARY KEY(`training_course_id`)
) COMMENT 'Reference master defining all training courses and programmes offered or mandated by the airline. Captures course code, course name, course category (type rating, recurrent, regulatory, leadership, safety, ground ops), delivery method, duration, regulatory mandate flag, applicable ICAO/EASA/FAA regulation reference, required recurrence interval (months), minimum pass score, and approved training organisation (ATO) delivering the course. Used to drive training compliance tracking and scheduling.';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`union_agreement` (
    `union_agreement_id` BIGINT COMMENT 'Unique identifier for the collective bargaining agreement (CBA). Primary key.',
    `agreement_name` STRING COMMENT 'Full legal name or title of the collective bargaining agreement.',
    `agreement_number` STRING COMMENT 'Externally-known unique identifier for the collective bargaining agreement, typically formatted as CBA- followed by alphanumeric code.. Valid values are `^CBA-[A-Z0-9]{6,12}$`',
    `agreement_type` STRING COMMENT 'Classification of the agreement lifecycle stage (initial, renewal, amendment, extension, successor, interim).. Valid values are `initial|renewal|amendment|extension|successor|interim`',
    `amendment_count` STRING COMMENT 'Total number of formal amendments made to this collective bargaining agreement since its effective date.',
    `arbitration_clause` STRING COMMENT 'Terms and conditions for binding arbitration of unresolved disputes under this collective bargaining agreement.',
    `bargaining_unit` STRING COMMENT 'Category of employees covered by this agreement (e.g., pilots, cabin crew, ground staff, mechanics, dispatchers, corporate employees). [ENUM-REF-CANDIDATE: pilots|cabin_crew|ground_staff|mechanics|dispatchers|corporate|other — 7 candidates stripped; promote to reference product]',
    `covered_employee_count` STRING COMMENT 'Total number of employees covered under this collective bargaining agreement at the time of ratification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this union agreement record was first created in the system.',
    `document_url` STRING COMMENT 'URL or file path to the full legal text of the collective bargaining agreement document.. Valid values are `^https?://.*`',
    `duration_months` STRING COMMENT 'Total duration of the collective bargaining agreement in months from effective date to expiry date.',
    `duty_hour_limit_monthly` DECIMAL(18,2) COMMENT 'Maximum number of duty hours per month allowed under this agreement for covered employees.',
    `effective_date` DATE COMMENT 'Date when the collective bargaining agreement becomes legally binding and enforceable.',
    `expiry_date` DATE COMMENT 'Date when the collective bargaining agreement expires and is no longer in force. Nullable for open-ended agreements.',
    `flight_hour_limit_monthly` DECIMAL(18,2) COMMENT 'Maximum number of flight hours per month allowed under this agreement for flight crew members.',
    `furlough_recall_provisions` STRING COMMENT 'Terms governing employee furloughs (temporary layoffs) and recall procedures, including seniority order and notification requirements.',
    `governing_law` STRING COMMENT 'Legal framework or statute governing this collective bargaining agreement (e.g., Railway Labor Act, National Labor Relations Act).',
    `grievance_procedure` STRING COMMENT 'Formal process for resolving disputes and grievances between employees and management as outlined in the agreement.',
    `health_benefits_summary` STRING COMMENT 'Summary of health insurance and medical benefits provisions negotiated in the agreement.',
    `job_security_provisions` STRING COMMENT 'Terms protecting employee job security, including no-furlough clauses, minimum fleet size commitments, and outsourcing restrictions.',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction(s) where this collective bargaining agreement applies (e.g., USA, CAN, GBR). Pipe-separated list for multi-jurisdiction agreements.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to this collective bargaining agreement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this union agreement record was last updated in the system.',
    `management_signatory` STRING COMMENT 'Name and title of the airline management representative who signed the collective bargaining agreement on behalf of the company.',
    `minimum_rest_hours` DECIMAL(18,2) COMMENT 'Minimum consecutive rest hours required between duty periods as specified in the agreement.',
    `negotiating_committee_lead` STRING COMMENT 'Name of the lead negotiator or committee chair representing the union during agreement negotiations.',
    `negotiation_end_date` DATE COMMENT 'Date when formal negotiations for this collective bargaining agreement concluded.',
    `negotiation_start_date` DATE COMMENT 'Date when formal negotiations for this collective bargaining agreement commenced.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding this collective bargaining agreement, including special provisions or historical context.',
    `pay_scale_structure` STRING COMMENT 'Description of the compensation structure defined in the agreement, including base pay scales, step progressions, and longevity increases.',
    `ratification_date` DATE COMMENT 'Date when the union membership voted to approve and ratify the collective bargaining agreement.',
    `retirement_benefits_summary` STRING COMMENT 'Summary of pension, 401(k), and other retirement benefit provisions negotiated in the agreement.',
    `scope_clause` STRING COMMENT 'Provisions defining the scope of work that must be performed by union members versus contractors or other carriers (critical for protecting union jobs).',
    `seniority_bidding_rules` STRING COMMENT 'Description of seniority-based bidding procedures for schedules, routes, bases, and equipment assignments as defined in the agreement.',
    `union_agreement_status` STRING COMMENT 'Current lifecycle status of the collective bargaining agreement (draft, negotiation, ratification, active, expired, terminated, suspended). [ENUM-REF-CANDIDATE: draft|negotiation|ratification|active|expired|terminated|suspended — 7 candidates stripped; promote to reference product]',
    `union_code` STRING COMMENT 'Standardized abbreviation or code for the union (e.g., ALPA for Air Line Pilots Association, AFA for Association of Flight Attendants, IAM for International Association of Machinists, AMFA for Aircraft Mechanics Fraternal Association).. Valid values are `^[A-Z]{2,6}$`',
    `union_name` STRING COMMENT 'Full legal name of the labor union or staff association that is party to this agreement (e.g., Air Line Pilots Association, Association of Flight Attendants).',
    `union_signatory` STRING COMMENT 'Name and title of the union representative who signed the collective bargaining agreement on behalf of the union membership.',
    CONSTRAINT pk_union_agreement PRIMARY KEY(`union_agreement_id`)
) COMMENT 'Master entity representing a collective bargaining agreement (CBA) between the airline and a recognised labour union or staff association. Captures union name, IATA union code, bargaining unit scope (pilots/ALPA, cabin crew/AFA, IAM ground staff, AMFA engineers), effective and expiry dates, negotiation status, key provisions (pay scales, duty hour limits, rest rules, seniority bidding, furlough/recall), applicable jurisdictions, and amendment history. SSOT for labour relations — referenced by employment contracts, payroll rules, and scheduling constraints.';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`grievance` (
    `grievance_id` BIGINT COMMENT 'Unique identifier for the employee grievance record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the HR or labor relations staff member assigned to investigate the grievance.',
    `grievance_employee_id` BIGINT COMMENT 'Reference to the employee who filed the grievance. Links to the employee master record in the workforce domain.',
    `arbitration_date` DATE COMMENT 'Date when the arbitration hearing took place, if applicable.',
    `arbitration_decision` STRING COMMENT 'Summary of the arbitrators binding decision, if arbitration occurred.',
    `arbitration_flag` BOOLEAN COMMENT 'Indicates whether the grievance was escalated to external arbitration. True if arbitration was invoked, False otherwise.',
    `arbitrator_name` STRING COMMENT 'Name of the neutral third-party arbitrator assigned to the case, if arbitration occurred.',
    `case_status` STRING COMMENT 'Current lifecycle status of the grievance case. Tracks progression from filing through resolution or arbitration.. Valid values are `open|under_investigation|resolved|escalated_to_arbitration|withdrawn|closed`',
    `closed_date` DATE COMMENT 'Date when the grievance case was formally closed and no further action is pending. Marks the end of the grievance lifecycle.',
    `confidentiality_flag` BOOLEAN COMMENT 'Indicates whether a confidentiality or non-disclosure agreement was executed as part of the resolution. True if confidentiality agreement exists, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this grievance record was first created in the system. Audit trail field.',
    `documentation_reference` STRING COMMENT 'Reference identifier or file path to supporting documentation, evidence, or investigation reports stored in the document management system.',
    `filing_date` DATE COMMENT 'Date when the employee formally filed the grievance with the airline. This is the principal business event timestamp for the grievance lifecycle.',
    `financial_settlement_amount` DECIMAL(18,2) COMMENT 'Monetary settlement amount paid to the employee as part of the grievance resolution, if applicable. Null if no financial settlement.',
    `grievance_description` STRING COMMENT 'Detailed narrative description of the grievance as provided by the employee. Contains the facts, circumstances, and specific complaint details.',
    `grievance_number` STRING COMMENT 'Externally-visible unique case number assigned to the grievance for tracking and reference purposes. Format: GRV-YYYYNNNN.. Valid values are `^GRV-[0-9]{8}$`',
    `grievance_type` STRING COMMENT 'Classification of the grievance based on the nature of the complaint. CBA = Collective Bargaining Agreement.. Valid values are `disciplinary|harassment|unfair_treatment|cba_violation|safety_concern|discrimination`',
    `incident_date` DATE COMMENT 'Date when the incident or event that led to the grievance occurred. May differ from filing date.',
    `investigation_completion_date` DATE COMMENT 'Date when the investigation was completed and findings were documented.',
    `investigation_start_date` DATE COMMENT 'Date when the formal investigation of the grievance commenced.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this grievance record was last updated. Audit trail field for tracking changes.',
    `legal_counsel_involved_flag` BOOLEAN COMMENT 'Indicates whether external legal counsel was engaged by either party during the grievance process. True if legal counsel was involved, False otherwise.',
    `priority_level` STRING COMMENT 'Priority classification assigned to the grievance based on severity, urgency, and potential impact. Critical priority typically assigned to safety concerns or legal risks.. Valid values are `low|medium|high|critical`',
    `related_policy_reference` STRING COMMENT 'Reference to the airline policy, Standard Operating Procedure (SOP), or Collective Bargaining Agreement (CBA) clause cited in the grievance.',
    `requested_remedy` STRING COMMENT 'The resolution or corrective action requested by the employee. Examples: reinstatement, back pay, policy change, disciplinary action reversal.',
    `resolution_date` DATE COMMENT 'Date when the grievance was formally resolved, either through internal resolution, settlement, or arbitration decision.',
    `resolution_outcome` STRING COMMENT 'Final outcome of the grievance case. Upheld means the grievance was found valid and remedy granted; denied means grievance was not substantiated.. Valid values are `upheld|partially_upheld|denied|settled|arbitration_pending`',
    `resolution_summary` STRING COMMENT 'Detailed summary of the resolution, including findings, corrective actions taken, and rationale for the decision.',
    `respondent_department` STRING COMMENT 'Organizational department or division of the respondent. Examples: Flight Operations, Cabin Crew, Ground Handling, Maintenance.',
    `respondent_name` STRING COMMENT 'Name of the manager, supervisor, or department against whom the grievance is filed.',
    `settlement_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial settlement amount. Example: USD, EUR, GBP.. Valid values are `^[A-Z]{3}$`',
    `union_name` STRING COMMENT 'Name of the labor union representing the employee, if applicable. Null if no union representation.',
    `union_representation_flag` BOOLEAN COMMENT 'Indicates whether the employee is represented by a union in this grievance case. True if union representation is involved, False otherwise.',
    `union_representative_name` STRING COMMENT 'Name of the union representative assigned to this case, if applicable.',
    `witness_count` STRING COMMENT 'Number of witnesses interviewed or statements collected during the investigation.',
    CONSTRAINT pk_grievance PRIMARY KEY(`grievance_id`)
) COMMENT 'Transactional entity recording formal employee grievances, disciplinary actions, and labour relations cases filed within the airline. Captures grievance type (disciplinary, harassment, unfair treatment, CBA violation, safety concern), filing date, employee reference, respondent (manager/department), union representation flag, case status (open, under investigation, resolved, escalated to arbitration), resolution date, outcome, and any financial settlement. Supports labour relations management and legal compliance.';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique identifier for the performance review record. Primary key.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Performance review should reference the org unit for organizational context and reporting. The organizational_unit_code is an attribute of org_unit and should be retrieved via JOIN. This normalizes or',
    `employee_id` BIGINT COMMENT 'Identifier of the employee being reviewed. Links to employee master data in SAP S/4HANA HR module.',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the employee conducting the review, typically the line manager or supervisor.',
    `union_agreement_id` BIGINT COMMENT 'Foreign key linking to workforce.union_agreement. Business justification: Performance review should reference the union agreement for review process compliance. The union_agreement_code is an attribute of union_agreement and should be retrieved via JOIN. This ensures perfor',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Performance review should reference the position being evaluated. The job_position_code is an attribute of position and should be retrieved via JOIN. This links performance reviews to the position mas',
    `attendance_punctuality_rating` STRING COMMENT 'Rating for attendance, punctuality, and reliability. Critical for crew scheduling and operational reliability. Includes adherence to duty times and rest requirements.. Valid values are `outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `behavioral_competency_rating` STRING COMMENT 'Rating for behavioral competencies including teamwork, communication, customer service, safety culture, and adherence to Standard Operating Procedures (SOP).. Valid values are `outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `compensation_adjustment_recommendation` STRING COMMENT 'Recommendation for compensation adjustment based on performance. Used as input for annual compensation planning cycle.. Valid values are `merit_increase|bonus|no_adjustment|salary_review|promotion_adjustment`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was first created in the system.',
    `customer_service_rating` STRING COMMENT 'Rating for customer service quality and passenger satisfaction. Applicable to customer-facing roles including cabin crew, ground staff, and airport operations. Not applicable for non-customer-facing roles.. Valid values are `outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_applicable`',
    `development_areas_summary` STRING COMMENT 'Narrative summary of areas identified for improvement and professional development. Includes specific skills, competencies, or behaviors requiring attention.',
    `development_plan_actions` STRING COMMENT 'Specific actions and development activities recommended for the employee. May include training courses, certifications, mentoring, job rotation, or special projects.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the employee has formally disputed the performance review. True if disputed, False otherwise. Triggers labor relations review process.',
    `employee_acknowledgement_date` DATE COMMENT 'Date when the employee acknowledged the performance review. Null if not yet acknowledged.',
    `employee_acknowledgement_flag` BOOLEAN COMMENT 'Indicates whether the employee has acknowledged receipt and review of the performance appraisal. True if acknowledged, False otherwise.',
    `employee_comments` STRING COMMENT 'Comments or feedback provided by the employee in response to the performance review. Allows employee to provide their perspective and input.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review record was last modified. Tracks all updates throughout the review lifecycle.',
    `leadership_competency_rating` STRING COMMENT 'Rating for leadership and management competencies. Applicable to supervisory and management roles. Not applicable for non-supervisory positions.. Valid values are `outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_applicable`',
    `objective_achievement_score` DECIMAL(18,2) COMMENT 'Percentage score representing achievement of individual objectives and key results set at the beginning of the review period. Scale 0.00 to 100.00.',
    `overall_rating` STRING COMMENT 'Overall performance rating assigned to the employee for the review period. Standard five-point scale used across all staff categories.. Valid values are `outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric score corresponding to the overall rating, typically on a scale of 1.00 to 5.00. Used for quantitative analysis and compensation decisions.',
    `performance_improvement_plan_flag` BOOLEAN COMMENT 'Indicates whether a formal Performance Improvement Plan has been initiated as a result of this review. True if PIP initiated, False otherwise.',
    `promotion_readiness_timeline` STRING COMMENT 'Estimated timeline for promotion readiness if promotion is recommended. Indicates when the employee is expected to be ready for the next level.. Valid values are `ready_now|ready_6_months|ready_12_months|ready_18_months|not_ready|not_applicable`',
    `promotion_recommendation_flag` BOOLEAN COMMENT 'Indicates whether the reviewer recommends the employee for promotion consideration. True if recommended, False otherwise.',
    `review_cycle_type` STRING COMMENT 'Type of performance review cycle. Includes annual reviews, mid-year reviews, probation reviews, line checks for flight crew, recurrent training assessments, and special reviews.. Valid values are `annual|mid_year|probation|line_check|recurrent|special`',
    `review_date` DATE COMMENT 'Date when the performance review was conducted or completed.',
    `review_period_end_date` DATE COMMENT 'End date of the performance period being evaluated.',
    `review_period_start_date` DATE COMMENT 'Start date of the performance period being evaluated.',
    `review_status` STRING COMMENT 'Current lifecycle status of the performance review. Tracks progression from draft through completion and employee acknowledgement. [ENUM-REF-CANDIDATE: draft|submitted|in_review|approved|completed|acknowledged|disputed — 7 candidates stripped; promote to reference product]',
    `reviewer_comments` STRING COMMENT 'Detailed comments and observations from the reviewer. Provides context and justification for ratings and recommendations.',
    `safety_compliance_rating` STRING COMMENT 'Rating for safety compliance and adherence to Safety Management System (SMS) requirements. Critical for all operational roles including flight crew, cabin crew, and ground operations.. Valid values are `outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `second_level_approval_date` DATE COMMENT 'Date when the second-level reviewer approved the performance review. Null if not yet approved.',
    `staff_category` STRING COMMENT 'Category of airline staff being reviewed. Different categories may have specialized competency frameworks and rating criteria.. Valid values are `pilot|cabin_crew|ground_staff|maintenance|corporate|management`',
    `strengths_summary` STRING COMMENT 'Narrative summary of the employees key strengths and positive contributions during the review period.',
    `technical_competency_rating` STRING COMMENT 'Rating for technical skills and job-specific competencies. For flight crew includes type ratings, procedures knowledge, and technical proficiency. For ground staff includes operational systems proficiency.. Valid values are `outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Transactional entity capturing the formal performance appraisal of an employee for a defined review period. Captures review cycle (annual, mid-year, probation), review date, reviewer (line manager), overall rating, competency ratings, objective achievement scores, development areas identified, promotion recommendation flag, and employee acknowledgement status. Aligns with SAP PA Performance Management. Covers all staff categories including line checks for flight crew.';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` (
    `recruitment_requisition_id` BIGINT COMMENT 'Unique identifier for the recruitment requisition. Primary key for this entity.',
    `job_classification_id` BIGINT COMMENT 'Foreign key linking to workforce.job_classification. Business justification: Recruitment requisition should reference the job classification for grade and pay structure. The job_classification_code is an attribute of job_classification and should be retrieved via JOIN. This en',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Normalize requisition location from code to station FK for headcount planning, station staffing analysis, and recruitment pipeline reporting by operational location.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (department, division, station) where the position will be located.',
    `position_id` BIGINT COMMENT 'Reference to the position master record that defines the role being recruited for.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is the hiring manager responsible for this requisition and will make the final hiring decision.',
    `quaternary_recruitment_replacement_employee_id` BIGINT COMMENT 'For backfill or replacement requisitions, reference to the employee who is being replaced (due to departure, promotion, or transfer). Null for new headcount requisitions.',
    `tertiary_recruitment_approved_by_employee_id` BIGINT COMMENT 'Reference to the employee (typically senior manager or HR director) who provided final approval for this requisition.',
    `union_agreement_id` BIGINT COMMENT 'Foreign key linking to workforce.union_agreement. Business justification: Recruitment requisition should reference the union agreement for hiring rules and seniority provisions. The union_agreement_code is an attribute of union_agreement and should be retrieved via JOIN. Th',
    `approved_budget_amount` DECIMAL(18,2) COMMENT 'Total approved budget allocated for this recruitment requisition, covering salary, benefits, relocation, and recruitment costs. Expressed in the airlines reporting currency.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the approved budget amount.. Valid values are `^[A-Z]{3}$`',
    `cost_center_code` STRING COMMENT 'Financial cost center to which the salary and recruitment costs for this position will be charged.. Valid values are `^[A-Z0-9]{6,10}$`',
    `diversity_initiative_flag` BOOLEAN COMMENT 'Indicates whether this requisition is part of a diversity and inclusion hiring initiative or targeted recruitment program.',
    `employment_type` STRING COMMENT 'Type of employment contract being offered: permanent (indefinite), fixed-term (defined end date), temporary (short-term assignment), seasonal (recurring seasonal demand), contract (independent contractor).. Valid values are `permanent|fixed_term|temporary|seasonal|contract`',
    `external_posting_flag` BOOLEAN COMMENT 'Indicates whether this requisition should be posted to external job boards and public career sites, or restricted to internal candidates only.',
    `job_description_text` STRING COMMENT 'Detailed description of the role, responsibilities, qualifications, and requirements for the position.',
    `job_posting_title` STRING COMMENT 'Public-facing job title to be used in external job postings and advertisements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the recruitment requisition record was last updated in the system.',
    `minimum_flight_hours` STRING COMMENT 'For pilot or cabin crew positions, the minimum total flight hours required. Null for non-flight crew roles.',
    `number_of_vacancies` STRING COMMENT 'Total number of open positions to be filled under this requisition.',
    `posting_end_date` DATE COMMENT 'Date when the job posting will be removed from job boards and no longer accept applications.',
    `posting_start_date` DATE COMMENT 'Date when the job posting becomes visible to candidates on internal and external job boards.',
    `priority_level` STRING COMMENT 'Business priority assigned to this requisition indicating urgency: critical (AOG or safety-critical role), high (operational impact), medium (planned growth), low (opportunistic hire).. Valid values are `critical|high|medium|low`',
    `recruitment_channel` STRING COMMENT 'Primary channel through which candidates will be sourced: internal (existing employees), external (public job boards), agency (third-party recruiters), employee referral program, campus recruitment, or military transition programs for ex-service personnel.. Valid values are `internal|external|agency|employee_referral|campus|military_transition`',
    `relocation_assistance_flag` BOOLEAN COMMENT 'Indicates whether relocation assistance is available for candidates who need to relocate for this position.',
    `remote_work_eligible_flag` BOOLEAN COMMENT 'Indicates whether the position is eligible for remote or hybrid work arrangements.',
    `required_start_date` DATE COMMENT 'Target date by which the hired candidate(s) must commence employment to meet operational needs.',
    `requisition_approved_timestamp` TIMESTAMP COMMENT 'Date and time when the recruitment requisition received final approval and became active for recruiting.',
    `requisition_closed_timestamp` TIMESTAMP COMMENT 'Date and time when the recruitment requisition was closed (filled, cancelled, or otherwise completed).',
    `requisition_created_timestamp` TIMESTAMP COMMENT 'Date and time when the recruitment requisition was first created in the system.',
    `requisition_notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or context about the requisition for recruiters and hiring managers.',
    `requisition_number` STRING COMMENT 'Business identifier for the recruitment requisition, externally visible and used in communications with hiring managers and candidates.. Valid values are `^REQ-[0-9]{8}$`',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the recruitment requisition: draft (being prepared), pending approval (awaiting management sign-off), approved (authorized to recruit), active (recruiting in progress), on hold (temporarily paused), filled (all vacancies filled), cancelled (requisition withdrawn), closed (completed and archived). [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|on_hold|filled|cancelled|closed — 8 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Type of recruitment requisition indicating the business driver: new headcount expansion, backfill for departure, replacement for terminated employee, ACMI (Aircraft Crew Maintenance Insurance) crew intake for wet lease operations, seasonal demand, or project-based temporary hire.. Valid values are `new_headcount|backfill|replacement|acmi_crew_intake|seasonal|project_based`',
    `security_clearance_required_flag` BOOLEAN COMMENT 'Indicates whether the position requires aviation security clearance or background checks per TSA or equivalent authority requirements.',
    `type_rating_required` STRING COMMENT 'For pilot positions, specifies the aircraft type rating required (e.g., A320, B737, B777). Empty for non-pilot roles.',
    `work_schedule_type` STRING COMMENT 'Expected work schedule pattern for the position: full-time (standard hours), part-time (reduced hours), shift work (rotating shifts), roster-based (crew scheduling), on-call (as-needed availability).. Valid values are `full_time|part_time|shift_work|roster_based|on_call`',
    CONSTRAINT pk_recruitment_requisition PRIMARY KEY(`recruitment_requisition_id`)
) COMMENT 'Transactional entity representing an approved headcount request to fill a position within the airline. Captures requisition number, position reference, org unit, job classification, number of vacancies, requisition type (new headcount, backfill, ACMI crew intake), required start date, approved budget, recruitment channel (internal, external, agency), status (draft, approved, active, filled, cancelled), and hiring manager. Aligns with SAP E-Recruiting / SuccessFactors Recruiting module.';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`applicant` (
    `applicant_id` BIGINT COMMENT 'Unique identifier for the applicant record. Primary key.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the recruiter or HR specialist responsible for managing this application.',
    `applicant_referral_employee_id` BIGINT COMMENT 'Employee identifier of the internal employee who referred this applicant, if applicable.',
    `recruitment_requisition_id` BIGINT COMMENT 'Reference to the job requisition or vacancy posting that the applicant is applying for.',
    `address_line1` STRING COMMENT 'Primary street address line for the applicants current residence.',
    `address_line2` STRING COMMENT 'Secondary address line (apartment, suite, building) for the applicants current residence.',
    `alternate_phone_number` STRING COMMENT 'Secondary contact phone number for the applicant, if provided.',
    `application_date` DATE COMMENT 'Date when the applicant submitted their application for the position.',
    `application_number` STRING COMMENT 'Externally visible unique application reference number assigned when the candidate submits their application.. Valid values are `^APP[0-9]{10}$`',
    `application_status` STRING COMMENT 'Current status of the application in the recruitment workflow (applied, screened, interview, assessment, offer, hired, rejected, withdrawn). [ENUM-REF-CANDIDATE: applied|screened|interview|assessment|offer|hired|rejected|withdrawn — 8 candidates stripped; promote to reference product]',
    `aviation_licence_type` STRING COMMENT 'Type of aviation licence held by the applicant, if applicable (ATPL - Airline Transport Pilot Licence, CPL - Commercial Pilot Licence, PPL - Private Pilot Licence, cabin crew, AME - Aircraft Maintenance Engineer, none).. Valid values are `ATPL|CPL|PPL|cabin_crew|AME|none`',
    `city` STRING COMMENT 'City of the applicants current residence.',
    `country_code` STRING COMMENT 'Three-letter ISO country code of the applicants current residence.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the applicant record was first created in the system.',
    `current_employer` STRING COMMENT 'Name of the applicants current employer or most recent employer if unemployed.',
    `current_job_title` STRING COMMENT 'Job title or role of the applicant at their current or most recent employer.',
    `data_retention_expiry_date` DATE COMMENT 'Date when the applicants personal data must be deleted or anonymized per GDPR data retention policies.',
    `email_address` STRING COMMENT 'Primary email address used for all recruitment communication with the applicant.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `expected_start_date` DATE COMMENT 'Expected or agreed date when the applicant will commence employment if hired.',
    `first_name` STRING COMMENT 'Legal first name (given name) of the applicant as provided in the application.',
    `gdpr_consent_date` DATE COMMENT 'Date when the applicant provided GDPR consent for data processing.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether the applicant has provided explicit consent for processing their personal data under GDPR requirements (True/False).',
    `interview_date` DATE COMMENT 'Date of the most recent or scheduled interview with the applicant.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the applicant record was last updated or modified.',
    `last_name` STRING COMMENT 'Legal last name (family name) of the applicant as provided in the application.',
    `licence_issuing_authority` STRING COMMENT 'Name of the civil aviation authority that issued the applicants aviation licence (e.g., FAA, EASA, DGCA).',
    `licence_number` STRING COMMENT 'Unique licence number issued by the civil aviation authority for the applicants aviation licence, if held.',
    `middle_name` STRING COMMENT 'Middle name or initial of the applicant, if provided.',
    `offer_accepted_date` DATE COMMENT 'Date when the applicant accepted the job offer.',
    `offer_date` DATE COMMENT 'Date when a formal job offer was extended to the applicant.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the applicant, including country code.',
    `pic_hours` DECIMAL(18,2) COMMENT 'Total flight hours logged as Pilot in Command, if applicable for pilot applicants.',
    `position_applied_for` STRING COMMENT 'Job title or position name that the applicant is applying for.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the applicants current residence.',
    `screening_score` DECIMAL(18,2) COMMENT 'Numerical score assigned during initial screening or assessment of the application (0-100 scale).',
    `source_channel` STRING COMMENT 'Channel or source through which the applicant discovered and applied for the position (careers portal, GDS job board, agency, internal transfer, employee referral, social media).. Valid values are `careers_portal|gds_job_board|recruitment_agency|internal_transfer|employee_referral|social_media`',
    `state_province` STRING COMMENT 'State or province of the applicants current residence.',
    `status_reason` STRING COMMENT 'Reason or notes explaining the current application status, particularly for rejected or withdrawn applications.',
    `total_flight_hours` DECIMAL(18,2) COMMENT 'Total accumulated flight hours logged by the applicant, if applicable for pilot applicants.',
    `type_ratings_held` STRING COMMENT 'Comma-separated list of aircraft type ratings held by the applicant (e.g., B737, A320, B777), if applicable for pilot applicants.',
    `years_of_experience` DECIMAL(18,2) COMMENT 'Total years of relevant work experience declared by the applicant.',
    CONSTRAINT pk_applicant PRIMARY KEY(`applicant_id`)
) COMMENT 'Master entity representing an individual who has applied for a position at the airline. Captures applicant name, contact details, application date, source channel (careers portal, GDS job board, agency, internal transfer), current employer, aviation licence held (if applicable), type ratings held, total flight hours (for pilot applicants), application status (applied, screened, interview, assessment, offer, hired, rejected, withdrawn), and GDPR consent flag. Aligns with SAP E-Recruiting Applicant Master.';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`absence_record` (
    `absence_record_id` BIGINT COMMENT 'Unique identifier for the absence record. Primary key.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Normalize absence home base location for crew availability analysis by station, replacement crew sourcing, and FDP impact assessment. Essential for operations control.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Absence record should reference the org unit for cost allocation and reporting. The cost_center_code is an attribute of org_unit and should be retrieved via JOIN. This normalizes cost center assignmen',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is absent. Links to the employee master record.',
    `tertiary_absence_replacement_employee_id` BIGINT COMMENT 'Reference to the employee assigned to cover duties during this absence period. Nullable if no replacement assigned. Links to employee master record.',
    `union_agreement_id` BIGINT COMMENT 'Foreign key linking to workforce.union_agreement. Business justification: Absence record should reference the union agreement for leave policy compliance. The union_code is an attribute of union_agreement and should be retrieved via JOIN. This ensures absence records are go',
    `absence_category` STRING COMMENT 'High-level categorization of the absence: planned (scheduled in advance, e.g., annual leave), unplanned (short-notice, e.g., sick leave), or emergency (immediate, e.g., family emergency, AOG crew replacement).. Valid values are `planned|unplanned|emergency`',
    `absence_reason_notes` STRING COMMENT 'Free-text notes providing additional context or reason for the absence. May contain sensitive information. Access restricted to HR and authorized managers.',
    `absence_type_code` STRING COMMENT 'Code representing the type of absence (e.g., annual leave, sick leave, maternity leave, compassionate leave, training leave, unpaid leave, union leave, jury duty). Aligns with SAP Infotype 2001 absence type catalog.. Valid values are `^[A-Z0-9]{2,10}$`',
    `absence_type_description` STRING COMMENT 'Human-readable description of the absence type for reporting and display purposes.',
    `approval_date` DATE COMMENT 'The date the absence request was approved or rejected by the approving manager.',
    `approval_status` STRING COMMENT 'Current approval status of the absence request. Workflow state tracking from submission through final approval or rejection.. Valid values are `pending|approved|rejected|cancelled|withdrawn`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this absence record was first created in the system. Audit trail for data lineage and compliance.',
    `crew_availability_impact_flag` BOOLEAN COMMENT 'Indicates whether this absence affects crew availability for scheduling purposes. True if the employee is unavailable for duty assignment during the absence period.',
    `duration_days` DECIMAL(18,2) COMMENT 'Total duration of the absence measured in calendar days. Calculated from start and end dates, accounting for partial days.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the absence measured in hours. Used for partial-day absences and precise crew scheduling calculations.',
    `end_date` DATE COMMENT 'The date the absence period ends. May be null for open-ended absences pending return-to-work confirmation.',
    `fdp_impact_flag` BOOLEAN COMMENT 'Indicates whether this absence impacts Flight Duty Period compliance calculations for flight crew. True if FDP-relevant (e.g., sick leave, fatigue-related absence), False otherwise. Critical for FAA/EASA crew rest compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this absence record was last updated. Audit trail for change tracking and compliance.',
    `medical_certificate_received_date` DATE COMMENT 'The date the medical certificate was received by HR or the relevant authority.',
    `medical_certificate_received_flag` BOOLEAN COMMENT 'Indicates whether the required medical certificate has been received and validated. True if received, False otherwise.',
    `medical_certificate_required_flag` BOOLEAN COMMENT 'Indicates whether a medical certificate is required for this absence (typically for sick leave exceeding a threshold duration). True if required, False otherwise.',
    `pay_impact_code` STRING COMMENT 'Indicates the impact of the absence on employee pay: paid (full pay maintained), unpaid (no pay during absence), or partial (reduced pay per policy or union agreement).. Valid values are `paid|unpaid|partial`',
    `pay_percentage` DECIMAL(18,2) COMMENT 'Percentage of regular pay the employee receives during the absence period (0-100). Used for partial pay scenarios such as statutory sick pay or union-negotiated rates.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this absence must be reported to regulatory authorities (e.g., FAA, EASA, DOT) for safety or compliance purposes. True if reportable, False otherwise.',
    `return_to_work_confirmed_flag` BOOLEAN COMMENT 'Indicates whether the employees return to work has been confirmed by the manager or HR. True if confirmed, False otherwise.',
    `return_to_work_date` DATE COMMENT 'The actual date the employee returned to work following the absence. May differ from planned end date. Critical for crew availability and FDP compliance.',
    `start_date` DATE COMMENT 'The date the absence period begins. Used for crew availability calculations and Flight Duty Period (FDP) compliance.',
    `submission_date` DATE COMMENT 'The date the employee submitted the absence request. Used for compliance with advance notice requirements.',
    CONSTRAINT pk_absence_record PRIMARY KEY(`absence_record_id`)
) COMMENT 'Transactional entity recording all employee absences including annual leave, sick leave, maternity/paternity leave, compassionate leave, training leave, and unpaid leave. Captures absence type, start date, end date, duration in days/hours, approval status, approving manager, medical certificate required flag, return-to-work date, and impact on pay. Aligns with SAP PA Time Management (Infotype 2001 Absences). Critical for crew availability calculations and FDP (Flight Duty Period) compliance.';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`employee_action` (
    `employee_action_id` BIGINT COMMENT 'Unique identifier for the employee action record. Primary key for the employee action entity.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is the subject of this personnel action.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit the employee belonged to before this action.',
    `position_id` BIGINT COMMENT 'Reference to the employees position before this action was executed.',
    `tertiary_hr_approver_employee_id` BIGINT COMMENT 'Reference to the HR representative who approved this personnel action.',
    `action_date` DATE COMMENT 'Date when the personnel action was initiated or recorded in the system.',
    `action_reason_code` STRING COMMENT 'SAP action reason code providing detailed classification of why the action occurred (e.g., voluntary resignation, retirement, performance-based promotion, operational transfer).',
    `action_status` STRING COMMENT 'Current workflow status of the personnel action in the approval and execution lifecycle.. Valid values are `draft|pending_approval|approved|effective|cancelled|rejected`',
    `action_type` STRING COMMENT 'Type of personnel action being recorded. [ENUM-REF-CANDIDATE: hire|promotion|transfer|demotion|base_change|leave_of_absence|return_from_leave|contract_change|termination|salary_adjustment|position_change|grade_change — promote to reference product]. Valid values are `hire|promotion|transfer|demotion|base_change|leave_of_absence`',
    `approval_date` DATE COMMENT 'Date when the personnel action was approved by the authorized approver.',
    `comments` STRING COMMENT 'Free-text comments or notes providing additional context about the personnel action.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee action record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when the personnel action becomes effective and the employment changes take effect.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee action record was last modified.',
    `modified_by_user` STRING COMMENT 'User ID or username of the person who last modified this employee action record.',
    `new_base_salary` DECIMAL(18,2) COMMENT 'Annual base salary amount after this personnel action, in the employees local currency.',
    `new_employment_status` STRING COMMENT 'Employment status of the employee after this action.. Valid values are `active|on_leave|suspended|terminated`',
    `new_employment_type` STRING COMMENT 'Type of employment contract after this action.. Valid values are `full_time|part_time|contract|temporary|seasonal|intern`',
    `new_fte_allocation` DECIMAL(18,2) COMMENT 'Full-time equivalent allocation after this action (e.g., 1.00 for full-time, 0.50 for half-time).',
    `new_grade_band` STRING COMMENT 'Salary grade or band the employee is assigned to after this action.',
    `new_home_base_airport_code` STRING COMMENT 'Three-letter IATA airport code representing the employees home base after this action. Relevant for crew and operational staff.. Valid values are `^[A-Z]{3}$`',
    `new_job_title` STRING COMMENT 'Job title assigned to the employee after this personnel action.',
    `previous_base_salary` DECIMAL(18,2) COMMENT 'Annual base salary amount before this personnel action, in the employees local currency.',
    `previous_employment_status` STRING COMMENT 'Employment status of the employee before this action.. Valid values are `active|on_leave|suspended|terminated`',
    `previous_employment_type` STRING COMMENT 'Type of employment contract before this action.. Valid values are `full_time|part_time|contract|temporary|seasonal|intern`',
    `previous_fte_allocation` DECIMAL(18,2) COMMENT 'Full-time equivalent allocation before this action (e.g., 1.00 for full-time, 0.50 for half-time).',
    `previous_grade_band` STRING COMMENT 'Salary grade or band the employee was assigned to before this action.',
    `previous_home_base_airport_code` STRING COMMENT 'Three-letter IATA airport code representing the employees home base before this action. Relevant for crew and operational staff.. Valid values are `^[A-Z]{3}$`',
    `previous_job_title` STRING COMMENT 'Job title held by the employee before this personnel action.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this action requires reporting to regulatory authorities such as FAA, EASA, or DOT.',
    `salary_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for salary amounts.. Valid values are `^[A-Z]{3}$`',
    `union_notification_date` DATE COMMENT 'Date when the union was notified of this personnel action, if applicable.',
    `union_notification_required_flag` BOOLEAN COMMENT 'Indicates whether union notification is required for this personnel action per collective bargaining agreements.',
    CONSTRAINT pk_employee_action PRIMARY KEY(`employee_action_id`)
) COMMENT 'Transactional entity recording all HR personnel actions and employment lifecycle events for an employee — including hire, promotion, transfer, demotion, base change, leave of absence, return from leave, contract change, and termination. Captures action type, effective date, previous and new values (position, org unit, grade, salary), reason code, initiating manager, HR approver, and SAP action reason code. Aligns with SAP PA Infotype 0000 Actions. SSOT for employment history and audit trail.';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` (
    `staff_travel_entitlement_id` BIGINT COMMENT 'Unique identifier for the staff travel entitlement record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who holds this travel entitlement. Links to the employee master record in the workforce domain.',
    `advance_booking_days_maximum` STRING COMMENT 'Maximum number of days in advance that staff travel can be booked under this entitlement. Null if no maximum advance booking restriction applies.',
    `advance_booking_days_minimum` STRING COMMENT 'Minimum number of days in advance that staff travel must be booked under this entitlement. Null if no minimum advance booking requirement applies.',
    `annual_allocation_sectors` STRING COMMENT 'Number of flight sectors (individual flight segments) allocated to the employee per calendar year under this entitlement. Null if allocation is measured in trips instead of sectors.',
    `annual_allocation_trips` STRING COMMENT 'Number of round trips or one-way trips allocated to the employee per calendar year under this entitlement. Null if allocation is measured in sectors instead of trips.',
    `blackout_dates_apply_flag` BOOLEAN COMMENT 'Indicates whether blackout dates (peak travel periods where staff travel is restricted) apply to this entitlement. True if blackout restrictions apply, false if entitlement is exempt from blackout dates.',
    `cabin_class_restriction` STRING COMMENT 'Maximum cabin class the employee is entitled to book under this entitlement. Economy restricts to economy class only; business allows up to business class; first allows all classes including first; any indicates no restriction.. Valid values are `economy|premium_economy|business|first|any`',
    `carry_forward_allowed_flag` BOOLEAN COMMENT 'Indicates whether unused allocation from the current year can be carried forward to the next calendar year. True if carry-forward is permitted, false otherwise.',
    `carry_forward_limit_sectors` STRING COMMENT 'Maximum number of unused sectors that can be carried forward to the next calendar year. Null if no carry-forward is allowed or if measured in trips.',
    `carry_forward_limit_trips` STRING COMMENT 'Maximum number of unused trips that can be carried forward to the next calendar year. Null if no carry-forward is allowed or if measured in sectors.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this entitlement record was first created in the system. Used for audit trail and record lifecycle tracking.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the base fare for staff travel bookings under this entitlement. For example, 90.00 represents a 90% discount (ID90), 50.00 represents a 50% discount (ID50).',
    `effective_from_date` DATE COMMENT 'Date from which this travel entitlement becomes valid and can be used for booking staff travel.',
    `effective_to_date` DATE COMMENT 'Date until which this travel entitlement remains valid. Nullable for open-ended entitlements that remain valid until employment termination or policy change.',
    `eligibility_tier` STRING COMMENT 'Tier classification determining the level of travel benefits based on employee grade, tenure, and position. Higher tiers receive more generous allocations and priority. [ENUM-REF-CANDIDATE: tier_1|tier_2|tier_3|tier_4|executive|management|operational|probationary — 8 candidates stripped; promote to reference product]',
    `entitlement_code` STRING COMMENT 'Unique business identifier for this entitlement record, used for operational reference and tracking.. Valid values are `^[A-Z0-9]{4,12}$`',
    `entitlement_type` STRING COMMENT 'Type of staff travel concession granted. ID90 standby (90% discount standby), ID50 confirmed (50% discount confirmed), ID75 standby (75% discount standby), ZED interline (Zonal Employee Discount for interline travel), rebate coupon (fixed rebate voucher), positive space (confirmed seat), staff leisure (personal travel), staff business (official business travel). [ENUM-REF-CANDIDATE: ID90_standby|ID50_confirmed|ID75_standby|ZED_interline|rebate_coupon|positive_space|staff_leisure|staff_business — 8 candidates stripped; promote to reference product]',
    `geographic_restriction` STRING COMMENT 'Geographic scope restriction applied to this entitlement. None indicates no restriction; domestic_only limits to domestic flights; regional limits to specific regions; international allows international travel; specific_routes limits to designated route list.. Valid values are `none|domestic_only|regional|international|specific_routes`',
    `interline_partner_agreements` STRING COMMENT 'Comma-separated list of IATA airline codes representing interline partner airlines where this entitlement can be used for ZED or reciprocal staff travel. Example: BA,LH,AF,QF. Null if entitlement is restricted to own airline only.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this entitlement record was last updated. Used for audit trail, change tracking, and data synchronization.',
    `maximum_nominees_count` STRING COMMENT 'Maximum number of eligible nominees (spouse, dependants, parents) who can be registered under this entitlement. Null if no limit applies.',
    `modified_by_user` STRING COMMENT 'User ID or username of the HR administrator or system user who last modified this entitlement record. Used for audit trail and accountability.',
    `nominee_dependants_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employees dependent children are eligible to use this travel entitlement as nominees. True if dependants are eligible, false otherwise.',
    `nominee_parents_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employees parents are eligible to use this travel entitlement as nominees. True if parents are eligible, false otherwise.',
    `nominee_spouse_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employees spouse or domestic partner is eligible to use this travel entitlement as a nominee. True if spouse is eligible, false otherwise.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or remarks related to this travel entitlement. May include information about special approvals, exceptions, or restrictions.',
    `policy_version` STRING COMMENT 'Version number of the staff travel policy under which this entitlement was granted. Used for tracking policy changes over time and ensuring compliance with the applicable policy version.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    `priority_level` STRING COMMENT 'Boarding priority level assigned to staff travel bookings under this entitlement when traveling standby. Lower numbers indicate higher priority. Used for waitlist sequencing when flights are overbooked.',
    `remaining_allocation_sectors` STRING COMMENT 'Number of sectors remaining in the annual allocation available for future bookings. Calculated as annual_allocation_sectors minus used_allocation_sectors.',
    `remaining_allocation_trips` STRING COMMENT 'Number of trips remaining in the annual allocation available for future bookings. Calculated as annual_allocation_trips minus used_allocation_trips.',
    `service_charge_amount` DECIMAL(18,2) COMMENT 'Fixed service charge amount levied per booking or per sector for administrative processing of staff travel under this entitlement. Null if no service charge applies.',
    `service_charge_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the service charge amount. Example: USD, EUR, GBP. Null if no service charge applies.. Valid values are `^[A-Z]{3}$`',
    `staff_travel_entitlement_status` STRING COMMENT 'Current lifecycle status of the travel entitlement. Active entitlements can be used for booking; suspended entitlements are temporarily blocked; expired entitlements have passed their validity period; revoked entitlements are permanently cancelled.. Valid values are `active|suspended|expired|revoked|pending_activation|inactive`',
    `taxes_fees_waived_flag` BOOLEAN COMMENT 'Indicates whether airport taxes, fuel surcharges, and government fees are waived for staff travel bookings under this entitlement. True if taxes and fees are waived, false if employee must pay taxes and fees.',
    `union_agreement_code` STRING COMMENT 'Code identifying the collective bargaining agreement or union contract that governs this travel entitlement. Null if entitlement is not governed by a union agreement.. Valid values are `^[A-Z0-9]{2,10}$`',
    `used_allocation_sectors` STRING COMMENT 'Number of sectors from the annual allocation that have been consumed year-to-date. Updated after each completed staff travel booking.',
    `used_allocation_trips` STRING COMMENT 'Number of trips from the annual allocation that have been consumed year-to-date. Updated after each completed staff travel booking.',
    CONSTRAINT pk_staff_travel_entitlement PRIMARY KEY(`staff_travel_entitlement_id`)
) COMMENT 'Master entity defining the staff travel concession entitlements granted to employees and their eligible nominees (spouse, dependants, parents) as part of the airlines employee benefit programme. Captures employee reference, entitlement type (ID90 standby, ID50 confirmed, ZED interline, rebate coupon), eligible nominees, annual allocation (number of trips or sectors), used allocation, carry-forward rules, eligibility tier (based on grade and tenure), and applicable interline partner agreements. Distinct from the loyalty FFP domain.';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`medical_compliance` (
    `medical_compliance_id` BIGINT COMMENT 'Unique identifier for the medical compliance record. Primary key. Role: TRANSACTION_HEADER.',
    `medical_certificate_id` BIGINT COMMENT 'Reference to the aviation medical certificate record in crew.medical_certificate, which is the system of record (SSOT) for the actual medical certificate. This compliance record tracks HR administrative follow-up and fitness-for-duty decisions related to that certificate.',
    `employee_id` BIGINT COMMENT 'Reference to the employee whose medical compliance is being tracked. Links to workforce.employee.',
    `tertiary_medical_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the HR system user who last modified this compliance record, providing audit trail for compliance actions and determinations.',
    `superseded_medical_compliance_id` BIGINT COMMENT 'Self-referencing FK on medical_compliance (superseded_medical_compliance_id)',
    `certificate_class` STRING COMMENT 'Class of aviation medical certificate required for the employees role (Class 1 for airline transport pilots, Class 2 for commercial pilots, Class 3 for private pilots, cabin crew medical, or air traffic controller medical).. Valid values are `class_1|class_2|class_3|cabin_crew|atc`',
    `certificate_expiry_date` DATE COMMENT 'Date when the current medical certificate expires. Denormalized from crew.medical_certificate for HR operational convenience and expiry notification workflows.',
    `compliance_record_number` STRING COMMENT 'Human-readable unique identifier for this HR medical compliance administrative record, used for tracking and reference in HR systems.',
    `compliance_status` STRING COMMENT 'Current HR compliance status of the employees medical certification from an administrative and fitness-for-duty perspective. Reflects HR follow-up actions and administrative decisions, distinct from the certificate validity status in crew.medical_certificate. [ENUM-REF-CANDIDATE: compliant|non_compliant|pending_review|expired|waiver_granted|under_investigation|remediation_required — 7 candidates stripped; promote to reference product]',
    `crew_scheduling_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is currently eligible for crew scheduling and flight duty assignment based on their medical compliance status. Used by crew scheduling systems to filter available crew.',
    `fitness_determination_date` DATE COMMENT 'Date when the fitness-for-duty determination was made by HR or occupational health, establishing the current operational status.',
    `fitness_for_duty_status` STRING COMMENT 'HR administrative determination of the employees fitness to perform safety-critical duties based on medical compliance status. This is an HR operational flag that may trigger crew scheduling restrictions.. Valid values are `fit|unfit|fit_with_restrictions|pending_assessment|temporary_grounding|permanent_grounding`',
    `follow_up_action_required` STRING COMMENT 'HR administrative follow-up action required to maintain or restore medical compliance status. Tracks the next step in the compliance workflow. [ENUM-REF-CANDIDATE: none|renewal_required|medical_exam_scheduled|documentation_submission|fitness_assessment|management_review|grounding_recommended — 7 candidates stripped; promote to reference product]',
    `follow_up_completed_date` DATE COMMENT 'Date when the required follow-up action was completed by the employee or HR, resolving the compliance issue.',
    `follow_up_due_date` DATE COMMENT 'Date by which the required follow-up action must be completed to maintain compliance status and avoid operational impact (e.g., crew scheduling restrictions).',
    `issuing_authority` STRING COMMENT 'Regulatory authority or aviation medical examiner (AME) that issued the medical certificate or waiver (e.g., FAA, EASA, national civil aviation authority).',
    `issuing_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the regulatory authority that issued the medical certificate.. Valid values are `^[A-Z]{3}$`',
    `last_medical_exam_date` DATE COMMENT 'Date of the employees most recent aviation medical examination. Denormalized from crew.medical_certificate for HR tracking and scheduling of next exam.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this medical compliance record was last updated, reflecting the most recent HR review, status change, or follow-up action.',
    `next_medical_exam_due_date` DATE COMMENT 'Date by which the employee must complete their next aviation medical examination to maintain certificate validity and compliance status.',
    `notes` STRING COMMENT 'Free-text notes from HR regarding medical compliance status, follow-up actions, communications with employee, or special circumstances. Confidential HR administrative information.',
    `notification_method` STRING COMMENT 'Method used by HR to notify the employee of medical compliance requirements, expiry warnings, or follow-up actions.. Valid values are `email|sms|postal_mail|in_person|system_alert|manager_notification`',
    `notification_sent_date` DATE COMMENT 'Date when HR sent expiry notification or compliance reminder to the employee regarding their medical certificate renewal or compliance action required.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this medical compliance record was first created in the HR system, marking the start of HR administrative tracking for this compliance event.',
    `regulatory_report_date` DATE COMMENT 'Date when the medical compliance event was reported to the regulatory authority, if required.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this medical compliance event requires reporting to regulatory authorities (e.g., FAA, EASA) due to safety implications, certificate suspension, or fitness determination.',
    `restrictions_description` STRING COMMENT 'Description of any operational restrictions or limitations placed on the employees duties due to medical compliance status or fitness-for-duty assessment (e.g., no night flights, no long-haul, ground duties only).',
    `review_date` DATE COMMENT 'Date when the HR reviewer last assessed this medical compliance record and updated the compliance status or fitness determination.',
    `scheduling_restriction_end_date` DATE COMMENT 'Date when crew scheduling restrictions are expected to be lifted, subject to compliance restoration and fitness clearance.',
    `scheduling_restriction_start_date` DATE COMMENT 'Date when crew scheduling restrictions due to medical non-compliance or fitness concerns became effective, preventing assignment to flight duties.',
    `union_notification_date` DATE COMMENT 'Date when the union was notified of medical compliance actions affecting the employee, as required by labor agreements.',
    `union_notification_required_flag` BOOLEAN COMMENT 'Indicates whether union notification is required for this medical compliance action per collective bargaining agreement provisions on medical fitness and duty restrictions.',
    `waiver_conditions` STRING COMMENT 'Specific conditions or limitations attached to the medical waiver by the regulatory authority (e.g., periodic monitoring, co-pilot restriction, operational limitations).',
    `waiver_expiry_date` DATE COMMENT 'Date when the medical waiver or special issuance expires, requiring renewal or reassessment.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether a medical waiver or special issuance has been granted by the regulatory authority, allowing the employee to operate despite a medical condition that would normally be disqualifying.',
    CONSTRAINT pk_medical_compliance PRIMARY KEY(`medical_compliance_id`)
) COMMENT 'Tracks HR compliance status and administrative records for employee medical certificates, referencing crew.medical_certificate as the SSOT for the actual aviation medical certificate. Records HR follow-up actions, expiry notifications, and fitness-for-duty administrative decisions.';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`licence_compliance` (
    `licence_compliance_id` BIGINT COMMENT 'Unique identifier for the licence compliance record. Primary key for this product.',
    `licence_id` BIGINT COMMENT 'Reference to the aviation licence record in crew.licence which serves as the system of record for the actual licence details.',
    `employee_id` BIGINT COMMENT 'Reference to the employee whose licence compliance is being tracked.',
    `quaternary_licence_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the person who last modified this compliance record.',
    `tertiary_licence_responsible_hr_manager_employee_id` BIGINT COMMENT 'Reference to the HR manager responsible for overseeing this compliance record.',
    `superseded_licence_compliance_id` BIGINT COMMENT 'Self-referencing FK on licence_compliance (superseded_licence_compliance_id)',
    `action_date` DATE COMMENT 'Date when the compliance action was taken or recorded.',
    `audit_trail_notes` STRING COMMENT 'Free-text notes documenting the compliance verification process, actions taken, and any relevant observations for audit purposes.',
    `compliance_action_type` STRING COMMENT 'Type of administrative compliance action recorded in this entry.. Valid values are `initial_verification|periodic_review|renewal_tracking|suspension_notice|reinstatement|audit_response`',
    `compliance_record_number` STRING COMMENT 'Unique business identifier for the compliance record, formatted as LCR- followed by 8 digits.. Valid values are `^LCR-[0-9]{8}$`',
    `compliance_status` STRING COMMENT 'Current compliance status of the employees aviation licence from an HR administrative perspective.. Valid values are `compliant|non_compliant|pending_verification|expired|suspended|under_review`',
    `cost_center_code` STRING COMMENT 'Cost center code associated with the employee for compliance tracking and reporting purposes.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance record was first created in the system.',
    `crew_scheduling_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for crew scheduling based on current licence compliance status.',
    `document_reference_url` STRING COMMENT 'URL or file path to supporting documentation for the compliance record (scanned licence copies, verification certificates, correspondence).',
    `effective_from_date` DATE COMMENT 'Date from which this compliance record is effective.',
    `effective_to_date` DATE COMMENT 'Date until which this compliance record is effective. Null indicates currently active record.',
    `grounding_effective_date` DATE COMMENT 'Date when grounding from flight duties became effective.',
    `grounding_flag` BOOLEAN COMMENT 'Indicates whether the employee has been grounded from flight duties due to licence compliance issues.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance record was last updated.',
    `next_verification_due_date` DATE COMMENT 'Date when the next compliance verification is scheduled or required.',
    `non_compliance_reason` STRING COMMENT 'Detailed explanation of why the licence is marked as non-compliant, if applicable.',
    `regulatory_authority_code` STRING COMMENT 'Code identifying the aviation regulatory authority that issued or oversees the licence (e.g., FAA, EASA, CAAC, DGCA).. Valid values are `^[A-Z]{2,4}$`',
    `regulatory_report_date` DATE COMMENT 'Date when the compliance status was reported to the regulatory authority.',
    `regulatory_report_reference_number` STRING COMMENT 'Reference number assigned by the regulatory authority for the compliance report submission.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this compliance record must be reported to regulatory authorities.',
    `remediation_deadline_date` DATE COMMENT 'Deadline by which remediation actions must be completed.',
    `remediation_plan` STRING COMMENT 'Description of the remediation plan or corrective actions required to achieve compliance.',
    `remediation_required_flag` BOOLEAN COMMENT 'Indicates whether remediation actions are required to restore compliance status.',
    `renewal_deadline_date` DATE COMMENT 'Administrative deadline by which the licence must be renewed to maintain compliance status.',
    `renewal_reminder_sent_date` DATE COMMENT 'Date when the renewal reminder notification was sent to the employee.',
    `renewal_tracking_status` STRING COMMENT 'Administrative tracking status for licence renewal process from HR perspective.. Valid values are `not_due|reminder_sent|renewal_in_progress|renewal_completed|overdue`',
    `verification_date` DATE COMMENT 'Date when the licence was last verified by HR or compliance personnel.',
    `verification_method` STRING COMMENT 'Method used to verify the authenticity and validity of the aviation licence.. Valid values are `manual_inspection|regulatory_authority_api|third_party_service|document_upload|in_person`',
    `verification_status` STRING COMMENT 'Status of the administrative verification process for the licence authenticity and validity.. Valid values are `verified|pending|failed|not_required|expired`',
    CONSTRAINT pk_licence_compliance PRIMARY KEY(`licence_compliance_id`)
) COMMENT 'Tracks HR compliance status and administrative records for employee aviation licences, referencing crew.licence as the SSOT for the actual aviation licence. Records licence verification, renewal tracking, and regulatory compliance administrative actions.';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`enrollment` (
    `enrollment_id` BIGINT COMMENT 'Unique identifier for this benefit enrollment record. Primary key.',
    `benefit_plan_id` BIGINT COMMENT 'Foreign key linking to the benefit plan in which the employee is enrolled',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee who is enrolled in the benefit plan',
    `coverage_end_date` DATE COMMENT 'Date when benefit coverage ends or is terminated for this enrollment. Null for active enrollments. Identified in detection relationship data.',
    `coverage_start_date` DATE COMMENT 'Date when benefit coverage becomes effective for this enrollment. Identified in detection relationship data.',
    `coverage_tier` STRING COMMENT 'Coverage tier elected by the employee for this plan (employee_only, employee_spouse, employee_children, family). Identified in detection relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was first created in the system.',
    `dependents_enrolled_count` STRING COMMENT 'Number of dependents (spouse, children) covered under this enrollment. Identified in detection relationship data.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Actual dollar amount the employee contributes per pay period for this enrollment. May differ from plan default based on coverage tier. Identified in detection relationship data.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Actual dollar amount the employer contributes per pay period for this enrollment. May differ from plan default based on coverage tier. Identified in detection relationship data.',
    `enrollment_date` DATE COMMENT 'Date when the employee elected or enrolled in this benefit plan. Corresponds to enrolment_date from detection data.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of this benefit enrollment (active, terminated, waived, pending, suspended). Corresponds to enrolment_status from detection data.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was last updated. Tracks changes to enrollment status, coverage tier, or contribution amounts.',
    `life_event_date` DATE COMMENT 'Date when the qualifying life event occurred that triggered this enrollment change. Identified in detection relationship data.',
    `life_event_type` STRING COMMENT 'Qualifying life event that triggered this enrollment or change outside of open enrollment period. Identified in detection relationship data.',
    `waiver_flag` BOOLEAN COMMENT 'Indicates whether the employee explicitly waived enrollment in this benefit plan during open enrollment. Identified in detection relationship data.',
    `waiver_reason` STRING COMMENT 'Reason code or description for why the employee waived this benefit (e.g., covered_by_spouse, cost, not_needed). Identified in detection relationship data.',
    CONSTRAINT pk_enrollment PRIMARY KEY(`enrollment_id`)
) COMMENT 'This association product represents the enrollment contract between employee and benefit_plan. It captures the employees election of a specific benefit plan with coverage tier, contribution amounts, enrollment dates, and life event triggers. Each record links one employee to one benefit_plan with attributes that exist only in the context of this enrollment relationship. Supports open enrollment, qualifying life events, and historical tracking of benefit elections.. Existence Justification: Benefit enrollment is a core HR business process where employees actively elect multiple benefit plans (health, dental, vision, life insurance, retirement) and the airline offers each plan to thousands of employees. The business manages enrollments as operational records with coverage tiers, contribution amounts, enrollment dates, life event triggers, and status tracking. HR and benefits administrators create, modify, and terminate enrollments during open enrollment periods and qualifying life events.';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`position_budget` (
    `position_budget_id` BIGINT COMMENT 'Unique surrogate identifier for the position budget allocation record. Primary key for the association.',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to the budget plan. Each position budget allocation belongs to exactly one budget plan (annual, rolling forecast, scenario plan, etc.).',
    `position_id` BIGINT COMMENT 'Foreign key linking to the position being budgeted. Each position budget allocation references exactly one authorized position in the organizational structure.',
    `approval_status` STRING COMMENT 'Current approval status of this position budget allocation within the budget approval workflow. Values: draft, submitted, approved, rejected, revised. Enables position-level budget approval tracking within the overall plan.',
    `budget_notes` STRING COMMENT 'Free-text notes or assumptions specific to this position budget allocation (e.g., assumes 3-month vacancy, includes type rating training cost, contingent on fleet expansion approval). Provides context for budget reviewers and variance analysis.',
    `budgeted_fte` DECIMAL(18,2) COMMENT 'The planned FTE allocation for this position within this budget plan. May differ from the positions base FTE allocation to reflect hiring plans, vacancy assumptions, or scenario planning (e.g., 0.50 FTE budgeted for a 1.00 FTE position due to expected vacancy).',
    `budgeted_salary_amount` DECIMAL(18,2) COMMENT 'The total salary cost budgeted for this position within this budget plan, including base salary, allowances, and statutory benefits. Denominated in the budget plans currency. Used for labor cost forecasting and OPEX planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this position budget allocation record was first created in the system. Used for audit trail and planning cycle tracking.',
    `effective_from` DATE COMMENT 'The start date from which this position budget allocation is effective within the budget plan. Supports phased hiring plans or mid-year position activations.',
    `effective_until` DATE COMMENT 'The end date through which this position budget allocation remains effective within the budget plan. Null for allocations that span the entire plan horizon. Supports scenario planning for position phase-outs or transfers.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this position budget allocation applies. Supports multi-year planning where a position may have different budgeted amounts across fiscal years within the same budget plan.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this position budget allocation record was last updated. Used for change tracking during iterative budget cycles.',
    `modified_by_user` STRING COMMENT 'User identifier of the person who last modified this position budget allocation record. Used for accountability in budget planning workflows.',
    `variance_threshold` DECIMAL(18,2) COMMENT 'The maximum allowable absolute monetary deviation between budgeted and actual salary costs for this position within this plan before triggering management review. May differ from the plan-level variance threshold to reflect position criticality or cost materiality.',
    CONSTRAINT pk_position_budget PRIMARY KEY(`position_budget_id`)
) COMMENT 'This association product represents the budgeting allocation between budget_plan and position. It captures the planned headcount (FTE) and salary costs for each position within each budget plan, supporting multi-year workforce planning, scenario analysis, and labor cost forecasting aligned with fleet expansion and route network changes. Each record links one budget_plan to one position with budgeted amounts, approval status, and variance tracking that exist only in the context of this planning relationship.. Existence Justification: In airline workforce planning, a single budget plan (annual budget, rolling forecast, scenario plan) allocates budgeted FTE and salary amounts to hundreds or thousands of positions across the organizational structure. Conversely, a single position appears in multiple budget plans simultaneously—the FY2025 annual budget, the Q2 rolling forecast, and the fleet expansion scenario plan may all contain different budgeted amounts for the same Captain position. The business actively manages these position budget allocations as discrete planning records with approval workflows, variance tracking, and scenario-specific assumptions.';

CREATE OR REPLACE TABLE `airlines_ecm`.`workforce`.`category_responsibility` (
    `category_responsibility_id` BIGINT COMMENT 'Unique identifier for this category responsibility assignment record. Primary key.',
    `assigned_by_employee_id` BIGINT COMMENT 'Foreign key to workforce.employee identifying the manager or procurement director who made this assignment. Supports audit trail and accountability.',
    `category_procurement_category_id` BIGINT COMMENT 'Foreign key linking to the procurement category for which responsibility is assigned',
    `employee_id` BIGINT COMMENT 'Foreign key to workforce.employee. Identifies the employee assigned to this category responsibility.',
    `procurement_category_id` BIGINT COMMENT 'Foreign key to procurement.procurement_category. Identifies the category for which responsibility is assigned.',
    `assignment_notes` STRING COMMENT 'Free-text notes about this assignment, including special conditions, coverage arrangements, or transition plans.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this responsibility assignment. Values: active (currently in effect), on_hold (temporarily suspended), pending (scheduled future assignment), expired (past assignment).',
    `authorization_level` STRING COMMENT 'The level of authorization this employee has for procurement decisions in this category. Values: full_authority (can commit spend and manage suppliers), approval_only (can approve requisitions), advisory_only (provides input but no approval rights), read_only (visibility only). Explicitly identified in detection reasoning.',
    `backup_flag` BOOLEAN COMMENT 'Indicates whether this is a backup assignment (true) or primary assignment (false). Critical for vacation coverage and workload distribution. Explicitly identified in detection reasoning.',
    `category_manager_email` STRING COMMENT 'Email address of the category manager or lead buyer responsible for this category. Used for escalations and strategic sourcing inquiries. [Moved from procurement_category: The category_manager_email attribute in procurement_category stores a single managers email, but the business reality requires tracking multiple employees with different roles per category. This attribute should be deprecated in favor of joining to workforce.employee through the category_responsibility association to retrieve email addresses for all assigned employees based on their roles.]. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `category_owner` STRING COMMENT 'Name or identifier of the lead buyer or procurement manager responsible for strategic sourcing and supplier management within this category. [Moved from procurement_category: The category_owner attribute in procurement_category currently stores a single owner name/identifier, but the business reality is that multiple employees have different roles for each category (primary manager, backup, technical specialist, finance controller). This attribute should be deprecated in favor of querying the category_responsibility association to determine the current primary_manager for each category. The association provides richer role-based assignment tracking.]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was created in the system.',
    `effective_date` DATE COMMENT 'Date from which this employees responsibility for this category became active. Used for tracking assignment history and determining current responsibilities. Explicitly identified in detection reasoning.',
    `expiry_date` DATE COMMENT 'Date on which this employees responsibility for this category ends or ended. Null for current active assignments. Supports rotation planning and historical tracking. Explicitly identified in detection reasoning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was last updated. Used for change tracking and audit.',
    `role_type` STRING COMMENT 'The specific role this employee performs for this category. Values: primary_manager (lead category manager), backup_manager (coverage during absence), technical_specialist (technical expertise for specifications), finance_controller (financial oversight), approver (approval authority), technical_advisor (advisory role). Explicitly identified in detection reasoning.',
    `workload_percentage` DECIMAL(18,2) COMMENT 'Percentage of the employees time allocated to this category (0.00 to 100.00). Used for workload balancing and capacity planning when employees manage multiple categories.',
    CONSTRAINT pk_category_responsibility PRIMARY KEY(`category_responsibility_id`)
) COMMENT 'This association product represents the assignment of employees to procurement categories with specific roles and authorization levels. It captures the operational responsibility structure for category management, including primary managers, backup coverage, technical specialists, and approval authorities. Each record links one employee to one procurement category with role-specific attributes that exist only in the context of this assignment relationship.. Existence Justification: In airline procurement operations, multiple employees are assigned to each procurement category with distinct roles (primary manager, backup manager, technical specialist, finance controller, approver, technical advisor), and employees typically manage multiple categories across the spend taxonomy. The business actively manages these assignments for workload distribution, vacation coverage, approval routing, and succession planning. This is an operational assignment process, not an analytical correlation.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_job_classification_id` FOREIGN KEY (`job_classification_id`) REFERENCES `airlines_ecm`.`workforce`.`job_classification`(`job_classification_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_union_agreement_id` FOREIGN KEY (`union_agreement_id`) REFERENCES `airlines_ecm`.`workforce`.`union_agreement`(`union_agreement_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_position_id` FOREIGN KEY (`position_id`) REFERENCES `airlines_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `airlines_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_classification_id` FOREIGN KEY (`job_classification_id`) REFERENCES `airlines_ecm`.`workforce`.`job_classification`(`job_classification_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `airlines_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `airlines_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_union_agreement_id` FOREIGN KEY (`union_agreement_id`) REFERENCES `airlines_ecm`.`workforce`.`union_agreement`(`union_agreement_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ADD CONSTRAINT `fk_workforce_job_classification_union_agreement_id` FOREIGN KEY (`union_agreement_id`) REFERENCES `airlines_ecm`.`workforce`.`union_agreement`(`union_agreement_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `airlines_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_previous_contract_employment_contract_id` FOREIGN KEY (`previous_contract_employment_contract_id`) REFERENCES `airlines_ecm`.`workforce`.`employment_contract`(`employment_contract_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_union_agreement_id` FOREIGN KEY (`union_agreement_id`) REFERENCES `airlines_ecm`.`workforce`.`union_agreement`(`union_agreement_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_position_id` FOREIGN KEY (`position_id`) REFERENCES `airlines_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ADD CONSTRAINT `fk_workforce_payslip_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `airlines_ecm`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ADD CONSTRAINT `fk_workforce_benefit_plan_union_agreement_id` FOREIGN KEY (`union_agreement_id`) REFERENCES `airlines_ecm`.`workforce`.`union_agreement`(`union_agreement_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ADD CONSTRAINT `fk_workforce_benefit_enrolment_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `airlines_ecm`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ADD CONSTRAINT `fk_workforce_benefit_enrolment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ADD CONSTRAINT `fk_workforce_type_rating_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `airlines_ecm`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ADD CONSTRAINT `fk_workforce_grievance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ADD CONSTRAINT `fk_workforce_grievance_grievance_employee_id` FOREIGN KEY (`grievance_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `airlines_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_union_agreement_id` FOREIGN KEY (`union_agreement_id`) REFERENCES `airlines_ecm`.`workforce`.`union_agreement`(`union_agreement_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_position_id` FOREIGN KEY (`position_id`) REFERENCES `airlines_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_job_classification_id` FOREIGN KEY (`job_classification_id`) REFERENCES `airlines_ecm`.`workforce`.`job_classification`(`job_classification_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `airlines_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_position_id` FOREIGN KEY (`position_id`) REFERENCES `airlines_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_quaternary_recruitment_replacement_employee_id` FOREIGN KEY (`quaternary_recruitment_replacement_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_tertiary_recruitment_approved_by_employee_id` FOREIGN KEY (`tertiary_recruitment_approved_by_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_union_agreement_id` FOREIGN KEY (`union_agreement_id`) REFERENCES `airlines_ecm`.`workforce`.`union_agreement`(`union_agreement_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_applicant_referral_employee_id` FOREIGN KEY (`applicant_referral_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_recruitment_requisition_id` FOREIGN KEY (`recruitment_requisition_id`) REFERENCES `airlines_ecm`.`workforce`.`recruitment_requisition`(`recruitment_requisition_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `airlines_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_tertiary_absence_replacement_employee_id` FOREIGN KEY (`tertiary_absence_replacement_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_union_agreement_id` FOREIGN KEY (`union_agreement_id`) REFERENCES `airlines_ecm`.`workforce`.`union_agreement`(`union_agreement_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ADD CONSTRAINT `fk_workforce_employee_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ADD CONSTRAINT `fk_workforce_employee_action_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `airlines_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ADD CONSTRAINT `fk_workforce_employee_action_position_id` FOREIGN KEY (`position_id`) REFERENCES `airlines_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ADD CONSTRAINT `fk_workforce_employee_action_tertiary_hr_approver_employee_id` FOREIGN KEY (`tertiary_hr_approver_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ADD CONSTRAINT `fk_workforce_staff_travel_entitlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ADD CONSTRAINT `fk_workforce_medical_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ADD CONSTRAINT `fk_workforce_medical_compliance_tertiary_medical_modified_by_user_employee_id` FOREIGN KEY (`tertiary_medical_modified_by_user_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ADD CONSTRAINT `fk_workforce_medical_compliance_superseded_medical_compliance_id` FOREIGN KEY (`superseded_medical_compliance_id`) REFERENCES `airlines_ecm`.`workforce`.`medical_compliance`(`medical_compliance_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ADD CONSTRAINT `fk_workforce_licence_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ADD CONSTRAINT `fk_workforce_licence_compliance_quaternary_licence_modified_by_user_employee_id` FOREIGN KEY (`quaternary_licence_modified_by_user_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ADD CONSTRAINT `fk_workforce_licence_compliance_tertiary_licence_responsible_hr_manager_employee_id` FOREIGN KEY (`tertiary_licence_responsible_hr_manager_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ADD CONSTRAINT `fk_workforce_licence_compliance_superseded_licence_compliance_id` FOREIGN KEY (`superseded_licence_compliance_id`) REFERENCES `airlines_ecm`.`workforce`.`licence_compliance`(`licence_compliance_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` ADD CONSTRAINT `fk_workforce_enrollment_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `airlines_ecm`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` ADD CONSTRAINT `fk_workforce_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`position_budget` ADD CONSTRAINT `fk_workforce_position_budget_position_id` FOREIGN KEY (`position_id`) REFERENCES `airlines_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ADD CONSTRAINT `fk_workforce_category_responsibility_assigned_by_employee_id` FOREIGN KEY (`assigned_by_employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ADD CONSTRAINT `fk_workforce_category_responsibility_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `airlines_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= TAGS =========
ALTER SCHEMA `airlines_ecm`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `airlines_ecm`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `job_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Job Classification Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `union_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Position Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Employee Date of Birth');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Employee Email Address');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Number');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|leave|terminated|retired');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'permanent|contract|temporary|seasonal|acmi|intern');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Employee First Name');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Hire Date');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `home_base_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Home Base Airport Code');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `home_base_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Last Name');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `medical_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Expiry Date');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `medical_certificate_expiry_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `medical_certificate_expiry_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `medical_certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Status');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `medical_certificate_status` SET TAGS ('dbx_value_regex' = 'valid|expired|suspended|pending|not_required');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `medical_certificate_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `medical_certificate_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Middle Name');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Employee Nationality');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `nationality` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `nationality` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `passport_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Passport Expiry Date');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `passport_expiry_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `passport_expiry_date` SET TAGS ('dbx_pii_passport' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `passport_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Passport Number');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `passport_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `passport_number` SET TAGS ('dbx_pii_passport' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'outstanding|exceeds|meets|needs_improvement|unsatisfactory');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `performance_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Phone Number');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `salary_grade` SET TAGS ('dbx_business_glossary_term' = 'Salary Grade');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `salary_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `seniority_date` SET TAGS ('dbx_business_glossary_term' = 'Seniority Date');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Termination Date');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `union_membership_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `work_permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Expiry Date');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `work_permit_expiry_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `work_permit_expiry_date` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `work_permit_status` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Status');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `work_permit_status` SET TAGS ('dbx_value_regex' = 'not_required|valid|expired|pending|revoked');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `work_permit_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee` ALTER COLUMN `work_permit_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `headcount_actual` SET TAGS ('dbx_business_glossary_term' = 'Headcount Actual');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `headcount_planned` SET TAGS ('dbx_business_glossary_term' = 'Headcount Planned');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `iata_functional_code` SET TAGS ('dbx_business_glossary_term' = 'IATA (International Air Transport Association) Functional Code');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `iata_functional_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `is_hub` SET TAGS ('dbx_business_glossary_term' = 'Is Hub Indicator');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `is_revenue_generating` SET TAGS ('dbx_business_glossary_term' = 'Is Revenue Generating Indicator');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_level` SET TAGS ('dbx_business_glossary_term' = 'Organizational Level');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Description');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|dissolved|suspended');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `regulatory_oversight_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Oversight Authority');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `safety_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Short Name');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`org_unit` ALTER COLUMN `union_representation_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Representation Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `job_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Job Classification Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `reports_to_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Position Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `union_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `base_station_code` SET TAGS ('dbx_business_glossary_term' = 'Base Station Code');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `base_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `crew_category` SET TAGS ('dbx_business_glossary_term' = 'Crew Category');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `exempt_status` SET TAGS ('dbx_business_glossary_term' = 'Exempt Status');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `grade_band` SET TAGS ('dbx_business_glossary_term' = 'Grade Band');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `grade_band` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `icao_licence_category` SET TAGS ('dbx_business_glossary_term' = 'International Civil Aviation Organization (ICAO) Licence Category');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `language_requirements` SET TAGS ('dbx_business_glossary_term' = 'Language Requirements');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `medical_class_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Class Required');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `medical_class_required` SET TAGS ('dbx_value_regex' = 'class_1|class_2|class_3|not_required');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `medical_class_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `medical_class_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `minimum_flight_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Flight Hours');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'active|frozen|obsolete|planned|pending_approval');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `safety_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety-Critical Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_value_regex' = 'none|basic|enhanced|top_secret');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `seniority_list_code` SET TAGS ('dbx_business_glossary_term' = 'Seniority List Code');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `seniority_list_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `airlines_ecm`.`workforce`.`position` ALTER COLUMN `type_rating_required` SET TAGS ('dbx_business_glossary_term' = 'Type Rating Required');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `job_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Job Classification Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `union_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `eligible_for_bonus` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Bonus');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `eligible_for_stock` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Stock Compensation');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Status');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `iata_job_category` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Job Category');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `icao_occupational_category` SET TAGS ('dbx_business_glossary_term' = 'International Civil Aviation Organization (ICAO) Occupational Category');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `is_executive` SET TAGS ('dbx_business_glossary_term' = 'Is Executive Position');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `is_management` SET TAGS ('dbx_business_glossary_term' = 'Is Management Position');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `job_classification_status` SET TAGS ('dbx_business_glossary_term' = 'Job Classification Status');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `job_classification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|obsolete|pending');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `job_subfamily` SET TAGS ('dbx_business_glossary_term' = 'Job Subfamily');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `license_type_required` SET TAGS ('dbx_business_glossary_term' = 'License Type Required');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `medical_class_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Class Required');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `medical_class_required` SET TAGS ('dbx_value_regex' = 'class_1|class_2|class_3|cabin_crew|not_required');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `medical_class_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `medical_class_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `minimum_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience Years');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `organizational_level` SET TAGS ('dbx_business_glossary_term' = 'Organizational Level');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `pay_grade_maximum` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Maximum');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `pay_grade_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `pay_grade_midpoint` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Midpoint');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `pay_grade_midpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `pay_grade_minimum` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Minimum');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `pay_grade_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `reports_to_job_code` SET TAGS ('dbx_business_glossary_term' = 'Reports To Job Code');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `requires_aviation_license` SET TAGS ('dbx_business_glossary_term' = 'Requires Aviation License');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `requires_medical_certificate` SET TAGS ('dbx_business_glossary_term' = 'Requires Medical Certificate');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `requires_medical_certificate` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `requires_medical_certificate` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `requires_security_clearance` SET TAGS ('dbx_business_glossary_term' = 'Requires Security Clearance');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `requires_type_rating` SET TAGS ('dbx_business_glossary_term' = 'Requires Type Rating');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `safety_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Safety Sensitive Position');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `standard_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Standard Hours Per Week');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `standard_work_schedule` SET TAGS ('dbx_business_glossary_term' = 'Standard Work Schedule');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `standard_work_schedule` SET TAGS ('dbx_value_regex' = 'full_time|part_time|variable|shift_work|on_call');
ALTER TABLE `airlines_ecm`.`workforce`.`job_classification` ALTER COLUMN `union_eligible` SET TAGS ('dbx_business_glossary_term' = 'Union Eligible');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `employment_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `previous_contract_employment_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Contract Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `union_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Position Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `base_salary` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `base_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `benefits_package_code` SET TAGS ('dbx_business_glossary_term' = 'Benefits Package Code');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Uniform Resource Locator (URL)');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|pending_approval');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_version` SET TAGS ('dbx_business_glossary_term' = 'Contract Version Number');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contracted_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Contracted Hours Per Week');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `employment_category` SET TAGS ('dbx_business_glossary_term' = 'Employment Category');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `employment_category` SET TAGS ('dbx_value_regex' = 'flight_crew|cabin_crew|ground_staff|maintenance|corporate|management');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `full_time_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE)');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `governing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Jurisdiction Code');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `governing_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `is_union_member` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Indicator');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Duration (Days)');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly|annual');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `probation_period_months` SET TAGS ('dbx_business_glossary_term' = 'Probation Period Duration (Months)');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Contract Remarks');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'resignation|dismissal|redundancy|retirement|mutual_agreement|contract_expiry');
ALTER TABLE `airlines_ecm`.`workforce`.`employment_contract` ALTER COLUMN `travel_privileges_tier` SET TAGS ('dbx_business_glossary_term' = 'Travel Privileges Tier');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `accounting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}[0-9]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `calculation_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation End Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `calculation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Start Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `co_document_number` SET TAGS ('dbx_business_glossary_term' = 'Controlling (CO) Document Number');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `co_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Count Processed');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `fi_document_number` SET TAGS ('dbx_business_glossary_term' = 'Financial Accounting (FI) Document Number');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `fi_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Notes');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `off_cycle_reason` SET TAGS ('dbx_business_glossary_term' = 'Off-Cycle Payroll Reason');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `pay_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_area` SET TAGS ('dbx_business_glossary_term' = 'Payroll Area Code');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_period_identifier` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_period_identifier` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_schema` SET TAGS ('dbx_business_glossary_term' = 'Payroll Schema Code');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_schema` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `personnel_area` SET TAGS ('dbx_business_glossary_term' = 'Personnel Area Code');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `personnel_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `personnel_subarea` SET TAGS ('dbx_business_glossary_term' = 'Personnel Subarea Code');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `personnel_subarea` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Posting Date');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processing Status');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Description');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversal Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Type');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'regular|off_cycle|correction|advance|bonus|final');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_employee_tax` SET TAGS ('dbx_business_glossary_term' = 'Total Employee Tax Withholding');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_employee_tax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_employer_tax` SET TAGS ('dbx_business_glossary_term' = 'Total Employer Tax and Social Charges');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_employer_tax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Pay Amount');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Net Pay Amount');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_voluntary_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Voluntary Deductions Amount');
ALTER TABLE `airlines_ecm`.`workforce`.`payroll_run` ALTER COLUMN `total_voluntary_deductions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `payslip_id` SET TAGS ('dbx_business_glossary_term' = 'Payslip Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `allowances` SET TAGS ('dbx_business_glossary_term' = 'Other Allowances');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `base_salary` SET TAGS ('dbx_business_glossary_term' = 'Base Salary');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `base_salary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `base_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `block_hours` SET TAGS ('dbx_business_glossary_term' = 'Block Hours');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `bonus` SET TAGS ('dbx_business_glossary_term' = 'Bonus Payment');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `commission` SET TAGS ('dbx_business_glossary_term' = 'Commission Payment');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `employee_type` SET TAGS ('dbx_business_glossary_term' = 'Employee Type');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `employer_health_contribution` SET TAGS ('dbx_business_glossary_term' = 'Employer Health Insurance Contribution');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `employer_health_contribution` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `employer_health_contribution` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `employer_payroll_tax` SET TAGS ('dbx_business_glossary_term' = 'Employer Payroll Tax');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `employer_pension_contribution` SET TAGS ('dbx_business_glossary_term' = 'Employer Pension Contribution');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `flying_pay` SET TAGS ('dbx_business_glossary_term' = 'Flying Pay');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `garnishments` SET TAGS ('dbx_business_glossary_term' = 'Wage Garnishments');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `gross_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `gross_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `health_insurance_premium` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Premium (Employee)');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `health_insurance_premium` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `health_insurance_premium` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `income_tax` SET TAGS ('dbx_business_glossary_term' = 'Income Tax Withheld');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `medicare_tax` SET TAGS ('dbx_business_glossary_term' = 'Medicare Tax');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `net_pay` SET TAGS ('dbx_business_glossary_term' = 'Net Pay');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `net_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `net_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `other_deductions` SET TAGS ('dbx_business_glossary_term' = 'Other Deductions');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `overtime_pay` SET TAGS ('dbx_business_glossary_term' = 'Overtime Pay');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'direct_deposit|check|cash|wire_transfer');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `payslip_number` SET TAGS ('dbx_business_glossary_term' = 'Payslip Number');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `payslip_status` SET TAGS ('dbx_business_glossary_term' = 'Payslip Status');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `payslip_status` SET TAGS ('dbx_value_regex' = 'draft|calculated|approved|paid|voided|corrected');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `pension_contribution` SET TAGS ('dbx_business_glossary_term' = 'Pension Contribution (Employee)');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `per_diem` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Allowance');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `shift_differential` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Pay');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `social_security_tax` SET TAGS ('dbx_business_glossary_term' = 'Social Security Tax');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `social_security_tax` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `social_security_tax` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `total_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Deductions');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `union_dues` SET TAGS ('dbx_business_glossary_term' = 'Union Dues');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `year_to_date_gross` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Gross Pay');
ALTER TABLE `airlines_ecm`.`workforce`.`payslip` ALTER COLUMN `year_to_date_tax` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Tax Withheld');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `union_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `coverage_tier_structure` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier Structure');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `coverage_tier_structure` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|employee_family|tiered_custom');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `dependent_coverage_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Dependent Coverage Allowed Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `eligibility_employment_type` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Employment Type');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `eligibility_grade_range` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Grade Range');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `eligibility_minimum_tenure_months` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Minimum Tenure (Months)');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `employee_contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Rate');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `employer_contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Rate');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `enrollment_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window End Date');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `enrollment_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window Start Date');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `maximum_dependent_age` SET TAGS ('dbx_business_glossary_term' = 'Maximum Dependent Age');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `monthly_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Premium Amount');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `monthly_premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Code');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `plan_description_summary` SET TAGS ('dbx_business_glossary_term' = 'Plan Description Summary');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `plan_document_url` SET TAGS ('dbx_business_glossary_term' = 'Plan Document Uniform Resource Locator (URL)');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `plan_document_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `plan_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Date');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `plan_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Expiration Date');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Name');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Status');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|closed');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Type');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Provider Name');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `provider_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Provider Policy Number');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `provider_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `regulatory_compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Framework');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `travel_concession_class_entitlement` SET TAGS ('dbx_business_glossary_term' = 'Travel Concession Class Entitlement');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `travel_concession_class_entitlement` SET TAGS ('dbx_value_regex' = 'economy|premium_economy|business|first|mixed');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `travel_concession_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Travel Concession Eligibility Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `waiting_period_days` SET TAGS ('dbx_business_glossary_term' = 'Waiting Period (Days)');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `benefit_enrolment_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrolment Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `annual_election_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Election Amount');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `annual_election_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `annual_election_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `beneficiary_designation` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Designation');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `beneficiary_designation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `beneficiary_designation` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Policy Number');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `cobra_election_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Election Deadline Date');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `cobra_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Eligible Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `contribution_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Contribution Currency Code');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `contribution_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly|quarterly|annual');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|employee_family');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `dependents_enrolled_count` SET TAGS ('dbx_business_glossary_term' = 'Dependents Enrolled Count');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `enrolment_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Enrolment Confirmation Number');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `enrolment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrolment Date');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `enrolment_method` SET TAGS ('dbx_business_glossary_term' = 'Enrolment Method');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `enrolment_method` SET TAGS ('dbx_value_regex' = 'online_portal|paper_form|phone|hr_representative|automated');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `enrolment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrolment Source');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `enrolment_source` SET TAGS ('dbx_value_regex' = 'open_enrolment|new_hire|life_event|annual_renewal|qualifying_event|administrative');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `enrolment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrolment Status');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `enrolment_status` SET TAGS ('dbx_value_regex' = 'active|terminated|suspended|pending|waived|cancelled');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `evidence_of_insurability_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability Required Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `evidence_of_insurability_status` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability Status');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `evidence_of_insurability_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|denied|waived');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `life_event_date` SET TAGS ('dbx_business_glossary_term' = 'Life Event Date');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `life_event_type` SET TAGS ('dbx_business_glossary_term' = 'Life Event Type');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `pre_tax_election_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Tax Election Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `tobacco_user_flag` SET TAGS ('dbx_business_glossary_term' = 'Tobacco User Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `tobacco_user_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `tobacco_user_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `airlines_ecm`.`workforce`.`benefit_enrolment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_value_regex' = 'coverage_elsewhere|cost|not_needed|other');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` SET TAGS ('dbx_subdomain' = 'qualification_compliance');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `type_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Type Rating Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `aircraft_type_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Type Rating Certificate Number');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `certificate_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `checkride_date` SET TAGS ('dbx_business_glossary_term' = 'Type Rating Checkride Date');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `crew_scheduling_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Crew Scheduling Eligible Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `current_validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Current Validity Start Date');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `endorsements` SET TAGS ('dbx_business_glossary_term' = 'Type Rating Endorsements');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `examiner_name` SET TAGS ('dbx_business_glossary_term' = 'Designated Examiner Name');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Type Rating Expiry Date');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `fleet_transition_source_type` SET TAGS ('dbx_business_glossary_term' = 'Fleet Transition Source Aircraft Type');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `initial_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Issue Date');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Regulatory Authority');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_value_regex' = 'FAA|EASA|CAAC|TCCA|CASA|DGCA');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `last_revalidation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Revalidation Date');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `line_check_date` SET TAGS ('dbx_business_glossary_term' = 'Line Check Date');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `next_revalidation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Revalidation Due Date');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Type Rating Notes');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `pic_hours_on_type` SET TAGS ('dbx_business_glossary_term' = 'Pilot in Command (PIC) Hours on Aircraft Type');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `proficiency_check_date` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Check Date');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `rating_category` SET TAGS ('dbx_business_glossary_term' = 'Type Rating Category');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `rating_category` SET TAGS ('dbx_value_regex' = 'PIC|SIC|TRI|TRE|FE|AME');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `recency_check_date` SET TAGS ('dbx_business_glossary_term' = 'Recency Check Date');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `restrictions` SET TAGS ('dbx_business_glossary_term' = 'Type Rating Restrictions');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `simulator_qualification_level` SET TAGS ('dbx_business_glossary_term' = 'Simulator Qualification Level');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `simulator_qualification_level` SET TAGS ('dbx_value_regex' = 'Level A|Level B|Level C|Level D|FTD|FFS');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `total_flight_hours_on_type` SET TAGS ('dbx_business_glossary_term' = 'Total Flight Hours on Aircraft Type');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `training_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Training Organization Code');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `transition_training_hours` SET TAGS ('dbx_business_glossary_term' = 'Transition Training Hours');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `validity_status` SET TAGS ('dbx_business_glossary_term' = 'Type Rating Validity Status');
ALTER TABLE `airlines_ecm`.`workforce`.`type_rating` ALTER COLUMN `validity_status` SET TAGS ('dbx_value_regex' = 'valid|expired|suspended|revoked|pending');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` SET TAGS ('dbx_subdomain' = 'qualification_compliance');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Training Record Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Training Centre Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `aircraft_type_code` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Code');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `aircraft_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `approval_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Training Approval Authority Code');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `approval_authority_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `certificate_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Date');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Training Certificate Number');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `certificate_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration in Hours');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Training Expiry Date');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `external_provider_flag` SET TAGS ('dbx_business_glossary_term' = 'External Training Provider Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `external_provider_name` SET TAGS ('dbx_business_glossary_term' = 'External Training Provider Name');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Training Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Training Due Date');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `recurrency_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Recurrency Interval in Months');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `recurrent_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrent Training Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `recurrent_training_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recurrent Training Due Date');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Training Record Remarks');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Training Score');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `simulator_device_code` SET TAGS ('dbx_business_glossary_term' = 'Simulator Device Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `simulator_device_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `simulator_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `simulator_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `training_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Amount');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `training_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `training_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Currency Code');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `training_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `training_result` SET TAGS ('dbx_business_glossary_term' = 'Training Result');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `training_result` SET TAGS ('dbx_value_regex' = 'pass|fail|incomplete|withdrawn|deferred|no_show');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `training_status` SET TAGS ('dbx_business_glossary_term' = 'Training Record Status');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `training_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|expired|pending_approval');
ALTER TABLE `airlines_ecm`.`workforce`.`training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` SET TAGS ('dbx_subdomain' = 'qualification_compliance');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `approved_training_organisation` SET TAGS ('dbx_business_glossary_term' = 'Approved Training Organisation (ATO)');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'written_exam|practical_test|simulator_check|observation|portfolio|none');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `ato_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Approved Training Organisation (ATO) Approval Number');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `certification_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_business_glossary_term' = 'Cost per Participant');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `course_category` SET TAGS ('dbx_business_glossary_term' = 'Course Category');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `course_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `course_description` SET TAGS ('dbx_business_glossary_term' = 'Course Description');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `course_name` SET TAGS ('dbx_business_glossary_term' = 'Course Name');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `course_status` SET TAGS ('dbx_business_glossary_term' = 'Course Status');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `course_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_development|retired|suspended');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `course_version` SET TAGS ('dbx_business_glossary_term' = 'Course Version');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `course_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'classroom|simulator|elearning|on_the_job|blended|practical');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration in Hours');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `language_of_instruction` SET TAGS ('dbx_business_glossary_term' = 'Language of Instruction');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `language_of_instruction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `maximum_participants` SET TAGS ('dbx_business_glossary_term' = 'Maximum Participants');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `minimum_pass_score` SET TAGS ('dbx_business_glossary_term' = 'Minimum Pass Score');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `prerequisite_courses` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Courses');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `recurrence_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Interval in Months');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `regulation_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulation Reference');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `sms_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Management System (SMS) Integration Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `target_audience` SET TAGS ('dbx_value_regex' = 'pilots|cabin_crew|ground_staff|maintenance|management|all_staff');
ALTER TABLE `airlines_ecm`.`workforce`.`training_course` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` SET TAGS ('dbx_subdomain' = 'labor_relations');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `union_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Number');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^CBA-[A-Z0-9]{6,12}$');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'initial|renewal|amendment|extension|successor|interim');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `arbitration_clause` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Clause');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `bargaining_unit` SET TAGS ('dbx_business_glossary_term' = 'Bargaining Unit');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `covered_employee_count` SET TAGS ('dbx_business_glossary_term' = 'Covered Employee Count');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document Uniform Resource Locator (URL)');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `document_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `duration_months` SET TAGS ('dbx_business_glossary_term' = 'Agreement Duration in Months');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `duty_hour_limit_monthly` SET TAGS ('dbx_business_glossary_term' = 'Duty Hour Limit Monthly');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `flight_hour_limit_monthly` SET TAGS ('dbx_business_glossary_term' = 'Flight Hour Limit Monthly');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `furlough_recall_provisions` SET TAGS ('dbx_business_glossary_term' = 'Furlough and Recall Provisions');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `grievance_procedure` SET TAGS ('dbx_business_glossary_term' = 'Grievance Procedure');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `health_benefits_summary` SET TAGS ('dbx_business_glossary_term' = 'Health Benefits Summary');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `health_benefits_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `job_security_provisions` SET TAGS ('dbx_business_glossary_term' = 'Job Security Provisions');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `management_signatory` SET TAGS ('dbx_business_glossary_term' = 'Management Signatory');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `minimum_rest_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Rest Hours');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `negotiating_committee_lead` SET TAGS ('dbx_business_glossary_term' = 'Negotiating Committee Lead');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `negotiation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation End Date');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `negotiation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Start Date');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `pay_scale_structure` SET TAGS ('dbx_business_glossary_term' = 'Pay Scale Structure');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `pay_scale_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `ratification_date` SET TAGS ('dbx_business_glossary_term' = 'Ratification Date');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `retirement_benefits_summary` SET TAGS ('dbx_business_glossary_term' = 'Retirement Benefits Summary');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `retirement_benefits_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `scope_clause` SET TAGS ('dbx_business_glossary_term' = 'Scope Clause');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `seniority_bidding_rules` SET TAGS ('dbx_business_glossary_term' = 'Seniority Bidding Rules');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `union_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `union_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `union_name` SET TAGS ('dbx_business_glossary_term' = 'Union Name');
ALTER TABLE `airlines_ecm`.`workforce`.`union_agreement` ALTER COLUMN `union_signatory` SET TAGS ('dbx_business_glossary_term' = 'Union Signatory');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` SET TAGS ('dbx_subdomain' = 'labor_relations');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_id` SET TAGS ('dbx_business_glossary_term' = 'Grievance Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `arbitration_date` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Hearing Date');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `arbitration_decision` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Decision');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `arbitration_decision` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `arbitration_flag` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `arbitrator_name` SET TAGS ('dbx_business_glossary_term' = 'Arbitrator Name');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `arbitrator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Grievance Case Status');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|resolved|escalated_to_arbitration|withdrawn|closed');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Case Closed Date');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Agreement Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Documentation Reference');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Grievance Filing Date');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `financial_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Settlement Amount');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `financial_settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `financial_settlement_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_description` SET TAGS ('dbx_business_glossary_term' = 'Grievance Description');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_number` SET TAGS ('dbx_business_glossary_term' = 'Grievance Case Number');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_number` SET TAGS ('dbx_value_regex' = '^GRV-[0-9]{8}$');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_type` SET TAGS ('dbx_business_glossary_term' = 'Grievance Type');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_type` SET TAGS ('dbx_value_regex' = 'disciplinary|harassment|unfair_treatment|cba_violation|safety_concern|discrimination');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Occurrence Date');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `legal_counsel_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Involved Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Grievance Priority Level');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `related_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Related Policy Reference');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `requested_remedy` SET TAGS ('dbx_business_glossary_term' = 'Requested Remedy');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `requested_remedy` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Grievance Resolution Date');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'upheld|partially_upheld|denied|settled|arbitration_pending');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `resolution_summary` SET TAGS ('dbx_business_glossary_term' = 'Resolution Summary');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `resolution_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `respondent_department` SET TAGS ('dbx_business_glossary_term' = 'Respondent Department');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `respondent_name` SET TAGS ('dbx_business_glossary_term' = 'Respondent Name');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `respondent_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `union_name` SET TAGS ('dbx_business_glossary_term' = 'Union Name');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `union_representation_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Representation Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `union_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Union Representative Name');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `union_representative_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`grievance` ALTER COLUMN `witness_count` SET TAGS ('dbx_business_glossary_term' = 'Witness Count');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'labor_relations');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `union_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Position Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `attendance_punctuality_rating` SET TAGS ('dbx_business_glossary_term' = 'Attendance and Punctuality Rating');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `attendance_punctuality_rating` SET TAGS ('dbx_value_regex' = 'outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `behavioral_competency_rating` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Competency Rating');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `behavioral_competency_rating` SET TAGS ('dbx_value_regex' = 'outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_adjustment_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Compensation Adjustment Recommendation');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_adjustment_recommendation` SET TAGS ('dbx_value_regex' = 'merit_increase|bonus|no_adjustment|salary_review|promotion_adjustment');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `compensation_adjustment_recommendation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `customer_service_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Rating');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `customer_service_rating` SET TAGS ('dbx_value_regex' = 'outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_applicable');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `development_areas_summary` SET TAGS ('dbx_business_glossary_term' = 'Development Areas Summary');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `development_plan_actions` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Actions');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Date');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgement_flag` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Comments');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `leadership_competency_rating` SET TAGS ('dbx_business_glossary_term' = 'Leadership Competency Rating');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `leadership_competency_rating` SET TAGS ('dbx_value_regex' = 'outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_applicable');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `objective_achievement_score` SET TAGS ('dbx_business_glossary_term' = 'Objective Achievement Score');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating Score');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `performance_improvement_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `promotion_readiness_timeline` SET TAGS ('dbx_business_glossary_term' = 'Promotion Readiness Timeline');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `promotion_readiness_timeline` SET TAGS ('dbx_value_regex' = 'ready_now|ready_6_months|ready_12_months|ready_18_months|not_ready|not_applicable');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `promotion_recommendation_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Recommendation Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Type');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_cycle_type` SET TAGS ('dbx_value_regex' = 'annual|mid_year|probation|line_check|recurrent|special');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `safety_compliance_rating` SET TAGS ('dbx_business_glossary_term' = 'Safety Compliance Rating');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `safety_compliance_rating` SET TAGS ('dbx_value_regex' = 'outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `second_level_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Second Level Approval Date');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `staff_category` SET TAGS ('dbx_business_glossary_term' = 'Staff Category');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `staff_category` SET TAGS ('dbx_value_regex' = 'pilot|cabin_crew|ground_staff|maintenance|corporate|management');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `strengths_summary` SET TAGS ('dbx_business_glossary_term' = 'Strengths Summary');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `technical_competency_rating` SET TAGS ('dbx_business_glossary_term' = 'Technical Competency Rating');
ALTER TABLE `airlines_ecm`.`workforce`.`performance_review` ALTER COLUMN `technical_competency_rating` SET TAGS ('dbx_value_regex' = 'outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Requisition ID');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `job_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Job Classification Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Location Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager ID');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `quaternary_recruitment_replacement_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Employee ID');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `quaternary_recruitment_replacement_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `quaternary_recruitment_replacement_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `union_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `diversity_initiative_flag` SET TAGS ('dbx_business_glossary_term' = 'Diversity Initiative Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'permanent|fixed_term|temporary|seasonal|contract');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `external_posting_flag` SET TAGS ('dbx_business_glossary_term' = 'External Posting Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `job_description_text` SET TAGS ('dbx_business_glossary_term' = 'Job Description Text');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `job_posting_title` SET TAGS ('dbx_business_glossary_term' = 'Job Posting Title');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `minimum_flight_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Flight Hours');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `number_of_vacancies` SET TAGS ('dbx_business_glossary_term' = 'Number of Vacancies');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `posting_end_date` SET TAGS ('dbx_business_glossary_term' = 'Posting End Date');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `posting_start_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Start Date');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `recruitment_channel` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Channel');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `recruitment_channel` SET TAGS ('dbx_value_regex' = 'internal|external|agency|employee_referral|campus|military_transition');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `relocation_assistance_flag` SET TAGS ('dbx_business_glossary_term' = 'Relocation Assistance Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `remote_work_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `required_start_date` SET TAGS ('dbx_business_glossary_term' = 'Required Start Date');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Requisition Approved Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Requisition Closed Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Requisition Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_notes` SET TAGS ('dbx_business_glossary_term' = 'Requisition Notes');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{8}$');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'new_headcount|backfill|replacement|acmi_crew_intake|seasonal|project_based');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `security_clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Required Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `type_rating_required` SET TAGS ('dbx_business_glossary_term' = 'Type Rating Required');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `work_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Type');
ALTER TABLE `airlines_ecm`.`workforce`.`recruitment_requisition` ALTER COLUMN `work_schedule_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|shift_work|roster_based|on_call');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Employee Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `applicant_referral_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Employee Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `applicant_referral_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `applicant_referral_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Job Requisition Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Applicant Address Line 1');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Applicant Address Line 2');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `alternate_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Applicant Alternate Phone Number');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `alternate_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `alternate_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Date');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^APP[0-9]{10}$');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `aviation_licence_type` SET TAGS ('dbx_business_glossary_term' = 'Aviation Licence Type');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `aviation_licence_type` SET TAGS ('dbx_value_regex' = 'ATPL|CPL|PPL|cabin_crew|AME|none');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Applicant City');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Applicant Country Code');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `current_employer` SET TAGS ('dbx_business_glossary_term' = 'Current Employer Name');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `current_job_title` SET TAGS ('dbx_business_glossary_term' = 'Current Job Title');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiry Date');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Applicant Email Address');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `expected_start_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Start Date');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant First Name');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `gdpr_consent_date` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Date');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `interview_date` SET TAGS ('dbx_business_glossary_term' = 'Interview Date');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Last Name');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `licence_issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Licence Issuing Authority');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `licence_number` SET TAGS ('dbx_business_glossary_term' = 'Aviation Licence Number');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `licence_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `licence_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Middle Name');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `offer_accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Accepted Date');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Date');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Applicant Phone Number');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `pic_hours` SET TAGS ('dbx_business_glossary_term' = 'Pilot in Command (PIC) Hours');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `position_applied_for` SET TAGS ('dbx_business_glossary_term' = 'Position Applied For');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Applicant Postal Code');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `screening_score` SET TAGS ('dbx_business_glossary_term' = 'Screening Score');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Application Source Channel');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'careers_portal|gds_job_board|recruitment_agency|internal_transfer|employee_referral|social_media');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Applicant State or Province');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Application Status Reason');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `total_flight_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Flight Hours');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `type_ratings_held` SET TAGS ('dbx_business_glossary_term' = 'Type Ratings Held');
ALTER TABLE `airlines_ecm`.`workforce`.`applicant` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_record_id` SET TAGS ('dbx_business_glossary_term' = 'Absence Record Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Home Base Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `tertiary_absence_replacement_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `tertiary_absence_replacement_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `tertiary_absence_replacement_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `union_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_category` SET TAGS ('dbx_business_glossary_term' = 'Absence Category');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_category` SET TAGS ('dbx_value_regex' = 'planned|unplanned|emergency');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Absence Reason Notes');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_reason_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_type_code` SET TAGS ('dbx_business_glossary_term' = 'Absence Type Code');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `absence_type_description` SET TAGS ('dbx_business_glossary_term' = 'Absence Type Description');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Absence Approval Date');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Absence Approval Status');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled|withdrawn');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `crew_availability_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Crew Availability Impact Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Absence Duration in Days');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Absence Duration in Hours');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Absence End Date');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `fdp_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Flight Duty Period (FDP) Impact Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certificate_received_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Received Date');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certificate_received_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certificate_received_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certificate_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Received Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certificate_received_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certificate_received_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certificate_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Required Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certificate_required_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `medical_certificate_required_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `pay_impact_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Impact Code');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `pay_impact_code` SET TAGS ('dbx_value_regex' = 'paid|unpaid|partial');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `pay_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pay Percentage During Absence');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `return_to_work_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Confirmed Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Absence Start Date');
ALTER TABLE `airlines_ecm`.`workforce`.`absence_record` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Absence Request Submission Date');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `employee_action_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Action Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Organizational Unit Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Position Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `tertiary_hr_approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Approver Employee Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `tertiary_hr_approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `tertiary_hr_approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `action_date` SET TAGS ('dbx_business_glossary_term' = 'Action Date');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `action_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Action Reason Code');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Action Status');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|effective|cancelled|rejected');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'hire|promotion|transfer|demotion|base_change|leave_of_absence');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `new_base_salary` SET TAGS ('dbx_business_glossary_term' = 'New Base Salary');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `new_base_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `new_employment_status` SET TAGS ('dbx_business_glossary_term' = 'New Employment Status');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `new_employment_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|suspended|terminated');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `new_employment_type` SET TAGS ('dbx_business_glossary_term' = 'New Employment Type');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `new_employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temporary|seasonal|intern');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `new_fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'New Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `new_grade_band` SET TAGS ('dbx_business_glossary_term' = 'New Grade Band');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `new_home_base_airport_code` SET TAGS ('dbx_business_glossary_term' = 'New Home Base Airport Code');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `new_home_base_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `new_job_title` SET TAGS ('dbx_business_glossary_term' = 'New Job Title');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `previous_base_salary` SET TAGS ('dbx_business_glossary_term' = 'Previous Base Salary');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `previous_base_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `previous_employment_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Employment Status');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `previous_employment_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|suspended|terminated');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `previous_employment_type` SET TAGS ('dbx_business_glossary_term' = 'Previous Employment Type');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `previous_employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temporary|seasonal|intern');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `previous_fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Previous Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `previous_grade_band` SET TAGS ('dbx_business_glossary_term' = 'Previous Grade Band');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `previous_home_base_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Previous Home Base Airport Code');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `previous_home_base_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `previous_job_title` SET TAGS ('dbx_business_glossary_term' = 'Previous Job Title');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `union_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Union Notification Date');
ALTER TABLE `airlines_ecm`.`workforce`.`employee_action` ALTER COLUMN `union_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Notification Required Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `staff_travel_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Travel Entitlement ID');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `advance_booking_days_maximum` SET TAGS ('dbx_business_glossary_term' = 'Advance Booking Days Maximum');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `advance_booking_days_minimum` SET TAGS ('dbx_business_glossary_term' = 'Advance Booking Days Minimum');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `annual_allocation_sectors` SET TAGS ('dbx_business_glossary_term' = 'Annual Allocation Sectors');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `annual_allocation_trips` SET TAGS ('dbx_business_glossary_term' = 'Annual Allocation Trips');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `blackout_dates_apply_flag` SET TAGS ('dbx_business_glossary_term' = 'Blackout Dates Apply Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `cabin_class_restriction` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class Restriction');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `cabin_class_restriction` SET TAGS ('dbx_value_regex' = 'economy|premium_economy|business|first|any');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `carry_forward_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Carry Forward Allowed Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `carry_forward_limit_sectors` SET TAGS ('dbx_business_glossary_term' = 'Carry Forward Limit Sectors');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `carry_forward_limit_trips` SET TAGS ('dbx_business_glossary_term' = 'Carry Forward Limit Trips');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `eligibility_tier` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Tier');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `entitlement_code` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Code');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `entitlement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `entitlement_type` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Type');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_value_regex' = 'none|domestic_only|regional|international|specific_routes');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `interline_partner_agreements` SET TAGS ('dbx_business_glossary_term' = 'Interline Partner Agreements');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `maximum_nominees_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Nominees Count');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `nominee_dependants_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Nominee Dependants Eligible Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `nominee_parents_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Nominee Parents Eligible Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `nominee_spouse_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Nominee Spouse Eligible Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Notes');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `policy_version` SET TAGS ('dbx_business_glossary_term' = 'Policy Version');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `policy_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `remaining_allocation_sectors` SET TAGS ('dbx_business_glossary_term' = 'Remaining Allocation Sectors');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `remaining_allocation_trips` SET TAGS ('dbx_business_glossary_term' = 'Remaining Allocation Trips');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `service_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Amount');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `service_charge_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Currency Code');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `service_charge_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `staff_travel_entitlement_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Status');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `staff_travel_entitlement_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|revoked|pending_activation|inactive');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `taxes_fees_waived_flag` SET TAGS ('dbx_business_glossary_term' = 'Taxes and Fees Waived Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `union_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Code');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `union_agreement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `used_allocation_sectors` SET TAGS ('dbx_business_glossary_term' = 'Used Allocation Sectors');
ALTER TABLE `airlines_ecm`.`workforce`.`staff_travel_entitlement` ALTER COLUMN `used_allocation_trips` SET TAGS ('dbx_business_glossary_term' = 'Used Allocation Trips');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` SET TAGS ('dbx_subdomain' = 'qualification_compliance');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `medical_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Compliance ID');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `medical_compliance_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `medical_compliance_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `medical_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate ID');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `medical_certificate_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `medical_certificate_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `tertiary_medical_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `tertiary_medical_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `tertiary_medical_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `superseded_medical_compliance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `certificate_class` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Class');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `certificate_class` SET TAGS ('dbx_value_regex' = 'class_1|class_2|class_3|cabin_crew|atc');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `compliance_record_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Record Number');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `crew_scheduling_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Crew Scheduling Eligible Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `fitness_determination_date` SET TAGS ('dbx_business_glossary_term' = 'Fitness Determination Date');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `fitness_for_duty_status` SET TAGS ('dbx_business_glossary_term' = 'Fitness for Duty Status');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `fitness_for_duty_status` SET TAGS ('dbx_value_regex' = 'fit|unfit|fit_with_restrictions|pending_assessment|temporary_grounding|permanent_grounding');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `follow_up_action_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Required');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `follow_up_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Completed Date');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `last_medical_exam_date` SET TAGS ('dbx_business_glossary_term' = 'Last Medical Exam Date');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `last_medical_exam_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `last_medical_exam_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `next_medical_exam_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Medical Exam Due Date');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `next_medical_exam_due_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `next_medical_exam_due_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|sms|postal_mail|in_person|system_alert|manager_notification');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `restrictions_description` SET TAGS ('dbx_business_glossary_term' = 'Restrictions Description');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `restrictions_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `scheduling_restriction_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Restriction End Date');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `scheduling_restriction_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Restriction Start Date');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `union_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Union Notification Date');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `union_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Notification Required Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `waiver_conditions` SET TAGS ('dbx_business_glossary_term' = 'Waiver Conditions');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `waiver_conditions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `waiver_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Expiry Date');
ALTER TABLE `airlines_ecm`.`workforce`.`medical_compliance` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` SET TAGS ('dbx_subdomain' = 'qualification_compliance');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `licence_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Licence Compliance ID');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `licence_id` SET TAGS ('dbx_business_glossary_term' = 'Licence ID');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `quaternary_licence_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `quaternary_licence_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `quaternary_licence_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `tertiary_licence_responsible_hr_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible HR (Human Resources) Manager ID');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `tertiary_licence_responsible_hr_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `tertiary_licence_responsible_hr_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `superseded_licence_compliance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `action_date` SET TAGS ('dbx_business_glossary_term' = 'Action Date');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `compliance_action_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Action Type');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `compliance_action_type` SET TAGS ('dbx_value_regex' = 'initial_verification|periodic_review|renewal_tracking|suspension_notice|reinstatement|audit_response');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `compliance_record_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Record Number');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `compliance_record_number` SET TAGS ('dbx_value_regex' = '^LCR-[0-9]{8}$');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_verification|expired|suspended|under_review');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `crew_scheduling_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Crew Scheduling Eligible Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `document_reference_url` SET TAGS ('dbx_business_glossary_term' = 'Document Reference URL');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `grounding_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Grounding Effective Date');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `grounding_flag` SET TAGS ('dbx_business_glossary_term' = 'Grounding Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `next_verification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Verification Due Date');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `non_compliance_reason` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Reason');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `regulatory_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Code');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `regulatory_authority_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `regulatory_report_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Reference Number');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `remediation_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Deadline Date');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `renewal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Deadline Date');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `renewal_reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Reminder Sent Date');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `renewal_tracking_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Tracking Status');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `renewal_tracking_status` SET TAGS ('dbx_value_regex' = 'not_due|reminder_sent|renewal_in_progress|renewal_completed|overdue');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'manual_inspection|regulatory_authority_api|third_party_service|document_upload|in_person');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `airlines_ecm`.`workforce`.`licence_compliance` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not_required|expired');
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` SET TAGS ('dbx_association_edges' = 'workforce.employee,workforce.benefit_plan');
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` ALTER COLUMN `enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Benefit Plan Id');
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Employee Id');
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` ALTER COLUMN `dependents_enrolled_count` SET TAGS ('dbx_business_glossary_term' = 'Dependents Enrolled Count');
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` ALTER COLUMN `life_event_date` SET TAGS ('dbx_business_glossary_term' = 'Life Event Date');
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` ALTER COLUMN `life_event_type` SET TAGS ('dbx_business_glossary_term' = 'Life Event Type');
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` ALTER COLUMN `waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Flag');
ALTER TABLE `airlines_ecm`.`workforce`.`enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `airlines_ecm`.`workforce`.`position_budget` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`workforce`.`position_budget` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `airlines_ecm`.`workforce`.`position_budget` SET TAGS ('dbx_association_edges' = 'finance.budget_plan,workforce.position');
ALTER TABLE `airlines_ecm`.`workforce`.`position_budget` ALTER COLUMN `position_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Position Budget Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`position_budget` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Position Budget - Budget Plan Id');
ALTER TABLE `airlines_ecm`.`workforce`.`position_budget` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Budget - Workforce Position Id');
ALTER TABLE `airlines_ecm`.`workforce`.`position_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `airlines_ecm`.`workforce`.`position_budget` ALTER COLUMN `budget_notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `airlines_ecm`.`workforce`.`position_budget` ALTER COLUMN `budgeted_fte` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Full-Time Equivalent');
ALTER TABLE `airlines_ecm`.`workforce`.`position_budget` ALTER COLUMN `budgeted_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Salary Amount');
ALTER TABLE `airlines_ecm`.`workforce`.`position_budget` ALTER COLUMN `budgeted_salary_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`position_budget` ALTER COLUMN `budgeted_salary_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`position_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`position_budget` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `airlines_ecm`.`workforce`.`position_budget` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `airlines_ecm`.`workforce`.`position_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `airlines_ecm`.`workforce`.`position_budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`position_budget` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `airlines_ecm`.`workforce`.`position_budget` ALTER COLUMN `variance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` SET TAGS ('dbx_association_edges' = 'workforce.employee,procurement.procurement_category');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `category_responsibility_id` SET TAGS ('dbx_business_glossary_term' = 'Category Responsibility Assignment Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `assigned_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigning Manager Employee Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `assigned_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `assigned_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `category_procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Responsibility - Procurement Category Id');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Identifier');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Authorization Level');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `backup_flag` SET TAGS ('dbx_business_glossary_term' = 'Backup Assignment Indicator');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `category_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Category Manager Email');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `category_manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `category_manager_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `category_owner` SET TAGS ('dbx_business_glossary_term' = 'Category Owner');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Effective Date');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Expiry Date');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Category Responsibility Role Type');
ALTER TABLE `airlines_ecm`.`workforce`.`category_responsibility` ALTER COLUMN `workload_percentage` SET TAGS ('dbx_business_glossary_term' = 'Category Workload Allocation Percentage');
