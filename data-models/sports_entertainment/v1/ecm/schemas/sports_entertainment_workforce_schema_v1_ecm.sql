-- Schema for Domain: workforce | Business: Sports Entertainment | Version: v1_ecm
-- Generated on: 2026-05-09 01:42:59

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `sports_entertainment_ecm`.`workforce` COMMENT 'Human capital management domain owning employee records, recruitment, payroll, benefits, talent development, and organizational structure via SAP SuccessFactors. Covers full-time staff, part-time event crew, broadcast crews, league officials, and seasonal workers. Manages OSHA safety compliance and CBA labor agreement obligations. SSOT for all workforce identity and HR data.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique surrogate identifier for each workforce member record in the Sports Entertainment enterprise. Primary key for the employee master record sourced from SAP SuccessFactors HCM.',
    `corporate_entity_id` BIGINT COMMENT 'Foreign key linking to legal.corporate_entity. Business justification: In multi-entity sports organizations (league holdco, team entities, broadcast subsidiaries), each employee is employed by a specific legal entity for tax withholding, statutory reporting (W-2, IR35), ',
    `manager_employee_id` BIGINT COMMENT 'The employee_id of the direct line manager for this employee, enabling organizational hierarchy traversal. Used for approval workflows, performance management chains, and org chart generation. Self-referencing FK within the employee product.',
    `ada_accommodation_flag` BOOLEAN COMMENT 'Indicates whether the employee has an active ADA (Americans with Disabilities Act) workplace accommodation in place. Drives facility assignment, equipment provisioning, and event deployment planning. Classified as confidential to protect employee privacy.',
    `background_check_date` DATE COMMENT 'The date on which the most recent background check was completed for this employee. Used to determine background check currency for venue access, broadcast facility credentialing, and league compliance requirements.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'The employees annual base salary or hourly rate as applicable, in the local currency of the work location. Stored as a raw compensation figure for payroll processing, budget planning, and CBA compliance verification. Classified as confidential business data.',
    `business_unit` STRING COMMENT 'The top-level business unit within Sports Entertainment to which the employee belongs (e.g., League Operations, Broadcast Network, Venue Management, Fan Engagement, Merchandise). Used for high-level workforce segmentation and executive reporting.',
    `cba_agreement_code` STRING COMMENT 'The reference code identifying the specific Collective Bargaining Agreement (CBA) governing this employees terms of employment. Applicable to unionized staff including broadcast crews, venue operations workers, and league officials. Null for non-union employees.',
    `cost_center_code` STRING COMMENT 'The SAP cost center code to which the employees labor costs are allocated. Links workforce costs to the financial controlling structure in SAP S/4HANA CO (Controlling). Critical for EBITDA reporting, budget variance analysis, and event cost attribution.',
    `credential_expiry_date` DATE COMMENT 'The date on which the employees primary professional credential, certification, or work authorization expires (e.g., broadcast technician certification, venue safety certification, work visa). Triggers renewal workflows and may restrict event deployment if expired.',
    `data_source_system` STRING COMMENT 'Identifies the originating system of record for this employee record. Primarily successfactors for SAP SuccessFactors HCM-sourced records. Supports data lineage, reconciliation, and audit traceability across the Databricks Silver Layer.. Valid values are `successfactors|manual_entry|migration`',
    `date_of_birth` DATE COMMENT 'The employees date of birth in ISO 8601 format (yyyy-MM-dd). Used for age verification, benefits eligibility determination, and compliance with minor labor laws. Required for CBA (Collective Bargaining Agreement) age-related provisions.',
    `department_code` STRING COMMENT 'The organizational department code to which the employee is assigned, as defined in the SAP SuccessFactors organizational structure. Used for workforce segmentation, reporting hierarchies, and budget allocation across business units such as Broadcast, Venue Operations, Ticketing, and Fan Engagement.',
    `employment_status` STRING COMMENT 'Current lifecycle state of the employees employment relationship with Sports Entertainment. Drives access provisioning, payroll activation, and workforce reporting. pending_start indicates a hired employee who has not yet commenced work.. Valid values are `active|on_leave|terminated|suspended|pending_start`',
    `employment_type` STRING COMMENT 'Categorizes the nature of the employment relationship. Distinguishes full-time staff, part-time event crew, seasonal workers, independent contractors, league officials, and broadcast crews — all of which are managed within the Sports Entertainment workforce. Drives benefits eligibility, payroll processing rules, and FLSA classification logic.. Valid values are `full_time|part_time|seasonal|contractor|league_official|broadcast_crew`',
    `ethnicity_code` STRING COMMENT 'Standardized code representing the employees self-identified ethnicity, as voluntarily provided. Used exclusively for EEOC regulatory reporting and DEI workforce analytics. Classified as restricted sensitive personal data under GDPR Article 9. [ENUM-REF-CANDIDATE: promote to reference product per EEOC categories]',
    `flsa_classification` STRING COMMENT 'The employees classification under the U.S. Fair Labor Standards Act (FLSA), determining overtime eligibility and minimum wage applicability. exempt employees are not entitled to overtime; non_exempt employees are. Critical for payroll compliance and labor law audits.. Valid values are `exempt|non_exempt|independent_contractor`',
    `gender_identity` STRING COMMENT 'The employees self-identified gender, as voluntarily provided and stored in SAP SuccessFactors. Used for DEI (Diversity, Equity, and Inclusion) workforce analytics and regulatory EEO reporting. Classified as restricted sensitive personal data under GDPR Article 9. [ENUM-REF-CANDIDATE: male|female|non_binary|prefer_not_to_say|other — promote to reference product]',
    `hire_date` DATE COMMENT 'The official date on which the employee commenced employment with Sports Entertainment, as recorded in SAP SuccessFactors. Used for tenure calculations, benefits vesting schedules, and CBA seniority determinations.',
    `identity_verification_status` STRING COMMENT 'The current status of the employees identity verification process, including background checks and document validation. Required for credentialing, venue access control, and compliance with league security protocols. verified is required before event deployment.. Valid values are `verified|pending|failed|not_required`',
    `is_union_member` BOOLEAN COMMENT 'Indicates whether the employee is a member of a labor union. Drives CBA (Collective Bargaining Agreement) applicability, union dues deduction processing, and labor relations reporting. Critical for compliance with league-specific CBA obligations (e.g., NFL, NBA, MLB, NHL CBAs).',
    `job_code` STRING COMMENT 'The standardized job classification code from the Sports Entertainment job catalog, as maintained in SAP SuccessFactors. Maps to a specific job family, grade, and FLSA classification. Examples include codes for event operations staff, broadcast technicians, league officials, and venue management roles.',
    `job_title` STRING COMMENT 'The human-readable job title associated with the employees current position within Sports Entertainment (e.g., Broadcast Technician, Event Operations Manager, League Official, Venue Safety Officer). Used in org charts, event rosters, and credential displays.',
    `legal_first_name` STRING COMMENT 'The employees legal given name as recorded on government-issued identification. Used for payroll, tax filings, and compliance reporting. Must match identity verification documents.',
    `legal_last_name` STRING COMMENT 'The employees legal family/surname as recorded on government-issued identification. Used for payroll, tax filings, and compliance reporting.',
    `national_id_hash` STRING COMMENT 'Cryptographic hash (SHA-256) of the employees government-issued national identification number (e.g., SSN, SIN, NIN). Stored as a hash to support identity deduplication and background check verification without retaining the raw value. Raw value is stored in the HR vault system.',
    `nationality_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the employees nationality. Required for international event deployment, visa processing, and compliance with league international player/staff regulations (e.g., FIFA, IOC international staff rules).. Valid values are `^[A-Z]{3}$`',
    `osha_safety_trained` BOOLEAN COMMENT 'Indicates whether the employee has completed the required OSHA (Occupational Safety and Health Administration) safety training for their role. Mandatory for venue operations staff, event crew, and broadcast crews working in physical environments. Blocks event deployment if false.',
    `osha_training_date` DATE COMMENT 'The date on which the employee most recently completed OSHA-required safety training. Used to determine training currency and trigger renewal notifications per OSHA compliance schedules.',
    `pay_frequency` STRING COMMENT 'The frequency at which the employee is paid (e.g., weekly for event crew, bi-weekly for full-time staff). Drives payroll processing schedules in SAP SuccessFactors Payroll and determines pay period boundaries for labor cost accruals.. Valid values are `weekly|bi_weekly|semi_monthly|monthly`',
    `pay_grade` STRING COMMENT 'The compensation grade band assigned to the employees position within the Sports Entertainment pay structure, as defined in SAP SuccessFactors Compensation. Determines salary range eligibility, bonus targets, and benefits tier. Classified as confidential business data.',
    `pay_type` STRING COMMENT 'Indicates whether the employee is compensated on a salaried, hourly, per diem, or stipend basis. Determines payroll calculation method and overtime eligibility rules. Seasonal event crew and broadcast crews are typically hourly or per diem.. Valid values are `salary|hourly|per_diem|stipend`',
    `preferred_name` STRING COMMENT 'The name the employee prefers to be addressed by in day-to-day operations, communications, and internal directories. May differ from legal name. Used in scheduling, broadcast crew lists, and event rosters.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when the employee record was first created in the Sports Entertainment data platform (Silver Layer). Represents the data ingestion audit trail timestamp in ISO 8601 format with timezone offset (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent update to the employee record in the Sports Entertainment data platform. Used for change data capture (CDC), data lineage tracking, and audit compliance under SOX and GDPR.',
    `salary_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the employees base salary amount (e.g., USD, GBP, EUR). Required for multi-currency payroll processing across Sports Entertainments global operations.. Valid values are `^[A-Z]{3}$`',
    `successfactors_person_code` STRING COMMENT 'The natural/business key assigned by SAP SuccessFactors Employee Central to uniquely identify the person across all employment instances. Used for system-of-record cross-referencing and HR integrations.',
    `termination_date` DATE COMMENT 'The date on which the employees employment relationship with Sports Entertainment ended. Null for active employees. Used for offboarding workflows, final pay calculations, benefits cessation, and workforce analytics.',
    `termination_reason` STRING COMMENT 'Standardized reason code for the end of the employment relationship. Used for attrition analytics, CBA compliance reporting, and workforce planning. Null for active employees.. Valid values are `voluntary_resignation|involuntary_termination|end_of_contract|retirement|redundancy|death`',
    `work_authorization_type` STRING COMMENT 'The type of work authorization held by the employee, relevant for international staff across Sports Entertainments global operations. Drives I-9/equivalent compliance, visa tracking, and international event deployment eligibility.. Valid values are `citizen|permanent_resident|work_visa|seasonal_visa|not_applicable`',
    `work_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the employees primary work location country. Drives applicable labor law, tax jurisdiction, GDPR/CCPA privacy obligations, and CBA applicability for global Sports Entertainment operations.. Valid values are `^[A-Z]{3}$`',
    `work_email` STRING COMMENT 'The official corporate email address assigned to the employee for business communications, system access, and identity federation. Primary digital contact channel for internal HR and operational notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `work_location_code` STRING COMMENT 'The code identifying the primary physical work location assigned to the employee (e.g., a specific venue, broadcast facility, league office, or remote designation). Used for OSHA safety compliance, ADA accommodation tracking, and event crew deployment planning.',
    `work_phone` STRING COMMENT 'The employees primary work telephone number in E.164 international format. Used for operational contact, emergency notifications, and broadcast/event crew coordination.. Valid values are `^+?[1-9]d{1,14}$`',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'SSOT master record for all workforce members across Sports Entertainment — full-time staff, part-time event crew, broadcast crews, league officials, and seasonal workers. Sourced from SAP SuccessFactors HCM. Captures legal name, employment type, hire date, termination date, job classification, cost center assignment, work location, employment status, FLSA classification, union membership flag, CBA agreement reference, and identity verification status. This is the authoritative workforce identity record referenced by all HR sub-domains.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique surrogate identifier for an approved organizational position slot within the Sports Entertainment workforce structure. Primary key for the position master record in SAP SuccessFactors Position Management.',
    `facility_id` BIGINT COMMENT 'Identifier of the primary work location (venue, office, broadcast facility) associated with this position. Used for venue-based workforce planning, OSHA site compliance, and ADA accessibility reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee currently assigned to fill this position. Null if the position is vacant. Enables position-to-person mapping for org chart, payroll, and workforce reporting.',
    `location_facility_id` BIGINT COMMENT 'Identifier of the primary work location (venue, office, broadcast facility) associated with this position. Used for venue-based workforce planning, OSHA site compliance, and ADA accessibility reporting.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational unit (division, business unit, or team) to which this position is assigned in the SAP SuccessFactors org structure. Supports hierarchical workforce reporting and headcount governance.',
    `reports_to_position_id` BIGINT COMMENT 'Self-referencing identifier of the parent position in the organizational hierarchy to which this position directly reports. Enables org chart construction, span-of-control analysis, and reporting line governance.',
    `approved_date` DATE COMMENT 'The date on which the position was formally approved in the headcount plan by the authorized budget owner. Used for SOX financial controls audit trails and workforce governance.',
    `budget_approval_status` STRING COMMENT 'Indicates the current budget authorization state of the position. approved means the position has been funded in the annual headcount plan; pending means awaiting finance sign-off; rejected means not funded; on_hold means temporarily suspended pending budget review.. Valid values are `approved|pending|rejected|on_hold`',
    `cba_agreement_code` STRING COMMENT 'Code identifying the specific Collective Bargaining Agreement (CBA) that governs this position, if applicable (e.g., IATSE, Teamsters, NFLPA). Null for non-union positions. Used for labor compliance, grievance management, and payroll rule application.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this position record was first created in the system of record (SAP SuccessFactors). Used for audit trail, data lineage, and compliance reporting.',
    `department_code` STRING COMMENT 'Code identifying the organizational department to which this position belongs, as defined in the SAP SuccessFactors organizational structure. Links the position to cost center and budget ownership for financial reporting.. Valid values are `^DEPT-[A-Z0-9]{2,10}$`',
    `department_name` STRING COMMENT 'Human-readable name of the organizational department to which this position belongs (e.g., Broadcast Operations, Venue Facilities, Athlete Services). Denormalized for reporting convenience.',
    `eeo1_category` STRING COMMENT 'EEO-1 job category assigned to the position per EEOC reporting requirements. Used to classify positions for annual EEO-1 Component 1 workforce demographic reporting submitted to the U.S. Equal Employment Opportunity Commission. [ENUM-REF-CANDIDATE: Executive/Senior Officials|First/Mid Officials|Professionals|Technicians|Sales Workers|Administrative Support|Craft Workers|Operatives|Laborers|Service Workers — promote to reference product]',
    `effective_end_date` DATE COMMENT 'The date on which this position is scheduled to end or was eliminated from the organizational structure. Null for permanent positions with no planned end. Used for seasonal workforce planning and position lifecycle governance.',
    `effective_start_date` DATE COMMENT 'The date on which this position became or becomes effective in the organizational structure. Used for workforce planning timelines, headcount reporting, and position lifecycle management.',
    `filled_date` DATE COMMENT 'The date on which an incumbent was assigned to fill this position. Used to calculate time-to-fill KPIs, vacancy duration analysis, and recruitment performance reporting.',
    `flsa_status` STRING COMMENT 'Indicates whether the position is classified as exempt or non-exempt under the U.S. Fair Labor Standards Act. Non-exempt positions are eligible for overtime pay. Critical for payroll compliance, CBA obligations, and OSHA labor reporting.. Valid values are `exempt|non_exempt`',
    `fte_allocation` DECIMAL(18,2) COMMENT 'The Full-Time Equivalent (FTE) value assigned to this position, representing the proportion of a full-time workload (e.g., 1.0 = full-time, 0.5 = half-time). Used for headcount governance, budget planning, and workforce capacity analysis.',
    `headcount_plan_year` STRING COMMENT 'The fiscal year in which this position was approved in the headcount plan (e.g., 2025). Used to align position records with annual workforce planning cycles and budget periods.',
    `is_key_position` BOOLEAN COMMENT 'Indicates whether this position is designated as a key or critical role for succession planning purposes. True = key position requiring a succession plan; False = standard position. Used in SAP SuccessFactors Succession & Development.',
    `is_safety_sensitive` BOOLEAN COMMENT 'Indicates whether the position is classified as safety-sensitive under OSHA regulations, requiring additional pre-employment screening, drug testing, and ongoing safety compliance monitoring (e.g., field crew, electrical technicians, event security).',
    `is_union_eligible` BOOLEAN COMMENT 'Indicates whether the position is eligible for union membership under applicable labor agreements. True = union-eligible; False = non-union. Critical for CBA compliance, labor relations management, and payroll processing.',
    `job_code` STRING COMMENT 'Standardized job classification code from the SAP SuccessFactors Job Catalog that maps the position to a defined job role, enabling compensation benchmarking, EEO-1 reporting, and workforce analytics.. Valid values are `^JC-[A-Z0-9]{3,10}$`',
    `job_family` STRING COMMENT 'Broad functional grouping of the position within Sports Entertainments organizational taxonomy. Segments the workforce by operational domain for headcount planning, compensation banding, and workforce analytics. [ENUM-REF-CANDIDATE: Event Operations|Broadcast Production|Athlete Services|Venue Management|Corporate Functions|League Administration|Content Production|Sponsorship and Partnerships|Merchandise and Licensing|Digital Platform — promote to reference product]',
    `job_level` STRING COMMENT 'Career level designation indicating the seniority and scope of the position within the organizational hierarchy. Used for compensation banding, succession planning, and workforce segmentation. [ENUM-REF-CANDIDATE: Individual Contributor|Senior Individual Contributor|Manager|Senior Manager|Director|Senior Director|Vice President|Senior Vice President|Executive — promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this position record was most recently updated in the system of record. Used for change data capture, audit trails, and incremental data pipeline processing.',
    `league_entity_code` STRING COMMENT 'Code identifying the specific league, sports property, or business entity (e.g., NFL franchise, NBA team, MLS club, broadcast network) to which this position is assigned. Enables workforce segmentation across multi-league and multi-entity operations.',
    `max_incumbents` STRING COMMENT 'The maximum number of employees that can be assigned to this position simultaneously (typically 1 for standard positions; may be greater for shared or pooled positions such as event-day crew pools). Used for headcount governance.',
    `pay_grade` STRING COMMENT 'Compensation band or pay grade code assigned to the position, defining the salary range within which the role is compensated. Sourced from SAP SuccessFactors Compensation module. Confidential as it reveals internal compensation structure.. Valid values are `^PG-[A-Z0-9]{1,5}$`',
    `pay_range_max` DECIMAL(18,2) COMMENT 'Maximum annual base salary (in USD) defined for this positions pay grade band. Used for compensation benchmarking, offer management, and budget planning. Confidential as it reveals internal compensation structure.',
    `pay_range_min` DECIMAL(18,2) COMMENT 'Minimum annual base salary (in USD) defined for this positions pay grade band. Used for compensation benchmarking, offer management, and budget planning. Confidential as it reveals internal compensation structure.',
    `position_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the position in SAP SuccessFactors Job Catalog and used in cross-system references (e.g., payroll, budgeting). Follows the format POS-XXXXXXXX.. Valid values are `^POS-[A-Z0-9]{4,12}$`',
    `position_status` STRING COMMENT 'Current lifecycle state of the position slot. active indicates the position is approved and operational; frozen indicates a budget hold; eliminated indicates the position has been removed from the org structure; pending_approval indicates awaiting budget authorization; filled indicates an incumbent is assigned; vacant indicates the position is open for recruitment.. Valid values are `active|frozen|eliminated|pending_approval|filled|vacant`',
    `position_type` STRING COMMENT 'Classification of the position by employment duration and engagement model. permanent denotes year-round full-time roles; seasonal denotes roles tied to a sports season or event cycle; event_day denotes roles activated only on event days (e.g., ushers, security); contract denotes fixed-term engagements; part_time denotes recurring part-time roles.. Valid values are `permanent|seasonal|event_day|contract|part_time`',
    `remote_work_eligibility` STRING COMMENT 'Indicates the remote work classification for this position. on_site requires physical presence (e.g., venue operations, event-day staff); hybrid allows partial remote; remote is fully remote-eligible; not_eligible applies to positions with mandatory on-site requirements.. Valid values are `on_site|hybrid|remote|not_eligible`',
    `requires_background_check` BOOLEAN COMMENT 'Indicates whether incumbents in this position are required to pass a background check as a condition of employment. Driven by venue security requirements, league governance mandates, and regulatory compliance.',
    `requires_credential` BOOLEAN COMMENT 'Indicates whether the position requires a specific professional credential, license, or certification (e.g., EMT certification for medical staff, broadcast engineering license, security guard license). Drives compliance tracking in SAP SuccessFactors.',
    `source_system_code` STRING COMMENT 'The native record identifier from the source system of record (SAP SuccessFactors Position Management) used for data lineage, reconciliation, and cross-system traceability in the Databricks Silver Layer.. Valid values are `^SF-[A-Z0-9]{4,20}$`',
    `succession_readiness` STRING COMMENT 'Indicates the succession readiness state for this key position, reflecting whether a qualified successor is identified and ready. Used in talent review and succession planning processes.. Valid values are `ready_now|ready_1_2_years|ready_3_5_years|no_successor`',
    `title` STRING COMMENT 'Official human-readable title of the position as defined in the job catalog (e.g., Broadcast Production Coordinator, Head Groundskeeper, Event Day Security Supervisor). Used in org charts, offer letters, and workforce reporting.',
    `vacancy_reason` STRING COMMENT 'Reason code explaining why the position is currently vacant. Used for workforce analytics, attrition reporting, and recruitment prioritization. [ENUM-REF-CANDIDATE: new_position|resignation|termination|retirement|transfer|leave_of_absence|promotion — 7 candidates stripped; promote to reference product]',
    `work_schedule_code` STRING COMMENT 'Code identifying the standard work schedule pattern assigned to this position (e.g., standard 40-hour week, event-day shift, rotating broadcast schedule). Sourced from SAP SuccessFactors Time Management.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Organizational position master defining approved headcount slots and job classification within the Sports Entertainment org structure. Captures position title, job code, job family (Event Operations, Broadcast Production, Athlete Services, Venue Management), job level, FLSA status (exempt/non-exempt), EEO-1 category, pay grade band, department, reporting line, FTE allocation, position type (permanent, seasonal, event-day), budget approval status, open/filled status, union eligibility flag, and CBA applicability. Sourced from SAP SuccessFactors Position Management and Job Catalog. Enables workforce planning, headcount governance, compensation banding, compliance reporting, and workforce segmentation across leagues, venues, broadcast, and corporate functions.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique surrogate identifier for the organizational unit record within the Sports Entertainment enterprise. Primary key for the org_unit master data product.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Org units belong to legal entities for financial consolidation and statutory reporting. Multi-entity sports groups need this link for entity-level headcount reporting, labor cost consolidation, and co',
    `corporate_entity_id` BIGINT COMMENT 'Foreign key linking to legal.corporate_entity. Business justification: Org units in multi-entity sports organizations belong to a specific legal entity for entity-level financial consolidation, labor law applicability, and regulatory reporting. company_code is a denormal',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Org units map to cost centers for financial reporting and headcount budget allocation. Sports organizations align organizational structure to financial cost centers for labor cost reporting, budget va',
    `franchise_id` BIGINT COMMENT 'Foreign key linking to league.franchise. Business justification: Org units in sports-entertainment are franchise-specific (e.g., Cowboys Football Operations, Lakers Basketball Ops). Franchise-level org structure, headcount planning, and cost center allocation r',
    `parent_unit_org_unit_id` BIGINT COMMENT 'Self-referencing identifier pointing to the immediate parent organizational unit in the hierarchy. Enables recursive traversal of the org tree for span-of-control analysis, rollup reporting, and budget consolidation. Null for the root-level enterprise unit.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the designated manager or head of this organizational unit as recorded in SAP SuccessFactors. Used for approval workflows, span-of-control reporting, and organizational accountability mapping.',
    `quaternary_org_hr_business_partner_employee_id` BIGINT COMMENT 'Employee identifier of the HR Business Partner (HRBP) assigned to support this organizational unit. Used for HR service delivery routing, talent management accountability, and CBA labor relations management.',
    `tertiary_org_employee_id` BIGINT COMMENT 'Employee identifier of the HR Business Partner (HRBP) assigned to support this organizational unit. Used for HR service delivery routing, talent management accountability, and CBA labor relations management.',
    `venue_id` BIGINT COMMENT 'Reference to the primary venue associated with this organizational unit, applicable when the unit type is venue or when the unit is operationally tied to a specific facility (e.g., a venue operations department). Null for non-venue org units.',
    `ada_compliance_scope` BOOLEAN COMMENT 'Indicates whether this organizational unit has ADA compliance obligations, particularly relevant for venue operations, fan-facing event units, and public-access facilities. Drives accessibility audit scheduling and accommodation workflow routing.',
    `business_unit_code` STRING COMMENT 'Code identifying the broader business unit or profit center grouping to which this org unit belongs (e.g., SPORTS, ENTERTAINMENT, BROADCAST, VENUES). Supports EBITDA reporting by business segment and strategic portfolio analysis.. Valid values are `^[A-Z0-9_-]{2,15}$`',
    `cba_agreement_code` STRING COMMENT 'Code identifying the specific Collective Bargaining Agreement (CBA) applicable to this organizational unit (e.g., NFL-CBA-2020, NBA-CBA-2023). Null when cba_applicable is False. Used for labor compliance reporting and contract administration.',
    `cba_applicable` BOOLEAN COMMENT 'Indicates whether employees in this organizational unit are covered by a Collective Bargaining Agreement (CBA). Drives labor relations workflows, grievance management routing, and compliance with union contract obligations across NFL, NBA, MLB, NHL, and MLS player associations.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the country in which this organizational unit primarily operates. Used for international payroll, tax jurisdiction determination, and regulatory compliance scoping.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was first created in the enterprise data platform (Silver Layer). Follows ISO 8601 extended format with timezone offset. Used for data lineage, audit trail, and record provenance tracking.',
    `effective_end_date` DATE COMMENT 'Date on which this organizational unit record ceases to be valid. Null indicates the record is currently active with no planned end. Used for org restructuring, merger/acquisition integration, and historical workforce reporting.',
    `effective_start_date` DATE COMMENT 'Date from which this organizational unit record is valid and active in the enterprise hierarchy. Supports bi-temporal modeling for historical org chart reconstruction, retroactive payroll processing, and workforce planning as-of-date queries. Sourced from SAP SuccessFactors effective dating.',
    `fte_count_actual` DECIMAL(18,2) COMMENT 'Current actual full-time equivalent (FTE) count of employees assigned to this organizational unit, including part-time workers converted to FTE fractions. Sourced from SAP SuccessFactors headcount reporting. Used for span-of-control analysis and budget variance tracking.',
    `functional_area` STRING COMMENT 'Broad functional classification of the org units primary business activity. Used for cross-domain workforce analytics, headcount planning, and functional cost allocation. [ENUM-REF-CANDIDATE: operations|finance|hr|legal|technology|marketing|broadcast|venue|athlete_management|content|sponsorship|merchandise|compliance|fan_engagement — promote to reference product]',
    `gdpr_data_controller` BOOLEAN COMMENT 'Indicates whether this organizational unit acts as a GDPR data controller for personal data processed within its scope. Relevant for EU-based operations, fan data management, and broadcast rights distribution in European markets. Drives data protection impact assessment (DPIA) obligations.',
    `geographic_region` STRING COMMENT 'ISO 3166-1 alpha-3 country code or ISO 3166-2 region code representing the primary geographic jurisdiction of this org unit. Drives GDPR/CCPA data privacy obligations, OSHA safety compliance scope, and regional labor law applicability (e.g., CBA jurisdiction).. Valid values are `^[A-Z]{2,3}$`',
    `gl_account_code` STRING COMMENT 'SAP S/4HANA General Ledger (GL) account code associated with the primary expense account for this organizational unit. Enables direct mapping between org unit labor costs and the financial chart of accounts for P&L reporting and SOX-compliant financial controls.. Valid values are `^[0-9]{6,10}$`',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this organizational unit within the enterprise hierarchy tree, where 1 represents the root enterprise entity. Used for span-of-control analysis, reporting roll-ups, and org chart rendering. Derived from parent chain but stored for query performance.',
    `hierarchy_path` STRING COMMENT 'Materialized slash-delimited path of org unit codes from root to this node (e.g., SE/SPORTS/NFL/OPS/SCOUTING). Enables efficient subtree queries and breadcrumb navigation in org chart tools without recursive joins.',
    `iso_20121_certified` BOOLEAN COMMENT 'Indicates whether this organizational unit holds or is pursuing ISO 20121 Event Sustainability Management System certification. Relevant for event planning, venue operations, and league governance units committed to sustainable event delivery.',
    `last_reviewed_date` DATE COMMENT 'Date on which this organizational unit record was last formally reviewed and validated by HR or Finance governance. Supports data quality management, annual org design review cycles, and SOX control evidence requirements.',
    `league_code` STRING COMMENT 'Industry-specific code identifying the professional league or governing body associated with this org unit where applicable (e.g., NFL, NBA, MLB, NHL, MLS, FIFA). Null for non-league org units such as corporate functions or venue operations.',
    `org_unit_status` STRING COMMENT 'Current lifecycle status of the organizational unit. active indicates the unit is operational and staffed; inactive indicates it has been decommissioned or merged; pending indicates it is approved but not yet operational; archived indicates historical record retained for audit purposes.. Valid values are `active|inactive|pending|archived`',
    `osha_establishment_number` STRING COMMENT 'OSHA establishment identifier assigned to this organizational unit for safety compliance reporting purposes. Required for OSHA 300 injury and illness log maintenance, particularly for venue operations, event crew, and broadcast production units. Null for non-physical or administrative org units.',
    `payroll_area_code` STRING COMMENT 'SAP SuccessFactors / SAP HCM payroll area code assigned to this organizational unit, determining the payroll processing schedule, pay frequency, and payroll run grouping. Critical for multi-country payroll operations across global sports entertainment markets.. Valid values are `^[A-Z0-9]{2,6}$`',
    `source_system` STRING COMMENT 'Identifier of the operational system of record from which this organizational unit record was sourced. Supports data lineage, master data management conflict resolution, and Silver Layer provenance tracking.. Valid values are `successfactors|sap_s4hana|workday|manual`',
    `successfactors_object_code` STRING COMMENT 'Native object identifier from SAP SuccessFactors Org Chart for this organizational unit (Foundation Object external code). Used for bi-directional synchronization between the Silver Layer data product and the system of record, and for audit trail reconciliation.. Valid values are `^[A-Za-z0-9_-]{1,32}$`',
    `succession_plan_status` STRING COMMENT 'Current status of the succession planning process for the leadership position of this organizational unit. Tracked in SAP SuccessFactors Succession & Development module. Critical for talent risk management across key sports operations and broadcast leadership roles.. Valid values are `not_started|in_progress|complete|under_review`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the org units primary operating location (e.g., America/New_York, America/Los_Angeles, Europe/London). Used for scheduling event crew, broadcast shifts, and venue operations staff across global markets.',
    `unit_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the organizational unit across enterprise systems (SAP SuccessFactors, SAP S/4HANA, Workday Adaptive Planning). Used as the business key for cross-system integration and reporting.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `unit_name` STRING COMMENT 'Official human-readable name of the organizational unit as defined in SAP SuccessFactors Org Chart (e.g., NFL Operations Division, Broadcast Network – East, Venue Facilities – Madison Square Garden). Used in workforce reporting, org charts, and budget allocation displays.',
    `unit_short_name` STRING COMMENT 'Abbreviated display name for the organizational unit used in dashboards, payslips, and space-constrained reporting contexts (e.g., NFL Ops, Broadcast-E, MSG Facilities).. Valid values are `^.{1,30}$`',
    `unit_type` STRING COMMENT 'Classification of the organizational unit by its structural role within Sports Entertainment. Drives hierarchy rules, budget allocation logic, and workforce reporting segmentation. [ENUM-REF-CANDIDATE: department|division|league|venue|broadcast_network|cost_center_group|shared_service — promote to reference product if additional types emerge]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this organizational unit record in the enterprise data platform. Used for change data capture (CDC), incremental ETL processing, and audit trail maintenance.',
    `workforce_category` STRING COMMENT 'Primary workforce category of employees within this organizational unit. Drives payroll processing rules, benefits eligibility, OSHA recordkeeping scope, and CBA applicability. [ENUM-REF-CANDIDATE: full_time|part_time|seasonal|event_crew|broadcast_crew|league_official|contractor — promote to reference product]',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational hierarchy master representing departments, divisions, leagues, venues, and broadcast units within Sports Entertainment. Captures org unit name, org unit type (department, division, league, venue, broadcast network), parent org unit, cost center code, effective date, and active status. Sourced from SAP SuccessFactors Org Chart. Provides the structural backbone for workforce reporting, budget allocation, and span-of-control analysis.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`job_application` (
    `job_application_id` BIGINT COMMENT 'Unique surrogate identifier for each job application record in the talent acquisition lifecycle. Primary key for the job_application data product sourced from SAP SuccessFactors Recruiting Management.',
    `candidate_id` BIGINT COMMENT 'Reference to the candidate profile record in the talent acquisition system. Enables tracking of a single candidate across multiple applications.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Recruiting costs (cost_per_hire_usd field exists) are charged to cost centers. Sports organizations track talent acquisition costs by department/cost center for headcount budget management and cost-pe',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: A job application is submitted for a specific approved headcount position slot. Linking job_application.position_id → position.position_id normalizes the position reference (currently only position_ti',
    `employee_id` BIGINT COMMENT 'Reference to the internal employee record of the hiring manager responsible for the open position. Used for approval routing, interview scheduling, and workforce analytics.',
    `requisition_id` BIGINT COMMENT 'Reference to the approved headcount requisition that triggered this job posting. Links the application to the originating position request and budget authorization.',
    `tertiary_job_referral_employee_id` BIGINT COMMENT 'Reference to the internal employee who referred this candidate, when source_channel is employee_referral. Used for referral bonus processing and referral program effectiveness reporting.',
    `actual_start_date` DATE COMMENT 'Confirmed first day of employment after offer acceptance and onboarding completion. May differ from target_start_date due to notice periods or scheduling changes. Triggers employee record creation in SAP SuccessFactors.',
    `application_number` STRING COMMENT 'Externally visible, human-readable application reference number generated by SAP SuccessFactors Recruiting Management (e.g., APP-20240001). Used in candidate communications, offer letters, and audit trails.. Valid values are `^APP-[0-9]{8}$`',
    `application_status` STRING COMMENT 'Current workflow state of the job application within the talent acquisition pipeline. Drives recruiter task queues, candidate communications, and funnel conversion reporting. [ENUM-REF-CANDIDATE: new|in_review|interview|offer|hired|withdrawn|rejected — promote to reference product]',
    `applied_date` DATE COMMENT 'Calendar date on which the candidate formally submitted the job application. Principal business event date for time-to-fill calculations and sourcing analytics.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numeric score from standardized pre-employment assessments (skills tests, cognitive assessments, or role-specific evaluations) administered during the recruiting process. Expressed as a percentage or scaled score per assessment design.',
    `background_check_status` STRING COMMENT 'Current status of the pre-employment background check for the candidate. Required for compliance with OSHA venue safety standards and league governance requirements for officials and staff.. Valid values are `not_initiated|pending|clear|adverse|cancelled`',
    `candidate_email` STRING COMMENT 'Primary email address of the job applicant used for all recruiting communications, interview invitations, and offer delivery. Governed under GDPR and CCPA data privacy regulations.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `candidate_first_name` STRING COMMENT 'Legal first (given) name of the job applicant as provided during application submission. Required for candidate communications, offer letters, and background check initiation.',
    `candidate_last_name` STRING COMMENT 'Legal last (family) name of the job applicant as provided during application submission. Required for candidate communications, offer letters, and background check initiation.',
    `candidate_phone` STRING COMMENT 'Primary contact phone number for the job applicant. Used by recruiters for interview scheduling and offer negotiation calls.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `cost_per_hire_usd` DECIMAL(18,2) COMMENT 'Total recruiting cost attributed to this application, expressed in USD. Includes agency fees, advertising spend, assessment costs, and recruiter time allocation. Key KPI for talent acquisition efficiency benchmarking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the job application record was first created in SAP SuccessFactors Recruiting Management. Used for audit trail and data lineage in the Silver layer.',
    `dei_disability_status` STRING COMMENT 'Self-reported disability status of the candidate, collected voluntarily for Section 503 and ADA compliance reporting. Not used in hiring decisions. Governed under GDPR Article 9.. Valid values are `yes|no|prefer_not_to_say`',
    `dei_ethnicity` STRING COMMENT 'Self-reported ethnicity of the candidate, collected voluntarily for DEI hiring metrics and EEOC compliance reporting. Not used in hiring decisions. Governed under GDPR Article 9 and CCPA. [ENUM-REF-CANDIDATE: white|black_or_african_american|hispanic_or_latino|asian|native_american|pacific_islander|two_or_more|prefer_not_to_say — promote to reference product]',
    `dei_gender_identity` STRING COMMENT 'Self-reported gender identity of the candidate, collected voluntarily for DEI hiring metrics and EEOC compliance reporting. Not used in hiring decisions. Governed under GDPR and CCPA.. Valid values are `male|female|non_binary|prefer_not_to_say|other`',
    `dei_veteran_status` STRING COMMENT 'Self-reported veteran status of the candidate, collected voluntarily for VEVRAA compliance and DEI reporting. Not used in hiring decisions.. Valid values are `veteran|not_veteran|prefer_not_to_say`',
    `department_code` STRING COMMENT 'Organizational department code from SAP SuccessFactors to which the open position belongs (e.g., BRDCST-OPS, VENUE-MGMT, ATHLETE-SVC). Used for workforce headcount reporting and cost center allocation.',
    `employment_type` STRING COMMENT 'Classification of the employment arrangement for the open position. Distinguishes full-time staff from part-time event crew, seasonal workers, broadcast crews, and interns — all tracked in the workforce domain.. Valid values are `full_time|part_time|seasonal|contract|intern`',
    `interview_stage` STRING COMMENT 'Current or most recently completed interview stage in the candidate evaluation process. Tracks pipeline progression from initial phone screen through final round interviews.. Valid values are `phone_screen|hiring_manager|panel|final|none`',
    `is_internal_candidate` BOOLEAN COMMENT 'Indicates whether the applicant is a current employee of Sports Entertainment applying for an internal transfer or promotion. Drives internal mobility reporting and CBA compliance tracking.',
    `is_rehire` BOOLEAN COMMENT 'Indicates whether the candidate was previously employed by Sports Entertainment. Triggers rehire eligibility review and prior employment record lookup in SAP SuccessFactors.',
    `job_family` STRING COMMENT 'Functional grouping of the position within the organizational job architecture (e.g., Broadcast & Media, Athlete Operations, Venue Management, Finance, Technology). Supports workforce planning and DEI analytics segmentation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the job application record. Supports incremental data loading, change detection, and audit compliance.',
    `offer_accepted_date` DATE COMMENT 'Calendar date on which the candidate formally accepted the employment offer. Marks the successful close of the talent acquisition lifecycle for this application.',
    `offer_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the offered_base_salary and any other monetary offer components (e.g., USD, GBP, EUR, AUD). Required for global workforce compensation reporting.. Valid values are `^[A-Z]{3}$`',
    `offer_decline_reason` STRING COMMENT 'Categorized reason provided by the candidate for declining the employment offer. Informs compensation benchmarking, location strategy, and talent market competitiveness assessments.. Valid values are `compensation|competing_offer|location|role_fit|personal|no_reason_given`',
    `offer_declined_date` DATE COMMENT 'Calendar date on which the candidate declined the employment offer. Populated when offer_accepted_date is null and the candidate chose not to accept. Used for offer decline rate and competitive compensation analysis.',
    `offer_extended_date` DATE COMMENT 'Calendar date on which a formal employment offer was extended to the candidate. Used for time-to-offer KPI measurement and offer acceptance rate analytics.',
    `offered_base_salary` DECIMAL(18,2) COMMENT 'Annual base salary amount included in the formal employment offer extended to the candidate. Expressed in the local currency of the position. Confidential business data used for compensation benchmarking and budget variance analysis.',
    `position_title` STRING COMMENT 'Job title of the open position the candidate is applying for (e.g., Head of Broadcast Operations, Event Crew Coordinator, League Official). Sourced from the approved requisition in SAP SuccessFactors.',
    `posting_type` STRING COMMENT 'Indicates whether the job requisition was posted internally (to existing employees), externally (to the public), or both. Drives internal mobility tracking and sourcing channel attribution.. Valid values are `internal|external|both`',
    `rejection_reason` STRING COMMENT 'Categorized reason for rejecting the candidates application. Used for recruiter disposition compliance, EEOC reporting, and funnel quality analysis.. Valid values are `qualifications|experience|culture_fit|position_filled|budget_frozen|other`',
    `requisition_number` STRING COMMENT 'Human-readable requisition reference number from SAP SuccessFactors (e.g., REQ-0001234). Externally visible identifier used in job postings, candidate communications, and headcount governance reporting.. Valid values are `^REQ-[0-9]{7}$`',
    `source_channel` STRING COMMENT 'The recruiting channel through which the candidate discovered and applied for the position (e.g., LinkedIn, Indeed, Employee Referral, Career Site, Agency, Internal Transfer, Campus Recruiting). Critical for source effectiveness and cost-per-hire (CPH) analytics. [ENUM-REF-CANDIDATE: linkedin|indeed|employee_referral|career_site|agency|internal_transfer|campus|other — promote to reference product]',
    `target_start_date` DATE COMMENT 'Anticipated first day of employment for the candidate as specified in the requisition or offer. Used for workforce planning, onboarding scheduling, and time-to-fill measurement.',
    `withdrawal_date` DATE COMMENT 'Date on which the candidate voluntarily withdrew their application from consideration. Populated when application_status is withdrawn. Used for candidate drop-off analysis.',
    `withdrawal_reason` STRING COMMENT 'Categorized reason for candidate withdrawal from the application process. Supports pipeline attrition analysis and process improvement initiatives.. Valid values are `accepted_other_offer|personal_reasons|role_change|no_response|other`',
    `work_authorization_status` STRING COMMENT 'Candidates self-reported eligibility to work in the country of the open position without employer sponsorship. Required for I-9 compliance and international hiring decisions across global markets.. Valid values are `authorized|requires_sponsorship|not_authorized|not_disclosed`',
    CONSTRAINT pk_job_application PRIMARY KEY(`job_application_id`)
) COMMENT 'Talent acquisition lifecycle record managing the end-to-end hiring process at Sports Entertainment — from headcount requisition approval through candidate offer acceptance. Captures requisition management (position linked, hiring manager, recruiter assigned, requisition status, target start date, sourcing channels, internal/external posting, time-to-fill), candidate pipeline (applicant identity, source channel, application status, interview stage, assessment scores, background check status, offer details), and hiring analytics (funnel conversion rates, source effectiveness, DEI hiring metrics, cost-per-hire). Sourced from SAP SuccessFactors Recruiting Management. SSOT for all talent acquisition activity including requisition governance and candidate lifecycle.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` (
    `employment_contract_id` BIGINT COMMENT 'Unique surrogate identifier for each employment contract record in the Sports Entertainment workforce system. Primary key for the employment_contract data product sourced from SAP SuccessFactors Employee Central.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Employment contracts are issued by specific legal entities in multi-entity sports groups (league entity, team subsidiary, broadcast co.). Company code assignment drives statutory reporting, tax withho',
    `corporate_entity_id` BIGINT COMMENT 'Foreign key linking to legal.corporate_entity. Business justification: Employment contracts are executed by a specific legal entity. In sports-entertainment multi-entity structures, this determines applicable labor law, tax jurisdiction, and entity-level headcount. legal',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Employment contracts assign labor costs to cost centers for headcount budgeting and labor cost allocation. Sports organizations track which cost center (team ops, broadcast, venue) bears each employee',
    `employee_id` BIGINT COMMENT 'Reference to the workforce member (employee, contractor, seasonal crew, broadcast talent, or league official) to whom this contract applies. Links to the workforce identity record in SAP SuccessFactors.',
    `franchise_id` BIGINT COMMENT 'Foreign key linking to league.franchise. Business justification: Coaching staff, GM, and front-office employment contracts are issued by a specific franchise. Franchise-level contract management, staff salary cap cost tracking, and CBA compliance reporting all requ',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: An employment contract is executed within a specific organizational unit, governing CBA applicability, payroll area, and cost center. employment_contract already has cost_center_code and legal_entity_',
    `position_id` BIGINT COMMENT 'Reference to the organizational position or job role associated with this employment contract, as defined in the SAP SuccessFactors Position Management module.',
    `worker_employee_id` BIGINT COMMENT 'Reference to the workforce member (employee, contractor, seasonal crew, broadcast talent, or league official) to whom this contract applies. Links to the workforce identity record in SAP SuccessFactors.',
    `base_pay_rate` DECIMAL(18,2) COMMENT 'The contractual base compensation amount expressed in the unit defined by pay_basis (annual salary, hourly rate, daily rate, or per-event fee). Excludes bonuses, commissions, and NIL-related compensation. Stored in the contract currency. Used for pay equity analysis, CBA compliance, and labor cost forecasting.',
    `bonus_target_pct` DECIMAL(18,2) COMMENT 'The contractually agreed target annual bonus expressed as a percentage of base pay rate. Used in total compensation modeling, labor cost forecasting, and annual incentive plan administration. Zero if no bonus is applicable for this contract.',
    `cba_agreement_reference` STRING COMMENT 'The identifier or name of the specific Collective Bargaining Agreement governing this contract (e.g., NFL-NFLPA-CBA-2020, IATSE-Local-695-2023). Populated only when cba_covered is True. Used for CBA compliance reporting and labor relations management.',
    `cba_covered` BOOLEAN COMMENT 'Indicates whether this employment contract is governed by a Collective Bargaining Agreement (True) or is an individual/non-union contract (False). Determines which CBA provisions, wage scales, and grievance procedures apply.',
    `commission_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible to earn commission under this contract (True) or not (False). Applicable to sponsorship sales staff, merchandise sales roles, and ticket sales representatives. Drives commission plan enrollment in SAP SuccessFactors.',
    `contract_number` STRING COMMENT 'Externally-known unique alphanumeric reference number assigned to this employment contract, used in legal documents, payroll systems, and CBA compliance reporting. Generated by SAP SuccessFactors and referenced in SAP S/4HANA HR-FI integration.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the employment contract. Draft indicates contract is being prepared; active indicates currently binding; suspended indicates temporarily paused (e.g., leave of absence); terminated indicates ended before natural expiry; expired indicates fixed-term or seasonal contract reached its end date; pending_renewal indicates contract is under renegotiation.. Valid values are `draft|active|suspended|terminated|expired|pending_renewal`',
    `contract_type` STRING COMMENT 'Classification of the employment arrangement: permanent (indefinite full-time/part-time), fixed_term (defined end date), seasonal (event-season bound, e.g., summer tour crew), zero_hours (on-call event staff), or casual (ad-hoc broadcast crew). Drives CBA applicability and benefit eligibility rules.. Valid values are `permanent|fixed_term|seasonal|zero_hours|casual`',
    `contracted_hours_per_week` DECIMAL(18,2) COMMENT 'The number of hours per week the employee is contractually obligated to work. Used for FTE (Full-Time Equivalent) calculations, overtime threshold determination, and labor cost forecasting. Zero for zero-hours contracts.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this employment contract record was first created in the SAP SuccessFactors system. Used for audit trail, data lineage, and SOX compliance reporting.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all monetary compensation values in this contract are denominated (e.g., USD, GBP, EUR). Required for multi-currency labor cost consolidation in SAP S/4HANA FI/CO.. Valid values are `^[A-Z]{3}$`',
    `employment_category` STRING COMMENT 'Legal employment category determining tax treatment, benefit eligibility, and labor law protections: employee (direct hire with full employment rights), independent_contractor (self-employed, no employment rights), agency_worker (supplied by staffing agency), or intern (structured learning placement). Critical for IRS worker classification compliance and GDPR data subject rights determination.. Valid values are `employee|independent_contractor|agency_worker|intern`',
    `end_date` DATE COMMENT 'The date on which the employment contract expires or is scheduled to terminate. Null for permanent/indefinite contracts. Used for fixed-term, seasonal, and zero-hours contract lifecycle management and workforce planning.',
    `flsa_status` STRING COMMENT 'Indicates whether the employee is classified as exempt (not entitled to overtime pay) or non_exempt (entitled to overtime pay at 1.5x rate) under the US Fair Labor Standards Act. Critical for overtime cost management, payroll compliance, and OSHA labor standards reporting.. Valid values are `exempt|non_exempt`',
    `fte_ratio` DECIMAL(18,2) COMMENT 'The proportion of a standard full-time working week represented by this contract, expressed as a decimal (e.g., 1.000 = full-time, 0.500 = half-time). Derived from contracted hours but stored for workforce planning, headcount reporting, and labor cost allocation.',
    `job_grade` STRING COMMENT 'The compensation grade or band level assigned to the position under this contract (e.g., G5, M3, E1). Determines the applicable salary range, benefit tier, and merit increase eligibility. Sourced from SAP SuccessFactors Job Classification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this employment contract record was most recently updated in the SAP SuccessFactors system. Used for change data capture, audit trail, and SOX compliance reporting.',
    `last_reviewed_date` DATE COMMENT 'The date on which this employment contract was most recently reviewed as part of an annual compensation review cycle, CBA renegotiation, or ad-hoc contract amendment process. Used to track review cadence compliance.',
    `merit_increase_schedule` STRING COMMENT 'The schedule governing when merit-based pay increases are reviewed and applied under this contract: annual (standard review cycle), bi_annual (twice-yearly for high-demand broadcast talent), performance_triggered (milestone-based for athlete-adjacent roles), or none (fixed-rate contracts such as CBA-governed hourly staff).. Valid values are `annual|bi_annual|performance_triggered|none`',
    `nil_compensation_eligible` BOOLEAN COMMENT 'Indicates whether this contract includes provisions for Name, Image, and Likeness (NIL) compensation, applicable to athlete-adjacent roles such as brand ambassadors, coaching staff with public profiles, and broadcast talent. True enables NIL agreement linkage and NIL revenue tracking.',
    `nil_provision_details` STRING COMMENT 'Free-text description of the NIL-related compensation provisions included in this contract, such as approved usage categories, revenue share percentages, or exclusivity restrictions. Populated only when nil_compensation_eligible is True.',
    `notice_period_days` STRING COMMENT 'Number of calendar days of notice required by either party to terminate this employment contract. Varies by contract type, seniority, and CBA provisions. Used in workforce planning and termination processing.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible to receive overtime pay under this contract (True) or not (False). Typically aligned with FLSA non-exempt status but may also reflect CBA-specific overtime provisions for event crew and broadcast staff.',
    `pay_basis` STRING COMMENT 'The basis on which compensation is calculated: annual_salary (salaried employees), hourly_rate (part-time and event crew), daily_rate (broadcast crew and officials), or per_event (talent and officials paid per appearance). Determines how base pay rate is interpreted and applied in payroll.. Valid values are `annual_salary|hourly_rate|daily_rate|per_event`',
    `pay_frequency` STRING COMMENT 'The frequency at which the employee is paid under this contract: weekly (event crew), bi_weekly (standard staff), semi_monthly (salaried staff), monthly (executives/international), or event_based (per-event broadcast talent and officials). Drives payroll processing cycles in SAP S/4HANA Payroll.. Valid values are `weekly|bi_weekly|semi_monthly|monthly|event_based`',
    `probation_end_date` DATE COMMENT 'The date on which the employees probationary period concludes. During probation, different notice periods and benefit eligibility rules may apply. Null if no probation period is applicable (e.g., rehires, senior executives).',
    `remote_work_type` STRING COMMENT 'The contractually agreed work location arrangement: on_site (venue/office-based), remote (fully remote), hybrid (split on-site and remote), or travelling (primarily travelling, e.g., touring broadcast crew, league officials). Affects tax nexus determination, OSHA safety obligations, and facility cost allocation.. Valid values are `on_site|remote|hybrid|travelling`',
    `renewal_notice_days` STRING COMMENT 'Number of calendar days before the contract end_date by which the renewal option must be exercised or declined. Null when renewal_option is False. Used to trigger automated renewal workflow alerts in SAP SuccessFactors.',
    `renewal_option` BOOLEAN COMMENT 'Indicates whether this contract contains a renewal or extension option clause (True) that either party may exercise before the end_date. Used in workforce planning to forecast headcount continuity for seasonal and fixed-term contracts.',
    `salary_range_max` DECIMAL(18,2) COMMENT 'The maximum of the approved compensation band for the position. Used to flag above-band compensation requiring executive approval and to cap merit increase eligibility in annual review cycles.',
    `salary_range_mid` DECIMAL(18,2) COMMENT 'The midpoint (market reference point) of the approved compensation band for the position. Used as the benchmark for compa-ratio calculations in annual compensation review cycles and pay equity reporting.',
    `salary_range_min` DECIMAL(18,2) COMMENT 'The minimum of the approved compensation band for the position associated with this contract. Used in pay equity analysis, compensation review cycles, and to ensure base_pay_rate does not fall below the band floor. Sourced from SAP SuccessFactors Compensation Management grade structures.',
    `signed_date` DATE COMMENT 'The date on which the employment contract was formally executed (signed by both parties). May differ from start_date for contracts signed in advance of commencement. Used for legal enforceability tracking and audit purposes.',
    `start_date` DATE COMMENT 'The date on which the employment contract becomes effective and binding. Used for tenure calculations, benefit eligibility vesting, and CBA seniority tracking.',
    `termination_date` DATE COMMENT 'The actual date on which the employment contract was terminated, if applicable. Distinct from end_date (scheduled expiry) — this captures early or involuntary terminations. Null for active contracts. Used in workforce attrition analysis and CBA grievance tracking.',
    `termination_reason` STRING COMMENT 'The reason code for contract termination: resignation (voluntary), redundancy (role elimination), end_of_term (natural expiry of fixed/seasonal contract), dismissal (involuntary for cause), mutual_agreement (negotiated exit), or retirement. Used for workforce attrition reporting and CBA compliance. [ENUM-REF-CANDIDATE: resignation|redundancy|end_of_term|dismissal|mutual_agreement|retirement|transfer|death — promote to reference product]. Valid values are `resignation|redundancy|end_of_term|dismissal|mutual_agreement|retirement`',
    `union_local` STRING COMMENT 'The specific union local or chapter to which the employee belongs under the applicable CBA (e.g., IATSE Local 695, IBEW Local 40). Used for union dues remittance, grievance routing, and CBA compliance tracking. Null for non-union contracts.',
    `work_location_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the primary work location specified in the contract. Determines applicable labor law jurisdiction, tax withholding rules, GDPR/CCPA applicability, and governing CBA.. Valid values are `^[A-Z]{3}$`',
    `worker_classification` STRING COMMENT 'Operational classification of the workforce member under this contract: full_time (permanent staff), part_time (regular reduced-hours staff), seasonal (event-season workers), event_crew (per-event technical and production crew), broadcast_talent (on-air and production broadcast staff), or league_official (referees, umpires, and governing body officials). Drives benefit eligibility, OSHA training requirements, and reporting.. Valid values are `full_time|part_time|seasonal|event_crew|broadcast_talent|league_official`',
    CONSTRAINT pk_employment_contract PRIMARY KEY(`employment_contract_id`)
) COMMENT 'Formal employment agreement and compensation terms record for each workforce member at Sports Entertainment, including full-time staff, seasonal event crew, broadcast talent, and league officials. Captures contract terms (contract type — permanent, fixed-term, seasonal, zero-hours; start/end date, contracted hours, probation period, contract status), compensation structure (base pay rate, pay frequency, salary range min/mid/max, bonus target percentage, commission eligibility, merit increase schedule, NIL-related compensation provisions for athlete-adjacent roles), CBA provisions (CBA agreement reference, union local), and effective dates. Sourced from SAP SuccessFactors Employee Central and Compensation Management. Supports CBA compliance, labor cost forecasting, pay equity analysis, annual compensation review cycles, and workforce planning.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` (
    `payroll_record_id` BIGINT COMMENT 'Unique surrogate identifier for each payroll processing record in the Sports Entertainment workforce payroll system. Primary key for this entity. Sourced from SAP SuccessFactors Payroll.',
    `athlete_contract_id` BIGINT COMMENT 'Foreign key linking to athlete.contract. Business justification: Athlete payroll processing requires validating base salary, signing bonuses, and incentive payments against the athlete contract terms. This link drives payroll audit reports, cap-hit reconciliation, ',
    `production_id` BIGINT COMMENT 'Foreign key linking to broadcast.production. Business justification: payroll_record carries broadcast_differential_amount — a pay premium for broadcast work days. Linking to the specific broadcast production enables production-level labor cost reporting, finance reconc',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Payroll records must be tied to the issuing legal entity for statutory tax filings, financial consolidation, and multi-entity sports group reporting. Multi-subsidiary organizations (league, team, broa',
    `corporate_entity_id` BIGINT COMMENT 'Foreign key linking to legal.corporate_entity. Business justification: Payroll is processed by a specific legal entity for statutory tax filings (941, W-2, state returns) and entity-level labor cost reporting. In multi-entity sports orgs, payroll_record must identify the',
    `cost_center_id` BIGINT COMMENT 'Reference to the organizational cost center to which this payroll expense is allocated. Used for financial controlling and departmental labor cost reporting in SAP S/4HANA CO module.',
    `employee_id` BIGINT COMMENT 'Reference to the employee whose compensation is captured in this payroll record. Links to the workforce employee master in SAP SuccessFactors.',
    `employment_contract_id` BIGINT COMMENT 'Foreign key linking to workforce.employment_contract. Business justification: Payroll processing is governed by employment contract terms — base_pay_rate, pay_frequency, pay_basis, overtime_eligible, cba_covered, and salary_range. Linking payroll_record.employment_contract_id →',
    `franchise_id` BIGINT COMMENT 'Foreign key linking to league.franchise. Business justification: Franchise payroll reporting, staff cost budgeting, and league revenue-sharing calculations require payroll records to be attributed to the correct franchise. Standard requirement in sports-entertainme',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Payroll journal posting maps each pay component (wages, overtime, benefits) to specific GL accounts. Sports organizations require this link for payroll accrual entries, period-end close, and SOX contr',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Payroll records are processed by payroll area which maps to organizational units. payroll_record has payroll_area_code as a string but no org_unit_id FK. Linking payroll_record.org_unit_id → org_unit.',
    `payroll_run_id` BIGINT COMMENT 'Reference to the payroll run batch that produced this record. Enables grouping of all employee pay results processed in the same payroll execution cycle.',
    `tax_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to finance.tax_jurisdiction. Business justification: Payroll tax withholding (state income tax, local tax, jock tax for traveling athletes) depends on the tax jurisdiction where work is performed. Sports organizations with multi-state operations must ap',
    `bank_routing_number` STRING COMMENT 'ABA routing transit number of the employees primary bank for direct deposit disbursement. Nine-digit identifier required for ACH payment processing. Stored for payroll disbursement and audit purposes.. Valid values are `^[0-9]{9}$`',
    `base_pay_amount` DECIMAL(18,2) COMMENT 'The regular base salary or hourly wage earnings component for the pay period, excluding overtime, differentials, and supplemental pay. Core compensation component sourced from the employees pay structure in SAP SuccessFactors.',
    `benefit_deduction_amount` DECIMAL(18,2) COMMENT 'Total employee pre-tax and post-tax benefit deductions for the pay period, including health insurance premiums, dental, vision, 401(k) contributions, FSA/HSA contributions, and other voluntary benefit elections.',
    `broadcast_differential_amount` DECIMAL(18,2) COMMENT 'Additional shift differential pay earned by broadcast crew members for specialized broadcast production work. Reflects premium compensation for technical broadcast roles per applicable CBA or employment agreements.',
    `cba_agreement_code` STRING COMMENT 'Identifier of the Collective Bargaining Agreement (CBA) governing this employees compensation terms at the time of the payroll record. Applicable to unionized Sports Entertainment workforce; determines wage rates, overtime rules, and differential eligibility.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this payroll record was first created in the SAP SuccessFactors Payroll system. Used for audit trail, data lineage, and payroll compliance reporting per SOX requirements.',
    `direct_deposit_flag` BOOLEAN COMMENT 'Indicates whether the employees net pay for this payroll record was disbursed via direct deposit (True) or by physical check (False). Used for payment method tracking and bank reconciliation.',
    `employer_fica_amount` DECIMAL(18,2) COMMENT 'Employers matching share of FICA (Social Security 6.2% + Medicare 1.45%) contributions for the pay period. Represents a labor cost to Sports Entertainment beyond gross pay; required for IRS Form 941 and financial labor cost reporting.',
    `employment_type` STRING COMMENT 'Classification of the employees engagement type at the time of this payroll record. Determines applicable tax treatment, benefit eligibility, and CBA obligations for Sports Entertainment workforce categories including event crew, broadcast crews, and seasonal workers.. Valid values are `full_time|part_time|seasonal|contractor|event_crew`',
    `event_day_differential_amount` DECIMAL(18,2) COMMENT 'Additional shift differential pay earned for hours worked on event days (game days, concert days, live events). Specific to Sports Entertainment operations where event-day staffing commands premium compensation per CBA or employment agreements.',
    `federal_income_tax_withheld` DECIMAL(18,2) COMMENT 'Total federal income tax withheld from the employees gross pay for the pay period per IRS withholding tables and the employees W-4 filing status. Required for IRS Form 941 and W-2 reporting.',
    `fica_medicare_amount` DECIMAL(18,2) COMMENT 'Employees share of Federal Insurance Contributions Act (FICA) Medicare tax withheld for the pay period. Calculated at the statutory rate (1.45%), with additional 0.9% for high earners. Required for IRS Form 941 and W-2 reporting.',
    `fica_social_security_amount` DECIMAL(18,2) COMMENT 'Employees share of Federal Insurance Contributions Act (FICA) Social Security tax withheld for the pay period. Calculated at the statutory rate (6.2%) up to the annual wage base limit. Required for IRS Form 941 and W-2 reporting.',
    `garnishment_amount` DECIMAL(18,2) COMMENT 'Total court-ordered or legally mandated wage garnishment deductions applied to the employees pay for the period. Includes child support, tax levies, creditor garnishments, and student loan garnishments per applicable court orders.',
    `gross_pay_amount` DECIMAL(18,2) COMMENT 'Total pre-tax compensation earned by the employee for the pay period, including base pay, overtime, shift differentials, and all other earnings components before any deductions. Expressed in USD.',
    `is_union_member` BOOLEAN COMMENT 'Indicates whether the employee was a union member at the time of this payroll record. Determines applicability of CBA wage rates, union dues deductions, and labor agreement compliance obligations.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this payroll record was most recently modified in the SAP SuccessFactors Payroll system. Tracks corrections, reversals, and amendments for audit trail and SOX compliance.',
    `local_income_tax_withheld` DECIMAL(18,2) COMMENT 'Total local/municipal income tax withheld from the employees gross pay for the pay period. Applicable in jurisdictions with local income taxes (e.g., city taxes in markets where Sports Entertainment operates venues).',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'Total take-home pay disbursed to the employee after all tax withholdings, benefit deductions, union dues, garnishments, and other deductions have been subtracted from gross pay. Expressed in USD.',
    `overnight_differential_amount` DECIMAL(18,2) COMMENT 'Additional shift differential pay earned for hours worked during overnight shifts (typically midnight to 6 AM). Applicable to venue operations, security, and broadcast crews working overnight at Sports Entertainment facilities.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Total number of overtime hours worked by the employee during the pay period, as defined by FLSA thresholds (hours exceeding 40 per workweek) or applicable CBA provisions for Sports Entertainment event and broadcast crews.',
    `overtime_pay_amount` DECIMAL(18,2) COMMENT 'Total premium compensation paid for overtime hours worked during the pay period. Calculated at the applicable overtime rate (typically 1.5x base rate) per FLSA or CBA requirements.',
    `pay_date` DATE COMMENT 'The actual date on which the employees net pay was disbursed via direct deposit or check. Used for cash flow reporting and payroll audit compliance.',
    `pay_frequency` STRING COMMENT 'The cadence at which the employee is paid. Determines the pay period structure and is tied to the employees employment agreement or Collective Bargaining Agreement (CBA).. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `pay_group_code` STRING COMMENT 'SAP SuccessFactors pay group identifier that clusters employees sharing the same payroll processing schedule, pay frequency, and payroll area (e.g., FT-STAFF, PT-EVENT, BROADCAST-CREW, LEAGUE-OFFICIAL).',
    `pay_period_end_date` DATE COMMENT 'The last calendar date of the pay period covered by this payroll record. Defines the closing boundary of the earnings window for compensation calculation.',
    `pay_period_start_date` DATE COMMENT 'The first calendar date of the pay period covered by this payroll record. Together with pay_period_end_date defines the earnings window for which compensation is calculated.',
    `payment_method` STRING COMMENT 'The specific disbursement method used to deliver net pay to the employee. Provides granular payment channel detail beyond the direct_deposit_flag for audit and reconciliation purposes.. Valid values are `direct_deposit|check|wire_transfer|pay_card`',
    `payroll_area_code` STRING COMMENT 'SAP SuccessFactors payroll area code identifying the organizational payroll processing unit. Aligns with legal entity, country, and pay schedule groupings for multi-entity Sports Entertainment operations.',
    `payroll_run_date` DATE COMMENT 'The date on which the payroll processing run was executed in SAP SuccessFactors. Distinct from pay_date; used for payroll audit trails and reconciliation.',
    `regular_hours_worked` DECIMAL(18,2) COMMENT 'Total regular (non-overtime) hours worked by the employee during the pay period. Used for hourly pay calculation, FLSA compliance tracking, and workforce capacity reporting.',
    `retirement_contribution_amount` DECIMAL(18,2) COMMENT 'Employees elective deferral contribution to qualified retirement plans (401(k), 403(b)) deducted from pay for the period. Tracked separately from general benefit deductions for IRS annual contribution limit compliance and plan reporting.',
    `run_status` STRING COMMENT 'Current lifecycle status of this payroll record within the payroll processing workflow. Tracks progression from initial calculation through financial posting or reversal.. Valid values are `draft|processed|approved|posted|reversed|cancelled`',
    `run_type` STRING COMMENT 'Classification of the payroll run that produced this record. Regular runs follow the standard pay schedule; off-cycle and supplemental runs address corrections, bonuses, or termination pay outside the normal cycle.. Valid values are `regular|off_cycle|supplemental|correction|final`',
    `state_income_tax_withheld` DECIMAL(18,2) COMMENT 'Total state income tax withheld from the employees gross pay for the pay period per applicable state tax authority requirements. Varies by state of employment; critical for multi-state Sports Entertainment operations.',
    `total_deductions_amount` DECIMAL(18,2) COMMENT 'Sum of all deductions applied to gross pay for the period, including taxes, FICA, union dues, garnishments, and benefit deductions. Reconciliation field: gross_pay_amount minus total_deductions_amount equals net_pay_amount.',
    `union_dues_amount` DECIMAL(18,2) COMMENT 'Total union dues deducted from the employees pay for the period per Collective Bargaining Agreement (CBA) obligations. Applicable to unionized Sports Entertainment workforce including event crew, broadcast technicians, and league officials.',
    `ytd_federal_tax_withheld` DECIMAL(18,2) COMMENT 'Cumulative federal income tax withheld from the employees pay from the start of the calendar year through this pay period. Required for IRS Form W-2 Box 2 reporting and annual tax reconciliation.',
    `ytd_fica_social_security_amount` DECIMAL(18,2) COMMENT 'Cumulative employee FICA Social Security tax withheld from the start of the calendar year through this pay period. Used to track against the annual Social Security wage base limit and for IRS Form W-2 Box 4 reporting.',
    `ytd_gross_pay_amount` DECIMAL(18,2) COMMENT 'Cumulative gross pay earned by the employee from the start of the calendar year through the end of this pay period. Required for FICA wage base tracking, W-2 preparation, and annual compensation reporting.',
    CONSTRAINT pk_payroll_record PRIMARY KEY(`payroll_record_id`)
) COMMENT 'Payroll processing record capturing each pay run result for an employee at Sports Entertainment. Includes pay period start/end, gross pay, net pay, federal/state/local tax withholdings, FICA contributions, union dues deducted, overtime hours and premium pay, shift differentials (event-day, broadcast, overnight), garnishments, direct deposit status, and payroll run date. Sourced from SAP SuccessFactors Payroll. SSOT for all compensation disbursement data and payroll audit compliance.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Unique surrogate identifier for each benefit enrollment record in the Sports Entertainment workforce benefits system. Primary key for this entity.',
    `benefit_plan_id` BIGINT COMMENT 'Reference to the specific benefit plan offered by Sports Entertainment (e.g., Blue Shield PPO, Delta Dental, Fidelity 401k). Links to the benefit plan catalog.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to partner.vendor. Business justification: Benefit carriers (health insurers, retirement plan providers) in sports-entertainment are registered vendors with formal contracts. Linking benefit enrollments to vendor enables contract compliance tr',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Employer benefit contributions (health, retirement, COBRA) are charged to cost centers for labor cost reporting and budget variance analysis. Sports organizations require cost center assignment on ben',
    `employee_id` BIGINT COMMENT 'Reference to the workforce member (employee, seasonal worker, broadcast crew, league official) who elected this benefit plan. Links to the employee master record in SAP SuccessFactors.',
    `employment_contract_id` BIGINT COMMENT 'Foreign key linking to workforce.employment_contract. Business justification: Benefit eligibility and plan selection are governed by employment contract terms — specifically contract_type, fte_ratio, cba_covered, and employment_category. Linking benefit_enrollment.employment_co',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Benefit plan costs post to specific GL accounts (employee benefits expense, employer FICA liability, retirement contribution). Finance teams in sports organizations need this link for benefits accrual',
    `open_enrollment_period_id` BIGINT COMMENT 'Reference to the annual or qualifying open enrollment window during which this election was made. Supports benefits cost reporting by enrollment cycle.',
    `aca_offer_of_coverage_code` STRING COMMENT 'IRS-defined code indicating the type of minimum essential coverage (MEC) offered to the employee and their dependents for ACA Form 1095-C Line 14 reporting. Values correspond to IRS ACA offer codes (1A through 1F).. Valid values are `1A|1B|1C|1D|1E|1F`',
    `annual_election_amount` DECIMAL(18,2) COMMENT 'Total annual dollar amount elected by the employee for the benefit plan. Primarily applicable to FSA, HSA, and 401k contribution elections. Expressed in USD.',
    `beneficiary_designation_on_file` BOOLEAN COMMENT 'Indicates whether the employee has a valid beneficiary designation on file for this benefit plan (life insurance, 401k, disability). Absence of a beneficiary designation triggers HR follow-up workflow. True = designation on file; False = missing.',
    `carrier_member_number` STRING COMMENT 'Unique member identification number assigned by the insurance carrier or benefit provider to the enrolled employee. Used for claims processing, eligibility verification, and carrier file transmissions.',
    `cba_plan_indicator` BOOLEAN COMMENT 'Indicates whether this benefit enrollment is governed by a Collective Bargaining Agreement (CBA) rather than the standard Sports Entertainment benefits program. CBA-governed plans may have different contribution rates, eligibility rules, and carrier arrangements.',
    `cobra_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible for COBRA (Consolidated Omnibus Budget Reconciliation Act) continuation coverage upon termination of this enrollment. Triggers COBRA notification workflow within the required 14-day window.',
    `cobra_notification_date` DATE COMMENT 'Date on which the COBRA election notice was sent to the employee following a qualifying event. Required for DOL compliance; Sports Entertainment must notify within 14 days of the plan administrator being notified of the qualifying event.',
    `coverage_end_date` DATE COMMENT 'Actual date on which insurance or benefit coverage ends for the employee and enrolled dependents. Used for COBRA notification triggering and ACA compliance gap analysis.',
    `coverage_start_date` DATE COMMENT 'Actual date on which insurance or benefit coverage begins for the employee and any enrolled dependents. May differ from effective_date in cases of retroactive enrollment or carrier processing delays.',
    `coverage_tier` STRING COMMENT 'Level of coverage elected by the employee, determining which dependents are covered under the plan. Options include employee only, employee plus spouse, employee plus children, or full family coverage.. Valid values are `employee_only|employee_spouse|employee_children|family`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit enrollment record was first created in the SAP SuccessFactors Benefits system. Supports audit trail, data lineage, and compliance record-keeping requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this enrollment record. Supports global workforce operations across international markets. Typically USD for domestic employees.. Valid values are `^[A-Z]{3}$`',
    `dependent_count` STRING COMMENT 'Number of dependents (spouse, children, domestic partner) enrolled under this benefit plan. Drives coverage tier validation and premium calculation. Does not include the employee themselves.',
    `effective_date` DATE COMMENT 'Date on which the benefit coverage becomes active for the employee. Determines the start of the coverage period for ACA compliance reporting and payroll deduction scheduling.',
    `election_date` DATE COMMENT 'Date on which the employee made or confirmed their benefit election. Distinct from the effective date; captures the actual decision event for audit and compliance purposes.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Annual dollar amount contributed by the employee toward the benefit plan premium or election. Used in total rewards analysis and payroll deduction calculations. Expressed in USD.',
    `employee_work_classification` STRING COMMENT 'Employment classification of the workforce member at the time of enrollment. Determines benefit eligibility rules; full-time employees receive full benefits while part-time, seasonal, and event crew may have restricted eligibility per CBA (Collective Bargaining Agreement) terms.. Valid values are `full_time|part_time|seasonal|contract|broadcast_crew|league_official`',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Annual dollar amount contributed by Sports Entertainment toward the employees benefit plan. Supports benefits cost reporting, EBITDA analysis, and total compensation benchmarking. Expressed in USD.',
    `employer_match_rate` DECIMAL(18,2) COMMENT 'Sports Entertainments employer matching contribution rate for retirement plan enrollments, expressed as a decimal percentage of the employees contribution (e.g., 0.5000 = 50% match up to the match cap). Applicable only to 401k plan type enrollments.',
    `enrollment_number` STRING COMMENT 'Externally-known business identifier for this benefit enrollment record, used in correspondence with carriers, brokers, and employees. Format: ENR-{YEAR}-{SEQUENCE}.. Valid values are `^ENR-[0-9]{4}-[0-9]{8}$`',
    `enrollment_source` STRING COMMENT 'Reason or trigger that initiated this benefit enrollment. Distinguishes between annual open enrollment, new hire enrollment, qualifying life event (QLE) changes, rehire reinstatement, or administrative corrections.. Valid values are `open_enrollment|new_hire|qualifying_life_event|rehire|correction`',
    `enrollment_status` STRING COMMENT 'Current lifecycle state of the benefit enrollment record. Active indicates the employee is currently enrolled; waived indicates the employee opted out; terminated indicates coverage has ended.. Valid values are `active|pending|waived|terminated|suspended`',
    `evidence_of_insurability_required` BOOLEAN COMMENT 'Indicates whether the employee is required to submit Evidence of Insurability (EOI) / medical underwriting for this enrollment (e.g., supplemental life insurance above guaranteed issue amount). True = EOI required; False = not required.',
    `evidence_of_insurability_status` STRING COMMENT 'Current status of the Evidence of Insurability (EOI) submission and carrier review process. Applicable only when evidence_of_insurability_required is True. Pending coverage may be limited until EOI is approved.. Valid values are `not_required|pending|approved|denied`',
    `fsa_rollover_amount` DECIMAL(18,2) COMMENT 'Dollar amount of unused FSA funds rolled over from the prior plan year under IRS rollover provisions. Applicable only to FSA plan type enrollments. Expressed in USD.',
    `group_number` STRING COMMENT 'Insurance group number assigned by the carrier to Sports Entertainments benefit plan. Used on insurance cards and for carrier eligibility file transmissions (HIPAA 834).',
    `hsa_contribution_limit` DECIMAL(18,2) COMMENT 'IRS-mandated annual contribution limit applicable to this employees HSA enrollment based on coverage tier (self-only vs. family) and age (catch-up contributions for age 55+). Stored for compliance validation against annual_election_amount. Expressed in USD.',
    `is_aca_eligible` BOOLEAN COMMENT 'Indicates whether the employee meets the ACA employer mandate eligibility threshold (typically 30+ hours per week for 120+ days). Drives IRS Form 1095-C reporting obligations for Sports Entertainment as an Applicable Large Employer (ALE).',
    `is_tobacco_user` BOOLEAN COMMENT 'Indicates whether the employee self-reported as a tobacco user during enrollment. Affects premium surcharge calculations for medical plans under ACA wellness program rules. True = tobacco user; False = non-tobacco user.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit enrollment record was most recently updated in the SAP SuccessFactors Benefits system. Used for incremental data pipeline processing and change audit tracking.',
    `per_pay_period_deduction` DECIMAL(18,2) COMMENT 'Employees benefit premium deduction amount per payroll cycle. Derived from the annual employee contribution divided by the number of pay periods; stored here as the operational payroll deduction value. Expressed in USD.',
    `plan_type` STRING COMMENT 'Category of benefit plan elected by the employee. Covers medical, dental, vision, retirement savings (401k), life insurance, disability, Flexible Spending Account (FSA), Health Savings Account (HSA), and Employee Assistance Program (EAP). [ENUM-REF-CANDIDATE: medical|dental|vision|401k|life_insurance|disability|fsa|hsa|eap — promote to reference product]',
    `plan_year` STRING COMMENT 'Calendar or fiscal year for which this benefit enrollment is in effect (e.g., 2024). Used for annual benefits cost reporting, ACA employer mandate compliance, and year-over-year total rewards analysis.',
    `qualifying_life_event_date` DATE COMMENT 'Date on which the qualifying life event occurred that triggered the mid-year enrollment change. Required for IRS compliance validation of the 30/60-day election window.',
    `qualifying_life_event_type` STRING COMMENT 'Type of qualifying life event (QLE) that triggered a mid-year enrollment change outside of open enrollment. Applicable only when enrollment_source is qualifying_life_event. [ENUM-REF-CANDIDATE: marriage|divorce|birth|adoption|death|loss_of_coverage|relocation|other — promote to reference product]',
    `retirement_contribution_rate` DECIMAL(18,2) COMMENT 'Employees elected contribution rate as a percentage of gross pay for 401k or other retirement savings plan enrollment. Stored as a decimal (e.g., 0.0600 = 6%). Applicable only to retirement plan type enrollments.',
    `safe_harbor_code` STRING COMMENT 'IRS-defined safe harbor code for ACA Form 1095-C Line 16 reporting, indicating the reason an employer shared responsibility payment may not apply (e.g., employee not employed, enrolled in coverage, not full-time). Values correspond to IRS ACA safe harbor codes (2A through 2F).. Valid values are `2A|2B|2C|2D|2E|2F`',
    `termination_date` DATE COMMENT 'Date on which the benefit coverage ends for the employee. Populated upon voluntary waiver, employment termination, or plan discontinuation. Null for currently active enrollments.',
    `waiver_reason` STRING COMMENT 'Reason provided by the employee for waiving (opting out of) a benefit plan. Required for ACA minimum essential coverage (MEC) compliance tracking and workforce analytics. Populated only when enrollment_status is waived. [ENUM-REF-CANDIDATE: covered_by_spouse|covered_by_parent|other_employer_coverage|military_coverage|medicare|medicaid|voluntary_waiver — promote to reference product]',
    `wellness_program_enrolled` BOOLEAN COMMENT 'Indicates whether the employee has enrolled in Sports Entertainments wellness program in conjunction with this benefit plan. Wellness participation may affect premium discounts under ACA-compliant wellness incentive programs.',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Employee benefits enrollment record capturing elected benefit plans for each workforce member at Sports Entertainment. Tracks benefit plan type (medical, dental, vision, 401k, life insurance, disability, FSA, HSA, EAP), coverage tier (employee only, employee+spouse, family), enrollment effective date, annual election amount, employer contribution, employee contribution, and open enrollment period. Sourced from SAP SuccessFactors Benefits. Supports benefits cost reporting, ACA compliance, and total rewards analysis.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique system-generated identifier for each leave and absence request record in SAP SuccessFactors Time and Attendance. Primary key for the leave_request data product.',
    `employee_id` BIGINT COMMENT 'Reference to the workforce employee record of the direct manager or HR delegate responsible for approving or denying this leave request. Used for approval workflow routing and absence accountability.',
    `employment_contract_id` BIGINT COMMENT 'Foreign key linking to workforce.employment_contract. Business justification: Leave entitlements — FMLA eligibility, paid leave treatment, CBA-governed leave provisions — are defined in the employment contract. Linking leave_request.employment_contract_id → employment_contract.',
    `employment_event_id` BIGINT COMMENT 'Reference to a specific sports or entertainment event in the event domain that this leave request may impact. Populated when the leave overlaps with a scheduled event requiring the employees role (e.g., game day, concert, broadcast). Supports event staffing gap identification.',
    `fixture_id` BIGINT COMMENT 'Reference to a specific sports or entertainment event in the event domain that this leave request may impact. Populated when the leave overlaps with a scheduled event requiring the employees role (e.g., game day, concert, broadcast). Supports event staffing gap identification.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: leave_request stores department_code as a denormalized string. Replacing with org_unit_id → org_unit.org_unit_id normalizes the organizational context of the leave, enabling org-level absence reportin',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: leave_request currently stores job_position_code as a denormalized string. Replacing with position_id → position.position_id normalizes the position reference, enabling leave impact analysis by positi',
    `primary_leave_employee_id` BIGINT COMMENT 'Reference to the workforce employee record in SAP SuccessFactors for whom this leave request is submitted. Links to the employee master in the workforce domain.',
    `tertiary_leave_backfill_employee_id` BIGINT COMMENT 'Reference to the workforce employee record of the individual assigned to cover the absent employees duties during the leave period. Null if no backfill has been assigned or if backfill_required = False.',
    `ada_accommodation_required` BOOLEAN COMMENT 'Indicates whether the leave request is associated with an ADA reasonable accommodation request. True = ADA accommodation process initiated; False = no ADA accommodation required. Triggers the interactive process with HR and legal for venue and operational role accommodations.',
    `approval_date` DATE COMMENT 'The calendar date on which the approving manager or HR delegate formally approved or denied the leave request. Used to measure approval turnaround time and ensure timely FMLA designation notice (within 5 business days of sufficient information).',
    `approval_status` STRING COMMENT 'Current workflow state of the leave request through the HR approval lifecycle. PENDING indicates awaiting manager action; APPROVED indicates authorized absence; DENIED indicates rejected by manager or HR; CANCELLED indicates voided before start; IN_REVIEW indicates escalated to HR; WITHDRAWN indicates employee-initiated cancellation.. Valid values are `PENDING|APPROVED|DENIED|CANCELLED|IN_REVIEW|WITHDRAWN`',
    `approved_days` DECIMAL(18,2) COMMENT 'Total number of calendar or working days approved for this leave request, expressed as a decimal to accommodate partial-day approvals. Used for absence trend analysis, payroll deduction calculations, and FMLA entitlement tracking (12-week annual cap).',
    `approved_hours` DECIMAL(18,2) COMMENT 'Total number of hours approved for this leave request. Used for intermittent FMLA tracking (where leave is taken in hourly increments), part-time employee proration, and event-day comp time calculations for broadcast crews and event staff.',
    `backfill_required` BOOLEAN COMMENT 'Indicates whether a temporary replacement or backfill resource must be sourced to cover the employees responsibilities during the leave period. True = backfill needed; False = coverage not required. Triggers workforce planning and contingent labor procurement workflows.',
    `cba_agreement_code` STRING COMMENT 'Identifier of the applicable Collective Bargaining Agreement governing the employees leave entitlements and conditions. Null for non-union employees. Ensures leave terms are applied per the correct union contract (e.g., broadcast crew union, venue operations union).',
    `certification_due_date` DATE COMMENT 'The deadline by which the employee must submit required medical certification documentation to HR. Typically 15 calendar days from the date HR requests certification per FMLA regulations. Null when certification is not required.',
    `cost_center_code` STRING COMMENT 'SAP S/4HANA Controlling cost center code associated with the employees organizational unit at the time of the leave request. Used for financial impact allocation of paid leave costs and absence-related overtime backfill expenses.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this leave request record was first created in the Silver Layer data product. Serves as the RECORD_AUDIT_CREATED timestamp for data lineage and audit trail purposes.',
    `denial_reason` STRING COMMENT 'Free-text or coded explanation provided by the approving manager or HR when a leave request is denied. Null when approval_status is not DENIED. Required for CBA grievance defense and FMLA interference claim mitigation. [ENUM-REF-CANDIDATE: INSUFFICIENT_NOTICE|INSUFFICIENT_DOCUMENTATION|OPERATIONAL_NEED|INELIGIBLE|DUPLICATE_REQUEST|POLICY_VIOLATION — promote to reference product]',
    `employee_notes` STRING COMMENT 'Free-text notes entered by the employee at the time of submission providing additional context for the leave request. Confidential HR data. Must not contain PHI (medical details should be captured via formal certification process only). Restricted to HR and the approving manager.',
    `employee_work_schedule` STRING COMMENT 'Work schedule classification of the employee at the time of the leave request. Determines applicable leave entitlements, proration rules, and staffing gap impact. Covers full-time staff, part-time event crew, broadcast crews, league officials, and seasonal workers per the workforce domain scope.. Valid values are `FULL_TIME|PART_TIME|SEASONAL|EVENT_DAY|BROADCAST_CREW|ON_CALL`',
    `fmla_designation_notice_date` DATE COMMENT 'The date on which HR issued the FMLA Designation Notice (WH-382) to the employee, confirming whether the leave qualifies as FMLA-protected. Must be issued within 5 business days of receiving sufficient information per DOL regulations. Null for non-FMLA leave types.',
    `fmla_hours_used` DECIMAL(18,2) COMMENT 'Cumulative FMLA-designated hours consumed by this specific leave request against the employees annual 480-hour (12-week) FMLA entitlement. Populated only when is_fmla_eligible = True. Used for FMLA entitlement balance tracking and DOL compliance reporting.',
    `hr_notes` STRING COMMENT 'Free-text notes entered by HR personnel during the review and processing of the leave request. May include documentation status, escalation notes, or compliance observations. Confidential HR data restricted to HR personnel only.',
    `is_fmla_eligible` BOOLEAN COMMENT 'Indicates whether the employee meets FMLA eligibility criteria at the time of the request: employed for at least 12 months, worked 1,250 hours in the prior 12 months, and works at a location with 50+ employees within 75 miles. True = eligible; False = not eligible. Drives FMLA compliance reporting.',
    `is_intermittent` BOOLEAN COMMENT 'Indicates whether this leave is taken intermittently (in separate blocks of time or by reducing the normal work schedule) rather than as a continuous absence. True = intermittent leave; False = continuous leave. Intermittent FMLA requires separate hourly tracking and is common for chronic conditions among event-day staff.',
    `is_paid` BOOLEAN COMMENT 'Indicates whether the approved leave is compensated (paid) or uncompensated (unpaid). True = paid leave; False = unpaid leave. Drives payroll processing in SAP SuccessFactors and determines whether PTO balance is decremented.',
    `jury_duty_court_name` STRING COMMENT 'Name of the court or tribunal issuing the jury summons for jury duty leave requests. Null for non-jury-duty leave types. Used to validate the legitimacy of the jury duty claim and for payroll differential calculations.',
    `leave_end_date` DATE COMMENT 'The last calendar date on which the employee is scheduled to be absent under this leave request. Null for open-ended leaves pending medical certification. Used to calculate approved leave duration and plan workforce coverage.',
    `leave_reason` STRING COMMENT 'General business reason or description provided by the employee for the leave request. Kept at a high level to avoid PHI exposure (e.g., personal medical, family care, military deployment). Confidential HR data restricted to HR personnel and the approving manager. [ENUM-REF-CANDIDATE: PERSONAL_MEDICAL|FAMILY_CARE|MILITARY_DEPLOYMENT|BEREAVEMENT|CIVIC_DUTY|PARENTAL_BONDING|PERSONAL — promote to reference product]',
    `leave_start_date` DATE COMMENT 'The first calendar date on which the employee is scheduled to be absent under this leave request. Used for event staffing gap analysis and payroll processing.',
    `leave_type` STRING COMMENT 'Classification of the leave category as defined by HR policy and applicable labor law. Values include: FMLA (Family and Medical Leave Act), PTO (Paid Time Off), SICK, BEREAVEMENT, JURY_DUTY, MILITARY, PARENTAL, COMP_TIME (event-day compensatory time). Drives eligibility rules, pay treatment, and regulatory reporting. [ENUM-REF-CANDIDATE: FMLA|PTO|SICK|BEREAVEMENT|JURY_DUTY|MILITARY|PARENTAL|COMP_TIME — 8 candidates stripped; promote to reference product]',
    `medical_certification_received` BOOLEAN COMMENT 'Indicates whether the required medical certification documentation has been received and accepted by HR. True = received; False = pending or not received. Used to track FMLA compliance deadlines (employee has 15 calendar days to provide certification).',
    `medical_certification_required` BOOLEAN COMMENT 'Indicates whether a medical certification form (e.g., FMLA WH-380-E or WH-380-F) is required to support this leave request. True = certification required; False = not required. Drives HR compliance workflow and document collection tracking.',
    `military_order_number` STRING COMMENT 'Official military deployment order number provided by the employee to support a military leave request under USERRA (Uniformed Services Employment and Reemployment Rights Act). Null for non-military leave types. Confidential HR document reference.',
    `pay_treatment` STRING COMMENT 'Specifies the compensation treatment applied during the leave period. FULL_PAY = 100% salary continuation; PARTIAL_PAY = reduced pay per policy or CBA; UNPAID = no compensation; STD = Short-Term Disability benefit; LTD = Long-Term Disability benefit. Used by payroll to apply correct earnings codes.. Valid values are `FULL_PAY|PARTIAL_PAY|UNPAID|STD|LTD`',
    `phased_return_plan` BOOLEAN COMMENT 'Indicates whether the employee has an approved phased or gradual return-to-work plan following the leave (e.g., reduced hours for first two weeks). True = phased return approved; False = full-duty return. Common for medical and parental leave returns in sports operations.',
    `pto_hours_deducted` DECIMAL(18,2) COMMENT 'Number of accrued PTO hours deducted from the employees PTO balance for this leave request. Applicable when leave type is PTO or when employer requires concurrent PTO usage during FMLA leave. Feeds into SAP SuccessFactors leave balance management.',
    `request_date` DATE COMMENT 'The calendar date on which the employee formally submitted the leave request. Used to measure advance notice compliance per CBA and FMLA notice requirements (typically 30-day advance notice for foreseeable leave).',
    `request_number` STRING COMMENT 'Externally visible, human-readable business identifier for the leave request, formatted as LR-{YEAR}-{SEQUENCE}. Used in employee communications, manager approvals, and FMLA compliance documentation.. Valid values are `^LR-[0-9]{4}-[0-9]{6}$`',
    `return_to_work_date` DATE COMMENT 'The confirmed or expected calendar date on which the employee is scheduled to return to active duty following the leave. May differ from leave_end_date + 1 due to weekends, holidays, or phased return arrangements. Critical for event staffing and broadcast crew scheduling.',
    `source_system_record_code` STRING COMMENT 'The native record identifier assigned by SAP SuccessFactors Time and Attendance to this leave request. Preserved for data lineage, reconciliation, and bi-directional sync between the Silver Layer and the system of record.',
    `submitted_timestamp` TIMESTAMP COMMENT 'The precise date and time (with timezone) at which the employee submitted the leave request in SAP SuccessFactors. Serves as the authoritative BUSINESS_EVENT_TIMESTAMP for this transaction and is used to enforce advance notice compliance windows.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this leave request record was most recently modified in the Silver Layer data product. Serves as the RECORD_AUDIT_UPDATED timestamp for change tracking, incremental ETL processing, and audit compliance.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Employee leave and absence request record managing all time-off events at Sports Entertainment. Captures leave type (FMLA, PTO, sick, bereavement, jury duty, military, parental, event-day comp time), request date, leave start date, leave end date, approved hours/days, approval status, approving manager, FMLA eligibility flag, intermittent leave flag, and return-to-work date. Sourced from SAP SuccessFactors Time and Attendance. Supports FMLA compliance, absence trend analysis, and event staffing gap identification.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` (
    `shift_assignment_id` BIGINT COMMENT 'Unique surrogate identifier for each shift assignment record in the workforce time and attendance system. Primary key for the shift_assignment data product sourced from SAP SuccessFactors Time and Attendance.',
    `production_id` BIGINT COMMENT 'Foreign key linking to broadcast.production. Business justification: Broadcast crew shift assignments must reference the specific production to support labor cost allocation per production, union call-sheet compliance, and payroll broadcast_differential_amount reconcil',
    `contingent_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.contingent_worker. Business justification: Contingent workers (event crew, broadcast crews, seasonal staff) are assigned to shifts just as employees are. shift_assignment currently only has employee_id for the worker. Adding contingent_worker_',
    `cost_center_id` BIGINT COMMENT 'Reference to the SAP S/4HANA Controlling (CO) cost center to which this shifts labor cost is allocated. Supports financial reporting and EBITDA analysis by department.',
    `credential_assignment_id` BIGINT COMMENT 'Foreign key linking to security.credential_assignment. Business justification: Security officer shift assignments must be verified against active credential assignments for the same event. This link supports the pre-shift credential verification workflow, enabling supervisors to',
    `employee_id` BIGINT COMMENT 'Reference to the employee assigned to this shift. Links to the workforce employee master record in SAP SuccessFactors. Supports PARTY_REFERENCE requirement for TRANSACTION_HEADER role.',
    `event_fixture_id` BIGINT COMMENT 'Reference to the sports or entertainment event associated with this shift assignment. Nullable for non-event shifts (e.g., office or maintenance shifts). Enables event-level staffing labor cost tracking.',
    `fixture_id` BIGINT COMMENT 'Reference to the sports or entertainment event associated with this shift assignment. Nullable for non-event shifts (e.g., office or maintenance shifts). Enables event-level staffing labor cost tracking.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Shift labor costs (labor_cost_amount field exists) post to specific GL accounts (wages expense, event-day premium, overtime). Sports venue operations require GL account assignment per shift for accura',
    `position_id` BIGINT COMMENT 'Reference to the organizational position or job role the employee is fulfilling during this shift (e.g., Event Coordinator, Broadcast Technician, Venue Security Officer). Drives role-based labor cost allocation.',
    `retail_location_id` BIGINT COMMENT 'Foreign key linking to merchandise.retail_location. Business justification: Retail merchandise staff shifts are assigned to specific store/kiosk/pop-up locations for labor scheduling, sales-per-labor-hour reporting, and event-day staffing plans. `assigned_location` is a plain',
    `staffing_plan_id` BIGINT COMMENT 'Foreign key linking to security.security_staffing_plan. Business justification: Individual security officer shift assignments must be traceable to the event-level security staffing plan they fulfill. This link enables plan-vs-actual headcount reporting, SLA fill-rate tracking aga',
    `venue_id` BIGINT COMMENT 'Reference to the venue or facility where the shift is performed. Used for venue-level labor cost tracking and OSHA hours-of-service compliance reporting.',
    `actual_end_time` TIMESTAMP COMMENT 'Actual clock-out timestamp recorded when the employee ended the shift. Used to calculate actual hours worked, overtime determination, and FLSA audit trails. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `actual_hours_worked` DECIMAL(18,2) COMMENT 'Total compensable hours worked during the shift after deducting unpaid break time. Feeds directly into payroll processing. Supports FLSA audit trails and CBA overtime compliance calculations.',
    `actual_start_time` TIMESTAMP COMMENT 'Actual clock-in timestamp recorded when the employee began the shift, captured via time clock, mobile check-in, or supervisor entry in SAP SuccessFactors. Used for FLSA audit trails and tardiness tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `assigned_location` STRING COMMENT 'Specific location within the venue or facility where the employee is assigned during the shift (e.g., Gate 4 Entry, Press Box Level 3, Broadcast Truck Bay 2, Main Office Floor 5). Supports venue operations management and OSHA safety compliance.',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the shift assignment. scheduled = shift planned but not yet started; confirmed = employee acknowledged; in_progress = shift actively underway; completed = shift finished and time recorded; cancelled = shift removed before start; no_show = employee did not report. Drives payroll processing and CBA compliance workflows.. Valid values are `scheduled|confirmed|in_progress|completed|cancelled|no_show`',
    `break_deduction_hours` DECIMAL(18,2) COMMENT 'Total unpaid break time deducted from gross hours to arrive at compensable actual hours worked. Includes meal breaks and rest periods per FLSA and applicable state labor laws.',
    `cba_rule_code` STRING COMMENT 'Code identifying the specific Collective Bargaining Agreement (CBA) provision or rule set applied to this shift for pay calculation (e.g., overtime thresholds, rest period requirements, event-day premiums). Critical for union labor compliance and grievance resolution.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shift assignment record was first created in SAP SuccessFactors Time and Attendance. Provides audit trail for record provenance and SOX financial controls. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the hourly rate and labor cost amounts on this shift record (e.g., USD, GBP, EUR). Supports multi-currency payroll for international league operations.. Valid values are `^[A-Z]{3}$`',
    `double_time_hours` DECIMAL(18,2) COMMENT 'Hours worked at 2x the regular pay rate, typically triggered by CBA provisions for extended shifts, consecutive days worked, or specific event-day conditions. Feeds into payroll processing and labor cost reporting.',
    `event_day_premium_hours` DECIMAL(18,2) COMMENT 'Hours eligible for event-day premium pay as defined in CBA agreements for staff working live sports or entertainment events. Distinct from standard overtime; reflects sports-entertainment industry-specific compensation structures.',
    `flsa_exemption_status` STRING COMMENT 'FLSA exemption classification for the employee on this shift. Determines whether overtime pay provisions apply. non_exempt employees are entitled to FLSA overtime protections; exempt categories are not. Required for FLSA audit trail compliance.. Valid values are `non_exempt|exempt_executive|exempt_administrative|exempt_professional`',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Employees base hourly compensation rate applicable to this shift in local currency. Used as the base for regular, overtime, and double-time pay calculations. Classified as confidential financial data.',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'Total gross labor cost for this shift assignment calculated as actual hours worked multiplied by applicable pay rates (regular + overtime + double-time + premiums). Feeds event staffing labor cost tracking and EBITDA reporting via SAP S/4HANA CO.',
    `manager_approval_status` STRING COMMENT 'Current approval workflow status of the timesheet for this shift. pending = awaiting manager review; approved = manager confirmed hours; rejected = returned for correction; escalated = routed to HR or payroll for exception handling. Required for payroll processing gate.. Valid values are `pending|approved|rejected|escalated`',
    `manager_approval_timestamp` TIMESTAMP COMMENT 'Date and time when the manager approved or rejected the timesheet for this shift. Provides audit trail for SOX financial controls and payroll processing compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `no_show_flag` BOOLEAN COMMENT 'Indicates whether the employee failed to report for a scheduled shift without prior notification. True when assignment_status = no_show. Triggers HR attendance management workflows and may affect CBA disciplinary provisions.',
    `on_call_hours` DECIMAL(18,2) COMMENT 'Hours the employee was designated on-call and available for deployment, compensated per CBA on-call provisions. Common for broadcast crews, medical staff, and event operations personnel.',
    `osha_hours_of_service_flag` BOOLEAN COMMENT 'Indicates whether this shift triggers an OSHA hours-of-service review due to extended duration, insufficient rest between shifts, or hazardous work environment conditions. True when OSHA thresholds are approached or exceeded.',
    `overtime_flag` BOOLEAN COMMENT 'Indicates whether this shift contains overtime hours requiring premium pay calculation. True when overtime_hours > 0. Used as a quick filter for CBA overtime compliance reporting and payroll exception management.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Hours worked beyond the standard threshold (typically 8 hours/day or 40 hours/week) compensated at 1.5x the regular rate per FLSA and CBA provisions. Critical for payroll accuracy and CBA overtime compliance reporting.',
    `pay_grade_code` STRING COMMENT 'Pay grade or compensation band code applicable to the employee for this shift, sourced from SAP SuccessFactors compensation management. Determines base hourly rate for payroll calculation. Classified as confidential business data.',
    `payroll_period` STRING COMMENT 'Payroll period identifier to which this shift record is assigned for compensation processing (e.g., 2024-11-W2 for bi-weekly or 2024-11-M for monthly). Aligns with SAP S/4HANA payroll run cycles.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])-(W[1-4]|M)$`',
    `payroll_processing_status` STRING COMMENT 'Status of this shift record within the payroll processing pipeline. not_submitted = pending manager approval; submitted = sent to payroll; processed = included in payroll run; on_hold = flagged for manual review; error = processing failure requiring correction. Feeds SAP S/4HANA FI payroll integration.. Valid values are `not_submitted|submitted|processed|on_hold|error`',
    `regular_hours` DECIMAL(18,2) COMMENT 'Hours worked at the standard straight-time pay rate, not exceeding the CBA or FLSA threshold for overtime. Component of the pay calculation triplet (regular + overtime + double-time = actual hours worked).',
    `role_during_shift` STRING COMMENT 'Specific functional role the employee performs during this shift (e.g., Head Usher, Broadcast Director, Security Supervisor, Concessions Lead). May differ from the employees primary position for cross-trained or flex-deployed staff.',
    `scheduled_end_time` TIMESTAMP COMMENT 'Planned end date and time of the shift as defined in the workforce schedule. Used to calculate scheduled hours, identify overtime risk, and plan event-day crew rotations. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `scheduled_hours` DECIMAL(18,2) COMMENT 'Total number of hours the employee is scheduled to work during this shift, derived from scheduled start and end times minus planned breaks. Used for pre-event labor cost forecasting and CBA compliance checks.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Planned start date and time of the shift as defined in the workforce schedule. Used for scheduling conflict detection, CBA minimum rest period compliance, and event-day staffing coordination. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `shift_date` DATE COMMENT 'Calendar date on which the shift is scheduled or was worked. Used as the primary date dimension for workforce scheduling, payroll period alignment, and event-day staffing reports. Format: yyyy-MM-dd.',
    `shift_notes` STRING COMMENT 'Free-text notes entered by the employee or manager regarding this shift assignment (e.g., early departure reason, equipment issues, special event conditions). Supports exception management and HR documentation.',
    `shift_reference_number` STRING COMMENT 'Externally-known business identifier for the shift assignment, generated by SAP SuccessFactors Time and Attendance. Used in payroll processing, manager communications, and audit trails. Format: SHF-YYYYMMDD-XXXXXX.. Valid values are `^SHF-[0-9]{8}-[A-Z0-9]{6}$`',
    `shift_type` STRING COMMENT 'Classification of the shift by operational context. event_day = live sports/entertainment event staffing; broadcast = OB (Outside Broadcast) or studio production crew; venue_operations = facility maintenance and operations; office = administrative/back-office; overnight = overnight security or facility shift. Drives premium pay eligibility and CBA rule application.. Valid values are `event_day|broadcast|venue_operations|office|overnight`',
    `timesheet_submission_date` DATE COMMENT 'Date on which the employee submitted the timesheet for this shift in SAP SuccessFactors. Used to track submission timeliness, enforce payroll cutoff deadlines, and audit late submissions.',
    `travel_time_hours` DECIMAL(18,2) COMMENT 'Compensable travel time hours recorded for employees traveling to away events, broadcast locations, or multi-venue assignments per FLSA and CBA travel pay provisions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the shift assignment record in SAP SuccessFactors. Used for incremental data pipeline processing, change detection, and audit trail maintenance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `worker_category` STRING COMMENT 'Classification of the worker type for this shift assignment. Determines applicable CBA provisions, benefit eligibility, and payroll processing rules. [ENUM-REF-CANDIDATE: full_time|part_time|seasonal|event_crew|broadcast_crew|league_official — promote to reference product]. Valid values are `full_time|part_time|seasonal|event_crew|broadcast_crew|league_official`',
    CONSTRAINT pk_shift_assignment PRIMARY KEY(`shift_assignment_id`)
) COMMENT 'Workforce time and attendance record capturing both scheduled shifts and actual hours worked at Sports Entertainment events, venues, and broadcast operations. For scheduling: shift date, start/end time, shift type (event-day, broadcast, venue operations, office, overnight), assigned location, role during shift, scheduled hours. For time reporting: actual hours worked, regular/overtime/double-time breakdown, event-day premium hours, on-call hours, travel time, break deductions. Workflow: timesheet submission date, manager approval status, payroll processing status, overtime flag, no-show flag. Sourced from SAP SuccessFactors Time and Attendance. Feeds directly into payroll processing and supports CBA overtime compliance, FLSA audit trails, OSHA hours-of-service compliance, and event staffing labor cost tracking.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique surrogate identifier for each performance review record in the Sports Entertainment workforce system. Primary key for the performance_review data product.',
    `development_plan_id` BIGINT COMMENT 'Reference to the Individual Development Plan (IDP) created in SAP SuccessFactors as a follow-up action from this performance review, capturing learning and growth objectives.',
    `employee_id` BIGINT COMMENT 'Reference to the direct manager or supervisor who authored and submitted the performance review for the employee.',
    `hr_business_partner_employee_id` BIGINT COMMENT 'Reference to the HR Business Partner responsible for overseeing the review process for this employees department or business unit.',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: In sports entertainment, employee performance reviews for analytics, commercial, and operations staff are explicitly tied to KPI definitions (e.g., ticket revenue KPI, broadcast rating KPI). Linking e',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: performance_review stores department_code as a denormalized string. Replacing with org_unit_id → org_unit.org_unit_id normalizes the organizational context of the review, enabling org-level talent ana',
    `primary_performance_employee_id` BIGINT COMMENT 'Reference to the employee whose performance is being evaluated. Links to the workforce employee master record in SAP SuccessFactors.',
    `position_id` BIGINT COMMENT 'Reference to the organizational position held by the employee at the time of the review, capturing role context for succession planning.',
    `review_form_id` BIGINT COMMENT 'Reference to the performance review form template used for this evaluation cycle, as configured in SAP SuccessFactors.',
    `tertiary_performance_hr_business_partner_employee_id` BIGINT COMMENT 'Reference to the HR Business Partner responsible for overseeing the review process for this employees department or business unit.',
    `acknowledged_date` DATE COMMENT 'The date on which the employee formally acknowledged receipt and review of their completed performance evaluation in SAP SuccessFactors.',
    `business_unit_code` STRING COMMENT 'The business unit or division code of the employee at the time of the review (e.g., League Operations, Venue Management, Broadcast, Fan Engagement). Supports cross-unit talent analytics.',
    `calibrated_rating` DECIMAL(18,2) COMMENT 'The final performance rating after HR calibration session adjustments. May differ from the managers original overall_rating if the calibration panel modified the score.',
    `calibration_date` DATE COMMENT 'The date on which the performance rating was reviewed and validated in an HR calibration session to ensure consistency and fairness across the organization.',
    `calibration_status` STRING COMMENT 'Indicates the current state of the HR calibration process for this review. Calibration ensures rating consistency across departments and business units within Sports Entertainment.. Valid values are `not_required|pending|in_session|calibrated|overridden`',
    `competency_rating` DECIMAL(18,2) COMMENT 'Numeric rating reflecting the employees demonstrated behavioral competencies (e.g., leadership, collaboration, communication, innovation) as assessed by the manager during the review period.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the performance review record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `development_gap_assessment` STRING COMMENT 'Free-text or structured narrative describing the competency and skill gaps the employee must address to be ready for the succession target position or next career level.',
    `goal_achievement_rating` DECIMAL(18,2) COMMENT 'Numeric rating reflecting the degree to which the employee achieved their defined performance goals and Key Performance Indicators (KPIs) during the review period.',
    `is_cba_covered` BOOLEAN COMMENT 'Indicates whether the employee is covered by a Collective Bargaining Agreement (CBA) at the time of the review. CBA-covered employees may have specific review process requirements and rating constraints.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent update to the performance review record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports change tracking and audit compliance.',
    `manager_comments` STRING COMMENT 'Free-text narrative provided by the reviewing manager summarizing the employees performance, strengths, development areas, and behavioral observations during the review period.',
    `merit_increase_pct` DECIMAL(18,2) COMMENT 'The recommended merit salary increase percentage for the employee based on their performance rating. Expressed as a percentage of current base salary. Confidential compensation data.',
    `merit_increase_recommended` BOOLEAN COMMENT 'Indicates whether the employee is recommended for a merit-based salary increase based on their performance rating outcome. Feeds into the compensation planning cycle.',
    `nine_box_placement` STRING COMMENT 'The employees placement on the 9-box talent grid (performance vs. potential matrix) as determined during the calibration session. Used for succession planning and talent pipeline segmentation. [ENUM-REF-CANDIDATE: high_performer_high_potential|high_performer_medium_potential|high_performer_low_potential|medium_performer_high_potential|medium_performer_medium_potential|medium_performer_low_potential|low_performer_high_potential|low_performer_medium_potential|low_performer_low_potential — promote to reference product]',
    `overall_rating` DECIMAL(18,2) COMMENT 'The final composite performance rating assigned to the employee for the review period, expressed on a numeric scale (e.g., 1.00–5.00). Drives merit increase eligibility and succession planning decisions.',
    `overall_rating_label` STRING COMMENT 'Descriptive label corresponding to the overall numeric performance rating. Used in HR communications, talent reviews, and succession planning discussions.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `pip_flag` BOOLEAN COMMENT 'Indicates whether the employee has been placed on a formal Performance Improvement Plan (PIP) as an outcome of this review. Triggers specific HR workflow and CBA-governed notification obligations.',
    `promotion_recommended` BOOLEAN COMMENT 'Indicates whether the reviewing manager has formally recommended the employee for promotion as part of this performance review cycle.',
    `readiness_tier` STRING COMMENT 'Indicates the employees assessed readiness to assume the succession target position. Used in talent pipeline planning: ready_now (immediate successor), one_to_two_years (near-term development), three_plus_years (long-term pipeline), not_ready (not currently a viable successor).. Valid values are `ready_now|one_to_two_years|three_plus_years|not_ready`',
    `retention_risk_rating` STRING COMMENT 'HR assessment of the likelihood that the employee may voluntarily leave the organization. Informs targeted retention strategies and succession urgency planning for critical roles.. Valid values are `low|medium|high|critical`',
    `review_cycle_year` STRING COMMENT 'The calendar or fiscal year of the performance review cycle (e.g., 2024). Used for year-over-year talent analytics, merit budget planning, and succession pipeline reporting.',
    `review_due_date` DATE COMMENT 'The deadline by which the manager must complete and submit the performance review. Used for HR compliance tracking and escalation workflows.',
    `review_number` STRING COMMENT 'Externally visible business identifier for the performance review record, formatted as PR-{YEAR}-{SEQUENCE}. Used for cross-system reference and HR correspondence.. Valid values are `^PR-[0-9]{4}-[0-9]{6}$`',
    `review_period_end_date` DATE COMMENT 'The last date of the performance evaluation period covered by this review. Defines the end boundary of the assessment window.',
    `review_period_start_date` DATE COMMENT 'The first date of the performance evaluation period covered by this review. Defines the start boundary of the assessment window.',
    `review_status` STRING COMMENT 'Current workflow lifecycle state of the performance review record within SAP SuccessFactors. Tracks progression from draft authoring through manager submission, HR calibration, approval, employee acknowledgement, and final closure. [ENUM-REF-CANDIDATE: draft|in_progress|pending_calibration|calibrated|approved|acknowledged|closed — promote to reference product]',
    `review_type` STRING COMMENT 'Classification of the review cycle type. Annual covers full-year evaluations; mid_year covers interim check-ins; probationary covers new hire assessments; event_season covers seasonal/event crew evaluations; pip_checkpoint covers Performance Improvement Plan (PIP) milestone reviews.. Valid values are `annual|mid_year|probationary|event_season|pip_checkpoint`',
    `self_assessment_comments` STRING COMMENT 'Free-text narrative authored by the employee reflecting on their own performance, accomplishments, challenges, and development goals during the review period.',
    `self_assessment_rating` DECIMAL(18,2) COMMENT 'Numeric rating the employee assigned to their own overall performance during the self-assessment phase of the review cycle. Used for calibration comparison against manager rating.',
    `source_system_record_code` STRING COMMENT 'The native record identifier from SAP SuccessFactors Performance & Goals module for this review record. Enables traceability and reconciliation between the lakehouse silver layer and the system of record.',
    `submitted_date` DATE COMMENT 'The date on which the manager formally submitted the completed performance review for HR processing and calibration.',
    `succession_nominated` BOOLEAN COMMENT 'Indicates whether the employee has been nominated as a successor for a critical or target position as part of the succession planning process linked to this review cycle.',
    `workforce_segment` STRING COMMENT 'Classification of the employees workforce category at the time of the review. Determines applicable review templates, CBA obligations, and rating scale configurations within SAP SuccessFactors.. Valid values are `full_time|part_time|seasonal|event_crew|broadcast_crew|league_official`',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Employee performance evaluation and talent succession record capturing formal review cycles and leadership pipeline planning at Sports Entertainment. For performance: tracks review period, review type (annual, mid-year, probationary, event-season), overall rating, competency ratings, goal achievement, manager comments, self-assessment, calibration status, PIP flag, promotion recommendation. For succession: captures target position for succession, readiness tier (ready now, 1-2 years, 3+ years), nominated successor, development gap assessment, retention risk rating. Sourced from SAP SuccessFactors Performance & Goals and Succession & Development. Drives merit increase decisions, succession planning, talent pipeline management, and critical role coverage.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` (
    `learning_enrollment_id` BIGINT COMMENT 'Unique surrogate identifier for each learning enrollment record in the SAP SuccessFactors Learning Management System (LMS). Primary key for the learning_enrollment data product.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Mandatory training programs fulfill specific regulatory obligations (OSHA safety training, CBA requirements, broadcast licensing). Linking learning_enrollment to compliance obligation enables obligati',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Training costs (training_cost field exists) are charged to cost centers for budget tracking. Sports organizations track mandatory safety, broadcast crew, and compliance training costs by department. c',
    `course_id` BIGINT COMMENT 'Reference to the course or learning program catalog item in the LMS. Identifies the specific training offering the employee is enrolled in.',
    `employee_id` BIGINT COMMENT 'Reference to the workforce employee record who is enrolled in this learning activity. Links to the employee master in SAP SuccessFactors HCM.',
    `performance_review_id` BIGINT COMMENT 'Foreign key linking to workforce.performance_review. Business justification: Performance reviews identify development gaps and trigger mandatory learning enrollments (development_gap_assessment, development_plan_id on performance_review). Linking learning_enrollment.performanc',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: learning_enrollment stores job_code as a denormalized string to indicate the role context of the training. Replacing with position_id → position.position_id normalizes this reference and enables posit',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to partner.vendor. Business justification: External training providers for LMS-tracked learning (broadcast skills, venue safety, fan engagement) are registered vendors. Linking enables training spend analytics by vendor, contract compliance tr',
    `attempt_number` STRING COMMENT 'Sequential attempt number for this enrollment, starting at 1. Increments when an employee re-attempts a course after a failed assessment. Used to track remediation patterns and compliance risk.',
    `cba_obligation_code` STRING COMMENT 'Reference code identifying the specific Collective Bargaining Agreement (CBA) clause or article that mandates this training. Null for non-CBA-required training. Critical for labor relations compliance reporting.',
    `completion_date` DATE COMMENT 'Calendar date on which the employee completed the learning activity. Null if not yet completed. Used for compliance deadline tracking and credential issuance.',
    `completion_timestamp` TIMESTAMP COMMENT 'Precise date and time when the employee completed the learning activity, including timezone offset. Used for exact compliance deadline calculations and audit trail purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this enrollment record was first created in the SAP SuccessFactors LMS. Used for audit trail and data lineage tracking.',
    `credential_expiry_date` DATE COMMENT 'Date on which the credential or certificate expires and must be renewed. Critical for venue access control, broadcast regulatory licensing, and OSHA compliance. Null for credentials with no expiry.',
    `credential_issue_date` DATE COMMENT 'Date on which the credential or certificate was formally issued by the issuing authority. Marks the start of the credential validity period.',
    `credential_number` STRING COMMENT 'Unique identifier assigned to the credential or certificate by the issuing authority upon successful completion. Used for verification and regulatory audit purposes.',
    `credential_renewal_status` STRING COMMENT 'Current renewal state of the credential. Drives automated alerts for upcoming expirations and supports venue access control decisions. Expired credentials may restrict employee access to regulated areas.. Valid values are `current|due_for_renewal|expired|renewed|not_applicable`',
    `credential_type` STRING COMMENT 'Type of credential or certification issued upon successful completion of this learning activity. Drives venue access control and regulatory licensing verification. [ENUM-REF-CANDIDATE: osha_10|osha_30|first_aid_cpr|broadcast_engineering_license|food_handler_permit|security_license|forklift_certification|ped_education — promote to reference product]. Valid values are `osha_10|osha_30|first_aid_cpr|broadcast_engineering_license|food_handler_permit|security_license`',
    `credential_verification_status` STRING COMMENT 'Status of third-party or issuing authority verification of the credential. Unverified or rejected credentials may block venue access or broadcast licensing. Supports audit and compliance reporting.. Valid values are `verified|pending_verification|unverified|rejected`',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the training cost amount (e.g., USD, GBP, EUR). Supports multi-currency reporting for global operations.. Valid values are `^[A-Z]{3}$`',
    `delivery_method` STRING COMMENT 'Method by which the learning activity is delivered to the employee. Determines scheduling, venue, and cost allocation. Instructor-led and on-the-job methods are common for OSHA and CBA safety training.. Valid values are `instructor_led|online_self_paced|virtual_classroom|on_the_job|blended|external_provider`',
    `department_code` STRING COMMENT 'Organizational department code of the employee at the time of enrollment, sourced from SAP SuccessFactors. Supports departmental compliance reporting and training budget allocation.',
    `due_date` DATE COMMENT 'Mandatory deadline by which the employee must complete the learning activity. Drives compliance alerts and escalation workflows for OSHA-required and CBA-mandated training.',
    `enrollment_date` DATE COMMENT 'Calendar date on which the employee was enrolled in the course or learning program. Used to calculate training deadlines and compliance windows.',
    `enrollment_number` STRING COMMENT 'Externally visible business identifier for this enrollment record, generated by SAP SuccessFactors LMS. Used in learner communications, compliance reports, and audit trails.. Valid values are `^ENR-[0-9]{8,12}$`',
    `enrollment_source` STRING COMMENT 'Indicates how the enrollment was initiated. Self-enrolled means the employee registered voluntarily; manager_assigned and hr_assigned indicate directed enrollment; system_auto_assigned covers automated compliance-driven enrollment; compliance_required covers regulatory mandate-driven enrollment.. Valid values are `self_enrolled|manager_assigned|system_auto_assigned|hr_assigned|compliance_required`',
    `enrollment_status` STRING COMMENT 'Current lifecycle state of the learning enrollment. Tracks progression from initial enrollment through completion or withdrawal. Supports OSHA compliance tracking and CBA training obligation reporting.. Valid values are `enrolled|in_progress|completed|failed|withdrawn|waitlisted`',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this enrollment is mandatory for the employee based on their role, job classification, or regulatory requirement (OSHA, CBA, FCC, GDPR, PCI-DSS). Mandatory enrollments trigger compliance escalation if not completed by the due date.',
    `is_recurrent` BOOLEAN COMMENT 'Indicates whether this training must be periodically renewed (e.g., annual OSHA refresher, biennial First Aid/CPR recertification). Drives automated re-enrollment scheduling.',
    `issuing_authority` STRING COMMENT 'Name of the organization or regulatory body that issued the credential or certificate (e.g., OSHA, American Red Cross, FCC, National Restaurant Association, WADA). Required for regulatory compliance verification.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this enrollment record was most recently modified in the SAP SuccessFactors LMS. Used for incremental data pipeline processing and audit trail.',
    `learning_type` STRING COMMENT 'Classification of the learning activity by its business purpose and regulatory driver. Mandatory compliance covers GDPR, PCI-DSS, and SOX training; CBA-required safety covers Collective Bargaining Agreement (CBA) obligations; broadcast certification covers FCC licensing requirements; OSHA certification covers Occupational Safety and Health Administration (OSHA) mandates.. Valid values are `mandatory_compliance|cba_required_safety|broadcast_certification|leadership_development|osha_certification`',
    `lms_source_code` STRING COMMENT 'Native identifier of this enrollment record in the SAP SuccessFactors Learning Management System (LMS). Enables traceability back to the system of record for reconciliation and audit purposes.',
    `max_attempts_allowed` STRING COMMENT 'Maximum number of assessment attempts permitted for this course enrollment before escalation or mandatory re-enrollment is triggered. Defined at the course level and copied to the enrollment for audit traceability.',
    `pass_fail_status` STRING COMMENT 'Assessment outcome for the learning activity. Pass status may trigger credential issuance or venue access rights. Fail status may trigger mandatory re-enrollment per OSHA or CBA requirements.. Valid values are `pass|fail|not_applicable|pending_assessment`',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the course assessment, expressed as a percentage. Defined at the course level and copied to the enrollment for audit traceability.',
    `recurrence_interval_months` STRING COMMENT 'Number of months between required renewals for recurrent training. For example, 12 for annual OSHA refresher or 24 for biennial CPR recertification. Null for non-recurrent training.',
    `score` DECIMAL(18,2) COMMENT 'Numeric score achieved by the employee on the course assessment, expressed as a percentage (0.00–100.00). Used to determine pass/fail outcome and to support competency analytics.',
    `start_date` DATE COMMENT 'Calendar date on which the employee began the learning activity. May differ from enrollment date for scheduled or instructor-led training.',
    `training_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for this enrollment, including registration fees, external provider fees, and materials. Denominated in the operating currency (USD). Used for workforce development budget tracking and cost allocation to business units.',
    `training_hours` DECIMAL(18,2) COMMENT 'Total number of hours of learning activity credited to the employee upon completion. Used for CBA training hour obligations, OSHA compliance reporting, and workforce development analytics.',
    `training_location` STRING COMMENT 'Physical venue or virtual platform where the training was delivered (e.g., venue name, city, or online platform URL). Relevant for instructor-led and on-the-job training sessions.',
    `worker_type` STRING COMMENT 'Classification of the employees workforce category at the time of enrollment. Determines applicable CBA training obligations and OSHA requirements. Event crew and broadcast crew have specific certification requirements.. Valid values are `full_time|part_time|seasonal|event_crew|broadcast_crew|league_official`',
    CONSTRAINT pk_learning_enrollment PRIMARY KEY(`learning_enrollment_id`)
) COMMENT 'Employee training, development, and credential management record at Sports Entertainment. Covers learning activities: course/program name, learning type (mandatory compliance, CBA-required safety, broadcast certification, leadership development, OSHA certification), enrollment/completion dates, pass/fail status, training hours, delivery method, cost. Covers credentials: credential type (OSHA 10/30, first aid/CPR, broadcast engineering license, food handler permit, security license, forklift certification), issuing authority, issue/expiration dates, renewal status, verification status. Sourced from SAP SuccessFactors Learning Management System. SSOT for all workforce competency, certification, and compliance training data. Supports OSHA compliance tracking, CBA training obligations, venue access control, and broadcast regulatory licensing.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` (
    `osha_incident_id` BIGINT COMMENT 'Unique system-generated identifier for each OSHA workplace safety incident record. Primary key for the osha_incident data product within the workforce domain.',
    `production_id` BIGINT COMMENT 'Foreign key linking to broadcast.production. Business justification: OSHA incidents during live broadcast productions (OB truck operations, camera rigging, RF equipment) must be attributed to the specific production for OSHA 300 log accuracy, production safety audits, ',
    `contingent_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.contingent_worker. Business justification: OSHA recordability requirements apply to all workers on-site, including contingent workers (freelancers, event crew, broadcast crews). osha_incident currently only has employee_id for the injured part',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: OSHA incidents generate workers compensation costs, medical expenses, and remediation costs charged to cost centers. Sports venue operators track incident costs by cost center for insurance reporting',
    `employee_id` BIGINT COMMENT 'SAP SuccessFactors employee identifier for the worker who was injured, became ill, or was involved in the near-miss incident. Links to the workforce master record for employment status, job role, and CBA classification.',
    `fixture_id` BIGINT COMMENT 'Identifier for the live sports or entertainment event in progress at the time of the incident, if the incident occurred on an event day. Null for non-event-day incidents. Enables correlation of safety incidents with specific events for post-event safety reviews.',
    `incident_report_id` BIGINT COMMENT 'Foreign key linking to compliance.incident_report. Business justification: OSHA workplace incidents must be escalated to compliance incident reports for OSHA 300 log filing and regulatory submission. Linking osha_incident to compliance incident_report supports the named regu',
    `injury_record_id` BIGINT COMMENT 'Foreign key linking to athlete.injury_record. Business justification: OSHA-recordable athlete injuries (flagged on injury_record.is_osha_recordable) require a corresponding OSHA incident log entry. Linking osha_incident to injury_record enables regulatory cross-referenc',
    `insurance_claim_id` BIGINT COMMENT 'Foreign key linking to legal.insurance_claim. Business justification: OSHA recordable incidents at sports venues directly generate workers comp and general liability insurance claims. Linking osha_incident to insurance_claim enables claims management, reserve setting, ',
    `litigation_case_id` BIGINT COMMENT 'Foreign key linking to legal.litigation_case. Business justification: Stadium and venue OSHA incidents (worker injuries during events, broadcast setup) routinely generate workers comp litigation or OSHA citation defense cases. Legal needs to link the incident record to',
    `matter_id` BIGINT COMMENT 'Foreign key linking to legal.legal_matter. Business justification: OSHA incidents trigger legal matters for regulatory citation response, OSHA 300 log compliance, and workers comp management. In-house counsel opens a legal_matter per significant incident; this FK en',
    `security_incident_id` BIGINT COMMENT 'Foreign key linking to security.security_incident. Business justification: Crowd-related injuries, assaults, and venue accidents generate both an OSHA recordable incident and a security incident report. Cross-referencing these records is required for OSHA 300 log accuracy, i',
    `shift_assignment_id` BIGINT COMMENT 'Foreign key linking to workforce.shift_assignment. Business justification: OSHA incidents occur during specific work shifts. Linking osha_incident.shift_assignment_id → shift_assignment.shift_assignment_id enables direct correlation between incidents and the shift context — ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to partner.vendor. Business justification: OSHA incidents at sports-entertainment venues frequently involve vendor personnel or vendor-supplied equipment. Regulatory reporting and liability management require tracking which vendor was involved',
    `venue_id` BIGINT COMMENT 'Identifier for the Sports Entertainment venue, broadcast site, or office location where the incident occurred. Supports venue-level safety performance reporting and OSHA establishment-level recordkeeping.',
    `amputation_flag` BOOLEAN COMMENT 'Indicates whether the incident resulted in an amputation. Amputations must be reported to OSHA within 24 hours per 29 CFR 1904.39. Triggers mandatory regulatory notification workflow.',
    `body_part_affected` STRING COMMENT 'The specific body part injured or affected by the illness, coded per OSHA BLS OIICS body part classification (e.g., head, neck, back, shoulder, hand, knee, foot). Required field on OSHA 300 Log. [ENUM-REF-CANDIDATE: head|neck|back|shoulder|arm|hand|trunk|leg|knee|foot|multiple|other — promote to reference product]',
    `corrective_action_completed_date` DATE COMMENT 'Actual date on which all corrective and preventive actions were verified as completed. Null if actions are still pending. Used to measure corrective action closure rate and safety program effectiveness.',
    `corrective_action_description` STRING COMMENT 'Description of the corrective and preventive actions taken or planned in response to the incident to eliminate or reduce the risk of recurrence. Includes engineering controls, administrative controls, and PPE measures.',
    `corrective_action_due_date` DATE COMMENT 'Target completion date for all corrective and preventive actions identified in the incident investigation. Tracks accountability and closure of safety improvement commitments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the OSHA incident record was first created in the system. Audit trail field supporting data lineage, compliance verification, and Silver layer ingestion tracking.',
    `days_away_from_work` STRING COMMENT 'Number of calendar days the injured or ill employee was away from work as a result of the incident. Required field on OSHA 300 Log column G. Used to calculate DART (Days Away, Restricted, or Transferred) rate.',
    `days_restricted_duty` STRING COMMENT 'Number of calendar days the employee was placed on restricted work activity or job transfer as a result of the incident. Required field on OSHA 300 Log column H. Combined with days_away_from_work to calculate DART rate.',
    `employment_type` STRING COMMENT 'Classification of the employees employment arrangement at the time of the incident. Relevant for CBA (Collective Bargaining Agreement) obligations, workers compensation eligibility, and OSHA recordkeeping applicability for contractors vs. direct employees.. Valid values are `full_time|part_time|seasonal|contractor|temporary|volunteer`',
    `establishment_name` STRING COMMENT 'The legal name of the Sports Entertainment establishment (venue, office, or broadcast facility) as registered with OSHA for recordkeeping purposes. Required on OSHA 300 Log header. May differ from the operational venue name.',
    `event_activity` STRING COMMENT 'Description of the work activity or task the employee was performing at the time of the incident (e.g., stage rigging, field maintenance, crowd management, broadcast equipment setup, merchandise stocking). Required for root cause analysis and corrective action planning.',
    `fatality_flag` BOOLEAN COMMENT 'Indicates whether the incident resulted in the death of the employee. Fatalities must be reported to OSHA within 8 hours of the employer learning of the death. Triggers mandatory regulatory notification workflow.',
    `hospitalization_flag` BOOLEAN COMMENT 'Indicates whether the incident resulted in in-patient hospitalization of the employee. In-patient hospitalizations must be reported to OSHA within 24 hours. Distinct from emergency room visits without admission.',
    `incident_date` DATE COMMENT 'The calendar date on which the workplace safety incident, injury, illness, near-miss, or fatality occurred. Principal real-world event date used for OSHA 300 Log annual reporting and trend analysis.',
    `incident_description` STRING COMMENT 'Narrative description of how the injury or illness occurred, including the sequence of events leading to the incident. Required field on OSHA 300 Log and 301 Incident Report. Used for root cause analysis and legal documentation.',
    `incident_location_description` STRING COMMENT 'Specific description of the physical location within the venue, broadcast site, or facility where the incident occurred (e.g., loading dock, field level, broadcast booth, concourse level 2, locker room). Supplements the venue_id with granular location context.',
    `incident_number` STRING COMMENT 'Externally-known, human-readable reference number assigned to the incident at the time of reporting. Used for cross-referencing with OSHA 300 Log entries, regulatory submissions, and internal safety management systems. Format: OSHA-YYYY-NNNNNN.. Valid values are `^OSHA-[0-9]{4}-[0-9]{6}$`',
    `incident_status` STRING COMMENT 'Current lifecycle state of the OSHA incident record, tracking progression from initial report through investigation, corrective action, and closure. Drives workflow routing in the safety management program.. Valid values are `open|under_investigation|corrective_action_pending|closed|voided`',
    `incident_time` TIMESTAMP COMMENT 'Precise date and time at which the workplace safety incident occurred. Used for shift-level analysis, event-day correlation, and root cause investigation timelines.',
    `incident_type` STRING COMMENT 'Primary classification of the safety event. Drives OSHA recordability determination and regulatory reporting pathway. Fatality triggers mandatory 8-hour OSHA reporting; hospitalization triggers 24-hour reporting.. Valid values are `injury|illness|near_miss|fatality|property_damage`',
    `injury_nature` STRING COMMENT 'Describes the physical nature of the injury or illness sustained (e.g., laceration, fracture, sprain, burn, concussion, heat illness, respiratory condition). Coded per OSHA BLS Occupational Injury and Illness Classification System (OIICS). [ENUM-REF-CANDIDATE: laceration|fracture|sprain|strain|burn|concussion|contusion|heat_illness|respiratory|amputation|dislocation|other — promote to reference product]',
    `investigation_completed_date` DATE COMMENT 'Date on which the formal incident investigation was completed and findings were documented. Used to measure investigation timeliness and compliance with internal safety program SLAs.',
    `job_title` STRING COMMENT 'The job title or position of the employee at the time of the incident. Required on OSHA 301 Incident Report. Used for occupational safety trend analysis by role type (e.g., event crew, broadcast technician, venue operations staff, league official).',
    `location_type` STRING COMMENT 'Categorical classification of the facility area type where the incident occurred. Supports safety trend analysis by location category across the Sports Entertainment portfolio of venues and sites. [ENUM-REF-CANDIDATE: venue_field|venue_concourse|venue_locker_room|broadcast_site|office|loading_dock|parking|other — 8 candidates stripped; promote to reference product]',
    `lost_consciousness` BOOLEAN COMMENT 'Indicates whether the employee lost consciousness as a result of the incident. Loss of consciousness is an independent OSHA recordability criterion regardless of medical treatment received.',
    `medical_treatment_beyond_first_aid` BOOLEAN COMMENT 'Indicates whether the injured employee received medical treatment beyond first aid, which is a key criterion for OSHA recordability determination. True if treatment beyond first aid was provided; False if only first aid was administered.',
    `naics_code` STRING COMMENT 'Six-digit NAICS code for the establishment where the incident occurred. Required on OSHA 300A Annual Summary and electronic submission to OSHA ITA. Identifies the industry sector for benchmarking injury rates.. Valid values are `^[0-9]{6}$`',
    `osha_case_number` STRING COMMENT 'Sequential case number assigned to the incident on the OSHA 300 Log for the establishment and calendar year. Required field on OSHA Form 300. Used for annual 300A summary compilation and regulatory audit trail.',
    `osha_log_type` STRING COMMENT 'Identifies which OSHA recordkeeping form(s) this incident is entered on: OSHA 300 Log of Work-Related Injuries and Illnesses, OSHA 300A Annual Summary, or OSHA 301 Incident Report. Drives compliance reporting workflow.. Valid values are `300_log|300a_summary|301_incident_report|not_applicable`',
    `osha_recordability` STRING COMMENT 'Determination of whether the incident meets OSHA recordability criteria under 29 CFR 1904.7. Recordable cases must be entered on the OSHA 300 Log. Non-recordable cases are retained for internal tracking only.. Valid values are `recordable|non_recordable|under_review`',
    `osha_submission_date` DATE COMMENT 'The date on which the incident was formally submitted or reported to OSHA through the Injury Tracking Application (ITA) or direct notification. Used to verify compliance with mandatory reporting deadlines (8-hour for fatalities, 24-hour for hospitalizations/amputations).',
    `reported_date` DATE COMMENT 'The date on which the injured or ill employee (or a witness) formally reported the incident to management or the safety officer. Used to measure reporting lag and compliance with internal notification SLAs.',
    `root_cause_category` STRING COMMENT 'Primary root cause classification of the incident determined through investigation. Drives corrective action type and safety program improvement initiatives. Aligned with standard safety investigation frameworks. [ENUM-REF-CANDIDATE: unsafe_act|unsafe_condition|equipment_failure|environmental|human_error|procedural_gap|other — 7 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed narrative of the root cause(s) identified through the incident investigation process. Documents contributing factors, systemic issues, and causal chain. Used to inform corrective and preventive actions.',
    `supervisor_name` STRING COMMENT 'Name of the direct supervisor or manager responsible for the work area where the incident occurred. Required on OSHA 301 Incident Report. Used for accountability tracking and investigation assignment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the OSHA incident record. Supports audit trail requirements, change tracking, and Silver layer incremental load processing.',
    `witness_names` STRING COMMENT 'Names of individuals who witnessed the incident. Required on OSHA 301 Incident Report. Stored as a delimited string. Classified as confidential due to potential legal sensitivity in workers compensation and liability proceedings.',
    `work_related` BOOLEAN COMMENT 'Indicates whether the incident has been determined to be work-related per OSHA 29 CFR 1904.5 criteria. Work-relatedness is a prerequisite for OSHA recordability. False for incidents determined to be personal in nature.',
    `workers_comp_claim_number` STRING COMMENT 'The workers compensation insurance claim number associated with this OSHA incident, if a claim was filed. Links the safety record to the financial and insurance claim management process. Confidential due to financial and legal sensitivity.',
    CONSTRAINT pk_osha_incident PRIMARY KEY(`osha_incident_id`)
) COMMENT 'OSHA workplace safety incident record capturing all recordable and reportable safety events at Sports Entertainment venues, broadcast sites, and office locations. Tracks incident date, incident type (injury, illness, near-miss, fatality), OSHA recordability classification (300 log, 300A summary), injured employee, incident location, event association (if event-day incident), body part affected, nature of injury, days away from work, restricted duty days, root cause, corrective action taken, and OSHA reporting submission date. Supports OSHA 300/300A compliance and venue safety program management.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` (
    `employee_certification_id` BIGINT COMMENT 'Unique surrogate identifier for each employee certification record in the Sports Entertainment workforce credential tracking system.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Mandatory certifications (OSHA, CBA, broadcast crew) fulfill specific regulatory obligations. Linking employee_certification to compliance obligation enables obligation fulfillment reporting and audit',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Certification costs (cost_amount field exists on employee_certification) are charged to cost centers. Sports venue and broadcast operations track which cost center bears mandatory certification expens',
    `employee_id` BIGINT COMMENT 'Reference to the workforce member who holds this certification. Links to the employee master record in SAP SuccessFactors.',
    `learning_enrollment_id` BIGINT COMMENT 'Foreign key linking to workforce.learning_enrollment. Business justification: Employee certifications are frequently earned through completion of a learning enrollment (training course). Both tables share credential_type, training_provider, training_completion_date, and trainin',
    `previous_certification_employee_certification_id` BIGINT COMMENT 'Self-referencing identifier pointing to the prior version of this certification record that was superseded by renewal or reissuance. Enables full renewal chain traceability for audit and compliance purposes.',
    `regulatory_license_id` BIGINT COMMENT 'Foreign key linking to legal.regulatory_license. Business justification: Employee certifications (FCC broadcast engineer license, venue alcohol service certification, security guard license) are often required to satisfy an organizational regulatory_license condition. This',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to partner.vendor. Business justification: External training providers for employee certifications (safety, broadcast operations, venue management) are registered vendors in sports-entertainment. Linking enables vendor spend tracking for train',
    `venue_id` BIGINT COMMENT 'Reference to the specific venue or facility for which this certification or access credential is applicable. Relevant for venue-specific licenses such as food handler permits or site-specific OSHA certifications.',
    `access_credential_scope` STRING COMMENT 'Defines the venue zones, broadcast facilities, or restricted areas that this credential authorizes the employee to access (e.g., Field Level, Broadcast Compound, Back of House, VIP Areas). Integrates with venue access control systems.',
    `certification_name` STRING COMMENT 'Official full name of the credential or certification as issued by the certifying authority (e.g., OSHA 30-Hour Construction Safety, CPR/AED Certification, Food Handler Permit, Forklift Operator Certification, Broadcast Engineering License).',
    `certification_number` STRING COMMENT 'Externally-issued unique identifier assigned by the certifying authority (e.g., OSHA card number, CPR certificate number, broadcast license number). Used for verification against issuing body records.',
    `certification_status` STRING COMMENT 'Current lifecycle state of the certification record. Active indicates the credential is valid and in force. Expired, suspended, or revoked credentials trigger access restriction workflows and OSHA compliance flags.. Valid values are `active|expired|suspended|revoked|pending_verification`',
    `certification_subtype` STRING COMMENT 'Granular classification within the certification type (e.g., OSHA 10, OSHA 30, Basic First Aid, Advanced CPR, Forklift Class I, SIA Door Supervisor). Enables precise compliance tracking at the credential level.',
    `certification_type` STRING COMMENT 'High-level category classifying the nature of the credential. Drives compliance reporting and access control logic. [ENUM-REF-CANDIDATE: safety|medical|broadcast_license|food_handler|security|access_credential|event_management|professional_license — promote to reference product]',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether this certification record is currently in a compliant state (True) or has triggered a compliance violation (False) based on expiration, verification failure, or regulatory requirement. Drives OSHA and venue access compliance dashboards.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred by the organization for obtaining or renewing this certification, including training fees, examination fees, and administrative costs. Used for workforce development budget tracking and cost center allocation.',
    `cost_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the certification cost amount (e.g., USD, GBP, EUR). Required for multi-currency financial reporting in global sports entertainment operations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the system. Supports audit trail requirements under SOX and GDPR data lineage obligations.',
    `credential_document_ref` STRING COMMENT 'Reference identifier or URL pointing to the scanned or digital copy of the certification document stored in the SAP SuccessFactors document management system or enterprise DAM. Enables auditors to retrieve source documents.',
    `exam_score` DECIMAL(18,2) COMMENT 'Numeric score achieved by the employee on the certification examination, where applicable. Expressed as a percentage or raw score per the certifying authoritys scale. Null if no examination was required.',
    `expiration_date` DATE COMMENT 'Calendar date on which the certification expires and is no longer valid. Null indicates a lifetime or non-expiring credential. Drives automated renewal alerts and access control enforcement.',
    `is_cba_required` BOOLEAN COMMENT 'Indicates whether this certification is mandated under a Collective Bargaining Agreement (CBA) for unionized workforce members such as broadcast crews, stagehands, or arena operations staff.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this certification is a mandatory requirement for the employees role or venue access. Mandatory certifications trigger compliance alerts and may restrict access if expired or unverified.',
    `is_osha_required` BOOLEAN COMMENT 'Flags whether this certification is specifically required to satisfy Occupational Safety and Health Administration (OSHA) regulatory obligations for the employees role or work environment (e.g., OSHA 10/30 for venue construction and event setup crews).',
    `issue_date` DATE COMMENT 'Calendar date on which the certification was officially issued or awarded by the certifying authority. Used to calculate credential age and validate compliance windows.',
    `issuing_authority` STRING COMMENT 'Name of the organization, regulatory body, or accreditation body that issued the certification (e.g., OSHA, American Red Cross, FCC, National Restaurant Association, Security Industry Authority).',
    `issuing_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction in which the certification was issued. Supports multi-jurisdiction compliance tracking for global sports entertainment operations.. Valid values are `^[A-Z]{3}$`',
    `issuing_state_province` STRING COMMENT 'State or province of the issuing jurisdiction where applicable (e.g., CA, NY, TX). Required for state-level licenses such as food handler permits and security licenses that are jurisdiction-specific.',
    `job_role_requirement` STRING COMMENT 'The specific job role, position, or workforce category for which this certification is required (e.g., Broadcast Engineer, Event Crew, Food Service Staff, Security Officer, Forklift Operator). Links certification requirements to workforce role definitions.',
    `non_compliance_reason` STRING COMMENT 'Free-text description of the reason for non-compliance when compliance_flag is False (e.g., Certification expired, Verification failed, Renewal not completed by due date). Supports HR investigation and remediation workflows.',
    `notes` STRING COMMENT 'Free-text field for HR administrators to record additional context, exceptions, or special conditions related to this certification record (e.g., waiver approvals, special accommodations, issuing authority contact details).',
    `passing_score` DECIMAL(18,2) COMMENT 'Minimum score required to pass the certification examination as defined by the certifying authority. Used to validate exam_score and determine pass/fail outcome.',
    `regulatory_body` STRING COMMENT 'Name of the government agency or industry regulatory body that mandates this certification (e.g., OSHA, FCC, FDA, State Health Department). Distinct from the issuing authority; used for regulatory compliance mapping.',
    `renewal_count` STRING COMMENT 'Number of times this specific certification has been renewed for this employee. Tracks the renewal history depth and supports longitudinal compliance reporting.',
    `renewal_due_date` DATE COMMENT 'Target date by which the employee must initiate or complete the renewal process, typically set ahead of the expiration date per organizational policy (e.g., 60 days prior). Supports proactive workforce compliance management.',
    `renewal_status` STRING COMMENT 'Current state of the certification renewal process. Drives compliance dashboards and HR workflow triggers in SAP SuccessFactors.. Valid values are `not_required|pending|in_progress|renewed|overdue`',
    `source_system` STRING COMMENT 'Identifies the originating operational system from which this certification record was ingested into the Databricks Silver Layer (e.g., SAP SuccessFactors, manual HR entry, third-party background check import). Supports data lineage and reconciliation.. Valid values are `sap_successfactors|manual_entry|third_party_import`',
    `training_completion_date` DATE COMMENT 'Date on which the employee completed the training course or examination that resulted in this certification. May differ from the issue date if there is a processing lag at the certifying authority.',
    `training_hours` DECIMAL(18,2) COMMENT 'Total number of instructional hours completed as part of the certification program (e.g., 10 hours for OSHA 10, 30 hours for OSHA 30). Used for CBA compliance reporting and workforce development tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this certification record. Used for change data capture (CDC) in the Databricks Silver Layer pipeline and audit trail compliance.',
    `validity_period_months` STRING COMMENT 'Standard duration in months for which this certification type remains valid before renewal is required, as defined by the issuing authority (e.g., 24 months for CPR/AED, 36 months for OSHA 30). Used to auto-calculate renewal due dates.',
    `verification_date` DATE COMMENT 'Date on which the most recent verification of this certification was completed. Used to determine if re-verification is required per organizational policy or regulatory mandate.',
    `verification_method` STRING COMMENT 'Method used to verify the authenticity of the certification against the issuing authority (e.g., manual document review, online registry lookup, third-party background check service, document upload to SAP SuccessFactors).. Valid values are `manual_review|online_registry|third_party_service|document_upload`',
    `verification_status` STRING COMMENT 'Indicates whether the certification has been independently verified against the issuing authoritys records. Verified credentials are required for OSHA compliance and venue access control. Failed status triggers HR investigation workflow.. Valid values are `unverified|verified|failed|pending`',
    `verified_by` STRING COMMENT 'Name or identifier of the HR staff member, compliance officer, or third-party service that performed the verification of this certification. Supports audit trail requirements under SOX and OSHA.',
    CONSTRAINT pk_employee_certification PRIMARY KEY(`employee_certification_id`)
) COMMENT 'Employee credential and certification master tracking all professional licenses, safety certifications, and access credentials held by Sports Entertainment workforce members. Captures credential type (OSHA 10/30, first aid/CPR, broadcast engineering license, food handler permit, security license, forklift certification, event management certification), issuing authority, issue date, expiration date, renewal status, and verification status. Supports OSHA compliance, venue access control, and broadcast regulatory licensing requirements.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` (
    `labor_relations_case_id` BIGINT COMMENT 'Primary key for labor_relations_case',
    `cba_agreement_id` BIGINT COMMENT 'Reference to the Collective Bargaining Agreement (CBA) under which this labor relations case is governed. Links to league.cba_agreement.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Grievance arbitration fees, legal costs, and fine amounts (fine_amount field exists) from CBA labor cases are charged to cost centers. Sports organizations with union workforces track these costs by c',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is the subject of this labor relations case. Links to the workforce employee master record in SAP SuccessFactors.',
    `franchise_id` BIGINT COMMENT 'Foreign key linking to league.franchise. Business justification: CBA grievances and labor relations cases are filed against a specific franchise as the employer. Franchise-level grievance tracking, CBA compliance reporting, and league labor relations oversight all ',
    `incident_report_id` BIGINT COMMENT 'Foreign key linking to compliance.incident_report. Business justification: Labor relations cases involving CBA violations, workplace misconduct, or safety breaches may generate compliance incident reports for regulatory tracking. Linking enables compliance teams to associate',
    `insurance_policy_id` BIGINT COMMENT 'Foreign key linking to legal.insurance_policy. Business justification: Labor relations cases (wrongful termination, harassment, discrimination) are covered under Employment Practices Liability Insurance (EPLI). Linking the case to the applicable insurance_policy enables ',
    `integrity_alert_id` BIGINT COMMENT 'Foreign key linking to gaming.integrity_alert. Business justification: When a gaming integrity alert implicates an employee, a disciplinary/labor relations case is opened. Sports entertainment integrity departments require traceability from the disciplinary case back to ',
    `litigation_case_id` BIGINT COMMENT 'Foreign key linking to legal.litigation_case. Business justification: Labor grievances and disciplinary actions under CBAs frequently escalate to formal litigation (wrongful termination, discrimination suits). Linking labor_relations_case to litigation_case enables lega',
    `matter_id` BIGINT COMMENT 'Foreign key linking to legal.legal_matter. Business justification: CBA grievances and disciplinary cases are managed as legal matters by in-house counsel. This link enables legal spend tracking, outside counsel assignment, and matter lifecycle management tied directl',
    `osha_incident_id` BIGINT COMMENT 'Foreign key linking to workforce.osha_incident. Business justification: labor_relations_case has an osha_related boolean flag indicating the case stems from a workplace safety incident. Linking labor_relations_case.osha_incident_id → osha_incident.osha_incident_id formali',
    `security_incident_id` BIGINT COMMENT 'Foreign key linking to security.security_incident. Business justification: Disciplinary cases (assault, misconduct, policy violation) frequently originate from a security incident report. HR and legal teams need to cross-reference the security incident when processing the la',
    `suspension_record_id` BIGINT COMMENT 'Foreign key linking to athlete.suspension_record. Business justification: When a league suspends an athlete, the players union files a CBA grievance creating a labor_relations_case. Linking to suspension_record enables CBA dispute tracking, arbitration case management, and ',
    `union_id` BIGINT COMMENT 'Reference to the labor union representing the employee in this case. Links to the union master record. Relevant for cases involving unionized workforce segments (e.g., NFLPA, NBPA, MLBPA, NHLPA, MLSPA, broadcast crew unions).',
    `venue_id` BIGINT COMMENT 'Reference to the venue where the incident underlying this case occurred, if applicable. Relevant for event crew, venue operations, and OSHA-related cases. Null for cases not tied to a specific venue.',
    `appeal_date` DATE COMMENT 'Date on which the appeal was formally filed. Null if no appeal has been filed. Used for tracking appeal deadlines and case escalation timelines.',
    `appeal_filed` BOOLEAN COMMENT 'Indicates whether an appeal has been filed against the resolution of this labor relations case. True if an appeal is in progress or has been filed; False otherwise.',
    `appeal_outcome` STRING COMMENT 'The outcome of the appeal process. Pending means the appeal is still under review; upheld means the original decision was confirmed; overturned means the appeal succeeded; remanded means the case was sent back for reconsideration; withdrawn means the appeal was retracted. Null if no appeal was filed.. Valid values are `pending|upheld|overturned|remanded|withdrawn`',
    `arbitrator_name` STRING COMMENT 'Full name of the neutral arbitrator assigned to adjudicate the case when it reaches arbitration. Null for cases resolved prior to arbitration. Sourced from the agreed arbitration panel per the CBA.',
    `case_description` STRING COMMENT 'Detailed narrative description of the labor relations case, including the nature of the alleged violation, the circumstances of the incident, and the basis for the case. Treated as confidential HR data.',
    `case_number` STRING COMMENT 'Externally-known unique business identifier for the labor relations case, formatted as LRC-YYYY-NNNNNN. Used in all formal correspondence, arbitration filings, and regulatory submissions.. Valid values are `^LRC-[0-9]{4}-[0-9]{6}$`',
    `case_source` STRING COMMENT 'Identifies who or what initiated this labor relations case. Distinguishes between employee-initiated grievances, union-filed actions, management-initiated disciplinary proceedings, regulatory agency referrals, or third-party complaints.. Valid values are `employee_filed|union_filed|management_initiated|regulatory_referral|third_party`',
    `case_status` STRING COMMENT 'Current lifecycle status of the labor relations case. Tracks progression from initial filing through resolution or appeal.. Valid values are `open|under_review|pending_hearing|settled|closed|appealed`',
    `case_type` STRING COMMENT 'Classification of the labor relations case by its formal type. Grievance covers employee-filed complaints under CBA; arbitration covers formal third-party dispute resolution; disciplinary_action covers employer-initiated corrective actions; unfair_labor_practice covers NLRA violations; cba_dispute covers contract interpretation disagreements; mediation covers facilitated settlement processes.. Valid values are `grievance|arbitration|disciplinary_action|unfair_labor_practice|cba_dispute|mediation`',
    `cba_article_reference` STRING COMMENT 'Specific article, section, or clause of the Collective Bargaining Agreement (CBA) that is alleged to have been violated or is in dispute. For example, Article 12, Section 3(b) - Just Cause. Critical for arbitration proceedings.',
    `confidentiality_level` STRING COMMENT 'Data classification level assigned to this labor relations case record, governing access controls and data handling requirements. Aligns with Sports Entertainment data classification policy.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this labor relations case record was first created in the system. Used for audit trail and data lineage purposes.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the fine_amount. Supports international operations across global markets (e.g., USD, GBP, EUR, CAD, AUD).. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Organizational department code of the employee at the time the case was filed. Sourced from SAP SuccessFactors organizational structure. Used for workforce analytics and HR reporting by business unit.',
    `disciplinary_action_type` STRING COMMENT 'The specific type of disciplinary action imposed on the employee, if applicable. Null for grievance or arbitration cases not involving employer-initiated discipline.. Valid values are `verbal_warning|written_warning|suspension|termination|demotion|fine`',
    `employer_representative_name` STRING COMMENT 'Full name of the management or HR representative handling this case on behalf of Sports Entertainment. Used for case accountability and correspondence tracking.',
    `external_case_reference` STRING COMMENT 'External reference number assigned by a third-party body such as the American Arbitration Association (AAA), National Labor Relations Board (NLRB), Court of Arbitration for Sport (CAS), or a league office. Used for cross-referencing with external proceedings.',
    `filed_date` DATE COMMENT 'The date on which the labor relations case was formally filed or initiated. This is the principal real-world event date for the case lifecycle and is used for statutory deadline tracking.',
    `fine_amount` DECIMAL(18,2) COMMENT 'Monetary fine levied against the employee as part of the disciplinary action, expressed in USD. Applicable for leagues with CBA-authorized fine schedules (e.g., NFL, NBA conduct policies). Null if no fine is imposed.',
    `gdpr_applicable` BOOLEAN COMMENT 'Indicates whether this case involves an employee subject to General Data Protection Regulation (GDPR) jurisdiction (i.e., EU-based employees or EU market operations). True if GDPR applies; False otherwise. Governs data retention, access, and erasure obligations.',
    `grievance_step` STRING COMMENT 'Current step in the multi-step CBA grievance procedure. Most CBAs define a sequential escalation path (Step 1: supervisor, Step 2: HR/management, Step 3: senior management, then arbitration). Null for non-grievance case types.. Valid values are `step_1|step_2|step_3|arbitration|closed`',
    `hearing_date` DATE COMMENT 'Scheduled or actual date of the formal arbitration or grievance hearing. Null if no hearing has been scheduled or the case was resolved without a hearing.',
    `incident_date` DATE COMMENT 'The date on which the underlying incident, violation, or event that triggered this labor relations case occurred. Distinct from the filed date; used for CBA statute-of-limitations compliance and root-cause analysis.',
    `legal_counsel_engaged` BOOLEAN COMMENT 'Indicates whether external or internal legal counsel has been formally engaged to represent Sports Entertainment in this labor relations case. True if legal counsel is involved; False otherwise. Triggers legal hold and document preservation obligations.',
    `legal_hold` BOOLEAN COMMENT 'Indicates whether a legal hold has been placed on records associated with this case, preventing deletion or modification of related documents and data. True if a legal hold is active; False otherwise.',
    `osha_related` BOOLEAN COMMENT 'Indicates whether this labor relations case involves an Occupational Safety and Health Administration (OSHA) workplace safety violation or injury-related grievance. True if OSHA-related; False otherwise. Triggers mandatory OSHA recordkeeping and reporting obligations.',
    `prior_case_count` STRING COMMENT 'Number of prior labor relations cases on record for this employee at the time this case was filed. Used to assess progressive discipline history and inform case handling decisions under CBA progressive discipline provisions.',
    `resolution_date` DATE COMMENT 'Date on which the labor relations case was formally resolved, settled, or closed. Used for case duration analytics and CBA compliance reporting.',
    `resolution_notes` STRING COMMENT 'Narrative summary of the resolution outcome, including any remedies awarded, conditions imposed, or settlement terms agreed upon. Treated as confidential HR and legal data.',
    `resolution_type` STRING COMMENT 'The outcome classification of the resolved labor relations case. Upheld means the disciplinary action or employer position was sustained; overturned means the employee prevailed; settled means mutual agreement was reached; withdrawn means the filing party retracted; dismissed means the case was found without merit; modified means the original action was partially changed.. Valid values are `upheld|overturned|settled|withdrawn|dismissed|modified`',
    `response_deadline_date` DATE COMMENT 'The contractual or statutory deadline by which Sports Entertainment must formally respond to the grievance or case filing, as defined by the applicable CBA or labor law. Used for SLA compliance monitoring and legal risk management.',
    `successfactors_case_code` STRING COMMENT 'The native case or employee relations record identifier from SAP SuccessFactors Employee Central. Used for system-of-record traceability and cross-system reconciliation between the Databricks Silver layer and the HR source system.',
    `suspension_days` STRING COMMENT 'Number of calendar days the employee is suspended without pay as part of the disciplinary action. Applicable only when disciplinary_action_type is suspension. Used for payroll adjustment and CBA compliance tracking.',
    `union_representative_name` STRING COMMENT 'Full name of the union steward or representative assigned to represent the employee in this labor relations case. Captured as a denormalized field for case documentation purposes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this labor relations case record was most recently modified. Supports audit trail, change tracking, and incremental data pipeline processing.',
    `wada_related` BOOLEAN COMMENT 'Indicates whether this labor relations case involves a Performance Enhancing Drug (PED) violation or World Anti-Doping Agency (WADA) anti-doping policy matter. True if WADA-related; False otherwise. Triggers additional compliance reporting obligations.',
    `workforce_category` STRING COMMENT 'Classification of the employees workforce category at the time of the case. Determines applicable CBA, labor law protections, and HR policy framework. [ENUM-REF-CANDIDATE: full_time|part_time|seasonal|event_crew|broadcast_crew|league_official|contractor — promote to reference product]',
    CONSTRAINT pk_labor_relations_case PRIMARY KEY(`labor_relations_case_id`)
) COMMENT 'Labor relations case record documenting all formal employee relations actions at Sports Entertainment including grievances, arbitrations, and CBA-related disputes. References league.cba_agreement for league-level CBAs.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` (
    `employment_event_id` BIGINT COMMENT 'Primary key for employment_event',
    `cba_agreement_id` BIGINT COMMENT 'Identifier of the specific Collective Bargaining Agreement (CBA) governing this employment event. Applicable when cba_governed is true. Links to the CBA master record for compliance validation.',
    `corporate_entity_id` BIGINT COMMENT 'Identifier of the league or sports entity involved in an inter-league secondment or transfer event. Relevant for cross-entity workforce movements within the Sports Entertainment group (e.g., NFL, NBA, MLS properties).',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Employment events (transfers, terminations) trigger cost center reassignments and severance cost postings. Sports organizations must track which cost center bears severance expenses (severance_eligibl',
    `credential_id` BIGINT COMMENT 'Foreign key linking to security.credential. Business justification: Termination and transfer employment events trigger mandatory credential revocation. The offboarding checklist in sports organizations explicitly requires revoking venue access credentials. Linking emp',
    `employee_id` BIGINT COMMENT 'Employee ID of the manager who initiated this employment event in SAP SuccessFactors. Used for accountability tracking, org change management reporting, and manager-level turnover analysis.',
    `employment_contract_id` BIGINT COMMENT 'Foreign key linking to workforce.employment_contract. Business justification: Employment lifecycle events (promotions, transfers, separations) directly affect or are triggered by employment contracts. A promotion event creates a new contract; a separation event terminates one. ',
    `franchise_id` BIGINT COMMENT 'Foreign key linking to league.franchise. Business justification: Coaching staff transfers, GM hirings, and front-office terminations are franchise-specific employment events tracked for league compliance and staff movement reporting. Franchise attribution on employ',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational unit (department, division, or cost center) the employee belonged to before this employment event. Supports org change management and headcount reporting.',
    `position_id` BIGINT COMMENT 'Identifier of the employees position prior to this employment event. Applicable for internal movements. Used for internal mobility reporting and org change management in SAP SuccessFactors.',
    `venue_id` BIGINT COMMENT 'Identifier of the venue or facility the employee was assigned to prior to this employment event. Relevant for venue-to-venue transfers and seasonal staff movements across Sports Entertainment properties.',
    `hr_approver_employee_id` BIGINT COMMENT 'Employee ID of the HR Business Partner or HR manager who approved this employment event in SAP SuccessFactors. Required for SOX internal controls and CBA compliance documentation.',
    `job_application_id` BIGINT COMMENT 'Foreign key linking to workforce.job_application. Business justification: A hire employment event is the direct outcome of a successful job application. Linking employment_event.job_application_id → job_application.job_application_id closes the talent acquisition lifecycle ',
    `labor_relations_case_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_relations_case. Business justification: Employment events such as terminations, suspensions, and demotions are frequently the outcome of a labor relations case (disciplinary action, grievance resolution, arbitration award). Linking employme',
    `primary_employment_employee_id` BIGINT COMMENT 'Unique identifier for the employee who is the subject of this employment event. References the workforce employee master record in SAP SuccessFactors Employee Central.',
    `staff_plan_id` BIGINT COMMENT 'Identifier of the venue or facility the employee was assigned to prior to this employment event. Relevant for venue-to-venue transfers and seasonal staff movements across Sports Entertainment properties.',
    `tertiary_employment_hr_approver_employee_id` BIGINT COMMENT 'Employee ID of the HR Business Partner or HR manager who approved this employment event in SAP SuccessFactors. Required for SOX internal controls and CBA compliance documentation.',
    `to_org_unit_id` BIGINT COMMENT 'Identifier of the organizational unit the employee is moving to as a result of this employment event. Null for separation events.',
    `to_position_id` BIGINT COMMENT 'Identifier of the employees new position following this employment event. Applicable for internal movements. Null for separation events.',
    `to_venue_id` BIGINT COMMENT 'Identifier of the venue or facility the employee is being assigned to as a result of this employment event. Null for separation events or non-venue movements.',
    `to_venue_venue_staff_plan_id` BIGINT COMMENT 'Identifier of the venue or facility the employee is being assigned to as a result of this employment event. Null for separation events or non-venue movements.',
    `cba_governed` BOOLEAN COMMENT 'Indicates whether this employment event is subject to a Collective Bargaining Agreement (CBA). Drives additional compliance validation steps and documentation requirements for unionized workforce segments.',
    `compensation_change_flag` BOOLEAN COMMENT 'Indicates whether this employment event is accompanied by a change in the employees base compensation. True when a salary adjustment is triggered by the event (e.g., promotion, demotion). Drives downstream payroll processing in SAP S/4HANA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this employment event record was first created in SAP SuccessFactors Employee Central. Used for audit trail and SOX financial controls compliance.',
    `effective_date` DATE COMMENT 'The business-effective date on which the employment event takes legal and operational effect. Used for payroll cutover, access provisioning/deprovisioning, and org chart updates. Distinct from the record creation timestamp.',
    `equipment_return_status` STRING COMMENT 'Tracks the status of company equipment return for separation events (e.g., laptops, access cards, broadcast equipment, uniforms). Supports offboarding checklist compliance and asset management.. Valid values are `not_required|pending|completed|overdue`',
    `event_number` STRING COMMENT 'Externally-known business identifier for this employment event, formatted as EE-{YYYY}-{NNNNNN}. Used in HR correspondence, audit trails, and cross-system references with SAP SuccessFactors and Workday Adaptive Planning.. Valid values are `^EE-[0-9]{4}-[0-9]{6}$`',
    `event_status` STRING COMMENT 'Current workflow lifecycle state of the employment event record within SAP SuccessFactors. Tracks progression from initial draft through HR approval to completion or cancellation.. Valid values are `draft|pending_approval|approved|completed|cancelled`',
    `event_type` STRING COMMENT 'High-level classification of the employment event, distinguishing between an internal organizational movement (transfer, promotion, demotion, secondment) and a separation (resignation, termination, retirement, contract end).. Valid values are `internal_movement|separation`',
    `exit_interview_completed` BOOLEAN COMMENT 'Indicates whether an exit interview was conducted for this separation event. Applicable only for separation event types. Supports turnover analysis and employee experience reporting.',
    `exit_interview_date` DATE COMMENT 'Date on which the exit interview was conducted for a separation event. Null if exit_interview_completed is false or event is an internal movement.',
    `exit_reason_category` STRING COMMENT 'Standardized category of the primary reason for voluntary separation as captured during the exit interview. Used for attrition root-cause analysis and retention strategy development.. Valid values are `compensation|career_growth|work_environment|personal|relocation|end_of_contract`',
    `from_job_grade` STRING COMMENT 'The employees job grade or pay band classification prior to this employment event. Used to determine if the event constitutes a promotion or demotion and for compensation equity analysis.',
    `hr_approval_status` STRING COMMENT 'Current approval status of the employment event within the HR workflow in SAP SuccessFactors. Tracks whether the event is awaiting HR sign-off, has been approved, rejected, or escalated to senior HR leadership.. Valid values are `pending|approved|rejected|escalated`',
    `hr_approval_timestamp` TIMESTAMP COMMENT 'Date and time when the HR approver formally approved or rejected this employment event in SAP SuccessFactors. Critical for SLA compliance and audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this employment event record in SAP SuccessFactors Employee Central. Supports change data capture in the Databricks Silver layer and audit compliance.',
    `last_working_date` DATE COMMENT 'The final date on which the employee is expected to perform work duties. For separations, this drives final payroll processing, benefit termination, and system access revocation scheduling. May differ from effective_date for notice periods.',
    `movement_type` STRING COMMENT 'Specific classification of an internal movement event. Applicable only when event_type is internal_movement. Captures whether the employee moved laterally, was promoted, demoted, placed on temporary assignment, seconded to another league entity, or transferred between venues. [ENUM-REF-CANDIDATE: lateral_transfer|promotion|demotion|temporary_assignment|inter_league_secondment|venue_to_venue_transfer — promote to reference product]. Valid values are `lateral_transfer|promotion|demotion|temporary_assignment|inter_league_secondment|venue_to_venue_transfer`',
    `notice_period_days` STRING COMMENT 'Number of calendar days of notice provided or required for this employment event, as stipulated by the employees contract or CBA. Used for compliance tracking and workforce planning.',
    `osha_incident_related` BOOLEAN COMMENT 'Indicates whether this employment event (particularly an involuntary termination or medical separation) is related to an OSHA-reportable workplace safety incident. Supports OSHA compliance reporting and legal risk management.',
    `reason_code` STRING COMMENT 'Standardized SAP SuccessFactors reason code describing the specific business rationale for the employment event (e.g., REORG, PERF_ISSUE, BUDGET_CUT, PERSONAL_REASON, CONTRACT_EXPIRY). Drives turnover analytics and CBA reporting. [ENUM-REF-CANDIDATE: promote to reference product as reason codes vary by event type and league governance rules]',
    `reason_description` STRING COMMENT 'Free-text narrative providing additional context for the employment event reason beyond the standardized reason code. May contain sensitive HR commentary; classified as confidential.',
    `rehire_eligible` BOOLEAN COMMENT 'Indicates whether the separating employee is eligible for future rehire at Sports Entertainment. Determined by HR based on separation type, performance history, and CBA provisions. Used in talent acquisition screening.',
    `rehire_restriction_reason` STRING COMMENT 'Narrative explanation for why an employee is flagged as ineligible for rehire. Populated only when rehire_eligible is false. Classified as confidential due to sensitive HR content.',
    `secondment_end_date` DATE COMMENT 'Planned end date for a temporary assignment or inter-league secondment. Applicable only when movement_type is temporary_assignment or inter_league_secondment. Null for permanent movements and separations.',
    `separation_type` STRING COMMENT 'Specific classification of a separation event. Applicable only when event_type is separation. Distinguishes voluntary resignation, involuntary termination, retirement, and end of seasonal contract — critical for turnover analysis and CBA compliance reporting.. Valid values are `voluntary_resignation|involuntary_termination|retirement|end_of_seasonal_contract`',
    `severance_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible for severance pay as part of this separation event. Determined by employment contract terms, CBA provisions, and HR policy. Drives downstream payroll processing in SAP S/4HANA.',
    `successfactors_event_code` STRING COMMENT 'The native event identifier assigned by SAP SuccessFactors Employee Central for this employment event record. Used for source system traceability and reconciliation between the Databricks Silver layer and the system of record.',
    `system_access_revocation_date` DATE COMMENT 'Date on which all system access was or is scheduled to be revoked for a separating employee. Null for internal movement events. Supports security audit and GDPR compliance.',
    `system_access_revoked` BOOLEAN COMMENT 'Indicates whether all IT system access (SAP, Salesforce CRM, Adobe Experience Platform, broadcast systems, etc.) has been revoked for a separating employee. Critical for information security compliance and GDPR data access controls.',
    `to_job_grade` STRING COMMENT 'The employees job grade or pay band classification following this employment event. Null for separation events. Compared against from_job_grade to classify promotion or demotion.',
    `worker_type` STRING COMMENT 'Classification of the employees workforce category at the time of the employment event. Distinguishes full-time staff, part-time event crew, broadcast crews, league officials, and seasonal workers — each governed by different CBA and OSHA obligations. [ENUM-REF-CANDIDATE: full_time|part_time|seasonal|broadcast_crew|league_official|event_crew — promote to reference product]. Valid values are `full_time|part_time|seasonal|broadcast_crew|league_official|event_crew`',
    CONSTRAINT pk_employment_event PRIMARY KEY(`employment_event_id`)
) COMMENT 'Employee lifecycle movement record capturing all organizational transitions and separations at Sports Entertainment. For internal movements: tracks movement type (lateral transfer, promotion, demotion, temporary assignment, inter-league secondment, venue-to-venue transfer), from/to position, from/to org unit, compensation change flag. For separations: tracks separation type (voluntary resignation, involuntary termination, retirement, end of seasonal contract), exit interview data, equipment return, system access revocation, rehire eligibility. Common fields: effective date, reason code, initiating manager, HR approval status. Sourced from SAP SuccessFactors Employee Central. Supports internal mobility reporting, turnover analysis, and org change management.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` (
    `contingent_worker_id` BIGINT COMMENT 'Unique surrogate identifier for the contingent worker master record in the Sports Entertainment workforce data platform. Primary key for all downstream joins and lineage tracking.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Contingent workers may be engaged by different legal entities within a sports group (league vs. venue operator vs. broadcast subsidiary). Company code assignment is required for tax withholding determ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Contingent workers (broadcast crews, event staff, security) are engaged against specific cost centers for labor cost tracking and budget management. Sports organizations routinely charge contingent la',
    `corporate_entity_id` BIGINT COMMENT 'Foreign key linking to legal.corporate_entity. Business justification: Contingent workers (broadcast crew, event staff) are engaged by a specific legal entity for tax form issuance (1099, IR35 determination) and entity-level contractor spend reporting. Role-prefixed eng',
    `fixture_id` BIGINT COMMENT 'Foreign key linking this assignment to the specific fixture (live event) the contingent worker is deployed to.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Contingent workers are engaged to support specific organizational units. contingent_worker has cost_center_code as a string but no org_unit_id FK. Linking contingent_worker.org_unit_id → org_unit.org_',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Contingent workers fill specific functional roles that correspond to approved position slots in the workforce plan. Linking contingent_worker.position_id → position.position_id enables headcount plann',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to partner.vendor. Business justification: Contingent workers (broadcast crew, event staff, security) in sports-entertainment are supplied by staffing agencies registered as vendors. Linking enables vendor performance tracking for staffing age',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to partner.vendor_contract. Business justification: Contingent worker engagements in sports-entertainment are governed by specific vendor contracts with the supplying staffing agency. Linking to vendor_contract enables rate verification, contract term ',
    `referred_by_contingent_worker_id` BIGINT COMMENT 'Self-referencing FK on contingent_worker (referred_by_contingent_worker_id)',
    `ada_accommodation_flag` BOOLEAN COMMENT 'Indicates whether the contingent worker has an active ADA reasonable accommodation in place that must be considered during shift assignment, venue access, and task allocation.',
    `agency_worker_number` STRING COMMENT 'The identifier assigned to this worker by the supplying staffing agency. Used to reconcile agency invoices, track agency-specific compliance records, and manage agency SLA performance.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this specific fixture assignment. Drives access provisioning, payroll processing, and post-event reconciliation workflows.',
    `background_check_date` DATE COMMENT 'The date on which the most recent background check was completed for this contingent worker. Used to determine re-screening eligibility based on tenure and role sensitivity.',
    `background_check_status` STRING COMMENT 'Current status of the contingent workers background screening. Venue access credentials and event-day assignments are blocked until status is passed. Expired status triggers re-screening workflow.. Valid values are `not_required|pending|passed|failed|expired`',
    `broadcast_crew_role` STRING COMMENT 'Specific broadcast production role for contingent workers engaged in broadcast operations (e.g., Camera Operator, Audio Engineer, Graphics Operator, OB Truck Technician, Replay Operator). Null for non-broadcast workers. Aligns with Dalet Galaxy workflow assignments.',
    `cba_agreement_code` STRING COMMENT 'Code identifying the specific Collective Bargaining Agreement (CBA) governing this contingent workers engagement terms, if applicable. Null for non-union workers. Drives overtime rules, break requirements, and differential pay calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp at which the contingent worker master record was first created in the Sports Entertainment workforce data platform. Supports data lineage, audit trail, and GDPR data retention policy enforcement.',
    `credential_expiry_date` DATE COMMENT 'The date on which the contingent workers primary professional credential expires. Triggers renewal notification workflows and blocks assignment to roles requiring the credential after expiry.',
    `credential_type` STRING COMMENT 'The type of professional credential, licence, or certification held by the contingent worker that is required for their functional role (e.g., EMT Certification, Broadcast Engineer Licence, Security Guard Licence, Referee Certification). Drives access control and compliance validation.',
    `credential_verified_flag` BOOLEAN COMMENT 'Indicates whether the contingent workers required professional credential was verified as current and valid specifically for this fixture. Credential expiry may occur between assignments, making per-assignment verification operationally necessary for venue access compliance.',
    `data_privacy_region` STRING COMMENT 'The primary data privacy regulatory region applicable to this contingent workers personal data. Determines which privacy framework governs data retention, consent, and subject access rights.. Valid values are `EU|US_CCPA|UK_GDPR|CA_PIPEDA|other`',
    `engagement_end_date` DATE COMMENT 'The date on which the contingent workers current engagement is scheduled to end or has ended. Null for open-ended engagements. Triggers offboarding workflows and access revocation.',
    `engagement_start_date` DATE COMMENT 'The date on which the contingent workers current engagement with Sports Entertainment commenced. Used for tenure calculations, benefit eligibility windows, and CBA compliance tracking.',
    `functional_domain` STRING COMMENT 'The primary business domain in which the contingent worker operates. Aligns with Sports Entertainments data domain taxonomy and drives cost center allocation and reporting. [ENUM-REF-CANDIDATE: broadcast|event_operations|venue|athlete_support|league_officiating|content_production|security|merchandise|ticketing|fan_engagement — promote to reference product]',
    `functional_role` STRING COMMENT 'The primary operational role the contingent worker performs for Sports Entertainment (e.g., Camera Operator, Event Security, Stage Crew, Broadcast Producer, Referee, Ticket Scanner). Used for scheduling, credentialing, and labor cost allocation.',
    `gdpr_consent_status` STRING COMMENT 'Current GDPR data processing consent status for contingent workers engaged in EU jurisdictions. Governs whether personal data may be processed for scheduling, payroll, and analytics purposes.. Valid values are `obtained|withdrawn|not_required|pending`',
    `identity_verification_status` STRING COMMENT 'Current status of the identity verification process for this contingent worker. Required before issuing venue access credentials and processing first payment. Integrates with SAP SuccessFactors onboarding workflows.. Valid values are `not_started|in_progress|verified|failed|expired`',
    `is_union_member` BOOLEAN COMMENT 'Indicates whether the contingent worker is a member of a labor union covered by a Collective Bargaining Agreement (CBA) applicable to Sports Entertainment. Drives CBA rule enforcement in scheduling and payroll.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp at which the contingent worker master record was most recently updated. Used for incremental data pipeline processing, change data capture, and audit compliance.',
    `legal_first_name` STRING COMMENT 'Legal given name of the contingent worker as it appears on government-issued identification. Required for payroll tax filings, background checks, and OSHA incident reporting.',
    `legal_last_name` STRING COMMENT 'Legal surname of the contingent worker as it appears on government-issued identification. Required for payroll tax filings, background checks, and OSHA incident reporting.',
    `national_id_hash` STRING COMMENT 'One-way cryptographic hash of the contingent workers national identification number (e.g., SSN, SIN, NIN). Stored as a hash to enable deduplication and tax reporting linkage without exposing the raw identifier. Required for IRS 1099-NEC filing.',
    `nationality_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the contingent workers nationality. Required for international event staffing, visa processing, and WADA anti-doping jurisdiction determination for officiating staff.. Valid values are `^[A-Z]{3}$`',
    `onboarding_completion_date` DATE COMMENT 'The date on which the contingent worker completed all required onboarding steps including identity verification, background check, safety training, and credential validation. Marks the worker as fully eligible for assignment.',
    `osha_safety_trained` BOOLEAN COMMENT 'Indicates whether the contingent worker has completed the mandatory OSHA safety training required for their assigned functional role and venue environment. Blocks event-day assignment if false for safety-sensitive roles.',
    `osha_training_date` DATE COMMENT 'The date on which the contingent worker most recently completed OSHA safety training. Used to track training currency and trigger renewal workflows per OSHA recertification schedules.',
    `pay_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the contingent workers pay rate (e.g., USD, GBP, EUR). Required for multi-currency payroll processing and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `pay_rate` DECIMAL(18,2) COMMENT 'The agreed compensation rate for this contingent worker. Interpretation depends on pay_rate_type (hourly, daily, flat fee). Used for labor cost forecasting, invoice validation, and CBA compliance checks.',
    `pay_rate_type` STRING COMMENT 'The basis on which the contingent workers pay rate is calculated. Determines how labor costs are accrued and how timesheet hours translate to payable amounts.. Valid values are `hourly|daily|per_event|flat_fee|weekly`',
    `preferred_name` STRING COMMENT 'The name the contingent worker prefers to be addressed by in operational communications, scheduling systems, and event-day rosters. May differ from legal name.',
    `rehire_eligible` BOOLEAN COMMENT 'Indicates whether this contingent worker is eligible to be re-engaged for future events or assignments. Set to false for workers terminated for cause, failed background checks, or flagged under do-not-rehire policies.',
    `role_during_event` STRING COMMENT 'The specific functional role the contingent worker performs at this fixture. May differ from the workers default functional_role on the master record — e.g., a worker whose default role is broadcast_crew may be assigned as operations for a specific event.',
    `scheduled_end_time` TIMESTAMP COMMENT 'The scheduled date and time the contingent workers shift ends for this fixture. Used for hours calculation and payroll processing.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The scheduled date and time the contingent workers shift begins for this fixture. Distinct from the fixtures doors_open_timestamp — workers typically report earlier for setup and briefing.',
    `successfactors_external_code` STRING COMMENT 'The external worker identifier assigned by SAP SuccessFactors to this contingent worker record. Used to reconcile the silver-layer master record with the system of record.',
    `tax_form_type` STRING COMMENT 'The IRS or equivalent tax form type applicable to this contingent workers engagement. Drives tax withholding logic, year-end reporting obligations, and vendor payment processing in SAP S/4HANA.. Valid values are `W9|W8-BEN|W8-BEN-E|1099-NEC|none`',
    `termination_reason` STRING COMMENT 'The reason code for the termination of the contingent workers engagement. Used for workforce analytics, rehire eligibility determination, and CBA grievance tracking. [ENUM-REF-CANDIDATE: contract_end|voluntary_resignation|performance|misconduct|redundancy|no_show|other — 7 candidates stripped; promote to reference product]',
    `venue_access_level` STRING COMMENT 'The maximum venue access level granted to this contingent worker based on their role, background check status, and credential verification. Controls physical access badge provisioning via Ticketmaster/AXS access control systems.. Valid values are `none|general_access|field_level|broadcast_compound|backstage|restricted_zone`',
    `work_authorization_type` STRING COMMENT 'The type of work authorization held by the contingent worker in the country of engagement. Required for I-9 compliance in the US and equivalent immigration compliance in other jurisdictions.. Valid values are `citizen|permanent_resident|work_visa|ota_authorization|not_required`',
    `work_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the primary country where the contingent worker performs services. Determines applicable labor law, tax jurisdiction, and GDPR/CCPA data privacy obligations.. Valid values are `^[A-Z]{3}$`',
    `work_email` STRING COMMENT 'Primary work email address used for scheduling communications, credential distribution, and broadcast crew coordination. May be a personal email for gig workers without a company domain.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `work_phone` STRING COMMENT 'Primary contact phone number for the contingent worker used for event-day coordination, last-minute scheduling changes, and emergency contact by venue operations.',
    `worker_status` STRING COMMENT 'Current lifecycle status of the contingent worker record. Controls access provisioning, scheduling eligibility, and payroll processing. do_not_rehire flags workers barred from future engagements per HR or legal directive.. Valid values are `active|inactive|pending_onboarding|suspended|terminated|do_not_rehire`',
    `worker_type` STRING COMMENT 'Classification of the contingent workers engagement model. Drives tax treatment (1099 vs W-2 agency), CBA applicability, and onboarding workflow. [ENUM-REF-CANDIDATE: freelance|event_day_contractor|gig_worker|temporary_staff|agency_worker|independent_contractor — promote to reference product]. Valid values are `freelance|event_day_contractor|gig_worker|temporary_staff|agency_worker|independent_contractor`',
    CONSTRAINT pk_contingent_worker PRIMARY KEY(`contingent_worker_id`)
) COMMENT 'Master record for non-employee contingent workforce members engaged by Sports Entertainment — freelance broadcast crew, event-day contractors, gig workers, and temporary staff not managed through standard employment contracts.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`position_cost_allocation` (
    `position_cost_allocation_id` BIGINT COMMENT 'Primary key for the position_cost_allocation association',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking this allocation record to the cost center that funds a portion of the positions labor costs.',
    `position_id` BIGINT COMMENT 'Foreign key linking this allocation record to the organizational position whose labor costs are being distributed.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The proportion of the positions total FTE and labor cost charged to this cost center, expressed as a decimal (e.g., 0.60 = 60%). All allocation_percentage values for a given position_id must sum to 1.00 across active records.',
    `budget_approval_status` STRING COMMENT 'The current budget authorization state of this specific position-cost center funding split. Sourced from the detection phase relationship data. Distinct from the position-level budget_approval_status, as each funding line may be approved independently.',
    `effective_end_date` DATE COMMENT 'The date on which this position-to-cost-center funding allocation expires or was terminated. Null indicates the allocation is currently open-ended.',
    `effective_start_date` DATE COMMENT 'The date on which this position-to-cost-center funding allocation became or becomes active. Sourced from the detection phase relationship data.',
    `fte_allocation` DECIMAL(18,2) COMMENT 'The Full-Time Equivalent value allocated to this cost center for this position, representing the fractional headcount charged. Sourced from the detection phase relationship data. Derived from position.fte_allocation × allocation_percentage but stored explicitly for SAP CO posting.',
    `headcount_plan_year` STRING COMMENT 'The fiscal year in which this position-cost center allocation was approved in the headcount plan. Sourced from the detection phase relationship data. Enables year-over-year workforce cost planning analysis.',
    `is_primary_cost_center` BOOLEAN COMMENT 'Indicates whether this cost center is the primary (majority) funding source for the position. Used to determine the default cost center for reporting and payroll posting when a single cost center must be nominated.',
    `pay_grade` STRING COMMENT 'The compensation band or pay grade code applicable to this position-cost center funding line. Sourced from the detection phase relationship data. May differ from the position-level pay_grade when a position spans multiple cost centers with different compensation structures.',
    CONSTRAINT pk_position_cost_allocation PRIMARY KEY(`position_cost_allocation_id`)
) COMMENT 'This association product represents the funding contract between a position and a cost center in Sports Entertainments workforce and financial planning model. It captures the split-funding arrangement by which a positions labor costs are distributed across one or more cost centers at defined allocation percentages and effective date ranges. Each record links one position to one cost center with attributes — allocation percentage, effective dates, budget approval status, headcount plan year, and pay grade — that exist only in the context of this specific position-to-cost-center funding relationship. Sourced from SAP CO labor distribution and SuccessFactors Position Management.. Existence Justification: In Sports Entertainment organizations, positions are routinely split-funded across multiple cost centers — e.g., a Head of Broadcast Operations charged 60% to the Broadcast Production cost center and 40% to the Venue Operations cost center. Conversely, each cost center funds multiple positions simultaneously. This split-funding arrangement is an actively managed operational record with its own attributes (allocation percentage, effective dates, budget approval status) that belong to neither the position nor the cost center alone.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`jurisdiction_license` (
    `jurisdiction_license_id` BIGINT COMMENT 'Primary key for the jurisdiction_license association',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the licensed employee in the workforce master record.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to the gaming regulatory jurisdiction in which the employee holds the license.',
    `assigned_role` STRING COMMENT 'The specific regulatory role or designation the employee holds under this jurisdiction license. Defined by the jurisdictions licensing authority and determines the scope of the employees authorized activities.',
    `effective_date` DATE COMMENT 'The date on which this employees license or authorization in the jurisdiction became legally effective. Used for compliance reporting and determining authorized operating windows.',
    `expiry_date` DATE COMMENT 'The date on which this employees license or authorization in the jurisdiction expires and must be renewed. Drives renewal workflow triggers and compliance alerts.',
    `license_number` STRING COMMENT 'The unique license or authorization number issued by the gaming regulatory authority to this specific employee for this jurisdiction. Distinct from the entity-level license number stored on gaming_jurisdiction; this is the individual employees credential.',
    `license_status` STRING COMMENT 'Current lifecycle state of this employees license or authorization within the jurisdiction. Determines whether the employee is currently authorized to perform regulated activities in that jurisdiction.',
    CONSTRAINT pk_jurisdiction_license PRIMARY KEY(`jurisdiction_license_id`)
) COMMENT 'This association product represents the regulatory licensing contract between an employee and a gaming jurisdiction. It captures the specific license or authorization held by an individual workforce member within a given gaming regulatory jurisdiction, including their assigned compliance role, the jurisdiction-issued license number, the effective and expiry dates of the authorization, and the current license status. Each record is an independently managed compliance artifact — created when a license application is approved, updated on renewal or status change, and retired on expiry or revocation. This is the SSOT for employee-level gaming regulatory authorization across all jurisdictions.. Existence Justification: In Sports Entertainments gaming compliance operations, specific employees (compliance officers, legal counsel, regulatory affairs staff) hold individual licenses or authorizations in multiple gaming jurisdictions simultaneously (e.g., NJ, PA, NV, CO), and each jurisdiction has multiple licensed employees operating within it. This is an actively managed operational relationship — the business must track which employee is licensed in which jurisdiction, under what role, with what license number, effective dates, and current status. This is not derivable from transactional data; it is a directly managed compliance record.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'Primary key for benefit_plan',
    `superseded_benefit_plan_id` BIGINT COMMENT 'Self-referencing FK on benefit_plan (superseded_benefit_plan_id)',
    `carrier_name` STRING COMMENT 'Name of the insurance carrier or third-party administrator providing the benefit plan.',
    `carrier_policy_number` STRING COMMENT 'Unique policy or contract number assigned by the insurance carrier for this benefit plan.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Percentage of costs the employee pays after meeting the deductible. Expressed as a decimal (e.g., 20.00 for 20%).',
    `compliance_status` STRING COMMENT 'Current compliance status of the benefit plan with applicable federal and state regulations (ERISA, ACA, HIPAA).',
    `contribution_frequency` STRING COMMENT 'Frequency at which employee and employer contributions are collected for the benefit plan.',
    `copay_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the employee pays for specific covered services (e.g., doctor visits, prescriptions).',
    `coverage_level` STRING COMMENT 'Scope of coverage indicating who is eligible under the plan enrollment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit plan record was first created in the HR system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this benefit plan.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Annual deductible amount the employee must pay before the plan begins coverage. Applicable to health and insurance plans.',
    `effective_end_date` DATE COMMENT 'Date when the benefit plan is no longer available for new enrollments. Nullable for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the benefit plan becomes active and available for employee enrollment.',
    `eligibility_criteria` STRING COMMENT 'Textual description of the requirements employees must meet to enroll in this benefit plan (e.g., full-time status, waiting period).',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Standard monetary amount the employee contributes per pay period for this benefit plan.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Standard monetary amount the employer contributes per pay period for this benefit plan.',
    `enrollment_period_end_date` DATE COMMENT 'End date of the annual open enrollment period when employees can elect or change this benefit plan.',
    `enrollment_period_start_date` DATE COMMENT 'Start date of the annual open enrollment period when employees can elect or change this benefit plan.',
    `is_cobra_eligible` BOOLEAN COMMENT 'Indicates whether this benefit plan is eligible for COBRA continuation coverage after employment termination.',
    `is_fsa_eligible` BOOLEAN COMMENT 'Indicates whether this benefit plan allows employees to contribute to a Flexible Spending Account for eligible expenses.',
    `is_hsa_eligible` BOOLEAN COMMENT 'Indicates whether this benefit plan qualifies as a high-deductible health plan eligible for HSA contributions.',
    `last_compliance_review_date` DATE COMMENT 'Date when the benefit plan was last reviewed for regulatory compliance with ERISA, ACA, and other applicable laws.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit plan record was last updated in the HR system.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the HR system user who last modified this benefit plan record.',
    `next_compliance_review_date` DATE COMMENT 'Scheduled date for the next regulatory compliance review of this benefit plan.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or administrative comments about the benefit plan.',
    `out_of_pocket_maximum` DECIMAL(18,2) COMMENT 'Maximum annual amount the employee pays for covered services before the plan pays 100%. Applicable to health plans.',
    `plan_administrator_email` STRING COMMENT 'Email address of the plan administrator for employee inquiries and plan management communications.',
    `plan_administrator_name` STRING COMMENT 'Name of the individual or department responsible for administering this benefit plan within the organization.',
    `plan_administrator_phone` STRING COMMENT 'Phone number of the plan administrator for employee inquiries and plan management communications.',
    `plan_category` STRING COMMENT 'Broader classification grouping related benefit types for reporting and administration.',
    `plan_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the benefit plan in HR systems and employee communications.',
    `plan_document_url` STRING COMMENT 'Web address or file path to the official plan document, summary plan description, or benefits guide.',
    `plan_name` STRING COMMENT 'Human-readable name of the benefit plan as displayed to employees and in HR documentation.',
    `plan_type` STRING COMMENT 'Category of benefit plan indicating the primary benefit domain.',
    `plan_year_end_date` DATE COMMENT 'End date of the benefit plan year for tracking deductibles, out-of-pocket maximums, and annual limits.',
    `plan_year_start_date` DATE COMMENT 'Start date of the benefit plan year for tracking deductibles, out-of-pocket maximums, and annual limits.',
    `benefit_plan_status` STRING COMMENT 'Current lifecycle state of the benefit plan indicating availability for enrollment and administration.',
    `summary_plan_description` STRING COMMENT 'Detailed textual description of the benefit plan features, coverage, exclusions, and employee rights as required by ERISA.',
    `waiting_period_days` STRING COMMENT 'Number of days a new employee must wait before becoming eligible to enroll in this benefit plan.',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Master reference table for benefit_plan. Referenced by benefit_plan_id.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`open_enrollment_period` (
    `open_enrollment_period_id` BIGINT COMMENT 'Primary key for open_enrollment_period',
    `cba_agreement_id` BIGINT COMMENT 'Identifier of the collective bargaining agreement that governs benefit terms for this enrollment period, if applicable to union employees.',
    `created_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user who created this open enrollment period record.',
    `employee_id` BIGINT COMMENT 'Identifier of the HR benefits administrator responsible for managing this open enrollment period.',
    `modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user who last modified this open enrollment period record.',
    `prior_open_enrollment_period_id` BIGINT COMMENT 'Self-referencing FK on open_enrollment_period (prior_open_enrollment_period_id)',
    `approval_required` BOOLEAN COMMENT 'Indicates whether benefit elections made during this period require managerial or HR approval before being finalized.',
    `auto_enrollment_enabled` BOOLEAN COMMENT 'Indicates whether employees who do not make active elections will be automatically enrolled in default benefit plans.',
    `communication_start_date` DATE COMMENT 'Date when enrollment communications and educational materials are released to employees.',
    `coverage_effective_date` DATE COMMENT 'Date when benefit elections made during this enrollment period become effective and coverage begins.',
    `coverage_end_date` DATE COMMENT 'Date when benefit coverage elected during this enrollment period expires or terminates.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this open enrollment period record was first created in the system.',
    `dependent_verification_required` BOOLEAN COMMENT 'Indicates whether employees must provide documentation to verify dependent eligibility during this enrollment period.',
    `eligible_employee_count` STRING COMMENT 'Total number of employees eligible to participate in this open enrollment period.',
    `end_date` DATE COMMENT 'Date when the open enrollment period closes and no further benefit elections are accepted.',
    `enrollment_deadline_date` DATE COMMENT 'Final date by which employees must complete their benefit elections. May differ from end_date if there is a grace period for processing.',
    `grace_period_days` STRING COMMENT 'Number of days after the enrollment deadline during which late elections may be accepted under special circumstances.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this open enrollment period record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or special instructions related to this open enrollment period, such as policy changes, special circumstances, or administrative guidance.',
    `passive_enrollment_enabled` BOOLEAN COMMENT 'Indicates whether employees who do not make changes will have their current benefit elections automatically carried forward to the new plan year.',
    `period_code` STRING COMMENT 'Business identifier code for the open enrollment period, typically following format OE{YEAR}{CYCLE} (e.g., OE2024AN for 2024 Annual).',
    `period_name` STRING COMMENT 'Human-readable name for the open enrollment period (e.g., 2024 Annual Open Enrollment, Mid-Year Special Enrollment).',
    `period_type` STRING COMMENT 'Classification of the enrollment period type: annual (standard yearly enrollment), special (ad-hoc enrollment window), qualifying_event (triggered by life events), new_hire (for new employees), or mid_year (mid-cycle adjustment period).',
    `plan_year` STRING COMMENT 'Calendar year for which the benefit elections apply (e.g., 2024, 2025).',
    `qualifying_event_window_days` STRING COMMENT 'Number of days employees have to make benefit changes following a qualifying life event during this period.',
    `reminder_frequency_days` STRING COMMENT 'Number of days between automated reminder notifications sent to employees who have not completed enrollment.',
    `start_date` DATE COMMENT 'Date when the open enrollment period begins and employees can start making benefit elections.',
    `open_enrollment_period_status` STRING COMMENT 'Current lifecycle status of the open enrollment period: draft (being configured), scheduled (future period), active (currently open for enrollment), closed (enrollment window ended), cancelled (period was cancelled), or suspended (temporarily paused).',
    CONSTRAINT pk_open_enrollment_period PRIMARY KEY(`open_enrollment_period_id`)
) COMMENT 'Master reference table for open_enrollment_period. Referenced by open_enrollment_period_id.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`requisition` (
    `requisition_id` BIGINT COMMENT 'Primary key for requisition',
    `approved_by_employee_id` BIGINT COMMENT 'Reference to the employee who provided final approval for the requisition to be opened.',
    `created_by_employee_id` BIGINT COMMENT 'Reference to the employee or system user who originally created the requisition record.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is the hiring manager responsible for this requisition and will supervise the hired candidate.',
    `facility_id` BIGINT COMMENT 'Reference to the primary work location or venue where the position will be based.',
    `modified_by_employee_id` BIGINT COMMENT 'Reference to the employee or system user who last modified the requisition record.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational department or business unit where the position will be located.',
    `recruiter_employee_id` BIGINT COMMENT 'Reference to the HR recruiter or talent acquisition specialist assigned to manage the recruiting process for this requisition.',
    `replacement_for_requisition_id` BIGINT COMMENT 'Self-referencing FK on requisition (replacement_for_requisition_id)',
    `approval_workflow_code` BIGINT COMMENT 'Reference to the approval workflow instance governing the requisition approval process.',
    `approved_date` DATE COMMENT 'The date the requisition received final approval and was authorized to proceed to active recruiting.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the requisition was cancelled or closed without filling the position.',
    `close_date` DATE COMMENT 'The date the requisition was closed, either due to successful hire, cancellation, or other disposition.',
    `cost_center_code` STRING COMMENT 'The financial cost center that will bear the salary and benefits expense for this position.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time the requisition record was first created in the system.',
    `employment_type` STRING COMMENT 'The employment classification for the position: full-time staff, part-time event crew, seasonal workers, contractors, or interns.',
    `flsa_classification` STRING COMMENT 'Classification under the Fair Labor Standards Act indicating whether the position is exempt or non-exempt from overtime pay requirements.',
    `job_code` STRING COMMENT 'Standardized classification code linking the requisition to the job catalog and compensation structure.',
    `job_description` STRING COMMENT 'Detailed narrative description of the role, responsibilities, qualifications, and expectations for the position.',
    `job_title` STRING COMMENT 'The official title of the position being recruited for, as it will appear in job postings and employment contracts.',
    `minimum_education_level` STRING COMMENT 'The minimum educational qualification required for candidates applying to this position.',
    `minimum_years_experience` STRING COMMENT 'The minimum number of years of relevant work experience required for the position.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time the requisition record was last updated or modified.',
    `number_of_openings` STRING COMMENT 'The quantity of positions to be filled under this requisition, typically 1 but may be higher for bulk seasonal or event crew hiring.',
    `pay_frequency` STRING COMMENT 'The frequency at which the employee in this position will be paid.',
    `physical_requirements_description` STRING COMMENT 'Description of physical demands and working conditions for the position, relevant for OSHA safety compliance and ADA accommodation planning.',
    `positions_filled` STRING COMMENT 'The count of positions that have been successfully filled and closed under this requisition.',
    `posted_date` DATE COMMENT 'The date the requisition was published to internal or external job boards and made visible to candidates.',
    `posting_visibility` STRING COMMENT 'Indicates whether the requisition is posted internally to current employees only, externally to the public, both, or kept confidential.',
    `priority_level` STRING COMMENT 'Business priority assigned to the requisition, influencing recruiter workload allocation and time-to-fill targets.',
    `remote_work_eligible_flag` BOOLEAN COMMENT 'Indicates whether the position is eligible for remote or hybrid work arrangements.',
    `requisition_number` STRING COMMENT 'Externally-visible business identifier for the job requisition, used in communications with candidates and hiring managers.',
    `requisition_type` STRING COMMENT 'Classification of the requisition indicating whether it is for a new headcount, replacement of a departing employee, seasonal hiring, or other workforce planning scenario.',
    `salary_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the salary range (e.g., USD, CAD, GBP).',
    `salary_range_maximum` DECIMAL(18,2) COMMENT 'The maximum annual salary or hourly rate budgeted for this position, in USD.',
    `salary_range_minimum` DECIMAL(18,2) COMMENT 'The minimum annual salary or hourly rate budgeted for this position, in USD.',
    `security_clearance_required_flag` BOOLEAN COMMENT 'Indicates whether the position requires background checks, security clearance, or credential verification due to venue access or sensitive operations.',
    `requisition_status` STRING COMMENT 'Current lifecycle state of the requisition in the recruiting workflow, from draft through approval, active recruiting, and final disposition.',
    `target_start_date` DATE COMMENT 'The desired or planned start date for the successful candidate to begin employment.',
    `travel_requirement_percentage` STRING COMMENT 'The estimated percentage of time the position requires business travel, relevant for broadcast crews, league officials, and touring event staff.',
    `union_code` STRING COMMENT 'Code identifying the specific labor union or bargaining unit that covers this position, if applicable.',
    `union_covered_flag` BOOLEAN COMMENT 'Indicates whether this position is covered by a collective bargaining agreement (CBA) or labor union contract.',
    CONSTRAINT pk_requisition PRIMARY KEY(`requisition_id`)
) COMMENT 'Master reference table for requisition. Referenced by requisition_id.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`candidate` (
    `candidate_id` BIGINT COMMENT 'Primary key for candidate',
    `employee_id` BIGINT COMMENT 'Identifier of the recruiter or talent acquisition specialist assigned to this candidate.',
    `referred_by_candidate_id` BIGINT COMMENT 'Self-referencing FK on candidate (referred_by_candidate_id)',
    `address_line_1` STRING COMMENT 'First line of the candidates residential street address.',
    `address_line_2` STRING COMMENT 'Second line of the candidates residential street address (apartment, suite, unit).',
    `application_date` DATE COMMENT 'Date when the candidate submitted their application or was entered into the system.',
    `application_status` STRING COMMENT 'Current lifecycle status of the candidate application in the recruitment process.',
    `background_check_date` DATE COMMENT 'Date when the background check was completed.',
    `background_check_status` STRING COMMENT 'Current status of the candidates background verification process.',
    `candidate_type` STRING COMMENT 'Classification of the candidate source or type (internal transfer, external applicant, employee referral, agency submission, rehire, contractor conversion).',
    `certifications` STRING COMMENT 'List of professional certifications, licenses, or credentials held by the candidate.',
    `city` STRING COMMENT 'City of the candidates residential address.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the candidates residential address (e.g., USA, GBR, CAN).',
    `cover_letter_text` STRING COMMENT 'Full text content of the candidates cover letter or application statement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the candidate record was first created in the system.',
    `current_employer` STRING COMMENT 'Name of the candidates current or most recent employer organization.',
    `current_job_title` STRING COMMENT 'The candidates current or most recent job title.',
    `date_of_birth` DATE COMMENT 'Candidates date of birth for age verification and compliance purposes.',
    `degree_field` STRING COMMENT 'Primary field of study or major for the candidates highest degree.',
    `desired_salary_max` DECIMAL(18,2) COMMENT 'Maximum salary expectation stated by the candidate.',
    `desired_salary_min` DECIMAL(18,2) COMMENT 'Minimum salary expectation stated by the candidate.',
    `disability_status` STRING COMMENT 'Self-disclosed disability status for Equal Employment Opportunity (EEO) and affirmative action compliance.',
    `drug_test_date` DATE COMMENT 'Date when the drug screening test was completed.',
    `drug_test_status` STRING COMMENT 'Current status of the candidates drug screening test.',
    `email_address` STRING COMMENT 'Primary email address for candidate communication and correspondence.',
    `ethnicity` STRING COMMENT 'Self-identified ethnicity or race of the candidate for Equal Employment Opportunity (EEO) reporting. [ENUM-REF-CANDIDATE: hispanic_latino|white|black_african_american|asian|native_american|pacific_islander|two_or_more|decline_to_answer — promote to reference product]',
    `first_name` STRING COMMENT 'The first or given name of the candidate.',
    `gender` STRING COMMENT 'Self-identified gender of the candidate for Equal Employment Opportunity (EEO) reporting.',
    `highest_education_level` STRING COMMENT 'The highest level of education attained by the candidate.',
    `interview_count` STRING COMMENT 'Total number of interviews conducted with this candidate.',
    `last_interview_date` DATE COMMENT 'Date of the most recent interview with the candidate.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the candidate record was last updated.',
    `last_name` STRING COMMENT 'The last or family name of the candidate.',
    `linkedin_profile_url` STRING COMMENT 'URL to the candidates LinkedIn profile page.',
    `notes` STRING COMMENT 'Free-form notes and comments from recruiters and hiring managers about the candidate.',
    `offer_accepted_date` DATE COMMENT 'Date when the candidate accepted the job offer.',
    `offer_extended_date` DATE COMMENT 'Date when a formal job offer was extended to the candidate.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the candidate.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the candidates residential address.',
    `preferred_location` STRING COMMENT 'Candidates preferred geographic location or city for work.',
    `referral_source` STRING COMMENT 'Name or identifier of the person or entity who referred the candidate, if applicable.',
    `rejection_reason` STRING COMMENT 'Reason or category for rejecting the candidate application.',
    `resume_text` STRING COMMENT 'Full text content of the candidates resume or curriculum vitae.',
    `salary_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for desired salary (e.g., USD, GBP, EUR).',
    `screening_score` DECIMAL(18,2) COMMENT 'Numeric score from initial resume screening or automated assessment (0-100 scale).',
    `skills_summary` STRING COMMENT 'Comma-separated or structured summary of the candidates key skills and competencies.',
    `source_channel` STRING COMMENT 'The recruitment channel or source through which the candidate was acquired (career site, job board, social media, employee referral, recruiting agency, campus recruiting, event, direct application).',
    `state_province` STRING COMMENT 'State, province, or region of the candidates residential address.',
    `veteran_status` STRING COMMENT 'Indicates whether the candidate is a veteran for Equal Employment Opportunity (EEO) and affirmative action reporting.',
    `willing_to_relocate` BOOLEAN COMMENT 'Indicates whether the candidate is willing to relocate for the position.',
    `work_authorization_status` STRING COMMENT 'The candidates current work authorization or visa status for employment eligibility.',
    `years_of_experience` DECIMAL(18,2) COMMENT 'Total years of relevant professional work experience.',
    CONSTRAINT pk_candidate PRIMARY KEY(`candidate_id`)
) COMMENT 'Master reference table for candidate. Referenced by candidate_id.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`union` (
    `union_id` BIGINT COMMENT 'Primary key for union',
    `parent_union_id` BIGINT COMMENT 'Self-referencing FK on union (parent_union_id)',
    `affiliation` STRING COMMENT 'Parent federation or umbrella organization the union is affiliated with (e.g., AFL-CIO, Change to Win, independent).',
    `bargaining_unit_description` STRING COMMENT 'Description of the employee group or job classifications covered by this union (e.g., broadcast technicians, stagehands, performers, officials).',
    `cba_effective_date` DATE COMMENT 'Start date of the current collective bargaining agreement between the organization and the union.',
    `cba_expiration_date` DATE COMMENT 'End date of the current collective bargaining agreement. Critical for labor relations planning and negotiation scheduling.',
    `certification_date` DATE COMMENT 'Date when the union was officially certified as the collective bargaining representative for a specific bargaining unit.',
    `contact_email` STRING COMMENT 'Primary email address for union correspondence and labor relations communication.',
    `contact_name` STRING COMMENT 'Name of the primary union representative or business agent for labor relations communication.',
    `contact_phone` STRING COMMENT 'Primary phone number for reaching the union representative.',
    `contact_title` STRING COMMENT 'Job title or role of the primary union contact (e.g., Business Agent, Shop Steward, Union President).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this union record was first created in the system.',
    `decertification_date` DATE COMMENT 'Date when the union was decertified or lost its representation status, if applicable.',
    `dues_deduction_code` STRING COMMENT 'Payroll system code used to process union dues deductions from member paychecks.',
    `dues_flat_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount deducted for union dues per pay period, if applicable.',
    `dues_percentage` DECIMAL(18,2) COMMENT 'Standard percentage of gross wages deducted for union dues, if applicable.',
    `grievance_procedure_summary` STRING COMMENT 'Brief summary of the grievance and dispute resolution process outlined in the CBA.',
    `jurisdiction` STRING COMMENT 'Geographic or organizational scope of the unions representation authority (e.g., national, regional, local, specific venue).',
    `last_negotiation_date` DATE COMMENT 'Date of the most recent collective bargaining negotiation session or contract ratification.',
    `local_number` STRING COMMENT 'Local chapter or branch number if the union is part of a larger national or international organization.',
    `member_count` STRING COMMENT 'Approximate number of organization employees who are members of this union. Used for labor relations analytics and CBA impact assessment.',
    `next_negotiation_date` DATE COMMENT 'Scheduled date for the next collective bargaining negotiation or contract renewal discussion.',
    `notes` STRING COMMENT 'Additional notes, comments, or special considerations related to the union relationship and labor agreements.',
    `office_address_line1` STRING COMMENT 'First line of the union office street address.',
    `office_address_line2` STRING COMMENT 'Second line of the union office street address (suite, floor, building).',
    `office_city` STRING COMMENT 'City where the union office is located.',
    `office_country_code` STRING COMMENT 'Three-letter ISO country code for the union office location (e.g., USA, CAN, MEX).',
    `office_postal_code` STRING COMMENT 'Postal or ZIP code for the union office address.',
    `office_state_province` STRING COMMENT 'State or province where the union office is located.',
    `recognition_date` DATE COMMENT 'Date when the organization formally recognized the union for collective bargaining purposes.',
    `union_status` STRING COMMENT 'Current operational status of the union relationship with the organization.',
    `strike_history_flag` BOOLEAN COMMENT 'Indicates whether this union has a history of work stoppages or strikes involving the organization.',
    `union_abbreviation` STRING COMMENT 'Commonly used abbreviation or acronym for the union name (e.g., SAG-AFTRA, IATSE, IBEW).',
    `union_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the union for operational use and external reporting. Used in payroll systems and labor relations documentation.',
    `union_name` STRING COMMENT 'Full legal name of the labor union or collective bargaining unit.',
    `union_type` STRING COMMENT 'Classification of the union based on the type of workers represented (craft, industrial, professional, public sector, entertainment).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this union record was last modified.',
    `website_url` STRING COMMENT 'Official website URL for the union organization.',
    CONSTRAINT pk_union PRIMARY KEY(`union_id`)
) COMMENT 'Master reference table for union. Referenced by union_id.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`course` (
    `course_id` BIGINT COMMENT 'Primary key for course',
    `prerequisite_course_id` BIGINT COMMENT 'Self-referencing FK on course (prerequisite_course_id)',
    `accreditation_body` STRING COMMENT 'Name of the external accreditation or certification body that has approved or recognized this course (e.g., SHRM, PMI, IACET). Null if not accredited.',
    `accreditation_number` STRING COMMENT 'Unique accreditation or approval number issued by the accreditation body. Used for audit and compliance verification.',
    `course_category` STRING COMMENT 'High-level business classification of the course subject matter. Used for curriculum planning, reporting, and compliance tracking.',
    `compliance_framework` STRING COMMENT 'Name of the regulatory framework, standard, or collective bargaining agreement that this course satisfies (e.g., OSHA 1910.120, CBA Article 12, SAG-AFTRA Safety Protocol).',
    `content_owner` STRING COMMENT 'Name of the internal department, team, or individual responsible for course content development, maintenance, and quality assurance.',
    `cost_per_participant` DECIMAL(18,2) COMMENT 'Standard cost per participant for delivering the course, including instructor fees, materials, and facility costs. Used for training budget planning and cost allocation. Currency is USD.',
    `course_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the course in the learning management system and HR systems. Used for course registration and transcript references.',
    `course_type` STRING COMMENT 'Classification of the course delivery method and format. Determines scheduling, resource allocation, and completion tracking requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the course record was first created in the system. Used for audit trail and data lineage tracking.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Number of continuing education or professional development credit hours awarded upon successful completion. Used for certification and license maintenance.',
    `delivery_method` STRING COMMENT 'Primary method by which the course content is delivered to participants. Determines technology requirements and scheduling constraints.',
    `course_description` STRING COMMENT 'Detailed description of the course content, learning objectives, and outcomes. Used for course catalog and employee self-service portals.',
    `difficulty_level` STRING COMMENT 'Skill level required or targeted by the course. Used for prerequisite validation and career path planning.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Standard duration of the course measured in hours. Used for scheduling, capacity planning, and training time tracking.',
    `effective_end_date` DATE COMMENT 'Date when the course is no longer available for new enrollments. Null for courses with indefinite availability.',
    `effective_start_date` DATE COMMENT 'Date when the course becomes available for enrollment and delivery. Used for course catalog management and scheduling.',
    `is_compliance_required` BOOLEAN COMMENT 'Indicates whether the course fulfills regulatory or industry compliance requirements such as OSHA safety training or collective bargaining agreement obligations. True if compliance-related.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the course is required for specific roles, compliance obligations, or onboarding programs. True if mandatory, false if optional.',
    `language` STRING COMMENT 'Primary language in which the course is delivered, using ISO 639-2 three-letter language codes (e.g., ENG for English, SPA for Spanish).',
    `last_review_date` DATE COMMENT 'Date when the course content was last reviewed for accuracy, relevance, and compliance. Used for content governance and quality assurance.',
    `learning_objectives` STRING COMMENT 'Structured list of specific learning outcomes and competencies participants will achieve upon successful completion of the course.',
    `materials_included` STRING COMMENT 'Description of materials provided to participants, such as workbooks, digital resources, reference guides, or certification kits.',
    `max_enrollment` STRING COMMENT 'Maximum number of participants that can be enrolled in a single course offering. Used for capacity planning and waitlist management.',
    `min_enrollment` STRING COMMENT 'Minimum number of participants required for a course offering to proceed. Used for cost-effectiveness and scheduling decisions.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified the course record. Used for change tracking and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the course record was last modified. Used for change tracking and data quality monitoring.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next content review cycle. Used for proactive content maintenance and compliance validation.',
    `passing_score_percentage` DECIMAL(18,2) COMMENT 'Minimum score percentage required to successfully complete the course. Used for assessment and certification validation.',
    `prerequisites` STRING COMMENT 'Description of prerequisite courses, certifications, or experience required before enrolling in this course. Used for enrollment validation.',
    `recertification_interval_months` STRING COMMENT 'Number of months after course completion before recertification is required. Null if recertification is not required.',
    `recertification_required` BOOLEAN COMMENT 'Indicates whether the course requires periodic recertification or renewal. True if recertification is required to maintain compliance or competency.',
    `short_title` STRING COMMENT 'Abbreviated title of the course for use in reports, dashboards, and mobile interfaces where space is limited.',
    `course_status` STRING COMMENT 'Current lifecycle state of the course. Only active courses are available for enrollment. Retired courses remain for historical transcript purposes.',
    `subject_area` STRING COMMENT 'Specific subject domain or discipline the course covers (e.g., broadcast operations, event management, talent relations, venue safety, production technology).',
    `target_audience` STRING COMMENT 'Description of the intended audience for the course, including job roles, departments, or employee classifications (e.g., broadcast crew, event staff, league officials, venue managers).',
    `title` STRING COMMENT 'Full official title of the course as displayed in catalogs, transcripts, and learning management systems.',
    `vendor_name` STRING COMMENT 'Name of the external training vendor or provider if the course is delivered by a third party. Null for internally-developed courses.',
    `version_number` STRING COMMENT 'Version identifier for the course content, following semantic versioning (e.g., 1.0, 2.1). Incremented when course content is updated.',
    `created_by` STRING COMMENT 'User identifier or system account that created the course record. Used for audit trail and accountability.',
    CONSTRAINT pk_course PRIMARY KEY(`course_id`)
) COMMENT 'Master reference table for course. Referenced by course_id.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Primary key for payroll_run',
    `created_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who initiated this payroll run.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this payroll run for payment.',
    `modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this payroll run record.',
    `reversed_payroll_run_id` BIGINT COMMENT 'Reference to the original payroll run that this run reverses (populated only if reversal_flag is true).',
    `reversal_payroll_run_id` BIGINT COMMENT 'Self-referencing FK on payroll_run (reversal_payroll_run_id)',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run was approved for payment processing.',
    `calculation_end_timestamp` TIMESTAMP COMMENT 'Date and time when payroll calculation processing completed for this run.',
    `calculation_start_timestamp` TIMESTAMP COMMENT 'Date and time when payroll calculation processing began for this run.',
    `check_date` DATE COMMENT 'The date printed on physical checks or used as the effective date for electronic payments.',
    `collective_bargaining_agreement_flag` BOOLEAN COMMENT 'Indicates whether this payroll run includes employees covered by a collective bargaining agreement.',
    `country_code` STRING COMMENT 'Three-letter ISO country code indicating the jurisdiction under which this payroll run is processed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts in this payroll run.',
    `employee_count` STRING COMMENT 'Total number of employees included in this payroll run.',
    `general_ledger_batch_reference` STRING COMMENT 'Identifier of the general ledger batch to which this payroll run was posted for financial accounting.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or comments about this payroll run for audit or operational reference.',
    `off_cycle_reason` STRING COMMENT 'Explanation for why this payroll run was processed outside the regular payroll schedule (applicable only for off-cycle runs).',
    `paid_timestamp` TIMESTAMP COMMENT 'Date and time when payments were successfully disbursed to employees for this payroll run.',
    `pay_date` DATE COMMENT 'The date on which employees will receive payment for this payroll run.',
    `pay_period_end_date` DATE COMMENT 'The last date of the pay period covered by this payroll run.',
    `pay_period_start_date` DATE COMMENT 'The first date of the pay period covered by this payroll run.',
    `payroll_area` STRING COMMENT 'Organizational subdivision within the company that groups employees by payroll processing characteristics (e.g., hourly staff, salaried staff, union workers).',
    `payroll_company_code` STRING COMMENT 'The legal entity or company code under which this payroll run is processed, used for financial and tax reporting segregation.',
    `payroll_frequency` STRING COMMENT 'The recurring schedule on which this payroll run is processed (e.g., weekly, biweekly, semimonthly, monthly).',
    `posted_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run was posted to the general ledger.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this payroll run is a reversal of a previously processed payroll run.',
    `run_number` STRING COMMENT 'Business-facing identifier for the payroll run, typically sequential or formatted according to organizational standards (e.g., PR-2024-001).',
    `run_type` STRING COMMENT 'Classification of the payroll run indicating the purpose or nature of the payroll processing cycle.',
    `payroll_run_status` STRING COMMENT 'Current lifecycle state of the payroll run, tracking its progression from initiation through completion.',
    `total_deductions` DECIMAL(18,2) COMMENT 'Aggregate amount of all deductions (taxes, benefits, garnishments) withheld from employee pay in this payroll run.',
    `total_employer_benefits` DECIMAL(18,2) COMMENT 'Aggregate employer-paid benefits contributions (e.g., health insurance, retirement matching) for this payroll run.',
    `total_employer_taxes` DECIMAL(18,2) COMMENT 'Aggregate employer-paid payroll taxes (e.g., FICA, FUTA, SUTA) for this payroll run.',
    `total_gross_pay` DECIMAL(18,2) COMMENT 'Aggregate gross earnings for all employees included in this payroll run before any deductions.',
    `total_net_pay` DECIMAL(18,2) COMMENT 'Aggregate net pay disbursed to all employees in this payroll run after all deductions.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Master reference table for payroll_run. Referenced by payroll_run_id.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`review_form` (
    `review_form_id` BIGINT COMMENT 'Primary key for review_form',
    `competency_framework_id` BIGINT COMMENT 'Reference to the competency framework used for evaluating skills and behaviors in this review form.',
    `created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created this review form template record.',
    `employee_id` BIGINT COMMENT 'Reference to the HR administrator or business owner responsible for maintaining and updating this review form template.',
    `modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this review form template record.',
    `derived_from_review_form_id` BIGINT COMMENT 'Self-referencing FK on review_form (derived_from_review_form_id)',
    `approval_workflow_required` BOOLEAN COMMENT 'Indicates whether completed reviews using this form require formal approval workflow through HR or senior management.',
    `business_unit` STRING COMMENT 'Business unit or division for which this review form is designed (e.g., Broadcasting, Venue Operations, League Operations, Corporate).',
    `calibration_required` BOOLEAN COMMENT 'Indicates whether reviews using this form must go through a calibration session to ensure rating consistency across the organization.',
    `cba_compliant` BOOLEAN COMMENT 'Indicates whether this review form meets requirements specified in applicable collective bargaining agreements for unionized workforce segments.',
    `compensation_impact` BOOLEAN COMMENT 'Indicates whether results from this review form directly influence compensation decisions such as merit increases or bonuses.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this review form template record was first created in the system.',
    `review_form_description` STRING COMMENT 'Detailed description of the review form purpose, intended audience, and usage guidelines for HR administrators and managers.',
    `effective_end_date` DATE COMMENT 'Date when this review form template is no longer active. Null indicates open-ended availability.',
    `effective_start_date` DATE COMMENT 'Date when this review form template becomes active and available for use in performance review cycles.',
    `employee_category` STRING COMMENT 'Employee classification for which this review form is designed, aligning with workforce segments in sports entertainment operations.',
    `estimated_completion_minutes` STRING COMMENT 'Estimated time in minutes required to complete this review form, used for planning and communication to participants.',
    `form_code` STRING COMMENT 'Business identifier code for the review form template used in HR systems and reporting.',
    `form_name` STRING COMMENT 'Human-readable name of the review form template (e.g., Annual Performance Review, 90-Day Probation Review, Talent Assessment).',
    `form_status` STRING COMMENT 'Current lifecycle status of the review form template indicating availability for use in performance cycles.',
    `form_type` STRING COMMENT 'Classification of the review form by purpose and usage context within the performance management lifecycle.',
    `includes_manager_assessment` BOOLEAN COMMENT 'Indicates whether this review form includes an assessment component completed by the direct manager.',
    `includes_peer_feedback` BOOLEAN COMMENT 'Indicates whether this review form includes feedback from peer colleagues as part of a 360-degree review process.',
    `includes_self_assessment` BOOLEAN COMMENT 'Indicates whether this review form includes a self-assessment component completed by the employee being reviewed.',
    `includes_upward_feedback` BOOLEAN COMMENT 'Indicates whether this review form includes feedback from direct reports evaluating their manager.',
    `job_level` STRING COMMENT 'Organizational job level or grade range for which this review form is applicable (e.g., Individual Contributor, Manager, Executive).',
    `language_code` STRING COMMENT 'ISO language and country code for the primary language of this review form template (e.g., en_US, es_MX).',
    `last_used_date` DATE COMMENT 'Most recent date when this review form template was used to initiate a performance review.',
    `legal_entity` STRING COMMENT 'Legal entity or subsidiary for which this review form is applicable, supporting multi-entity sports entertainment operations.',
    `localization_available` BOOLEAN COMMENT 'Indicates whether this review form has been localized and is available in multiple languages for global workforce use.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this review form template record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for HR administrators to record internal notes, change history, or special instructions related to this review form.',
    `question_count` STRING COMMENT 'Total number of questions, rating items, or assessment criteria included in this review form template.',
    `rating_scale_type` STRING COMMENT 'Type of rating or scoring methodology used in this review form for evaluating employee performance.',
    `requires_development_plan` BOOLEAN COMMENT 'Indicates whether this review form requires creation of an individual development plan for talent growth and skill enhancement.',
    `requires_goal_setting` BOOLEAN COMMENT 'Indicates whether completion of this review form requires the establishment of performance goals for the next review period.',
    `review_cycle_type` STRING COMMENT 'Frequency or timing pattern for which this review form is designed within the performance management calendar.',
    `section_count` STRING COMMENT 'Number of major sections or categories within this review form template structure.',
    `succession_planning_impact` BOOLEAN COMMENT 'Indicates whether results from this review form are used in succession planning and talent pipeline identification.',
    `usage_count` STRING COMMENT 'Total number of times this review form template has been used in completed performance review cycles.',
    `version_number` STRING COMMENT 'Version identifier for the review form template to track revisions and changes over time (e.g., 1.0, 2.1).',
    CONSTRAINT pk_review_form PRIMARY KEY(`review_form_id`)
) COMMENT 'Master reference table for review_form. Referenced by review_form_id.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`development_plan` (
    `development_plan_id` BIGINT COMMENT 'Primary key for development_plan',
    `approved_by_employee_id` BIGINT COMMENT 'Reference to the employee or manager who approved this development plan. Links to the employee master record. Nullable if not yet approved.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who owns this development plan. Links to the employee master record.',
    `manager_employee_id` BIGINT COMMENT 'Reference to the employees direct manager or supervisor who oversees and approves the development plan. Links to the employee master record.',
    `mentor_employee_id` BIGINT COMMENT 'Reference to the assigned mentor or coach supporting the employee through this development plan. Links to the employee master record. Nullable if no formal mentor is assigned.',
    `position_id` BIGINT COMMENT 'Reference to the target job position or role that this development plan is preparing the employee for. Links to the position master record. Nullable for skill-focused plans without a specific target role.',
    `superseded_development_plan_id` BIGINT COMMENT 'Self-referencing FK on development_plan (superseded_development_plan_id)',
    `actual_completion_date` DATE COMMENT 'The actual date when the development plan was completed or all objectives were achieved. Null if the plan is still in progress.',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'The actual amount spent to date on this development plan. Updated as expenses are incurred. Expressed in USD.',
    `approval_date` DATE COMMENT 'The date when the development plan was officially approved by the authorized manager or HR representative.',
    `approval_status` STRING COMMENT 'The current approval state of the development plan within the organizational workflow, indicating whether it has been reviewed and authorized by management.',
    `business_unit` STRING COMMENT 'The organizational business unit or division to which this development plan belongs (e.g., Broadcasting, League Operations, Venue Management, Talent Relations).',
    `career_track` STRING COMMENT 'The specific career path or track this development plan supports (e.g., Technical Specialist, People Management, Broadcast Operations, League Official, Venue Management).',
    `cba_compliance_flag` BOOLEAN COMMENT 'Indicates whether this development plan is subject to or complies with collective bargaining agreement requirements for training and career development.',
    `cost_center` STRING COMMENT 'The financial cost center responsible for funding and tracking expenses related to this development plan (training costs, certification fees, etc.).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this development plan record was first created in the system. Audit field for data lineage and compliance tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this development plan (e.g., USD, EUR, GBP).',
    `current_competency_level` STRING COMMENT 'The employees assessed competency level at the start of the development plan, establishing the baseline for measuring growth.',
    `department` STRING COMMENT 'The specific department within the business unit where the employee and development plan are aligned.',
    `development_plan_description` STRING COMMENT 'Detailed narrative description of the development plans objectives, scope, expected outcomes, and strategic alignment with organizational and individual career goals.',
    `estimated_budget_amount` DECIMAL(18,2) COMMENT 'The estimated total budget allocated for this development plan, covering training, certifications, travel, and other development-related expenses. Expressed in USD.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this development plan record is currently active and in use. False indicates the record has been logically deleted or archived.',
    `last_review_date` DATE COMMENT 'The most recent date when the development plan was reviewed and progress was assessed.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this development plan record was last updated or modified. Audit field for change tracking and data governance.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next formal review of the development plan progress.',
    `notes` STRING COMMENT 'Free-form text field for capturing additional notes, observations, feedback, or context related to the development plan that does not fit structured fields.',
    `plan_name` STRING COMMENT 'Human-readable name or title of the development plan, describing the focus area or career track (e.g., Broadcast Production Leadership Track, Referee Certification Path).',
    `plan_type` STRING COMMENT 'Classification of the development plan based on its primary purpose and scope within the talent development framework.',
    `priority` STRING COMMENT 'The business priority or urgency level assigned to this development plan, used for resource allocation and scheduling decisions.',
    `progress_percentage` DECIMAL(18,2) COMMENT 'The overall completion percentage of the development plan, calculated based on completed activities, milestones, and objectives. Range: 0.00 to 100.00.',
    `review_frequency` STRING COMMENT 'The scheduled frequency for reviewing progress on this development plan with the employee and manager.',
    `start_date` DATE COMMENT 'The date when the development plan officially begins or became active. Marks the commencement of the employees development journey under this plan.',
    `development_plan_status` STRING COMMENT 'Current lifecycle state of the development plan, indicating whether it is being drafted, actively pursued, paused, or concluded.',
    `succession_plan_flag` BOOLEAN COMMENT 'Indicates whether this development plan is part of a formal succession planning initiative to prepare the employee for a critical or leadership role.',
    `target_competency_level` STRING COMMENT 'The desired competency level the employee should achieve upon successful completion of the development plan.',
    `target_completion_date` DATE COMMENT 'The planned or expected date by which the development plan objectives should be achieved. Used for tracking progress and milestone planning.',
    CONSTRAINT pk_development_plan PRIMARY KEY(`development_plan_id`)
) COMMENT 'Master reference table for development_plan. Referenced by development_plan_id.';

CREATE OR REPLACE TABLE `sports_entertainment_ecm`.`workforce`.`competency_framework` (
    `competency_framework_id` BIGINT COMMENT 'Primary key for competency_framework',
    `parent_competency_framework_id` BIGINT COMMENT 'Self-referencing FK on competency_framework (parent_competency_framework_id)',
    `applicable_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where this competency framework is applicable. Null if global.',
    `approval_date` DATE COMMENT 'Date when the competency framework was officially approved for use.',
    `approval_status` STRING COMMENT 'Current approval status of the competency framework within the organizational governance process.',
    `approved_by_employee_id` BIGINT COMMENT 'Identifier of the employee who approved this competency framework for organizational use.',
    `assessment_method` STRING COMMENT 'Primary method used to evaluate competencies within this framework.',
    `business_unit` STRING COMMENT 'Primary business unit or division to which this competency framework applies (e.g., Broadcasting, League Operations, Venue Management).',
    `competency_count` STRING COMMENT 'Total number of individual competencies defined within this framework.',
    `created_by_employee_id` BIGINT COMMENT 'Identifier of the employee who created this competency framework record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the competency framework record was first created in the system.',
    `competency_framework_description` STRING COMMENT 'Detailed description of the competency framework including its purpose, scope, and intended application within the organization.',
    `effective_end_date` DATE COMMENT 'Date when the competency framework is no longer active. Null for frameworks with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when the competency framework becomes active and available for use in talent management processes.',
    `external_reference_url` STRING COMMENT 'URL link to external documentation, industry standards, or reference materials related to this competency framework.',
    `framework_category` STRING COMMENT 'Categorization indicating the scope and application level of the competency framework within the organization.',
    `framework_code` STRING COMMENT 'Unique business identifier code for the competency framework used in HR systems and documentation.',
    `framework_name` STRING COMMENT 'Official name of the competency framework (e.g., Broadcast Production Competencies, Athlete Performance Framework).',
    `framework_type` STRING COMMENT 'Classification of the competency framework by its primary focus area.',
    `industry_standard_alignment` STRING COMMENT 'Reference to external industry standards or professional bodies that this framework aligns with (e.g., SHRM Competency Model, National Occupational Standards).',
    `is_global` BOOLEAN COMMENT 'Indicates whether this competency framework applies globally across all organizational locations (True) or is region/country-specific (False).',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether competencies in this framework are mandatory for employees in the associated roles (True) or optional/developmental (False).',
    `job_family` STRING COMMENT 'Job family or occupational group for which this competency framework is designed (e.g., Production Crew, Athletic Performance, Event Operations).',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the primary language in which the framework is authored.',
    `last_modified_by_employee_id` BIGINT COMMENT 'Identifier of the employee who last modified this competency framework record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the competency framework record was last modified.',
    `last_review_date` DATE COMMENT 'Date when the competency framework was last reviewed and validated by the framework owner or governance committee.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of the competency framework.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information about the competency framework for internal reference.',
    `owner_employee_id` BIGINT COMMENT 'Identifier of the employee responsible for maintaining and governing this competency framework.',
    `proficiency_levels` STRING COMMENT 'Total number of proficiency levels defined within this competency framework (e.g., 3 for Basic/Intermediate/Advanced, 5 for a more granular scale).',
    `regulatory_requirement` STRING COMMENT 'Regulatory or compliance requirement that mandates this competency framework (e.g., OSHA Safety Training, CBA Skill Certification Requirements).',
    `review_frequency_months` STRING COMMENT 'Frequency in months at which this competency framework should be reviewed and updated to ensure relevance and accuracy.',
    `competency_framework_status` STRING COMMENT 'Current lifecycle status of the competency framework indicating its availability for use in talent management processes.',
    `usage_count` STRING COMMENT 'Number of active employees or roles currently associated with this competency framework.',
    `version_number` STRING COMMENT 'Version identifier for the competency framework to track revisions and updates over time.',
    CONSTRAINT pk_competency_framework PRIMARY KEY(`competency_framework_id`)
) COMMENT 'Master reference table for competency_framework. Referenced by competency_framework_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_unit_org_unit_id` FOREIGN KEY (`parent_unit_org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_quaternary_org_hr_business_partner_employee_id` FOREIGN KEY (`quaternary_org_hr_business_partner_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_tertiary_org_employee_id` FOREIGN KEY (`tertiary_org_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_candidate_id` FOREIGN KEY (`candidate_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`candidate`(`candidate_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_position_id` FOREIGN KEY (`position_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`requisition`(`requisition_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_tertiary_job_referral_employee_id` FOREIGN KEY (`tertiary_job_referral_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_position_id` FOREIGN KEY (`position_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_worker_employee_id` FOREIGN KEY (`worker_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_employment_contract_id` FOREIGN KEY (`employment_contract_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employment_contract`(`employment_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_employment_contract_id` FOREIGN KEY (`employment_contract_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employment_contract`(`employment_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_open_enrollment_period_id` FOREIGN KEY (`open_enrollment_period_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`open_enrollment_period`(`open_enrollment_period_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_employment_contract_id` FOREIGN KEY (`employment_contract_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employment_contract`(`employment_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_employment_event_id` FOREIGN KEY (`employment_event_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employment_event`(`employment_event_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_position_id` FOREIGN KEY (`position_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_primary_leave_employee_id` FOREIGN KEY (`primary_leave_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_tertiary_leave_backfill_employee_id` FOREIGN KEY (`tertiary_leave_backfill_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_contingent_worker_id` FOREIGN KEY (`contingent_worker_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`contingent_worker`(`contingent_worker_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_position_id` FOREIGN KEY (`position_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_development_plan_id` FOREIGN KEY (`development_plan_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`development_plan`(`development_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_hr_business_partner_employee_id` FOREIGN KEY (`hr_business_partner_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_primary_performance_employee_id` FOREIGN KEY (`primary_performance_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_position_id` FOREIGN KEY (`position_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_review_form_id` FOREIGN KEY (`review_form_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`review_form`(`review_form_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_tertiary_performance_hr_business_partner_employee_id` FOREIGN KEY (`tertiary_performance_hr_business_partner_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ADD CONSTRAINT `fk_workforce_learning_enrollment_course_id` FOREIGN KEY (`course_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`course`(`course_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ADD CONSTRAINT `fk_workforce_learning_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ADD CONSTRAINT `fk_workforce_learning_enrollment_performance_review_id` FOREIGN KEY (`performance_review_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`performance_review`(`performance_review_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ADD CONSTRAINT `fk_workforce_learning_enrollment_position_id` FOREIGN KEY (`position_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_contingent_worker_id` FOREIGN KEY (`contingent_worker_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`contingent_worker`(`contingent_worker_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_shift_assignment_id` FOREIGN KEY (`shift_assignment_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`shift_assignment`(`shift_assignment_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ADD CONSTRAINT `fk_workforce_employee_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ADD CONSTRAINT `fk_workforce_employee_certification_learning_enrollment_id` FOREIGN KEY (`learning_enrollment_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`learning_enrollment`(`learning_enrollment_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ADD CONSTRAINT `fk_workforce_employee_certification_previous_certification_employee_certification_id` FOREIGN KEY (`previous_certification_employee_certification_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee_certification`(`employee_certification_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ADD CONSTRAINT `fk_workforce_labor_relations_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ADD CONSTRAINT `fk_workforce_labor_relations_case_osha_incident_id` FOREIGN KEY (`osha_incident_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`osha_incident`(`osha_incident_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ADD CONSTRAINT `fk_workforce_labor_relations_case_union_id` FOREIGN KEY (`union_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`union`(`union_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_employment_contract_id` FOREIGN KEY (`employment_contract_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employment_contract`(`employment_contract_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_position_id` FOREIGN KEY (`position_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_hr_approver_employee_id` FOREIGN KEY (`hr_approver_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_job_application_id` FOREIGN KEY (`job_application_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`job_application`(`job_application_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_labor_relations_case_id` FOREIGN KEY (`labor_relations_case_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`labor_relations_case`(`labor_relations_case_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_primary_employment_employee_id` FOREIGN KEY (`primary_employment_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_tertiary_employment_hr_approver_employee_id` FOREIGN KEY (`tertiary_employment_hr_approver_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_to_org_unit_id` FOREIGN KEY (`to_org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ADD CONSTRAINT `fk_workforce_employment_event_to_position_id` FOREIGN KEY (`to_position_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ADD CONSTRAINT `fk_workforce_contingent_worker_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ADD CONSTRAINT `fk_workforce_contingent_worker_position_id` FOREIGN KEY (`position_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ADD CONSTRAINT `fk_workforce_contingent_worker_referred_by_contingent_worker_id` FOREIGN KEY (`referred_by_contingent_worker_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`contingent_worker`(`contingent_worker_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position_cost_allocation` ADD CONSTRAINT `fk_workforce_position_cost_allocation_position_id` FOREIGN KEY (`position_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`jurisdiction_license` ADD CONSTRAINT `fk_workforce_jurisdiction_license_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_plan` ADD CONSTRAINT `fk_workforce_benefit_plan_superseded_benefit_plan_id` FOREIGN KEY (`superseded_benefit_plan_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`open_enrollment_period` ADD CONSTRAINT `fk_workforce_open_enrollment_period_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`open_enrollment_period` ADD CONSTRAINT `fk_workforce_open_enrollment_period_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`open_enrollment_period` ADD CONSTRAINT `fk_workforce_open_enrollment_period_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`open_enrollment_period` ADD CONSTRAINT `fk_workforce_open_enrollment_period_prior_open_enrollment_period_id` FOREIGN KEY (`prior_open_enrollment_period_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`open_enrollment_period`(`open_enrollment_period_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_created_by_employee_id` FOREIGN KEY (`created_by_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_modified_by_employee_id` FOREIGN KEY (`modified_by_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_recruiter_employee_id` FOREIGN KEY (`recruiter_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`requisition` ADD CONSTRAINT `fk_workforce_requisition_replacement_for_requisition_id` FOREIGN KEY (`replacement_for_requisition_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`requisition`(`requisition_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_referred_by_candidate_id` FOREIGN KEY (`referred_by_candidate_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`candidate`(`candidate_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`union` ADD CONSTRAINT `fk_workforce_union_parent_union_id` FOREIGN KEY (`parent_union_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`union`(`union_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`course` ADD CONSTRAINT `fk_workforce_course_prerequisite_course_id` FOREIGN KEY (`prerequisite_course_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`course`(`course_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_reversed_payroll_run_id` FOREIGN KEY (`reversed_payroll_run_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_reversal_payroll_run_id` FOREIGN KEY (`reversal_payroll_run_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`review_form` ADD CONSTRAINT `fk_workforce_review_form_competency_framework_id` FOREIGN KEY (`competency_framework_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`competency_framework`(`competency_framework_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`review_form` ADD CONSTRAINT `fk_workforce_review_form_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`review_form` ADD CONSTRAINT `fk_workforce_review_form_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`review_form` ADD CONSTRAINT `fk_workforce_review_form_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`review_form` ADD CONSTRAINT `fk_workforce_review_form_derived_from_review_form_id` FOREIGN KEY (`derived_from_review_form_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`review_form`(`review_form_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`development_plan` ADD CONSTRAINT `fk_workforce_development_plan_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`development_plan` ADD CONSTRAINT `fk_workforce_development_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`development_plan` ADD CONSTRAINT `fk_workforce_development_plan_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`development_plan` ADD CONSTRAINT `fk_workforce_development_plan_mentor_employee_id` FOREIGN KEY (`mentor_employee_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`development_plan` ADD CONSTRAINT `fk_workforce_development_plan_position_id` FOREIGN KEY (`position_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`development_plan` ADD CONSTRAINT `fk_workforce_development_plan_superseded_development_plan_id` FOREIGN KEY (`superseded_development_plan_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`development_plan`(`development_plan_id`);
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`competency_framework` ADD CONSTRAINT `fk_workforce_competency_framework_parent_competency_framework_id` FOREIGN KEY (`parent_competency_framework_id`) REFERENCES `sports_entertainment_ecm`.`workforce`.`competency_framework`(`competency_framework_id`);

-- ========= TAGS =========
ALTER SCHEMA `sports_entertainment_ecm`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `sports_entertainment_ecm`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Employing Corporate Entity Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `ada_accommodation_flag` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Accommodation Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `ada_accommodation_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `cba_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `credential_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Expiry Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'successfactors|manual_entry|migration');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|terminated|suspended|pending_start');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|seasonal|contractor|league_official|broadcast_crew');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_business_glossary_term' = 'Ethnicity Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt|independent_contractor');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `gender_identity` SET TAGS ('dbx_business_glossary_term' = 'Gender Identity');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `gender_identity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `identity_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `identity_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not_required');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `is_union_member` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Legal First Name');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `national_id_hash` SET TAGS ('dbx_business_glossary_term' = 'National Identification Number Hash');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `national_id_hash` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `national_id_hash` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `nationality_code` SET TAGS ('dbx_business_glossary_term' = 'Nationality Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `nationality_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `nationality_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `nationality_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `osha_safety_trained` SET TAGS ('dbx_business_glossary_term' = 'OSHA Safety Training Completion Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `osha_training_date` SET TAGS ('dbx_business_glossary_term' = 'OSHA Safety Training Completion Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|bi_weekly|semi_monthly|monthly');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `pay_type` SET TAGS ('dbx_business_glossary_term' = 'Pay Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `pay_type` SET TAGS ('dbx_value_regex' = 'salary|hourly|per_diem|stipend');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `successfactors_person_code` SET TAGS ('dbx_business_glossary_term' = 'SAP SuccessFactors Person ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `successfactors_person_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `successfactors_person_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'voluntary_resignation|involuntary_termination|end_of_contract|retirement|redundancy|death');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `work_authorization_type` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `work_authorization_type` SET TAGS ('dbx_value_regex' = 'citizen|permanent_resident|work_visa|seasonal_visa|not_applicable');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `work_country_code` SET TAGS ('dbx_business_glossary_term' = 'Work Country Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `work_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_business_glossary_term' = 'Work Email Address');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Incumbent Employee ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `location_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `reports_to_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reports-To Position ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Position Approved Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `budget_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `budget_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|on_hold');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `cba_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^DEPT-[A-Z0-9]{2,10}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `eeo1_category` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO-1) Category');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Position Effective End Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Position Effective Start Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `filled_date` SET TAGS ('dbx_business_glossary_term' = 'Position Filled Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `headcount_plan_year` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Year');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `is_key_position` SET TAGS ('dbx_business_glossary_term' = 'Key Position Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `is_safety_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Safety-Sensitive Position Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `is_union_eligible` SET TAGS ('dbx_business_glossary_term' = 'Union Eligibility Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^JC-[A-Z0-9]{3,10}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `league_entity_code` SET TAGS ('dbx_business_glossary_term' = 'League Entity Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `max_incumbents` SET TAGS ('dbx_business_glossary_term' = 'Maximum Incumbents');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^PG-[A-Z0-9]{1,5}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `pay_range_max` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Maximum');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `pay_range_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `pay_range_min` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Minimum');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `pay_range_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^POS-[A-Z0-9]{4,12}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'active|frozen|eliminated|pending_approval|filled|vacant');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'permanent|seasonal|event_day|contract|part_time');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `remote_work_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligibility');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `remote_work_eligibility` SET TAGS ('dbx_value_regex' = 'on_site|hybrid|remote|not_eligible');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `requires_background_check` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `requires_credential` SET TAGS ('dbx_business_glossary_term' = 'Credential Required Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^SF-[A-Z0-9]{4,20}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `succession_readiness` SET TAGS ('dbx_business_glossary_term' = 'Succession Readiness');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `succession_readiness` SET TAGS ('dbx_value_regex' = 'ready_now|ready_1_2_years|ready_3_5_years|no_successor');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `vacancy_reason` SET TAGS ('dbx_business_glossary_term' = 'Vacancy Reason');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position` ALTER COLUMN `work_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Entity Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `parent_unit_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `quaternary_org_hr_business_partner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Business Partner ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `quaternary_org_hr_business_partner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `quaternary_org_hr_business_partner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `tertiary_org_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Business Partner ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `tertiary_org_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `tertiary_org_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'Venue ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `ada_compliance_scope` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliance Scope Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,15}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `cba_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Agreement Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `cba_applicable` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Applicable Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `fte_count_actual` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Actual Count');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `gdpr_data_controller` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Data Controller Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Organizational Hierarchy Level');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Organizational Hierarchy Path');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `iso_20121_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 20121 Event Sustainability Certification Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `league_code` SET TAGS ('dbx_business_glossary_term' = 'League Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|archived');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `osha_establishment_number` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Establishment ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `payroll_area_code` SET TAGS ('dbx_business_glossary_term' = 'Payroll Area Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `payroll_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'successfactors|sap_s4hana|workday|manual');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `successfactors_object_code` SET TAGS ('dbx_business_glossary_term' = 'SAP SuccessFactors Foundation Object ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `successfactors_object_code` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9_-]{1,32}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `succession_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `succession_plan_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|complete|under_review');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_short_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Short Name');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_short_name` SET TAGS ('dbx_value_regex' = '^.{1,30}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`org_unit` ALTER COLUMN `workforce_category` SET TAGS ('dbx_business_glossary_term' = 'Workforce Category');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `job_application_id` SET TAGS ('dbx_business_glossary_term' = 'Job Application ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `candidate_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Employee ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `tertiary_job_referral_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Employee ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `tertiary_job_referral_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `tertiary_job_referral_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^APP-[0-9]{8}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `applied_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submitted Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_initiated|pending|clear|adverse|cancelled');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `candidate_email` SET TAGS ('dbx_business_glossary_term' = 'Candidate Email Address');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `candidate_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `candidate_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `candidate_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `candidate_first_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate First Name');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `candidate_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `candidate_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `candidate_last_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate Last Name');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `candidate_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `candidate_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `candidate_phone` SET TAGS ('dbx_business_glossary_term' = 'Candidate Phone Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `candidate_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `candidate_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `candidate_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `cost_per_hire_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Hire (CPH) USD');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `cost_per_hire_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `dei_disability_status` SET TAGS ('dbx_business_glossary_term' = 'Diversity Equity and Inclusion (DEI) Disability Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `dei_disability_status` SET TAGS ('dbx_value_regex' = 'yes|no|prefer_not_to_say');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `dei_disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `dei_disability_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `dei_ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Diversity Equity and Inclusion (DEI) Ethnicity');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `dei_ethnicity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `dei_ethnicity` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `dei_gender_identity` SET TAGS ('dbx_business_glossary_term' = 'Diversity Equity and Inclusion (DEI) Gender Identity');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `dei_gender_identity` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say|other');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `dei_gender_identity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `dei_gender_identity` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `dei_veteran_status` SET TAGS ('dbx_business_glossary_term' = 'Diversity Equity and Inclusion (DEI) Veteran Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `dei_veteran_status` SET TAGS ('dbx_value_regex' = 'veteran|not_veteran|prefer_not_to_say');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `dei_veteran_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `dei_veteran_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|seasonal|contract|intern');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `interview_stage` SET TAGS ('dbx_business_glossary_term' = 'Interview Stage');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `interview_stage` SET TAGS ('dbx_value_regex' = 'phone_screen|hiring_manager|panel|final|none');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `is_internal_candidate` SET TAGS ('dbx_business_glossary_term' = 'Internal Candidate Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `is_rehire` SET TAGS ('dbx_business_glossary_term' = 'Rehire Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `offer_accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Accepted Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `offer_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Offer Currency Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `offer_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `offer_decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Offer Decline Reason');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `offer_decline_reason` SET TAGS ('dbx_value_regex' = 'compensation|competing_offer|location|role_fit|personal|no_reason_given');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `offer_declined_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Declined Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `offer_extended_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Extended Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `offered_base_salary` SET TAGS ('dbx_business_glossary_term' = 'Offered Base Salary');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `offered_base_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `position_title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `posting_type` SET TAGS ('dbx_business_glossary_term' = 'Posting Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `posting_type` SET TAGS ('dbx_value_regex' = 'internal|external|both');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_value_regex' = 'qualifications|experience|culture_fit|position_filled|budget_frozen|other');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{7}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Application Withdrawal Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Application Withdrawal Reason');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_value_regex' = 'accepted_other_offer|personal_reasons|role_change|no_response|other');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`job_application` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_value_regex' = 'authorized|requires_sponsorship|not_authorized|not_disclosed');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `employment_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Entity Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `worker_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `base_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Pay Rate');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `base_pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `base_pay_rate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `bonus_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Bonus Target Percentage');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `bonus_target_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `cba_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Reference Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `cba_covered` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Coverage Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `commission_eligible` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligibility Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `commission_eligible` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|pending_renewal');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'permanent|fixed_term|seasonal|zero_hours|casual');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `contracted_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Contracted Hours Per Week');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Currency Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `employment_category` SET TAGS ('dbx_business_glossary_term' = 'Employment Category');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `employment_category` SET TAGS ('dbx_value_regex' = 'employee|independent_contractor|agency_worker|intern');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Exemption Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `fte_ratio` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Ratio');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `job_grade` SET TAGS ('dbx_business_glossary_term' = 'Job Grade');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `job_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Last Reviewed Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `merit_increase_schedule` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Schedule');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `merit_increase_schedule` SET TAGS ('dbx_value_regex' = 'annual|bi_annual|performance_triggered|none');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `merit_increase_schedule` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `nil_compensation_eligible` SET TAGS ('dbx_business_glossary_term' = 'Name Image and Likeness (NIL) Compensation Eligibility Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `nil_compensation_eligible` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `nil_provision_details` SET TAGS ('dbx_business_glossary_term' = 'Name Image and Likeness (NIL) Provision Details');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `nil_provision_details` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period (Days)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligibility Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `pay_basis` SET TAGS ('dbx_business_glossary_term' = 'Pay Basis');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `pay_basis` SET TAGS ('dbx_value_regex' = 'annual_salary|hourly_rate|daily_rate|per_event');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `pay_basis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|bi_weekly|semi_monthly|monthly|event_based');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `probation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Probation Period End Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `remote_work_type` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Arrangement Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `remote_work_type` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid|travelling');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Option Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `renewal_option` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Maximum');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_range_mid` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Midpoint');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_range_mid` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Minimum');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `signed_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Reason');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'resignation|redundancy|end_of_term|dismissal|mutual_agreement|retirement');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `union_local` SET TAGS ('dbx_business_glossary_term' = 'Union Local Identifier');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `work_location_country` SET TAGS ('dbx_business_glossary_term' = 'Work Location Country Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `work_location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `worker_classification` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_contract` ALTER COLUMN `worker_classification` SET TAGS ('dbx_value_regex' = 'full_time|part_time|seasonal|event_crew|broadcast_talent|league_official');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `athlete_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Athlete Contract Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `production_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Production Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Entity Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employment_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `tax_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `base_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Pay Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `base_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `base_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `benefit_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Benefits Deduction Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `benefit_deduction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `benefit_deduction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `broadcast_differential_amount` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Crew Shift Differential Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `broadcast_differential_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `broadcast_differential_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `cba_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `direct_deposit_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Deposit Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employer_fica_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer FICA Contribution Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employer_fica_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|seasonal|contractor|event_crew');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `event_day_differential_amount` SET TAGS ('dbx_business_glossary_term' = 'Event Day Shift Differential Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `event_day_differential_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `event_day_differential_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `federal_income_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Federal Income Tax Withheld');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `federal_income_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `federal_income_tax_withheld` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `fica_medicare_amount` SET TAGS ('dbx_business_glossary_term' = 'FICA Medicare Withholding Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `fica_medicare_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `fica_medicare_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `fica_social_security_amount` SET TAGS ('dbx_business_glossary_term' = 'FICA Social Security Withholding Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `fica_social_security_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `fica_social_security_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `garnishment_amount` SET TAGS ('dbx_business_glossary_term' = 'Wage Garnishment Deduction Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `garnishment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `garnishment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `is_union_member` SET TAGS ('dbx_business_glossary_term' = 'Union Member Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `local_income_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Local Income Tax Withheld');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `local_income_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `local_income_tax_withheld` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overnight_differential_amount` SET TAGS ('dbx_business_glossary_term' = 'Overnight Shift Differential Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overnight_differential_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overnight_differential_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overtime_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Overtime Pay Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overtime_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overtime_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_group_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Group Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'direct_deposit|check|wire_transfer|pay_card');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_area_code` SET TAGS ('dbx_business_glossary_term' = 'Payroll Area Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_run_date` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `regular_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours Worked');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `retirement_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Retirement Plan Contribution Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `retirement_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `retirement_contribution_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'draft|processed|approved|posted|reversed|cancelled');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'regular|off_cycle|supplemental|correction|final');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `state_income_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'State Income Tax Withheld');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `state_income_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `state_income_tax_withheld` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `total_deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Deductions Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `total_deductions_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `total_deductions_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `union_dues_amount` SET TAGS ('dbx_business_glossary_term' = 'Union Dues Deduction Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `union_dues_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `union_dues_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `ytd_federal_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Federal Income Tax Withheld');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `ytd_federal_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `ytd_federal_tax_withheld` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `ytd_fica_social_security_amount` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) FICA Social Security Withheld');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `ytd_fica_social_security_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `ytd_fica_social_security_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `ytd_gross_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Gross Pay Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `ytd_gross_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_record` ALTER COLUMN `ytd_gross_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Vendor Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employment_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `aca_offer_of_coverage_code` SET TAGS ('dbx_business_glossary_term' = 'Affordable Care Act (ACA) Offer of Coverage Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `aca_offer_of_coverage_code` SET TAGS ('dbx_value_regex' = '1A|1B|1C|1D|1E|1F');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `annual_election_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Election Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `annual_election_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_designation_on_file` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Designation On File Indicator');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Member ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cba_plan_indicator` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Plan Indicator');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_eligible` SET TAGS ('dbx_business_glossary_term' = 'COBRA Eligibility Indicator');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_notification_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA Notification Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|family');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Dependent Count');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `election_date` SET TAGS ('dbx_business_glossary_term' = 'Election Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_work_classification` SET TAGS ('dbx_business_glossary_term' = 'Employee Work Classification');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_work_classification` SET TAGS ('dbx_value_regex' = 'full_time|part_time|seasonal|contract|broadcast_crew|league_official');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_match_rate` SET TAGS ('dbx_business_glossary_term' = 'Employer Match Rate');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_match_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_value_regex' = '^ENR-[0-9]{4}-[0-9]{8}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'open_enrollment|new_hire|qualifying_life_event|rehire|correction');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|pending|waived|terminated|suspended');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_required` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability (EOI) Required Indicator');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_status` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability (EOI) Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|denied');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `fsa_rollover_amount` SET TAGS ('dbx_business_glossary_term' = 'Flexible Spending Account (FSA) Rollover Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `fsa_rollover_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Benefit Group Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `hsa_contribution_limit` SET TAGS ('dbx_business_glossary_term' = 'Health Savings Account (HSA) Annual Contribution Limit');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `hsa_contribution_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `is_aca_eligible` SET TAGS ('dbx_business_glossary_term' = 'Affordable Care Act (ACA) Eligibility Indicator');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `is_tobacco_user` SET TAGS ('dbx_business_glossary_term' = 'Tobacco User Indicator');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `is_tobacco_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `per_pay_period_deduction` SET TAGS ('dbx_business_glossary_term' = 'Per Pay Period Deduction Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `per_pay_period_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Year');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `qualifying_life_event_date` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event (QLE) Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `qualifying_life_event_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event (QLE) Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `retirement_contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Retirement Contribution Rate');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `retirement_contribution_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `safe_harbor_code` SET TAGS ('dbx_business_glossary_term' = 'Affordable Care Act (ACA) Safe Harbor Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `safe_harbor_code` SET TAGS ('dbx_value_regex' = '2A|2B|2C|2D|2E|2F');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Termination Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `wellness_program_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Wellness Program Enrollment Indicator');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` SET TAGS ('dbx_subdomain' = 'workforce_operations');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Manager ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `employment_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `employment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `tertiary_leave_backfill_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Backfill Employee ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `tertiary_leave_backfill_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `tertiary_leave_backfill_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `ada_accommodation_required` SET TAGS ('dbx_business_glossary_term' = 'ADA (Americans with Disabilities Act) Accommodation Required Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Approval Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Approval Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'PENDING|APPROVED|DENIED|CANCELLED|IN_REVIEW|WITHDRAWN');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `approved_days` SET TAGS ('dbx_business_glossary_term' = 'Approved Leave Days');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `approved_hours` SET TAGS ('dbx_business_glossary_term' = 'Approved Leave Hours');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `backfill_required` SET TAGS ('dbx_business_glossary_term' = 'Backfill Required Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `cba_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'CBA (Collective Bargaining Agreement) Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `certification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Due Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Leave Denial Reason');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_notes` SET TAGS ('dbx_business_glossary_term' = 'Employee Leave Notes');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_work_schedule` SET TAGS ('dbx_business_glossary_term' = 'Employee Work Schedule Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `employee_work_schedule` SET TAGS ('dbx_value_regex' = 'FULL_TIME|PART_TIME|SEASONAL|EVENT_DAY|BROADCAST_CREW|ON_CALL');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `fmla_designation_notice_date` SET TAGS ('dbx_business_glossary_term' = 'FMLA (Family and Medical Leave Act) Designation Notice Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `fmla_hours_used` SET TAGS ('dbx_business_glossary_term' = 'FMLA (Family and Medical Leave Act) Hours Used');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `hr_notes` SET TAGS ('dbx_business_glossary_term' = 'HR Notes');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `hr_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `is_fmla_eligible` SET TAGS ('dbx_business_glossary_term' = 'FMLA (Family and Medical Leave Act) Eligibility Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `is_intermittent` SET TAGS ('dbx_business_glossary_term' = 'Intermittent Leave Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `is_paid` SET TAGS ('dbx_business_glossary_term' = 'Paid Leave Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `jury_duty_court_name` SET TAGS ('dbx_business_glossary_term' = 'Jury Duty Court Name');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_end_date` SET TAGS ('dbx_business_glossary_term' = 'Leave End Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_reason` SET TAGS ('dbx_business_glossary_term' = 'Leave Reason');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_start_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Start Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Received Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Required Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `military_order_number` SET TAGS ('dbx_business_glossary_term' = 'Military Order Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `military_order_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `pay_treatment` SET TAGS ('dbx_business_glossary_term' = 'Leave Pay Treatment');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `pay_treatment` SET TAGS ('dbx_value_regex' = 'FULL_PAY|PARTIAL_PAY|UNPAID|STD|LTD');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `pay_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `pay_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `phased_return_plan` SET TAGS ('dbx_business_glossary_term' = 'Phased Return to Work Plan Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `pto_hours_deducted` SET TAGS ('dbx_business_glossary_term' = 'PTO (Paid Time Off) Hours Deducted');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^LR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Submitted Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`leave_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` SET TAGS ('dbx_subdomain' = 'workforce_operations');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `production_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Production Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `contingent_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Contingent Worker Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `credential_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Assignment Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `event_fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `retail_location_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Location Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `staffing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Security Staffing Plan Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'Venue ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Shift End Time');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `actual_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Worked');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Shift Start Time');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `assigned_location` SET TAGS ('dbx_business_glossary_term' = 'Assigned Location');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'scheduled|confirmed|in_progress|completed|cancelled|no_show');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `break_deduction_hours` SET TAGS ('dbx_business_glossary_term' = 'Break Deduction Hours');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `cba_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Rule Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `double_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Double Time Hours');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `event_day_premium_hours` SET TAGS ('dbx_business_glossary_term' = 'Event Day Premium Hours');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `flsa_exemption_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Exemption Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `flsa_exemption_status` SET TAGS ('dbx_value_regex' = 'non_exempt|exempt_executive|exempt_administrative|exempt_professional');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `manager_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Manager Approval Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `manager_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `manager_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manager Approval Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No-Show Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `on_call_hours` SET TAGS ('dbx_business_glossary_term' = 'On-Call Hours');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `osha_hours_of_service_flag` SET TAGS ('dbx_business_glossary_term' = 'OSHA Hours of Service Compliance Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `overtime_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `pay_grade_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `pay_grade_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `payroll_period` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `payroll_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])-(W[1-4]|M)$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `payroll_processing_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processing Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `payroll_processing_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|processed|on_hold|error');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `role_during_shift` SET TAGS ('dbx_business_glossary_term' = 'Role During Shift');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Shift End Time');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Hours');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Shift Start Time');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_notes` SET TAGS ('dbx_business_glossary_term' = 'Shift Notes');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Shift Reference Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_reference_number` SET TAGS ('dbx_value_regex' = '^SHF-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'event_day|broadcast|venue_operations|office|overnight');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `timesheet_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Submission Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `travel_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Travel Time Hours');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `worker_category` SET TAGS ('dbx_business_glossary_term' = 'Worker Category');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`shift_assignment` ALTER COLUMN `worker_category` SET TAGS ('dbx_value_regex' = 'full_time|part_time|seasonal|event_crew|broadcast_crew|league_official');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `development_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Individual Development Plan (IDP) ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `hr_business_partner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'HR Business Partner (HRBP) ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `primary_performance_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_form_id` SET TAGS ('dbx_business_glossary_term' = 'Review Form Template ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `tertiary_performance_hr_business_partner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'HR Business Partner (HRBP) ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `tertiary_performance_hr_business_partner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `tertiary_performance_hr_business_partner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `acknowledged_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibrated_rating` SET TAGS ('dbx_business_glossary_term' = 'Calibrated Performance Rating');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Session Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_session|calibrated|overridden');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `competency_rating` SET TAGS ('dbx_business_glossary_term' = 'Competency Rating');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `development_gap_assessment` SET TAGS ('dbx_business_glossary_term' = 'Development Gap Assessment');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `development_gap_assessment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `goal_achievement_rating` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Rating');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `is_cba_covered` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Covered Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `manager_comments` SET TAGS ('dbx_business_glossary_term' = 'Manager Performance Comments');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `manager_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_pct` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Percentage');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_recommended` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Recommendation Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `nine_box_placement` SET TAGS ('dbx_business_glossary_term' = '9-Box Talent Grid Placement');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `nine_box_placement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating_label` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating Label');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating_label` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `pip_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `pip_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `promotion_recommended` SET TAGS ('dbx_business_glossary_term' = 'Promotion Recommendation Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `readiness_tier` SET TAGS ('dbx_business_glossary_term' = 'Succession Readiness Tier');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `readiness_tier` SET TAGS ('dbx_value_regex' = 'ready_now|one_to_two_years|three_plus_years|not_ready');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `retention_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Retention Risk Rating');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `retention_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `retention_risk_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_cycle_year` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Year');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_number` SET TAGS ('dbx_value_regex' = '^PR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|mid_year|probationary|event_season|pip_checkpoint');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `self_assessment_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Self-Assessment Comments');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `self_assessment_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `self_assessment_rating` SET TAGS ('dbx_business_glossary_term' = 'Employee Self-Assessment Rating');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Review Submitted Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `succession_nominated` SET TAGS ('dbx_business_glossary_term' = 'Succession Nomination Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `workforce_segment` SET TAGS ('dbx_business_glossary_term' = 'Workforce Segment');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`performance_review` ALTER COLUMN `workforce_segment` SET TAGS ('dbx_value_regex' = 'full_time|part_time|seasonal|event_crew|broadcast_crew|league_official');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` SET TAGS ('dbx_subdomain' = 'workforce_operations');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `learning_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Enrollment ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Training Provider Vendor Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Attempt Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `cba_obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Obligation Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Learning Completion Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `credential_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Expiry Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `credential_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Issue Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `credential_number` SET TAGS ('dbx_business_glossary_term' = 'Credential Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `credential_renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Credential Renewal Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `credential_renewal_status` SET TAGS ('dbx_value_regex' = 'current|due_for_renewal|expired|renewed|not_applicable');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `credential_type` SET TAGS ('dbx_value_regex' = 'osha_10|osha_30|first_aid_cpr|broadcast_engineering_license|food_handler_permit|security_license');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `credential_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Credential Verification Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `credential_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|unverified|rejected');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'instructor_led|online_self_paced|virtual_classroom|on_the_job|blended|external_provider');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Training Due Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_value_regex' = '^ENR-[0-9]{8,12}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'self_enrolled|manager_assigned|system_auto_assigned|hr_assigned|compliance_required');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|in_progress|completed|failed|withdrawn|waitlisted');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Training Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `is_recurrent` SET TAGS ('dbx_business_glossary_term' = 'Recurrent Training Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Credential Issuing Authority');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `learning_type` SET TAGS ('dbx_business_glossary_term' = 'Learning Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `learning_type` SET TAGS ('dbx_value_regex' = 'mandatory_compliance|cba_required_safety|broadcast_certification|leadership_development|osha_certification');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `lms_source_code` SET TAGS ('dbx_business_glossary_term' = 'Learning Management System (LMS) Source ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `max_attempts_allowed` SET TAGS ('dbx_business_glossary_term' = 'Maximum Attempts Allowed');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable|pending_assessment');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `recurrence_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Interval (Months)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Learning Start Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `training_cost` SET TAGS ('dbx_business_glossary_term' = 'Training Cost');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `training_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `worker_type` SET TAGS ('dbx_business_glossary_term' = 'Worker Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`learning_enrollment` ALTER COLUMN `worker_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|seasonal|event_crew|broadcast_crew|league_official');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` SET TAGS ('dbx_subdomain' = 'workforce_operations');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `osha_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Incident ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `production_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Production Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `contingent_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Contingent Worker Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Event ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `incident_report_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Report Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `injury_record_id` SET TAGS ('dbx_business_glossary_term' = 'Injury Record Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `insurance_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `litigation_case_id` SET TAGS ('dbx_business_glossary_term' = 'Litigation Case Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Matter Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `security_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `shift_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'Venue ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `amputation_flag` SET TAGS ('dbx_business_glossary_term' = 'Amputation Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `body_part_affected` SET TAGS ('dbx_business_glossary_term' = 'Body Part Affected');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `corrective_action_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completed Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `days_away_from_work` SET TAGS ('dbx_business_glossary_term' = 'Days Away From Work');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `days_restricted_duty` SET TAGS ('dbx_business_glossary_term' = 'Days on Restricted Duty');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type at Time of Incident');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|seasonal|contractor|temporary|volunteer');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `establishment_name` SET TAGS ('dbx_business_glossary_term' = 'OSHA Establishment Name');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `event_activity` SET TAGS ('dbx_business_glossary_term' = 'Event Activity at Time of Incident');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `fatality_flag` SET TAGS ('dbx_business_glossary_term' = 'Fatality Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `hospitalization_flag` SET TAGS ('dbx_business_glossary_term' = 'In-Patient Hospitalization Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `incident_location_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Location Description');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'OSHA Incident Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^OSHA-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|corrective_action_pending|closed|voided');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `incident_time` SET TAGS ('dbx_business_glossary_term' = 'Incident Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'injury|illness|near_miss|fatality|property_damage');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `injury_nature` SET TAGS ('dbx_business_glossary_term' = 'Nature of Injury or Illness');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `investigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Employee Job Title at Time of Incident');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Location Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `lost_consciousness` SET TAGS ('dbx_business_glossary_term' = 'Loss of Consciousness Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `medical_treatment_beyond_first_aid` SET TAGS ('dbx_business_glossary_term' = 'Medical Treatment Beyond First Aid Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `medical_treatment_beyond_first_aid` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `medical_treatment_beyond_first_aid` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `naics_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `osha_case_number` SET TAGS ('dbx_business_glossary_term' = 'OSHA 300 Log Case Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `osha_log_type` SET TAGS ('dbx_business_glossary_term' = 'OSHA Log Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `osha_log_type` SET TAGS ('dbx_value_regex' = '300_log|300a_summary|301_incident_report|not_applicable');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `osha_recordability` SET TAGS ('dbx_business_glossary_term' = 'OSHA Recordability Classification');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `osha_recordability` SET TAGS ('dbx_value_regex' = 'recordable|non_recordable|under_review');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `osha_submission_date` SET TAGS ('dbx_business_glossary_term' = 'OSHA Regulatory Submission Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Reported Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `supervisor_name` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Name at Time of Incident');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `witness_names` SET TAGS ('dbx_business_glossary_term' = 'Incident Witness Names');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `witness_names` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `work_related` SET TAGS ('dbx_business_glossary_term' = 'Work-Related Determination Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `workers_comp_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Claim Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`osha_incident` ALTER COLUMN `workers_comp_claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `employee_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Certification ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `learning_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Enrollment Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `previous_certification_employee_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Certification ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `regulatory_license_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory License Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Training Provider Vendor Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'Venue ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `access_credential_scope` SET TAGS ('dbx_business_glossary_term' = 'Access Credential Scope');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending_verification');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `certification_subtype` SET TAGS ('dbx_business_glossary_term' = 'Certification Subtype');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Certification Cost Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `credential_document_ref` SET TAGS ('dbx_business_glossary_term' = 'Credential Document Reference');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `exam_score` SET TAGS ('dbx_business_glossary_term' = 'Examination Score');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `is_cba_required` SET TAGS ('dbx_business_glossary_term' = 'Is Collective Bargaining Agreement (CBA) Required');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Certification');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `is_osha_required` SET TAGS ('dbx_business_glossary_term' = 'Is OSHA Required');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `issuing_country` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `issuing_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `issuing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Issuing State or Province');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `job_role_requirement` SET TAGS ('dbx_business_glossary_term' = 'Job Role Requirement');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `non_compliance_reason` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Reason');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `passing_score` SET TAGS ('dbx_business_glossary_term' = 'Passing Score');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `renewal_count` SET TAGS ('dbx_business_glossary_term' = 'Renewal Count');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|renewed|overdue');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'sap_successfactors|manual_entry|third_party_import');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `validity_period_months` SET TAGS ('dbx_business_glossary_term' = 'Validity Period (Months)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'manual_review|online_registry|third_party_service|document_upload');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|verified|failed|pending');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employee_certification` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` SET TAGS ('dbx_subdomain' = 'workforce_operations');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `labor_relations_case_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Relations Case Identifier');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `cba_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `incident_report_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Report Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `insurance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `integrity_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Integrity Alert Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `litigation_case_id` SET TAGS ('dbx_business_glossary_term' = 'Litigation Case Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Matter Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `osha_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Osha Incident Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `security_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `suspension_record_id` SET TAGS ('dbx_business_glossary_term' = 'Suspension Record Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `union_id` SET TAGS ('dbx_business_glossary_term' = 'Union ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'Venue ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `appeal_filed` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Indicator');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'pending|upheld|overturned|remanded|withdrawn');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `arbitrator_name` SET TAGS ('dbx_business_glossary_term' = 'Arbitrator Name');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `arbitrator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `case_description` SET TAGS ('dbx_business_glossary_term' = 'Case Description');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `case_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Labor Relations Case Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^LRC-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `case_source` SET TAGS ('dbx_business_glossary_term' = 'Case Source');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `case_source` SET TAGS ('dbx_value_regex' = 'employee_filed|union_filed|management_initiated|regulatory_referral|third_party');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Labor Relations Case Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|under_review|pending_hearing|settled|closed|appealed');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Labor Relations Case Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'grievance|arbitration|disciplinary_action|unfair_labor_practice|cba_dispute|mediation');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `cba_article_reference` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Article Reference');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `disciplinary_action_type` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `disciplinary_action_type` SET TAGS ('dbx_value_regex' = 'verbal_warning|written_warning|suspension|termination|demotion|fine');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `employer_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Employer Representative Name');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `employer_representative_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `external_case_reference` SET TAGS ('dbx_business_glossary_term' = 'External Case Reference Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `filed_date` SET TAGS ('dbx_business_glossary_term' = 'Case Filed Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `fine_amount` SET TAGS ('dbx_business_glossary_term' = 'Fine Amount');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `fine_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `gdpr_applicable` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Applicable Indicator');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `grievance_step` SET TAGS ('dbx_business_glossary_term' = 'Grievance Step');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `grievance_step` SET TAGS ('dbx_value_regex' = 'step_1|step_2|step_3|arbitration|closed');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `hearing_date` SET TAGS ('dbx_business_glossary_term' = 'Hearing Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `legal_counsel_engaged` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Engaged Indicator');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `legal_hold` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Indicator');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `osha_related` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Related Indicator');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `prior_case_count` SET TAGS ('dbx_business_glossary_term' = 'Prior Case Count');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Case Resolution Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Case Resolution Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `resolution_type` SET TAGS ('dbx_value_regex' = 'upheld|overturned|settled|withdrawn|dismissed|modified');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `response_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Response Deadline Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `successfactors_case_code` SET TAGS ('dbx_business_glossary_term' = 'SAP SuccessFactors Case ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `suspension_days` SET TAGS ('dbx_business_glossary_term' = 'Suspension Duration Days');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `union_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Union Representative Name');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `union_representative_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `wada_related` SET TAGS ('dbx_business_glossary_term' = 'World Anti-Doping Agency (WADA) Related Indicator');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`labor_relations_case` ALTER COLUMN `workforce_category` SET TAGS ('dbx_business_glossary_term' = 'Workforce Category');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `employment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Event Identifier');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `cba_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Agreement ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'League Entity ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `credential_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating Manager ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `employment_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'From Organizational Unit ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'From Position ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `venue_id` SET TAGS ('dbx_business_glossary_term' = 'From Venue ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `hr_approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'HR Approver ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `job_application_id` SET TAGS ('dbx_business_glossary_term' = 'Job Application Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `labor_relations_case_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Relations Case Workforce Disciplinary Action Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `primary_employment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `primary_employment_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `primary_employment_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `staff_plan_id` SET TAGS ('dbx_business_glossary_term' = 'From Venue ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `tertiary_employment_hr_approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'HR Approver ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `tertiary_employment_hr_approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `tertiary_employment_hr_approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `to_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'To Organizational Unit ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `to_position_id` SET TAGS ('dbx_business_glossary_term' = 'To Position ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `to_venue_id` SET TAGS ('dbx_business_glossary_term' = 'To Venue ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `to_venue_venue_staff_plan_id` SET TAGS ('dbx_business_glossary_term' = 'To Venue ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `cba_governed` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Governed Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `compensation_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Change Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `compensation_change_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `compensation_change_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `equipment_return_status` SET TAGS ('dbx_business_glossary_term' = 'Equipment Return Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `equipment_return_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|completed|overdue');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Employment Event Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `event_number` SET TAGS ('dbx_value_regex' = '^EE-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Event Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|completed|cancelled');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Event Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'internal_movement|separation');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `exit_interview_completed` SET TAGS ('dbx_business_glossary_term' = 'Exit Interview Completed Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `exit_interview_date` SET TAGS ('dbx_business_glossary_term' = 'Exit Interview Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `exit_reason_category` SET TAGS ('dbx_business_glossary_term' = 'Exit Reason Category');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `exit_reason_category` SET TAGS ('dbx_value_regex' = 'compensation|career_growth|work_environment|personal|relocation|end_of_contract');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `exit_reason_category` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `from_job_grade` SET TAGS ('dbx_business_glossary_term' = 'From Job Grade');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `from_job_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `hr_approval_status` SET TAGS ('dbx_business_glossary_term' = 'HR Approval Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `hr_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `hr_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'HR Approval Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `last_working_date` SET TAGS ('dbx_business_glossary_term' = 'Last Working Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Internal Movement Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = 'lateral_transfer|promotion|demotion|temporary_assignment|inter_league_secondment|venue_to_venue_transfer');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `osha_incident_related` SET TAGS ('dbx_business_glossary_term' = 'OSHA Incident Related Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Event Reason Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Event Reason Description');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `reason_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `rehire_eligible` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligible Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `rehire_restriction_reason` SET TAGS ('dbx_business_glossary_term' = 'Rehire Restriction Reason');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `rehire_restriction_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `secondment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Secondment End Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `separation_type` SET TAGS ('dbx_business_glossary_term' = 'Separation Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `separation_type` SET TAGS ('dbx_value_regex' = 'voluntary_resignation|involuntary_termination|retirement|end_of_seasonal_contract');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `severance_eligible` SET TAGS ('dbx_business_glossary_term' = 'Severance Eligible Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `successfactors_event_code` SET TAGS ('dbx_business_glossary_term' = 'SAP SuccessFactors Event ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `system_access_revocation_date` SET TAGS ('dbx_business_glossary_term' = 'System Access Revocation Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `system_access_revoked` SET TAGS ('dbx_business_glossary_term' = 'System Access Revoked Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `to_job_grade` SET TAGS ('dbx_business_glossary_term' = 'To Job Grade');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `to_job_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `worker_type` SET TAGS ('dbx_business_glossary_term' = 'Worker Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`employment_event` ALTER COLUMN `worker_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|seasonal|broadcast_crew|league_official|event_crew');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `contingent_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Contingent Worker ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Engaging Corporate Entity Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `fixture_id` SET TAGS ('dbx_business_glossary_term' = 'Contingent Worker Assignment - Fixture Id');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplying Vendor Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `referred_by_contingent_worker_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `ada_accommodation_flag` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Accommodation Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `agency_worker_number` SET TAGS ('dbx_business_glossary_term' = 'Agency Worker ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|passed|failed|expired');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `broadcast_crew_role` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Crew Role');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `cba_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `credential_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Expiry Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `credential_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Credential Verified');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `data_privacy_region` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Regulatory Region');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `data_privacy_region` SET TAGS ('dbx_value_regex' = 'EU|US_CCPA|UK_GDPR|CA_PIPEDA|other');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `functional_domain` SET TAGS ('dbx_business_glossary_term' = 'Functional Domain');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `functional_role` SET TAGS ('dbx_business_glossary_term' = 'Functional Role');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `gdpr_consent_status` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `gdpr_consent_status` SET TAGS ('dbx_value_regex' = 'obtained|withdrawn|not_required|pending');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `identity_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `identity_verification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|verified|failed|expired');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `is_union_member` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Legal First Name');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `national_id_hash` SET TAGS ('dbx_business_glossary_term' = 'National Identification Number Hash');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `national_id_hash` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `national_id_hash` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `nationality_code` SET TAGS ('dbx_business_glossary_term' = 'Nationality Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `nationality_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `nationality_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `nationality_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `onboarding_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completion Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `osha_safety_trained` SET TAGS ('dbx_business_glossary_term' = 'OSHA Safety Training Completed Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `osha_training_date` SET TAGS ('dbx_business_glossary_term' = 'OSHA Safety Training Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `pay_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Currency Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `pay_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `pay_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `pay_rate_type` SET TAGS ('dbx_value_regex' = 'hourly|daily|per_event|flat_fee|weekly');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `rehire_eligible` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligibility Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `role_during_event` SET TAGS ('dbx_business_glossary_term' = 'Event Role');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Shift End');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Shift Start');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `successfactors_external_code` SET TAGS ('dbx_business_glossary_term' = 'SAP SuccessFactors External Worker ID');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `tax_form_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Form Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `tax_form_type` SET TAGS ('dbx_value_regex' = 'W9|W8-BEN|W8-BEN-E|1099-NEC|none');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Engagement Termination Reason');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `venue_access_level` SET TAGS ('dbx_business_glossary_term' = 'Venue Access Level');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `venue_access_level` SET TAGS ('dbx_value_regex' = 'none|general_access|field_level|broadcast_compound|backstage|restricted_zone');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `work_authorization_type` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `work_authorization_type` SET TAGS ('dbx_value_regex' = 'citizen|permanent_resident|work_visa|ota_authorization|not_required');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `work_country_code` SET TAGS ('dbx_business_glossary_term' = 'Work Country Code');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `work_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `work_email` SET TAGS ('dbx_business_glossary_term' = 'Work Email Address');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `work_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `work_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `work_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `work_phone` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `work_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `worker_status` SET TAGS ('dbx_business_glossary_term' = 'Contingent Worker Lifecycle Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `worker_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_onboarding|suspended|terminated|do_not_rehire');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `worker_type` SET TAGS ('dbx_business_glossary_term' = 'Contingent Worker Type');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`contingent_worker` ALTER COLUMN `worker_type` SET TAGS ('dbx_value_regex' = 'freelance|event_day_contractor|gig_worker|temporary_staff|agency_worker|independent_contractor');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position_cost_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position_cost_allocation` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position_cost_allocation` SET TAGS ('dbx_association_edges' = 'finance.cost_center,workforce.position');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position_cost_allocation` ALTER COLUMN `position_cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Position Cost Allocation - Position Cost Allocation Id');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position_cost_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Position Cost Allocation - Cost Center Id');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position_cost_allocation` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Cost Allocation - Position Id');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position_cost_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position_cost_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position_cost_allocation` ALTER COLUMN `budget_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position_cost_allocation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective End Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position_cost_allocation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective Start Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position_cost_allocation` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'FTE Allocation');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position_cost_allocation` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position_cost_allocation` ALTER COLUMN `headcount_plan_year` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Year');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position_cost_allocation` ALTER COLUMN `is_primary_cost_center` SET TAGS ('dbx_business_glossary_term' = 'Primary Cost Center Flag');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`position_cost_allocation` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`jurisdiction_license` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`jurisdiction_license` SET TAGS ('dbx_subdomain' = 'personnel_administration');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`jurisdiction_license` SET TAGS ('dbx_association_edges' = 'workforce.employee,gaming.gaming_jurisdiction');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`jurisdiction_license` ALTER COLUMN `jurisdiction_license_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction License - Jurisdiction License Id');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`jurisdiction_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction License - Employee Id');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`jurisdiction_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`jurisdiction_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`jurisdiction_license` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction License - Gaming Jurisdiction Id');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`jurisdiction_license` ALTER COLUMN `assigned_role` SET TAGS ('dbx_business_glossary_term' = 'Assigned Regulatory Role');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`jurisdiction_license` ALTER COLUMN `assigned_role` SET TAGS ('dbx_compliance' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`jurisdiction_license` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'License Effective Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`jurisdiction_license` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiry Date');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`jurisdiction_license` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction License Number');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`jurisdiction_license` ALTER COLUMN `license_number` SET TAGS ('dbx_compliance_sensitive' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`jurisdiction_license` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`jurisdiction_license` ALTER COLUMN `license_status` SET TAGS ('dbx_compliance' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_plan` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `superseded_benefit_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`open_enrollment_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`open_enrollment_period` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`open_enrollment_period` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Identifier');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`open_enrollment_period` ALTER COLUMN `prior_open_enrollment_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`requisition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`requisition` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`requisition` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Identifier');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`requisition` ALTER COLUMN `replacement_for_requisition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`requisition` ALTER COLUMN `salary_range_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`requisition` ALTER COLUMN `salary_range_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `candidate_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate Identifier');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `referred_by_candidate_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `background_check_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `background_check_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `cover_letter_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `desired_salary_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `desired_salary_max` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `desired_salary_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `desired_salary_min` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `disability_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `drug_test_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `drug_test_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `offer_accepted_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `offer_extended_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `resume_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `screening_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `veteran_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`candidate` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`union` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`union` SET TAGS ('dbx_subdomain' = 'workforce_operations');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`union` ALTER COLUMN `union_id` SET TAGS ('dbx_business_glossary_term' = 'Union Identifier');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`union` ALTER COLUMN `parent_union_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`union` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`union` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`union` ALTER COLUMN `contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`union` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`union` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`union` ALTER COLUMN `office_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`union` ALTER COLUMN `office_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`union` ALTER COLUMN `office_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`union` ALTER COLUMN `office_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`union` ALTER COLUMN `office_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`union` ALTER COLUMN `office_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`union` ALTER COLUMN `office_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`union` ALTER COLUMN `office_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`union` ALTER COLUMN `office_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`union` ALTER COLUMN `office_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`course` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`course` SET TAGS ('dbx_subdomain' = 'workforce_operations');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`course` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course Identifier');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`course` ALTER COLUMN `prerequisite_course_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`course` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_run` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Identifier');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`payroll_run` ALTER COLUMN `reversal_payroll_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`review_form` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`review_form` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`review_form` ALTER COLUMN `review_form_id` SET TAGS ('dbx_business_glossary_term' = 'Review Form Identifier');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`review_form` ALTER COLUMN `derived_from_review_form_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`development_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`development_plan` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`development_plan` ALTER COLUMN `development_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Identifier');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`development_plan` ALTER COLUMN `superseded_development_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`development_plan` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`development_plan` ALTER COLUMN `estimated_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`competency_framework` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`competency_framework` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`competency_framework` ALTER COLUMN `competency_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Framework Identifier');
ALTER TABLE `sports_entertainment_ecm`.`workforce`.`competency_framework` ALTER COLUMN `parent_competency_framework_id` SET TAGS ('dbx_self_ref_fk' = 'true');
