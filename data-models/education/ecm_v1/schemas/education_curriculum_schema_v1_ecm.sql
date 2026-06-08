-- Schema for Domain: curriculum | Business: Education | Version: v1_ecm
-- Generated on: 2026-05-06 12:28:00

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `education_ecm`.`curriculum` COMMENT 'Authoritative source for academic programs, degrees, courses, learning outcomes, and instructional design. Manages degree requirements, course catalogs, CIP codes, credit hour definitions, prerequisite chains, SLOs, PLOs, OER designations, and curriculum approval workflows. Supports program accreditation (AACSB, ABET), articulation agreements, and academic quality assurance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`academic_program` (
    `academic_program_id` BIGINT COMMENT 'Unique surrogate identifier for the academic program record in the institutional data lakehouse. Primary key for the academic_program master entity.',
    `cip_code_id` BIGINT COMMENT 'FK to curriculum.cip_code',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Academic programs require designated cost centers for budget management, expense tracking, and financial reporting. Program directors manage budgets through cost center assignments. Essential for prog',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Programs often have dedicated funds (endowed chairs, scholarships, restricted gifts). Links program to its primary operating fund for revenue recognition, expenditure authorization, and donor stewards',
    `org_unit_id` BIGINT COMMENT 'Identifier of the owning college or school within the institution responsible for administering this academic program (e.g., College of Engineering, College of Business).',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Programs are often housed in designated buildings (e.g., College of Engineering in Smith Hall). Supports facility planning, student wayfinding, program marketing materials, and space allocation decisi',
    `campus_id` BIGINT COMMENT 'Foreign key linking to facility.campus. Business justification: Multi-campus institutions assign programs to specific campuses for IPEDS reporting, student services planning, and enrollment management. Essential for catalog publication and accreditation documentat',
    `collection_id` BIGINT COMMENT 'Foreign key linking to library.collection. Business justification: Academic programs require library collections aligned to their CIP code and accreditation standards. Collection development budgets are allocated by program, accreditation reviews assess collection ad',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Many academic programs require specialized enterprise applications (engineering programs use CAD software, business programs use Bloomberg terminals, nursing programs use simulation software). Program',
    `employee_id` BIGINT COMMENT 'Identifier of the faculty member or administrator designated as the Program Director or Coordinator responsible for curriculum oversight, accreditation compliance, and program governance.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Programs must track compliance with federal regulations (Title IV eligibility, federal student aid, gainful employment). Essential for financial aid administration, IPEDS reporting, and program approv',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Programs need designated revenue accounts for tuition allocation, fee collection, and program-specific income tracking. Enables program-level financial statements, cost-per-credit analysis, and revenu',
    `state_authorization_id` BIGINT COMMENT 'Foreign key linking to compliance.state_authorization. Business justification: Online and out-of-state programs require state authorization tracking per SARA and individual state regulations. Critical for enrollment management, marketing compliance, and avoiding regulatory penal',
    `accreditation_body` STRING COMMENT 'Name of the specialized programmatic accreditation body that accredits this program (e.g., AACSB, ABET, LCME, ABA, ACEN, CCNE). Null if the program holds only regional institutional accreditation. [ENUM-REF-CANDIDATE: AACSB|ABET|LCME|ABA|ACEN|CCNE|NASAD|NASM|APA|CSWE — promote to reference product]',
    `accreditation_status` STRING COMMENT 'Current accreditation standing of the program with its specialized accreditation body. accredited indicates full standing; candidate indicates candidacy status; probation and show_cause indicate adverse actions requiring remediation.. Valid values are `accredited|candidate|not_accredited|probation|show_cause`',
    `admission_type` STRING COMMENT 'Characterizes the selectivity of admission into the program. open indicates no selective criteria beyond institutional admission; selective indicates program-specific requirements; competitive indicates limited seats with ranked selection; cohort indicates fixed-group entry.. Valid values are `open|selective|competitive|cohort`',
    `approval_date` DATE COMMENT 'Date on which the program received final institutional governance approval (e.g., Faculty Senate, Board of Trustees, or state higher education board). Required for accreditation documentation and regulatory filings.',
    `capstone_required` BOOLEAN COMMENT 'Indicates whether a capstone project, comprehensive examination, or integrative experience is required for program completion. Distinct from thesis requirement; applies to professional and applied programs.',
    `catalog_year` STRING COMMENT 'The academic catalog year in which this version of the program requirements became effective (e.g., 2024 for the 2024–2025 catalog). Students are typically held to the requirements of their catalog year of entry.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the academic program record was first created in the institutional data system. Supports data lineage, audit trail, and Silver layer ingestion tracking.',
    `degree_designation` STRING COMMENT 'Specific credential title conferred upon completion (e.g., B.S., B.A., M.S., M.B.A., Ph.D., Ed.D., J.D., M.D., A.A.S.). Printed on the diploma and official transcript.',
    `degree_level` STRING COMMENT 'Academic level of the credential awarded upon program completion. Drives IPEDS classification, financial aid eligibility, and accreditation scope. [ENUM-REF-CANDIDATE: associate|bachelor|master|doctoral|certificate|professional|post-baccalaureate — promote to reference product if additional levels are needed]. Valid values are `associate|bachelor|master|doctoral|certificate|professional`',
    `delivery_modality` STRING COMMENT 'Primary instructional delivery mode for the program. Drives Distance Education reporting to IPEDS, accreditation disclosures, and student eligibility for certain financial aid programs.. Valid values are `on_campus|online|hybrid|blended|competency_based`',
    `dfw_rate` DECIMAL(18,2) COMMENT 'Percentage of enrolled students who received a D grade, F grade, or withdrew (DFW) from program-required courses in the most recent academic year. Key academic quality indicator used in curriculum review and accreditation self-studies.',
    `effective_end_date` DATE COMMENT 'Date on which this academic program version was superseded, suspended, or discontinued. Null for currently active programs. Used in teach-out planning and accreditation reporting.',
    `effective_start_date` DATE COMMENT 'Date on which this academic program version became officially active and open for student enrollment. Aligns with the catalog year effective date.',
    `gainful_employment_applicable` BOOLEAN COMMENT 'Indicates whether this program is subject to U.S. Department of Education Gainful Employment (GE) regulations, which apply to non-degree certificate programs and for-profit institution programs. Triggers GE disclosure and reporting obligations.',
    `internship_required` BOOLEAN COMMENT 'Indicates whether a supervised internship, practicum, clinical rotation, or cooperative education experience is a mandatory component of the program. Relevant for professional licensure programs and ABET/AACSB accreditation.',
    `ipeds_award_level` STRING COMMENT 'IPEDS award level code used for federal completions reporting (e.g., 1=Less than 1-year certificate, 3=Associates degree, 5=Bachelors degree, 7=Masters degree, 9=Doctors degree-research/scholarship). Required for annual IPEDS Completions Survey submission. [ENUM-REF-CANDIDATE: 1|2|3|4|5|6|7|8|9|10|11|12 — promote to reference product]',
    `is_stem_designated` BOOLEAN COMMENT 'Indicates whether the program holds an official STEM (Science, Technology, Engineering, Mathematics) designation under the U.S. Department of Homeland Security STEM OPT extension list. Affects international student Optional Practical Training (OPT) eligibility.',
    `last_curriculum_review_date` DATE COMMENT 'Date of the most recent formal curriculum review conducted by the program faculty and curriculum committee. Accreditation bodies require periodic curriculum review cycles (typically every 5–7 years).',
    `licensure_track` BOOLEAN COMMENT 'Indicates whether the program is designed to prepare students for a professional licensure examination (e.g., CPA, PE, bar exam, nursing licensure). Triggers required consumer disclosures under 34 CFR 668.43(a)(5)(v).',
    `max_transfer_credit_hours` STRING COMMENT 'Maximum number of transfer credit hours that may be applied toward the programs degree requirements. Governs articulation agreement limits and transfer credit evaluation policies.',
    `min_gpa_required` DECIMAL(18,2) COMMENT 'Minimum cumulative Grade Point Average (GPA) required for admission to or continuation in the program. Used in academic standing reviews and Satisfactory Academic Progress (SAP) determinations.',
    `next_accreditation_review_date` DATE COMMENT 'Scheduled date of the next programmatic or institutional accreditation review visit or self-study submission deadline. Used in accreditation compliance planning and institutional research calendars.',
    `oer_adopted` BOOLEAN COMMENT 'Indicates whether the program has formally adopted Open Educational Resources (OER) as the primary instructional materials, reducing student textbook costs. Supports affordability reporting and state OER grant compliance.',
    `program_code` STRING COMMENT 'Institutionally assigned alphanumeric code uniquely identifying the academic program within the Student Information System (SIS). Used in Banner, transcripts, and degree audits (e.g., CS-BS, MBA-FLEX).. Valid values are `^[A-Z0-9-]{2,20}$`',
    `program_description` STRING COMMENT 'Official narrative description of the academic program as published in the institutional catalog. Describes program objectives, career outcomes, and distinguishing features for prospective students and accreditation documentation.',
    `program_format` STRING COMMENT 'Structural format of the program offering. Drives scheduling, tuition rate assignment, and marketing segmentation (e.g., executive MBA vs. standard MBA). [ENUM-REF-CANDIDATE: full_time|part_time|accelerated|executive|dual_degree|weekend|evening — promote to reference product]. Valid values are `full_time|part_time|accelerated|executive|dual_degree`',
    `program_status` STRING COMMENT 'Current lifecycle status of the academic program. active indicates open for enrollment; suspended indicates temporarily closed; teach_out indicates no new admissions but existing students may complete; discontinued indicates fully closed; pending_approval indicates awaiting governance approval.. Valid values are `active|suspended|teach_out|discontinued|pending_approval`',
    `program_title` STRING COMMENT 'Official full title of the academic program as it appears in the institutional catalog and on diplomas (e.g., Bachelor of Science in Computer Science, Master of Business Administration).',
    `program_url` STRING COMMENT 'Public-facing URL of the programs official webpage on the institutional website. Used in CRM (Slate) communications, recruitment materials, and IPEDS Consumer Information disclosures.. Valid values are `^https?://.+$`',
    `six_year_graduation_rate` DECIMAL(18,2) COMMENT 'Percentage of first-time, full-time (FTIAC) students who completed the program within 150% of normal time (six years for a four-year program). Required for IPEDS Graduation Rates Survey and consumer disclosure.',
    `state_approval_required` BOOLEAN COMMENT 'Indicates whether this program requires state-level authorization approval beyond institutional accreditation, particularly for online programs enrolling students in other states under State Authorization Reciprocity Agreements (SARA).',
    `thesis_required` BOOLEAN COMMENT 'Indicates whether completion of a thesis (masters level) or dissertation (doctoral level) is a mandatory graduation requirement for this program. Affects degree audit configuration and graduate school workflow.',
    `title_iv_eligible` BOOLEAN COMMENT 'Indicates whether students enrolled in this program are eligible to receive Title IV federal financial aid (Pell Grants, Direct Loans, etc.) under the Higher Education Act. Drives FAFSA processing and financial aid packaging.',
    `total_credit_hours` STRING COMMENT 'Minimum number of credit hours (CR) a student must earn to satisfy all degree requirements and graduate from the program. Used in degree audit, financial aid Satisfactory Academic Progress (SAP) calculations, and accreditation reporting.',
    `total_enrolled_students` STRING COMMENT 'Current headcount of students actively enrolled in the program as of the most recent official census date. Used in enrollment management reporting, resource allocation, and IPEDS Fall Enrollment Survey.',
    `typical_duration_semesters` STRING COMMENT 'Expected number of semesters (or equivalent terms) for a full-time student to complete the program. Used in enrollment planning, financial aid cost of attendance (COA) calculations, and student advising.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the academic program record. Used for change detection in ETL pipelines, data quality monitoring, and audit compliance.',
    `va_approved` BOOLEAN COMMENT 'Indicates whether the program has been approved by the U.S. Department of Veterans Affairs (VA) for GI Bill and other veterans education benefits. Required for enrollment certification of veteran students.',
    CONSTRAINT pk_academic_program PRIMARY KEY(`academic_program_id`)
) COMMENT 'Master record for all degree and certificate programs offered by the institution, including undergraduate, graduate, and professional programs. Captures program title, CIP code, degree level (associate, bachelor, master, doctoral, certificate), total credit hours required, delivery modality (on-campus, online, hybrid), specialized accreditation body (AACSB, ABET, LCME, ABA), program status (active, suspended, teach-out, discontinued), effective catalog year, owning college and department, STEM designation, and IPEDS classification. Serves as the authoritative catalog of institutional academic offerings and the parent entity for degree requirements, concentrations, PLOs, and curriculum maps.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`course` (
    `course_id` BIGINT COMMENT 'Unique surrogate identifier for the course master record in the Silver Layer lakehouse. This is the primary key for the course catalog entity, distinct from any term-specific section or offering.',
    `cip_code_id` BIGINT COMMENT 'FK to curriculum.cip_code',
    `org_unit_id` BIGINT COMMENT 'Reference to the college or school within the institution that houses the department offering this course (e.g., College of Engineering, College of Business). Used for accreditation unit reporting (AACSB, ABET) and institutional analytics.',
    `course_org_unit_id` BIGINT COMMENT 'Reference to the academic department or unit that owns and administers the course. Used for faculty assignment, budget allocation, and accreditation unit mapping. Links to the organizational unit hierarchy.',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Courses with specialized facility needs (labs, studios, performance spaces) require default room assignments for scheduling systems. Supports room utilization analysis, equipment planning, and ensures',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Courses are delivered through learning management systems (Canvas, Blackboard, Moodle) which are enterprise applications. Faculty need to know which LMS hosts their course for content management, grad',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Courses are typically scheduled in specific buildings based on department location and facility requirements. Supports student schedule planning, classroom utilization reporting, and ensures courses a',
    `primary_cross_list_course_id` BIGINT COMMENT 'For cross-listed courses, the course_id of the primary (canonical) course record. Null if this course is the primary listing or is not cross-listed. Used to resolve cross-listing relationships and prevent duplicate catalog entries.',
    `bib_record_id` BIGINT COMMENT 'Foreign key linking to library.bib_record. Business justification: Course syllabi specify required textbooks and readings that must be available in library catalog. Faculty submit reserve requests, students check availability, and library liaison librarians verify ho',
    `approval_date` DATE COMMENT 'The date on which the course was formally approved by the institutional curriculum committee or faculty governance body. Used for accreditation documentation and curriculum change audit trails.',
    `approval_status` STRING COMMENT 'The current status of the course within the institutional curriculum approval workflow. New courses and course modifications must pass through faculty governance review before becoming active in the catalog. Used for curriculum management and accreditation audit trails.. Valid values are `draft|under_review|approved|rejected|archived`',
    `banner_course_key` STRING COMMENT 'The natural business identifier for the course as stored in Ellucian Banner, typically the concatenation of subject code, course number, and effective term (e.g., MATH101-202310). Serves as the externally-known unique course identifier for system integration and data lineage tracing.',
    `canvas_course_code` STRING COMMENT 'The course code or SIS ID used to identify this course in the Canvas Learning Management System (LMS). Used for LMS integration, content mapping, and learning analytics alignment between the SIS and LMS.',
    `catalog_year_end` STRING COMMENT 'The four-digit academic year in which this course definition was last valid in the published academic catalog. Null for currently active course definitions. Used for degree audit and historical catalog archiving.',
    `catalog_year_start` STRING COMMENT 'The four-digit academic year in which this course definition first appeared in the published academic catalog (e.g., 2023 for the 2023-2024 catalog). Used for degree audit grandfathering and curriculum change tracking.',
    `contact_hours` DECIMAL(18,2) COMMENT 'The total number of scheduled instructional contact hours per week (or per term) for the course. Used for faculty workload calculations, accreditation compliance, and Carnegie Unit verification. Distinct from credit hours.',
    `corequisite_text` STRING COMMENT 'The human-readable narrative description of corequisite requirements — courses that must be taken concurrently with this course. Published in the academic catalog and enforced during registration.',
    `course_description` STRING COMMENT 'The full narrative course description as published in the academic catalog. Describes course content, objectives, and scope. Used by students for course selection, by advisors for degree planning, and by accreditors for curriculum review.',
    `course_level` STRING COMMENT 'The numeric level of the course indicating its academic complexity tier (e.g., 100=introductory undergraduate, 200=sophomore, 300=junior, 400=senior, 500=graduate, 600=advanced graduate, 700=doctoral, 800=professional, 900=post-doctoral). Used for degree audit, prerequisite enforcement, and IPEDS reporting.',
    `course_number` STRING COMMENT 'The numeric or alphanumeric course designator within a subject area (e.g., 101, 301, 4820). Combined with subject_code to form the full course identifier (e.g., MATH 101). Corresponds to Banner SCBCRSE_CRSE_NUMB.. Valid values are `^[0-9]{3,4}[A-Z]?$`',
    `course_status` STRING COMMENT 'The current lifecycle status of the course master record in the catalog. Active courses are available for scheduling and registration. Inactive or discontinued courses are retained for historical transcript purposes but cannot be scheduled. Corresponds to Banner SCBCRSE_CSTA_CODE.. Valid values are `active|inactive|pending_approval|suspended|discontinued`',
    `course_type` STRING COMMENT 'The primary instructional format or delivery type of the course. Distinguishes lecture-based, laboratory, seminar, studio, clinical, independent study, internship, thesis, dissertation, and hybrid formats. Used for scheduling, accreditation, and faculty workload reporting. [ENUM-REF-CANDIDATE: lecture|lab|seminar|studio|clinical|independent_study|internship|thesis|dissertation|hybrid|online|practicum — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the course master record was first created in the source system or ingested into the Silver Layer. Used for data lineage, audit compliance, and curriculum change history tracking.',
    `credit_hours` DECIMAL(18,2) COMMENT 'The number of academic credit hours (CR) awarded upon successful completion of the course. Used for degree requirement tracking, financial aid eligibility (SAP), full-time equivalent (FTE) calculations, and IPEDS reporting. Corresponds to Banner SCBCRSE_CREDIT_HR_HIGH or SCBCRSE_CREDIT_HR_LOW for variable-credit courses.',
    `credit_hours_min` DECIMAL(18,2) COMMENT 'The minimum number of credit hours that may be awarded for variable-credit courses (e.g., independent study, thesis, internship). Null for fixed-credit courses. Corresponds to Banner SCBCRSE_CREDIT_HR_LOW.',
    `cross_listed_flag` BOOLEAN COMMENT 'Indicates whether this course is cross-listed under multiple subject codes or departments. Cross-listed courses share the same instructional content but appear under different prefixes (e.g., WMST 301 / SOC 301). Used for enrollment reporting and catalog management.',
    `delivery_modality` STRING COMMENT 'The instructional delivery modality for the course as defined in the catalog. Indicates whether the course is delivered in-person, fully online, hybrid (blended), HyFlex, synchronous online, or asynchronous online. Used for enrollment reporting, accreditation, and IPEDS distance education reporting.. Valid values are `in_person|online|hybrid|hyflex|synchronous_online|asynchronous_online`',
    `discontinue_date` DATE COMMENT 'The date on which the course was officially discontinued and removed from the active catalog. Null for active courses. Used for historical reporting, degree audit grandfathering, and accreditation documentation.',
    `effective_date` DATE COMMENT 'The date from which this version of the course definition is effective in the academic catalog. Used for catalog year tracking, curriculum change management, and degree audit. Corresponds to Banner SCBCRSE_EFF_TERM converted to date.',
    `gen_ed_category` STRING COMMENT 'The general education (gen ed) distribution category or core curriculum area fulfilled by this course (e.g., Quantitative Reasoning, Written Communication, Natural Sciences, Social Sciences, Humanities, Diversity). Used for degree audit and accreditation reporting. Values are institution-specific. [ENUM-REF-CANDIDATE: written_communication|quantitative_reasoning|natural_sciences|social_sciences|humanities|diversity|global_awareness|arts — promote to reference product]',
    `grading_basis` STRING COMMENT 'The grading method applied to the course. Determines how student performance is recorded on the transcript and factored into GPA calculations. Letter-graded courses affect GPA; pass/fail and audit courses typically do not. Corresponds to Banner SCBCRSE_GMOD_CODE.. Valid values are `letter|pass_fail|audit|satisfactory_unsatisfactory|credit_no_credit`',
    `honors_eligible` BOOLEAN COMMENT 'Indicates whether the course is eligible for honors designation or is part of the institutions honors program curriculum. Used for honors program tracking, degree audit, and academic distinction reporting.',
    `lab_hours` DECIMAL(18,2) COMMENT 'The number of weekly laboratory contact hours for the course. Relevant for STEM courses, nursing, and other lab-intensive disciplines. Used in accreditation reporting (ABET) and facility scheduling.',
    `lecture_hours` DECIMAL(18,2) COMMENT 'The number of weekly lecture contact hours for the course. Used to distinguish instructional modality components and calculate faculty FTE workload. Part of the contact hours breakdown alongside lab and seminar hours.',
    `long_title` STRING COMMENT 'The full descriptive title of the course used in catalog publications, accreditation reports, and articulation agreements where the abbreviated transcript title may be insufficient.',
    `max_enrollment` STRING COMMENT 'The default maximum number of students permitted to enroll in a single section of this course, as defined at the catalog level. May be overridden at the section level for specific terms. Used for capacity planning and accreditation student-to-faculty ratio reporting.',
    `max_repeat_hours` DECIMAL(18,2) COMMENT 'The maximum total credit hours that may be earned by repeating this course. Null if the course is not repeatable or has no cap. Used in degree audit to prevent over-crediting. Corresponds to Banner SCBCRSE_MAX_RPT_UNITS.',
    `oer_designated` BOOLEAN COMMENT 'Indicates whether the course has been officially designated as using Open Educational Resources (OER) as the primary course materials, eliminating or significantly reducing textbook costs for students. Supports affordability reporting and student financial aid cost-of-attendance (COA) calculations.',
    `prerequisite_text` STRING COMMENT 'The human-readable narrative description of prerequisite requirements for enrollment in this course, as published in the academic catalog. May include course prerequisites, minimum GPA requirements, class standing, or instructor consent. The structured prerequisite chain is managed separately in the curriculum domain.',
    `repeatable` BOOLEAN COMMENT 'Indicates whether the course may be repeated for additional credit (True) or may only be taken once for credit (False). Common for topics courses, independent study, thesis, and performance courses. Corresponds to Banner SCBCRSE_REPEAT_IND.',
    `stem_designated` BOOLEAN COMMENT 'Indicates whether the course is classified as a Science, Technology, Engineering, or Mathematics (STEM) course per the DHS STEM Designated Degree Program List. Relevant for international student visa compliance (OPT extension eligibility) and federal STEM grant reporting.',
    `subject_code` STRING COMMENT 'The academic subject or department prefix that identifies the discipline area of the course (e.g., MATH, ENGL, BIOL, CS). Corresponds to the Banner SCBCRSE_SUBJ_CODE field and is used in the human-readable course identifier alongside the course number.. Valid values are `^[A-Z]{2,10}$`',
    `title` STRING COMMENT 'The official short title of the course as it appears in the academic catalog and on student transcripts. Corresponds to Banner SCBCRSE_TITLE. Used in registration systems, LMS, and official academic records.',
    `transfer_equivalency_flag` BOOLEAN COMMENT 'Indicates whether this course participates in formal transfer equivalency or articulation agreements with other institutions. Used by the registrar and transfer credit evaluation process to identify courses with established equivalencies.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the course master record was most recently modified in the source system or Silver Layer. Used for incremental ETL processing, change data capture, and audit trail compliance.',
    `writing_intensive` BOOLEAN COMMENT 'Indicates whether the course has been designated as writing intensive, requiring substantial written work as a core component of instruction and assessment. Used to track fulfillment of general education writing requirements and for accreditation reporting.',
    CONSTRAINT pk_course PRIMARY KEY(`course_id`)
) COMMENT 'Authoritative catalog record for every course offered by the institution, independent of any specific term or section. Captures course prefix, number, title, long description, credit hours (CR), contact hours, course level (100–900), delivery modality, grading basis (letter, pass/fail, audit), repeatability rules, OER designation, writing-intensive flag, lab/lecture/seminar type, and Banner course master attributes. This is the SSOT for course identity and definition, distinct from section-level scheduling data owned by the enrollment domain.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`degree_requirement` (
    `degree_requirement_id` BIGINT COMMENT 'Unique surrogate identifier for each degree requirement block within a programs degree plan. Primary key for this entity in the Databricks Silver Layer.',
    `academic_program_id` BIGINT COMMENT 'Reference to the academic program (degree or certificate) to which this requirement block belongs. Links to the curriculum program master.',
    `cip_code_id` BIGINT COMMENT 'FK to curriculum.cip_code',
    `concentration_id` BIGINT COMMENT 'Foreign key linking to curriculum.concentration. Business justification: degree_requirement currently has concentration_code (STRING) to identify which concentration a requirement applies to. This should be normalized to a FK relationship to the concentration master table.',
    `plo_id` BIGINT COMMENT 'Reference to the primary Program Learning Outcome (PLO) that this requirement block is mapped to in the curriculum assessment framework. Supports assurance of learning and accreditation reporting.',
    `prerequisite_rule_id` BIGINT COMMENT 'Reference to another degree requirement block that must be completed before this block can be satisfied. Supports prerequisite chain modeling within the degree plan structure.',
    `accreditation_body` STRING COMMENT 'The accreditation body whose standards this requirement block is designed to satisfy (e.g., AACSB for business programs, ABET for engineering). Supports accreditation self-study documentation and compliance reporting. [ENUM-REF-CANDIDATE: AACSB|ABET|ABA|LCME|SACSCOC|HLC|MSCHE|NWCCU|NECHE|WSCUC|NCAA|none — promote to reference product]',
    `allow_concurrent_enrollment` BOOLEAN COMMENT 'Indicates whether courses taken concurrently (simultaneously enrolled in two courses that satisfy the same block) may both count toward this requirement block (True). Prevents double-counting when False.',
    `allow_substitution` BOOLEAN COMMENT 'Indicates whether course substitutions are permitted within this requirement block (True). When True, an academic advisor may substitute an equivalent course via a formal substitution/waiver process tracked in Banner SMRALIB.',
    `allow_test_credit` BOOLEAN COMMENT 'Indicates whether credit earned through standardized examinations (AP, CLEP, IB, DSST) may be applied toward this requirement block (True). Supports prior learning assessment (PLA) policy enforcement.',
    `allow_transfer_credit` BOOLEAN COMMENT 'Indicates whether transfer credit may be applied toward this requirement block (True). Governs articulation agreement enforcement and transfer credit evaluation workflows.',
    `approval_status` STRING COMMENT 'Current status of this requirement block within the institutional curriculum approval workflow (e.g., curriculum committee review, faculty senate approval). Tracks the governance lifecycle from draft through final approval.. Valid values are `draft|submitted|approved|rejected|withdrawn`',
    `approved_date` DATE COMMENT 'The date on which this requirement block received final institutional approval from the curriculum committee or faculty governance body. Null if not yet approved.',
    `approving_body` STRING COMMENT 'Name of the institutional governance body that approved this requirement block (e.g., Undergraduate Curriculum Committee, Graduate Council, Faculty Senate). Supports audit trail for accreditation and compliance reviews.',
    `catalog_year` STRING COMMENT 'The academic catalog year (e.g., 2024) under which this requirement block is effective. Students are typically held to the catalog year in effect at the time of their enrollment or program declaration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this degree requirement record was first created in the data platform. Supports data lineage, audit trail, and Silver Layer ingestion tracking.',
    `degree_type` STRING COMMENT 'The type of academic credential (degree or certificate) to which this requirement block belongs (e.g., BA, BS, MBA, PhD, certificate). Drives degree audit differentiation across credential types within the same program. [ENUM-REF-CANDIDATE: BA|BS|BFA|BBA|MA|MS|MBA|MFA|PhD|EdD|JD|MD|certificate|associate — promote to reference product]',
    `diversity_requirement` BOOLEAN COMMENT 'Indicates whether this requirement block fulfills an institutional diversity, equity, and inclusion (DEI) general education or program requirement. Supports diversity curriculum reporting and accreditation documentation.',
    `effective_from` DATE COMMENT 'The date from which this requirement block is effective and enforceable in degree audit processing. Students entering the program on or after this date are subject to this requirement block.',
    `effective_until` DATE COMMENT 'The date after which this requirement block is no longer enforced for new students. Null for currently active blocks. Supports catalog year versioning and sunset of deprecated requirement structures.',
    `is_repeatable` BOOLEAN COMMENT 'Indicates whether courses within this requirement block may be repeated for additional credit toward the requirement (True) or whether repeat attempts are excluded from credit hour totals (False).',
    `is_required` BOOLEAN COMMENT 'Indicates whether this requirement block is mandatory (True) or optional/advisory (False) for degree completion. Mandatory blocks must be satisfied before degree clearance is granted.',
    `level_code` STRING COMMENT 'Academic level at which this requirement block applies: UG (Undergraduate), GR (Graduate), PF (Professional), DC (Doctoral). Ensures degree audit rules are applied only to students at the appropriate academic level.. Valid values are `UG|GR|PF|DC`',
    `max_credit_hours` DECIMAL(18,2) COMMENT 'Maximum number of credit hours (CR) that may be applied toward this requirement block. Caps the number of credits counted from elective or free-elective pools in degree audit processing.',
    `max_transfer_credit_hours` DECIMAL(18,2) COMMENT 'Maximum number of transfer credit hours that may be applied toward this specific requirement block. Enforces institutional transfer credit caps at the block level, complementing the program-level residency requirement.',
    `min_course_count` STRING COMMENT 'Minimum number of distinct courses a student must complete within this requirement block, independent of credit hour totals. Used when a block requires completion of a specific number of courses (e.g., complete at least 3 courses from the following list).',
    `min_credit_hours` DECIMAL(18,2) COMMENT 'Minimum number of credit hours (CR) a student must complete within this requirement block to satisfy the degree requirement. Expressed in semester credit hours per federal definition (34 CFR 600.2).',
    `min_gpa` DECIMAL(18,2) COMMENT 'Minimum cumulative or block-level Grade Point Average (GPA) a student must achieve within this requirement group to satisfy the requirement. Supports Satisfactory Academic Progress (SAP) enforcement and degree clearance.',
    `min_grade` STRING COMMENT 'Minimum letter grade a student must earn in individual courses within this requirement block for those courses to count toward the requirement (e.g., C, C-, B). Enforced during degree audit course-level evaluation.. Valid values are `^[A-DF][+-]?$`',
    `notes` STRING COMMENT 'Free-text advisory notes or special instructions associated with this requirement block, as displayed to academic advisors and students in degree audit reports and advising worksheets. May include waiver conditions, special circumstances, or catalog footnotes.',
    `oer_eligible` BOOLEAN COMMENT 'Indicates whether courses satisfying this requirement block are designated as using Open Educational Resources (OER), reducing or eliminating textbook costs for students. Supports affordability reporting and OER initiative tracking.',
    `requirement_code` STRING COMMENT 'Externally-known alphanumeric code identifying this requirement block within the Banner SMRPRLE/SMRALIB rule structure (e.g., CORE-ENG-2024, ELEC-BUS-CONC). Used in degree audit processing and advising reports.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `requirement_name` STRING COMMENT 'Human-readable name of the requirement block as it appears in the academic catalog and degree audit (e.g., Core Curriculum, Business Concentration Electives, Capstone Experience).',
    `requirement_status` STRING COMMENT 'Current lifecycle state of the requirement block. active blocks are enforced in degree audits; superseded blocks are replaced by a newer version; pending_approval blocks are in curriculum committee review.. Valid values are `active|inactive|pending_approval|archived|superseded`',
    `requirement_type` STRING COMMENT 'Categorical classification of the requirement block indicating its role in the degree plan. Drives degree audit logic and advising workflows. [ENUM-REF-CANDIDATE: core|elective|concentration|general_education|capstone|residency|free_elective|cognate — promote to reference product]',
    `residency_credit_hours` DECIMAL(18,2) COMMENT 'Minimum number of credit hours within this requirement block that must be earned in residence at the awarding institution (not via transfer, AP, CLEP, or prior learning assessment). Supports accreditation residency standards.',
    `sequence_number` STRING COMMENT 'Numeric ordering of this requirement block within the programs degree plan. Controls the display order in degree audit reports, academic advising worksheets, and catalog publications.',
    `slo_alignment` STRING COMMENT 'Free-text or structured reference to the Student Learning Outcomes (SLOs) or Program Learning Outcomes (PLOs) that this requirement block is designed to develop or assess. Supports curriculum mapping and accreditation quality assurance reporting.',
    `smralib_rule_code` STRING COMMENT 'The native area/list rule code from Ellucian Banners SMRALIB (Student Module Requirements Area List) table associated with this requirement block. Identifies the specific course list or area rule used in degree audit processing.. Valid values are `^[A-Z0-9_]{1,30}$`',
    `smrprle_rule_code` STRING COMMENT 'The native rule code from Ellucian Banners SMRPRLE (Student Module Requirements Program Rule) table that corresponds to this requirement block. Used for direct traceability to the system of record and degree audit engine.. Valid values are `^[A-Z0-9_]{1,30}$`',
    `stem_designated` BOOLEAN COMMENT 'Indicates whether this requirement block is classified as part of a Science, Technology, Engineering, and Mathematics (STEM) designated program area. Relevant for OPT STEM extension eligibility reporting and federal STEM program tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this degree requirement record was most recently modified in the data platform. Supports change detection, incremental ETL processing, and audit trail maintenance.',
    `writing_intensive` BOOLEAN COMMENT 'Indicates whether this requirement block includes or requires writing-intensive courses as part of the institutions writing across the curriculum (WAC) or writing in the disciplines (WID) program.',
    CONSTRAINT pk_degree_requirement PRIMARY KEY(`degree_requirement_id`)
) COMMENT 'Defines the structured set of requirements a student must satisfy to earn a specific academic programs degree or certificate. Captures requirement group type (core, elective, concentration, general education, capstone), minimum credit hours, minimum GPA threshold, course substitution rules, residency requirements, and the Banner SMRPRLE/SMRALIB rule structures. Supports degree audit processing and academic advising. Each record represents one requirement block within a programs degree plan.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`prerequisite_rule` (
    `prerequisite_rule_id` BIGINT COMMENT 'Unique system-generated identifier for the prerequisite rule record. Primary key for the prerequisite_rule data product in the curriculum domain.',
    `academic_program_id` BIGINT COMMENT 'Identifier of the academic program (major, minor, or certificate) in which a student must be enrolled to satisfy this prerequisite rule. Applicable only when program_enrollment_required is True.',
    `articulation_agreement_id` BIGINT COMMENT 'Identifier of the articulation agreement under which this prerequisite rule may be satisfied by a course completed at a partner institution. Links to the curriculum domain articulation agreement product for transfer pathway validation.',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: Prerequisite rules activate at specific term boundaries for registration enforcement. SIS prerequisite checking requires term-specific rule activation for accurate student registration validation. Rep',
    `org_unit_id` BIGINT COMMENT 'Identifier of the academic department that owns and administers this prerequisite rule. Determines which department chair has override authority and which curriculum committee reviews rule changes.',
    `parent_rule_prerequisite_rule_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent prerequisite rule record in a nested Boolean condition hierarchy. Null for top-level rules. Enables recursive evaluation of complex prerequisite trees.',
    `course_id` BIGINT COMMENT 'Identifier of the course that owns this prerequisite rule — the course a student is attempting to register for. This is the gating course whose enrollment eligibility is governed by this rule.',
    `prerequisite_group_id` BIGINT COMMENT 'Identifier linking multiple prerequisite rule records into a logical group for complex Boolean evaluation (e.g., CALC1 AND (TRIG OR PRECALC)). Rules sharing the same rule_group_id are evaluated together using their respective boolean_operator values.',
    `advisory_only_flag` BOOLEAN COMMENT 'Indicates that this rule is displayed as an academic advising recommendation in degree planning tools but does not generate a hard registration block in the SIS. Distinct from sis_enforcement_flag: a rule may be SIS-enforced as a soft warning but still be advisory.',
    `ap_credit_applicable` BOOLEAN COMMENT 'Indicates whether Advanced Placement (AP) exam credit awarded by the institution can satisfy this prerequisite rule. When True, qualifying AP scores on file in the SIS are evaluated during registration.',
    `applicable_term_end` STRING COMMENT 'Banner-format term code (YYYYTT) representing the last academic term in which this prerequisite rule is enforced. Null for rules with no planned end term. Used to sunset rules aligned with curriculum revision cycles.. Valid values are `^[0-9]{6}$`',
    `approved_by` STRING COMMENT 'Name or institutional username of the faculty member, department chair, or curriculum committee representative who formally approved this prerequisite rule. Supports audit trail for accreditation and compliance reviews.',
    `boolean_operator` STRING COMMENT 'Logical operator used to combine this rule with sibling rules within the same rule group. AND requires all conditions in the group to be met; OR requires at least one; NOT excludes students who have completed the referenced course (anti-requisite logic).. Valid values are `AND|OR|NOT`',
    `catalog_year` STRING COMMENT 'The academic catalog year (e.g., 2024-2025) in which this prerequisite rule was first published. Students are typically held to the prerequisite rules of their catalog year for degree planning and articulation agreement purposes.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `class_standing_required` STRING COMMENT 'Minimum academic class standing a student must have achieved to enroll in the controlling course. Derived from cumulative credit hours earned per institutional policy (e.g., junior requires 60+ credit hours).. Valid values are `freshman|sophomore|junior|senior|graduate|doctoral`',
    `concurrent_enrollment_allowed` BOOLEAN COMMENT 'Indicates whether a student may be simultaneously enrolled in the required course and the controlling course within the same term to satisfy a corequisite rule. True for corequisites; typically False for standard prerequisites.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this prerequisite rule record was first created in the system of record (Ellucian Banner or the curriculum management system). Supports audit trail and data lineage requirements.',
    `curriculum_approval_date` DATE COMMENT 'Date on which the institutional curriculum committee formally approved this prerequisite rule. Required for accreditation documentation (AACSB, ABET, HLC) and academic quality assurance records.',
    `dfw_impact_flag` BOOLEAN COMMENT 'Indicates whether this prerequisite rule was established or modified in response to analysis of the DFW (D-grade, F-grade, Withdrawal) rate for the controlling course. Supports institutional research and academic quality assurance reporting.',
    `effective_date` DATE COMMENT 'The calendar date on which this prerequisite rule becomes enforceable in the SIS registration system. Rules are applied to all registration attempts on or after this date for the applicable term.',
    `expiration_date` DATE COMMENT 'The calendar date after which this prerequisite rule is no longer enforced. Null for rules with no planned end date. Used when a curriculum revision sunsets an existing prerequisite requirement.',
    `last_reviewed_date` DATE COMMENT 'Date on which this prerequisite rule was most recently reviewed by the curriculum committee or department, regardless of whether any changes were made. Supports periodic review cycles required by accreditation bodies (HLC, SACSCOC, AACSB).',
    `minimum_credit_hours` DECIMAL(18,2) COMMENT 'Minimum number of credit hours (CR) a student must have earned overall or in a specific subject area prior to enrolling in the controlling course. Used for class-standing prerequisites (e.g., Junior standing: 60+ credit hours).',
    `minimum_gpa` DECIMAL(18,2) COMMENT 'Minimum cumulative GPA (Grade Point Average) a student must maintain to satisfy this prerequisite rule. Commonly used for upper-division or honors course prerequisites (e.g., 3.000 GPA required).',
    `minimum_grade` STRING COMMENT 'The minimum letter grade a student must have earned in the required course to satisfy this prerequisite. For example, C means a grade of C or better is required. Null when the rule type is test_score or when any passing grade is acceptable.. Valid values are `A|A-|B+|B|B-|C+|C|C-|D+|D|P|S`',
    `minimum_grade_points` DECIMAL(18,2) COMMENT 'Numeric GPA (Grade Point Average) equivalent of the minimum grade threshold (e.g., 2.00 for a C grade on a 4.0 scale). Supports automated SIS enforcement when letter-grade comparison is insufficient for transfer or non-standard grading schemes.',
    `minimum_test_score` DECIMAL(18,2) COMMENT 'The minimum score a student must achieve on the specified standardized test (test_type / test_subject_code) to satisfy this prerequisite rule. Scale varies by test (e.g., 550 for SAT Math, 22 for ACT, 3 for AP exam).',
    `nesting_level` STRING COMMENT 'Depth of this rule within a nested Boolean condition tree (0 = top-level, 1 = first nested group, 2 = second nested group, etc.). Supports complex prerequisite structures such as (A AND B) OR (C AND D).',
    `override_permission_level` STRING COMMENT 'Highest authority level permitted to grant a prerequisite override for a student who does not meet this rule. none means no override is allowed; instructor allows the course instructor to waive; department_chair requires chair approval; registrar requires Registrar office action; dean requires dean-level approval.. Valid values are `none|instructor|department_chair|registrar|dean`',
    `override_requires_documentation` BOOLEAN COMMENT 'Indicates whether a prerequisite override request must be accompanied by supporting documentation (e.g., transfer transcript, test score report, instructor approval form) before the SIS will permit enrollment.',
    `program_enrollment_required` BOOLEAN COMMENT 'Indicates whether the student must be actively enrolled in a specific academic program or major to satisfy this prerequisite rule. When True, the program_id field identifies the required program.',
    `rationale` STRING COMMENT 'Academic justification for why this prerequisite rule exists, as documented during the curriculum approval process. Used in accreditation self-studies (AACSB, ABET, HLC) to demonstrate alignment between course prerequisites and Student Learning Outcomes (SLOs).',
    `rule_code` STRING COMMENT 'Institution-assigned alphanumeric code uniquely identifying this prerequisite rule within the SIS (e.g., PREREQ-CALC1-001). Used for cross-system reference in Banner SFAREGS and academic advising tools.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `rule_description` STRING COMMENT 'Human-readable narrative description of the prerequisite rule as it appears in the course catalog and student-facing degree planning tools (e.g., Students must complete MATH 1510 with a grade of C or better, or achieve a score of 550 or higher on the SAT Math section).',
    `rule_sequence` STRING COMMENT 'Numeric ordering of this rule within its rule group, controlling the evaluation sequence for nested Boolean logic. Lower sequence numbers are evaluated first.',
    `rule_status` STRING COMMENT 'Current lifecycle state of the prerequisite rule. active rules are enforced in real-time SIS registration; pending_approval rules are awaiting curriculum committee sign-off; retired rules are preserved for historical audit.. Valid values are `active|inactive|pending_approval|retired|draft`',
    `rule_type` STRING COMMENT 'Classifies the nature of the enrollment eligibility rule. prerequisite requires prior completion; corequisite requires concurrent enrollment; anti_requisite prohibits enrollment if the course was already taken; pre_or_corequisite allows either; test_score requires a qualifying standardized test score.. Valid values are `prerequisite|corequisite|anti_requisite|pre_or_corequisite|test_score`',
    `sis_enforcement_flag` BOOLEAN COMMENT 'Indicates whether this prerequisite rule is actively enforced in real-time by the Student Information System (SIS) during the Banner SFAREGS registration process. When False, the rule is advisory only and does not block enrollment.',
    `test_subject_code` STRING COMMENT 'Subject area code for the standardized test component that must meet the minimum score threshold (e.g., MATH for SAT Math, ENG for ACT English, CALC for AP Calculus AB). Used in conjunction with test_type and minimum_test_score.. Valid values are `^[A-Z0-9]{2,10}$`',
    `test_type` STRING COMMENT 'Type of standardized test whose score may satisfy this prerequisite rule when rule_type is test_score. Includes SAT (Scholastic Assessment Test), ACT (American College Testing), AP (Advanced Placement), CLEP, TOEFL (Test of English as a Foreign Language), IELTS (International English Language Testing System), GRE (Graduate Record Examination), GMAT (Graduate Management Admission Test), or institutional PLACEMENT exam. [ENUM-REF-CANDIDATE: SAT|ACT|AP|CLEP|TOEFL|IELTS|GRE|GMAT|PLACEMENT — promote to reference product]',
    `transfer_credit_applicable` BOOLEAN COMMENT 'Indicates whether an equivalent course completed at another institution and accepted as transfer credit can satisfy this prerequisite rule. When True, the SIS evaluates transfer equivalency records during registration validation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this prerequisite rule record. Used for incremental ETL (Extract Transform Load) processing in the Databricks Silver Layer and for audit trail compliance.',
    CONSTRAINT pk_prerequisite_rule PRIMARY KEY(`prerequisite_rule_id`)
) COMMENT 'Defines prerequisite, corequisite, and anti-requisite relationships for courses, enforcing enrollment eligibility rules during registration. Captures the controlling course (the course requiring the prerequisite), the required course(s) or standardized test scores (SAT, ACT, AP, placement exam), minimum grade threshold (e.g., C or better), concurrent enrollment allowance for corequisites, override permission levels (instructor, department chair, registrar), and complex Boolean logic (AND/OR groupings, nested conditions). Supports real-time registration enforcement in SIS (Banner SFAREGS), academic advising, and degree planning tools.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`slo` (
    `slo_id` BIGINT COMMENT 'Unique surrogate identifier for the Student Learning Outcome (SLO) record in the curriculum domain. Primary key for this entity.',
    `academic_program_id` BIGINT COMMENT 'Optional reference to the academic program to which this SLO contributes, enabling curriculum mapping from course-level SLOs up to Program Learning Outcomes (PLOs). Nullable when the SLO is course-scoped only.',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Student learning outcomes are assessed and tracked through specialized assessment management enterprise applications (Taskstream, Anthology, Watermark). Required for accreditation reporting, program r',
    `course_id` BIGINT COMMENT 'Reference to the course with which this Student Learning Outcome (SLO) is associated. Each SLO is scoped to a specific course in the curriculum catalog.',
    `superseded_by_slo_id` BIGINT COMMENT 'Reference to the SLO record that replaces this one when a substantive revision creates a new SLO version. Nullable for current active SLOs. Enables curriculum lineage tracing and ensures historical assessment data can be linked to the correct outcome version.',
    `aacsb_standard_ref` STRING COMMENT 'Reference to the specific AACSB International Assurance of Learning (AoL) standard or learning goal to which this SLO is aligned (e.g., LG1-LO2: Written Communication). Required for business school accreditation self-studies and continuous improvement reporting submitted to AACSB.',
    `abet_outcome_ref` STRING COMMENT 'Reference to the specific ABET Criterion 3 student outcome to which this SLO is aligned (e.g., Outcome 1: Apply knowledge of mathematics, science, and engineering). Required for engineering and computing program accreditation self-studies submitted to ABET.',
    `approval_date` DATE COMMENT 'Date on which this SLO was formally approved by the curriculum committee or academic governance body. Required for accreditation self-study documentation to demonstrate systematic curriculum review processes.',
    `approval_status` STRING COMMENT 'Status of this SLO within the institutional curriculum approval workflow. Pending means submitted for review; approved means formally ratified by the curriculum committee; rejected means not approved; revision_required means returned to the originator for changes. Supports governance and QA processes.. Valid values are `pending|approved|rejected|revision_required`',
    `approved_by` STRING COMMENT 'Name or identifier of the curriculum committee, faculty governance body, or academic officer who formally approved this SLO. Provides an audit trail for accreditation documentation and institutional governance records.',
    `assessment_frequency` STRING COMMENT 'How frequently this SLO is formally assessed and reported. Every_term means assessed each time the course is offered; annual means once per academic year; biennial means every two years; rotating means assessed on a departmentally defined rotation schedule. Drives assessment planning calendars.. Valid values are `every_term|annual|biennial|rotating`',
    `assessment_level` STRING COMMENT 'Scope at which this SLO is assessed: course-level (within a single course section), program-level (aggregated across multiple course sections within a program), or institutional-level (contributing to institution-wide general education or core competency assessment).. Valid values are `course|program|institutional`',
    `assessment_method` STRING COMMENT 'Primary method used to assess student attainment of this SLO (e.g., written exam, rubric-scored essay, lab report, oral presentation, portfolio, standardized test, capstone project). Informs Canvas LMS gradebook configuration and accreditation assessment plans. [ENUM-REF-CANDIDATE: written_exam|rubric_essay|lab_report|oral_presentation|portfolio|standardized_test|capstone_project|simulation|case_study|performance_task — promote to reference product]',
    `assessment_tool` STRING COMMENT 'Specific instrument or tool used to measure student performance on this SLO (e.g., AAC&U VALUE Rubric, ETS Major Field Test, departmental rubric name, standardized exam code). Provides traceability between the SLO and its measurement instrument for accreditation evidence.',
    `banner_outcome_code` STRING COMMENT 'Source system identifier for this SLO as stored in Ellucian Banners academic history and curriculum modules. Used for ETL reconciliation between Banner (system of record) and the Databricks Silver Layer data product.',
    `blooms_domain` STRING COMMENT 'Domain of learning as classified by Blooms Taxonomy: cognitive (knowledge and intellectual skills), affective (attitudes, values, and feelings), or psychomotor (physical and procedural skills). Supports comprehensive curriculum design and accreditation reporting.. Valid values are `cognitive|affective|psychomotor`',
    `blooms_taxonomy_level` STRING COMMENT 'Cognitive level of the learning outcome as classified by Blooms Revised Taxonomy (Anderson & Krathwohl, 2001). Drives assessment design and curriculum rigor analysis. Values: remember, understand, apply, analyze, evaluate, create — ordered from lower-order to higher-order thinking.. Valid values are `remember|understand|apply|analyze|evaluate|create`',
    `cip_code` STRING COMMENT 'Six-digit CIP (Classification of Instructional Programs) code associated with the discipline of this SLO, following the NCES taxonomy (e.g., 52.0301 for Accounting). Used for IPEDS reporting, program benchmarking, and cross-institutional curriculum comparisons.. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLO record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides the audit trail entry point for data governance, lineage tracking, and accreditation evidence of when outcomes were formally documented.',
    `credit_hour_type` STRING COMMENT 'Type of instructional activity associated with the course section in which this SLO is assessed. Relevant for determining appropriate assessment methods and Carnegie Unit compliance. Values align with federal credit hour definitions under 34 CFR 600.2.. Valid values are `lecture|lab|studio|clinical|seminar|independent_study`',
    `curriculum_map_level` STRING COMMENT 'Indicates the level at which this SLO is addressed in the curriculum map for the associated program: introduced (first exposure), developed (reinforced and practiced), or mastered (demonstrated at capstone level). Standard taxonomy used in AACSB and ABET curriculum mapping documentation.. Valid values are `introduced|developed|mastered`',
    `delivery_modality` STRING COMMENT 'Instructional delivery modality for which this SLO is applicable. Some SLOs may be modality-specific (e.g., lab-based outcomes only apply to face-to-face sections). Supports modality-disaggregated assessment reporting required by accreditors for distance education programs.. Valid values are `face_to_face|online|hybrid|hyflex`',
    `effective_term` STRING COMMENT 'The academic term in which this SLO first became effective, expressed as a four-digit year followed by a term code (e.g., 2024FA for Fall 2024, 2025SP for Spring 2025). Supports term-over-term curriculum change tracking and accreditation cycle reporting.. Valid values are `^[0-9]{4}(FA|SP|SU|WI)$`',
    `faculty_lead` STRING COMMENT 'Name or employee identifier of the faculty member designated as the primary lead for assessing and reporting on this SLO. This individual is responsible for collecting assessment evidence, analyzing results, and submitting improvement plans to the curriculum committee.',
    `hlc_criterion_ref` STRING COMMENT 'Reference to the specific HLC (Higher Learning Commission) Criterion for Accreditation to which this SLO contributes evidence (e.g., Criterion 4.B: The institution demonstrates a commitment to educational achievement and improvement through ongoing assessment of student learning). Supports regional accreditation self-study documentation.',
    `is_core_outcome` BOOLEAN COMMENT 'Indicates whether this SLO is designated as a core or primary outcome for the course (True) versus a supplementary or supporting outcome (False). Core outcomes are typically required to be assessed every term; supplementary outcomes may be assessed on a rotating schedule.',
    `is_general_education` BOOLEAN COMMENT 'Indicates whether this SLO is designated as a General Education (Gen Ed) outcome (True), meaning it contributes to the institutions general education assessment framework and may be reported to regional accreditors as evidence of broad learning competencies.',
    `is_stem_designated` BOOLEAN COMMENT 'Indicates whether this SLO is associated with a STEM (Science, Technology, Engineering, Mathematics) designated course or program. Relevant for NSF grant reporting, IPEDS STEM program classification, and OPT extension eligibility tracking for international students.',
    `last_reviewed_date` DATE COMMENT 'Date on which this SLO was most recently reviewed for currency, rigor, and alignment with program goals. Accreditors require evidence of systematic, ongoing review of learning outcomes. Supports identification of SLOs overdue for review.',
    `lms_outcome_code` STRING COMMENT 'External identifier for this SLO as recorded in the Canvas LMS Outcomes module. Enables bidirectional traceability between the authoritative curriculum data product and the LMS gradebook alignment, supporting automated assessment data collection from Canvas.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this SLO as part of the institutions continuous improvement and assessment cycle. Enables proactive curriculum governance and ensures compliance with accreditor-mandated review frequencies.',
    `notes` STRING COMMENT 'Free-text field for additional context, clarifications, or implementation guidance related to this SLO. May include notes from curriculum committee reviews, faculty feedback, or accreditor recommendations. Not used for structured data.',
    `oer_aligned` BOOLEAN COMMENT 'Indicates whether the primary instructional materials used to achieve this SLO are designated as OER (Open Educational Resources), meaning freely available and openly licensed. Supports institutional OER adoption tracking, affordability reporting, and grant compliance for OER initiatives.',
    `outcome_statement` STRING COMMENT 'Full narrative statement describing the measurable competency students are expected to demonstrate upon completing the course. Written in observable, measurable terms aligned with Blooms Taxonomy (e.g., Students will be able to analyze financial statements using ratio analysis). This is the authoritative text used in syllabi, accreditation self-studies, and curriculum maps.',
    `outcome_status` STRING COMMENT 'Current lifecycle status of the SLO record. Active SLOs are in use for the current or upcoming academic term. Draft SLOs are under development. Under_review SLOs are in the curriculum approval workflow. Retired SLOs are no longer assessed but retained for historical reporting.. Valid values are `active|inactive|draft|under_review|retired`',
    `owner_department` STRING COMMENT 'Name or code of the academic department responsible for maintaining and assessing this SLO (e.g., Department of Accounting, School of Engineering). Supports departmental assessment reporting, faculty workload attribution, and accreditation unit-level reporting.',
    `performance_threshold_pct` DECIMAL(18,2) COMMENT 'Minimum percentage of assessed students expected to meet or exceed the proficiency benchmark for this SLO, as defined in the assessment plan (e.g., 70.00 means 70% of students must demonstrate proficiency). Used to determine whether the SLO has been met in annual assessment reporting and accreditation self-studies.',
    `plo_alignment` STRING COMMENT 'Code or identifier of the Program Learning Outcome (PLO) to which this course-level SLO contributes, enabling curriculum mapping from SLO to PLO. Supports program-level assessment aggregation and accreditation curriculum maps. Distinct from program_id — this references the specific PLO statement, not the program entity.',
    `proficiency_benchmark` STRING COMMENT 'Qualitative or quantitative description of the minimum acceptable performance standard for this SLO (e.g., Score of 3 or higher on a 4-point rubric, Correctly answers 75% of exam items mapped to this outcome). Complements performance_threshold_pct with narrative context for accreditation documentation.',
    `retirement_term` STRING COMMENT 'The academic term in which this SLO was retired or superseded. Nullable for active SLOs. Enables historical curriculum mapping and ensures retired outcomes are excluded from current assessment cycles while remaining available for longitudinal analysis.. Valid values are `^[0-9]{4}(FA|SP|SU|WI)$`',
    `sacscoc_standard_ref` STRING COMMENT 'Reference to the specific SACSCOC (Southern Association of Colleges and Schools Commission on Colleges) Principles of Accreditation standard to which this SLO is aligned (e.g., Standard 8.2: Student Outcomes: Educational Programs). Applicable for institutions in the SACSCOC region.',
    `scorm_objective_code` STRING COMMENT 'Identifier mapping this SLO to a SCORM (Sharable Content Object Reference Model) learning objective within a packaged e-learning module deployed in the LMS. Enables automated tracking of objective completion data from SCORM-compliant content packages.',
    `slo_code` STRING COMMENT 'Institutionally assigned alphanumeric code uniquely identifying this SLO within the course or program context. Used in accreditation reports, curriculum maps, and assessment tracking systems. Example: ACCT301-SLO-001.. Valid values are `^[A-Z0-9]{2,10}-SLO-[0-9]{3}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLO record was most recently modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports change detection in ETL pipelines, audit trails, and curriculum change management processes.',
    `version_number` STRING COMMENT 'Integer version number of this SLO record, incremented each time the outcome statement, assessment method, or benchmark is substantively revised through the curriculum approval workflow. Enables longitudinal tracking of outcome evolution across accreditation cycles.',
    CONSTRAINT pk_slo PRIMARY KEY(`slo_id`)
) COMMENT 'Student Learning Outcome (SLO) master record defining the measurable competencies students are expected to demonstrate upon completing a course. Captures outcome statement, Blooms taxonomy level, assessment method, alignment to accreditation standards (AACSB, ABET, HLC), active status, and the owning course or program. Serves as the foundational unit for course-level assessment and curriculum mapping. Distinct from PLO (Program Learning Outcome) which is program-scoped.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`plo` (
    `plo_id` BIGINT COMMENT 'Unique surrogate identifier for the Program Learning Outcome (PLO) record in the curriculum data product.',
    `academic_program_id` BIGINT COMMENT 'Reference to the academic program (degree or certificate program) to which this PLO belongs. Links PLO to its parent program record.',
    `employee_id` BIGINT COMMENT 'Reference to the faculty member or staff person designated as the primary lead responsible for coordinating assessment of this PLO within the program.',
    `prior_version_plo_id` BIGINT COMMENT 'Reference to the previous version of this PLO record if it was revised and a new record created. Enables curriculum change lineage tracking and accreditation historical documentation.',
    `accreditation_standard_code` STRING COMMENT 'Specific accreditation standard or criterion code to which this PLO is aligned (e.g., AACSB Standard 4, ABET Criterion 3, SACSCOC 8.2, HLC 4.B). Enables direct traceability from PLO to accreditor requirement in self-study reports.',
    `accrediting_body` STRING COMMENT 'Name of the accrediting body whose standards this PLO is designed to satisfy. Supports multi-accreditor programs (e.g., a business school may be subject to both AACSB and HLC). [ENUM-REF-CANDIDATE: AACSB|ABET|SACSCOC|HLC|MSCHE|NWCCU|NECHE|WSCUC|ABA|LCME|none|other — promote to reference product]',
    `approval_date` DATE COMMENT 'Date on which this PLO was formally approved through the institutions curriculum governance process (e.g., curriculum committee, faculty senate, academic affairs). Required for accreditation documentation.',
    `approved_by` STRING COMMENT 'Name or title of the governance body or individual who formally approved this PLO (e.g., Undergraduate Curriculum Committee, Dean of Academic Affairs). Provides audit trail for accreditation self-studies.',
    `assessment_cycle` STRING COMMENT 'Frequency at which this PLO is formally assessed and reported: annual, biennial (every two years), triennial (every three years), continuous, or other. Drives the assessment calendar and accreditation reporting schedule.. Valid values are `annual|biennial|triennial|continuous|other`',
    `assessment_method` STRING COMMENT 'Primary method used to assess student achievement of this PLO (e.g., capstone project, standardized exam, portfolio review, rubric-scored assignment, licensure exam, employer survey). Documented for accreditation assessment plans.',
    `assessment_tool_name` STRING COMMENT 'Name of the primary instrument or tool used to assess this PLO (e.g., Capstone Project Rubric, ETS Major Field Test, NCLEX-RN, CPA Exam, Portfolio Assessment Rubric). Supports assessment plan documentation.',
    `bloom_taxonomy_level` STRING COMMENT 'Cognitive level of the learning outcome as classified by Blooms Revised Taxonomy (Anderson & Krathwohl, 2001): remember, understand, apply, analyze, evaluate, or create. Used in curriculum design quality assurance and SLO alignment.. Valid values are `remember|understand|apply|analyze|evaluate|create`',
    `catalog_year` STRING COMMENT 'Academic catalog year in which this PLO was first published (e.g., 2023-2024). Ties the PLO to the official program catalog for a given academic year, supporting student rights under catalog year policies.. Valid values are `^d{4}-d{4}$`',
    `cip_code` STRING COMMENT 'Six-digit CIP code (XX.XXXX format) assigned by the U.S. Department of Education classifying the instructional program discipline to which this PLO belongs. Required for IPEDS reporting and federal program approval.. Valid values are `^d{2}.d{4}$`',
    `course_count` STRING COMMENT 'Number of courses in the program curriculum that are mapped to this PLO. Provides a quick indicator of instructional coverage breadth. Note: authoritative count is derived from course-PLO mapping associations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PLO record was first created in the system. Provides audit trail for curriculum governance and accreditation documentation.',
    `degree_level` STRING COMMENT 'Academic credential level of the program to which this PLO applies: certificate, associate, bachelor, master, doctoral, or professional. Determines the rigor and complexity expectations for the outcome. [ENUM-REF-CANDIDATE: certificate|associate|bachelor|master|doctoral|professional|other — 7 candidates stripped; promote to reference product]',
    `direct_indirect_indicator` STRING COMMENT 'Indicates whether the primary assessment method for this PLO is direct (measures student performance on the outcome directly, e.g., exam, project), indirect (measures student perception or satisfaction, e.g., survey, alumni feedback), or both. Accreditors typically require at least one direct measure per PLO.. Valid values are `direct|indirect|both`',
    `domain_area` STRING COMMENT 'Disciplinary or thematic domain area to which this PLO belongs within the program (e.g., Quantitative Reasoning, Ethical Leadership, Technical Communication, Research Methods). Supports curriculum mapping and outcome clustering for assessment reporting.',
    `effective_date` DATE COMMENT 'Date on which this PLO became or becomes officially effective for the program. Marks the start of the assessment obligation for this outcome.',
    `improvement_action_notes` STRING COMMENT 'Free-text notes documenting closing the loop actions taken based on assessment results for this PLO (e.g., curriculum changes, pedagogical adjustments, resource additions). Required by accreditors to demonstrate use of assessment data for improvement.',
    `institutional_mission_alignment` STRING COMMENT 'Narrative description of how this PLO aligns to the institutions stated mission, strategic plan, or core values. Required for regional accreditation self-studies demonstrating mission-driven curriculum design.',
    `is_accreditation_required` BOOLEAN COMMENT 'Indicates whether this PLO is mandated by a specific accrediting bodys standards (True) or is an institutionally defined outcome beyond accreditor minimums (False). Supports gap analysis during accreditation self-study preparation.',
    `is_core_outcome` BOOLEAN COMMENT 'Indicates whether this PLO is designated as a core or required outcome for all graduates of the program (True), as opposed to a concentration-specific or elective outcome (False). Core outcomes are typically required for all accreditation reporting.',
    `is_general_education` BOOLEAN COMMENT 'Indicates whether this PLO is also designated as a General Education (Gen Ed) outcome applicable across multiple programs at the institution (True) or is program-specific (False). Supports institutional general education assessment reporting.',
    `last_reviewed_date` DATE COMMENT 'Date on which this PLO was most recently reviewed by the program faculty or curriculum committee, regardless of whether changes were made. Supports continuous improvement documentation required by accreditors.',
    `next_review_date` DATE COMMENT 'Date on which this PLO is next scheduled for formal review by the program faculty or curriculum committee. Drives the assessment calendar and ensures timely accreditation compliance.',
    `notes` STRING COMMENT 'Free-text administrative notes or contextual information about this PLO not captured in other structured fields. May include rationale for outcome design, cross-program alignment notes, or accreditor feedback.',
    `outcome_category` STRING COMMENT 'Broad category classifying the type of learning outcome: knowledge (cognitive understanding), skill (applied ability), disposition (attitude or value), competency (integrated performance), or other. Supports Blooms Taxonomy alignment and accreditation reporting.. Valid values are `knowledge|skill|disposition|value|competency|other`',
    `outcome_statement` STRING COMMENT 'Full narrative statement describing the measurable competency, knowledge, skill, or disposition that graduates of the program are expected to demonstrate upon completion. Written in observable, assessable language per accreditation standards.',
    `outcome_status` STRING COMMENT 'Current lifecycle status of the PLO: draft (being developed), active (in use for assessment), under_review (undergoing curriculum revision), suspended (temporarily paused), or retired (no longer assessed). Governs whether the PLO appears in active assessment plans.. Valid values are `draft|active|under_review|suspended|retired`',
    `plo_code` STRING COMMENT 'Institutionally assigned alphanumeric code uniquely identifying this PLO within the program (e.g., PLO-01, CS-PLO-03). Used in accreditation self-studies and curriculum mapping documents.. Valid values are `^[A-Z0-9]{2,20}$`',
    `proficiency_scale_max` DECIMAL(18,2) COMMENT 'Maximum possible score on the assessment instrument used to measure this PLO (e.g., 4.0 for a rubric, 100 for a percentage scale). Provides context for interpreting the proficiency threshold score.',
    `proficiency_threshold_score` DECIMAL(18,2) COMMENT 'Minimum score or rubric rating a student must achieve on the designated assessment instrument to be counted as meeting this PLO. Expressed in the scale of the assessment tool (e.g., 3.0 on a 4-point rubric, 70 on a 100-point scale).',
    `retirement_date` DATE COMMENT 'Date on which this PLO was or will be retired and removed from active assessment plans. Null if the PLO is currently active. Supports historical curriculum audit trails.',
    `sequence_number` STRING COMMENT 'Ordinal position of this PLO within the programs ordered list of learning outcomes (e.g., 1, 2, 3). Used for display ordering in accreditation reports, syllabi, and assessment plans.',
    `slo_count` STRING COMMENT 'Number of Student Learning Outcomes (SLOs) currently mapped to this PLO through the slo_plo_mapping association. Provides a quick indicator of curriculum coverage depth for this outcome. Note: this is a denormalized convenience field; authoritative count is derived from slo_plo_mapping.',
    `strategic_goal_reference` STRING COMMENT 'Reference code or label of the institutional strategic plan goal or objective to which this PLO contributes (e.g., Strategic Goal 2: Student Success). Supports institutional effectiveness reporting.',
    `target_benchmark_pct` DECIMAL(18,2) COMMENT 'Minimum percentage of assessed students expected to meet or exceed the proficiency threshold for this PLO (e.g., 70.00 means 70% of students must demonstrate proficiency). Used as the success criterion in assessment reporting and accreditation self-studies.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this PLO record was most recently modified. Supports change detection in ETL pipelines and curriculum governance audit trails.',
    `version_number` STRING COMMENT 'Version identifier for this PLO statement (e.g., 1.0, 2.1). Incremented when the outcome statement or assessment criteria are substantively revised. Supports curriculum change history and accreditation audit trails.. Valid values are `^d+.d+$`',
    CONSTRAINT pk_plo PRIMARY KEY(`plo_id`)
) COMMENT 'Program Learning Outcome (PLO) master record defining the measurable competencies graduates of an academic program are expected to demonstrate. Captures outcome statement, associated accreditation standard (AACSB, ABET, SACSCOC), assessment cycle, target performance benchmark, and alignment to institutional mission. PLOs are mapped to SLOs through the slo_plo_mapping association. Supports program-level assessment reporting and accreditation self-studies.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`map` (
    `map_id` BIGINT COMMENT 'Unique surrogate identifier for each curriculum map record linking a course to a Program Learning Outcome (PLO) within an academic program. Serves as the primary key for this Silver Layer data product.',
    `academic_program_id` BIGINT COMMENT 'Reference to the academic degree or certificate program within which this curriculum map entry exists. Establishes the program-level context for PLO alignment.',
    `assessment_instrument_id` BIGINT COMMENT 'Reference to the assessment instrument (e.g., rubric, exam, project, portfolio) used within this course to measure student attainment of the mapped PLO.',
    `accreditation_standard_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_standard. Business justification: Curriculum maps demonstrate how course sequences meet specific accreditor standards. Essential for accreditation self-studies showing standards compliance through curriculum design. Core accreditation',
    `course_id` BIGINT COMMENT 'Reference to the specific course in the course catalog that is mapped to the PLO. Identifies which course contributes to the learning outcome.',
    `instructor_id` BIGINT COMMENT 'Reference to the faculty member (typically the course coordinator or program director) responsible for maintaining this curriculum map entry and ensuring PLO assessment is conducted. Links to the HR employee record.',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Curriculum maps are created and maintained in specialized enterprise applications for accreditation compliance and program assessment. Accreditation bodies (AACSB, ABET, HLC) require documented curric',
    `plo_id` BIGINT COMMENT 'Reference to the specific Program Learning Outcome (PLO) that this course is mapped to. PLOs define the competencies graduates are expected to demonstrate upon program completion.',
    `academic_year` STRING COMMENT 'The academic year in which this curriculum map entry is effective (e.g., 2024-2025). Supports versioning of curriculum maps across catalog years and accreditation review cycles.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `accreditation_body` STRING COMMENT 'The accreditation organization whose standards govern this curriculum map entry (e.g., AACSB, ABET, HLC, SACSCOC, LCME, ABA). Determines which assurance-of-learning or criterion-based reporting requirements apply. [ENUM-REF-CANDIDATE: AACSB|ABET|HLC|SACSCOC|MSCHE|NWCCU|NECHE|WSCUC|LCME|ABA|AACSB_ABET — promote to reference product]',
    `accreditation_standard_ref` STRING COMMENT 'Specific accreditation standard or criterion that this curriculum map entry satisfies (e.g., AACSB Standard 8 - Assurance of Learning, ABET Criterion 3 - Student Outcomes). Enables direct traceability from curriculum map to accreditation evidence.',
    `assessment_method` STRING COMMENT 'Indicates whether the assessment of the PLO in this course uses direct evidence (e.g., exams, projects, rubric-scored artifacts), indirect evidence (e.g., surveys, self-reports), or both. Accreditation bodies require a mix of direct and indirect assessment evidence.. Valid values are `direct|indirect|both`',
    `catalog_year` STRING COMMENT 'The academic catalog year under which this curriculum map entry is published (e.g., 2024-2025). Students follow degree requirements from their catalog year; curriculum maps must be versioned accordingly for compliance and advising.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `cip_code` STRING COMMENT 'The six-digit CIP (Classification of Instructional Programs) code assigned to the academic program by the National Center for Education Statistics (NCES). Used for federal reporting (IPEDS), accreditation, and program classification (e.g., 11.0701 for Computer Science).. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `closing_loop_action` STRING COMMENT 'Description of the curricular or instructional improvement action taken in response to PLO assessment results for this course-PLO mapping (e.g., Added additional case studies to reinforce analytical reasoning PLO, Revised rubric criteria for written communication). Core component of AACSB Assurance of Learning closing-the-loop documentation.',
    `college_name` STRING COMMENT 'Name of the college or school within the institution that houses the academic program (e.g., College of Engineering, School of Business). Used for accreditation unit-level reporting (AACSB, ABET) and institutional analytics.',
    `coverage_level` STRING COMMENT 'Indicates the depth at which the PLO is addressed in this course: I = Introduced (first exposure), R = Reinforced (practiced and developed), M = Mastered (demonstrated at program exit level). This I/R/M taxonomy is the standard framework used in AACSB Assurance of Learning and ABET Criterion 3 curriculum mapping.. Valid values are `I|R|M`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this curriculum map record was first created in the system. Provides the audit trail creation marker required for data governance and accreditation evidence management.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Number of credit hours (CR) assigned to the course in this curriculum map entry. Used to weight the courses contribution to the programs total credit hour requirements and to calculate PLO coverage intensity across the curriculum.',
    `curriculum_committee_approval_date` DATE COMMENT 'Date on which the curriculum committee formally approved this curriculum map entry. Establishes the official governance record for accreditation audit trails and catalog publication timelines.',
    `degree_level` STRING COMMENT 'The level of the academic credential associated with this program (e.g., bachelor, master, doctoral). Used to segment curriculum maps by degree tier for accreditation reporting and institutional analytics.. Valid values are `associate|bachelor|master|doctoral|certificate|professional`',
    `delivery_modality` STRING COMMENT 'The instructional delivery format for the course in this curriculum map entry: in_person = face-to-face; online = fully asynchronous/synchronous online; hybrid = blended in-person and online; hyflex = simultaneous in-person and online; mooc = Massive Open Online Course (MOOC). Relevant for accreditation distance education reviews.. Valid values are `in_person|online|hybrid|hyflex|mooc`',
    `department_code` STRING COMMENT 'Code identifying the academic department responsible for delivering the course in this curriculum map entry (e.g., CS, MGMT, ENGR). Used for departmental curriculum reporting and accreditation unit-level analysis.. Valid values are `^[A-Z0-9]{2,10}$`',
    `effective_end_date` DATE COMMENT 'Date on which this curriculum map entry ceases to be effective, typically aligned with a catalog year transition or program revision. Null indicates the entry is currently active. Supports historical curriculum map versioning.',
    `effective_start_date` DATE COMMENT 'Date from which this curriculum map entry is effective and applicable to students enrolled under the corresponding catalog year. Supports temporal versioning of curriculum maps across accreditation cycles.',
    `gap_analysis_notes` STRING COMMENT 'Free-text notes documenting identified gaps in PLO coverage, redundancies, or areas requiring curriculum revision as identified during curriculum gap analysis reviews. Supports closing-the-loop actions in Assurance of Learning (AoL) cycles.',
    `is_capstone` BOOLEAN COMMENT 'Indicates whether this course serves as a capstone or culminating experience for the program. Capstone courses are typically the primary site for PLO mastery-level assessment and are highlighted in accreditation self-studies.',
    `is_oer_designated` BOOLEAN COMMENT 'Indicates whether the course uses Open Educational Resources (OER) as the primary instructional materials, eliminating or significantly reducing textbook costs for students. Supports institutional OER adoption tracking and affordability reporting.',
    `is_writing_intensive` BOOLEAN COMMENT 'Indicates whether this course is designated as writing intensive, requiring substantial written work as a primary mode of learning and assessment. Relevant for general education requirements, accreditation, and curriculum gap analysis for written communication PLOs.',
    `last_reviewed_date` DATE COMMENT 'Date on which this curriculum map entry was most recently reviewed by the program faculty or curriculum committee. Supports accreditation requirements for regular curriculum review cycles (typically annual or per accreditation cycle).',
    `map_status` STRING COMMENT 'Current lifecycle status of this curriculum map entry within the curriculum approval workflow. draft = under initial development; active = approved and in use; under_review = submitted for curriculum committee review; approved = formally approved by governance body; retired = no longer in use.. Valid values are `draft|active|under_review|approved|retired`',
    `next_review_date` DATE COMMENT 'Date by which this curriculum map entry is scheduled for its next formal review. Supports proactive curriculum quality assurance and ensures compliance with accreditation body review cycle requirements.',
    `performance_target_pct` DECIMAL(18,2) COMMENT 'The minimum percentage of students expected to meet or exceed the proficiency threshold on the PLO assessment in this course (e.g., 70.00 means 70% of students must achieve the target score). Used in Assurance of Learning (AoL) closing-the-loop analysis.',
    `proficiency_threshold_score` DECIMAL(18,2) COMMENT 'The minimum score or rubric rating a student must achieve on the assessment instrument to be considered proficient on the mapped PLO (e.g., 3.0 on a 4-point rubric, or 75.00 on a 100-point scale). Defines the benchmark for PLO attainment.',
    `slo_alignment` STRING COMMENT 'Description of how the course-level Student Learning Outcome (SLO) aligns with and contributes to the mapped Program Learning Outcome (PLO). Provides the narrative linkage between course-level and program-level assessment for accreditation documentation.',
    `term_sequence_position` STRING COMMENT 'Ordinal position of the course within the programs recommended term sequence (e.g., 1 = first term, 4 = fourth term). Used to visualize the progression of PLO coverage across the curriculum and identify gaps in the learning sequence.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this curriculum map record was most recently modified. Supports change tracking, audit compliance, and identification of stale curriculum map entries requiring review.',
    `version_number` STRING COMMENT 'Integer version number of this curriculum map entry, incremented each time the mapping is revised through the curriculum approval workflow. Supports audit trail and historical comparison of curriculum map changes across accreditation cycles.',
    CONSTRAINT pk_map PRIMARY KEY(`map_id`)
) COMMENT 'Structured mapping of courses within an academic program to the programs PLOs, showing where each outcome is introduced, reinforced, and mastered across the curriculum sequence. Captures the program, the course, the PLO, the coverage level (I/R/M), the term sequence position, and the assessment instrument used. Supports accreditation reporting (AACSB Assurance of Learning, ABET Criterion 3) and curriculum gap analysis.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`course_proposal` (
    `course_proposal_id` BIGINT COMMENT 'Unique surrogate identifier for the course proposal record in the curriculum management system. Primary key for this entity.',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: Course proposals specify the academic term when the new/revised course becomes available for registration. Curriculum approval workflow requires term context for SIS integration, catalog publication, ',
    `course_id` BIGINT COMMENT 'Foreign key linking to curriculum.course. Business justification: When proposal_type is modify or discontinue, the proposal must reference the existing course being modified or discontinued. This FK enables the workflow to link back to the authoritative course r',
    `service_request_id` BIGINT COMMENT 'Foreign key linking to technology.service_request. Business justification: New course proposals trigger IT service requests for LMS course shell creation, software license provisioning, classroom technology setup, and specialized lab software installation. Workflow automatio',
    `bib_record_id` BIGINT COMMENT 'Foreign key linking to library.bib_record. Business justification: New course proposals require library review to verify adequate resources exist. Curriculum approval workflow includes library impact statement citing specific holdings. The library_resource_adequate_f',
    `org_unit_id` BIGINT COMMENT 'Identifier of the academic department submitting the course proposal. Links to the organizational unit responsible for the proposed course.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: New course proposals must verify compliance with ADA accessibility standards, copyright law, and accreditation requirements. Required for curriculum approval workflows and accreditation documentation.',
    `employee_id` BIGINT COMMENT 'Identifier of the faculty or staff member who formally submitted the course proposal. Typically the course coordinator or department chair.',
    `accreditation_body` STRING COMMENT 'Name of the specialized accreditation body (e.g., AACSB, ABET, ABA, LCME) whose standards this course is designed to satisfy or contribute toward. Null if the course is not tied to a specialized accreditor. [ENUM-REF-CANDIDATE: AACSB|ABET|ABA|LCME|ACEN|CAEP|NASM — promote to reference product]',
    `banner_course_nmbr` STRING COMMENT 'The internal Banner Student Information System (SIS) course number assigned upon successful integration of the approved proposal into the SCACRSE course master. Null until Banner integration is complete.',
    `banner_integration_status` STRING COMMENT 'Status of the data integration process that loads the approved course proposal into the Ellucian Banner course master (SCACRSE). Tracks whether the approved course has been successfully activated in the Student Information System (SIS).. Valid values are `pending|in_progress|completed|failed`',
    `catalog_description` STRING COMMENT 'Official narrative description of the course content, learning objectives, and instructional approach as it will appear in the institutional academic catalog. Subject to curriculum committee review for clarity and accuracy.',
    `catalog_year` STRING COMMENT 'Academic catalog year (e.g., 2024-2025) in which the proposed course change will first appear. Used for degree audit catalog locking and student program requirement tracking.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `cip_code` STRING COMMENT 'Six-digit Classification of Instructional Programs (CIP) code assigned to the proposed course per the U.S. Department of Education taxonomy. Required for IPEDS reporting, state funding formulas, and program accreditation alignment.. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `college_approved_date` DATE COMMENT 'Date on which the college-level curriculum committee or dean formally approved the course proposal, advancing it to the institutional curriculum committee.',
    `committee_vote_date` DATE COMMENT 'Date on which the institutional curriculum committee conducted its formal vote on the course proposal. Recorded for governance transparency and accreditation audit trail.',
    `committee_vote_outcome` STRING COMMENT 'Formal outcome of the institutional curriculum committee vote on the course proposal. Drives subsequent workflow routing to provost office or back to the submitting department.. Valid values are `approved|approved_with_conditions|rejected|deferred|tabled`',
    `contact_hours_lab` DECIMAL(18,2) COMMENT 'Weekly scheduled laboratory or studio contact hours for the proposed course. Distinct from lecture hours for workload, scheduling, and accreditation compliance calculations.',
    `contact_hours_lecture` DECIMAL(18,2) COMMENT 'Weekly scheduled lecture contact hours for the proposed course. Used to verify compliance with the federal credit hour definition and accreditor seat-time requirements.',
    `corequisite_description` STRING COMMENT 'Free-text narrative description of courses or conditions that must be taken concurrently with this course. Displayed in the academic catalog and enforced in Banner registration controls.',
    `course_level` STRING COMMENT 'Academic level classification of the proposed course indicating the student population for which it is designed. Drives degree audit rules, financial aid eligibility, and accreditation reporting.. Valid values are `undergraduate|graduate|professional|doctoral|continuing_education`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the course proposal record was first created in the curriculum management system, including draft saves prior to formal submission.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Number of academic credit hours (CR) assigned to the proposed course. Determines student load calculations, financial aid eligibility, degree audit progress, and faculty workload. Aligns with federal credit hour definition (34 CFR 600.2).',
    `delivery_mode` STRING COMMENT 'Instructional delivery modality for the proposed course. Impacts room scheduling, technology resource requirements, financial aid eligibility for distance education, and accreditor substantive change review.. Valid values are `face_to_face|online|hybrid|hyflex|correspondence`',
    `department_approved_date` DATE COMMENT 'Date on which the department curriculum committee or department chair formally approved the course proposal, advancing it to the college-level review stage.',
    `effective_term` STRING COMMENT 'Banner term code (YYYYTT format, e.g., 202501 for Spring 2025) in which the approved course action takes effect in the course master and academic catalog. Populated upon final approval.. Valid values are `^[0-9]{6}$`',
    `grading_basis` STRING COMMENT 'Method by which student performance in the proposed course will be evaluated and recorded on the transcript. Affects GPA calculation, Satisfactory Academic Progress (SAP) determination, and degree audit.. Valid values are `letter_grade|pass_fail|satisfactory_unsatisfactory|audit|credit_no_credit`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the course proposal record, capturing any field-level change, status transition, or approver action.',
    `library_resource_adequate_flag` BOOLEAN COMMENT 'Indicates whether the institutions library resources (print, digital, Alma/Ex Libris holdings) are deemed adequate to support the proposed course, as confirmed by the library liaison review. Required for regional accreditation compliance.',
    `max_enrollment` STRING COMMENT 'Proposed maximum number of students permitted to enroll in a single section of this course. Informs room scheduling, faculty workload planning, and Archibus space utilization.',
    `oer_flag` BOOLEAN COMMENT 'Indicates whether the proposed course is designated to use Open Educational Resources (OER) as the primary instructional materials, eliminating or significantly reducing student textbook costs. Supports institutional affordability reporting.',
    `prerequisite_description` STRING COMMENT 'Free-text narrative description of prerequisite courses, minimum grade requirements, test scores, or other conditions students must satisfy before enrolling. Displayed in the academic catalog and enforced in Banner registration controls.',
    `proposal_number` STRING COMMENT 'Externally visible, human-readable reference number assigned to the course proposal upon submission (e.g., CP-2024-00123). Used in curriculum committee agendas, approval letters, and Banner integration.. Valid values are `^CP-[0-9]{4}-[0-9]{5}$`',
    `proposal_status` STRING COMMENT 'Current lifecycle state of the course proposal within the institutional curriculum approval workflow. Tracks progression from initial draft through final disposition. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|withdrawn|deferred — promote to reference product]',
    `proposal_type` STRING COMMENT 'Categorizes the nature of the curriculum action being requested: new course creation, modification of an existing course, deactivation/retirement, reactivation of a previously deactivated course, or experimental/pilot offering.. Valid values are `new|modify|deactivate|reactivate|experimental`',
    `provost_approved_date` DATE COMMENT 'Date on which the Provost or Chief Academic Officer granted final institutional approval for the course proposal, authorizing Banner course master integration.',
    `rationale` STRING COMMENT 'Narrative justification provided by the proposing department explaining the academic need, student demand, program alignment, or strategic rationale for the proposed course action. Required by curriculum committee for deliberation.',
    `repeat_credit_limit` DECIMAL(18,2) COMMENT 'Maximum total credit hours a student may earn by repeating this course. Applicable only when repeatable_flag is true. Used in degree audit and financial aid SAP calculations.',
    `repeatable_flag` BOOLEAN COMMENT 'Indicates whether students may enroll in this course more than once for additional credit (e.g., independent study, thesis, ensemble). When true, the repeat_credit_limit field governs maximum allowable credit accumulation.',
    `resource_impact_statement` STRING COMMENT 'Narrative assessment of the fiscal, staffing, library, technology, and facilities resources required to support the proposed course. Reviewed by college dean and provost office for budget and capacity planning.',
    `short_title` STRING COMMENT 'Abbreviated course title (typically 30 characters or fewer) used in Banner transcript display, schedule of classes, and systems with character-length constraints.',
    `slo_summary` STRING COMMENT 'Narrative summary of the Student Learning Outcomes (SLOs) for the proposed course, describing what students will know, value, or be able to do upon successful completion. Required for accreditation and curriculum quality assurance.',
    `stem_flag` BOOLEAN COMMENT 'Indicates whether the proposed course is classified as a Science, Technology, Engineering, or Mathematics (STEM) course per DHS/SEVIS STEM CIP code list. Relevant for international student visa compliance and OPT extension eligibility.',
    `submitted_date` DATE COMMENT 'Calendar date on which the course proposal was formally submitted by the originating department into the curriculum approval workflow. Serves as the principal business event date for this transaction.',
    `workflow_stage` STRING COMMENT 'Current stage in the multi-level curriculum approval workflow indicating which governance body currently holds the proposal for review or action (department, college, curriculum committee, provost office, or registrar for Banner integration).. Valid values are `department|college|curriculum_committee|provost|registrar|complete`',
    `writing_intensive_flag` BOOLEAN COMMENT 'Indicates whether the proposed course is designated as writing intensive, requiring substantial written work as a core pedagogical component. Used in general education requirement tracking and accreditation reporting.',
    CONSTRAINT pk_course_proposal PRIMARY KEY(`course_proposal_id`)
) COMMENT 'Transactional record capturing the formal workflow for proposing a new course, modifying an existing course, or deactivating a course through the institutional curriculum approval process. Tracks proposal type (new, modify, deactivate), submitting department, proposed changes, rationale, resource impact statement, workflow stage (department, college, curriculum committee, provost), approver actions, vote outcomes, and effective term. Integrates with Banner course master upon final approval.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`program_proposal` (
    `program_proposal_id` BIGINT COMMENT 'Unique identifier for the program proposal record. Primary key for tracking the formal approval workflow to create, modify, suspend, or discontinue an academic program.',
    `academic_program_id` BIGINT COMMENT 'Reference to the existing academic program if this proposal is a modification, suspension, or discontinuation. Null for new program proposals.',
    `department_org_unit_id` BIGINT COMMENT 'Reference to the academic department responsible for delivering the proposed program curriculum and managing faculty resources.',
    `service_request_id` BIGINT COMMENT 'Foreign key linking to technology.service_request. Business justification: New academic program proposals trigger IT service requests for infrastructure provisioning, application access, network resources, and specialized software. Program launch checklists require IT readin',
    `org_unit_id` BIGINT COMMENT 'Reference to the college or school that will house the proposed program and provide administrative oversight.',
    `employee_id` BIGINT COMMENT 'Reference to the faculty member or administrator who is the primary author and champion of the program proposal, responsible for shepherding it through the approval process.',
    `term_id` BIGINT COMMENT 'Reference to the academic term when the proposed program is planned to launch or when modifications will take effect, critical for catalog publication and student recruitment timelines.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: New program proposals require extensive regulatory review including HLC substantive change, state authorization, Title IV eligibility determination. Essential for program approval process and regulato',
    `state_authorization_id` BIGINT COMMENT 'Foreign key linking to compliance.state_authorization. Business justification: New programs trigger state authorization applications, especially for online delivery. Links proposal workflow to authorization tracking. Critical for launch planning and regulatory compliance timelin',
    `collection_id` BIGINT COMMENT 'Foreign key linking to library.collection. Business justification: New program proposals require library impact assessment demonstrating collection depth and breadth. Accreditation standards mandate documented library support before program approval. The library_reso',
    `accreditation_required` BOOLEAN COMMENT 'Indicates whether specialized programmatic accreditation is required for the proposed program to operate, grant degrees, or enable graduates to pursue professional licensure.',
    `board_of_trustees_approval_date` DATE COMMENT 'Date when the institutional governing board granted final approval for the program proposal, the ultimate authority for new program authorization.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the program proposal record was first created in the curriculum management system, supporting audit trail and workflow tracking.',
    `curriculum_committee_vote_date` DATE COMMENT 'Date when the institutional curriculum committee formally voted on the program proposal, representing the first major governance milestone.',
    `curriculum_committee_vote_result` STRING COMMENT 'Outcome of the curriculum committee vote on the program proposal, determining whether it advances to the next governance stage.. Valid values are `approved|approved_with_conditions|rejected|tabled|withdrawn`',
    `estimated_annual_operating_cost` DECIMAL(18,2) COMMENT 'Projected recurring annual expenses to operate the proposed program at steady state, including faculty salaries, staff support, facilities, and supplies.',
    `estimated_annual_revenue` DECIMAL(18,2) COMMENT 'Projected annual tuition and fee revenue generated by the proposed program at steady-state enrollment, used for financial viability and return on investment (ROI) analysis.',
    `estimated_new_faculty_fte` DECIMAL(18,2) COMMENT 'Total full-time equivalent faculty positions that must be hired to support the proposed program, critical for budget planning and accreditation compliance.',
    `estimated_startup_cost` DECIMAL(18,2) COMMENT 'Total one-time costs required to launch the proposed program, including curriculum development, faculty recruitment, equipment purchases, and marketing expenses.',
    `external_accreditation_body` STRING COMMENT 'Name of specialized programmatic accreditor that will review this program (e.g., AACSB for business, ABET for engineering, ABA for law, LCME for medicine), if applicable.',
    `facility_resource_requirements` STRING COMMENT 'Description of classroom space, laboratory facilities, specialized equipment, technology infrastructure, and physical resources needed to support the proposed program.',
    `faculty_resource_requirements` STRING COMMENT 'Description of new faculty positions, reassigned faculty FTE (Full-Time Equivalent), adjunct needs, and faculty qualifications required to deliver the proposed program.',
    `faculty_senate_vote_date` DATE COMMENT 'Date when the faculty senate or academic council formally voted on the program proposal, representing faculty governance approval.',
    `faculty_senate_vote_result` STRING COMMENT 'Outcome of the faculty senate vote on the program proposal, critical for shared governance compliance.. Valid values are `approved|approved_with_conditions|rejected|tabled|withdrawn`',
    `final_approval_date` DATE COMMENT 'Date when all required approvals (internal governance, regional accreditation, state authorization, specialized accreditation) were secured and the program is authorized to launch.',
    `hlc_approval_date` DATE COMMENT 'Date when HLC granted approval for the substantive change, if required. Program cannot launch until this approval is received.',
    `hlc_notification_date` DATE COMMENT 'Date when the institution formally notified HLC of the substantive change, required to maintain regional accreditation compliance.',
    `hlc_substantive_change_required` BOOLEAN COMMENT 'Indicates whether the proposed program triggers HLC substantive change notification or approval requirements based on degree level, modality, or location criteria.',
    `is_stem_designated` BOOLEAN COMMENT 'Indicates whether the proposed program qualifies for STEM designation, which affects international student visa extensions (OPT) and federal grant eligibility.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the program proposal record was most recently updated, tracking the evolution of the proposal through the review and revision process.',
    `library_resource_requirements` STRING COMMENT 'Description of new library holdings, databases, journals, and information resources needed to support the proposed program curriculum and student research.',
    `market_demand_justification` STRING COMMENT 'Narrative explanation of labor market demand, employer needs, student interest, and competitive landscape supporting the need for this program. Required for HLC substantive change and state approval processes.',
    `projected_enrollment_year_one` STRING COMMENT 'Estimated number of students expected to enroll in the first year of program operation, used for resource planning and financial viability assessment.',
    `projected_enrollment_year_three` STRING COMMENT 'Estimated steady-state enrollment by the third year of program operation, used for long-term resource allocation and sustainability analysis.',
    `proposal_number` STRING COMMENT 'Externally-known unique business identifier for the program proposal, typically formatted as department code, year, and sequence number (e.g., ENGR-2024-001).. Valid values are `^[A-Z]{2,4}-[0-9]{4}-[0-9]{3}$`',
    `proposal_status` STRING COMMENT 'Current lifecycle status of the program proposal in the approval workflow, tracking progression through institutional governance stages from draft through final board approval or rejection. [ENUM-REF-CANDIDATE: draft|submitted|under_review|curriculum_committee_review|faculty_senate_review|provost_review|board_review|approved|rejected|withdrawn|on_hold — 11 candidates stripped; promote to reference product]',
    `proposal_type` STRING COMMENT 'Type of program proposal action being requested: new program creation, modification to existing program, temporary suspension, permanent discontinuation, reactivation of suspended program, or change in degree level.. Valid values are `new_program|program_modification|program_suspension|program_discontinuation|program_reactivation|degree_level_change`',
    `proposed_cip_code` STRING COMMENT 'Six-digit CIP code that classifies the proposed programs instructional content area for federal reporting (IPEDS) and program taxonomy.. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `proposed_degree_designation` STRING COMMENT 'Specific degree designation or abbreviation for the proposed program (e.g., BS, BA, MS, MBA, PhD, EdD, MD, JD).',
    `proposed_degree_level` STRING COMMENT 'Academic level of the proposed program aligned with IPEDS award level classifications. [ENUM-REF-CANDIDATE: certificate|associate|bachelor|post_baccalaureate_certificate|master|post_master_certificate|specialist|doctoral_research|doctoral_professional|post_doctoral_certificate — 10 candidates stripped; promote to reference product]',
    `proposed_delivery_modality` STRING COMMENT 'Primary instructional delivery format for the proposed program, critical for state authorization and accreditation compliance. [ENUM-REF-CANDIDATE: on_campus|fully_online|hybrid|competency_based|accelerated|evening_weekend|low_residency — 7 candidates stripped; promote to reference product]',
    `proposed_program_title` STRING COMMENT 'Full official title of the proposed academic program as it will appear in the catalog, marketing materials, and on transcripts.',
    `proposed_total_credit_hours` STRING COMMENT 'Total number of credit hours required for completion of the proposed program, used for Title IV financial aid eligibility and program length determination.',
    `provost_approval_date` DATE COMMENT 'Date when the chief academic officer (provost or vice president for academic affairs) approved the program proposal, representing administrative endorsement.',
    `state_authorization_required` BOOLEAN COMMENT 'Indicates whether the proposed program requires approval from state higher education agencies, particularly critical for online programs under State Authorization Reciprocity Agreement (SARA) rules.',
    `state_authorization_status` STRING COMMENT 'Current status of state-level approval process for the proposed program, tracking compliance with state higher education regulatory requirements.. Valid values are `not_required|pending|submitted|approved|denied|conditional_approval`',
    `submission_date` DATE COMMENT 'Date when the program proposal was formally submitted to the curriculum governance process, marking the start of the official review timeline.',
    CONSTRAINT pk_program_proposal PRIMARY KEY(`program_proposal_id`)
) COMMENT 'Transactional record for the formal approval workflow to create, modify, suspend, or discontinue an academic program. Captures proposal type, degree level, CIP code, market demand justification, resource requirements, external accreditation implications, state authorization requirements, HLC substantive change notification status, curriculum committee votes, board of trustees approval, and effective implementation term. Distinct from course_proposal in scope, governance pathway, and regulatory implications.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`articulation_agreement` (
    `articulation_agreement_id` BIGINT COMMENT 'Unique identifier for the articulation agreement record. Primary key.',
    `academic_program_id` BIGINT COMMENT 'Reference to the academic program at the receiving institution into which students transfer under this agreement.',
    `institution_id` BIGINT COMMENT 'Reference to the partner institution with which this articulation agreement is established.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Transfer agreements must comply with federal credit hour definitions, state transfer mandates, and accreditation standards for credit acceptance. Required for agreement approval and audit documentatio',
    `active_student_count` STRING COMMENT 'Current number of students enrolled under this articulation agreement pathway.',
    `agreement_code` STRING COMMENT 'Business identifier code for the articulation agreement, used for external reference and reporting.',
    `agreement_notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or clarifications regarding the articulation agreement.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the articulation agreement.. Valid values are `draft|pending approval|active|suspended|expired|terminated`',
    `agreement_title` STRING COMMENT 'Full descriptive title of the articulation agreement, including partner institution and program pathway.',
    `agreement_type` STRING COMMENT 'Classification of the articulation agreement structure. [ENUM-REF-CANDIDATE: 2+2 pathway|3+1 pathway|course-by-course equivalency|statewide transfer compact|reverse transfer|dual enrollment|concurrent enrollment — promote to reference product]. Valid values are `2+2 pathway|3+1 pathway|course-by-course equivalency|statewide transfer compact|reverse transfer|dual enrollment|concurrent enrollment`',
    `agreement_url` STRING COMMENT 'Web address where the full text of the articulation agreement document is published for student and advisor access.',
    `approval_date` DATE COMMENT 'Date when the articulation agreement was approved by the governing body or curriculum committee.',
    `approving_body` STRING COMMENT 'Name of the committee, board, or authority that approved the articulation agreement (e.g., Faculty Senate, Board of Trustees, State Higher Education Commission).',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the articulation agreement automatically renews at the end of the renewal term without explicit action.',
    `cip_code` STRING COMMENT 'Six-digit CIP code identifying the instructional program area covered by this articulation agreement.. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `contact_person_home` STRING COMMENT 'Name and contact information of the primary point of contact at the home institution for questions about this articulation agreement.',
    `contact_person_partner` STRING COMMENT 'Name and contact information of the primary point of contact at the partner institution for questions about this articulation agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the articulation agreement record was first created in the system.',
    `degree_level_from` STRING COMMENT 'Degree or credential level at the sending institution that qualifies for transfer under this agreement.. Valid values are `certificate|associate|bachelor|master|doctoral`',
    `degree_level_to` STRING COMMENT 'Degree or credential level at the receiving institution into which students transfer.. Valid values are `certificate|associate|bachelor|master|doctoral`',
    `effective_end_date` DATE COMMENT 'Date when the articulation agreement expires or is no longer valid. Null indicates open-ended agreement.',
    `effective_start_date` DATE COMMENT 'Date when the articulation agreement becomes binding and operational for transfer students.',
    `governing_state` STRING COMMENT 'Two-letter state code where the articulation agreement is governed or mandated.. Valid values are `^[A-Z]{2}$`',
    `guaranteed_admission_flag` BOOLEAN COMMENT 'Indicates whether students meeting the agreement criteria are guaranteed admission to the receiving institution and program.',
    `last_review_date` DATE COMMENT 'Date when the articulation agreement was last reviewed for currency and compliance.',
    `min_gpa_required` DECIMAL(18,2) COMMENT 'Minimum cumulative GPA a student must maintain at the partner institution to qualify for transfer under this agreement.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the articulation agreement.',
    `partner_fice_code` STRING COMMENT 'Six-digit FICE code identifying the partner institution in federal education databases.. Valid values are `^[0-9]{6}$`',
    `partner_institution_name` STRING COMMENT 'Official legal name of the partner institution as registered with accreditation agencies.',
    `partner_institution_type` STRING COMMENT 'Classification of the partner institution by Carnegie classification or state designation.. Valid values are `community college|four-year college|university|technical college|system office`',
    `partner_opeid` STRING COMMENT 'Eight-digit OPEID number assigned by the U.S. Department of Education to the partner institution for Title IV financial aid administration.. Valid values are `^[0-9]{8}$`',
    `renewal_term_months` STRING COMMENT 'Number of months after which the articulation agreement must be reviewed and renewed.',
    `residency_requirement_credit_hours` DECIMAL(18,2) COMMENT 'Minimum number of credit hours that must be completed at the receiving institution to satisfy residency requirements under this agreement.',
    `scholarship_eligibility_flag` BOOLEAN COMMENT 'Indicates whether students transferring under this articulation agreement are eligible for special transfer scholarships or financial aid.',
    `sending_program_code` STRING COMMENT 'Program code or credential designation at the partner (sending) institution that qualifies for this articulation pathway.',
    `signatory_authority_home` STRING COMMENT 'Name and title of the authorized signatory from the home institution who executed the agreement.',
    `signatory_authority_partner` STRING COMMENT 'Name and title of the authorized signatory from the partner institution who executed the agreement.',
    `signed_date` DATE COMMENT 'Date when the articulation agreement was formally signed by both parties.',
    `state_mandate_code` STRING COMMENT 'Reference code for the state-level transfer mandate or legislation governing this agreement, if applicable.',
    `termination_date` DATE COMMENT 'Date when the articulation agreement was formally terminated or discontinued, if applicable.',
    `termination_reason` STRING COMMENT 'Explanation for why the articulation agreement was terminated (e.g., program discontinuation, partner accreditation loss, state policy change).',
    `total_credit_hours_transferable` DECIMAL(18,2) COMMENT 'Maximum number of credit hours that can transfer under this articulation agreement.',
    `total_students_transferred` STRING COMMENT 'Cumulative count of students who have successfully transferred under this articulation agreement since inception.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the articulation agreement record was last modified in the system.',
    CONSTRAINT pk_articulation_agreement PRIMARY KEY(`articulation_agreement_id`)
) COMMENT 'Master record for formal articulation agreements between the institution and partner colleges, universities, or systems, defining how courses or credentials transfer and satisfy requirements. Captures partner institution (FICE/OPEID code), agreement type (2+2 pathway, 3+1, course-by-course equivalency, statewide transfer compact, reverse transfer), effective date range, renewal terms, signatory authorities, governing state mandate (if applicable), total credit hours transferable, and agreement status (draft, active, expired, terminated). Supports transfer student advising, state articulation compliance reporting (e.g., state transfer module requirements), and strategic enrollment partnership management.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`transfer_equivalency` (
    `transfer_equivalency_id` BIGINT COMMENT 'Unique identifier for the transfer equivalency mapping record. Primary key for the transfer equivalency entity.',
    `academic_program_id` BIGINT COMMENT 'Reference to a specific academic program if this equivalency mapping is restricted to students in that program. Null if the mapping applies broadly across programs.',
    `articulation_agreement_id` BIGINT COMMENT 'Reference to the parent articulation agreement under which this course equivalency is defined. Links this equivalency to the formal agreement between sending and receiving institutions.',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: Transfer equivalencies become effective at specific term start dates for transfer credit evaluation. Registrar operations require term-specific equivalency activation for articulation agreement implem',
    `employee_id` BIGINT COMMENT 'Reference to the employee (typically registrar, department chair, or curriculum committee member) who approved this transfer equivalency mapping.',
    `course_id` BIGINT COMMENT 'Reference to the specific course at the receiving institution that the sending course maps to. Null if the equivalency is to elective credit or a requirement group rather than a specific course.',
    `institution_id` BIGINT COMMENT 'Identifier of the institution receiving the transfer student. The institution that will award equivalent credit based on this mapping.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Transfer credit evaluations must comply with federal credit hour regulations, accreditation standards for credit acceptance, and state transfer policies. Required for financial aid eligibility and acc',
    `sending_institution_id` BIGINT COMMENT 'Identifier of the institution from which the student is transferring. The originating institution whose course is being evaluated for equivalency.',
    `applies_to_degree_level` STRING COMMENT 'The degree level(s) to which this equivalency mapping applies. Restricts the use of the equivalency to specific academic levels.. Valid values are `undergraduate|graduate|certificate|all`',
    `approval_date` DATE COMMENT 'The date when this transfer equivalency mapping was officially approved for use in transfer credit evaluations. Format: yyyy-MM-dd.',
    `approval_status` STRING COMMENT 'The approval workflow status for this equivalency mapping. Tracks whether the mapping has been reviewed and approved by the appropriate academic authority.. Valid values are `draft|submitted|approved|rejected|revision_required`',
    `counts_toward_residency` BOOLEAN COMMENT 'Indicates whether credit awarded through this equivalency counts toward the receiving institutions residency credit hour requirement for degree completion. False if the credit is transfer credit that does not count toward residency.',
    `course_content_match_level` STRING COMMENT 'Assessment of how closely the sending course content aligns with the receiving course content. Exact: nearly identical. Substantial: 75%+ overlap. Partial: 50-74% overlap. Minimal: less than 50% overlap but still transferable.. Valid values are `exact|substantial|partial|minimal`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this transfer equivalency record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage.',
    `credit_hours_awarded` DECIMAL(18,2) COMMENT 'The number of credit hours (CR) awarded by the receiving institution for successful completion of the sending course. May differ from the sending course credit hours based on institutional policy.',
    `effective_end_date` DATE COMMENT 'The date when this transfer equivalency mapping expires or is no longer valid for new evaluations. Null if the mapping is open-ended. Format: yyyy-MM-dd.',
    `effective_start_date` DATE COMMENT 'The date when this transfer equivalency mapping becomes active and can be applied to transfer credit evaluations. Format: yyyy-MM-dd.',
    `equivalency_type` STRING COMMENT 'The type of equivalency mapping. Direct: one-to-one course match. Block: multiple courses map to a block of credit. Elective: maps to elective credit hours. General Education: satisfies a general education requirement. Major Requirement: satisfies a major-specific requirement. No Credit: course does not transfer for credit.. Valid values are `direct|block|elective|general_education|major_requirement|no_credit`',
    `evaluation_notes` STRING COMMENT 'Free-text notes documenting the rationale for the equivalency mapping, special conditions, or instructions for transfer credit evaluators. May include syllabus comparison details or accreditation considerations.',
    `evaluation_status` STRING COMMENT 'Current status of this equivalency mapping in the transfer credit evaluation workflow. Active: currently in use. Inactive: temporarily disabled. Pending Review: awaiting approval. Superseded: replaced by newer mapping. Expired: past effective end date.. Valid values are `active|inactive|pending_review|superseded|expired`',
    `external_equivalency_code` STRING COMMENT 'External identifier for this equivalency mapping in a third-party transfer credit system or statewide articulation database (e.g., state transfer portal, ASSIST system in California).',
    `is_reciprocal` BOOLEAN COMMENT 'Indicates whether this equivalency mapping is reciprocal (bidirectional). True if the receiving institution course also maps back to the sending institution course in reverse transfer scenarios.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this transfer equivalency record was most recently updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for change tracking and audit purposes.',
    `last_review_date` DATE COMMENT 'The date when this equivalency mapping was last reviewed for accuracy and currency. Used to track periodic review cycles required by accreditation or institutional policy. Format: yyyy-MM-dd.',
    `learning_outcome_alignment` STRING COMMENT 'Assessment of how well the sending course learning outcomes align with the receiving course Student Learning Outcomes (SLO). Used for accreditation and quality assurance purposes.. Valid values are `full|high|moderate|low|not_assessed`',
    `max_credit_applicable` DECIMAL(18,2) COMMENT 'The maximum number of credit hours (CR) that can be awarded through this equivalency mapping, even if the sending course carries more credit. Used to cap transfer credit in certain scenarios.',
    `min_grade_required` STRING COMMENT 'The minimum grade the student must earn in the sending course for the equivalency to apply and credit to be awarded (e.g., C, C-, D). Null if no minimum grade is specified.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of this equivalency mapping. Ensures mappings remain current with curriculum changes. Format: yyyy-MM-dd.',
    `prerequisite_waived` BOOLEAN COMMENT 'Indicates whether successful completion of the sending course waives prerequisite requirements for subsequent courses at the receiving institution. True if the equivalency satisfies prerequisite chains.',
    `requirement_group_code` STRING COMMENT 'Code identifying the degree requirement group or category that this equivalency satisfies (e.g., CORE-MATH, GEN-ED-SCI, MAJOR-ELEC). Used when the equivalency maps to a requirement rather than a specific course.',
    `sending_course_code` STRING COMMENT 'The course code or number at the sending institution that is being mapped for transfer credit. Example: MATH 101, ENG 1301.',
    `sending_course_credit_hours` DECIMAL(18,2) COMMENT 'The number of credit hours (CR) assigned to the course at the sending institution. Used to determine how much credit should be awarded at the receiving institution.',
    `sending_course_subject` STRING COMMENT 'The academic subject or discipline area of the sending course (e.g., Mathematics, English, Biology). Used for classification and mapping purposes.',
    `sending_course_title` STRING COMMENT 'The official title of the course at the sending institution as it appears in their course catalog.',
    `source_system_code` STRING COMMENT 'Identifier of the source system or module where this equivalency mapping was originally created (e.g., Banner SHATRCE, TES, custom articulation system). Used for data lineage and integration tracking.',
    CONSTRAINT pk_transfer_equivalency PRIMARY KEY(`transfer_equivalency_id`)
) COMMENT 'Defines the course-level equivalency mappings within an articulation agreement, specifying how a specific course at a sending institution maps to a course or requirement at the receiving institution. Captures sending institution course, receiving institution course or requirement group, equivalency type (direct, block, elective credit), credit hours awarded, effective term range, and evaluation status. Supports transfer credit evaluation workflows and degree audit processing for transfer students.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`program_accreditation` (
    `program_accreditation_id` BIGINT COMMENT 'Unique identifier for the program accreditation record. Primary key for tracking specialized accreditation status and review cycles.',
    `academic_program_id` BIGINT COMMENT 'Reference to the academic program subject to specialized accreditation review.',
    `employee_id` BIGINT COMMENT 'Reference to the faculty member serving as the academic program director responsible for accreditation compliance and reporting.',
    `tertiary_program_updated_by_employee_id` BIGINT COMMENT 'Reference to the employee who last updated this accreditation record.',
    `accreditation_decision_date` DATE COMMENT 'The date when the accrediting body officially communicated its accreditation decision following the review.',
    `accreditation_expiration_date` DATE COMMENT 'The date when the current accreditation status expires and renewal or reaffirmation is required.',
    `accreditation_fees_annual` DECIMAL(18,2) COMMENT 'The annual membership or maintenance fees charged by the accrediting body for maintaining accredited status.',
    `accreditation_level` STRING COMMENT 'The organizational level at which accreditation is granted: program (specific degree program), department (academic unit), college (school within university), or institutional (entire institution).. Valid values are `program|department|college|institutional`',
    `accreditation_standards_version` STRING COMMENT 'The version or edition of the accrediting bodys standards under which the program is being reviewed (e.g., ABET 2023-2024 Criteria, AACSB 2020 Standards).',
    `accreditation_status` STRING COMMENT 'Current accreditation standing of the program: accredited (full approval), candidate (pre-accreditation status), probation (conditional approval with concerns), withdrawn (voluntarily removed), denied (application rejected), expired (lapsed without renewal).. Valid values are `accredited|candidate|probation|withdrawn|denied|expired`',
    `accreditation_type` STRING COMMENT 'The type of accreditation review being conducted: initial (first-time accreditation), continuing (renewal), reaffirmation (periodic review), specialized (discipline-specific), or conditional (provisional status).. Valid values are `initial|continuing|reaffirmation|specialized|conditional`',
    `accreditation_url` STRING COMMENT 'Web address where the programs accreditation status and related documentation are publicly disclosed.',
    `accrediting_body` STRING COMMENT 'The specialized accreditation agency responsible for program review. Examples include AACSB (Association to Advance Collegiate Schools of Business), ABET (Accreditation Board for Engineering and Technology), ABA (American Bar Association), LCME (Liaison Committee on Medical Education). [ENUM-REF-CANDIDATE: AACSB|ABET|ABA|LCME|ACPE|CCNE|NAAB|NASM|CEPH|CSWE — 10 candidates stripped; promote to reference product]',
    `annual_report_due_date` DATE COMMENT 'The recurring deadline for submission of annual reports to the accrediting body, if required.',
    `annual_report_required` BOOLEAN COMMENT 'Indicates whether the accrediting body mandates submission of annual data or progress reports between comprehensive reviews.',
    `appeal_decision_date` DATE COMMENT 'The date when the accrediting body issued a final decision on the institutions appeal, if applicable.',
    `appeal_filed` BOOLEAN COMMENT 'Indicates whether the institution has filed a formal appeal of an adverse accreditation decision.',
    `commendations` STRING COMMENT 'Areas of strength or exemplary practices recognized by the accrediting body during the review process.',
    `compliance_status` STRING COMMENT 'Current compliance standing with accreditation standards: compliant (meeting all standards), non-compliant (deficiencies identified), monitoring (under observation), remediation (corrective action in progress).. Valid values are `compliant|non-compliant|monitoring|remediation`',
    `conditions_cited` STRING COMMENT 'Specific conditions, deficiencies, or areas of concern identified by the accrediting body that require remediation or monitoring.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this accreditation record was first created in the system.',
    `current_accreditation_effective_date` DATE COMMENT 'The effective start date of the current accreditation status or most recent reaffirmation.',
    `initial_accreditation_date` DATE COMMENT 'The date when the program first received accreditation from this accrediting body.',
    `interim_report_due_date` DATE COMMENT 'The deadline for submission of any required interim or progress report to the accrediting body.',
    `interim_report_required` BOOLEAN COMMENT 'Indicates whether the accrediting body has mandated submission of an interim progress report between comprehensive reviews.',
    `last_review_date` DATE COMMENT 'The date of the most recent comprehensive accreditation review or site visit conducted by the accrediting body.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next comprehensive accreditation review or reaffirmation cycle.',
    `notes` STRING COMMENT 'Additional contextual information, internal observations, or supplementary details regarding the accreditation status and review process.',
    `public_disclosure_statement` STRING COMMENT 'The official public statement regarding the programs accreditation status as required for transparency and consumer information purposes.',
    `review_cycle_years` STRING COMMENT 'The number of years between comprehensive accreditation reviews as specified by the accrediting body (typically 5, 7, or 10 years).',
    `review_fees_estimated` DECIMAL(18,2) COMMENT 'The estimated total cost of the comprehensive accreditation review process, including application fees, site visit expenses, and evaluation costs.',
    `self_study_due_date` DATE COMMENT 'The deadline for submission of the self-study report to the accrediting body as part of the review process.',
    `site_visit_date` DATE COMMENT 'The date when the accrediting body conducted or is scheduled to conduct an on-site evaluation visit.',
    `substantive_change_approval_required` BOOLEAN COMMENT 'Indicates whether the accrediting body requires prior approval for substantive changes to the program (e.g., new delivery modality, significant curriculum revision, new location).',
    `teach_out_plan_approval_date` DATE COMMENT 'The date when the teach-out plan was approved by the accrediting body, if applicable.',
    `teach_out_plan_required` BOOLEAN COMMENT 'Indicates whether a teach-out plan is required due to program closure, loss of accreditation, or institutional closure to ensure current students can complete their degrees.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this accreditation record was last modified in the system.',
    CONSTRAINT pk_program_accreditation PRIMARY KEY(`program_accreditation_id`)
) COMMENT 'Tracks the accreditation status and review cycle for each academic program subject to specialized accreditation (AACSB, ABET, ABA, LCME, AACSB). Captures accrediting body, accreditation type (initial, continuing, specialized), current status (accredited, candidate, probation, withdrawn), last review date, next review date, self-study due date, conditions or concerns cited, and institutional liaison. Supports compliance reporting and accreditation preparation workflows.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`assessment_cycle` (
    `assessment_cycle_id` BIGINT COMMENT 'Unique identifier for the assessment cycle record. Primary key.',
    `academic_program_id` BIGINT COMMENT 'Reference to the academic program being assessed in this cycle.',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Assessment cycles are executed and documented through enterprise assessment management systems. Assessment coordinators use these applications to collect data, analyze results, and generate accreditat',
    `employee_id` BIGINT COMMENT 'Reference to the faculty or staff member responsible for leading this assessment cycle.',
    `accreditation_standard_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_standard. Business justification: Assessment cycles demonstrate compliance with specific accreditor standards (AACSB, ABET, HLC criteria). Essential for accreditation self-studies and continuous improvement documentation. Core accredi',
    `plo_id` BIGINT COMMENT 'Reference to the specific PLO being evaluated in this assessment cycle.',
    `academic_year` STRING COMMENT 'The academic year during which this assessment cycle is conducted (e.g., 2023-2024).',
    `accreditation_body` STRING COMMENT 'The accrediting agency for which this assessment cycle provides evidence (e.g., AACSB, ABET, HLC, SACSCOC).',
    `accreditation_standard_reference` STRING COMMENT 'Specific accreditation standard or criterion addressed by this assessment cycle (e.g., AACSB Standard 8, ABET Criterion 3, HLC Criterion 4.B).',
    `action_plan_approved_date` DATE COMMENT 'The date when the improvement action plan was formally approved by the curriculum committee or program leadership.',
    `actual_mean_score` DECIMAL(18,2) COMMENT 'The mean score achieved by students on the assessment instrument in this cycle.',
    `actual_proficiency_pct` DECIMAL(18,2) COMMENT 'The actual percentage of students who met or exceeded the proficiency threshold in this cycle.',
    `analysis_completed_date` DATE COMMENT 'The date when the analysis of assessment data was completed.',
    `assessment_method_description` STRING COMMENT 'Detailed description of the specific assessment method used (e.g., embedded case analysis rubric in capstone course, exit survey, portfolio review).',
    `assessment_method_type` STRING COMMENT 'Classification of the assessment method as direct (embedded exam, rubric-scored artifact, capstone evaluation) or indirect (survey, focus group, self-report).. Valid values are `direct|indirect`',
    `benchmark_met_flag` BOOLEAN COMMENT 'Indicates whether the target benchmark was achieved (True) or not (False) in this cycle.',
    `catalog_year` STRING COMMENT 'The catalog year of the program curriculum being assessed, ensuring alignment with published program requirements.',
    `cip_code` STRING COMMENT 'The CIP code of the program being assessed, used for federal reporting and program classification.',
    `closure_evidence` STRING COMMENT 'Documentation that improvement actions were enacted and their impact evaluated, demonstrating closure of the assess-analyze-act-improve loop required by accreditors.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this assessment cycle record was first created in the system.',
    `cycle_closed_date` DATE COMMENT 'The date when the assessment cycle was formally closed, indicating that improvement actions were implemented and closure-of-loop evidence was documented.',
    `cycle_code` STRING COMMENT 'Business identifier for the assessment cycle, typically combining program code, PLO code, and academic year (e.g., MBA-PLO1-2023).',
    `cycle_name` STRING COMMENT 'Descriptive name for the assessment cycle, summarizing the program, outcome, and period under review.',
    `cycle_status` STRING COMMENT 'Current lifecycle status of the assessment cycle within the assess-analyze-act-improve loop.. Valid values are `planned|data_collection|analysis|action_planning|implementation|closed`',
    `data_collection_end_date` DATE COMMENT 'The date when data collection for this assessment cycle was completed.',
    `data_collection_instrument` STRING COMMENT 'Name or identifier of the tool, rubric, survey, or exam used to collect assessment data (e.g., AAC&U VALUE Rubric, custom capstone rubric, Qualtrics exit survey).',
    `data_collection_start_date` DATE COMMENT 'The date when data collection for this assessment cycle began.',
    `degree_level` STRING COMMENT 'The level of the degree program being assessed (e.g., bachelor, master, doctoral).. Valid values are `certificate|associate|bachelor|master|doctoral|professional`',
    `gap_analysis` STRING COMMENT 'Analysis of the gap between target and actual performance, identifying specific areas where students did not meet expectations and potential root causes.',
    `implementation_timeline` STRING COMMENT 'Planned timeline for implementing the identified improvement actions, including milestones and responsible parties.',
    `improvement_actions` STRING COMMENT 'Specific improvement actions identified to address performance gaps, such as curriculum revisions, pedagogical changes, or resource enhancements.',
    `instrument_version` STRING COMMENT 'Version number or date of the data collection instrument to track changes over time.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this assessment cycle record was last modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information about the assessment cycle.',
    `proficiency_scale_max` DECIMAL(18,2) COMMENT 'The maximum possible score on the assessment instrument scale (e.g., 4.00 for a 4-point rubric, 100.00 for a percentage scale).',
    `proficiency_threshold_score` DECIMAL(18,2) COMMENT 'The minimum score on the assessment instrument that represents proficiency (e.g., 3.00 on a 4-point rubric).',
    `results_summary` STRING COMMENT 'Narrative summary of the assessment results, including key findings, trends, and observations from the data analysis.',
    `sample_size_actual` STRING COMMENT 'Actual number of students or artifacts assessed in this cycle.',
    `sample_size_target` STRING COMMENT 'Planned number of students or artifacts to be assessed in this cycle.',
    `target_benchmark_pct` DECIMAL(18,2) COMMENT 'The target percentage of students expected to meet or exceed the proficiency threshold (e.g., 80.00 means 80% of students should score at proficiency or above).',
    CONSTRAINT pk_assessment_cycle PRIMARY KEY(`assessment_cycle_id`)
) COMMENT 'Defines a scheduled assessment cycle for evaluating PLO attainment within an academic program, representing one complete iteration of the assess-analyze-act-improve loop required by accreditors. Captures the program, PLO(s) under review, academic year, assessment method (direct: embedded exam, rubric-scored artifact, capstone evaluation; indirect: survey, focus group), data collection instrument, sample size, target performance benchmark, actual results summary, gap analysis, improvement actions identified, implementation timeline, and closure-of-loop evidence documenting that improvements were enacted. Supports AACSB Assurance of Learning, ABET continuous improvement, and HLC Criteria 4.B documentation.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`cip_code` (
    `cip_code_id` BIGINT COMMENT 'Unique identifier for the CIP code record. Primary key for the CIP code reference taxonomy.',
    `action_code` STRING COMMENT 'The type of change applied to this CIP code in the current edition relative to the prior edition. New indicates a newly created code. Revised indicates definition or title changes. Moved indicates reclassification to a different series. Deleted indicates retirement. No change indicates the code is unchanged from the prior edition.. Valid values are `new|revised|moved|deleted|no_change`',
    `cip_code` STRING COMMENT 'Six-digit hierarchical CIP code in format XX.XXXX where the first two digits represent the broad field (series), the middle two represent the narrow field (intermediate grouping), and the last two represent the specific program. This is the authoritative NCES classification code.. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `cip_definition` STRING COMMENT 'Official NCES definition and scope statement for the CIP code. Describes the instructional content, typical courses, and program characteristics that define this classification.',
    `cip_edition_year` STRING COMMENT 'The year of the CIP taxonomy edition in which this code was published or last updated (e.g., 2010, 2020). NCES updates the CIP taxonomy biennially.',
    `cip_status` STRING COMMENT 'Current lifecycle status of the CIP code. Active codes are valid for current use in IPEDS reporting and program classification. Inactive codes have been retired or superseded. Moved codes have been reclassified to a different CIP code. Deleted codes are no longer valid.. Valid values are `active|inactive|moved|deleted`',
    `cip_title` STRING COMMENT 'Official NCES title for the CIP code. This is the authoritative program name as published by the National Center for Education Statistics.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this CIP code record was first created in the institutional system. Used for audit trail and data lineage.',
    `cross_reference_cip_codes` STRING COMMENT 'Comma-separated list of related or similar CIP codes that institutions should consider when classifying programs. Used for disambiguation and classification guidance.',
    `discontinue_date` DATE COMMENT 'The date on which this CIP code was retired, superseded, or otherwise discontinued for use in program classification. Null for active codes.',
    `effective_date` DATE COMMENT 'The date on which this CIP code became valid for use in institutional program classification and IPEDS reporting.',
    `examples` STRING COMMENT 'Illustrative examples of specific degree programs, majors, or concentrations that would be classified under this CIP code. Provided by NCES for classification guidance.',
    `four_digit_series` STRING COMMENT 'The first four digits of the CIP code (XX.XX format) representing the intermediate or narrow instructional field within the broad series (e.g., 11.01 = Computer and Information Sciences, General).. Valid values are `^[0-9]{2}.[0-9]{2}$`',
    `four_digit_series_title` STRING COMMENT 'The official NCES title for the four-digit narrow field series (e.g., Computer and Information Sciences, General).',
    `ipeds_reporting_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether this CIP code is valid for use in IPEDS completions reporting. Only active CIP codes from the current edition are IPEDS-eligible.',
    `is_stem_designated` BOOLEAN COMMENT 'Boolean flag indicating whether this CIP code is designated as a STEM program per the Department of Homeland Security STEM Designated Degree Program List. STEM designation affects international student Optional Practical Training (OPT) eligibility and STEM OPT extension eligibility.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this CIP code record was last updated in the institutional system. Used for data lineage and change tracking.',
    `nces_url` STRING COMMENT 'The official NCES web URL for this CIP code definition and detailed classification guidance.',
    `opt_stem_extension_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether international students who complete a degree program in this CIP code are eligible for the 24-month STEM OPT extension beyond the standard 12-month OPT period.',
    `prior_cip_code_2010` STRING COMMENT 'The equivalent CIP code from the 2010 edition, if applicable. Used for historical crosswalk mapping and longitudinal analysis of program completions data.',
    `title_iv_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether programs classified under this CIP code are eligible for Title IV federal financial aid. Certain CIP codes (e.g., recreational or avocational programs) may be ineligible for federal aid.',
    `two_digit_series` STRING COMMENT 'The first two digits of the CIP code representing the broad instructional field or discipline area (e.g., 11 = Computer and Information Sciences, 14 = Engineering, 51 = Health Professions).. Valid values are `^[0-9]{2}$`',
    `two_digit_series_title` STRING COMMENT 'The official NCES title for the two-digit broad field series (e.g., Computer and Information Sciences and Support Services, Engineering, Health Professions and Related Programs).',
    CONSTRAINT pk_cip_code PRIMARY KEY(`cip_code_id`)
) COMMENT 'Reference taxonomy record for the Classification of Instructional Programs (CIP) maintained by the National Center for Education Statistics (NCES), updated biennially. Captures CIP code (6-digit hierarchical: XX.XXXX), title, definition, two-digit series (broad field), four-digit series (narrow field), six-digit series (specific program), active/inactive status, STEM designation flag (DHS STEM Designated Degree Program List), and crosswalk mappings to prior CIP editions (2010→2020). Serves as the authoritative classification for IPEDS completions reporting, state authorization applications, OPT/STEM OPT visa eligibility determination, Title IV federal financial aid program eligibility, and institutional research analytics. Updated centrally when NCES publishes new editions; institutional programs reference but do not modify CIP definitions.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`concentration` (
    `concentration_id` BIGINT COMMENT 'Unique system identifier for the concentration, track, specialization, emphasis, or minor within an academic program. Primary key for the concentration entity.',
    `academic_program_id` BIGINT COMMENT 'Foreign key reference to the parent academic program under which this concentration is offered. Links to curriculum.academic_program.',
    `cip_code_id` BIGINT COMMENT 'FK to curriculum.cip_code',
    `org_unit_id` BIGINT COMMENT 'Foreign key reference to the college or school that houses the concentration. Typically aligns with the parent program college but may differ for cross-college concentrations.',
    `concentration_org_unit_id` BIGINT COMMENT 'Foreign key reference to the academic department that administers the concentration. May differ from the parent program department for interdisciplinary concentrations.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the faculty member serving as the concentration director or coordinator, responsible for curriculum oversight, student advising, and assessment.',
    `accreditation_body` STRING COMMENT 'Name of the specialized accrediting agency that reviews this concentration if distinct from the parent program accreditation (e.g., AACSB for a Finance concentration within a Business program, ABET for an Engineering concentration).',
    `accreditation_status` STRING COMMENT 'Current accreditation status of the concentration with the specialized accrediting body. Not applicable if the concentration does not require separate accreditation.. Valid values are `accredited|candidate|not_accredited|not_applicable`',
    `admission_requirements` STRING COMMENT 'Narrative description of any special admission requirements for the concentration, including prerequisite courses, minimum GPA, application materials, auditions, portfolios, or faculty approval processes.',
    `admission_restricted` BOOLEAN COMMENT 'Indicates whether admission to the concentration requires a separate application, faculty approval, portfolio review, or other selective criteria beyond enrollment in the parent program.',
    `appears_on_diploma` BOOLEAN COMMENT 'Indicates whether the concentration title is printed on the official diploma. Varies by institutional policy; some institutions print only the major degree, others include concentrations.',
    `appears_on_transcript` BOOLEAN COMMENT 'Indicates whether the concentration title is printed on the official academic transcript. True for most concentrations; false for internal tracking-only designations.',
    `approval_date` DATE COMMENT 'Date on which the concentration was formally approved by the curriculum committee, faculty senate, or governing board, authorizing its inclusion in the academic catalog.',
    `banner_area_code` STRING COMMENT 'Ellucian Banner SMRPRLE area code used in degree audit processing (DegreeWorks) to identify and evaluate concentration requirements. Maps directly to Banner curriculum rules.. Valid values are `^[A-Z0-9]{1,4}$`',
    `capstone_required` BOOLEAN COMMENT 'Indicates whether completion of a capstone course, project, thesis, or comprehensive examination is required as part of the concentration requirements.',
    `catalog_year` STRING COMMENT 'Academic catalog year in which this concentration version became effective, formatted as YYYY-YYYY (e.g., 2023-2024). Students are typically held to the catalog year in effect at the time of their initial enrollment.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `concentration_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the concentration within the institution. Used in student information systems, degree audits, and transcript processing. Maps to Banner SMRPRLE area code.. Valid values are `^[A-Z0-9]{2,10}$`',
    `concentration_description` STRING COMMENT 'Detailed narrative description of the concentration, including its academic focus, career outcomes, unique features, and relationship to the parent program. Published in the academic catalog.',
    `concentration_status` STRING COMMENT 'Current lifecycle status of the concentration indicating whether it is available for student enrollment and degree audit processing.. Valid values are `active|inactive|suspended|pending_approval|discontinued`',
    `concentration_type` STRING COMMENT 'Classification of the sub-plan type: concentration (focused study area within major), track (pathway variant), specialization (advanced focus), emphasis (thematic grouping), minor (secondary credential), or certificate (standalone credential).. Valid values are `concentration|track|specialization|emphasis|minor|certificate`',
    `core_credit_hours` DECIMAL(18,2) COMMENT 'Number of credit hours that must be fulfilled through required core courses specific to the concentration, with no substitution allowed.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this concentration record was first created in the student information system.',
    `effective_end_date` DATE COMMENT 'Date on which this concentration was discontinued or superseded by a new version. Null for currently active concentrations. Students enrolled before this date may continue under teach-out provisions.',
    `effective_start_date` DATE COMMENT 'Date on which this concentration became available for student enrollment and degree audit processing. Aligns with the start of the catalog year or mid-year curriculum changes.',
    `elective_credit_hours` DECIMAL(18,2) COMMENT 'Number of credit hours that must be fulfilled through elective courses within the concentration, allowing student choice within defined parameters.',
    `honors_eligible` BOOLEAN COMMENT 'Indicates whether students in this concentration are eligible to pursue honors designation through additional coursework, thesis, or research requirements.',
    `internship_required` BOOLEAN COMMENT 'Indicates whether completion of an internship, practicum, clinical placement, or field experience is required as part of the concentration requirements.',
    `ipeds_reportable` BOOLEAN COMMENT 'Indicates whether completions of this concentration must be reported separately to IPEDS as a distinct award. True when the concentration has a unique CIP code and meets IPEDS reporting thresholds.',
    `last_curriculum_review_date` DATE COMMENT 'Date of the most recent comprehensive curriculum review for the concentration, typically conducted on a 3-7 year cycle as part of program assessment and continuous improvement.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this concentration record was most recently modified, supporting audit trail and data lineage tracking.',
    `max_transfer_credit_hours` DECIMAL(18,2) COMMENT 'Maximum number of transfer credit hours that may be applied toward concentration requirements. Null if no transfer credit is allowed or if parent program limits apply.',
    `min_gpa_required` DECIMAL(18,2) COMMENT 'Minimum cumulative or major GPA required for admission to or continuation in the concentration. Null if no GPA threshold applies.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next comprehensive curriculum review of the concentration, ensuring ongoing alignment with industry standards, accreditation requirements, and student learning outcomes.',
    `oer_designated` BOOLEAN COMMENT 'Indicates whether the concentration has been designated as using primarily Open Educational Resources, reducing textbook costs for students and supporting affordability initiatives.',
    `required_credit_hours` DECIMAL(18,2) COMMENT 'Total number of credit hours required to complete the concentration, including both required and elective courses within the concentration plan.',
    `residency_credit_hours` DECIMAL(18,2) COMMENT 'Minimum number of credit hours within the concentration that must be completed in residence at the degree-granting institution, not through transfer or test credit.',
    `stem_designated` BOOLEAN COMMENT 'Indicates whether the concentration is designated as a STEM program for purposes of Optional Practical Training (OPT) extension eligibility for international students on F-1 visas.',
    `thesis_required` BOOLEAN COMMENT 'Indicates whether completion of a formal thesis or dissertation is required as part of the concentration requirements, typically for graduate-level concentrations.',
    `title` STRING COMMENT 'Official full title of the concentration, track, specialization, emphasis, or minor as it appears in the academic catalog and on official transcripts.',
    `total_enrolled_students` STRING COMMENT 'Current count of students actively enrolled in this concentration. Used for capacity planning, resource allocation, and viability assessment.',
    `url` STRING COMMENT 'Web address of the official concentration page on the institutional website, providing prospective and current students with detailed information, course requirements, and contact information.. Valid values are `^https?://.*$`',
    `writing_intensive` BOOLEAN COMMENT 'Indicates whether the concentration includes a significant writing component across multiple courses, meeting institutional writing-intensive program criteria.',
    CONSTRAINT pk_concentration PRIMARY KEY(`concentration_id`)
) COMMENT 'Master record for concentrations, tracks, specializations, emphases, and minors embedded within an academic program that represent a structured sub-plan of study. Captures concentration title, parent academic program, required credit hours, elective credit hours, specific course requirements, CIP sub-code if distinct from parent program, active status, effective catalog year range, admission requirements (if restricted), whether the concentration appears on the official transcript and/or diploma, and Banner SMRPRLE area code. Supports degree audit processing (DegreeWorks/Banner), program-level IPEDS completions reporting at the concentration level, and student academic planning.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`curriculum_enrollment` (
    `curriculum_enrollment_id` BIGINT COMMENT 'Primary key for curriculum_enrollment',
    `course_id` BIGINT COMMENT 'Foreign key linking to the course master record in which the student athlete is enrolled',
    `enrollment_registration_id` BIGINT COMMENT 'Unique surrogate identifier for the enrollment record. Primary key for the enrollment association.',
    `student_athlete_id` BIGINT COMMENT 'Foreign key linking to the student athlete who is enrolled in the course',
    `academic_year` STRING COMMENT 'The academic year of the enrollment (e.g., 2023 for 2023-2024 academic year). Used for eligibility year calculations and compliance reporting.',
    `completion_date` DATE COMMENT 'The date when the student athlete completed the course (grade posted). Used for progress-toward-degree calculations and eligibility certification timing.',
    `credit_hours_earned` DECIMAL(18,2) COMMENT 'The number of credit hours earned by the student athlete for this specific enrollment. May differ from the course catalog credit hours if the student enrolled for variable credit or received partial credit.',
    `degree_applicable_flag` BOOLEAN COMMENT 'Indicates whether the credits from this enrollment count toward the student athletes degree progress for NCAA eligibility purposes. Not all enrolled courses count toward the percentage-of-degree requirement.',
    `enrollment_date` DATE COMMENT 'The date when the student athlete enrolled in this course. Used to determine if enrollment occurred before census date for eligibility credit.',
    `enrollment_status` STRING COMMENT 'Current status of the enrollment. Tracks whether the student athlete is actively enrolled, has dropped, withdrawn, or completed the course. Critical for real-time eligibility monitoring.',
    `grade` STRING COMMENT 'The final grade earned by the student athlete in this course. Used to calculate term GPA and determine satisfactory academic progress for eligibility.',
    `term_code` STRING COMMENT 'The academic term in which the enrollment occurred (format: YYYYTT where TT is term type). Critical for eligibility tracking as student athletes must maintain full-time status each term.',
    CONSTRAINT pk_curriculum_enrollment PRIMARY KEY(`curriculum_enrollment_id`)
) COMMENT 'This association product represents the enrollment event between a course and a student athlete. It captures the term-specific registration of a student athlete in a course, including enrollment status, academic performance, credit hours earned, and whether the credits count toward degree progress for NCAA eligibility certification. Each record links one course to one student athlete for a specific term with attributes that exist only in the context of this enrollment relationship.. Existence Justification: In higher education operations, student athletes enroll in multiple courses each term to maintain full-time status (minimum 12 credit hours for NCAA eligibility), and each course section has multiple student athletes enrolled. Compliance officers actively manage and monitor these enrollments to verify eligibility requirements: full-time enrollment status, term GPA calculation, percentage-of-degree progress, and whether credits are degree-applicable. Enrollment is a recognized business entity with term-specific data (grades, status, dates) that belongs to neither the course catalog nor the student athlete profile alone.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`program_affiliation` (
    `program_affiliation_id` BIGINT COMMENT 'Unique surrogate identifier for the program affiliation record. Primary key for the association.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to the academic program to which the instructor is affiliated',
    `instructor_id` BIGINT COMMENT 'Foreign key linking to the instructor who holds the program affiliation',
    `affiliation_type` STRING COMMENT 'Type of affiliation the instructor holds with the program. Primary indicates main program responsibility, secondary indicates supporting role, joint indicates shared appointment across programs, courtesy indicates non-compensated affiliation, affiliate indicates external/adjunct relationship, graduate_faculty indicates authorization to teach graduate courses and chair dissertations. Critical for accreditation faculty sufficiency calculations.',
    `appointment_term` STRING COMMENT 'Academic term or contract period for this affiliation (e.g., Fall 2024, AY 2024-2025, Multi-year). Supports term-based appointment tracking and renewal processes.',
    `effective_end_date` DATE COMMENT 'Date on which this program affiliation ended or will end. Null for current active affiliations. Supports historical tracking and transition planning.',
    `effective_start_date` DATE COMMENT 'Date on which this program affiliation became effective. Supports historical tracking of faculty affiliations for accreditation self-studies and workload history.',
    `graduate_faculty_status` STRING COMMENT 'Graduate faculty status of the instructor within this program. Full indicates authorization to teach graduate courses, chair dissertations, and serve on comprehensive exam committees. Associate indicates authorization to teach graduate courses and serve on committees but not chair. None indicates no graduate faculty privileges. Critical for graduate program accreditation and governance.',
    `is_primary_affiliation` BOOLEAN COMMENT 'Indicates whether this is the instructors primary program affiliation. Each instructor should have exactly one primary affiliation at any time. Used for reporting and organizational hierarchy.',
    `research_percentage` DECIMAL(18,2) COMMENT 'Percentage of the instructors research workload allocated to this program. Relevant for research-intensive programs and graduate programs where faculty research productivity contributes to program quality metrics.',
    `service_percentage` DECIMAL(18,2) COMMENT 'Percentage of the instructors service workload (committees, advising, governance) allocated to this program. Used for workload planning and faculty contribution assessment.',
    `teaching_percentage` DECIMAL(18,2) COMMENT 'Percentage of the instructors teaching workload allocated to this program. Used for faculty sufficiency calculations in accreditation reporting. Sum across all program affiliations for an instructor should equal 100% of their teaching FTE.',
    CONSTRAINT pk_program_affiliation PRIMARY KEY(`program_affiliation_id`)
) COMMENT 'This association product represents the formal appointment or affiliation relationship between an instructor and an academic program. It captures faculty sufficiency for accreditation, workload allocation across programs, graduate faculty status, and appointment terms. Each record links one instructor to one academic program with attributes that exist only in the context of this affiliation relationship, supporting accreditation reporting (AACSB, ABET faculty sufficiency requirements), workload planning, and academic governance.. Existence Justification: In higher education, instructors routinely hold formal affiliations with multiple academic programs (joint appointments, cross-disciplinary teaching, graduate faculty appointments), and programs require multiple affiliated faculty to meet accreditation standards for faculty sufficiency. The affiliation relationship itself carries critical operational data including workload allocation percentages, graduate faculty status, and appointment terms that belong to neither the instructor nor the program alone but to the specific instructor-program pairing.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`section` (
    `section_id` BIGINT COMMENT 'Primary key for the section association',
    `course_id` BIGINT COMMENT 'Foreign key linking to the course master record that defines the academic content, credit hours, and catalog attributes for this section',
    `instructor_id` BIGINT COMMENT 'Foreign key linking to the instructor assigned to teach this section',
    `delivery_modality` STRING COMMENT 'The instructional delivery modality for this specific section. May differ from the course catalog default based on instructor preference or term-specific constraints.',
    `end_date` DATE COMMENT 'The last day of instruction for this section. Used for grade submission deadlines and faculty load calculations.',
    `enrollment_count` STRING COMMENT 'The current number of students enrolled in this section. Used for capacity management and faculty load reporting.',
    `meeting_pattern` STRING COMMENT 'The scheduled meeting days and times for this section (e.g., MWF 10:00-10:50, TR 14:00-15:15). Used for room scheduling and student schedule conflict detection.',
    `section_number` STRING COMMENT 'The section designator within the term (e.g., 001, 002, W01 for web sections). Distinguishes multiple offerings of the same course in the same term.',
    `start_date` DATE COMMENT 'The first day of instruction for this section. May differ from term start date for accelerated or late-start sections.',
    `term_code` STRING COMMENT 'The academic term in which this section is offered (e.g., 202401 for Spring 2024). Part of the natural key for section identity.',
    CONSTRAINT pk_section PRIMARY KEY(`section_id`)
) COMMENT 'This association product represents the specific offering of a course taught by an instructor in a particular term. It captures the operational reality of course delivery: scheduling, enrollment capacity, delivery modality, and meeting patterns. Each record links one course definition to one instructor for one term and section, with attributes that exist only in the context of this specific teaching assignment.. Existence Justification: In higher education operations, instructors teach multiple courses across different terms and sections, and courses are taught by different instructors depending on term, section, and faculty availability. The business actively manages course sections as operational entities with scheduling, enrollment capacity, delivery modality, and meeting patterns. Section is a recognized business concept in academic operations, distinct from both the course catalog definition and the instructor master record.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`teaching_assignment` (
    `teaching_assignment_id` BIGINT COMMENT 'Unique surrogate identifier for the teaching assignment record',
    `course_id` BIGINT COMMENT 'Foreign key linking to the course master record being taught',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the non-faculty staff employee assigned as instructor',
    `assignment_end_date` DATE COMMENT 'The date this teaching assignment ended, typically the last day of the term or when the instructor was reassigned.',
    `assignment_start_date` DATE COMMENT 'The date this teaching assignment became effective, typically the first day of the term or section start date.',
    `assignment_status` STRING COMMENT 'The current lifecycle status of the teaching assignment (Active, Completed, Cancelled, Pending).',
    `credit_hour_allocation` DECIMAL(18,2) COMMENT 'The number of credit hours allocated to this instructor for this course section, used for workload calculation. Explicitly identified in detection reasoning as relationship data.',
    `enrollment_count` STRING COMMENT 'The number of students enrolled in this course section at the time of assignment or as of census date. Explicitly identified in detection reasoning as relationship data.',
    `instructional_method` STRING COMMENT 'The instructional delivery method for this specific teaching assignment (e.g., lecture, lab, online, hybrid). Explicitly identified in detection reasoning as relationship data.',
    `primary_instructor_flag` BOOLEAN COMMENT 'Indicates whether this employee is the instructor-of-record (primary instructor) for this course section. Explicitly identified in detection reasoning as relationship data.',
    `section_number` STRING COMMENT 'The specific section number of the course being taught (e.g., 001, 002, LAB). Explicitly identified in detection reasoning as relationship data.',
    `term_code` STRING COMMENT 'The academic term code (e.g., 202401 for Spring 2024) during which this teaching assignment is active. Explicitly identified in detection reasoning as relationship data.',
    `workload_percentage` DECIMAL(18,2) COMMENT 'The percentage of teaching responsibility this instructor has for this course section (e.g., 100.00 for sole instructor, 50.00 for team-teaching). Explicitly identified in detection reasoning as relationship data.',
    CONSTRAINT pk_teaching_assignment PRIMARY KEY(`teaching_assignment_id`)
) COMMENT 'This association product represents the teaching assignment relationship between courses and instructors (non-faculty employees). It captures the operational assignment of staff instructors to course sections, including workload distribution, instructional role, and section-specific teaching responsibilities. Each record links one course to one employee with attributes that exist only in the context of this teaching relationship.. Existence Justification: In higher education operations, courses are routinely taught by multiple instructors through team-teaching arrangements, lab coordinators, teaching assistants, and co-instructors across different sections and terms. Simultaneously, instructors teach multiple courses per term as part of their workload. The registrar actively manages these teaching assignments as operational records, tracking instructor-of-record status, workload distribution, credit hour allocation, and section-specific responsibilities.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`course_training_requirement` (
    `course_training_requirement_id` BIGINT COMMENT 'Unique surrogate identifier for this course-training requirement association record',
    `course_id` BIGINT COMMENT 'Foreign key linking to the course master record that has associated compliance training requirements',
    `training_program_id` BIGINT COMMENT 'Foreign key linking to the compliance training program required for teaching the associated course',
    `assignment_date` DATE COMMENT 'Date on which this training requirement was established for this course, typically driven by regulatory changes, accreditation standards updates, or institutional policy revisions',
    `completion_deadline` DATE COMMENT 'Absolute date by which instructors teaching this course must complete the associated training. May be set based on term start dates, regulatory effective dates, or institutional policy timelines.',
    `completion_required_for_teaching` BOOLEAN COMMENT 'Indicates whether completion of this training is mandatory before an instructor can be assigned to teach this course. True means instructor cannot teach without current certification; False means training is recommended but not blocking.',
    `course_training_requirement_status` STRING COMMENT 'Current lifecycle status of this course-training requirement. Active requirements are enforced for instructor assignments; Inactive requirements are historical; Pending requirements are scheduled for future enforcement; Superseded requirements have been replaced by updated training programs.',
    `effective_end_date` DATE COMMENT 'Date on which this training requirement is no longer applicable for this course. Null indicates the requirement is currently active. Used when regulatory requirements change or courses are modified to no longer require specific training.',
    `effective_start_date` DATE COMMENT 'Date from which this training requirement is effective for this course. Used to track when requirements were added or modified.',
    `notes` STRING COMMENT 'Free-text notes documenting special circumstances, exceptions, or additional context for this specific course-training requirement pairing',
    `requirement_basis` STRING COMMENT 'The regulatory, accreditation, or policy basis that mandates this training for this course. Examples: Title IX - health sciences content, FERPA - student record access, ADA - online course delivery, IRB - human subjects research lab',
    `waiver_status` STRING COMMENT 'Current status of any waiver request for this training requirement for this course. Tracks whether an exception has been requested or granted due to equivalent prior training, subject matter expertise, or other institutional considerations.',
    CONSTRAINT pk_course_training_requirement PRIMARY KEY(`course_training_requirement_id`)
) COMMENT 'This association product represents the compliance training requirements mandated for faculty teaching specific courses. It captures which compliance training programs must be completed before or during instruction of particular courses, driven by regulatory requirements (Title IX, FERPA, accessibility standards, research ethics) and institutional policy. Each record links one course to one required training program with completion tracking attributes that exist only in the context of this teaching requirement relationship.. Existence Justification: In higher education compliance operations, courses require multiple compliance training programs based on their content and delivery characteristics (e.g., health courses require Title IX training, online courses require accessibility training, lab courses require research ethics training), and each compliance training program applies to multiple courses across different departments. Compliance officers actively manage these requirement mappings, tracking which trainings are mandatory for teaching specific courses, setting course-specific completion deadlines, managing waiver requests, and auditing instructor compliance before course assignments.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`course_asset_requirement` (
    `course_asset_requirement_id` BIGINT COMMENT 'Unique surrogate identifier for the course-asset requirement record',
    `course_id` BIGINT COMMENT 'Foreign key linking to the course master record that requires the IT asset',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to the IT asset master record required by the course',
    `asset_requirement_type` STRING COMMENT 'Classification of the requirement level indicating whether the asset is mandatory for course delivery, preferred but substitutable, or optional enhancement',
    `effective_date` DATE COMMENT 'Date from which this asset requirement becomes active for the course',
    `end_date` DATE COMMENT 'Date on which this asset requirement is no longer active, supporting historical tracking of changing technology requirements',
    `quantity_required` STRING COMMENT 'Number of units of this asset type required to support the course (e.g., 25 lab workstations for a computer science lab course)',
    `scheduling_priority` STRING COMMENT 'Numeric priority ranking used by registrar scheduling systems to resolve resource conflicts when multiple courses require the same asset during overlapping time periods',
    `section_number` STRING COMMENT 'Specific course section identifier when asset requirements vary by section (e.g., Section 001 uses Mac lab, Section 002 uses PC lab)',
    `term_code` STRING COMMENT 'Academic term identifier indicating when this asset requirement is active (e.g., Fall 2024, Spring 2025), allowing requirements to vary by term',
    CONSTRAINT pk_course_asset_requirement PRIMARY KEY(`course_asset_requirement_id`)
) COMMENT 'This association product represents the operational requirement relationship between courses and IT assets. It captures the specific technology assets required to deliver a course, including lab computers, specialized software, projectors, and equipment. Each record links one course to one IT asset with scheduling and quantity attributes that exist only in the context of this requirement. This supports registrar scheduling, facilities management, and resource conflict resolution across academic terms.. Existence Justification: In higher education operations, courses require multiple IT assets (lab computers, projectors, specialized software, equipment) to support delivery, and individual assets are shared across multiple courses throughout academic terms. The registrar and facilities management actively manage these requirements to schedule sections, avoid resource conflicts, and ensure availability. This is an operational relationship with specific attributes (quantity, priority, term) that belong to neither the course catalog nor the asset inventory alone.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`institution` (
    `institution_id` BIGINT COMMENT 'Primary key for institution',
    `parent_institution_id` BIGINT COMMENT 'Reference to the parent institution if this institution is a branch campus, satellite location, or subsidiary of a larger system.',
    `accreditation_date` DATE COMMENT 'Date when the institution received its current accreditation status from the primary accreditor.',
    `accreditation_expiration_date` DATE COMMENT 'Date when the current accreditation status expires and requires renewal or reaffirmation.',
    `accreditation_status` STRING COMMENT 'Current institutional accreditation standing with the primary regional or national accrediting body.',
    `address_line_1` STRING COMMENT 'Primary street address line for the institutions main campus or administrative headquarters.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, building, or department information.',
    `carnegie_classification` STRING COMMENT 'Carnegie Classification framework category describing the institutions mission, degree offerings, and research activity level.',
    `city` STRING COMMENT 'City where the institutions main campus or administrative headquarters is located.',
    `closure_date` DATE COMMENT 'Date when the institution ceased operations or closed permanently.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the institution is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this institution record was first created in the system.',
    `email_domain` STRING COMMENT 'Primary email domain used by the institution for official communications and student/faculty email accounts.',
    `enrollment_size_category` STRING COMMENT 'Classification of the institution based on total student enrollment headcount ranges.',
    `fax_number` STRING COMMENT 'Fax number for the institutions main administrative office.',
    `fice_code` STRING COMMENT 'Federal identification code used for Title IV financial aid eligibility and federal reporting.',
    `founded_year` STRING COMMENT 'Year the institution was originally established or chartered.',
    `hispanic_serving_institution` BOOLEAN COMMENT 'Indicates whether the institution meets the federal definition of a Hispanic-Serving Institution with at least 25% Hispanic enrollment.',
    `historically_black_college` BOOLEAN COMMENT 'Indicates whether the institution is designated as a Historically Black College or University under federal law.',
    `institution_code` STRING COMMENT 'Unique alphanumeric code assigned to the institution for external identification and reporting purposes.',
    `institution_level` STRING COMMENT 'Primary level of instruction offered by the institution based on degree programs.',
    `institution_name` STRING COMMENT 'Official legal name of the higher education institution.',
    `institution_type` STRING COMMENT 'Classification of the institution based on control and ownership structure.',
    `ipeds_unit_code` STRING COMMENT 'Six-digit identifier assigned by the National Center for Education Statistics for federal reporting.',
    `land_grant_institution` BOOLEAN COMMENT 'Indicates whether the institution is designated as a land-grant institution under the Morrill Acts.',
    `locale_classification` STRING COMMENT 'Geographic setting classification describing the institutions location as city, suburb, town, or rural.',
    `ope_code` STRING COMMENT 'Eight-digit identifier assigned by the US Department of Education Office of Postsecondary Education for Title IV program participation.',
    `operational_status` STRING COMMENT 'Current operational status of the institution indicating whether it is actively enrolling students and offering programs.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the institutions main administrative office.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the institutions main address.',
    `primary_accreditor` STRING COMMENT 'Name of the primary regional or national accrediting agency responsible for institutional accreditation.',
    `religious_affiliation` STRING COMMENT 'Religious denomination or affiliation of the institution, if applicable.',
    `research_classification` STRING COMMENT 'Classification of the institutions research activity level and doctoral program offerings.',
    `state_province` STRING COMMENT 'State or province where the institution is located, using standard postal abbreviations.',
    `system_name` STRING COMMENT 'Name of the higher education system or consortium to which the institution belongs, if applicable.',
    `title_iv_eligible` BOOLEAN COMMENT 'Indicates whether the institution is eligible to participate in federal Title IV student financial aid programs.',
    `tribal_college` BOOLEAN COMMENT 'Indicates whether the institution is a Tribal College or University chartered by a federally recognized tribe.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this institution record was last modified.',
    `website_url` STRING COMMENT 'Official website URL for the institution.',
    CONSTRAINT pk_institution PRIMARY KEY(`institution_id`)
) COMMENT 'Master reference table for institution. Referenced by partner_institution_id.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`assessment_instrument` (
    `assessment_instrument_id` BIGINT COMMENT 'Primary key for assessment_instrument',
    `rubric_id` BIGINT COMMENT 'Reference to the grading rubric used to evaluate student performance on this assessment instrument.',
    `parent_assessment_instrument_id` BIGINT COMMENT 'Self-referencing FK on assessment_instrument (parent_assessment_instrument_id)',
    `accessibility_compliant` BOOLEAN COMMENT 'Indicates whether the assessment instrument meets accessibility standards such as WCAG 2.1 AA for students with disabilities.',
    `accommodations_allowed` BOOLEAN COMMENT 'Indicates whether the assessment instrument allows for student accommodations such as extended time or assistive technology.',
    `accreditation_body` STRING COMMENT 'Name of the accreditation body that requires or recognizes this assessment instrument (e.g., AACSB, ABET, HLC).',
    `accreditation_required` BOOLEAN COMMENT 'Indicates whether this assessment instrument is required for program accreditation purposes by bodies such as AACSB or ABET.',
    `alignment_to_plo` BOOLEAN COMMENT 'Indicates whether this assessment instrument is formally aligned to one or more Program Learning Outcomes.',
    `alignment_to_slo` BOOLEAN COMMENT 'Indicates whether this assessment instrument is formally aligned to one or more Student Learning Outcomes.',
    `approval_date` DATE COMMENT 'Date when the assessment instrument was formally approved by the curriculum committee or academic authority.',
    `approved_by` STRING COMMENT 'Name or identifier of the academic authority or committee that approved this assessment instrument.',
    `assessment_method` STRING COMMENT 'Pedagogical method or approach used by the assessment instrument to measure learning outcomes.',
    `bloom_taxonomy_level` STRING COMMENT 'Highest cognitive level from Blooms Taxonomy that this assessment instrument is designed to measure.',
    `collaboration_allowed` BOOLEAN COMMENT 'Indicates whether students are permitted to collaborate or work in groups on this assessment instrument.',
    `created_date` DATE COMMENT 'Date when the assessment instrument record was first created in the curriculum management system.',
    `delivery_mode` STRING COMMENT 'Mode through which the assessment instrument is administered to students.',
    `assessment_instrument_description` STRING COMMENT 'Detailed description of the assessment instrument including its purpose, scope, and methodology.',
    `duration_minutes` STRING COMMENT 'Allocated time in minutes for students to complete the assessment instrument.',
    `effective_end_date` DATE COMMENT 'Date after which this assessment instrument is no longer active or available for use in courses.',
    `effective_start_date` DATE COMMENT 'Date from which this assessment instrument becomes active and available for use in courses.',
    `feedback_provided` BOOLEAN COMMENT 'Indicates whether students receive automated or instructor feedback upon completion of the assessment instrument.',
    `feedback_timing` STRING COMMENT 'Timing at which feedback is released to students relative to assessment submission and grading.',
    `instrument_code` STRING COMMENT 'Unique business identifier code for the assessment instrument used in catalogs and external references.',
    `instrument_type` STRING COMMENT 'Classification of the assessment instrument by its primary format and delivery method.',
    `last_modified_by` STRING COMMENT 'Name or identifier of the user who most recently modified this assessment instrument record.',
    `last_modified_date` DATE COMMENT 'Date when the assessment instrument record was most recently modified.',
    `maximum_retakes` STRING COMMENT 'Maximum number of times a student may retake or resubmit this assessment instrument if retakes are allowed.',
    `notes` STRING COMMENT 'Additional notes, comments, or instructions related to the assessment instrument for faculty or administrative reference.',
    `passing_score` DECIMAL(18,2) COMMENT 'Minimum score or points required to achieve a passing grade on this assessment instrument.',
    `proctoring_required` BOOLEAN COMMENT 'Indicates whether the assessment instrument requires proctoring or invigilation during administration.',
    `question_count` STRING COMMENT 'Total number of questions, items, or components included in this assessment instrument.',
    `randomization_enabled` BOOLEAN COMMENT 'Indicates whether question order or answer choices are randomized to reduce academic dishonesty.',
    `retake_allowed` BOOLEAN COMMENT 'Indicates whether students are permitted to retake or resubmit this assessment instrument for a revised grade.',
    `retired_date` DATE COMMENT 'Date when the assessment instrument was formally retired from active curriculum use.',
    `retired_reason` STRING COMMENT 'Explanation or justification for why the assessment instrument was retired from active use.',
    `short_title` STRING COMMENT 'Abbreviated or shortened title of the assessment instrument for display in constrained spaces.',
    `assessment_instrument_status` STRING COMMENT 'Current lifecycle status of the assessment instrument in the curriculum management system.',
    `title` STRING COMMENT 'Full official title of the assessment instrument as it appears in curriculum documentation.',
    `total_points` DECIMAL(18,2) COMMENT 'Maximum possible points or score that can be earned on this assessment instrument.',
    `version_number` STRING COMMENT 'Version identifier for the assessment instrument to track revisions and updates over time.',
    `weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight of this assessment instrument in the overall course grade calculation.',
    `created_by` STRING COMMENT 'Name or identifier of the faculty member or instructional designer who created this assessment instrument.',
    CONSTRAINT pk_assessment_instrument PRIMARY KEY(`assessment_instrument_id`)
) COMMENT 'Master reference table for assessment_instrument. Referenced by assessment_instrument_id.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`prerequisite_group` (
    `prerequisite_group_id` BIGINT COMMENT 'Primary key for prerequisite_group',
    `term_id` BIGINT COMMENT 'Identifier of the academic term when this prerequisite group was established or last revised.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the academic department responsible for maintaining and enforcing this prerequisite group.',
    `parent_group_id` BIGINT COMMENT 'Identifier of the parent prerequisite group when this group is nested within a hierarchical prerequisite structure. Null for top-level groups.',
    `parent_prerequisite_group_id` BIGINT COMMENT 'Self-referencing FK on prerequisite_group (parent_prerequisite_group_id)',
    `applies_to_transfer_students` BOOLEAN COMMENT 'Indicates whether this prerequisite group applies to transfer students or only to native students. Used for articulation agreement handling.',
    `approval_date` DATE COMMENT 'Date when this prerequisite group was approved by the curriculum committee or authorized governance body.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or committee that approved this prerequisite group.',
    `catalog_display_text` STRING COMMENT 'Formatted text describing this prerequisite group as it should appear in the course catalog and student-facing documentation.',
    `competency_framework` STRING COMMENT 'Name or identifier of the competency framework used to define prerequisite competencies in this group. Applicable when group_type is competency.',
    `concurrent_enrollment_allowed` BOOLEAN COMMENT 'Indicates whether students may enroll in the target course concurrently with prerequisites in this group (true) or must complete them beforehand (false).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this prerequisite group record was first created in the system.',
    `prerequisite_group_description` STRING COMMENT 'Detailed description of the prerequisite group explaining the requirements, rationale, and any special conditions or notes for students and advisors.',
    `effective_date` DATE COMMENT 'Date when this prerequisite group becomes effective and begins to be enforced for course enrollment.',
    `enforcement_level` STRING COMMENT 'Level of enforcement for this prerequisite group: hard_block prevents enrollment, soft_warning allows enrollment with notification, advisory_only provides guidance without restriction.',
    `expiration_date` DATE COMMENT 'Date when this prerequisite group expires and is no longer enforced. Null indicates no expiration.',
    `group_code` STRING COMMENT 'Business identifier code for the prerequisite group used in course catalogs and curriculum documentation.',
    `group_name` STRING COMMENT 'Human-readable name of the prerequisite group describing the collection of prerequisite requirements.',
    `group_type` STRING COMMENT 'Classification of the prerequisite group indicating the nature of requirements (course-based, competency-based, test-based, corequisite, concurrent enrollment, or advisory).',
    `logic_operator` STRING COMMENT 'Boolean logic operator defining how prerequisites within this group must be satisfied (AND requires all, OR requires any one, XOR requires exactly one).',
    `minimum_courses_required` STRING COMMENT 'Minimum number of courses from this prerequisite group that must be completed to satisfy the requirement. Used for flexible prerequisite structures.',
    `minimum_credits_required` DECIMAL(18,2) COMMENT 'Minimum number of credit hours from courses in this prerequisite group required to satisfy the prerequisite. Supports credit-based prerequisite rules.',
    `minimum_gpa_required` DECIMAL(18,2) COMMENT 'Minimum cumulative or prerequisite-specific GPA required for courses in this group, on a 4.0 scale.',
    `minimum_grade_required` STRING COMMENT 'Minimum grade that must be achieved in prerequisite courses within this group (e.g., C-, B, P for Pass, S for Satisfactory).',
    `minimum_test_score` STRING COMMENT 'Minimum score on the specified test required to satisfy this prerequisite group. Applicable when group_type is placement_test.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this prerequisite group record was last modified.',
    `revision_number` STRING COMMENT 'Version number tracking revisions to this prerequisite group over time. Increments with each approved change.',
    `sequence_order` STRING COMMENT 'Numeric ordering of this prerequisite group when multiple groups apply to a course, controlling display and evaluation sequence.',
    `prerequisite_group_status` STRING COMMENT 'Current lifecycle status of the prerequisite group indicating whether it is actively enforced, inactive, awaiting curriculum committee approval, or archived.',
    `test_score_type` STRING COMMENT 'Type of standardized or placement test that can satisfy this prerequisite group (e.g., SAT, ACT, AP, CLEP, institutional placement test). Applicable when group_type is placement_test.',
    `waiver_allowed` BOOLEAN COMMENT 'Indicates whether this prerequisite group can be waived by authorized personnel (department chair, advisor, registrar).',
    `waiver_authority_role` STRING COMMENT 'Role or position authorized to grant waivers for this prerequisite group when waiver_allowed is true.',
    CONSTRAINT pk_prerequisite_group PRIMARY KEY(`prerequisite_group_id`)
) COMMENT 'Master reference table for prerequisite_group. Referenced by prerequisite_group_id.';

CREATE OR REPLACE TABLE `education_ecm`.`curriculum`.`competency_framework` (
    `competency_framework_id` BIGINT COMMENT 'Primary key for competency_framework',
    `parent_competency_framework_id` BIGINT COMMENT 'Self-referencing FK on competency_framework (parent_competency_framework_id)',
    `accreditation_body` STRING COMMENT 'Name of the accrediting agency or quality assurance body associated with this framework (e.g., AACSB, ABET, SACSCOC, HLC). Used for compliance tracking and program review.',
    `accreditation_standard_reference` STRING COMMENT 'Specific accreditation standard or criterion document reference that this framework addresses (e.g., AACSB Standard 9: Curriculum Content, ABET Criterion 3: Student Outcomes).',
    `alignment_standard` STRING COMMENT 'External standard or framework to which this competency framework is aligned or mapped (e.g., Degree Qualifications Profile, Lumina Foundation DQP, European Qualifications Framework). Supports articulation and transfer.',
    `applicable_degree_levels` STRING COMMENT 'Comma-separated list of degree levels to which this framework applies (e.g., undergraduate, graduate, doctoral, certificate, associate). Supports filtering and applicability rules. [ENUM-REF-CANDIDATE: undergraduate|graduate|doctoral|certificate|associate|professional|post_doctoral — promote to reference product if more granular tracking needed]',
    `approval_authority` STRING COMMENT 'Name of the committee, board, or individual with authority to approve adoption or revision of this competency framework (e.g., Faculty Senate, Curriculum Committee, Dean of Academic Affairs).',
    `approval_date` DATE COMMENT 'Date when the competency framework was formally approved for use by the designated approval authority.',
    `cip_code` STRING COMMENT 'Six-digit CIP code identifying the instructional program area aligned with this competency framework (e.g., 52.0201 for Business Administration). Supports federal reporting and program classification.',
    `competency_domains` STRING COMMENT 'Total number of distinct competency domains or categories defined in this framework (e.g., cognitive, affective, psychomotor; or technical, professional, interpersonal).',
    `competency_levels` STRING COMMENT 'Total number of hierarchical competency levels defined in this framework (e.g., 3 for beginner/intermediate/advanced, 6 for Blooms cognitive levels). Used for competency progression mapping.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this competency framework record was first created in the system. Supports audit trail and data lineage.',
    `competency_framework_description` STRING COMMENT 'Detailed narrative description of the competency framework, including its purpose, scope, intended audience, and key competency domains covered.',
    `discipline` STRING COMMENT 'Primary academic discipline or field of study to which this competency framework applies (e.g., Business Administration, Engineering, Computer Science, Liberal Arts). May be null for cross-disciplinary frameworks.',
    `documentation_url` STRING COMMENT 'URL link to the official documentation, guidelines, or detailed specification of the competency framework. Provides access to full framework details for faculty and administrators.',
    `effective_date` DATE COMMENT 'Date when this version of the competency framework became or will become active and applicable for curriculum mapping and assessment.',
    `expiration_date` DATE COMMENT 'Date when this version of the competency framework will be or was superseded or retired. Null for frameworks with no planned end date.',
    `framework_code` STRING COMMENT 'Externally-known unique code or identifier for the competency framework (e.g., AACSB-2020, ABET-EAC, QAA-FHEQ). Used for cross-institutional references and accreditation mapping.',
    `framework_name` STRING COMMENT 'Full official name of the competency framework (e.g., Association to Advance Collegiate Schools of Business Assurance of Learning Standards, Framework for Higher Education Qualifications).',
    `framework_type` STRING COMMENT 'Classification of the competency framework by scope and authority: accreditation (AACSB, ABET), institutional (university-specific), disciplinary (field-specific), professional (industry certification), national (country-level qualifications), or international (global standards).',
    `geographic_scope` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the primary geographic region or country for which this framework is designed (e.g., USA, GBR, AUS). Use INT for international frameworks.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether adoption of this competency framework is mandatory (true) or optional (false) for programs within its scope. Used for compliance enforcement.',
    `issuing_organization` STRING COMMENT 'Name of the organization, accrediting body, or institution that published and maintains the competency framework (e.g., AACSB International, ABET, Quality Assurance Agency for Higher Education).',
    `issuing_organization_url` STRING COMMENT 'Official website URL of the issuing organization where the framework documentation and updates can be accessed.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags for search and discovery of the competency framework (e.g., critical thinking, quantitative reasoning, communication, ethics, leadership).',
    `language` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the primary language in which the competency framework is published (e.g., ENG for English, SPA for Spanish, FRA for French).',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review or revision of the competency framework by the issuing organization or institutional committee.',
    `modified_by` STRING COMMENT 'Username or identifier of the person who last modified this competency framework record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this competency framework record was last modified. Supports change tracking and audit compliance.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review or revision of the competency framework. Used for governance planning and compliance tracking.',
    `notes` STRING COMMENT 'Additional free-text notes, implementation guidance, or contextual information about the competency framework. Used for special instructions or historical context.',
    `review_cycle_months` STRING COMMENT 'Standard interval in months for periodic review and update of the competency framework (e.g., 36 for three-year review cycle, 60 for five-year cycle). Supports governance and quality assurance.',
    `scope` STRING COMMENT 'Level of application for the competency framework: program (degree/certificate program level), course (individual course level), institutional (university-wide), discipline (academic field), or industry (professional sector).',
    `competency_framework_status` STRING COMMENT 'Current lifecycle status of the competency framework: draft (under development), active (in use), under_review (being revised), deprecated (phased out but still referenced), archived (historical record only).',
    `taxonomy_type` STRING COMMENT 'Educational taxonomy model used to structure competency levels within this framework: blooms (Blooms Taxonomy), solo (Structure of Observed Learning Outcomes), fink (Finks Taxonomy of Significant Learning), custom (institution-defined), or other.',
    `version` STRING COMMENT 'Version number of the competency framework (e.g., 1.0, 2.1, 3.0.1). Supports tracking of framework revisions and historical mappings.',
    `created_by` STRING COMMENT 'Username or identifier of the person who created this competency framework record in the system.',
    CONSTRAINT pk_competency_framework PRIMARY KEY(`competency_framework_id`)
) COMMENT 'Master reference table for competency_framework. Referenced by competency_framework_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ADD CONSTRAINT `fk_curriculum_academic_program_cip_code_id` FOREIGN KEY (`cip_code_id`) REFERENCES `education_ecm`.`curriculum`.`cip_code`(`cip_code_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course` ADD CONSTRAINT `fk_curriculum_course_cip_code_id` FOREIGN KEY (`cip_code_id`) REFERENCES `education_ecm`.`curriculum`.`cip_code`(`cip_code_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course` ADD CONSTRAINT `fk_curriculum_course_primary_cross_list_course_id` FOREIGN KEY (`primary_cross_list_course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ADD CONSTRAINT `fk_curriculum_degree_requirement_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ADD CONSTRAINT `fk_curriculum_degree_requirement_cip_code_id` FOREIGN KEY (`cip_code_id`) REFERENCES `education_ecm`.`curriculum`.`cip_code`(`cip_code_id`);
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ADD CONSTRAINT `fk_curriculum_degree_requirement_concentration_id` FOREIGN KEY (`concentration_id`) REFERENCES `education_ecm`.`curriculum`.`concentration`(`concentration_id`);
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ADD CONSTRAINT `fk_curriculum_degree_requirement_plo_id` FOREIGN KEY (`plo_id`) REFERENCES `education_ecm`.`curriculum`.`plo`(`plo_id`);
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ADD CONSTRAINT `fk_curriculum_degree_requirement_prerequisite_rule_id` FOREIGN KEY (`prerequisite_rule_id`) REFERENCES `education_ecm`.`curriculum`.`prerequisite_rule`(`prerequisite_rule_id`);
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ADD CONSTRAINT `fk_curriculum_prerequisite_rule_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ADD CONSTRAINT `fk_curriculum_prerequisite_rule_articulation_agreement_id` FOREIGN KEY (`articulation_agreement_id`) REFERENCES `education_ecm`.`curriculum`.`articulation_agreement`(`articulation_agreement_id`);
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ADD CONSTRAINT `fk_curriculum_prerequisite_rule_parent_rule_prerequisite_rule_id` FOREIGN KEY (`parent_rule_prerequisite_rule_id`) REFERENCES `education_ecm`.`curriculum`.`prerequisite_rule`(`prerequisite_rule_id`);
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ADD CONSTRAINT `fk_curriculum_prerequisite_rule_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ADD CONSTRAINT `fk_curriculum_prerequisite_rule_prerequisite_group_id` FOREIGN KEY (`prerequisite_group_id`) REFERENCES `education_ecm`.`curriculum`.`prerequisite_group`(`prerequisite_group_id`);
ALTER TABLE `education_ecm`.`curriculum`.`slo` ADD CONSTRAINT `fk_curriculum_slo_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`curriculum`.`slo` ADD CONSTRAINT `fk_curriculum_slo_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`curriculum`.`slo` ADD CONSTRAINT `fk_curriculum_slo_superseded_by_slo_id` FOREIGN KEY (`superseded_by_slo_id`) REFERENCES `education_ecm`.`curriculum`.`slo`(`slo_id`);
ALTER TABLE `education_ecm`.`curriculum`.`plo` ADD CONSTRAINT `fk_curriculum_plo_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`curriculum`.`plo` ADD CONSTRAINT `fk_curriculum_plo_prior_version_plo_id` FOREIGN KEY (`prior_version_plo_id`) REFERENCES `education_ecm`.`curriculum`.`plo`(`plo_id`);
ALTER TABLE `education_ecm`.`curriculum`.`map` ADD CONSTRAINT `fk_curriculum_map_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`curriculum`.`map` ADD CONSTRAINT `fk_curriculum_map_assessment_instrument_id` FOREIGN KEY (`assessment_instrument_id`) REFERENCES `education_ecm`.`curriculum`.`assessment_instrument`(`assessment_instrument_id`);
ALTER TABLE `education_ecm`.`curriculum`.`map` ADD CONSTRAINT `fk_curriculum_map_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`curriculum`.`map` ADD CONSTRAINT `fk_curriculum_map_plo_id` FOREIGN KEY (`plo_id`) REFERENCES `education_ecm`.`curriculum`.`plo`(`plo_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ADD CONSTRAINT `fk_curriculum_course_proposal_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ADD CONSTRAINT `fk_curriculum_program_proposal_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ADD CONSTRAINT `fk_curriculum_articulation_agreement_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ADD CONSTRAINT `fk_curriculum_articulation_agreement_institution_id` FOREIGN KEY (`institution_id`) REFERENCES `education_ecm`.`curriculum`.`institution`(`institution_id`);
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ADD CONSTRAINT `fk_curriculum_transfer_equivalency_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ADD CONSTRAINT `fk_curriculum_transfer_equivalency_articulation_agreement_id` FOREIGN KEY (`articulation_agreement_id`) REFERENCES `education_ecm`.`curriculum`.`articulation_agreement`(`articulation_agreement_id`);
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ADD CONSTRAINT `fk_curriculum_transfer_equivalency_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ADD CONSTRAINT `fk_curriculum_transfer_equivalency_institution_id` FOREIGN KEY (`institution_id`) REFERENCES `education_ecm`.`curriculum`.`institution`(`institution_id`);
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ADD CONSTRAINT `fk_curriculum_transfer_equivalency_sending_institution_id` FOREIGN KEY (`sending_institution_id`) REFERENCES `education_ecm`.`curriculum`.`institution`(`institution_id`);
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ADD CONSTRAINT `fk_curriculum_program_accreditation_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ADD CONSTRAINT `fk_curriculum_assessment_cycle_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ADD CONSTRAINT `fk_curriculum_assessment_cycle_plo_id` FOREIGN KEY (`plo_id`) REFERENCES `education_ecm`.`curriculum`.`plo`(`plo_id`);
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ADD CONSTRAINT `fk_curriculum_concentration_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ADD CONSTRAINT `fk_curriculum_concentration_cip_code_id` FOREIGN KEY (`cip_code_id`) REFERENCES `education_ecm`.`curriculum`.`cip_code`(`cip_code_id`);
ALTER TABLE `education_ecm`.`curriculum`.`curriculum_enrollment` ADD CONSTRAINT `fk_curriculum_curriculum_enrollment_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`curriculum`.`program_affiliation` ADD CONSTRAINT `fk_curriculum_program_affiliation_academic_program_id` FOREIGN KEY (`academic_program_id`) REFERENCES `education_ecm`.`curriculum`.`academic_program`(`academic_program_id`);
ALTER TABLE `education_ecm`.`curriculum`.`section` ADD CONSTRAINT `fk_curriculum_section_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` ADD CONSTRAINT `fk_curriculum_teaching_assignment_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course_training_requirement` ADD CONSTRAINT `fk_curriculum_course_training_requirement_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`curriculum`.`course_asset_requirement` ADD CONSTRAINT `fk_curriculum_course_asset_requirement_course_id` FOREIGN KEY (`course_id`) REFERENCES `education_ecm`.`curriculum`.`course`(`course_id`);
ALTER TABLE `education_ecm`.`curriculum`.`institution` ADD CONSTRAINT `fk_curriculum_institution_parent_institution_id` FOREIGN KEY (`parent_institution_id`) REFERENCES `education_ecm`.`curriculum`.`institution`(`institution_id`);
ALTER TABLE `education_ecm`.`curriculum`.`assessment_instrument` ADD CONSTRAINT `fk_curriculum_assessment_instrument_parent_assessment_instrument_id` FOREIGN KEY (`parent_assessment_instrument_id`) REFERENCES `education_ecm`.`curriculum`.`assessment_instrument`(`assessment_instrument_id`);
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_group` ADD CONSTRAINT `fk_curriculum_prerequisite_group_parent_group_id` FOREIGN KEY (`parent_group_id`) REFERENCES `education_ecm`.`curriculum`.`prerequisite_group`(`prerequisite_group_id`);
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_group` ADD CONSTRAINT `fk_curriculum_prerequisite_group_parent_prerequisite_group_id` FOREIGN KEY (`parent_prerequisite_group_id`) REFERENCES `education_ecm`.`curriculum`.`prerequisite_group`(`prerequisite_group_id`);
ALTER TABLE `education_ecm`.`curriculum`.`competency_framework` ADD CONSTRAINT `fk_curriculum_competency_framework_parent_competency_framework_id` FOREIGN KEY (`parent_competency_framework_id`) REFERENCES `education_ecm`.`curriculum`.`competency_framework`(`competency_framework_id`);

-- ========= TAGS =========
ALTER SCHEMA `education_ecm`.`curriculum` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `education_ecm`.`curriculum` SET TAGS ('dbx_domain' = 'curriculum');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` SET TAGS ('dbx_subdomain' = 'program_design');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program ID');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `cip_code_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'College ID');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Campus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Collection Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Director Employee ID');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `state_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'State Authorization Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Specialized Accreditation Body');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Specialized Accreditation Status');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|candidate|not_accredited|probation|show_cause');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `admission_type` SET TAGS ('dbx_business_glossary_term' = 'Program Admission Type');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `admission_type` SET TAGS ('dbx_value_regex' = 'open|selective|competitive|cohort');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Governance Approval Date');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `capstone_required` SET TAGS ('dbx_business_glossary_term' = 'Capstone Experience Required Flag');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `catalog_year` SET TAGS ('dbx_business_glossary_term' = 'Effective Catalog Year');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `degree_designation` SET TAGS ('dbx_business_glossary_term' = 'Degree Designation');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `degree_level` SET TAGS ('dbx_business_glossary_term' = 'Degree Level');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `degree_level` SET TAGS ('dbx_value_regex' = 'associate|bachelor|master|doctoral|certificate|professional');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `delivery_modality` SET TAGS ('dbx_business_glossary_term' = 'Program Delivery Modality');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `delivery_modality` SET TAGS ('dbx_value_regex' = 'on_campus|online|hybrid|blended|competency_based');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `dfw_rate` SET TAGS ('dbx_business_glossary_term' = 'D-grade F-grade Withdrawal (DFW) Rate');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective End Date');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective Start Date');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `gainful_employment_applicable` SET TAGS ('dbx_business_glossary_term' = 'Gainful Employment Regulation Applicable Flag');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `internship_required` SET TAGS ('dbx_business_glossary_term' = 'Internship or Practicum Required Flag');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `ipeds_award_level` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Award Level Code');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `is_stem_designated` SET TAGS ('dbx_business_glossary_term' = 'Science Technology Engineering Mathematics (STEM) Designation Flag');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `last_curriculum_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Curriculum Review Date');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `licensure_track` SET TAGS ('dbx_business_glossary_term' = 'Professional Licensure Track Flag');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `max_transfer_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transfer Credit Hours Accepted');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `min_gpa_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Grade Point Average (GPA) Required');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `next_accreditation_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Accreditation Review Date');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `oer_adopted` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resources (OER) Adopted Flag');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Code');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{2,20}$');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Description');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `program_format` SET TAGS ('dbx_business_glossary_term' = 'Program Format');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `program_format` SET TAGS ('dbx_value_regex' = 'full_time|part_time|accelerated|executive|dual_degree');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Status');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|suspended|teach_out|discontinued|pending_approval');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `program_title` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Title');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `program_url` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Web URL');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `program_url` SET TAGS ('dbx_value_regex' = '^https?://.+$');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `six_year_graduation_rate` SET TAGS ('dbx_business_glossary_term' = 'Six-Year Graduation Rate');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `state_approval_required` SET TAGS ('dbx_business_glossary_term' = 'State Authorization Approval Required Flag');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `thesis_required` SET TAGS ('dbx_business_glossary_term' = 'Thesis or Dissertation Required Flag');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `title_iv_eligible` SET TAGS ('dbx_business_glossary_term' = 'Title IV Federal Financial Aid Eligible Flag');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `total_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Hours (CR) Required');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `total_enrolled_students` SET TAGS ('dbx_business_glossary_term' = 'Total Enrolled Students Count');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `typical_duration_semesters` SET TAGS ('dbx_business_glossary_term' = 'Typical Program Duration in Semesters');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`academic_program` ALTER COLUMN `va_approved` SET TAGS ('dbx_business_glossary_term' = 'Veterans Affairs (VA) Education Benefits Approved Flag');
ALTER TABLE `education_ecm`.`curriculum`.`course` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`curriculum`.`course` SET TAGS ('dbx_subdomain' = 'program_design');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course ID');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `cip_code_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'College ID');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `course_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Default Room Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Lms Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `primary_cross_list_course_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Cross-Listed Course ID');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `bib_record_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Textbook Bib Record Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Approval Date');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Approval Status');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|rejected|archived');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `banner_course_key` SET TAGS ('dbx_business_glossary_term' = 'Banner Course Master Key (Business Identifier)');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `canvas_course_code` SET TAGS ('dbx_business_glossary_term' = 'Canvas LMS Course Code');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `catalog_year_end` SET TAGS ('dbx_business_glossary_term' = 'Catalog Year End');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `catalog_year_start` SET TAGS ('dbx_business_glossary_term' = 'Catalog Year Start');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `contact_hours` SET TAGS ('dbx_business_glossary_term' = 'Contact Hours');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `corequisite_text` SET TAGS ('dbx_business_glossary_term' = 'Corequisite Text');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `course_description` SET TAGS ('dbx_business_glossary_term' = 'Course Description');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `course_level` SET TAGS ('dbx_business_glossary_term' = 'Course Level');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `course_number` SET TAGS ('dbx_business_glossary_term' = 'Course Number');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `course_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3,4}[A-Z]?$');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `course_status` SET TAGS ('dbx_business_glossary_term' = 'Course Status (Lifecycle Status)');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `course_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|suspended|discontinued');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `course_type` SET TAGS ('dbx_business_glossary_term' = 'Course Type (Instructional Format)');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR)');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `credit_hours_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Credit Hours');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `cross_listed_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Listed Course Flag');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `delivery_modality` SET TAGS ('dbx_business_glossary_term' = 'Delivery Modality');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `delivery_modality` SET TAGS ('dbx_value_regex' = 'in_person|online|hybrid|hyflex|synchronous_online|asynchronous_online');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `discontinue_date` SET TAGS ('dbx_business_glossary_term' = 'Course Discontinuation Date');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `gen_ed_category` SET TAGS ('dbx_business_glossary_term' = 'General Education Category');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `grading_basis` SET TAGS ('dbx_business_glossary_term' = 'Grading Basis');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `grading_basis` SET TAGS ('dbx_value_regex' = 'letter|pass_fail|audit|satisfactory_unsatisfactory|credit_no_credit');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `honors_eligible` SET TAGS ('dbx_business_glossary_term' = 'Honors Eligible Course Flag');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `lab_hours` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Hours');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `lecture_hours` SET TAGS ('dbx_business_glossary_term' = 'Lecture Hours');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `long_title` SET TAGS ('dbx_business_glossary_term' = 'Course Long Title');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `max_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Maximum Enrollment Capacity');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `max_repeat_hours` SET TAGS ('dbx_business_glossary_term' = 'Maximum Repeatable Credit Hours');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `oer_designated` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resources (OER) Designated Flag');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `prerequisite_text` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Text');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `repeatable` SET TAGS ('dbx_business_glossary_term' = 'Repeatable Course Indicator');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `stem_designated` SET TAGS ('dbx_business_glossary_term' = 'STEM Designated Course Flag');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `subject_code` SET TAGS ('dbx_business_glossary_term' = 'Subject Code (Course Prefix)');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `subject_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Course Title');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `transfer_equivalency_flag` SET TAGS ('dbx_business_glossary_term' = 'Transfer Equivalency Eligible Flag');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`course` ALTER COLUMN `writing_intensive` SET TAGS ('dbx_business_glossary_term' = 'Writing Intensive Course Flag');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` SET TAGS ('dbx_subdomain' = 'program_design');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `degree_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Degree Requirement ID');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program ID');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `cip_code_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `concentration_id` SET TAGS ('dbx_business_glossary_term' = 'Concentration Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `plo_id` SET TAGS ('dbx_business_glossary_term' = 'Program Learning Outcome (PLO) ID');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `prerequisite_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Requirement Group ID');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `allow_concurrent_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Allow Concurrent Enrollment Flag');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `allow_substitution` SET TAGS ('dbx_business_glossary_term' = 'Allow Course Substitution Flag');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `allow_test_credit` SET TAGS ('dbx_business_glossary_term' = 'Allow Examination Credit Flag');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `allow_transfer_credit` SET TAGS ('dbx_business_glossary_term' = 'Allow Transfer Credit Flag');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Approval Status');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|withdrawn');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Approval Date');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `approving_body` SET TAGS ('dbx_business_glossary_term' = 'Approving Governance Body');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `catalog_year` SET TAGS ('dbx_business_glossary_term' = 'Catalog Year');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `degree_type` SET TAGS ('dbx_business_glossary_term' = 'Degree Type');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `diversity_requirement` SET TAGS ('dbx_business_glossary_term' = 'Diversity Requirement Flag');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `is_repeatable` SET TAGS ('dbx_business_glossary_term' = 'Is Repeatable Flag');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `is_required` SET TAGS ('dbx_business_glossary_term' = 'Is Required Flag');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `level_code` SET TAGS ('dbx_business_glossary_term' = 'Academic Level Code');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `level_code` SET TAGS ('dbx_value_regex' = 'UG|GR|PF|DC');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `max_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Maximum Credit Hours (CR)');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `max_transfer_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transfer Credit Hours Allowed');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `min_course_count` SET TAGS ('dbx_business_glossary_term' = 'Minimum Course Count');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `min_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Credit Hours (CR)');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `min_gpa` SET TAGS ('dbx_business_glossary_term' = 'Minimum Grade Point Average (GPA) Threshold');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `min_grade` SET TAGS ('dbx_business_glossary_term' = 'Minimum Acceptable Grade');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `min_grade` SET TAGS ('dbx_value_regex' = '^[A-DF][+-]?$');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requirement Block Notes');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `oer_eligible` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resources (OER) Eligible Flag');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Requirement Block Code');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `requirement_name` SET TAGS ('dbx_business_glossary_term' = 'Requirement Block Name');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Block Status');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|archived|superseded');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Requirement Group Type');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `residency_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Residency Credit Hour Requirement');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Requirement Block Sequence Number');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `slo_alignment` SET TAGS ('dbx_business_glossary_term' = 'Student Learning Outcome (SLO) Alignment');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `smralib_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Banner SMRALIB Area/List Rule Code');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `smralib_rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,30}$');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `smrprle_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Banner SMRPRLE Rule Code');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `smrprle_rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,30}$');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `stem_designated` SET TAGS ('dbx_business_glossary_term' = 'STEM Designated Flag');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`degree_requirement` ALTER COLUMN `writing_intensive` SET TAGS ('dbx_business_glossary_term' = 'Writing Intensive Requirement Flag');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` SET TAGS ('dbx_subdomain' = 'program_design');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `prerequisite_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Rule ID');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Required Program ID');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `articulation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Articulation Agreement ID');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Effective Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `parent_rule_prerequisite_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Rule ID');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Controlling Course ID');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `prerequisite_group_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Group ID');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `advisory_only_flag` SET TAGS ('dbx_business_glossary_term' = 'Advisory Only Flag');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `ap_credit_applicable` SET TAGS ('dbx_business_glossary_term' = 'Advanced Placement (AP) Credit Applicable Flag');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `applicable_term_end` SET TAGS ('dbx_business_glossary_term' = 'Applicable Term End Code');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `applicable_term_end` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `boolean_operator` SET TAGS ('dbx_business_glossary_term' = 'Boolean Logic Operator');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `boolean_operator` SET TAGS ('dbx_value_regex' = 'AND|OR|NOT');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `catalog_year` SET TAGS ('dbx_business_glossary_term' = 'Catalog Year');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `catalog_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `class_standing_required` SET TAGS ('dbx_business_glossary_term' = 'Required Class Standing');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `class_standing_required` SET TAGS ('dbx_value_regex' = 'freshman|sophomore|junior|senior|graduate|doctoral');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `concurrent_enrollment_allowed` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Enrollment Allowed Flag');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `curriculum_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Committee Approval Date');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `dfw_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'DFW Rate Impact Flag');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `minimum_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Credit Hours (CR)');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `minimum_gpa` SET TAGS ('dbx_business_glossary_term' = 'Minimum Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `minimum_grade` SET TAGS ('dbx_business_glossary_term' = 'Minimum Grade Requirement');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `minimum_grade` SET TAGS ('dbx_value_regex' = 'A|A-|B+|B|B-|C+|C|C-|D+|D|P|S');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `minimum_grade_points` SET TAGS ('dbx_business_glossary_term' = 'Minimum Grade Point Value');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `minimum_test_score` SET TAGS ('dbx_business_glossary_term' = 'Minimum Test Score');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `nesting_level` SET TAGS ('dbx_business_glossary_term' = 'Nesting Level');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `override_permission_level` SET TAGS ('dbx_business_glossary_term' = 'Override Permission Level');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `override_permission_level` SET TAGS ('dbx_value_regex' = 'none|instructor|department_chair|registrar|dean');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `override_requires_documentation` SET TAGS ('dbx_business_glossary_term' = 'Override Requires Documentation Flag');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `program_enrollment_required` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment Required Flag');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `rationale` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Rule Rationale');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Rule Code');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Rule Description');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `rule_sequence` SET TAGS ('dbx_business_glossary_term' = 'Rule Sequence Number');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Rule Status');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|retired|draft');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Rule Type');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'prerequisite|corequisite|anti_requisite|pre_or_corequisite|test_score');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `sis_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'SIS Enforcement Flag');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `test_subject_code` SET TAGS ('dbx_business_glossary_term' = 'Test Subject Code');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `test_subject_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Standardized Test Type');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `transfer_credit_applicable` SET TAGS ('dbx_business_glossary_term' = 'Transfer Credit Applicable Flag');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`slo` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`curriculum`.`slo` SET TAGS ('dbx_subdomain' = 'program_design');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `slo_id` SET TAGS ('dbx_business_glossary_term' = 'Student Learning Outcome (SLO) ID');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course ID');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `superseded_by_slo_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By SLO ID');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `aacsb_standard_ref` SET TAGS ('dbx_business_glossary_term' = 'AACSB Assurance of Learning Standard Reference');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `abet_outcome_ref` SET TAGS ('dbx_business_glossary_term' = 'ABET Student Outcome Reference');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Approval Date');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Approval Status');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_required');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (Curriculum Committee)');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `assessment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Assessment Frequency');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `assessment_frequency` SET TAGS ('dbx_value_regex' = 'every_term|annual|biennial|rotating');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `assessment_level` SET TAGS ('dbx_business_glossary_term' = 'Assessment Level');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `assessment_level` SET TAGS ('dbx_value_regex' = 'course|program|institutional');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `assessment_tool` SET TAGS ('dbx_business_glossary_term' = 'Assessment Tool or Instrument');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `banner_outcome_code` SET TAGS ('dbx_business_glossary_term' = 'Ellucian Banner Outcome Code');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `blooms_domain` SET TAGS ('dbx_business_glossary_term' = 'Blooms Taxonomy Domain');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `blooms_domain` SET TAGS ('dbx_value_regex' = 'cognitive|affective|psychomotor');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `blooms_taxonomy_level` SET TAGS ('dbx_business_glossary_term' = 'Blooms Taxonomy Cognitive Level');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `blooms_taxonomy_level` SET TAGS ('dbx_value_regex' = 'remember|understand|apply|analyze|evaluate|create');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `credit_hour_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Hour (CR) Type');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `credit_hour_type` SET TAGS ('dbx_value_regex' = 'lecture|lab|studio|clinical|seminar|independent_study');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `curriculum_map_level` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Map Level');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `curriculum_map_level` SET TAGS ('dbx_value_regex' = 'introduced|developed|mastered');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `delivery_modality` SET TAGS ('dbx_business_glossary_term' = 'Delivery Modality');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `delivery_modality` SET TAGS ('dbx_value_regex' = 'face_to_face|online|hybrid|hyflex');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `effective_term` SET TAGS ('dbx_business_glossary_term' = 'Effective Academic Term');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `effective_term` SET TAGS ('dbx_value_regex' = '^[0-9]{4}(FA|SP|SU|WI)$');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `faculty_lead` SET TAGS ('dbx_business_glossary_term' = 'Faculty Assessment Lead');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `hlc_criterion_ref` SET TAGS ('dbx_business_glossary_term' = 'HLC Criterion Reference');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `is_core_outcome` SET TAGS ('dbx_business_glossary_term' = 'Core Outcome Indicator');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `is_general_education` SET TAGS ('dbx_business_glossary_term' = 'General Education Outcome Indicator');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `is_stem_designated` SET TAGS ('dbx_business_glossary_term' = 'STEM Designation Indicator');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Curriculum Review Date');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `lms_outcome_code` SET TAGS ('dbx_business_glossary_term' = 'Learning Management System (LMS) Outcome ID');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'SLO Notes');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `oer_aligned` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resources (OER) Alignment Indicator');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `outcome_statement` SET TAGS ('dbx_business_glossary_term' = 'Student Learning Outcome (SLO) Statement');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `outcome_status` SET TAGS ('dbx_business_glossary_term' = 'Student Learning Outcome (SLO) Status');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `outcome_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|under_review|retired');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owning Department');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `performance_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Performance Threshold Percentage');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `plo_alignment` SET TAGS ('dbx_business_glossary_term' = 'Program Learning Outcome (PLO) Alignment Code');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `proficiency_benchmark` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Benchmark Description');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `retirement_term` SET TAGS ('dbx_business_glossary_term' = 'Retirement Academic Term');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `retirement_term` SET TAGS ('dbx_value_regex' = '^[0-9]{4}(FA|SP|SU|WI)$');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `sacscoc_standard_ref` SET TAGS ('dbx_business_glossary_term' = 'SACSCOC Standard Reference');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `scorm_objective_code` SET TAGS ('dbx_business_glossary_term' = 'SCORM Objective ID');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `slo_code` SET TAGS ('dbx_business_glossary_term' = 'Student Learning Outcome (SLO) Code');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `slo_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}-SLO-[0-9]{3}$');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`slo` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'SLO Version Number');
ALTER TABLE `education_ecm`.`curriculum`.`plo` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`curriculum`.`plo` SET TAGS ('dbx_subdomain' = 'program_design');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `plo_id` SET TAGS ('dbx_business_glossary_term' = 'Program Learning Outcome (PLO) ID');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program ID');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'PLO Assessment Lead Employee ID');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `prior_version_plo_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Version PLO ID');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `accreditation_standard_code` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Standard Code');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `accrediting_body` SET TAGS ('dbx_business_glossary_term' = 'Accrediting Body');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'PLO Curriculum Approval Date');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'PLO Approving Authority');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `assessment_cycle` SET TAGS ('dbx_business_glossary_term' = 'PLO Assessment Cycle');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `assessment_cycle` SET TAGS ('dbx_value_regex' = 'annual|biennial|triennial|continuous|other');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'PLO Assessment Method');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `assessment_tool_name` SET TAGS ('dbx_business_glossary_term' = 'PLO Assessment Tool Name');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `bloom_taxonomy_level` SET TAGS ('dbx_business_glossary_term' = 'Blooms Taxonomy Cognitive Level');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `bloom_taxonomy_level` SET TAGS ('dbx_value_regex' = 'remember|understand|apply|analyze|evaluate|create');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `catalog_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Catalog Year');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `catalog_year` SET TAGS ('dbx_value_regex' = '^d{4}-d{4}$');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^d{2}.d{4}$');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `course_count` SET TAGS ('dbx_business_glossary_term' = 'Mapped Course Count');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'PLO Record Created Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `degree_level` SET TAGS ('dbx_business_glossary_term' = 'Degree Level');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `direct_indirect_indicator` SET TAGS ('dbx_business_glossary_term' = 'PLO Assessment Direct/Indirect Indicator');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `direct_indirect_indicator` SET TAGS ('dbx_value_regex' = 'direct|indirect|both');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `domain_area` SET TAGS ('dbx_business_glossary_term' = 'PLO Domain Area');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'PLO Effective Date');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `improvement_action_notes` SET TAGS ('dbx_business_glossary_term' = 'PLO Continuous Improvement Action Notes');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `institutional_mission_alignment` SET TAGS ('dbx_business_glossary_term' = 'Institutional Mission Alignment Statement');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `is_accreditation_required` SET TAGS ('dbx_business_glossary_term' = 'PLO Accreditation Required Indicator');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `is_core_outcome` SET TAGS ('dbx_business_glossary_term' = 'PLO Core Outcome Indicator');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `is_general_education` SET TAGS ('dbx_business_glossary_term' = 'General Education Outcome Indicator');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'PLO Last Reviewed Date');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'PLO Next Scheduled Review Date');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'PLO Administrative Notes');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `outcome_category` SET TAGS ('dbx_business_glossary_term' = 'Program Learning Outcome (PLO) Category');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `outcome_category` SET TAGS ('dbx_value_regex' = 'knowledge|skill|disposition|value|competency|other');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `outcome_statement` SET TAGS ('dbx_business_glossary_term' = 'Program Learning Outcome (PLO) Statement');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `outcome_status` SET TAGS ('dbx_business_glossary_term' = 'Program Learning Outcome (PLO) Status');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `outcome_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|suspended|retired');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `plo_code` SET TAGS ('dbx_business_glossary_term' = 'Program Learning Outcome (PLO) Code');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `plo_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `proficiency_scale_max` SET TAGS ('dbx_business_glossary_term' = 'PLO Proficiency Scale Maximum Score');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `proficiency_threshold_score` SET TAGS ('dbx_business_glossary_term' = 'PLO Proficiency Threshold Score');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'PLO Retirement Date');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'PLO Sequence Number');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `slo_count` SET TAGS ('dbx_business_glossary_term' = 'Mapped Student Learning Outcome (SLO) Count');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `strategic_goal_reference` SET TAGS ('dbx_business_glossary_term' = 'Institutional Strategic Goal Reference');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `target_benchmark_pct` SET TAGS ('dbx_business_glossary_term' = 'PLO Target Performance Benchmark Percentage');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'PLO Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'PLO Version Number');
ALTER TABLE `education_ecm`.`curriculum`.`plo` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^d+.d+$');
ALTER TABLE `education_ecm`.`curriculum`.`map` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`curriculum`.`map` SET TAGS ('dbx_subdomain' = 'program_design');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `map_id` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Map ID');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program ID');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `assessment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Instrument ID');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `accreditation_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Accreditation Standard Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course ID');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Faculty ID');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Mapping Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `plo_id` SET TAGS ('dbx_business_glossary_term' = 'Program Learning Outcome (PLO) ID');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `academic_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `accreditation_standard_ref` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Standard Reference');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method Type');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'direct|indirect|both');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `catalog_year` SET TAGS ('dbx_business_glossary_term' = 'Catalog Year');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `catalog_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `closing_loop_action` SET TAGS ('dbx_business_glossary_term' = 'Closing the Loop Action');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `college_name` SET TAGS ('dbx_business_glossary_term' = 'College or School Name');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `coverage_level` SET TAGS ('dbx_business_glossary_term' = 'Coverage Level (Introduced / Reinforced / Mastered)');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `coverage_level` SET TAGS ('dbx_value_regex' = 'I|R|M');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR)');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `curriculum_committee_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Committee Approval Date');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `degree_level` SET TAGS ('dbx_business_glossary_term' = 'Degree Level');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `degree_level` SET TAGS ('dbx_value_regex' = 'associate|bachelor|master|doctoral|certificate|professional');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `delivery_modality` SET TAGS ('dbx_business_glossary_term' = 'Course Delivery Modality');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `delivery_modality` SET TAGS ('dbx_value_regex' = 'in_person|online|hybrid|hyflex|mooc');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `gap_analysis_notes` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Gap Analysis Notes');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `is_capstone` SET TAGS ('dbx_business_glossary_term' = 'Capstone Course Flag');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `is_oer_designated` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resources (OER) Designation Flag');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `is_writing_intensive` SET TAGS ('dbx_business_glossary_term' = 'Writing Intensive Course Flag');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `map_status` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Map Status');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `map_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|approved|retired');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `performance_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Performance Target Percentage');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `proficiency_threshold_score` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Threshold Score');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `slo_alignment` SET TAGS ('dbx_business_glossary_term' = 'Student Learning Outcome (SLO) Alignment');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `term_sequence_position` SET TAGS ('dbx_business_glossary_term' = 'Term Sequence Position');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`map` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Map Version Number');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` SET TAGS ('dbx_subdomain' = 'governance_workflow');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `course_proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Course Proposal ID');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Effective Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Existing Course Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'It Service Request Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `bib_record_id` SET TAGS ('dbx_business_glossary_term' = 'Library Resource Bib Record Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitter Employee ID');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `banner_course_nmbr` SET TAGS ('dbx_business_glossary_term' = 'Banner Course Number (SIS Reference)');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `banner_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Banner Integration Status');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `banner_integration_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `catalog_description` SET TAGS ('dbx_business_glossary_term' = 'Catalog Course Description');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `catalog_year` SET TAGS ('dbx_business_glossary_term' = 'Catalog Year');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `catalog_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `college_approved_date` SET TAGS ('dbx_business_glossary_term' = 'College Approval Date');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `committee_vote_date` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Committee Vote Date');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `committee_vote_outcome` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Committee Vote Outcome');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `committee_vote_outcome` SET TAGS ('dbx_value_regex' = 'approved|approved_with_conditions|rejected|deferred|tabled');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `contact_hours_lab` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Contact Hours');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `contact_hours_lecture` SET TAGS ('dbx_business_glossary_term' = 'Lecture Contact Hours');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `corequisite_description` SET TAGS ('dbx_business_glossary_term' = 'Corequisite Description');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `course_level` SET TAGS ('dbx_business_glossary_term' = 'Course Level');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `course_level` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|professional|doctoral|continuing_education');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR)');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Course Delivery Mode');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_value_regex' = 'face_to_face|online|hybrid|hyflex|correspondence');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `department_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Department Approval Date');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `effective_term` SET TAGS ('dbx_business_glossary_term' = 'Effective Term');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `effective_term` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `grading_basis` SET TAGS ('dbx_business_glossary_term' = 'Grading Basis');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `grading_basis` SET TAGS ('dbx_value_regex' = 'letter_grade|pass_fail|satisfactory_unsatisfactory|audit|credit_no_credit');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `library_resource_adequate_flag` SET TAGS ('dbx_business_glossary_term' = 'Library Resource Adequacy Flag');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `max_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Maximum Enrollment Capacity');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `oer_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resources (OER) Flag');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `prerequisite_description` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Description');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `proposal_number` SET TAGS ('dbx_business_glossary_term' = 'Course Proposal Number');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `proposal_number` SET TAGS ('dbx_value_regex' = '^CP-[0-9]{4}-[0-9]{5}$');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_business_glossary_term' = 'Course Proposal Status');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_business_glossary_term' = 'Course Proposal Type');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_value_regex' = 'new|modify|deactivate|reactivate|experimental');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `provost_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Provost Approval Date');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `rationale` SET TAGS ('dbx_business_glossary_term' = 'Proposal Rationale');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `repeat_credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Repeat Credit Hour Limit');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `repeatable_flag` SET TAGS ('dbx_business_glossary_term' = 'Course Repeatable Flag');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `resource_impact_statement` SET TAGS ('dbx_business_glossary_term' = 'Resource Impact Statement');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `short_title` SET TAGS ('dbx_business_glossary_term' = 'Course Short Title');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `slo_summary` SET TAGS ('dbx_business_glossary_term' = 'Student Learning Outcomes (SLO) Summary');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `stem_flag` SET TAGS ('dbx_business_glossary_term' = 'Science Technology Engineering Mathematics (STEM) Designation Flag');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Submitted Date');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `workflow_stage` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Workflow Stage');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `workflow_stage` SET TAGS ('dbx_value_regex' = 'department|college|curriculum_committee|provost|registrar|complete');
ALTER TABLE `education_ecm`.`curriculum`.`course_proposal` ALTER COLUMN `writing_intensive_flag` SET TAGS ('dbx_business_glossary_term' = 'Writing Intensive Course Flag');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` SET TAGS ('dbx_subdomain' = 'governance_workflow');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `program_proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Program Proposal Identifier (ID)');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Identifier (ID)');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `department_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'It Service Request Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'College Identifier (ID)');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Lead Employee Identifier (ID)');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Proposed Effective Term Identifier (ID)');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `state_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'State Authorization Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Supporting Collection Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `accreditation_required` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Required Flag');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `board_of_trustees_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Board of Trustees Approval Date');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `curriculum_committee_vote_date` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Committee Vote Date');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `curriculum_committee_vote_result` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Committee Vote Result');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `curriculum_committee_vote_result` SET TAGS ('dbx_value_regex' = 'approved|approved_with_conditions|rejected|tabled|withdrawn');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `estimated_annual_operating_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Operating Cost');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `estimated_annual_operating_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `estimated_annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Revenue');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `estimated_annual_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `estimated_new_faculty_fte` SET TAGS ('dbx_business_glossary_term' = 'Estimated New Faculty Full-Time Equivalent (FTE)');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `estimated_startup_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Startup Cost');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `estimated_startup_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `external_accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'External Accreditation Body');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `facility_resource_requirements` SET TAGS ('dbx_business_glossary_term' = 'Facility Resource Requirements');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `faculty_resource_requirements` SET TAGS ('dbx_business_glossary_term' = 'Faculty Resource Requirements');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `faculty_senate_vote_date` SET TAGS ('dbx_business_glossary_term' = 'Faculty Senate Vote Date');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `faculty_senate_vote_result` SET TAGS ('dbx_business_glossary_term' = 'Faculty Senate Vote Result');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `faculty_senate_vote_result` SET TAGS ('dbx_value_regex' = 'approved|approved_with_conditions|rejected|tabled|withdrawn');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `final_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Date');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `hlc_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Higher Learning Commission (HLC) Approval Date');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `hlc_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Higher Learning Commission (HLC) Notification Date');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `hlc_substantive_change_required` SET TAGS ('dbx_business_glossary_term' = 'Higher Learning Commission (HLC) Substantive Change Required Flag');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `is_stem_designated` SET TAGS ('dbx_business_glossary_term' = 'Science Technology Engineering Mathematics (STEM) Designated Flag');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `library_resource_requirements` SET TAGS ('dbx_business_glossary_term' = 'Library Resource Requirements');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `market_demand_justification` SET TAGS ('dbx_business_glossary_term' = 'Market Demand Justification');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `projected_enrollment_year_one` SET TAGS ('dbx_business_glossary_term' = 'Projected Enrollment Year One');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `projected_enrollment_year_three` SET TAGS ('dbx_business_glossary_term' = 'Projected Enrollment Year Three');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `proposal_number` SET TAGS ('dbx_business_glossary_term' = 'Proposal Number');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `proposal_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4}-[0-9]{3}$');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_business_glossary_term' = 'Proposal Status');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_business_glossary_term' = 'Proposal Type');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_value_regex' = 'new_program|program_modification|program_suspension|program_discontinuation|program_reactivation|degree_level_change');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `proposed_cip_code` SET TAGS ('dbx_business_glossary_term' = 'Proposed Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `proposed_cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `proposed_degree_designation` SET TAGS ('dbx_business_glossary_term' = 'Proposed Degree Designation');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `proposed_degree_level` SET TAGS ('dbx_business_glossary_term' = 'Proposed Degree Level');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `proposed_delivery_modality` SET TAGS ('dbx_business_glossary_term' = 'Proposed Delivery Modality');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `proposed_program_title` SET TAGS ('dbx_business_glossary_term' = 'Proposed Program Title');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `proposed_total_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Proposed Total Credit Hours');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `provost_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Provost Approval Date');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `state_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'State Authorization Required Flag');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `state_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'State Authorization Status');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `state_authorization_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|submitted|approved|denied|conditional_approval');
ALTER TABLE `education_ecm`.`curriculum`.`program_proposal` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` SET TAGS ('dbx_subdomain' = 'governance_workflow');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `articulation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Articulation Agreement ID');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Program ID');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `institution_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Institution ID');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `active_student_count` SET TAGS ('dbx_business_glossary_term' = 'Active Student Count');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Agreement Code');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `agreement_notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending approval|active|suspended|expired|terminated');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `agreement_title` SET TAGS ('dbx_business_glossary_term' = 'Agreement Title');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = '2+2 pathway|3+1 pathway|course-by-course equivalency|statewide transfer compact|reverse transfer|dual enrollment|concurrent enrollment');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `agreement_url` SET TAGS ('dbx_business_glossary_term' = 'Agreement Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `approving_body` SET TAGS ('dbx_business_glossary_term' = 'Approving Body');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `contact_person_home` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Home Institution');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `contact_person_partner` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Partner Institution');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `degree_level_from` SET TAGS ('dbx_business_glossary_term' = 'Degree Level From');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `degree_level_from` SET TAGS ('dbx_value_regex' = 'certificate|associate|bachelor|master|doctoral');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `degree_level_to` SET TAGS ('dbx_business_glossary_term' = 'Degree Level To');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `degree_level_to` SET TAGS ('dbx_value_regex' = 'certificate|associate|bachelor|master|doctoral');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `governing_state` SET TAGS ('dbx_business_glossary_term' = 'Governing State');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `governing_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `guaranteed_admission_flag` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Admission Flag');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `min_gpa_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Grade Point Average (GPA) Required');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `partner_fice_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Interagency Committee on Education (FICE) Code');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `partner_fice_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `partner_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Institution Name');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `partner_institution_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Institution Type');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `partner_institution_type` SET TAGS ('dbx_value_regex' = 'community college|four-year college|university|technical college|system office');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `partner_opeid` SET TAGS ('dbx_business_glossary_term' = 'Office of Postsecondary Education Identification (OPEID) Number');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `partner_opeid` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Months');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `residency_requirement_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Residency Requirement Credit Hours (CR)');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `scholarship_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Eligibility Flag');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `sending_program_code` SET TAGS ('dbx_business_glossary_term' = 'Sending Program Code');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `signatory_authority_home` SET TAGS ('dbx_business_glossary_term' = 'Signatory Authority Home Institution');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `signatory_authority_partner` SET TAGS ('dbx_business_glossary_term' = 'Signatory Authority Partner Institution');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `state_mandate_code` SET TAGS ('dbx_business_glossary_term' = 'State Mandate Code');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `total_credit_hours_transferable` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Hours (CR) Transferable');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `total_students_transferred` SET TAGS ('dbx_business_glossary_term' = 'Total Students Transferred');
ALTER TABLE `education_ecm`.`curriculum`.`articulation_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` SET TAGS ('dbx_subdomain' = 'governance_workflow');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `transfer_equivalency_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Equivalency ID');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Applies to Program ID');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `articulation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Articulation Agreement ID');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Effective Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Course ID');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `institution_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Institution ID');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `sending_institution_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Institution ID');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `applies_to_degree_level` SET TAGS ('dbx_business_glossary_term' = 'Applies to Degree Level');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `applies_to_degree_level` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|certificate|all');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|revision_required');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `counts_toward_residency` SET TAGS ('dbx_business_glossary_term' = 'Counts Toward Residency Requirement');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `course_content_match_level` SET TAGS ('dbx_business_glossary_term' = 'Course Content Match Level');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `course_content_match_level` SET TAGS ('dbx_value_regex' = 'exact|substantial|partial|minimal');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `credit_hours_awarded` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR) Awarded');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `equivalency_type` SET TAGS ('dbx_business_glossary_term' = 'Equivalency Type');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `equivalency_type` SET TAGS ('dbx_value_regex' = 'direct|block|elective|general_education|major_requirement|no_credit');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_review|superseded|expired');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `external_equivalency_code` SET TAGS ('dbx_business_glossary_term' = 'External Equivalency ID');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `is_reciprocal` SET TAGS ('dbx_business_glossary_term' = 'Is Reciprocal Equivalency');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `learning_outcome_alignment` SET TAGS ('dbx_business_glossary_term' = 'Student Learning Outcome (SLO) Alignment');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `learning_outcome_alignment` SET TAGS ('dbx_value_regex' = 'full|high|moderate|low|not_assessed');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `max_credit_applicable` SET TAGS ('dbx_business_glossary_term' = 'Maximum Credit Hours (CR) Applicable');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `min_grade_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Grade Required');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `prerequisite_waived` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Waived');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `requirement_group_code` SET TAGS ('dbx_business_glossary_term' = 'Requirement Group Code');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `sending_course_code` SET TAGS ('dbx_business_glossary_term' = 'Sending Course Code');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `sending_course_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Sending Course Credit Hours (CR)');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `sending_course_subject` SET TAGS ('dbx_business_glossary_term' = 'Sending Course Subject Area');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `sending_course_title` SET TAGS ('dbx_business_glossary_term' = 'Sending Course Title');
ALTER TABLE `education_ecm`.`curriculum`.`transfer_equivalency` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` SET TAGS ('dbx_subdomain' = 'governance_workflow');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `program_accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'Program Accreditation Identifier (ID)');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Identifier (ID)');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Director Employee Identifier (ID)');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `tertiary_program_updated_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By Employee Identifier (ID)');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `tertiary_program_updated_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `tertiary_program_updated_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `accreditation_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Decision Date');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `accreditation_fees_annual` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Fees Annual');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `accreditation_level` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Level');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `accreditation_level` SET TAGS ('dbx_value_regex' = 'program|department|college|institutional');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `accreditation_standards_version` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Standards Version');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|candidate|probation|withdrawn|denied|expired');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `accreditation_type` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Type');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `accreditation_type` SET TAGS ('dbx_value_regex' = 'initial|continuing|reaffirmation|specialized|conditional');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `accreditation_url` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `accrediting_body` SET TAGS ('dbx_business_glossary_term' = 'Accrediting Body');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `annual_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Annual Report Due Date');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `annual_report_required` SET TAGS ('dbx_business_glossary_term' = 'Annual Report Required');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `appeal_filed` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `commendations` SET TAGS ('dbx_business_glossary_term' = 'Commendations');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|monitoring|remediation');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `conditions_cited` SET TAGS ('dbx_business_glossary_term' = 'Conditions Cited');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `current_accreditation_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Current Accreditation Effective Date');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `initial_accreditation_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Accreditation Date');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `interim_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Interim Report Due Date');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `interim_report_required` SET TAGS ('dbx_business_glossary_term' = 'Interim Report Required');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `public_disclosure_statement` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Statement');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `review_cycle_years` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Years');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `review_fees_estimated` SET TAGS ('dbx_business_glossary_term' = 'Review Fees Estimated');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `self_study_due_date` SET TAGS ('dbx_business_glossary_term' = 'Self-Study Due Date');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `site_visit_date` SET TAGS ('dbx_business_glossary_term' = 'Site Visit Date');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `substantive_change_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Substantive Change Approval Required');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `teach_out_plan_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Teach-Out Plan Approval Date');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `teach_out_plan_required` SET TAGS ('dbx_business_glossary_term' = 'Teach-Out Plan Required');
ALTER TABLE `education_ecm`.`curriculum`.`program_accreditation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` SET TAGS ('dbx_subdomain' = 'governance_workflow');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `assessment_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Cycle Identifier (ID)');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Identifier (ID)');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Lead Employee Identifier (ID)');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `accreditation_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Accreditation Standard Id (Foreign Key)');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `plo_id` SET TAGS ('dbx_business_glossary_term' = 'Program Learning Outcome (PLO) Identifier (ID)');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `accreditation_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Standard Reference');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `action_plan_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Approved Date');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `actual_mean_score` SET TAGS ('dbx_business_glossary_term' = 'Actual Mean Score');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `actual_proficiency_pct` SET TAGS ('dbx_business_glossary_term' = 'Actual Proficiency Percentage (Pct)');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `analysis_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Completed Date');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `assessment_method_description` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method Description');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `assessment_method_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method Type');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `assessment_method_type` SET TAGS ('dbx_value_regex' = 'direct|indirect');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `benchmark_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Met Flag');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `catalog_year` SET TAGS ('dbx_business_glossary_term' = 'Catalog Year');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `closure_evidence` SET TAGS ('dbx_business_glossary_term' = 'Closure of the Loop Evidence');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `cycle_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle Closed Date');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Assessment Cycle Code');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Assessment Cycle Name');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Cycle Status');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_value_regex' = 'planned|data_collection|analysis|action_planning|implementation|closed');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `data_collection_end_date` SET TAGS ('dbx_business_glossary_term' = 'Data Collection End Date');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `data_collection_instrument` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Instrument');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `data_collection_start_date` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Start Date');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `degree_level` SET TAGS ('dbx_business_glossary_term' = 'Degree Level');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `degree_level` SET TAGS ('dbx_value_regex' = 'certificate|associate|bachelor|master|doctoral|professional');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `gap_analysis` SET TAGS ('dbx_business_glossary_term' = 'Gap Analysis');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `implementation_timeline` SET TAGS ('dbx_business_glossary_term' = 'Implementation Timeline');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `improvement_actions` SET TAGS ('dbx_business_glossary_term' = 'Improvement Actions');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `instrument_version` SET TAGS ('dbx_business_glossary_term' = 'Instrument Version');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `proficiency_scale_max` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Scale Maximum');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `proficiency_threshold_score` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Threshold Score');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `results_summary` SET TAGS ('dbx_business_glossary_term' = 'Results Summary');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `sample_size_actual` SET TAGS ('dbx_business_glossary_term' = 'Sample Size Actual');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `sample_size_target` SET TAGS ('dbx_business_glossary_term' = 'Sample Size Target');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_cycle` ALTER COLUMN `target_benchmark_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Benchmark Percentage (Pct)');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` SET TAGS ('dbx_subdomain' = 'program_design');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `cip_code_id` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code Identifier');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `action_code` SET TAGS ('dbx_business_glossary_term' = 'CIP Action Code');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `action_code` SET TAGS ('dbx_value_regex' = 'new|revised|moved|deleted|no_change');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `cip_definition` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Definition');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `cip_edition_year` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Edition Year');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `cip_status` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Status');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `cip_status` SET TAGS ('dbx_value_regex' = 'active|inactive|moved|deleted');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `cip_title` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Title');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `cross_reference_cip_codes` SET TAGS ('dbx_business_glossary_term' = 'Cross-Reference CIP Codes');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `discontinue_date` SET TAGS ('dbx_business_glossary_term' = 'CIP Code Discontinue Date');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'CIP Code Effective Date');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `examples` SET TAGS ('dbx_business_glossary_term' = 'CIP Code Program Examples');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `four_digit_series` SET TAGS ('dbx_business_glossary_term' = 'Four-Digit CIP Series (Narrow Field)');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `four_digit_series` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{2}$');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `four_digit_series_title` SET TAGS ('dbx_business_glossary_term' = 'Four-Digit CIP Series Title');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `ipeds_reporting_eligible` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Reporting Eligible Flag');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `is_stem_designated` SET TAGS ('dbx_business_glossary_term' = 'Science Technology Engineering Mathematics (STEM) Designation Flag');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `nces_url` SET TAGS ('dbx_business_glossary_term' = 'National Center for Education Statistics (NCES) URL');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `opt_stem_extension_eligible` SET TAGS ('dbx_business_glossary_term' = 'Optional Practical Training (OPT) STEM Extension Eligible Flag');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `prior_cip_code_2010` SET TAGS ('dbx_business_glossary_term' = 'Prior CIP Code (2010 Edition)');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `title_iv_eligible` SET TAGS ('dbx_business_glossary_term' = 'Title IV Federal Financial Aid Eligible Flag');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `two_digit_series` SET TAGS ('dbx_business_glossary_term' = 'Two-Digit CIP Series (Broad Field)');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `two_digit_series` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `education_ecm`.`curriculum`.`cip_code` ALTER COLUMN `two_digit_series_title` SET TAGS ('dbx_business_glossary_term' = 'Two-Digit CIP Series Title');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` SET TAGS ('dbx_subdomain' = 'program_design');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `concentration_id` SET TAGS ('dbx_business_glossary_term' = 'Concentration Identifier (ID)');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Identifier (ID)');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `cip_code_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'College Identifier (ID)');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `concentration_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Concentration Director Employee Identifier (ID)');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|candidate|not_accredited|not_applicable');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `admission_requirements` SET TAGS ('dbx_business_glossary_term' = 'Admission Requirements');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `admission_restricted` SET TAGS ('dbx_business_glossary_term' = 'Admission Restricted Flag');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `appears_on_diploma` SET TAGS ('dbx_business_glossary_term' = 'Appears on Diploma Flag');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `appears_on_transcript` SET TAGS ('dbx_business_glossary_term' = 'Appears on Transcript Flag');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `banner_area_code` SET TAGS ('dbx_business_glossary_term' = 'Banner Area Code');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `banner_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `capstone_required` SET TAGS ('dbx_business_glossary_term' = 'Capstone Required Flag');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `catalog_year` SET TAGS ('dbx_business_glossary_term' = 'Catalog Year');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `catalog_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `concentration_code` SET TAGS ('dbx_business_glossary_term' = 'Concentration Code');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `concentration_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `concentration_description` SET TAGS ('dbx_business_glossary_term' = 'Concentration Description');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `concentration_status` SET TAGS ('dbx_business_glossary_term' = 'Concentration Status');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `concentration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|discontinued');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `concentration_type` SET TAGS ('dbx_business_glossary_term' = 'Concentration Type');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `concentration_type` SET TAGS ('dbx_value_regex' = 'concentration|track|specialization|emphasis|minor|certificate');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `core_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Core Credit Hours (CR)');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `elective_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Elective Credit Hours (CR)');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `honors_eligible` SET TAGS ('dbx_business_glossary_term' = 'Honors Eligible Flag');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `internship_required` SET TAGS ('dbx_business_glossary_term' = 'Internship Required Flag');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `ipeds_reportable` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Reportable Flag');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `last_curriculum_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Curriculum Review Date');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `max_transfer_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transfer Credit Hours (CR)');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `min_gpa_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Grade Point Average (GPA) Required');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `oer_designated` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resources (OER) Designated Flag');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `required_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Required Credit Hours (CR)');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `residency_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Residency Credit Hours (CR)');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `stem_designated` SET TAGS ('dbx_business_glossary_term' = 'Science Technology Engineering Mathematics (STEM) Designated Flag');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `thesis_required` SET TAGS ('dbx_business_glossary_term' = 'Thesis Required Flag');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Concentration Title');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `total_enrolled_students` SET TAGS ('dbx_business_glossary_term' = 'Total Enrolled Students');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Concentration Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `education_ecm`.`curriculum`.`concentration` ALTER COLUMN `writing_intensive` SET TAGS ('dbx_business_glossary_term' = 'Writing Intensive Flag');
ALTER TABLE `education_ecm`.`curriculum`.`curriculum_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`curriculum`.`curriculum_enrollment` SET TAGS ('dbx_subdomain' = 'teaching_operations');
ALTER TABLE `education_ecm`.`curriculum`.`curriculum_enrollment` SET TAGS ('dbx_association_edges' = 'curriculum.course,athletics.student_athlete');
ALTER TABLE `education_ecm`.`curriculum`.`curriculum_enrollment` ALTER COLUMN `curriculum_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'curriculum_enrollment Identifier');
ALTER TABLE `education_ecm`.`curriculum`.`curriculum_enrollment` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Course Id');
ALTER TABLE `education_ecm`.`curriculum`.`curriculum_enrollment` ALTER COLUMN `enrollment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Identifier');
ALTER TABLE `education_ecm`.`curriculum`.`curriculum_enrollment` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Student Athlete Id');
ALTER TABLE `education_ecm`.`curriculum`.`curriculum_enrollment` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`curriculum`.`curriculum_enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Course Completion Date');
ALTER TABLE `education_ecm`.`curriculum`.`curriculum_enrollment` ALTER COLUMN `credit_hours_earned` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours Earned');
ALTER TABLE `education_ecm`.`curriculum`.`curriculum_enrollment` ALTER COLUMN `degree_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Degree Applicable Flag');
ALTER TABLE `education_ecm`.`curriculum`.`curriculum_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `education_ecm`.`curriculum`.`curriculum_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `education_ecm`.`curriculum`.`curriculum_enrollment` ALTER COLUMN `grade` SET TAGS ('dbx_business_glossary_term' = 'Course Grade');
ALTER TABLE `education_ecm`.`curriculum`.`curriculum_enrollment` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Code');
ALTER TABLE `education_ecm`.`curriculum`.`program_affiliation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`curriculum`.`program_affiliation` SET TAGS ('dbx_subdomain' = 'teaching_operations');
ALTER TABLE `education_ecm`.`curriculum`.`program_affiliation` SET TAGS ('dbx_association_edges' = 'curriculum.academic_program,faculty.instructor');
ALTER TABLE `education_ecm`.`curriculum`.`program_affiliation` ALTER COLUMN `program_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Program Affiliation Identifier');
ALTER TABLE `education_ecm`.`curriculum`.`program_affiliation` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Affiliation - Academic Program Id');
ALTER TABLE `education_ecm`.`curriculum`.`program_affiliation` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Program Affiliation - Instructor Id');
ALTER TABLE `education_ecm`.`curriculum`.`program_affiliation` ALTER COLUMN `affiliation_type` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Type');
ALTER TABLE `education_ecm`.`curriculum`.`program_affiliation` ALTER COLUMN `appointment_term` SET TAGS ('dbx_business_glossary_term' = 'Appointment Term');
ALTER TABLE `education_ecm`.`curriculum`.`program_affiliation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Effective End Date');
ALTER TABLE `education_ecm`.`curriculum`.`program_affiliation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Effective Start Date');
ALTER TABLE `education_ecm`.`curriculum`.`program_affiliation` ALTER COLUMN `graduate_faculty_status` SET TAGS ('dbx_business_glossary_term' = 'Graduate Faculty Status');
ALTER TABLE `education_ecm`.`curriculum`.`program_affiliation` ALTER COLUMN `is_primary_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Primary Affiliation Flag');
ALTER TABLE `education_ecm`.`curriculum`.`program_affiliation` ALTER COLUMN `research_percentage` SET TAGS ('dbx_business_glossary_term' = 'Research Workload Percentage');
ALTER TABLE `education_ecm`.`curriculum`.`program_affiliation` ALTER COLUMN `service_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Workload Percentage');
ALTER TABLE `education_ecm`.`curriculum`.`program_affiliation` ALTER COLUMN `teaching_percentage` SET TAGS ('dbx_business_glossary_term' = 'Teaching Workload Percentage');
ALTER TABLE `education_ecm`.`curriculum`.`section` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`curriculum`.`section` SET TAGS ('dbx_subdomain' = 'teaching_operations');
ALTER TABLE `education_ecm`.`curriculum`.`section` SET TAGS ('dbx_association_edges' = 'curriculum.course,faculty.instructor');
ALTER TABLE `education_ecm`.`curriculum`.`section` ALTER COLUMN `section_id` SET TAGS ('dbx_business_glossary_term' = 'Section - Section Id');
ALTER TABLE `education_ecm`.`curriculum`.`section` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Section - Course Id');
ALTER TABLE `education_ecm`.`curriculum`.`section` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Section - Instructor Id');
ALTER TABLE `education_ecm`.`curriculum`.`section` ALTER COLUMN `delivery_modality` SET TAGS ('dbx_business_glossary_term' = 'Section Delivery Modality');
ALTER TABLE `education_ecm`.`curriculum`.`section` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Section End Date');
ALTER TABLE `education_ecm`.`curriculum`.`section` ALTER COLUMN `enrollment_count` SET TAGS ('dbx_business_glossary_term' = 'Current Enrollment Count');
ALTER TABLE `education_ecm`.`curriculum`.`section` ALTER COLUMN `meeting_pattern` SET TAGS ('dbx_business_glossary_term' = 'Meeting Pattern');
ALTER TABLE `education_ecm`.`curriculum`.`section` ALTER COLUMN `section_number` SET TAGS ('dbx_business_glossary_term' = 'Section Number');
ALTER TABLE `education_ecm`.`curriculum`.`section` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Section Start Date');
ALTER TABLE `education_ecm`.`curriculum`.`section` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Code');
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` SET TAGS ('dbx_subdomain' = 'teaching_operations');
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` SET TAGS ('dbx_association_edges' = 'curriculum.course,hr.employee');
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` ALTER COLUMN `teaching_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Teaching Assignment Identifier');
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Teaching Assignment - Course Id');
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Teaching Assignment - Employee Id');
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` ALTER COLUMN `credit_hour_allocation` SET TAGS ('dbx_business_glossary_term' = 'Credit Hour Allocation');
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` ALTER COLUMN `enrollment_count` SET TAGS ('dbx_business_glossary_term' = 'Section Enrollment Count');
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` ALTER COLUMN `instructional_method` SET TAGS ('dbx_business_glossary_term' = 'Instructional Method');
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` ALTER COLUMN `primary_instructor_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Instructor Indicator');
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` ALTER COLUMN `section_number` SET TAGS ('dbx_business_glossary_term' = 'Course Section Number');
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Code');
ALTER TABLE `education_ecm`.`curriculum`.`teaching_assignment` ALTER COLUMN `workload_percentage` SET TAGS ('dbx_business_glossary_term' = 'Workload Percentage');
ALTER TABLE `education_ecm`.`curriculum`.`course_training_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`curriculum`.`course_training_requirement` SET TAGS ('dbx_subdomain' = 'teaching_operations');
ALTER TABLE `education_ecm`.`curriculum`.`course_training_requirement` SET TAGS ('dbx_association_edges' = 'curriculum.course,compliance.training_program');
ALTER TABLE `education_ecm`.`curriculum`.`course_training_requirement` ALTER COLUMN `course_training_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Course Training Requirement ID');
ALTER TABLE `education_ecm`.`curriculum`.`course_training_requirement` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course Training Requirement - Course Id');
ALTER TABLE `education_ecm`.`curriculum`.`course_training_requirement` ALTER COLUMN `training_program_id` SET TAGS ('dbx_business_glossary_term' = 'Course Training Requirement - Compliance Training Id');
ALTER TABLE `education_ecm`.`curriculum`.`course_training_requirement` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Assignment Date');
ALTER TABLE `education_ecm`.`curriculum`.`course_training_requirement` ALTER COLUMN `completion_deadline` SET TAGS ('dbx_business_glossary_term' = 'Completion Deadline');
ALTER TABLE `education_ecm`.`curriculum`.`course_training_requirement` ALTER COLUMN `completion_required_for_teaching` SET TAGS ('dbx_business_glossary_term' = 'Completion Required for Teaching');
ALTER TABLE `education_ecm`.`curriculum`.`course_training_requirement` ALTER COLUMN `course_training_requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Status');
ALTER TABLE `education_ecm`.`curriculum`.`course_training_requirement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`curriculum`.`course_training_requirement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`curriculum`.`course_training_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requirement Notes');
ALTER TABLE `education_ecm`.`curriculum`.`course_training_requirement` ALTER COLUMN `requirement_basis` SET TAGS ('dbx_business_glossary_term' = 'Requirement Basis');
ALTER TABLE `education_ecm`.`curriculum`.`course_training_requirement` ALTER COLUMN `waiver_status` SET TAGS ('dbx_business_glossary_term' = 'Waiver Status');
ALTER TABLE `education_ecm`.`curriculum`.`course_asset_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`curriculum`.`course_asset_requirement` SET TAGS ('dbx_subdomain' = 'teaching_operations');
ALTER TABLE `education_ecm`.`curriculum`.`course_asset_requirement` SET TAGS ('dbx_association_edges' = 'curriculum.course,technology.it_asset');
ALTER TABLE `education_ecm`.`curriculum`.`course_asset_requirement` ALTER COLUMN `course_asset_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Course Asset Requirement ID');
ALTER TABLE `education_ecm`.`curriculum`.`course_asset_requirement` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course Asset Requirement - Course Id');
ALTER TABLE `education_ecm`.`curriculum`.`course_asset_requirement` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Course Asset Requirement - It Asset Id');
ALTER TABLE `education_ecm`.`curriculum`.`course_asset_requirement` ALTER COLUMN `asset_requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Requirement Type');
ALTER TABLE `education_ecm`.`curriculum`.`course_asset_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `education_ecm`.`curriculum`.`course_asset_requirement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `education_ecm`.`curriculum`.`course_asset_requirement` ALTER COLUMN `quantity_required` SET TAGS ('dbx_business_glossary_term' = 'Quantity Required');
ALTER TABLE `education_ecm`.`curriculum`.`course_asset_requirement` ALTER COLUMN `scheduling_priority` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Priority');
ALTER TABLE `education_ecm`.`curriculum`.`course_asset_requirement` ALTER COLUMN `section_number` SET TAGS ('dbx_business_glossary_term' = 'Section Number');
ALTER TABLE `education_ecm`.`curriculum`.`course_asset_requirement` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Term Code');
ALTER TABLE `education_ecm`.`curriculum`.`institution` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`curriculum`.`institution` SET TAGS ('dbx_subdomain' = 'teaching_operations');
ALTER TABLE `education_ecm`.`curriculum`.`institution` ALTER COLUMN `institution_id` SET TAGS ('dbx_business_glossary_term' = 'Institution Identifier');
ALTER TABLE `education_ecm`.`curriculum`.`institution` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`institution` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`institution` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`institution` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`institution` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`institution` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`institution` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`institution` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`institution` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`institution` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`institution` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`institution` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_instrument` SET TAGS ('dbx_subdomain' = 'governance_workflow');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_instrument` ALTER COLUMN `assessment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Instrument Identifier');
ALTER TABLE `education_ecm`.`curriculum`.`assessment_instrument` ALTER COLUMN `parent_assessment_instrument_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_group` SET TAGS ('dbx_subdomain' = 'teaching_operations');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_group` ALTER COLUMN `prerequisite_group_id` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Group Identifier');
ALTER TABLE `education_ecm`.`curriculum`.`prerequisite_group` ALTER COLUMN `parent_prerequisite_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`curriculum`.`competency_framework` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`curriculum`.`competency_framework` SET TAGS ('dbx_subdomain' = 'governance_workflow');
ALTER TABLE `education_ecm`.`curriculum`.`competency_framework` ALTER COLUMN `competency_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Framework Identifier');
ALTER TABLE `education_ecm`.`curriculum`.`competency_framework` ALTER COLUMN `parent_competency_framework_id` SET TAGS ('dbx_self_ref_fk' = 'true');
