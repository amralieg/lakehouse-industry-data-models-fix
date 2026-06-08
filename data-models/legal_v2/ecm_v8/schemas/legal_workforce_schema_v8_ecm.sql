-- Schema for Domain: workforce | Business: Legal | Version: v8_ecm
-- Generated on: 2026-05-21 01:11:39

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `legal_ecm_v1`.`workforce` COMMENT 'Manages all timekeeper, attorney, paralegal, and staff human capital data including attorney bar admissions, CPD/CLE tracking, performance management, compensation structures (FTE, equity partner tiers, PPP, PEP, RPE), recruitment, succession planning, and resource allocation across matters. SAP SuccessFactors is the system of record.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `legal_ecm_v1`.`workforce`.`timekeeper` (
    `timekeeper_id` BIGINT COMMENT 'Unique surrogate identifier for every fee-earner or staff member in the firm. Primary key for the timekeeper master record; referenced by billing, matter, conflict, and intake domains as the single source of truth for timekeeper identity. Entity role: MASTER_PARTY.',
    `employee_id` BIGINT COMMENT 'The unique employee identifier assigned by SAP SuccessFactors, the system of record for human capital management. Used to cross-reference HR records for compensation, performance, and learning data. Serves as the operational HR system key.',
    `supervisor_employee_timekeeper_id` BIGINT COMMENT 'The SAP SuccessFactors employee ID of the timekeepers direct supervisor or supervising attorney. Used for performance management hierarchies, matter supervision compliance, and organisational reporting structures. Self-referencing relationship within the timekeeper population.',
    `admission_multi_jurisdiction` BOOLEAN COMMENT 'Indicates whether the attorney timekeeper holds bar admissions in more than one jurisdiction. Used for matter assignment eligibility across jurisdictions, cross-border transaction staffing, and conflict check scope determination in Intapp Conflicts.',
    `annual_billable_hours_target` DECIMAL(18,2) COMMENT 'The annual billable hours target assigned to the timekeeper for performance management and compensation purposes. Used in utilisation rate calculations, performance review benchmarking, and Legal Project Management (LPM) capacity planning.',
    `bar_admission_date` DATE COMMENT 'The date on which the attorney timekeeper was first admitted to the bar in their primary jurisdiction. Used to calculate years of post-qualification experience (PQE), seniority benchmarking, and partnership track eligibility assessments.',
    `bar_admission_jurisdiction` STRING COMMENT 'The primary jurisdiction (state, country, or territory) in which the attorney timekeeper is admitted to practise law. Used for matter assignment eligibility, court appearance authorisation, and regulatory compliance reporting. Null for non-attorney timekeepers.',
    `bar_number` STRING COMMENT 'The official bar admission number issued by the relevant state bar or law society to the attorney timekeeper. Required for court filings, ECF registration, regulatory compliance, and verification of attorney standing. Null for non-attorney timekeepers.',
    `bar_status` STRING COMMENT 'Current standing of the attorney timekeepers bar admission in their primary jurisdiction. Active status is required for matter assignment and client representation. Suspended or disbarred status triggers immediate matter reassignment and regulatory notification workflows.. Valid values are `active|inactive|suspended|disbarred|retired`',
    `billing_rate_tier` STRING COMMENT 'The standard billing rate tier code assigned to the timekeeper in the billing system (Elite 3E / Aderant Expert). Determines the default hourly rate applied to time entries before client-specific rate overrides or Alternative Fee Arrangements (AFA) are applied. Referenced by the billing.timekeeper_rate product.',
    `biography` STRING COMMENT 'The timekeepers professional biography narrative for use in client-facing materials, firm website directory listings, pitch documents, and Request for Proposal (RFP) responses. Maintained in the firms CRM (Microsoft Dynamics 365) and HR system.',
    `cost_center_code` STRING COMMENT 'The financial cost center code to which the timekeepers compensation and overhead costs are allocated in the firms general ledger (Elite 3E GL). Used for practice group profitability analysis, budget variance reporting, and financial consolidation.',
    `cpd_compliance_period_end` DATE COMMENT 'The end date of the current CPD/CLE compliance reporting period for the timekeepers primary bar jurisdiction. Used to trigger compliance alerts and reporting to state bar associations or the SRA.',
    `cpd_hours_completed` DECIMAL(18,2) COMMENT 'The number of CPD/CLE hours completed by the timekeeper in the current compliance period. Compared against cpd_hours_required to determine compliance status. Sourced from SAP SuccessFactors Learning module.',
    `cpd_hours_required` DECIMAL(18,2) COMMENT 'The annual Continuing Professional Development (CPD) / Continuing Legal Education (CLE) hours required for the timekeeper to maintain their bar admission and professional standing in their jurisdiction. Drives compliance tracking in SAP SuccessFactors Learning.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the timekeeper master record was first created in the system. Used for data lineage, audit trail compliance, and record provenance tracking. RECORD_AUDIT_CREATED for MASTER_PARTY role.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the timekeepers standard billing rate (e.g., USD, GBP, EUR). Required for multi-currency firm environments and cross-border matter billing.. Valid values are `^[A-Z]{3}$`',
    `employment_status` STRING COMMENT 'Current lifecycle status of the timekeepers employment at the firm. Controls system access provisioning, billing eligibility, matter assignment availability, and conflict check participation. LIFECYCLE_STATUS for MASTER_PARTY role.. Valid values are `active|on_leave|terminated|retired|suspended`',
    `employment_type` STRING COMMENT 'Classification of the timekeepers employment arrangement with the firm. Drives Full-Time Equivalent (FTE) calculations, benefit eligibility, billing rate tier assignment, and workforce planning analytics. CLASSIFICATION_OR_TYPE for MASTER_PARTY role.. Valid values are `full_time|part_time|contract|secondment|of_counsel`',
    `firm_office_location` STRING COMMENT 'The primary office or geographic location where the timekeeper is based. Used for resource allocation, jurisdictional billing rate assignment, office-level profitability reporting, and conflict of interest geographic analysis.',
    `first_name` STRING COMMENT 'Given name of the timekeeper. Used in internal directories, system displays, and personalised communications. Decomposed from full_name for search and sorting purposes.',
    `fte_percentage` DECIMAL(18,2) COMMENT 'The timekeepers contracted Full-Time Equivalent (FTE) percentage, where 100.00 represents a full-time position. Used for capacity planning, pro-rated compensation calculations, billable hours target setting, and workforce headcount reporting.',
    `full_name` STRING COMMENT 'The full legal name of the timekeeper as it appears on bar admission records, engagement letters, and client-facing directories. Used for billing narratives, court filings, and professional biography publications. IDENTITY_LABEL for MASTER_PARTY role.',
    `hire_date` DATE COMMENT 'The date on which the timekeeper commenced employment or engagement with the firm. Used for seniority calculations, partnership track eligibility, benefit accrual, and workforce tenure analytics.',
    `is_billing_timekeeper` BOOLEAN COMMENT 'Indicates whether the timekeeper is authorised to record billable time entries against client matters. Non-billing staff (e.g., administrative support) are excluded from billing workflows in Elite 3E and Aderant Expert. Controls time entry system access.',
    `is_equity_partner` BOOLEAN COMMENT 'Indicates whether the timekeeper holds equity partner status in the firm. Equity partners participate in Profit Per Equity Partner (PEP) and Profit Per Partner (PPP) distributions. Drives partnership compensation calculations and governance reporting.',
    `is_partnership_track` BOOLEAN COMMENT 'Indicates whether the timekeeper is currently on the firms partnership track programme. Used for succession planning, performance management targeting, and mentorship programme assignment in SAP SuccessFactors.',
    `languages_spoken` STRING COMMENT 'Comma-separated list of ISO 639-1 language codes representing languages in which the timekeeper is professionally proficient. Used for international matter staffing, client communication matching, and cross-border transaction team assembly.',
    `last_name` STRING COMMENT 'Family name of the timekeeper. Used in alphabetical directory listings, bar admission lookups, and billing system identification. Decomposed from full_name for search and sorting purposes.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the timekeeper master record was most recently modified. Used for change data capture (CDC) in the Databricks Silver Layer pipeline, audit trail compliance, and downstream system synchronisation.',
    `law_school` STRING COMMENT 'The name of the law school or university from which the timekeeper obtained their primary legal qualification (JD, LLB, LLM). Used in professional biography publications, client-facing directory listings, and lateral hire credential verification.',
    `law_school_graduation_year` STRING COMMENT 'The calendar year in which the timekeeper graduated from law school. Used to calculate class year seniority, benchmark compensation against peer cohorts, and support partnership track timeline analysis.',
    `lpp_designation` BOOLEAN COMMENT 'Indicates whether the timekeeper holds a Legal Professional Privilege (LPP) designation, meaning their communications and work product may attract privilege protection. Used in eDiscovery (Relativity) privilege review workflows, document tagging, and litigation hold management.',
    `practice_specializations` STRING COMMENT 'Comma-separated list of the timekeepers declared legal practice specializations (e.g., M&A, IP Litigation, Employment, Regulatory Compliance). Used for matter staffing recommendations, client directory listings, and knowledge management tagging in Thomson Reuters Practical Law.',
    `preferred_name` STRING COMMENT 'The name the timekeeper prefers to use professionally, which may differ from their legal name. Used in client-facing materials, email signatures, and directory listings where the preferred name is authorised.',
    `primary_practice_group_id` BIGINT COMMENT 'FK to workforce.practice_group.practice_group_id — Every timekeeper is assigned to a practice group. This is the primary organizational hierarchy link for staffing and financial reporting.',
    `pro_bono_hours_target` DECIMAL(18,2) COMMENT 'The annual pro bono hours target assigned to the timekeeper, consistent with American Bar Association (ABA) aspirational guidelines of 50 hours per year. Used for pro bono programme compliance tracking, performance review, and firm-level pro bono reporting.',
    `seniority_level` STRING COMMENT 'The professional seniority tier of the timekeeper within the firm hierarchy. Drives billing rate tier assignment, Profit Per Partner (PPP), Profit Per Equity Partner (PEP), and Revenue Per Equity Partner (RPE) analytics. Critical for partnership track reporting and compensation modelling. [ENUM-REF-CANDIDATE: associate|senior_associate|counsel|senior_counsel|partner|equity_partner|of_counsel|managing_partner|non_equity_partner — promote to reference product]',
    `standard_hourly_rate` DECIMAL(18,2) COMMENT 'The timekeepers standard rack-rate hourly billing rate in the firms base currency. Used as the default rate for time entry valuation before client-specific rate agreements, Alternative Fee Arrangements (AFA), or volume discounts are applied. Stored in billing.timekeeper_rate for rate history; this field holds the current effective rate.',
    `termination_date` DATE COMMENT 'The date on which the timekeepers employment or engagement with the firm ended. Null for active timekeepers. Used to deactivate billing access, close matter assignments, and trigger offboarding workflows in SAP SuccessFactors.',
    `timekeeper_type` STRING COMMENT 'Categorical classification of the timekeepers professional role within the firm. Determines billing eligibility, rate tier, UTBMS classification, and matter staffing rules. Used in LEDES invoice generation and client billing guidelines compliance.. Valid values are `attorney|paralegal|legal_assistant|law_clerk|staff|contract_attorney`',
    `utbms_timekeeper_code` STRING COMMENT 'The firm-assigned UTBMS timekeeper code used in LEDES-formatted invoices and electronic billing submissions to clients and insurers. Required for e-billing compliance and client matter billing feeds. Aligns with UTBMS coding standards.. Valid values are `^[A-Z0-9]{2,20}$`',
    `work_email` STRING COMMENT 'Primary corporate email address for the timekeeper. Used for matter communications, client correspondence, DMS access provisioning, and system notifications. PRIMARY_CONTACT for MASTER_PARTY role.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `work_phone` STRING COMMENT 'Direct office telephone number for the timekeeper. Used for client contact, internal directory, and matter team coordination. Stored in E.164-compatible format.. Valid values are `^+?[0-9s-().]{7,20}$`',
    CONSTRAINT pk_timekeeper PRIMARY KEY(`timekeeper_id`)
) COMMENT 'Master record for every fee-earner and staff member who records time or performs billable/non-billable work at the firm. Captures attorney, paralegal, and support staff identity, employment classification (FTE, part-time, contract), bar admission status, practice group, office location, UTBMS timekeeper code, standard billing rate tier, seniority level (associate, senior associate, counsel, partner, equity partner), SAP SuccessFactors employee ID, and extended professional profile attributes including law school, graduation year, practice specializations, languages spoken, partnership track status, PPP/PEP participation flag, pro bono hours target, LPP designation, and professional biography for client-facing materials and directory listings. This is the SSOT for timekeeper identity and professional credentials referenced by billing, matter, conflict, and intake domains.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`workforce`.`attorney_profile` (
    `attorney_profile_id` BIGINT COMMENT 'Unique surrogate identifier for the attorney profile record in the Silver Layer lakehouse. Primary key for this entity. Role classification: MASTER_PARTY — represents a licensed legal professional (person) the firm employs and interacts with as a credentialed practitioner.',
    `practice_group_id` BIGINT COMMENT 'Foreign key linking to workforce.practice_group. Business justification: Attorneys belong to practice groups as a core organizational relationship. The attorney_profile table currently has practice_group_code (STRING) but no FK to practice_group. This normalization establi',
    `timekeeper_id` BIGINT COMMENT 'Reference to the core timekeeper master record in Elite 3E, which holds employment identity and billing attributes. This profile extends that record with legal-specific credentials and career attributes not held on the timekeeper record.',
    `to_timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Every attorney_profile extends exactly one timekeeper record. This is the most fundamental 1:1 extension relationship in the domain — without it, attorney credentials cannot be associated with the fee',
    `admission_jurisdiction_summary` STRING COMMENT 'Comma-separated summary list of jurisdictions in which the attorney holds active bar admission or practising certificate (e.g., NY, CA, England & Wales). This is a denormalised summary view for quick reference and directory display; full detail is held in the bar_admission product.',
    `afa_eligible_flag` BOOLEAN COMMENT 'Indicates whether the attorney is eligible to be staffed on matters billed under Alternative Fee Arrangements (AFA), such as fixed fees, capped fees, or success fees. Drives billing configuration in Elite 3E and Aderant Expert.',
    `attorney_type` STRING COMMENT 'Classification of the legal professional by credential type, distinguishing attorneys (US), solicitors and barristers (UK/Commonwealth), paralegals, and legal executives. Drives jurisdiction-specific compliance and billing rate rules.. Valid values are `Attorney|Solicitor|Barrister|Paralegal|Legal Executive`',
    `bar_number` STRING COMMENT 'Primary bar admission or practising certificate number issued by the attorneys principal licensing jurisdiction. Uniquely identifies the attorney as a licensed legal practitioner. Used in court filings, Electronic Case Filing (ECF), and conflict checks in Intapp Conflicts.',
    `chambers_ranking` STRING COMMENT 'Current Chambers & Partners directory ranking band for the attorney (e.g., Band 1, Band 2, Up and Coming, Recognised Practitioner). Used in business development, pitch materials, and competitive benchmarking.',
    `conflict_check_clearance_status` STRING COMMENT 'Current conflict-of-interest clearance status for the attorney as maintained in Intapp Conflicts. Flagged status prevents the attorney from being assigned to new matters until the conflict is resolved or a waiver is obtained per ABA Model Rules.. Valid values are `cleared|pending|flagged|waived`',
    `cpd_annual_hours_target` DECIMAL(18,2) COMMENT 'Annual target number of Continuing Professional Development (CPD) or Continuing Legal Education (CLE) hours the attorney must complete to maintain bar admission and firm compliance. Jurisdiction-specific minimums are tracked in the bar_admission product.',
    `cpd_compliance_status` STRING COMMENT 'Current CPD/CLE compliance status of the attorney for the active reporting period. Non-compliant status may trigger bar suspension risk and must be escalated to the firms General Counsel (GC) or Chief Legal Officer (CLO).. Valid values are `compliant|at_risk|non_compliant|exempt`',
    `cpd_hours_completed_ytd` DECIMAL(18,2) COMMENT 'Cumulative number of CPD/CLE hours completed by the attorney in the current reporting year to date. Compared against the annual target to assess compliance status. Sourced from SAP SuccessFactors Learning Management.',
    `data_privacy_certified_flag` BOOLEAN COMMENT 'Indicates whether the attorney has completed mandatory data privacy training covering GDPR, CCPA, and the Data Protection Act (DPA). Required for attorneys advising on data protection matters or handling Personally Identifiable Information (PII) in client engagements.',
    `directory_listing_flag` BOOLEAN COMMENT 'Indicates whether the attorneys profile is approved for publication in external legal directories (e.g., Chambers & Partners, Legal 500) and the firms public-facing website. Controls visibility in client-facing marketing materials.',
    `ethical_wall_flag` BOOLEAN COMMENT 'Indicates whether the attorney is currently subject to an ethical wall (information barrier) in Intapp Conflicts, restricting their access to specific matters or client information to manage conflicts of interest.',
    `firm_office_location_code` STRING COMMENT 'Code identifying the firm office or geographic location to which the attorney is primarily assigned (e.g., NYC, LON, HKG). Used for resource allocation, matter staffing across offices, and workforce reporting.',
    `fte_classification` STRING COMMENT 'Employment basis classification of the attorney, indicating whether they are a Full-Time Equivalent (FTE) employee, part-time, on secondment to a client, or engaged as Of Counsel. Drives resource capacity planning and billing rate eligibility.. Valid values are `full_time|part_time|contract|secondment|of_counsel`',
    `fte_percentage` DECIMAL(18,2) COMMENT 'The proportion of full-time hours the attorney is contracted to work, expressed as a percentage (e.g., 100.00 for full-time, 50.00 for half-time). Used in capacity planning, matter staffing, and workforce analytics in SAP SuccessFactors.',
    `full_name` STRING COMMENT 'Full legal name of the attorney or solicitor as it appears on bar admission records and client-facing materials, including directory listings and engagement letters.',
    `hire_date` DATE COMMENT 'Date on which the attorney commenced employment or engagement with the firm. Used to calculate firm tenure, vesting schedules, and seniority for compensation and partnership track purposes in SAP SuccessFactors.',
    `industry_sector_focus` STRING COMMENT 'Comma-separated list of client industry sectors in which the attorney has specialised experience (e.g., Financial Services, Technology, Healthcare, Energy). Used for client relationship management in Microsoft Dynamics 365 and pitch targeting.',
    `is_equity_partner` BOOLEAN COMMENT 'Indicates whether the attorney is a current equity partner of the firm, participating in profit distributions. Drives Profit Per Partner (PPP) and Profit Per Equity Partner (PEP) calculations and Revenue Per Equity Partner (RPE) reporting.',
    `kyc_aml_certification_date` DATE COMMENT 'Date on which the attorney most recently completed KYC/AML certification training. Used to determine certification currency and trigger renewal reminders per FATF and SRA requirements.',
    `kyc_aml_certified_flag` BOOLEAN COMMENT 'Indicates whether the attorney has completed mandatory Know Your Client (KYC) and Anti-Money Laundering (AML) certification training required for client intake and matter opening. Non-certified attorneys may not supervise new client onboarding.',
    `languages_spoken` STRING COMMENT 'Comma-separated list of languages in which the attorney is professionally proficient, using ISO 639-1 language codes (e.g., en,fr,de,zh). Used for international matter staffing, client communication, and directory listings.',
    `law_degree_type` STRING COMMENT 'Type of primary legal qualification awarded by the law school (e.g., Juris Doctor (JD) in the US, Bachelor of Laws (LLB) in the UK/Commonwealth, Master of Laws (LLM) for postgraduate). Determines eligibility for bar admission in specific jurisdictions. [ENUM-REF-CANDIDATE: JD|LLB|LLM|BCL|SJD|LLD|BL — 7 candidates stripped; promote to reference product]',
    `law_school` STRING COMMENT 'Name of the law school or faculty of law from which the attorney obtained their primary legal qualification (JD, LLB, LLM, or equivalent). Used in directory listings, pitch materials, and credential verification.',
    `law_school_graduation_year` STRING COMMENT 'Calendar year in which the attorney graduated from law school with their primary legal degree (JD, LLB, or equivalent). Used to calculate years of post-qualification experience (PQE) and seniority benchmarking.',
    `lpm_certified_flag` BOOLEAN COMMENT 'Indicates whether the attorney holds a recognised Legal Project Management (LPM) certification, qualifying them to lead matter budgeting, scoping, and project governance under Alternative Fee Arrangements (AFA).',
    `lpp_designation` BOOLEAN COMMENT 'Indicates whether the attorney holds a recognised Legal Professional Privilege (LPP) designation, confirming their status as a qualified legal adviser whose communications with clients are privileged. Critical for eDiscovery privilege review, document tagging in iManage Work, and Relativity privilege logs.',
    `partnership_track_status` STRING COMMENT 'Current status of the attorneys progression toward equity or non-equity partnership. Confidential HR data used in succession planning, compensation modelling, and workforce analytics. Managed in SAP SuccessFactors Performance & Goals.. Valid values are `not_on_track|on_track|nominated|elected|deferred|withdrawn`',
    `ppp_pep_participation_flag` BOOLEAN COMMENT 'Indicates whether the attorney participates in the firms Profit Per Partner (PPP) or Profit Per Equity Partner (PEP) compensation pool. Used in financial reporting, partner compensation analytics, and benchmarking against industry PPP/PEP metrics.',
    `preferred_name` STRING COMMENT 'Preferred or commonly used name of the attorney for internal communications and informal directory listings, which may differ from the full legal name.',
    `primary_admission_date` DATE COMMENT 'Date on which the attorney was first admitted to the bar or granted a practising certificate in their primary jurisdiction. Used to calculate years of post-qualification experience (PQE) and seniority for compensation benchmarking.',
    `primary_practice_area` STRING COMMENT 'The attorneys principal area of legal specialisation (e.g., Corporate M&A, Litigation, Intellectual Property, Employment Law, Regulatory Compliance). Used for matter staffing, resource allocation, and directory categorisation. [ENUM-REF-CANDIDATE: Corporate M&A|Litigation|Intellectual Property|Employment|Regulatory Compliance|Real Estate|Tax|Finance|Restructuring|Arbitration — promote to reference product]',
    `pro_bono_hours_target` DECIMAL(18,2) COMMENT 'Annual target number of pro bono hours the attorney is expected to contribute, as set by firm policy or American Bar Association (ABA) aspirational guidelines (50 hours per year). Used in pro bono programme tracking and attorney performance reviews.',
    `professional_biography` STRING COMMENT 'Narrative professional biography of the attorney used in client-facing materials, firm website directory listings, pitch documents, and Request for Proposal (RFP) responses. Maintained in SAP SuccessFactors and published via Microsoft Dynamics 365 CRM.',
    `professional_title` STRING COMMENT 'Formal professional title of the attorney within the firm hierarchy, used in client-facing materials, directory listings, and engagement letters. [ENUM-REF-CANDIDATE: Partner|Senior Associate|Associate|Of Counsel|Counsel|Paralegal|Legal Director|Solicitor|Barrister|Senior Partner|Managing Partner — promote to reference product]',
    `profile_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the attorney profile record was first created in the Silver Layer lakehouse, sourced from SAP SuccessFactors. Serves as the record audit creation timestamp for data lineage and compliance purposes.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the attorney profile record. Active indicates the attorney is currently practising at the firm. Suspended may reflect a bar disciplinary action or internal investigation. Drives access controls and conflict-check eligibility.. Valid values are `active|inactive|on_leave|suspended|terminated`',
    `profile_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the attorney profile record was most recently modified in the Silver Layer lakehouse. Used for data freshness monitoring, incremental ETL processing, and audit trail compliance under GDPR and ISO 27001.',
    `secondary_practice_areas` STRING COMMENT 'Comma-separated list of secondary or ancillary practice areas in which the attorney has demonstrated competency, supplementing the primary practice area. Used for cross-selling, matter staffing, and capability mapping in pitches.',
    `years_post_qualification` STRING COMMENT 'Number of complete years of post-qualification experience (PQE) since the attorneys primary bar admission date. Used for seniority classification, billing rate banding, matter staffing, and compensation benchmarking. Derived from primary_admission_date but stored for reporting efficiency.',
    CONSTRAINT pk_attorney_profile PRIMARY KEY(`attorney_profile_id`)
) COMMENT 'Extended professional profile for attorneys and solicitors, supplementing the core timekeeper master record with legal-specific credentials and career attributes NOT held on the timekeeper record. Stores law school, graduation year, jurisdictions of admission (summary view — detail in bar_admission), practice specializations, languages spoken, pro bono hours target, LPP designation, partnership track status, PPP/PEP participation flag, and professional biography used in client-facing materials and directory listings. Distinguished from timekeeper by holding career/credential attributes rather than employment/billing identity. Sourced from SAP SuccessFactors and supplemented by bar admission records.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`workforce`.`bar_admission` (
    `bar_admission_id` BIGINT COMMENT 'Unique identifier for the bar admission record. Primary key for the bar admission entity.',
    `timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Bar admissions belong to a specific attorney/timekeeper. This FK is critical for conflict checking and matter staffing eligibility validation.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key to matter.jurisdiction.jurisdiction_id',
    `primary_bar_timekeeper_id` BIGINT COMMENT 'Identifier of the attorney or legal professional who holds this bar admission. Links to the timekeeper master record in the workforce domain.',
    `matter_id` BIGINT COMMENT 'For pro hac vice admissions, the identifier of the specific matter or case for which temporary admission was granted. Pro hac vice admissions are case-specific and expire when the matter concludes. Null for permanent bar admissions.',
    `to_timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Each bar admission belongs to a specific attorney/timekeeper. Required for conflict checking eligibility, matter staffing validation, and regulatory compliance.',
    `admission_date` DATE COMMENT 'The date on which the attorney was officially admitted to practice law in this jurisdiction. This is the effective start date of the bar admission.',
    `admission_status` STRING COMMENT 'The current lifecycle status of the bar admission. Active indicates the attorney is in good standing and authorized to practice; inactive indicates the attorney has voluntarily placed the license on inactive status; suspended indicates temporary disciplinary suspension; disbarred indicates permanent revocation; retired indicates voluntary retirement from practice; resigned indicates voluntary resignation from the bar.. Valid values are `active|inactive|suspended|disbarred|retired|resigned`',
    `admission_type` STRING COMMENT 'The method by which the attorney was admitted to the bar. Examination indicates passing the bar exam; motion indicates admission without examination based on prior practice; reciprocity indicates admission based on another jurisdictions bar membership; pro hac vice indicates temporary admission for a specific case; in-house counsel indicates limited admission for corporate legal department work.. Valid values are `examination|motion|reciprocity|pro_hac_vice|in_house_counsel`',
    `annual_fee_amount` DECIMAL(18,2) COMMENT 'The annual or periodic membership fee required to maintain this bar admission in good standing. Amount is in the local currency of the jurisdiction.',
    `bar_association_website` STRING COMMENT 'The official website URL of the governing bar association. Used for reference and verification of admission status and requirements.',
    `bar_belongs_to_timekeeper` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Every bar admission record must reference the attorney it belongs to. Critical for conflict checking and matter staffing eligibility validation.',
    `bar_number` STRING COMMENT 'The unique registration or license number issued by the bar association or regulatory authority upon admission. This is the externally-known identifier for the attorney in that jurisdiction.',
    `cle_compliance_status` STRING COMMENT 'Indicates whether the attorney is in compliance with the CLE or CPD requirements for this jurisdiction. Compliant indicates all requirements are met; non-compliant indicates requirements are not met; pending verification indicates CLE credits are submitted but not yet verified; exempt indicates the attorney is exempt from CLE requirements.. Valid values are `compliant|non_compliant|pending_verification|exempt`',
    `cle_hours_completed_current_period` DECIMAL(18,2) COMMENT 'The number of CLE or CPD hours the attorney has completed in the current reporting period for this jurisdiction. Used to track compliance with mandatory continuing education requirements.',
    `cle_hours_required_annual` DECIMAL(18,2) COMMENT 'The number of Continuing Legal Education (CLE) or Continuing Professional Development (CPD) hours required annually by this jurisdiction to maintain the bar admission in good standing.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this bar admission record was first created in the system. Used for audit trail and data lineage tracking.',
    `disciplinary_action_count` STRING COMMENT 'The total number of formal disciplinary actions taken against this attorney by the bar association in this jurisdiction over the lifetime of the admission. Used for risk assessment and matter staffing decisions.',
    `disciplinary_standing` STRING COMMENT 'The current disciplinary status of the attorney with the bar association. Good standing indicates no disciplinary issues; under investigation indicates an active disciplinary inquiry; probation indicates the attorney is under disciplinary probation; suspended indicates temporary disciplinary suspension; disbarred indicates permanent revocation of the license to practice.. Valid values are `good_standing|under_investigation|probation|suspended|disbarred`',
    `eligibility_for_matter_staffing_flag` BOOLEAN COMMENT 'Boolean indicator of whether this bar admission qualifies the attorney to be staffed on matters in this jurisdiction. True indicates the attorney is eligible (active status, good standing, no practice restrictions); False indicates the attorney is not eligible due to inactive status, disciplinary issues, or practice restrictions. Critical for conflict checking and resource allocation.',
    `fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the annual fee amount (e.g., USD, GBP, EUR, CAD, AUD).. Valid values are `^[A-Z]{3}$`',
    `fee_payment_status` STRING COMMENT 'The current payment status of the annual bar membership fee. Current indicates fees are paid and up to date; overdue indicates fees are past due; waived indicates fees have been waived by the bar association; exempt indicates the attorney is exempt from fees (e.g., retired status, pro bono service).. Valid values are `current|overdue|waived|exempt`',
    `governing_bar_association` STRING COMMENT 'The name of the bar association or regulatory authority that governs this bar admission and enforces professional conduct rules (e.g., State Bar of California, New York State Bar Association, Solicitors Regulation Authority, Law Society of England and Wales).',
    `last_disciplinary_action_date` DATE COMMENT 'The date of the most recent formal disciplinary action taken against this attorney by the bar association in this jurisdiction. Null if no disciplinary actions have been taken.',
    `last_fee_payment_date` DATE COMMENT 'The date on which the most recent bar membership fee payment was received and processed by the bar association.',
    `malpractice_insurance_compliance_status` STRING COMMENT 'Indicates whether the attorney is in compliance with professional liability insurance requirements for this jurisdiction. Compliant indicates insurance is current; non-compliant indicates insurance is lapsed or insufficient; exempt indicates the attorney is exempt from the requirement; not required indicates the jurisdiction does not mandate insurance.. Valid values are `compliant|non_compliant|exempt|not_required`',
    `malpractice_insurance_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this jurisdiction requires attorneys to maintain professional liability (malpractice) insurance as a condition of bar membership. True indicates insurance is required; False indicates it is not required.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special circumstances related to this bar admission. May include details about conditional admissions, pending appeals, special accommodations, or historical context.',
    `practice_restriction_description` STRING COMMENT 'Detailed description of any practice restrictions or limitations associated with this bar admission. Examples include limited to corporate in-house counsel, limited to federal practice, limited to specific counties, or subject to supervision requirements.',
    `practice_restriction_flag` BOOLEAN COMMENT 'Boolean indicator of whether this bar admission has any practice restrictions or limitations imposed by the bar association (e.g., limited to in-house counsel work, limited to specific practice areas, geographic restrictions). True indicates restrictions exist; False indicates no restrictions.',
    `pro_hac_vice_expiration_date` DATE COMMENT 'For pro hac vice admissions, the date on which the temporary admission expires. Typically tied to the conclusion of the specific matter. Null for permanent bar admissions.',
    `reciprocity_source_jurisdiction` STRING COMMENT 'For admissions granted by reciprocity or motion, the name of the jurisdiction whose bar membership served as the basis for admission without examination. Null for admissions by examination.',
    `renewal_due_date` DATE COMMENT 'The date by which the bar admission must be renewed to maintain active status. Most jurisdictions require annual or biennial renewal with payment of fees and completion of Continuing Legal Education (CLE) requirements.',
    `renewal_frequency` STRING COMMENT 'The frequency with which this bar admission must be renewed. Annual indicates yearly renewal; biennial indicates every two years; triennial indicates every three years; not required indicates jurisdictions with no periodic renewal requirement.. Valid values are `annual|biennial|triennial|not_required`',
    `status_effective_date` DATE COMMENT 'The date on which the current admission status became effective. Used to track when status changes occurred (e.g., when a suspension began, when an attorney went inactive).',
    `trust_account_certification_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this jurisdiction requires attorneys to certify compliance with Interest on Lawyers Trust Accounts (IOLTA) or client trust account rules as part of bar membership. True indicates certification is required; False indicates it is not required.',
    `trust_account_compliance_status` STRING COMMENT 'Indicates whether the attorney is in compliance with IOLTA or client trust account certification requirements for this jurisdiction. Compliant indicates certification is current; non-compliant indicates certification is missing or deficient; exempt indicates the attorney is exempt; not applicable indicates the attorney does not handle client funds.. Valid values are `compliant|non_compliant|exempt|not_applicable`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this bar admission record was last modified in the system. Used for audit trail and change tracking.',
    `verification_date` DATE COMMENT 'The date on which the bar admission status and details were last verified with the governing bar association. Used to ensure data accuracy and compliance with regulatory reporting requirements.',
    `verification_method` STRING COMMENT 'The method used to verify the bar admission status and details. Manual lookup indicates direct verification with the bar association website or records; API integration indicates automated verification via bar association API; attorney self-certification indicates the attorney provided the information; third party service indicates verification through a legal credentialing service.. Valid values are `manual_lookup|api_integration|attorney_self_certification|third_party_service`',
    `years_practice_at_admission` STRING COMMENT 'The number of years the attorney had been practicing law at the time of admission to this jurisdiction. Used for admissions by motion or reciprocity where prior practice experience is a requirement.',
    CONSTRAINT pk_bar_admission PRIMARY KEY(`bar_admission_id`)
) COMMENT 'Tracks each attorneys active and historical bar admissions across all jurisdictions (state bars, federal courts, international bars). Records jurisdiction name, admission date, bar number, admission type (active, inactive, pro hac vice), renewal due date, annual fee status, disciplinary standing, and the governing bar association. Critical for conflict checking, matter staffing eligibility, and regulatory compliance with SRA, ABA, and state bar requirements.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` (
    `cle_requirement_id` BIGINT COMMENT 'Unique surrogate identifier for each CLE/CPD requirement record. Primary key for the cle_requirement data product in the workforce domain.',
    `attorney_profile_id` BIGINT COMMENT 'Identifier of the attorney or timekeeper to whom this CLE/CPD requirement applies. Links to the workforce attorney master record in SAP SuccessFactors.',
    `timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — CLE requirements are tracked per attorney per jurisdiction. The requirement must link to the timekeeper to determine individual compliance status.',
    `required_timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — CLE requirements are tracked per attorney per jurisdiction. Must link to the timekeeper to determine compliance status.',
    `to_timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — CLE requirements are tracked per attorney per jurisdiction. The link to timekeeper identifies which attorney must fulfill which requirement.',
    `accredited_provider_required_flag` BOOLEAN COMMENT 'Indicates whether the jurisdiction requires CLE/CPD hours to be earned exclusively from accredited providers. When True, only courses from approved providers count toward the requirement.',
    `bias_inclusion_hours_required` DECIMAL(18,2) COMMENT 'The minimum number of CLE/CPD hours that must be earned in implicit bias, diversity, equity, and inclusion topics as mandated by certain jurisdictions (e.g., California, New York).',
    `carryover_expiry_months` STRING COMMENT 'The number of months after the end of the current reporting period within which carried-over CLE/CPD hours must be applied before they expire. Null if the jurisdiction does not impose a carry-over expiry.',
    `carryover_hours_allowed` DECIMAL(18,2) COMMENT 'The maximum number of excess CLE/CPD hours earned in the current reporting period that may be carried forward and credited toward the next reporting period, as permitted by the jurisdiction.',
    `compliance_deadline_date` DATE COMMENT 'The date by which the attorney must certify completion of all required CLE/CPD hours to the licensing jurisdiction. May differ from period_end_date where a grace period is granted.',
    `compliance_status` STRING COMMENT 'Current compliance status of the attorney against this CLE/CPD requirement for the reporting period. Drives firm-wide compliance dashboards and escalation workflows. [MASTER_RESOURCE LIFECYCLE_STATUS]. Valid values are `compliant|non_compliant|in_progress|exempt|pending_review`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction governing this CLE/CPD requirement (e.g., USA, GBR). Supports multi-national firm reporting and GDPR/DPA compliance scoping.. Valid values are `^[A-Z]{3}$`',
    `cpd_scheme_name` STRING COMMENT 'Name of the CPD/CLE scheme or programme under which this requirement is administered (e.g., SRA CPD Scheme, New York Continuing Legal Education Program). Relevant for multi-jurisdictional firms operating under different CPD frameworks.',
    `cycle_type` STRING COMMENT 'The recurrence pattern of the CLE/CPD reporting cycle as mandated by the jurisdiction. Drives automated generation of future requirement records.. Valid values are `annual|biennial|triennial|rolling`',
    `effective_date` DATE COMMENT 'The date from which this version of the CLE/CPD requirement definition became effective. Supports versioning and historical audit of regulatory rule changes. [MASTER_RESOURCE EFFECTIVE_FROM]',
    `ethics_hours_required` DECIMAL(18,2) COMMENT 'The minimum number of CLE/CPD hours that must be earned in legal ethics, professional responsibility, or professionalism topics as mandated by the jurisdiction.',
    `exemption_eligible_flag` BOOLEAN COMMENT 'Indicates whether the attorney may be eligible for a full or partial exemption from CLE/CPD requirements for this period (e.g., inactive status, judicial appointment, hardship). Triggers a review workflow.',
    `exemption_type` STRING COMMENT 'The category of exemption applied to this CLE/CPD requirement record when exemption_eligible_flag is True. Null or none when no exemption applies.. Valid values are `inactive_status|judicial_appointment|hardship|military_service|retired|none`',
    `jurisdiction_code` STRING COMMENT 'Standardised code identifying the licensing jurisdiction (state bar, SRA, or other regulatory body) that mandates this CLE/CPD requirement. Examples: CA, NY, TX, ENGLAND_WALES. An attorney admitted in multiple jurisdictions will have one record per jurisdiction per reporting period.. Valid values are `^[A-Z]{2,6}$`',
    `jurisdiction_name` STRING COMMENT 'Full descriptive name of the licensing jurisdiction that mandates this CLE/CPD requirement (e.g., State Bar of California, Solicitors Regulation Authority – England and Wales). Complements jurisdiction_code for reporting and display purposes.',
    `late_filing_penalty_description` STRING COMMENT 'Textual description of the penalty or consequence imposed by the jurisdiction for failure to certify CLE/CPD compliance by the compliance_deadline_date (e.g., Administrative suspension, $100 late fee). Supports risk management and attorney communications.',
    `new_attorney_requirement_flag` BOOLEAN COMMENT 'Indicates whether this requirement record reflects a newly-admitted attorney (bridge-the-gap or transition) CLE/CPD requirement, which typically differs in hours and subject matter from the standard requirement.',
    `notes` STRING COMMENT 'Free-text field for additional commentary, special conditions, or jurisdiction-specific nuances associated with this CLE/CPD requirement that are not captured in structured fields (e.g., transitional provisions, grandfathering clauses).',
    `online_hours_cap` DECIMAL(18,2) COMMENT 'The maximum number of CLE/CPD hours that may be earned through online, on-demand, or self-study formats within the reporting period, as restricted by the jurisdiction. Null if no cap applies.',
    `period_end_date` DATE COMMENT 'The last day of the CLE/CPD compliance reporting cycle for this jurisdiction and attorney. Hours earned after this date count toward the next cycle.',
    `period_start_date` DATE COMMENT 'The first day of the CLE/CPD compliance reporting cycle for this jurisdiction and attorney. Defines the window within which qualifying hours must be earned.',
    `practice_area_restriction` STRING COMMENT 'Specifies any practice-area-specific CLE/CPD sub-requirements mandated by the jurisdiction (e.g., Tax practitioners must complete 3 hours of tax law update). Null if no practice-area restriction applies.',
    `pro_bono_credit_hours_allowed` DECIMAL(18,2) COMMENT 'The maximum number of CLE/CPD credit hours that may be satisfied through qualifying pro bono legal service activities in lieu of formal coursework, as permitted by the jurisdiction.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this CLE/CPD requirement record was first created in the data platform. Supports audit trail and data lineage requirements. [MASTER_RESOURCE RECORD_AUDIT_CREATED]',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this CLE/CPD requirement record was last modified in the data platform. Supports change tracking and audit trail requirements.',
    `regulatory_body_code` STRING COMMENT 'Code identifying the specific regulatory or licensing body that issued this CLE/CPD mandate (e.g., ABA, SRA, CALBAR, NYSBA). Enables multi-jurisdictional reporting and regulatory body-level analytics.',
    `regulatory_body_name` STRING COMMENT 'Full name of the regulatory or licensing body that issued this CLE/CPD mandate (e.g., State Bar of California, Solicitors Regulation Authority). Complements regulatory_body_code for display and reporting.',
    `reporting_period_label` STRING COMMENT 'Human-readable label for the CLE/CPD compliance reporting cycle (e.g., 2024–2025 Biennial, FY2024 Annual). Used for display in dashboards and compliance reports.',
    `requirement_source_url` STRING COMMENT 'URL reference to the official regulatory body publication or rule document that defines this CLE/CPD requirement. Provides an audit trail back to the authoritative source.',
    `requirement_version` STRING COMMENT 'Version identifier for this CLE/CPD requirement definition, reflecting updates issued by the regulatory body (e.g., 2024.1). Enables tracking of rule changes over time and audit of which version governed a given period.',
    `self_study_subject_restriction` STRING COMMENT 'Describes any subject-matter restrictions on self-study or on-demand CLE/CPD hours imposed by the jurisdiction (e.g., ethics hours may not be earned via self-study in some jurisdictions). Null if no restriction applies.',
    `source_system_code` STRING COMMENT 'The identifier of this CLE/CPD requirement record as it exists in the originating system of record (SAP SuccessFactors Learning). Enables lineage tracing and reconciliation between the lakehouse silver layer and the source system.',
    `substance_abuse_hours_required` DECIMAL(18,2) COMMENT 'The minimum number of CLE/CPD hours that must be earned in attorney wellness, substance abuse, or mental health topics as mandated by certain jurisdictions.',
    `superseded_date` DATE COMMENT 'The date on which this version of the CLE/CPD requirement was superseded by a newer version. Null if this is the current active version. [MASTER_RESOURCE EFFECTIVE_UNTIL]',
    `technology_hours_required` DECIMAL(18,2) COMMENT 'The minimum number of CLE/CPD hours that must be earned in legal technology topics (e.g., cybersecurity, AI in law, eDiscovery) as mandated by the jurisdiction. Reflects ABA Comment 8 to Rule 1.1 on technological competence.',
    `total_hours_required` DECIMAL(18,2) COMMENT 'The total number of CLE/CPD credit hours the attorney must complete within the reporting period as mandated by the jurisdiction. Includes all sub-category requirements.',
    CONSTRAINT pk_cle_requirement PRIMARY KEY(`cle_requirement_id`)
) COMMENT 'Defines the CPD/CLE compliance requirements applicable to each attorney by jurisdiction and reporting period. Stores jurisdiction, reporting cycle start and end dates, total hours required, ethics hours required, technology CLE hours required, pro bono hours credit allowed, carry-over rules, and compliance deadline. Enables the firm to track each attorneys obligations across multiple jurisdictions simultaneously. Sourced from state bar and SRA regulatory mandates.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`workforce`.`cle_completion` (
    `cle_completion_id` BIGINT COMMENT 'Unique surrogate identifier for each CLE/CPD completion record in the Silver layer. Primary key for this transactional entity. Role: TRANSACTION_HEADER.',
    `timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Each CLE completion record must reference the attorney who completed the course. Required for compliance reporting.',
    `knowledge_asset_id` BIGINT COMMENT 'Foreign key linking to knowledge.knowledge_asset. Business justification: Internal CLE courses (webinars, training sessions, practice notes) are knowledge assets. Linking enables CPD credit allocation, knowledge reuse metrics, and compliance reporting for jurisdictions requ',
    `learning_item_id` BIGINT COMMENT 'Reference to the course or learning item catalogue record in SAP SuccessFactors Learning. Enables linkage to the course master for provider, accreditation body, and curriculum metadata.',
    `cle_requirement_id` BIGINT COMMENT 'Foreign key linking to workforce.cle_requirement. Business justification: CLE completions should link to the specific requirement record they satisfy. This enables tracking compliance against jurisdiction-specific CPD/CLE requirements. The cle_completion table currently has',
    `primary_cle_timekeeper_id` BIGINT COMMENT 'Reference to the attorney, paralegal, or professional staff member who completed the CLE/CPD activity. Links to the workforce timekeeper master record. Satisfies PARTY_REFERENCE category for TRANSACTION_HEADER role.',
    `recorded_by_timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Each CLE completion event is performed by a specific attorney/timekeeper. Essential for compliance tracking.',
    `satisfied_cle_requirement_id` BIGINT COMMENT 'FK to workforce.cle_requirement.cle_requirement_id — Completions must be matched against requirements to determine compliance. This is the core CLE compliance join.',
    `to_cle_requirement_id` BIGINT COMMENT 'FK to workforce.cle_requirement.cle_requirement_id — Each completion record satisfies credits toward a specific CLE requirement (jurisdiction + reporting period). This link enables compliance gap analysis.',
    `to_timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Each CLE completion event is performed by a specific attorney/timekeeper. Required for compliance reporting.',
    `accreditation_number` STRING COMMENT 'Unique accreditation or approval number assigned to this course by the accrediting bar association or regulatory body. Required for bar compliance submissions and audit verification.',
    `accreditation_status` STRING COMMENT 'Accreditation status of the course or activity as determined by the relevant bar association or regulatory body. Only accredited completions count toward mandatory CLE/CPD requirements. pending indicates the firm has applied for accreditation but approval has not yet been received.. Valid values are `accredited|pending|not_accredited|conditionally_accredited`',
    `accrediting_body` STRING COMMENT 'Name of the bar association, regulatory body, or professional organisation that accredited this CLE/CPD activity (e.g., New York State CLE Board, State Bar of California, Solicitors Regulation Authority, International Bar Association). A single completion may be accredited by multiple bodies; this field captures the primary accrediting body.',
    `achieved_score` DECIMAL(18,2) COMMENT 'The actual score (as a percentage) achieved by the timekeeper on the course assessment. Null if no assessment is required. Used to validate completion eligibility and track learning effectiveness.',
    `bar_confirmation_number` STRING COMMENT 'Confirmation or acknowledgement number returned by the bar association or regulatory body upon successful receipt of the CLE/CPD completion report. Provides audit evidence that the credit has been officially recorded by the regulator.',
    `certificate_number` STRING COMMENT 'Unique certificate or completion reference number issued by the course provider to the individual timekeeper upon successful completion. Used for audit evidence and bar compliance verification.',
    `completion_date` DATE COMMENT 'The calendar date on which the attorney or professional staff member completed the CLE/CPD course or activity. This is the principal real-world event date used for bar compliance reporting and CPD cycle calculations. Satisfies BUSINESS_EVENT_TIMESTAMP category.',
    `completion_number` STRING COMMENT 'Externally-visible business identifier for this completion record, typically generated by SAP SuccessFactors Learning or the accrediting body. Used for audit trails, bar reporting submissions, and certificate cross-referencing. Satisfies BUSINESS_IDENTIFIER category.',
    `completion_status` STRING COMMENT 'Current lifecycle state of the CLE/CPD completion record within the learning management workflow. completed indicates credit is earned and reportable; pending_approval indicates awaiting accreditation body or firm administrator sign-off. Satisfies LIFECYCLE_STATUS category.. Valid values are `completed|in_progress|failed|withdrawn|pending_approval`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred by the firm for this CLE/CPD completion, including registration fees, materials, and any associated expenses. Used for workforce development budget tracking and cost-per-credit analytics. Expressed in the firms base currency.',
    `cost_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the cost amount (e.g., USD, GBP, EUR). Required for multi-currency firms operating across jurisdictions.. Valid values are `^[A-Z]{3}$`',
    `course_category` STRING COMMENT 'Categorical classification of the CLE/CPD course content area as defined by the accrediting body or firm taxonomy. Used for workforce development analytics, skills gap analysis, and compliance sub-category tracking. [ENUM-REF-CANDIDATE: substantive_law|ethics_professionalism|skills|practice_management|technology|diversity_equity_inclusion|wellbeing — promote to reference product if additional categories are required]',
    `course_duration_minutes` STRING COMMENT 'Total instructional duration of the CLE/CPD course in minutes as recorded by the provider. Used to validate credit hour claims (typically 60 minutes = 1.0 credit hour) and detect discrepancies between claimed and actual seat time.',
    `course_start_date` DATE COMMENT 'The date on which the CLE/CPD course or activity commenced. For multi-day programmes, this is the first day of instruction. Distinct from completion_date; used to calculate course duration and validate credit hour claims.',
    `course_title` STRING COMMENT 'Full title of the CLE/CPD course or activity as provided by the course provider or accrediting body. Used for compliance reporting submissions to state bars, SRA, and IBA, and for knowledge management analytics.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CLE completion record was first captured in SAP SuccessFactors Learning or ingested into the Silver layer. Used for audit trail and data lineage. Satisfies RECORD_AUDIT_CREATED category.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Total number of Continuing Legal Education (CLE) or Continuing Professional Development (CPD) credit hours earned by the timekeeper for this completion. Expressed in decimal hours (e.g., 1.50 = 90 minutes). Used to calculate compliance against annual or biennial bar requirements.',
    `delivery_format` STRING COMMENT 'Method by which the CLE/CPD activity was delivered to the participant. Some jurisdictions impose caps on self-study or on-demand credits; this field enables compliance validation against those rules. [ENUM-REF-CANDIDATE: in_person|webinar|self_study|on_demand|blended|podcast — promote to reference product if additional formats are required]. Valid values are `in_person|webinar|self_study|on_demand|blended|podcast`',
    `diversity_equity_inclusion_credit_hours` DECIMAL(18,2) COMMENT 'Subset of total credit hours that qualify as diversity, equity, and inclusion (DEI) credits. A growing number of state bars (e.g., California, New York) mandate DEI-focused CLE credits per reporting period. Enables compliance tracking against DEI credit sub-requirements.',
    `ethics_credit_hours` DECIMAL(18,2) COMMENT 'Subset of total credit hours that qualify as ethics or professional responsibility credits. Most state bars and the SRA mandate a minimum number of ethics credits per reporting period; this field enables compliance tracking against those sub-requirements.',
    `is_diversity_equity_inclusion_credit` BOOLEAN COMMENT 'Boolean flag indicating whether any portion of this CLE/CPD activity qualifies as a diversity, equity, and inclusion (DEI) credit. Enables rapid filtering for DEI credit compliance reporting.',
    `is_ethics_credit` BOOLEAN COMMENT 'Boolean flag indicating whether any portion of this CLE/CPD activity qualifies as ethics or professional responsibility credit. Provides a quick filter for ethics compliance dashboards without requiring a numeric threshold check.',
    `is_firm_sponsored` BOOLEAN COMMENT 'Boolean flag indicating whether the firm paid for or sponsored this CLE/CPD activity. False indicates the attorney self-funded the course. Used for workforce development budget reporting and reimbursement processing.',
    `is_mandatory` BOOLEAN COMMENT 'Boolean flag indicating whether this CLE/CPD activity was designated as mandatory by the firm, practice group, or regulatory body (as opposed to elective). Used to distinguish required training completions from voluntary professional development in compliance and workforce analytics.',
    `is_pro_bono_credit` BOOLEAN COMMENT 'Boolean flag indicating whether this activity qualifies for pro bono CLE credit. Some jurisdictions (e.g., New York) allow attorneys to earn CLE credit for qualifying pro bono legal services. Enables compliance tracking for pro bono credit sub-requirements.',
    `is_technology_credit` BOOLEAN COMMENT 'Boolean flag indicating whether any portion of this CLE/CPD activity qualifies as a technology competency credit. Enables rapid filtering for technology credit compliance reporting.',
    `location_city` STRING COMMENT 'City where the in-person CLE/CPD event was held. Applicable for in-person and blended delivery formats. Used for travel expense reconciliation and geographic analytics on CLE attendance patterns.',
    `location_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the in-person CLE/CPD event was held (e.g., USA, GBR, AUS). Used for international compliance reporting and travel analytics.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free-text field for additional context, exceptions, or administrative remarks related to this CLE/CPD completion record (e.g., reasons for a conditional accreditation status, details of a credit hour adjustment, or notes from the bar reporting submission). Populated by firm administrators or the learning management system.',
    `pass_score` DECIMAL(18,2) COMMENT 'The minimum passing score threshold (as a percentage) required by the course provider or accrediting body for this CLE/CPD activity. Applicable for courses with a formal assessment component. Null if no assessment is required.',
    `practice_area` STRING COMMENT 'Legal practice area or subject matter covered by the CLE/CPD course (e.g., Corporate M&A, Intellectual Property, Employment Law, Litigation, Regulatory Compliance). Enables analytics on attorney skill development aligned to firm practice group strategy.',
    `provider_code` STRING COMMENT 'Accreditation or registration code assigned to the course provider by the relevant bar association or regulatory body (e.g., MCLE provider number issued by a state bar). Required for automated compliance submissions.',
    `provider_name` STRING COMMENT 'Name of the organisation or institution that delivered the CLE/CPD course or activity (e.g., PLI, ALI CLE, Law Society, IBA). Used to verify accreditation status and track preferred provider relationships.',
    `reported_to_bar_date` DATE COMMENT 'The date on which this CLE/CPD completion was formally reported to the relevant bar association or regulatory body. Null if not yet reported. Used to track submission status and ensure timely compliance filings.',
    `reporting_jurisdiction` STRING COMMENT 'The bar association jurisdiction or regulatory body to which this completion is being reported (e.g., NY, CA, TX, SRA-England-Wales, IBA). An attorney admitted in multiple jurisdictions may have the same completion reported to several bodies; this field identifies the primary reporting jurisdiction for this record.',
    `reporting_period` STRING COMMENT 'The compliance reporting period to which this CLE/CPD credit applies, expressed as a calendar year (e.g., 2024) or biennial period (e.g., 2023-2024) depending on the jurisdictions cycle. Credits must be allocated to the correct reporting period for bar compliance submissions.. Valid values are `^[0-9]{4}(-[0-9]{4})?$`',
    `source_record_code` STRING COMMENT 'The native record identifier from the originating source system (e.g., SAP SuccessFactors Learning completion ID). Enables traceability back to the system of record for reconciliation, re-processing, and audit purposes.',
    `source_system` STRING COMMENT 'Identifies the originating system or ingestion channel for this CLE completion record. SAP_SuccessFactors is the primary system of record; manual_entry indicates a firm administrator entered the record directly; provider_feed indicates an automated data feed from the course provider; bar_portal indicates import from a bar association reporting portal.. Valid values are `SAP_SuccessFactors|manual_entry|provider_feed|bar_portal`',
    `technology_credit_hours` DECIMAL(18,2) COMMENT 'Subset of total credit hours that qualify as technology competency credits. Several state bars (e.g., Florida, North Carolina) require attorneys to complete technology-focused CLE credits per reporting period. Enables compliance tracking against technology credit sub-requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this CLE completion record was last modified in the source system or Silver layer. Tracks corrections, status changes, and credit hour adjustments. Satisfies RECORD_AUDIT_UPDATED category.',
    CONSTRAINT pk_cle_completion PRIMARY KEY(`cle_completion_id`)
) COMMENT 'Transactional record of each CPD/CLE course or activity completed by an attorney. Captures course title, provider, delivery format (in-person, webinar, self-study), completion date, credit hours earned, ethics credit flag, technology credit flag, accreditation status, certificate number, and the reporting period to which the credit applies. Supports compliance reporting to state bars, SRA, and IBA. Sourced from SAP SuccessFactors Learning module.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`workforce`.`billing_rate` (
    `billing_rate_id` BIGINT COMMENT 'Unique surrogate identifier for each billing rate record in the master rate schedule. Primary key for the billing_rate data product.',
    `timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Billing rates are set per timekeeper. This link is critical for rate lookups during time entry and billing.',
    `billing_approving_partner_timekeeper_id` BIGINT COMMENT 'Reference to the equity or billing partner who approved this rate. Required for rate governance and audit trail per firm billing policy.',
    `billing_timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper (attorney, paralegal, or staff) for whom this billing rate applies. Links to the workforce timekeeper master record.',
    `matter_id` BIGINT COMMENT 'Reference to the specific matter for which a matter-specific billing rate applies. Null for standard or client-level rates not scoped to a single matter.',
    `practice_group_id` BIGINT COMMENT 'Foreign key linking to workforce.practice_group. Business justification: Billing rates are often defined and managed by practice group. The billing_rate table currently has practice_group_code (STRING) but no FK to the practice_group master table. This normalization remove',
    `prior_rate_billing_rate_id` BIGINT COMMENT 'Reference to the immediately preceding billing rate record that this version supersedes. Enables traversal of the rate version chain for historical billing analysis and dispute resolution.',
    `profile_id` BIGINT COMMENT 'Reference to the client for whom a client-negotiated or matter-specific rate applies. Null for standard rack rates not tied to a specific client.',
    `rate_owner_timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Billing rates are defined per timekeeper. This is the core link enabling rate lookups for time entry billing.',
    `to_timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Billing rates are set per timekeeper. This is the critical link enabling the billing domain to resolve rates for time entries.',
    `afa_arrangement_type` STRING COMMENT 'Specifies the type of Alternative Fee Arrangement (AFA) when rate_type is afa_blended. Drives billing logic, WIP recognition, and revenue forecasting for non-hourly engagements.. Valid values are `blended_rate|fixed_fee|capped_fee|contingency|success_fee|subscription`',
    `approved_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the approving partner formally approved this billing rate in the system. Distinct from rate_approval_date (day-level) — provides exact time for audit and workflow tracking.',
    `billing_frequency` STRING COMMENT 'The agreed frequency at which invoices are generated under this rate arrangement. Relevant for retainer, fixed-fee, and subscription AFA structures. Drives prebill scheduling in Aderant Expert.. Valid values are `monthly|quarterly|milestone|on_demand|annual`',
    `billing_guideline_ref` STRING COMMENT 'Reference identifier for the client billing guidelines document that governs this rate (e.g., Outside Counsel Guidelines reference number). Ensures rate compliance with client-mandated billing rules and supports LEDES export validation.',
    `client_agreed_date` DATE COMMENT 'The date on which the client formally agreed to or acknowledged this billing rate, typically documented in the Letter of Engagement (LOE) or rate agreement letter. Supports billing dispute resolution.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing rate record was first created in the system. Provides the audit trail creation marker for the rate record lifecycle.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the hourly rate amount is denominated (e.g., USD, GBP, EUR). Supports multi-currency billing for international matters.. Valid values are `^[A-Z]{3}$`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied to the standard rack rate to derive this negotiated rate. Expressed as a percentage (e.g., 10.00 = 10%). Used for rate analytics, profitability reporting, and RPE (Revenue Per Equity Partner) calculations.',
    `effective_from_date` DATE COMMENT 'The date from which this billing rate becomes effective and may be applied to time entries. Defines the start of the rates validity window for billing and WIP (Work in Progress) calculations.',
    `effective_to_date` DATE COMMENT 'The date on which this billing rate expires and is no longer applicable to new time entries. Null indicates an open-ended rate with no scheduled expiry. Supports rate versioning and historical rate lookups.',
    `firm_office_code` STRING COMMENT 'Code identifying the firm office or jurisdiction to which this rate applies. Rates may differ by office location due to market conditions and local bar requirements.',
    `hourly_rate_amount` DECIMAL(18,2) COMMENT 'The standard hourly billing rate amount for this timekeeper under this rate record. Represents the principal monetary value of the rate schedule entry. For AFA blended rates, this reflects the blended equivalent hourly rate.',
    `is_client_approved` BOOLEAN COMMENT 'Indicates whether the client has formally approved or acknowledged this billing rate. True = client has confirmed acceptance; False = rate is pending client acknowledgement. Critical for billing dispute prevention.',
    `is_default_rate` BOOLEAN COMMENT 'Indicates whether this rate is the default billing rate applied to the timekeeper when no client-specific or matter-specific rate exists. True = default fallback rate; False = targeted rate for specific client or matter.',
    `is_pro_bono` BOOLEAN COMMENT 'Indicates whether this rate record applies to pro bono matters. True = pro bono rate (typically zero or nominal); False = commercial rate. Supports pro bono reporting and ABA pro bono commitment tracking.',
    `jurisdiction_code` STRING COMMENT 'ISO 3166-1 alpha-2 or alpha-3 country/jurisdiction code indicating the legal jurisdiction in which this rate applies. Rates may vary by jurisdiction due to local bar regulations, market conditions, and currency.. Valid values are `^[A-Z]{2,3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this billing rate record. Supports change detection, incremental data loading, and audit trail requirements.',
    `ledes_rate_code` STRING COMMENT 'The LEDES-compliant rate code assigned to this billing rate for inclusion in LEDES 1998B and LEDES XML electronic billing exports submitted to clients and legal bill review vendors.. Valid values are `^[A-Z0-9]{1,10}$`',
    `matter_phase_code` STRING COMMENT 'UTBMS or firm-defined phase code indicating the matter phase to which this rate applies (e.g., discovery, trial, closing). Enables phase-specific rate differentiation under phased AFA or fixed-fee arrangements.',
    `rate_approval_date` DATE COMMENT 'The date on which the approving partner formally approved this billing rate. Required for rate governance, audit trail, and compliance with firm billing policy.',
    `rate_basis` STRING COMMENT 'The fee basis under which this rate is structured. Hourly = time-and-rate billing; fixed_fee = flat fee per matter or phase; contingency = percentage of recovery; retainer = periodic fixed payment; capped = hourly with a maximum ceiling; blended = single rate across multiple timekeepers under an AFA.. Valid values are `hourly|fixed_fee|contingency|retainer|capped|blended`',
    `rate_cap_amount` DECIMAL(18,2) COMMENT 'Maximum hourly rate ceiling agreed with the client, applicable when rate_basis is capped. Billing above this amount requires explicit client approval. Supports AFA and capped-fee arrangement management.',
    `rate_code` STRING COMMENT 'Unique alphanumeric code identifying this rate record within Aderant Expert Rate Management. Used as the business-facing identifier for rate lookups and LEDES billing exports.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `rate_notes` STRING COMMENT 'Free-text notes providing additional context about this billing rate, such as negotiation history, special conditions, client-specific restrictions, or approval commentary. Sourced from Aderant Expert rate record comments.',
    `rate_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this billing rate. Supports proactive rate management, annual rate increase cycles, and client relationship management.',
    `rate_schedule_name` STRING COMMENT 'The name of the rate schedule or rate card to which this rate belongs (e.g., Standard 2024, Acme Corp Preferred Rates, EMEA Litigation Schedule). Supports grouping of rates for bulk management and client reporting.',
    `rate_status` STRING COMMENT 'Current lifecycle status of the billing rate record. Active = currently in use; pending_approval = submitted for partner/management approval; approved = approved but not yet effective; superseded = replaced by a newer rate version; expired = past effective_to_date; rejected = approval denied.. Valid values are `active|pending_approval|approved|superseded|expired|rejected`',
    `rate_type` STRING COMMENT 'Classification of the billing rate indicating its scope and negotiation basis. Standard = rack rate; client_negotiated = agreed rate for a client; matter_specific = scoped to one matter; afa_blended = blended rate under an Alternative Fee Arrangement (AFA); volume_discount = tiered discount rate; pro_bono = zero or reduced rate for pro bono matters.. Valid values are `standard|client_negotiated|matter_specific|afa_blended|volume_discount|pro_bono`',
    `rate_version` STRING COMMENT 'Sequential version number for this rate record, incremented each time the rate is revised for the same timekeeper, client, or matter combination. Supports rate history tracking and audit.',
    `source_system_rate_code` STRING COMMENT 'The native rate record identifier from the Aderant Expert Rate Management source system. Preserved for lineage tracing, reconciliation, and cross-system audits between Aderant Expert and Elite 3E.',
    `standard_rate_amount` DECIMAL(18,2) COMMENT 'The published standard (rack) hourly rate for this timekeeper before any client or matter-specific discounts are applied. Stored alongside the negotiated rate to enable discount analysis and realisation reporting.',
    `timekeeper_class` STRING COMMENT 'Professional classification of the timekeeper to which this rate applies, reflecting seniority and role tier used in rate scheduling and UTBMS task-based billing.. Valid values are `partner|associate|of_counsel|paralegal|legal_assistant|staff`',
    `utbms_task_code` STRING COMMENT 'UTBMS task code associated with this rate, enabling task-based billing categorisation for client billing guidelines and legal spend analytics. Aligns with ABA/ACCA UTBMS code sets (L-series for litigation, B-series for business).',
    `wip_recognition_method` STRING COMMENT 'Specifies how Work in Progress (WIP) is recognised for this rate type. time_and_rate = standard hourly WIP accrual; fixed_fee_milestone = WIP recognised at milestone completion; contingent = WIP held until contingency event; deferred = WIP deferred per agreement terms.. Valid values are `time_and_rate|fixed_fee_milestone|contingent|deferred`',
    CONSTRAINT pk_billing_rate PRIMARY KEY(`billing_rate_id`)
) COMMENT 'Master rate schedule defining the standard, negotiated, and matter-specific billing rates for each timekeeper by effective date range. Stores rate type (standard, client-negotiated, AFA blended, matter-specific), currency, hourly rate amount, LEDES rate code, rate approval status, and the approving partner. Supports LEDES billing exports and AFA arrangements. This is the SSOT for timekeeper rate data consumed by the billing domain. Sourced from Aderant Expert Rate Management module.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`workforce`.`practice_group` (
    `practice_group_id` BIGINT COMMENT 'Unique surrogate identifier for the practice group record in the Silver Layer lakehouse. Primary key sourced from SAP SuccessFactors organizational unit identifier.',
    `parent_group_practice_group_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent practice group in the organizational hierarchy, enabling multi-level group structures (e.g., Disputes as parent of Commercial Litigation and International Arbitration). Null for top-level groups. Supports hierarchical financial roll-up reporting.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Practice groups are organized around practice areas for service delivery alignment, resource allocation, and conflict checking scope. Essential for matter staffing, rate card construction, and P&L rep',
    `timekeeper_id` BIGINT COMMENT 'foreign_key_to',
    `primary_timekeeper_id` BIGINT COMMENT 'Default lead timekeeper for this practice group',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to knowledge.knowledge_taxonomy. Business justification: Practice groups align to knowledge taxonomy nodes for precedent organization, matter classification, and knowledge management structure. Enables taxonomy-driven resource allocation, knowledge contribu',
    `afa_eligible` BOOLEAN COMMENT 'Indicates whether matters assigned to this practice group are eligible for Alternative Fee Arrangements (AFA) such as fixed fees, capped fees, contingency, or blended rates. Drives AFA proposal workflows in Elite 3E and client engagement letter templates.',
    `approved_fte_count` DECIMAL(18,2) COMMENT 'Approved Full-Time Equivalent (FTE) count for the practice group, accounting for part-time and flexible working arrangements. Distinct from headcount_budget as it normalizes part-time positions to full-time equivalents. Sourced from SAP SuccessFactors workforce planning module.',
    `associate_count` STRING COMMENT 'Number of associates (non-partner attorneys) currently assigned to the practice group. Used in leverage ratio calculations (associates per partner), capacity planning, and recruitment pipeline management.',
    `billing_rate_schedule_code` STRING COMMENT 'Code referencing the standard billing rate schedule applied to timekeepers in this practice group in Aderant Expert. Determines the default hourly rates for matter billing, AFA (Alternative Fee Arrangement) baseline calculations, and client rate negotiations.. Valid values are `^[A-Z0-9-]{2,20}$`',
    `cle_requirement_hours` DECIMAL(18,2) COMMENT 'Annual Continuing Legal Education (CLE) / Continuing Professional Development (CPD) hours required for attorneys in this practice group, which may exceed the minimum jurisdictional bar requirement due to practice area specialization (e.g., IP attorneys may require additional patent prosecution training). Tracked in SAP SuccessFactors Learning.',
    `conflict_check_scope` STRING COMMENT 'Defines the scope of conflict checking applied when new matters are opened under this practice group in Intapp Conflicts. firm_wide applies full firm-wide conflict screening; group_only restricts to practice group relationships; office_only restricts to office-level relationships. Drives ethical wall configuration.. Valid values are `firm_wide|group_only|office_only`',
    `cost_center_code` STRING COMMENT 'Financial cost center code assigned to the practice group in Elite 3E and the firms general ledger, enabling allocation of overhead costs, attorney compensation, and support staff expenses to the correct organizational unit for profitability reporting.. Valid values are `^[A-Z0-9-]{3,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the practice group record was first created in the source system (SAP SuccessFactors). Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX per firm data standards. Used for audit trail and data lineage tracking.',
    `current_headcount` STRING COMMENT 'Actual current number of active timekeepers and staff assigned to the practice group as of the last data refresh from SAP SuccessFactors. Used to calculate headcount variance against budget and identify open positions requiring recruitment.',
    `department_type` STRING COMMENT 'Classifies whether the practice group is a fee-earning (revenue-generating legal practice), business services (support function such as HR, Finance, IT), or hybrid unit. Drives financial reporting segmentation, FTE budgeting, and profitability analysis.. Valid values are `fee_earning|business_services|hybrid`',
    `effective_from_date` DATE COMMENT 'Date from which the practice group became operationally active and authorized to accept matter assignments and timekeeper allocations. Supports temporal validity tracking for organizational hierarchy changes and historical reporting.',
    `effective_to_date` DATE COMMENT 'Date on which the practice group ceased to be operationally active (e.g., due to dissolution or merger into another group). Null for currently active groups. Enables point-in-time organizational hierarchy queries and historical matter staffing analysis.',
    `gl_account_code` STRING COMMENT 'General ledger account code in Elite 3E associated with the practice group for revenue recognition, WIP tracking, and financial statement reporting. Enables drill-down from firm-level financials to practice group-level P&L.. Valid values are `^[0-9]{4,10}$`',
    `group_code` STRING COMMENT 'Externally-known alphanumeric short code uniquely identifying the practice group across firm systems (e.g., MA, LIT, IP, EMP, REG). Used as the business key in Elite 3E matter staffing, billing rate tables, and financial reporting. Aligns with UTBMS task code groupings.. Valid values are `^[A-Z0-9-]{2,20}$`',
    `group_name` STRING COMMENT 'Full human-readable name of the practice group or department (e.g., Mergers and Acquisitions, Commercial Litigation, Intellectual Property, Employment Law, Regulatory Compliance). The primary display label used in client-facing materials, internal directories, and reporting dashboards.',
    `headcount_budget` STRING COMMENT 'Total approved headcount budget (number of positions) for the practice group in the current fiscal year, including attorneys, paralegals, and dedicated support staff. Used in workforce planning, recruitment authorization, and FTE utilization reporting.',
    `jurisdiction_primary` STRING COMMENT 'ISO 3166-1 alpha-2 or alpha-3 country code representing the primary legal jurisdiction in which this practice group operates and advises (e.g., USA, GBR, DEU). Drives bar admission requirements for timekeepers, regulatory compliance obligations, and jurisdictional conflict checking in Intapp Conflicts.. Valid values are `^[A-Z]{2,3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the practice group record in the source system (SAP SuccessFactors). Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for incremental data pipeline processing and change detection in the Silver Layer.',
    `lpp_classification` STRING COMMENT 'Indicates the default Legal Professional Privilege (LPP) classification for documents and communications produced by this practice group. privileged indicates all work product is presumed privileged; non_privileged for non-advisory groups; mixed for groups with both advisory and non-advisory functions. Drives document classification in iManage Work and eDiscovery TAR workflows in Relativity.. Valid values are `privileged|non_privileged|mixed`',
    `matter_count_active` STRING COMMENT 'Current number of active matters assigned to this practice group as sourced from Elite 3E matter management. Used in capacity planning, workload balancing, and practice group performance dashboards. This is a point-in-time operational count, not a calculated aggregate.',
    `notes` STRING COMMENT 'Free-text field for operational notes, strategic context, or administrative remarks about the practice group (e.g., merger history, planned restructuring, special billing arrangements). Sourced from SAP SuccessFactors organizational unit description or manually maintained by firm administration.',
    `paralegal_count` STRING COMMENT 'Number of paralegals and legal assistants currently assigned to the practice group. Used in resource allocation, matter staffing models, and billing rate mix analysis.',
    `partner_count` STRING COMMENT 'Number of equity and income partners currently assigned to the practice group. Used in PPP (Profit Per Partner) and PEP (Profit Per Equity Partner) calculations, partner leverage ratio analysis, and compensation committee reporting.',
    `performance_review_cycle` STRING COMMENT 'Frequency of formal performance reviews for timekeepers assigned to this practice group as configured in SAP SuccessFactors Performance & Goals. Drives automated review initiation, goal-setting workflows, and compensation adjustment timelines.. Valid values are `annual|semi_annual|quarterly`',
    `practice_group_status` STRING COMMENT 'Current lifecycle status of the practice group within the firms organizational structure. active indicates the group is operational and accepting matter assignments; inactive indicates temporarily suspended; pending indicates newly created but not yet operational; dissolved indicates permanently closed; merged indicates consolidated into another group.. Valid values are `active|inactive|pending|dissolved|merged`',
    `recruitment_open_positions` STRING COMMENT 'Number of currently open and approved recruitment positions for the practice group as tracked in SAP SuccessFactors Recruiting. Used in talent acquisition planning, headcount gap analysis, and lateral hire pipeline management.',
    `region_scope` STRING COMMENT 'Geographic or jurisdictional scope of the practice groups operations (e.g., North America, EMEA, Asia Pacific, Global, United States, United Kingdom). Indicates whether the group operates locally, regionally, or globally. Used in resource allocation planning and cross-border matter staffing.',
    `revenue_target_amount` DECIMAL(18,2) COMMENT 'Annual revenue target (in firm base currency) set for the practice group for the current fiscal year. Used in financial performance dashboards, RPE (Revenue Per Equity Partner) calculations, and partner compensation reviews. Sourced from the firms annual budgeting process.',
    `revenue_target_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the revenue target amount (e.g., USD, GBP, EUR). Required for multi-currency firms operating across jurisdictions.. Valid values are `^[A-Z]{3}$`',
    `revenue_target_fiscal_year` STRING COMMENT 'The fiscal year (four-digit integer, e.g., 2025) to which the revenue target applies. Enables year-over-year comparison of practice group financial performance and target-setting history.',
    `short_name` STRING COMMENT 'Abbreviated display name for the practice group used in space-constrained UI elements, reports, and dashboards (e.g., M&A, Litigation, IP, Employment). Sourced from SAP SuccessFactors organizational unit short description field.. Valid values are `^.{1,50}$`',
    `source_system_code` STRING COMMENT 'The native identifier of this practice group record in the originating source system (SAP SuccessFactors organizational unit ID). Enables traceability from the Silver Layer back to the system of record for reconciliation and audit purposes.. Valid values are `^[A-Za-z0-9-_]{1,50}$`',
    `succession_plan_status` STRING COMMENT 'Current status of the succession planning process for the practice groups managing partner and key leadership roles in SAP SuccessFactors Succession & Development. Supports firm continuity planning and partner transition management.. Valid values are `not_started|in_progress|approved|under_review`',
    `timekeeper_class_scope` STRING COMMENT 'Comma-separated list of timekeeper classification levels authorized to bill under this practice group (e.g., Equity Partner, Income Partner, Senior Associate, Associate, Paralegal, Law Clerk). Drives billing rate table lookups in Aderant Expert and timekeeper assignment validation in Elite 3E.',
    `utbms_task_code_prefix` STRING COMMENT 'The UTBMS task code prefix associated with this practice group, used to align matter billing entries and time records to the industry-standard task-based billing framework (e.g., L1 for Litigation, B1 for Business/Corporate). Enables LEDES-compliant invoice generation and client billing analytics.. Valid values are `^[A-Z][0-9]{2,4}$`',
    `wip_write_off_authority_limit` DECIMAL(18,2) COMMENT 'Maximum monetary amount (in firm base currency) that the managing partner of this practice group is authorized to write off from WIP (Work in Progress) without escalation to firm management. Supports financial controls and write-off governance in Elite 3E.',
    CONSTRAINT pk_practice_group PRIMARY KEY(`practice_group_id`)
) COMMENT 'Organizational unit representing a legal practice group or department within the firm (e.g., M&A, Litigation, IP, Employment, Regulatory). Stores practice group name, group code, managing partner, practice area classification (aligned to UTBMS task codes), office or region scope, revenue target, headcount budget, approved FTE count, and active status. Serves as the primary organizational hierarchy for matter staffing, financial reporting by practice, resource allocation, and recruitment planning. Sourced from SAP SuccessFactors organizational structure.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` (
    `matter_assignment_id` BIGINT COMMENT 'Unique surrogate identifier for each matter assignment record linking a timekeeper to a specific matter. Primary key of this entity.',
    `timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Matter assignments link timekeepers to matters. The timekeeper FK is essential for resource utilization and staffing.',
    `budget_id` BIGINT COMMENT 'Reference to the matter-level budget record against which this assignments budgeted hours and fees are tracked. Supports LPM budget variance reporting and matter profitability analysis.',
    `matter_id` BIGINT COMMENT 'Reference to the matter to which the timekeeper is assigned. Establishes the core association between workforce and matter management domains.',
    `practice_group_id` BIGINT COMMENT 'FK to workforce.practice_group.practice_group_id — Matter assignments are often analyzed by practice group for utilization and staffing balance. The practice group context enables resource allocation reporting.',
    `primary_matter_team_lead_timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper designated as the overall matter team lead, which may differ from the responsible attorney or lead partner. Used for LPM reporting and team coordination.',
    `tertiary_matter_supervising_timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper who holds supervisory responsibility over this assignment. Supports professional responsibility compliance, associate development, and matter hierarchy reporting. Null for lead partners or independently operating timekeepers.',
    `to_timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Each matter assignment associates a specific timekeeper to a matter. This is the core staffing relationship enabling utilization tracking and resource planning.',
    `actual_hours_to_date` DECIMAL(18,2) COMMENT 'Cumulative hours recorded by this timekeeper against this matter assignment as of the most recent data refresh. Sourced from Elite 3E time entry records. Enables budget-to-actual variance tracking and Work in Progress (WIP) analysis.',
    `afa_flag` BOOLEAN COMMENT 'Indicates whether this matter assignment is governed by an Alternative Fee Arrangement (AFA) such as a fixed fee, capped fee, or blended rate, rather than standard hourly billing. Affects how time entries are treated in billing workflows.',
    `afa_type` STRING COMMENT 'Specifies the type of Alternative Fee Arrangement (AFA) applicable to this assignment when afa_flag is True. Drives billing configuration in Elite 3E and Aderant Expert and informs revenue recognition treatment.. Valid values are `fixed_fee|capped_fee|blended_rate|contingency|success_fee|retainer`',
    `assignment_created_timestamp` TIMESTAMP COMMENT 'The date and time at which this matter assignment record was first created in the system of record (Elite 3E or SAP SuccessFactors). Supports audit trail, data lineage, and compliance reporting.',
    `assignment_notes` STRING COMMENT 'Free-text notes capturing additional context about this matter assignment, such as scope limitations, special instructions, or staffing rationale. Not intended for privileged legal content.',
    `assignment_role` STRING COMMENT 'The functional role the timekeeper holds on this matter. Drives billing authority, supervision hierarchy, and resource utilization reporting. [ENUM-REF-CANDIDATE: lead_partner|supervising_attorney|associate|paralegal|project_manager|of_counsel|staff — promote to reference product]',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the matter assignment. Active indicates the timekeeper is currently working on the matter; completed indicates the assignment has concluded; withdrawn indicates the timekeeper was removed prior to matter closure.. Valid values are `active|inactive|suspended|completed|withdrawn`',
    `assignment_updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this matter assignment record was most recently modified in the system of record. Supports change tracking, audit trail, and Silver layer incremental load processing.',
    `billing_attorney_flag` BOOLEAN COMMENT 'Indicates whether this timekeeper is designated as the Billing Attorney responsible for reviewing and approving prebills and invoices for this matter in Aderant Expert and Elite 3E.',
    `billing_authorization_flag` BOOLEAN COMMENT 'Indicates whether this timekeeper is authorized to record billable time against this matter. When False, time entries may be recorded as non-billable or blocked at prebill stage in Aderant Expert.',
    `billing_rate_currency` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the billing_rate_override for this matter assignment (e.g., USD, GBP, EUR). Supports multi-currency matter billing in international practices.. Valid values are `^[A-Z]{3}$`',
    `billing_rate_override` DECIMAL(18,2) COMMENT 'Matter-specific billing rate override for this timekeeper, expressed in the matters billing currency. When populated, supersedes the standard timekeeper rate defined in Aderant Expert for this specific matter assignment. Confidential commercial data.',
    `budgeted_fees` DECIMAL(18,2) COMMENT 'The total fee budget allocated to this timekeeper for this matter assignment, expressed in the matters billing currency. Used for LPM budget tracking, matter profitability analysis, and RPE/PPP calculations.',
    `budgeted_hours` DECIMAL(18,2) COMMENT 'The planned number of billable and non-billable hours allocated to this timekeeper for this matter assignment. Used for Legal Project Management (LPM) budgeting, resource planning, and variance analysis against actual hours.',
    `conflict_clearance_date` DATE COMMENT 'The date on which the conflict of interest check was cleared for this timekeeper on this matter. Supports audit trail requirements for professional responsibility and regulatory compliance.',
    `conflict_clearance_flag` BOOLEAN COMMENT 'Indicates whether a conflict of interest check has been completed and cleared for this timekeeper on this matter assignment. Sourced from Intapp Conflicts. Mandatory for professional responsibility compliance.',
    `cpd_hours_earned` DECIMAL(18,2) COMMENT 'Number of Continuing Professional Development (CPD) / Continuing Legal Education (CLE) hours earned by the timekeeper through work on this matter assignment, where applicable (e.g., pro bono matters qualifying for CLE credit). Tracked in SAP SuccessFactors.',
    `cross_border_flag` BOOLEAN COMMENT 'Indicates whether this assignment involves a timekeeper working across jurisdictional boundaries, triggering additional compliance checks for multi-jurisdictional practice rules, tax obligations, and regulatory reporting.',
    `end_date` DATE COMMENT 'The date on which the timekeepers assignment to the matter concluded or is scheduled to conclude. Null for open-ended assignments. Used for staffing timeline and resource planning.',
    `estimated_completion_date` DATE COMMENT 'The projected date by which this timekeepers work on the matter assignment is expected to be completed. Used for resource capacity planning, LPM milestone tracking, and matter staffing forecasting.',
    `ethical_wall_flag` BOOLEAN COMMENT 'Indicates whether an ethical wall (information barrier) has been erected around this timekeeper for this matter assignment to prevent conflicts of interest or protect Legal Professional Privilege (LPP). Managed in Intapp Conflicts.',
    `lpm_responsibility_flag` BOOLEAN COMMENT 'Indicates whether this timekeeper holds Legal Project Management (LPM) responsibility for this matter assignment, including budget oversight, milestone tracking, and resource coordination.',
    `matter_role_sequence` STRING COMMENT 'Numeric ordering of this timekeepers role within the matter team, used to distinguish primary from secondary assignments of the same role type (e.g., first associate vs. second associate). Supports matter team hierarchy display and reporting.',
    `originating_attorney_flag` BOOLEAN COMMENT 'Indicates whether this timekeeper is the originating attorney who brought the client or matter to the firm. Used for business development credit allocation, compensation calculations, and PPP/RPE attribution.',
    `pro_bono_committed_hours` DECIMAL(18,2) COMMENT 'The number of pro bono hours this timekeeper has committed to deliver on this matter assignment. Populated only when pro_bono_flag is True. Used for tracking individual and firm-level pro bono commitments against ABA Model Rule 6.1 targets.',
    `pro_bono_delivered_hours` DECIMAL(18,2) COMMENT 'Actual pro bono hours delivered by this timekeeper on this matter assignment to date. Populated only when pro_bono_flag is True. Enables variance analysis between committed and delivered pro bono hours for regulatory and firm reporting.',
    `pro_bono_flag` BOOLEAN COMMENT 'Indicates whether this assignment is on a pro bono matter. Drives pro bono hours reporting against firm-wide and individual attorney targets as required by ABA and state bar associations.',
    `responsible_attorney_flag` BOOLEAN COMMENT 'Indicates whether this timekeeper is designated as the Responsible Attorney (RA) for the matter, holding ultimate professional and ethical accountability. Relevant for conflict checking, client relationship management, and regulatory compliance.',
    `secondment_flag` BOOLEAN COMMENT 'Indicates whether this timekeeper is on secondment (temporarily assigned to a client or another office) for this matter. Affects billing treatment, cost allocation, and SAP SuccessFactors workforce records.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this matter assignment record was sourced (e.g., Elite 3E, SAP SuccessFactors). Supports data lineage tracking and Silver layer reconciliation in the Databricks Lakehouse.. Valid values are `elite_3e|sap_successfactors|aderant_expert`',
    `source_system_record_code` STRING COMMENT 'The native identifier of this matter assignment record in the originating source system (e.g., Elite 3E internal assignment key). Enables traceability from the Silver layer back to the operational system for reconciliation and audit purposes.',
    `start_date` DATE COMMENT 'The date on which the timekeepers assignment to the matter became effective. Used for resource utilization analysis, staffing timeline reporting, and RPE/PPP period calculations.',
    `supervision_level` STRING COMMENT 'Indicates the degree of supervision under which this timekeeper operates on this matter. Relevant for professional responsibility compliance, associate development tracking, and quality control under ABA Model Rules.. Valid values are `independent|supervised|co_supervised`',
    `wip_hours_unbilled` DECIMAL(18,2) COMMENT 'Hours recorded by this timekeeper on this matter that have been entered in Elite 3E but not yet included on a client invoice. Represents the timekeepers contribution to the matters Work in Progress (WIP) balance for revenue recognition and collections management.',
    CONSTRAINT pk_matter_assignment PRIMARY KEY(`matter_assignment_id`)
) COMMENT 'Association record linking timekeepers to specific matters with defined roles, responsibilities, and time periods. Captures assignment role (lead partner, supervising attorney, associate, paralegal, project manager), assignment start and end dates, budgeted hours, actual hours to date, billing authorization flag, LPM responsibility flag, pro bono matter flag, pro bono hours commitment and delivery tracking, and assignment status. Enables resource utilization tracking, matter staffing analysis, RPE/PPP calculations, and pro bono hours reporting against firm and individual targets. This is the workforce domains authoritative record of who works on what.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique surrogate identifier for each performance review record in the workforce domain. Primary key for the performance_review data product.',
    `calibration_session_id` BIGINT COMMENT 'Reference to the talent calibration session in which this review was discussed and the overall rating was validated against peer group. Calibration sessions ensure rating consistency across practice groups and seniority levels.',
    `practice_group_id` BIGINT COMMENT 'Foreign key linking to workforce.practice_group. Business justification: Performance reviews are conducted within practice group context, with practice group managing partners often serving as reviewers or calibration participants. The performance_review table currently ha',
    `timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper (attorney, paralegal, or staff member) who is the subject of this performance review. Sourced from SAP SuccessFactors employee master.',
    `reviewed_timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Performance reviews are conducted for a specific timekeeper. Critical for compensation decisions and partnership track.',
    `reviewer_timekeeper_id` BIGINT COMMENT 'Reference to the supervising attorney, partner, or manager who authored and submitted this performance review. Typically the direct supervisor or practice group leader.',
    `to_timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Each performance review evaluates a specific timekeeper. Required for compensation decisions, promotion tracking, and utilization variance analysis.',
    `acknowledgement_date` DATE COMMENT 'The date on which the timekeeper formally acknowledged their performance review in SAP SuccessFactors. Provides audit trail for employment law compliance and HR record-keeping.',
    `billable_hours_achieved` DECIMAL(18,2) COMMENT 'The actual billable hours recorded by the timekeeper during the review period, sourced from Elite 3E or Aderant Expert time entry systems. Compared against billable_hours_target to assess performance.',
    `billable_hours_target` DECIMAL(18,2) COMMENT 'The annual or period billable hours target assigned to the timekeeper at the start of the review cycle, as set by practice group leadership. A core KPI for attorney performance evaluation and compensation decisions.',
    `business_development_hours` DECIMAL(18,2) COMMENT 'Total hours invested by the timekeeper in business development activities (pitches, RFP responses, client entertainment, networking) during the review period. Sourced from non-billable time entries in Elite 3E or Aderant Expert.',
    `client_feedback_score` DECIMAL(18,2) COMMENT 'Aggregated client satisfaction score for the timekeeper during the review period, typically on a 1.0–5.0 or 1–10 scale derived from client surveys or matter feedback programs. Reflects service quality and client relationship management.',
    `collection_rate` DECIMAL(18,2) COMMENT 'The percentage of billed fees actually collected from clients attributable to the timekeepers work during the review period. Distinct from realization_rate; reflects accounts receivable performance and client payment behavior.',
    `compensation_adjustment_recommended` BOOLEAN COMMENT 'Indicates whether the reviewer has recommended a compensation adjustment (salary increase, bonus, or equity tier change) as an outcome of this performance review. Feeds the compensation decision workflow.',
    `completion_date` DATE COMMENT 'The date on which the performance review was formally completed and signed off by the reviewer. Used to track compliance with firm review deadlines and feeds partnership track timelines.',
    `cpd_hours_completed` DECIMAL(18,2) COMMENT 'Total Continuing Professional Development (CPD) or Continuing Legal Education (CLE) hours completed by the timekeeper during the review period. Tracked for regulatory compliance with bar admission requirements and firm development standards.',
    `cpd_hours_required` DECIMAL(18,2) COMMENT 'The minimum CPD/CLE hours required for the timekeeper during the review period, as mandated by the relevant bar association or regulatory body for their jurisdiction and practice area.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this performance review record was first created in the Silver Layer lakehouse, sourced from SAP SuccessFactors. Provides data lineage and audit trail for the record lifecycle.',
    `development_areas_narrative` STRING COMMENT 'Free-text narrative authored by the reviewer identifying areas for improvement and development goals for the timekeeper in the next review period. Feeds individual development plans in SAP SuccessFactors.',
    `employee_acknowledgement` BOOLEAN COMMENT 'Indicates whether the timekeeper has formally acknowledged receipt and review of their completed performance evaluation in SAP SuccessFactors. Required for HR compliance and employment law documentation.',
    `fte_status` STRING COMMENT 'The Full-Time Equivalent (FTE) employment status of the timekeeper during the review period. Affects billable hours targets, utilization rate calculations, and compensation benchmarking.. Valid values are `full_time|part_time|secondment|contract`',
    `leadership_rating` DECIMAL(18,2) COMMENT 'Numerical rating assessing the timekeepers leadership contributions, mentoring of junior staff, participation in firm committees, and professional development activities during the review period. Typically on a 1.0–5.0 scale.',
    `matter_count` STRING COMMENT 'The total number of active matters on which the timekeeper recorded time or was assigned during the review period. Provides context for workload assessment and resource allocation analysis.',
    `origination_credit_amount` DECIMAL(18,2) COMMENT 'The total value of new business originated by the timekeeper during the review period, expressed in the firms base currency. Origination credit is a key metric for partnership track and compensation decisions, reflecting business development contribution.',
    `overall_rating` DECIMAL(18,2) COMMENT 'The composite numerical performance rating assigned to the timekeeper for the review period, typically on a 1.0–5.0 scale as configured in SAP SuccessFactors. Drives compensation band placement, partnership track eligibility, and bonus pool allocation.',
    `overall_rating_label` STRING COMMENT 'Descriptive label corresponding to the overall_rating numeric score, as defined in the firms performance calibration framework. Used in narrative reporting and partnership committee presentations.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `partnership_track_eligible` BOOLEAN COMMENT 'Indicates whether the timekeeper has been identified as eligible for partnership track consideration based on this review cycles outcomes. Drives succession planning and partnership committee workflows.',
    `performance_improvement_plan_required` BOOLEAN COMMENT 'Indicates whether a formal Performance Improvement Plan (PIP) has been triggered as a result of this review. Drives HR case management workflows and compliance documentation requirements.',
    `pro_bono_hours_delivered` DECIMAL(18,2) COMMENT 'The actual pro bono hours recorded by the timekeeper during the review period. Compared against pro_bono_hours_target to assess compliance with firm pro bono commitments and ABA aspirational standards.',
    `pro_bono_hours_target` DECIMAL(18,2) COMMENT 'The pro bono hours target assigned to the timekeeper for the review period, in alignment with the firms pro bono policy and ABA Model Rule 6.1 aspirational standard of 50 hours per year.',
    `promotion_recommended` BOOLEAN COMMENT 'Indicates whether the reviewer has recommended the timekeeper for promotion (e.g., associate to senior associate, senior associate to counsel, counsel to partner) as an outcome of this review.',
    `realization_rate` DECIMAL(18,2) COMMENT 'The percentage of the timekeepers standard billing rate actually collected after write-downs and write-offs during the review period. A key financial performance metric for attorneys, reflecting billing efficiency and client relationship quality.',
    `review_cycle_year` STRING COMMENT 'The calendar or fiscal year in which this performance review cycle falls (e.g., 2024). Used to group and compare reviews across annual cycles for partnership track and compensation decisions.',
    `review_period_end_date` DATE COMMENT 'The last date of the performance evaluation period covered by this review. Together with review_period_start_date, defines the measurement window for all quantitative metrics.',
    `review_period_start_date` DATE COMMENT 'The first date of the performance evaluation period covered by this review. Defines the window over which billable hours, utilization, and other metrics are measured.',
    `review_status` STRING COMMENT 'Current workflow state of the performance review record within the SAP SuccessFactors performance management cycle. Drives routing, visibility, and downstream compensation processing.. Valid values are `draft|in_progress|pending_approval|completed|cancelled`',
    `review_type` STRING COMMENT 'Classification of the performance review by its purpose and timing within the HR cycle. Annual reviews drive compensation; mid-year reviews are developmental; probationary reviews assess new hires; promotion reviews support partnership track decisions; exit reviews capture departure context.. Valid values are `annual|mid_year|probationary|promotion|exit`',
    `reviewer_comments` STRING COMMENT 'Overall narrative comments provided by the reviewer summarising the performance evaluation, including context for the overall rating and any specific recommendations. Distinct from strengths and development area narratives.',
    `self_assessment_narrative` STRING COMMENT 'Free-text self-assessment narrative authored by the timekeeper themselves as part of the review process. Captures the employees own perspective on their performance, achievements, and development needs.',
    `seniority_level` STRING COMMENT 'The timekeepers seniority classification at the time of the review (e.g., equity partner, counsel, senior associate, associate, paralegal, staff). Used for peer group benchmarking, PPP/PEP calculations, and compensation band assignment.. Valid values are `partner|counsel|senior_associate|associate|paralegal|staff`',
    `source_system_review_code` STRING COMMENT 'The native performance review identifier as assigned by SAP SuccessFactors Performance Management module. Enables traceability back to the system of record for audit and reconciliation purposes.',
    `strengths_narrative` STRING COMMENT 'Free-text narrative authored by the reviewer describing the timekeepers key strengths, accomplishments, and positive contributions during the review period. Stored as sourced from SAP SuccessFactors performance form.',
    `submitted_timestamp` TIMESTAMP COMMENT 'The precise date and time when the reviewer submitted the completed performance review in SAP SuccessFactors. Provides audit trail for compliance with firm review submission deadlines.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this performance review record was last modified in the Silver Layer lakehouse. Tracks changes from SAP SuccessFactors delta loads and supports incremental processing and audit compliance.',
    `utilization_rate_actual` DECIMAL(18,2) COMMENT 'The actual utilization rate achieved by the timekeeper during the review period, expressed as a percentage. Calculated from time entry data in Elite 3E or Aderant Expert. Used in utilization variance analysis and compensation decisions.',
    `utilization_rate_target` DECIMAL(18,2) COMMENT 'The target utilization rate (billable hours as a percentage of total available hours) set for the timekeeper for the review period. Expressed as a percentage (e.g., 85.00 for 85%). Feeds utilization variance analysis.',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Annual and mid-year performance evaluation records for all timekeepers and staff. Stores review cycle year, review type (annual, mid-year, probationary, promotion), overall rating, billable hours target and achieved, utilization rate target and actual, origination credit, client feedback score, pro bono hours target and delivered, business development hours, leadership and development rating, reviewer identity, review completion date, and narrative comments. Sourced from SAP SuccessFactors Performance Management module. Feeds partnership track, compensation decisions, and utilization variance analysis.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`workforce`.`compensation_record` (
    `compensation_record_id` BIGINT COMMENT 'Unique surrogate identifier for each compensation record in the workforce domain. Primary key for the compensation_record data product.',
    `compensation_plan_id` BIGINT COMMENT 'Reference to the firm-defined compensation plan template (e.g., lockstep associate plan, equity partner plan, staff merit plan) under which this record is governed.',
    `timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Compensation records belong to a specific timekeeper. Critical for payroll and PPP/PEP calculations.',
    `practice_group_id` BIGINT COMMENT 'Foreign key linking to workforce.practice_group. Business justification: Compensation structures and pay bands are often defined by practice group. The compensation_record table currently has practice_group_code (STRING) but no FK to practice_group. This normalization esta',
    `record_owner_timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Compensation records belong to a specific timekeeper. Critical for payroll and PPP/PEP calculations.',
    `to_timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Each compensation record belongs to a specific timekeeper. Required for payroll, PPP/PEP calculations, and partner compensation modeling.',
    `approval_date` DATE COMMENT 'Date on which this compensation record received final management approval. Used for audit trail, governance reporting, and determining when compensation changes become actionable for payroll.',
    `approval_status` STRING COMMENT 'Current workflow state of this compensation record within the firms HR approval process. Tracks progression from draft through management and executive sign-off to final approval or rejection.. Valid values are `draft|pending_approval|approved|rejected|withdrawn`',
    `approved_by` STRING COMMENT 'Name or identifier of the firm management authority (e.g., Managing Partner, Compensation Committee Chair, HR Director) who granted final approval for this compensation record. Supports governance and audit trail requirements.',
    `base_salary` DECIMAL(18,2) COMMENT 'Annual base salary amount for the timekeeper in the firms operating currency. Excludes bonuses, origination credits, and profit share distributions. Core input for PPP and RPE financial analytics.',
    `benefits_tier_code` STRING COMMENT 'Code identifying the benefits package tier assigned to this timekeeper (e.g., BASIC, STANDARD, ENHANCED, EXECUTIVE). Determines eligibility for health insurance, retirement contributions, professional indemnity coverage, and other firm-provided benefits.',
    `bonus_actual_amount` DECIMAL(18,2) COMMENT 'Actual bonus amount paid to the timekeeper for the compensation period following performance evaluation and management approval. May differ from the target based on individual and firm performance outcomes.',
    `bonus_target_amount` DECIMAL(18,2) COMMENT 'Target bonus amount established for the timekeeper at the start of the performance period under the applicable bonus plan. Represents the expected payout at 100% performance achievement. Used for compensation modeling and budget forecasting.',
    `capital_contribution` DECIMAL(18,2) COMMENT 'Amount of capital contributed by the equity partner to the firm as required under the partnership agreement. Null for non-equity timekeepers. Used in partner financial modeling and balance sheet reporting.',
    `compensation_review_cycle` STRING COMMENT 'Frequency of the compensation review cycle under which this record was generated. Determines the cadence of pay adjustments and supports scheduling of future review events.. Valid values are `annual|semi_annual|quarterly|off_cycle`',
    `compensation_type` STRING COMMENT 'Classification of the compensation structure applied to this timekeeper. Lockstep advances by seniority year; merit-based is performance-driven; equity and non-equity partner tiers reflect partnership status; staff covers non-attorney personnel.. Valid values are `lockstep|merit_based|equity_partner|non_equity_partner|staff`',
    `compensation_year` STRING COMMENT 'The fiscal or calendar year to which this compensation record applies. Used to partition historical compensation data for year-over-year PPP, PEP, and RPE trend analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compensation record was first created in the data platform. Supports audit trail, data lineage, and compliance with record-keeping obligations under applicable regulations.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all monetary compensation amounts on this record are denominated (e.g., USD, GBP, EUR). Supports multi-jurisdictional firm operations.. Valid values are `^[A-Z]{3}$`',
    `deferred_compensation` DECIMAL(18,2) COMMENT 'Amount of compensation deferred to a future period under a firm-sponsored deferred compensation arrangement. Common for equity partners deferring a portion of profit distributions. Supports long-term compensation liability reporting.',
    `draw_amount` DECIMAL(18,2) COMMENT 'Monthly or periodic draw amount paid to an equity partner as an advance against their anticipated profit share distribution. Null for non-partner timekeepers. Used in partner cash flow management and year-end reconciliation against actual profit share.',
    `effective_date` DATE COMMENT 'Date from which this compensation record becomes operative for the timekeeper. Used to determine the applicable pay period for billing rate alignment, payroll processing, and PPP/PEP analytics.',
    `equity_partner_points` DECIMAL(18,2) COMMENT 'Numeric points value assigned to the equity partner under the firms points-based profit sharing system. Determines the partners proportional share of distributable profits. Null for non-equity timekeepers. Key input for PPP and PEP calculations.',
    `equity_partner_tier_name` STRING COMMENT 'Human-readable name of the equity partner tier assigned to this timekeeper (e.g., Tier 1, Senior Partner, Managing Partner). Null for non-equity timekeepers. Drives profit share and capital contribution calculations for PEP and PPP analytics.',
    `expiry_date` DATE COMMENT 'Date on which this compensation record ceases to be operative. Null for open-ended records. Used to manage compensation history and support point-in-time analytics for PPP and PEP reporting.',
    `external_record_ref` STRING COMMENT 'Externally-known reference number or identifier for this compensation record as assigned by SAP SuccessFactors or the firms HR system of record. Used for cross-system reconciliation.',
    `firm_office_code` STRING COMMENT 'Code identifying the firm office or location to which this timekeeper is assigned for compensation purposes. Used to apply jurisdiction-specific pay scales, benefits rules, and local regulatory compliance requirements.',
    `fte_fraction` DECIMAL(18,2) COMMENT 'Numeric fraction representing the timekeepers working proportion relative to a full-time position (e.g., 1.0 for full-time, 0.5 for half-time). Used to prorate salary, bonus targets, and billable hour targets for part-time timekeepers.',
    `fte_status` STRING COMMENT 'Employment basis of the timekeeper indicating whether they are a full-time equivalent (FTE), part-time, contract, or on secondment. Affects compensation proration, benefits eligibility, and FTE headcount reporting for firm management analytics.. Valid values are `full_time|part_time|contract|secondment`',
    `is_equity_partner` BOOLEAN COMMENT 'Indicates whether the timekeeper holds equity partner status in the firm. True for equity partners who participate in profit sharing and capital contributions; False for all other timekeepers. Key filter for PEP and PPP analytics.',
    `job_title` STRING COMMENT 'Official job title of the timekeeper as recorded in the HR system of record (e.g., Associate, Senior Associate, Counsel, Partner, Paralegal, Legal Secretary). Used for compensation benchmarking and workforce reporting.',
    `lockstep_year` STRING COMMENT 'The seniority year within the firms lockstep compensation progression at which this timekeeper is placed for the compensation period. Null for merit-based or partner compensation structures. Drives automatic salary advancement in lockstep plans.',
    `merit_increase_pct` DECIMAL(18,2) COMMENT 'Percentage salary increase awarded to the timekeeper based on individual performance evaluation for the compensation cycle. Null for lockstep or partner compensation structures. Supports merit budget analysis and pay equity reporting.',
    `origination_bonus` DECIMAL(18,2) COMMENT 'Bonus amount awarded to the timekeeper for originating new client business or matters during the compensation period. Reflects the firms business development incentive structure and is a key component of partner compensation analytics including RPE.',
    `pay_band_code` STRING COMMENT 'Firm-defined pay band or grade code assigned to this timekeeper under the applicable compensation plan (e.g., A1, A2, SA1, P1 for associates and senior associates). Drives lockstep or merit-based salary range boundaries.',
    `pay_band_max` DECIMAL(18,2) COMMENT 'Maximum salary amount defined for the assigned pay band. Used to validate that the timekeepers base salary does not exceed the approved compensation ceiling and supports pay equity reporting.',
    `pay_band_min` DECIMAL(18,2) COMMENT 'Minimum salary amount defined for the assigned pay band. Used to validate that the timekeepers base salary falls within the approved compensation range and supports equity analysis.',
    `pay_equity_flag` BOOLEAN COMMENT 'Indicates whether this compensation record has been flagged for pay equity review, typically triggered when the timekeepers compensation falls outside the expected range for their grade, gender, or demographic cohort. Supports compliance with pay equity legislation.',
    `performance_rating` STRING COMMENT 'Firm-defined performance rating assigned to the timekeeper for the compensation cycle (e.g., Exceeds Expectations, Meets Expectations, Below Expectations). Drives merit increase percentage and bonus payout calculations. [ENUM-REF-CANDIDATE: exceeds_expectations|meets_expectations|partially_meets|below_expectations|not_rated — promote to reference product]',
    `profit_share_pct` DECIMAL(18,2) COMMENT 'Percentage of the firms distributable profits allocated to this equity partner for the compensation period. Derived from the partners points relative to total firm points but stored as a discrete record for audit and historical reporting. Null for non-equity timekeepers.',
    `retirement_contribution_pct` DECIMAL(18,2) COMMENT 'Firms contribution percentage to the timekeepers retirement or pension plan as a proportion of base salary. Supports total compensation cost modeling and benefits benchmarking.',
    `source_system_ref` STRING COMMENT 'Identifier of the originating record in SAP SuccessFactors Compensation module (e.g., the SuccessFactors compensation form ID or employee compensation record ID). Supports data lineage, reconciliation, and audit traceability from the Silver layer back to the system of record.',
    `timekeeper_grade` STRING COMMENT 'Seniority or grade classification of the timekeeper within the firms career framework (e.g., Year 1 Associate, Year 5 Associate, Senior Associate, Counsel, Non-Equity Partner, Equity Partner). Drives pay band assignment and lockstep progression.',
    `total_cash_compensation` DECIMAL(18,2) COMMENT 'Total cash compensation for the timekeeper for the compensation period, comprising base salary plus actual bonus payout plus origination bonus. Stored as a discrete field (not computed at query time) to support point-in-time compensation reporting and regulatory pay equity analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this compensation record was last modified in the data platform. Used to detect changes, support incremental data processing, and maintain audit trail integrity.',
    CONSTRAINT pk_compensation_record PRIMARY KEY(`compensation_record_id`)
) COMMENT 'Confidential compensation record for each timekeeper capturing base salary, lockstep or merit-based pay band, equity partner tier designation (tier name, points value, profit share percentage, capital contribution), bonus target and actual payout, origination bonus, benefits package tier, effective date, and compensation approval status. Supports PPP, PEP, and RPE financial analytics including partner compensation modeling across equity tiers. Sourced from SAP SuccessFactors Compensation module. Access is restricted to HR and firm management.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` (
    `recruitment_requisition_id` BIGINT COMMENT 'Unique surrogate identifier for each recruitment requisition record in the workforce data product. Primary key for the silver-layer lakehouse table. Entity role: TRANSACTION_HEADER.',
    `practice_group_id` BIGINT COMMENT 'FK to workforce.practice_group.practice_group_id — Recruitment requisitions are opened for a specific practice group. Links hiring to organizational structure.',
    `primary_recruitment_practice_group_id` BIGINT COMMENT 'FK to workforce.practice_group',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the attorney, partner, or staff manager who initiated and owns the recruitment requisition. Corresponds to the PARTY_REFERENCE category for TRANSACTION_HEADER role. Links to the workforce employee/timekeeper master record.',
    `requesting_practice_group_id` BIGINT COMMENT 'FK to workforce.practice_group.practice_group_id — Recruitment requisitions are opened for specific practice groups. Required for headcount planning alignment.',
    `succession_plan_id` BIGINT COMMENT 'Foreign key linking to workforce.succession_plan. Business justification: Recruitment requisitions may be created to fulfill succession plans when a key role needs to be filled. The recruitment_requisition table has succession_plan_flag (BOOLEAN) indicating the requisition ',
    `target_practice_group_id` BIGINT COMMENT 'FK to workforce.practice_group.practice_group_id — Each recruitment requisition is opened for a specific practice group. Required for headcount planning and budget tracking by practice area.',
    `approved_headcount` STRING COMMENT 'Number of full-time equivalent (FTE) positions approved for hire under this requisition. Typically 1 for individual hires; may be greater for cohort or class-year campus recruiting campaigns. Drives headcount budget reconciliation.',
    `background_check_required_flag` BOOLEAN COMMENT 'Indicates whether candidates for this requisition are required to complete a background check (criminal, credit, education verification) as part of the pre-employment screening process. Driven by position type, seniority level, and client-facing responsibilities.',
    `bar_admission_required_flag` BOOLEAN COMMENT 'Indicates whether the open position requires the candidate to hold an active bar admission or solicitor qualification. True for attorney and counsel roles; False for paralegal, legal secretary, and business services staff. Drives compliance screening in the candidate pipeline.',
    `bar_jurisdiction_required` STRING COMMENT 'The specific jurisdiction(s) in which the candidate must hold an active bar admission or solicitor qualification (e.g., New York, California, England and Wales). Null for non-attorney positions. Used for compliance screening and lateral hire eligibility assessment.',
    `close_date` DATE COMMENT 'The date on which the recruitment requisition was formally closed, whether due to being filled, cancelled, or withdrawn. Used to calculate time-to-fill KPIs and recruiter performance metrics.',
    `close_reason` STRING COMMENT 'The business reason for closing the recruitment requisition. Distinguishes successful fills from cancellations due to headcount freezes, organisational restructuring, or strategic withdrawal. Critical for workforce planning analytics.. Valid values are `filled|cancelled|withdrawn|headcount_frozen|restructured`',
    `compensation_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the salary band and compensation figures associated with this requisition (e.g., USD, GBP, EUR). Required for multi-office firms operating across jurisdictions.. Valid values are `^[A-Z]{3}$`',
    `conflicts_prescreening_required_flag` BOOLEAN COMMENT 'Indicates whether candidates for this requisition must undergo a conflicts of interest pre-screen via Intapp Conflicts before progressing to interview stages. Mandatory for attorney and counsel positions to satisfy professional responsibility obligations and ethical wall requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the recruitment requisition record was first created in SAP SuccessFactors. Corresponds to the RECORD_AUDIT_CREATED category for TRANSACTION_HEADER role. Stored in ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `current_pipeline_count` STRING COMMENT 'Total number of active candidates currently in the pipeline for this requisition across all interview stages. Provides a real-time snapshot of pipeline depth for recruiter workload management and hiring manager reporting.',
    `employment_type` STRING COMMENT 'Classification of the employment arrangement for the open position. Full-time (FTE) positions are tracked against approved headcount budgets; secondments and summer associate roles have distinct billing and supervision requirements.. Valid values are `full_time|part_time|contract|secondment|summer_associate`',
    `firm_office_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the office location of the open position. Used for jurisdiction-specific regulatory compliance, GDPR applicability, and compensation currency determination.. Valid values are `^[A-Z]{3}$`',
    `firm_office_location` STRING COMMENT 'The firm office or geographic location for which the position is being recruited (e.g., New York, London, Hong Kong). Used for jurisdiction-specific bar admission requirements and compensation benchmarking.',
    `interview_stage_count` STRING COMMENT 'Total number of defined interview stages configured for this requisitions hiring process in SAP SuccessFactors (e.g., phone screen, first-round, callback, partner interview). Used for process standardisation and time-to-hire analytics.',
    `job_description_url` STRING COMMENT 'URL link to the full job description document stored in the firms document management system (iManage Work or NetDocuments) or careers portal. Provides recruiters and hiring managers with direct access to the approved position specification.. Valid values are `^https?://.+`',
    `job_posting_date` DATE COMMENT 'The date on which the position was first published externally on job boards, the firms careers portal, or law school recruiting platforms. Used to measure sourcing lead time and candidate pipeline velocity.',
    `kyc_aml_check_required_flag` BOOLEAN COMMENT 'Indicates whether the candidate must undergo KYC (Know Your Client) and AML (Anti-Money Laundering) screening as part of the pre-employment process. Applicable for positions with access to client trust accounts (IOLTA), financial transactions, or regulated activities under FATF guidelines.',
    `law_school_target_tier` STRING COMMENT 'For law school campus recruiting requisitions, the target law school ranking tier from which the firm is recruiting (e.g., T14 top-14 law schools, Top 25, Top 50, any ABA-accredited school). Not applicable for lateral hire or staff requisitions.. Valid values are `t14|top_25|top_50|any_accredited|not_applicable`',
    `offer_accepted_date` DATE COMMENT 'The date on which the selected candidate formally accepted the employment offer. Marks the transition from active recruiting to onboarding. Null if offer has not yet been accepted.',
    `offer_date` DATE COMMENT 'The date on which the formal employment offer was extended to the selected candidate. Used to calculate offer-to-acceptance cycle time and compliance with candidate communication SLAs.',
    `offer_extended_flag` BOOLEAN COMMENT 'Indicates whether a formal offer of employment has been extended to at least one candidate under this requisition. True when an offer letter has been issued; False when no offer has yet been made. Used for pipeline conversion rate reporting.',
    `offer_outcome` STRING COMMENT 'The outcome of the most recent employment offer extended under this requisition. Accepted indicates the candidate accepted the offer; declined indicates candidate rejection; rescinded indicates the firm withdrew the offer. Null when no offer has been extended.. Valid values are `accepted|declined|rescinded|pending|expired`',
    `open_date` DATE COMMENT 'The date on which the recruitment requisition was formally opened and approved for sourcing. Represents the principal business event timestamp (BUSINESS_EVENT_TIMESTAMP) for the TRANSACTION_HEADER role. Used to calculate time-to-fill and recruiter SLA metrics.',
    `position_title` STRING COMMENT 'Official job title for the open position as defined in the firms job architecture (e.g., Associate Attorney, Senior Paralegal, Legal Project Manager, Equity Partner). Used in job postings and offer letters.',
    `position_type` STRING COMMENT 'Categorical classification of the open position distinguishing attorney roles from paralegal, legal secretary, and business services staff. Determines applicable bar admission requirements and CPD/CLE obligations. [ENUM-REF-CANDIDATE: attorney|paralegal|legal_secretary|staff|partner|of_counsel — promote to reference product]. Valid values are `attorney|paralegal|legal_secretary|staff|partner|of_counsel`',
    `replacement_or_new_flag` STRING COMMENT 'Indicates whether the requisition is for a replacement of a departing employee, a net-new approved headcount position, or a backfill for a temporarily vacated role. Critical for headcount budget reconciliation and workforce planning analytics.. Valid values are `replacement|new_headcount|backfill`',
    `requisition_notes` STRING COMMENT 'Free-text field for additional context, special requirements, or internal notes related to the recruitment requisition as entered by the recruiter or HR business partner in SAP SuccessFactors. May include client-specific staffing requirements or practice group preferences.',
    `requisition_number` STRING COMMENT 'Externally-known, human-readable business identifier for the recruitment requisition as assigned by SAP SuccessFactors Recruiting. Used in communications with hiring managers, HR business partners, and candidates. Corresponds to the BUSINESS_IDENTIFIER category for TRANSACTION_HEADER role.. Valid values are `^REQ-[0-9]{6,10}$`',
    `requisition_priority` STRING COMMENT 'Business priority level assigned to the requisition by the hiring manager or HR business partner. Critical and high-priority requisitions receive accelerated recruiter attention and may trigger executive escalation if unfilled beyond SLA thresholds.. Valid values are `critical|high|medium|low`',
    `requisition_status` STRING COMMENT 'Current lifecycle state of the recruitment requisition. Drives workflow routing, reporting, and headcount budget tracking. Corresponds to the LIFECYCLE_STATUS category for TRANSACTION_HEADER role. [ENUM-REF-CANDIDATE: draft|open|on_hold|filled|cancelled|closed — promote to reference product if additional states are required]. Valid values are `draft|open|on_hold|filled|cancelled|closed`',
    `salary_band_max` DECIMAL(18,2) COMMENT 'The maximum base compensation amount for the approved salary band associated with this requisition, expressed in the office locations local currency. Used for compensation benchmarking, budget approval, and pay equity analysis. Classified confidential as it represents sensitive business compensation data.',
    `salary_band_min` DECIMAL(18,2) COMMENT 'The minimum base compensation amount for the approved salary band associated with this requisition, expressed in the office locations local currency. Used for compensation benchmarking and pay equity analysis. Classified confidential as it represents sensitive business compensation data.',
    `seniority_level` STRING COMMENT 'Seniority classification of the open position within the firms attorney and staff hierarchy. Drives compensation band selection, PPP/PEP tier assignment, and approval routing. [ENUM-REF-CANDIDATE: entry|junior|mid|senior|counsel|partner|equity_partner — promote to reference product]',
    `sourcing_agency_name` STRING COMMENT 'Name of the external legal search firm or recruitment agency engaged to source candidates for this requisition (e.g., Major Lindsey & Africa, Lateral Link). Null for internally sourced or campus recruiting requisitions. Used for agency fee tracking and vendor performance management.',
    `sourcing_channel` STRING COMMENT 'Primary channel through which candidates are being sourced for this requisition. Lateral hire indicates experienced attorney recruitment; law_school_campus indicates on-campus recruiting; ALSP (Alternative Legal Service Provider) indicates contract staffing; referral indicates employee referral programme. Used for cost-per-hire and sourcing effectiveness analytics.. Valid values are `lateral_hire|law_school_campus|alsp|referral|job_board|search_firm`',
    `target_start_date` DATE COMMENT 'The desired or planned start date for the successful candidate as specified by the hiring manager at the time of requisition creation. Used for workforce planning, matter staffing projections, and bar admission timeline management.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the recruitment requisition record in SAP SuccessFactors. Corresponds to the RECORD_AUDIT_UPDATED category for TRANSACTION_HEADER role. Used for incremental data pipeline processing and audit trails.',
    `years_experience_min` STRING COMMENT 'Minimum number of years of post-qualification or relevant legal experience required for the open position. Used to filter candidate pipelines and benchmark against lateral hire market data.',
    CONSTRAINT pk_recruitment_requisition PRIMARY KEY(`recruitment_requisition_id`)
) COMMENT 'Tracks open and closed attorney and staff recruitment requisitions from job posting through offer acceptance, including the embedded candidate pipeline for each requisition. Stores position title, seniority level, practice group, office location, requisition open date, target start date, approved headcount budget, sourcing channel (lateral hire, law school campus, ALSP, referral), recruiter assigned, interview stages, offer extended flag, offer outcome, and requisition close reason. Candidate pipeline attributes per requisition include candidate name, current employer, law school, years of experience, bar admissions held, application stage, background check status, and conflicts pre-screen status. Sourced from SAP SuccessFactors Recruiting module.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`workforce`.`leave_record` (
    `leave_record_id` BIGINT COMMENT 'Unique surrogate identifier for each leave record in the workforce domain. Primary key for the leave_record data product sourced from SAP SuccessFactors Time and Attendance.',
    `timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Leave records track absences for a specific timekeeper. Critical for resource planning and billable hours target adjustment.',
    `practice_group_id` BIGINT COMMENT 'Foreign key to workforce.practice_group.practice_group_id',
    `primary_leave_timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper (attorney, paralegal, or staff member) for whom this leave record applies. Links to the workforce.timekeeper master record.',
    `tertiary_leave_covering_timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper assigned as primary cover for the absent timekeepers matters. Populated when coverage_arrangement is internal_cover or shared_cover. Supports matter staffing continuity and conflict checking.',
    `to_timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Each leave record belongs to a specific timekeeper. Required for resource planning, billable hours target adjustment, and matter staffing continuity.',
    `actual_return_date` DATE COMMENT 'The actual calendar date on which the timekeeper returned to active work. May differ from approved_end_date due to early return, extended leave, or phased return arrangements. Null until the timekeeper has returned.',
    `approval_date` DATE COMMENT 'The calendar date on which the approving manager formally approved the leave request in SAP SuccessFactors. Used for SLA measurement of HR approval turnaround time.',
    `approved_duration_days` STRING COMMENT 'Total number of calendar days covered by the approved leave period, calculated from approved_start_date to approved_end_date inclusive. Used for entitlement balance deduction and payroll adjustment.',
    `approved_end_date` DATE COMMENT 'The formally approved last calendar day of the leave period. Nullable for open-ended leaves such as long-term medical or parental leave where return date is not yet confirmed.',
    `approved_start_date` DATE COMMENT 'The formally approved first calendar day of the leave period. Used for matter staffing continuity planning, billable hours target proration, and payroll processing.',
    `bar_compliance_risk_flag` BOOLEAN COMMENT 'Indicates whether this leave event creates a risk of non-compliance with bar admission CPD/CLE requirements (True). Triggers proactive outreach to the timekeeper and bar compliance team.',
    `billable_hours_target_impact` DECIMAL(18,2) COMMENT 'Reduction in the timekeepers annual billable hours target (in hours) attributable to this leave event. Used by Legal Project Management (LPM) and practice group leaders to reforecast capacity and matter staffing.',
    `cancellation_date` DATE COMMENT 'The calendar date on which an approved or pending leave request was cancelled, either by the employee or HR. Populated only when leave_status is cancelled. Triggers reversal of payroll adjustments and entitlement balance restoration.',
    `coverage_arrangement` STRING COMMENT 'Describes the staffing continuity arrangement put in place to cover the absent timekeepers matters and client responsibilities during the leave period.. Valid values are `none|internal_cover|external_cover|matter_reassignment|shared_cover`',
    `cpd_impact_hours` DECIMAL(18,2) COMMENT 'Number of Continuing Professional Development (CPD)/Continuing Legal Education (CLE) hours that may be deferred or waived as a result of this leave event. Used by HR to manage bar compliance and CPD exemption applications.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp at which this leave record was first created in the Databricks Silver Layer, sourced from SAP SuccessFactors. Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the payroll_adjustment_amount (e.g., USD, GBP, EUR). Supports multi-jurisdiction payroll processing.. Valid values are `^[A-Z]{3}$`',
    `employee_notes` STRING COMMENT 'Free-text notes submitted by the timekeeper as part of the leave request, providing context or special instructions. Classified as confidential.',
    `hr_notes` STRING COMMENT 'Free-text notes entered by HR personnel regarding special circumstances, accommodation arrangements, or case-specific details for this leave record. Classified as confidential due to potential sensitivity of employment-related information.',
    `is_intermittent` BOOLEAN COMMENT 'Indicates whether the leave is taken intermittently (True) rather than as a continuous block (False). Intermittent leave requires separate scheduling and has different billable hours impact calculations under FMLA.',
    `is_paid` BOOLEAN COMMENT 'Indicates whether the leave is fully paid (True) or unpaid/partially unpaid (False). Drives payroll adjustment processing and IOLTA trust account considerations for partner draws.',
    `is_phased_return` BOOLEAN COMMENT 'Indicates whether the timekeeper is returning to work on a phased/reduced-hours basis (True) rather than full capacity (False). Affects FTE percentage, billable hours target, and matter staffing planning.',
    `leave_balance_after` DECIMAL(18,2) COMMENT 'The timekeepers accrued leave entitlement balance in days immediately after this leave event has been applied. Supports entitlement audit and payroll reconciliation.',
    `leave_balance_before` DECIMAL(18,2) COMMENT 'The timekeepers accrued leave entitlement balance in days immediately prior to this leave event being applied. Supports entitlement audit and dispute resolution.',
    `leave_reason_code` STRING COMMENT 'Standardised code from SAP SuccessFactors identifying the specific reason for the leave (e.g., FMLA-SELF, FMLA-FAMILY, PERSONAL-ILLNESS, MATERNITY, PATERNITY, SABBATICAL-RESEARCH). Sensitive business data used for HR reporting and regulatory compliance.',
    `leave_request_number` STRING COMMENT 'Externally visible, human-readable business identifier for the leave request as generated by SAP SuccessFactors Time and Attendance. Used for cross-system reference and employee communications.. Valid values are `^LR-[0-9]{4}-[0-9]{6}$`',
    `leave_status` STRING COMMENT 'Current lifecycle state of the leave record within the approval and execution workflow. Drives resource planning and matter staffing continuity actions.. Valid values are `pending|approved|rejected|cancelled|active|completed`',
    `leave_type` STRING COMMENT 'Classification of the leave event by its nature and entitlement basis. Drives payroll treatment, billable hours target adjustment, and matter staffing continuity planning. [ENUM-REF-CANDIDATE: annual|parental|medical|sabbatical|unpaid|bereavement|jury_duty|military|study|compassionate — promote to reference product]. Valid values are `annual|parental|medical|sabbatical|unpaid|bereavement`',
    `matter_impact_assessed` BOOLEAN COMMENT 'Indicates whether a formal matter staffing impact assessment has been completed for this leave event (True). Ensures compliance with ABA Rule 1.3 (Diligence) and SRA Code of Conduct obligations for client service continuity.',
    `medical_certification_received` BOOLEAN COMMENT 'Indicates whether the required medical certification documentation has been received and validated by HR (True). Null or False when medical_certification_required is False.',
    `medical_certification_required` BOOLEAN COMMENT 'Indicates whether medical certification documentation is required for this leave type and jurisdiction (True). Drives document collection workflow in SAP SuccessFactors and compliance with FMLA/ADA certification requirements.',
    `payroll_adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary value of the payroll deduction or adjustment resulting from this leave event, expressed in the firms base currency. Populated only when payroll_adjustment_flag is True. Sensitive compensation data.',
    `payroll_adjustment_flag` BOOLEAN COMMENT 'Indicates whether a payroll adjustment is required for this leave event (True) due to unpaid leave, partial pay, or leave without pay arrangements. Triggers downstream payroll processing in SAP SuccessFactors Payroll.',
    `phased_return_end_date` DATE COMMENT 'The date on which the phased return arrangement concludes and the timekeeper resumes full FTE capacity. Null when is_phased_return is False.',
    `phased_return_fte_percentage` DECIMAL(18,2) COMMENT 'The reduced Full-Time Equivalent (FTE) percentage applicable during a phased return period, expressed as a decimal percentage (e.g., 50.00 for 50%). Null when is_phased_return is False.',
    `regulatory_leave_category` STRING COMMENT 'The statutory or regulatory framework under which this leave is classified (e.g., FMLA, ADA, UK statutory maternity/paternity, EU Working Time Directive, or firm policy only). Drives compliance reporting obligations. [ENUM-REF-CANDIDATE: fmla|ada|state_statutory|firm_policy|uk_statutory|eu_directive|none — 7 candidates stripped; promote to reference product]',
    `rejection_reason` STRING COMMENT 'Free-text or coded reason provided by the approving manager when a leave request is rejected. Populated only when leave_status is rejected. Supports employee relations and grievance management.',
    `request_date` DATE COMMENT 'Calendar date on which the timekeeper formally submitted the leave request in SAP SuccessFactors. Used to measure advance notice compliance and SLA adherence for HR approval workflows.',
    `source_system_code` STRING COMMENT 'The native record identifier assigned by SAP SuccessFactors Time and Attendance to this leave request. Enables traceability and reconciliation between the Databricks Silver Layer and the system of record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp at which this leave record was most recently modified in the Databricks Silver Layer. Supports change tracking, audit trail, and incremental data pipeline processing.',
    `working_days_absent` STRING COMMENT 'Number of business working days (excluding weekends and public holidays) within the approved leave period. Used for billable hours target adjustment and FTE capacity planning.',
    CONSTRAINT pk_leave_record PRIMARY KEY(`leave_record_id`)
) COMMENT 'Tracks all approved and pending leave events for timekeepers including parental leave, sabbatical, medical leave, vacation, and unpaid leave. Stores leave type, request date, approved start date, approved end date, actual return date, leave reason code, coverage arrangement, impact on billable hours target, payroll adjustment flag, and approving manager. Sourced from SAP SuccessFactors Time and Attendance. Critical for resource planning and matter staffing continuity.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`workforce`.`succession_plan` (
    `succession_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the succession plan record. Primary key for the succession_plan data product in the workforce domain.',
    `practice_group_id` BIGINT COMMENT 'Foreign key linking to workforce.practice_group. Business justification: Succession planning is organized by practice group to ensure continuity of practice group leadership and key roles. The succession_plan table currently has practice_group (STRING) but no FK to the pra',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the first-ranked designated successor candidate for the key role. References the timekeeper record of the attorney or professional identified as the primary succession candidate.',
    `subject_timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Succession plans identify the incumbent in a key role. Must reference the timekeeper at risk of departure.',
    `tertiary_succession_timekeeper_id` BIGINT COMMENT 'Identifier of the equity partner or senior leader who sponsors and is accountable for this succession plan. Responsible for overseeing development actions and plan reviews.',
    `to_timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Each succession plan identifies an incumbent timekeeper in a key role. Required for continuity planning and client relationship transition.',
    `bar_admission_gap` BOOLEAN COMMENT 'Indicates whether the primary successor candidate lacks a required bar admission or jurisdiction-specific licence needed to fully assume the key role. Triggers targeted bar admission development actions.',
    `cle_gap_identified` BOOLEAN COMMENT 'Indicates whether a Continuing Legal Education (CLE) or Continuing Professional Development (CPD) gap has been identified for the primary successor candidate that must be addressed before they are ready to assume the key role.',
    `client_transition_risk` STRING COMMENT 'Assessment of the risk to client relationships if the incumbent vacates the role without a prepared successor. Reflects the degree to which key client relationships are concentrated in the incumbent and the potential revenue impact on the firm.. Valid values are `critical|high|medium|low|not_assessed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this succession plan record was first created in the system. Audit trail field sourced from SAP SuccessFactors. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the key_client_revenue_at_risk amount (e.g., USD, GBP, EUR). Supports multi-currency firm operations.. Valid values are `^[A-Z]{3}$`',
    `development_actions_required` STRING COMMENT 'Narrative description of the key development actions, training programs, mentoring assignments, or experience gaps that must be addressed to prepare successor candidates for the role. May reference CPD/CLE requirements or LPM training.',
    `estimated_vacancy_date` DATE COMMENT 'Projected date on which the incumbent is expected to vacate the role (e.g., planned retirement date, anticipated departure date). Used to set urgency and readiness timelines for successor development.',
    `external_candidate_considered` BOOLEAN COMMENT 'Indicates whether external lateral hire candidates are being considered as part of the succession strategy for this role, in addition to or instead of internal successor development.',
    `firm_office_location` STRING COMMENT 'The firm office or geographic location associated with the key role being succession-planned. Used for regional continuity planning and client relationship transition analysis.',
    `incumbent_performance_rating` STRING COMMENT 'Most recent formal performance rating of the incumbent in the key role. Confidential HR data used to assess whether the role vacancy is performance-driven and to calibrate urgency of succession planning.. Valid values are `exceptional|exceeds_expectations|meets_expectations|below_expectations|unsatisfactory`',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether this succession plan is designated as strictly confidential and restricted to a limited set of firm leadership. When true, access is limited to the sponsoring partner, managing partner, and HR leadership only.',
    `is_emergency_plan` BOOLEAN COMMENT 'Indicates whether this plan has been designated as an emergency succession plan, activated in response to an unplanned or sudden vacancy (e.g., unexpected departure, incapacitation). Triggers expedited review and activation workflows.',
    `key_client_revenue_at_risk` DECIMAL(18,2) COMMENT 'Estimated annual revenue (in the firms base currency) associated with key client relationships held by the incumbent that could be at risk upon role vacancy. Confidential financial planning data used to prioritize succession investment.',
    `knowledge_transfer_status` STRING COMMENT 'Current status of knowledge transfer activities from the incumbent to designated successor candidates. Tracks progress of client introductions, matter handovers, and institutional knowledge documentation.. Valid values are `not_started|in_progress|substantially_complete|complete`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this succession plan record was most recently updated in the system. Audit trail field used to detect stale plans and track plan maintenance activity. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_review_date` DATE COMMENT 'Date on which this succession plan was most recently formally reviewed and updated by the sponsoring partner or HR leadership. Used to identify stale plans requiring refresh.',
    `lateral_hire_target_seniority` STRING COMMENT 'If an external lateral hire is being considered as part of the succession strategy, the target seniority level for the lateral candidate. Applicable only when external_candidate_considered is true.. Valid values are `partner|senior_associate|of_counsel|not_applicable`',
    `lpm_training_required` BOOLEAN COMMENT 'Indicates whether Legal Project Management (LPM) training has been identified as a required development action for the designated successor(s) to be ready for the key role.',
    `mentoring_assignment` STRING COMMENT 'Description of formal mentoring or coaching arrangements established between the incumbent and successor candidates, or between the sponsoring partner and successors, as part of the development plan.',
    `nine_box_rating` STRING COMMENT 'Nine-box talent grid position assigned to the primary successor candidate, combining performance and potential dimensions (e.g., 1A, 2B, 3C). Confidential HR assessment used to calibrate succession readiness and development investment. [ENUM-REF-CANDIDATE: 1A|1B|1C|2A|2B|2C|3A|3B|3C — promote to reference product]',
    `plan_effective_date` DATE COMMENT 'Date from which this succession plan became active and operative. Marks the start of the formal succession planning period for the role.',
    `plan_expiry_date` DATE COMMENT 'Date on which this succession plan is scheduled to expire or be superseded. Nullable for open-ended plans. Triggers mandatory review or closure workflow upon reaching this date.',
    `plan_reference_code` STRING COMMENT 'Externally-known alphanumeric reference code assigned to the succession plan, used for cross-system identification and reporting. Sourced from SAP SuccessFactors.',
    `plan_review_date` DATE COMMENT 'Scheduled date for the next formal review of this succession plan by the sponsoring partner and HR leadership. Ensures plans remain current and development actions are progressing.',
    `plan_status` STRING COMMENT 'Current lifecycle state of the succession plan record. Drives workflow routing and reporting visibility. Valid values: draft, active, under_review, on_hold, closed, archived.. Valid values are `draft|active|under_review|on_hold|closed|archived`',
    `primary_successor_readiness` STRING COMMENT 'Individual readiness assessment for the primary successor candidate, indicating how soon they could assume the key role. May differ from the overall plan readiness timeline if multiple candidates are assessed.. Valid values are `ready_now|ready_1_year|ready_2_3_years|ready_4_5_years`',
    `readiness_timeline` STRING COMMENT 'Assessed timeframe within which a designated successor will be ready to assume the key role. Drives development action prioritization and urgency of succession planning activities.. Valid values are `ready_now|ready_1_year|ready_2_3_years|ready_4_5_years|not_yet_identified`',
    `retirement_eligibility_date` DATE COMMENT 'Date on which the incumbent becomes eligible for retirement under the firms partnership agreement or retirement policy. Confidential HR data used to calibrate the succession planning horizon.',
    `risk_category` STRING COMMENT 'Classification of the primary risk driver that makes this role a succession priority. Indicates whether the incumbent is a flight risk (likely to leave for another firm), approaching retirement, or at risk for other reasons. Informs urgency and development timeline.. Valid values are `flight_risk|retirement_horizon|health_risk|voluntary_departure|unknown`',
    `risk_level` STRING COMMENT 'Assessed severity of succession risk for the role. Critical indicates immediate risk with no ready successor; high indicates near-term risk; medium and low indicate longer planning horizons. Drives prioritization of development investment.. Valid values are `critical|high|medium|low`',
    `role_title` STRING COMMENT 'Title of the critical role or position being succession-planned (e.g., Managing Partner, Practice Group Leader, Head of Litigation, Chief Legal Officer). Represents the position, not the individual.',
    `role_type` STRING COMMENT 'Classification of the role being succession-planned within the firms partnership and leadership hierarchy. Determines applicable compensation structures (PPP, PEP, RPE) and governance obligations. [ENUM-REF-CANDIDATE: equity_partner|non_equity_partner|practice_group_leader|managing_partner|of_counsel|senior_associate|department_head|chief_legal_officer — promote to reference product]. Valid values are `equity_partner|non_equity_partner|practice_group_leader|managing_partner|of_counsel|senior_associate`',
    `secondary_successor_readiness` STRING COMMENT 'Individual readiness assessment for the secondary successor candidate, indicating how soon they could assume the key role if the primary successor is unavailable.. Valid values are `ready_now|ready_1_year|ready_2_3_years|ready_4_5_years`',
    `source_system_record_code` STRING COMMENT 'The native record identifier assigned by SAP SuccessFactors Succession and Development module to this succession plan. Used for lineage tracing and reconciliation between the Silver Layer and the system of record.',
    `succession_notes` STRING COMMENT 'Free-text confidential notes recorded by the sponsoring partner or HR leadership regarding the succession plan, including context on risk factors, candidate assessments, client sensitivities, or special circumstances not captured in structured fields.',
    `successor_count` STRING COMMENT 'Total number of identified successor candidates associated with this succession plan. A count of zero indicates a critical gap with no identified pipeline for the role.',
    `talent_pool_segment` STRING COMMENT 'SAP SuccessFactors talent pool classification assigned to the primary successor candidate. Segments the successor pipeline by potential and performance to prioritize development investment.. Valid values are `high_potential|high_performer|key_expert|emerging_leader|not_classified`',
    `years_in_role` STRING COMMENT 'Number of years the incumbent has held the key role being succession-planned. Used to assess institutional knowledge concentration and urgency of knowledge transfer activities.',
    CONSTRAINT pk_succession_plan PRIMARY KEY(`succession_plan_id`)
) COMMENT 'Succession planning records identifying key roles at risk and designated successors for critical partner and leadership positions. Stores the incumbent timekeeper, role title, risk level (flight risk, retirement horizon), readiness timeline, designated successor candidates, development actions required, plan review date, and sponsoring partner. Sourced from SAP SuccessFactors Succession and Development module. Supports firm continuity and client relationship transition planning.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`workforce`.`secondment` (
    `secondment_id` BIGINT COMMENT 'Unique surrogate identifier for the secondment arrangement record in the workforce data product. Primary key for the secondment entity.',
    `timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Secondment records track which timekeeper is placed externally. Essential for resource planning and cost allocation.',
    `matter_id` BIGINT COMMENT 'Reference to the client matter under which the secondment costs and time are recorded for billing and WIP tracking purposes. Applicable when the secondment is linked to a specific client engagement.',
    `organisation_id` BIGINT COMMENT 'Foreign key to client.organisation.organisation_id',
    `primary_secondment_supervising_partner_timekeeper_id` BIGINT COMMENT 'Reference to the equity or non-equity partner responsible for overseeing the secondment arrangement, managing performance expectations, and maintaining the client relationship during the placement.',
    `seconded_timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Secondments place a specific timekeeper with a client or office. Required for tracking who is seconded where.',
    `tertiary_secondment_approved_by_employee_timekeeper_id` BIGINT COMMENT 'Reference to the firm employee (typically a practice group leader, managing partner, or HR director) who formally approved the secondment arrangement in SAP SuccessFactors.',
    `to_timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Each secondment places a specific timekeeper with a client or office. Required for resource allocation and billing rate management during secondment.',
    `actual_end_date` DATE COMMENT 'The actual date the secondment concluded, which may differ from the scheduled end date due to early termination or extension. Populated upon completion or early termination of the arrangement.',
    `agreement_date` DATE COMMENT 'The date on which the formal secondment agreement between the firm and the host organisation was executed and signed by all parties. Marks the binding commencement of the contractual arrangement.',
    `approval_date` DATE COMMENT 'The date on which the secondment arrangement received formal internal approval from the authorised approver. Marks the transition from proposed to approved status.',
    `billing_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the billing rate and cost amounts for this secondment arrangement (e.g., USD, GBP, EUR). Supports multi-currency financial reporting.. Valid values are `^[A-Z]{3}$`',
    `billing_rate_during_secondment` DECIMAL(18,2) COMMENT 'The hourly billing rate applied to the secondees time charged to the host organisation or matter during the secondment period. May differ from the timekeepers standard rate in the firms rate schedule. Expressed in the currency defined by billing_currency_code.',
    `conflict_check_status` STRING COMMENT 'Status of the ethical conflict check performed prior to or during the secondment to identify any conflicts of interest between the secondees firm matters and the host organisations business. Managed via Intapp Conflicts.. Valid values are `not_started|in_progress|cleared|conflict_identified|waived`',
    `cost_allocation_type` STRING COMMENT 'Defines how the financial cost of the secondment is allocated between the firm and the host organisation. Client-funded: host client bears full cost; Firm-funded: firm absorbs all costs; Split: costs shared under an agreed ratio; Third-party funded: an external body (e.g., government grant) funds the placement.. Valid values are `client_funded|firm_funded|split|third_party_funded`',
    `cost_split_percentage` DECIMAL(18,2) COMMENT 'Where cost_allocation_type is split, the percentage of total secondment cost borne by the host organisation. The firm bears the remainder (100 minus this value). Expressed as a percentage between 0.00 and 100.00.',
    `cpd_hours_credited` DECIMAL(18,2) COMMENT 'Number of Continuing Professional Development (CPD) or Continuing Legal Education (CLE) hours formally credited to the secondee for the secondment placement, as recognised by the relevant bar association or regulatory body.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp at which the secondment record was first created in the system, in ISO 8601 format with timezone offset. Supports audit trail and data lineage requirements.',
    `data_protection_agreement_signed` BOOLEAN COMMENT 'Indicates whether a data protection agreement or data processing addendum has been executed between the firm and the host organisation governing the handling of personal data accessed by the secondee during the placement.',
    `early_termination_reason` STRING COMMENT 'Reason code for the early termination of the secondment before the scheduled end date. Populated only when secondment_status is terminated_early. [ENUM-REF-CANDIDATE: recall_by_firm|resignation|host_request|performance|health|redundancy|matter_concluded|other — promote to reference product]',
    `end_date` DATE COMMENT 'The scheduled or actual date on which the secondment placement concludes and the timekeeper is expected to return to their substantive role at the firm. Nullable for open-ended arrangements.',
    `ethical_wall_required` BOOLEAN COMMENT 'Indicates whether an information barrier (ethical wall) must be erected to screen the secondee from accessing confidential firm or client information that could create a conflict of interest during the placement.',
    `host_bar_admission_required` BOOLEAN COMMENT 'Indicates whether the secondee must hold or obtain a bar admission, practising certificate, or equivalent authorisation in the host jurisdiction to perform legal work during the secondment.',
    `host_bar_admission_status` STRING COMMENT 'Current status of the secondees bar admission or practising certificate in the host jurisdiction. Not Required: no local admission needed; Pending: application in progress; Obtained: admission secured; Waived: exemption granted; Expired: admission lapsed.. Valid values are `not_required|pending|obtained|waived|expired`',
    `host_city` STRING COMMENT 'City where the host organisations primary office or placement location is situated. Used for resource planning, travel and expense management, and cross-border staffing analytics.',
    `host_contact_email` STRING COMMENT 'Email address of the primary contact at the host organisation. Used for secondment coordination, performance review communications, and return-to-role planning.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `host_contact_name` STRING COMMENT 'Full name of the primary contact person at the host organisation responsible for managing the secondees day-to-day activities, performance feedback, and administrative matters during the placement.',
    `host_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction where the host organisation is located. Drives international rotation classification, cross-border tax treatment, work permit requirements, and applicable bar admission rules.. Valid values are `^[A-Z]{3}$`',
    `host_organisation_name` STRING COMMENT 'The legal or trading name of the organisation hosting the secondee, which may be a client entity, another law firm office, a government body, or a non-profit. Sensitive as it reveals client relationship details.',
    `host_organisation_type` STRING COMMENT 'Classification of the host organisation category, used to determine applicable billing arrangements, conflict-check requirements, and regulatory obligations during the secondment.. Valid values are `client|firm_office|government_body|court_tribunal|non_profit|international_organisation`',
    `is_billable` BOOLEAN COMMENT 'Indicates whether the secondment arrangement generates billable charges to the host organisation or client. True for client-funded or split arrangements; False for firm-funded or pro bono placements.',
    `lpp_risk_assessment` STRING COMMENT 'Assessment of the risk that Legal Professional Privilege (LPP) over communications and work product may be compromised during the secondment, particularly relevant for in-house placements where LPP protections may differ from private practice.. Valid values are `low|medium|high|not_assessed`',
    `notice_period_days` STRING COMMENT 'The number of calendar days notice required by either party to terminate or recall the secondee from the placement before the scheduled end date, as stipulated in the secondment agreement.',
    `objectives` STRING COMMENT 'Narrative description of the agreed business and professional development objectives for the secondment, including skills to be developed, client relationship goals, and knowledge transfer targets. Used in performance management and CPD planning.',
    `performance_review_completed` BOOLEAN COMMENT 'Indicates whether the formal performance review for the secondment has been completed and submitted in SAP SuccessFactors. Used to track compliance with the firms performance management obligations.',
    `performance_review_due_date` DATE COMMENT 'The scheduled date by which a formal mid-secondment or end-of-secondment performance review must be completed by the supervising partner and host contact, feeding into the timekeepers annual performance management cycle.',
    `reference` STRING COMMENT 'Externally-known unique business reference code assigned to the secondment arrangement, used in correspondence with the host organisation, HR documentation, and billing systems. Format: SEC-YYYY-NNNNN.. Valid values are `^SEC-[0-9]{4}-[0-9]{5}$`',
    `return_to_role_plan` STRING COMMENT 'Documented plan outlining the timekeepers reintegration into their substantive role upon completion of the secondment, including practice group reassignment, matter allocation, and any transitional support arrangements.',
    `secondment_status` STRING COMMENT 'Current lifecycle state of the secondment arrangement. Proposed: under internal review; Approved: authorised but not yet started; Active: timekeeper currently on placement; Extended: original end date extended; Completed: placement concluded as planned; Cancelled: arrangement cancelled before start; Terminated Early: placement ended before scheduled end date. [ENUM-REF-CANDIDATE: proposed|approved|active|extended|completed|cancelled|terminated_early — promote to reference product]',
    `secondment_type` STRING COMMENT 'Classification of the secondment arrangement indicating the nature of the placement. Client secondment places the timekeeper at a client organisation; inter-office moves the timekeeper between firm offices; international rotation supports cross-border staffing; pro bono places the timekeeper with a non-profit or legal aid organisation; government secondment places the timekeeper with a regulatory or government body; judicial clerkship places the timekeeper with a court or tribunal. [ENUM-REF-CANDIDATE: client_secondment|inter_office|international_rotation|pro_bono|government_secondment|judicial_clerkship — promote to reference product]. Valid values are `client_secondment|inter_office|international_rotation|pro_bono|government_secondment|judicial_clerkship`',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this secondment record originated. Supports data lineage tracking in the Databricks Silver Layer lakehouse architecture.. Valid values are `SAP_SF|ELITE_3E|MANUAL|ADERANT`',
    `start_date` DATE COMMENT 'The date on which the timekeeper formally commences the secondment placement at the host organisation. Used for resource planning, billing commencement, and compliance tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp at which the secondment record was most recently modified, in ISO 8601 format with timezone offset. Used for change tracking, data synchronisation, and audit compliance.',
    `work_permit_expiry_date` DATE COMMENT 'The date on which the work permit, visa, or immigration authorisation for the secondment expires. Used to trigger renewal workflows and ensure continuous legal right to work compliance.',
    `work_permit_reference` STRING COMMENT 'Government-issued reference number for the work permit, visa, or immigration authorisation obtained for the secondee to work in the host jurisdiction. Classified as restricted PII as it is a government-issued personal identifier.',
    `work_permit_required` BOOLEAN COMMENT 'Indicates whether the secondee requires a work permit, visa, or immigration authorisation to perform the secondment in the host country. Relevant for international rotation and cross-border placements.',
    CONSTRAINT pk_secondment PRIMARY KEY(`secondment_id`)
) COMMENT 'Records attorney and staff secondment arrangements where a timekeeper is temporarily placed with a client organization, another firm office, or an international rotation. Stores secondment type (client secondment, inter-office, international rotation), host organization, host contact, secondment start and end dates, cost allocation arrangement (client-funded, firm-funded, split), billing rate during secondment, supervising partner, secondment objectives, and return-to-role plan. Supports client relationship management, cross-border staffing, and resource planning continuity.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` (
    `disciplinary_record_id` BIGINT COMMENT 'Unique surrogate identifier for each disciplinary record within the firm. Primary key for the disciplinary_record data product in the workforce domain.',
    `timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Disciplinary records are about a specific timekeeper. Critical for HR management and regulatory reporting.',
    `matter_id` BIGINT COMMENT 'Reference to the client matter associated with the incident, where the disciplinary event arose in the context of specific client work (e.g., billing fraud on a matter, conflict of interest on a transaction). Null if incident is not matter-specific.',
    `practice_group_id` BIGINT COMMENT 'Foreign key to workforce.practice_group.practice_group_id',
    `primary_disciplinary_timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper (attorney, paralegal, or staff member) who is the subject of this disciplinary record. Links to the workforce.timekeeper product.',
    `tertiary_disciplinary_hr_case_owner_timekeeper_id` BIGINT COMMENT 'Reference to the HR business partner or case manager who owns and administers this disciplinary record within the HR function. Distinct from the investigating officer. Links to the workforce.timekeeper product.',
    `to_timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Each disciplinary record pertains to a specific timekeeper. Required for HR case management and regulatory notification obligations.',
    `appeal_outcome` STRING COMMENT 'Result of the formal appeal process if an appeal was filed. Upheld indicates original outcome overturned; partially_upheld indicates outcome modified; dismissed indicates original outcome confirmed; pending indicates appeal in progress. Null if no appeal was filed.. Valid values are `upheld|partially_upheld|dismissed|pending`',
    `appeal_resolution_date` DATE COMMENT 'The date on which the appeal was formally resolved and the final outcome confirmed. Null if no appeal was filed or appeal is still pending.',
    `bar_referral_body` STRING COMMENT 'Name of the bar association, regulatory authority, or professional body to which the matter was referred (e.g., State Bar of California, SRA, Law Society of England and Wales). Supports multi-jurisdiction tracking.',
    `bar_referral_date` DATE COMMENT 'The date on which the matter was formally referred to the bar association or regulatory body. Null if is_bar_referral is false or referral has not yet been made.',
    `confidentiality_level` STRING COMMENT 'Data access classification for this disciplinary record, controlling which firm personnel may view the record. Restricted limits access to HR leadership and managing partners; confidential limits to HR and direct line management; internal is accessible to broader HR team.. Valid values are `restricted|confidential|internal`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp at which this disciplinary record was first created in the system of record (SAP SuccessFactors). Provides the audit trail creation point for compliance and data lineage purposes.',
    `incident_category` STRING COMMENT 'Granular sub-classification of the incident within its type, such as billing irregularity, client confidentiality breach, conflict of interest, sexual harassment, substance abuse, or absenteeism. Supports detailed analytics and regulatory reporting. [ENUM-REF-CANDIDATE: billing_irregularity|confidentiality_breach|conflict_of_interest|harassment|substance_abuse|absenteeism|misrepresentation|data_breach — promote to reference product]',
    `incident_date` DATE COMMENT 'The date on which the alleged conduct, performance failure, ethics breach, or regulatory violation occurred or was first identified. This is the principal real-world event date for the disciplinary matter.',
    `incident_description` STRING COMMENT 'Detailed narrative description of the alleged incident, including facts, circumstances, and any relevant context. This field is subject to Legal Professional Privilege (LPP) and is restricted to HR and firm management access.',
    `incident_type` STRING COMMENT 'High-level classification of the disciplinary incident. Conduct covers behavioural matters; performance covers work quality/output failures; ethics covers breaches of professional duty; regulatory covers violations of bar or regulatory rules; financial covers billing fraud or misappropriation; harassment covers workplace harassment or discrimination. [ENUM-REF-CANDIDATE: conduct|performance|ethics|regulatory|financial|harassment — promote to reference product]. Valid values are `conduct|performance|ethics|regulatory|financial|harassment`',
    `investigation_close_date` DATE COMMENT 'The date on which the internal investigation was formally concluded and findings were documented. Null if investigation is still open.',
    `investigation_start_date` DATE COMMENT 'The date on which the formal internal investigation into the disciplinary matter was commenced. Used to track investigation duration and compliance with firm HR policy timelines.',
    `investigation_status` STRING COMMENT 'Current lifecycle state of the disciplinary investigation. Pending indicates not yet commenced; open indicates active investigation; under_review indicates findings being assessed; concluded indicates investigation complete pending outcome; closed indicates fully resolved; appealed indicates outcome under appeal.. Valid values are `pending|open|under_review|concluded|closed|appealed`',
    `is_appeal_filed` BOOLEAN COMMENT 'Indicates whether the subject timekeeper has filed a formal appeal against the disciplinary outcome. True triggers appeal tracking workflow and suspends record finalisation.',
    `is_bar_referral` BOOLEAN COMMENT 'Indicates whether this disciplinary matter has been or is required to be referred to the relevant state bar association, Law Society, or SRA for professional conduct review. True triggers mandatory regulatory notification workflow.',
    `is_lpp_protected` BOOLEAN COMMENT 'Indicates whether the investigation documents and record contents are subject to Legal Professional Privilege (LPP), restricting disclosure in litigation or regulatory proceedings. Governs eDiscovery and document production obligations.',
    `is_paid_suspension` BOOLEAN COMMENT 'Indicates whether a suspension was on full pay (true) or unpaid (false). Relevant for payroll processing and employment law compliance during the suspension period. Null if outcome is not suspension.',
    `is_pii_involved` BOOLEAN COMMENT 'Indicates whether the incident involved a breach or mishandling of Personally Identifiable Information (PII) or client data, triggering GDPR, CCPA, or DPA notification obligations.',
    `is_regulatory_notification` BOOLEAN COMMENT 'Indicates whether a regulatory notification obligation has been triggered by this disciplinary matter (e.g., GDPR data breach notification to DPA, AML/KYC notification to FATF-aligned authority, or SRA mandatory reporting). Distinct from bar referral.',
    `jurisdiction` STRING COMMENT 'The legal jurisdiction governing the employment relationship and disciplinary process for this record (e.g., England and Wales, New York, California). Determines applicable employment law, bar reporting obligations, and data retention requirements.',
    `outcome` STRING COMMENT 'The formal outcome or sanction determined following the investigation. No_action indicates allegations unsubstantiated; verbal_warning/written_warning/final_warning are progressive disciplinary steps; suspension indicates temporary removal from duties; termination indicates employment ended; referral indicates matter referred to bar or regulatory body. [ENUM-REF-CANDIDATE: no_action|verbal_warning|written_warning|final_warning|suspension|termination|referral|demotion — promote to reference product]',
    `outcome_date` DATE COMMENT 'The date on which the disciplinary outcome was formally communicated to the subject timekeeper. Marks the resolution of the disciplinary process for reporting and retention purposes.',
    `record_reference_number` STRING COMMENT 'Externally-known unique business identifier for this disciplinary record, used in HR correspondence, investigation files, and regulatory notifications. Format: DR-YYYY-NNNNN.. Valid values are `^DR-[0-9]{4}-[0-9]{5}$`',
    `record_retention_expiry` DATE COMMENT 'The date after which this disciplinary record may be purged or anonymised in accordance with the firms data retention policy and applicable employment law. Derived from outcome date plus jurisdiction-specific retention period but stored as a business date for operational use.',
    `regulatory_body_notified` STRING COMMENT 'Name of the regulatory authority notified (e.g., Information Commissioners Office, Financial Action Task Force, SRA, relevant DPA). Supports audit trail for multi-regulatory compliance obligations.',
    `regulatory_notification_date` DATE COMMENT 'The date on which the required regulatory notification was submitted to the relevant authority. Null if is_regulatory_notification is false or notification has not yet been made.',
    `related_record_reference` BIGINT COMMENT 'Reference to a prior or related disciplinary record for the same timekeeper, enabling tracking of repeat conduct patterns and progressive discipline history. Null if this is a standalone first incident.',
    `remediation_completion_date` DATE COMMENT 'The date on which all required remediation actions were confirmed as completed. Null if remediation is not required or not yet completed.',
    `remediation_description` STRING COMMENT 'Description of the specific remediation actions required as part of the disciplinary outcome, such as mandatory ethics CLE hours, supervised practice period, or performance improvement plan milestones.',
    `remediation_due_date` DATE COMMENT 'The deadline by which all required remediation actions must be completed. Used to track compliance with disciplinary outcome conditions and trigger escalation if overdue.',
    `remediation_required` BOOLEAN COMMENT 'Indicates whether the disciplinary outcome includes a mandatory remediation action such as additional Continuing Professional Development (CPD/CLE), ethics training, supervision, or a performance improvement plan.',
    `reported_date` DATE COMMENT 'The date on which the incident was formally reported to HR or firm management, which may differ from the incident date. Used to track reporting timeliness obligations under SRA and ABA rules.',
    `resolution_date` DATE COMMENT 'The date on which all aspects of the disciplinary matter were fully resolved, including any appeal period expiry, remediation completion, or regulatory notification confirmation. May differ from outcome_date if appeals or remediation actions follow.',
    `severity_level` STRING COMMENT 'Assessed severity of the disciplinary incident, used to prioritise investigation resources and determine escalation paths. Critical severity incidents trigger immediate bar referral assessment and senior management notification.. Valid values are `low|medium|high|critical`',
    `suspension_end_date` DATE COMMENT 'The date on which a suspension sanction ended and the timekeeper was reinstated to duties. Null if outcome is not suspension or suspension is ongoing.',
    `suspension_start_date` DATE COMMENT 'The date on which a suspension sanction commenced, if the outcome was suspension. Null if outcome is not suspension. Used to track suspension duration and manage matter reassignment.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp at which this disciplinary record was most recently modified in the system of record. Supports change tracking, audit trail, and Silver Layer incremental load processing.',
    `witness_count` STRING COMMENT 'Number of witnesses formally interviewed or identified during the disciplinary investigation. Supports investigation completeness assessment and audit trail.',
    CONSTRAINT pk_disciplinary_record PRIMARY KEY(`disciplinary_record_id`)
) COMMENT 'Confidential record of internal disciplinary actions and professional conduct matters involving firm timekeepers. Stores incident date, incident type (conduct, performance, ethics, regulatory), description, investigation status, outcome (warning, suspension, termination, no action), bar referral flag, regulatory notification flag, and resolution date. Distinct from bar admission disciplinary standing which is externally held. Access is restricted to HR and firm management. Supports SRA and ABA professional conduct obligations.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`workforce`.`diversity_record` (
    `diversity_record_id` BIGINT COMMENT 'Unique identifier for the diversity record. Primary key.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper (attorney, paralegal, or staff member) to whom this diversity record belongs.',
    `prior_diversity_record_id` BIGINT COMMENT 'Self-referencing FK on diversity_record (prior_diversity_record_id)',
    `subject_timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Diversity data is collected per timekeeper. Essential for SRA reporting, Mansfield Rule certification, and client diversity surveys.',
    `to_timekeeper_id` BIGINT COMMENT 'FK to workforce.timekeeper.timekeeper_id — Each diversity record captures DEI data for a specific timekeeper. Required for SRA diversity reporting, Mansfield Rule certification, and client diversity surveys.',
    `access_restricted_to_role` STRING COMMENT 'Role-based access control designation specifying which roles (e.g., HR Director, DEI Officer, Chief People Officer) are authorized to view this diversity record.',
    `anonymization_flag` BOOLEAN COMMENT 'Indicates whether this diversity record should be anonymized for aggregate reporting purposes to protect timekeeper identity in small cohorts.',
    `caregiver_status` STRING COMMENT 'Self-reported caregiver status indicating whether the timekeeper has primary or significant caregiving responsibilities (e.g., for children, elderly parents, or disabled family members).. Valid values are `yes|no|prefer_not_to_say`',
    `client_diversity_survey_date` DATE COMMENT 'Date on which the timekeepers diversity data was submitted to a client diversity survey or reporting platform.',
    `client_diversity_survey_response` STRING COMMENT 'Status of the timekeepers response to client-driven diversity surveys (e.g., ABA Model Diversity Survey, client-specific RFP diversity questionnaires).. Valid values are `submitted|not_submitted|declined|pending`',
    `confidentiality_level` STRING COMMENT 'Data classification level for this diversity record, indicating access restrictions and handling requirements.. Valid values are `restricted|confidential|internal`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this diversity record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Calculated data quality score (0-100) indicating the completeness and accuracy of the diversity record, used to assess the reliability of DEI reporting.',
    `data_source` STRING COMMENT 'Source from which the diversity data was collected (e.g., voluntary self-identification workflow, HR system import, recruitment intake, third-party diversity survey).. Valid values are `self_identification|hr_import|recruitment|third_party_survey`',
    `disability_description` STRING COMMENT 'Optional free-text description of the nature of the disability, provided voluntarily by the timekeeper for accommodation and support purposes. Highly sensitive Protected Health Information (PHI).',
    `disability_status` STRING COMMENT 'Self-reported disability status indicating whether the timekeeper has a disability as defined by applicable law (e.g., ADA, Equality Act 2010).. Valid values are `yes|no|prefer_not_to_say`',
    `disclosure_consent_date` DATE COMMENT 'Date on which the timekeeper provided consent for disclosure of their diversity data.',
    `disclosure_consent_flag` BOOLEAN COMMENT 'Indicates whether the timekeeper has consented to the disclosure of their diversity data to clients, regulatory bodies, or third-party diversity surveys.',
    `ethnicity` STRING COMMENT 'Self-reported ethnicity or racial background of the timekeeper as collected for DEI reporting and client diversity survey requirements. [ENUM-REF-CANDIDATE: white|black_african_caribbean|asian|hispanic_latino|native_american|pacific_islander|mixed_multiple|prefer_not_to_say|other — promote to reference product]',
    `first_generation_professional` BOOLEAN COMMENT 'Indicates whether the timekeeper is the first in their family to enter a professional occupation, used for social mobility and DEI tracking.',
    `gender_identity` STRING COMMENT 'Self-reported gender identity of the timekeeper as collected for diversity, equity, and inclusion (DEI) reporting. [ENUM-REF-CANDIDATE: male|female|non_binary|transgender|prefer_not_to_say|prefer_to_self_describe|other — promote to reference product]',
    `last_updated_date` DATE COMMENT 'Date on which the diversity record was last updated by the timekeeper or HR administrator.',
    `mansfield_rule_category` STRING COMMENT 'The specific Mansfield Rule diversity category under which the timekeeper qualifies (e.g., women, racial/ethnic minority, LGBTQ+, lawyer with disability).',
    `mansfield_rule_eligible` BOOLEAN COMMENT 'Indicates whether the timekeeper is eligible to be counted in the Mansfield Rule candidate pool for leadership and governance roles based on their diversity characteristics.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review or refresh of the timekeepers diversity data, typically aligned with annual reporting cycles.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the diversity record, used by HR or DEI leadership for context, clarifications, or special handling instructions.',
    `record_reference_number` STRING COMMENT 'External or human-readable reference number for this diversity record, used for tracking and reporting purposes.',
    `record_status` STRING COMMENT 'Current lifecycle status of the diversity record indicating whether it is active, inactive, pending review, or archived.. Valid values are `active|inactive|pending_review|archived`',
    `religion_or_belief` STRING COMMENT 'Self-reported religion or belief system of the timekeeper, collected for DEI reporting and to support religious accommodation requests. [ENUM-REF-CANDIDATE: christian|muslim|jewish|hindu|buddhist|sikh|no_religion|prefer_not_to_say|other — promote to reference product]',
    `reporting_period` STRING COMMENT 'The reporting period or cycle to which this diversity record applies, typically annual or aligned with regulatory reporting deadlines (e.g., 2023, FY2023, Q4-2023).',
    `reporting_period_end_date` DATE COMMENT 'End date of the reporting period for which this diversity data is collected and reported.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the reporting period for which this diversity data is collected and reported.',
    `retention_expiry_date` DATE COMMENT 'Date on which this diversity record is scheduled for deletion or anonymization in accordance with data retention policies and GDPR right to erasure.',
    `self_identification_date` DATE COMMENT 'Date on which the timekeeper voluntarily self-identified their diversity characteristics through the firms diversity data collection workflow.',
    `sexual_orientation` STRING COMMENT 'Self-reported sexual orientation of the timekeeper as collected for DEI reporting and Mansfield Rule certification. [ENUM-REF-CANDIDATE: heterosexual|gay|lesbian|bisexual|pansexual|asexual|prefer_not_to_say|prefer_to_self_describe|other — promote to reference product]',
    `socioeconomic_background` STRING COMMENT 'Self-reported socioeconomic background of the timekeeper, typically captured as parental occupation or educational background, used for social mobility tracking and DEI initiatives. [ENUM-REF-CANDIDATE: professional|intermediate|working_class|unemployed|prefer_not_to_say|other — promote to reference product]',
    `sra_diversity_reporting_flag` BOOLEAN COMMENT 'Indicates whether this diversity record is included in the firms annual SRA diversity data collection submission (applicable to UK-regulated firms).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this diversity record was last modified in the system.',
    `veteran_status` STRING COMMENT 'Self-reported veteran or military service status, collected for diversity reporting and affirmative action compliance in applicable jurisdictions.. Valid values are `yes|no|prefer_not_to_say`',
    CONSTRAINT pk_diversity_record PRIMARY KEY(`diversity_record_id`)
) COMMENT 'Tracks self-reported and firm-collected diversity, equity, and inclusion (DEI) data for each timekeeper as required by SRA diversity data collection, Mansfield Rule certification, client-driven diversity reporting (e.g., ABA Model Diversity Survey), and internal firm DEI initiatives. Stores demographic category (gender, ethnicity, disability status, sexual orientation, socioeconomic background, caregiver status), self-identification date, reporting period, disclosure consent flag, Mansfield Rule candidate pool eligibility, client diversity survey response data, and anonymization flag for aggregate reporting. Access restricted to HR and DEI leadership. Sourced from SAP SuccessFactors with voluntary self-identification workflows.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`workforce`.`rfp_team_assignment` (
    `rfp_team_assignment_id` BIGINT COMMENT 'Unique identifier for this RFP team assignment record. Primary key.',
    `rfp_submission_id` BIGINT COMMENT 'Foreign key linking to the RFP submission for which this team assignment was made',
    `timekeeper_id` BIGINT COMMENT 'Foreign key linking to the timekeeper assigned to this RFP pitch team',
    `assignment_date` DATE COMMENT 'The date on which this timekeeper was assigned to the RFP pitch team. Used to track team assembly timeline and response preparation duration.',
    `assignment_status` STRING COMMENT 'The current status of this team assignment. Tracks whether the timekeeper accepted the assignment, is actively working, completed their contribution, or withdrew due to conflicts or capacity constraints.',
    `bio_included_flag` BOOLEAN COMMENT 'Indicates whether this timekeepers professional biography was included in the RFP response materials. Used to track which team members were presented to the client.',
    `conflict_cleared_date` DATE COMMENT 'The date on which this timekeeper received conflict clearance for this RFP submission.',
    `conflict_cleared_flag` BOOLEAN COMMENT 'Indicates whether this specific timekeeper has been cleared through the conflict check process for this RFP. Required before timekeeper can be included in client-facing proposal materials.',
    `contribution_hours` DECIMAL(18,2) COMMENT 'The number of hours this timekeeper contributed to the RFP response preparation. Used for cost recovery analysis, capacity planning, and pitch team efficiency metrics.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this assignment record was created.',
    `pitch_team_members` STRING COMMENT 'Comma-separated list or description of the pitch team members assigned to work on the RFP response, including partners, associates, and business development staff. [Moved from rfp_submission: This attribute currently stores a comma-separated list or description of pitch team members in the rfp_submission product. This is a denormalized representation of the many-to-many relationship. The individual team member assignments should be modeled as separate records in the rfp_team_assignment association, each with its own role, hours, and rate attributes. The pitch_team_members attribute becomes redundant once the association product exists and should be removed to eliminate data duplication and maintain referential integrity.]',
    `presentation_section_responsibility` STRING COMMENT 'The specific section(s) of the RFP response or pitch presentation for which this timekeeper has primary authorship or delivery responsibility (e.g., Executive Summary, Technical Approach, Pricing Schedule, Team Qualifications).',
    `rate_quoted` DECIMAL(18,2) COMMENT 'The hourly billing rate quoted for this specific timekeeper in this specific RFP response. May differ from their standard rack rate due to client negotiations, competitive positioning, or blended rate strategies. Critical for pricing analysis and margin calculation.',
    `rate_quoted_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the quoted rate. Required for multi-jurisdiction RFPs and cross-border engagements.',
    `team_role` STRING COMMENT 'The specific role this timekeeper plays in the RFP response effort. Drives responsibility assignment, effort allocation, and performance attribution in win/loss analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this assignment record was last modified.',
    CONSTRAINT pk_rfp_team_assignment PRIMARY KEY(`rfp_team_assignment_id`)
) COMMENT 'This association product represents the assignment of individual timekeepers (attorneys, paralegals, and staff) to RFP pitch teams. It captures the specific role each timekeeper plays in the RFP response effort, their time contribution, section ownership, and the billing rate quoted for their participation. Each record links one timekeeper to one RFP submission with attributes that exist only in the context of this specific pitch team assignment, enabling cost recovery analysis, win/loss performance tracking, and pitch team composition optimization.. Existence Justification: In legal services, RFP responses require multi-attorney pitch teams where each timekeeper contributes specific expertise, hours, and section ownership. A single timekeeper participates in multiple concurrent RFP opportunities throughout the year, and each RFP submission requires multiple timekeepers with distinct roles (lead partner, subject matter expert, pricing analyst, etc.). The firm actively manages these assignments for cost recovery, capacity planning, and win/loss analysis by team composition.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`workforce`.`user` (
    `user_id` BIGINT COMMENT 'Primary key for user',
    `employee_id` BIGINT COMMENT 'Business identifier for the employee assigned by the human resources system. Unique across the organization.',
    `primary_manager_user_id` BIGINT COMMENT 'Reference to the users direct manager or supervisor within the organizational hierarchy.',
    `tertiary_created_by_user_id` BIGINT COMMENT 'Self-referencing FK on user (created_by_user_id)',
    `active_flag` BOOLEAN COMMENT 'Indicates whether the user account is currently active and has system access. True for active users, false for deactivated accounts.',
    `bar_admission_count` STRING COMMENT 'Total number of bar admissions held by the user across all jurisdictions. Zero for non-attorney staff.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the users time is billable to clients. True for timekeepers (attorneys, paralegals), false for administrative staff.',
    `cle_credits_completed_current_year` DECIMAL(18,2) COMMENT 'CLE or CPD credit hours completed by the user in the current calendar or reporting year. Used for compliance tracking.',
    `cle_credits_required_annual` DECIMAL(18,2) COMMENT 'Annual continuing legal education (CLE) or continuing professional development (CPD) credit hours required for the user to maintain professional standing. Zero for non-attorneys.',
    `cost_center` STRING COMMENT 'Financial cost center code for budgeting and expense allocation purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the user record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the users billing rate and compensation (e.g., USD, GBP, EUR).',
    `department` STRING COMMENT 'Organizational department or division to which the user is assigned.',
    `email_address` STRING COMMENT 'Primary business email address for the user. Used for official communication and system notifications.',
    `employment_status` STRING COMMENT 'Current employment lifecycle status of the user. Determines access rights and resource allocation.',
    `firm_office_location` STRING COMMENT 'Primary office or branch location where the user is based.',
    `first_name` STRING COMMENT 'Legal first name (given name) of the user.',
    `full_time_equivalent` DECIMAL(18,2) COMMENT 'Full-time equivalent percentage representing the users work commitment. 1.00 for full-time, 0.50 for half-time, etc. Used for capacity planning and resource allocation.',
    `hire_date` DATE COMMENT 'Date the user was hired or commenced employment with the organization.',
    `job_title` STRING COMMENT 'Official job title or position held by the user within the organization.',
    `language_preference` STRING COMMENT 'Two-letter ISO 639-1 language code representing the users preferred language for system interface and communication (e.g., en, fr, es, de).',
    `last_name` STRING COMMENT 'Legal last name (surname or family name) of the user.',
    `last_performance_review_date` DATE COMMENT 'Date of the users most recent formal performance review or appraisal.',
    `middle_name` STRING COMMENT 'Middle name or initial of the user. Nullable.',
    `mobile_number` STRING COMMENT 'Mobile phone number for the user. Used for urgent communication and mobile access.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the user record was last modified or updated.',
    `partner_tier` STRING COMMENT 'Partnership classification tier for attorneys who hold partner status. Includes equity partner, non-equity partner, junior partner, senior partner, and managing partner. Not applicable for non-partner users.',
    `performance_rating` STRING COMMENT 'Most recent performance management rating for the user. Confidential human resources data used for compensation and succession planning.',
    `phone_number` STRING COMMENT 'Primary business phone number for the user. Used for client and internal communication.',
    `practice_area` STRING COMMENT 'Primary legal practice area or specialty of the user (e.g., Corporate Law, Litigation, Intellectual Property, Employment Law, Regulatory Compliance).',
    `preferred_name` STRING COMMENT 'Name the user prefers to be called in professional settings. May differ from legal name.',
    `primary_bar_jurisdiction` STRING COMMENT 'Primary jurisdiction or state where the user holds bar admission. Nullable for non-attorneys.',
    `standard_hourly_rate` DECIMAL(18,2) COMMENT 'Standard billing rate per hour for the users services. Used for client billing and revenue forecasting. Confidential compensation data.',
    `termination_date` DATE COMMENT 'Date the users employment ended. Nullable for active employees.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the users primary work location (e.g., America/New_York, Europe/London). Used for scheduling and time tracking.',
    `user_type` STRING COMMENT 'Classification of the user role within the legal organization. Distinguishes between attorneys, paralegals, administrative staff, partners, of counsel, and contract workers.',
    `username` STRING COMMENT 'Unique login username for system access and authentication.',
    `utilization_target_percentage` DECIMAL(18,2) COMMENT 'Target billable utilization percentage for the user, representing the expected proportion of working hours that should be billed to clients. Used for performance management and capacity planning.',
    `work_address_city` STRING COMMENT 'City of the users primary work address.',
    `work_address_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the users primary work address (e.g., USA, GBR, CAN).',
    `work_address_line1` STRING COMMENT 'First line of the users primary work address (street address).',
    `work_address_postal_code` STRING COMMENT 'Postal code or ZIP code of the users primary work address.',
    `work_address_state_province` STRING COMMENT 'State or province of the users primary work address.',
    CONSTRAINT pk_user PRIMARY KEY(`user_id`)
) COMMENT 'Master reference table for user. Referenced by modified_by_user_id.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`workforce`.`lateral_candidate` (
    `lateral_candidate_id` BIGINT COMMENT 'Primary key for lateral_candidate',
    `timekeeper_id` BIGINT COMMENT 'Foreign key linking to workforce.timekeeper. Business justification: Lateral candidates are managed by a recruiting partner who is responsible for the candidate relationship. The lateral_candidate table currently has recruiting_partner_name (STRING) which should be nor',
    `recruitment_requisition_id` BIGINT COMMENT 'Foreign key linking to workforce.recruitment_requisition. Business justification: Lateral candidates are sourced for specific open requisitions. This FK links candidates to the requisition they are being considered for. The target office, practice group, and level are defined on th',
    `referred_by_lateral_candidate_id` BIGINT COMMENT 'Self-referencing FK on lateral_candidate (referred_by_lateral_candidate_id)',
    `background_check_status` STRING COMMENT 'Status of the background verification process for the lateral candidate.',
    `bar_admission_jurisdictions` STRING COMMENT 'Comma-separated list of jurisdictions where the candidate is admitted to practice law (e.g., New York, California, District of Columbia).',
    `candidate_number` STRING COMMENT 'Business-facing unique identifier for the lateral candidate, typically formatted as LC-XXXXXXXX.',
    `candidate_status` STRING COMMENT 'Current status of the lateral candidate in the recruitment lifecycle.',
    `candidate_type` STRING COMMENT 'Classification of the lateral candidate by role type being recruited for.',
    `conflict_check_status` STRING COMMENT 'Status of the conflicts of interest check for the lateral candidate.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lateral candidate record was first created in the system.',
    `current_compensation_usd` DECIMAL(18,2) COMMENT 'Current total annual compensation of the candidate in US dollars, including base salary and bonuses.',
    `current_firm_name` STRING COMMENT 'Name of the law firm or legal organization where the candidate is currently employed.',
    `current_title` STRING COMMENT 'Current job title or position held by the lateral candidate at their present firm.',
    `email_address` STRING COMMENT 'Primary email address for contacting the lateral candidate.',
    `expected_start_date` DATE COMMENT 'Anticipated date when the lateral candidate will begin employment with the firm.',
    `first_contact_date` DATE COMMENT 'Date when the firm first made contact with the lateral candidate.',
    `first_name` STRING COMMENT 'Legal first name of the lateral candidate.',
    `interview_date` DATE COMMENT 'Date of the most recent or primary interview with the lateral candidate.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the lateral candidate record was last updated.',
    `last_name` STRING COMMENT 'Legal last name (surname) of the lateral candidate.',
    `law_school` STRING COMMENT 'Name of the law school from which the candidate obtained their Juris Doctor (JD) or equivalent legal degree.',
    `law_school_graduation_year` STRING COMMENT 'Year the candidate graduated from law school.',
    `middle_name` STRING COMMENT 'Middle name or initial of the lateral candidate.',
    `mobile_number` STRING COMMENT 'Mobile phone number for the lateral candidate.',
    `notes` STRING COMMENT 'Free-text notes and observations about the lateral candidate, interview feedback, and recruitment progress.',
    `offer_acceptance_date` DATE COMMENT 'Date when the lateral candidate accepted the offer.',
    `offer_date` DATE COMMENT 'Date when a formal offer was extended to the lateral candidate.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the lateral candidate.',
    `portable_book_value_usd` DECIMAL(18,2) COMMENT 'Estimated annual revenue in US dollars that the candidate is expected to bring from existing client relationships.',
    `practice_area` STRING COMMENT 'Primary legal practice area or specialty of the lateral candidate (e.g., Corporate M&A, Litigation, Intellectual Property, Employment Law).',
    `preferred_name` STRING COMMENT 'Name the candidate prefers to be addressed by in professional settings.',
    `primary_bar_admission_year` STRING COMMENT 'Year the candidate was first admitted to practice law in their primary jurisdiction.',
    `proposed_compensation_usd` DECIMAL(18,2) COMMENT 'Proposed total annual compensation offer for the lateral candidate in US dollars.',
    `recruiter_name` STRING COMMENT 'Name of the internal or external recruiter managing the lateral candidate relationship.',
    `referral_source` STRING COMMENT 'Name of the person or organization that referred the lateral candidate, if applicable.',
    `secondary_practice_area` STRING COMMENT 'Secondary or complementary legal practice area of the lateral candidate.',
    `signing_bonus_usd` DECIMAL(18,2) COMMENT 'One-time signing bonus offered to the lateral candidate in US dollars.',
    `source_channel` STRING COMMENT 'Channel or method through which the lateral candidate was sourced.',
    `undergraduate_institution` STRING COMMENT 'Name of the college or university where the candidate completed their undergraduate degree.',
    `years_of_experience` STRING COMMENT 'Total number of years of post-qualification legal experience.',
    CONSTRAINT pk_lateral_candidate PRIMARY KEY(`lateral_candidate_id`)
) COMMENT 'Master reference table for lateral_candidate. Referenced by candidate_id.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`workforce`.`learning_item` (
    `learning_item_id` BIGINT COMMENT 'Primary key for learning_item',
    `practice_group_id` BIGINT COMMENT 'Foreign key to workforce.practice_group.practice_group_id',
    `prerequisite_learning_item_id` BIGINT COMMENT 'Self-referencing FK on learning_item (prerequisite_learning_item_id)',
    `accreditation_body` STRING COMMENT 'The regulatory or professional body that has accredited or approved this learning item for credit.',
    `accreditation_number` STRING COMMENT 'The unique accreditation or approval number assigned by the accrediting body.',
    `assessment_required_flag` BOOLEAN COMMENT 'Indicates whether participants must complete an assessment or examination to receive credit.',
    `learning_item_category` STRING COMMENT 'The subject matter category or domain of the learning item.',
    `certification_awarded_flag` BOOLEAN COMMENT 'Indicates whether successful completion results in a formal certification or credential.',
    `certification_name` STRING COMMENT 'The name of the certification or credential awarded upon successful completion.',
    `cle_credit_hours` DECIMAL(18,2) COMMENT 'The number of CLE credit hours awarded upon successful completion, as recognized by bar associations.',
    `learning_item_code` STRING COMMENT 'The unique business identifier or catalog code for the learning item used for external reference and registration.',
    `competency_level` STRING COMMENT 'The target competency or skill level for participants of this learning item.',
    `compliance_requirement_flag` BOOLEAN COMMENT 'Indicates whether this learning item fulfills a regulatory or professional compliance requirement.',
    `cost_amount` DECIMAL(18,2) COMMENT 'The standard enrollment or registration fee for the learning item.',
    `cpd_credit_hours` DECIMAL(18,2) COMMENT 'The number of CPD credit hours awarded upon successful completion, as recognized by professional regulatory bodies.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this learning item record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the cost amount.',
    `delivery_method` STRING COMMENT 'The instructional delivery format for the learning item.',
    `learning_item_description` STRING COMMENT 'Detailed description of the learning item content, objectives, and outcomes.',
    `duration_hours` DECIMAL(18,2) COMMENT 'The total instructional time required to complete the learning item, measured in hours.',
    `effective_end_date` DATE COMMENT 'The date after which this learning item is no longer available or valid for enrollment.',
    `effective_start_date` DATE COMMENT 'The date from which this learning item becomes available in the catalog.',
    `ethics_credit_hours` DECIMAL(18,2) COMMENT 'The number of ethics-specific credit hours awarded, often required separately by bar associations.',
    `jurisdiction` STRING COMMENT 'The legal jurisdiction or bar association territory where the learning item credits are recognized.',
    `language` STRING COMMENT 'The primary language of instruction for the learning item.',
    `last_updated_date` DATE COMMENT 'The date when the learning item content or metadata was last revised.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this learning item is mandatory for certain roles or compliance requirements.',
    `maximum_capacity` STRING COMMENT 'The maximum number of participants that can enroll in a single offering of this learning item.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this learning item record was last modified in the system.',
    `passing_score_percentage` DECIMAL(18,2) COMMENT 'The minimum score percentage required to pass the assessment and receive credit.',
    `practice_area` STRING COMMENT 'The legal practice area or specialty that this learning item addresses (e.g., corporate law, litigation, intellectual property).',
    `prerequisite_requirements` STRING COMMENT 'Description of any prerequisite knowledge, courses, or qualifications required before enrolling in this learning item.',
    `provider_name` STRING COMMENT 'Name of the organization or institution providing or accrediting the learning item.',
    `provider_type` STRING COMMENT 'Classification of the learning provider by organizational relationship.',
    `recertification_period_months` STRING COMMENT 'The number of months after which recertification or renewal is required.',
    `recertification_required_flag` BOOLEAN COMMENT 'Indicates whether the certification or credit requires periodic renewal or recertification.',
    `learning_item_status` STRING COMMENT 'Current lifecycle status of the learning item in the catalog.',
    `title` STRING COMMENT 'The official title or name of the learning item, course, or training program.',
    `learning_item_type` STRING COMMENT 'Classification of the learning item by delivery format and purpose.',
    `version_number` STRING COMMENT 'The version identifier for the learning item content, used to track curriculum updates and revisions.',
    CONSTRAINT pk_learning_item PRIMARY KEY(`learning_item_id`)
) COMMENT 'Master reference table for learning_item. Referenced by learning_item_id.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` (
    `compensation_plan_id` BIGINT COMMENT 'Primary key for compensation_plan',
    `practice_group_id` BIGINT COMMENT 'Foreign key to workforce.practice_group.practice_group_id',
    `superseded_compensation_plan_id` BIGINT COMMENT 'Self-referencing FK on compensation_plan (superseded_compensation_plan_id)',
    `approval_authority_level` STRING COMMENT 'The organizational authority level required to approve assignment to this compensation plan.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether assignment of a timekeeper to this compensation plan requires executive or compensation committee approval.',
    `bar_dues_reimbursement_eligible` BOOLEAN COMMENT 'Indicates whether the firm reimburses bar association membership dues for timekeepers under this plan.',
    `base_salary_maximum` DECIMAL(18,2) COMMENT 'Maximum annual base salary amount for timekeepers assigned to this compensation plan.',
    `base_salary_minimum` DECIMAL(18,2) COMMENT 'Minimum annual base salary amount for timekeepers assigned to this compensation plan.',
    `benefits_package_tier` STRING COMMENT 'Classification tier for the benefits package associated with this compensation plan.',
    `billable_hours_target` STRING COMMENT 'Annual target number of billable hours expected for timekeepers under this compensation plan.',
    `bonus_eligible` BOOLEAN COMMENT 'Indicates whether timekeepers under this plan are eligible for discretionary or performance-based bonuses.',
    `bonus_target_percentage` DECIMAL(18,2) COMMENT 'Target bonus amount expressed as a percentage of base salary for bonus-eligible plans.',
    `cle_allowance_amount` DECIMAL(18,2) COMMENT 'Annual allowance amount provided for Continuing Legal Education and Continuing Professional Development activities.',
    `compensation_review_cycle` STRING COMMENT 'Frequency at which compensation adjustments are reviewed and potentially modified for this plan.',
    `compensation_structure` STRING COMMENT 'The fundamental compensation methodology used by this plan, defining how compensation is calculated and distributed.',
    `created_date` DATE COMMENT 'Date when this compensation plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this compensation plan.',
    `compensation_plan_description` STRING COMMENT 'Detailed description of the compensation plan including its purpose, target population, and key features.',
    `effective_end_date` DATE COMMENT 'Date when this compensation plan ceases to be effective. Null for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when this compensation plan becomes effective and available for timekeeper assignment.',
    `equity_eligible` BOOLEAN COMMENT 'Indicates whether this plan includes eligibility for equity ownership in the firm.',
    `firm_office_location_restriction` STRING COMMENT 'Specific office location or geographic region this compensation plan is restricted to, if applicable. Null if no restriction.',
    `fte_classification` STRING COMMENT 'Employment classification indicating the full-time equivalent status for this compensation plan.',
    `fte_percentage` DECIMAL(18,2) COMMENT 'Percentage of full-time employment represented by this plan, where 100.00 equals full-time.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who most recently modified this compensation plan record.',
    `last_modified_date` DATE COMMENT 'Date when this compensation plan record was most recently modified.',
    `notes` STRING COMMENT 'Additional notes, special conditions, or administrative remarks related to this compensation plan.',
    `origination_credit_percentage` DECIMAL(18,2) COMMENT 'Percentage of credit allocated for client origination activities under this compensation plan.',
    `partner_tier` STRING COMMENT 'Hierarchical tier classification for partner-level compensation plans. Null or not_applicable for non-partner plans.',
    `pep_eligible` BOOLEAN COMMENT 'Indicates whether this plan is included in the firms Profit Per Equity Partner calculation and distribution.',
    `performance_review_frequency` STRING COMMENT 'Frequency at which formal performance reviews are conducted for timekeepers under this compensation plan.',
    `plan_code` STRING COMMENT 'Unique business identifier code for the compensation plan used in external communications and reporting.',
    `plan_name` STRING COMMENT 'Full descriptive name of the compensation plan.',
    `plan_type` STRING COMMENT 'Classification of the compensation plan based on the role category it applies to within the legal services organization.',
    `ppp_eligible` BOOLEAN COMMENT 'Indicates whether this plan is included in the firms Profit Per Partner calculation and distribution.',
    `practice_area_restriction` STRING COMMENT 'Specific practice area or legal specialty this compensation plan is restricted to, if applicable. Null if no restriction.',
    `profit_sharing_eligible` BOOLEAN COMMENT 'Indicates whether timekeepers under this plan are eligible to participate in firm profit sharing distributions.',
    `retirement_contribution_percentage` DECIMAL(18,2) COMMENT 'Employer contribution percentage to retirement plans for timekeepers under this compensation plan.',
    `rpe_eligible` BOOLEAN COMMENT 'Indicates whether this plan is included in the firms Revenue Per Equity Partner calculation.',
    `seniority_level_maximum` STRING COMMENT 'Maximum years of post-qualification experience for assignment to this compensation plan. Null if no upper limit.',
    `seniority_level_minimum` STRING COMMENT 'Minimum years of post-qualification experience required for assignment to this compensation plan.',
    `compensation_plan_status` STRING COMMENT 'Current lifecycle status of the compensation plan indicating whether it is available for assignment.',
    `created_by` STRING COMMENT 'User identifier of the person who created this compensation plan record.',
    CONSTRAINT pk_compensation_plan PRIMARY KEY(`compensation_plan_id`)
) COMMENT 'Master reference table for compensation_plan. Referenced by compensation_plan_id.';

CREATE TABLE IF NOT EXISTS `legal_ecm_v1`.`workforce`.`calibration_session` (
    `calibration_session_id` BIGINT COMMENT 'Primary key for calibration_session',
    `timekeeper_id` BIGINT COMMENT 'Reference to the senior partner or managing partner who approved the calibration session outcomes and compensation decisions.',
    `user_id` BIGINT COMMENT 'System user identifier of the person who created the calibration session record.',
    `calibration_facilitator_timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper (partner or senior attorney) who is facilitating and leading the calibration session.',
    `calibration_last_modified_by_user_id` BIGINT COMMENT 'System user identifier of the person who most recently modified the calibration session record.',
    `practice_group_id` BIGINT COMMENT 'Reference to the practice group or department for which this calibration session is being conducted, enabling practice-specific performance calibration.',
    `prior_calibration_session_id` BIGINT COMMENT 'Self-referencing FK on calibration_session (prior_calibration_session_id)',
    `rating_scale_id` BIGINT COMMENT 'Reference to the performance rating scale or competency framework being used for calibration in this session.',
    `review_cycle_id` BIGINT COMMENT 'Reference to the performance review cycle or compensation cycle to which this calibration session belongs.',
    `actual_end_time` TIMESTAMP COMMENT 'The actual date and time when the calibration session concluded, used for tracking session duration and completion.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual date and time when the calibration session commenced, used for tracking session duration and attendance.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether the calibration session outcomes require formal approval from senior leadership or compensation committee before finalization.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the calibration session outcomes were formally approved by authorized leadership.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget pool amount, supporting multi-currency compensation management.',
    `budget_pool_amount` DECIMAL(18,2) COMMENT 'Total compensation budget pool allocated for distribution during this calibration session, used for bonus and merit increase allocation.',
    `calibration_methodology` STRING COMMENT 'The performance calibration methodology or approach being applied in this session, such as forced ranking, relative distribution curves, or consensus-based evaluation.',
    `compensation_cycle_year` STRING COMMENT 'The fiscal or calendar year for which compensation decisions are being calibrated in this session, relevant for partner compensation and bonus allocation.',
    `confidentiality_level` STRING COMMENT 'Data classification level for the calibration session and its outcomes, typically confidential or restricted due to sensitive compensation and performance data.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the calibration session record was first created in the system.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the calibration session record is currently active and valid in the system, supporting soft-delete and historical tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the calibration session record was most recently updated or modified.',
    `meeting_location` STRING COMMENT 'Physical or virtual location where the calibration session is being held, such as conference room name, video conference link, or office address.',
    `participant_count` STRING COMMENT 'Total number of participants (reviewers, managers, partners) attending the calibration session.',
    `scheduled_date` DATE COMMENT 'The date on which the calibration session is scheduled to occur or occurred.',
    `scheduled_end_time` TIMESTAMP COMMENT 'The precise date and time when the calibration session is scheduled to conclude, supporting resource planning and meeting management.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The precise date and time when the calibration session is scheduled to begin, supporting meeting coordination and calendar integration.',
    `session_code` STRING COMMENT 'Business identifier for the calibration session, typically following a structured format for external reference and reporting.',
    `session_name` STRING COMMENT 'Human-readable name or title of the calibration session, typically indicating the review cycle, practice group, or organizational unit being calibrated.',
    `session_notes` STRING COMMENT 'Confidential notes and discussion points captured during the calibration session, documenting key decisions, rationale, and consensus reached.',
    `session_objectives` STRING COMMENT 'Detailed description of the goals and objectives for this calibration session, including specific outcomes to be achieved and decisions to be made.',
    `session_recording_url` STRING COMMENT 'Link to the recorded video or audio of the calibration session, if recorded for documentation and compliance purposes.',
    `session_status` STRING COMMENT 'Current lifecycle status of the calibration session indicating its progression through the review and approval workflow.',
    `session_type` STRING COMMENT 'Classification of the calibration session indicating the purpose and scope of the performance review or compensation calibration being conducted.',
    `target_distribution_curve` STRING COMMENT 'The target performance rating distribution or bell curve that the calibration session aims to achieve, expressed as percentages across rating categories.',
    `timekeeper_count` STRING COMMENT 'Total number of timekeepers (attorneys, paralegals, staff) whose performance or compensation is being calibrated in this session.',
    CONSTRAINT pk_calibration_session PRIMARY KEY(`calibration_session_id`)
) COMMENT 'Master reference table for calibration_session. Referenced by calibration_session_id.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Primary key for employee',
    `department_id` BIGINT COMMENT 'Identifier for the department or practice group to which the employee is assigned.',
    `practice_area_id` BIGINT COMMENT 'Identifier for the primary practice area or legal specialty of the employee. Applicable primarily to attorneys.',
    `primary_supervisor_employee_id` BIGINT COMMENT 'Employee identifier for the direct supervisor or manager of this employee. Self-referential foreign key to employee table.',
    `annual_base_salary` DECIMAL(18,2) COMMENT 'Annual base salary for the employee excluding bonuses, profit sharing, and other variable compensation.',
    `attorney_classification` STRING COMMENT 'Hierarchical classification for attorneys indicating seniority and partnership status. Null for non-attorney employees.',
    `bar_admission_count` STRING COMMENT 'Total number of bar admissions held by the attorney. Zero for non-attorney employees.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the employees time is billable to clients. True for timekeepers (attorneys, paralegals), false for administrative and support staff.',
    `cle_hours_completed_current_year` DECIMAL(18,2) COMMENT 'Continuing legal education hours completed by the employee in the current calendar or compliance year.',
    `cle_hours_required_annual` DECIMAL(18,2) COMMENT 'Annual continuing legal education hours required for the employee to maintain professional credentials and bar admissions.',
    `conflict_check_required_flag` BOOLEAN COMMENT 'Indicates whether the employee must be included in conflict of interest checks for new client matters. Typically true for attorneys and senior staff.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the employees compensation and billing rates.',
    `diversity_self_identification` STRING COMMENT 'Voluntary self-identification of diversity characteristics for equal opportunity and diversity reporting purposes. Stored in accordance with applicable employment law.',
    `email_address` STRING COMMENT 'Primary business email address for the employee used for firm communications.',
    `employee_number` STRING COMMENT 'Externally-known unique employee number assigned by the firm, used for payroll, timekeeping, and HR systems.',
    `employee_type` STRING COMMENT 'Classification of the employee by their primary role category within the legal services organization.',
    `employment_status` STRING COMMENT 'Current lifecycle status of the employee within the firm.',
    `first_name` STRING COMMENT 'Legal first name of the employee as recorded in official HR records.',
    `fte_percentage` DECIMAL(18,2) COMMENT 'Full-time equivalent percentage representing the employees contracted work capacity. 100.00 represents full-time, values below 100 represent part-time arrangements.',
    `high_potential_flag` BOOLEAN COMMENT 'Indicates whether the employee has been identified as high potential for advancement and leadership development.',
    `hire_date` DATE COMMENT 'Date the employee was originally hired by the firm.',
    `languages_spoken` STRING COMMENT 'Comma-separated list of languages the employee is proficient in, used for client matter staffing and international work.',
    `last_name` STRING COMMENT 'Legal last name or surname of the employee as recorded in official HR records.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review for the employee.',
    `middle_name` STRING COMMENT 'Middle name or initial of the employee.',
    `mobile_phone_number` STRING COMMENT 'Mobile phone number for the employee, used for urgent communications and mobile access.',
    `next_performance_review_date` DATE COMMENT 'Scheduled date for the next formal performance review for the employee.',
    `office_id` BIGINT COMMENT 'Foreign key to workforce.workforce_office.workforce_office_id',
    `partner_tier` STRING COMMENT 'Equity partner tier classification used for profit distribution and compensation calculations. Applicable only to equity partners.',
    `performance_rating` STRING COMMENT 'Most recent performance management rating for the employee from the annual review cycle.',
    `preferred_name` STRING COMMENT 'Name the employee prefers to be called in professional settings, may differ from legal name.',
    `professional_liability_insurance_flag` BOOLEAN COMMENT 'Indicates whether the employee is covered under the firms professional liability insurance policy. Typically true for all practicing attorneys.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was last modified in the system.',
    `security_clearance_level` STRING COMMENT 'Government security clearance level held by the employee, relevant for attorneys working on government contracts or matters requiring clearance.',
    `standard_hourly_rate` DECIMAL(18,2) COMMENT 'Standard billing rate per hour for the employee when their time is charged to client matters. Applicable to billable timekeepers.',
    `succession_plan_flag` BOOLEAN COMMENT 'Indicates whether the employee is included in formal succession planning for key leadership or partner positions.',
    `termination_date` DATE COMMENT 'Date the employees employment was terminated. Null for active employees.',
    `termination_reason` STRING COMMENT 'Reason for employment termination. Null for active employees.',
    `utilization_target_percentage` DECIMAL(18,2) COMMENT 'Target billable utilization percentage for the employee, representing the expected proportion of working hours that should be billed to client matters.',
    `work_arrangement` STRING COMMENT 'Primary work arrangement classification indicating whether the employee works on-site, in a hybrid model, or fully remote.',
    `work_phone_number` STRING COMMENT 'Primary work telephone number for the employee.',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Master reference table for employee. Referenced by employee_id.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`workforce`.`department` (
    `department_id` BIGINT COMMENT 'Primary key for department',
    `parent_department_id` BIGINT COMMENT 'Reference to the parent department in a hierarchical organizational structure. Null for top-level departments. Enables multi-tier departmental reporting and roll-up analytics.',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Total annual operating budget allocated to the department for the current fiscal year, including personnel costs, overhead, and discretionary spending.',
    `annual_revenue_target` DECIMAL(18,2) COMMENT 'Target annual revenue goal for the department for the current fiscal year. Applicable to billable practice departments. Used for performance management and compensation planning.',
    `attorney_count` STRING COMMENT 'Total number of attorneys (partners, counsel, associates) assigned to the department. Used for workload distribution and expertise capacity planning.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the departments work is typically billable to clients. True for practice departments that generate client revenue; false for administrative and support departments.',
    `cost_center_code` STRING COMMENT 'Financial accounting code used to track expenses, overhead allocation, and budgetary performance for this department. Aligns with the firms general ledger structure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the department record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the departments primary operating currency. Used for financial reporting and budget management.',
    `department_code` STRING COMMENT 'Short alphanumeric code used to identify the department in business systems and reporting. Typically used in timekeeping, matter coding, and financial allocation.',
    `department_type` STRING COMMENT 'Classification of the department by its primary function within the firm. Practice departments are client-facing legal service delivery units; administrative, support, executive, operations, and business development are non-billable support functions.',
    `department_description` STRING COMMENT 'Detailed narrative description of the departments mission, scope of services, key responsibilities, and strategic focus areas.',
    `dissolution_date` DATE COMMENT 'Date when the department was officially dissolved, merged, or permanently closed. Null for active departments.',
    `effective_end_date` DATE COMMENT 'Date on which the current department configuration, structure, or attributes ceased to be effective. Null for currently active configurations. Used for temporal tracking and historical reporting.',
    `effective_start_date` DATE COMMENT 'Date from which the current department configuration, structure, or attributes became effective. Used for temporal tracking and historical reporting.',
    `email_address` STRING COMMENT 'Primary email address for the department used for general inquiries, client communication, and internal correspondence.',
    `established_date` DATE COMMENT 'Date when the department was officially established or created within the firms organizational structure.',
    `extension` STRING COMMENT 'Internal phone extension number for the department within the firms telecommunications system.',
    `floor_number` STRING COMMENT 'Physical floor number or level within the office building where the department is primarily located.',
    `headcount_fte` DECIMAL(18,2) COMMENT 'Total full-time equivalent headcount allocated to the department, including attorneys, paralegals, and support staff. Used for capacity planning and utilization analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the department record was last updated or modified. Used for audit trail, change tracking, and data freshness monitoring.',
    `department_name` STRING COMMENT 'Full official name of the department as recognized within the firm organizational structure.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or contextual information about the department not captured in other structured fields.',
    `paralegal_count` STRING COMMENT 'Total number of paralegals assigned to the department. Used for support resource planning and matter staffing.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the department. Used for client communication and internal coordination.',
    `practice_area` STRING COMMENT 'Primary legal practice area or specialty served by this department. Applicable only to practice-type departments. Used for matter assignment, expertise matching, and revenue attribution.',
    `profit_center_code` STRING COMMENT 'Financial accounting code used to track revenue, profitability, and financial performance for revenue-generating departments. Applicable primarily to practice departments.',
    `realization_target_percentage` DECIMAL(18,2) COMMENT 'Target realization rate (collected revenue as a percentage of billed revenue) for the department. Used to measure billing effectiveness and client payment performance.',
    `short_name` STRING COMMENT 'Abbreviated or shortened name of the department used in reports, dashboards, and user interfaces where space is limited.',
    `department_status` STRING COMMENT 'Current operational status of the department within the firm. Active departments are fully operational; inactive departments are temporarily non-operational; suspended departments are under review; merged departments have been consolidated into another unit; dissolved departments have been permanently closed.',
    `suite_number` STRING COMMENT 'Suite or room number designation for the departments primary workspace within the office location.',
    `support_staff_count` STRING COMMENT 'Total number of administrative and support staff assigned to the department, including legal secretaries, administrative assistants, and coordinators.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the departments primary office location. Used for scheduling, time tracking, and cross-office coordination.',
    `utilization_target_percentage` DECIMAL(18,2) COMMENT 'Target billable utilization rate for the department, expressed as a percentage of total available hours. Used for performance benchmarking and resource optimization.',
    CONSTRAINT pk_department PRIMARY KEY(`department_id`)
) COMMENT 'Master reference table for department. Referenced by department_id.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`workforce`.`review_cycle` (
    `review_cycle_id` BIGINT COMMENT 'Primary key for review_cycle',
    `practice_group_id` BIGINT COMMENT 'Foreign key to workforce.practice_group.practice_group_id',
    `prior_review_cycle_id` BIGINT COMMENT 'Self-referencing FK on review_cycle (prior_review_cycle_id)',
    `applicable_to_attorneys` BOOLEAN COMMENT 'Indicates whether this review cycle applies to attorney timekeepers.',
    `applicable_to_paralegals` BOOLEAN COMMENT 'Indicates whether this review cycle applies to paralegal staff.',
    `applicable_to_partners` BOOLEAN COMMENT 'Indicates whether this review cycle applies to equity and non-equity partners.',
    `applicable_to_staff` BOOLEAN COMMENT 'Indicates whether this review cycle applies to non-timekeeper administrative and support staff.',
    `billable_hours_threshold` DECIMAL(18,2) COMMENT 'The minimum billable hours target or threshold used as a performance criterion in this review cycle.',
    `calibration_meeting_date` DATE COMMENT 'The scheduled date for the calibration or normalization meeting where review ratings are discussed and aligned across the firm.',
    `cle_cpd_requirement_check` BOOLEAN COMMENT 'Indicates whether this review cycle includes verification of CLE or CPD compliance for attorneys.',
    `compensation_linked` BOOLEAN COMMENT 'Indicates whether the outcomes of this review cycle are directly linked to compensation adjustments, bonuses, or profit-sharing distributions.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this review cycle record was first created in the system.',
    `cycle_close_date` DATE COMMENT 'The date when the review cycle officially closes and no further review submissions are accepted.',
    `cycle_code` STRING COMMENT 'The externally-known unique code or identifier for the review cycle used in business communications and reporting.',
    `cycle_name` STRING COMMENT 'The business name or title of the review cycle (e.g., 2024 Annual Partner Review, Q2 Associate Performance Review).',
    `cycle_open_date` DATE COMMENT 'The date when the review cycle officially opens and review activities can begin.',
    `cycle_type` STRING COMMENT 'The type or category of review cycle, indicating the purpose and frequency of the review process.',
    `review_cycle_description` STRING COMMENT 'A detailed description of the review cycle, including its objectives, scope, and any special considerations or instructions for participants.',
    `feedback_delivery_end_date` DATE COMMENT 'The deadline by which all formal review feedback must be delivered to timekeepers.',
    `feedback_delivery_start_date` DATE COMMENT 'The date when managers can begin delivering formal review feedback to timekeepers.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this review cycle belongs for financial and compensation planning purposes.',
    `includes_360_feedback` BOOLEAN COMMENT 'Indicates whether this review cycle includes 360-degree feedback from peers, subordinates, and clients.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this review cycle record is currently active and available for use in the system.',
    `last_modified_by` STRING COMMENT 'The username or identifier of the user who last modified this review cycle record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this review cycle record was last modified.',
    `manager_review_due_date` DATE COMMENT 'The deadline by which supervising partners or managers must complete their review assessments.',
    `mandatory_participation` BOOLEAN COMMENT 'Indicates whether participation in this review cycle is mandatory for all eligible timekeepers.',
    `origination_credit_weight` DECIMAL(18,2) COMMENT 'The percentage weight assigned to client origination and business development activities in the overall review assessment.',
    `peer_review_count` STRING COMMENT 'The number of peer reviews required or recommended for each participant in this review cycle.',
    `promotion_eligible` BOOLEAN COMMENT 'Indicates whether this review cycle includes consideration for promotions or advancement to the next tier.',
    `rating_scale_type` STRING COMMENT 'The type of rating scale used for performance assessments in this review cycle.',
    `review_period_end_date` DATE COMMENT 'The end date of the performance period being evaluated in this review cycle.',
    `review_period_start_date` DATE COMMENT 'The start date of the performance period being evaluated in this review cycle.',
    `self_assessment_due_date` DATE COMMENT 'The deadline by which timekeepers must complete their self-assessment portion of the review.',
    `source_system` STRING COMMENT 'The name of the source system from which this review cycle data originated (e.g., SAP SuccessFactors).',
    `source_system_code` STRING COMMENT 'The unique identifier for this review cycle in the source system of record.',
    `review_cycle_status` STRING COMMENT 'The current lifecycle status of the review cycle indicating its operational state.',
    `created_by` STRING COMMENT 'The username or identifier of the human resources or administrative user who created this review cycle record.',
    CONSTRAINT pk_review_cycle PRIMARY KEY(`review_cycle_id`)
) COMMENT 'Master reference table for review_cycle. Referenced by review_cycle_id.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`workforce`.`rating_scale` (
    `rating_scale_id` BIGINT COMMENT 'Primary key for rating_scale',
    `practice_group_id` BIGINT COMMENT 'Foreign key to workforce.practice_group.practice_group_id',
    `primary_superseded_rating_scale_id` BIGINT COMMENT 'Self-referencing FK on rating_scale (superseded_rating_scale_id)',
    `allows_decimal_precision` BOOLEAN COMMENT 'Indicates whether the rating scale permits decimal precision beyond half-points (e.g., 3.75, 4.25). True if decimal precision is allowed, False otherwise.',
    `allows_half_points` BOOLEAN COMMENT 'Indicates whether the rating scale permits half-point increments (e.g., 3.5 on a 1-5 scale). True if half-points are allowed, False if only whole numbers are permitted.',
    `applicable_to_attorneys` BOOLEAN COMMENT 'Indicates whether this rating scale is used for attorney performance evaluations, competency assessments, or partner reviews. True if applicable to attorneys, False otherwise.',
    `applicable_to_partners` BOOLEAN COMMENT 'Indicates whether this rating scale is used for equity partner, non-equity partner, or senior partner evaluations. True if applicable to partners, False otherwise.',
    `applicable_to_staff` BOOLEAN COMMENT 'Indicates whether this rating scale is used for non-attorney staff evaluations (paralegals, legal assistants, administrative staff). True if applicable to staff, False otherwise.',
    `approval_level` STRING COMMENT 'The organizational level required to approve ratings using this scale: none (no approval needed), manager (direct supervisor), practice_leader (practice group head), compensation_committee (firm compensation committee), managing_partner (firm managing partner).',
    `approval_required` BOOLEAN COMMENT 'Indicates whether ratings using this scale require formal approval by a manager, practice group leader, or compensation committee before being finalized. True if approval is required, False otherwise.',
    `comments_required` BOOLEAN COMMENT 'Indicates whether evaluators must provide written comments or justification when assigning ratings using this scale. True if comments are mandatory, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this rating scale record was first created in the system. Audit field for data lineage and compliance.',
    `display_order` STRING COMMENT 'Numeric value controlling the display order of this rating scale in user interfaces and selection lists. Lower numbers appear first.',
    `distribution_curve_type` STRING COMMENT 'The type of distribution curve applied when forced distribution is required: none (no forced distribution), bell_curve (normal distribution), top_grading (A/B/C player model), rank_and_yank (bottom percentage must be rated low).',
    `effective_end_date` DATE COMMENT 'The date on which this rating scale is retired or replaced. Null if the scale is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'The date from which this rating scale becomes active and available for use in performance evaluations and assessments.',
    `excellence_threshold` DECIMAL(18,2) COMMENT 'The rating value at or above which performance is considered excellent or exceeds expectations. Used for identifying high performers and bonus eligibility.',
    `external_system_code` STRING COMMENT 'The unique identifier for this rating scale in the source system (e.g., SAP SuccessFactors rating scale ID). Used for system integration and data reconciliation.',
    `forced_distribution_required` BOOLEAN COMMENT 'Indicates whether this rating scale requires forced distribution (e.g., only 20% can receive the highest rating, 10% must be in the lowest tier). True if forced distribution applies, False otherwise.',
    `increment_step` DECIMAL(18,2) COMMENT 'The numeric increment between valid rating values (e.g., 1.0 for integer scales, 0.5 for half-point scales, 0.1 for decimal scales).',
    `is_default_scale` BOOLEAN COMMENT 'Indicates whether this is the default rating scale used when no specific scale is designated for a performance review or assessment. True if this is the default scale, False otherwise.',
    `linked_to_compensation` BOOLEAN COMMENT 'Indicates whether ratings on this scale directly influence compensation decisions such as bonuses, salary increases, or profit-sharing distributions. True if linked to compensation, False otherwise.',
    `linked_to_promotion` BOOLEAN COMMENT 'Indicates whether ratings on this scale are a factor in promotion decisions (e.g., associate to senior associate, counsel to partner). True if linked to promotion, False otherwise.',
    `maximum_value` DECIMAL(18,2) COMMENT 'The highest numeric value on the rating scale (e.g., 5 for a 1-5 scale, 100 for a 0-100 scale).',
    `midpoint_value` DECIMAL(18,2) COMMENT 'The midpoint or neutral value on the rating scale, often representing meets expectations or satisfactory performance.',
    `minimum_value` DECIMAL(18,2) COMMENT 'The lowest numeric value on the rating scale (e.g., 1 for a 1-5 scale, 0 for a 0-100 scale).',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this rating scale record was last updated. Audit field for change tracking and data governance.',
    `notes` STRING COMMENT 'Additional notes, guidance, or instructions for evaluators using this rating scale. May include examples of behaviors or performance indicators for each rating level.',
    `passing_threshold` DECIMAL(18,2) COMMENT 'The minimum rating value required to be considered passing or acceptable performance. Used in competency assessments and mandatory training evaluations.',
    `peer_review_allowed` BOOLEAN COMMENT 'Indicates whether this rating scale can be used for peer-to-peer evaluations (e.g., associate reviewing another associate, partner reviewing another partner). True if peer review is allowed, False otherwise.',
    `requires_calibration` BOOLEAN COMMENT 'Indicates whether ratings using this scale must go through a calibration process with peer review or management committee to ensure consistency across evaluators. True if calibration is required, False otherwise.',
    `scale_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the rating scale for system integration and reporting (e.g., PERF-5PT, COMP-10PT, PARTNER-EVAL).',
    `scale_description` STRING COMMENT 'Detailed business description of the rating scale, its purpose, and usage context within performance management, talent development, or compensation processes.',
    `scale_direction` STRING COMMENT 'Indicates whether higher values represent better performance (ascending) or lower values represent better performance (descending). Most legal industry scales are ascending.',
    `scale_name` STRING COMMENT 'The business name of the rating scale (e.g., Annual Performance Review Scale, Partner Evaluation Scale, Associate Competency Scale).',
    `scale_type` STRING COMMENT 'Categorical classification of the rating scale purpose: performance (annual reviews), competency (skill assessments), potential (succession planning), behavior (conduct evaluations), skill (technical proficiency), client_feedback (client satisfaction).',
    `self_assessment_allowed` BOOLEAN COMMENT 'Indicates whether timekeepers can use this rating scale to perform self-assessments as part of the performance review process. True if self-assessment is allowed, False otherwise.',
    `source_system` STRING COMMENT 'The system of record where this rating scale is defined and maintained (e.g., SAP SuccessFactors, Workday HCM, custom HRIS).',
    `rating_scale_status` STRING COMMENT 'Current lifecycle status of the rating scale: active (in use), inactive (temporarily suspended), draft (under development), retired (no longer used), under_review (being evaluated for changes).',
    `usage_context` STRING COMMENT 'The primary business context in which this rating scale is applied: annual_review (year-end performance), mid_year_review (interim check-in), probation_review (new hire evaluation), promotion_review (advancement consideration), compensation_review (bonus and salary decisions), succession_planning (leadership pipeline assessment).',
    `version_number` STRING COMMENT 'Version identifier for the rating scale to track changes over time (e.g., v1.0, v2.1, 2024.1). Used when scales are updated or refined.',
    CONSTRAINT pk_rating_scale PRIMARY KEY(`rating_scale_id`)
) COMMENT 'Master reference table for rating_scale. Referenced by rating_scale_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ADD CONSTRAINT `fk_workforce_timekeeper_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `legal_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ADD CONSTRAINT `fk_workforce_timekeeper_supervisor_employee_timekeeper_id` FOREIGN KEY (`supervisor_employee_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ADD CONSTRAINT `fk_workforce_attorney_profile_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ADD CONSTRAINT `fk_workforce_attorney_profile_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ADD CONSTRAINT `fk_workforce_attorney_profile_to_timekeeper_id` FOREIGN KEY (`to_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ADD CONSTRAINT `fk_workforce_bar_admission_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ADD CONSTRAINT `fk_workforce_bar_admission_primary_bar_timekeeper_id` FOREIGN KEY (`primary_bar_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ADD CONSTRAINT `fk_workforce_bar_admission_to_timekeeper_id` FOREIGN KEY (`to_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ADD CONSTRAINT `fk_workforce_cle_requirement_attorney_profile_id` FOREIGN KEY (`attorney_profile_id`) REFERENCES `legal_ecm_v1`.`workforce`.`attorney_profile`(`attorney_profile_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ADD CONSTRAINT `fk_workforce_cle_requirement_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ADD CONSTRAINT `fk_workforce_cle_requirement_required_timekeeper_id` FOREIGN KEY (`required_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ADD CONSTRAINT `fk_workforce_cle_requirement_to_timekeeper_id` FOREIGN KEY (`to_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ADD CONSTRAINT `fk_workforce_cle_completion_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ADD CONSTRAINT `fk_workforce_cle_completion_learning_item_id` FOREIGN KEY (`learning_item_id`) REFERENCES `legal_ecm_v1`.`workforce`.`learning_item`(`learning_item_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ADD CONSTRAINT `fk_workforce_cle_completion_cle_requirement_id` FOREIGN KEY (`cle_requirement_id`) REFERENCES `legal_ecm_v1`.`workforce`.`cle_requirement`(`cle_requirement_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ADD CONSTRAINT `fk_workforce_cle_completion_primary_cle_timekeeper_id` FOREIGN KEY (`primary_cle_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ADD CONSTRAINT `fk_workforce_cle_completion_recorded_by_timekeeper_id` FOREIGN KEY (`recorded_by_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ADD CONSTRAINT `fk_workforce_cle_completion_satisfied_cle_requirement_id` FOREIGN KEY (`satisfied_cle_requirement_id`) REFERENCES `legal_ecm_v1`.`workforce`.`cle_requirement`(`cle_requirement_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ADD CONSTRAINT `fk_workforce_cle_completion_to_cle_requirement_id` FOREIGN KEY (`to_cle_requirement_id`) REFERENCES `legal_ecm_v1`.`workforce`.`cle_requirement`(`cle_requirement_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ADD CONSTRAINT `fk_workforce_cle_completion_to_timekeeper_id` FOREIGN KEY (`to_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ADD CONSTRAINT `fk_workforce_billing_rate_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ADD CONSTRAINT `fk_workforce_billing_rate_billing_approving_partner_timekeeper_id` FOREIGN KEY (`billing_approving_partner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ADD CONSTRAINT `fk_workforce_billing_rate_billing_timekeeper_id` FOREIGN KEY (`billing_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ADD CONSTRAINT `fk_workforce_billing_rate_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ADD CONSTRAINT `fk_workforce_billing_rate_prior_rate_billing_rate_id` FOREIGN KEY (`prior_rate_billing_rate_id`) REFERENCES `legal_ecm_v1`.`workforce`.`billing_rate`(`billing_rate_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ADD CONSTRAINT `fk_workforce_billing_rate_rate_owner_timekeeper_id` FOREIGN KEY (`rate_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ADD CONSTRAINT `fk_workforce_billing_rate_to_timekeeper_id` FOREIGN KEY (`to_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ADD CONSTRAINT `fk_workforce_practice_group_parent_group_practice_group_id` FOREIGN KEY (`parent_group_practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ADD CONSTRAINT `fk_workforce_practice_group_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ADD CONSTRAINT `fk_workforce_practice_group_primary_timekeeper_id` FOREIGN KEY (`primary_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ADD CONSTRAINT `fk_workforce_matter_assignment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ADD CONSTRAINT `fk_workforce_matter_assignment_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ADD CONSTRAINT `fk_workforce_matter_assignment_primary_matter_team_lead_timekeeper_id` FOREIGN KEY (`primary_matter_team_lead_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ADD CONSTRAINT `fk_workforce_matter_assignment_tertiary_matter_supervising_timekeeper_id` FOREIGN KEY (`tertiary_matter_supervising_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ADD CONSTRAINT `fk_workforce_matter_assignment_to_timekeeper_id` FOREIGN KEY (`to_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_calibration_session_id` FOREIGN KEY (`calibration_session_id`) REFERENCES `legal_ecm_v1`.`workforce`.`calibration_session`(`calibration_session_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_reviewed_timekeeper_id` FOREIGN KEY (`reviewed_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_reviewer_timekeeper_id` FOREIGN KEY (`reviewer_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_to_timekeeper_id` FOREIGN KEY (`to_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ADD CONSTRAINT `fk_workforce_compensation_record_compensation_plan_id` FOREIGN KEY (`compensation_plan_id`) REFERENCES `legal_ecm_v1`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ADD CONSTRAINT `fk_workforce_compensation_record_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ADD CONSTRAINT `fk_workforce_compensation_record_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ADD CONSTRAINT `fk_workforce_compensation_record_record_owner_timekeeper_id` FOREIGN KEY (`record_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ADD CONSTRAINT `fk_workforce_compensation_record_to_timekeeper_id` FOREIGN KEY (`to_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_primary_recruitment_practice_group_id` FOREIGN KEY (`primary_recruitment_practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_requesting_practice_group_id` FOREIGN KEY (`requesting_practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_succession_plan_id` FOREIGN KEY (`succession_plan_id`) REFERENCES `legal_ecm_v1`.`workforce`.`succession_plan`(`succession_plan_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ADD CONSTRAINT `fk_workforce_recruitment_requisition_target_practice_group_id` FOREIGN KEY (`target_practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ADD CONSTRAINT `fk_workforce_leave_record_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ADD CONSTRAINT `fk_workforce_leave_record_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ADD CONSTRAINT `fk_workforce_leave_record_primary_leave_timekeeper_id` FOREIGN KEY (`primary_leave_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ADD CONSTRAINT `fk_workforce_leave_record_tertiary_leave_covering_timekeeper_id` FOREIGN KEY (`tertiary_leave_covering_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ADD CONSTRAINT `fk_workforce_leave_record_to_timekeeper_id` FOREIGN KEY (`to_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_subject_timekeeper_id` FOREIGN KEY (`subject_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_tertiary_succession_timekeeper_id` FOREIGN KEY (`tertiary_succession_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_to_timekeeper_id` FOREIGN KEY (`to_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ADD CONSTRAINT `fk_workforce_secondment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ADD CONSTRAINT `fk_workforce_secondment_primary_secondment_supervising_partner_timekeeper_id` FOREIGN KEY (`primary_secondment_supervising_partner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ADD CONSTRAINT `fk_workforce_secondment_seconded_timekeeper_id` FOREIGN KEY (`seconded_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ADD CONSTRAINT `fk_workforce_secondment_tertiary_secondment_approved_by_employee_timekeeper_id` FOREIGN KEY (`tertiary_secondment_approved_by_employee_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ADD CONSTRAINT `fk_workforce_secondment_to_timekeeper_id` FOREIGN KEY (`to_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ADD CONSTRAINT `fk_workforce_disciplinary_record_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ADD CONSTRAINT `fk_workforce_disciplinary_record_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ADD CONSTRAINT `fk_workforce_disciplinary_record_primary_disciplinary_timekeeper_id` FOREIGN KEY (`primary_disciplinary_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ADD CONSTRAINT `fk_workforce_disciplinary_record_tertiary_disciplinary_hr_case_owner_timekeeper_id` FOREIGN KEY (`tertiary_disciplinary_hr_case_owner_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ADD CONSTRAINT `fk_workforce_disciplinary_record_to_timekeeper_id` FOREIGN KEY (`to_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ADD CONSTRAINT `fk_workforce_diversity_record_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ADD CONSTRAINT `fk_workforce_diversity_record_prior_diversity_record_id` FOREIGN KEY (`prior_diversity_record_id`) REFERENCES `legal_ecm_v1`.`workforce`.`diversity_record`(`diversity_record_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ADD CONSTRAINT `fk_workforce_diversity_record_subject_timekeeper_id` FOREIGN KEY (`subject_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ADD CONSTRAINT `fk_workforce_diversity_record_to_timekeeper_id` FOREIGN KEY (`to_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`rfp_team_assignment` ADD CONSTRAINT `fk_workforce_rfp_team_assignment_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ADD CONSTRAINT `fk_workforce_user_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `legal_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ADD CONSTRAINT `fk_workforce_user_primary_manager_user_id` FOREIGN KEY (`primary_manager_user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ADD CONSTRAINT `fk_workforce_user_tertiary_created_by_user_id` FOREIGN KEY (`tertiary_created_by_user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ADD CONSTRAINT `fk_workforce_lateral_candidate_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ADD CONSTRAINT `fk_workforce_lateral_candidate_recruitment_requisition_id` FOREIGN KEY (`recruitment_requisition_id`) REFERENCES `legal_ecm_v1`.`workforce`.`recruitment_requisition`(`recruitment_requisition_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ADD CONSTRAINT `fk_workforce_lateral_candidate_referred_by_lateral_candidate_id` FOREIGN KEY (`referred_by_lateral_candidate_id`) REFERENCES `legal_ecm_v1`.`workforce`.`lateral_candidate`(`lateral_candidate_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ADD CONSTRAINT `fk_workforce_learning_item_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ADD CONSTRAINT `fk_workforce_learning_item_prerequisite_learning_item_id` FOREIGN KEY (`prerequisite_learning_item_id`) REFERENCES `legal_ecm_v1`.`workforce`.`learning_item`(`learning_item_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_superseded_compensation_plan_id` FOREIGN KEY (`superseded_compensation_plan_id`) REFERENCES `legal_ecm_v1`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ADD CONSTRAINT `fk_workforce_calibration_session_timekeeper_id` FOREIGN KEY (`timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ADD CONSTRAINT `fk_workforce_calibration_session_user_id` FOREIGN KEY (`user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ADD CONSTRAINT `fk_workforce_calibration_session_calibration_facilitator_timekeeper_id` FOREIGN KEY (`calibration_facilitator_timekeeper_id`) REFERENCES `legal_ecm_v1`.`workforce`.`timekeeper`(`timekeeper_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ADD CONSTRAINT `fk_workforce_calibration_session_calibration_last_modified_by_user_id` FOREIGN KEY (`calibration_last_modified_by_user_id`) REFERENCES `legal_ecm_v1`.`workforce`.`user`(`user_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ADD CONSTRAINT `fk_workforce_calibration_session_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ADD CONSTRAINT `fk_workforce_calibration_session_prior_calibration_session_id` FOREIGN KEY (`prior_calibration_session_id`) REFERENCES `legal_ecm_v1`.`workforce`.`calibration_session`(`calibration_session_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ADD CONSTRAINT `fk_workforce_calibration_session_rating_scale_id` FOREIGN KEY (`rating_scale_id`) REFERENCES `legal_ecm_v1`.`workforce`.`rating_scale`(`rating_scale_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ADD CONSTRAINT `fk_workforce_calibration_session_review_cycle_id` FOREIGN KEY (`review_cycle_id`) REFERENCES `legal_ecm_v1`.`workforce`.`review_cycle`(`review_cycle_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_department_id` FOREIGN KEY (`department_id`) REFERENCES `legal_ecm_v1`.`workforce`.`department`(`department_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_primary_supervisor_employee_id` FOREIGN KEY (`primary_supervisor_employee_id`) REFERENCES `legal_ecm_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ADD CONSTRAINT `fk_workforce_department_parent_department_id` FOREIGN KEY (`parent_department_id`) REFERENCES `legal_ecm_v1`.`workforce`.`department`(`department_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ADD CONSTRAINT `fk_workforce_review_cycle_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ADD CONSTRAINT `fk_workforce_review_cycle_prior_review_cycle_id` FOREIGN KEY (`prior_review_cycle_id`) REFERENCES `legal_ecm_v1`.`workforce`.`review_cycle`(`review_cycle_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ADD CONSTRAINT `fk_workforce_rating_scale_practice_group_id` FOREIGN KEY (`practice_group_id`) REFERENCES `legal_ecm_v1`.`workforce`.`practice_group`(`practice_group_id`);
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ADD CONSTRAINT `fk_workforce_rating_scale_primary_superseded_rating_scale_id` FOREIGN KEY (`primary_superseded_rating_scale_id`) REFERENCES `legal_ecm_v1`.`workforce`.`rating_scale`(`rating_scale_id`);

-- ========= TAGS =========
ALTER SCHEMA `legal_ecm_v1`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `legal_ecm_v1`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'SAP SuccessFactors Employee ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `employee_id` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `employee_id` SET TAGS ('dbx_dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `supervisor_employee_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Supervising Attorney / Manager Employee ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `admission_multi_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Multi-Jurisdiction Bar Admission Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `annual_billable_hours_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Billable Hours Target');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `annual_billable_hours_target` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `bar_admission_date` SET TAGS ('dbx_business_glossary_term' = 'Bar Admission Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `bar_admission_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Bar Admission Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `bar_number` SET TAGS ('dbx_business_glossary_term' = 'Bar Admission Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `bar_number` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `bar_status` SET TAGS ('dbx_business_glossary_term' = 'Bar Admission Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `bar_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|disbarred|retired');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `billing_rate_tier` SET TAGS ('dbx_business_glossary_term' = 'Standard Billing Rate Tier');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `biography` SET TAGS ('dbx_business_glossary_term' = 'Professional Biography');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `cpd_compliance_period_end` SET TAGS ('dbx_business_glossary_term' = 'CPD/CLE Compliance Period End Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `cpd_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Continuing Professional Development (CPD) / Continuing Legal Education (CLE) Hours Completed');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `cpd_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Continuing Professional Development (CPD) / Continuing Legal Education (CLE) Hours Required');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|terminated|retired|suspended');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|secondment|of_counsel');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `firm_office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper First Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `first_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `first_name` SET TAGS ('dbx_dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Full Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `full_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `full_name` SET TAGS ('dbx_dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `is_billing_timekeeper` SET TAGS ('dbx_business_glossary_term' = 'Billing Timekeeper Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `is_equity_partner` SET TAGS ('dbx_business_glossary_term' = 'Equity Partner Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `is_equity_partner` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `is_partnership_track` SET TAGS ('dbx_business_glossary_term' = 'Partnership Track Status Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `is_partnership_track` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `languages_spoken` SET TAGS ('dbx_business_glossary_term' = 'Languages Spoken');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Last Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `last_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `last_name` SET TAGS ('dbx_dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `law_school` SET TAGS ('dbx_business_glossary_term' = 'Law School');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `law_school_graduation_year` SET TAGS ('dbx_business_glossary_term' = 'Law School Graduation Year');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `lpp_designation` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Designation Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `practice_specializations` SET TAGS ('dbx_business_glossary_term' = 'Practice Specializations');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Preferred Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `preferred_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `preferred_name` SET TAGS ('dbx_dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `primary_practice_group_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `pro_bono_hours_target` SET TAGS ('dbx_business_glossary_term' = 'Pro Bono Hours Annual Target');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `seniority_level` SET TAGS ('dbx_business_glossary_term' = 'Seniority Level');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `standard_hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Standard Hourly Billing Rate');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `standard_hourly_rate` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `timekeeper_type` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `timekeeper_type` SET TAGS ('dbx_value_regex' = 'attorney|paralegal|legal_assistant|law_clerk|staff|contract_attorney');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `utbms_timekeeper_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Timekeeper Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `utbms_timekeeper_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `work_email` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Work Email Address');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `work_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `work_email` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `work_email` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `work_phone` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Work Phone Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `work_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `work_phone` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`timekeeper` ALTER COLUMN `work_phone` SET TAGS ('dbx_dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Attorney Profile ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `practice_group_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `to_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'To Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `admission_jurisdiction_summary` SET TAGS ('dbx_business_glossary_term' = 'Admission Jurisdiction Summary');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `afa_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fee Arrangement (AFA) Eligible Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `attorney_type` SET TAGS ('dbx_business_glossary_term' = 'Attorney Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `attorney_type` SET TAGS ('dbx_value_regex' = 'Attorney|Solicitor|Barrister|Paralegal|Legal Executive');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `bar_number` SET TAGS ('dbx_business_glossary_term' = 'Bar Admission Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `bar_number` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `bar_number` SET TAGS ('dbx_dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `chambers_ranking` SET TAGS ('dbx_business_glossary_term' = 'Chambers & Partners Ranking');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `conflict_check_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Clearance Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `conflict_check_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|flagged|waived');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `cpd_annual_hours_target` SET TAGS ('dbx_business_glossary_term' = 'Continuing Professional Development (CPD) / Continuing Legal Education (CLE) Annual Hours Target');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `cpd_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Continuing Professional Development (CPD) / Continuing Legal Education (CLE) Compliance Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `cpd_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|at_risk|non_compliant|exempt');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `cpd_hours_completed_ytd` SET TAGS ('dbx_business_glossary_term' = 'Continuing Professional Development (CPD) / Continuing Legal Education (CLE) Hours Completed Year-to-Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `data_privacy_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Certification Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `directory_listing_flag` SET TAGS ('dbx_business_glossary_term' = 'Directory Listing Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `ethical_wall_flag` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `firm_office_location_code` SET TAGS ('dbx_business_glossary_term' = 'Office Location Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `fte_classification` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Classification');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `fte_classification` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|secondment|of_counsel');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Attorney Full Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `full_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `full_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `industry_sector_focus` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector Focus');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `is_equity_partner` SET TAGS ('dbx_business_glossary_term' = 'Equity Partner Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `is_equity_partner` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `kyc_aml_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) / Anti-Money Laundering (AML) Certification Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `kyc_aml_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) / Anti-Money Laundering (AML) Certified Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `languages_spoken` SET TAGS ('dbx_business_glossary_term' = 'Languages Spoken');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `law_degree_type` SET TAGS ('dbx_business_glossary_term' = 'Law Degree Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `law_school` SET TAGS ('dbx_business_glossary_term' = 'Law School');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `law_school_graduation_year` SET TAGS ('dbx_business_glossary_term' = 'Law School Graduation Year');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `lpm_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Project Management (LPM) Certified Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `lpp_designation` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Designation');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `partnership_track_status` SET TAGS ('dbx_business_glossary_term' = 'Partnership Track Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `partnership_track_status` SET TAGS ('dbx_value_regex' = 'not_on_track|on_track|nominated|elected|deferred|withdrawn');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `partnership_track_status` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `ppp_pep_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Profit Per Partner / Profit Per Equity Partner (PPP/PEP) Participation Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `ppp_pep_participation_flag` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Attorney Preferred Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `preferred_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `preferred_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `primary_admission_date` SET TAGS ('dbx_business_glossary_term' = 'Primary Bar Admission Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `primary_practice_area` SET TAGS ('dbx_business_glossary_term' = 'Primary Practice Area');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `pro_bono_hours_target` SET TAGS ('dbx_business_glossary_term' = 'Pro Bono Hours Target');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `professional_biography` SET TAGS ('dbx_business_glossary_term' = 'Professional Biography');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `professional_title` SET TAGS ('dbx_business_glossary_term' = 'Professional Title');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `profile_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Attorney Profile Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|suspended|terminated');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `profile_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profile Last Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `secondary_practice_areas` SET TAGS ('dbx_business_glossary_term' = 'Secondary Practice Areas');
ALTER TABLE `legal_ecm_v1`.`workforce`.`attorney_profile` ALTER COLUMN `years_post_qualification` SET TAGS ('dbx_business_glossary_term' = 'Years Post-Qualification Experience (PQE)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `bar_admission_id` SET TAGS ('dbx_business_glossary_term' = 'Bar Admission ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `primary_bar_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Pro Hac Vice (PHV) Matter ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `to_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'To Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `admission_status` SET TAGS ('dbx_business_glossary_term' = 'Admission Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `admission_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|disbarred|retired|resigned');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `admission_type` SET TAGS ('dbx_business_glossary_term' = 'Admission Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `admission_type` SET TAGS ('dbx_value_regex' = 'examination|motion|reciprocity|pro_hac_vice|in_house_counsel');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `annual_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Fee Amount');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `bar_association_website` SET TAGS ('dbx_business_glossary_term' = 'Bar Association Website');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `bar_belongs_to_timekeeper` SET TAGS ('dbx_business_glossary_term' = 'Bar Belongs To Timekeeper');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `bar_number` SET TAGS ('dbx_business_glossary_term' = 'Bar Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `cle_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Continuing Legal Education (CLE) Compliance Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `cle_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_verification|exempt');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `cle_hours_completed_current_period` SET TAGS ('dbx_business_glossary_term' = 'Continuing Legal Education (CLE) Hours Completed Current Period');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `cle_hours_required_annual` SET TAGS ('dbx_business_glossary_term' = 'Continuing Legal Education (CLE) Hours Required Annual');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `disciplinary_action_count` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Count');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `disciplinary_standing` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Standing');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `disciplinary_standing` SET TAGS ('dbx_value_regex' = 'good_standing|under_investigation|probation|suspended|disbarred');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `eligibility_for_matter_staffing_flag` SET TAGS ('dbx_business_glossary_term' = 'Eligibility for Matter Staffing Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `fee_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `fee_payment_status` SET TAGS ('dbx_value_regex' = 'current|overdue|waived|exempt');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `governing_bar_association` SET TAGS ('dbx_business_glossary_term' = 'Governing Bar Association');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `last_disciplinary_action_date` SET TAGS ('dbx_business_glossary_term' = 'Last Disciplinary Action Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `last_fee_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Fee Payment Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `malpractice_insurance_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Malpractice Insurance Compliance Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `malpractice_insurance_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt|not_required');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `malpractice_insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Malpractice Insurance Required Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Bar Admission Notes');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `practice_restriction_description` SET TAGS ('dbx_business_glossary_term' = 'Practice Restriction Description');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `practice_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Practice Restriction Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `pro_hac_vice_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Pro Hac Vice (PHV) Expiration Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `reciprocity_source_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Reciprocity Source Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `renewal_frequency` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `renewal_frequency` SET TAGS ('dbx_value_regex' = 'annual|biennial|triennial|not_required');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `status_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `trust_account_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Certification Required Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `trust_account_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Compliance Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `trust_account_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt|not_applicable');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'manual_lookup|api_integration|attorney_self_certification|third_party_service');
ALTER TABLE `legal_ecm_v1`.`workforce`.`bar_admission` ALTER COLUMN `years_practice_at_admission` SET TAGS ('dbx_business_glossary_term' = 'Years of Practice at Admission');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `cle_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Continuing Legal Education (CLE) Requirement ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Attorney ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Cle Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `required_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `to_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'To Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `accredited_provider_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Accredited Provider Required Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `bias_inclusion_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Bias and Inclusion Continuing Legal Education (CLE) Hours Required');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `carryover_expiry_months` SET TAGS ('dbx_business_glossary_term' = 'Carry-Over Expiry Months');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `carryover_hours_allowed` SET TAGS ('dbx_business_glossary_term' = 'Carry-Over Hours Allowed');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `compliance_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Continuing Legal Education (CLE) Compliance Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|in_progress|exempt|pending_review');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `cpd_scheme_name` SET TAGS ('dbx_business_glossary_term' = 'Continuing Professional Development (CPD) Scheme Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Continuing Legal Education (CLE) Cycle Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `cycle_type` SET TAGS ('dbx_value_regex' = 'annual|biennial|triennial|rolling');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Effective Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `ethics_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Ethics Continuing Legal Education (CLE) Hours Required');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `exemption_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Exemption Eligible Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `exemption_type` SET TAGS ('dbx_business_glossary_term' = 'Continuing Legal Education (CLE) Exemption Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `exemption_type` SET TAGS ('dbx_value_regex' = 'inactive_status|judicial_appointment|hardship|military_service|retired|none');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `jurisdiction_name` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `late_filing_penalty_description` SET TAGS ('dbx_business_glossary_term' = 'Late Filing Penalty Description');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `new_attorney_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'New Attorney Requirement Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requirement Notes');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `online_hours_cap` SET TAGS ('dbx_business_glossary_term' = 'Online / Self-Study Continuing Legal Education (CLE) Hours Cap');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `practice_area_restriction` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Restriction');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `pro_bono_credit_hours_allowed` SET TAGS ('dbx_business_glossary_term' = 'Pro Bono Credit Hours Allowed');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `regulatory_body_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `regulatory_body_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `reporting_period_label` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Label');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `requirement_source_url` SET TAGS ('dbx_business_glossary_term' = 'Requirement Source URL');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `requirement_version` SET TAGS ('dbx_business_glossary_term' = 'Requirement Version');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `self_study_subject_restriction` SET TAGS ('dbx_business_glossary_term' = 'Self-Study Subject Restriction');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `substance_abuse_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Substance Abuse / Mental Health Continuing Legal Education (CLE) Hours Required');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Superseded Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `technology_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Technology Continuing Legal Education (CLE) Hours Required');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_requirement` ALTER COLUMN `total_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Total Continuing Legal Education (CLE) Hours Required');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `cle_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Continuing Legal Education (CLE) Completion ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `learning_item_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Item ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `cle_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Cle Requirement Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `primary_cle_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `recorded_by_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Cle Recorded By Timekeeper');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `satisfied_cle_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Cle Satisfies Requirement');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `to_cle_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'To Cle Requirement Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `to_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'To Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'CLE Accreditation Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'CLE Accreditation Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|pending|not_accredited|conditionally_accredited');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `accrediting_body` SET TAGS ('dbx_business_glossary_term' = 'CLE Accrediting Body');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `achieved_score` SET TAGS ('dbx_business_glossary_term' = 'CLE Assessment Achieved Score');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `bar_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Bar Confirmation Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'CLE Certificate Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'CLE Completion Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `completion_number` SET TAGS ('dbx_business_glossary_term' = 'CLE Completion Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'CLE Completion Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|failed|withdrawn|pending_approval');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'CLE Course Cost Amount');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `cost_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'CLE Course Cost Currency');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `course_category` SET TAGS ('dbx_business_glossary_term' = 'CLE Course Category');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `course_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'CLE Course Duration (Minutes)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `course_start_date` SET TAGS ('dbx_business_glossary_term' = 'CLE Course Start Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `course_title` SET TAGS ('dbx_business_glossary_term' = 'CLE Course Title');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `credit_hours` SET TAGS ('dbx_business_glossary_term' = 'CLE Credit Hours');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `delivery_format` SET TAGS ('dbx_business_glossary_term' = 'CLE Delivery Format');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `delivery_format` SET TAGS ('dbx_value_regex' = 'in_person|webinar|self_study|on_demand|blended|podcast');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `diversity_equity_inclusion_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Diversity, Equity and Inclusion (DEI) CLE Credit Hours');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `ethics_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Ethics CLE Credit Hours');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `is_diversity_equity_inclusion_credit` SET TAGS ('dbx_business_glossary_term' = 'Diversity, Equity and Inclusion (DEI) Credit Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `is_ethics_credit` SET TAGS ('dbx_business_glossary_term' = 'Ethics Credit Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `is_firm_sponsored` SET TAGS ('dbx_business_glossary_term' = 'Firm Sponsored Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory CLE Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `is_pro_bono_credit` SET TAGS ('dbx_business_glossary_term' = 'Pro Bono Credit Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `is_technology_credit` SET TAGS ('dbx_business_glossary_term' = 'Technology Credit Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'CLE Location City');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `location_country` SET TAGS ('dbx_business_glossary_term' = 'CLE Location Country');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'CLE Completion Notes');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `pass_score` SET TAGS ('dbx_business_glossary_term' = 'CLE Assessment Pass Score');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'CLE Practice Area');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `provider_code` SET TAGS ('dbx_business_glossary_term' = 'CLE Provider Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'CLE Provider Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `reported_to_bar_date` SET TAGS ('dbx_business_glossary_term' = 'CLE Reported to Bar Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `reporting_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'CLE Reporting Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'CLE Reporting Period');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `reporting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}(-[0-9]{4})?$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_SuccessFactors|manual_entry|provider_feed|bar_portal');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `technology_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Technology CLE Credit Hours');
ALTER TABLE `legal_ecm_v1`.`workforce`.`cle_completion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `billing_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Billing For Timekeeper');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `billing_approving_partner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Partner ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `billing_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `practice_group_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `prior_rate_billing_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Rate ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `rate_owner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `to_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'To Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `afa_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fee Arrangement (AFA) Arrangement Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `afa_arrangement_type` SET TAGS ('dbx_value_regex' = 'blended_rate|fixed_fee|capped_fee|contingency|success_fee|subscription');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rate Approved Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|milestone|on_demand|annual');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `billing_guideline_ref` SET TAGS ('dbx_business_glossary_term' = 'Billing Guideline Reference');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `client_agreed_date` SET TAGS ('dbx_business_glossary_term' = 'Client Agreed Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `firm_office_code` SET TAGS ('dbx_business_glossary_term' = 'Office Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `hourly_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate Amount');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `hourly_rate_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `is_client_approved` SET TAGS ('dbx_business_glossary_term' = 'Client Approved Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `is_default_rate` SET TAGS ('dbx_business_glossary_term' = 'Default Rate Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `is_pro_bono` SET TAGS ('dbx_business_glossary_term' = 'Pro Bono Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `ledes_rate_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Electronic Data Exchange Standard (LEDES) Rate Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `ledes_rate_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `matter_phase_code` SET TAGS ('dbx_business_glossary_term' = 'Matter Phase Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `rate_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Approval Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `rate_basis` SET TAGS ('dbx_value_regex' = 'hourly|fixed_fee|contingency|retainer|capped|blended');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `rate_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Cap Amount');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `rate_cap_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `rate_notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Notes');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `rate_review_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Review Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `rate_schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'active|pending_approval|approved|superseded|expired|rejected');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'standard|client_negotiated|matter_specific|afa_blended|volume_discount|pro_bono');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `rate_version` SET TAGS ('dbx_business_glossary_term' = 'Rate Version');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `source_system_rate_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Rate ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `standard_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard Rate Amount');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `standard_rate_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `timekeeper_class` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Class');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `timekeeper_class` SET TAGS ('dbx_value_regex' = 'partner|associate|of_counsel|paralegal|legal_assistant|staff');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `wip_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Recognition Method');
ALTER TABLE `legal_ecm_v1`.`workforce`.`billing_rate` ALTER COLUMN `wip_recognition_method` SET TAGS ('dbx_value_regex' = 'time_and_rate|fixed_fee_milestone|contingent|deferred');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `practice_group_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Group ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `practice_group_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `parent_group_practice_group_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Practice Group ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Practice Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Taxonomy Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `afa_eligible` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fee Arrangement (AFA) Eligible');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `approved_fte_count` SET TAGS ('dbx_business_glossary_term' = 'Approved Full-Time Equivalent (FTE) Count');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `approved_fte_count` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `associate_count` SET TAGS ('dbx_business_glossary_term' = 'Associate Count');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `billing_rate_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Schedule Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `billing_rate_schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{2,20}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `billing_rate_schedule_code` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `cle_requirement_hours` SET TAGS ('dbx_business_glossary_term' = 'Continuing Legal Education (CLE) Requirement Hours');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `conflict_check_scope` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Scope');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `conflict_check_scope` SET TAGS ('dbx_value_regex' = 'firm_wide|group_only|office_only');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,20}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `current_headcount` SET TAGS ('dbx_business_glossary_term' = 'Current Headcount');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `department_type` SET TAGS ('dbx_business_glossary_term' = 'Department Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `department_type` SET TAGS ('dbx_value_regex' = 'fee_earning|business_services|hybrid');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `group_code` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{2,20}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `group_name` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `headcount_budget` SET TAGS ('dbx_business_glossary_term' = 'Headcount Budget');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `headcount_budget` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `jurisdiction_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `jurisdiction_primary` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `lpp_classification` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Classification');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `lpp_classification` SET TAGS ('dbx_value_regex' = 'privileged|non_privileged|mixed');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `matter_count_active` SET TAGS ('dbx_business_glossary_term' = 'Active Matter Count');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Notes');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `paralegal_count` SET TAGS ('dbx_business_glossary_term' = 'Paralegal Count');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `partner_count` SET TAGS ('dbx_business_glossary_term' = 'Partner Count');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `performance_review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Cycle');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `performance_review_cycle` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `practice_group_status` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `practice_group_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|dissolved|merged');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `recruitment_open_positions` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Open Positions');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `region_scope` SET TAGS ('dbx_business_glossary_term' = 'Region Scope');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `revenue_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Target Amount');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `revenue_target_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `revenue_target_currency` SET TAGS ('dbx_business_glossary_term' = 'Revenue Target Currency');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `revenue_target_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `revenue_target_fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Revenue Target Fiscal Year');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Short Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `short_name` SET TAGS ('dbx_value_regex' = '^.{1,50}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9-_]{1,50}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `succession_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `succession_plan_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|approved|under_review');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `succession_plan_status` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `timekeeper_class_scope` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Class Scope');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `utbms_task_code_prefix` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code Prefix');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `utbms_task_code_prefix` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2,4}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `wip_write_off_authority_limit` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Write-Off Authority Limit');
ALTER TABLE `legal_ecm_v1`.`workforce`.`practice_group` ALTER COLUMN `wip_write_off_authority_limit` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `matter_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Assignment ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Budget ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `practice_group_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `primary_matter_team_lead_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Team Lead ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `tertiary_matter_supervising_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Supervising Timekeeper ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `to_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'To Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `actual_hours_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours to Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `afa_flag` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fee Arrangement (AFA) Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `afa_type` SET TAGS ('dbx_business_glossary_term' = 'Alternative Fee Arrangement (AFA) Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `afa_type` SET TAGS ('dbx_value_regex' = 'fixed_fee|capped_fee|blended_rate|contingency|success_fee|retainer');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `assignment_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|completed|withdrawn');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `assignment_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `billing_attorney_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Attorney Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `billing_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Authorization Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `billing_rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Currency');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `billing_rate_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `billing_rate_override` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Override');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `billing_rate_override` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `budgeted_fees` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Fees');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `budgeted_fees` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `budgeted_hours` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Hours');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `conflict_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict Clearance Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `conflict_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict Clearance Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `cpd_hours_earned` SET TAGS ('dbx_business_glossary_term' = 'Continuing Professional Development (CPD) Hours Earned');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `cross_border_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Assignment Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `estimated_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `ethical_wall_flag` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `lpm_responsibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Project Management (LPM) Responsibility Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `matter_role_sequence` SET TAGS ('dbx_business_glossary_term' = 'Matter Role Sequence');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `originating_attorney_flag` SET TAGS ('dbx_business_glossary_term' = 'Originating Attorney Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `pro_bono_committed_hours` SET TAGS ('dbx_business_glossary_term' = 'Pro Bono Committed Hours');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `pro_bono_delivered_hours` SET TAGS ('dbx_business_glossary_term' = 'Pro Bono Delivered Hours');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `pro_bono_flag` SET TAGS ('dbx_business_glossary_term' = 'Pro Bono Matter Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `responsible_attorney_flag` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `secondment_flag` SET TAGS ('dbx_business_glossary_term' = 'Secondment Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'elite_3e|sap_successfactors|aderant_expert');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `supervision_level` SET TAGS ('dbx_business_glossary_term' = 'Supervision Level');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `supervision_level` SET TAGS ('dbx_value_regex' = 'independent|supervised|co_supervised');
ALTER TABLE `legal_ecm_v1`.`workforce`.`matter_assignment` ALTER COLUMN `wip_hours_unbilled` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Unbilled Hours');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `calibration_session_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Session ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `practice_group_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewed_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `to_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'To Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `billable_hours_achieved` SET TAGS ('dbx_business_glossary_term' = 'Billable Hours Achieved');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `billable_hours_achieved` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `billable_hours_target` SET TAGS ('dbx_business_glossary_term' = 'Billable Hours Target');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `billable_hours_target` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `business_development_hours` SET TAGS ('dbx_business_glossary_term' = 'Business Development Hours');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `business_development_hours` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `client_feedback_score` SET TAGS ('dbx_business_glossary_term' = 'Client Feedback Score');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `client_feedback_score` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `collection_rate` SET TAGS ('dbx_business_glossary_term' = 'Collection Rate (Percent)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `collection_rate` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `compensation_adjustment_recommended` SET TAGS ('dbx_business_glossary_term' = 'Compensation Adjustment Recommended Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `compensation_adjustment_recommended` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `cpd_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Continuing Professional Development (CPD) Hours Completed');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `cpd_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Continuing Professional Development (CPD) Hours Required');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `development_areas_narrative` SET TAGS ('dbx_business_glossary_term' = 'Development Areas Narrative');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `development_areas_narrative` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgement` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `fte_status` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `fte_status` SET TAGS ('dbx_value_regex' = 'full_time|part_time|secondment|contract');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `leadership_rating` SET TAGS ('dbx_business_glossary_term' = 'Leadership and Development Rating');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `leadership_rating` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `matter_count` SET TAGS ('dbx_business_glossary_term' = 'Matter Count');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `origination_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Origination Credit Amount');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `origination_credit_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating_label` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating Label');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating_label` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating_label` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `partnership_track_eligible` SET TAGS ('dbx_business_glossary_term' = 'Partnership Track Eligible Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `partnership_track_eligible` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_improvement_plan_required` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Required Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_improvement_plan_required` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `pro_bono_hours_delivered` SET TAGS ('dbx_business_glossary_term' = 'Pro Bono Hours Delivered');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `pro_bono_hours_target` SET TAGS ('dbx_business_glossary_term' = 'Pro Bono Hours Target');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `promotion_recommended` SET TAGS ('dbx_business_glossary_term' = 'Promotion Recommended Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `promotion_recommended` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `realization_rate` SET TAGS ('dbx_business_glossary_term' = 'Realization Rate (Percent)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `realization_rate` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `review_cycle_year` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Year');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|pending_approval|completed|cancelled');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|mid_year|probationary|promotion|exit');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `self_assessment_narrative` SET TAGS ('dbx_business_glossary_term' = 'Self-Assessment Narrative');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `self_assessment_narrative` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `seniority_level` SET TAGS ('dbx_business_glossary_term' = 'Seniority Level');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `seniority_level` SET TAGS ('dbx_value_regex' = 'partner|counsel|senior_associate|associate|paralegal|staff');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `source_system_review_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Review ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `strengths_narrative` SET TAGS ('dbx_business_glossary_term' = 'Strengths Narrative');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `strengths_narrative` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Submitted Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `utilization_rate_actual` SET TAGS ('dbx_business_glossary_term' = 'Utilization Rate Actual (Percent)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `utilization_rate_actual` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `utilization_rate_target` SET TAGS ('dbx_business_glossary_term' = 'Utilization Rate Target (Percent)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`performance_review` ALTER COLUMN `utilization_rate_target` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `compensation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Record ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `compensation_record_id` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `compensation_record_id` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `practice_group_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `record_owner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `to_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'To Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Compensation Approval Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Compensation Approval Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|withdrawn');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `base_salary` SET TAGS ('dbx_business_glossary_term' = 'Base Salary');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `base_salary` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `base_salary` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `benefits_tier_code` SET TAGS ('dbx_business_glossary_term' = 'Benefits Package Tier Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `bonus_actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Actual Payout Amount');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `bonus_actual_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `bonus_actual_amount` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `bonus_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Target Amount');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `bonus_target_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `bonus_target_amount` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `capital_contribution` SET TAGS ('dbx_business_glossary_term' = 'Capital Contribution');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `capital_contribution` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `capital_contribution` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `compensation_review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Compensation Review Cycle');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `compensation_review_cycle` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|off_cycle');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `compensation_review_cycle` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `compensation_review_cycle` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `compensation_type` SET TAGS ('dbx_value_regex' = 'lockstep|merit_based|equity_partner|non_equity_partner|staff');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `compensation_type` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `compensation_type` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `compensation_year` SET TAGS ('dbx_business_glossary_term' = 'Compensation Year');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `compensation_year` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `compensation_year` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `deferred_compensation` SET TAGS ('dbx_business_glossary_term' = 'Deferred Compensation Amount');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `deferred_compensation` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `deferred_compensation` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `draw_amount` SET TAGS ('dbx_business_glossary_term' = 'Partner Draw Amount');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `draw_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `draw_amount` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Compensation Effective Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `equity_partner_points` SET TAGS ('dbx_business_glossary_term' = 'Equity Partner Points Value');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `equity_partner_points` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `equity_partner_tier_name` SET TAGS ('dbx_business_glossary_term' = 'Equity Partner Tier Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `equity_partner_tier_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Compensation Expiry Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `external_record_ref` SET TAGS ('dbx_business_glossary_term' = 'External Compensation Record Reference');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `external_record_ref` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `firm_office_code` SET TAGS ('dbx_business_glossary_term' = 'Office Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `fte_fraction` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Fraction');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `fte_status` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `fte_status` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|secondment');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `is_equity_partner` SET TAGS ('dbx_business_glossary_term' = 'Is Equity Partner Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `lockstep_year` SET TAGS ('dbx_business_glossary_term' = 'Lockstep Year');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `merit_increase_pct` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Percentage');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `merit_increase_pct` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `origination_bonus` SET TAGS ('dbx_business_glossary_term' = 'Origination Bonus');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `origination_bonus` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `origination_bonus` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `pay_band_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Band Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `pay_band_max` SET TAGS ('dbx_business_glossary_term' = 'Pay Band Maximum');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `pay_band_max` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `pay_band_min` SET TAGS ('dbx_business_glossary_term' = 'Pay Band Minimum');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `pay_band_min` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `pay_equity_flag` SET TAGS ('dbx_business_glossary_term' = 'Pay Equity Review Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `profit_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Profit Share Percentage');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `profit_share_pct` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `retirement_contribution_pct` SET TAGS ('dbx_business_glossary_term' = 'Retirement Contribution Percentage');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `retirement_contribution_pct` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `timekeeper_grade` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Grade');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `total_cash_compensation` SET TAGS ('dbx_business_glossary_term' = 'Total Cash Compensation');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `total_cash_compensation` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `total_cash_compensation` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Requisition ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `practice_group_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Requisition For Practice Group');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `primary_recruitment_practice_group_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Practice Group Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `primary_recruitment_practice_group_id` SET TAGS ('dbx_dbx_internal' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `requesting_practice_group_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `succession_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `target_practice_group_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Requisition To Practice Group');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `approved_headcount` SET TAGS ('dbx_business_glossary_term' = 'Approved Headcount');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `background_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `bar_admission_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Bar Admission Required Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `bar_jurisdiction_required` SET TAGS ('dbx_business_glossary_term' = 'Required Bar Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Close Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `close_reason` SET TAGS ('dbx_business_glossary_term' = 'Requisition Close Reason');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `close_reason` SET TAGS ('dbx_value_regex' = 'filled|cancelled|withdrawn|headcount_frozen|restructured');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `conflicts_prescreening_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflicts Pre-Screening Required Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `current_pipeline_count` SET TAGS ('dbx_business_glossary_term' = 'Current Pipeline Candidate Count');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|secondment|summer_associate');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `firm_office_country_code` SET TAGS ('dbx_business_glossary_term' = 'Office Country Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `firm_office_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `firm_office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `interview_stage_count` SET TAGS ('dbx_business_glossary_term' = 'Interview Stage Count');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `job_description_url` SET TAGS ('dbx_business_glossary_term' = 'Job Description URL');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `job_description_url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `job_posting_date` SET TAGS ('dbx_business_glossary_term' = 'Job Posting Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `kyc_aml_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client / Anti-Money Laundering Check Required Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `law_school_target_tier` SET TAGS ('dbx_business_glossary_term' = 'Law School Target Tier');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `law_school_target_tier` SET TAGS ('dbx_value_regex' = 't14|top_25|top_50|any_accredited|not_applicable');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `offer_accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Accepted Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `offer_extended_flag` SET TAGS ('dbx_business_glossary_term' = 'Offer Extended Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `offer_outcome` SET TAGS ('dbx_business_glossary_term' = 'Offer Outcome');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `offer_outcome` SET TAGS ('dbx_value_regex' = 'accepted|declined|rescinded|pending|expired');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Open Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `position_title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'attorney|paralegal|legal_secretary|staff|partner|of_counsel');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `replacement_or_new_flag` SET TAGS ('dbx_business_glossary_term' = 'Replacement or New Headcount Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `replacement_or_new_flag` SET TAGS ('dbx_value_regex' = 'replacement|new_headcount|backfill');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_notes` SET TAGS ('dbx_business_glossary_term' = 'Requisition Notes');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{6,10}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_priority` SET TAGS ('dbx_business_glossary_term' = 'Requisition Priority');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_value_regex' = 'draft|open|on_hold|filled|cancelled|closed');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_band_max` SET TAGS ('dbx_business_glossary_term' = 'Salary Band Maximum');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_band_max` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_band_min` SET TAGS ('dbx_business_glossary_term' = 'Salary Band Minimum');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_band_min` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `seniority_level` SET TAGS ('dbx_business_glossary_term' = 'Seniority Level');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `sourcing_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Agency Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `sourcing_channel` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Channel');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `sourcing_channel` SET TAGS ('dbx_value_regex' = 'lateral_hire|law_school_campus|alsp|referral|job_board|search_firm');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `years_experience_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years of Experience Required');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `leave_record_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Record ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `primary_leave_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `tertiary_leave_covering_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Covering Timekeeper ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `to_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'To Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `actual_return_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Approval Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `approved_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Approved Leave Duration (Days)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `approved_end_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Leave End Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `approved_start_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Leave Start Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `bar_compliance_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Bar Compliance Risk Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `billable_hours_target_impact` SET TAGS ('dbx_business_glossary_term' = 'Billable Hours Target Impact');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Cancellation Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `coverage_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Coverage Arrangement');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `coverage_arrangement` SET TAGS ('dbx_value_regex' = 'none|internal_cover|external_cover|matter_reassignment|shared_cover');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `cpd_impact_hours` SET TAGS ('dbx_business_glossary_term' = 'Continuing Professional Development (CPD) Impact Hours');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `employee_notes` SET TAGS ('dbx_business_glossary_term' = 'Employee Notes');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `employee_notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `hr_notes` SET TAGS ('dbx_business_glossary_term' = 'HR Notes');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `hr_notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `is_intermittent` SET TAGS ('dbx_business_glossary_term' = 'Is Intermittent Leave Indicator');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `is_paid` SET TAGS ('dbx_business_glossary_term' = 'Is Paid Leave Indicator');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `is_phased_return` SET TAGS ('dbx_business_glossary_term' = 'Is Phased Return Indicator');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `leave_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance After (Days)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `leave_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance Before (Days)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `leave_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Leave Reason Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `leave_reason_code` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `leave_request_number` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `leave_request_number` SET TAGS ('dbx_value_regex' = '^LR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `leave_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `leave_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled|active|completed');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `leave_type` SET TAGS ('dbx_value_regex' = 'annual|parental|medical|sabbatical|unpaid|bereavement');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `matter_impact_assessed` SET TAGS ('dbx_business_glossary_term' = 'Matter Impact Assessed Indicator');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Received Indicator');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `medical_certification_received` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Required Indicator');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `payroll_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payroll Adjustment Amount');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `payroll_adjustment_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `payroll_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Adjustment Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `phased_return_end_date` SET TAGS ('dbx_business_glossary_term' = 'Phased Return End Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `phased_return_fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Phased Return Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `regulatory_leave_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Leave Category');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Leave Rejection Reason');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`leave_record` ALTER COLUMN `working_days_absent` SET TAGS ('dbx_business_glossary_term' = 'Working Days Absent');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `succession_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `practice_group_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Successor Timekeeper ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `subject_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `tertiary_succession_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Partner ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `to_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'To Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `bar_admission_gap` SET TAGS ('dbx_business_glossary_term' = 'Bar Admission Gap Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `cle_gap_identified` SET TAGS ('dbx_business_glossary_term' = 'Continuing Legal Education (CLE) Gap Identified Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `client_transition_risk` SET TAGS ('dbx_business_glossary_term' = 'Client Relationship Transition Risk');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `client_transition_risk` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|not_assessed');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `development_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Development Actions Required');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `estimated_vacancy_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Vacancy Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `external_candidate_considered` SET TAGS ('dbx_business_glossary_term' = 'External Candidate Considered Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `firm_office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `incumbent_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Incumbent Performance Rating');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `incumbent_performance_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|below_expectations|unsatisfactory');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `incumbent_performance_rating` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Confidentiality Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `is_emergency_plan` SET TAGS ('dbx_business_glossary_term' = 'Emergency Succession Plan Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `key_client_revenue_at_risk` SET TAGS ('dbx_business_glossary_term' = 'Key Client Revenue at Risk');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `key_client_revenue_at_risk` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `knowledge_transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Transfer Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `knowledge_transfer_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|substantially_complete|complete');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Succession Plan Review Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `lateral_hire_target_seniority` SET TAGS ('dbx_business_glossary_term' = 'Lateral Hire Target Seniority Level');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `lateral_hire_target_seniority` SET TAGS ('dbx_value_regex' = 'partner|senior_associate|of_counsel|not_applicable');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `lpm_training_required` SET TAGS ('dbx_business_glossary_term' = 'Legal Project Management (LPM) Training Required Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `mentoring_assignment` SET TAGS ('dbx_business_glossary_term' = 'Mentoring Assignment Description');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `nine_box_rating` SET TAGS ('dbx_business_glossary_term' = 'Nine-Box Talent Grid Rating');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `nine_box_rating` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `plan_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Effective Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `plan_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Expiry Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `plan_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Reference Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `plan_review_date` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Review Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|on_hold|closed|archived');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `primary_successor_readiness` SET TAGS ('dbx_business_glossary_term' = 'Primary Successor Readiness Assessment');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `primary_successor_readiness` SET TAGS ('dbx_value_regex' = 'ready_now|ready_1_year|ready_2_3_years|ready_4_5_years');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `readiness_timeline` SET TAGS ('dbx_business_glossary_term' = 'Successor Readiness Timeline');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `readiness_timeline` SET TAGS ('dbx_value_regex' = 'ready_now|ready_1_year|ready_2_3_years|ready_4_5_years|not_yet_identified');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `retirement_eligibility_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Eligibility Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `retirement_eligibility_date` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Succession Risk Category');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'flight_risk|retirement_horizon|health_risk|voluntary_departure|unknown');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Succession Risk Level');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `role_title` SET TAGS ('dbx_business_glossary_term' = 'Key Role Title');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Key Role Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `role_type` SET TAGS ('dbx_value_regex' = 'equity_partner|non_equity_partner|practice_group_leader|managing_partner|of_counsel|senior_associate');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `secondary_successor_readiness` SET TAGS ('dbx_business_glossary_term' = 'Secondary Successor Readiness Assessment');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `secondary_successor_readiness` SET TAGS ('dbx_value_regex' = 'ready_now|ready_1_year|ready_2_3_years|ready_4_5_years');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `succession_notes` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Notes');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `succession_notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `successor_count` SET TAGS ('dbx_business_glossary_term' = 'Total Successor Candidate Count');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `talent_pool_segment` SET TAGS ('dbx_business_glossary_term' = 'Talent Pool Segment');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `talent_pool_segment` SET TAGS ('dbx_value_regex' = 'high_potential|high_performer|key_expert|emerging_leader|not_classified');
ALTER TABLE `legal_ecm_v1`.`workforce`.`succession_plan` ALTER COLUMN `years_in_role` SET TAGS ('dbx_business_glossary_term' = 'Years in Key Role');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `secondment_id` SET TAGS ('dbx_business_glossary_term' = 'Secondment ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Secondment Assigns Timekeeper');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Matter ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `primary_secondment_supervising_partner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Supervising Partner ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `seconded_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `tertiary_secondment_approved_by_employee_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `to_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'To Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Secondment Actual End Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `agreement_date` SET TAGS ('dbx_business_glossary_term' = 'Secondment Agreement Execution Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Secondment Approval Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `billing_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `billing_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `billing_rate_during_secondment` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate During Secondment');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `billing_rate_during_secondment` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|cleared|conflict_identified|waived');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `cost_allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `cost_allocation_type` SET TAGS ('dbx_value_regex' = 'client_funded|firm_funded|split|third_party_funded');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `cost_split_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Split Percentage');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `cost_split_percentage` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `cpd_hours_credited` SET TAGS ('dbx_business_glossary_term' = 'Continuing Professional Development (CPD) Hours Credited');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `data_protection_agreement_signed` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Agreement Signed');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `early_termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Reason');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Secondment End Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `ethical_wall_required` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Required');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `host_bar_admission_required` SET TAGS ('dbx_business_glossary_term' = 'Host Jurisdiction Bar Admission Required');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `host_bar_admission_status` SET TAGS ('dbx_business_glossary_term' = 'Host Jurisdiction Bar Admission Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `host_bar_admission_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|obtained|waived|expired');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `host_city` SET TAGS ('dbx_business_glossary_term' = 'Host City');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `host_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Host Contact Email Address');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `host_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `host_contact_email` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `host_contact_email` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `host_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Host Contact Full Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `host_contact_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `host_contact_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `host_country_code` SET TAGS ('dbx_business_glossary_term' = 'Host Country Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `host_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `host_organisation_name` SET TAGS ('dbx_business_glossary_term' = 'Host Organisation Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `host_organisation_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `host_organisation_type` SET TAGS ('dbx_business_glossary_term' = 'Host Organisation Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `host_organisation_type` SET TAGS ('dbx_value_regex' = 'client|firm_office|government_body|court_tribunal|non_profit|international_organisation');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Secondment');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `lpp_risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Risk Assessment');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `lpp_risk_assessment` SET TAGS ('dbx_value_regex' = 'low|medium|high|not_assessed');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `lpp_risk_assessment` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `objectives` SET TAGS ('dbx_business_glossary_term' = 'Secondment Objectives');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `performance_review_completed` SET TAGS ('dbx_business_glossary_term' = 'Secondment Performance Review Completed');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `performance_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Secondment Performance Review Due Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Secondment Reference Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `reference` SET TAGS ('dbx_value_regex' = '^SEC-[0-9]{4}-[0-9]{5}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `return_to_role_plan` SET TAGS ('dbx_business_glossary_term' = 'Return-to-Role Plan');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `secondment_status` SET TAGS ('dbx_business_glossary_term' = 'Secondment Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `secondment_type` SET TAGS ('dbx_business_glossary_term' = 'Secondment Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `secondment_type` SET TAGS ('dbx_value_regex' = 'client_secondment|inter_office|international_rotation|pro_bono|government_secondment|judicial_clerkship');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_SF|ELITE_3E|MANUAL|ADERANT');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Secondment Start Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `work_permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Expiry Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `work_permit_reference` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Reference Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `work_permit_reference` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `work_permit_reference` SET TAGS ('dbx_dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`secondment` ALTER COLUMN `work_permit_required` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Required');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `disciplinary_record_id` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Record ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `primary_disciplinary_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `tertiary_disciplinary_hr_case_owner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'HR Case Owner ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `to_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'To Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|partially_upheld|dismissed|pending');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `appeal_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Resolution Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `appeal_resolution_date` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `bar_referral_body` SET TAGS ('dbx_business_glossary_term' = 'Bar Referral Body');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `bar_referral_body` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `bar_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Bar Referral Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `bar_referral_date` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `incident_category` SET TAGS ('dbx_business_glossary_term' = 'Incident Category');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `incident_category` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `incident_date` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `incident_description` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'conduct|performance|ethics|regulatory|financial|harassment');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `incident_type` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `investigation_close_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Close Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `investigation_close_date` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'pending|open|under_review|concluded|closed|appealed');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `investigation_status` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `is_appeal_filed` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `is_appeal_filed` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `is_bar_referral` SET TAGS ('dbx_business_glossary_term' = 'Bar Referral Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `is_bar_referral` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `is_lpp_protected` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Protected Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `is_lpp_protected` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `is_paid_suspension` SET TAGS ('dbx_business_glossary_term' = 'Paid Suspension Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `is_paid_suspension` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `is_pii_involved` SET TAGS ('dbx_business_glossary_term' = 'Personally Identifiable Information (PII) Involved Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `is_pii_involved` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `is_regulatory_notification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `is_regulatory_notification` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Outcome');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `outcome` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `outcome_date` SET TAGS ('dbx_business_glossary_term' = 'Outcome Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `outcome_date` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `record_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Record Reference Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `record_reference_number` SET TAGS ('dbx_value_regex' = '^DR-[0-9]{4}-[0-9]{5}$');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `record_reference_number` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `record_retention_expiry` SET TAGS ('dbx_business_glossary_term' = 'Record Retention Expiry Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `record_retention_expiry` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `regulatory_body_notified` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Notified');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `regulatory_body_notified` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `related_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Related Disciplinary Record ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `related_record_reference` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `remediation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completion Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `remediation_completion_date` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `remediation_description` SET TAGS ('dbx_business_glossary_term' = 'Remediation Description');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `remediation_description` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `remediation_required` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `remediation_required` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `reported_date` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `resolution_date` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `severity_level` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `witness_count` SET TAGS ('dbx_business_glossary_term' = 'Witness Count');
ALTER TABLE `legal_ecm_v1`.`workforce`.`disciplinary_record` ALTER COLUMN `witness_count` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `diversity_record_id` SET TAGS ('dbx_business_glossary_term' = 'Diversity Record Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `prior_diversity_record_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Diversity Record Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `prior_diversity_record_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `subject_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `to_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'To Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `access_restricted_to_role` SET TAGS ('dbx_business_glossary_term' = 'Access Restricted to Role');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `anonymization_flag` SET TAGS ('dbx_business_glossary_term' = 'Anonymization Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `caregiver_status` SET TAGS ('dbx_business_glossary_term' = 'Caregiver Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `caregiver_status` SET TAGS ('dbx_value_regex' = 'yes|no|prefer_not_to_say');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `caregiver_status` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `client_diversity_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Client Diversity Survey Submission Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `client_diversity_survey_response` SET TAGS ('dbx_business_glossary_term' = 'Client Diversity Survey Response Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `client_diversity_survey_response` SET TAGS ('dbx_value_regex' = 'submitted|not_submitted|declined|pending');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Diversity Data Source');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'self_identification|hr_import|recruitment|third_party_survey');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `disability_description` SET TAGS ('dbx_business_glossary_term' = 'Disability Description');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `disability_description` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `disability_description` SET TAGS ('dbx_dbx_pii_health' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `disability_status` SET TAGS ('dbx_value_regex' = 'yes|no|prefer_not_to_say');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `disability_status` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `disclosure_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Consent Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `disclosure_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Consent Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Ethnicity');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `ethnicity` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `first_generation_professional` SET TAGS ('dbx_business_glossary_term' = 'First Generation Professional Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `first_generation_professional` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `gender_identity` SET TAGS ('dbx_business_glossary_term' = 'Gender Identity');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `gender_identity` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `mansfield_rule_category` SET TAGS ('dbx_business_glossary_term' = 'Mansfield Rule Category');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `mansfield_rule_eligible` SET TAGS ('dbx_business_glossary_term' = 'Mansfield Rule Eligible Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Diversity Record Notes');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `record_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Diversity Record Reference Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Diversity Record Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_review|archived');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `religion_or_belief` SET TAGS ('dbx_business_glossary_term' = 'Religion or Belief');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `religion_or_belief` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Diversity Reporting Period');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `self_identification_date` SET TAGS ('dbx_business_glossary_term' = 'Self-Identification Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `sexual_orientation` SET TAGS ('dbx_business_glossary_term' = 'Sexual Orientation');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `sexual_orientation` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `socioeconomic_background` SET TAGS ('dbx_business_glossary_term' = 'Socioeconomic Background');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `socioeconomic_background` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `sra_diversity_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Solicitors Regulation Authority (SRA) Diversity Reporting Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `veteran_status` SET TAGS ('dbx_business_glossary_term' = 'Veteran Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `veteran_status` SET TAGS ('dbx_value_regex' = 'yes|no|prefer_not_to_say');
ALTER TABLE `legal_ecm_v1`.`workforce`.`diversity_record` ALTER COLUMN `veteran_status` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rfp_team_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rfp_team_assignment` ALTER COLUMN `rfp_team_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'RFP Team Assignment ID');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rfp_team_assignment` ALTER COLUMN `rfp_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Rfp Team Assignment - Rfp Submission Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rfp_team_assignment` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Rfp Team Assignment - Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rfp_team_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rfp_team_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rfp_team_assignment` ALTER COLUMN `bio_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Bio Included Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rfp_team_assignment` ALTER COLUMN `conflict_cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict Cleared Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rfp_team_assignment` ALTER COLUMN `conflict_cleared_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict Cleared Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rfp_team_assignment` ALTER COLUMN `contribution_hours` SET TAGS ('dbx_business_glossary_term' = 'Contribution Hours');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rfp_team_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rfp_team_assignment` ALTER COLUMN `pitch_team_members` SET TAGS ('dbx_business_glossary_term' = 'Pitch Team Members');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rfp_team_assignment` ALTER COLUMN `presentation_section_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Presentation Section Responsibility');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rfp_team_assignment` ALTER COLUMN `rate_quoted` SET TAGS ('dbx_business_glossary_term' = 'Rate Quoted');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rfp_team_assignment` ALTER COLUMN `rate_quoted_currency` SET TAGS ('dbx_business_glossary_term' = 'Rate Quoted Currency');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rfp_team_assignment` ALTER COLUMN `team_role` SET TAGS ('dbx_business_glossary_term' = 'Team Role');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rfp_team_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `user_id` SET TAGS ('dbx_business_glossary_term' = 'User Identifier');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `primary_manager_user_id` SET TAGS ('dbx_business_glossary_term' = 'Manager User Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `primary_manager_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `primary_manager_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `tertiary_created_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `tertiary_created_by_user_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `tertiary_created_by_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `tertiary_created_by_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `bar_admission_count` SET TAGS ('dbx_business_glossary_term' = 'Bar Admission Count');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `cle_credits_completed_current_year` SET TAGS ('dbx_business_glossary_term' = 'Cle Credits Completed Current Year');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `cle_credits_required_annual` SET TAGS ('dbx_business_glossary_term' = 'Cle Credits Required Annual');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `email_address` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `email_address` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `firm_office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `first_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `first_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `full_time_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Full Time Equivalent');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `last_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `last_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `middle_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `middle_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `mobile_number` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `mobile_number` SET TAGS ('dbx_dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `partner_tier` SET TAGS ('dbx_business_glossary_term' = 'Partner Tier');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `partner_tier` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `performance_rating` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `phone_number` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `phone_number` SET TAGS ('dbx_dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `preferred_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `preferred_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `primary_bar_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Primary Bar Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `standard_hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Standard Hourly Rate');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `standard_hourly_rate` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `user_type` SET TAGS ('dbx_business_glossary_term' = 'User Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `username` SET TAGS ('dbx_business_glossary_term' = 'Username');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `utilization_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Utilization Target Percentage');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `work_address_city` SET TAGS ('dbx_business_glossary_term' = 'Work Address City');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `work_address_city` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `work_address_city` SET TAGS ('dbx_dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `work_address_country_code` SET TAGS ('dbx_business_glossary_term' = 'Work Address Country Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `work_address_country_code` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `work_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Work Address Line1');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `work_address_line1` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `work_address_line1` SET TAGS ('dbx_dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `work_address_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Work Address Postal Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `work_address_postal_code` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `work_address_postal_code` SET TAGS ('dbx_dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `work_address_state_province` SET TAGS ('dbx_business_glossary_term' = 'Work Address State Province');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `work_address_state_province` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`user` ALTER COLUMN `work_address_state_province` SET TAGS ('dbx_dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `lateral_candidate_id` SET TAGS ('dbx_business_glossary_term' = 'Lateral Candidate Identifier');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiting Partner Timekeeper Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Requisition Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `referred_by_lateral_candidate_id` SET TAGS ('dbx_business_glossary_term' = 'Referred By Lateral Candidate Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `referred_by_lateral_candidate_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `bar_admission_jurisdictions` SET TAGS ('dbx_business_glossary_term' = 'Bar Admission Jurisdictions');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `candidate_number` SET TAGS ('dbx_business_glossary_term' = 'Candidate Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `candidate_status` SET TAGS ('dbx_business_glossary_term' = 'Candidate Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `candidate_type` SET TAGS ('dbx_business_glossary_term' = 'Candidate Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `conflict_check_status` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `current_compensation_usd` SET TAGS ('dbx_business_glossary_term' = 'Current Compensation Usd');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `current_compensation_usd` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `current_compensation_usd` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `current_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Current Firm Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `current_firm_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `current_title` SET TAGS ('dbx_business_glossary_term' = 'Current Title');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `current_title` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `expected_start_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Start Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `first_contact_date` SET TAGS ('dbx_business_glossary_term' = 'First Contact Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `interview_date` SET TAGS ('dbx_business_glossary_term' = 'Interview Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `law_school` SET TAGS ('dbx_business_glossary_term' = 'Law School');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `law_school_graduation_year` SET TAGS ('dbx_business_glossary_term' = 'Law School Graduation Year');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `middle_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `middle_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `mobile_number` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `mobile_number` SET TAGS ('dbx_dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `offer_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Acceptance Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `portable_book_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Portable Book Value Usd');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `portable_book_value_usd` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `preferred_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `preferred_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `primary_bar_admission_year` SET TAGS ('dbx_business_glossary_term' = 'Primary Bar Admission Year');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `proposed_compensation_usd` SET TAGS ('dbx_business_glossary_term' = 'Proposed Compensation Usd');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `proposed_compensation_usd` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `proposed_compensation_usd` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `recruiter_name` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `secondary_practice_area` SET TAGS ('dbx_business_glossary_term' = 'Secondary Practice Area');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `signing_bonus_usd` SET TAGS ('dbx_business_glossary_term' = 'Signing Bonus Usd');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `signing_bonus_usd` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `signing_bonus_usd` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `undergraduate_institution` SET TAGS ('dbx_business_glossary_term' = 'Undergraduate Institution');
ALTER TABLE `legal_ecm_v1`.`workforce`.`lateral_candidate` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years Of Experience');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `learning_item_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Item Identifier');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `prerequisite_learning_item_id` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Learning Item Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `prerequisite_learning_item_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `assessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Assessment Required Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `learning_item_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `certification_awarded_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Awarded Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `cle_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Cle Credit Hours');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `learning_item_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `competency_level` SET TAGS ('dbx_business_glossary_term' = 'Competency Level');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `compliance_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `cpd_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Cpd Credit Hours');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `learning_item_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `ethics_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Ethics Credit Hours');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `maximum_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Capacity');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `passing_score_percentage` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Percentage');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `prerequisite_requirements` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Requirements');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = 'Provider Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `recertification_period_months` SET TAGS ('dbx_business_glossary_term' = 'Recertification Period Months');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `recertification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `learning_item_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `learning_item_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`learning_item` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Identifier');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `superseded_compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Compensation Plan Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `superseded_compensation_plan_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `superseded_compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `superseded_compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `bar_dues_reimbursement_eligible` SET TAGS ('dbx_business_glossary_term' = 'Bar Dues Reimbursement Eligible');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `base_salary_maximum` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Maximum');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `base_salary_maximum` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `base_salary_minimum` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Minimum');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `base_salary_minimum` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `benefits_package_tier` SET TAGS ('dbx_business_glossary_term' = 'Benefits Package Tier');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `billable_hours_target` SET TAGS ('dbx_business_glossary_term' = 'Billable Hours Target');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_eligible` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligible');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Bonus Target Percentage');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_target_percentage` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `cle_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Cle Allowance Amount');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `cle_allowance_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Compensation Review Cycle');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_review_cycle` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_business_glossary_term' = 'Compensation Structure');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_structure` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `equity_eligible` SET TAGS ('dbx_business_glossary_term' = 'Equity Eligible');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `firm_office_location_restriction` SET TAGS ('dbx_business_glossary_term' = 'Office Location Restriction');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `fte_classification` SET TAGS ('dbx_business_glossary_term' = 'Fte Classification');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fte Percentage');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `origination_credit_percentage` SET TAGS ('dbx_business_glossary_term' = 'Origination Credit Percentage');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `origination_credit_percentage` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `partner_tier` SET TAGS ('dbx_business_glossary_term' = 'Partner Tier');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `pep_eligible` SET TAGS ('dbx_business_glossary_term' = 'Pep Eligible');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `performance_review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Frequency');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `ppp_eligible` SET TAGS ('dbx_business_glossary_term' = 'Ppp Eligible');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `practice_area_restriction` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Restriction');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `profit_sharing_eligible` SET TAGS ('dbx_business_glossary_term' = 'Profit Sharing Eligible');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `retirement_contribution_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retirement Contribution Percentage');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `retirement_contribution_percentage` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `rpe_eligible` SET TAGS ('dbx_business_glossary_term' = 'Rpe Eligible');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `seniority_level_maximum` SET TAGS ('dbx_business_glossary_term' = 'Seniority Level Maximum');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `seniority_level_minimum` SET TAGS ('dbx_business_glossary_term' = 'Seniority Level Minimum');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`compensation_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `calibration_session_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Session Identifier');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `calibration_facilitator_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Facilitator Timekeeper Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `calibration_last_modified_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `calibration_last_modified_by_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `calibration_last_modified_by_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `practice_group_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `prior_calibration_session_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Calibration Session Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `prior_calibration_session_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `rating_scale_id` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `review_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `budget_pool_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Pool Amount');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `budget_pool_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `calibration_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calibration Methodology');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `compensation_cycle_year` SET TAGS ('dbx_business_glossary_term' = 'Compensation Cycle Year');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `compensation_cycle_year` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `meeting_location` SET TAGS ('dbx_business_glossary_term' = 'Meeting Location');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `participant_count` SET TAGS ('dbx_business_glossary_term' = 'Participant Count');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Session Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `session_name` SET TAGS ('dbx_business_glossary_term' = 'Session Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `session_notes` SET TAGS ('dbx_business_glossary_term' = 'Session Notes');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `session_notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `session_objectives` SET TAGS ('dbx_business_glossary_term' = 'Session Objectives');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `session_recording_url` SET TAGS ('dbx_business_glossary_term' = 'Session Recording Url');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `session_recording_url` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `session_status` SET TAGS ('dbx_business_glossary_term' = 'Session Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `session_type` SET TAGS ('dbx_business_glossary_term' = 'Session Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `target_distribution_curve` SET TAGS ('dbx_business_glossary_term' = 'Target Distribution Curve');
ALTER TABLE `legal_ecm_v1`.`workforce`.`calibration_session` ALTER COLUMN `timekeeper_count` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Count');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `primary_supervisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `primary_supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `primary_supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `annual_base_salary` SET TAGS ('dbx_business_glossary_term' = 'Annual Base Salary');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `annual_base_salary` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `annual_base_salary` SET TAGS ('dbx_dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `attorney_classification` SET TAGS ('dbx_business_glossary_term' = 'Attorney Classification');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `bar_admission_count` SET TAGS ('dbx_business_glossary_term' = 'Bar Admission Count');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `cle_hours_completed_current_year` SET TAGS ('dbx_business_glossary_term' = 'Cle Hours Completed Current Year');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `cle_hours_required_annual` SET TAGS ('dbx_business_glossary_term' = 'Cle Hours Required Annual');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `conflict_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Required Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `diversity_self_identification` SET TAGS ('dbx_business_glossary_term' = 'Diversity Self Identification');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `diversity_self_identification` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `employee_type` SET TAGS ('dbx_business_glossary_term' = 'Employee Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fte Percentage');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `high_potential_flag` SET TAGS ('dbx_business_glossary_term' = 'High Potential Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `high_potential_flag` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `languages_spoken` SET TAGS ('dbx_business_glossary_term' = 'Languages Spoken');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `mobile_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `mobile_phone_number` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `mobile_phone_number` SET TAGS ('dbx_dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `next_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Performance Review Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `partner_tier` SET TAGS ('dbx_business_glossary_term' = 'Partner Tier');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `partner_tier` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `performance_rating` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `professional_liability_insurance_flag` SET TAGS ('dbx_business_glossary_term' = 'Professional Liability Insurance Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `standard_hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Standard Hourly Rate');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `standard_hourly_rate` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `succession_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `succession_plan_flag` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `utilization_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Utilization Target Percentage');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `work_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Work Arrangement');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `work_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `work_phone_number` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`employee` ALTER COLUMN `work_phone_number` SET TAGS ('dbx_dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `parent_department_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Department Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `parent_department_id` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `annual_revenue_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Target');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `annual_revenue_target` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `attorney_count` SET TAGS ('dbx_business_glossary_term' = 'Attorney Count');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `department_type` SET TAGS ('dbx_business_glossary_term' = 'Department Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `department_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dissolution Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `email_address` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'Established Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `extension` SET TAGS ('dbx_business_glossary_term' = 'Extension');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `headcount_fte` SET TAGS ('dbx_business_glossary_term' = 'Headcount Fte');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `paralegal_count` SET TAGS ('dbx_business_glossary_term' = 'Paralegal Count');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `phone_number` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `practice_area` SET TAGS ('dbx_business_glossary_term' = 'Practice Area');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `realization_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Realization Target Percentage');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Short Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `department_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `suite_number` SET TAGS ('dbx_business_glossary_term' = 'Suite Number');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `support_staff_count` SET TAGS ('dbx_business_glossary_term' = 'Support Staff Count');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `legal_ecm_v1`.`workforce`.`department` ALTER COLUMN `utilization_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Utilization Target Percentage');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Identifier');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `prior_review_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Review Cycle Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `prior_review_cycle_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `applicable_to_attorneys` SET TAGS ('dbx_business_glossary_term' = 'Applicable To Attorneys');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `applicable_to_paralegals` SET TAGS ('dbx_business_glossary_term' = 'Applicable To Paralegals');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `applicable_to_partners` SET TAGS ('dbx_business_glossary_term' = 'Applicable To Partners');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `applicable_to_staff` SET TAGS ('dbx_business_glossary_term' = 'Applicable To Staff');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `billable_hours_threshold` SET TAGS ('dbx_business_glossary_term' = 'Billable Hours Threshold');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `calibration_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Meeting Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `cle_cpd_requirement_check` SET TAGS ('dbx_business_glossary_term' = 'Cle Cpd Requirement Check');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `compensation_linked` SET TAGS ('dbx_business_glossary_term' = 'Compensation Linked');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `compensation_linked` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `cycle_close_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle Close Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Cycle Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Cycle Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `cycle_open_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle Open Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Cycle Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_cycle_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `feedback_delivery_end_date` SET TAGS ('dbx_business_glossary_term' = 'Feedback Delivery End Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `feedback_delivery_start_date` SET TAGS ('dbx_business_glossary_term' = 'Feedback Delivery Start Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `includes_360_feedback` SET TAGS ('dbx_business_glossary_term' = 'Includes 360 Feedback');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `manager_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Manager Review Due Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `mandatory_participation` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Participation');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `origination_credit_weight` SET TAGS ('dbx_business_glossary_term' = 'Origination Credit Weight');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `peer_review_count` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Count');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `promotion_eligible` SET TAGS ('dbx_business_glossary_term' = 'Promotion Eligible');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `rating_scale_type` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `self_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Self Assessment Due Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`review_cycle` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `rating_scale_id` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale Identifier');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `primary_superseded_rating_scale_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Rating Scale Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `primary_superseded_rating_scale_id` SET TAGS ('dbx_dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `allows_decimal_precision` SET TAGS ('dbx_business_glossary_term' = 'Allows Decimal Precision');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `allows_half_points` SET TAGS ('dbx_business_glossary_term' = 'Allows Half Points');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `applicable_to_attorneys` SET TAGS ('dbx_business_glossary_term' = 'Applicable To Attorneys');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `applicable_to_partners` SET TAGS ('dbx_business_glossary_term' = 'Applicable To Partners');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `applicable_to_staff` SET TAGS ('dbx_business_glossary_term' = 'Applicable To Staff');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Level');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `comments_required` SET TAGS ('dbx_business_glossary_term' = 'Comments Required');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `distribution_curve_type` SET TAGS ('dbx_business_glossary_term' = 'Distribution Curve Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `excellence_threshold` SET TAGS ('dbx_business_glossary_term' = 'Excellence Threshold');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `external_system_code` SET TAGS ('dbx_business_glossary_term' = 'External System Id');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `forced_distribution_required` SET TAGS ('dbx_business_glossary_term' = 'Forced Distribution Required');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `increment_step` SET TAGS ('dbx_business_glossary_term' = 'Increment Step');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `is_default_scale` SET TAGS ('dbx_business_glossary_term' = 'Is Default Scale');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `linked_to_compensation` SET TAGS ('dbx_business_glossary_term' = 'Linked To Compensation');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `linked_to_compensation` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `linked_to_promotion` SET TAGS ('dbx_business_glossary_term' = 'Linked To Promotion');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `maximum_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Value');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `midpoint_value` SET TAGS ('dbx_business_glossary_term' = 'Midpoint Value');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `minimum_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Value');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `passing_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Threshold');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `peer_review_allowed` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Allowed');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `requires_calibration` SET TAGS ('dbx_business_glossary_term' = 'Requires Calibration');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `scale_code` SET TAGS ('dbx_business_glossary_term' = 'Scale Code');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `scale_description` SET TAGS ('dbx_business_glossary_term' = 'Scale Description');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `scale_direction` SET TAGS ('dbx_business_glossary_term' = 'Scale Direction');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `scale_name` SET TAGS ('dbx_business_glossary_term' = 'Scale Name');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `scale_type` SET TAGS ('dbx_business_glossary_term' = 'Scale Type');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `self_assessment_allowed` SET TAGS ('dbx_business_glossary_term' = 'Self Assessment Allowed');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `rating_scale_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `usage_context` SET TAGS ('dbx_business_glossary_term' = 'Usage Context');
ALTER TABLE `legal_ecm_v1`.`workforce`.`rating_scale` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
