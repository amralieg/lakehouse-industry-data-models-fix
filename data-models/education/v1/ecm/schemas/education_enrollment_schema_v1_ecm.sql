-- Schema for Domain: enrollment | Business: Education | Version: v1_ecm
-- Generated on: 2026-05-06 12:28:00

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `education_ecm`.`enrollment` COMMENT 'Manages the complete student enrollment lifecycle from prospective student recruitment, application processing, admissions decisions, through course registration, section scheduling, seat capacity, waitlists, add/drop/withdraw transactions, FTE calculations, and term-based enrollment cycles. Integrates recruitment through matriculation into active course enrollment.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`prospect` (
    `prospect_id` BIGINT COMMENT 'Unique surrogate identifier for the prospective student record in the Silver Layer lakehouse. Primary key for the prospect master record sourced from Slate CRM.',
    `employee_id` BIGINT COMMENT 'Identifier of the admissions counselor or recruiter assigned to manage this prospects recruitment relationship. Supports workload balancing, counselor performance analytics, and personalized outreach tracking.',
    `identity_account_id` BIGINT COMMENT 'Foreign key linking to technology.identity_account. Business justification: Prospects who engage digitally (event registration, portal access, inquiry forms) receive guest/prospect identity accounts for authentication and activity tracking. Essential for recruitment CRM integ',
    `principal_investigator_id` BIGINT COMMENT 'Foreign key linking to research.principal_investigator. Business justification: Graduate recruitment tracks prospective students interest in specific faculty research labs. Recruitment systems record which PI a prospect wants to work with, essential for targeted faculty outreach',
    `recruitment_territory_id` BIGINT COMMENT 'Foreign key linking to enrollment.recruitment_territory. Business justification: Prospects are assigned to recruitment territories for counselor assignment and outreach management. Currently prospect has territory_code as STRING but no FK to recruitment_territory. Adding recruitme',
    `act_score` STRING COMMENT 'The prospective students self-reported or ACT-supplied composite score. Used alongside SAT score for academic profile benchmarking and merit aid eligibility determination.',
    `address_line1` STRING COMMENT 'Primary street address line for the prospective students home address. Used for direct mail recruitment materials and geographic territory assignment.',
    `address_line2` STRING COMMENT 'Secondary street address line (apartment, suite, unit number) for the prospective students home address. Supplements address_line1 for complete mailing address construction.',
    `birth_date` DATE COMMENT 'Date of birth of the prospective student. Used for age verification, FERPA minor-student compliance determinations, and demographic reporting to IPEDS.',
    `campus_visit_flag` BOOLEAN COMMENT 'Indicates whether the prospective student has completed at least one campus visit (in-person or virtual). Campus visit is a strong predictor of application submission and is tracked as a key recruitment engagement signal.',
    `cip_code` STRING COMMENT 'The six-digit CIP code corresponding to the prospective students program of interest, as defined by the National Center for Education Statistics (NCES). Enables standardized program-level reporting to IPEDS and federal agencies.. Valid values are `^d{2}.d{4}$`',
    `citizenship_status` STRING COMMENT 'Citizenship or residency classification of the prospective student. Determines eligibility for federal financial aid (Title IV), in-state tuition, and visa processing requirements. Required for IPEDS reporting.. Valid values are `us_citizen|permanent_resident|international|daca|refugee|unknown`',
    `city` STRING COMMENT 'City of the prospective students home address. Used for geographic recruitment analytics, territory assignment, and targeted regional outreach campaigns.',
    `college_of_interest` STRING COMMENT 'The academic college or school within the institution that houses the prospective students program of interest (e.g., College of Engineering, School of Business). Supports college-level recruitment analytics and dean-level reporting.',
    `contact_preference` STRING COMMENT 'The prospective students preferred method of communication for recruitment outreach. Drives communication channel selection in Slate CRM automated workflows and ensures compliance with opt-out preferences.. Valid values are `email|phone|text|mail|no_contact`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the prospective students country of origin or permanent residence. Drives international vs. domestic classification, visa requirement identification, and TOEFL/IELTS requirement triggers.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the prospect record was first created in the system, representing the moment the prospective student entered the institutions recruitment pipeline. Audit field aligned with FERPA record-keeping requirements.',
    `degree_level` STRING COMMENT 'The academic degree level the prospective student is seeking. Used to route prospects to appropriate recruitment tracks and for IPEDS degree-level enrollment reporting.. Valid values are `certificate|associate|bachelor|master|doctoral|professional`',
    `do_not_contact_flag` BOOLEAN COMMENT 'Indicates that the prospective student has opted out of all recruitment communications. When True, suppresses all outbound contact in Slate CRM. Critical for CAN-SPAM, TCPA, and GDPR compliance.',
    `email` STRING COMMENT 'Primary email address used for all recruitment communications with the prospective student. Serves as the principal digital contact channel and is the operational source-of-truth contact identifier in Slate CRM.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `ethnicity` STRING COMMENT 'Self-reported racial/ethnic identity of the prospective student per federal OMB categories. Required for IPEDS race/ethnicity enrollment reporting and Title VI compliance monitoring. [ENUM-REF-CANDIDATE: hispanic_latino|american_indian_alaska_native|asian|black_african_american|native_hawaiian_pacific_islander|white|two_or_more_races|unknown — promote to reference product]',
    `first_generation_flag` BOOLEAN COMMENT 'Indicates whether the prospective student would be the first in their immediate family to earn a college degree. Used for targeted outreach, support program eligibility, and federal reporting on first-generation student recruitment.',
    `first_name` STRING COMMENT 'Legal given name of the prospective student as captured at initial inquiry. Used for personalized recruitment communications and identity matching against application records.',
    `ftiac_flag` BOOLEAN COMMENT 'Indicates whether the prospective student has never previously enrolled in any college or university. FTIAC classification is a key IPEDS reporting category and drives freshman-specific recruitment and orientation programming.',
    `gender` STRING COMMENT 'Self-reported gender identity of the prospective student. Used for IPEDS gender-disaggregated enrollment reporting and equity-focused recruitment analytics. Collected in compliance with institutional DEI policies.. Valid values are `male|female|non_binary|prefer_not_to_say|unknown`',
    `gpa_self_reported` DECIMAL(18,2) COMMENT 'The prospective students self-reported high school GPA on a 4.0 scale, as captured during the inquiry or pre-application process. Used for preliminary academic profile assessment and scholarship eligibility screening.',
    `high_school_ceeb_code` STRING COMMENT 'The College Entrance Examination Board (CEEB) six-digit code identifying the prospective students high school. Used for high school relationship management, feeder school analytics, and SAT/ACT score retrieval.. Valid values are `^[0-9]{6}$`',
    `high_school_graduation_year` STRING COMMENT 'The calendar year in which the prospective student graduated or is expected to graduate from high school. Used to determine academic readiness, cohort year classification, and gap-year identification.',
    `inquiry_date` DATE COMMENT 'The date on which the prospective student first expressed interest in the institution. Marks the start of the recruitment relationship and is used to calculate time-to-application and funnel velocity metrics.',
    `inquiry_source` STRING COMMENT 'The channel or origin through which the prospective student first expressed interest in the institution (e.g., college fair, website form, social media, purchased list, campus visit, referral, high school visit). Critical for recruitment ROI analysis and marketing attribution. [ENUM-REF-CANDIDATE: college_fair|website|social_media|purchased_list|campus_visit|referral|high_school_visit|test_score_service|alumni_referral|faculty_referral — promote to reference product]',
    `intended_entry_term` STRING COMMENT 'The academic term in which the prospective student intends to begin enrollment (e.g., Fall 2025, Spring 2026). Used for cohort planning, capacity forecasting, and term-based recruitment cycle management.',
    `intended_entry_year` STRING COMMENT 'The calendar year in which the prospective student intends to begin enrollment. Supports multi-year enrollment pipeline forecasting and cohort-level reporting.',
    `last_activity_date` DATE COMMENT 'The date of the most recent recorded recruitment interaction or engagement activity with the prospective student (e.g., email open, event attendance, portal login, counselor contact). Used to identify cold prospects and prioritize re-engagement.',
    `last_name` STRING COMMENT 'Legal family name (surname) of the prospective student as captured at initial inquiry. Used in combination with first_name for identity resolution and deduplication.',
    `middle_name` STRING COMMENT 'Middle name or initial of the prospective student. Supports full legal name construction and identity deduplication when first and last names are common.',
    `phone` STRING COMMENT 'Primary telephone number for the prospective student. Used for direct recruiter outreach, event reminders, and SMS communications. Captured in E.164 or local format.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `preferred_name` STRING COMMENT 'The name the prospective student prefers to be addressed by in communications. Supports inclusive and personalized recruitment outreach distinct from the legal name.',
    `program_of_interest` STRING COMMENT 'The academic program or major the prospective student has expressed interest in pursuing. Used for program-level demand forecasting, faculty engagement, and targeted recruitment communications.',
    `prospect_type` STRING COMMENT 'Categorical classification of the prospective student by intended enrollment level or pathway. Drives recruitment strategy, counselor assignment, and communication track selection. [ENUM-REF-CANDIDATE: undergraduate|graduate|transfer|international|non_degree|dual_enrollment — promote to reference product]. Valid values are `undergraduate|graduate|transfer|international|non_degree|dual_enrollment`',
    `recruitment_stage` STRING COMMENT 'Current stage of the prospective student in the enrollment funnel lifecycle. Tracks progression from initial inquiry through matriculation. Drives CRM workflow automation and funnel analytics in Slate CRM.. Valid values are `inquiry|prospect|applicant|admitted|enrolled|inactive`',
    `sat_score` STRING COMMENT 'The prospective students self-reported or College Board-supplied SAT composite score. Used for academic profile benchmarking, merit scholarship screening, and test-optional policy analytics.',
    `slate_prospect_code` STRING COMMENT 'The native prospect identifier assigned by Slate CRM (Admissions and Enrollment system). Used for cross-system reconciliation and lineage tracing back to the operational source of record.',
    `state_code` STRING COMMENT 'Two-letter USPS state abbreviation for the prospective students home state. Used for in-state vs. out-of-state classification, tuition eligibility analysis, and geographic recruitment reporting.. Valid values are `^[A-Z]{2}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent update to the prospect record in the Silver Layer. Supports incremental ETL processing, change data capture, and audit trail maintenance.',
    `visa_type` STRING COMMENT 'The U.S. visa classification applicable to the prospective student (e.g., F-1, J-1, H-4). Relevant only for international prospects. Informs international student services engagement and I-20 issuance planning.',
    `zip_code` STRING COMMENT 'ZIP or postal code of the prospective students home address. Enables micro-geographic recruitment analysis, territory mapping, and socioeconomic context overlays for financial aid planning.. Valid values are `^d{5}(-d{4})?$`',
    CONSTRAINT pk_prospect PRIMARY KEY(`prospect_id`)
) COMMENT 'Master record for every prospective student who has expressed interest in the institution, sourced from Slate CRM. Captures inquiry source, program of interest, recruitment stage, contact preferences, geographic origin (state, country, zip code), intended entry term, initial engagement date, assigned recruitment territory, and counselor. Serves as the top-of-funnel identity record before a formal application is submitted. Distinct from the applicant record (post-application identity) and the student master record owned by the student domain.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`enrollment_application` (
    `enrollment_application_id` BIGINT COMMENT 'Unique surrogate identifier for the enrollment application record in the Silver Layer lakehouse. Primary key for this entity.',
    `academic_program_id` BIGINT COMMENT 'Reference to the academic program (degree, certificate, or credential) to which the applicant is seeking admission.',
    `aid_application_id` BIGINT COMMENT 'Foreign key linking to aid.aid_application. Business justification: Admissions applications trigger FAFSA/aid application workflows. Links admitted student packaging to enrollment intent. Operational for financial aid offer letters, enrollment deposit coordination, an',
    `campus_id` BIGINT COMMENT 'Foreign key linking to facility.campus. Business justification: Applications specify target campus for enrollment. Admissions reporting, yield analysis, and campus-specific recruitment strategies require linking applications to campus entities. Campus_code denorma',
    `employee_id` BIGINT COMMENT 'Reference to the admissions counselor or recruiter assigned to this applicant in Slate CRM. Used for territory management, counselor workload reporting, and yield attribution.',
    `enrollment_applicant_id` BIGINT COMMENT 'Reference to the prospective student (applicant/person) who submitted this application. Links to the student or person master record.',
    `org_unit_id` BIGINT COMMENT 'Reference to the academic college or school within the institution to which the applicant is applying (e.g., College of Engineering, School of Business). Supports college-level admissions reporting.',
    `principal_investigator_id` BIGINT COMMENT 'Foreign key linking to research.principal_investigator. Business justification: Graduate applications for research programs require PI selection. Admissions decisions depend on faculty capacity, research fit, and available funding in PI labs. Enables PI-specific application revie',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Application drives student account creation and tuition assessment. Residency classification, program level, and term from application determine billing rates and fee schedules. Account setup and init',
    `term_id` BIGINT COMMENT 'Reference to the academic term (semester, quarter, or session) for which admission is being sought.',
    `title_ix_case_id` BIGINT COMMENT 'Foreign key linking to compliance.title_ix_case. Business justification: Title IX investigations may result in admission rescission, denial, or conditional admission. Admissions offices must link applications to active Title IX cases to implement interim measures, hold dec',
    `academic_level` STRING COMMENT 'Broad academic level of the program being applied to. Used for segmentation in IPEDS reporting, financial aid eligibility, and admissions workflow routing.. Valid values are `Undergraduate|Graduate|Professional|Certificate|Non-Degree`',
    `act_composite_score` STRING COMMENT 'Applicants highest reported ACT composite score (range 1–36). Used in admissions review and merit aid evaluation. Null if test-optional or not submitted.',
    `application_number` STRING COMMENT 'Externally visible, human-readable application reference number assigned at submission. Used by applicants, admissions staff, and Slate CRM to track and communicate about the application.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `application_source` STRING COMMENT 'Platform or channel through which the application was submitted. Informs recruitment channel effectiveness analysis and integration routing between Slate CRM and Ellucian Banner.. Valid values are `Common App|Coalition App|Institution Direct|Transfer Portal|Graduate Direct|International Portal`',
    `application_status` STRING COMMENT 'Current workflow stage of the application within the admissions processing pipeline. Drives routing, communications, and reporting in Ellucian Banner and Slate CRM.. Valid values are `Incomplete|Complete|Under Review|Decision Made|Withdrawn|Cancelled`',
    `application_type` STRING COMMENT 'Categorizes the applicant population and admission pathway. FTIAC (First-Time-In-Any-College) denotes first-year undergraduates; Transfer applies to students with prior college credit; Graduate and Professional denote post-baccalaureate applicants; Re-Admit covers returning students; Non-Degree covers non-matriculating applicants.. Valid values are `FTIAC|Transfer|Graduate|Professional|Re-Admit|Non-Degree`',
    `athletics_recruit_flag` BOOLEAN COMMENT 'Indicates whether the applicant is a recruited student-athlete. Triggers NCAA compliance review, athletic scholarship eligibility assessment, and coordination with the athletics department.',
    `checklist_complete_flag` BOOLEAN COMMENT 'Indicates whether all required application materials (transcripts, recommendations, essays, test scores, etc.) have been received and verified, making the application file complete for review.',
    `cip_code` STRING COMMENT 'Six-digit CIP code identifying the academic discipline of the program applied to, per the U.S. Department of Education taxonomy. Required for IPEDS reporting and accreditation documentation.. Valid values are `^d{2}.d{4}$`',
    `citizenship_status` STRING COMMENT 'Applicants citizenship or immigration status as declared on the application. Affects financial aid eligibility (Title IV), visa processing, and IPEDS reporting. Classified as confidential due to sensitivity.. Valid values are `US Citizen|Permanent Resident|Non-Resident Alien|Refugee|DACA|Unknown`',
    `confirmation_deadline_date` DATE COMMENT 'Date by which an admitted applicant must confirm their intent to enroll (typically by submitting an enrollment deposit). Used to manage yield and seat planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the application record was first created in the system of record (Ellucian Banner or Slate CRM). Supports audit trail, SLA measurement, and data lineage in the Silver Layer.',
    `decision_date` DATE COMMENT 'Calendar date on which the official admissions decision was rendered and communicated to the applicant. Null if no decision has been issued.',
    `decision_status` STRING COMMENT 'Official admissions decision rendered by the institution for this application. Pending indicates no decision has been issued. Conditional Admit may require additional requirements (e.g., English proficiency, prerequisite coursework).. Valid values are `Pending|Admitted|Denied|Waitlisted|Deferred|Conditional Admit`',
    `early_action_flag` BOOLEAN COMMENT 'Indicates whether the application was submitted under an Early Action admissions plan (non-binding early decision cycle). Affects decision timeline and yield strategy.',
    `early_decision_flag` BOOLEAN COMMENT 'Indicates whether the application was submitted under a binding Early Decision admissions plan. Early Decision applicants commit to enroll if admitted. Affects yield calculations and contract obligations.',
    `enrollment_intent` STRING COMMENT 'Applicants stated or confirmed intent to enroll following an admissions offer. Confirmed indicates deposit or formal acceptance received. Used for yield management and enrollment forecasting.. Valid values are `Confirmed|Declined|Pending|Deferred Enrollment`',
    `fee_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the application fee assessed for this application. May vary by application type (e.g., graduate vs. undergraduate) or program. Denominated in USD.',
    `fee_paid_flag` BOOLEAN COMMENT 'Indicates whether the application fee has been received and posted. Applications with unpaid fees (and no waiver) may be held from review per institutional policy.',
    `fee_waiver_flag` BOOLEAN COMMENT 'Indicates whether the application fee was waived for this applicant (e.g., due to financial hardship, Common App waiver, or institutional policy). Affects accounts receivable and access equity reporting.',
    `first_generation_flag` BOOLEAN COMMENT 'Indicates whether the applicant is a first-generation college student (neither parent holds a bachelors degree). Used for targeted outreach, financial aid priority, and IPEDS equity reporting.',
    `high_school_gpa` DECIMAL(18,2) COMMENT 'Self-reported or official high school cumulative GPA submitted as part of the application. Used in admissions review, merit scholarship evaluation, and predictive analytics. Applicable primarily to FTIAC applicants.',
    `ielts_score` DECIMAL(18,2) COMMENT 'Applicants reported IELTS overall band score (range 0.0–9.0). Alternative to TOEFL for demonstrating English language proficiency for international applicants.',
    `materials_complete_date` DATE COMMENT 'Date on which all required application materials were received and the application file was deemed complete for admissions review. Null until checklist is fully satisfied.',
    `prior_institution_code` BIGINT COMMENT 'Reference to the most recent prior institution attended by the applicant. Used for transfer credit evaluation, articulation agreement application, and IPEDS transfer reporting.',
    `priority_deadline_flag` BOOLEAN COMMENT 'Indicates whether the application was submitted on or before the institutions priority admissions deadline. Priority applicants may receive earlier decisions, scholarship consideration, or preferred housing.',
    `residency_classification` STRING COMMENT 'Applicants tuition residency classification at the time of application. Determines tuition rate applicability and affects financial aid eligibility. May be updated after enrollment.. Valid values are `In-State|Out-of-State|International|Unknown`',
    `sat_total_score` STRING COMMENT 'Applicants highest reported SAT composite score (Evidence-Based Reading and Writing + Math, range 400–1600). Used in admissions review and merit aid evaluation. Null if test-optional or not submitted.',
    `scholarship_consideration_flag` BOOLEAN COMMENT 'Indicates whether the applicant has been flagged for automatic merit scholarship review based on academic credentials. Drives routing to the financial aid merit award workflow.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this application record was sourced or last updated. Supports data lineage, reconciliation, and conflict resolution between Ellucian Banner and Slate CRM.. Valid values are `Banner|Slate|Both`',
    `special_population_code` STRING COMMENT 'Code identifying applicant membership in a special admissions population requiring distinct processing or support (e.g., Veterans, Honors Program, Dual Enrollment, International, TRIO). [ENUM-REF-CANDIDATE: Veteran|Honors|Dual Enrollment|International|TRIO|Disability Services|Other — promote to reference product]',
    `submitted_date` DATE COMMENT 'Calendar date on which the applicant formally submitted the application. Used for deadline compliance, priority processing windows, and IPEDS reporting.',
    `test_optional_flag` BOOLEAN COMMENT 'Indicates whether the applicant applied under the institutions test-optional admissions policy, meaning standardized test scores were not submitted or considered. Relevant for policy analysis and equity reporting.',
    `toefl_score` STRING COMMENT 'Applicants reported TOEFL iBT total score (range 0–120). Required for international applicants whose native language is not English. Used to assess English language proficiency for admission and conditional admit decisions.',
    `transfer_credit_hours` DECIMAL(18,2) COMMENT 'Number of transferable credit hours (CR) evaluated and accepted from prior institutions at the time of application review. Applicable to transfer applicants. Affects degree plan mapping and time-to-degree projections.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the application record in the source system. Used for incremental ETL processing, change detection, and audit compliance in the Databricks Silver Layer.',
    `visa_type` STRING COMMENT 'Type of U.S. visa held by the applicant, if applicable (e.g., F-1, J-1, H-4). Required for international student admissions processing, SEVIS compliance, and enrollment reporting. Null for domestic applicants. [ENUM-REF-CANDIDATE: F-1|J-1|H-1B|H-4|OPT|CPT|B-1/B-2|Other — promote to reference product]',
    `withdrawal_reason` STRING COMMENT 'Reason code recorded when an applicant withdraws or cancels their application. Used for yield analysis, competitive intelligence, and process improvement. Null if application is not withdrawn.. Valid values are `Enrolled Elsewhere|Financial Reasons|Personal Reasons|Program Not Available|No Response|Other`',
    CONSTRAINT pk_enrollment_application PRIMARY KEY(`enrollment_application_id`)
) COMMENT 'Core transactional record representing a formal application for admission submitted by a prospective student. Tracks application type (FTIAC, transfer, graduate, professional), program applied to, application term, submission date, application fee status, current workflow stage, and decision status. Sourced from Ellucian Banner Admissions and Slate CRM. Central entity of the admission domain.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`enrollment_applicant` (
    `enrollment_applicant_id` BIGINT COMMENT 'Unique surrogate identifier for the applicant master record in the enrollment data lakehouse. Serves as the primary key bridging the prospect pipeline to the formal application workflow and the eventual student master record.',
    `identity_account_id` BIGINT COMMENT 'Foreign key linking to technology.identity_account. Business justification: Applicants receive institutional NetID/identity accounts upon application submission to access applicant portal, upload documents, check status, and receive communications. Identity management is core',
    `principal_investigator_id` BIGINT COMMENT 'Foreign key linking to research.principal_investigator. Business justification: Graduate applicants specify desired research advisor in applications. Admissions committees use PI preferences for program fit assessment, faculty workload balancing, and matching students to availabl',
    `prospect_id` BIGINT COMMENT 'Unique identifier assigned to the individual in the Slate CRM system during the prospect management phase, prior to formal application submission. Enables traceability from initial recruitment contact through matriculation.',
    `academic_level` STRING COMMENT 'Level of study the applicant is pursuing. Determines applicable admissions requirements, financial aid eligibility rules, tuition rate schedules, and IPEDS reporting category.. Valid values are `undergraduate|graduate|doctoral|professional|certificate|non_degree`',
    `act_composite_score` STRING COMMENT 'Applicants ACT composite score (range 1–36) as reported by ACT, Inc. Used alongside SAT scores in admissions merit review and scholarship eligibility determination under test-optional or test-flexible policies.',
    `admissions_decision_code` STRING COMMENT 'Official admissions decision rendered by the institution for the applicants most recent application. Drives downstream enrollment deposit processing, financial aid packaging, and IPEDS admissions reporting.. Valid values are `admitted|denied|waitlisted|deferred|conditional_admit|withdrawn`',
    `admissions_decision_date` DATE COMMENT 'Date on which the institution rendered an official admissions decision (admit, deny, waitlist, or defer) for the applicant. Used for decision turnaround time analytics and NACAC compliance reporting.',
    `applicant_type` STRING COMMENT 'Classification of the applicant based on their prior academic history and enrollment intent. FTIAC (First-Time-In-Any-College) applicants are tracked separately for IPEDS first-time student cohort reporting. Drives admissions review workflow routing. [ENUM-REF-CANDIDATE: ftiac|transfer|readmit|graduate|international|non_degree|dual_enrollment — 7 candidates stripped; promote to reference product]',
    `application_fee_paid` BOOLEAN COMMENT 'Indicates whether the applicant has paid the required application fee or received an approved fee waiver. Applications with unpaid fees are typically held from admissions review until payment or waiver is confirmed.',
    `application_status` STRING COMMENT 'Current lifecycle status of the applicants most recent or active application within the admissions workflow. Drives Slate CRM communications, Banner SIS record activation, and enrollment funnel reporting. Represents the applicant-level rollup status. [ENUM-REF-CANDIDATE: prospect|applied|under_review|decision_pending|admitted|denied|waitlisted|withdrawn — 8 candidates stripped; promote to reference product]',
    `application_submitted_date` DATE COMMENT 'Date on which the applicant formally submitted their application for admission. Used for application deadline compliance tracking, admissions cycle reporting, and funnel conversion analytics.',
    `banner_pidm` BIGINT COMMENT 'Internal Banner SIS person identifier (PIDM) that uniquely identifies the individual across all Banner modules including Admissions, Financial Aid, Student Accounts, and Academic History. Acts as the cross-module linkage key within the source system.',
    `birth_date` DATE COMMENT 'Applicants date of birth in ISO 8601 format (yyyy-MM-dd). Used for age verification, FERPA minor-student protections, NCAA eligibility checks, and demographic reporting to IPEDS.',
    `citizenship_status` STRING COMMENT 'Federal citizenship classification of the applicant. Determines Title IV financial aid eligibility (FAFSA), in-state tuition residency analysis, visa requirements, and IPEDS reporting. Sourced from Ellucian Banner GORVISA/SPBPERS.. Valid values are `us_citizen|permanent_resident|nonresident_alien|refugee|daca|unknown`',
    `country_of_birth` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the applicants country of birth. Used for international student classification, visa eligibility determination, and demographic analytics.. Valid values are `^[A-Z]{3}$`',
    `country_of_citizenship` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the applicants country of citizenship. Required for international student visa processing (F-1, J-1), SEVIS reporting, and IPEDS international student counts.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the applicant master record was first created in the enrollment data lakehouse Silver layer. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for data lineage, audit compliance, and ETL pipeline monitoring.',
    `disability_status` STRING COMMENT 'Indicates whether the applicant has self-disclosed a disability requiring academic accommodations. Triggers referral to Disability Services office. Stored as disclosure status only — specific disability details are maintained separately under ADA/Section 504 protections.. Valid values are `disclosed|not_disclosed|no_disability|prefer_not_to_say`',
    `email_address` STRING COMMENT 'Primary personal email address provided by the applicant for admissions communications, application status notifications, and pre-enrollment correspondence via Slate CRM. Distinct from any institutional email assigned post-admission.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `enrollment_deposit_date` DATE COMMENT 'Date on which the admitted applicant paid the enrollment confirmation deposit. Used for yield analysis, melt tracking, and enrollment projection modeling.',
    `enrollment_deposit_paid` BOOLEAN COMMENT 'Indicates whether the admitted applicant has paid the enrollment confirmation deposit, signaling intent to enroll. A key yield metric in enrollment management and the trigger for orientation and housing assignment workflows.',
    `entry_term_code` STRING COMMENT 'Academic term code for which the applicant is seeking enrollment (e.g., 202501 for Spring 2025). Used for cohort tracking, capacity planning, and term-based enrollment cycle management in Banner SIS.',
    `ethnicity_code` STRING COMMENT 'Federal race/ethnicity category code for the applicant per IPEDS reporting standards. Used for Title VI compliance, diversity reporting, and accreditation data submissions. [ENUM-REF-CANDIDATE: hispanic_latino|american_indian_alaska_native|asian|black_african_american|native_hawaiian_pacific_islander|white|two_or_more_races|unknown — promote to reference product]',
    `fee_waiver_type` STRING COMMENT 'Type of application fee waiver granted to the applicant, if applicable. Identifies the authorizing body (College Board, ACT, NACAC, or institutional) for audit and equity reporting purposes.. Valid values are `college_board|act|nacac|institutional|none`',
    `ferpa_consent_date` DATE COMMENT 'Date on which the applicant provided or last updated their FERPA consent authorization. Required for compliance audit trails and determining the effective period of consent.',
    `ferpa_consent_flag` BOOLEAN COMMENT 'Indicates whether the applicant has provided written FERPA consent authorizing the institution to release education records to designated third parties (e.g., parents, guardians). False indicates records are protected and cannot be disclosed without further authorization.',
    `first_generation_indicator` BOOLEAN COMMENT 'Indicates whether the applicant is a first-generation college student, defined as neither parent having completed a bachelors degree. Used for targeted support program eligibility, Title III/IV reporting, and equity analytics.',
    `first_name` STRING COMMENT 'Legal given (first) name of the applicant as provided on the application. Used for identity verification, FERPA-protected communications, and official enrollment records.',
    `gender_identity` STRING COMMENT 'Self-reported gender identity of the applicant. Collected for IPEDS demographic reporting, Title IX compliance, and inclusive student services. [ENUM-REF-CANDIDATE: male|female|non_binary|genderqueer|transgender|prefer_not_to_say|other — promote to reference product]',
    `high_school_ceeb_code` STRING COMMENT 'Six-digit College Board CEEB code identifying the applicants high school or secondary institution. Used for transcript verification, SAT/ACT score matching, and high school partnership analytics.. Valid values are `^[0-9]{6}$`',
    `high_school_gpa` DECIMAL(18,2) COMMENT 'Applicants cumulative high school GPA on a 4.0 scale as reported on the official transcript. A key academic merit indicator used in admissions review, merit scholarship eligibility, and predictive enrollment analytics.',
    `ielts_score` DECIMAL(18,2) COMMENT 'Applicants IELTS overall band score (range 0.0–9.0 in 0.5 increments) as an alternative English proficiency measure to TOEFL. Used for international student admissions decisions and conditional admission routing.',
    `inquiry_date` DATE COMMENT 'Date on which the applicant first expressed interest in the institution, either through a direct inquiry, college fair contact, or Slate CRM prospect capture. Marks the start of the recruitment funnel for time-to-application analytics.',
    `intended_college_code` STRING COMMENT 'Institutional code for the college or school within the university to which the applicant is applying (e.g., College of Engineering, School of Business). Used for college-level admissions routing and capacity management.',
    `intended_program_code` STRING COMMENT 'Classification of Instructional Programs (CIP) code or institutional program code for the degree program the applicant intends to pursue. Used for program-level enrollment analytics, accreditation reporting (ABET, AACSB, HLC), and capacity planning.',
    `last_name` STRING COMMENT 'Legal surname (last name) of the applicant as provided on the application. Used for identity verification, official correspondence, and enrollment records.',
    `middle_name` STRING COMMENT 'Legal middle name or initial of the applicant. Used for identity disambiguation when first and last names are common, and for official document generation.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the applicant in E.164 international format. Used for admissions outreach, interview scheduling, and enrollment communications via Slate CRM.. Valid values are `^+?[1-9]d{1,14}$`',
    `preferred_name` STRING COMMENT 'Name the applicant prefers to be addressed by in non-legal communications, such as advising, orientation, and LMS interactions. Distinct from legal name used on official documents.',
    `prior_college_gpa` DECIMAL(18,2) COMMENT 'Cumulative GPA from all prior postsecondary institutions attended, on a 4.0 scale. Applicable for transfer, readmit, and graduate applicants. Used in transfer admissions review and Satisfactory Academic Progress (SAP) baseline assessment.',
    `recruitment_source_code` STRING COMMENT 'Code identifying the primary recruitment channel or initiative through which the applicant was first engaged (e.g., college fair, high school visit, digital campaign, alumni referral). Used for ROI analysis of recruitment spend and Slate CRM campaign attribution.',
    `residency_classification` STRING COMMENT 'Tuition residency classification assigned to the applicant based on domicile verification. Determines applicable tuition rate tier (in-state, out-of-state, international). Critical for revenue forecasting and NACUBO financial reporting.. Valid values are `in_state|out_of_state|international|military|unknown`',
    `sat_total_score` STRING COMMENT 'Applicants total SAT composite score (Evidence-Based Reading and Writing + Math, range 400–1600) as reported by College Board. Used in admissions merit review, scholarship eligibility, and test-optional policy analytics.',
    `state_of_legal_residence` STRING COMMENT 'Two-letter USPS state abbreviation for the applicants state of legal domicile. Used for residency classification determination, in-state tuition eligibility, and state-level enrollment reporting.. Valid values are `^[A-Z]{2}$`',
    `toefl_score` STRING COMMENT 'Applicants TOEFL iBT total score (range 0–120) as reported by ETS. Required for international applicants whose primary language is not English. Used to determine English language proficiency and conditional admission eligibility.',
    `transfer_credit_hours` DECIMAL(18,2) COMMENT 'Total number of transferable credit hours (CR) evaluated from prior postsecondary institutions. Used for degree audit, time-to-degree planning, and financial aid credit hour eligibility calculations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the applicant master record in the enrollment data lakehouse Silver layer. Used for change data capture (CDC), incremental ETL processing, and audit trail compliance.',
    `veteran_status` STRING COMMENT 'Military service classification of the applicant. Determines eligibility for GI Bill benefits, Yellow Ribbon Program, in-state tuition waivers for veterans, and VA certification requirements. Reported to IPEDS and the VA.. Valid values are `non_veteran|veteran|active_duty|reservist|dependent|unknown`',
    CONSTRAINT pk_enrollment_applicant PRIMARY KEY(`enrollment_applicant_id`)
) COMMENT 'Master identity record for an individual who has submitted at least one application. Captures personal demographics, citizenship status, residency classification (in-state, out-of-state, international), first-generation indicator, veteran status, and FERPA consent flags. Bridges the prospect pipeline to the formal application workflow and is the precursor to the student master record in the student domain.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`application_program` (
    `application_program_id` BIGINT COMMENT 'Unique surrogate identifier for the application-program association record in the Silver Layer lakehouse. Primary key for this entity.',
    `academic_program_id` BIGINT COMMENT 'Reference to the academic program being applied to, as defined in the institutions program catalog. Identifies the degree-granting program entity.',
    `department_org_unit_id` BIGINT COMMENT 'Reference to the academic department responsible for delivering the applied-to program (e.g., Department of Computer Science, Department of Economics).',
    `enrollment_application_id` BIGINT COMMENT 'Reference to the parent admissions application record. Links this program selection back to the applicants overall application submission.',
    `org_unit_id` BIGINT COMMENT 'Reference to the college or school within the institution that houses the applied-to program (e.g., College of Engineering, College of Business).',
    `plan_academic_program_id` BIGINT COMMENT 'Reference to the specific academic plan (major, minor, certificate, or concentration) within the program being applied to. Supports sub-program granularity within a degree program.',
    `principal_investigator_id` BIGINT COMMENT 'Foreign key linking to research.principal_investigator. Business justification: Research-based program applications track intended faculty advisor for each program choice. Supports multi-program applications where students apply to different labs/PIs, enabling program-specific PI',
    `term_id` BIGINT COMMENT 'Reference to the academic term for which the applicant is seeking admission into this program (e.g., Fall 2025, Spring 2026).',
    `accreditation_body` STRING COMMENT 'Name of the specialized accreditation body that accredits this specific program (e.g., AACSB for business programs, ABET for engineering programs, ABA for law programs, LCME for medical programs). Null if the program holds only regional institutional accreditation. Used for compliance tracking and applicant disclosure.',
    `accreditation_status` STRING COMMENT 'Current accreditation status of the program at the time of application. Affects applicant disclosures, Title IV financial aid eligibility, and institutional compliance obligations.. Valid values are `accredited|candidate|provisional|not_accredited`',
    `application_status` STRING COMMENT 'Current workflow status of this specific program application. Tracks the admissions decision lifecycle for this program-application pairing. Distinct from the overall application status as individual programs within a multi-program application may have different statuses. [ENUM-REF-CANDIDATE: pending|under_review|decision_ready|admitted|denied|waitlisted|withdrawn|deferred|incomplete — promote to reference product]',
    `application_type` STRING COMMENT 'Categorization of the application by applicant population type, driving distinct admissions review workflows, required materials, and decision criteria within Ellucian Banner and Slate CRM.. Valid values are `freshman|transfer|graduate|international|readmission`',
    `attendance_type` STRING COMMENT 'Intended enrollment intensity for this program application indicating whether the applicant plans to attend full-time, part-time, or less than half-time. Affects Full-Time Equivalent (FTE) calculations, financial aid eligibility under Title IV, and Satisfactory Academic Progress (SAP) standards.. Valid values are `full_time|part_time|less_than_half_time`',
    `campus_code` STRING COMMENT 'Code identifying the physical campus or instructional site where the applicant intends to complete the program. Relevant for multi-campus institutions and required for IPEDS branch campus reporting.. Valid values are `^[A-Z0-9]{2,10}$`',
    `cip_code` STRING COMMENT 'Six-digit CIP code assigned by the National Center for Education Statistics (NCES) classifying the instructional program by discipline (e.g., 11.0701 for Computer Science). Required for IPEDS federal reporting and accreditation submissions.. Valid values are `^d{2}.d{4}$`',
    `concentration_code` STRING COMMENT 'Institution-assigned code identifying the specific concentration, track, or specialization within the program being applied to (e.g., FINMKT for Finance and Marketing concentration). Null if no concentration is selected.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `concentration_name` STRING COMMENT 'Full descriptive name of the concentration or specialization within the program (e.g., Finance and Marketing, Artificial Intelligence). Null if no concentration is selected.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this application-program association record was first created in the system of record. Supports audit trail, data lineage, and admissions cycle analytics.',
    `deadline_date` DATE COMMENT 'Application deadline date specific to this program for the target enrollment term. Programs within the same institution may have different deadlines (e.g., early action, regular decision, rolling admissions).',
    `deadline_type` STRING COMMENT 'Classification of the admissions deadline round under which this program application was submitted. Affects binding commitment rules (early decision is binding), notification timelines, and yield analysis segmentation.. Valid values are `early_action|early_decision|regular_decision|rolling|priority`',
    `decision_code` STRING COMMENT 'Standardized admissions decision code issued by the institution for this program application (AD=Admitted, DN=Denied, WL=Waitlisted, WD=Withdrawn, DF=Deferred, IN=Incomplete, CN=Conditional). Used for Banner integration and IPEDS reporting. [ENUM-REF-CANDIDATE: AD|DN|WL|WD|DF|IN|CN — 7 candidates stripped; promote to reference product]',
    `decision_date` DATE COMMENT 'Calendar date on which the admissions decision was rendered and recorded for this program application. Used for cycle-time analytics, yield modeling, and compliance reporting.',
    `degree_level` STRING COMMENT 'Level of the academic credential being sought through this program application. Drives admissions workflow routing, financial aid eligibility, and IPEDS award level reporting. [ENUM-REF-CANDIDATE: certificate|associate|bachelor|master|doctoral|professional|post-baccalaureate — promote to reference product]. Valid values are `certificate|associate|bachelor|master|doctoral|professional`',
    `degree_type` STRING COMMENT 'Specific credential designation awarded upon program completion (e.g., BA, BS, MA, MS, MBA, PhD, EdD, JD, MD). Distinct from degree_level which captures the broad tier; degree_type captures the exact credential abbreviation.. Valid values are `^[A-Z]{2,10}$`',
    `delivery_mode` STRING COMMENT 'Instructional delivery modality for the program being applied to. Determines campus resource requirements, financial aid eligibility rules for distance education, and accreditation reporting under HLC/SACSCOC standards.. Valid values are `on_campus|online|hybrid|blended`',
    `enrollment_confirm_date` DATE COMMENT 'Date on which the admitted applicant confirmed their intent to enroll in this program. Null if enrollment has not been confirmed. Used for yield tracking and seat planning.',
    `enrollment_confirmed` BOOLEAN COMMENT 'Indicates whether the admitted applicant has confirmed their intent to enroll in this program by submitting an enrollment deposit or formal acceptance. True = enrollment confirmed; False = not yet confirmed or declined.',
    `expected_graduation_date` DATE COMMENT 'Projected graduation date for the applicant if admitted and enrolled in this program, based on the target entry term and standard time-to-degree for the program. Used for enrollment planning, financial aid award period calculations, and retention analytics.',
    `fee_waiver_granted` BOOLEAN COMMENT 'Indicates whether an application fee waiver was granted for this program application based on financial need, NACAC waiver criteria, or institutional policy. True = fee waiver granted; False = standard fee applies.',
    `is_dual_degree` BOOLEAN COMMENT 'Indicates whether this program application is part of a dual-degree or joint-degree arrangement where the applicant is simultaneously pursuing two distinct credentials (e.g., JD/MBA, MD/PhD). True = dual degree; False = single degree.',
    `is_primary_program` BOOLEAN COMMENT 'Indicates whether this program is designated as the applicants primary program of interest when multiple programs are included in a single application. True = primary program; False = secondary or alternate program. Aligns with priority_rank = 1.',
    `notes` STRING COMMENT 'Free-text field for admissions staff to record program-specific notes, special conditions, or exceptions associated with this application-program record (e.g., conditional admission requirements, departmental interview notes, special program prerequisites).',
    `priority_rank` STRING COMMENT 'Applicant-assigned numeric rank indicating preference order when applying to multiple programs simultaneously (1 = first choice, 2 = second choice, etc.). Used to determine primary program assignment upon admission and to analyze applicant program preferences.',
    `program_code` STRING COMMENT 'Institution-assigned alphanumeric code uniquely identifying the academic program being applied to (e.g., BSCS, MBAFIN, PHDBIO). Used for reporting, IPEDS submissions, and SIS integration.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `program_name` STRING COMMENT 'Full descriptive name of the academic program being applied to (e.g., Bachelor of Science in Computer Science, Master of Business Administration - Finance Concentration). Used in applicant communications and official documents.',
    `required_credit_hours` STRING COMMENT 'Total number of credit hours (CR) required to complete this program as defined in the academic catalog at the time of application. Used for degree audit planning, financial aid cost-of-attendance (COA) calculations, and enrollment projections.',
    `residency_classification` STRING COMMENT 'Tuition residency classification for this program application determining applicable tuition rate tier (in-state, out-of-state, or international). Drives tuition billing, financial aid packaging, and enrollment revenue forecasting.. Valid values are `in_state|out_of_state|international`',
    `scholarship_consideration` BOOLEAN COMMENT 'Indicates whether the applicant has opted into or been flagged for merit scholarship consideration for this specific program application. True = under scholarship consideration; False = not considered for merit scholarship. Drives financial aid packaging workflows.',
    `source_system_key` STRING COMMENT 'Natural key or record identifier from the originating operational system of record (Ellucian Banner or Slate CRM) for this application-program association. Enables lineage tracing and reconciliation between the Silver Layer lakehouse and the source SIS.',
    `student_type` STRING COMMENT 'Classification of the applicants enrollment history context for this program application. FTIAC (First-Time-In-Any-College) indicates no prior college attendance; transfer indicates prior college credit; readmit indicates prior enrollment at this institution. Critical for IPEDS cohort reporting and retention tracking.. Valid values are `ftiac|transfer|readmit|graduate|non_degree`',
    `submitted_date` DATE COMMENT 'Date on which the applicant formally submitted this program selection as part of their application. May differ from the overall application submission date if programs are added sequentially.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this application-program association record. Used for incremental ETL processing, change data capture, and audit compliance under FERPA.',
    `waitlist_position` STRING COMMENT 'Numeric position of the applicant on the program waitlist when the application_status is waitlisted. Lower numbers indicate higher priority for admission from the waitlist. Null if the applicant is not on the waitlist.',
    CONSTRAINT pk_application_program PRIMARY KEY(`application_program_id`)
) COMMENT 'Association entity linking an application to the specific academic program(s) and plan(s) being applied to, supporting multiple-program applications. Captures CIP code, degree level, college, department, concentration, and program priority rank when an applicant applies to more than one program simultaneously.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`admission_decision` (
    `admission_decision_id` BIGINT COMMENT 'Unique surrogate identifier for each admission decision record. One record per application per decision cycle. Primary key for the admission_decision data product.',
    `academic_program_id` BIGINT COMMENT 'Reference to the academic program (degree, certificate, or credential) to which the applicant applied and for which this decision was rendered.',
    `award_package_id` BIGINT COMMENT 'Reference to the financial aid award package associated with this admission offer. Links the admission decision to the corresponding aid offer for COA (Cost of Attendance) and EFC (Expected Family Contribution) reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the staff or faculty member who rendered or finalized the admission decision when decision_authority_type is individual_reviewer or dean_override. Null when decision was made by committee or automated rules engine.',
    `enrollment_applicant_id` BIGINT COMMENT 'Reference to the prospective student (applicant) party record associated with this admission decision. Supports yield management and enrollment funnel reporting.',
    `enrollment_application_id` BIGINT COMMENT 'Reference to the student application record for which this admission decision was rendered. Links the decision to the originating application in the admissions lifecycle.',
    `term_id` BIGINT COMMENT 'Reference to the term or academic period for which admission is being offered (e.g., Fall 2025, Spring 2026). Drives term-based enrollment cycle reporting.',
    `applicant_response` STRING COMMENT 'The applicants formal response to the admission offer. Drives yield calculation and enrollment confirmation workflows. Values: accepted (applicant confirmed enrollment intent), declined (applicant declined the offer), deferred_response (applicant requested additional time), no_response (no response received by offer expiration date).. Valid values are `accepted|declined|deferred_response|no_response`',
    `applicant_response_date` DATE COMMENT 'The date on which the applicant submitted their formal response (accept, decline, or deferred response) to the admission offer. Null if no response has been received.',
    `condition_deadline` DATE COMMENT 'The date by which the applicant must fulfill all conditions of a conditional admission offer. Null for unconditional admits and non-admit decisions.',
    `condition_description` STRING COMMENT 'Narrative description of the conditions the applicant must satisfy to convert a conditional admission to a full admission (e.g., final transcript submission, minimum GPA requirement, English proficiency test score). Populated only when is_conditional is True.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this admission decision record was first created in the data platform. Serves as the audit creation timestamp for the Silver Layer record. Distinct from decision_timestamp which captures the business event time.',
    `decision_authority_type` STRING COMMENT 'Identifies the mechanism or body that rendered the admission decision. Supports holistic review documentation and institutional audit requirements. Values: committee (admissions committee vote), automated_rules_engine (system-generated based on configured criteria), individual_reviewer (single admissions officer), dean_override (dean or senior administrator override).. Valid values are `committee|automated_rules_engine|individual_reviewer|dean_override`',
    `decision_cycle` STRING COMMENT 'Identifies the admissions decision cycle within a term (e.g., Early Decision, Early Action, Regular Decision, Rolling). Supports yield management analytics and enrollment funnel segmentation by admission round.',
    `decision_date` DATE COMMENT 'The official calendar date on which the admissions decision was rendered and recorded. Represents the principal real-world business event date for this transaction. Used in cycle-time analytics and accreditation reporting.',
    `decision_number` STRING COMMENT 'Externally visible, human-readable identifier for this admission decision record (e.g., DEC-2025-0048291). Used in correspondence, portal displays, and audit trails.',
    `decision_status` STRING COMMENT 'Current lifecycle state of this admission decision record. Pending indicates the decision is in review; finalized indicates the decision has been officially rendered and communicated; rescinded indicates a previously issued offer has been withdrawn; superseded indicates this record has been replaced by a newer decision in the same cycle.. Valid values are `pending|finalized|rescinded|superseded`',
    `decision_timestamp` TIMESTAMP COMMENT 'Precise date and time at which the admission decision was officially recorded in the system, including timezone offset. Supports audit trails and SLA measurement for admissions processing turnaround.',
    `decision_type` STRING COMMENT 'The official classification of the admissions decision rendered for this application. Drives downstream yield management, enrollment funnel reporting, and accreditation data submissions. Values: admit (full unconditional offer), deny (application rejected), waitlist (placed on waitlist pending space), defer (decision postponed to next cycle), conditional_admit (offer contingent on meeting specified conditions).. Valid values are `admit|deny|waitlist|defer|conditional_admit`',
    `defer_target_term` STRING COMMENT 'The academic term to which the application has been deferred for reconsideration (e.g., Spring 2026, Fall 2026). Populated only when decision_type is defer. Supports cycle-over-cycle enrollment funnel tracking.',
    `deny_reason_code` STRING COMMENT 'Standardized institutional code indicating the primary reason for a denial decision (e.g., academic_qualifications, capacity, incomplete_application, program_fit). Populated only when decision_type is deny. Supports equity analysis and holistic review documentation.',
    `enrollment_deposit_amount` DECIMAL(18,2) COMMENT 'The enrollment confirmation deposit amount (in USD) required from the applicant upon accepting the admission offer. Confirms seat reservation and is typically credited toward tuition. Null for non-admit decisions.',
    `enrollment_deposit_paid_date` DATE COMMENT 'The date on which the applicant submitted the enrollment confirmation deposit. Null if deposit has not been received. Confirms intent to enroll and triggers downstream onboarding processes.',
    `holistic_review_score` DECIMAL(18,2) COMMENT 'Composite numeric score assigned to the application during holistic review, aggregating academic, extracurricular, essay, and recommendation dimensions per institutional rubric. Supports equity analysis, yield modeling, and accreditation documentation of holistic review practices.',
    `honors_designation` STRING COMMENT 'The specific honors program or designation offered to the applicant (e.g., University Honors, Departmental Honors, Presidential Scholars). Populated only when is_honors_eligible is True. Null otherwise.',
    `is_conditional` BOOLEAN COMMENT 'Indicates whether this admission offer is conditional, requiring the applicant to satisfy specified conditions prior to enrollment. True = conditional admit; False = unconditional offer. Applicable only when decision_type is conditional_admit.',
    `is_honors_eligible` BOOLEAN COMMENT 'Indicates whether the applicant has been identified as eligible for the institutional honors program as part of this admission decision. True = eligible for honors designation; False = not eligible.',
    `is_rescinded` BOOLEAN COMMENT 'Indicates whether a previously issued admission offer has been formally rescinded by the institution (e.g., due to academic performance decline, disciplinary action, or misrepresentation on application). True = offer rescinded; False = offer remains valid.',
    `is_scholarship_eligible` BOOLEAN COMMENT 'Indicates whether the applicant has been identified as eligible for institutional merit or need-based scholarship consideration as part of this admission decision. True = eligible; False = not eligible.',
    `offer_delivery_method` STRING COMMENT 'The channel through which the admission offer letter was delivered to the applicant. Supports communication analytics and yield management. Values: portal (applicant self-service portal), email (electronic mail), mail (physical postal mail), in_person (delivered during campus visit or event).. Valid values are `portal|email|mail|in_person`',
    `offer_expiration_date` DATE COMMENT 'The date by which the applicant must respond to the admission offer (accept or decline) before the offer is considered expired. Commonly May 1 for undergraduate admissions per National Candidates Reply Date. Null for deny, waitlist, and defer decisions.',
    `offer_letter_generated_date` DATE COMMENT 'The date on which the official admission offer letter was generated and prepared for delivery. Applicable only for admit and conditional_admit decisions. Supports yield management and communication timeline analytics.',
    `offer_sent_date` DATE COMMENT 'The date on which the admission offer letter was dispatched to the applicant via the designated delivery method. Distinct from offer_letter_generated_date; captures actual transmission date for SLA and yield analytics.',
    `rescind_date` DATE COMMENT 'The date on which the admission offer was formally rescinded. Populated only when is_rescinded is True. Null otherwise.',
    `rescind_reason` STRING COMMENT 'Narrative or coded reason explaining why a previously issued admission offer was rescinded. Populated only when is_rescinded is True. Supports compliance documentation and institutional audit requirements.',
    `scholarship_amount` DECIMAL(18,2) COMMENT 'The annual institutional scholarship or merit aid amount (in USD) included in the admission offer letter. Applicable only when is_scholarship_eligible is True and an offer has been extended. Null for non-admit decisions.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this admission decision record originated. Supports data lineage and ETL (Extract Transform Load) audit in the Databricks Silver Layer. Values: banner (Ellucian Banner SIS), slate (Slate CRM), manual (manually entered record).. Valid values are `banner|slate|manual`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this admission decision record was most recently modified in the data platform. Supports change tracking, data quality monitoring, and incremental ETL processing in the Silver Layer.',
    `waitlist_offered_date` DATE COMMENT 'The date on which an applicant on the waitlist was extended a formal admission offer from the waitlist. Null if the applicant has not been offered admission from the waitlist.',
    `waitlist_rank` STRING COMMENT 'Numeric rank or position of the applicant on the institutional waitlist. Lower numbers indicate higher priority for admission if seats become available. Populated only when decision_type is waitlist. Null otherwise.',
    CONSTRAINT pk_admission_decision PRIMARY KEY(`admission_decision_id`)
) COMMENT 'Transactional record capturing the official admissions decision and corresponding offer communication for an application. Stores decision type (admit, deny, waitlist, defer, conditional admit), decision date, decision authority (committee, automated rules engine, individual reviewer), scholarship eligibility flag, honors program eligibility, and conditions for conditional admits. For admit decisions, also captures offer letter generation date, delivery method (portal, email, mail), offer expiration date, scholarship amount included, honors designation, and applicant response (accepted, declined, deferred response). One record per application per decision cycle. Supports holistic review outcomes, yield management, and enrollment funnel reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`enrollment_test_score` (
    `enrollment_test_score_id` BIGINT COMMENT 'Unique surrogate identifier for each test score or international credential record submitted by an applicant. Primary key for the test_score data product in the enrollment domain Silver layer.',
    `application_checklist_id` BIGINT COMMENT 'Foreign key linking to enrollment.application_checklist. Business justification: Test score is a specific type of application checklist item. While test_score already references application_id directly, it should also link to its corresponding checklist entry to track receipt stat',
    `enrollment_applicant_id` BIGINT COMMENT 'Reference to the applicant who submitted this test score or international credential. Links the score record to the admissions applicant master record in Ellucian Banner and Slate CRM.',
    `enrollment_application_id` BIGINT COMMENT 'Reference to the specific admissions application for which this test score or credential was submitted. An applicant may have multiple applications across terms or programs.',
    `academic_program_code` STRING COMMENT 'Institutional code identifying the academic program or degree program to which the applicant applied and for which this test score is being evaluated. Used to apply program-specific minimum score thresholds (e.g., MBA programs requiring minimum GMAT scores, engineering programs requiring minimum GRE Quantitative scores).',
    `composite_score` DECIMAL(18,2) COMMENT 'The total or composite score for the test as reported by the testing agency. Scale varies by test type (e.g., SAT: 400–1600, ACT: 1–36, GRE: 260–340, GMAT: 200–800, TOEFL iBT: 0–120, IELTS: 0–9.0). Null for international credential records where no single composite score applies.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the country where the credential was issued or the test was administered. Used in international admissions review, IPEDS reporting of international student enrollment, and country-specific admissions criteria application.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this test score or credential record was first created in the system, either through manual data entry by admissions staff, electronic score import from the testing agency, or automated ETL ingestion from Ellucian Banner or Slate CRM into the Silver layer.',
    `credential_type` STRING COMMENT 'For international credential records (record_type = international_credential), the type of academic credential submitted (e.g., secondary_transcript, undergraduate_transcript, degree_certificate, evaluation_report, mark_sheet, leaving_certificate). Null for standardized test score records. [ENUM-REF-CANDIDATE: secondary_transcript|undergraduate_transcript|degree_certificate|evaluation_report|mark_sheet|leaving_certificate|other — promote to reference product]',
    `english_proficiency_waiver` BOOLEAN COMMENT 'Indicates whether the applicant has been granted a waiver of the English language proficiency test requirement (TOEFL/IELTS) based on factors such as prior English-medium instruction, citizenship in an English-speaking country, or completion of a U.S. degree. Relevant for international admissions compliance.',
    `evaluation_agency` STRING COMMENT 'Name of the third-party credential evaluation agency that assessed the international academic credential (e.g., WES for World Education Services, ECE for Educational Credential Evaluators, NACES member agencies). Null for standardized test records or credentials evaluated internally.',
    `evaluation_report_date` DATE COMMENT 'Date on which the credential evaluation agency issued the evaluation report for the international academic credential. Used to assess report recency and to track the completeness of the international admissions file.',
    `gpa_equivalent` DECIMAL(18,2) COMMENT 'The U.S. 4.0-scale Grade Point Average (GPA) equivalent assigned by the credential evaluation agency for the international academic credential. Enables standardized academic performance comparison across international applicants. Null for standardized test score records.',
    `ipeds_test_score_flag` BOOLEAN COMMENT 'Indicates whether this test score record is included in the institutions IPEDS Admissions Component reporting for the 25th and 75th percentile score ranges of enrolled first-time degree-seeking undergraduates. Supports federal regulatory reporting to the U.S. Department of Education.',
    `issuing_institution_name` STRING COMMENT 'Name of the foreign university, college, secondary school, or credentialing body that issued the international academic credential. Used in international admissions review to assess institutional reputation and accreditation status in the country of origin.',
    `language_of_instruction` STRING COMMENT 'ISO 639-2 three-letter language code indicating the primary language of instruction at the issuing institution for the international credential. Used to determine English proficiency test waiver eligibility (e.g., applicants from English-medium institutions may be exempt from TOEFL/IELTS requirements).. Valid values are `^[A-Z]{3}$`',
    `meets_minimum_requirement` BOOLEAN COMMENT 'Indicates whether the composite score or credential evaluation meets the institutions or programs minimum admissions score threshold for the applicable test type. Computed at the time of admissions review based on program-specific thresholds. Supports automated admissions screening workflows.',
    `percentile_rank` DECIMAL(18,2) COMMENT 'National percentile rank corresponding to the composite score as published by the testing agency. Indicates the percentage of test-takers who scored at or below this score. Used in admissions benchmarking and IPEDS reporting of admitted student test score profiles.',
    `record_type` STRING COMMENT 'Discriminator indicating whether this record represents a standardized test score (SAT, ACT, GRE, GMAT, TOEFL, IELTS) or an international academic credential (foreign transcript, degree certificate, evaluation report). Drives downstream processing logic in admissions review.. Valid values are `standardized_test|international_credential`',
    `score_notes` STRING COMMENT 'Free-text field for admissions staff to record contextual notes about the test score or credential record, such as discrepancies between self-reported and official scores, special testing accommodations, score cancellation history, or credential authentication concerns.',
    `score_report_date` DATE COMMENT 'Date on which the official score report was received by the institution from the testing agency (e.g., College Board, ETS, ACT Inc.) or evaluation agency. Distinct from test_date; used to track score receipt timelines and admissions file completeness.',
    `score_report_number` STRING COMMENT 'The externally-assigned confirmation or report number provided by the testing agency on the official score report. Used to cross-reference and verify the score against the agencys records and to resolve discrepancies between self-reported and official scores.',
    `score_section_1_label` STRING COMMENT 'Name or label of the first sub-score section for the test (e.g., Evidence-Based Reading and Writing for SAT, English for ACT, Verbal Reasoning for GRE, Verbal for GMAT, Reading for TOEFL). Enables structured storage of section scores across heterogeneous test types.',
    `score_section_1_value` DECIMAL(18,2) COMMENT 'Numeric score for the first sub-score section identified in score_section_1_label. Scale is test-type dependent. Used in admissions criteria evaluation and program-specific minimum score thresholds.',
    `score_section_2_label` STRING COMMENT 'Name or label of the second sub-score section (e.g., Math for SAT/ACT, Quantitative Reasoning for GRE, Quantitative for GMAT, Listening for TOEFL/IELTS). Null if the test type has fewer than two scored sections.',
    `score_section_2_value` DECIMAL(18,2) COMMENT 'Numeric score for the second sub-score section identified in score_section_2_label. Null if the test type has fewer than two scored sections.',
    `score_section_3_label` STRING COMMENT 'Name or label of the third sub-score section (e.g., Reading for ACT, Analytical Writing for GRE/GMAT, Speaking for TOEFL/IELTS). Null if the test type has fewer than three scored sections.',
    `score_section_3_value` DECIMAL(18,2) COMMENT 'Numeric score for the third sub-score section identified in score_section_3_label. Null if the test type has fewer than three scored sections.',
    `score_section_4_label` STRING COMMENT 'Name or label of the fourth sub-score section (e.g., Science for ACT, Writing for TOEFL/IELTS). Null if the test type has fewer than four scored sections.',
    `score_section_4_value` DECIMAL(18,2) COMMENT 'Numeric score for the fourth sub-score section identified in score_section_4_label. Null if the test type has fewer than four scored sections.',
    `score_source` STRING COMMENT 'Indicates whether the score was self-reported by the applicant, received as an official score report directly from the testing agency, or verified by a third-party evaluation agency. Drives admissions decision validity rules; self-reported scores may require official verification upon enrollment.. Valid values are `self_reported|official|agency_verified`',
    `score_status` STRING COMMENT 'Current processing status of the test score record within the admissions workflow. pending = awaiting official score receipt; received = official score received but not yet reviewed; verified = score confirmed authentic; expired = score past validity window; waived = test requirement waived per institutional policy; rejected = score deemed invalid or fraudulent.. Valid values are `pending|received|verified|expired|waived|rejected`',
    `score_validity_expiry_date` DATE COMMENT 'Date on which the test score expires per the testing agencys validity policy (e.g., GRE scores valid for 5 years from test date, TOEFL/IELTS scores valid for 2 years). Null for tests with no expiry policy (e.g., SAT, ACT). Used to flag stale scores during admissions file review.',
    `superscore` DECIMAL(18,2) COMMENT 'Institution-calculated superscore representing the highest composite score assembled from the best section scores across multiple test sittings of the same test type. Applicable for SAT and ACT where the institution has a superscore policy. Null if the institution does not superscore or if only one sitting exists.',
    `superscore_eligible` BOOLEAN COMMENT 'Indicates whether this test score record is eligible to be included in the institutions superscore calculation for the applicant. True when the test type supports superscoring per institutional policy and the score is official. Drives the superscore computation logic in admissions analytics.',
    `term_code` STRING COMMENT 'Institutional term code identifying the admissions cycle or enrollment term for which this test score was submitted (e.g., FALL2025, 202509). Aligns with Ellucian Banner term coding conventions and supports term-based admissions cohort analysis.',
    `test_date` DATE COMMENT 'Calendar date on which the applicant sat for the standardized test or, for international credentials, the date the credential was issued or conferred. Used to assess score recency and validity windows per admissions policy.',
    `test_optional_waiver` BOOLEAN COMMENT 'Indicates whether the applicant was granted a test-optional waiver, meaning the institution does not require a standardized test score for this application cycle. Reflects test-optional or test-blind admissions policies adopted by many institutions. Relevant for IPEDS admissions reporting.',
    `test_type` STRING COMMENT 'Standardized classification of the test or credential instrument submitted. Examples include SAT (Scholastic Assessment Test), ACT (American College Testing), GRE (Graduate Record Examination), GMAT (Graduate Management Admission Test), TOEFL (Test of English as a Foreign Language), IELTS (International English Language Testing System), AP (Advanced Placement), IB (International Baccalaureate), DUOLINGO, or FOREIGN_CREDENTIAL. [ENUM-REF-CANDIDATE: SAT|ACT|GRE|GMAT|TOEFL|IELTS|AP|IB|DUOLINGO|FOREIGN_CREDENTIAL|OTHER — promote to reference product]',
    `testing_agency_code` STRING COMMENT 'Standardized code identifying the external testing agency or credentialing body that issued the score or credential (e.g., CB for College Board, ACT for ACT Inc., ETS for Educational Testing Service, GMAC for Graduate Management Admission Council, IELTS for IELTS Partners, WES for World Education Services, ECE for Educational Credential Evaluators).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this test score or credential record, such as when an official score replaced a self-reported score, when score status was updated, or when admissions staff added notes. Supports data lineage and audit trail requirements.',
    `us_equivalent_degree_level` STRING COMMENT 'The U.S. degree level equivalent assigned by the credential evaluation agency for the international academic credential (e.g., bachelor = equivalent to a U.S. bachelors degree). Used to determine admissions eligibility and program placement for international applicants. [ENUM-REF-CANDIDATE: high_school|associate|bachelor|master|doctoral|professional|other — 7 candidates stripped; promote to reference product]',
    `used_in_admissions_decision` BOOLEAN COMMENT 'Indicates whether this specific test score or credential record was used as evidence in the final admissions decision for the associated application. An applicant may submit multiple scores of the same type; only the highest or most recent may be used. Supports audit trails for admissions decisions and FERPA compliance.',
    CONSTRAINT pk_enrollment_test_score PRIMARY KEY(`enrollment_test_score_id`)
) COMMENT 'Master record of externally-sourced academic evidence submitted by an applicant for admissions evaluation. Includes standardized test scores (SAT, ACT, GRE, GMAT, TOEFL, IELTS) and international academic credentials (foreign transcripts, degree certificates, WES/ECE evaluation reports). For test scores: captures test type, test date, composite score, sub-scores by section, score source (self-reported vs. official), score report date, and superscore eligibility flag. For international credentials: captures country of origin, credential type, issuing institution, evaluation agency, evaluated US-equivalent degree level, and evaluation report date. Supports admissions criteria evaluation, international admissions review, and IPEDS reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`application_checklist` (
    `application_checklist_id` BIGINT COMMENT 'Unique surrogate identifier for each application checklist item record in the Silver layer lakehouse. Primary key for this entity.',
    `enrollment_applicant_id` BIGINT COMMENT 'Reference to the prospective student (applicant) associated with this checklist item. Enables direct applicant-level reporting without joining through the application record.',
    `enrollment_application_id` BIGINT COMMENT 'Reference to the admissions application to which this checklist item belongs. Links the checklist item to the applicants formal application record in Banner and Slate CRM.',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Checklist items are managed through document management enterprise applications (Slate, Workday, Ellucian, custom portals). Tracking which application manages each checklist item type is essential for',
    `ceeb_fice_code` STRING COMMENT 'The College Board CEEB code (for high schools) or FICE code (for colleges/universities) of the sending institution. Used to uniquely identify the transcript source institution and cross-reference with national clearinghouse records. Applicable when item_type = transcript.. Valid values are `^[0-9]{4,6}$`',
    `checklist_code` STRING COMMENT 'Institution-defined alphanumeric code uniquely identifying the type of checklist requirement (e.g., TRANS_HS, LOR_1, PERS_STMT, TEST_SAT, APP_FEE). Sourced from Banner checklist code table and synchronized with Slate CRM checklist configuration.. Valid values are `^[A-Z0-9_]{2,30}$`',
    `class_rank` STRING COMMENT 'Applicants ordinal rank within their graduating class as reported on the high school transcript. Applicable when item_type = transcript and transcript_type = high_school. Null if the sending institution does not report class rank.',
    `class_size` STRING COMMENT 'Total number of students in the applicants graduating class as reported on the high school transcript. Used in conjunction with class_rank to compute class rank percentile for admissions evaluation. Applicable when item_type = transcript and transcript_type = high_school.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this checklist item record was first created in the source system or ingested into the Silver layer. Supports audit trail, data lineage, and application completeness timeline analysis. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `credit_hours_earned` DECIMAL(18,2) COMMENT 'Total credit hours earned as reported on the transcript from the sending institution. Applicable when item_type = transcript and transcript_type is undergraduate or graduate. Used for transfer credit evaluation and degree audit. CR = Credit Hour.',
    `cumulative_gpa` DECIMAL(18,2) COMMENT 'Cumulative GPA as reported on the official transcript from the sending institution. Applicable when item_type = transcript. Stored on the 4.0 scale unless otherwise noted in gpa_scale. Used in admissions eligibility evaluation and academic standing analysis. GPA = Grade Point Average.',
    `deadline_date` DATE COMMENT 'The date by which this checklist item must be received for the application to be considered complete and eligible for review. May differ by item type, program, and application round (e.g., Early Decision vs. Regular Decision). Drives deadline compliance alerts in Slate CRM.',
    `ferpa_waiver_flag` BOOLEAN COMMENT 'Indicates whether the applicant has waived their right to access this letter of recommendation under FERPA. True = applicant waived access (confidential recommendation); False = applicant retains right to access. Applicable when item_type = recommendation. FERPA = Family Educational Rights and Privacy Act.',
    `gpa_scale` DECIMAL(18,2) COMMENT 'The maximum GPA scale used by the sending institution (e.g., 4.0, 5.0, 10.0, 100.0). Required to normalize cumulative_gpa for comparative admissions analysis. Applicable when item_type = transcript.',
    `is_required` BOOLEAN COMMENT 'Indicates whether this checklist item is mandatory for the application to be considered complete and eligible for an admissions decision. True = required; False = optional or supplemental.',
    `item_description` STRING COMMENT 'Human-readable label for the checklist requirement as displayed to the applicant and admissions staff (e.g., Official High School Transcript, Letter of Recommendation — Academic, SAT Score Report). Sourced from Banner checklist description and Slate CRM checklist label.',
    `item_status` STRING COMMENT 'Current workflow status of this checklist item within the application completeness process. Drives the application completeness calculation in Slate CRM and Banner admissions workflow. Pending = not yet received; Received = document in hand but not yet reviewed; Verified = reviewed and accepted; Incomplete = received but insufficient; Rejected = received but not accepted; Waived = requirement formally waived.. Valid values are `pending|received|waived|incomplete|verified|rejected`',
    `item_type` STRING COMMENT 'Categorical classification of the checklist material required. Drives downstream processing logic: transcript items trigger GPA/credit-hour capture; recommendation items trigger recommender identity capture; test_score items trigger score verification. [ENUM-REF-CANDIDATE: transcript|recommendation|personal_statement|test_score|portfolio|essay|application_fee|financial_document|resume|writing_sample|other — promote to reference product]',
    `official_score_flag` BOOLEAN COMMENT 'Indicates whether the test score was received as an official score report directly from the testing agency (True) or as a self-reported score from the applicant (False). Applicable when item_type = test_score. Official scores are required for final admissions decisions at most institutions.',
    `program_code` STRING COMMENT 'Code identifying the academic program or degree level to which the applicant applied (e.g., BSCS, MBA, PHD-CHEM). Checklist requirements may vary by program; this field enables program-specific completeness rules and reporting.',
    `received_date` DATE COMMENT 'Calendar date on which the checklist item was received by the admissions office, whether submitted electronically, by mail, or via third-party service. Null if not yet received. Used to calculate application completeness timelines and deadline compliance.',
    `recommender_email` STRING COMMENT 'Email address of the recommender used to send recommendation request notifications and track submission status. Applicable when item_type = recommendation. Governed by FERPA and institutional privacy policy.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recommender_institution` STRING COMMENT 'Name of the institution, organization, or employer where the recommender is employed. Applicable when item_type = recommendation. Supports evaluation of recommender credibility and relationship context.',
    `recommender_name` STRING COMMENT 'Full legal name of the individual providing the letter of recommendation. Applicable when item_type = recommendation. Captured for identity verification and FERPA waiver tracking purposes.',
    `recommender_rating_academic` STRING COMMENT 'Structured evaluation rating provided by the recommender assessing the applicants academic ability relative to peers. Applicable when item_type = recommendation. Sourced from structured recommendation form fields in Slate CRM. Supports holistic admissions review analytics.. Valid values are `exceptional|strong|good|average|below_average|no_basis`',
    `recommender_rating_personal` STRING COMMENT 'Structured evaluation rating provided by the recommender assessing the applicants personal character, integrity, and interpersonal skills. Applicable when item_type = recommendation. Sourced from structured recommendation form fields in Slate CRM.. Valid values are `exceptional|strong|good|average|below_average|no_basis`',
    `recommender_relationship` STRING COMMENT 'Nature of the relationship between the recommender and the applicant. Applicable when item_type = recommendation. Used to assess the type and relevance of the recommendation in the admissions review process.. Valid values are `academic|professional|personal|employer|coach|other`',
    `recommender_title` STRING COMMENT 'Professional title or position of the recommender (e.g., Professor of Chemistry, High School Principal, Director of Research). Applicable when item_type = recommendation. Used to assess the relevance and authority of the recommendation.',
    `reminder_sent_date` DATE COMMENT 'Date on which the most recent automated reminder notification was sent to the applicant or recommender regarding this outstanding checklist item. Supports communication tracking in Slate CRM and reduces incomplete application rates.',
    `reviewed_by` STRING COMMENT 'Username or staff identifier of the admissions staff member who last reviewed and updated the status of this checklist item. Supports audit trail and workload reporting.',
    `reviewer_notes` STRING COMMENT 'Free-text notes entered by the admissions reviewer regarding the checklist item (e.g., discrepancies found, follow-up actions required, special circumstances noted). Supports the admissions review workflow in Slate CRM.',
    `sending_institution_name` STRING COMMENT 'Name of the institution that issued the transcript (for transcript-type checklist items). Applicable when item_type = transcript. Examples: Lincoln High School, University of Michigan.',
    `sort_order` STRING COMMENT 'Numeric sequence controlling the display order of checklist items within an applications checklist view in the applicant portal and admissions staff interface. Lower values appear first.',
    `source_system` STRING COMMENT 'Operational system of record from which this checklist item record originated (e.g., Ellucian Banner, Slate CRM, Common Application, Coalition App). Supports data lineage tracking and ETL reconciliation in the Silver layer lakehouse. [ENUM-REF-CANDIDATE: Banner|Slate|CommonApp|CoalitionApp|ApplyTexas|manual|other — 7 candidates stripped; promote to reference product]',
    `submission_method` STRING COMMENT 'Channel through which the checklist item was submitted to the institution (e.g., electronic via Parchment/National Student Clearinghouse, postal mail, hand-delivered, third-party service such as Common App or Coalition App). Supports audit and document tracking.. Valid values are `electronic|mail|fax|hand_delivered|third_party_service|email`',
    `term_code` STRING COMMENT 'Banner-format term code (YYYYTT) identifying the enrollment term for which the application and associated checklist items apply (e.g., 202408 = Fall 2024). Enables term-based completeness reporting and admissions cycle analytics.. Valid values are `^[0-9]{6}$`',
    `test_date` DATE COMMENT 'Date on which the standardized test was administered. Applicable when item_type = test_score. Used to assess score recency relative to institutional policies (e.g., TOEFL scores valid for 2 years) and to identify the most recent score for superscore calculations.',
    `test_score` DECIMAL(18,2) COMMENT 'Composite or total score reported on the standardized test. Applicable when item_type = test_score. Score scale varies by test type (e.g., SAT 400–1600, ACT 1–36, TOEFL 0–120, IELTS 0–9.0). Used in admissions eligibility evaluation and institutional IPEDS reporting.',
    `test_type` STRING COMMENT 'Type of standardized test score submitted as a checklist item. Applicable when item_type = test_score. SAT = Scholastic Assessment Test; ACT = American College Testing; GRE = Graduate Record Examination; GMAT = Graduate Management Admission Test; TOEFL = Test of English as a Foreign Language; IELTS = International English Language Testing System; AP = Advanced Placement; IB = International Baccalaureate. [ENUM-REF-CANDIDATE: SAT|ACT|GRE|GMAT|TOEFL|IELTS|AP|IB|other — 9 candidates stripped; promote to reference product]',
    `transcript_type` STRING COMMENT 'Classification of the transcript by educational level. Applicable when item_type = transcript. Drives GPA normalization logic and accreditation reporting requirements. High_school = secondary education; undergraduate = post-secondary bachelors level; graduate = post-baccalaureate; international = foreign credential requiring evaluation.. Valid values are `high_school|undergraduate|graduate|international|ged|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this checklist item record in the source system or Silver layer. Used for incremental ETL processing, change detection, and audit trail compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `verified_date` DATE COMMENT 'Calendar date on which an admissions reviewer confirmed the checklist item as authentic, complete, and meeting institutional requirements. Null if not yet verified.',
    `waiver_flag` BOOLEAN COMMENT 'Indicates whether the institution has formally waived this checklist requirement for the applicant (e.g., test-optional policy waiving standardized test scores, or GED waiving high school transcript). True = waived; False = not waived.',
    `waiver_reason` STRING COMMENT 'Narrative explanation for why the checklist requirement was waived (e.g., Test-optional policy AY2024, International applicant — transcript equivalent accepted, GED holder — HS transcript not applicable). Populated only when waiver_flag is True.',
    CONSTRAINT pk_application_checklist PRIMARY KEY(`application_checklist_id`)
) COMMENT 'Tracks the required and optional materials for each application including transcripts, letters of recommendation, personal statements, test scores, portfolios, essays, and application fees. For recommendation items, captures recommender identity, title, institution, relationship to applicant, submission method, FERPA waiver of access, and structured evaluation ratings. For transcript items, captures sending institution, CEEB/FICE code, transcript type (high school, undergraduate, graduate), cumulative GPA, class rank, and credit hours. Records item type, required flag, received date, waiver flag, verification status, and reviewer notes. Drives the application completeness workflow in Slate CRM and Banner.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`recommendation` (
    `recommendation_id` BIGINT COMMENT 'Unique system-generated identifier for each letter of recommendation record submitted on behalf of an applicant.',
    `application_checklist_id` BIGINT COMMENT 'Reference to the specific application checklist item that this recommendation satisfies. Tracks which required recommendation slot (e.g., first academic reference, second professional reference) has been fulfilled.',
    `enrollment_application_id` BIGINT COMMENT 'Reference to the admissions application for which this recommendation was submitted. Links the recommendation to the applicants application checklist in the Student Information System (SIS).',
    `ferpa_disclosure_id` BIGINT COMMENT 'Foreign key linking to compliance.ferpa_disclosure. Business justification: Recommendation letters shared beyond admissions committee (scholarships, external programs) constitute FERPA disclosures. Admissions offices must track when recommendations are disclosed, especially w',
    `academic_ability_rating` STRING COMMENT 'Recommenders structured rating of the applicants academic ability and intellectual capacity on a standardized evaluation form. Used in admissions analytics to correlate recommender assessments with enrollment outcomes.. Valid values are `exceptional|strong|good|average|below_average|insufficient_basis`',
    `applicant_rank_percentile` DECIMAL(18,2) COMMENT 'Recommenders assessment of the applicants rank relative to comparable individuals the recommender has known (e.g., top 5% of students taught in 20 years). Expressed as a percentile. Applicable only on structured forms.',
    `character_rating` STRING COMMENT 'Recommenders structured rating of the applicants character, integrity, and personal qualities on a standardized evaluation form. Supports holistic admissions review processes.. Valid values are `exceptional|strong|good|average|below_average|insufficient_basis`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this recommendation record was first created in the system. Serves as the audit trail creation marker for the record lifecycle.',
    `deadline_date` DATE COMMENT 'Application-specific deadline by which the recommendation must be received. Used to flag overdue recommendations and trigger automated reminder communications to recommenders.',
    `document_file_name` STRING COMMENT 'Name of the uploaded recommendation document file as stored in the document management system. Used to locate and retrieve the physical letter for admissions review.',
    `document_page_count` STRING COMMENT 'Number of pages in the submitted recommendation document. Used for quality control to ensure the document is complete and not truncated during upload or mail processing.',
    `document_storage_path` STRING COMMENT 'Logical storage path or URI of the recommendation document in the institutional document repository or cloud storage. Restricted to authorized admissions staff per FERPA guidelines.',
    `ferpa_waiver_date` DATE COMMENT 'Date on which the applicant signed or electronically acknowledged the FERPA waiver for this recommendation. Required for compliance documentation under FERPA regulations.',
    `ferpa_waiver_flag` BOOLEAN COMMENT 'Indicates whether the applicant has waived their right to access this letter of recommendation under the Family Educational Rights and Privacy Act (FERPA). A value of True means the applicant waived access, which is generally considered to increase the credibility of the recommendation by admissions reviewers.',
    `form_type` STRING COMMENT 'Indicates whether the recommendation was submitted as an open-ended letter, a structured evaluation form with rating scales, or a hybrid combining both formats. Determines whether structured rating fields are applicable.. Valid values are `open_letter|structured_form|hybrid`',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the recommendation was submitted under a confidentiality agreement separate from the FERPA waiver. Some recommenders request institutional confidentiality beyond the applicant waiver.',
    `last_reminder_date` DATE COMMENT 'Date on which the most recent reminder communication was sent to the recommender. Used to manage follow-up cadence and avoid over-contacting recommenders.',
    `leadership_rating` STRING COMMENT 'Recommenders structured rating of the applicants demonstrated leadership potential and initiative on a standardized evaluation form.. Valid values are `exceptional|strong|good|average|below_average|insufficient_basis`',
    `overall_rating` STRING COMMENT 'Recommenders overall categorical rating of the applicant on a structured evaluation form. Applicable only when form_type is structured_form or hybrid. Used in holistic admissions review and analytics. [ENUM-REF-CANDIDATE: exceptional|strong|good|average|below_average|insufficient_basis — promote to reference product]. Valid values are `exceptional|strong|good|average|below_average|insufficient_basis`',
    `program_type` STRING COMMENT 'Type of academic program for which this recommendation was submitted. Allows differentiation of recommendation requirements and evaluation criteria across undergraduate, graduate, doctoral, and professional programs.. Valid values are `undergraduate|graduate|doctoral|professional|certificate`',
    `received_timestamp` TIMESTAMP COMMENT 'Precise date and time the recommendation was received and recorded in the admissions system. Distinct from submission_date; captures the exact moment of institutional receipt for audit and deadline compliance purposes.',
    `recommender_department` STRING COMMENT 'Academic department, division, or organizational unit within the recommenders institution (e.g., Department of Chemistry, College of Engineering).',
    `recommender_email` STRING COMMENT 'Professional email address of the recommender used to send the recommendation request, track submission status, and send reminders via the admissions portal.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recommender_first_name` STRING COMMENT 'Legal first (given) name of the individual who authored and submitted the letter of recommendation.',
    `recommender_institution` STRING COMMENT 'Name of the organization, university, college, company, or institution where the recommender is currently employed or affiliated.',
    `recommender_last_name` STRING COMMENT 'Legal last (family/surname) name of the individual who authored and submitted the letter of recommendation.',
    `recommender_phone` STRING COMMENT 'Professional phone number of the recommender for follow-up contact by the admissions office if verification or clarification is needed.',
    `recommender_title` STRING COMMENT 'Professional title or honorific of the recommender (e.g., Professor, Dr., Director, Vice President). Used to assess the authority and relevance of the recommendation.',
    `relationship_description` STRING COMMENT 'Free-text narrative describing the specific nature of the recommenders relationship to the applicant (e.g., Thesis advisor for two years, Direct supervisor during summer internship). Provides context beyond the categorical relationship type.',
    `relationship_duration_years` DECIMAL(18,2) COMMENT 'Number of years the recommender has known the applicant. Helps admissions reviewers assess the depth and credibility of the recommendation.',
    `relationship_type` STRING COMMENT 'Categorical classification of the recommenders relationship to the applicant. Used by admissions reviewers to assess the context and weight of the recommendation. [ENUM-REF-CANDIDATE: academic|professional|personal|research|supervisory|other — promote to reference product if additional values are needed]. Valid values are `academic|professional|personal|research|supervisory|other`',
    `reminder_count` STRING COMMENT 'Number of automated or manual reminder communications sent to the recommender requesting submission of the outstanding recommendation. Supports admissions workflow management.',
    `request_date` DATE COMMENT 'Date on which the applicant or institution formally requested the recommendation from the recommender. Used to calculate response time and manage reminder workflows.',
    `review_notes` STRING COMMENT 'Internal notes entered by admissions staff regarding the recommendation (e.g., authenticity concerns, follow-up actions taken, verification outcomes). Confidential and restricted to authorized admissions personnel per FERPA.',
    `source_system_code` STRING COMMENT 'Code identifying the originating operational system from which this recommendation record was ingested into the data lakehouse. Supports data lineage tracking across Ellucian Banner, Slate CRM, Common Application, Coalition Application, and Interfolio.. Valid values are `banner|slate|common_app|coalition_app|interfolio|manual`',
    `source_system_rec_code` STRING COMMENT 'Native identifier of this recommendation record in the originating operational system (e.g., Banner SPRRECC key, Slate document ID). Enables reconciliation and traceability between the lakehouse silver layer and the system of record.',
    `strength` STRING COMMENT 'Recommenders explicit endorsement level for the applicants admission. Captures the recommenders overall willingness to advocate for the applicants acceptance.. Valid values are `highly_recommend|recommend|recommend_with_reservations|cannot_recommend`',
    `submission_date` DATE COMMENT 'Date on which the recommender submitted the completed recommendation. Used to confirm checklist completion and assess timeliness relative to application deadlines.',
    `submission_method` STRING COMMENT 'Method by which the recommendation was submitted to the institution. Tracks whether the document arrived via the online admissions portal, physical mail, email attachment, fax, hand delivery, or a third-party credential service such as Interfolio. [ENUM-REF-CANDIDATE: online_portal|mail|email|fax|hand_delivered|interfolio — promote to reference product if additional values are needed]. Valid values are `online_portal|mail|email|fax|hand_delivered|interfolio`',
    `submission_status` STRING COMMENT 'Current lifecycle status of the recommendation within the admissions process. Tracks progression from initial request through receipt and review. [ENUM-REF-CANDIDATE: requested|pending|submitted|received|waived|expired|declined — promote to reference product]',
    `term_code` STRING COMMENT 'Academic term code for which the application and associated recommendation are being considered (e.g., 202501 for Spring 2025). Aligns with the institutional term calendar in the Student Information System (SIS).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this recommendation record was most recently modified. Supports incremental data loading, change data capture, and audit compliance in the Databricks Lakehouse Silver Layer.',
    `verification_status` STRING COMMENT 'Status of any authenticity or identity verification performed on the recommendation or recommender. Used to flag potentially fraudulent submissions and support compliance with institutional integrity policies.. Valid values are `not_required|pending|verified|failed|waived`',
    CONSTRAINT pk_recommendation PRIMARY KEY(`recommendation_id`)
) COMMENT 'Record of a letter of recommendation submitted on behalf of an applicant. Captures recommender name, title, institution, relationship to applicant, submission method (online portal, mail), submission date, waiver of access flag (FERPA), and evaluation ratings if a structured form was used. Linked to the application checklist.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`transcript` (
    `transcript_id` BIGINT COMMENT 'Unique surrogate identifier for each transcript record received from a prior institution as part of the admissions or transfer credit evaluation process.',
    `application_checklist_id` BIGINT COMMENT 'Foreign key linking to enrollment.application_checklist. Business justification: Transcript is a specific type of application checklist item. While transcript already references application_id directly, it should also link to its corresponding checklist entry to track receipt stat',
    `employee_id` BIGINT COMMENT 'Reference to the staff member or admissions counselor responsible for evaluating this transcript and making the credit or admissions determination.',
    `enrollment_applicant_id` BIGINT COMMENT 'Reference to the individual applicant or prospective student who submitted or for whom this transcript was received.',
    `enrollment_application_id` BIGINT COMMENT 'Reference to the admissions application with which this transcript is associated, linking the transcript to the applicants file in the admissions workflow.',
    `ferpa_disclosure_id` BIGINT COMMENT 'Foreign key linking to compliance.ferpa_disclosure. Business justification: Transcript releases are FERPA disclosures requiring audit trail per 34 CFR 99.32. Registrar offices must track each disclosure event, recipient, purpose, and student consent. Essential for FERPA compl',
    `academic_standing` STRING COMMENT 'Academic standing of the student at the sending institution as reported on the transcript (e.g., good standing, academic probation, academic suspension, academic dismissal, deans list). Used in admissions eligibility review and transfer credit decisions.. Valid values are `good_standing|academic_probation|academic_suspension|academic_dismissal|dean_list`',
    `ceeb_code` STRING COMMENT 'Six-digit College Entrance Examination Board (CEEB) code assigned by College Board to uniquely identify the sending high school or college. Used for standardized institution identification in admissions processing.. Valid values are `^[0-9]{6}$`',
    `cip_code` STRING COMMENT 'Six-digit Classification of Instructional Programs (CIP) code corresponding to the major or program of study at the sending institution. Enables standardized program comparison and transfer articulation across institutions.. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `class_rank` STRING COMMENT 'Ordinal rank of the student within their graduating class as reported on the transcript. Used in admissions criteria review for competitive programs. Null if the sending institution does not report class rank.',
    `class_size` STRING COMMENT 'Total number of students in the graduating class at the sending institution, used in conjunction with class rank to calculate class rank percentile for admissions evaluation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transcript record was first created in the system, representing the point at which the transcript was logged into the admissions processing workflow.',
    `credit_system` STRING COMMENT 'Credit hour system used by the sending institution: semester hours, quarter hours, trimester hours, ECTS (European Credit Transfer System) credits, or institutional units. Required for accurate credit conversion during transfer evaluation.. Valid values are `semester|quarter|trimester|ects|unit`',
    `credits_attempted` DECIMAL(18,2) COMMENT 'Total number of credit hours (CR) attempted by the student at the sending institution as reported on the transcript. Used in transfer credit evaluation and Satisfactory Academic Progress (SAP) determination.',
    `credits_earned` DECIMAL(18,2) COMMENT 'Total number of credit hours (CR) successfully earned (passed) by the student at the sending institution as reported on the transcript. Distinct from credits attempted; used to assess academic completion rate.',
    `credits_transferable` DECIMAL(18,2) COMMENT 'Number of credit hours from the sending institution that have been approved for transfer to the receiving institution following evaluation. May be less than or equal to credits earned.',
    `cumulative_gpa` DECIMAL(18,2) COMMENT 'Cumulative Grade Point Average (GPA) as reported on the transcript from the sending institution, typically on a 4.0 scale. Used as a primary academic performance indicator in admissions criteria review and transfer credit eligibility assessment.',
    `degree_awarded` STRING COMMENT 'Name of the degree, diploma, or credential awarded by the sending institution as printed on the transcript (e.g., Bachelor of Science, Associate of Arts, High School Diploma, GED). Null if no degree was conferred.',
    `delivery_method` STRING COMMENT 'Method by which the transcript was delivered to the receiving institution: electronic (e.g., via Parchment, National Student Clearinghouse), physical mail, hand-delivered by applicant, or fax.. Valid values are `electronic|mail|hand_delivered|fax`',
    `disciplinary_notation` BOOLEAN COMMENT 'Indicates whether the transcript contains a disciplinary notation or academic integrity violation record from the sending institution (True). Used in admissions character review and compliance with institutional conduct policies.',
    `document_reference_number` STRING COMMENT 'External reference or tracking number assigned by the sending institution or transcript delivery service (e.g., Parchment order ID, NSC tracking number) to uniquely identify the transcript document for reconciliation and audit purposes.',
    `document_source_system` STRING COMMENT 'Electronic transcript exchange network or delivery platform through which the transcript was received (e.g., Parchment, National Student Clearinghouse, Scrip-Safe, paper mail). Used for document provenance tracking and audit.. Valid values are `parchment|national_student_clearinghouse|scrip_safe|paper|edi|other`',
    `evaluation_date` DATE COMMENT 'Calendar date on which the transcript evaluation was completed by the admissions evaluator or transfer credit analyst.',
    `evaluation_status` STRING COMMENT 'Current workflow status of the transcript evaluation process: pending (received, not yet reviewed), in_review (actively being evaluated), evaluated (review complete), accepted (credits or credentials accepted), rejected (not accepted), or on_hold (awaiting additional information). Drives admissions and transfer credit workflows.. Valid values are `pending|in_review|evaluated|accepted|rejected|on_hold`',
    `fice_code` STRING COMMENT 'Six-digit Federal Interagency Committee on Education (FICE) code assigned by the U.S. Department of Education to identify postsecondary institutions. Used for IPEDS reporting and transfer credit institution matching.. Valid values are `^[0-9]{6}$`',
    `foreign_credential_eval_agency` STRING COMMENT 'Name of the NACES-member credential evaluation agency (e.g., WES, ECE, AACRAO EDGE) that evaluated the foreign transcript. Populated only when foreign_credential_eval_required is True.',
    `foreign_credential_eval_date` DATE COMMENT 'Date on which the foreign credential evaluation was completed by the designated evaluation agency. Used to track evaluation turnaround and application completeness for international applicants.',
    `foreign_credential_eval_required` BOOLEAN COMMENT 'Indicates whether this transcript requires a foreign credential evaluation by a NACES-member evaluation service (True) because it originates from a non-U.S. institution. Triggers the foreign credential evaluation workflow in admissions.',
    `gpa_scale` DECIMAL(18,2) COMMENT 'Maximum GPA scale used by the sending institution (e.g., 4.0, 5.0, 10.0, 100.0). Required to normalize and compare GPA values across institutions with different grading systems.',
    `graduation_date` DATE COMMENT 'Date on which the student graduated or completed their program at the sending institution as reported on the transcript. Used to verify degree completion for graduate admissions and transfer eligibility.',
    `honors_notation` STRING COMMENT 'Academic honors designation printed on the transcript from the sending institution (e.g., cum laude, magna cum laude, summa cum laude, honors program). Used in merit scholarship evaluation and admissions recognition.. Valid values are `cum_laude|magna_cum_laude|summa_cum_laude|honors|none`',
    `institution_country` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the country where the sending institution is located. Used to identify international transcripts requiring foreign credential evaluation.. Valid values are `^[A-Z]{3}$`',
    `institution_name` STRING COMMENT 'Full legal name of the prior institution (high school, college, or university) that issued this official or unofficial transcript.',
    `institution_state` STRING COMMENT 'Two-letter U.S. state or territory abbreviation where the sending institution is located. Applicable for domestic institutions; null for international institutions.. Valid values are `^[A-Z]{2}$`',
    `major_field_of_study` STRING COMMENT 'Primary academic major or field of study as reported on the transcript from the sending institution. Used in transfer credit articulation and program admission requirements review.',
    `notes` STRING COMMENT 'Free-text notes entered by the admissions evaluator or registrar staff regarding special circumstances, exceptions, or observations related to this transcript evaluation. May contain sensitive academic information.',
    `official_flag` BOOLEAN COMMENT 'Indicates whether the transcript is an official document received directly from the issuing institution (True) or an unofficial copy submitted by the applicant (False). Official transcripts are required for final admissions decisions and enrollment confirmation.',
    `receipt_date` DATE COMMENT 'Calendar date on which the transcript was received by the institutions admissions or registrar office. Used to track application completeness and compliance with admissions deadlines.',
    `term_end_date` DATE COMMENT 'End date of the last term of enrollment at the sending institution as reported on the transcript. Used to establish the duration of prior enrollment and recency of academic activity.',
    `term_start_date` DATE COMMENT 'Start date of the first term of enrollment at the sending institution as reported on the transcript. Used to establish the duration of prior enrollment and academic history timeline.',
    `transcript_type` STRING COMMENT 'Classification of the transcript by the level of education it represents: high school (secondary), undergraduate (bachelors-level), graduate (masters/doctoral), professional (law/medical/business), or vocational/technical. Drives transfer credit evaluation rules and admissions criteria review. [ENUM-REF-CANDIDATE: high_school|undergraduate|graduate|professional|vocational|international — promote to reference product]. Valid values are `high_school|undergraduate|graduate|professional|vocational`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this transcript record, supporting audit trail requirements and change tracking for FERPA compliance and accreditation reporting.',
    `verification_date` DATE COMMENT 'Date on which the transcript was verified as authentic by the admissions office or third-party verification service. Populated only when verified_flag is True.',
    `verified_flag` BOOLEAN COMMENT 'Indicates whether the authenticity of the transcript has been independently verified by the admissions office or a third-party verification service (True). Supports fraud prevention and accreditation compliance.',
    CONSTRAINT pk_transcript PRIMARY KEY(`transcript_id`)
) COMMENT 'Record of an official or unofficial academic transcript received from a prior institution as part of the application process. Captures sending institution name, CEEB/FICE code, transcript type (high school, undergraduate, graduate), receipt date, evaluation status, cumulative GPA, class rank, and credit hours attempted. Supports transfer credit evaluation and admissions criteria review.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`admission_criteria` (
    `admission_criteria_id` BIGINT COMMENT 'Unique surrogate identifier for each admission criteria record. Primary key for the admission_criteria data product.',
    `academic_program_id` BIGINT COMMENT 'Reference to the academic program for which these admission criteria apply. Links criteria to a specific degree or certificate program.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Admission criteria authorship and approval tracking requires linking to the faculty member or academic administrator who created or last reviewed the criteria. Accreditation reviews and academic gover',
    `accreditation_standard_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_standard. Business justification: Admission criteria must demonstrably align with accreditor standards (e.g., AACSB minimum GMAT, ABET prerequisite requirements). Program directors and accreditation liaisons use this link to document ',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: Admission criteria vary by entry term. Currently admission_criteria has entry_term_code as STRING but no FK to term. Adding term_id FK normalizes the term reference and enables proper term-based crite',
    `accreditation_body_code` STRING COMMENT 'Code identifying the accreditation body whose standards govern the admission criteria for this program. Ensures criteria align with accreditor-mandated admission requirements. [ENUM-REF-CANDIDATE: HLC|SACSCOC|ABET|AACSB|ABA|LCME|MSCHE|NWCCU|NECHE|WSCUC — promote to reference product]',
    `application_deadline_date` DATE COMMENT 'Final date by which applications must be submitted to be evaluated under this criteria set. Used to configure deadline enforcement in Slate CRM and Banner admissions workflows.',
    `approved_by` STRING COMMENT 'Name or identifier of the admissions office authority (e.g., Dean of Admissions, Program Director) who approved this criteria configuration. Supports governance and audit trail for criteria changes.',
    `approved_date` DATE COMMENT 'Date on which this admission criteria configuration was formally approved by the designated authority. Supports governance, audit, and accreditation compliance documentation.',
    `automated_screening_enabled` BOOLEAN COMMENT 'Indicates whether this criteria set is configured to drive automated eligibility screening in the admissions system. When True, Banner or Slate CRM applies the criteria thresholds to filter applications without manual review.',
    `citizenship_requirement` STRING COMMENT 'Citizenship status requirement for applicants under this criteria set. Relevant for programs with federal funding restrictions or visa-related enrollment constraints.. Valid values are `US_CITIZEN|PERMANENT_RESIDENT|INTERNATIONAL|ANY`',
    `criteria_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this criteria configuration within the admissions office. Used for cross-referencing in Slate CRM and Banner.',
    `criteria_name` STRING COMMENT 'Human-readable name describing this set of admission criteria (e.g., Fall 2025 Undergraduate Engineering Freshman Criteria). Used in admissions office reporting and communications.',
    `criteria_notes` STRING COMMENT 'Free-text field for additional context, exceptions, or special instructions associated with this admission criteria set. Used by admissions staff to document program-specific nuances not captured in structured fields.',
    `criteria_status` STRING COMMENT 'Current lifecycle status of this admission criteria record. DRAFT indicates criteria under review; ACTIVE indicates currently in use for eligibility screening; INACTIVE indicates suspended; ARCHIVED indicates historical record no longer applied.. Valid values are `DRAFT|ACTIVE|INACTIVE|ARCHIVED`',
    `criteria_type` STRING COMMENT 'Classification of the admission review methodology. STANDARD applies fixed thresholds; HOLISTIC incorporates weighted qualitative review; SELECTIVE applies competitive ranking; OPEN_ADMISSION has no minimum requirements; CONDITIONAL applies provisional admission rules.. Valid values are `STANDARD|HOLISTIC|SELECTIVE|OPEN_ADMISSION|CONDITIONAL`',
    `decision_notification_date` DATE COMMENT 'Target date by which admission decisions are communicated to applicants for this criteria cycle. Used for planning admissions office workflows and applicant communications in Slate CRM.',
    `effective_end_date` DATE COMMENT 'Date after which this admission criteria configuration is no longer applied. Null indicates the criteria is open-ended and currently active. Supports historical versioning.',
    `effective_start_date` DATE COMMENT 'Date from which this admission criteria configuration becomes effective and is applied to incoming applications. Supports versioning of criteria across admission cycles.',
    `entry_level_code` STRING COMMENT 'Academic entry level for which these criteria apply, such as freshman, transfer, graduate, doctoral, certificate, or professional. Determines which applicant population is evaluated against this criteria set.. Valid values are `FRESHMAN|TRANSFER|GRADUATE|DOCTORAL|CERTIFICATE|PROFESSIONAL`',
    `essay_weight_pct` DECIMAL(18,2) COMMENT 'Percentage weight assigned to personal statement or essay submissions in the holistic review scoring model. Expressed as a percentage (0-100).',
    `extracurricular_weight_pct` DECIMAL(18,2) COMMENT 'Percentage weight assigned to extracurricular activities, leadership, and community involvement in the holistic review scoring model. Expressed as a percentage (0-100).',
    `gpa_scale` DECIMAL(18,2) COMMENT 'The numeric scale used to evaluate the minimum GPA requirement (e.g., 4.0, 5.0, 10.0). Necessary to correctly interpret min_gpa when evaluating international or non-standard transcripts.',
    `gpa_weight_pct` DECIMAL(18,2) COMMENT 'Percentage weight assigned to GPA in the holistic review scoring model. Expressed as a percentage (0-100). All weight percentages across review criteria should sum to 100 when holistic review is enabled.',
    `holistic_review_enabled` BOOLEAN COMMENT 'Indicates whether holistic review methodology is applied in the admission evaluation, considering non-academic factors such as leadership, community service, and life experience alongside academic metrics.',
    `interview_format` STRING COMMENT 'Format of the required admission interview. IN_PERSON for on-campus interviews; VIRTUAL for video-based interviews; PANEL for multi-interviewer sessions; MMI (Multiple Mini Interview) for medical/health professional programs.. Valid values are `IN_PERSON|VIRTUAL|PANEL|MMI|NONE`',
    `interview_required` BOOLEAN COMMENT 'Indicates whether a formal interview is required as part of the admission evaluation process. Applicable to selective programs such as honors, medical, law, and MBA programs.',
    `last_reviewed_date` DATE COMMENT 'Date on which this admission criteria record was last reviewed by the admissions office for accuracy and relevance. Supports annual review cycles required by accreditation bodies.',
    `letters_of_recommendation_required` STRING COMMENT 'Number of letters of recommendation required as part of the application. Zero indicates no letters are required. Used to configure application checklists in Slate CRM.',
    `min_act_composite` STRING COMMENT 'Minimum ACT (American College Testing) composite score required for admission consideration. Null indicates ACT is not required or no minimum is enforced. Applies to undergraduate freshman applicants.',
    `min_class_rank_pct` DECIMAL(18,2) COMMENT 'Minimum high school class rank percentile required for admission consideration (e.g., 75.00 means applicant must be in the top 25% of their graduating class). Null indicates class rank is not evaluated.',
    `min_credit_hours_completed` STRING COMMENT 'Minimum number of college credit hours (CR) an applicant must have completed prior to admission. Primarily applicable to transfer applicants. Null indicates no minimum credit hour requirement.',
    `min_gmat_total` STRING COMMENT 'Minimum GMAT (Graduate Management Admission Test) total score required for business graduate program admission. Null indicates GMAT is not required or no minimum is enforced. Relevant for AACSB-accredited programs.',
    `min_gpa` DECIMAL(18,2) COMMENT 'Minimum cumulative GPA (Grade Point Average) on a 4.0 scale required for an applicant to be considered for admission. Null indicates no minimum GPA threshold is enforced for this criteria set.',
    `min_gre_quantitative` STRING COMMENT 'Minimum GRE (Graduate Record Examination) quantitative reasoning score required for graduate admission. Null indicates GRE quantitative is not required or no minimum is enforced.',
    `min_gre_verbal` STRING COMMENT 'Minimum GRE (Graduate Record Examination) verbal reasoning score required for graduate admission. Null indicates GRE verbal is not required or no minimum is enforced.',
    `min_ielts_band` DECIMAL(18,2) COMMENT 'Minimum IELTS (International English Language Testing System) overall band score required for international applicants. Null indicates IELTS is not required. Accepted as an alternative to TOEFL.',
    `min_sat_total` STRING COMMENT 'Minimum combined SAT (Scholastic Assessment Test) score required for admission consideration. Null indicates SAT is not required or no minimum is enforced. Applies to undergraduate freshman applicants.',
    `min_toefl_score` STRING COMMENT 'Minimum TOEFL (Test of English as a Foreign Language) iBT total score required for international applicants whose native language is not English. Null indicates TOEFL is not required.',
    `personal_statement_required` BOOLEAN COMMENT 'Indicates whether a personal statement or statement of purpose essay is required as part of the application. Drives application checklist configuration in Slate CRM.',
    `portfolio_required` BOOLEAN COMMENT 'Indicates whether a creative or professional portfolio submission is required for admission. Applicable to programs in fine arts, architecture, design, and similar disciplines.',
    `portfolio_type` STRING COMMENT 'Type of portfolio required for admission when portfolio_required is True. CREATIVE for arts/design programs; PROFESSIONAL for business/engineering; RESEARCH for graduate research programs; DIGITAL for online submission formats.. Valid values are `CREATIVE|PROFESSIONAL|RESEARCH|DIGITAL|NONE`',
    `prerequisite_coursework_description` STRING COMMENT 'Narrative description of required prerequisite courses or subject areas (e.g., Calculus I, Chemistry I, Biology I). Used by admissions counselors and applicants to understand coursework requirements.',
    `prerequisite_coursework_required` BOOLEAN COMMENT 'Indicates whether specific prerequisite coursework must be completed prior to admission. When True, the admissions office evaluates transcripts for required course completion.',
    `priority_deadline_date` DATE COMMENT 'Earlier deadline by which applications must be submitted to receive priority consideration for admission and financial aid. Applications received after this date but before the final deadline are still reviewed but may not receive priority treatment.',
    `residency_requirement` STRING COMMENT 'Residency classification requirement for applicants under this criteria set. Determines whether criteria apply to in-state, out-of-state, international, or all applicants. Affects tuition classification and eligibility screening.. Valid values are `IN_STATE|OUT_OF_STATE|INTERNATIONAL|DOMESTIC|ANY`',
    `test_optional_flag` BOOLEAN COMMENT 'Indicates whether standardized test scores (SAT/ACT/GRE/GMAT) are optional for this admission criteria set. True means applicants may apply without submitting test scores. Reflects test-optional admission policies.',
    `test_score_weight_pct` DECIMAL(18,2) COMMENT 'Percentage weight assigned to standardized test scores (SAT/ACT/GRE/GMAT) in the holistic review scoring model. Expressed as a percentage (0-100).',
    CONSTRAINT pk_admission_criteria PRIMARY KEY(`admission_criteria_id`)
) COMMENT 'Reference entity defining the admissions requirements and evaluation criteria for each program, entry level, and entry term. Captures minimum GPA thresholds, required test scores, prerequisite coursework, portfolio requirements, interview requirements, and holistic review weights. Managed by the admissions office and updated each cycle. Drives automated eligibility screening.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`recruitment_event` (
    `recruitment_event_id` BIGINT COMMENT 'Unique surrogate identifier for each recruitment event record in the enrollment domain. Primary key for the recruitment_event data product.',
    `employee_id` BIGINT COMMENT 'Identifier of the primary admissions counselor responsible for hosting and managing this recruitment event. Links to the staff/employee record for workload management, territory assignment, and performance reporting. Serves as the PARTY_REFERENCE for this transaction.',
    `recruitment_territory_id` BIGINT COMMENT 'Foreign key linking to enrollment.recruitment_territory. Business justification: Recruitment events are organized within specific territories. Currently recruitment_event has territory_name and territory_region as denormalized strings. Adding FK to recruitment_territory normalizes',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: On-campus recruitment events (open houses, admitted student days) are held in specific buildings. Event planning, space coordination, and facility services require linking recruitment events to buildi',
    `academic_term` STRING COMMENT 'The enrollment term for which this recruitment event is intended to generate yield (e.g., Fall 2025, Spring 2026). Aligns recruitment activity to term-based enrollment cycles and supports cohort-level yield analysis.',
    `academic_year` STRING COMMENT 'The academic year associated with this recruitment event (e.g., 2024-2025). Used for year-over-year trend analysis, accreditation reporting, and IPEDS enrollment data submissions.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `actual_attendance` STRING COMMENT 'The actual number of individuals who attended the recruitment event. Populated after event completion. Used for yield management analysis, ROI calculation, and show rate (actual_attendance / registered_count) reporting.',
    `actual_cost` DECIMAL(18,2) COMMENT 'The actual total expenditure (in USD) incurred for this recruitment event after completion. Populated from Oracle PeopleSoft Financials. Used for recruitment ROI analysis, cost-per-attendee calculations, and territory budget variance reporting.',
    `cancellation_reason` STRING COMMENT 'Free-text description of the reason this recruitment event was cancelled or postponed. Populated only when event_status is cancelled or postponed. Used for operational review and future event planning.',
    `cip_code` STRING COMMENT 'The six-digit Classification of Instructional Programs (CIP) code associated with the primary academic program being recruited for at this event (e.g., 11.0701 for Computer Science). Enables standardized program-level reporting to IPEDS and accreditation bodies.. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `college_unit` STRING COMMENT 'The specific college, school, or academic unit within the institution that this recruitment event primarily represents or is organized by (e.g., College of Engineering, School of Business, Graduate School). Supports unit-level yield analysis and AACSB/ABET accreditation reporting.',
    `cost_center_code` STRING COMMENT 'The institutional cost center or budget unit code to which the expenses for this recruitment event are charged. Sourced from Oracle PeopleSoft Financials chart of accounts. Enables financial reporting and budget reconciliation by organizational unit.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this recruitment event record was first created in the source system (Slate CRM). Serves as the RECORD_AUDIT_CREATED field for data lineage, audit trail, and silver layer ingestion tracking.',
    `delivery_mode` STRING COMMENT 'Indicates whether the recruitment event is conducted in-person at a physical location, fully virtual (online), or in a hybrid format combining both modalities. Informs logistics planning, technology requirements, and attendance capacity management.. Valid values are `in_person|virtual|hybrid`',
    `end_timestamp` TIMESTAMP COMMENT 'The precise date and time at which the recruitment event concludes. Combined with start_timestamp to calculate event duration for ROI and counselor workload analysis.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'The planned or budgeted total cost (in USD) for executing this recruitment event, including venue rental, travel, materials, and staff time. Used for recruitment ROI analysis and budget planning. Compared against actual_cost post-event.',
    `event_date` DATE COMMENT 'The calendar date on which the recruitment event is scheduled to occur or did occur. Used for term-based recruitment cycle planning, territory scheduling, and yield management timelines.',
    `event_name` STRING COMMENT 'Human-readable title or name of the recruitment event as displayed to prospective students and staff (e.g., Fall Open House 2024, Engineering Campus Tour – October). Used in communications, reporting dashboards, and yield management analysis.',
    `event_status` STRING COMMENT 'Current lifecycle state of the recruitment event. Tracks the event from initial planning through execution and closure. draft indicates planning phase; published indicates open for registration; active indicates event is in progress; completed indicates event concluded; cancelled or postponed indicate event did not proceed as scheduled.. Valid values are `draft|published|active|completed|cancelled|postponed`',
    `event_type` STRING COMMENT 'Categorical classification of the recruitment event format. Drives yield management strategy, ROI analysis, and counselor workload reporting. [ENUM-REF-CANDIDATE: open_house|campus_tour|college_fair|virtual_info_session|high_school_visit|yield_event|admitted_student_day|graduate_info_session — promote to reference product if additional types are needed]. Valid values are `open_house|campus_tour|college_fair|virtual_info_session|high_school_visit|yield_event`',
    `is_registration_required` BOOLEAN COMMENT 'Indicates whether advance registration is required to attend this recruitment event. When True, attendance is tracked against registered_count and registration_capacity. When False, the event is open walk-in and capacity is managed differently.',
    `is_virtual_platform_recorded` BOOLEAN COMMENT 'Indicates whether a recording of the virtual or hybrid recruitment event is available for on-demand viewing by prospective students who could not attend live. Relevant only for virtual and hybrid delivery modes; supports asynchronous yield engagement.',
    `notes` STRING COMMENT 'Free-text field for admissions staff to capture operational notes, special instructions, or contextual information about the recruitment event that does not fit structured fields. Sourced from Slate CRM event record comments.',
    `program_focus` STRING COMMENT 'The specific academic program or field of study that this recruitment event is designed to promote (e.g., Computer Science, MBA, Nursing). May align to Classification of Instructional Programs (CIP) codes. Supports program-level yield analysis and enrollment pipeline reporting.',
    `registered_count` STRING COMMENT 'The total number of individuals who have registered for this recruitment event as of the last data refresh. Compared against registration_capacity to determine fill rate and waitlist trigger thresholds.',
    `registration_capacity` STRING COMMENT 'The maximum number of registrants (prospective students and guests) permitted to register for this recruitment event. Used for capacity planning, waitlist management, and yield optimization. Represents the planned upper bound set at event creation.',
    `registration_close_date` DATE COMMENT 'The date on which registration for this recruitment event closes. After this date, no new registrations are accepted unless the event allows walk-ins. Used for communications scheduling and final capacity management.',
    `registration_open_date` DATE COMMENT 'The date on which registration for this recruitment event opens to prospective students. Used to manage the registration window, trigger Slate CRM communications, and monitor early registration demand.',
    `staff_count` STRING COMMENT 'The total number of institutional staff members (admissions counselors, faculty, student ambassadors) assigned to support this recruitment event. Used for counselor workload management and event resource planning.',
    `start_timestamp` TIMESTAMP COMMENT 'The precise date and time at which the recruitment event begins. Used for scheduling, calendar integration, and counselor workload management. Stored in ISO 8601 format with timezone offset.',
    `target_audience` STRING COMMENT 'The primary prospective student population this event is designed to recruit. First-Time-In-Any-College (FTIAC) refers to first-year undergraduate prospects; transfer refers to students moving from another institution; graduate refers to post-baccalaureate prospects; international refers to non-domestic prospects. Drives yield management segmentation and ROI analysis by audience type.. Valid values are `ftiac|transfer|graduate|international|undecided`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this recruitment event record was most recently modified in the source system (Slate CRM). Serves as the RECORD_AUDIT_UPDATED field for change detection, incremental ETL processing, and audit compliance.',
    `venue_city` STRING COMMENT 'The city in which the recruitment event venue is located. Used for geographic territory analysis, travel cost tracking, and territory-based recruitment planning.',
    `venue_country` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code for the country where the recruitment event venue is located (e.g., USA, CAN, GBR). Supports international recruitment tracking and territory-based planning.. Valid values are `^[A-Z]{3}$`',
    `venue_name` STRING COMMENT 'The name of the physical or virtual venue where the recruitment event is held (e.g., University Student Union Ballroom, Chicago Marriott Downtown, Zoom Webinar). Used for logistics coordination and event reporting.',
    `venue_state_province` STRING COMMENT 'The two-letter US state or Canadian province code where the recruitment event venue is located (e.g., MI, IL, ON). Used for territory assignment, geographic yield analysis, and counselor territory mapping.. Valid values are `^[A-Z]{2}$`',
    `virtual_event_url` STRING COMMENT 'The web URL or meeting link for accessing the virtual or hybrid recruitment event. Distributed to registered attendees via Slate CRM communications. Applicable when delivery_mode is virtual or hybrid.',
    `virtual_platform` STRING COMMENT 'The technology platform used to host virtual or hybrid recruitment events (e.g., Zoom, Microsoft Teams, Webex). Applicable when delivery_mode is virtual or hybrid. Used for technology cost tracking and platform performance analysis.. Valid values are `zoom|teams|webex|youtube_live|other`',
    `waitlist_count` STRING COMMENT 'The number of prospective students currently on the waitlist for this recruitment event after registration capacity has been reached. Supports demand analysis and informs decisions to add additional event sessions.',
    CONSTRAINT pk_recruitment_event PRIMARY KEY(`recruitment_event_id`)
) COMMENT 'Master record for admissions recruitment events and the geographic territories they serve. Captures event type (open house, campus tour, college fair, virtual info session, high school visit), date, location, target audience (FTIAC, transfer, graduate), registration capacity, actual attendance, host staff, and territory context (territory name, geographic boundaries, assigned counselor). Sourced from Slate CRM Events module. Supports yield management, recruitment ROI analysis, territory-based recruitment planning, and counselor workload management.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`event_registration` (
    `event_registration_id` BIGINT COMMENT 'Unique surrogate identifier for each event registration record in the enrollment recruitment funnel. Primary key for the event_registration data product.',
    `employee_id` BIGINT COMMENT 'Reference to the admissions counselor or recruiter assigned to this prospect at the time of event registration. Used for counselor workload reporting, territory management, and follow-up accountability tracking.',
    `enrollment_application_id` BIGINT COMMENT 'Reference to the admissions application submitted by the prospect following event attendance. Null if no application has been submitted. Enables direct linkage between event participation and application conversion for yield modeling.',
    `recruitment_event_session_id` BIGINT COMMENT 'Reference to a specific session or breakout within a multi-session recruitment event (e.g., a campus open house with concurrent information sessions by college). Null for single-session events.',
    `prospect_id` BIGINT COMMENT 'Reference to the prospective student or applicant who registered for the recruitment event. Links to the prospect master record in the admissions CRM for funnel attribution and yield modeling.',
    `recruit_id` BIGINT COMMENT 'Foreign key linking to athletics.recruit. Business justification: NCAA limits official and unofficial campus visits by athletic recruits. When a prospect registers for a campus event and is also a recruit, this link enables compliance tracking of visit counts, ensur',
    `recruitment_event_id` BIGINT COMMENT 'Reference to the recruitment event for which this registration was created. Links to the event master record capturing event type, location, date, and capacity.',
    `academic_term_code` STRING COMMENT 'The academic term (e.g., FALL2025, SPRING2026) for which the prospect intends to enroll. Used to align recruitment event attendance with enrollment cycle planning and yield forecasting by term.',
    `accessibility_accommodation` STRING COMMENT 'Free-text or coded description of any accessibility or disability-related accommodations requested by the registrant for the event (e.g., wheelchair access, sign language interpreter, dietary restriction). Classified as confidential per ADA and institutional disability services policy.',
    `application_submitted_flag` BOOLEAN COMMENT 'Indicates whether the prospect submitted an application to the institution following attendance at this recruitment event. Key yield modeling indicator linking event attendance to application conversion in the admissions funnel.',
    `cancellation_date` DATE COMMENT 'The date on which the registrant cancelled their event registration. Null if the registration was not cancelled. Used to track cancellation lead time relative to the event date and to manage seat reallocation.',
    `cancellation_reason` STRING COMMENT 'Standardized reason provided by the registrant or staff for cancelling the event registration. Supports analysis of barriers to attendance and informs event scheduling and logistics improvements.. Valid values are `schedule_conflict|no_longer_interested|enrolled_elsewhere|transportation|illness|other`',
    `check_in_method` STRING COMMENT 'The mechanism by which the registrant checked in to the event. Supports operational analysis of check-in efficiency and technology adoption. Values: qr_code (scanned QR code), staff_manual (staff entered manually), self_service_kiosk (kiosk terminal), mobile_app (institution mobile app), online_virtual (virtual event login).. Valid values are `qr_code|staff_manual|self_service_kiosk|mobile_app|online_virtual`',
    `check_in_timestamp` TIMESTAMP COMMENT 'The date and time when the registrant physically or virtually checked in to the recruitment event. Null if the registrant did not attend. Distinct from registration_date; used to confirm actual attendance and calculate check-in lead time.',
    `communication_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the registrant consented to receive future recruitment communications from the institution at the time of event registration. Required for CAN-SPAM and GDPR compliance in outbound admissions marketing.',
    `consent_timestamp` TIMESTAMP COMMENT 'The date and time when the registrant provided or withdrew consent for recruitment communications. Required for GDPR and CAN-SPAM audit trails. Null if no explicit consent action was recorded.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the event registration record was first created in the system. Used for audit trail, data lineage, and registration velocity analysis. Aligns with FERPA record-keeping requirements.',
    `dietary_restriction` STRING COMMENT 'Dietary restriction or preference indicated by the registrant at the time of registration (e.g., vegetarian, vegan, halal, kosher, gluten-free). Used for catering planning at events that include meals or refreshments.',
    `first_generation_flag` BOOLEAN COMMENT 'Indicates whether the prospect self-identified as a first-generation college student (neither parent holds a bachelors degree). Used for targeted outreach, equity reporting, and Title IV program eligibility tracking.',
    `follow_up_date` DATE COMMENT 'The date on which the post-event follow-up communication was completed or is scheduled to be completed by the assigned admissions counselor. Used for counselor accountability and pipeline management reporting.',
    `follow_up_status` STRING COMMENT 'Status of the post-event follow-up action assigned to the admissions counselor for this registrant. Tracks whether outreach has been initiated, completed, or is not required (e.g., for no-shows who cancelled). Supports counselor workflow management.. Valid values are `pending|contacted|completed|not_required`',
    `ftiac_flag` BOOLEAN COMMENT 'Indicates whether the prospect is a First-Time-In-Any-College (FTIAC) student with no prior postsecondary enrollment. Critical for IPEDS cohort reporting, NCAA eligibility, and institutional retention benchmarking.',
    `guest_count` STRING COMMENT 'Number of additional guests (e.g., parents, guardians, siblings) registered to accompany the primary prospect at the event. Used for event capacity planning, catering, and logistics management.',
    `intended_degree_level` STRING COMMENT 'The degree level the prospect intends to pursue at the institution. Used to segment recruitment events by audience type and to route prospects to appropriate admissions counselors and follow-up workflows.. Valid values are `undergraduate|graduate|doctoral|professional|certificate|non_degree`',
    `intended_program_code` STRING COMMENT 'The Classification of Instructional Programs (CIP) code or institution-specific program code representing the academic program the prospect intends to pursue. Supports program-level yield analysis and targeted follow-up by academic unit.',
    `notes` STRING COMMENT 'Free-text notes entered by admissions staff regarding the registrants event participation, special circumstances, or follow-up actions. Classified as confidential per FERPA student record privacy requirements.',
    `registration_channel` STRING COMMENT 'The channel or interface through which the prospect submitted their event registration. Used for marketing attribution and channel effectiveness analysis. Values: web_portal (institution website), email_link (direct email campaign link), staff_entry (entered by admissions staff), mobile_app (institution mobile app), third_party_fair (college fair or external platform).. Valid values are `web_portal|email_link|staff_entry|mobile_app|third_party_fair`',
    `registration_date` TIMESTAMP COMMENT 'The exact date and time (with timezone offset) when the prospect or applicant submitted their registration for the recruitment event. Used for lead time analysis, registration velocity reporting, and funnel timing metrics.',
    `registration_number` STRING COMMENT 'Externally visible, human-readable confirmation number assigned to the registrant at the time of registration. Used in confirmation emails, check-in kiosks, and attendee communications. Format: REG-YYYY-NNNNNN.. Valid values are `^REG-[0-9]{4}-[0-9]{6}$`',
    `registration_source_code` STRING COMMENT 'Marketing or outreach source code associated with the registration, used to attribute the registrant to a specific campaign, communication, or recruitment initiative. Aligns with Slate CRM source tracking for yield modeling and ROI analysis.',
    `registration_status` STRING COMMENT 'Current lifecycle status of the event registration record. Drives funnel attribution, yield modeling, and post-event follow-up workflows. Values: registered (confirmed seat), attended (physically or virtually present), no_show (did not attend without cancellation), cancelled (registrant withdrew), waitlisted (capacity full, on waitlist), pending (registration submitted but not yet confirmed). [ENUM-REF-CANDIDATE: registered|attended|no_show|cancelled|waitlisted|pending — promote to reference product]. Valid values are `registered|attended|no_show|cancelled|waitlisted|pending`',
    `residency_type` STRING COMMENT 'Indicates whether the prospect is a domestic or international student. Drives routing to appropriate admissions teams, financial aid eligibility screening, and TOEFL/IELTS requirement flags. Relevant for IPEDS reporting and international enrollment tracking.. Valid values are `domestic|international`',
    `survey_response_date` DATE COMMENT 'The date on which the registrant submitted their post-event survey response. Null if no survey was completed. Used to measure response timeliness and correlate survey completion with subsequent application activity.',
    `survey_response_flag` BOOLEAN COMMENT 'Indicates whether the registrant completed a post-event satisfaction or feedback survey. Used to measure event engagement quality, calculate survey response rates, and identify prospects for follow-up outreach.',
    `survey_satisfaction_score` STRING COMMENT 'Numeric satisfaction rating provided by the registrant in the post-event survey, typically on a scale of 1–5 or 1–10 as defined by the institution. Null if no survey was completed. Used as a KPI for event quality and recruiter performance.',
    `transportation_assistance_flag` BOOLEAN COMMENT 'Indicates whether the registrant requested transportation assistance (e.g., shuttle service, bus coordination) to attend the event. Used for logistics planning and equity-focused recruitment program tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when the event registration record was most recently modified. Used for incremental ETL processing, change data capture, and audit trail compliance in the Databricks Lakehouse Silver Layer.',
    `virtual_attendance_flag` BOOLEAN COMMENT 'Indicates whether the registrant attended the event virtually (online) rather than in person. Supports hybrid event analytics, virtual engagement tracking, and geographic reach reporting.',
    `virtual_platform_session_code` STRING COMMENT 'The session or participant identifier assigned by the virtual event platform (e.g., Zoom, Teams, Hopin) for the registrants virtual attendance. Used to reconcile virtual check-in data with the CRM registration record.',
    `waitlist_position` STRING COMMENT 'Numeric position of the registrant on the event waitlist when the event has reached capacity. Null if the registrant is not on the waitlist. Used to manage seat releases and notify prospects when seats become available.',
    `yield_segment` STRING COMMENT 'Enrollment yield intent segment assigned to the registrant based on event engagement signals, survey responses, and CRM scoring models. Used by admissions leadership for targeted yield intervention strategies and enrollment forecasting.. Valid values are `high_intent|medium_intent|low_intent|unknown`',
    CONSTRAINT pk_event_registration PRIMARY KEY(`event_registration_id`)
) COMMENT 'Transactional record of a prospect or applicant registering for and attending a recruitment event. Captures registration date, attendance status (registered, attended, no-show, cancelled), check-in method, and post-event survey response flag. Links prospects and applicants to recruitment events for funnel attribution and yield modeling.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`communication_activity` (
    `communication_activity_id` BIGINT COMMENT 'Unique surrogate identifier for each communication activity record in the admissions enrollment funnel. Primary key for this transactional log entity.',
    `campaign_id` BIGINT COMMENT 'Reference to the enrollment marketing or yield management campaign under which this communication was sent. Null for ad-hoc or individually initiated communications.',
    `employee_id` BIGINT COMMENT 'Reference to the admissions staff member or recruiter who initiated or is responsible for this communication. Null for fully automated system-generated communications.',
    `enrollment_application_id` BIGINT COMMENT 'Reference to the admissions application associated with this communication, if applicable. Null for communications with prospects who have not yet submitted an application.',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Communications are delivered through enterprise applications (Slate CRM, Salesforce, email platforms, SMS gateways, chatbots). Tracking which application sent each communication is essential for deliv',
    `principal_investigator_id` BIGINT COMMENT 'Foreign key linking to research.principal_investigator. Business justification: Faculty PIs conduct direct recruitment outreach to prospective graduate students. Tracks PI-initiated communications for recruitment attribution, faculty engagement metrics, and yield analysis by rese',
    `prospect_id` BIGINT COMMENT 'Reference to the prospect or applicant who is the recipient or sender of this communication. Links to the prospect/applicant master record in the enrollment domain.',
    `recruit_id` BIGINT COMMENT 'Foreign key linking to athletics.recruit. Business justification: NCAA recruiting rules require tracking all institutional contacts with athletic recruits (phone, email, text) to enforce permissible contact periods and frequency limits. When a prospect is also a rec',
    `recruitment_event_id` BIGINT COMMENT 'Foreign key linking to enrollment.recruitment_event. Business justification: Communications can be event-related (invitations, reminders, follow-ups). This FK links communications to the specific recruitment event they support, enabling event-based communication tracking and c',
    `academic_period` STRING COMMENT 'The academic term or entry period for which the prospect is being recruited (e.g., Fall 2025, Spring 2026). Supports term-based enrollment cycle reporting and yield analysis.',
    `academic_year` STRING COMMENT 'The academic year associated with the enrollment cycle for which this communication was generated (e.g., 2024-2025). Supports year-over-year enrollment funnel benchmarking.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `bounce_type` STRING COMMENT 'Classifies the type of email bounce if the communication failed to deliver. Hard bounce indicates a permanent delivery failure (invalid address); soft bounce indicates a temporary failure. Null or none for non-email channels or successful deliveries.. Valid values are `hard|soft|none`',
    `click_count` STRING COMMENT 'The total number of link clicks recorded for this communication by the prospect. Applicable to email and portal message channels. Supports engagement depth analysis beyond the binary is_clicked flag.',
    `clicked_timestamp` TIMESTAMP COMMENT 'The date and time when the prospect first clicked a link within the communication (applicable to email and portal messages). Null if no click was recorded or channel does not support click tracking.',
    `communication_notes` STRING COMMENT 'Free-text notes entered by the admissions staff member regarding the content or outcome of this communication. Applicable primarily to phone calls and in-person interactions. Classified as confidential per FERPA student record privacy requirements.',
    `communication_purpose` STRING COMMENT 'The business purpose or intent of the communication within the enrollment funnel. Classifies communications by their role in the recruitment-to-matriculation lifecycle. [ENUM-REF-CANDIDATE: inquiry_response|application_status|decision_notification|yield_nurture|financial_aid_info|event_invitation|document_request|general_outreach — promote to reference product]',
    `communication_type` STRING COMMENT 'The channel or medium through which the communication was delivered or received. Drives channel-specific analytics and yield management reporting across the enrollment funnel.. Valid values are `email|sms|phone|mail|portal_message|chat`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this communication activity record was first created in the system. Used for audit trail and data lineage tracking in the Silver layer lakehouse.',
    `degree_level` STRING COMMENT 'The level of the degree program the prospect is pursuing (e.g., undergraduate, graduate). Enables segmentation of communication analytics by degree level for enrollment planning.. Valid values are `undergraduate|graduate|doctoral|professional|certificate`',
    `delivered_timestamp` TIMESTAMP COMMENT 'The date and time when the communication was confirmed as delivered to the recipients inbox, device, or mailbox. Null if delivery has not been confirmed or failed.',
    `delivery_status` STRING COMMENT 'Current delivery status of the outbound communication. Tracks whether the message was successfully delivered to the recipients channel endpoint. Inbound communications default to delivered.. Valid values are `sent|delivered|failed|bounced|pending|cancelled`',
    `direction` STRING COMMENT 'Indicates whether the communication was sent by the institution to the prospect/applicant (outbound) or received from the prospect/applicant (inbound). Critical for funnel engagement analysis.. Valid values are `outbound|inbound`',
    `enrollment_stage` STRING COMMENT 'The stage of the enrollment funnel at which the prospect was positioned when this communication was sent or received. Enables funnel-stage-specific engagement analytics and yield management reporting. [ENUM-REF-CANDIDATE: prospect|inquiry|applicant|admitted|deposited|enrolled|withdrawn — 7 candidates stripped; promote to reference product]',
    `ferpa_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this communication involved the disclosure of student education records subject to FERPA protections. Required for institutional FERPA compliance audit and reporting to the U.S. Department of Education.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether this communication was generated and sent automatically by the Slate CRM workflow engine (True) or was manually initiated by a staff member (False). Supports automation rate reporting.',
    `is_clicked` BOOLEAN COMMENT 'Boolean flag indicating whether the prospect clicked at least one link within this communication. Applicable to email and portal messages. Supports click-through rate KPI for yield management.',
    `is_opened` BOOLEAN COMMENT 'Boolean flag indicating whether the prospect opened or viewed this communication. Applicable to email and portal message channels. Supports open rate KPI calculation for enrollment campaigns.',
    `is_responded` BOOLEAN COMMENT 'Boolean flag indicating whether the prospect replied to or responded to this communication. Supports response rate analytics across channels and enrollment funnel stages.',
    `mail_piece_type` STRING COMMENT 'The type of physical mail piece sent to the prospect, applicable when communication_type is mail. Supports direct mail campaign cost and response rate analysis.. Valid values are `viewbook|letter|postcard|package|brochure|other`',
    `open_count` STRING COMMENT 'The total number of times this communication was opened or viewed by the prospect. Applicable to email and portal messages. Supports engagement frequency analysis for yield management.',
    `opened_timestamp` TIMESTAMP COMMENT 'The date and time when the prospect first opened or viewed the communication (applicable to email and portal messages). Null if not opened or channel does not support open tracking.',
    `opt_out_flag` BOOLEAN COMMENT 'Indicates whether this communication triggered an opt-out or unsubscribe action by the prospect. Critical for CAN-SPAM, TCPA, and institutional communication preference compliance.',
    `opt_out_timestamp` TIMESTAMP COMMENT 'The date and time when the prospect opted out of communications following this activity. Null if no opt-out was recorded. Required for CAN-SPAM and TCPA compliance audit trails.',
    `phone_call_duration_sec` STRING COMMENT 'Duration of the phone call in seconds, applicable only when communication_type is phone. Null for non-phone channels. Supports recruiter productivity and engagement quality analysis.',
    `phone_call_outcome` STRING COMMENT 'The outcome of a phone call communication attempt. Applicable only when communication_type is phone. Supports recruiter call effectiveness reporting and follow-up workflow triggers.. Valid values are `connected|voicemail|no_answer|busy|wrong_number`',
    `program_of_interest` STRING COMMENT 'The academic program or degree program the prospect is interested in at the time of this communication. Supports program-level yield analysis and targeted recruitment strategy.',
    `prospect_geographic_region` STRING COMMENT 'The geographic region or state of the prospect at the time of this communication. Supports regional enrollment funnel analytics and targeted recruitment strategy reporting.',
    `recruiter_territory` STRING COMMENT 'The geographic or market territory assigned to the recruiter or admissions counselor who initiated this communication. Supports territory-based enrollment funnel performance reporting.',
    `responded_timestamp` TIMESTAMP COMMENT 'The date and time when the prospect replied to or responded to this communication. Applicable to email, phone, and portal message channels. Null if no response was recorded.',
    `scheduled_send_date` DATE COMMENT 'The date on which this communication was scheduled to be sent as part of a campaign workflow or drip sequence. Null for immediately dispatched or inbound communications. Supports campaign scheduling analysis.',
    `sent_timestamp` TIMESTAMP COMMENT 'The date and time when the communication was dispatched from the institutions system or received from the prospect. Represents the principal business event time for this transaction log record.',
    `slate_activity_ref` STRING COMMENT 'The native activity or communication record identifier from Slate CRM, used for cross-system reconciliation and audit traceability back to the source system of record.',
    `source_system` STRING COMMENT 'The operational system of record from which this communication activity record originated. Supports data lineage and cross-system reconciliation in the Silver layer lakehouse.. Valid values are `slate|banner|manual|other`',
    `subject_line` STRING COMMENT 'The subject line of the email or portal message, or a brief descriptive title for other communication types (e.g., phone call topic, mail piece title). Supports content performance analysis.',
    `template_code` STRING COMMENT 'The identifier or code of the Slate CRM communication template used to generate this message. Enables template performance analysis and A/B testing across enrollment campaigns.',
    `template_name` STRING COMMENT 'The human-readable name of the communication template used. Supports reporting and yield management analysis without requiring a join to the template reference table.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this communication activity record was last modified. Tracks status updates, delivery confirmations, and engagement flag changes.',
    CONSTRAINT pk_communication_activity PRIMARY KEY(`communication_activity_id`)
) COMMENT 'Transactional log of all admissions-related outbound and inbound communications with prospects and applicants, sourced from Slate CRM. Captures communication type (email, SMS, phone, mail, portal message), direction, campaign or template used, delivery status, open/click flags, and staff initiator. Supports enrollment funnel nurturing and yield management workflows.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`deposit` (
    `deposit_id` BIGINT COMMENT 'Unique surrogate identifier for each enrollment deposit record. Primary key for the enrollment_deposit data product in the Databricks Silver Layer.',
    `admission_offer_id` BIGINT COMMENT 'Foreign key linking to enrollment.admission_offer. Business justification: Enrollment deposit is paid in response to a specific admission offer. This FK links the deposit to the offer it accepts, enabling tracking of offer-to-deposit conversion and deposit reconciliation aga',
    `enrollment_application_id` BIGINT COMMENT 'Reference to the admissions application for which this enrollment deposit was submitted. Links the deposit to the admitted students application record, enforcing the one-deposit-per-application-per-deposit-type constraint.',
    `profile_id` BIGINT COMMENT 'Reference to the student (admitted applicant) who submitted the enrollment deposit. Used for yield management reporting and matriculation tracking.',
    `term_id` BIGINT COMMENT 'Reference to the academic term for which the student is confirming enrollment intent via this deposit. Supports term-based yield and enrollment cycle analysis.',
    `academic_level` STRING COMMENT 'Level of study for which the enrollment deposit was submitted. Used for yield segmentation, financial aid eligibility determination, and IPEDS enrollment level reporting.. Valid values are `undergraduate|graduate|doctoral|professional|certificate`',
    `academic_program_code` STRING COMMENT 'Code identifying the academic program (degree program) for which the student submitted the enrollment deposit. Supports program-level yield analysis and capacity planning. Aligns with CIP (Classification of Instructional Programs) coding.',
    `admit_type` STRING COMMENT 'Classification of the admitted students entry type at the time of deposit. Supports yield analysis segmented by admit cohort (e.g., FTIAC freshman vs. transfer vs. graduate). Aligns with IPEDS enrollment reporting categories.. Valid values are `freshman|transfer|graduate|readmit|international|non_degree`',
    `amount` DECIMAL(18,2) COMMENT 'Gross monetary amount of the enrollment deposit required or assessed, expressed in the institutional operating currency (USD). Represents the full deposit obligation before any waivers or adjustments.',
    `amount_paid` DECIMAL(18,2) COMMENT 'Actual monetary amount received from the student for this deposit. May differ from deposit_amount in cases of partial payment, waiver, or institutional adjustment. Used for cash reconciliation and student account posting.',
    `college_code` STRING COMMENT 'Code identifying the college or school within the university to which the student was admitted and for which the deposit was submitted (e.g., College of Engineering, College of Business). Supports college-level yield and enrollment reporting.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the students country of citizenship or permanent residence. Used for international student yield analysis, visa compliance tracking, and IPEDS international enrollment reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment deposit record was first created in the data platform (Silver Layer). Represents the audit creation time, distinct from payment_date (the business event date). Supports data lineage and audit trail requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the deposit transaction (e.g., USD, CAD, GBP). Supports international student deposit processing and multi-currency reconciliation.. Valid values are `^[A-Z]{3}$`',
    `deadline` DATE COMMENT 'Institutional deadline by which the admitted student must submit the enrollment deposit to confirm matriculation intent. Used for yield management, deadline compliance monitoring, and National Candidates Reply Date (May 1) tracking per NACAC guidelines.',
    `deposit_number` STRING COMMENT 'Externally visible, human-readable business identifier for the deposit transaction, used in student-facing communications, receipts, and reconciliation with the student accounts system in Ellucian Banner.. Valid values are `^DEP-[0-9]{8,12}$`',
    `deposit_status` STRING COMMENT 'Current lifecycle state of the enrollment deposit. pending indicates payment initiated but not yet confirmed; received indicates payment received but not yet cleared; cleared indicates funds confirmed; refunded indicates deposit returned to student; waived indicates deposit requirement formally waived; cancelled indicates deposit voided.. Valid values are `pending|received|cleared|refunded|waived|cancelled`',
    `deposit_type` STRING COMMENT 'Categorizes the purpose of the deposit. Common types include tuition (confirms academic enrollment intent), housing (reserves on-campus housing), and orientation (reserves orientation seat). One record per admitted application per deposit type. [ENUM-REF-CANDIDATE: tuition|housing|orientation|health|parking|other — promote to reference product]. Valid values are `tuition|housing|orientation|health|parking|other`',
    `financial_aid_applicant` BOOLEAN COMMENT 'Indicates whether the student has submitted a FAFSA (Free Application for Federal Student Aid) or institutional financial aid application. Used to contextualize deposit waiver decisions and yield analysis by financial aid status.',
    `first_generation_student` BOOLEAN COMMENT 'Indicates whether the student is a first-generation college student (neither parent holds a bachelors degree). Used for equity-focused yield analysis, Title III/IV reporting, and institutional diversity metrics.',
    `geographic_origin` STRING COMMENT 'Two-letter U.S. state code (or equivalent geographic origin code) of the students permanent address at time of deposit. Used for in-state vs. out-of-state yield analysis, tuition classification, and IPEDS geographic distribution reporting.. Valid values are `^[A-Z]{2}$`',
    `housing_preference` STRING COMMENT 'Students stated housing preference at the time of deposit submission. Relevant when deposit_type includes housing. Used by Facilities/Housing management (Archibus) for capacity planning and room assignment.. Valid values are `on_campus|off_campus|undecided`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this enrollment deposit record is the current active version. Supports soft-delete patterns and SCD (Slowly Changing Dimension) Type 2 history management in the Databricks Silver Layer without physical deletion.',
    `is_refunded` BOOLEAN COMMENT 'Indicates whether the enrollment deposit has been refunded to the student. True when a refund has been issued. Used for yield management, financial reconciliation, and melt (deposit-to-enrollment attrition) analysis.',
    `is_waived` BOOLEAN COMMENT 'Indicates whether the enrollment deposit requirement was formally waived for this student. True when the institution has granted a waiver, allowing the student to confirm enrollment without payment. Critical for financial aid equity reporting and yield analysis.',
    `matriculation_confirmed` BOOLEAN COMMENT 'Indicates whether the student ultimately matriculated (enrolled) at the institution following submission of this deposit. True when the student completed registration for the target term. Key yield management KPI linking deposit to actual enrollment.',
    `matriculation_date` DATE COMMENT 'Date on which the student officially matriculated (first registered for courses) for the target term. Populated when matriculation_confirmed is True. Used for enrollment reporting, IPEDS census date calculations, and FTIAC tracking.',
    `notes` STRING COMMENT 'Free-text field for admissions or student accounts staff to record contextual notes about the deposit transaction (e.g., special payment arrangements, exception approvals, follow-up actions). Not used for structured reporting.',
    `payment_channel` STRING COMMENT 'Interface or channel through which the deposit payment was submitted (e.g., online student portal, in-person at bursars office, mailed check). Distinct from payment_method; supports channel-level yield and operational analytics.. Valid values are `online_portal|in_person|mail|phone|third_party`',
    `payment_date` DATE COMMENT 'Calendar date on which the enrollment deposit payment was received or processed by the institution. Used as the principal business event date for yield management reporting, deadline compliance tracking, and IPEDS enrollment reporting.',
    `payment_method` STRING COMMENT 'Instrument used by the student to submit the enrollment deposit. Supports reconciliation, fraud monitoring, and payment channel analytics. [ENUM-REF-CANDIDATE: credit_card|debit_card|check|wire_transfer|ach|cash|money_order — promote to reference product]',
    `payment_reference_number` STRING COMMENT 'External transaction reference number returned by the payment processor, bank, or check number provided by the student. Used for payment reconciliation, dispute resolution, and audit trail with the financial system (Oracle PeopleSoft Financials AR).',
    `recruitment_source` STRING COMMENT 'Source or channel through which the student was originally recruited or first engaged with the institution (e.g., college fair, direct mail, digital campaign, high school visit). Sourced from Slate CRM. Used for ROI analysis of recruitment investments and yield by source.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Monetary amount refunded to the student. May equal amount_paid (full refund) or be less (partial refund per institutional policy). Used for financial reconciliation and student account adjustments in Ellucian Banner.',
    `refund_date` DATE COMMENT 'Calendar date on which the enrollment deposit refund was issued to the student. Populated only when is_refunded is True. Used for refund timeline compliance and cash flow reporting.',
    `refund_reason` STRING COMMENT 'Reason code explaining why the enrollment deposit was refunded. Supports melt analysis, yield management, and institutional policy compliance reporting.. Valid values are `student_withdrew|admission_rescinded|duplicate_payment|institutional_error|other`',
    `scholarship_recipient` BOOLEAN COMMENT 'Indicates whether the student has been awarded an institutional scholarship at the time of deposit. Used to analyze the relationship between merit/need-based aid awards and deposit yield rates.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this deposit record originated (e.g., Ellucian Banner Student Accounts, Slate CRM, TouchNet payment gateway). Supports data lineage and ETL reconciliation in the Databricks Silver Layer.. Valid values are `banner|slate|touchnet|nelnet|cashnet|manual`',
    `source_system_record_code` STRING COMMENT 'The native primary key or record identifier of this deposit in the originating operational system (e.g., Banner SPRIDEN PIDM-based transaction ID, TouchNet payment ID). Enables traceability from the Silver Layer back to the system of record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment deposit record was last modified in the data platform. Used for incremental ETL processing, change data capture, and audit trail maintenance in the Databricks Silver Layer.',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the institutional staff member or office that authorized the deposit waiver. Supports audit trail and compliance review for waiver decisions.',
    `waiver_reason` STRING COMMENT 'Reason code explaining why the enrollment deposit was waived. Populated only when is_waived is True. Supports equity reporting, financial aid compliance, and institutional policy analysis. [ENUM-REF-CANDIDATE: financial_hardship|full_scholarship|athletic_scholarship|staff_dependent|veterans_benefit|institutional_policy|other — promote to reference product]',
    CONSTRAINT pk_deposit PRIMARY KEY(`deposit_id`)
) COMMENT 'Transactional record of an enrollment deposit (intent-to-enroll payment) submitted by an admitted student to confirm matriculation intent. Captures deposit amount, payment date, payment method (credit card, check, wire), deposit type (tuition, housing), waiver flag, waiver reason, refund status, and refund date. Critical yield management indicator linking the admission decision to confirmed matriculation. One deposit record per admitted application per deposit type.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`matriculation` (
    `matriculation_id` BIGINT COMMENT 'Unique surrogate identifier for each matriculation record in the Databricks Silver Layer. Primary key for the matriculation data product within the enrollment domain.',
    `admission_offer_id` BIGINT COMMENT 'Foreign key linking to enrollment.admission_offer. Business justification: Matriculation is the result of accepting an admission offer. This FK links matriculation to the offer that was accepted, enabling offer-to-matriculation tracking and yield analysis. Note: matriculatio',
    `aid_application_id` BIGINT COMMENT 'Foreign key linking to aid.aid_application. Business justification: Matriculated students have aid applications on file. Links enrollment confirmation to aid eligibility verification. Operational for Title IV enrollment reporting, COD roster reconciliation, and first-',
    `campus_id` BIGINT COMMENT 'Foreign key linking to facility.campus. Business justification: Matriculated students are assigned to specific campus for their program. Student services, orientation planning, IPEDS reporting, and enrollment management all require campus assignment. Campus_code s',
    `deposit_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_deposit. Business justification: Matriculation is triggered by enrollment deposit payment. This FK links matriculation to the deposit that confirmed enrollment intent, enabling tracking of deposit-to-matriculation workflow and ensuri',
    `instructor_id` BIGINT COMMENT 'Reference to the faculty or professional academic advisor assigned to the student at the time of matriculation. Supports advising caseload management, early alert systems, and retention intervention tracking.',
    `profile_id` BIGINT COMMENT 'Reference to the student master record created upon matriculation. Represents the Banner student ID assigned at the point of matriculation, serving as the primary identifier in the Student Information System (SIS) for all downstream enrollment, academic, and financial aid transactions.',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Students matriculating on research assistantships are funded by specific grants. Required for award expenditure tracking, effort certification, student stipend charging, and sponsor reporting of train',
    `student_athlete_id` BIGINT COMMENT 'Foreign key linking to athletics.student_athlete. Business justification: Matriculation records must flag athletic recruitment status for Title IX reporting, EADA compliance, and athletic financial aid coordination. When a matriculating student is a recruited athlete, this ',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: Matriculation occurs in a specific academic term. Currently matriculation has term_code as a STRING but no FK to term. Adding term_id FK normalizes the term reference and enables proper term-based mat',
    `academic_standing` STRING COMMENT 'The students academic standing classification at the point of matriculation. For new students this is typically new-student; for readmits it reflects the standing reinstated. Drives advising interventions and financial aid Satisfactory Academic Progress (SAP) determinations.. Valid values are `good-standing|probation|suspension|dismissed|new-student`',
    `admit_date` DATE COMMENT 'The date on which the admissions decision was rendered and communicated to the student. Carried forward from the admissions record to support time-to-matriculation analytics and yield funnel reporting.',
    `admit_type` STRING COMMENT 'The admissions decision pathway through which the student was admitted prior to matriculation (e.g., regular decision, early action, early decision, rolling admission, transfer). Carried forward from the admissions record for cohort analytics and yield reporting.. Valid values are `regular|early-action|early-decision|rolling|transfer|readmit`',
    `cip_code` STRING COMMENT 'The six-digit CIP (Classification of Instructional Programs) code assigned to the students program at matriculation, formatted as XX.XXXX (e.g., 11.0701 for Computer Science). Required for IPEDS federal reporting and accreditation submissions.. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `cohort_code` STRING COMMENT 'Institutional cohort identifier assigned at matriculation, typically combining entry level and term (e.g., FTIAC-FA2025, TRANSFER-SP2025). Used for longitudinal retention, graduation rate, and outcome tracking per IPEDS cohort methodology.',
    `college_code` STRING COMMENT 'Institutional code for the college or school within the university to which the students program belongs at matriculation (e.g., ENGR for College of Engineering, BUS for School of Business). Used for organizational reporting and accreditation unit tracking (AACSB, ABET).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this matriculation record was first created in the system of record (Ellucian Banner). Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX per institutional data standards. Required for audit trail and data lineage in the Silver Layer.',
    `degree_type` STRING COMMENT 'The type of credential the student is pursuing at matriculation (e.g., BA, BS, MBA, PhD, certificate). Used for tuition rate assignment, financial aid eligibility, and IPEDS award level reporting. [ENUM-REF-CANDIDATE: AA|AS|AAS|BA|BS|BFA|MA|MS|MBA|MFA|PhD|EdD|JD|MD|certificate|non-degree — promote to reference product]',
    `department_code` STRING COMMENT 'Institutional code for the academic department responsible for the students program at matriculation. Used for faculty advising assignment, departmental enrollment reporting, and resource allocation.',
    `deposit_date` DATE COMMENT 'The date on which the students enrollment deposit was received and posted. Used for yield management analytics, revenue forecasting, and admissions funnel reporting in Slate CRM and Tableau/Power BI dashboards.',
    `deposit_paid_flag` BOOLEAN COMMENT 'Indicates whether the student paid the required enrollment deposit prior to matriculation. True = deposit received. The enrollment deposit is a prerequisite for matriculation and confirms the students intent to enroll. Sourced from Ellucian Banner Student Accounts.',
    `enrollment_status` STRING COMMENT 'The students enrollment intensity at the time of matriculation, based on credit hour load thresholds (full-time, half-time, less-than-half-time). Drives Full-Time Equivalent (FTE) calculations, financial aid Satisfactory Academic Progress (SAP) determinations, and IPEDS enrollment reporting.. Valid values are `full-time|half-time|less-than-half-time|not-enrolled`',
    `entry_level` STRING COMMENT 'Classification of the students entry point into the institution at the time of matriculation. Drives IPEDS cohort classification, financial aid eligibility, and academic advising assignment. [ENUM-REF-CANDIDATE: freshman|transfer|graduate|doctoral|professional|readmit|post-baccalaureate — promote to reference product]. Valid values are `freshman|transfer|graduate|doctoral|professional|readmit`',
    `financial_aid_applicant_flag` BOOLEAN COMMENT 'Indicates whether the student submitted a FAFSA (Free Application for Federal Student Aid) for the matriculation term. True = FAFSA filed. Used to trigger financial aid packaging workflows in Ellucian Banner Financial Aid and for Title IV compliance reporting.',
    `first_generation_flag` BOOLEAN COMMENT 'Indicates whether the student is a first-generation college student (neither parent holds a bachelors degree) at the time of matriculation. True = first-generation. Used for targeted support program eligibility, Title III/V grant reporting, and equity analytics.',
    `ftiac_flag` BOOLEAN COMMENT 'Indicates whether the student is a First-Time-In-Any-College (FTIAC) student at the time of matriculation. FTIAC students form the primary IPEDS cohort for graduation rate and retention rate reporting. True = FTIAC; False = not FTIAC (transfer, readmit, etc.).',
    `housing_intent` STRING COMMENT 'The students stated housing intention at the time of matriculation (on-campus residence hall, off-campus, commuter). Used for residence life planning, facilities capacity management via Archibus, and IPEDS on-campus housing reporting.. Valid values are `on-campus|off-campus|commuter|unknown`',
    `instructional_method` STRING COMMENT 'Primary mode of instruction for the students program at matriculation (in-person, online, hybrid, blended, correspondence). Required for IPEDS distance education reporting and Title IV financial aid eligibility determination.. Valid values are `in-person|online|hybrid|blended|correspondence`',
    `international_flag` BOOLEAN COMMENT 'Indicates whether the student is an international (non-domestic) student at the time of matriculation. True = international student. Drives visa compliance tracking, SEVIS reporting requirements, and differential tuition rate application.',
    `matriculation_date` DATE COMMENT 'The specific calendar date on which the student formally matriculated and transitioned from admitted applicant to enrolled student. Used for cohort tracking, retention analysis, and IPEDS reporting. Distinct from the term start date.',
    `matriculation_status` STRING COMMENT 'Current lifecycle status of the matriculation record. Active indicates the student is enrolled; cancelled indicates the matriculation was reversed; deferred indicates the student requested a term deferral post-matriculation; withdrawn indicates the student withdrew after matriculating.. Valid values are `active|cancelled|deferred|withdrawn|deceased`',
    `orientation_date` DATE COMMENT 'The date on which the student completed new student orientation. Null if orientation has not yet been completed or was waived. Used for first-year experience analytics and enrollment readiness reporting.',
    `orientation_status` STRING COMMENT 'The students orientation registration and completion status at the time of matriculation. Tracks whether the student has registered for, completed, or been waived from mandatory new student orientation. Required for enrollment holds management and first-year experience reporting.. Valid values are `registered|completed|waived|not-required|pending`',
    `person_uid` BIGINT COMMENT 'Institution-assigned universal person identifier (PIDM in Ellucian Banner) that persists across all roles a person may hold (applicant, student, employee, alumni). Restricted PII as it directly identifies an individual across institutional systems.',
    `prior_institution_code` STRING COMMENT 'The IPEDS Unit ID or FICE (Federal Interagency Committee on Education) code of the most recent prior institution attended by transfer students. Null for FTIAC students. Used for articulation agreement analysis and transfer pathway reporting.',
    `program_code` STRING COMMENT 'The institutional code of the degree program confirmed at matriculation (e.g., BS-CS, MBA, PHD-CHEM). Represents the program the student is formally enrolled in as of matriculation. Aligns with CIP (Classification of Instructional Programs) coding for federal reporting.',
    `program_name` STRING COMMENT 'Human-readable name of the degree program confirmed at matriculation (e.g., Bachelor of Science in Computer Science, Master of Business Administration). Stored for reporting and display purposes independent of the program code.',
    `residency_status` STRING COMMENT 'The students tuition residency classification at the time of matriculation (in-state, out-of-state, international, military). Determines applicable tuition rate schedule and financial aid eligibility. Established through the residency determination process.. Valid values are `in-state|out-of-state|international|military|unknown`',
    `source_system` STRING COMMENT 'The operational system of record from which this matriculation record was sourced (e.g., Banner, Slate, Manual entry). Supports data lineage tracking in the Databricks Silver Layer ETL pipeline and audit trail requirements.. Valid values are `Banner|Slate|Manual|Migration|Other`',
    `stem_flag` BOOLEAN COMMENT 'Indicates whether the students program at matriculation is classified as a STEM (Science, Technology, Engineering, Mathematics) program per the U.S. Department of Homeland Security STEM OPT designated degree program list. True = STEM program. Relevant for international student visa extensions and NSF/NIH grant reporting.',
    `student_level` STRING COMMENT 'Broad academic level of the student at matriculation (undergraduate, graduate, professional, non-degree). Distinct from entry_level; used for tuition rate determination, financial aid packaging, and accreditation reporting.. Valid values are `undergraduate|graduate|professional|non-degree`',
    `transfer_credits_accepted` STRING COMMENT 'The number of transfer credit hours officially accepted and posted to the students academic record at the time of matriculation. Applicable to transfer and readmit students. Impacts degree completion timeline and financial aid credit hour tracking.',
    `transfer_flag` BOOLEAN COMMENT 'Indicates whether the student transferred from another institution prior to matriculation. True = transfer student. Used for IPEDS transfer cohort reporting, articulation agreement analysis, and transfer credit evaluation tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this matriculation record was most recently modified in the system of record. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for incremental ETL processing in the Databricks Silver Layer and change data capture (CDC) workflows.',
    `veteran_flag` BOOLEAN COMMENT 'Indicates whether the student is a veteran or military-affiliated student (active duty, reservist, dependent) at the time of matriculation. True = veteran/military-affiliated. Triggers VA benefits processing, Yellow Ribbon Program eligibility, and dedicated advising services.',
    `visa_type` STRING COMMENT 'The visa classification of the student at the time of matriculation, applicable to international students (e.g., F-1 student visa, J-1 exchange visitor). Required for SEVIS compliance reporting and financial aid eligibility determination. Null for domestic students. [ENUM-REF-CANDIDATE: F-1|J-1|M-1|H-1B|OPT|CPT|domestic|permanent-resident|other — promote to reference product]',
    CONSTRAINT pk_matriculation PRIMARY KEY(`matriculation_id`)
) COMMENT 'Transactional record marking the formal transition of an admitted and deposited applicant into an enrolled student. Captures matriculation term, matriculation date, entry level (freshman, transfer, graduate), program confirmed, orientation registration status, and the Banner student ID assigned upon matriculation. Serves as the handoff record from the admission domain to the student and enrollment domains.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`waitlist` (
    `waitlist_id` BIGINT COMMENT 'Unique surrogate identifier for each admissions waitlist record. Primary key for the waitlist data product in the enrollment domain.',
    `academic_program_id` BIGINT COMMENT 'Reference to the academic program (degree, certificate, or credential) for which the applicant is waitlisted. Supports capacity management by program.',
    `admission_decision_id` BIGINT COMMENT 'Foreign key linking to enrollment.admission_decision. Business justification: Admissions waitlist entry is created as the result of a waitlist admission decision. This FK links the waitlist record to the decision that placed the applicant on the waitlist, enabling tracking of d',
    `department_org_unit_id` BIGINT COMMENT 'Reference to the academic department responsible for the program for which the applicant is waitlisted. Enables department-level waitlist reporting and capacity oversight.',
    `employee_id` BIGINT COMMENT 'Reference to the admissions counselor or recruiter assigned to manage this waitlist record and communicate with the applicant. Supports workload tracking and relationship management in Slate CRM.',
    `enrollment_applicant_id` BIGINT COMMENT 'Reference to the applicant who has been placed on the admissions waitlist. Links to the applicant master record in the Student Information System.',
    `enrollment_application_id` BIGINT COMMENT 'Reference to the specific admissions application associated with this waitlist placement. An applicant may have multiple applications across terms or programs.',
    `org_unit_id` BIGINT COMMENT 'Reference to the college or school within the institution that administers the program for which the applicant is waitlisted (e.g., College of Engineering, College of Business). Supports college-level capacity management.',
    `term_id` BIGINT COMMENT 'Reference to the academic entry term for which the applicant is waitlisted (e.g., Fall 2025, Spring 2026). Drives term-based enrollment cycle management.',
    `academic_level` STRING COMMENT 'Level of study for which the applicant is waitlisted. Drives admissions workflow routing, capacity pool segmentation, and IPEDS reporting. Valid values: undergraduate, graduate, doctoral, professional, certificate.. Valid values are `undergraduate|graduate|doctoral|professional|certificate`',
    `applicant_response` STRING COMMENT 'Applicants response to the waitlist placement notification indicating whether they wish to remain on the waitlist. Valid values: accepted (applicant confirmed intent to remain), declined (applicant declined waitlist placement), no_response (no response received by deadline).. Valid values are `accepted|declined|no_response`',
    `applicant_response_date` DATE COMMENT 'Date on which the applicant submitted their response (accept or decline) to the waitlist placement offer. Null if no response has been received.',
    `capacity_pool_size` STRING COMMENT 'Total number of seats available in the waitlist pool for the program and entry term at the time of this records creation. Used in yield contingency planning to determine how many waitlisted applicants may be admitted.',
    `cip_code` STRING COMMENT 'Six-digit CIP code assigned to the academic program for which the applicant is waitlisted. Used for IPEDS reporting, accreditation documentation, and program-level enrollment analytics.. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `citizenship_status` STRING COMMENT 'Applicants citizenship classification relevant to admissions processing, financial aid eligibility, and IPEDS reporting. Valid values: us_citizen, permanent_resident, international, daca, unknown. [ENUM-REF-CANDIDATE: us_citizen|permanent_resident|international|daca|unknown — promote to reference product]. Valid values are `us_citizen|permanent_resident|international|daca|unknown`',
    `communication_preference` STRING COMMENT 'Applicants preferred communication channel for waitlist-related notifications and correspondence. Drives outreach strategy in Slate CRM. Valid values: email, portal, mail, phone.. Valid values are `email|portal|mail|phone`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this waitlist record was first created in the system. Serves as the audit creation marker for data lineage and compliance tracking in the Databricks Silver Layer.',
    `entry_type` STRING COMMENT 'Classification of the applicants entry pathway into the institution. FTIAC (First-Time-In-Any-College) indicates a first-time freshman; transfer indicates a student transferring from another institution. Supports cohort-based capacity planning and yield modeling. [ENUM-REF-CANDIDATE: ftiac|transfer|readmit|international|non_degree — promote to reference product]. Valid values are `ftiac|transfer|readmit|international|non_degree`',
    `ferpa_release_on_file` BOOLEAN COMMENT 'Indicates whether the applicant has a FERPA (Family Educational Rights and Privacy Act) release authorization on file permitting disclosure of admissions and waitlist information to designated third parties (e.g., parents, guardians). True = release on file; False = no release on file.',
    `final_disposition` STRING COMMENT 'Ultimate outcome of the waitlist record at the close of the admissions cycle. Valid values: admitted (admitted from waitlist), denied (denied from waitlist by institution), withdrew (applicant withdrew from waitlist), no_action (waitlist closed with no action taken). Supports IPEDS reporting and yield analysis.. Valid values are `admitted|denied|withdrew|no_action`',
    `final_disposition_date` DATE COMMENT 'Date on which the final disposition of the waitlist record was recorded (admission, denial, withdrawal, or no action). Marks the closure of the waitlist lifecycle for this applicant-program-term combination.',
    `financial_aid_impact` STRING COMMENT 'Indicates the financial aid eligibility status for the applicant if admitted from the waitlist. Waitlist admissions may have reduced or no institutional aid availability depending on remaining aid budget. Valid values: eligible (institutional aid available), not_eligible (no institutional aid remaining), pending_review (aid availability under review).. Valid values are `eligible|not_eligible|pending_review`',
    `intended_enrollment_type` STRING COMMENT 'Applicants intended enrollment intensity if admitted from the waitlist. Used in FTE (Full-Time Equivalent) projections and capacity planning. Valid values: full_time, part_time.. Valid values are `full_time|part_time`',
    `is_position_disclosed` BOOLEAN COMMENT 'Indicates whether the institution has disclosed the applicants waitlist position to the applicant. Some institutions do not disclose ranked positions. True = position disclosed to applicant; False = position not disclosed.',
    `is_ranked` BOOLEAN COMMENT 'Indicates whether the waitlist for this program and term is a ranked (ordered) waitlist or an unranked pool. True = ranked waitlist with assigned positions; False = unranked pool where all applicants have equal consideration.',
    `notes` STRING COMMENT 'Free-text field for admissions staff to record relevant observations, special circumstances, or follow-up actions related to this waitlist record. Subject to FERPA access controls.',
    `notification_date` DATE COMMENT 'Date on which the applicant was formally notified of their waitlist placement via official communication (email, portal, or letter). Supports compliance with institutional notification timelines.',
    `offer_accepted_date` DATE COMMENT 'Date on which the applicant formally accepted the admission offer extended from the waitlist. Null if offer was declined, not yet responded to, or not yet extended.',
    `offer_extended_date` DATE COMMENT 'Date on which an admission offer was formally extended to the applicant from the waitlist. Null if no offer has been made. Distinct from the initial waitlist notification date.',
    `offer_response_deadline_date` DATE COMMENT 'Deadline date by which the applicant must accept or decline the admission offer extended from the waitlist. Supports yield management and seat reallocation planning.',
    `pool_size` STRING COMMENT 'Total number of applicants on the waitlist for the same program and entry term at the time this record was created. Provides context for the applicants relative position and probability of admission.',
    `position` STRING COMMENT 'Ordinal rank of the applicant on the waitlist for the given program and entry term. Lower numbers indicate higher priority for admission offers. Used in yield contingency planning and capacity management.',
    `prior_institution_code` STRING COMMENT 'IPEDS unit ID or FICE code of the most recent institution attended by the applicant prior to this application. Relevant for transfer applicants on the waitlist. Supports transfer credit evaluation and articulation agreement analysis.',
    `reason` STRING COMMENT 'Narrative or coded reason explaining why the applicant was placed on the waitlist rather than admitted or denied outright. Examples include capacity constraints, incomplete file pending review, or competitive pool evaluation. Supports admissions process transparency and appeals.',
    `residency_status` STRING COMMENT 'Applicants residency classification for tuition and enrollment purposes. Affects tuition rate assignment and state-level enrollment reporting. Valid values: in_state, out_of_state, international.. Valid values are `in_state|out_of_state|international`',
    `response_deadline_date` DATE COMMENT 'Deadline date by which the applicant must respond to the waitlist placement notification. Applicants who do not respond by this date may be removed from the waitlist.',
    `scholarship_eligibility` BOOLEAN COMMENT 'Indicates whether the applicant, if admitted from the waitlist, would be eligible for merit-based scholarship consideration. True = eligible for scholarship review upon waitlist admission; False = not eligible.',
    `source_channel` STRING COMMENT 'Channel through which the waitlist placement was initiated or the applicants response was received. Supports process analytics and system integration auditing. Valid values: online_portal, paper, slate_crm, edi, staff_entry.. Valid values are `online_portal|paper|slate_crm|edi|staff_entry`',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this waitlist record originated. Supports data lineage tracking and ETL (Extract Transform Load) reconciliation in the Silver Layer. Valid values: banner (Ellucian Banner SIS), slate (Slate CRM), manual (manually entered).. Valid values are `banner|slate|manual`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this waitlist record. Used for incremental data pipeline processing, change detection, and audit trail maintenance in the Silver Layer.',
    `waitlist_date` DATE COMMENT 'Calendar date on which the applicant was officially placed on the admissions waitlist. Serves as the principal business event date for this record and is used to determine waitlist seniority when positions are equal.',
    `waitlist_number` STRING COMMENT 'Externally visible, human-readable business identifier for this waitlist record. Used in applicant communications, staff lookups, and Slate CRM correspondence tracking.. Valid values are `^WL-[0-9]{4}-[A-Z0-9]{6,12}$`',
    `waitlist_status` STRING COMMENT 'Current lifecycle state of the waitlist record. Tracks progression from active waitlist placement through final disposition. Valid values: active (on waitlist, no offer yet), offer_extended (admission offer sent), admitted (applicant accepted offer from waitlist), denied (institution denied from waitlist), withdrew (applicant withdrew from waitlist), expired (waitlist closed without action). [ENUM-REF-CANDIDATE: active|offer_extended|admitted|denied|withdrew|expired — promote to reference product]. Valid values are `active|offer_extended|admitted|denied|withdrew|expired`',
    `waitlist_type` STRING COMMENT 'Classification of the waitlist placement indicating the category or tier of the waitlist. Valid values: standard (general waitlist), priority (elevated consideration tier), alternate (alternate list for specific cohorts), conditional (waitlist contingent on meeting specific conditions such as financial aid or prerequisite completion).. Valid values are `standard|priority|alternate|conditional`',
    CONSTRAINT pk_waitlist PRIMARY KEY(`waitlist_id`)
) COMMENT 'Tracks applicants placed on an admissions waitlist for a specific program and entry term. Captures waitlist position, waitlist date, notification date, applicant response (accept/decline waitlist offer), offer extended date, and final disposition (admitted from waitlist, denied, withdrew). Supports capacity management and yield contingency planning.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`application_review` (
    `application_review_id` BIGINT COMMENT 'Unique surrogate identifier for each application review record in the admissions review process. Primary key for this entity.',
    `academic_program_id` BIGINT COMMENT 'Reference to the academic program or degree program to which the applicant is applying. Enables program-level review analytics and admission rate reporting by Classification of Instructional Programs (CIP) code.',
    `review_committee_id` BIGINT COMMENT 'Reference to the admissions committee responsible for this review, when the review is conducted as part of a formal committee-based decision process rather than an individual review.',
    `employee_id` BIGINT COMMENT 'Reference to the staff member, faculty member, or committee delegate who conducted this review. Supports tracking reviewer workload, calibration, and inter-rater reliability analysis.',
    `enrollment_application_id` BIGINT COMMENT 'Reference to the admissions application being reviewed. Links this review record to the applicants submitted application in the Student Information System (SIS).',
    `instructor_id` BIGINT COMMENT 'Foreign key linking to faculty.instructor. Business justification: Faculty serve on admissions review committees, especially for graduate programs. Accreditation bodies (SACSCOC, specialized accreditors) require documentation of faculty participation in admissions de',
    `term_id` BIGINT COMMENT 'Reference to the academic term or period for which the applicant is seeking admission (e.g., Fall 2025, Spring 2026). Supports term-based enrollment cycle reporting.',
    `academic_score` DECIMAL(18,2) COMMENT 'Numeric score assigned by the reviewer for the academic dimension of the holistic review, typically assessing GPA (Grade Point Average), course rigor, class rank, and standardized test performance (SAT/ACT/GRE/GMAT). Scale defined by institutional rubric.',
    `academic_year` STRING COMMENT 'Academic year associated with the admissions review cycle (e.g., 2024-2025). Used for year-over-year trend analysis of admissions outcomes, reviewer patterns, and program-level admit rates.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `banner_review_ref` STRING COMMENT 'Source system reference identifier from Ellucian Banner SIS for this review record. Enables traceability and reconciliation between the Databricks Silver Layer and the Banner admissions module.',
    `conflict_of_interest_flag` BOOLEAN COMMENT 'Indicates whether the reviewer declared a conflict of interest with this applicant (e.g., family relationship, prior professional relationship). When flagged, the review may be reassigned per institutional policy.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this application review record was first created in the system. Supports audit trail requirements and data lineage tracking in the Databricks Silver Layer.',
    `decision_alignment_flag` BOOLEAN COMMENT 'Indicates whether this reviewers recommendation aligned with the final admissions decision made for the application. Supports inter-rater reliability analysis, reviewer calibration, and quality assurance (QA) of the holistic review process.',
    `degree_level` STRING COMMENT 'Level of the degree program for which the application is being reviewed. Supports segmentation of review analytics by degree level and alignment with IPEDS degree-level reporting categories.. Valid values are `undergraduate|graduate|doctoral|professional|certificate`',
    `essay_score` DECIMAL(18,2) COMMENT 'Numeric score assigned by the reviewer for the personal statement and supplemental essay dimension of the holistic review, assessing writing quality, self-reflection, intellectual curiosity, and fit with institutional mission.',
    `extracurricular_score` DECIMAL(18,2) COMMENT 'Numeric score assigned by the reviewer for the extracurricular and co-curricular activities dimension of the holistic review, assessing leadership, community involvement, athletics, and other non-academic achievements.',
    `first_generation_noted` BOOLEAN COMMENT 'Indicates whether the reviewer noted first-generation college student status as a contextual factor in the holistic evaluation. Supports equity, access, and diversity reporting for accreditation and IPEDS compliance.',
    `honors_nomination` BOOLEAN COMMENT 'Indicates whether the reviewer has nominated this applicant for the institutional honors program based on demonstrated academic excellence and intellectual potential.',
    `internal_notes` STRING COMMENT 'Internal-only notes recorded by the reviewer for committee deliberation purposes. These notes are not shared with the applicant and are subject to institutional FERPA policy regarding the disclosure of admissions records.',
    `international_applicant_noted` BOOLEAN COMMENT 'Indicates whether the reviewer noted international student status as a contextual factor, including consideration of TOEFL/IELTS scores, credential evaluation, and country-of-origin context in the holistic review.',
    `interview_score` DECIMAL(18,2) COMMENT 'Numeric score assigned following an admissions interview, assessing communication skills, motivation, and institutional fit. Nullable when no interview was conducted as part of the review process.',
    `is_blind_review` BOOLEAN COMMENT 'Indicates whether this review was conducted under a blind or anonymized review protocol, where certain applicant identifying information (e.g., name, demographic data) was redacted to reduce reviewer bias.',
    `overall_score` DECIMAL(18,2) COMMENT 'Composite overall score assigned by the reviewer summarizing the holistic evaluation across all dimensions. May be a weighted average of dimension scores or an independent holistic judgment score per institutional rubric.',
    `recommendation` STRING COMMENT 'The reviewers formal recommendation for the admissions decision on this application. admit recommends acceptance; deny recommends rejection; waitlist recommends placement on waitlist; defer recommends deferral to a future term; further_review flags for additional committee consideration.. Valid values are `admit|deny|waitlist|defer|further_review`',
    `recommendation_score` DECIMAL(18,2) COMMENT 'Numeric score assigned by the reviewer for the quality and strength of letters of recommendation submitted with the application. Reflects the caliber of endorsements from teachers, counselors, and other references.',
    `recommendation_strength` STRING COMMENT 'Qualitative indicator of the reviewers confidence or conviction in their recommendation. Supports committee deliberation by distinguishing between strong and borderline recommendations.. Valid values are `strong|moderate|weak|neutral`',
    `recusal_reason` STRING COMMENT 'Free-text description of the reason a reviewer recused themselves or was removed from reviewing a specific application. Populated only when conflict_of_interest_flag is true or review_status is withdrawn.',
    `review_date` DATE COMMENT 'Calendar date on which the reviewer completed or submitted this evaluation. Used for tracking review cycle timelines, reviewer productivity, and admissions decision turnaround reporting.',
    `review_duration_min` STRING COMMENT 'Total time in minutes the reviewer spent evaluating this application, calculated from review_start_timestamp to review_submit_timestamp. Used for reviewer workload analysis and process efficiency reporting.',
    `review_method` STRING COMMENT 'Mode or channel through which the review was conducted. Distinguishes between online portal reviews (Slate), paper-based reviews, in-person committee meetings, and video conference committee sessions.. Valid values are `online_portal|paper|committee_meeting|video_conference`',
    `review_number` STRING COMMENT 'Externally visible business identifier for this review record, used in admissions correspondence, committee reports, and audit trails. Typically system-generated in Slate CRM or Banner.',
    `review_round` STRING COMMENT 'Stage or round within the holistic admissions review workflow at which this evaluation was conducted. Supports multi-round review processes including first read, second read, committee review, final decision, and appeal rounds.. Valid values are `first_read|second_read|committee|final|appeal`',
    `review_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the reviewer opened and began evaluating the application. Used in conjunction with review_submit_timestamp to calculate time-on-task and reviewer efficiency metrics.',
    `review_status` STRING COMMENT 'Current lifecycle state of this review record. pending indicates assigned but not started; in_progress indicates partially completed; completed indicates all scores and recommendation submitted; withdrawn indicates reviewer recused; overridden indicates a senior officer superseded the review outcome.. Valid values are `pending|in_progress|completed|withdrawn|overridden`',
    `review_submit_timestamp` TIMESTAMP COMMENT 'Precise date and time when the reviewer submitted the completed evaluation. Represents the principal business event timestamp for this transaction. Used for SLA tracking and admissions cycle management.',
    `reviewer_comments` STRING COMMENT 'Free-text narrative comments entered by the reviewer summarizing their holistic evaluation, noting strengths, concerns, and contextual factors. Subject to FERPA protections as part of the students education record once an admissions decision is made.',
    `reviewer_type` STRING COMMENT 'Classification of the reviewers role in the admissions process. Distinguishes between admissions staff, faculty reviewers, alumni readers, formal committee members, and external readers. Supports analysis of review outcomes by reviewer category.. Valid values are `admissions_staff|faculty|alumni|committee_member|external_reader`',
    `rubric_version` STRING COMMENT 'Version identifier of the institutional scoring rubric applied during this review. Enables longitudinal comparability of scores across admissions cycles when rubric criteria are updated.',
    `scholarship_nomination` BOOLEAN COMMENT 'Indicates whether the reviewer has nominated this applicant for merit scholarship consideration as part of the holistic review. Feeds into the financial aid and scholarship award process.',
    `score_scale_max` DECIMAL(18,2) COMMENT 'Maximum possible value on the scoring rubric used for this review. Enables normalization of scores across different review cycles, programs, or institutional rubric versions for comparative analytics.',
    `slate_review_ref` STRING COMMENT 'Source system reference identifier from Slate CRM for this review record. Enables traceability and reconciliation between the Databricks Silver Layer and the operational Slate CRM admissions system.',
    `special_talent_flag` BOOLEAN COMMENT 'Indicates whether the reviewer identified a special talent (e.g., NCAA athletics, performing arts, STEM research distinction) that warrants special consideration in the admissions decision process.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this application review record was most recently modified. Supports change tracking, data quality monitoring, and incremental ETL (Extract Transform Load) processing in the lakehouse pipeline.',
    CONSTRAINT pk_application_review PRIMARY KEY(`application_review_id`)
) COMMENT 'Transactional record of a reviewers evaluation of an application during the admissions review process. Captures reviewer identity (staff, faculty, committee), review date, evaluation scores by dimension (academic, extracurricular, essay, interview), overall recommendation, and review round. Supports holistic review workflows and committee-based decision processes.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`admission_offer` (
    `admission_offer_id` BIGINT COMMENT 'Unique system-generated identifier for the admission offer record. Primary key for this entity.',
    `academic_program_id` BIGINT COMMENT 'Reference to the academic program (degree program) for which the admission offer is extended.',
    `employee_id` BIGINT COMMENT 'Reference to the admissions staff member or counselor responsible for managing this offer. Used for territory-based yield reporting and counselor performance analytics.',
    `enrollment_applicant_id` BIGINT COMMENT 'Reference to the prospective student (applicant/party) to whom this offer is extended. Supports yield management and enrollment funnel reporting.',
    `enrollment_application_id` BIGINT COMMENT 'Reference to the student application from which this admission offer was generated. Links the offer to the originating admissions application record.',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Graduate admission offers with research assistantship funding specify the source grant/award. Required for offer letter generation with accurate funding details, award budget commitment tracking, and ',
    `admit_type` STRING COMMENT 'Classification of the admission offer by applicant category. Determines applicable admission policies, financial aid eligibility, and enrollment reporting segments. [ENUM-REF-CANDIDATE: freshman|transfer|graduate|readmit|international|non_degree — promote to reference product]. Valid values are `freshman|transfer|graduate|readmit|international|non_degree`',
    `applicant_response` STRING COMMENT 'The applicants formal response to the admission offer. Drives yield management, seat reservation, and enrollment funnel reporting. deferred_response indicates the applicant has requested additional time.. Valid values are `accepted|declined|deferred_response|no_response`',
    `applicant_response_date` DATE COMMENT 'The date on which the applicant formally responded to the admission offer (accepted, declined, or deferred response). Null if no response has been received.',
    `cip_code` STRING COMMENT 'The six-digit Classification of Instructional Programs (CIP) code assigned to the academic program in the admission offer. Required for IPEDS reporting and federal program classification.. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `coa_amount` DECIMAL(18,2) COMMENT 'The estimated total Cost of Attendance (COA) for the entry term included in the offer package. Includes tuition, fees, room, board, and other allowances. Used in financial aid packaging and yield counseling.',
    `college_unit_code` STRING COMMENT 'The institutional code identifying the college or school within the university to which the applicant has been admitted (e.g., College of Engineering, College of Business). Used for unit-level enrollment reporting and accreditation.',
    `condition_notes` STRING COMMENT 'Free-text description of specific conditions attached to the admission offer when conditions_of_admission is not unconditional. Documents requirements the applicant must satisfy before enrollment is confirmed.',
    `conditions_of_admission` STRING COMMENT 'Specifies whether the offer is unconditional or subject to conditions the applicant must fulfill prior to enrollment (e.g., submission of final transcripts, English proficiency verification, completion of prerequisite coursework). [ENUM-REF-CANDIDATE: unconditional|conditional_final_transcript|conditional_english_proficiency|conditional_prerequisite|conditional_other — promote to reference product]. Valid values are `unconditional|conditional_final_transcript|conditional_english_proficiency|conditional_prerequisite|conditional_other`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time the admission offer record was first created in the system. Supports audit trail, data lineage, and FERPA compliance documentation.',
    `decision_authority` STRING COMMENT 'Identifies the authority or body that approved the admission offer (e.g., admissions committee, dean, automated rules engine). Supports audit trails and accreditation compliance.. Valid values are `committee|dean|director|automated|department`',
    `degree_level` STRING COMMENT 'The academic degree level associated with the program for which the offer is extended. Used for IPEDS reporting, financial aid eligibility, and enrollment segmentation.. Valid values are `certificate|associate|bachelor|master|doctoral|professional`',
    `delivery_method` STRING COMMENT 'The channel through which the admission offer was delivered to the applicant (e.g., applicant portal, email, physical mail, in-person). Used for communication effectiveness analysis.. Valid values are `portal|email|mail|in_person`',
    `delivery_timestamp` TIMESTAMP COMMENT 'The exact date and time the admission offer was delivered to the applicant via the specified delivery method. Supports SLA tracking and communication audit trails.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'The dollar amount of the enrollment deposit required to confirm acceptance of the admission offer. Null if no deposit is required. Used in student accounts and yield management reporting.',
    `deposit_paid_date` DATE COMMENT 'The date on which the applicant paid the enrollment deposit to confirm acceptance. Null if deposit has not been paid. Triggers seat reservation and onboarding workflows.',
    `deposit_required` BOOLEAN COMMENT 'Indicates whether an enrollment deposit is required from the applicant to confirm acceptance of the admission offer. Drives student accounts and yield management workflows.',
    `entry_academic_year` STRING COMMENT 'The academic year associated with the entry term for which the offer is extended (e.g., 2025-2026). Used for cohort tracking and annual enrollment reporting.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `entry_term_code` STRING COMMENT 'The academic term for which the applicant is being offered admission (e.g., 2025FA for Fall 2025). Drives enrollment cycle planning and cohort reporting.. Valid values are `^[0-9]{4}(FA|SP|SU|WI)$`',
    `expiration_date` DATE COMMENT 'The date by which the applicant must respond to the admission offer. After this date, the offer is considered expired if no response has been recorded. Critical for enrollment funnel management.',
    `ftiac_flag` BOOLEAN COMMENT 'Indicates whether the applicant is a First-Time-In-Any-College (FTIAC) student. Critical for IPEDS first-time freshman cohort reporting, retention tracking, and federal enrollment statistics.',
    `honors_designation` STRING COMMENT 'Indicates whether the admission offer includes an honors college or honors program designation. Drives specialized onboarding, advising, and scholarship eligibility workflows.. Valid values are `none|honors_college|honors_program|presidential_scholars`',
    `housing_guarantee` BOOLEAN COMMENT 'Indicates whether the admission offer includes a guaranteed on-campus housing assignment for the entry term. Relevant for yield management and facilities planning.',
    `international_student` BOOLEAN COMMENT 'Indicates whether the applicant is classified as an international student for this admission offer. Drives visa processing workflows, SEVIS reporting, and international student services.',
    `issued_date` DATE COMMENT 'The date on which the formal admission offer was generated and made available to the applicant. Represents the principal business event timestamp for this transaction. Used in yield analysis and time-to-offer reporting.',
    `offer_letter_template_code` STRING COMMENT 'The code identifying the offer letter template used to generate the admission offer communication. Supports communication consistency audits and template version tracking.',
    `offer_number` STRING COMMENT 'Externally visible, human-readable identifier for the admission offer, used in offer letters, portal communications, and correspondence with the applicant. Format: ADM-YYYY-NNNNNN.. Valid values are `^ADM-[0-9]{4}-[0-9]{6}$`',
    `offer_status` STRING COMMENT 'Current lifecycle state of the admission offer. Drives yield management workflows and enrollment funnel reporting. [ENUM-REF-CANDIDATE: draft|issued|accepted|declined|deferred|rescinded|expired — promote to reference product]',
    `portal_viewed` BOOLEAN COMMENT 'Indicates whether the applicant has viewed the admission offer in the applicant portal. Used for yield management follow-up workflows and engagement tracking.',
    `portal_viewed_timestamp` TIMESTAMP COMMENT 'The date and time the applicant first viewed the admission offer in the applicant portal. Supports yield counseling intervention timing and engagement analytics.',
    `rescind_reason` STRING COMMENT 'The reason the admission offer was rescinded, if applicable. Required for compliance documentation and institutional reporting.. Valid values are `academic_deficiency|conduct_violation|fraudulent_application|capacity|other`',
    `rescinded_date` DATE COMMENT 'The date on which the admission offer was rescinded by the institution, if applicable. Null if the offer has not been rescinded. Used for compliance documentation and enrollment audit trails.',
    `scholarship_amount` DECIMAL(18,2) COMMENT 'The institutional merit scholarship dollar amount included in the admission offer letter. Represents the gross institutional grant offered at time of admission. Distinct from need-based financial aid awarded through FAFSA processing.',
    `scholarship_name` STRING COMMENT 'The name of the institutional scholarship or merit award included in the admission offer (e.g., Presidential Scholarship, Deans Award). Used for donor stewardship, yield communications, and financial aid reporting.',
    `scholarship_renewable` BOOLEAN COMMENT 'Indicates whether the scholarship included in the admission offer is renewable for subsequent academic years, subject to Satisfactory Academic Progress (SAP) requirements.',
    `scholarship_renewal_gpa` DECIMAL(18,2) COMMENT 'The minimum cumulative GPA (Grade Point Average) the student must maintain to retain the scholarship in subsequent terms. Null if scholarship is not renewable or has no GPA requirement.',
    `stem_designated` BOOLEAN COMMENT 'Indicates whether the program in the admission offer is classified as a STEM (Science, Technology, Engineering, Mathematics) designated program. Relevant for OPT extension eligibility for international students and federal reporting.',
    `toefl_waived` BOOLEAN COMMENT 'Indicates whether the TOEFL (Test of English as a Foreign Language) or equivalent English proficiency requirement has been waived for this applicant as part of the admission offer. Relevant for international student admissions compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time the admission offer record was last modified. Supports audit trail, change tracking, and data lineage for compliance and reporting purposes.',
    `visa_type_required` STRING COMMENT 'The U.S. student visa type required for the applicant to enroll, if applicable. Used for I-20/DS-2019 issuance workflows and SEVIS compliance reporting.. Valid values are `F-1|J-1|M-1|other|not_applicable`',
    CONSTRAINT pk_admission_offer PRIMARY KEY(`admission_offer_id`)
) COMMENT 'Formal offer of admission extended to an applicant, distinct from the internal decision record. Captures offer letter generation date, delivery method (portal, email, mail), offer expiration date, scholarship amount included in offer, honors designation, and applicant response (accepted, declined, deferred response). Drives yield management and enrollment funnel reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` (
    `transfer_credit_eval_id` BIGINT COMMENT 'Unique surrogate identifier for each transfer credit evaluation record in the Ellucian Banner Student Information System (SIS). Entity role: TRANSACTION_HEADER — represents a discrete academic evaluation event with its own lifecycle.',
    `aid_sap_evaluation_id` BIGINT COMMENT 'Foreign key linking to aid.sap_evaluation. Business justification: Transfer credits impact SAP maximum timeframe calculations (attempted hours vs. program length). Operational link for aid eligibility when transfer students approach 150% completion threshold. Require',
    `articulation_agreement_id` BIGINT COMMENT 'Reference to a formal articulation agreement between the receiving institution and the sending institution, if one exists. When populated, the evaluation follows pre-negotiated equivalency mappings rather than individual review.',
    `athletic_eligibility_id` BIGINT COMMENT 'Foreign key linking to athletics.athletic_eligibility. Business justification: Transfer student-athletes eligibility depends on accepted transfer credits counting toward degree requirements for progress-toward-degree percentage calculation. Compliance officers must verify each ',
    `employee_id` BIGINT COMMENT 'Reference to the faculty member, academic advisor, or registrar staff member who rendered the articulation decision. Satisfies PARTY_REFERENCE category for TRANSACTION_HEADER role.',
    `enrollment_application_id` BIGINT COMMENT 'Reference to the admissions application submitted by the transfer applicant. Links the credit evaluation to the applicants enrollment application record in Ellucian Banner Admissions.',
    `course_id` BIGINT COMMENT 'Reference to the receiving institutions course catalog entry that the sending course has been articulated to. Null if no direct equivalent exists and credit is awarded as elective or generic credit.',
    `org_unit_id` BIGINT COMMENT 'Reference to the academic department responsible for reviewing and rendering the articulation decision for this transfer course. Departments evaluate subject-matter equivalency.',
    `profile_id` BIGINT COMMENT 'Reference to the student or prospective student record for whom the transfer credit evaluation is being conducted. May be populated after matriculation when the applicant becomes an enrolled student.',
    `transcript_id` BIGINT COMMENT 'Foreign key linking to enrollment.transcript. Business justification: Transfer credit evaluation is based on coursework documented in a specific transcript. This FK links the evaluation to the source transcript, enabling transcript-to-credit-award traceability. Removes ',
    `appeal_decision` STRING COMMENT 'Outcome of the formal appeal process for a disputed transfer credit evaluation. upheld = original denial maintained; overturned = credit awarded upon appeal; pending = appeal under review; withdrawn = applicant withdrew appeal.. Valid values are `upheld|overturned|pending|withdrawn`',
    `appeal_flag` BOOLEAN COMMENT 'Indicates whether the applicant or student has filed a formal appeal of the transfer credit evaluation decision (True = appeal filed; False = no appeal). Triggers appeal workflow in the registrars office.',
    `awarded_credit_hours` DECIMAL(18,2) COMMENT 'Number of credit hours (CR) granted by the receiving institution for this transfer course after evaluation. May differ from sending_credit_hours due to unit conversion or partial credit awards. Satisfies QUANTITATIVE_RESULT category for this non-monetary transaction.',
    `course_level` STRING COMMENT 'Academic level classification of the sending institutions course. Determines how credit applies toward degree requirements (e.g., lower-division credits may not satisfy upper-division requirements). Critical for degree audit and program planning.. Valid values are `lower_division|upper_division|graduate|remedial|professional`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transfer credit evaluation record was first created in the system. Satisfies RECORD_AUDIT_CREATED category for TRANSACTION_HEADER role.',
    `credential_eval_service` STRING COMMENT 'Name of the third-party credential evaluation service used to assess international transcripts (e.g., WES, ECE, NACES member). Applicable only for foreign transcripts requiring external evaluation before institutional review.',
    `credit_awarded_flag` BOOLEAN COMMENT 'Indicates whether academic credit was awarded for this transfer course (True = credit awarded; False = credit denied). Primary decision indicator used in transfer admission decisions and degree audit processing.',
    `credit_type` STRING COMMENT 'Classification of how the awarded credit applies at the receiving institution. direct_equivalent = maps to a specific course; elective = counts as free elective; generic = counts in subject area without specific course match; remedial = developmental credit, not degree-applicable; no_credit = denied; advanced_standing = exemption without credit.. Valid values are `direct_equivalent|elective|generic|remedial|no_credit|advanced_standing`',
    `degree_program_applicability` STRING COMMENT 'Indicates the specific degree program(s) or major(s) for which this transfer credit evaluation applies (e.g., B.S. Computer Science, B.A. Psychology). A course may satisfy requirements in one program but not another.',
    `denial_reason` STRING COMMENT 'Reason code explaining why transfer credit was denied or not awarded. Populated when credit_awarded_flag is False. Used for applicant communication, appeal processing, and policy analysis. [ENUM-REF-CANDIDATE: insufficient_grade|no_equivalent|outdated_content|unaccredited_institution|incomplete_documentation|remedial_course|other — promote to reference product]',
    `eval_date` DATE COMMENT 'The date on which the evaluating department rendered its articulation decision. Represents the principal real-world business event timestamp (day-level) for this evaluation. Satisfies BUSINESS_EVENT_TIMESTAMP category.',
    `eval_notes` STRING COMMENT 'Free-text notes entered by the evaluating department or registrar staff documenting the rationale for the articulation decision, conditions attached to conditional approvals, or instructions for the applicant. Subject to FERPA access controls.',
    `eval_reference_number` STRING COMMENT 'Human-readable, externally communicable reference number assigned to this evaluation record (e.g., TCE-2024-000123). Used in correspondence with applicants, advisors, and sending institutions. Satisfies BUSINESS_IDENTIFIER category requirement for TRANSACTION_HEADER role.. Valid values are `^TCE-[0-9]{4}-[0-9]{6}$`',
    `eval_status` STRING COMMENT 'Current lifecycle state of the transfer credit evaluation. pending = submitted, awaiting review; in_review = under departmental review; approved = credit awarded; denied = credit not awarded; conditional = credit awarded pending additional documentation; withdrawn = applicant withdrew request. Satisfies LIFECYCLE_STATUS category.. Valid values are `pending|in_review|approved|denied|conditional|withdrawn`',
    `eval_type` STRING COMMENT 'Method by which the transfer credit evaluation was conducted. individual_review = evaluated on a case-by-case basis by the department; articulation_agreement = governed by a formal bilateral agreement; statewide_policy = governed by state-mandated transfer policy; national_policy = governed by national standards (e.g., AP, CLEP).. Valid values are `individual_review|articulation_agreement|statewide_policy|national_policy`',
    `intended_entry_term` STRING COMMENT 'The academic term for which the transfer applicant intends to enroll at the receiving institution (e.g., Fall 2024). Used to align credit evaluation with the applicable catalog year and degree requirements.',
    `min_grade_required` STRING COMMENT 'The minimum letter grade that must have been earned at the sending institution for this course to be eligible for credit transfer under institutional policy (e.g., C, C-, B). Used to enforce grade threshold policies during evaluation.',
    `posted_date` DATE COMMENT 'Date on which the awarded transfer credit was officially posted to the students academic transcript. Null until posting occurs. Used for enrollment timeline tracking and degree audit activation.',
    `posted_to_transcript_flag` BOOLEAN COMMENT 'Indicates whether the awarded transfer credit has been officially posted to the students academic transcript in the Student Information System (SIS) (True = posted; False = not yet posted). Credit is typically posted after official transcript receipt and matriculation.',
    `sending_cip_code` STRING COMMENT 'Six-digit CIP (Classification of Instructional Programs) code assigned to the sending institutions course, used to classify the academic discipline for articulation matching, IPEDS reporting, and program alignment analysis.. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `sending_course_number` STRING COMMENT 'The course number as recorded on the official transcript from the sending institution (e.g., MATH 201). Preserved verbatim for audit and articulation agreement matching.',
    `sending_course_title` STRING COMMENT 'The official course title as it appears on the sending institutions transcript (e.g., Calculus II). Used by evaluators to assess subject-matter equivalency against the receiving institutions catalog.',
    `sending_credit_hours` DECIMAL(18,2) COMMENT 'Number of credit hours (or equivalent units) assigned to the course at the sending institution as recorded on the official transcript. May differ from awarded credit hours due to unit conversion (e.g., quarter-to-semester conversion).',
    `sending_credit_unit_type` STRING COMMENT 'The credit unit system used by the sending institution. Required for accurate credit hour conversion when the sending institution uses a different academic calendar system (e.g., quarter hours must be converted to semester hours at a 2/3 ratio).. Valid values are `semester_hour|quarter_hour|ects_credit|clock_hour|other`',
    `sending_grade` STRING COMMENT 'The letter grade or grade symbol earned in the course at the sending institution as recorded on the official transcript (e.g., A, B+, C, P, S). Used to determine grade threshold eligibility for credit transfer under institutional policy.',
    `sending_grade_points` DECIMAL(18,2) COMMENT 'Numeric grade point value corresponding to the grade earned at the sending institution on that institutions grading scale (e.g., 3.700 for A-). Used for GPA (Grade Point Average) equivalency analysis and transfer GPA calculations.',
    `sending_institution_accreditation` STRING COMMENT 'Accreditation classification of the sending institution at the time of transcript evaluation. Determines eligibility for credit transfer under institutional policy. Regionally accredited institutions typically receive full credit consideration.. Valid values are `regionally_accredited|nationally_accredited|foreign_recognized|unaccredited|unknown`',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this transfer credit evaluation record originated. banner = Ellucian Banner SIS; slate = Slate CRM (preliminary evaluation during admissions); manual = manually entered by registrar staff.. Valid values are `banner|slate|manual`',
    `term_completed` STRING COMMENT 'The academic term and year in which the course was completed at the sending institution as recorded on the transcript (e.g., Fall 2022, Spring 2023). Used to assess course recency policies and catalog year applicability.',
    `transcript_source_type` STRING COMMENT 'Indicates the form in which the sending institutions transcript was received. Official transcripts (paper or electronic) are required for final credit posting; unofficial or self-reported transcripts may be used for preliminary evaluation during admissions.. Valid values are `official_paper|official_electronic|unofficial|self_reported`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this transfer credit evaluation record was last modified. Tracks revisions to articulation decisions, credit awards, or equivalent course mappings. Satisfies RECORD_AUDIT_UPDATED category for TRANSACTION_HEADER role.',
    CONSTRAINT pk_transfer_credit_eval PRIMARY KEY(`transfer_credit_eval_id`)
) COMMENT 'Record of the evaluation of transfer coursework submitted by a transfer applicant for potential credit articulation. Captures sending institution, course title, course number, credit hours, grade earned, equivalent institutional course, credit awarded flag, and evaluating department. Supports transfer admission decisions and pre-enrollment academic planning.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`international_credential` (
    `international_credential_id` BIGINT COMMENT 'Unique surrogate identifier for the international academic credential record in the Databricks Silver Layer. Primary key for this master resource entity.',
    `enrollment_applicant_id` BIGINT COMMENT 'Reference to the individual applicant who submitted this international credential. Enables direct linkage to the applicants demographic and contact record.',
    `enrollment_application_id` BIGINT COMMENT 'Reference to the admissions application with which this international credential is associated. Links the credential to the applicants admission record in Ellucian Banner or Slate CRM.',
    `accreditation_status` STRING COMMENT 'Accreditation or recognition status of the foreign issuing institution as determined by the relevant national authority or international body. Unrecognized institutions may result in credential rejection per institutional policy.. Valid values are `accredited|recognized|unrecognized|unknown|under_review`',
    `admissions_reviewer_notes` STRING COMMENT 'Free-text notes entered by the admissions reviewer regarding the international credential, including observations about document quality, equivalency concerns, or special circumstances. Classified as confidential per FERPA student record protections.',
    `cip_code` STRING COMMENT 'Six-digit CIP code mapped to the field of study of the foreign credential, following the National Center for Education Statistics taxonomy. Enables standardized program comparison and IPEDS reporting.. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this international credential record was first created in the system. Provides audit trail and supports data lineage tracking in the Databricks Silver Layer.',
    `credential_award_date` DATE COMMENT 'Date on which the foreign academic credential was officially awarded or conferred by the issuing institution. Used to verify recency and eligibility for graduate or professional program admission.',
    `credential_code` STRING COMMENT 'Externally-known business identifier assigned to this credential record by the admissions office or Student Information System (SIS). Used for tracking and correspondence with applicants and evaluation agencies.. Valid values are `^INTLCRED-[0-9]{8}-[A-Z0-9]{6}$`',
    `credential_name` STRING COMMENT 'Official name of the academic credential as it appears on the foreign document (e.g., Licenciatura, Abitur, A-Levels, Bachelor of Engineering). Preserves the original credential title for accurate evaluation and record-keeping.',
    `credential_status` STRING COMMENT 'Current lifecycle status of the international credential record within the admissions review workflow. Tracks progression from initial receipt through evaluation and final admissions decision. [ENUM-REF-CANDIDATE: received|under_review|evaluated|accepted|rejected|pending_official — promote to reference product]. Valid values are `received|under_review|evaluated|accepted|rejected|pending_official`',
    `credential_type` STRING COMMENT 'Classification of the submitted international academic credential document. Distinguishes between original foreign transcripts, degree certificates, diplomas, mark sheets, and formal credential evaluation reports from agencies such as WES or ECE. [ENUM-REF-CANDIDATE: transcript|degree_certificate|diploma|mark_sheet|credential_evaluation_report|other — promote to reference product]. Valid values are `transcript|degree_certificate|diploma|mark_sheet|credential_evaluation_report|other`',
    `credit_hours_evaluated` DECIMAL(18,2) COMMENT 'Number of US-equivalent credit hours (CR) awarded or recognized based on the credential evaluation. Used for transfer credit articulation and degree completion planning.',
    `document_delivery_method` STRING COMMENT 'Method by which the credential document was delivered to the institution (e.g., postal mail, email, applicant portal upload, direct submission from evaluation agency, courier). Supports document tracking and audit.. Valid values are `mail|email|upload|agency_direct|courier`',
    `document_received_date` DATE COMMENT 'Date on which the physical or electronic credential document was received by the admissions office. Triggers the document verification and evaluation workflow in the admissions process.',
    `ects_credits` DECIMAL(18,2) COMMENT 'Number of European Credit Transfer System (ECTS) credits associated with the foreign credential, where applicable. Relevant for credentials from European institutions and supports international credit transfer articulation.',
    `enrollment_end_date` DATE COMMENT 'Date the applicant completed or ended enrollment at the foreign issuing institution. Together with enrollment start date, defines the full period of foreign study.',
    `enrollment_start_date` DATE COMMENT 'Date the applicant first enrolled at the foreign issuing institution. Used to calculate duration of study and verify academic history completeness.',
    `evaluated_gpa` DECIMAL(18,2) COMMENT 'The US-equivalent Grade Point Average (GPA) on a 4.0 scale as determined by the credential evaluation agency or admissions office conversion. Used for academic standing comparison and admissions eligibility assessment.',
    `evaluation_agency_membership` STRING COMMENT 'Professional membership body to which the credential evaluation agency belongs (e.g., NACES or AICE). Confirms the agency meets institutional standards for accepted evaluators in the admissions process.. Valid values are `NACES|AICE|other|none`',
    `evaluation_agency_name` STRING COMMENT 'Name of the third-party credential evaluation agency that assessed the foreign credential (e.g., World Education Services (WES), Educational Credential Evaluators (ECE), Josef Silny & Associates). Required for verifying the legitimacy and accreditation of the evaluation.',
    `evaluation_report_date` DATE COMMENT 'Date on which the credential evaluation report was issued by the evaluation agency. Used to assess report recency and compliance with institutional policies requiring evaluations within a specified timeframe.',
    `evaluation_report_number` STRING COMMENT 'Unique reference number assigned by the credential evaluation agency to the evaluation report. Used to verify authenticity and retrieve the official evaluation document from the agency.',
    `field_of_study` STRING COMMENT 'Academic discipline or major field of study associated with the foreign credential as reported by the issuing institution. Supports program alignment and CIP code mapping during admissions review.',
    `is_official_document` BOOLEAN COMMENT 'Indicates whether the submitted credential is an official document (sealed, certified, or sent directly from the issuing institution or evaluation agency) as opposed to an unofficial copy submitted by the applicant. Official documents are required for final admissions decisions.',
    `is_translated` BOOLEAN COMMENT 'Indicates whether the credential document required translation into English. Flags records where a certified translation was obtained, supporting document completeness verification.',
    `isced_level` STRING COMMENT 'UNESCO ISCED 2011 level classification assigned to the foreign credential. Provides internationally standardized education level coding for cross-border comparability and institutional reporting. [ENUM-REF-CANDIDATE: ISCED-1|ISCED-2|ISCED-3|ISCED-4|ISCED-5|ISCED-6|ISCED-7|ISCED-8 — promote to reference product]',
    `issuing_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code representing the country of origin of the foreign academic credential. Critical for international admissions review, visa processing, and IPEDS reporting.. Valid values are `^[A-Z]{3}$`',
    `issuing_institution_city` STRING COMMENT 'City where the foreign issuing institution is located. Supports geographic analysis and institutional verification workflows.',
    `issuing_institution_name` STRING COMMENT 'Full legal name of the foreign academic institution that issued the credential (e.g., university, college, or secondary school abroad). Used for institutional verification and accreditation cross-reference.',
    `original_grade_value` DECIMAL(18,2) COMMENT 'The applicants academic performance result as recorded on the foreign credential in the issuing institutions native grading format (e.g., 8.5/10, 85%, First Class). Preserved for audit and re-evaluation purposes.',
    `original_grading_scale` STRING COMMENT 'Description of the grading scale used by the foreign issuing institution (e.g., 1-10 scale, percentage 0-100, First/Second Class Honours). Provides context for GPA conversion and academic performance interpretation.',
    `source_system` STRING COMMENT 'Operational system of record from which this international credential record was sourced (e.g., Ellucian Banner SIS, Slate CRM, or manually entered). Supports data lineage and ETL audit in the Databricks Silver Layer.. Valid values are `Banner|Slate|manual`',
    `source_system_record_code` STRING COMMENT 'The native record identifier from the originating operational system (e.g., Banner credential record ID or Slate document ID). Enables traceability and reconciliation between the lakehouse Silver Layer and the system of record.',
    `translation_agency` STRING COMMENT 'Name of the certified translation agency or individual translator who provided the English translation of the foreign credential document. Required when is_translated is true.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this international credential record was most recently modified. Supports change tracking, incremental ETL processing, and audit compliance in the Databricks Silver Layer.',
    `us_equivalent_degree_level` STRING COMMENT 'The evaluated United States equivalent degree level assigned to the foreign credential by the credential evaluation agency or admissions office. Determines admissions eligibility and program placement. [ENUM-REF-CANDIDATE: high_school_diploma|associate|bachelor|master|doctoral|professional|certificate|other — promote to reference product]',
    `verification_date` DATE COMMENT 'Date on which the credential verification process was completed. Supports audit trail requirements and accreditation compliance documentation.',
    `verification_status` STRING COMMENT 'Status of the institutional verification process confirming the authenticity of the foreign credential with the issuing institution or evaluation agency. Distinct from credential_status which tracks the admissions workflow stage.. Valid values are `not_started|in_progress|verified|failed|waived`',
    `verified_by` STRING COMMENT 'Name or identifier of the admissions staff member or office responsible for completing the credential verification. Provides accountability and audit trail for the verification decision.',
    CONSTRAINT pk_international_credential PRIMARY KEY(`international_credential_id`)
) COMMENT 'Master record for international academic credentials submitted by international applicants, including foreign transcripts, degree certificates, and credential evaluation reports from agencies such as WES or ECE. Captures country of origin, credential type, issuing institution, evaluation agency, evaluated US equivalent degree level, and evaluation report date. Supports international admissions review.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`recruitment_territory` (
    `recruitment_territory_id` BIGINT COMMENT 'Unique surrogate identifier for the recruitment territory record. Primary key for the recruitment_territory entity in the enrollment domain Silver layer.',
    `employee_id` BIGINT COMMENT 'Identifier of the primary admissions counselor responsible for this territory. Links to the staff/counselor entity for workload management, performance tracking, and prospect routing in Slate CRM.',
    `tertiary_recruitment_assigned_counselor_employee_id` BIGINT COMMENT 'FK to hr.employee',
    `academic_year` STRING COMMENT 'Academic year for which this territory configuration is active (e.g., 2024-2025). Territories may be reconfigured annually to reflect enrollment strategy changes, counselor staffing, and institutional priorities.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `banner_territory_code` STRING COMMENT 'Territory code as stored in Ellucian Banner Student Information System (SIS). Used for cross-system reconciliation between Banner admissions records and Slate CRM territory assignments, and for IPEDS reporting alignment.',
    `college_unit_focus` STRING COMMENT 'Name or code of the college, school, or academic unit that this territory primarily recruits for (e.g., College of Engineering, School of Business, All Colleges). Supports college-specific recruitment planning and AACSB/ABET reporting.',
    `cost_center_code` STRING COMMENT 'Financial cost center code in Oracle PeopleSoft Financials to which territory-related expenses (travel, events, materials) are charged. Enables financial reporting and budget reconciliation at the territory level.',
    `counties_covered` STRING COMMENT 'Pipe-delimited list of county names or FIPS county codes included in this territory for sub-state geographic precision (e.g., Cook County, IL|DuPage County, IL). Used for high-density metro area territory delineation.',
    `countries_covered` STRING COMMENT 'Pipe-delimited list of ISO 3166-1 alpha-3 country codes included in this territory for international recruitment (e.g., CHN|IND|KOR|BRA). Null for purely domestic territories. Used for international prospect routing and visa/citizenship reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this recruitment territory record was first created in the data platform. Supports audit trail, data lineage, and Silver layer record management per institutional data governance policy.',
    `degree_level_focus` STRING COMMENT 'Degree level(s) that this territory is primarily responsible for recruiting (e.g., undergraduate, graduate, professional). Supports segmented recruitment strategy and counselor specialization by academic level.. Valid values are `undergraduate|graduate|both|professional|doctoral`',
    `effective_end_date` DATE COMMENT 'Date on which this territory assignment and configuration expires or is superseded. Null indicates an open-ended, currently active territory. Used for historical territory analysis and counselor transition management.',
    `effective_start_date` DATE COMMENT 'Date on which this territory assignment and configuration becomes effective. Supports bi-temporal modeling of territory changes across recruitment cycles and counselor transitions.',
    `high_school_count` STRING COMMENT 'Number of high schools within the territorys geographic boundaries. Used for planning high school visit schedules, counselor workload estimation, and CEEB code-based prospect sourcing.',
    `is_first_generation_focus` BOOLEAN COMMENT 'Indicates whether this territory has a designated focus on recruiting first-generation college students (FTIAC students whose parents did not complete a four-year degree). Supports equity and access reporting and targeted outreach program planning.',
    `is_international` BOOLEAN COMMENT 'Indicates whether this territory covers international (non-U.S.) geographic areas. Drives SEVIS compliance workflows, visa counseling requirements, TOEFL/IELTS score routing, and international student services coordination.',
    `is_stem_focus` BOOLEAN COMMENT 'Indicates whether this territory has a designated focus on recruiting STEM (Science, Technology, Engineering, Mathematics) program prospects. Supports targeted STEM pipeline initiatives and federal reporting on STEM enrollment diversity.',
    `priority_tier` STRING COMMENT 'Strategic priority classification of the territory based on enrollment yield history, institutional goals, and market opportunity (Tier 1 = highest priority). Drives resource allocation, travel frequency, and event investment decisions.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `slate_territory_ref` STRING COMMENT 'Source system identifier for this territory record in Slate CRM (Admissions and Enrollment system). Enables lineage tracing, incremental ETL reconciliation, and cross-system auditing between the Silver layer and the operational Slate CRM instance.',
    `states_covered` STRING COMMENT 'Pipe-delimited list of U.S. state abbreviations (USPS two-letter codes) included in this domestic territory (e.g., IL|WI|MN|IA). Null for international or virtual territories. Used for prospect routing and geographic reporting.',
    `target_applicant_volume` STRING COMMENT 'Planned number of completed applications expected from this territory for the academic year. Distinct from prospect volume; used to set conversion funnel benchmarks and measure territory yield performance.',
    `target_enrolled_volume` STRING COMMENT 'Planned number of students expected to enroll (matriculate) from this territory for the academic year. Supports enrollment goal tracking and territory-level yield analysis.',
    `target_prospect_volume` STRING COMMENT 'Planned number of prospective students to be recruited from this territory during the academic year. Used for counselor workload planning, travel budget allocation, and recruitment goal-setting.',
    `territory_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the recruitment territory within the admissions office (e.g., DOM-MW-IL, INTL-APAC). Used as the business key in Slate CRM and Banner for cross-system reference.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `territory_name` STRING COMMENT 'Human-readable name of the recruitment territory (e.g., Midwest Illinois, Southeast Asia Pacific, Virtual Graduate Domestic). Used in dashboards, counselor assignments, and recruitment planning reports.',
    `territory_notes` STRING COMMENT 'Free-text operational notes about the territory including special recruitment considerations, key feeder high schools, partnership agreements, competitive landscape observations, or counselor-specific guidance.',
    `territory_region` STRING COMMENT 'Broader geographic or organizational region grouping this territory (e.g., Northeast, Midwest, Southeast, West Coast, Latin America, EMEA, APAC). Supports regional rollup reporting and counselor team management. [ENUM-REF-CANDIDATE: Northeast|Midwest|Southeast|West|Southwest|Latin America|EMEA|APAC|Canada|Other — promote to reference product]',
    `territory_status` STRING COMMENT 'Current lifecycle status of the recruitment territory. Active territories are in use for the current recruitment cycle; inactive territories are suspended; pending territories are being configured; archived territories are retained for historical reporting.. Valid values are `active|inactive|pending|archived`',
    `territory_type` STRING COMMENT 'Classification of the territory by geographic scope: domestic (U.S.-based states/counties/zip codes), international (foreign countries/regions), virtual (online-only outreach without geographic boundary), or hybrid (combination of in-person and virtual coverage).. Valid values are `domestic|international|virtual|hybrid`',
    `travel_budget` DECIMAL(18,2) COMMENT 'Annual travel and recruitment event budget allocated to this territory in USD. Used for financial planning, counselor expense management, and ROI analysis of territory-level recruitment spend.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this recruitment territory record was most recently modified. Used for incremental ETL processing, change detection, and audit trail maintenance in the Databricks Silver layer.',
    `virtual_platform` STRING COMMENT 'Primary virtual engagement platform used for this territorys online recruitment activities (e.g., Zoom, Teams, Slate Events). Applicable for virtual and hybrid territory types. Null or none for purely in-person domestic territories.. Valid values are `zoom|teams|webex|slate_events|other|none`',
    `zip_codes_covered` STRING COMMENT 'Pipe-delimited list or range expression of U.S. ZIP codes included in this territory for fine-grained geographic targeting (e.g., 60601|60602|60603). Supports precise prospect routing in Slate CRM and targeted direct mail campaigns.',
    CONSTRAINT pk_recruitment_territory PRIMARY KEY(`recruitment_territory_id`)
) COMMENT 'Reference entity defining geographic recruitment territories assigned to admissions counselors. Captures territory name, geographic boundaries (states, counties, zip codes, countries), territory type (domestic, international, virtual), assigned counselor, effective dates, and target prospect volume. Supports territory-based recruitment planning and counselor workload management.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`term` (
    `term_id` BIGINT COMMENT 'Unique surrogate identifier for the academic term record in the Databricks Silver Layer. Primary key for the term master table.',
    `campus_id` BIGINT COMMENT 'Foreign key linking to facility.campus. Business justification: Academic terms may have campus-specific calendars, registration periods, and census dates in multi-campus institutions. Term management and registration systems require campus assignment. Campus_code ',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Academic terms must align with fiscal periods for tuition revenue recognition, financial statement preparation, IPEDS reporting, and audit compliance. Every institution maps academic calendars to fisc',
    `academic_year` STRING COMMENT 'The academic year to which this term belongs, expressed in YYYY-YYYY format (e.g., 2024-2025). Used for IPEDS reporting, financial aid year alignment, accreditation data submissions, and annual enrollment trend analysis.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `add_deadline_date` DATE COMMENT 'The last date students may add courses to their schedule for this term. After this date, course additions require instructor and dean approval. Critical for enrollment management, financial aid recalculation, and DFW rate tracking.',
    `banner_term_ref` STRING COMMENT 'The native term code as stored in the Ellucian Banner Student Information System (STVTERM table). Serves as the integration key for data lineage tracing between the Silver Layer and the Banner SIS source system. Enables reconciliation during ETL validation.',
    `calendar_type` STRING COMMENT 'The institutional calendar structure under which this term operates. Determines credit hour equivalencies, ECTS conversion factors, and financial aid disbursement schedules. Reported to IPEDS and regional accreditors.. Valid values are `semester|quarter|trimester|4-1-4`',
    `census_date` DATE COMMENT 'The official enrollment snapshot date used for IPEDS headcount and FTE reporting, state funding calculations, and institutional enrollment benchmarking. Enrollment counts frozen at census are the authoritative figures for accreditation and regulatory submissions.',
    `commencement_date` DATE COMMENT 'The date of the graduation ceremony associated with this term, if applicable. Used for degree conferral processing, alumni record creation in Blackbaud Raisers Edge, and NCAA eligibility tracking for student-athletes.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this term record was first created in the data platform. Supports audit trail requirements, data lineage tracking, and FERPA compliance documentation for record management.',
    `degree_conferral_date` DATE COMMENT 'The official date on which degrees are conferred for students completing requirements in this term. May differ from commencement_date (e.g., degrees conferred at end of term but ceremony held later). Used for transcript notation, alumni record activation, and IPEDS Completions Survey reporting.',
    `drop_deadline_date` DATE COMMENT 'The last date students may drop courses without academic record notation (no W grade). Drops before this date result in full or partial tuition refund per the institutional refund schedule. Impacts DFW rate calculations and enrollment reporting.',
    `end_date` DATE COMMENT 'The last day of the academic term when instruction concludes. Marks the boundary for enrollment reporting, financial aid return-to-title-IV (R2T4) calculations, and academic standing evaluations.',
    `financial_aid_disbursement_date` DATE COMMENT 'The scheduled date for initial financial aid disbursement to student accounts for this term. Must comply with U.S. Department of Education Title IV disbursement timing rules (no earlier than 10 days before term start for most aid types). Drives student billing and accounts receivable processing.',
    `financial_aid_year_code` STRING COMMENT 'The FAFSA award year associated with this term (e.g., 2024-2025). Links the term to the correct FAFSA cycle for Title IV aid eligibility determination, Expected Family Contribution (EFC) calculations, and Cost of Attendance (COA) budgets.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `fte_credit_hour_threshold` DECIMAL(18,2) COMMENT 'The minimum number of credit hours required for a student to be classified as full-time for FTE calculation purposes in this term. Typically 12 credit hours for undergraduates and 9 for graduates. Used in IPEDS FTE reporting, state funding formulas, and financial aid full-time enrollment requirements.',
    `grade_change_deadline` DATE COMMENT 'The last date by which faculty or academic administrators may submit grade changes (corrections or incomplete grade resolutions) for this term without requiring academic committee approval. Governs academic record integrity and transcript finalization.',
    `grade_submission_deadline` DATE COMMENT 'The deadline by which faculty must submit final grades for all courses in this term via the SIS or LMS gradebook. Triggers academic standing evaluation, Deans List processing, and financial aid SAP review upon completion.',
    `half_time_credit_hour_threshold` DECIMAL(18,2) COMMENT 'The minimum number of credit hours required for a student to be classified as half-time enrollment status for this term. Typically 6 credit hours for undergraduates. Determines financial aid eligibility levels and loan deferment qualification under Title IV regulations.',
    `incomplete_grade_deadline` DATE COMMENT 'The deadline by which students must complete coursework to resolve an Incomplete (I) grade assigned in this term. After this date, incomplete grades typically convert to a failing grade per institutional policy. Tracked in Banner Academic History.',
    `instruction_weeks` STRING COMMENT 'The number of weeks of scheduled instruction in this term. Used for credit hour compliance verification per U.S. Department of Education regulations (Carnegie Unit standard: 1 credit hour = 1 hour of instruction + 2 hours of out-of-class work per week for 15 weeks), ECTS conversion, and accreditation reporting.',
    `instructional_method` STRING COMMENT 'Primary instructional delivery modality for this term. Reported to IPEDS and accreditors. Hyflex indicates simultaneous in-person and online delivery. Drives distance education compliance reporting under U.S. Department of Education regulations.. Valid values are `face-to-face|online|hybrid|hyflex`',
    `ipeds_term_type_code` STRING COMMENT 'IPEDS-defined term type code for federal enrollment reporting: 1 = Fall, 2 = Spring, 3 = Summer. Required for IPEDS Fall Enrollment Survey and 12-Month Enrollment Survey submissions to the U.S. Department of Education.. Valid values are `1|2|3`',
    `is_degree_applicable` BOOLEAN COMMENT 'Indicates whether credits earned in this term count toward degree completion requirements. Non-degree-applicable terms (e.g., certain continuing education sessions) are excluded from academic progress calculations and transcript degree audits.',
    `is_financial_aid_eligible` BOOLEAN COMMENT 'Indicates whether students enrolled in this term are eligible to receive Title IV federal financial aid disbursements. Some special sessions or non-credit terms may not qualify. Governs FAFSA processing and aid packaging in Banner Financial Aid.',
    `is_open_enrollment` BOOLEAN COMMENT 'Indicates whether this term uses open/rolling enrollment (True) rather than a fixed registration window (False). Relevant for MOOC-style programs, continuing education, and competency-based education offerings that do not follow traditional term calendars.',
    `is_standard_term` BOOLEAN COMMENT 'Indicates whether this term follows the institutions standard academic calendar (True) or is a non-standard/accelerated/special session term (False). Non-standard terms may have different financial aid disbursement rules and credit hour compliance requirements under Title IV.',
    `last_day_of_attendance_date` DATE COMMENT 'The last official day of academic activity for this term, used for Title IV Return to Title IV (R2T4) calculations when a student withdraws. Distinct from end_date as it may exclude final exam periods for R2T4 purposes.',
    `payment_due_date` DATE COMMENT 'The deadline by which students must pay tuition and fees or establish a payment plan to avoid late fees or enrollment cancellation for this term. Managed in Banner Student Accounts.',
    `registration_close_date` DATE COMMENT 'The final date by which students may register for courses in this term through standard registration processes. After this date, late registration or departmental override processes apply.',
    `registration_open_date` DATE COMMENT 'The date on which student course registration opens for this term. Priority registration windows for different student populations (e.g., seniors, athletes, honors students) are governed by this baseline date in Banners registration control.',
    `sap_evaluation_date` DATE COMMENT 'The date on which Satisfactory Academic Progress (SAP) is evaluated for students enrolled in this term. SAP evaluation is required by U.S. Department of Education Title IV regulations to determine continued financial aid eligibility based on GPA and completion rate thresholds.',
    `session_code` STRING COMMENT 'Sub-term session identifier used when a term contains multiple instructional sessions of different lengths (e.g., A, B, C for 8-week sessions within a 16-week semester, or S1/S2 for summer sessions). Aligns with Banner part-of-term configuration.',
    `start_date` DATE COMMENT 'The first day of the academic term when instruction begins. Used to calculate enrollment duration, financial aid disbursement eligibility, and Satisfactory Academic Progress (SAP) evaluation periods.',
    `term_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the academic term, following Ellucian Banners YYYYTT convention (e.g., 202410 for Fall 2024, 202420 for Spring 2025). Used as the primary cross-system integration key across Banner, Canvas LMS, and Kuali Research.. Valid values are `^[0-9]{6}$`',
    `term_name` STRING COMMENT 'Human-readable display name of the academic term (e.g., Fall 2024, Spring 2025, Summer 2024 Session I). Used in student-facing portals, transcripts, and institutional reporting.',
    `term_status` STRING COMMENT 'Current lifecycle state of the academic term. Planning indicates the term is being configured; Open indicates registration is available; Active indicates the term is in session; Closed indicates the term has ended and grades are finalized; Archived indicates the term is historical. Controls system-wide access and processing rules in Banner.. Valid values are `planning|open|active|closed|archived`',
    `term_type` STRING COMMENT 'Classification of the academic term by season or session type. Drives financial aid disbursement cycles, IPEDS reporting, and enrollment analytics segmentation.. Valid values are `fall|spring|summer|winter`',
    `tuition_billing_date` DATE COMMENT 'The date on which tuition and fee charges are assessed to student accounts for this term. Aligns with the institutional billing cycle and triggers accounts receivable processing in Banner Student Accounts and PeopleSoft Financials.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this term record was most recently modified in the data platform. Used for incremental ETL processing, change data capture, and audit trail maintenance in the Silver Layer.',
    `withdrawal_deadline_date` DATE COMMENT 'The last date students may withdraw from courses with a W grade notation on their academic record. Withdrawals after this date require academic committee approval. Affects SAP evaluation, financial aid return-to-title-IV (R2T4), and DFW rate reporting.',
    CONSTRAINT pk_term PRIMARY KEY(`term_id`)
) COMMENT 'Academic term master record defining the enrollment period (semester, quarter, trimester, or summer session). Captures term code, start/end dates, registration open/close dates, census date, add/drop deadline, withdrawal deadline, grade submission deadline, term type (fall/spring/summer/winter), academic year, and term status. Serves as the foundational time dimension for all enrollment activity and integrates with Ellucian Banner term control table.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`enrollment_registration` (
    `enrollment_registration_id` BIGINT COMMENT 'Unique surrogate identifier for the student course registration record in the Silver Layer lakehouse. Primary key for the enrollment.registration data product.',
    `ada_accommodation_id` BIGINT COMMENT 'Foreign key linking to compliance.ada_accommodation. Business justification: Course registrations implement approved ADA accommodations (extended time, note-takers, accessible seating). Registrar and disability services offices use this link to verify accommodation delivery an',
    `campus_id` BIGINT COMMENT 'Foreign key linking to facility.campus. Business justification: Course registrations occur at specific campuses. Space utilization analysis, campus-level enrollment planning, and multi-campus scheduling coordination require linking registrations to campus. Campus_',
    `course_section_id` BIGINT COMMENT 'Reference to the specific course section (CRN) in which the student is enrolled for the given term.',
    `disbursement_id` BIGINT COMMENT 'Foreign key linking to aid.disbursement. Business justification: Disbursements require enrollment verification at census date. Operational link for Title IV compliance (enrollment status confirmation), COD reporting, and post-withdrawal disbursement eligibility. Tr',
    `profile_id` BIGINT COMMENT 'Reference to the student who is enrolled in the course section. Links to the student master record.',
    `term_id` BIGINT COMMENT 'Reference to the academic term (semester, quarter, or session) for which this registration applies.',
    `tuition_charge_id` BIGINT COMMENT 'Foreign key linking to billing.tuition_charge. Business justification: Each registration generates specific tuition charges based on credit hours, program, and residency. Drop/add transactions require linking registration to originating charge for refund calculation per ',
    `add_timestamp` TIMESTAMP COMMENT 'Date and time when the student added this course section, particularly relevant for late adds processed after the initial registration period. Supports add/drop period compliance reporting.',
    `banner_sfrstcr_key` STRING COMMENT 'Composite natural key from Ellucian Banner SFRSTCR table (PIDM + CRN + term code) used for source system lineage and reconciliation.',
    `billing_hours` DECIMAL(18,2) COMMENT 'Number of credit hours used for tuition billing purposes for this registration. May differ from credit_hours_attempted for audit enrollments, variable-credit courses, or consortium arrangements.',
    `census_enrolled_flag` BOOLEAN COMMENT 'Indicates whether the student was enrolled in this course section as of the official census date (enrollment snapshot date). Drives IPEDS headcount, FTE reporting, and state funding calculations.',
    `cip_code` STRING COMMENT 'Six-digit CIP code classifying the academic discipline of the course. Required for IPEDS completions and enrollment reporting, and for STEM designation under DHS regulations.. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `college_code` STRING COMMENT 'Code identifying the academic college or school that owns the course section (e.g., ENGR, BUS, LAS). Used for enrollment reporting by college unit and accreditation body reporting (AACSB, ABET).',
    `course_number` STRING COMMENT 'Numeric course identifier within the subject discipline (e.g., 101, 4520). Combined with course_subject forms the human-readable course designator used in transcripts and schedules.. Valid values are `^[0-9]{3,5}[A-Z]?$`',
    `course_subject` STRING COMMENT 'Discipline subject prefix code for the course (e.g., MATH, ENGL, BIOL). Denormalized from the course catalog for reporting convenience and IPEDS CIP code alignment.. Valid values are `^[A-Z]{2,6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this registration record was first created in the data platform. Supports audit trail, data lineage, and Silver Layer ingestion tracking.',
    `credit_hours_attempted` DECIMAL(18,2) COMMENT 'Number of credit hours the student is attempting for this course section registration. Used in FTE calculations, financial aid SAP evaluation, and IPEDS credit hour reporting.',
    `crn` STRING COMMENT 'Banner Course Reference Number uniquely identifying the course section within a term. The primary operational identifier used by students and registrar staff.. Valid values are `^[A-Z0-9]{4,6}$`',
    `department_code` STRING COMMENT 'Code identifying the academic department responsible for the course section. Used for departmental enrollment analytics, faculty workload reporting, and budget allocation.',
    `drop_timestamp` TIMESTAMP COMMENT 'Date and time when the student dropped this course section. A drop before the census date typically results in no academic record; after census date may result in a W grade. Critical for DFW rate calculation.',
    `enrollment_type` STRING COMMENT 'Enrollment intensity classification for the student in this term based on total credit hours. Affects financial aid disbursement thresholds, SAP evaluation, and IPEDS enrollment category reporting.. Valid values are `full_time|part_time|less_than_half_time|half_time`',
    `final_grade` STRING COMMENT 'Official final grade awarded for the course registration as recorded on the academic transcript. Drives GPA calculation, SAP evaluation, and degree audit. Values are institution-defined (A, B, C, D, F, W, I, etc.).',
    `financial_aid_eligible_flag` BOOLEAN COMMENT 'Indicates whether this course registration counts toward the students financial aid eligible enrollment intensity. Courses not meeting aid eligibility criteria (e.g., non-credit, repeated beyond limit) are flagged false.',
    `fte_contribution` DECIMAL(18,2) COMMENT 'Fractional FTE value contributed by this registration record, calculated as credit_hours_attempted divided by the full-time credit hour threshold (typically 15 for undergrad, 9 for grad). Used in IPEDS FTE reporting and state funding formulas.',
    `grade_mode` STRING COMMENT 'Grading basis elected by the student for this registration. Determines how the course outcome is recorded on the academic transcript and whether it affects GPA calculation.. Valid values are `standard|pass_fail|audit|satisfactory_unsatisfactory|no_grade`',
    `grade_points` DECIMAL(18,2) COMMENT 'Numeric grade point value assigned to the final grade for this registration (e.g., A=4.0, B=3.0). Used in GPA calculation. Stored at the registration level to support historical GPA reconstruction.',
    `incomplete_expiry_date` DATE COMMENT 'Deadline by which the student must complete outstanding coursework to resolve an Incomplete (I) grade. After this date, the grade typically converts to a failing grade per institutional policy.',
    `instructional_method` STRING COMMENT 'Mode of instruction for the course section in which the student is registered. Required for IPEDS distance education reporting and accreditation compliance.. Valid values are `in_person|online|hybrid|hyflex|correspondence`',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent change to the registration status. Supports audit trail and change history analysis for compliance and operational reporting.',
    `lms_enrollment_code` STRING COMMENT 'Corresponding enrollment record identifier in Canvas LMS. Enables cross-system linkage between the Banner registration record and the Canvas course enrollment for analytics and grade passback.',
    `midterm_grade` STRING COMMENT 'Interim grade assigned at midterm for early alert and academic intervention purposes. Not a final transcript grade; used by advisors and retention programs to identify at-risk students.',
    `override_authorized_by` STRING COMMENT 'Username or staff ID of the advisor, faculty member, or registrar staff who authorized the registration override. Required for audit trail and accountability reporting.',
    `override_type` STRING COMMENT 'Type of registration restriction that was overridden to allow this enrollment. Tracks exceptions granted by advisors or registrar staff for compliance and audit purposes.. Valid values are `capacity|prerequisite|time_conflict|major_restriction|level_restriction|none`',
    `pidm` BIGINT COMMENT 'Ellucian Banner internal Person IDentification Master number uniquely identifying the student across all Banner modules. Restricted as it is a system-of-record personal identifier.',
    `registration_source` STRING COMMENT 'Channel or mechanism through which the registration was initiated. Distinguishes student self-service (Banner SSB), registrar staff entry, advisor override, or automated batch/API load.. Valid values are `web_self_service|registrar_office|advisor_override|batch_load|api`',
    `registration_status` STRING COMMENT 'Current enrollment status of the student in the course section. Drives headcount, FTE calculations, and DFW rate reporting. [ENUM-REF-CANDIDATE: registered|dropped|withdrawn|audit|waitlisted|pass_fail|incomplete|cancelled — promote to reference product]. Valid values are `registered|dropped|withdrawn|audit|waitlisted|pass_fail`',
    `registration_timestamp` TIMESTAMP COMMENT 'Date and time when the student initially registered for the course section. The principal business event timestamp for this transaction. Used for priority registration analysis and add/drop period compliance.',
    `repeat_course_count` STRING COMMENT 'Number of times the student has previously attempted this course, including the current registration. Used to enforce institutional repeat policies and Title IV financial aid repeat course limits.',
    `repeat_indicator` BOOLEAN COMMENT 'Indicates whether this registration is a repeated attempt of a course the student has previously enrolled in. Affects GPA recalculation policies and financial aid eligibility under SAP rules.',
    `sap_applicable_flag` BOOLEAN COMMENT 'Indicates whether this registration is included in the students Satisfactory Academic Progress (SAP) evaluation for Title IV financial aid purposes. Excludes audit and certain non-credit enrollments.',
    `section_number` STRING COMMENT 'Alphanumeric identifier distinguishing this section from other sections of the same course in the same term (e.g., 001, 002, H01 for honors). Used in student schedules and registrar operations.',
    `student_level` STRING COMMENT 'Academic level of the student at the time of registration. Determines applicable tuition rates, financial aid eligibility, and IPEDS reporting category.. Valid values are `undergraduate|graduate|professional|doctoral|non_degree`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this registration record was last modified in the data platform. Used for incremental ETL processing and change data capture in the Databricks Silver Layer.',
    `waitlist_position` STRING COMMENT 'Numeric position of the student on the course section waitlist when registration_status is waitlisted. Null when not on waitlist. Used to manage seat availability and notify students of openings.',
    `withdraw_timestamp` TIMESTAMP COMMENT 'Date and time when the student officially withdrew from this course section after the drop deadline, resulting in a W grade on the transcript. Used in DFW rate and retention analytics.',
    CONSTRAINT pk_enrollment_registration PRIMARY KEY(`enrollment_registration_id`)
) COMMENT 'Core transactional record of a students enrollment in a specific course section for a given term. Captures registration date/time, registration status (registered, dropped, withdrawn, audit, pass/fail), credit hours attempted, grade mode, repeat indicator, add/drop/withdraw timestamps, registration source (web self-service, registrar office, advisor override), and Banner SFRSTCR record linkage. This is the primary enrollment transaction and the authoritative source for headcount and credit hour reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`waitlist_entry` (
    `waitlist_entry_id` BIGINT COMMENT 'Unique surrogate identifier for each waitlist entry record in the course section waitlist system. Primary key for the waitlist_entry data product.',
    `course_section_id` BIGINT COMMENT 'Reference to the specific course section for which the student is waitlisted. A section is a scheduled offering of a course in a given term with an assigned instructor and meeting pattern.',
    `enrollment_registration_id` BIGINT COMMENT 'Foreign key linking to enrollment.registration. Business justification: When a student is enrolled from a course waitlist (auto_enrolled_flag = true), this FK links the waitlist entry to the registration record that was created. This enables tracking of waitlist-to-enroll',
    `profile_id` BIGINT COMMENT 'Reference to the student who holds this waitlist position. Links to the student master record in Banner (PIDM-derived surrogate).',
    `term_id` BIGINT COMMENT 'Reference to the academic term (semester, quarter, or session) in which the waitlisted course section is offered. Supports term-based enrollment cycle processing.',
    `academic_level` STRING COMMENT 'The students academic level at the time of waitlist entry. Used to enforce enrollment eligibility rules and section-level restrictions (e.g., graduate-only sections).. Valid values are `undergraduate|graduate|doctoral|professional|non_degree`',
    `added_timestamp` TIMESTAMP COMMENT 'Date and time when the student was placed on the course section waitlist. This is the principal business event timestamp establishing the students queue position and priority.',
    `auto_enroll_eligible_flag` BOOLEAN COMMENT 'Indicates whether the student is eligible for automatic enrollment into the course section when a seat becomes available, without requiring manual acceptance. Eligibility is determined by Banner registration rules, holds, and student consent.',
    `auto_enrolled_flag` BOOLEAN COMMENT 'Indicates whether the student was automatically enrolled into the course section via the Banner automated waitlist processing job, as opposed to manually accepting a seat offer.',
    `auto_enrolled_timestamp` TIMESTAMP COMMENT 'Date and time when the student was automatically enrolled into the course section by the Banner automated waitlist processing job. Null if auto-enrollment did not occur.',
    `banner_waitlist_ref` STRING COMMENT 'Source system record identifier from Ellucian Banner Registration module (SFRSTCR/SSBSECT waitlist sequence key). Used for reconciliation and ETL traceability back to the system of record.',
    `college_code` STRING COMMENT 'Institutional college or school code owning the course section (e.g., BUS for College of Business, ENG for College of Engineering). Supports college-level waitlist capacity and demand reporting.',
    `course_number` STRING COMMENT 'Numeric or alphanumeric course number within the subject (e.g., 101, 301W). Combined with subject_code forms the human-readable course identifier (e.g., MATH 301).',
    `course_reference_number` STRING COMMENT 'Banner Course Reference Number (CRN) uniquely identifying the course section within a term. The CRN is the primary operational identifier used by students and staff during registration.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the waitlist entry record was first created in the data platform. Serves as the audit creation timestamp for data lineage and compliance purposes.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Number of credit hours (CR) associated with the waitlisted course section. Used to assess impact on the students total enrolled credit load and full-time equivalent (FTE) calculations upon enrollment.',
    `department_code` STRING COMMENT 'Academic department code responsible for the course section. Used for departmental waitlist management, override approvals, and capacity planning.',
    `enrollment_type` STRING COMMENT 'The students intended enrollment type for the waitlisted section, indicating full-time or part-time status and instructional delivery mode. Relevant for FTE calculations and financial aid eligibility.. Valid values are `full_time|part_time|online|hybrid`',
    `entry_status` STRING COMMENT 'Current lifecycle status of the waitlist entry. active = student is waiting; offered = seat offer extended; accepted = student accepted the seat offer; declined = student declined the offer; expired = offer deadline passed without response; cancelled = student removed themselves or was administratively removed.. Valid values are `active|offered|accepted|declined|expired|cancelled`',
    `ferpa_disclosure_flag` BOOLEAN COMMENT 'Indicates whether the student has an active FERPA disclosure restriction on file that limits sharing of this enrollment-related record with third parties. Governs data access controls for this waitlist entry in compliance with FERPA regulations.',
    `financial_aid_impact_flag` BOOLEAN COMMENT 'Indicates whether enrollment from this waitlist entry would affect the students financial aid eligibility or Satisfactory Academic Progress (SAP) status, such as pushing the student above or below full-time credit thresholds.',
    `grading_mode` STRING COMMENT 'The grading basis the student intends to use for the waitlisted course section upon enrollment (e.g., standard letter grade, pass/fail, audit). Captured at waitlist entry to preserve student intent.. Valid values are `standard|pass_fail|audit|credit_no_credit`',
    `notification_channel` STRING COMMENT 'The communication channel used to deliver the seat offer notification to the student. Supports multi-channel notification workflows in Banner and integrated CRM systems.. Valid values are `email|sms|portal|email_sms`',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a seat offer notification has been sent to the student via the configured communication channel (email, SMS, or student portal). True = notification dispatched; False = not yet sent.',
    `notification_timestamp` TIMESTAMP COMMENT 'Date and time when the seat offer notification was sent to the student. Null if notification_sent_flag is False.',
    `offer_expiration_timestamp` TIMESTAMP COMMENT 'Date and time by which the student must accept or decline the seat offer before it expires and is passed to the next student on the waitlist. Configurable per term and course level.',
    `offer_extended_timestamp` TIMESTAMP COMMENT 'Date and time when a seat offer was formally extended to the student, triggered by a vacancy opening in the course section. Null if no offer has been made.',
    `prerequisite_verified_flag` BOOLEAN COMMENT 'Indicates whether the students prerequisites for the waitlisted course have been verified as satisfied. A False value may block auto-enrollment even when a seat becomes available.',
    `priority_reason` STRING COMMENT 'Descriptive reason for priority waitlist status when waitlist_type is priority or department_override. Examples include graduating senior, required for major, department chair approval. Null for standard waitlist entries.',
    `registration_hold_flag` BOOLEAN COMMENT 'Indicates whether the student has an active registration hold in Banner that would prevent automatic enrollment even if a seat becomes available. Holds may include financial, academic, or administrative blocks.',
    `removal_reason` STRING COMMENT 'Reason the student was removed from the waitlist. [ENUM-REF-CANDIDATE: enrolled|declined_offer|offer_expired|student_withdrew|admin_removed|registration_hold|prerequisite_failed — promote to reference product]',
    `removal_timestamp` TIMESTAMP COMMENT 'Date and time when the student was removed from the waitlist, regardless of reason (enrolled, declined, expired, withdrew, or administratively removed). Null if the entry is still active.',
    `section_capacity` STRING COMMENT 'Maximum enrollment capacity of the course section at the time the student was added to the waitlist. Provides context for waitlist depth analysis and seat availability forecasting.',
    `section_number` STRING COMMENT 'Section identifier distinguishing multiple offerings of the same course in a term (e.g., 001, 002, W01 for online). Used alongside subject_code and course_number to fully identify the section.',
    `student_response` STRING COMMENT 'The students explicit response to the seat offer: accepted = student confirmed enrollment; declined = student declined the seat; no_response = offer expired without a response.. Valid values are `accepted|declined|no_response`',
    `student_response_timestamp` TIMESTAMP COMMENT 'Date and time when the student responded to the seat offer (accepted or declined). Null if no response has been recorded.',
    `subject_code` STRING COMMENT 'Alphabetic subject/discipline code for the course (e.g., MATH, ENGL, CS). Supports domain-level waitlist analysis and reporting by academic department.. Valid values are `^[A-Z]{2,8}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the waitlist entry record was last modified in the data platform. Tracks changes to status, position, notification flags, and offer details for audit and change-data-capture purposes.',
    `waitlist_capacity` STRING COMMENT 'Maximum number of students permitted on the waitlist for the course section, as configured in Banner SSBSECT. When the waitlist reaches this limit, no further students may join.',
    `waitlist_pool_size` STRING COMMENT 'Total number of students on the waitlist for the course section at the time this entry was created. Provides context for the students relative position and likelihood of enrollment.',
    `waitlist_position` STRING COMMENT 'Ordinal position of the student on the course section waitlist, where 1 indicates the next student to be offered a seat. Position is recalculated dynamically as students ahead are enrolled or removed.',
    `waitlist_type` STRING COMMENT 'Classification of the waitlist entry type: standard = general first-come-first-served queue; priority = student has been granted priority waitlist status (e.g., graduating senior, major requirement); department_override = department-initiated placement bypassing standard queue.. Valid values are `standard|priority|department_override`',
    CONSTRAINT pk_waitlist_entry PRIMARY KEY(`waitlist_entry_id`)
) COMMENT 'Tracks a students position on a course section waitlist when the section is at capacity. Captures waitlist position number, date/time added to waitlist, notification sent flag, notification timestamp, offer expiration date/time, offer accepted/declined status, and auto-enroll eligibility flag. Supports automated waitlist processing and seat offer workflows in Banner registration module.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`add_drop_transaction` (
    `add_drop_transaction_id` BIGINT COMMENT 'Unique surrogate identifier for each immutable add, drop, or withdrawal transaction record in the enrollment registration audit trail. Primary key for this product.',
    `charge_adjustment_id` BIGINT COMMENT 'Foreign key linking to billing.charge_adjustment. Business justification: Add/drop transactions trigger tuition adjustments and refund calculations per institutional refund schedule. Links enrollment action to billing adjustment for audit trail, refund percentage applicatio',
    `course_section_id` BIGINT COMMENT 'Reference to the specific course section (CRN) that was added, dropped, or withdrawn from in this transaction.',
    `employee_id` BIGINT COMMENT 'Reference to the user (student, advisor, or registrar staff) who performed this registration transaction.',
    `enrollment_registration_id` BIGINT COMMENT 'Foreign key linking to enrollment.registration. Business justification: Add/drop transaction is an immutable audit record of changes to a registration. This FK links the transaction to the registration record it modifies, enabling complete registration change history and ',
    `profile_id` BIGINT COMMENT 'Reference to the student whose course registration was affected by this transaction. Links to the student master record.',
    `r2t4_calculation_id` BIGINT COMMENT 'Foreign key linking to aid.r2t4_calculation. Business justification: Complete withdrawals trigger Return of Title IV (R2T4) calculations per federal regulation. Links withdrawal transactions to aid return calculations. Operational for institutional/student return amoun',
    `term_id` BIGINT COMMENT 'Reference to the academic term during which this registration transaction occurred.',
    `academic_period_week` STRING COMMENT 'The week number within the academic term during which this transaction occurred (e.g., Week 1, Week 8). Enables analysis of add/drop/withdrawal patterns by week of term for retention early-alert and DFW rate reporting.',
    `banner_sfrstcr_key` STRING COMMENT 'The composite source system key from Ellucian Banners SFRSTCR (Student Course Registration) table, used for lineage tracing and ETL reconciliation between the lakehouse silver layer and the Banner SIS source of record.',
    `course_number` STRING COMMENT 'The catalog course number of the section affected by this transaction (e.g., 101, 301, 4500). Combined with course_subject_code to form the full course identifier (e.g., MATH 101). Denormalized for reporting.',
    `course_subject_code` STRING COMMENT 'The subject/discipline code of the course section affected by this transaction (e.g., MATH, ENGL, BIOL). Denormalized for DFW rate analysis and enrollment reporting by discipline without requiring section joins.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this add/drop transaction record was first written to the data lakehouse silver layer. Represents the ETL ingestion time, distinct from transaction_timestamp which captures the business event time in Banner.',
    `credit_hours_after` DECIMAL(18,2) COMMENT 'The number of credit hours (CR) associated with the section after this transaction is applied. Zero for drop/withdraw transactions. For credit_change transactions, reflects the newly registered credit value. Drives FTE and SAP calculations.',
    `credit_hours_before` DECIMAL(18,2) COMMENT 'The number of credit hours (CR) the student was enrolled in for the section prior to this transaction. For variable-credit courses, captures the previously registered credit value. Used in FTE calculations and SAP monitoring.',
    `crn` STRING COMMENT 'The Course Reference Number uniquely identifying the course section within a term in Ellucian Banner. Denormalized for direct reporting and audit queries without requiring a join to the section dimension.',
    `dfw_flag` BOOLEAN COMMENT 'Indicates whether this transaction contributes to the DFW (D-grade, F-grade, Withdrawal) rate metric for the associated course section. True = this drop or withdrawal counts as a DFW event for institutional analytics and accreditation reporting.',
    `effective_date` DATE COMMENT 'The calendar date on which the registration change takes effect for academic and financial purposes. May differ from transaction_timestamp when a registrar processes a backdated adjustment.',
    `financial_aid_impact_flag` BOOLEAN COMMENT 'Indicates whether this transaction triggered a review or recalculation of the students financial aid package. True = financial aid office was notified or a recalculation was initiated. Critical for Satisfactory Academic Progress (SAP) monitoring and Title IV compliance.',
    `fte_after` DECIMAL(18,2) COMMENT 'The students Full-Time Equivalent (FTE) enrollment value calculated from total term credit hours after this transaction is applied. Paired with fte_before to measure the FTE impact of each registration action for IPEDS and state funding reporting.',
    `fte_before` DECIMAL(18,2) COMMENT 'The students Full-Time Equivalent (FTE) enrollment value calculated from total term credit hours prior to this transaction. Computed as total_credit_hours / FTE_divisor (12 for undergraduate, 9 for graduate). Used in IPEDS FTE reporting and state funding formulas.',
    `grade_mode_after` STRING COMMENT 'The grading mode applied to the student-section record as a result of this transaction. Paired with grade_mode_before to capture the complete grade mode transition for grade_mode_change transactions.. Valid values are `GR|PF|AU|SA`',
    `grade_mode_before` STRING COMMENT 'The grading mode in effect for the student-section record prior to this transaction. GR=Standard Graded, PF=Pass/Fail, AU=Audit, SA=Satisfactory/Unsatisfactory. Relevant for grade_mode_change transactions.. Valid values are `GR|PF|AU|SA`',
    `initiator_role` STRING COMMENT 'The role of the user who initiated this registration transaction. Distinguishes self-service student actions from advisor-directed changes, registrar administrative overrides, automated system processes, or faculty-initiated actions.. Valid values are `student|advisor|registrar|system|faculty`',
    `ipeds_enrollment_status` STRING COMMENT 'The students Integrated Postsecondary Education Data System (IPEDS) enrollment status after this transaction is applied, based on total enrolled credit hours for the term. full_time = 12+ undergraduate or 9+ graduate credit hours; part_time = below full-time threshold; not_enrolled = zero credit hours remaining.. Valid values are `full_time|part_time|not_enrolled`',
    `is_after_withdraw_deadline` BOOLEAN COMMENT 'Indicates whether this transaction occurred after the last day to withdraw without academic penalty. True = late withdrawal subject to W or WF grade assignment; False = within the standard withdrawal window. Drives DFW rate calculations and academic standing determinations.',
    `is_before_refund_deadline` BOOLEAN COMMENT 'Indicates whether this transaction occurred before the institutional tuition refund deadline for the term. True = transaction is within the refund window; False = transaction occurred after the refund deadline. Critical for Student Accounts billing adjustments and NACUBO refund policy compliance.',
    `is_complete_withdrawal` BOOLEAN COMMENT 'Indicates whether this transaction represents or contributes to a complete withdrawal from all courses for the term (total withdrawal). True = student is withdrawing from all enrolled sections. Triggers specific financial aid return-to-Title-IV (R2T4) calculations.',
    `new_registration_status` STRING COMMENT 'The Banner registration status code (STVRSTS) applied to the student-section record as a result of this transaction. Paired with prior_registration_status to form the complete state transition record. [ENUM-REF-CANDIDATE: RE|DD|DN|WD|AU|WF|WN — 7 candidates stripped; promote to reference product]',
    `override_flag` BOOLEAN COMMENT 'Indicates whether this transaction required an administrative override of a system-enforced registration restriction (e.g., prerequisite override, capacity override, time conflict override, holds override). True = at least one restriction was overridden to complete this transaction.',
    `override_type` STRING COMMENT 'Specifies the type of registration restriction that was overridden when override_flag is True. Values: prerequisite (prerequisite not met), capacity (section full), time_conflict (schedule overlap), hold (student account hold bypassed), level (student level restriction), college (college restriction), none (no override applied). [ENUM-REF-CANDIDATE: prerequisite|capacity|time_conflict|hold|level|college|none — 7 candidates stripped; promote to reference product]',
    `prior_registration_status` STRING COMMENT 'The Banner registration status code (STVRSTS) that was in effect for the student-section record immediately before this transaction was applied. Enables before/after audit comparison. Common codes: RE=Registered, DD=Dropped, DN=Dropped No Refund, WD=Withdrawn, AU=Audit, WF=Withdrawn Failing, WN=Withdrawn Not Failing. [ENUM-REF-CANDIDATE: RE|DD|DN|WD|AU|WF|WN — 7 candidates stripped; promote to reference product]',
    `processing_channel` STRING COMMENT 'The channel through which this registration transaction was submitted. web_self_service = student self-service portal; registrar_office = in-person or phone processing by registrar staff; advisor_portal = advisor-initiated via advising system; batch_process = automated system batch; api = programmatic API integration.. Valid values are `web_self_service|registrar_office|advisor_portal|batch_process|api`',
    `r2t4_required_flag` BOOLEAN COMMENT 'Indicates whether this transaction triggers a Return to Title IV (R2T4) funds calculation per U.S. Department of Education regulations. True = financial aid office must perform R2T4 calculation within 30 days. Applies when is_complete_withdrawal is True and student received Title IV aid.',
    `reason_code` STRING COMMENT 'Standardized institutional code indicating the business reason for the registration action (e.g., SCHED_CONFLICT, FINANCIAL, MEDICAL, ACADEMIC_DIFFICULTY, ADVISOR_DIRECTED, ADMIN_CORRECTION). Supports DFW rate analysis and retention reporting. [ENUM-REF-CANDIDATE: SCHED_CONFLICT|FINANCIAL|MEDICAL|ACADEMIC_DIFFICULTY|ADVISOR_DIRECTED|ADMIN_CORRECTION|PERSONAL|PROGRAM_CHANGE — promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text narrative provided by the student, advisor, or registrar staff explaining the reason for the registration action. Supplements the structured reason_code with additional context.',
    `refund_percentage` DECIMAL(18,2) COMMENT 'The percentage of tuition charges eligible for refund based on the institutional refund schedule at the time of this transaction (e.g., 100.00, 75.00, 50.00, 25.00, 0.00). Determined by the effective_date relative to the term refund schedule. Used by Student Accounts for billing adjustments.',
    `sap_impact_flag` BOOLEAN COMMENT 'Indicates whether this transaction affects the students Satisfactory Academic Progress (SAP) calculation for financial aid eligibility. True = the credit hour change from this transaction must be factored into the SAP completion rate and maximum timeframe calculations.',
    `transaction_number` STRING COMMENT 'Externally visible, human-readable reference number assigned to this registration transaction by the Student Information System (SIS). Used for audit inquiries and student-facing receipts.',
    `transaction_status` STRING COMMENT 'Current lifecycle state of this registration transaction. Completed indicates the action was successfully applied; reversed indicates a subsequent corrective action nullified this transaction; failed indicates a system or rule rejection.. Valid values are `completed|pending|reversed|failed|cancelled`',
    `transaction_timestamp` TIMESTAMP COMMENT 'The precise date and time (with timezone offset) at which the registration action was executed in the Student Information System. This is the principal business event timestamp for this record.',
    `transaction_type` STRING COMMENT 'Classifies the nature of the registration action: add (enrolling in a section), drop (removing before drop deadline), withdraw (removing after drop deadline with W grade), grade_mode_change (switching between graded/pass-fail/audit), credit_change (modifying variable credit hours), or audit_change (changing to audit status).. Valid values are `add|drop|withdraw|grade_mode_change|credit_change|audit_change`',
    `tuition_adjustment_amount` DECIMAL(18,2) COMMENT 'The dollar amount of tuition charge adjustment (credit or debit) generated on the students account as a result of this registration transaction. Negative values indicate a credit to the student account. Feeds Oracle PeopleSoft Financials AR module.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this record was last modified in the data lakehouse silver layer, such as when a status correction or reversal was applied. Supports incremental ETL processing and audit trail completeness.',
    CONSTRAINT pk_add_drop_transaction PRIMARY KEY(`add_drop_transaction_id`)
) COMMENT 'Immutable audit record of every add, drop, or withdrawal action performed on a students registration during a term. Captures transaction type (add/drop/withdraw/grade-mode-change/credit-change), transaction timestamp, initiating user (student/advisor/registrar), reason code, effective date, prior status, new status, and whether the action occurred before or after the refund deadline. Supports DFW rate tracking, financial aid SAP calculations, and regulatory reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`census` (
    `census_id` BIGINT COMMENT 'Unique surrogate identifier for each enrollment census snapshot record. Primary key for the enrollment_census data product in the Databricks Silver Layer.',
    `ipeds_submission_id` BIGINT COMMENT 'The IPEDS data collection submission identifier assigned by the U.S. Department of Education when this census record was submitted as part of the Fall Enrollment or 12-Month Enrollment survey. Null if not yet submitted.',
    `org_unit_id` BIGINT COMMENT 'Reference to the academic college or school unit for which this census breakdown is recorded. Enables college-level enrollment reporting.',
    `term_id` BIGINT COMMENT 'Reference to the academic term for which this census snapshot was captured. Links to the academic term master record.',
    `academic_year` STRING COMMENT 'Academic year in which this census falls, formatted as YYYY-YYYY (e.g., 2024-2025). Used for year-over-year trend analysis and IPEDS annual reporting.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `accreditation_submission_flag` BOOLEAN COMMENT 'Indicates whether this census record has been included in an accreditation data submission (e.g., HLC Annual Institutional Data Update, SACSCOC Fifth-Year Interim Report). True when submitted.',
    `attendance_type` STRING COMMENT 'Enrollment attendance classification for this census record: full-time, part-time, or combined (all). Full-time/part-time distinction is required for FTE calculation and IPEDS reporting.. Valid values are `full_time|part_time|all`',
    `census_date` DATE COMMENT 'The official point-in-time date on which enrollment counts were frozen for this snapshot. This is the authoritative date used for IPEDS reporting, state funding formulas, and accreditation submissions. Distinct from the date the record was created.',
    `census_number` STRING COMMENT 'Externally-known business identifier for this census snapshot record, typically formatted as TERM_CODE-CENSUS_TYPE (e.g., 202410-OFFICIAL). Used for audit trails and cross-system reconciliation.',
    `census_status` STRING COMMENT 'Current lifecycle state of this census record. Locked indicates the record is frozen and immutable for regulatory submission. Superseded indicates a newer revision has replaced this record.. Valid values are `draft|finalized|submitted|locked|superseded`',
    `census_type` STRING COMMENT 'Classification of the census snapshot indicating whether it is the official frozen record, a preliminary estimate, a post-census revision, or a supplemental count. Only official records are submitted to IPEDS and state agencies.. Valid values are `official|preliminary|revised|supplemental`',
    `continuing_headcount` STRING COMMENT 'Count of students who were enrolled in a prior term at this institution and are continuing enrollment in the current term. Used for retention analysis and year-over-year enrollment trend reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this census record was first created in the data platform. Audit trail field for data lineage and Silver Layer processing tracking.',
    `credit_hours_total` DECIMAL(18,2) COMMENT 'Sum of all credit hours (CR) enrolled by students included in this census record as of the census date. Used as the numerator in FTE calculations and for state funding formula submissions.',
    `finalized_timestamp` TIMESTAMP COMMENT 'The date and time at which this census record was officially finalized and locked. Represents the principal business event time — when the enrollment count was frozen and became the authoritative official record.',
    `first_generation_headcount` STRING COMMENT 'Count of students who are the first in their immediate family to attend a postsecondary institution as of the census date. Used for equity reporting, Title III/V grant compliance, and student success program targeting.',
    `fte_count` DECIMAL(18,2) COMMENT 'Full-Time Equivalent enrollment count calculated by dividing total credit hours by the standard full-time credit hour load (typically 15 for undergraduates, 12 for graduate). Used for state funding formulas, IPEDS FTE reporting, and institutional benchmarking via NACUBO.',
    `ftiac_headcount` STRING COMMENT 'Count of students who have never previously attended any postsecondary institution, enrolling for the first time in this term. FTIAC is a key IPEDS metric and is used for cohort-based retention and graduation rate calculations.',
    `full_time_headcount` STRING COMMENT 'Count of students enrolled full-time as of the census date. Full-time is defined as 12+ credit hours for undergraduates and 9+ for graduate students per IPEDS standards.',
    `graduate_fte` DECIMAL(18,2) COMMENT 'FTE count for graduate students only, calculated as total graduate credit hours divided by 12 (standard full-time load). Used for state funding formula submissions and IPEDS graduate FTE reporting.',
    `headcount` STRING COMMENT 'Total unduplicated student headcount as of the census date for the specified level, attendance type, and residency combination. Each student is counted once regardless of the number of courses enrolled. Primary metric for IPEDS headcount reporting.',
    `headcount_variance` STRING COMMENT 'Difference between current term headcount and prior term headcount (headcount minus prior_term_headcount). Stored as a pre-computed field on the frozen census record for regulatory submission packages and executive dashboards. Positive values indicate enrollment growth.',
    `hybrid_headcount` STRING COMMENT 'Count of students enrolled in some but not all distance education courses (hybrid/blended modality) as of the census date. Required for IPEDS distance education breakdown reporting.',
    `in_state_headcount` STRING COMMENT 'Count of students classified as in-state residents as of the census date. Used for state funding formula submissions and tuition revenue analysis.',
    `institution_code` BIGINT COMMENT 'Reference to the institution or campus unit for which this census record applies. Supports multi-campus reporting.',
    `instructional_method` STRING COMMENT 'Delivery modality breakdown for this census record. IPEDS requires separate reporting of exclusively distance education, some distance education, and no distance education enrollments.. Valid values are `in_person|online|hybrid|correspondence|all`',
    `international_headcount` STRING COMMENT 'Count of students classified as international (non-immigrant visa holders) as of the census date. Used for IPEDS reporting, visa compliance tracking, and international enrollment strategy.',
    `new_student_headcount` STRING COMMENT 'Count of students enrolling for the first time at this institution in this term, including First-Time-In-Any-College (FTIAC) and transfer students. Used for cohort tracking and IPEDS first-time student reporting.',
    `notes` STRING COMMENT 'Free-text notes recorded by institutional research staff regarding anomalies, adjustments, or contextual information about this census snapshot (e.g., late registration extensions, system corrections, natural disaster impacts on enrollment).',
    `online_exclusive_headcount` STRING COMMENT 'Count of students enrolled exclusively in distance education (online) courses as of the census date. Required for IPEDS distance education reporting and accreditation submissions.',
    `out_of_state_headcount` STRING COMMENT 'Count of students classified as out-of-state residents as of the census date. Used for tuition revenue analysis and enrollment mix reporting.',
    `part_time_headcount` STRING COMMENT 'Count of students enrolled part-time as of the census date. Part-time is defined as fewer than 12 credit hours for undergraduates and fewer than 9 for graduate students per IPEDS standards.',
    `pell_eligible_headcount` STRING COMMENT 'Count of students who are Pell Grant eligible as of the census date. Used for financial aid reporting, Title IV compliance, and institutional equity analytics.',
    `prior_term_headcount` STRING COMMENT 'Official headcount from the equivalent prior-year term census record. Stored on this record to enable direct year-over-year variance calculation without requiring a self-join. Populated during census finalization.',
    `readmit_headcount` STRING COMMENT 'Count of students who previously attended this institution, stopped out for at least one term, and have been readmitted and are enrolling in the current term.',
    `reporting_level` STRING COMMENT 'Granularity level at which this census record is aggregated. Institution-level records represent total unduplicated headcount; college/department/program levels represent sub-unit breakdowns.. Valid values are `institution|college|department|program`',
    `residency_status` STRING COMMENT 'Residency classification for this census record. Drives state funding formula allocations, tuition revenue projections, and IPEDS enrollment by residency reporting.. Valid values are `in_state|out_of_state|international|all`',
    `source_system` STRING COMMENT 'Operational system of record from which this census data was extracted. Typically Ellucian Banner SIS for enrollment counts. Supports data lineage and reconciliation.. Valid values are `Banner|PeopleSoft|Manual|Other`',
    `stem_headcount` STRING COMMENT 'Count of students enrolled in Science, Technology, Engineering, and Mathematics (STEM) designated programs as of the census date. Used for STEM reporting to NSF, NIH, and institutional diversity/pipeline analytics.',
    `student_level` STRING COMMENT 'Academic level of students included in this census record. Used for IPEDS unduplicated headcount reporting by level and state funding formula calculations.. Valid values are `undergraduate|graduate|professional|doctoral`',
    `transfer_headcount` STRING COMMENT 'Count of students who previously attended another postsecondary institution and are enrolling at this institution for the first time in this term. Used for transfer cohort tracking and IPEDS reporting.',
    `undergraduate_fte` DECIMAL(18,2) COMMENT 'FTE count for undergraduate students only, calculated as total undergraduate credit hours divided by 15 (standard full-time load). Used for state funding formula submissions and IPEDS undergraduate FTE reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this census record was last modified in the data platform. Used to detect revisions and support incremental ETL processing in the Silver Layer.',
    `veteran_headcount` STRING COMMENT 'Count of students who are veterans or active-duty military personnel as of the census date. Required for VA education benefit compliance reporting and institutional veteran services planning.',
    CONSTRAINT pk_census PRIMARY KEY(`census_id`)
) COMMENT 'Point-in-time snapshot of enrollment counts captured at the official census date for each term. Records official headcount, FTE (Full-Time Equivalent) count, credit hours enrolled, unduplicated headcount by level (undergraduate/graduate/professional/doctoral), residency breakdown, and instructional method breakdown. Used for IPEDS reporting, state funding formulas, accreditation data submissions, and institutional research benchmarking. Distinct from live registration data — this is the frozen official record.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`student_term_record` (
    `student_term_record_id` BIGINT COMMENT 'Unique surrogate identifier for the student term record in the Silver Layer lakehouse. Primary key for this aggregate enrollment summary entity.',
    `academic_program_id` BIGINT COMMENT 'Reference to the students primary program of study for this term as declared in the Student Information System (SIS). Drives degree audit and accreditation reporting.',
    `accreditation_review_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_review. Business justification: Student outcome data (retention, progression, graduation rates) is core evidence for accreditation self-studies. Accreditation coordinators tag cohorts of student records to specific review cycles for',
    `aid_sap_evaluation_id` BIGINT COMMENT 'Foreign key linking to aid.sap_evaluation. Business justification: SAP evaluations assess term-by-term academic progress (GPA, completion rate, max timeframe). Operational link for aid eligibility determination, academic standing holds, and financial aid warning/susp',
    `campus_id` BIGINT COMMENT 'Foreign key linking to facility.campus. Business justification: Term enrollment records track campus attendance for each academic period. IPEDS enrollment reporting, state funding formulas, and campus-level enrollment census require this link. Campus_code denormal',
    `instructor_id` BIGINT COMMENT 'Reference to the primary academic advisor assigned to the student for this term. Used for advisor caseload reporting, early alert workflows, and retention intervention tracking.',
    `profile_id` BIGINT COMMENT 'Reference to the student master record. Corresponds to Banner PIDM (Person Identification Master) — the internal system-of-record identifier for the student.',
    `term_id` BIGINT COMMENT 'Reference to the academic term for which this enrollment summary applies (e.g., Fall 2024, Spring 2025). Drives all term-scoped calculations.',
    `academic_standing` STRING COMMENT 'Students academic standing at the end of the term as determined by institutional GPA and credit completion thresholds. Governs financial aid eligibility, registration holds, and institutional intervention programs.. Valid values are `good-standing|probation|suspension|dismissal|dean-list`',
    `academic_year` STRING COMMENT 'Academic year in which this term falls, formatted as YYYY-YYYY (e.g., 2024-2025). Used for annual IPEDS reporting, financial aid year alignment, and institutional analytics.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `athlete_flag` BOOLEAN COMMENT 'Indicates whether the student is a varsity athlete participating in an NCAA-sanctioned sport. Required for NCAA eligibility certification, academic progress rate (APR) reporting, and athletic scholarship compliance.',
    `attendance_type` STRING COMMENT 'Primary mode of instructional delivery for the students enrollment in this term. Drives Distance Education reporting for IPEDS, state authorization compliance, and financial aid eligibility for online programs.. Valid values are `on-campus|online|hybrid|correspondence`',
    `banner_pidm` BIGINT COMMENT 'Ellucian Banner internal Person Identification Master (PIDM) number. The authoritative cross-module identifier linking student records across Banner modules (Registration, Financial Aid, Academic History, Student Accounts).',
    `cip_code` STRING COMMENT 'Six-digit Classification of Instructional Programs (CIP) code identifying the students primary field of study for this term. Required for IPEDS completions reporting, STEM designation, and federal financial aid program eligibility.. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `class_level` STRING COMMENT 'Students class level classification for the term based on cumulative credit hours earned and degree program. Used for course eligibility, financial aid packaging, and IPEDS enrollment reporting. [ENUM-REF-CANDIDATE: freshman|sophomore|junior|senior|graduate|doctoral|professional|post-baccalaureate|non-degree — promote to reference product]',
    `cohort_code` STRING COMMENT 'Institutional cohort identifier assigned to the student (e.g., FTIAC Fall 2022, Transfer Fall 2023). Used for cohort-based retention, graduation rate tracking, and IPEDS Graduation Rate Survey reporting.',
    `college_code` STRING COMMENT 'Code identifying the academic college or school within the institution to which the students primary program belongs for this term (e.g., CAS = College of Arts and Sciences, COB = College of Business). Used for college-level enrollment reporting and accreditation (AACSB, ABET).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this student term record was first created in the Silver Layer lakehouse, typically populated during the end-of-term Banner SHRTTRM extract. Supports data lineage and audit trail requirements.',
    `credit_hours_attempted` DECIMAL(18,2) COMMENT 'Total credit hours (CR) the student attempted during the term, including courses with grades of W (withdrawal), F, and D. Used as the denominator in SAP pace calculation and enrollment intensity classification.',
    `credit_hours_earned` DECIMAL(18,2) COMMENT 'Total credit hours successfully completed (earned) during the term with a passing grade. Used in SAP pace/completion rate calculation and cumulative progress toward degree.',
    `cumulative_credit_hours_attempted` DECIMAL(18,2) COMMENT 'Total cumulative credit hours attempted by the student across all terms at the institution as of the end of this term. Used for SAP maximum timeframe evaluation and class level determination.',
    `cumulative_credit_hours_earned` DECIMAL(18,2) COMMENT 'Total cumulative credit hours earned by the student across all terms at the institution as of the end of this term. Used for degree audit, graduation eligibility, and class level classification.',
    `cumulative_gpa` DECIMAL(18,2) COMMENT 'Students cumulative Grade Point Average (GPA) across all terms at the institution as of the end of this term. Primary metric for academic standing, graduation eligibility, honors designation, and SAP qualitative standard evaluation.',
    `degree_type` STRING COMMENT 'Type of degree or credential the student is pursuing in their primary program for this term. Used for IPEDS completions, financial aid program eligibility, and accreditation reporting. [ENUM-REF-CANDIDATE: AA|AS|AAS|BA|BS|BFA|BBA|MA|MS|MBA|MFA|MEd|PhD|EdD|JD|MD|DNP|certificate|non-degree — promote to reference product]',
    `department_code` STRING COMMENT 'Code identifying the academic department associated with the students primary program for this term. Used for departmental enrollment analytics and faculty workload planning.',
    `dfw_count` STRING COMMENT 'Count of courses in which the student received a D grade, F grade, or Withdrawal (W) during the term. The DFW rate is a key institutional retention and academic success metric used in accreditation reporting and early alert systems.',
    `enrollment_status` STRING COMMENT 'Students enrollment intensity classification for the term based on credit hours attempted. Drives financial aid eligibility (Title IV), SAP evaluation, and IPEDS FTE reporting. Values align with U.S. Department of Education enrollment intensity definitions.. Valid values are `full-time|half-time|less-than-half-time|not-enrolled|withdrawn`',
    `financial_aid_applicant_flag` BOOLEAN COMMENT 'Indicates whether the student submitted a FAFSA (Free Application for Federal Student Aid) or institutional aid application for this term. Used to link enrollment records to financial aid packaging and SAP evaluation workflows.',
    `first_generation_flag` BOOLEAN COMMENT 'Indicates whether the student is a first-generation college student (neither parent holds a bachelors degree). Used for Title III/IV reporting, TRIO program eligibility, and institutional equity analytics.',
    `fte_value` DECIMAL(18,2) COMMENT 'Students Full-Time Equivalent (FTE) value for the term, calculated as credit hours attempted divided by the full-time credit hour threshold (typically 12 for undergraduate, 9 for graduate). Used for state funding formulas, IPEDS FTE reporting, and institutional resource planning.',
    `ftiac_flag` BOOLEAN COMMENT 'Indicates whether the student is a First-Time-In-Any-College (FTIAC) student. Required for IPEDS 12-Month Enrollment and Graduation Rate surveys and federal cohort default rate calculations.',
    `international_flag` BOOLEAN COMMENT 'Indicates whether the student holds a non-immigrant visa status (e.g., F-1, J-1) for this term. Drives SEVIS reporting requirements, international student services, and IPEDS international student enrollment counts.',
    `last_date_of_attendance` DATE COMMENT 'The last date on which the student attended class or participated in an academically related activity during the term. Required for Return to Title IV (R2T4) calculations when a student withdraws and for federal financial aid compliance.',
    `quality_points_cumulative` DECIMAL(18,2) COMMENT 'Total cumulative grade quality points earned across all terms at the institution as of the end of this term. Used as the numerator in cumulative GPA calculation.',
    `quality_points_term` DECIMAL(18,2) COMMENT 'Total grade quality points earned during the term, calculated as the sum of (grade points × credit hours) for each course. Used as the numerator in term GPA calculation.',
    `registration_hold_flag` BOOLEAN COMMENT 'Indicates whether the student has an active registration hold at the time of this term record snapshot. Holds may be academic (probation), financial (outstanding balance), or administrative. Used for enrollment management and student services workflows.',
    `residency_classification` STRING COMMENT 'Students tuition residency classification for the term as determined by the institutions residency policy. Drives tuition rate assessment, state funding formulas, and IPEDS residency reporting.. Valid values are `in-state|out-of-state|international|military|district`',
    `sap_status` STRING COMMENT 'Satisfactory Academic Progress (SAP) status for the term as required by Title IV federal financial aid regulations. Evaluates qualitative (GPA), quantitative (pace/completion rate), and maximum timeframe standards. Determines continued financial aid eligibility.. Valid values are `meeting|warning|probation|suspension|ineligible`',
    `source_system` STRING COMMENT 'Operational system of record from which this student term record was sourced. Primarily Ellucian Banner (SGBSTDN/SHRTTRM) for enrollment domain. Supports data lineage and ETL audit in the lakehouse.. Valid values are `Banner|PeopleSoft|Workday|manual`',
    `student_level` STRING COMMENT 'Broad academic level of the student for the term (undergraduate, graduate, professional, doctoral, non-degree). Distinct from class level — drives tuition rate schedules, financial aid programs, and accreditation reporting.. Valid values are `undergraduate|graduate|professional|doctoral|non-degree`',
    `term_gpa` DECIMAL(18,2) COMMENT 'Students Grade Point Average (GPA) calculated for the current term only, based on quality points earned divided by credit hours attempted with grade points. Protected under FERPA. Used for academic standing determination and Deans List eligibility.',
    `transfer_credit_hours_accepted` DECIMAL(18,2) COMMENT 'Total credit hours accepted from prior institutions via transfer credit evaluation. Included in cumulative hours for degree audit and class level but may be excluded from institutional GPA calculation per policy.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this student term record was last updated in the Silver Layer lakehouse, reflecting grade changes, academic standing recalculations, or SAP status updates post-term.',
    `veteran_flag` BOOLEAN COMMENT 'Indicates whether the student is a veteran or active-duty military member. Drives VA education benefits processing (GI Bill), Yellow Ribbon Program eligibility, and veteran services reporting.',
    `visa_type` STRING COMMENT 'Non-immigrant visa classification for international students. Required for SEVIS compliance reporting and determination of financial aid eligibility. Null for domestic students. [ENUM-REF-CANDIDATE: F-1|J-1|M-1|H-1B|H-4|O-1|domestic|other — 8 candidates stripped; promote to reference product]',
    `withdrawal_count` STRING COMMENT 'Number of courses from which the student officially withdrew during the term. Distinct from DFW count — used for financial aid Return to Title IV (R2T4) calculations and enrollment intensity adjustments.',
    CONSTRAINT pk_student_term_record PRIMARY KEY(`student_term_record_id`)
) COMMENT 'Aggregate enrollment record summarizing a students academic standing and enrollment status for a specific term. Captures enrollment status (full-time/part-time/less-than-half-time), total credit hours attempted, total credit hours earned, term GPA, cumulative GPA, academic standing (good standing/probation/suspension/dismissal), class level (freshman/sophomore/junior/senior/graduate), primary program of study, residency classification, and SAP (Satisfactory Academic Progress) status. Sourced from Banner SGBSTDN and SHRTTRM. Serves as the per-term academic summary for a student.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`registration_hold` (
    `registration_hold_id` BIGINT COMMENT 'Unique surrogate identifier for each registration hold record in the Silver Layer lakehouse. Primary key for this entity.',
    `ada_accommodation_id` BIGINT COMMENT 'Foreign key linking to compliance.ada_accommodation. Business justification: Registration holds may be placed pending ADA accommodation documentation or released once accommodations are approved. Disability services and registrar offices use this link to coordinate hold manage',
    `athletic_eligibility_id` BIGINT COMMENT 'Foreign key linking to athletics.athletic_eligibility. Business justification: Ineligible student-athletes must be blocked from registration until eligibility is restored. This link enables automated hold placement when eligibility certification fails (GPA, progress-toward-degre',
    `employee_id` BIGINT COMMENT 'Reference to the staff user or system process that released the hold. Supports accountability and audit trail requirements under FERPA.',
    `profile_id` BIGINT COMMENT 'Reference to the student whose account carries this hold. Links to the student master record.',
    `term_id` BIGINT COMMENT 'Academic term during which this hold is active or was placed. Used to scope hold enforcement to a specific enrollment cycle.',
    `academic_standing_trigger` STRING COMMENT 'Academic standing condition that triggered an academic hold, if applicable (e.g., probation, suspension, dismissal). Null or none for non-academic hold types. Supports Satisfactory Academic Progress (SAP) compliance reporting.. Valid values are `probation|suspension|dismissal|warning|none`',
    `advising_requirement_code` STRING COMMENT 'Code identifying the specific advising mandate that must be fulfilled to release an advising hold (e.g., NEWSTUDENT, PROBATION, MAJOR_CHANGE, PREREQ_REVIEW). Null for non-advising hold types.',
    `appeal_flag` BOOLEAN COMMENT 'Indicates whether the student has filed a formal appeal to contest or request waiver of this hold.',
    `appeal_status` STRING COMMENT 'Current status of the students appeal against this hold. Null if no appeal has been filed.. Valid values are `pending|approved|denied|withdrawn`',
    `banner_pidm` BIGINT COMMENT 'Ellucian Banner internal Person Identification Master number uniquely identifying the individual across all Banner modules. Required for cross-module joins in the source system.',
    `blocks_enrollment_verification` BOOLEAN COMMENT 'Indicates whether this hold prevents the issuance of enrollment verification letters or certifications to third parties such as employers or insurance providers.',
    `blocks_financial_aid` BOOLEAN COMMENT 'Indicates whether this hold prevents disbursement of financial aid funds or processing of financial aid awards. Relevant for Title IV compliance.',
    `blocks_graduation` BOOLEAN COMMENT 'Indicates whether this hold prevents the student from applying for graduation or having a degree conferred.',
    `blocks_registration` BOOLEAN COMMENT 'Indicates whether this hold prevents the student from adding, dropping, or modifying course registrations. Core enforcement flag for the registration workflow.',
    `blocks_transcript` BOOLEAN COMMENT 'Indicates whether this hold prevents the release of official or unofficial academic transcripts to the student or third parties.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this registration hold record was first created in the Silver Layer lakehouse. Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the outstanding balance amount (e.g., USD). Defaults to USD for domestic institutions.. Valid values are `^[A-Z]{3}$`',
    `expiration_date` DATE COMMENT 'Date on which the hold automatically expires if not manually released. Null indicates the hold has no automatic expiration and requires manual release. Corresponds to Banner SPRHOLD_TO_DATE.',
    `hold_description` STRING COMMENT 'Free-text narrative describing the specific reason for the hold, resolution steps required, or additional context provided by the originating office. Displayed to students and advisors.',
    `hold_notes` STRING COMMENT 'Internal staff notes providing additional context about the hold, resolution history, or special circumstances. Not displayed to students. Supports case management and inter-office communication.',
    `hold_number` STRING COMMENT 'Externally visible alphanumeric identifier for this hold record as assigned by the originating office or Banner. Used for student-facing communications and staff lookup.',
    `hold_severity` STRING COMMENT 'Severity level indicating how strictly the hold is enforced. hard blocks the restricted action entirely; soft generates a warning but allows the action to proceed; informational is advisory only with no system enforcement.. Valid values are `hard|soft|informational`',
    `hold_status` STRING COMMENT 'Current lifecycle state of the hold. active means the hold is currently enforced; released means it has been cleared; expired means it lapsed past its end date without manual release; pending means it is queued but not yet enforced; suspended means temporarily paused.. Valid values are `active|released|expired|pending|suspended`',
    `hold_type_code` STRING COMMENT 'Standardized code classifying the category of hold (e.g., FI=Financial, AC=Academic, AD=Advising, IM=Immunization, LB=Library, JD=Judicial, HO=Housing, IN=Insurance). Drives enforcement rules and routing. [ENUM-REF-CANDIDATE: FI|AC|AD|IM|LB|JD|HO|IN|OT — promote to reference product]',
    `hold_type_description` STRING COMMENT 'Human-readable label for the hold type code (e.g., Financial Hold, Academic Hold, Advising Hold). Sourced from the Banner STVHOLD validation table.',
    `is_auto_release_eligible` BOOLEAN COMMENT 'Indicates whether this hold is eligible for automated release when the triggering condition is resolved (e.g., balance paid, immunization record received). Drives automated release workflow processing.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the hold was placed by an automated batch process (True) or manually by a staff member (False). Supports workflow auditing and distinguishes system-generated from human-initiated holds.',
    `notification_date` DATE COMMENT 'Date on which the student was notified of the hold via email, student portal, or other communication channel.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a notification has been sent to the student informing them of the hold placement and required resolution steps.',
    `originating_office_code` STRING COMMENT 'Code identifying the institutional office or department that placed the hold (e.g., BURSAR, REGISTRAR, ADVISING, LIBRARY, HEALTH, JUDICIAL). Determines which office must authorize release.',
    `originating_office_name` STRING COMMENT 'Full name of the institutional office or department that placed the hold (e.g., Bursar Office, Office of the Registrar, Academic Advising Center).',
    `outstanding_balance_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the outstanding financial obligation that triggered or is associated with a financial hold. Applicable primarily to bursar/financial holds. Null for non-financial hold types.',
    `placed_date` DATE COMMENT 'Calendar date on which the hold was placed on the student account. Represents the principal business event date for this transaction.',
    `placed_timestamp` TIMESTAMP COMMENT 'Precise date and time when the hold was placed, including timezone offset. Used for audit trails and batch processing sequencing.',
    `release_reason_code` STRING COMMENT 'Standardized code indicating why the hold was released (e.g., PAID=Balance paid, ADVMEET=Advising meeting completed, IMMCOMP=Immunization records complete, APPEAL=Appeal approved, AUTO=Automated batch release). [ENUM-REF-CANDIDATE: PAID|ADVMEET|IMMCOMP|APPEAL|AUTO|WAIVER|ADMIN — promote to reference product]',
    `release_reason_description` STRING COMMENT 'Free-text narrative explaining the specific circumstances under which the hold was released. Complements the release reason code with additional context.',
    `released_date` DATE COMMENT 'Calendar date on which the hold was manually or automatically released. Null if the hold is still active.',
    `released_timestamp` TIMESTAMP COMMENT 'Precise date and time when the hold was released, including timezone offset. Supports audit trail and SLA measurement for hold resolution.',
    `source_system` STRING COMMENT 'Identifies the originating system or process that created this hold record (e.g., Banner for SIS-generated holds, Batch for automated nightly processes, Manual for staff-entered holds, API for integration-sourced holds).. Valid values are `Banner|Manual|Batch|API`',
    `source_system_record_code` STRING COMMENT 'The native record identifier from the originating source system (e.g., Banner SPRHOLD sequence key). Enables lineage tracing and reconciliation between the lakehouse Silver Layer and the system of record.',
    `student_acknowledged_flag` BOOLEAN COMMENT 'Indicates whether the student has acknowledged receipt and awareness of the hold through the student self-service portal or other acknowledgment mechanism.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this registration hold record was last modified in the Silver Layer lakehouse. Used for incremental ETL processing and change data capture.',
    CONSTRAINT pk_registration_hold PRIMARY KEY(`registration_hold_id`)
) COMMENT 'Records holds placed on a students account that restrict registration activity. Captures hold type (financial, academic, advising, immunization, library, judicial), hold description, originating office, date placed, date released, release reason, hold severity, and restriction scope (blocks registration, transcript, graduation, or combination). Sourced from Banner SPRHOLD. Critical for enforcing prerequisite compliance, financial clearance, and advising mandates before registration opens. Supports batch hold processing and automated release workflows.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`registration_override` (
    `registration_override_id` BIGINT COMMENT 'Unique identifier for the registration override record. Primary key.',
    `course_section_id` BIGINT COMMENT 'Identifier of the course section for which the override is granted.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member or faculty who granted the override.',
    `enrollment_registration_id` BIGINT COMMENT 'Foreign key linking to enrollment.registration. Business justification: Registration override is granted and then used during a specific registration transaction. The used_date attribute indicates when the override was applied. This FK links the override to the registrati',
    `profile_id` BIGINT COMMENT 'Identifier of the student receiving the registration override.',
    `term_id` BIGINT COMMENT 'Identifier of the academic term in which the override applies.',
    `academic_year` STRING COMMENT 'Academic year in which the override applies (e.g., 2023-2024).',
    `approval_date` DATE COMMENT 'Date the override was officially approved by the authorizing party.',
    `approval_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the override approval was recorded in the system.',
    `capacity_override_count` STRING COMMENT 'Number of seats being added beyond the section enrollment capacity limit.',
    `condition_description` STRING COMMENT 'Description of any conditions or requirements the student must meet to use the override.',
    `corequisite_course_code` STRING COMMENT 'Course code of the corequisite requirement being waived, if applicable.',
    `course_number` STRING COMMENT 'Catalog course number within the subject (e.g., 101, 2050, 4999).',
    `course_reference_number` STRING COMMENT 'Banner Course Reference Number uniquely identifying the course section within the term.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the override record was first created in the system.',
    `denial_reason` STRING COMMENT 'Explanation provided when an override request is denied.',
    `expiration_date` DATE COMMENT 'Date after which the override is no longer valid and cannot be used for registration.',
    `granting_authority_type` STRING COMMENT 'Role or position type of the individual authorized to grant this override.. Valid values are `advisor|department_chair|dean|registrar|instructor|system_admin`',
    `granting_department_code` STRING COMMENT 'Code of the academic department or administrative unit that authorized the override.',
    `granting_user_name` STRING COMMENT 'Full name of the staff member or faculty who granted the override.',
    `is_conditional` BOOLEAN COMMENT 'Indicates whether the override is subject to additional conditions or requirements.',
    `is_one_time_use` BOOLEAN COMMENT 'Indicates whether the override can only be used once or is reusable within the validity period.',
    `justification_notes` STRING COMMENT 'Detailed explanation or rationale for granting the registration override.',
    `level_restriction_code` STRING COMMENT 'Code of the student classification or level restriction being waived (e.g., freshman, sophomore, graduate).',
    `major_restriction_code` STRING COMMENT 'Code of the major or program restriction being waived.',
    `override_number` STRING COMMENT 'Human-readable reference number assigned to the override for tracking and audit purposes.',
    `override_status` STRING COMMENT 'Current lifecycle status of the override request or authorization.. Valid values are `pending|approved|denied|expired|revoked|used`',
    `override_type` STRING COMMENT 'Category of registration restriction being overridden. [ENUM-REF-CANDIDATE: prerequisite|corequisite|capacity|time_conflict|major_restriction|level_restriction|college_restriction|department_permission|instructor_permission|dean_permission|campus_restriction|classification_restriction|cohort_restriction — promote to reference product]',
    `prerequisite_course_code` STRING COMMENT 'Course code of the prerequisite requirement being waived, if applicable.',
    `request_date` DATE COMMENT 'Date the student or advisor initiated the override request.',
    `restriction_code` STRING COMMENT 'System code identifying the specific registration restriction being overridden.',
    `restriction_description` STRING COMMENT 'Human-readable description of the registration restriction that was overridden.',
    `revocation_reason` STRING COMMENT 'Explanation provided when an approved override is subsequently revoked.',
    `revoked_date` DATE COMMENT 'Date the override was revoked or withdrawn before use.',
    `section_number` STRING COMMENT 'Section identifier for the course offering (e.g., 001, A, LAB).',
    `source_system` STRING COMMENT 'Name of the system or module where the override was originally created (e.g., Banner Student, Slate, Self-Service).',
    `source_system_record_code` STRING COMMENT 'Unique identifier of the override record in the source system for traceability.',
    `student_banner_code` STRING COMMENT 'Banner system identifier for the student (PIDM or student ID number).',
    `subject_code` STRING COMMENT 'Academic subject or discipline code for the course (e.g., MATH, ENGL, BIOL).',
    `time_conflict_course_code` STRING COMMENT 'Course code of the conflicting section for which the time conflict is being overridden.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the override record was last modified.',
    `used_date` DATE COMMENT 'Date the student successfully used the override to complete registration.',
    CONSTRAINT pk_registration_override PRIMARY KEY(`registration_override_id`)
) COMMENT 'Documents authorized exceptions granted to allow a student to bypass a registration restriction such as a prerequisite, co-requisite, time conflict, capacity limit, or major restriction. Captures override type, granting authority (advisor/department chair/registrar), override date, justification notes, expiration date, and approval status. Provides an auditable trail of all registration exceptions for compliance and academic integrity purposes.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`restriction` (
    `restriction_id` BIGINT COMMENT 'Unique identifier for the enrollment restriction record. Primary key.',
    `course_section_id` BIGINT COMMENT 'Reference to the course section to which this restriction applies.',
    `identity_account_id` BIGINT COMMENT 'User ID of the staff member who created this restriction record. Used for audit and accountability.. Valid values are `^[A-Za-z0-9_]{3,30}$`',
    `course_id` BIGINT COMMENT 'Reference to a corequisite course that must be taken concurrently for enrollment eligibility. Used when restriction enforces corequisite enrollment.',
    `restriction_prerequisite_course_id` BIGINT COMMENT 'Reference to a prerequisite course that must be completed for enrollment eligibility. Used when restriction enforces prerequisite completion.',
    `updated_by_user_identity_account_id` BIGINT COMMENT 'User ID of the staff member who last updated this restriction record. Used for audit and accountability.. Valid values are `^[A-Za-z0-9_]{3,30}$`',
    `applies_to_waitlist` BOOLEAN COMMENT 'Indicates whether this restriction also applies to waitlist enrollment. If false, ineligible students may join the waitlist even if they cannot register directly.',
    `attribute_code` STRING COMMENT 'Student attribute code when restriction_type is attribute. References institutional student attribute classifications.. Valid values are `^[A-Z0-9]{2,10}$`',
    `class_level_minimum` STRING COMMENT 'Minimum class standing required for enrollment when restriction_type is class_level. Values: FR (Freshman), SO (Sophomore), JR (Junior), SR (Senior), GR (Graduate).. Valid values are `FR|SO|JR|SR|GR`',
    `cohort_code` STRING COMMENT 'Cohort identifier when restriction_type is cohort. Used for cohort-based programs and special populations.. Valid values are `^[A-Z0-9]{4,15}$`',
    `college_code` STRING COMMENT 'College or school code when restriction_type is college. Identifies the academic college unit.. Valid values are `^[A-Z]{2,4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this restriction record was created in the system.',
    `credit_hours_minimum` DECIMAL(18,2) COMMENT 'Minimum cumulative credit hours earned required for enrollment eligibility. Used for progression-based restrictions.',
    `degree_code` STRING COMMENT 'Degree type code when restriction_type is degree (e.g., BA, BS, MS, MBA, PHD).. Valid values are `^[A-Z]{2,6}$`',
    `department_code` STRING COMMENT 'Academic department code when restriction_type is department. Identifies the departmental unit.. Valid values are `^[A-Z]{3,6}$`',
    `effective_end_date` DATE COMMENT 'Date when the restriction expires and no longer controls enrollment eligibility. Null indicates no expiration.',
    `effective_start_date` DATE COMMENT 'Date when the restriction becomes active and begins to control enrollment eligibility.',
    `gpa_minimum` DECIMAL(18,2) COMMENT 'Minimum cumulative GPA required for enrollment eligibility. Used for academic performance-based restrictions.',
    `major_code` STRING COMMENT 'Four-character major code when restriction_type is major. References institutional major classification.. Valid values are `^[A-Z]{4}$`',
    `message` STRING COMMENT 'User-facing message displayed when a student attempts to register but does not meet the restriction criteria. Provides guidance on eligibility requirements.',
    `override_authority_level` STRING COMMENT 'Minimum authority level required to override this restriction. Null or none if override_eligible is false.. Valid values are `registrar|advisor|department_chair|dean|none`',
    `override_eligible` BOOLEAN COMMENT 'Indicates whether this restriction can be overridden by authorized personnel (registrar, advisor, department chair) to allow enrollment of otherwise ineligible students.',
    `permission_required` BOOLEAN COMMENT 'Indicates whether explicit instructor or department permission is required for enrollment in addition to meeting restriction criteria.',
    `population_code` STRING COMMENT 'Special population code when restriction_type is population (e.g., HONORS, ATHLETE, VETERAN, INTERNATIONAL).. Valid values are `^[A-Z0-9]{2,10}$`',
    `priority_rank` STRING COMMENT 'Numeric rank defining the order in which multiple restrictions are evaluated for a course section. Lower numbers indicate higher priority.',
    `program_code` STRING COMMENT 'Academic program code when restriction_type is program. Identifies specific degree program.. Valid values are `^[A-Z0-9]{4,10}$`',
    `release_date` DATE COMMENT 'Date when reserved seats are released to the general population if not filled by eligible students. Used for time-based seat release strategies.',
    `reserved_seat_count` STRING COMMENT 'Number of seats reserved for the specified population when restriction_scope is reserved. Null for include/exclude restrictions.',
    `reserved_seat_used_count` STRING COMMENT 'Number of reserved seats currently occupied by eligible students. Tracks utilization of reserved capacity.',
    `restriction_code` STRING COMMENT 'Institutional code identifying the specific restriction rule (e.g., MAJOR, LEVEL, COLLEGE, COHORT, HONORS).. Valid values are `^[A-Z0-9]{2,10}$`',
    `restriction_description` STRING COMMENT 'Human-readable description of the restriction rule and its purpose. Displayed to students and advisors during registration.',
    `restriction_scope` STRING COMMENT 'Defines whether the restriction includes only specified populations (include), excludes specified populations (exclude), or reserves seats for specified populations (reserved).. Valid values are `include|exclude|reserved`',
    `restriction_status` STRING COMMENT 'Current operational status of the restriction rule.. Valid values are `active|inactive|pending|expired`',
    `restriction_type` STRING COMMENT 'Category of restriction applied to the course section enrollment. Defines the dimension along which enrollment is controlled. [ENUM-REF-CANDIDATE: major|minor|college|department|class_level|degree|program|cohort|population|attribute|reserved_seating — 11 candidates stripped; promote to reference product]',
    `restriction_value` DECIMAL(18,2) COMMENT 'The specific value that defines the restriction criteria (e.g., major code BIOL, class level JR, college code ENGR, cohort identifier HONORS2024).',
    `source_system` STRING COMMENT 'System of record that originated this restriction (BANNER for SIS-managed restrictions, SLATE for admissions-driven restrictions, MANUAL for ad-hoc restrictions, API for external integrations).. Valid values are `BANNER|SLATE|MANUAL|API`',
    `source_system_key` STRING COMMENT 'Natural key or unique identifier from the source system. Used for data lineage and reconciliation with upstream systems.',
    `term_code` STRING COMMENT 'Six-digit term code identifying the academic term for which this restriction is effective (format: YYYYMM where MM represents term type).. Valid values are `^[0-9]{6}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this restriction record was last modified in the system.',
    CONSTRAINT pk_restriction PRIMARY KEY(`restriction_id`)
) COMMENT 'Defines rules that restrict or control enrollment in a course section, including major restrictions, class-level restrictions (sophomore and above), college restrictions, degree restrictions, cohort restrictions, and population-based reserved seating (e.g., honors program, athletes, veterans). Captures restriction type, restriction value, restriction scope, effective term, and override eligibility. Sourced from Banner SSRRESV and SSRRSTS tables.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`registration_period` (
    `registration_period_id` BIGINT COMMENT 'Unique identifier for the registration period. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the administrative user who created this registration period record.',
    `term_id` BIGINT COMMENT 'Reference to the academic term for which this registration period applies.',
    `academic_level` STRING COMMENT 'Academic level of students eligible for this registration period.. Valid values are `undergraduate|graduate|doctoral|professional|non_degree`',
    `add_deadline_date` DATE COMMENT 'Last date students can add courses during this registration period without special permission.',
    `allows_waitlist` BOOLEAN COMMENT 'Indicates whether students can add themselves to course waitlists during this registration period.',
    `allows_web_registration` BOOLEAN COMMENT 'Indicates whether students can register online through the web portal during this period.',
    `banner_period_ref` STRING COMMENT 'External reference identifier from Ellucian Banner system for cross-system reconciliation.',
    `campus_code` STRING COMMENT 'Code identifying the campus to which this registration period applies (e.g., MAIN, BRANCH, ONLINE).. Valid values are `^[A-Z0-9]{2,10}$`',
    `college_code` STRING COMMENT 'Code identifying the college or school to which this registration period applies (e.g., ARTS, ENGR, BUS, MED).. Valid values are `^[A-Z0-9]{2,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this registration period record was created in the system.',
    `drop_deadline_date` DATE COMMENT 'Last date students can drop courses during this registration period without academic penalty.',
    `enrollment_status_restriction` STRING COMMENT 'Enrollment status restriction for this registration period, if applicable.. Valid values are `none|full_time|part_time|half_time`',
    `gpa_minimum` DECIMAL(18,2) COMMENT 'Minimum cumulative GPA required for students to register during this period, if applicable.',
    `max_credit_hours` DECIMAL(18,2) COMMENT 'Maximum number of credit hours a student is allowed to register for during this period without special permission or overload approval.',
    `min_credit_hours` DECIMAL(18,2) COMMENT 'Minimum number of credit hours a student must register for during this period to maintain enrollment status.',
    `notes` STRING COMMENT 'Free-text notes or comments about this registration period for administrative reference.',
    `notification_method` STRING COMMENT 'Method used to notify students about this registration period.. Valid values are `email|portal|sms|mail|none`',
    `notification_sent_date` DATE COMMENT 'Date when notification about this registration period was sent to eligible students.',
    `overload_threshold_hours` DECIMAL(18,2) COMMENT 'Credit hour threshold above which a student is considered to have an overload and may require advisor or dean approval.',
    `period_code` STRING COMMENT 'Business identifier code for the registration period (e.g., EARLY_REG, GENERAL_REG, LATE_REG, ADD_DROP).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `period_name` STRING COMMENT 'Human-readable name of the registration period (e.g., Early Registration for Seniors, General Registration, Late Registration).',
    `period_status` STRING COMMENT 'Current lifecycle status of the registration period.. Valid values are `scheduled|active|closed|cancelled`',
    `period_type` STRING COMMENT 'Classification of the registration period indicating the phase of the registration cycle.. Valid values are `early|priority|general|late|add_drop|open`',
    `priority_group_code` STRING COMMENT 'Code identifying the student population eligible for this registration period (e.g., SENIOR, GRAD, HONORS, ATHLETE, VETERAN, DISABLED).. Valid values are `^[A-Z0-9_]{2,15}$`',
    `priority_group_name` STRING COMMENT 'Descriptive name of the student population eligible for this registration period (e.g., Senior Students, Graduate Students, Honors Program, Student Athletes).',
    `program_code` STRING COMMENT 'Code identifying the academic program to which this registration period applies, if restricted to specific programs.. Valid values are `^[A-Z0-9]{2,15}$`',
    `registration_close_timestamp` TIMESTAMP COMMENT 'Date and time when registration closes for this period. No further registrations are accepted after this time.',
    `registration_open_timestamp` TIMESTAMP COMMENT 'Date and time when registration opens for this period. Students in the eligible population can begin registering at this time.',
    `requires_advisor_approval` BOOLEAN COMMENT 'Indicates whether students must obtain advisor approval before registering during this period.',
    `requires_hold_clearance` BOOLEAN COMMENT 'Indicates whether students must clear all registration holds before being allowed to register during this period.',
    `residency_restriction` STRING COMMENT 'Residency classification restriction for this registration period, if applicable.. Valid values are `none|resident|non_resident|international`',
    `sap_requirement` BOOLEAN COMMENT 'Indicates whether students must meet Satisfactory Academic Progress standards to register during this period.',
    `sequence_number` STRING COMMENT 'Numeric sequence indicating the order of this registration period within the term registration cycle.',
    `student_classification` STRING COMMENT 'Student classification level eligible for this registration period based on credit hours completed.. Valid values are `freshman|sophomore|junior|senior|graduate|doctoral`',
    `time_ticket_required` BOOLEAN COMMENT 'Indicates whether students must have an assigned time ticket to register during this period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this registration period record was last updated in the system.',
    `withdrawal_deadline_date` DATE COMMENT 'Last date students can withdraw from courses during this registration period. Withdrawals after this date may require special approval.',
    CONSTRAINT pk_registration_period PRIMARY KEY(`registration_period_id`)
) COMMENT 'Defines the registration windows and priority scheduling periods for a given term, including early registration for specific populations (seniors, athletes, honors, graduate students), general registration open dates, late registration period, and add/drop period boundaries. Captures population code, priority group, registration open datetime, registration close datetime, and maximum credit hour load allowed during each period. Supports Banner registration time-ticketing and priority enrollment management.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`cross_list_group` (
    `cross_list_group_id` BIGINT COMMENT 'Unique identifier for the cross-listed course section group. Primary key. This identifier links multiple course sections that share combined enrollment and meet together.',
    `employee_id` BIGINT COMMENT 'Reference to the faculty member or staff user authorized to approve enrollment requests for the cross-list group. Null if approval is not required.',
    `identity_account_id` BIGINT COMMENT 'Reference to the staff user who created the cross-list group record in the student information system. Used for audit and accountability purposes.',
    `instructor_id` BIGINT COMMENT 'Reference to the faculty member designated as the instructor of record for the entire cross-list group. This instructor is responsible for grading and course outcomes across all sections.',
    `course_section_id` BIGINT COMMENT 'Reference to the primary or lead section within the cross-list group. The primary section typically determines the course title, instructor of record, and grading schema for all linked sections.',
    `room_id` BIGINT COMMENT 'Reference to the shared classroom or meeting space where all sections in the cross-list group meet together. Null for online or asynchronous courses.',
    `term_id` BIGINT COMMENT 'Reference to the academic term in which this cross-list group is active. Cross-list groups are term-specific and must be re-established each term.',
    `updated_by_user_identity_account_id` BIGINT COMMENT 'Reference to the staff user who last modified the cross-list group record. Used for audit and change tracking purposes.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether departmental or instructor approval is required for students to enroll in any section of the cross-list group. True for restricted courses, capstones, or research sections.',
    `available_seats` STRING COMMENT 'Number of available seats remaining in the cross-list group, calculated as max_enrollment minus current_enrollment. Used by registration systems to determine if students can enroll.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cross-list group record was first created in the system. Used for audit trail and data lineage tracking.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Number of credit hours awarded for successful completion of the course. Typically consistent across all sections in the cross-list group, though variable credit arrangements are possible.',
    `cross_list_type` STRING COMMENT 'Classification of the cross-list arrangement. Departmental: sections from different departments; interdisciplinary: sections spanning multiple colleges; level: undergraduate and graduate sections combined; honors: honors and regular sections; special topics: variable content courses; dual-listed: same course with multiple catalog numbers.. Valid values are `departmental|interdisciplinary|level|honors|special_topics|dual_listed`',
    `current_enrollment` STRING COMMENT 'Current total number of students enrolled across all sections in the cross-list group. Used to calculate available seats and prevent over-enrollment. Updated in real-time during registration.',
    `current_waitlist_count` STRING COMMENT 'Current number of students on the waitlist for the cross-list group. Updated as students are added to or removed from the waitlist.',
    `effective_end_date` DATE COMMENT 'Date when the cross-list group is deactivated and no longer available for enrollment. Typically aligns with the term end date or course completion date.',
    `effective_start_date` DATE COMMENT 'Date when the cross-list group becomes active and available for student enrollment. Typically aligns with the term registration open date.',
    `fte_divisor` DECIMAL(18,2) COMMENT 'Divisor used to calculate student FTE (Full-Time Equivalent) for enrollment reporting. Typically 12 for undergraduate, 9 for graduate. Used to prevent double-counting students enrolled in cross-listed sections.',
    `grading_mode` STRING COMMENT 'Grading schema applied to the cross-list group. Standard: letter grades (A-F); pass_fail: binary outcome; audit: no grade assigned; honors: enhanced grading for honors sections; satisfactory_unsatisfactory: binary outcome for certain professional programs.. Valid values are `standard|pass_fail|audit|honors|satisfactory_unsatisfactory`',
    `group_code` STRING COMMENT 'Business identifier or code assigned to the cross-list group for external reference and reporting. Used in student information systems and course catalogs.',
    `group_name` STRING COMMENT 'Descriptive name of the cross-list group, typically combining the primary section identifier with participating sections for clarity in registration systems.',
    `group_status` STRING COMMENT 'Current lifecycle status of the cross-list group. Active groups allow enrollment; inactive groups are suspended; pending groups await approval; cancelled groups are terminated before activation; closed groups have completed their term.. Valid values are `active|inactive|pending|cancelled|closed`',
    `max_enrollment` STRING COMMENT 'Maximum combined enrollment capacity across all sections in the cross-list group. This is the total seat capacity shared by all participating sections and determines when the group is full.',
    `meeting_pattern_shared` BOOLEAN COMMENT 'Indicates whether all sections in the cross-list group meet at the same time and location. True for most cross-list groups; false for asynchronous or hybrid arrangements where sections may have different meeting times.',
    `notes` STRING COMMENT 'Free-text field for administrative notes, special instructions, or comments about the cross-list group. May include information about enrollment restrictions, prerequisite waivers, or coordination details.',
    `prevent_duplicate_enrollment` BOOLEAN COMMENT 'System flag indicating whether students are prevented from enrolling in multiple sections within the same cross-list group. True for most cross-list groups to prevent duplicate credit.',
    `registration_close_date` DATE COMMENT 'Date when student registration closes for the cross-list group. Typically aligns with the add/drop deadline for the term.',
    `registration_open_date` DATE COMMENT 'Date when student registration opens for the cross-list group. May differ from effective_start_date if early registration is permitted.',
    `section_count` STRING COMMENT 'Total number of course sections participating in this cross-list group. Typically ranges from 2 to 5 sections, though larger groups are possible for interdisciplinary courses.',
    `source_system` STRING COMMENT 'Identifier of the operational system of record from which this cross-list group data originated. Typically Ellucian Banner, Colleague, PeopleSoft Campus Solutions, or Workday Student.',
    `source_system_record_code` STRING COMMENT 'Primary key or unique identifier of the cross-list group record in the source operational system. Used for data lineage and reconciliation with source systems.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the cross-list group record was last modified. Updated whenever enrollment counts, status, or configuration changes occur.',
    `waitlist_capacity` STRING COMMENT 'Maximum number of students allowed on the combined waitlist for the cross-list group when all seats are filled. Null if waitlist is not enabled.',
    CONSTRAINT pk_cross_list_group PRIMARY KEY(`cross_list_group_id`)
) COMMENT 'Manages cross-listed course sections where multiple sections (often from different departments or academic levels) share a combined enrollment pool and meet together in the same room at the same time. Captures cross-list group identifier, maximum combined enrollment, current combined enrollment, primary section designator, and participating section references. Ensures accurate seat availability reporting across linked sections and prevents double-counting in official enrollment headcounts and FTE calculations.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` (
    `concurrent_enrollment_id` BIGINT COMMENT 'Unique identifier for the concurrent enrollment record. Primary key.',
    `aid_application_id` BIGINT COMMENT 'Foreign key linking to aid.aid_application. Business justification: Consortium agreements require aid coordination between home/host institutions. Links concurrent enrollment records to aid applications for Title IV eligibility determination, combined enrollment statu',
    `institution_id` BIGINT COMMENT 'Reference to the students primary home institution where they are degree-seeking.',
    `instructor_id` BIGINT COMMENT 'Reference to the academic advisor at the home institution who oversees the students concurrent enrollment plan and ensures courses align with degree requirements.',
    `profile_id` BIGINT COMMENT 'Reference to the student enrolled concurrently at multiple institutions.',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Concurrent enrollment agreements specify tuition payment responsibility (home vs host institution). Student account link required to track which institution bills, apply consortium agreements, coordin',
    `term_id` BIGINT COMMENT 'Reference to the academic term during which concurrent enrollment is active.',
    `academic_standing` STRING COMMENT 'Students academic standing status at the home institution during concurrent enrollment. Good standing indicates satisfactory progress; probation indicates below-standard performance; suspension indicates temporary removal; dismissal indicates permanent removal; warning indicates at-risk status.. Valid values are `good_standing|probation|suspension|dismissal|warning`',
    `agreement_number` STRING COMMENT 'Business identifier for the formal consortium or cross-institutional agreement governing this enrollment. Required for Title IV financial aid coordination.',
    `agreement_type` STRING COMMENT 'Type of formal agreement between institutions. Consortium agreements coordinate financial aid; articulation agreements facilitate credit transfer; dual credit covers high school partnerships; exchange covers student exchange programs; reciprocal allows mutual course access; visiting covers temporary enrollment arrangements.. Valid values are `consortium|articulation|dual_credit|exchange|reciprocal|visiting`',
    `approval_date` DATE COMMENT 'Date when the concurrent enrollment arrangement was officially approved by both institutions. Required for audit trail and compliance verification.',
    `approved_by_home` STRING COMMENT 'Name or identifier of the home institution official who approved the concurrent enrollment arrangement. Typically registrar or academic advisor.',
    `approved_by_host` STRING COMMENT 'Name or identifier of the host institution official who approved the concurrent enrollment arrangement. Typically registrar or admissions officer.',
    `combined_credit_hours` DECIMAL(18,2) COMMENT 'Total credit hours across both home and host institutions. Critical for Title IV financial aid eligibility determination and enrollment intensity classification.',
    `combined_fte` DECIMAL(18,2) COMMENT 'Combined Full-Time Equivalent enrollment status calculated across both institutions. Used for financial aid eligibility, enrollment reporting, and satisfactory academic progress (SAP) determination. Typically 1.0 = full-time, 0.5 = half-time.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this concurrent enrollment record was first created in the system. Used for audit trail and data lineage.',
    `credit_transfer_status` STRING COMMENT 'Status of credit transfer from host institution back to home institution. Automatic transfer occurs under articulation agreements; evaluation required indicates manual review needed; pre-approved indicates prior authorization; pending awaits decision; denied indicates credits not accepted; completed indicates transfer finalized.. Valid values are `automatic|evaluation_required|pre_approved|pending|denied|completed`',
    `degree_applicability` STRING COMMENT 'Classification of how host institution credits apply to the students degree program at the home institution. Degree requirement indicates required coursework; elective counts toward degree but not specific requirement; non-degree does not count toward degree; enrichment provides supplemental learning; remedial addresses deficiencies; prerequisite satisfies entry requirements.. Valid values are `degree_requirement|elective|non_degree|enrichment|remedial|prerequisite`',
    `effective_end_date` DATE COMMENT 'Date when the concurrent enrollment arrangement expires or terminates. May be null for open-ended arrangements.',
    `effective_start_date` DATE COMMENT 'Date when the concurrent enrollment arrangement becomes effective and the student may begin taking courses at the host institution.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the concurrent enrollment arrangement. Active indicates currently enrolled; pending awaits approval; approved indicates authorization granted; denied indicates request rejected; withdrawn indicates student-initiated cancellation; completed indicates term finished; expired indicates agreement lapsed. [ENUM-REF-CANDIDATE: active|pending|approved|denied|withdrawn|completed|expired — 7 candidates stripped; promote to reference product]',
    `enrollment_type` STRING COMMENT 'Classification of the concurrent enrollment arrangement. Dual enrollment refers to high school students taking college courses; consortium covers financial aid coordination across institutions; visiting student indicates temporary enrollment; cross-registration allows course-sharing between partner institutions; transient student indicates temporary enrollment for specific courses; exchange covers formal student exchange programs.. Valid values are `dual_enrollment|consortium|visiting_student|cross_registration|transient_student|exchange`',
    `ferpa_consent_date` DATE COMMENT 'Date when the student provided FERPA consent for cross-institutional data sharing. Null if consent not provided or not required.',
    `ferpa_consent_on_file` BOOLEAN COMMENT 'Indicates whether the student has provided FERPA consent authorizing cross-institutional data sharing between home and host institutions. Required for transcript exchange and academic progress reporting.',
    `financial_aid_home_institution` BOOLEAN COMMENT 'Indicates whether the home institution is the degree-granting institution responsible for administering Title IV financial aid. True when home institution manages aid; false when host institution manages aid.',
    `high_school_ceeb_code` STRING COMMENT 'College Board CEEB code for the high school partner institution in dual enrollment arrangements. Null for non-high-school concurrent enrollments.',
    `high_school_partnership_flag` BOOLEAN COMMENT 'Indicates whether this concurrent enrollment is part of a dual enrollment or early college program with a high school partner. True for high school students taking college courses.',
    `home_credit_hours` DECIMAL(18,2) COMMENT 'Number of credit hours the student is enrolled in at their home institution during the concurrent enrollment period. Used for combined Full-Time Equivalent (FTE) calculation.',
    `host_credit_hours` DECIMAL(18,2) COMMENT 'Number of credit hours the student is enrolled in at the host institution during the concurrent enrollment period. Used for combined Full-Time Equivalent (FTE) calculation.',
    `host_institution_code` BIGINT COMMENT 'Reference to the host institution where the student is taking concurrent courses.',
    `ipeds_reporting_flag` BOOLEAN COMMENT 'Indicates whether this concurrent enrollment must be included in IPEDS enrollment reporting. Dual enrollment high school students may be excluded from headcount depending on institutional policy and IPEDS guidance.',
    `notes` STRING COMMENT 'Free-text notes documenting special circumstances, conditions, restrictions, or administrative details related to the concurrent enrollment arrangement.',
    `nsc_reporting_flag` BOOLEAN COMMENT 'Indicates whether this concurrent enrollment must be reported to the National Student Clearinghouse for enrollment verification and degree verification services. Required for accurate multi-institutional enrollment tracking.',
    `residency_classification` STRING COMMENT 'Students residency classification at the host institution for tuition and fee purposes. In-state qualifies for resident rates; out-of-state pays non-resident rates; international indicates foreign student status; reciprocity indicates special agreement rates.. Valid values are `in_state|out_of_state|international|reciprocity`',
    `source_system` STRING COMMENT 'Identifier of the source system from which this concurrent enrollment record originated. Typically Banner, PeopleSoft, or other Student Information System (SIS).',
    `source_system_record_code` STRING COMMENT 'Unique identifier of this concurrent enrollment record in the source system. Used for data lineage and reconciliation.',
    `title_iv_eligible` BOOLEAN COMMENT 'Indicates whether this concurrent enrollment arrangement qualifies for federal Title IV financial aid eligibility. Must meet consortium agreement requirements and combined enrollment intensity thresholds.',
    `tuition_payment_responsibility` STRING COMMENT 'Identifies which party is responsible for paying tuition to the host institution. Home institution pays under consortium agreements; host institution waives under reciprocal agreements; student pays directly; shared indicates split responsibility; third party covers external sponsor payments.. Valid values are `home_institution|host_institution|student_direct|shared|third_party`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this concurrent enrollment record was last modified. Used for audit trail and change tracking.',
    `visa_type` STRING COMMENT 'Type of visa held by international students in concurrent enrollment. Common values include F-1 (academic student), J-1 (exchange visitor), M-1 (vocational student). Null for domestic students. Critical for SEVIS reporting compliance.',
    `withdrawal_date` DATE COMMENT 'Date when the student withdrew from the concurrent enrollment arrangement. Null if enrollment remains active or was completed normally.',
    `withdrawal_reason` STRING COMMENT 'Reason for withdrawal from concurrent enrollment. Common reasons include academic difficulty, financial constraints, schedule conflicts, transfer to single institution, personal circumstances, or completion of required coursework.',
    CONSTRAINT pk_concurrent_enrollment PRIMARY KEY(`concurrent_enrollment_id`)
) COMMENT 'Records students enrolled simultaneously at this institution and another institution under formal agreements. Covers dual enrollment (high school students taking college courses), consortium agreements (financial aid coordination across institutions), and visiting student arrangements. Captures home/host institution, enrollment type, credit hours at each institution, combined FTE for financial aid purposes, consortium agreement reference, and National Student Clearinghouse reporting flags. Supports Title IV financial aid eligibility determination and FERPA-compliant cross-institutional data sharing.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`repeat_course_record` (
    `repeat_course_record_id` BIGINT COMMENT 'Unique identifier for the repeat course record. Primary key.',
    `course_id` BIGINT COMMENT 'Identifier of the course that was repeated. Links to the course catalog.',
    `employee_id` BIGINT COMMENT 'Identifier of the faculty or staff member who approved the repeat, if approval was required.',
    `enrollment_registration_id` BIGINT COMMENT 'Identifier of the repeat course enrollment attempt. Links to the enrollment record for the repeat attempt.',
    `profile_id` BIGINT COMMENT 'Identifier of the student who repeated the course. Links to the student master record.',
    `repeat_enrollment_registration_id` BIGINT COMMENT 'Identifier of the original course enrollment attempt. Links to the enrollment record for the first attempt.',
    `academic_standing_impact` STRING COMMENT 'The impact of the repeat on the students academic standing: improved (standing improved), no_change (standing unchanged), declined (standing worsened).. Valid values are `improved|no_change|declined`',
    `course_title` STRING COMMENT 'The title of the course that was repeated.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this repeat course record was first created in the system.',
    `credit_hours` DECIMAL(18,2) COMMENT 'The number of credit hours associated with the repeated course.',
    `degree_applicable` BOOLEAN COMMENT 'Indicates whether the repeat course credits are applicable toward degree completion (True/False).',
    `financial_aid_countable` BOOLEAN COMMENT 'Indicates whether this repeat course counts toward financial aid eligibility and Satisfactory Academic Progress (SAP) under federal Title IV regulations (True/False).',
    `gpa_calculation_method` STRING COMMENT 'Method used to calculate GPA impact: use_repeat_only (only repeat grade counts), use_both (both grades count), use_highest (highest grade counts), use_average (average of both grades).. Valid values are `use_repeat_only|use_both|use_highest|use_average`',
    `grade_replacement_applied` BOOLEAN COMMENT 'Indicates whether grade replacement was actually applied to this repeat (True/False). May differ from eligibility if student opted out or policy limits were reached.',
    `grade_replacement_eligible` BOOLEAN COMMENT 'Indicates whether this repeat is eligible for grade replacement under institutional policy (True/False).',
    `institutional_repeat_limit` STRING COMMENT 'The maximum number of times a course may be repeated under institutional policy.',
    `ipeds_reportable` BOOLEAN COMMENT 'Indicates whether this repeat is included in IPEDS reporting calculations (True/False).',
    `original_gpa_impact` DECIMAL(18,2) COMMENT 'The impact of the original grade on cumulative GPA calculation after repeat policy is applied. May be zero if grade replacement removes original grade from GPA.',
    `original_grade` STRING COMMENT 'The grade earned in the original course attempt (e.g., D, F, W).',
    `original_grade_points` DECIMAL(18,2) COMMENT 'The grade points earned per credit hour in the original attempt, based on institutional grading scale.',
    `original_quality_points` DECIMAL(18,2) COMMENT 'Total quality points earned in the original attempt (credit hours × grade points).',
    `original_term_code` STRING COMMENT 'Academic term code when the course was originally attempted (e.g., 202301 for Spring 2023).',
    `repeat_approval_date` DATE COMMENT 'The date when repeat approval was granted, if required.',
    `repeat_approval_required` BOOLEAN COMMENT 'Indicates whether institutional approval was required for this repeat (True/False). Some institutions require advisor or dean approval for course repeats.',
    `repeat_approval_status` STRING COMMENT 'The approval status for this repeat: approved, denied, pending, not_required.. Valid values are `approved|denied|pending|not_required`',
    `repeat_count` STRING COMMENT 'The sequential number of times this course has been repeated by the student (1 for first repeat, 2 for second repeat, etc.).',
    `repeat_gpa_impact` DECIMAL(18,2) COMMENT 'The impact of the repeat grade on cumulative GPA calculation.',
    `repeat_grade` STRING COMMENT 'The grade earned in the repeat course attempt (e.g., A, B, C).',
    `repeat_grade_points` DECIMAL(18,2) COMMENT 'The grade points earned per credit hour in the repeat attempt, based on institutional grading scale.',
    `repeat_limit_exceeded` BOOLEAN COMMENT 'Indicates whether this repeat exceeds the institutional repeat limit (True/False).',
    `repeat_quality_points` DECIMAL(18,2) COMMENT 'Total quality points earned in the repeat attempt (credit hours × grade points).',
    `repeat_reason` STRING COMMENT 'The reason the student repeated the course: grade_improvement, failed_course, withdrawn_course, degree_requirement, gpa_improvement, other.. Valid values are `grade_improvement|failed_course|withdrawn_course|degree_requirement|gpa_improvement|other`',
    `repeat_term_code` STRING COMMENT 'Academic term code when the course was repeated (e.g., 202308 for Fall 2023).',
    `repeat_type` STRING COMMENT 'The type of repeat policy applied: grade_replacement (new grade replaces old), grade_averaging (both grades averaged), grade_forgiveness (original grade excluded from GPA but remains on transcript), no_replacement (both grades count separately).. Valid values are `grade_replacement|grade_averaging|grade_forgiveness|no_replacement`',
    `sap_repeat_limit_exceeded` BOOLEAN COMMENT 'Indicates whether this repeat exceeds the federal financial aid repeat limit (students may repeat a previously passed course once for financial aid purposes) (True/False).',
    `source_system` STRING COMMENT 'The system of record where this repeat course record originated (e.g., Banner, PeopleSoft, Colleague).',
    `source_system_record_code` STRING COMMENT 'The unique identifier for this record in the source system.',
    `subject_code` STRING COMMENT 'The academic subject or discipline code for the repeated course (e.g., MATH, ENGL, BIOL).',
    `transcript_notation` STRING COMMENT 'Special notation that appears on the academic transcript for this repeat (e.g., Repeated, Grade Replaced, Excluded from GPA).',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this repeat course record was last updated in the system.',
    CONSTRAINT pk_repeat_course_record PRIMARY KEY(`repeat_course_record_id`)
) COMMENT 'Tracks instances where a student repeats a previously attempted course, capturing original attempt term, repeat attempt term, original grade, repeat grade, grade replacement eligibility, grade replacement applied flag, GPA impact (both grades counted vs. replacement), repeat count, and institutional repeat policy applied. Supports GPA recalculation workflows, financial aid SAP repeat-course rules, and academic standing determinations per institutional repeat policy.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`athletic_recruitment` (
    `athletic_recruitment_id` BIGINT COMMENT 'Unique identifier for this sport-specific recruitment relationship record. Primary key.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to the prospective student record in the enrollment domain',
    `employee_id` BIGINT COMMENT 'Identifier of the coach (assistant or head coach) assigned as the primary recruiter for this prospect in this sport.',
    `sport_id` BIGINT COMMENT 'Foreign key linking to the sport program record in the athletics domain',
    `commitment_date` DATE COMMENT 'Date when the prospect committed to this sport program. Null if not yet committed.',
    `commitment_status` STRING COMMENT 'The prospects commitment status for this specific sport program. Tracks whether they have committed to compete for this sport.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sport-specific recruitment record was created in the system.',
    `evaluation_rating` STRING COMMENT 'Coaching staffs athletic evaluation rating for this prospect in this specific sport. Used to prioritize recruitment efforts and scholarship allocation.',
    `first_contact_date` DATE COMMENT 'Date of first contact between coaching staff and this prospect regarding this sport program. Used for NCAA compliance and recruitment timeline tracking.',
    `interest_level` STRING COMMENT 'The prospects expressed level of interest in competing for this specific sport program. Assessed and updated by coaching staff during recruitment.',
    `official_visit_date` DATE COMMENT 'Date of the prospects official visit to campus for this sport program. Null if no official visit has occurred.',
    `primary_position` STRING COMMENT 'The primary playing position or event specialty for which this prospect is being recruited in this sport (e.g., point guard, midfielder, 100m sprinter).',
    `recruitment_notes` STRING COMMENT 'Free-text notes from coaching staff regarding this prospects recruitment for this specific sport. Captures evaluation details, contact history, and recruitment strategy.',
    `recruitment_stage` STRING COMMENT 'Current stage of this prospect in the sport-specific recruitment pipeline. Tracks progression from initial inquiry through commitment for this particular sport.',
    `scholarship_offer_amount` DECIMAL(18,2) COMMENT 'The scholarship equivalency amount offered to this prospect for this sport (e.g., 0.5 for half scholarship). Null if no offer extended.',
    `scholarship_offer_date` DATE COMMENT 'Date when the scholarship offer was extended to this prospect for this sport. Used for compliance tracking and offer timeline management.',
    `scholarship_offer_extended` BOOLEAN COMMENT 'Indicates whether a scholarship offer has been extended to this prospect for this sport program. Critical for NCAA compliance and scholarship budget tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this sport-specific recruitment record.',
    CONSTRAINT pk_athletic_recruitment PRIMARY KEY(`athletic_recruitment_id`)
) COMMENT 'This association product represents the recruitment relationship between a prospective student and a sport program. It captures sport-specific recruitment pipeline data including interest level, position evaluation, scholarship offers, and commitment status. Each record links one prospect to one sport with attributes that exist only in the context of this sport-specific recruitment process.. Existence Justification: In higher education athletics, prospective students who are multi-sport athletes are actively recruited by multiple sport programs simultaneously. Each sport program maintains its own independent recruitment pipeline for the same prospect, with sport-specific evaluations, scholarship offers, and commitment tracking. Coaches manage these recruitment relationships as distinct operational entities, and a prospect can commit to one sport while declining others.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`review_committee` (
    `review_committee_id` BIGINT COMMENT 'Primary key for review_committee',
    `org_unit_id` BIGINT COMMENT 'Reference to the academic unit (college, school, department) that this committee serves or reports to.',
    `employee_id` BIGINT COMMENT 'Reference to the employee serving as the chair or lead of the review committee.',
    `institution_id` BIGINT COMMENT 'Reference to the institution that established and governs this review committee.',
    `secretary_employee_id` BIGINT COMMENT 'Reference to the employee serving as the secretary responsible for committee documentation and minutes.',
    `vice_chair_employee_id` BIGINT COMMENT 'Reference to the employee serving as the vice chair or co-lead of the review committee.',
    `parent_review_committee_id` BIGINT COMMENT 'Self-referencing FK on review_committee (parent_review_committee_id)',
    `appeal_level` STRING COMMENT 'Hierarchical level of this committee in the appeals process, where higher numbers indicate higher levels of appeal authority.',
    `average_review_duration_days` DECIMAL(18,2) COMMENT 'Typical number of days required for the committee to complete a review from submission to decision.',
    `charter_document_url` STRING COMMENT 'URL reference to the committee charter document that defines its purpose, authority, and operating procedures.',
    `committee_code` STRING COMMENT 'Unique business identifier code for the review committee used in external communications and reporting.',
    `committee_name` STRING COMMENT 'Official name of the review committee as recognized by the institution.',
    `committee_type` STRING COMMENT 'Classification of the committee based on its primary review function within the enrollment lifecycle.',
    `confidentiality_level` STRING COMMENT 'Classification of the confidentiality requirements for committee proceedings and decisions.',
    `contact_email` STRING COMMENT 'Official email address for inquiries and communications directed to the review committee.',
    `contact_phone` STRING COMMENT 'Primary phone number for contacting the review committee office or administrative support.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this committee record was first created in the system.',
    `decision_authority_level` STRING COMMENT 'Level of decision-making authority granted to the committee indicating whether decisions are recommendations or binding.',
    `review_committee_description` STRING COMMENT 'Detailed description of the committees purpose, responsibilities, and scope of review authority.',
    `effective_end_date` DATE COMMENT 'Date when the review committee ceased operations or was dissolved. Null for currently active committees.',
    `effective_start_date` DATE COMMENT 'Date when the review committee was established and began operations.',
    `external_representation_flag` BOOLEAN COMMENT 'Indicates whether the committee includes external members from outside the institution.',
    `faculty_representation_flag` BOOLEAN COMMENT 'Indicates whether the committee includes faculty members as part of its composition.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this committee record was most recently updated in the system.',
    `meeting_frequency` STRING COMMENT 'Standard frequency at which the committee convenes to conduct reviews.',
    `meeting_location` STRING COMMENT 'Primary physical or virtual location where the committee conducts its review meetings.',
    `member_count` STRING COMMENT 'Current total number of active members serving on the review committee.',
    `notes` STRING COMMENT 'Additional notes or special instructions related to the committees operations or unique characteristics.',
    `office_location` STRING COMMENT 'Physical office location or building where the committee administrative staff is located.',
    `quorum_requirement` STRING COMMENT 'Minimum number of committee members required to be present for official review decisions.',
    `review_criteria_document_url` STRING COMMENT 'URL reference to the official document defining the review criteria and decision-making guidelines for this committee.',
    `review_scope` STRING COMMENT 'Academic level scope that defines which student populations this committee reviews.',
    `staff_representation_flag` BOOLEAN COMMENT 'Indicates whether the committee includes administrative staff members as part of its composition.',
    `review_committee_status` STRING COMMENT 'Current operational status of the review committee indicating whether it is actively conducting reviews.',
    `student_representation_flag` BOOLEAN COMMENT 'Indicates whether the committee includes student members as part of its composition.',
    `term_specific_flag` BOOLEAN COMMENT 'Indicates whether the committee operates on a term-by-term basis or continuously throughout the academic year.',
    `voting_member_count` STRING COMMENT 'Number of committee members with voting privileges on review decisions.',
    CONSTRAINT pk_review_committee PRIMARY KEY(`review_committee_id`)
) COMMENT 'Master reference table for review_committee. Referenced by committee_id.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`institution` (
    `institution_id` BIGINT COMMENT 'Primary key for institution',
    `parent_institution_id` BIGINT COMMENT 'Reference to the parent institution if this institution is a branch campus or subsidiary of a larger system.',
    `accreditation_date` DATE COMMENT 'Date when the institution received its current accreditation status.',
    `accreditation_status` STRING COMMENT 'Current accreditation standing of the institution with its primary regional or national accrediting body.',
    `address_line_1` STRING COMMENT 'Primary street address line for the institutions main campus or administrative headquarters.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, building, or department information.',
    `campus_housing_available` BOOLEAN COMMENT 'Indicates whether the institution provides on-campus housing facilities for students.',
    `campus_setting` STRING COMMENT 'Geographic setting classification of the institutions primary campus location.',
    `carnegie_classification` STRING COMMENT 'Carnegie Classification framework category describing the institutions mission, degree offerings, and research activity level.',
    `city` STRING COMMENT 'City where the institutions main campus is located.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the institution is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this institution record was first created in the system.',
    `degree_granting_status` BOOLEAN COMMENT 'Indicates whether the institution is authorized to grant degrees (true) or only offers certificates and non-degree programs (false).',
    `email_address` STRING COMMENT 'Primary email address for general institutional inquiries and correspondence.',
    `fax_number` STRING COMMENT 'Fax number for the institutions main administrative office.',
    `federal_aid_eligible` BOOLEAN COMMENT 'Indicates whether the institution is eligible to participate in federal student financial aid programs under Title IV.',
    `fice_code` STRING COMMENT 'Six-digit code formerly used by the federal government to identify postsecondary institutions, now largely replaced by OPE ID.',
    `founded_date` DATE COMMENT 'Date when the institution was originally established or chartered.',
    `graduate_offering` BOOLEAN COMMENT 'Indicates whether the institution offers graduate programs (master or doctoral degrees).',
    `highest_degree_offered` STRING COMMENT 'The highest level of degree or credential that the institution is authorized to confer.',
    `hispanic_serving_institution` BOOLEAN COMMENT 'Indicates whether the institution is designated as a Hispanic Serving Institution based on enrollment demographics.',
    `historically_black_college` BOOLEAN COMMENT 'Indicates whether the institution is designated as a Historically Black College or University.',
    `institution_code` STRING COMMENT 'Unique alphanumeric code assigned to the institution for external identification and reporting purposes.',
    `institution_name` STRING COMMENT 'Official legal name of the higher education institution.',
    `institution_type` STRING COMMENT 'Classification of the institution based on control and ownership structure.',
    `ipeds_unit_code` STRING COMMENT 'Six-digit unique identifier assigned by IPEDS for federal reporting and data collection.',
    `land_grant_institution` BOOLEAN COMMENT 'Indicates whether the institution is designated as a land-grant institution under the Morrill Acts.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this institution record was last updated.',
    `medical_degree_granting` BOOLEAN COMMENT 'Indicates whether the institution grants medical degrees (MD, DO) through an accredited medical school.',
    `next_accreditation_review_date` DATE COMMENT 'Scheduled date for the next comprehensive accreditation review or reaffirmation.',
    `online_programs_offered` BOOLEAN COMMENT 'Indicates whether the institution offers fully online degree or certificate programs.',
    `ope_code` STRING COMMENT 'Eight-digit identifier assigned by the U.S. Department of Education Office of Postsecondary Education for Title IV eligibility.',
    `operational_status` STRING COMMENT 'Current operational state of the institution indicating whether it is actively enrolling and teaching students.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the institutions main administrative office.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the institutions main address.',
    `primary_accreditor` STRING COMMENT 'Name of the primary regional or national accrediting agency responsible for institutional accreditation.',
    `religious_affiliation` STRING COMMENT 'Religious denomination or affiliation of the institution, if applicable.',
    `state_province` STRING COMMENT 'State, province, or territory where the institution is located.',
    `system_member` BOOLEAN COMMENT 'Indicates whether the institution is part of a larger multi-campus system or consortium.',
    `tribal_college` BOOLEAN COMMENT 'Indicates whether the institution is designated as a Tribal College or University.',
    `undergraduate_offering` BOOLEAN COMMENT 'Indicates whether the institution offers undergraduate programs (associate or bachelor degrees).',
    `website_url` STRING COMMENT 'Official website URL for the institution.',
    CONSTRAINT pk_institution PRIMARY KEY(`institution_id`)
) COMMENT 'Master reference table for institution. Referenced by home_institution_id.';

CREATE OR REPLACE TABLE `education_ecm`.`enrollment`.`recruitment_event_session` (
    `recruitment_event_session_id` BIGINT COMMENT 'Primary key for recruitment_event_session',
    `academic_program_id` BIGINT COMMENT 'Reference to the specific academic program or major that this session focuses on, if program-specific.',
    `college_school_id` BIGINT COMMENT 'Reference to the college or school within the university that is hosting or sponsoring this session.',
    `division_id` BIGINT COMMENT 'Reference to the academic department that is hosting or sponsoring this session.',
    `employee_id` BIGINT COMMENT 'Reference to the staff member or employee responsible for coordinating and managing this recruitment event session.',
    `identity_account_id` BIGINT COMMENT 'Reference to the user or staff member who created this recruitment event session record.',
    `recruitment_event_id` BIGINT COMMENT 'Reference to the parent recruitment event under which this session is organized.',
    `room_id` BIGINT COMMENT 'Reference to the physical location or facility where the in-person or hybrid session is held.',
    `updated_by_user_identity_account_id` BIGINT COMMENT 'Reference to the user or staff member who last updated this recruitment event session record.',
    `parent_recruitment_event_session_id` BIGINT COMMENT 'Self-referencing FK on recruitment_event_session (parent_recruitment_event_session_id)',
    `attendance_count` STRING COMMENT 'Actual number of prospective students or attendees who participated in or checked into this session.',
    `cancellation_reason` STRING COMMENT 'Explanation or reason provided when a recruitment event session is cancelled or postponed.',
    `capacity_available` STRING COMMENT 'Current number of open seats or slots remaining for registration in this session.',
    `capacity_total` STRING COMMENT 'Maximum number of prospective students or attendees that can be accommodated in this session.',
    `check_in_required_flag` BOOLEAN COMMENT 'Indicates whether attendees must check in upon arrival or at the start of the session for attendance tracking.',
    `confirmation_email_sent_flag` BOOLEAN COMMENT 'Indicates whether confirmation emails have been sent to registered attendees for this session.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this recruitment event session record was first created in the system.',
    `delivery_mode` STRING COMMENT 'Method by which the recruitment event session is delivered to prospective students.',
    `duration_minutes` STRING COMMENT 'Planned duration of the recruitment event session measured in minutes.',
    `meeting_access_code` STRING COMMENT 'Password or access code required to join the virtual session.',
    `presenter_names` STRING COMMENT 'Comma-separated list of names of faculty, staff, or student ambassadors who will present or facilitate this session.',
    `registration_close_date` DATE COMMENT 'Date when registration for this session closes and no further sign-ups are accepted.',
    `registration_open_date` DATE COMMENT 'Date when registration for this session becomes available to prospective students.',
    `registration_required_flag` BOOLEAN COMMENT 'Indicates whether prospective students must pre-register to attend this session.',
    `reminder_email_sent_flag` BOOLEAN COMMENT 'Indicates whether reminder emails have been sent to registered attendees prior to the session start.',
    `session_code` STRING COMMENT 'Externally-known unique code or identifier for the recruitment event session, used for registration and communication purposes.',
    `session_description` STRING COMMENT 'Detailed narrative description of the recruitment event session, including agenda, topics covered, and what prospective students can expect.',
    `session_end_timestamp` TIMESTAMP COMMENT 'Date and time when the recruitment event session is scheduled to conclude.',
    `session_name` STRING COMMENT 'Human-readable name or title of the recruitment event session (e.g., Engineering Open House Morning Session, Virtual Campus Tour - Fall 2024).',
    `session_notes` STRING COMMENT 'Internal notes or comments about the session for staff reference, including special instructions or post-event observations.',
    `session_start_timestamp` TIMESTAMP COMMENT 'Date and time when the recruitment event session is scheduled to begin.',
    `session_status` STRING COMMENT 'Current lifecycle status of the recruitment event session indicating its operational state.',
    `session_type` STRING COMMENT 'Classification of the recruitment event session by format and purpose.',
    `target_audience` STRING COMMENT 'Primary audience segment that this recruitment event session is designed to serve.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this recruitment event session record was last modified or updated.',
    `virtual_meeting_url` STRING COMMENT 'Web link or URL for accessing the virtual recruitment event session.',
    `virtual_platform` STRING COMMENT 'Name of the virtual meeting or webinar platform used for virtual or hybrid sessions (e.g., Zoom, Microsoft Teams, Webex).',
    `waitlist_enabled_flag` BOOLEAN COMMENT 'Indicates whether a waitlist is available for prospective students when the session reaches full capacity.',
    CONSTRAINT pk_recruitment_event_session PRIMARY KEY(`recruitment_event_session_id`)
) COMMENT 'Master reference table for recruitment_event_session. Referenced by event_session_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ADD CONSTRAINT `fk_enrollment_prospect_recruitment_territory_id` FOREIGN KEY (`recruitment_territory_id`) REFERENCES `education_ecm`.`enrollment`.`recruitment_territory`(`recruitment_territory_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ADD CONSTRAINT `fk_enrollment_enrollment_application_enrollment_applicant_id` FOREIGN KEY (`enrollment_applicant_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_applicant`(`enrollment_applicant_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ADD CONSTRAINT `fk_enrollment_enrollment_application_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ADD CONSTRAINT `fk_enrollment_enrollment_applicant_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `education_ecm`.`enrollment`.`prospect`(`prospect_id`);
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ADD CONSTRAINT `fk_enrollment_application_program_enrollment_application_id` FOREIGN KEY (`enrollment_application_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_application`(`enrollment_application_id`);
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ADD CONSTRAINT `fk_enrollment_application_program_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ADD CONSTRAINT `fk_enrollment_admission_decision_enrollment_applicant_id` FOREIGN KEY (`enrollment_applicant_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_applicant`(`enrollment_applicant_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ADD CONSTRAINT `fk_enrollment_admission_decision_enrollment_application_id` FOREIGN KEY (`enrollment_application_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_application`(`enrollment_application_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ADD CONSTRAINT `fk_enrollment_admission_decision_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ADD CONSTRAINT `fk_enrollment_enrollment_test_score_application_checklist_id` FOREIGN KEY (`application_checklist_id`) REFERENCES `education_ecm`.`enrollment`.`application_checklist`(`application_checklist_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ADD CONSTRAINT `fk_enrollment_enrollment_test_score_enrollment_applicant_id` FOREIGN KEY (`enrollment_applicant_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_applicant`(`enrollment_applicant_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ADD CONSTRAINT `fk_enrollment_enrollment_test_score_enrollment_application_id` FOREIGN KEY (`enrollment_application_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_application`(`enrollment_application_id`);
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ADD CONSTRAINT `fk_enrollment_application_checklist_enrollment_applicant_id` FOREIGN KEY (`enrollment_applicant_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_applicant`(`enrollment_applicant_id`);
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ADD CONSTRAINT `fk_enrollment_application_checklist_enrollment_application_id` FOREIGN KEY (`enrollment_application_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_application`(`enrollment_application_id`);
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ADD CONSTRAINT `fk_enrollment_recommendation_application_checklist_id` FOREIGN KEY (`application_checklist_id`) REFERENCES `education_ecm`.`enrollment`.`application_checklist`(`application_checklist_id`);
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ADD CONSTRAINT `fk_enrollment_recommendation_enrollment_application_id` FOREIGN KEY (`enrollment_application_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_application`(`enrollment_application_id`);
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ADD CONSTRAINT `fk_enrollment_transcript_application_checklist_id` FOREIGN KEY (`application_checklist_id`) REFERENCES `education_ecm`.`enrollment`.`application_checklist`(`application_checklist_id`);
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ADD CONSTRAINT `fk_enrollment_transcript_enrollment_applicant_id` FOREIGN KEY (`enrollment_applicant_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_applicant`(`enrollment_applicant_id`);
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ADD CONSTRAINT `fk_enrollment_transcript_enrollment_application_id` FOREIGN KEY (`enrollment_application_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_application`(`enrollment_application_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ADD CONSTRAINT `fk_enrollment_admission_criteria_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ADD CONSTRAINT `fk_enrollment_recruitment_event_recruitment_territory_id` FOREIGN KEY (`recruitment_territory_id`) REFERENCES `education_ecm`.`enrollment`.`recruitment_territory`(`recruitment_territory_id`);
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ADD CONSTRAINT `fk_enrollment_event_registration_enrollment_application_id` FOREIGN KEY (`enrollment_application_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_application`(`enrollment_application_id`);
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ADD CONSTRAINT `fk_enrollment_event_registration_recruitment_event_session_id` FOREIGN KEY (`recruitment_event_session_id`) REFERENCES `education_ecm`.`enrollment`.`recruitment_event_session`(`recruitment_event_session_id`);
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ADD CONSTRAINT `fk_enrollment_event_registration_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `education_ecm`.`enrollment`.`prospect`(`prospect_id`);
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ADD CONSTRAINT `fk_enrollment_event_registration_recruitment_event_id` FOREIGN KEY (`recruitment_event_id`) REFERENCES `education_ecm`.`enrollment`.`recruitment_event`(`recruitment_event_id`);
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ADD CONSTRAINT `fk_enrollment_communication_activity_enrollment_application_id` FOREIGN KEY (`enrollment_application_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_application`(`enrollment_application_id`);
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ADD CONSTRAINT `fk_enrollment_communication_activity_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `education_ecm`.`enrollment`.`prospect`(`prospect_id`);
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ADD CONSTRAINT `fk_enrollment_communication_activity_recruitment_event_id` FOREIGN KEY (`recruitment_event_id`) REFERENCES `education_ecm`.`enrollment`.`recruitment_event`(`recruitment_event_id`);
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ADD CONSTRAINT `fk_enrollment_deposit_admission_offer_id` FOREIGN KEY (`admission_offer_id`) REFERENCES `education_ecm`.`enrollment`.`admission_offer`(`admission_offer_id`);
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ADD CONSTRAINT `fk_enrollment_deposit_enrollment_application_id` FOREIGN KEY (`enrollment_application_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_application`(`enrollment_application_id`);
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ADD CONSTRAINT `fk_enrollment_deposit_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ADD CONSTRAINT `fk_enrollment_matriculation_admission_offer_id` FOREIGN KEY (`admission_offer_id`) REFERENCES `education_ecm`.`enrollment`.`admission_offer`(`admission_offer_id`);
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ADD CONSTRAINT `fk_enrollment_matriculation_deposit_id` FOREIGN KEY (`deposit_id`) REFERENCES `education_ecm`.`enrollment`.`deposit`(`deposit_id`);
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ADD CONSTRAINT `fk_enrollment_matriculation_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ADD CONSTRAINT `fk_enrollment_waitlist_admission_decision_id` FOREIGN KEY (`admission_decision_id`) REFERENCES `education_ecm`.`enrollment`.`admission_decision`(`admission_decision_id`);
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ADD CONSTRAINT `fk_enrollment_waitlist_enrollment_applicant_id` FOREIGN KEY (`enrollment_applicant_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_applicant`(`enrollment_applicant_id`);
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ADD CONSTRAINT `fk_enrollment_waitlist_enrollment_application_id` FOREIGN KEY (`enrollment_application_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_application`(`enrollment_application_id`);
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ADD CONSTRAINT `fk_enrollment_waitlist_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ADD CONSTRAINT `fk_enrollment_application_review_review_committee_id` FOREIGN KEY (`review_committee_id`) REFERENCES `education_ecm`.`enrollment`.`review_committee`(`review_committee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ADD CONSTRAINT `fk_enrollment_application_review_enrollment_application_id` FOREIGN KEY (`enrollment_application_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_application`(`enrollment_application_id`);
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ADD CONSTRAINT `fk_enrollment_application_review_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ADD CONSTRAINT `fk_enrollment_admission_offer_enrollment_applicant_id` FOREIGN KEY (`enrollment_applicant_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_applicant`(`enrollment_applicant_id`);
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ADD CONSTRAINT `fk_enrollment_admission_offer_enrollment_application_id` FOREIGN KEY (`enrollment_application_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_application`(`enrollment_application_id`);
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ADD CONSTRAINT `fk_enrollment_transfer_credit_eval_enrollment_application_id` FOREIGN KEY (`enrollment_application_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_application`(`enrollment_application_id`);
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ADD CONSTRAINT `fk_enrollment_transfer_credit_eval_transcript_id` FOREIGN KEY (`transcript_id`) REFERENCES `education_ecm`.`enrollment`.`transcript`(`transcript_id`);
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ADD CONSTRAINT `fk_enrollment_international_credential_enrollment_applicant_id` FOREIGN KEY (`enrollment_applicant_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_applicant`(`enrollment_applicant_id`);
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ADD CONSTRAINT `fk_enrollment_international_credential_enrollment_application_id` FOREIGN KEY (`enrollment_application_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_application`(`enrollment_application_id`);
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ADD CONSTRAINT `fk_enrollment_enrollment_registration_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ADD CONSTRAINT `fk_enrollment_waitlist_entry_enrollment_registration_id` FOREIGN KEY (`enrollment_registration_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_registration`(`enrollment_registration_id`);
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ADD CONSTRAINT `fk_enrollment_waitlist_entry_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ADD CONSTRAINT `fk_enrollment_add_drop_transaction_enrollment_registration_id` FOREIGN KEY (`enrollment_registration_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_registration`(`enrollment_registration_id`);
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ADD CONSTRAINT `fk_enrollment_add_drop_transaction_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`enrollment`.`census` ADD CONSTRAINT `fk_enrollment_census_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ADD CONSTRAINT `fk_enrollment_student_term_record_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ADD CONSTRAINT `fk_enrollment_registration_hold_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ADD CONSTRAINT `fk_enrollment_registration_override_enrollment_registration_id` FOREIGN KEY (`enrollment_registration_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_registration`(`enrollment_registration_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ADD CONSTRAINT `fk_enrollment_registration_override_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ADD CONSTRAINT `fk_enrollment_registration_period_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ADD CONSTRAINT `fk_enrollment_cross_list_group_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ADD CONSTRAINT `fk_enrollment_concurrent_enrollment_institution_id` FOREIGN KEY (`institution_id`) REFERENCES `education_ecm`.`enrollment`.`institution`(`institution_id`);
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ADD CONSTRAINT `fk_enrollment_concurrent_enrollment_term_id` FOREIGN KEY (`term_id`) REFERENCES `education_ecm`.`enrollment`.`term`(`term_id`);
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ADD CONSTRAINT `fk_enrollment_repeat_course_record_enrollment_registration_id` FOREIGN KEY (`enrollment_registration_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_registration`(`enrollment_registration_id`);
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ADD CONSTRAINT `fk_enrollment_repeat_course_record_repeat_enrollment_registration_id` FOREIGN KEY (`repeat_enrollment_registration_id`) REFERENCES `education_ecm`.`enrollment`.`enrollment_registration`(`enrollment_registration_id`);
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ADD CONSTRAINT `fk_enrollment_athletic_recruitment_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `education_ecm`.`enrollment`.`prospect`(`prospect_id`);
ALTER TABLE `education_ecm`.`enrollment`.`review_committee` ADD CONSTRAINT `fk_enrollment_review_committee_institution_id` FOREIGN KEY (`institution_id`) REFERENCES `education_ecm`.`enrollment`.`institution`(`institution_id`);
ALTER TABLE `education_ecm`.`enrollment`.`review_committee` ADD CONSTRAINT `fk_enrollment_review_committee_parent_review_committee_id` FOREIGN KEY (`parent_review_committee_id`) REFERENCES `education_ecm`.`enrollment`.`review_committee`(`review_committee_id`);
ALTER TABLE `education_ecm`.`enrollment`.`institution` ADD CONSTRAINT `fk_enrollment_institution_parent_institution_id` FOREIGN KEY (`parent_institution_id`) REFERENCES `education_ecm`.`enrollment`.`institution`(`institution_id`);
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event_session` ADD CONSTRAINT `fk_enrollment_recruitment_event_session_recruitment_event_id` FOREIGN KEY (`recruitment_event_id`) REFERENCES `education_ecm`.`enrollment`.`recruitment_event`(`recruitment_event_id`);
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event_session` ADD CONSTRAINT `fk_enrollment_recruitment_event_session_parent_recruitment_event_session_id` FOREIGN KEY (`parent_recruitment_event_session_id`) REFERENCES `education_ecm`.`enrollment`.`recruitment_event_session`(`recruitment_event_session_id`);

-- ========= TAGS =========
ALTER SCHEMA `education_ecm`.`enrollment` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `education_ecm`.`enrollment` SET TAGS ('dbx_domain' = 'enrollment');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect ID');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Admissions Counselor ID');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `recruitment_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Territory Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `act_score` SET TAGS ('dbx_business_glossary_term' = 'ACT Score (American College Testing)');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Prospect Street Address Line 1');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Prospect Street Address Line 2');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `birth_date` SET TAGS ('dbx_business_glossary_term' = 'Prospect Date of Birth');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `birth_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `birth_date` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `campus_visit_flag` SET TAGS ('dbx_business_glossary_term' = 'Campus Visit Completed Flag');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^d{2}.d{4}$');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_business_glossary_term' = 'Citizenship Status');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_value_regex' = 'us_citizen|permanent_resident|international|daca|refugee|unknown');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Prospect City');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `college_of_interest` SET TAGS ('dbx_business_glossary_term' = 'College or School of Interest');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `contact_preference` SET TAGS ('dbx_business_glossary_term' = 'Contact Preference');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `contact_preference` SET TAGS ('dbx_value_regex' = 'email|phone|text|mail|no_contact');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Prospect Home Country Code');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `degree_level` SET TAGS ('dbx_business_glossary_term' = 'Degree Level of Interest');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `degree_level` SET TAGS ('dbx_value_regex' = 'certificate|associate|bachelor|master|doctoral|professional');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `do_not_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Prospect Primary Email Address');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Prospect Ethnicity');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `first_generation_flag` SET TAGS ('dbx_business_glossary_term' = 'First-Generation College Student Flag');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Prospect First Name');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `ftiac_flag` SET TAGS ('dbx_business_glossary_term' = 'First-Time-In-Any-College (FTIAC) Flag');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Prospect Gender Identity');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say|unknown');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `gpa_self_reported` SET TAGS ('dbx_business_glossary_term' = 'Self-Reported High School Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `high_school_ceeb_code` SET TAGS ('dbx_business_glossary_term' = 'High School CEEB Code');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `high_school_ceeb_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `high_school_graduation_year` SET TAGS ('dbx_business_glossary_term' = 'High School Graduation Year');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `inquiry_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Inquiry Date');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `inquiry_source` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Source');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `intended_entry_term` SET TAGS ('dbx_business_glossary_term' = 'Intended Entry Term');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `intended_entry_year` SET TAGS ('dbx_business_glossary_term' = 'Intended Entry Year');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Recruitment Activity Date');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Prospect Last Name');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Prospect Middle Name');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Prospect Primary Phone Number');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Prospect Preferred Name');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `program_of_interest` SET TAGS ('dbx_business_glossary_term' = 'Program of Interest');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `prospect_type` SET TAGS ('dbx_business_glossary_term' = 'Prospect Type');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `prospect_type` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|transfer|international|non_degree|dual_enrollment');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `recruitment_stage` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Stage');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `recruitment_stage` SET TAGS ('dbx_value_regex' = 'inquiry|prospect|applicant|admitted|enrolled|inactive');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `sat_score` SET TAGS ('dbx_business_glossary_term' = 'SAT Score (Scholastic Assessment Test)');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `slate_prospect_code` SET TAGS ('dbx_business_glossary_term' = 'Slate CRM Prospect ID');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'Prospect Home State Code');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `visa_type` SET TAGS ('dbx_business_glossary_term' = 'Visa Type');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `visa_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'Prospect ZIP Code');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `zip_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`prospect` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `enrollment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Application ID');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program ID');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `aid_application_id` SET TAGS ('dbx_business_glossary_term' = 'Aid Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter / Admissions Counselor ID');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `enrollment_applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant ID');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'College / School ID');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Application Term ID');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `title_ix_case_id` SET TAGS ('dbx_business_glossary_term' = 'Title Ix Case Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `academic_level` SET TAGS ('dbx_business_glossary_term' = 'Academic Level');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `academic_level` SET TAGS ('dbx_value_regex' = 'Undergraduate|Graduate|Professional|Certificate|Non-Degree');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `act_composite_score` SET TAGS ('dbx_business_glossary_term' = 'American College Testing (ACT) Composite Score');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `act_composite_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `application_source` SET TAGS ('dbx_business_glossary_term' = 'Application Source');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `application_source` SET TAGS ('dbx_value_regex' = 'Common App|Coalition App|Institution Direct|Transfer Portal|Graduate Direct|International Portal');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `application_status` SET TAGS ('dbx_value_regex' = 'Incomplete|Complete|Under Review|Decision Made|Withdrawn|Cancelled');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `application_type` SET TAGS ('dbx_business_glossary_term' = 'Application Type');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `application_type` SET TAGS ('dbx_value_regex' = 'FTIAC|Transfer|Graduate|Professional|Re-Admit|Non-Degree');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `athletics_recruit_flag` SET TAGS ('dbx_business_glossary_term' = 'Athletics Recruit Flag');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `checklist_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Application Checklist Complete Flag');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^d{2}.d{4}$');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_business_glossary_term' = 'Citizenship Status');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_value_regex' = 'US Citizen|Permanent Resident|Non-Resident Alien|Refugee|DACA|Unknown');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `confirmation_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Confirmation Deadline Date');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Admissions Decision Date');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `decision_status` SET TAGS ('dbx_business_glossary_term' = 'Admissions Decision Status');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `decision_status` SET TAGS ('dbx_value_regex' = 'Pending|Admitted|Denied|Waitlisted|Deferred|Conditional Admit');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `early_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Early Action Flag');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `early_decision_flag` SET TAGS ('dbx_business_glossary_term' = 'Early Decision Flag');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `enrollment_intent` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Intent');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `enrollment_intent` SET TAGS ('dbx_value_regex' = 'Confirmed|Declined|Pending|Deferred Enrollment');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Application Fee Amount');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `fee_paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Application Fee Paid Flag');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `fee_waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Application Fee Waiver Flag');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `first_generation_flag` SET TAGS ('dbx_business_glossary_term' = 'First Generation College Student Flag');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `high_school_gpa` SET TAGS ('dbx_business_glossary_term' = 'High School Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `high_school_gpa` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `ielts_score` SET TAGS ('dbx_business_glossary_term' = 'International English Language Testing System (IELTS) Score');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `ielts_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `materials_complete_date` SET TAGS ('dbx_business_glossary_term' = 'Application Materials Complete Date');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `prior_institution_code` SET TAGS ('dbx_business_glossary_term' = 'Prior Institution ID');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `priority_deadline_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Deadline Flag');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `residency_classification` SET TAGS ('dbx_business_glossary_term' = 'Residency Classification');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `residency_classification` SET TAGS ('dbx_value_regex' = 'In-State|Out-of-State|International|Unknown');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `sat_total_score` SET TAGS ('dbx_business_glossary_term' = 'Scholastic Assessment Test (SAT) Total Score');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `sat_total_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `scholarship_consideration_flag` SET TAGS ('dbx_business_glossary_term' = 'Merit Scholarship Consideration Flag');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Banner|Slate|Both');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `special_population_code` SET TAGS ('dbx_business_glossary_term' = 'Special Population Code');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submitted Date');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `test_optional_flag` SET TAGS ('dbx_business_glossary_term' = 'Test Optional Flag');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `toefl_score` SET TAGS ('dbx_business_glossary_term' = 'Test of English as a Foreign Language (TOEFL) Score');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `toefl_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `transfer_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Transfer Credit Hours');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `visa_type` SET TAGS ('dbx_business_glossary_term' = 'Visa Type');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `visa_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Application Withdrawal Reason');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_application` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_value_regex' = 'Enrolled Elsewhere|Financial Reasons|Personal Reasons|Program Not Available|No Response|Other');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `enrollment_applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant ID');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Slate CRM Prospect ID');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `prospect_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `prospect_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `academic_level` SET TAGS ('dbx_business_glossary_term' = 'Academic Level');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `academic_level` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|doctoral|professional|certificate|non_degree');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `act_composite_score` SET TAGS ('dbx_business_glossary_term' = 'American College Testing (ACT) Composite Score');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `admissions_decision_code` SET TAGS ('dbx_business_glossary_term' = 'Admissions Decision Code');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `admissions_decision_code` SET TAGS ('dbx_value_regex' = 'admitted|denied|waitlisted|deferred|conditional_admit|withdrawn');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `admissions_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Admissions Decision Date');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `applicant_type` SET TAGS ('dbx_business_glossary_term' = 'Applicant Type');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `application_fee_paid` SET TAGS ('dbx_business_glossary_term' = 'Application Fee Paid Indicator');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `application_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submitted Date');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `banner_pidm` SET TAGS ('dbx_business_glossary_term' = 'Banner Person Identification Master (PIDM)');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `banner_pidm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `banner_pidm` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `birth_date` SET TAGS ('dbx_business_glossary_term' = 'Applicant Date of Birth');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `birth_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `birth_date` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_business_glossary_term' = 'Applicant Citizenship Status');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_value_regex' = 'us_citizen|permanent_resident|nonresident_alien|refugee|daca|unknown');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `country_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Country of Birth (ISO 3166-1 Alpha-3)');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `country_of_birth` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `country_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `country_of_birth` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `country_of_citizenship` SET TAGS ('dbx_business_glossary_term' = 'Country of Citizenship (ISO 3166-1 Alpha-3)');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `country_of_citizenship` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `country_of_citizenship` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `country_of_citizenship` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Disclosure Status');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `disability_status` SET TAGS ('dbx_value_regex' = 'disclosed|not_disclosed|no_disability|prefer_not_to_say');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Applicant Personal Email Address');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `enrollment_deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Deposit Date');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `enrollment_deposit_paid` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Deposit Paid Indicator');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `entry_term_code` SET TAGS ('dbx_business_glossary_term' = 'Intended Entry Term Code');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_business_glossary_term' = 'Applicant Ethnicity Code');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `fee_waiver_type` SET TAGS ('dbx_business_glossary_term' = 'Application Fee Waiver Type');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `fee_waiver_type` SET TAGS ('dbx_value_regex' = 'college_board|act|nacac|institutional|none');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `ferpa_consent_date` SET TAGS ('dbx_business_glossary_term' = 'FERPA Consent Date');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `ferpa_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'FERPA Consent Flag');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `first_generation_indicator` SET TAGS ('dbx_business_glossary_term' = 'First-Generation College Student Indicator');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant First Name');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `gender_identity` SET TAGS ('dbx_business_glossary_term' = 'Applicant Gender Identity');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `gender_identity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `high_school_ceeb_code` SET TAGS ('dbx_business_glossary_term' = 'High School College Entrance Examination Board (CEEB) Code');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `high_school_ceeb_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `high_school_gpa` SET TAGS ('dbx_business_glossary_term' = 'High School Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `ielts_score` SET TAGS ('dbx_business_glossary_term' = 'International English Language Testing System (IELTS) Band Score');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `inquiry_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Inquiry Date');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `intended_college_code` SET TAGS ('dbx_business_glossary_term' = 'Intended College/School Code');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `intended_program_code` SET TAGS ('dbx_business_glossary_term' = 'Intended Program Code (CIP)');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Last Name');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Middle Name');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Applicant Primary Phone Number');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Preferred Name');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `prior_college_gpa` SET TAGS ('dbx_business_glossary_term' = 'Prior College Cumulative Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `recruitment_source_code` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Source Code');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `residency_classification` SET TAGS ('dbx_business_glossary_term' = 'Residency Classification');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `residency_classification` SET TAGS ('dbx_value_regex' = 'in_state|out_of_state|international|military|unknown');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `sat_total_score` SET TAGS ('dbx_business_glossary_term' = 'Scholastic Assessment Test (SAT) Total Score');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `state_of_legal_residence` SET TAGS ('dbx_business_glossary_term' = 'State of Legal Residence (USPS 2-Letter Code)');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `state_of_legal_residence` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `state_of_legal_residence` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `state_of_legal_residence` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `toefl_score` SET TAGS ('dbx_business_glossary_term' = 'Test of English as a Foreign Language (TOEFL) Score');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `transfer_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Transfer Credit Hours');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `veteran_status` SET TAGS ('dbx_business_glossary_term' = 'Veteran/Military Status');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_applicant` ALTER COLUMN `veteran_status` SET TAGS ('dbx_value_regex' = 'non_veteran|veteran|active_duty|reservist|dependent|unknown');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `application_program_id` SET TAGS ('dbx_business_glossary_term' = 'Application Program ID');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program ID');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `department_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `enrollment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'College ID');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `plan_academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Plan ID');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Term ID');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Program Accreditation Body');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Program Accreditation Status');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|candidate|provisional|not_accredited');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Program Status');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `application_type` SET TAGS ('dbx_business_glossary_term' = 'Application Type');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `application_type` SET TAGS ('dbx_value_regex' = 'freshman|transfer|graduate|international|readmission');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `attendance_type` SET TAGS ('dbx_business_glossary_term' = 'Attendance Type');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `attendance_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|less_than_half_time');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `campus_code` SET TAGS ('dbx_business_glossary_term' = 'Campus Code');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `campus_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^d{2}.d{4}$');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `concentration_code` SET TAGS ('dbx_business_glossary_term' = 'Concentration Code');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `concentration_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `concentration_name` SET TAGS ('dbx_business_glossary_term' = 'Concentration Name');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Program Application Deadline Date');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `deadline_type` SET TAGS ('dbx_business_glossary_term' = 'Application Deadline Type');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `deadline_type` SET TAGS ('dbx_value_regex' = 'early_action|early_decision|regular_decision|rolling|priority');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `decision_code` SET TAGS ('dbx_business_glossary_term' = 'Admissions Decision Code');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Admissions Decision Date');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `degree_level` SET TAGS ('dbx_business_glossary_term' = 'Degree Level');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `degree_level` SET TAGS ('dbx_value_regex' = 'certificate|associate|bachelor|master|doctoral|professional');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `degree_type` SET TAGS ('dbx_business_glossary_term' = 'Degree Type');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `degree_type` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Program Delivery Mode');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_value_regex' = 'on_campus|online|hybrid|blended');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `enrollment_confirm_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Confirmation Date');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `enrollment_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Confirmation Flag');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `expected_graduation_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Graduation Date');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `fee_waiver_granted` SET TAGS ('dbx_business_glossary_term' = 'Application Fee Waiver Granted Flag');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `is_dual_degree` SET TAGS ('dbx_business_glossary_term' = 'Dual Degree Program Flag');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `is_primary_program` SET TAGS ('dbx_business_glossary_term' = 'Primary Program Flag');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Admissions Program Notes');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Program Priority Rank');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Code');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Name');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `required_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Required Credit Hours (CR)');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `residency_classification` SET TAGS ('dbx_business_glossary_term' = 'Residency Classification');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `residency_classification` SET TAGS ('dbx_value_regex' = 'in_state|out_of_state|international');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `scholarship_consideration` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Consideration Flag');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `source_system_key` SET TAGS ('dbx_business_glossary_term' = 'Source System Key');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `student_type` SET TAGS ('dbx_business_glossary_term' = 'Student Type');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `student_type` SET TAGS ('dbx_value_regex' = 'ftiac|transfer|readmit|graduate|non_degree');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Program Application Submitted Date');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`application_program` ALTER COLUMN `waitlist_position` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Position');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `admission_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Admission Decision ID');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `award_package_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Package ID');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `enrollment_applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant ID');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `enrollment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Period ID');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `applicant_response` SET TAGS ('dbx_business_glossary_term' = 'Applicant Response');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `applicant_response` SET TAGS ('dbx_value_regex' = 'accepted|declined|deferred_response|no_response');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `applicant_response_date` SET TAGS ('dbx_business_glossary_term' = 'Applicant Response Date');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `condition_deadline` SET TAGS ('dbx_business_glossary_term' = 'Admission Condition Deadline');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `condition_description` SET TAGS ('dbx_business_glossary_term' = 'Admission Condition Description');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `decision_authority_type` SET TAGS ('dbx_business_glossary_term' = 'Decision Authority Type');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `decision_authority_type` SET TAGS ('dbx_value_regex' = 'committee|automated_rules_engine|individual_reviewer|dean_override');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `decision_cycle` SET TAGS ('dbx_business_glossary_term' = 'Decision Cycle');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Decision Date');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `decision_number` SET TAGS ('dbx_business_glossary_term' = 'Admission Decision Number');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `decision_status` SET TAGS ('dbx_business_glossary_term' = 'Admission Decision Status');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `decision_status` SET TAGS ('dbx_value_regex' = 'pending|finalized|rescinded|superseded');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Admission Decision Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `decision_type` SET TAGS ('dbx_business_glossary_term' = 'Admission Decision Type');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `decision_type` SET TAGS ('dbx_value_regex' = 'admit|deny|waitlist|defer|conditional_admit');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `defer_target_term` SET TAGS ('dbx_business_glossary_term' = 'Defer Target Term');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `deny_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `enrollment_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Deposit Amount');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `enrollment_deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `enrollment_deposit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `enrollment_deposit_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Deposit Paid Date');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `holistic_review_score` SET TAGS ('dbx_business_glossary_term' = 'Holistic Review Score');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `honors_designation` SET TAGS ('dbx_business_glossary_term' = 'Honors Designation');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `is_conditional` SET TAGS ('dbx_business_glossary_term' = 'Conditional Admission Flag');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `is_honors_eligible` SET TAGS ('dbx_business_glossary_term' = 'Honors Program Eligibility Flag');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `is_rescinded` SET TAGS ('dbx_business_glossary_term' = 'Offer Rescinded Flag');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `is_scholarship_eligible` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Eligibility Flag');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `offer_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Offer Delivery Method');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `offer_delivery_method` SET TAGS ('dbx_value_regex' = 'portal|email|mail|in_person');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `offer_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Expiration Date');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `offer_letter_generated_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Letter Generated Date');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `offer_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Sent Date');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `rescind_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Rescission Date');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `rescind_reason` SET TAGS ('dbx_business_glossary_term' = 'Offer Rescission Reason');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `scholarship_amount` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Amount');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `scholarship_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `scholarship_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'banner|slate|manual');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `waitlist_offered_date` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Offer Date');
ALTER TABLE `education_ecm`.`enrollment`.`admission_decision` ALTER COLUMN `waitlist_rank` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Rank');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `enrollment_test_score_id` SET TAGS ('dbx_business_glossary_term' = 'Test Score ID');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `application_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Application Checklist Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `enrollment_applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant ID');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `enrollment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `academic_program_code` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Code');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `composite_score` SET TAGS ('dbx_business_glossary_term' = 'Composite Score');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'International Credential Type');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `english_proficiency_waiver` SET TAGS ('dbx_business_glossary_term' = 'English Proficiency Waiver Flag');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `evaluation_agency` SET TAGS ('dbx_business_glossary_term' = 'Credential Evaluation Agency');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `evaluation_report_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Evaluation Report Date');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `gpa_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Grade Point Average (GPA) Equivalent');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `ipeds_test_score_flag` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Test Score Flag');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `issuing_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Institution Name');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `language_of_instruction` SET TAGS ('dbx_business_glossary_term' = 'Language of Instruction');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `language_of_instruction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `meets_minimum_requirement` SET TAGS ('dbx_business_glossary_term' = 'Meets Minimum Score Requirement Flag');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `percentile_rank` SET TAGS ('dbx_business_glossary_term' = 'Percentile Rank');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `record_type` SET TAGS ('dbx_business_glossary_term' = 'Test Score Record Type');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `record_type` SET TAGS ('dbx_value_regex' = 'standardized_test|international_credential');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `score_notes` SET TAGS ('dbx_business_glossary_term' = 'Score Notes');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `score_report_date` SET TAGS ('dbx_business_glossary_term' = 'Score Report Date');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `score_report_number` SET TAGS ('dbx_business_glossary_term' = 'Score Report Number');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `score_section_1_label` SET TAGS ('dbx_business_glossary_term' = 'Score Section 1 Label');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `score_section_1_value` SET TAGS ('dbx_business_glossary_term' = 'Score Section 1 Value');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `score_section_2_label` SET TAGS ('dbx_business_glossary_term' = 'Score Section 2 Label');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `score_section_2_value` SET TAGS ('dbx_business_glossary_term' = 'Score Section 2 Value');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `score_section_3_label` SET TAGS ('dbx_business_glossary_term' = 'Score Section 3 Label');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `score_section_3_value` SET TAGS ('dbx_business_glossary_term' = 'Score Section 3 Value');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `score_section_4_label` SET TAGS ('dbx_business_glossary_term' = 'Score Section 4 Label');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `score_section_4_value` SET TAGS ('dbx_business_glossary_term' = 'Score Section 4 Value');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `score_source` SET TAGS ('dbx_business_glossary_term' = 'Score Source');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `score_source` SET TAGS ('dbx_value_regex' = 'self_reported|official|agency_verified');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `score_status` SET TAGS ('dbx_business_glossary_term' = 'Score Status');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `score_status` SET TAGS ('dbx_value_regex' = 'pending|received|verified|expired|waived|rejected');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `score_validity_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Score Validity Expiry Date');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `superscore` SET TAGS ('dbx_business_glossary_term' = 'Superscore');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `superscore_eligible` SET TAGS ('dbx_business_glossary_term' = 'Superscore Eligible Flag');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Term Code');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `test_optional_waiver` SET TAGS ('dbx_business_glossary_term' = 'Test Optional Waiver Flag');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `testing_agency_code` SET TAGS ('dbx_business_glossary_term' = 'Testing Agency Code');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `us_equivalent_degree_level` SET TAGS ('dbx_business_glossary_term' = 'US-Equivalent Degree Level');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_test_score` ALTER COLUMN `used_in_admissions_decision` SET TAGS ('dbx_business_glossary_term' = 'Used in Admissions Decision Flag');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `application_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Application Checklist ID');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `enrollment_applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant ID');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `enrollment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `ceeb_fice_code` SET TAGS ('dbx_business_glossary_term' = 'College Entrance Examination Board / Federal Interagency Committee on Education (CEEB/FICE) Code');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `ceeb_fice_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,6}$');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `checklist_code` SET TAGS ('dbx_business_glossary_term' = 'Checklist Item Code');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `checklist_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,30}$');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `class_rank` SET TAGS ('dbx_business_glossary_term' = 'Class Rank');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `class_rank` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `class_size` SET TAGS ('dbx_business_glossary_term' = 'Graduating Class Size');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `credit_hours_earned` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR) Earned');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `cumulative_gpa` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `cumulative_gpa` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Checklist Item Deadline Date');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `ferpa_waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Family Educational Rights and Privacy Act (FERPA) Waiver of Access Flag');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `gpa_scale` SET TAGS ('dbx_business_glossary_term' = 'Grade Point Average (GPA) Scale');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `is_required` SET TAGS ('dbx_business_glossary_term' = 'Required Item Flag');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Checklist Item Description');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `item_status` SET TAGS ('dbx_business_glossary_term' = 'Checklist Item Status');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `item_status` SET TAGS ('dbx_value_regex' = 'pending|received|waived|incomplete|verified|rejected');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `item_type` SET TAGS ('dbx_business_glossary_term' = 'Checklist Item Type');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `official_score_flag` SET TAGS ('dbx_business_glossary_term' = 'Official Score Report Flag');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Item Received Date');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `recommender_email` SET TAGS ('dbx_business_glossary_term' = 'Recommender Email Address');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `recommender_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `recommender_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `recommender_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `recommender_institution` SET TAGS ('dbx_business_glossary_term' = 'Recommender Institution');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `recommender_name` SET TAGS ('dbx_business_glossary_term' = 'Recommender Full Name');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `recommender_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `recommender_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `recommender_rating_academic` SET TAGS ('dbx_business_glossary_term' = 'Recommender Academic Rating');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `recommender_rating_academic` SET TAGS ('dbx_value_regex' = 'exceptional|strong|good|average|below_average|no_basis');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `recommender_rating_personal` SET TAGS ('dbx_business_glossary_term' = 'Recommender Personal Character Rating');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `recommender_rating_personal` SET TAGS ('dbx_value_regex' = 'exceptional|strong|good|average|below_average|no_basis');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `recommender_relationship` SET TAGS ('dbx_business_glossary_term' = 'Recommender Relationship to Applicant');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `recommender_relationship` SET TAGS ('dbx_value_regex' = 'academic|professional|personal|employer|coach|other');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `recommender_title` SET TAGS ('dbx_business_glossary_term' = 'Recommender Title');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Reminder Notification Sent Date');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Notes');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `sending_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Sending Institution Name');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Checklist Item Sort Order');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic|mail|fax|hand_delivered|third_party_service|email');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Term Code');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `term_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `test_score` SET TAGS ('dbx_business_glossary_term' = 'Standardized Test Score');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `test_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Standardized Test Type');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `transcript_type` SET TAGS ('dbx_business_glossary_term' = 'Transcript Type');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `transcript_type` SET TAGS ('dbx_value_regex' = 'high_school|undergraduate|graduate|international|ged|other');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `verified_date` SET TAGS ('dbx_business_glossary_term' = 'Item Verified Date');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Requirement Waiver Flag');
ALTER TABLE `education_ecm`.`enrollment`.`application_checklist` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `recommendation_id` SET TAGS ('dbx_business_glossary_term' = 'Recommendation ID');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `application_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Item ID');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `enrollment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `ferpa_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Ferpa Disclosure Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `academic_ability_rating` SET TAGS ('dbx_business_glossary_term' = 'Academic Ability Rating');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `academic_ability_rating` SET TAGS ('dbx_value_regex' = 'exceptional|strong|good|average|below_average|insufficient_basis');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `applicant_rank_percentile` SET TAGS ('dbx_business_glossary_term' = 'Applicant Rank Percentile');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `character_rating` SET TAGS ('dbx_business_glossary_term' = 'Character and Personal Qualities Rating');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `character_rating` SET TAGS ('dbx_value_regex' = 'exceptional|strong|good|average|below_average|insufficient_basis');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Deadline Date');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `document_file_name` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Document File Name');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `document_page_count` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Document Page Count');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `document_storage_path` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Document Storage Path');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `document_storage_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `ferpa_waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Family Educational Rights and Privacy Act (FERPA) Waiver Date');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `ferpa_waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Family Educational Rights and Privacy Act (FERPA) Waiver Flag');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `form_type` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Form Type');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `form_type` SET TAGS ('dbx_value_regex' = 'open_letter|structured_form|hybrid');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Recommendation Flag');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `last_reminder_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reminder Date');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `leadership_rating` SET TAGS ('dbx_business_glossary_term' = 'Leadership Potential Rating');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `leadership_rating` SET TAGS ('dbx_value_regex' = 'exceptional|strong|good|average|below_average|insufficient_basis');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Recommendation Rating');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'exceptional|strong|good|average|below_average|insufficient_basis');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Target Program Type');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|doctoral|professional|certificate');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Received Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `recommender_department` SET TAGS ('dbx_business_glossary_term' = 'Recommender Department');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `recommender_email` SET TAGS ('dbx_business_glossary_term' = 'Recommender Email Address');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `recommender_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `recommender_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `recommender_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `recommender_first_name` SET TAGS ('dbx_business_glossary_term' = 'Recommender First Name');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `recommender_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `recommender_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `recommender_institution` SET TAGS ('dbx_business_glossary_term' = 'Recommender Institution');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `recommender_last_name` SET TAGS ('dbx_business_glossary_term' = 'Recommender Last Name');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `recommender_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `recommender_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `recommender_phone` SET TAGS ('dbx_business_glossary_term' = 'Recommender Phone Number');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `recommender_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `recommender_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `recommender_title` SET TAGS ('dbx_business_glossary_term' = 'Recommender Title');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `relationship_description` SET TAGS ('dbx_business_glossary_term' = 'Recommender Relationship Description');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `relationship_duration_years` SET TAGS ('dbx_business_glossary_term' = 'Recommender Relationship Duration (Years)');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Recommender Relationship Type');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'academic|professional|personal|research|supervisory|other');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `reminder_count` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Reminder Count');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Request Date');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Admissions Review Notes');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `review_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'banner|slate|common_app|coalition_app|interfolio|manual');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `source_system_rec_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Recommendation Identifier');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `strength` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Strength');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `strength` SET TAGS ('dbx_value_regex' = 'highly_recommend|recommend|recommend_with_reservations|cannot_recommend');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Submission Date');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Submission Method');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'online_portal|mail|email|fax|hand_delivered|interfolio');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Submission Status');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Application Term Code');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Verification Status');
ALTER TABLE `education_ecm`.`enrollment`.`recommendation` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|verified|failed|waived');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `transcript_id` SET TAGS ('dbx_business_glossary_term' = 'Transcript ID');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `application_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Application Checklist Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Transcript Evaluator ID');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `enrollment_applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant ID');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `enrollment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `ferpa_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Ferpa Disclosure Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `academic_standing` SET TAGS ('dbx_business_glossary_term' = 'Academic Standing');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `academic_standing` SET TAGS ('dbx_value_regex' = 'good_standing|academic_probation|academic_suspension|academic_dismissal|dean_list');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `academic_standing` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `ceeb_code` SET TAGS ('dbx_business_glossary_term' = 'College Entrance Examination Board (CEEB) Code');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `ceeb_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `class_rank` SET TAGS ('dbx_business_glossary_term' = 'Class Rank');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `class_rank` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `class_size` SET TAGS ('dbx_business_glossary_term' = 'Graduating Class Size');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `credit_system` SET TAGS ('dbx_business_glossary_term' = 'Credit System');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `credit_system` SET TAGS ('dbx_value_regex' = 'semester|quarter|trimester|ects|unit');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `credits_attempted` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR) Attempted');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `credits_earned` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR) Earned');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `credits_transferable` SET TAGS ('dbx_business_glossary_term' = 'Transferable Credit Hours (CR)');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `cumulative_gpa` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `cumulative_gpa` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `degree_awarded` SET TAGS ('dbx_business_glossary_term' = 'Degree Awarded');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Transcript Delivery Method');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'electronic|mail|hand_delivered|fax');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `disciplinary_notation` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Notation Flag');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `disciplinary_notation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `document_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transcript Document Reference Number');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `document_source_system` SET TAGS ('dbx_business_glossary_term' = 'Transcript Document Source System');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `document_source_system` SET TAGS ('dbx_value_regex' = 'parchment|national_student_clearinghouse|scrip_safe|paper|edi|other');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Transcript Evaluation Date');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Transcript Evaluation Status');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|evaluated|accepted|rejected|on_hold');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `fice_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Interagency Committee on Education (FICE) Code');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `fice_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `foreign_credential_eval_agency` SET TAGS ('dbx_business_glossary_term' = 'Foreign Credential Evaluation Agency');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `foreign_credential_eval_date` SET TAGS ('dbx_business_glossary_term' = 'Foreign Credential Evaluation Date');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `foreign_credential_eval_required` SET TAGS ('dbx_business_glossary_term' = 'Foreign Credential Evaluation Required Flag');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `gpa_scale` SET TAGS ('dbx_business_glossary_term' = 'Grade Point Average (GPA) Scale');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `graduation_date` SET TAGS ('dbx_business_glossary_term' = 'Graduation Date');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `graduation_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `honors_notation` SET TAGS ('dbx_business_glossary_term' = 'Honors Notation');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `honors_notation` SET TAGS ('dbx_value_regex' = 'cum_laude|magna_cum_laude|summa_cum_laude|honors|none');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `institution_country` SET TAGS ('dbx_business_glossary_term' = 'Sending Institution Country');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `institution_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `institution_name` SET TAGS ('dbx_business_glossary_term' = 'Sending Institution Name');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `institution_state` SET TAGS ('dbx_business_glossary_term' = 'Sending Institution State');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `institution_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `major_field_of_study` SET TAGS ('dbx_business_glossary_term' = 'Major Field of Study');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transcript Evaluation Notes');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `official_flag` SET TAGS ('dbx_business_glossary_term' = 'Official Transcript Flag');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Transcript Receipt Date');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `term_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Term End Date');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `term_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Term Start Date');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `transcript_type` SET TAGS ('dbx_business_glossary_term' = 'Transcript Type');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `transcript_type` SET TAGS ('dbx_value_regex' = 'high_school|undergraduate|graduate|professional|vocational');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Transcript Verification Date');
ALTER TABLE `education_ecm`.`enrollment`.`transcript` ALTER COLUMN `verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Transcript Verified Flag');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `admission_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Admission Criteria ID');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authored By Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `accreditation_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Accreditation Standard Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `accreditation_body_code` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body Code');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `application_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Application Deadline Date');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `automated_screening_enabled` SET TAGS ('dbx_business_glossary_term' = 'Automated Eligibility Screening Enabled Flag');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `citizenship_requirement` SET TAGS ('dbx_business_glossary_term' = 'Citizenship Requirement');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `citizenship_requirement` SET TAGS ('dbx_value_regex' = 'US_CITIZEN|PERMANENT_RESIDENT|INTERNATIONAL|ANY');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `citizenship_requirement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `citizenship_requirement` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `criteria_code` SET TAGS ('dbx_business_glossary_term' = 'Admission Criteria Code');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `criteria_name` SET TAGS ('dbx_business_glossary_term' = 'Admission Criteria Name');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `criteria_notes` SET TAGS ('dbx_business_glossary_term' = 'Admission Criteria Notes');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `criteria_status` SET TAGS ('dbx_business_glossary_term' = 'Admission Criteria Status');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `criteria_status` SET TAGS ('dbx_value_regex' = 'DRAFT|ACTIVE|INACTIVE|ARCHIVED');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `criteria_type` SET TAGS ('dbx_business_glossary_term' = 'Admission Criteria Type');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `criteria_type` SET TAGS ('dbx_value_regex' = 'STANDARD|HOLISTIC|SELECTIVE|OPEN_ADMISSION|CONDITIONAL');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `decision_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Decision Notification Date');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `entry_level_code` SET TAGS ('dbx_business_glossary_term' = 'Entry Level Code');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `entry_level_code` SET TAGS ('dbx_value_regex' = 'FRESHMAN|TRANSFER|GRADUATE|DOCTORAL|CERTIFICATE|PROFESSIONAL');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `essay_weight_pct` SET TAGS ('dbx_business_glossary_term' = 'Essay Weight Percentage');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `extracurricular_weight_pct` SET TAGS ('dbx_business_glossary_term' = 'Extracurricular Activity Weight Percentage');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `gpa_scale` SET TAGS ('dbx_business_glossary_term' = 'Grade Point Average (GPA) Scale');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `gpa_weight_pct` SET TAGS ('dbx_business_glossary_term' = 'GPA (Grade Point Average) Weight Percentage');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `holistic_review_enabled` SET TAGS ('dbx_business_glossary_term' = 'Holistic Review Enabled Flag');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `interview_format` SET TAGS ('dbx_business_glossary_term' = 'Interview Format');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `interview_format` SET TAGS ('dbx_value_regex' = 'IN_PERSON|VIRTUAL|PANEL|MMI|NONE');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `interview_required` SET TAGS ('dbx_business_glossary_term' = 'Interview Required Flag');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `letters_of_recommendation_required` SET TAGS ('dbx_business_glossary_term' = 'Letters of Recommendation Required Count');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `min_act_composite` SET TAGS ('dbx_business_glossary_term' = 'Minimum ACT (American College Testing) Composite Score');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `min_class_rank_pct` SET TAGS ('dbx_business_glossary_term' = 'Minimum Class Rank Percentile');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `min_credit_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Minimum Credit Hours (CR) Completed');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `min_gmat_total` SET TAGS ('dbx_business_glossary_term' = 'Minimum GMAT (Graduate Management Admission Test) Total Score');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `min_gpa` SET TAGS ('dbx_business_glossary_term' = 'Minimum Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `min_gre_quantitative` SET TAGS ('dbx_business_glossary_term' = 'Minimum GRE (Graduate Record Examination) Quantitative Score');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `min_gre_verbal` SET TAGS ('dbx_business_glossary_term' = 'Minimum GRE (Graduate Record Examination) Verbal Score');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `min_ielts_band` SET TAGS ('dbx_business_glossary_term' = 'Minimum IELTS (International English Language Testing System) Band Score');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `min_sat_total` SET TAGS ('dbx_business_glossary_term' = 'Minimum SAT (Scholastic Assessment Test) Total Score');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `min_toefl_score` SET TAGS ('dbx_business_glossary_term' = 'Minimum TOEFL (Test of English as a Foreign Language) Score');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `personal_statement_required` SET TAGS ('dbx_business_glossary_term' = 'Personal Statement Required Flag');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `portfolio_required` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Required Flag');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `portfolio_type` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Type');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `portfolio_type` SET TAGS ('dbx_value_regex' = 'CREATIVE|PROFESSIONAL|RESEARCH|DIGITAL|NONE');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `prerequisite_coursework_description` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Coursework Description');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `prerequisite_coursework_required` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Coursework Required Flag');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `priority_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Priority Application Deadline Date');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `residency_requirement` SET TAGS ('dbx_business_glossary_term' = 'Residency Requirement');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `residency_requirement` SET TAGS ('dbx_value_regex' = 'IN_STATE|OUT_OF_STATE|INTERNATIONAL|DOMESTIC|ANY');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `test_optional_flag` SET TAGS ('dbx_business_glossary_term' = 'Test Optional Flag');
ALTER TABLE `education_ecm`.`enrollment`.`admission_criteria` ALTER COLUMN `test_score_weight_pct` SET TAGS ('dbx_business_glossary_term' = 'Test Score Weight Percentage');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `recruitment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event ID');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Host Admissions Counselor ID');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `recruitment_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Territory Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Venue Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `academic_term` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Academic Term');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Academic Year');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `academic_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `actual_attendance` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Actual Attendance');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Actual Cost');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Cancellation Reason');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `college_unit` SET TAGS ('dbx_business_glossary_term' = 'Recruiting College or Academic Unit');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Delivery Mode');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_value_regex' = 'in_person|virtual|hybrid');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event End Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Estimated Cost');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Date');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Name');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Status');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'draft|published|active|completed|cancelled|postponed');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Type');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'open_house|campus_tour|college_fair|virtual_info_session|high_school_visit|yield_event');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `is_registration_required` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Registration Required Flag');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `is_virtual_platform_recorded` SET TAGS ('dbx_business_glossary_term' = 'Virtual Event Recording Available Flag');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Notes');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `program_focus` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Program Focus');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `registered_count` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Registered Count');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `registration_capacity` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Registration Capacity');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `registration_close_date` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Registration Close Date');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `registration_open_date` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Registration Open Date');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `staff_count` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Staff Count');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Start Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Target Audience');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `target_audience` SET TAGS ('dbx_value_regex' = 'ftiac|transfer|graduate|international|undecided');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `venue_city` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Venue City');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `venue_country` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Venue Country');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `venue_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `venue_name` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Venue Name');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `venue_state_province` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Venue State or Province');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `venue_state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `virtual_event_url` SET TAGS ('dbx_business_glossary_term' = 'Virtual Event URL');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `virtual_platform` SET TAGS ('dbx_business_glossary_term' = 'Virtual Event Platform');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `virtual_platform` SET TAGS ('dbx_value_regex' = 'zoom|teams|webex|youtube_live|other');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event` ALTER COLUMN `waitlist_count` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Waitlist Count');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `event_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Event Registration ID');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Admissions Counselor ID');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `enrollment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `recruitment_event_session_id` SET TAGS ('dbx_business_glossary_term' = 'Event Session ID');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect ID');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `recruit_id` SET TAGS ('dbx_business_glossary_term' = 'Recruit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `recruitment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event ID');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `academic_term_code` SET TAGS ('dbx_business_glossary_term' = 'Target Academic Term Code');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `accessibility_accommodation` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Accommodation Request');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `accessibility_accommodation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `application_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Application Submitted Flag');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Cancellation Date');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'schedule_conflict|no_longer_interested|enrolled_elsewhere|transportation|illness|other');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `check_in_method` SET TAGS ('dbx_business_glossary_term' = 'Check-In Method');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `check_in_method` SET TAGS ('dbx_value_regex' = 'qr_code|staff_manual|self_service_kiosk|mobile_app|online_virtual');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Check-In Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `communication_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Communication Opt-In Flag');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Communication Consent Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `dietary_restriction` SET TAGS ('dbx_business_glossary_term' = 'Dietary Restriction');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `first_generation_flag` SET TAGS ('dbx_business_glossary_term' = 'First-Generation College Student Flag');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Event Follow-Up Date');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_business_glossary_term' = 'Post-Event Follow-Up Status');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_value_regex' = 'pending|contacted|completed|not_required');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `ftiac_flag` SET TAGS ('dbx_business_glossary_term' = 'First-Time-In-Any-College (FTIAC) Flag');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `guest_count` SET TAGS ('dbx_business_glossary_term' = 'Registered Guest Count');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `intended_degree_level` SET TAGS ('dbx_business_glossary_term' = 'Intended Degree Level');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `intended_degree_level` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|doctoral|professional|certificate|non_degree');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `intended_program_code` SET TAGS ('dbx_business_glossary_term' = 'Intended Program Code (CIP)');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Admissions Staff Notes');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `registration_channel` SET TAGS ('dbx_business_glossary_term' = 'Registration Channel');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `registration_channel` SET TAGS ('dbx_value_regex' = 'web_portal|email_link|staff_entry|mobile_app|third_party_fair');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date and Time');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Confirmation Number');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `registration_number` SET TAGS ('dbx_value_regex' = '^REG-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `registration_source_code` SET TAGS ('dbx_business_glossary_term' = 'Registration Source Code');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Event Registration Status');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'registered|attended|no_show|cancelled|waitlisted|pending');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `residency_type` SET TAGS ('dbx_business_glossary_term' = 'Residency Type');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `residency_type` SET TAGS ('dbx_value_regex' = 'domestic|international');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `survey_response_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Event Survey Response Date');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `survey_response_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Event Survey Response Flag');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `survey_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Post-Event Survey Satisfaction Score');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `transportation_assistance_flag` SET TAGS ('dbx_business_glossary_term' = 'Transportation Assistance Requested Flag');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `virtual_attendance_flag` SET TAGS ('dbx_business_glossary_term' = 'Virtual Attendance Flag');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `virtual_platform_session_code` SET TAGS ('dbx_business_glossary_term' = 'Virtual Platform Session ID');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `waitlist_position` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Position');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `yield_segment` SET TAGS ('dbx_business_glossary_term' = 'Yield Modeling Segment');
ALTER TABLE `education_ecm`.`enrollment`.`event_registration` ALTER COLUMN `yield_segment` SET TAGS ('dbx_value_regex' = 'high_intent|medium_intent|low_intent|unknown');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `communication_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Activity ID');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Staff User ID');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `enrollment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect ID');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `recruit_id` SET TAGS ('dbx_business_glossary_term' = 'Recruit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `recruitment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `academic_period` SET TAGS ('dbx_business_glossary_term' = 'Academic Period');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `academic_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `bounce_type` SET TAGS ('dbx_business_glossary_term' = 'Email Bounce Type');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `bounce_type` SET TAGS ('dbx_value_regex' = 'hard|soft|none');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `click_count` SET TAGS ('dbx_business_glossary_term' = 'Click Count');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `clicked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clicked Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `communication_notes` SET TAGS ('dbx_business_glossary_term' = 'Communication Notes');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `communication_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `communication_purpose` SET TAGS ('dbx_business_glossary_term' = 'Communication Purpose');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `communication_type` SET TAGS ('dbx_business_glossary_term' = 'Communication Type');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `communication_type` SET TAGS ('dbx_value_regex' = 'email|sms|phone|mail|portal_message|chat');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `degree_level` SET TAGS ('dbx_business_glossary_term' = 'Degree Level');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `degree_level` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|doctoral|professional|certificate');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `delivered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivered Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'sent|delivered|failed|bounced|pending|cancelled');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Communication Direction');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'outbound|inbound');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `enrollment_stage` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Funnel Stage');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `ferpa_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'FERPA Disclosure Flag');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated Communication Flag');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `is_clicked` SET TAGS ('dbx_business_glossary_term' = 'Is Clicked Flag');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `is_opened` SET TAGS ('dbx_business_glossary_term' = 'Is Opened Flag');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `is_responded` SET TAGS ('dbx_business_glossary_term' = 'Is Responded Flag');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `mail_piece_type` SET TAGS ('dbx_business_glossary_term' = 'Mail Piece Type');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `mail_piece_type` SET TAGS ('dbx_value_regex' = 'viewbook|letter|postcard|package|brochure|other');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `open_count` SET TAGS ('dbx_business_glossary_term' = 'Open Count');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opened Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Flag');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `opt_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `phone_call_duration_sec` SET TAGS ('dbx_business_glossary_term' = 'Phone Call Duration (Seconds)');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `phone_call_duration_sec` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `phone_call_duration_sec` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `phone_call_outcome` SET TAGS ('dbx_business_glossary_term' = 'Phone Call Outcome');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `phone_call_outcome` SET TAGS ('dbx_value_regex' = 'connected|voicemail|no_answer|busy|wrong_number');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `phone_call_outcome` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `phone_call_outcome` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `program_of_interest` SET TAGS ('dbx_business_glossary_term' = 'Program of Interest');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `prospect_geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Prospect Geographic Region');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `recruiter_territory` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Territory');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `responded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Responded Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `scheduled_send_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Send Date');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sent Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `slate_activity_ref` SET TAGS ('dbx_business_glossary_term' = 'Slate CRM Activity Reference');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'slate|banner|manual|other');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `subject_line` SET TAGS ('dbx_business_glossary_term' = 'Communication Subject Line');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Communication Template Code');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Communication Template Name');
ALTER TABLE `education_ecm`.`enrollment`.`communication_activity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `deposit_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Deposit ID');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `admission_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Admission Offer Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `enrollment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Term ID');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `academic_level` SET TAGS ('dbx_business_glossary_term' = 'Academic Level');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `academic_level` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|doctoral|professional|certificate');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `academic_program_code` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Code');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `admit_type` SET TAGS ('dbx_business_glossary_term' = 'Admit Type');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `admit_type` SET TAGS ('dbx_value_regex' = 'freshman|transfer|graduate|readmit|international|non_degree');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Deposit Amount');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount Paid');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `amount_paid` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `amount_paid` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `college_code` SET TAGS ('dbx_business_glossary_term' = 'College Code');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `deadline` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Deposit Deadline');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `deposit_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Deposit Number');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `deposit_number` SET TAGS ('dbx_value_regex' = '^DEP-[0-9]{8,12}$');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `deposit_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Deposit Status');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `deposit_status` SET TAGS ('dbx_value_regex' = 'pending|received|cleared|refunded|waived|cancelled');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `deposit_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Deposit Type');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `deposit_type` SET TAGS ('dbx_value_regex' = 'tuition|housing|orientation|health|parking|other');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `financial_aid_applicant` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Applicant Flag');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `first_generation_student` SET TAGS ('dbx_business_glossary_term' = 'First-Generation Student Flag');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `geographic_origin` SET TAGS ('dbx_business_glossary_term' = 'Geographic Origin State Code');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `geographic_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `housing_preference` SET TAGS ('dbx_business_glossary_term' = 'Housing Preference');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `housing_preference` SET TAGS ('dbx_value_regex' = 'on_campus|off_campus|undecided');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `is_refunded` SET TAGS ('dbx_business_glossary_term' = 'Deposit Refund Flag');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `is_waived` SET TAGS ('dbx_business_glossary_term' = 'Deposit Waiver Flag');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `matriculation_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Matriculation Confirmed Flag');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `matriculation_date` SET TAGS ('dbx_business_glossary_term' = 'Matriculation Date');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Deposit Notes');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Deposit Payment Channel');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'online_portal|in_person|mail|phone|third_party');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Payment Date');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Deposit Payment Method');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `recruitment_source` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Source');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Refund Amount');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `refund_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `refund_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `refund_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Refund Date');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `refund_reason` SET TAGS ('dbx_business_glossary_term' = 'Deposit Refund Reason');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `refund_reason` SET TAGS ('dbx_value_regex' = 'student_withdrew|admission_rescinded|duplicate_payment|institutional_error|other');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `scholarship_recipient` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Recipient Flag');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'banner|slate|touchnet|nelnet|cashnet|manual');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Deposit Waiver Approved By');
ALTER TABLE `education_ecm`.`enrollment`.`deposit` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Deposit Waiver Reason');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `matriculation_id` SET TAGS ('dbx_business_glossary_term' = 'Matriculation ID');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `admission_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Admission Offer Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `aid_application_id` SET TAGS ('dbx_business_glossary_term' = 'Aid Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `deposit_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Deposit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Academic Advisor ID');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `student_athlete_id` SET TAGS ('dbx_business_glossary_term' = 'Student Athlete Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `academic_standing` SET TAGS ('dbx_business_glossary_term' = 'Academic Standing at Matriculation');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `academic_standing` SET TAGS ('dbx_value_regex' = 'good-standing|probation|suspension|dismissed|new-student');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `admit_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Decision Date');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `admit_type` SET TAGS ('dbx_business_glossary_term' = 'Admit Type');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `admit_type` SET TAGS ('dbx_value_regex' = 'regular|early-action|early-decision|rolling|transfer|readmit');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `cohort_code` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Cohort Code');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `college_code` SET TAGS ('dbx_business_glossary_term' = 'College/School Code');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `degree_type` SET TAGS ('dbx_business_glossary_term' = 'Degree Type');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Deposit Date');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `deposit_paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Deposit Paid Flag');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'full-time|half-time|less-than-half-time|not-enrolled');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `entry_level` SET TAGS ('dbx_business_glossary_term' = 'Entry Level');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `entry_level` SET TAGS ('dbx_value_regex' = 'freshman|transfer|graduate|doctoral|professional|readmit');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `financial_aid_applicant_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Applicant Flag (FAFSA)');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `first_generation_flag` SET TAGS ('dbx_business_glossary_term' = 'First-Generation College Student Flag');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `ftiac_flag` SET TAGS ('dbx_business_glossary_term' = 'First-Time-In-Any-College (FTIAC) Flag');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `housing_intent` SET TAGS ('dbx_business_glossary_term' = 'Housing Intent');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `housing_intent` SET TAGS ('dbx_value_regex' = 'on-campus|off-campus|commuter|unknown');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `instructional_method` SET TAGS ('dbx_business_glossary_term' = 'Instructional Method');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `instructional_method` SET TAGS ('dbx_value_regex' = 'in-person|online|hybrid|blended|correspondence');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `international_flag` SET TAGS ('dbx_business_glossary_term' = 'International Student Flag');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `matriculation_date` SET TAGS ('dbx_business_glossary_term' = 'Matriculation Date');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `matriculation_status` SET TAGS ('dbx_business_glossary_term' = 'Matriculation Status');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `matriculation_status` SET TAGS ('dbx_value_regex' = 'active|cancelled|deferred|withdrawn|deceased');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `orientation_date` SET TAGS ('dbx_business_glossary_term' = 'Orientation Completion Date');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `orientation_status` SET TAGS ('dbx_business_glossary_term' = 'Orientation Registration Status');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `orientation_status` SET TAGS ('dbx_value_regex' = 'registered|completed|waived|not-required|pending');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `person_uid` SET TAGS ('dbx_business_glossary_term' = 'Person Unique Identifier (UID)');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `person_uid` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `person_uid` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `prior_institution_code` SET TAGS ('dbx_business_glossary_term' = 'Prior Institution FICE/IPEDS Code');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Code');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Name');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `residency_status` SET TAGS ('dbx_business_glossary_term' = 'Residency Status');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `residency_status` SET TAGS ('dbx_value_regex' = 'in-state|out-of-state|international|military|unknown');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Banner|Slate|Manual|Migration|Other');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `stem_flag` SET TAGS ('dbx_business_glossary_term' = 'STEM Program Flag');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `student_level` SET TAGS ('dbx_business_glossary_term' = 'Student Level');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `student_level` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|professional|non-degree');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `transfer_credits_accepted` SET TAGS ('dbx_business_glossary_term' = 'Transfer Credits Accepted');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `transfer_flag` SET TAGS ('dbx_business_glossary_term' = 'Transfer Student Flag');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `veteran_flag` SET TAGS ('dbx_business_glossary_term' = 'Veteran/Military-Affiliated Student Flag');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `visa_type` SET TAGS ('dbx_business_glossary_term' = 'Visa Type');
ALTER TABLE `education_ecm`.`enrollment`.`matriculation` ALTER COLUMN `visa_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `waitlist_id` SET TAGS ('dbx_business_glossary_term' = 'Waitlist ID');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `admission_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Admission Decision Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `department_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Admissions Counselor ID');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `enrollment_applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant ID');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `enrollment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'College ID');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Term ID');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `academic_level` SET TAGS ('dbx_business_glossary_term' = 'Academic Level');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `academic_level` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|doctoral|professional|certificate');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `applicant_response` SET TAGS ('dbx_business_glossary_term' = 'Applicant Waitlist Response');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `applicant_response` SET TAGS ('dbx_value_regex' = 'accepted|declined|no_response');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `applicant_response_date` SET TAGS ('dbx_business_glossary_term' = 'Applicant Waitlist Response Date');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `capacity_pool_size` SET TAGS ('dbx_business_glossary_term' = 'Capacity Pool Size');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_business_glossary_term' = 'Citizenship Status');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_value_regex' = 'us_citizen|permanent_resident|international|daca|unknown');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `communication_preference` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `communication_preference` SET TAGS ('dbx_value_regex' = 'email|portal|mail|phone');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Entry Type');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'ftiac|transfer|readmit|international|non_degree');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `ferpa_release_on_file` SET TAGS ('dbx_business_glossary_term' = 'FERPA Release on File Indicator');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `final_disposition` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Final Disposition');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `final_disposition` SET TAGS ('dbx_value_regex' = 'admitted|denied|withdrew|no_action');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `final_disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Final Disposition Date');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `financial_aid_impact` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Impact Status');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `financial_aid_impact` SET TAGS ('dbx_value_regex' = 'eligible|not_eligible|pending_review');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `intended_enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Intended Enrollment Type');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `intended_enrollment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `is_position_disclosed` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Position Disclosed Indicator');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `is_ranked` SET TAGS ('dbx_business_glossary_term' = 'Ranked Waitlist Indicator');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Notes');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Notification Date');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `offer_accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Offer Accepted Date');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `offer_extended_date` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Offer Extended Date');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `offer_response_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Offer Response Deadline Date');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `pool_size` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Pool Size');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `position` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Position');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `prior_institution_code` SET TAGS ('dbx_business_glossary_term' = 'Prior Institution Code');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Reason');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `residency_status` SET TAGS ('dbx_business_glossary_term' = 'Residency Status');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `residency_status` SET TAGS ('dbx_value_regex' = 'in_state|out_of_state|international');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `response_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Response Deadline Date');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `scholarship_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Eligibility Indicator');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Source Channel');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'online_portal|paper|slate_crm|edi|staff_entry');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'banner|slate|manual');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `waitlist_date` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Date');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `waitlist_number` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Number');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `waitlist_number` SET TAGS ('dbx_value_regex' = '^WL-[0-9]{4}-[A-Z0-9]{6,12}$');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `waitlist_status` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Status');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `waitlist_status` SET TAGS ('dbx_value_regex' = 'active|offer_extended|admitted|denied|withdrew|expired');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `waitlist_type` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Type');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist` ALTER COLUMN `waitlist_type` SET TAGS ('dbx_value_regex' = 'standard|priority|alternate|conditional');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `application_review_id` SET TAGS ('dbx_business_glossary_term' = 'Application Review ID');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `review_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Admissions Committee ID');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `enrollment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Reviewer Instructor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Period ID');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `academic_score` SET TAGS ('dbx_business_glossary_term' = 'Academic Evaluation Score');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `academic_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `banner_review_ref` SET TAGS ('dbx_business_glossary_term' = 'Banner SIS Review Reference');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `conflict_of_interest_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Flag');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `decision_alignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Decision Alignment Flag');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `degree_level` SET TAGS ('dbx_business_glossary_term' = 'Degree Level');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `degree_level` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|doctoral|professional|certificate');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `essay_score` SET TAGS ('dbx_business_glossary_term' = 'Essay Evaluation Score');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `extracurricular_score` SET TAGS ('dbx_business_glossary_term' = 'Extracurricular Activities Score');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `first_generation_noted` SET TAGS ('dbx_business_glossary_term' = 'First-Generation Student Noted Flag');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `honors_nomination` SET TAGS ('dbx_business_glossary_term' = 'Honors Program Nomination Flag');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Admissions Notes');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `international_applicant_noted` SET TAGS ('dbx_business_glossary_term' = 'International Applicant Noted Flag');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `interview_score` SET TAGS ('dbx_business_glossary_term' = 'Interview Evaluation Score');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `is_blind_review` SET TAGS ('dbx_business_glossary_term' = 'Blind Review Flag');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Holistic Review Score');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `recommendation` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Recommendation');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `recommendation` SET TAGS ('dbx_value_regex' = 'admit|deny|waitlist|defer|further_review');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `recommendation_score` SET TAGS ('dbx_business_glossary_term' = 'Letters of Recommendation Score');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `recommendation_strength` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Strength');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `recommendation_strength` SET TAGS ('dbx_value_regex' = 'strong|moderate|weak|neutral');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `recusal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Recusal Reason');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `review_duration_min` SET TAGS ('dbx_business_glossary_term' = 'Review Duration (Minutes)');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `review_method` SET TAGS ('dbx_business_glossary_term' = 'Review Method');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `review_method` SET TAGS ('dbx_value_regex' = 'online_portal|paper|committee_meeting|video_conference');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Review Reference Number');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `review_round` SET TAGS ('dbx_business_glossary_term' = 'Review Round');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `review_round` SET TAGS ('dbx_value_regex' = 'first_read|second_read|committee|final|appeal');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `review_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Start Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|withdrawn|overridden');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `review_submit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Submit Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Narrative Comments');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `reviewer_type` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Type');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `reviewer_type` SET TAGS ('dbx_value_regex' = 'admissions_staff|faculty|alumni|committee_member|external_reader');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `rubric_version` SET TAGS ('dbx_business_glossary_term' = 'Scoring Rubric Version');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `scholarship_nomination` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Nomination Flag');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `score_scale_max` SET TAGS ('dbx_business_glossary_term' = 'Score Scale Maximum');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `slate_review_ref` SET TAGS ('dbx_business_glossary_term' = 'Slate CRM Review Reference');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `special_talent_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Talent Flag');
ALTER TABLE `education_ecm`.`enrollment`.`application_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `admission_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Admission Offer ID');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Admissions Counselor ID');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `enrollment_applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant ID');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `enrollment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `admit_type` SET TAGS ('dbx_business_glossary_term' = 'Admit Type');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `admit_type` SET TAGS ('dbx_value_regex' = 'freshman|transfer|graduate|readmit|international|non_degree');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `applicant_response` SET TAGS ('dbx_business_glossary_term' = 'Applicant Response');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `applicant_response` SET TAGS ('dbx_value_regex' = 'accepted|declined|deferred_response|no_response');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `applicant_response_date` SET TAGS ('dbx_business_glossary_term' = 'Applicant Response Date');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'CIP (Classification of Instructional Programs) Code');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `coa_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Attendance (COA) Amount');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `coa_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `coa_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `college_unit_code` SET TAGS ('dbx_business_glossary_term' = 'College Unit Code');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `condition_notes` SET TAGS ('dbx_business_glossary_term' = 'Condition Notes');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `conditions_of_admission` SET TAGS ('dbx_business_glossary_term' = 'Conditions of Admission');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `conditions_of_admission` SET TAGS ('dbx_value_regex' = 'unconditional|conditional_final_transcript|conditional_english_proficiency|conditional_prerequisite|conditional_other');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `decision_authority` SET TAGS ('dbx_business_glossary_term' = 'Decision Authority');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `decision_authority` SET TAGS ('dbx_value_regex' = 'committee|dean|director|automated|department');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `degree_level` SET TAGS ('dbx_business_glossary_term' = 'Degree Level');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `degree_level` SET TAGS ('dbx_value_regex' = 'certificate|associate|bachelor|master|doctoral|professional');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Offer Delivery Method');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'portal|email|mail|in_person');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Offer Delivery Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Deposit Amount');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `deposit_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Deposit Paid Date');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `deposit_required` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Deposit Required Flag');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `entry_academic_year` SET TAGS ('dbx_business_glossary_term' = 'Entry Academic Year');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `entry_academic_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `entry_term_code` SET TAGS ('dbx_business_glossary_term' = 'Entry Term Code');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `entry_term_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}(FA|SP|SU|WI)$');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Expiration Date');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `ftiac_flag` SET TAGS ('dbx_business_glossary_term' = 'First-Time-In-Any-College (FTIAC) Flag');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `honors_designation` SET TAGS ('dbx_business_glossary_term' = 'Honors Designation');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `honors_designation` SET TAGS ('dbx_value_regex' = 'none|honors_college|honors_program|presidential_scholars');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `housing_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Housing Guarantee Flag');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `international_student` SET TAGS ('dbx_business_glossary_term' = 'International Student Flag');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `issued_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Issued Date');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `offer_letter_template_code` SET TAGS ('dbx_business_glossary_term' = 'Offer Letter Template Code');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `offer_number` SET TAGS ('dbx_business_glossary_term' = 'Admission Offer Number');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `offer_number` SET TAGS ('dbx_value_regex' = '^ADM-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Admission Offer Status');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `portal_viewed` SET TAGS ('dbx_business_glossary_term' = 'Portal Viewed Flag');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `portal_viewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Portal Viewed Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `rescind_reason` SET TAGS ('dbx_business_glossary_term' = 'Offer Rescind Reason');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `rescind_reason` SET TAGS ('dbx_value_regex' = 'academic_deficiency|conduct_violation|fraudulent_application|capacity|other');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `rescinded_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Rescinded Date');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `scholarship_amount` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Amount');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `scholarship_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `scholarship_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `scholarship_name` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Name');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `scholarship_renewable` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Renewable Flag');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `scholarship_renewal_gpa` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Renewal GPA (Grade Point Average) Requirement');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `stem_designated` SET TAGS ('dbx_business_glossary_term' = 'STEM (Science Technology Engineering Mathematics) Designated Flag');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `toefl_waived` SET TAGS ('dbx_business_glossary_term' = 'TOEFL (Test of English as a Foreign Language) Waived Flag');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `visa_type_required` SET TAGS ('dbx_business_glossary_term' = 'Visa Type Required');
ALTER TABLE `education_ecm`.`enrollment`.`admission_offer` ALTER COLUMN `visa_type_required` SET TAGS ('dbx_value_regex' = 'F-1|J-1|M-1|other|not_applicable');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `transfer_credit_eval_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Credit Evaluation ID');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `aid_sap_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Financialaid Sap Evaluation Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `articulation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Articulation Agreement ID');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `athletic_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Athletic Eligibility Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator User ID');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `enrollment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Equivalent Institutional Course ID');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluating Department ID');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `transcript_id` SET TAGS ('dbx_business_glossary_term' = 'Transcript Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `appeal_decision` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `appeal_decision` SET TAGS ('dbx_value_regex' = 'upheld|overturned|pending|withdrawn');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `appeal_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `awarded_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Awarded Credit Hours');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `course_level` SET TAGS ('dbx_business_glossary_term' = 'Transfer Course Level');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `course_level` SET TAGS ('dbx_value_regex' = 'lower_division|upper_division|graduate|remedial|professional');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `credential_eval_service` SET TAGS ('dbx_business_glossary_term' = 'Credential Evaluation Service');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `credit_awarded_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Awarded Flag');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `credit_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Credit Type');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `credit_type` SET TAGS ('dbx_value_regex' = 'direct_equivalent|elective|generic|remedial|no_credit|advanced_standing');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `degree_program_applicability` SET TAGS ('dbx_business_glossary_term' = 'Degree Program Applicability');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Denial Reason');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `eval_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `eval_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `eval_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Credit Evaluation Reference Number');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `eval_reference_number` SET TAGS ('dbx_value_regex' = '^TCE-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `eval_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `eval_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|approved|denied|conditional|withdrawn');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `eval_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Type');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `eval_type` SET TAGS ('dbx_value_regex' = 'individual_review|articulation_agreement|statewide_policy|national_policy');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `intended_entry_term` SET TAGS ('dbx_business_glossary_term' = 'Intended Entry Term');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `min_grade_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Grade Required for Transfer');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `posted_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Posted Date');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `posted_to_transcript_flag` SET TAGS ('dbx_business_glossary_term' = 'Posted to Transcript Flag');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `sending_cip_code` SET TAGS ('dbx_business_glossary_term' = 'Sending Course Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `sending_cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `sending_course_number` SET TAGS ('dbx_business_glossary_term' = 'Sending Institution Course Number');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `sending_course_title` SET TAGS ('dbx_business_glossary_term' = 'Sending Institution Course Title');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `sending_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Sending Institution Credit Hours');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `sending_credit_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Sending Institution Credit Unit Type');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `sending_credit_unit_type` SET TAGS ('dbx_value_regex' = 'semester_hour|quarter_hour|ects_credit|clock_hour|other');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `sending_grade` SET TAGS ('dbx_business_glossary_term' = 'Sending Institution Grade Earned');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `sending_grade_points` SET TAGS ('dbx_business_glossary_term' = 'Sending Institution Grade Points');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `sending_institution_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Sending Institution Accreditation Status');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `sending_institution_accreditation` SET TAGS ('dbx_value_regex' = 'regionally_accredited|nationally_accredited|foreign_recognized|unaccredited|unknown');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'banner|slate|manual');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `term_completed` SET TAGS ('dbx_business_glossary_term' = 'Term Completed at Sending Institution');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `transcript_source_type` SET TAGS ('dbx_business_glossary_term' = 'Transcript Source Type');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `transcript_source_type` SET TAGS ('dbx_value_regex' = 'official_paper|official_electronic|unofficial|self_reported');
ALTER TABLE `education_ecm`.`enrollment`.`transfer_credit_eval` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `international_credential_id` SET TAGS ('dbx_business_glossary_term' = 'International Credential ID');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `enrollment_applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant ID');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `enrollment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Foreign Institution Accreditation Status');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|recognized|unrecognized|unknown|under_review');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `admissions_reviewer_notes` SET TAGS ('dbx_business_glossary_term' = 'Admissions Reviewer Notes');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `admissions_reviewer_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `credential_award_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Award Date');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `credential_code` SET TAGS ('dbx_business_glossary_term' = 'International Credential Code');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `credential_code` SET TAGS ('dbx_value_regex' = '^INTLCRED-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `credential_name` SET TAGS ('dbx_business_glossary_term' = 'Foreign Credential Name');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `credential_status` SET TAGS ('dbx_business_glossary_term' = 'International Credential Status');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `credential_status` SET TAGS ('dbx_value_regex' = 'received|under_review|evaluated|accepted|rejected|pending_official');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'International Credential Type');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `credential_type` SET TAGS ('dbx_value_regex' = 'transcript|degree_certificate|diploma|mark_sheet|credential_evaluation_report|other');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `credit_hours_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Evaluated Credit Hours (CR)');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `document_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Credential Document Delivery Method');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `document_delivery_method` SET TAGS ('dbx_value_regex' = 'mail|email|upload|agency_direct|courier');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `document_received_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Document Received Date');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `ects_credits` SET TAGS ('dbx_business_glossary_term' = 'European Credit Transfer System (ECTS) Credits');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Foreign Institution Enrollment End Date');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Foreign Institution Enrollment Start Date');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `evaluated_gpa` SET TAGS ('dbx_business_glossary_term' = 'Evaluated Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `evaluation_agency_membership` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Agency Membership Body');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `evaluation_agency_membership` SET TAGS ('dbx_value_regex' = 'NACES|AICE|other|none');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `evaluation_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Credential Evaluation Agency Name');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `evaluation_report_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Evaluation Report Date');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `evaluation_report_number` SET TAGS ('dbx_business_glossary_term' = 'Credential Evaluation Report Number');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `field_of_study` SET TAGS ('dbx_business_glossary_term' = 'Field of Study');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `is_official_document` SET TAGS ('dbx_business_glossary_term' = 'Official Document Indicator');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `is_translated` SET TAGS ('dbx_business_glossary_term' = 'Translation Required Indicator');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `isced_level` SET TAGS ('dbx_business_glossary_term' = 'International Standard Classification of Education (ISCED) Level');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `issuing_institution_city` SET TAGS ('dbx_business_glossary_term' = 'Issuing Institution City');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `issuing_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Institution Name');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `original_grade_value` SET TAGS ('dbx_business_glossary_term' = 'Original Foreign Grade Value');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `original_grading_scale` SET TAGS ('dbx_business_glossary_term' = 'Original Foreign Grading Scale');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Banner|Slate|manual');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `translation_agency` SET TAGS ('dbx_business_glossary_term' = 'Translation Agency Name');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `us_equivalent_degree_level` SET TAGS ('dbx_business_glossary_term' = 'US Equivalent Degree Level');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Verification Date');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Credential Verification Status');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|verified|failed|waived');
ALTER TABLE `education_ecm`.`enrollment`.`international_credential` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Credential Verified By');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `recruitment_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Territory ID');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Admissions Counselor ID');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `tertiary_recruitment_assigned_counselor_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Academic Year');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `academic_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `banner_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Ellucian Banner Territory Code');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `college_unit_focus` SET TAGS ('dbx_business_glossary_term' = 'College Unit Focus');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `counties_covered` SET TAGS ('dbx_business_glossary_term' = 'Counties Covered');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `countries_covered` SET TAGS ('dbx_business_glossary_term' = 'Countries Covered');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `degree_level_focus` SET TAGS ('dbx_business_glossary_term' = 'Degree Level Focus');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `degree_level_focus` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|both|professional|doctoral');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Territory Effective End Date');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Territory Effective Start Date');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `high_school_count` SET TAGS ('dbx_business_glossary_term' = 'High School Count in Territory');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `is_first_generation_focus` SET TAGS ('dbx_business_glossary_term' = 'First-Generation Student Focus Flag');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `is_international` SET TAGS ('dbx_business_glossary_term' = 'International Territory Flag');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `is_stem_focus` SET TAGS ('dbx_business_glossary_term' = 'Science Technology Engineering Mathematics (STEM) Focus Flag');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Territory Priority Tier');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `slate_territory_ref` SET TAGS ('dbx_business_glossary_term' = 'Slate CRM Territory Reference ID');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `states_covered` SET TAGS ('dbx_business_glossary_term' = 'States Covered');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `target_applicant_volume` SET TAGS ('dbx_business_glossary_term' = 'Target Applicant Volume');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `target_enrolled_volume` SET TAGS ('dbx_business_glossary_term' = 'Target Enrolled Volume');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `target_prospect_volume` SET TAGS ('dbx_business_glossary_term' = 'Target Prospect Volume');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Territory Code');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Territory Name');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `territory_notes` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Territory Notes');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `territory_region` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Territory Region');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Territory Status');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|archived');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Territory Type');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'domestic|international|virtual|hybrid');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `travel_budget` SET TAGS ('dbx_business_glossary_term' = 'Territory Travel Budget');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `travel_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `virtual_platform` SET TAGS ('dbx_business_glossary_term' = 'Virtual Recruitment Platform');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `virtual_platform` SET TAGS ('dbx_value_regex' = 'zoom|teams|webex|slate_events|other|none');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_territory` ALTER COLUMN `zip_codes_covered` SET TAGS ('dbx_business_glossary_term' = 'ZIP Codes Covered');
ALTER TABLE `education_ecm`.`enrollment`.`term` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `education_ecm`.`enrollment`.`term` SET TAGS ('dbx_subdomain' = 'course_registration');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Term ID');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `academic_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `add_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Add Deadline Date');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `banner_term_ref` SET TAGS ('dbx_business_glossary_term' = 'Ellucian Banner Term Reference Code');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `calendar_type` SET TAGS ('dbx_business_glossary_term' = 'Academic Calendar Type');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `calendar_type` SET TAGS ('dbx_value_regex' = 'semester|quarter|trimester|4-1-4');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `census_date` SET TAGS ('dbx_business_glossary_term' = 'Census Date');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `commencement_date` SET TAGS ('dbx_business_glossary_term' = 'Commencement Date');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `degree_conferral_date` SET TAGS ('dbx_business_glossary_term' = 'Degree Conferral Date');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `drop_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Drop Deadline Date');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Term End Date');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `financial_aid_disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Disbursement Date');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `financial_aid_year_code` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Year Code');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `financial_aid_year_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `fte_credit_hour_threshold` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Credit Hour Threshold');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `grade_change_deadline` SET TAGS ('dbx_business_glossary_term' = 'Grade Change Deadline');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `grade_submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Grade Submission Deadline');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `half_time_credit_hour_threshold` SET TAGS ('dbx_business_glossary_term' = 'Half-Time Credit Hour Threshold');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `incomplete_grade_deadline` SET TAGS ('dbx_business_glossary_term' = 'Incomplete Grade Resolution Deadline');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `instruction_weeks` SET TAGS ('dbx_business_glossary_term' = 'Instructional Weeks');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `instructional_method` SET TAGS ('dbx_business_glossary_term' = 'Instructional Method');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `instructional_method` SET TAGS ('dbx_value_regex' = 'face-to-face|online|hybrid|hyflex');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `ipeds_term_type_code` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Term Type Code');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `ipeds_term_type_code` SET TAGS ('dbx_value_regex' = '1|2|3');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `is_degree_applicable` SET TAGS ('dbx_business_glossary_term' = 'Degree Applicable Term Indicator');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `is_financial_aid_eligible` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Eligible Term Indicator');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `is_open_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Term Indicator');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `is_standard_term` SET TAGS ('dbx_business_glossary_term' = 'Standard Term Indicator');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `last_day_of_attendance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Day of Attendance Date');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Tuition Payment Due Date');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `registration_close_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Close Date');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `registration_open_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Open Date');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `sap_evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Satisfactory Academic Progress (SAP) Evaluation Date');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Session Code');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Term Start Date');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Term Code');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `term_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `term_name` SET TAGS ('dbx_business_glossary_term' = 'Term Name');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `term_status` SET TAGS ('dbx_business_glossary_term' = 'Term Status');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `term_status` SET TAGS ('dbx_value_regex' = 'planning|open|active|closed|archived');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `term_type` SET TAGS ('dbx_business_glossary_term' = 'Term Type');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `term_type` SET TAGS ('dbx_value_regex' = 'fall|spring|summer|winter');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `tuition_billing_date` SET TAGS ('dbx_business_glossary_term' = 'Tuition Billing Date');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`term` ALTER COLUMN `withdrawal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Deadline Date');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` SET TAGS ('dbx_subdomain' = 'course_registration');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `enrollment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration ID');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `ada_accommodation_id` SET TAGS ('dbx_business_glossary_term' = 'Ada Accommodation Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section ID');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term ID');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `tuition_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Tuition Charge Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `add_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Course Add Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `banner_sfrstcr_key` SET TAGS ('dbx_business_glossary_term' = 'Banner SFRSTCR Record Key');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `billing_hours` SET TAGS ('dbx_business_glossary_term' = 'Billing Hours');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `census_enrolled_flag` SET TAGS ('dbx_business_glossary_term' = 'Census Date Enrollment Flag');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `college_code` SET TAGS ('dbx_business_glossary_term' = 'College / School Code');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `course_number` SET TAGS ('dbx_business_glossary_term' = 'Course Number');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `course_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3,5}[A-Z]?$');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `course_subject` SET TAGS ('dbx_business_glossary_term' = 'Course Subject Code');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `course_subject` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `credit_hours_attempted` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR) Attempted');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `crn` SET TAGS ('dbx_business_glossary_term' = 'Course Reference Number (CRN)');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `crn` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,6}$');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `drop_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Course Drop Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|less_than_half_time|half_time');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `final_grade` SET TAGS ('dbx_business_glossary_term' = 'Final Grade');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `financial_aid_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Eligible Enrollment Flag');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `fte_contribution` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Contribution');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `grade_mode` SET TAGS ('dbx_business_glossary_term' = 'Grade Mode');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `grade_mode` SET TAGS ('dbx_value_regex' = 'standard|pass_fail|audit|satisfactory_unsatisfactory|no_grade');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `grade_points` SET TAGS ('dbx_business_glossary_term' = 'Grade Points');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `incomplete_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Incomplete Grade Expiry Date');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `instructional_method` SET TAGS ('dbx_business_glossary_term' = 'Instructional Method / Delivery Mode');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `instructional_method` SET TAGS ('dbx_value_regex' = 'in_person|online|hybrid|hyflex|correspondence');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Registration Status Change Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `lms_enrollment_code` SET TAGS ('dbx_business_glossary_term' = 'Learning Management System (LMS) Enrollment ID');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `midterm_grade` SET TAGS ('dbx_business_glossary_term' = 'Midterm Grade');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `override_authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Override Authorized By');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `override_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Override Type');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `override_type` SET TAGS ('dbx_value_regex' = 'capacity|prerequisite|time_conflict|major_restriction|level_restriction|none');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `pidm` SET TAGS ('dbx_business_glossary_term' = 'Banner Person Identifier Master (PIDM)');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `pidm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `pidm` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `registration_source` SET TAGS ('dbx_business_glossary_term' = 'Registration Source');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `registration_source` SET TAGS ('dbx_value_regex' = 'web_self_service|registrar_office|advisor_override|batch_load|api');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'registered|dropped|withdrawn|audit|waitlisted|pass_fail');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `registration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Registration Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `repeat_course_count` SET TAGS ('dbx_business_glossary_term' = 'Repeat Course Attempt Count');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `repeat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Repeat Course Indicator');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `sap_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Satisfactory Academic Progress (SAP) Applicable Flag');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `section_number` SET TAGS ('dbx_business_glossary_term' = 'Section Number');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `student_level` SET TAGS ('dbx_business_glossary_term' = 'Student Level');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `student_level` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|professional|doctoral|non_degree');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `waitlist_position` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Position');
ALTER TABLE `education_ecm`.`enrollment`.`enrollment_registration` ALTER COLUMN `withdraw_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Course Withdrawal Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` SET TAGS ('dbx_subdomain' = 'course_registration');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `waitlist_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry ID');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section ID');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `enrollment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term ID');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `academic_level` SET TAGS ('dbx_business_glossary_term' = 'Academic Level');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `academic_level` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|doctoral|professional|non_degree');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `added_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Added Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `auto_enroll_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Enroll Eligibility Flag');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `auto_enrolled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Enrolled Flag');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `auto_enrolled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Auto-Enrolled Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `banner_waitlist_ref` SET TAGS ('dbx_business_glossary_term' = 'Banner Waitlist Reference Number');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `college_code` SET TAGS ('dbx_business_glossary_term' = 'College Code');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `course_number` SET TAGS ('dbx_business_glossary_term' = 'Course Number');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `course_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Course Reference Number (CRN)');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR)');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|online|hybrid');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Status');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_value_regex' = 'active|offered|accepted|declined|expired|cancelled');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `ferpa_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Family Educational Rights and Privacy Act (FERPA) Disclosure Flag');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `financial_aid_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Impact Flag');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `grading_mode` SET TAGS ('dbx_business_glossary_term' = 'Grading Mode');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `grading_mode` SET TAGS ('dbx_value_regex' = 'standard|pass_fail|audit|credit_no_credit');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|portal|email_sms');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Seat Offer Notification Sent Flag');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Seat Offer Notification Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `offer_expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Seat Offer Expiration Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `offer_extended_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Seat Offer Extended Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `prerequisite_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Verified Flag');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `priority_reason` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Priority Reason');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `registration_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Hold Flag');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `removal_reason` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Removal Reason');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `removal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Removal Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `section_capacity` SET TAGS ('dbx_business_glossary_term' = 'Section Enrollment Capacity');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `section_number` SET TAGS ('dbx_business_glossary_term' = 'Section Number');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `student_response` SET TAGS ('dbx_business_glossary_term' = 'Student Seat Offer Response');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `student_response` SET TAGS ('dbx_value_regex' = 'accepted|declined|no_response');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `student_response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Student Response Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `subject_code` SET TAGS ('dbx_business_glossary_term' = 'Subject Code');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `subject_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,8}$');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `waitlist_capacity` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Capacity');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `waitlist_pool_size` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Pool Size');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `waitlist_position` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Position Number');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `waitlist_type` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Type');
ALTER TABLE `education_ecm`.`enrollment`.`waitlist_entry` ALTER COLUMN `waitlist_type` SET TAGS ('dbx_value_regex' = 'standard|priority|department_override');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` SET TAGS ('dbx_subdomain' = 'course_registration');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `add_drop_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Add/Drop Transaction ID');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `charge_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Adjustment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section ID');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating User ID');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `enrollment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `r2t4_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'R2T4 Calculation Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term ID');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `academic_period_week` SET TAGS ('dbx_business_glossary_term' = 'Academic Period Week Number');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `banner_sfrstcr_key` SET TAGS ('dbx_business_glossary_term' = 'Banner SFRSTCR Source Key');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `course_number` SET TAGS ('dbx_business_glossary_term' = 'Course Number');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `course_subject_code` SET TAGS ('dbx_business_glossary_term' = 'Course Subject Code');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `credit_hours_after` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours After Transaction');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `credit_hours_before` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours Before Transaction');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `crn` SET TAGS ('dbx_business_glossary_term' = 'Course Reference Number (CRN)');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `dfw_flag` SET TAGS ('dbx_business_glossary_term' = 'DFW Rate Flag');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `financial_aid_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Impact Flag');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `fte_after` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) After Transaction');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `fte_before` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Before Transaction');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `grade_mode_after` SET TAGS ('dbx_business_glossary_term' = 'Grade Mode After Transaction');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `grade_mode_after` SET TAGS ('dbx_value_regex' = 'GR|PF|AU|SA');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `grade_mode_before` SET TAGS ('dbx_business_glossary_term' = 'Grade Mode Before Transaction');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `grade_mode_before` SET TAGS ('dbx_value_regex' = 'GR|PF|AU|SA');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `initiator_role` SET TAGS ('dbx_business_glossary_term' = 'Transaction Initiator Role');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `initiator_role` SET TAGS ('dbx_value_regex' = 'student|advisor|registrar|system|faculty');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `ipeds_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'IPEDS Enrollment Status');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `ipeds_enrollment_status` SET TAGS ('dbx_value_regex' = 'full_time|part_time|not_enrolled');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `is_after_withdraw_deadline` SET TAGS ('dbx_business_glossary_term' = 'After Withdrawal Deadline Indicator');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `is_before_refund_deadline` SET TAGS ('dbx_business_glossary_term' = 'Before Refund Deadline Indicator');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `is_complete_withdrawal` SET TAGS ('dbx_business_glossary_term' = 'Complete Withdrawal Indicator');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `new_registration_status` SET TAGS ('dbx_business_glossary_term' = 'New Registration Status Code');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Override Flag');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `override_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Override Type');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `prior_registration_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Registration Status Code');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `processing_channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Processing Channel');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `processing_channel` SET TAGS ('dbx_value_regex' = 'web_self_service|registrar_office|advisor_portal|batch_process|api');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `r2t4_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Return to Title IV (R2T4) Required Flag');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reason Code');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reason Description');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `refund_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tuition Refund Percentage');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `sap_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Satisfactory Academic Progress (SAP) Impact Flag');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'completed|pending|reversed|failed|cancelled');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Transaction Type');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'add|drop|withdraw|grade_mode_change|credit_change|audit_change');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `tuition_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Tuition Adjustment Amount');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `tuition_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`add_drop_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`census` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`enrollment`.`census` SET TAGS ('dbx_subdomain' = 'course_registration');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `census_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Census ID');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `ipeds_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Submission ID');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'College ID');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Term ID');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `academic_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `accreditation_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Submission Flag');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `attendance_type` SET TAGS ('dbx_business_glossary_term' = 'Attendance Type');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `attendance_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|all');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `census_date` SET TAGS ('dbx_business_glossary_term' = 'Census Date');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `census_number` SET TAGS ('dbx_business_glossary_term' = 'Census Record Number');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `census_status` SET TAGS ('dbx_business_glossary_term' = 'Census Status');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `census_status` SET TAGS ('dbx_value_regex' = 'draft|finalized|submitted|locked|superseded');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `census_type` SET TAGS ('dbx_business_glossary_term' = 'Census Type');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `census_type` SET TAGS ('dbx_value_regex' = 'official|preliminary|revised|supplemental');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `continuing_headcount` SET TAGS ('dbx_business_glossary_term' = 'Continuing Student Headcount');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `credit_hours_total` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Hours (CR) Enrolled');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `finalized_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Census Finalized Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `first_generation_headcount` SET TAGS ('dbx_business_glossary_term' = 'First-Generation Student Headcount');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `fte_count` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Count');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `ftiac_headcount` SET TAGS ('dbx_business_glossary_term' = 'First-Time-In-Any-College (FTIAC) Headcount');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `full_time_headcount` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Headcount');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `graduate_fte` SET TAGS ('dbx_business_glossary_term' = 'Graduate Full-Time Equivalent (FTE)');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `headcount` SET TAGS ('dbx_business_glossary_term' = 'Headcount');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `headcount_variance` SET TAGS ('dbx_business_glossary_term' = 'Headcount Variance (Year-Over-Year)');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `hybrid_headcount` SET TAGS ('dbx_business_glossary_term' = 'Hybrid/Blended Enrollment Headcount');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `in_state_headcount` SET TAGS ('dbx_business_glossary_term' = 'In-State Headcount');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `institution_code` SET TAGS ('dbx_business_glossary_term' = 'Institution ID');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `instructional_method` SET TAGS ('dbx_business_glossary_term' = 'Instructional Method');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `instructional_method` SET TAGS ('dbx_value_regex' = 'in_person|online|hybrid|correspondence|all');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `international_headcount` SET TAGS ('dbx_business_glossary_term' = 'International Student Headcount');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `new_student_headcount` SET TAGS ('dbx_business_glossary_term' = 'New Student Headcount');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Census Notes');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `online_exclusive_headcount` SET TAGS ('dbx_business_glossary_term' = 'Exclusively Online Headcount');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `out_of_state_headcount` SET TAGS ('dbx_business_glossary_term' = 'Out-of-State Headcount');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `part_time_headcount` SET TAGS ('dbx_business_glossary_term' = 'Part-Time Headcount');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `pell_eligible_headcount` SET TAGS ('dbx_business_glossary_term' = 'Pell Grant Eligible Headcount');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `prior_term_headcount` SET TAGS ('dbx_business_glossary_term' = 'Prior Term Headcount');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `readmit_headcount` SET TAGS ('dbx_business_glossary_term' = 'Readmitted Student Headcount');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `reporting_level` SET TAGS ('dbx_business_glossary_term' = 'Reporting Level');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `reporting_level` SET TAGS ('dbx_value_regex' = 'institution|college|department|program');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `residency_status` SET TAGS ('dbx_business_glossary_term' = 'Residency Status');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `residency_status` SET TAGS ('dbx_value_regex' = 'in_state|out_of_state|international|all');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Banner|PeopleSoft|Manual|Other');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `stem_headcount` SET TAGS ('dbx_business_glossary_term' = 'STEM Headcount');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `student_level` SET TAGS ('dbx_business_glossary_term' = 'Student Level');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `student_level` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|professional|doctoral');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `transfer_headcount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Student Headcount');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `undergraduate_fte` SET TAGS ('dbx_business_glossary_term' = 'Undergraduate Full-Time Equivalent (FTE)');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`census` ALTER COLUMN `veteran_headcount` SET TAGS ('dbx_business_glossary_term' = 'Veteran Student Headcount');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` SET TAGS ('dbx_subdomain' = 'course_registration');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `student_term_record_id` SET TAGS ('dbx_business_glossary_term' = 'Student Term Record ID');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `accreditation_review_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Review Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `aid_sap_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Financialaid Sap Evaluation Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Advisor ID');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Term ID');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `academic_standing` SET TAGS ('dbx_business_glossary_term' = 'Academic Standing');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `academic_standing` SET TAGS ('dbx_value_regex' = 'good-standing|probation|suspension|dismissal|dean-list');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `academic_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `athlete_flag` SET TAGS ('dbx_business_glossary_term' = 'Student Athlete Flag');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `attendance_type` SET TAGS ('dbx_business_glossary_term' = 'Attendance Type');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `attendance_type` SET TAGS ('dbx_value_regex' = 'on-campus|online|hybrid|correspondence');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `banner_pidm` SET TAGS ('dbx_business_glossary_term' = 'Banner Person Identification Master (PIDM)');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `banner_pidm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `banner_pidm` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `class_level` SET TAGS ('dbx_business_glossary_term' = 'Class Level');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `cohort_code` SET TAGS ('dbx_business_glossary_term' = 'Cohort Code');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `college_code` SET TAGS ('dbx_business_glossary_term' = 'College Code');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `credit_hours_attempted` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours Attempted');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `credit_hours_earned` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours Earned');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `cumulative_credit_hours_attempted` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Credit Hours Attempted');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `cumulative_credit_hours_earned` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Credit Hours Earned');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `cumulative_gpa` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `cumulative_gpa` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `degree_type` SET TAGS ('dbx_business_glossary_term' = 'Degree Type');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `dfw_count` SET TAGS ('dbx_business_glossary_term' = 'D-grade, F-grade, Withdrawal (DFW) Count');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'full-time|half-time|less-than-half-time|not-enrolled|withdrawn');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `financial_aid_applicant_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Applicant Flag');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `first_generation_flag` SET TAGS ('dbx_business_glossary_term' = 'First-Generation Student Flag');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `fte_value` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Value');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `ftiac_flag` SET TAGS ('dbx_business_glossary_term' = 'First-Time-In-Any-College (FTIAC) Flag');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `international_flag` SET TAGS ('dbx_business_glossary_term' = 'International Student Flag');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `last_date_of_attendance` SET TAGS ('dbx_business_glossary_term' = 'Last Date of Attendance');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `quality_points_cumulative` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Quality Points');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `quality_points_term` SET TAGS ('dbx_business_glossary_term' = 'Term Quality Points');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `registration_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Hold Flag');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `residency_classification` SET TAGS ('dbx_business_glossary_term' = 'Residency Classification');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `residency_classification` SET TAGS ('dbx_value_regex' = 'in-state|out-of-state|international|military|district');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `sap_status` SET TAGS ('dbx_business_glossary_term' = 'Satisfactory Academic Progress (SAP) Status');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `sap_status` SET TAGS ('dbx_value_regex' = 'meeting|warning|probation|suspension|ineligible');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Banner|PeopleSoft|Workday|manual');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `student_level` SET TAGS ('dbx_business_glossary_term' = 'Student Level');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `student_level` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|professional|doctoral|non-degree');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `term_gpa` SET TAGS ('dbx_business_glossary_term' = 'Term Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `term_gpa` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `transfer_credit_hours_accepted` SET TAGS ('dbx_business_glossary_term' = 'Transfer Credit Hours Accepted');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `veteran_flag` SET TAGS ('dbx_business_glossary_term' = 'Veteran Student Flag');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `visa_type` SET TAGS ('dbx_business_glossary_term' = 'Visa Type');
ALTER TABLE `education_ecm`.`enrollment`.`student_term_record` ALTER COLUMN `withdrawal_count` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Count');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` SET TAGS ('dbx_subdomain' = 'course_registration');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `registration_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Hold ID');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `ada_accommodation_id` SET TAGS ('dbx_business_glossary_term' = 'Ada Accommodation Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `athletic_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Athletic Eligibility Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Released By User ID');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Term ID');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `academic_standing_trigger` SET TAGS ('dbx_business_glossary_term' = 'Academic Standing Trigger');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `academic_standing_trigger` SET TAGS ('dbx_value_regex' = 'probation|suspension|dismissal|warning|none');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `advising_requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Advising Requirement Code');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `appeal_flag` SET TAGS ('dbx_business_glossary_term' = 'Hold Appeal Flag');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Appeal Status');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|withdrawn');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `banner_pidm` SET TAGS ('dbx_business_glossary_term' = 'Banner Person Identification Master (PIDM)');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `banner_pidm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `banner_pidm` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `blocks_enrollment_verification` SET TAGS ('dbx_business_glossary_term' = 'Blocks Enrollment Verification Flag');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `blocks_financial_aid` SET TAGS ('dbx_business_glossary_term' = 'Blocks Financial Aid Flag');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `blocks_graduation` SET TAGS ('dbx_business_glossary_term' = 'Blocks Graduation Flag');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `blocks_registration` SET TAGS ('dbx_business_glossary_term' = 'Blocks Registration Flag');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `blocks_transcript` SET TAGS ('dbx_business_glossary_term' = 'Blocks Transcript Flag');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiration Date');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `hold_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Description');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `hold_notes` SET TAGS ('dbx_business_glossary_term' = 'Hold Notes');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_business_glossary_term' = 'Hold Number');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `hold_severity` SET TAGS ('dbx_business_glossary_term' = 'Hold Severity');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `hold_severity` SET TAGS ('dbx_value_regex' = 'hard|soft|informational');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|released|expired|pending|suspended');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `hold_type_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Type Code');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `hold_type_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Type Description');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `is_auto_release_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Auto-Release Eligible Flag');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated Hold Flag');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Notification Date');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `originating_office_code` SET TAGS ('dbx_business_glossary_term' = 'Originating Office Code');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `originating_office_name` SET TAGS ('dbx_business_glossary_term' = 'Originating Office Name');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `outstanding_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance Amount');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `outstanding_balance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `outstanding_balance_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `placed_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Placed Date');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Placed Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `release_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Reason Code');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `release_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Reason Description');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `released_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Released Date');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Released Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Banner|Manual|Batch|API');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `student_acknowledged_flag` SET TAGS ('dbx_business_glossary_term' = 'Student Acknowledged Flag');
ALTER TABLE `education_ecm`.`enrollment`.`registration_hold` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` SET TAGS ('dbx_subdomain' = 'course_registration');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `registration_override_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Override Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Granting User Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `enrollment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Override Approval Date');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Override Approval Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `capacity_override_count` SET TAGS ('dbx_business_glossary_term' = 'Capacity Override Count');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `condition_description` SET TAGS ('dbx_business_glossary_term' = 'Override Condition Description');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `corequisite_course_code` SET TAGS ('dbx_business_glossary_term' = 'Corequisite Course Code');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `course_number` SET TAGS ('dbx_business_glossary_term' = 'Course Number');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `course_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Course Reference Number (CRN)');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Denial Reason');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Override Expiration Date');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `granting_authority_type` SET TAGS ('dbx_business_glossary_term' = 'Granting Authority Type');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `granting_authority_type` SET TAGS ('dbx_value_regex' = 'advisor|department_chair|dean|registrar|instructor|system_admin');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `granting_department_code` SET TAGS ('dbx_business_glossary_term' = 'Granting Department Code');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `granting_user_name` SET TAGS ('dbx_business_glossary_term' = 'Granting User Name');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `granting_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `granting_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `is_conditional` SET TAGS ('dbx_business_glossary_term' = 'Conditional Override Flag');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `is_one_time_use` SET TAGS ('dbx_business_glossary_term' = 'One-Time Use Flag');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `justification_notes` SET TAGS ('dbx_business_glossary_term' = 'Override Justification Notes');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `level_restriction_code` SET TAGS ('dbx_business_glossary_term' = 'Level Restriction Code');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `major_restriction_code` SET TAGS ('dbx_business_glossary_term' = 'Major Restriction Code');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `override_number` SET TAGS ('dbx_business_glossary_term' = 'Override Reference Number');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `override_status` SET TAGS ('dbx_business_glossary_term' = 'Override Status');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `override_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|expired|revoked|used');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `override_type` SET TAGS ('dbx_business_glossary_term' = 'Override Type');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `prerequisite_course_code` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Course Code');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Override Request Date');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `restriction_code` SET TAGS ('dbx_business_glossary_term' = 'Restriction Code');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `restriction_description` SET TAGS ('dbx_business_glossary_term' = 'Restriction Description');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Revocation Reason');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `revoked_date` SET TAGS ('dbx_business_glossary_term' = 'Override Revoked Date');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `section_number` SET TAGS ('dbx_business_glossary_term' = 'Section Number');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `student_banner_code` SET TAGS ('dbx_business_glossary_term' = 'Student Banner Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `student_banner_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `student_banner_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `subject_code` SET TAGS ('dbx_business_glossary_term' = 'Subject Code');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `time_conflict_course_code` SET TAGS ('dbx_business_glossary_term' = 'Time Conflict Course Code');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`registration_override` ALTER COLUMN `used_date` SET TAGS ('dbx_business_glossary_term' = 'Override Used Date');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` SET TAGS ('dbx_subdomain' = 'course_registration');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `restriction_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Restriction Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9_]{3,30}$');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Corequisite Course Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `restriction_prerequisite_course_id` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Course Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `updated_by_user_identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `updated_by_user_identity_account_id` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9_]{3,30}$');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `updated_by_user_identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `updated_by_user_identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `applies_to_waitlist` SET TAGS ('dbx_business_glossary_term' = 'Applies to Waitlist Flag');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `attribute_code` SET TAGS ('dbx_business_glossary_term' = 'Student Attribute Code');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `attribute_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `class_level_minimum` SET TAGS ('dbx_business_glossary_term' = 'Class Level Minimum');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `class_level_minimum` SET TAGS ('dbx_value_regex' = 'FR|SO|JR|SR|GR');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `cohort_code` SET TAGS ('dbx_business_glossary_term' = 'Cohort Code');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `cohort_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,15}$');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `college_code` SET TAGS ('dbx_business_glossary_term' = 'College Code');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `college_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `credit_hours_minimum` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR) Minimum');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `degree_code` SET TAGS ('dbx_business_glossary_term' = 'Degree Code');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `degree_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,6}$');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `gpa_minimum` SET TAGS ('dbx_business_glossary_term' = 'Grade Point Average (GPA) Minimum');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `major_code` SET TAGS ('dbx_business_glossary_term' = 'Major Code');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `major_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `message` SET TAGS ('dbx_business_glossary_term' = 'Restriction Message');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `override_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Override Authority Level');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `override_authority_level` SET TAGS ('dbx_value_regex' = 'registrar|advisor|department_chair|dean|none');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `override_eligible` SET TAGS ('dbx_business_glossary_term' = 'Override Eligible Flag');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `permission_required` SET TAGS ('dbx_business_glossary_term' = 'Permission Required Flag');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `population_code` SET TAGS ('dbx_business_glossary_term' = 'Population Code');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `population_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Restriction Release Date');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `reserved_seat_count` SET TAGS ('dbx_business_glossary_term' = 'Reserved Seat Count');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `reserved_seat_used_count` SET TAGS ('dbx_business_glossary_term' = 'Reserved Seat Used Count');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `restriction_code` SET TAGS ('dbx_business_glossary_term' = 'Restriction Code');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `restriction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `restriction_description` SET TAGS ('dbx_business_glossary_term' = 'Restriction Description');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `restriction_scope` SET TAGS ('dbx_business_glossary_term' = 'Restriction Scope');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `restriction_scope` SET TAGS ('dbx_value_regex' = 'include|exclude|reserved');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `restriction_status` SET TAGS ('dbx_business_glossary_term' = 'Restriction Status');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `restriction_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `restriction_value` SET TAGS ('dbx_business_glossary_term' = 'Restriction Value');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'BANNER|SLATE|MANUAL|API');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `source_system_key` SET TAGS ('dbx_business_glossary_term' = 'Source System Key');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Code');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `term_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`enrollment`.`restriction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` SET TAGS ('dbx_subdomain' = 'course_registration');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `registration_period_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Period Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `academic_level` SET TAGS ('dbx_business_glossary_term' = 'Academic Level');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `academic_level` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|doctoral|professional|non_degree');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `add_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Add Deadline Date');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `allows_waitlist` SET TAGS ('dbx_business_glossary_term' = 'Allows Waitlist Flag');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `allows_web_registration` SET TAGS ('dbx_business_glossary_term' = 'Allows Web Registration Flag');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `banner_period_ref` SET TAGS ('dbx_business_glossary_term' = 'Banner Period Reference');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `campus_code` SET TAGS ('dbx_business_glossary_term' = 'Campus Code');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `campus_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `college_code` SET TAGS ('dbx_business_glossary_term' = 'College Code');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `college_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `drop_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Drop Deadline Date');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `enrollment_status_restriction` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status Restriction');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `enrollment_status_restriction` SET TAGS ('dbx_value_regex' = 'none|full_time|part_time|half_time');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `gpa_minimum` SET TAGS ('dbx_business_glossary_term' = 'Minimum Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `max_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Maximum Credit Hours (CR)');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `min_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Credit Hours (CR)');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Registration Period Notes');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|portal|sms|mail|none');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `overload_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Overload Threshold Credit Hours (CR)');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `period_code` SET TAGS ('dbx_business_glossary_term' = 'Registration Period Code');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `period_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Registration Period Name');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `period_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Period Status');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `period_status` SET TAGS ('dbx_value_regex' = 'scheduled|active|closed|cancelled');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Period Type');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'early|priority|general|late|add_drop|open');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `priority_group_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Group Code');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `priority_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,15}$');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `priority_group_name` SET TAGS ('dbx_business_glossary_term' = 'Priority Group Name');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Code');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,15}$');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `registration_close_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Registration Close Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `registration_open_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Registration Open Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `requires_advisor_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Advisor Approval Flag');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `requires_hold_clearance` SET TAGS ('dbx_business_glossary_term' = 'Requires Hold Clearance Flag');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `residency_restriction` SET TAGS ('dbx_business_glossary_term' = 'Residency Restriction');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `residency_restriction` SET TAGS ('dbx_value_regex' = 'none|resident|non_resident|international');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `sap_requirement` SET TAGS ('dbx_business_glossary_term' = 'Satisfactory Academic Progress (SAP) Requirement Flag');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `student_classification` SET TAGS ('dbx_business_glossary_term' = 'Student Classification');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `student_classification` SET TAGS ('dbx_value_regex' = 'freshman|sophomore|junior|senior|graduate|doctoral');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `time_ticket_required` SET TAGS ('dbx_business_glossary_term' = 'Time Ticket Required Flag');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`registration_period` ALTER COLUMN `withdrawal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Deadline Date');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` SET TAGS ('dbx_subdomain' = 'course_registration');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `cross_list_group_id` SET TAGS ('dbx_business_glossary_term' = 'Cross-List Group Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Instructor of Record Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Course Section Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `updated_by_user_identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `updated_by_user_identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `updated_by_user_identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `available_seats` SET TAGS ('dbx_business_glossary_term' = 'Available Seats');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR)');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `cross_list_type` SET TAGS ('dbx_business_glossary_term' = 'Cross-List Type');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `cross_list_type` SET TAGS ('dbx_value_regex' = 'departmental|interdisciplinary|level|honors|special_topics|dual_listed');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `current_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Current Combined Enrollment Count');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `current_waitlist_count` SET TAGS ('dbx_business_glossary_term' = 'Current Waitlist Count');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `fte_divisor` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Divisor');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `grading_mode` SET TAGS ('dbx_business_glossary_term' = 'Grading Mode');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `grading_mode` SET TAGS ('dbx_value_regex' = 'standard|pass_fail|audit|honors|satisfactory_unsatisfactory');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `group_code` SET TAGS ('dbx_business_glossary_term' = 'Cross-List Group Code');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `group_name` SET TAGS ('dbx_business_glossary_term' = 'Cross-List Group Name');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `group_status` SET TAGS ('dbx_business_glossary_term' = 'Cross-List Group Status');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `group_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|cancelled|closed');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `max_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Maximum Combined Enrollment Capacity');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `meeting_pattern_shared` SET TAGS ('dbx_business_glossary_term' = 'Meeting Pattern Shared Flag');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Administrative Notes');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `prevent_duplicate_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Prevent Duplicate Enrollment Flag');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `registration_close_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Close Date');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `registration_open_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Open Date');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `section_count` SET TAGS ('dbx_business_glossary_term' = 'Participating Section Count');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`cross_list_group` ALTER COLUMN `waitlist_capacity` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Capacity');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` SET TAGS ('dbx_subdomain' = 'course_registration');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `concurrent_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Enrollment Identifier');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `aid_application_id` SET TAGS ('dbx_business_glossary_term' = 'Aid Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `institution_id` SET TAGS ('dbx_business_glossary_term' = 'Home Institution Identifier');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Advisor Identifier');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Identifier');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `academic_standing` SET TAGS ('dbx_business_glossary_term' = 'Academic Standing');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `academic_standing` SET TAGS ('dbx_value_regex' = 'good_standing|probation|suspension|dismissal|warning');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Consortium Agreement Number');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'consortium|articulation|dual_credit|exchange|reciprocal|visiting');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Enrollment Approval Date');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `approved_by_home` SET TAGS ('dbx_business_glossary_term' = 'Approved By Home Institution');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `approved_by_host` SET TAGS ('dbx_business_glossary_term' = 'Approved By Host Institution');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `combined_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Combined Credit Hours');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `combined_fte` SET TAGS ('dbx_business_glossary_term' = 'Combined Full-Time Equivalent (FTE)');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `credit_transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Transfer Status');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `credit_transfer_status` SET TAGS ('dbx_value_regex' = 'automatic|evaluation_required|pre_approved|pending|denied|completed');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `degree_applicability` SET TAGS ('dbx_business_glossary_term' = 'Degree Applicability Classification');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `degree_applicability` SET TAGS ('dbx_value_regex' = 'degree_requirement|elective|non_degree|enrichment|remedial|prerequisite');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Enrollment Effective End Date');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Enrollment Effective Start Date');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Enrollment Status');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Enrollment Type');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'dual_enrollment|consortium|visiting_student|cross_registration|transient_student|exchange');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `ferpa_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Family Educational Rights and Privacy Act (FERPA) Consent Date');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `ferpa_consent_on_file` SET TAGS ('dbx_business_glossary_term' = 'Family Educational Rights and Privacy Act (FERPA) Consent On File');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `financial_aid_home_institution` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Home Institution Flag');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `high_school_ceeb_code` SET TAGS ('dbx_business_glossary_term' = 'High School College Entrance Examination Board (CEEB) Code');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `high_school_partnership_flag` SET TAGS ('dbx_business_glossary_term' = 'High School Partnership Flag');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `home_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Home Institution Credit Hours');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `host_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Host Institution Credit Hours');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `host_institution_code` SET TAGS ('dbx_business_glossary_term' = 'Host Institution Identifier');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `ipeds_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Reporting Flag');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Enrollment Notes');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `nsc_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'National Student Clearinghouse (NSC) Reporting Flag');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `residency_classification` SET TAGS ('dbx_business_glossary_term' = 'Residency Classification');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `residency_classification` SET TAGS ('dbx_value_regex' = 'in_state|out_of_state|international|reciprocity');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `title_iv_eligible` SET TAGS ('dbx_business_glossary_term' = 'Title IV Eligible Flag');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `tuition_payment_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Tuition Payment Responsibility');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `tuition_payment_responsibility` SET TAGS ('dbx_value_regex' = 'home_institution|host_institution|student_direct|shared|third_party');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `visa_type` SET TAGS ('dbx_business_glossary_term' = 'Visa Type');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Enrollment Withdrawal Date');
ALTER TABLE `education_ecm`.`enrollment`.`concurrent_enrollment` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` SET TAGS ('dbx_subdomain' = 'course_registration');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `repeat_course_record_id` SET TAGS ('dbx_business_glossary_term' = 'Repeat Course Record Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `enrollment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Repeat Enrollment Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `repeat_enrollment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Original Enrollment Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `academic_standing_impact` SET TAGS ('dbx_business_glossary_term' = 'Academic Standing Impact');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `academic_standing_impact` SET TAGS ('dbx_value_regex' = 'improved|no_change|declined');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `course_title` SET TAGS ('dbx_business_glossary_term' = 'Course Title');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR)');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `degree_applicable` SET TAGS ('dbx_business_glossary_term' = 'Degree Applicable Flag');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `financial_aid_countable` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Countable Flag');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `gpa_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'GPA (Grade Point Average) Calculation Method');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `gpa_calculation_method` SET TAGS ('dbx_value_regex' = 'use_repeat_only|use_both|use_highest|use_average');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `grade_replacement_applied` SET TAGS ('dbx_business_glossary_term' = 'Grade Replacement Applied Flag');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `grade_replacement_eligible` SET TAGS ('dbx_business_glossary_term' = 'Grade Replacement Eligible Flag');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `institutional_repeat_limit` SET TAGS ('dbx_business_glossary_term' = 'Institutional Repeat Limit');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `ipeds_reportable` SET TAGS ('dbx_business_glossary_term' = 'IPEDS (Integrated Postsecondary Education Data System) Reportable Flag');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `original_gpa_impact` SET TAGS ('dbx_business_glossary_term' = 'Original GPA (Grade Point Average) Impact');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `original_grade` SET TAGS ('dbx_business_glossary_term' = 'Original Grade');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `original_grade_points` SET TAGS ('dbx_business_glossary_term' = 'Original Grade Points');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `original_quality_points` SET TAGS ('dbx_business_glossary_term' = 'Original Quality Points');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `original_term_code` SET TAGS ('dbx_business_glossary_term' = 'Original Term Code');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `repeat_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Repeat Approval Date');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `repeat_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Repeat Approval Required Flag');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `repeat_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Repeat Approval Status');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `repeat_approval_status` SET TAGS ('dbx_value_regex' = 'approved|denied|pending|not_required');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `repeat_count` SET TAGS ('dbx_business_glossary_term' = 'Repeat Count');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `repeat_gpa_impact` SET TAGS ('dbx_business_glossary_term' = 'Repeat GPA (Grade Point Average) Impact');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `repeat_grade` SET TAGS ('dbx_business_glossary_term' = 'Repeat Grade');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `repeat_grade_points` SET TAGS ('dbx_business_glossary_term' = 'Repeat Grade Points');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `repeat_limit_exceeded` SET TAGS ('dbx_business_glossary_term' = 'Repeat Limit Exceeded Flag');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `repeat_quality_points` SET TAGS ('dbx_business_glossary_term' = 'Repeat Quality Points');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `repeat_reason` SET TAGS ('dbx_business_glossary_term' = 'Repeat Reason');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `repeat_reason` SET TAGS ('dbx_value_regex' = 'grade_improvement|failed_course|withdrawn_course|degree_requirement|gpa_improvement|other');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `repeat_term_code` SET TAGS ('dbx_business_glossary_term' = 'Repeat Term Code');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `repeat_type` SET TAGS ('dbx_business_glossary_term' = 'Repeat Type');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `repeat_type` SET TAGS ('dbx_value_regex' = 'grade_replacement|grade_averaging|grade_forgiveness|no_replacement');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `sap_repeat_limit_exceeded` SET TAGS ('dbx_business_glossary_term' = 'SAP (Satisfactory Academic Progress) Repeat Limit Exceeded Flag');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier (ID)');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `subject_code` SET TAGS ('dbx_business_glossary_term' = 'Subject Code');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `transcript_notation` SET TAGS ('dbx_business_glossary_term' = 'Transcript Notation');
ALTER TABLE `education_ecm`.`enrollment`.`repeat_course_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` SET TAGS ('dbx_association_edges' = 'enrollment.prospect,athletics.sport');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ALTER COLUMN `athletic_recruitment_id` SET TAGS ('dbx_business_glossary_term' = 'Athletic Recruitment ID');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Athletic Recruitment - Prospect Id');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiting Coach Employee ID');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ALTER COLUMN `sport_id` SET TAGS ('dbx_business_glossary_term' = 'Athletic Recruitment - Sport Id');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ALTER COLUMN `commitment_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Date');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Commitment Status');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ALTER COLUMN `evaluation_rating` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Rating');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ALTER COLUMN `first_contact_date` SET TAGS ('dbx_business_glossary_term' = 'First Contact Date');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ALTER COLUMN `interest_level` SET TAGS ('dbx_business_glossary_term' = 'Interest Level');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ALTER COLUMN `official_visit_date` SET TAGS ('dbx_business_glossary_term' = 'Official Visit Date');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ALTER COLUMN `primary_position` SET TAGS ('dbx_business_glossary_term' = 'Primary Position');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ALTER COLUMN `recruitment_notes` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Notes');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ALTER COLUMN `recruitment_stage` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Stage');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ALTER COLUMN `scholarship_offer_amount` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Offer Amount');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ALTER COLUMN `scholarship_offer_date` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Offer Date');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ALTER COLUMN `scholarship_offer_extended` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Offer Extended');
ALTER TABLE `education_ecm`.`enrollment`.`athletic_recruitment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `education_ecm`.`enrollment`.`review_committee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`enrollment`.`review_committee` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`review_committee` ALTER COLUMN `review_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Review Committee Identifier');
ALTER TABLE `education_ecm`.`enrollment`.`review_committee` ALTER COLUMN `parent_review_committee_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`review_committee` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`review_committee` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`institution` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`enrollment`.`institution` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`institution` ALTER COLUMN `institution_id` SET TAGS ('dbx_business_glossary_term' = 'Institution Identifier');
ALTER TABLE `education_ecm`.`enrollment`.`institution` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`institution` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`institution` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`institution` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`institution` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`institution` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`institution` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`institution` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`institution` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`institution` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`institution` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`institution` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`institution` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`institution` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event_session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event_session` SET TAGS ('dbx_subdomain' = 'admissions_pipeline');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event_session` ALTER COLUMN `recruitment_event_session_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Event Session Identifier');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event_session` ALTER COLUMN `parent_recruitment_event_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event_session` ALTER COLUMN `meeting_access_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`enrollment`.`recruitment_event_session` ALTER COLUMN `virtual_meeting_url` SET TAGS ('dbx_confidential' = 'true');
