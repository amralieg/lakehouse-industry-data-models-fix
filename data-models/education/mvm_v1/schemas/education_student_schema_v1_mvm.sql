-- Schema for Domain: student | Business: Education | Version: v1_mvm
-- Generated on: 2026-05-06 15:14:03

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `education_ecm`.`student` COMMENT 'Single source of truth for all student identity, demographics, academic standing, enrollment status, degree progress, academic history, and FERPA-protected records. Manages the student lifecycle from prospect through alumnus, supporting GPA calculations, SAP status, IPEDS reporting, Title IV compliance, and SIS integration with Ellucian Banner.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `education_ecm`.`student`.`profile` (
    `profile_id` BIGINT COMMENT 'Unique identifier for the student profile record. Primary key for the student profile entity.',
    `enrollment_applicant_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_applicant. Business justification: Admissions audit, re-admission processing, and IPEDS person-level reporting require tracing an enrolled students profile back to their original applicant record. Registrars and IR offices perform thi',
    `academic_standing` STRING COMMENT 'Current academic standing status of the student based on GPA and SAP (Satisfactory Academic Progress) evaluation. Determines eligibility for continued enrollment, financial aid, and academic support interventions.. Valid values are `good_standing|academic_warning|academic_probation|academic_suspension|academic_dismissal`',
    `citizenship_status` STRING COMMENT 'Students citizenship or immigration status. Critical for Title IV financial aid eligibility, visa compliance (SEVIS reporting), and state residency determination. [ENUM-REF-CANDIDATE: us_citizen|permanent_resident|refugee|asylee|temporary_visa|undocumented|other — 7 candidates stripped; promote to reference product]',
    `country_of_citizenship` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the students country of citizenship. Used for international student tracking, SEVIS reporting, and IPEDS reporting.',
    `date_of_birth` DATE COMMENT 'Students date of birth. Used for age verification, eligibility determination, IPEDS reporting, and identity verification. Protected under FERPA.',
    `disability_status` STRING COMMENT 'Indicates whether the student has disclosed a disability and is registered with disability services for ADA accommodations. Used for accessibility planning and compliance reporting.. Valid values are `none|documented|self_reported|prefer_not_to_disclose`',
    `email_address` STRING COMMENT 'Students primary institutional or personal email address for official communications, course notifications, and account recovery. Protected under FERPA as directory information unless opt-out is elected.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Full name of the students primary emergency contact person. Used for critical notifications in case of medical emergency, safety incident, or urgent situation.',
    `emergency_contact_phone` STRING COMMENT 'Primary phone number for the students emergency contact. Used for urgent notifications.',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact to the student (e.g., parent, spouse, sibling, guardian, friend).',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the students relationship with the institution. Determines access to systems, services, and reporting inclusion. [ENUM-REF-CANDIDATE: active|inactive|withdrawn|graduated|dismissed|leave_of_absence|deceased — 7 candidates stripped; promote to reference product]',
    `ethnicity_hispanic_latino` BOOLEAN COMMENT 'Indicates whether the student identifies as Hispanic or Latino ethnicity per IPEDS two-part race/ethnicity reporting standard. Used for federal reporting, diversity analytics, and compliance.',
    `ferpa_consent_third_party` BOOLEAN COMMENT 'Indicates whether the student has provided written consent for the institution to share education records with specified third parties (e.g., parents, sponsors, employers). Consent must be documented separately.',
    `ferpa_directory_opt_out` BOOLEAN COMMENT 'Indicates whether the student has elected to opt out of directory information disclosure under FERPA. When true, the institution may not release directory information (name, email, phone, enrollment status, degrees, honors) without explicit consent.',
    `first_time_in_any_college` BOOLEAN COMMENT 'Indicates whether the student is a first-time-in-any-college student (FTIAC) with no prior postsecondary enrollment. Critical for IPEDS cohort tracking, retention reporting, and graduation rate calculations.',
    `gender_identity` STRING COMMENT 'Students self-identified gender identity. Used for inclusive campus services, housing assignments, and optional demographic reporting. Distinct from legal sex assigned at birth.. Valid values are `male|female|non_binary|transgender|prefer_not_to_disclose|other`',
    `institutional_number` STRING COMMENT 'Institution-assigned unique identifier for the student, typically the Banner PIDM (Person Identification Master) or equivalent SIS identifier. This is the operational student ID used across all campus systems.',
    `legal_first_name` STRING COMMENT 'Students legal first name as it appears on official government-issued identification documents. Used for official transcripts, diplomas, and Title IV reporting.',
    `legal_last_name` STRING COMMENT 'Students legal last name (surname/family name) as it appears on official government-issued identification documents. Used for official transcripts, diplomas, and Title IV reporting.',
    `legal_middle_name` STRING COMMENT 'Students legal middle name or initial as it appears on official government-issued identification documents. Nullable if no middle name exists.',
    `mailing_address_line1` STRING COMMENT 'First line of the students current mailing address (street number and name, apartment/unit number). Used for official correspondence, billing statements, and emergency contact.',
    `mailing_address_line2` STRING COMMENT 'Second line of the students current mailing address (additional address details, building name, etc.). Nullable if not needed.',
    `mailing_city` STRING COMMENT 'City of the students current mailing address.',
    `mailing_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the students current mailing address.',
    `mailing_postal_code` STRING COMMENT 'Postal code or ZIP code of the students current mailing address.',
    `mailing_state_province` STRING COMMENT 'State, province, or region of the students current mailing address. Use standard postal abbreviations (e.g., CA, NY, ON).',
    `phone_number` STRING COMMENT 'Students primary contact phone number (mobile or landline). Used for emergency notifications, enrollment communications, and administrative contact. Protected under FERPA as directory information unless opt-out is elected.',
    `preferred_first_name` STRING COMMENT 'Students preferred first name for daily use in classroom rosters, email communications, and non-official documents. May differ from legal name to respect gender identity or cultural preferences.',
    `preferred_last_name` STRING COMMENT 'Students preferred last name for daily use in classroom rosters, email communications, and non-official documents. May differ from legal name.',
    `primary_language` STRING COMMENT 'ISO 639-2 three-letter language code representing the students primary or native language. Used for ESL program placement, accessibility services, and communication preferences.',
    `pronouns` STRING COMMENT 'Students preferred pronouns for use in communications and classroom settings (e.g., she/her, he/him, they/them, ze/zir). Supports inclusive campus environment.',
    `race_american_indian_alaska_native` BOOLEAN COMMENT 'Indicates whether the student identifies as American Indian or Alaska Native per IPEDS race categories. Students may select multiple race categories.',
    `race_asian` BOOLEAN COMMENT 'Indicates whether the student identifies as Asian per IPEDS race categories. Students may select multiple race categories.',
    `race_black_african_american` BOOLEAN COMMENT 'Indicates whether the student identifies as Black or African American per IPEDS race categories. Students may select multiple race categories.',
    `race_native_hawaiian_pacific_islander` BOOLEAN COMMENT 'Indicates whether the student identifies as Native Hawaiian or Other Pacific Islander per IPEDS race categories. Students may select multiple race categories.',
    `race_white` BOOLEAN COMMENT 'Indicates whether the student identifies as White per IPEDS race categories. Students may select multiple race categories.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this profile record was first created in the data warehouse. Used for audit trail and data lineage.',
    `record_source_system` STRING COMMENT 'Name of the source system from which this profile record originated (e.g., Ellucian Banner, Slate CRM, manual entry). Used for data lineage and reconciliation.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this profile record was last updated in the data warehouse. Used for audit trail and change tracking.',
    `ssn` STRING COMMENT 'U.S. Social Security Number for the student. Must be encrypted at rest. Required for Title IV financial aid processing and IPEDS reporting. Nullable for international students.',
    `veteran_status` BOOLEAN COMMENT 'Indicates whether the student is a U.S. military veteran. Used for veteran services, GI Bill benefits administration, and federal reporting.',
    `visa_type` STRING COMMENT 'Type of visa held by international students (e.g., F-1, J-1, M-1). Required for SEVIS compliance and international student services. Nullable for domestic students.',
    CONSTRAINT pk_profile PRIMARY KEY(`profile_id`)
) COMMENT 'Authoritative master record for every individual who has ever interacted with the institution as a student — from prospect through alumnus. Stores legal name, preferred name, date of birth, gender identity, pronouns, citizenship, national origin, race/ethnicity (IPEDS categories), primary language, disability status (ADA), veteran status, Social Security Number (encrypted), institutional ID (Banner PIDM), contact information, emergency contacts, FERPA consent flags, directory information opt-out, and record-source system. This is the single source of truth (SSOT) for student identity across all downstream domains.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`academic_standing` (
    `academic_standing_id` BIGINT COMMENT 'Unique identifier for the academic standing evaluation record. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member, office, or automated system that performed or certified the academic standing evaluation. Used for audit trail and accountability.',
    `term_id` BIGINT COMMENT 'Identifier of the academic term for which this standing evaluation was performed. Links to the term reference table.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student being evaluated for academic standing. Links to the student master record in the Student Information System (SIS).',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: SAP evaluation is directly mandated by 34 CFR 668.34 (Title IV regulatory requirement). academic_standing has policy_id but no FK to the specific regulatory_requirement. A financial aid compliance off',
    `student_term_record_id` BIGINT COMMENT 'Foreign key linking to enrollment.student_term_record. Business justification: Academic standing evaluation is driven by the term-level GPA and credit hours in student_term_record. Reconciliation reports and SAP audits require joining the authoritative standing determination (st',
    `academic_plan_required` BOOLEAN COMMENT 'Indicates whether the student is required to follow an academic plan as a condition of continued enrollment or financial aid eligibility. Typically required for students on probation or whose appeal was conditionally approved.',
    `appeal_decision` STRING COMMENT 'The outcome of the students SAP appeal. Approved appeals may reinstate Title IV eligibility with or without an academic plan. Denied appeals result in loss of federal financial aid eligibility.. Valid values are `approved|denied|pending|not_applicable`',
    `appeal_decision_date` DATE COMMENT 'The date on which the SAP appeal committee rendered a decision on the students appeal.',
    `appeal_submitted` BOOLEAN COMMENT 'Indicates whether the student submitted a formal appeal for SAP suspension or probation status. Appeals typically cite extenuating circumstances such as medical issues, family emergencies, or other documented hardships.',
    `completion_rate` DECIMAL(18,2) COMMENT 'The percentage of attempted credit hours that the student has successfully completed (earned credits / attempted credits * 100). Federal SAP requires a minimum 67% completion rate (pace) for Title IV eligibility.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this academic standing evaluation record was first created in the system. Used for audit trail and data lineage.',
    `credits_in_progress` DECIMAL(18,2) COMMENT 'Number of credit hours the student is currently enrolled in for the upcoming or current term. Used for enrollment status verification.',
    `cumulative_credits_attempted` DECIMAL(18,2) COMMENT 'Total number of credit hours the student has attempted across all terms at the institution, including courses in progress, completed, withdrawn, and failed. Used in SAP pace calculation.',
    `cumulative_credits_earned` DECIMAL(18,2) COMMENT 'Total number of credit hours the student has successfully completed with a passing grade across all terms at the institution. Used in SAP pace calculation and degree progress tracking.',
    `cumulative_gpa` DECIMAL(18,2) COMMENT 'The students cumulative grade point average across all terms at the institution, calculated on a 4.0 scale. Includes all graded coursework attempted at the institution, excluding transfer credits.',
    `evaluation_date` DATE COMMENT 'The date on which the academic standing evaluation was performed. Typically occurs at the end of each term after final grades are posted.',
    `evaluation_notes` STRING COMMENT 'Free-text notes or comments recorded by the evaluator regarding special circumstances, policy exceptions, or additional context for the standing determination. Confidential institutional record.',
    `gpa_threshold_met` BOOLEAN COMMENT 'Indicates whether the student met the minimum cumulative GPA threshold required for satisfactory academic progress. Threshold varies by academic level and institutional policy.',
    `institutional_standing` STRING COMMENT 'The official academic standing status assigned by the institution based on cumulative and term GPA performance. Determines eligibility for continued enrollment, honors recognition, and academic intervention programs.. Valid values are `good_standing|academic_probation|academic_suspension|academic_dismissal|deans_list|honors`',
    `ipeds_reportable` BOOLEAN COMMENT 'Indicates whether this academic standing record should be included in IPEDS reporting cohorts for retention, graduation rate, and academic progress metrics.',
    `maximum_timeframe_exceeded` BOOLEAN COMMENT 'Indicates whether the student has exceeded the maximum timeframe allowed to complete their degree program. Federal SAP requires completion within 150% of the published program length.',
    `notification_date` DATE COMMENT 'The date on which the student was notified of their academic standing evaluation results. Important for compliance with institutional notification requirements and appeal deadlines.',
    `notification_sent` BOOLEAN COMMENT 'Indicates whether the student was officially notified of their academic standing status and any associated actions required (probation, suspension, appeal rights, etc.).',
    `pace_threshold_met` BOOLEAN COMMENT 'Indicates whether the student met the minimum completion rate (pace) threshold required for satisfactory academic progress. Federal requirement is 67% for Title IV eligibility.',
    `policy_version` STRING COMMENT 'The version identifier of the academic standing and SAP policy that was applied during this evaluation. Ensures historical evaluations can be audited against the policy in effect at the time.',
    `sap_status` STRING COMMENT 'Federal Title IV financial aid eligibility status based on Satisfactory Academic Progress evaluation. Determines whether the student meets federal requirements for GPA, pace of completion, and maximum timeframe to continue receiving federal financial aid.. Valid values are `satisfactory|warning|probation|suspension|reinstated`',
    `term_credits_attempted` DECIMAL(18,2) COMMENT 'Number of credit hours the student attempted during the evaluation term, including completed, withdrawn, and failed courses.',
    `term_credits_earned` DECIMAL(18,2) COMMENT 'Number of credit hours the student successfully completed with a passing grade during the evaluation term.',
    `term_gpa` DECIMAL(18,2) COMMENT 'The students grade point average for the specific evaluation term, calculated on a 4.0 scale. Used to assess term-level academic performance.',
    `title_iv_eligible` BOOLEAN COMMENT 'Indicates whether the student is eligible to receive federal Title IV financial aid based on the SAP evaluation results. False if SAP status is suspension or if appeal was denied.',
    `transfer_gpa` DECIMAL(18,2) COMMENT 'The grade point average from transfer coursework accepted by the institution, if applicable. May be used in combined GPA calculations depending on institutional policy.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this academic standing evaluation record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_academic_standing PRIMARY KEY(`academic_standing_id`)
) COMMENT 'Tracks a students current and historical academic standing and Satisfactory Academic Progress (SAP) evaluation per term. Captures institutional standing (good standing, probation, suspension, dismissal, deans list, honor roll), GPA components (cumulative, term, transfer), credit hours (attempted, earned, in progress), SAP evaluation results (GPA threshold, pace/completion rate, maximum timeframe), overall SAP status (satisfactory, warning, probation, suspension), Title IV financial aid impact, SAP appeal status and decision, academic plan attachment, policy version applied, and evaluating authority. One record per student per term evaluation cycle. Supports both institutional academic standing decisions and federal Title IV SAP compliance.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`degree_progress` (
    `degree_progress_id` BIGINT COMMENT 'Unique identifier for the degree progress record. Primary key. Inferred role: MASTER_AGREEMENT (degree progress represents a students binding relationship with a declared academic program at a point in time).',
    `academic_program_id` BIGINT COMMENT 'Unique identifier for the declared academic program (degree, major, concentration). Links to the curriculum domain for degree requirements.',
    `concentration_id` BIGINT COMMENT 'Foreign key linking to curriculum.concentration. Business justification: Degree audit and graduation clearance require linking a students declared concentration to the official curriculum.concentration record. Advisors and registrars use this to verify concentration requi',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Degree audit and progress tracking are governed by institutional degree requirements policy (catalog year policy, substitution/waiver policy). degree_progress has accreditation_review_id but no FK to ',
    `profile_id` BIGINT COMMENT 'Unique identifier for the student whose degree progress is being tracked. Links to the student master record.',
    `student_term_record_id` BIGINT COMMENT 'Foreign key linking to enrollment.student_term_record. Business justification: Degree audit systems evaluate degree_progress against the per-term academic snapshot in student_term_record to compute completion percentage and verify SAP status. Academic advisors and degree audit e',
    `anticipated_graduation_term` STRING COMMENT 'The academic term in which the student is expected to complete all degree requirements and graduate (e.g., Spring 2025).. Valid values are `^(Fall|Spring|Summer)sd{4}$`',
    `audit_notes` STRING COMMENT 'Free-text notes or comments from the degree audit system regarding exceptions, substitutions, or special conditions affecting degree progress.',
    `catalog_year` STRING COMMENT 'The academic catalog year under which the student is pursuing the degree (e.g., 2023-2024). Determines the set of degree requirements applicable to the student.. Valid values are `^d{4}-d{4}$`',
    `cip_code` STRING COMMENT 'The six-digit CIP code that classifies the instructional program according to the National Center for Education Statistics taxonomy (e.g., 11.0701 for Computer Science).. Valid values are `^d{2}.d{4}$`',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of degree requirements completed, calculated as (credits completed + transferred + waived) / total credits required * 100.',
    `credits_completed` DECIMAL(18,2) COMMENT 'Total number of credit hours the student has successfully completed toward the degree program, including passed courses with grades of D or better (or institution-specific passing threshold).',
    `credits_in_progress` DECIMAL(18,2) COMMENT 'Total number of credit hours the student is currently enrolled in for the current term that count toward degree requirements.',
    `credits_remaining` DECIMAL(18,2) COMMENT 'Total number of credit hours still required to complete the degree program, calculated as total required minus completed, transferred, and waived credits.',
    `credits_transferred` DECIMAL(18,2) COMMENT 'Total number of credit hours accepted from other institutions or prior learning assessments that count toward the degree program.',
    `credits_waived` DECIMAL(18,2) COMMENT 'Total number of credit hours waived due to exemptions, advanced placement, or other institutional policies.',
    `declaration_date` DATE COMMENT 'The date on which the student officially declared this major or program.',
    `degree_audit_run_timestamp` TIMESTAMP COMMENT 'The timestamp when the most recent degree audit was executed to calculate progress toward degree completion.',
    `degree_level` STRING COMMENT 'The level of the degree program the student is pursuing (e.g., Bachelors, Masters, Doctoral).. Valid values are `associate|bachelor|master|doctoral|certificate|diploma`',
    `degree_type` STRING COMMENT 'The type of degree being pursued (e.g., BA, BS, MA, MS, PhD, MBA).',
    `effective_date` DATE COMMENT 'The date from which this degree progress record is effective. Supports point-in-time tracking of program changes.',
    `elective_credits_completed` DECIMAL(18,2) COMMENT 'Total number of elective credit hours the student has successfully completed.',
    `elective_credits_required` DECIMAL(18,2) COMMENT 'Total number of elective credit hours required for the degree program.',
    `end_date` DATE COMMENT 'The date on which this degree progress record is no longer effective (e.g., when the student changes programs or graduates). Null for current active records.',
    `general_education_credits_completed` DECIMAL(18,2) COMMENT 'Total number of general education or core curriculum credit hours the student has successfully completed.',
    `general_education_credits_required` DECIMAL(18,2) COMMENT 'Total number of general education or core curriculum credit hours required for the degree program.',
    `major_code` STRING COMMENT 'The institutional code for the students declared major within the academic program.',
    `major_credits_completed` DECIMAL(18,2) COMMENT 'Total number of credit hours the student has successfully completed in the major field of study.',
    `major_credits_required` DECIMAL(18,2) COMMENT 'Total number of credit hours required in the major field of study.',
    `major_name` STRING COMMENT 'The full name of the students declared major (e.g., Computer Science, Biology, Business Administration).',
    `minimum_gpa_required` DECIMAL(18,2) COMMENT 'The minimum cumulative or program GPA required for degree conferral under the applicable catalog year.',
    `minor_code` STRING COMMENT 'The institutional code for the students declared minor, if applicable.',
    `minor_name` STRING COMMENT 'The full name of the students declared minor (e.g., Mathematics, Psychology), if applicable.',
    `program_gpa` DECIMAL(18,2) COMMENT 'The students cumulative GPA calculated only for courses that count toward the declared program requirements.',
    `progress_status` STRING COMMENT 'Current status of the students progress toward degree completion. Indicates whether the student is on track, at risk, behind schedule, has completed the degree, withdrawn, or is suspended.. Valid values are `on_track|at_risk|behind|completed|withdrawn|suspended`',
    `residency_credits_completed` DECIMAL(18,2) COMMENT 'Total number of credit hours the student has completed at the institution that count toward residency requirements.',
    `residency_credits_required` DECIMAL(18,2) COMMENT 'Minimum number of credit hours that must be completed at the institution (not transferred) to satisfy residency requirements for the degree.',
    `sap_status` STRING COMMENT 'The students current SAP status for Title IV financial aid eligibility. Indicates whether the student is meeting, on warning, suspended, or on probation for academic progress standards.. Valid values are `meeting|warning|suspension|probation`',
    `scenario_description` STRING COMMENT 'Description of the what-if scenario being evaluated (e.g., Change major to Economics, Add minor in Statistics). Null for actual declared programs.',
    `total_credits_required` DECIMAL(18,2) COMMENT 'Total number of credit hours required to complete the degree program under the applicable catalog year.',
    `what_if_scenario_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this degree progress record represents a hypothetical what-if scenario for program change analysis (True) or the students actual declared program (False).',
    CONSTRAINT pk_degree_progress PRIMARY KEY(`degree_progress_id`)
) COMMENT 'Captures a students progress toward completion of a declared degree program at a point in time. Includes declared major(s), declared minor(s), concentration, catalog year, total credits required, credits completed, credits in progress, credits waived, credits transferred, percentage to completion, anticipated graduation term, graduation application status, and degree audit run timestamp. Supports what-if scenario tracking for program changes. Links to the curriculum domain for degree requirements.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`enrollment_status` (
    `enrollment_status_id` BIGINT COMMENT 'Unique identifier for the enrollment status record. Primary key for this entity. One record per student per term.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: IPEDS enrollment headcount, FTE calculation, and program-level enrollment reporting all require linking each enrollment record to the official academic program. Enrollment management and institutional',
    `academic_standing_id` BIGINT COMMENT 'Foreign key linking to student.academic_standing. Business justification: enrollment_status currently carries academic_standing as a denormalized STRING field, duplicating data from the authoritative academic_standing table. Linking enrollment_status to academic_standing vi',
    `campus_id` BIGINT COMMENT 'Foreign key linking to facility.campus. Business justification: Primary campus enrollment drives IPEDS reporting, tuition residency determination, student services allocation, and facilities capacity planning. Normalizes primary_campus_code text field to structu',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Enrollment eligibility, re-enrollment eligibility, and enrollment verification are governed by institutional enrollment policy. A registrar would expect each enrollment status record to cite the gover',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: IPEDS enrollment headcount by college, budget allocation, and accreditation reporting require linking enrollment records to the primary academic org unit. primary_college_code is a denormalized code; ',
    `profile_id` BIGINT COMMENT 'Unique identifier for the student. Links to the student master record in the Student Information System (SIS).',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: IPEDS enrollment reporting (ipeds_enrollment_category field), Title IV enrollment intensity determinations, and Clery Act enrollment counts are each driven by specific regulatory requirements. A compl',
    `residency_classification_id` BIGINT COMMENT 'Foreign key linking to student.residency_classification. Business justification: enrollment_status currently carries residency_status as a denormalized STRING field, duplicating data from the authoritative residency_classification table. Linking enrollment_status to residency_clas',
    `student_term_record_id` BIGINT COMMENT 'Foreign key linking to enrollment.student_term_record. Business justification: IPEDS enrollment reporting and SAP evaluation require reconciling the student-domain enrollment_status snapshot with the enrollment-domain student_term_record. Registrars and financial aid offices joi',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: enrollment_status.term_code is a denormalized plain attribute that should be normalized to enrollment.term.term_id. IPEDS enrollment reporting, census date processing, and financial aid disbursement a',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Enrollment change audit trails, FERPA accountability, and registrar compliance reporting require knowing which staff member last updated each enrollment status record. record_updated_by is a denormali',
    `athlete_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the student is a varsity athlete participating in NCAA-sanctioned sports. Used for NCAA compliance and academic support services.',
    `census_date` DATE COMMENT 'Official census date for this enrollment term. Enrollment status as of this date is used for official headcount reporting and financial aid freeze.',
    `cohort_year` STRING COMMENT 'Four-digit year identifying the students entry cohort for retention and graduation rate tracking. Used for IPEDS Graduation Rate Survey and institutional analytics.',
    `credit_hours_attempted` DECIMAL(18,2) COMMENT 'Total number of credit hours the student attempted during this term, including courses dropped after census date. Used for SAP calculations.',
    `credit_hours_enrolled` DECIMAL(18,2) COMMENT 'Total number of credit hours for which the student is enrolled in this term. Basis for FTE calculation and tuition billing.',
    `degree_seeking_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the student is enrolled in a degree or certificate program. Determines IPEDS reporting inclusion and Title IV eligibility.',
    `enrollment_date` DATE COMMENT 'Date the student officially enrolled in courses for this term. Typically the date of first registration or add transaction.',
    `enrollment_intensity` STRING COMMENT 'Classification of student enrollment intensity based on credit hour load. Used for Title IV financial aid eligibility, SAP monitoring, and IPEDS reporting.. Valid values are `full-time|part-time|less-than-half-time|not-enrolled`',
    `enrollment_level` STRING COMMENT 'Academic level at which the student is enrolled for this term. Determines program requirements, tuition rates, and IPEDS reporting category.. Valid values are `undergraduate|graduate|doctoral|professional|non-degree|post-baccalaureate`',
    `enrollment_status` STRING COMMENT 'Current enrollment status of the student for this term. Reflects the students active standing in the academic term lifecycle.. Valid values are `enrolled|withdrawn|completed|leave-of-absence|dismissed|deceased`',
    `enrollment_verification_date` DATE COMMENT 'Date the enrollment status was last verified by the Registrars Office. Used for National Student Clearinghouse reporting and loan deferment verification.',
    `expected_graduation_term` STRING COMMENT 'Six-digit term code indicating the students expected graduation term based on program requirements and current progress. Used for degree audit and commencement planning.. Valid values are `^[0-9]{6}$`',
    `ferpa_directory_hold_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the student has requested suppression of directory information under FERPA. When true, no directory information may be released without written consent.',
    `financial_aid_recipient_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the student received any financial aid (federal, state, institutional, or private) for this term.',
    `fte_value` DECIMAL(18,2) COMMENT 'Numeric FTE value representing the students enrollment intensity as a fraction of full-time status. Used for institutional capacity planning and state funding formulas. Range: 0.0000 to 1.0000.',
    `ftiac_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this is the students first enrollment in any postsecondary institution. Critical for cohort tracking and graduation rate calculations.',
    `honors_program_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the student is enrolled in an institutional honors program for this term.',
    `housing_status` STRING COMMENT 'Indicates whether the student is living in institutional housing, off-campus, or commuting. Used for housing capacity planning and student life programming.. Valid values are `on-campus|off-campus|commuter|not-applicable`',
    `instructional_method` STRING COMMENT 'Primary mode of instructional delivery for the students enrolled courses in this term. Determines Title IV eligibility and state authorization requirements.. Valid values are `on-campus|online|hybrid|correspondence`',
    `ipeds_enrollment_category` STRING COMMENT 'IPEDS-defined enrollment category for federal reporting. Classifies students by entry status and enrollment history for standardized national reporting.. Valid values are `first-time|transfer|continuing|returning|non-degree`',
    `last_date_of_attendance` DATE COMMENT 'Last documented date the student attended class or participated in an academically-related activity. Required for Title IV Return of Funds calculations when a student withdraws.',
    `re_enrollment_eligibility` STRING COMMENT 'Indicates whether the student is eligible to re-enroll in a future term based on academic standing, conduct status, and financial obligations.. Valid values are `eligible|ineligible|conditional|pending-review`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment status record was first created in the Student Information System. Used for audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment status record was last modified. Used for change tracking and data synchronization with downstream systems.',
    `sap_status` STRING COMMENT 'Students SAP status for Title IV financial aid eligibility. Evaluated based on GPA, completion rate, and maximum timeframe standards.. Valid values are `meeting|warning|suspension|appeal-approved|appeal-denied`',
    `veteran_status_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the student is a military veteran or active duty service member. Used for veteran services and GI Bill administration.',
    `withdrawal_date` DATE COMMENT 'Date the student officially withdrew from all courses in this term. Triggers Title IV Return of Funds calculation and impacts academic standing.',
    `withdrawal_reason_code` STRING COMMENT 'Institutional code indicating the reason for student withdrawal. Used for retention analysis and intervention program design.. Valid values are `^[A-Z0-9]{2,6}$`',
    CONSTRAINT pk_enrollment_status PRIMARY KEY(`enrollment_status_id`)
) COMMENT 'Authoritative record of a students enrollment status for each academic term. Captures full-time/part-time classification, FTE value, enrollment level (undergraduate, graduate, doctoral, professional, non-degree), primary campus, instructional method (on-campus, online, hybrid), enrollment date, last date of attendance, withdrawal date, withdrawal reason code, re-enrollment eligibility, and IPEDS enrollment category. One record per student per term. This is the SSOT for enrollment headcount and FTE reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`academic_history` (
    `academic_history_id` BIGINT COMMENT 'Unique identifier for each academic history record. Primary key for the academic history product.',
    `course_id` BIGINT COMMENT 'Unique identifier for the course taken. Links to the course catalog master record.',
    `course_section_id` BIGINT COMMENT 'Identifier for the specific section of the course in which the student was enrolled.',
    `final_grade_id` BIGINT COMMENT 'Foreign key linking to instruction.final_grade. Business justification: Grade posting reconciliation and transcript audit require linking each academic_history record to the authoritative final_grade record it was built from. Registrars use this to verify posted transcrip',
    `grade_entry_id` BIGINT COMMENT 'Foreign key linking to instruction.grade_entry. Business justification: Transcript integrity audits and grade appeal processes require tracing each academic_history record back to the specific gradebook grade_entry that sourced it. Higher-ed registrars and academic integr',
    `instructor_id` BIGINT COMMENT 'Unique identifier for the instructor of record who taught this section. Links to the faculty master record.',
    `profile_id` BIGINT COMMENT 'Unique identifier for the student to whom this academic history record belongs. Links to the student master record.',
    `registration_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_registration. Business justification: Grade change audit trails and transcript verification require tracing each academic_history record back to the originating enrollment_registration. Registrars processing grade changes and auditors ver',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Federal effort reporting (2 CFR 200) requires linking student RA academic activity to the specific funded award. Graduate research courses and RA appointments must be traceable to the sponsoring award',
    `service_learning_placement_id` BIGINT COMMENT 'Foreign key linking to studentlife.service_learning_placement. Business justification: Academic history records for service learning credit must reference the originating service_learning_placement for transcript accuracy and accreditation reporting. Registrars and accreditation officer',
    `student_term_record_id` BIGINT COMMENT 'Foreign key linking to enrollment.student_term_record. Business justification: GPA recalculation, SAP audits, and transcript verification require aggregating course-level academic_history records into the term-level student_term_record. Registrars and financial aid offices need ',
    `term_id` BIGINT COMMENT 'Identifier for the academic term in which the course was taken (e.g., Fall 2023, Spring 2024).',
    `transfer_credit_id` BIGINT COMMENT 'Foreign key linking to student.transfer_credit. Business justification: When transfer credits are accepted and posted to a students record, they appear in academic_history with transfer_credit_indicator=true. Linking academic_history to the originating transfer_credit re',
    `academic_level` STRING COMMENT 'The academic level at which the course was taken (e.g., undergraduate, graduate, professional, doctoral).. Valid values are `undergraduate|graduate|professional|doctoral|post_doctoral|continuing_education`',
    `academic_standing_impact` STRING COMMENT 'Indicates the impact of this course result on the students academic standing (e.g., positive contribution, neutral, negative impact, triggered probation or dismissal).. Valid values are `positive|neutral|negative|probation_trigger|dismissal_trigger`',
    `completion_status` STRING COMMENT 'The completion status of the course indicating whether the student successfully completed the course requirements.. Valid values are `completed|incomplete|in_progress|withdrawn|failed|not_started`',
    `course_delivery_mode` STRING COMMENT 'The instructional delivery method for the course (e.g., in-person, online, hybrid, blended, synchronous, asynchronous).. Valid values are `in_person|online|hybrid|blended|synchronous|asynchronous`',
    `course_level` STRING COMMENT 'The numeric level of the course indicating its difficulty or year level (e.g., 100-level for freshman, 200-level for sophomore, 500-level for graduate).. Valid values are `^[0-9]{3}$`',
    `course_reference_number` STRING COMMENT 'The unique course reference number (CRN) assigned to the section for registration purposes. Commonly used in Ellucian Banner systems.. Valid values are `^[A-Z0-9]{4,10}$`',
    `course_title` STRING COMMENT 'The official title of the course as it appears on the transcript (e.g., Introduction to Psychology, Calculus I).',
    `credit_hours_attempted` DECIMAL(18,2) COMMENT 'The number of credit hours the student attempted for this course. Used in GPA (Grade Point Average) and SAP (Satisfactory Academic Progress) calculations.',
    `credit_hours_earned` DECIMAL(18,2) COMMENT 'The number of credit hours the student successfully earned for this course. May differ from attempted hours if the course was failed or withdrawn.',
    `degree_applicable_flag` BOOLEAN COMMENT 'Flag indicating whether this course counts toward the students degree requirements for their declared program.',
    `financial_aid_eligible_flag` BOOLEAN COMMENT 'Flag indicating whether this course is eligible for financial aid consideration under Title IV regulations.',
    `general_education_flag` BOOLEAN COMMENT 'Flag indicating whether this course fulfills a general education or core curriculum requirement.',
    `gpa_included_flag` BOOLEAN COMMENT 'Flag indicating whether this course is included in the students GPA calculation. Some courses (e.g., pass/fail, audit, transfer credits) may be excluded.',
    `grade_change_date` DATE COMMENT 'The date on which the grade was last changed, if applicable. Used for audit trail and compliance purposes.',
    `grade_change_indicator` BOOLEAN COMMENT 'Flag indicating whether the grade for this course has been changed after initial posting. Used for audit trail purposes.',
    `grade_change_reason` STRING COMMENT 'The documented reason for any grade change, required for audit trail and FERPA compliance.',
    `grade_earned` STRING COMMENT 'The letter grade or grade code earned by the student for this course (e.g., A, B+, C-, F, W for withdrawal, I for incomplete, P for pass, NP for no pass, AU for audit).. Valid values are `^[A-F][+-]?|W|I|P|NP|AU|S|U|IP$`',
    `grade_points` DECIMAL(18,2) COMMENT 'The total grade points earned for this course, calculated as credit hours multiplied by the grade point value (e.g., 4.0 for A, 3.0 for B). Used in GPA (Grade Point Average) calculation.',
    `grade_replacement_flag` BOOLEAN COMMENT 'Flag indicating whether this grade replaces a previous grade for GPA calculation purposes under the institutions grade replacement policy.',
    `grading_mode` STRING COMMENT 'The grading basis under which the student took the course (e.g., standard letter grade, pass/fail, audit, credit/no credit).. Valid values are `standard|pass_fail|audit|credit_no_credit|satisfactory_unsatisfactory|honors`',
    `honors_course_flag` BOOLEAN COMMENT 'Flag indicating whether this course was taken as part of an honors program or honors section.',
    `major_requirement_flag` BOOLEAN COMMENT 'Flag indicating whether this course fulfills a major requirement for the students declared major program.',
    `online_course_flag` BOOLEAN COMMENT 'Flag indicating whether this course was delivered entirely online or through distance education.',
    `quality_points` DECIMAL(18,2) COMMENT 'Alternative term for grade points used in some institutions. Represents the numeric value assigned to the grade for GPA calculation purposes.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this academic history record was first created in the system. Used for audit trail purposes.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this academic history record was last updated. Used for audit trail and data lineage purposes.',
    `registration_status` STRING COMMENT 'The current or final registration status for this course enrollment (e.g., registered, dropped, withdrawn, completed).. Valid values are `registered|dropped|withdrawn|completed|in_progress|audit`',
    `repeat_count` STRING COMMENT 'The number of times the student has attempted this specific course, including the current attempt.',
    `repeat_indicator` BOOLEAN COMMENT 'Flag indicating whether this course is a repeat of a previously taken course. True if the student has taken this course before.',
    `source_institution_code` STRING COMMENT 'The code or identifier for the institution from which transfer credits were earned. Populated only for transfer credits.. Valid values are `^[A-Z0-9]{4,10}$`',
    `source_institution_name` STRING COMMENT 'The name of the institution from which transfer credits were earned. Populated only for transfer credits.',
    `subject_code` STRING COMMENT 'The subject area code for the course (e.g., MATH, ENGL, BIOL, CHEM).. Valid values are `^[A-Z]{2,4}$`',
    `transcript_display_flag` BOOLEAN COMMENT 'Flag indicating whether this course should appear on the official transcript. Some courses may be excluded from transcript display per institutional policy.',
    `transfer_credit_indicator` BOOLEAN COMMENT 'Flag indicating whether this course was transferred from another institution rather than taken at the home institution.',
    CONSTRAINT pk_academic_history PRIMARY KEY(`academic_history_id`)
) COMMENT 'Immutable official transcript record of all courses a student has completed, including course subject, course number, course title, credit hours, grade earned, grade points, repeat indicator, grade replacement flag, transfer credit indicator, source institution (for transfer credits), term taken, section identifier, instructor of record, and grading mode (standard, pass/fail, audit). Supports GPA recalculation, FERPA-protected transcript generation, and IPEDS Completions Survey reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`student_test_score` (
    `student_test_score_id` BIGINT COMMENT 'Unique identifier for the student test score record. Primary key.',
    `enrollment_application_id` BIGINT COMMENT 'Reference to the admissions application for which this test score was submitted. Links to the enrollment application record. Nullable if score was submitted outside of a specific application context.',
    `profile_id` BIGINT COMMENT 'Reference to the student who took the test. Links to the student master record in the Student Information System (SIS).',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Official test score verification and admissions processing workflows require tracking which admissions/registrar staff member received and processed each score report. received_by is a denormalized te',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Test score reporting for admissions transparency is regulatory under state authorization and accreditation. Test score policies must comply with state disclosure requirements. Essential for state auth',
    `composite_score` STRING COMMENT 'Overall composite or total score for the test. Scale varies by test type (e.g., SAT 400-1600, ACT 1-36, GRE 260-340, TOEFL 0-120, IELTS 0-9).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test score record was first created in the system. Used for audit trail and data lineage tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the test score record was last updated or modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments about the test score record. May include information about score discrepancies, special circumstances, or additional context for admissions review.',
    `official_verification_status` STRING COMMENT 'Status of official verification for the test score. Indicates whether an official score report has been received and validated by the institution. Pending indicates awaiting official report, verified indicates official report received and matched, rejected indicates discrepancy between self-reported and official scores, not_required indicates official verification is not needed for this use case.. Valid values are `pending|verified|rejected|not_required`',
    `percentile_rank` STRING COMMENT 'Percentile rank of the students composite score compared to all test takers in the reference population. Value ranges from 1 to 99, indicating the percentage of test takers who scored at or below this score.',
    `received_date` DATE COMMENT 'Date when the test score record was received and entered into the Student Information System (SIS). Used for tracking processing timelines and application completeness.',
    `record_status` STRING COMMENT 'Current status of the test score record. Active indicates the score is current and valid for use, superseded indicates a newer score has replaced this one, cancelled indicates the score has been invalidated, archived indicates the score is retained for historical purposes but no longer actively used.. Valid values are `active|superseded|cancelled|archived`',
    `score_report_date` DATE COMMENT 'Date when the official score report was issued by the testing agency. Used to track score validity periods and official reporting timelines.',
    `score_send_date` DATE COMMENT 'Date when the official score report was sent to the institution by the testing agency. Used for tracking score receipt and processing timelines.',
    `score_source` STRING COMMENT 'Indicates whether the test score was self-reported by the student or received as an official score report from the testing agency. Self-reported scores may be used for initial admissions review, while official scores are required for final admission decisions.. Valid values are `self_reported|official`',
    `score_use_purpose` STRING COMMENT 'Primary purpose for which the test score is being used by the institution. Admission indicates use in admissions evaluation, placement indicates use for course placement decisions, scholarship indicates use for merit scholarship consideration, research indicates use for institutional research and reporting.. Valid values are `admission|placement|scholarship|research`',
    `score_validity_end_date` DATE COMMENT 'Date after which the test score is no longer considered valid for admissions purposes. Validity periods vary by test type and institutional policy (e.g., GRE scores valid for 5 years, TOEFL scores valid for 2 years).',
    `section_1_name` STRING COMMENT 'Name of the first test section or component (e.g., SAT Evidence-Based Reading and Writing, ACT English, GRE Verbal Reasoning, TOEFL Reading).',
    `section_1_score` STRING COMMENT 'Score achieved on the first test section. Scale varies by test type and section.',
    `section_2_name` STRING COMMENT 'Name of the second test section or component (e.g., SAT Math, ACT Math, GRE Quantitative Reasoning, TOEFL Listening).',
    `section_2_score` STRING COMMENT 'Score achieved on the second test section. Scale varies by test type and section.',
    `section_3_name` STRING COMMENT 'Name of the third test section or component (e.g., ACT Reading, GRE Analytical Writing, TOEFL Speaking). Nullable for tests with fewer sections.',
    `section_3_score` STRING COMMENT 'Score achieved on the third test section. Nullable for tests with fewer sections. Scale varies by test type and section.',
    `section_4_name` STRING COMMENT 'Name of the fourth test section or component (e.g., ACT Science, TOEFL Writing). Nullable for tests with fewer sections.',
    `section_4_score` STRING COMMENT 'Score achieved on the fourth test section. Nullable for tests with fewer sections. Scale varies by test type and section.',
    `superscore_eligible_flag` BOOLEAN COMMENT 'Indicates whether this test score is eligible for superscoring. Superscoring combines the highest section scores from multiple test dates to create a new composite score. Eligibility depends on institutional policy and test type.',
    `test_administration_code` STRING COMMENT 'Unique code assigned by the testing agency to identify the specific test administration session. Used for score verification and tracking purposes.',
    `test_center_code` STRING COMMENT 'Code identifying the test center location where the student took the test. Used for tracking and verification purposes.',
    `test_center_name` STRING COMMENT 'Name of the test center location where the student took the test.',
    `test_date` DATE COMMENT 'Date on which the student took the standardized test. Used for score validity assessment and superscore eligibility determination.',
    `test_type` STRING COMMENT 'Type of standardized test taken by the student. Common types include SAT (Scholastic Assessment Test), ACT (American College Testing), GRE (Graduate Record Examination), GMAT (Graduate Management Admission Test), TOEFL (Test of English as a Foreign Language), IELTS (International English Language Testing System), AP (Advanced Placement), IB (International Baccalaureate), CLEP (College Level Examination Program), and Duolingo English Test. [ENUM-REF-CANDIDATE: SAT|ACT|GRE|GMAT|TOEFL|IELTS|AP|IB|CLEP|Duolingo|MCAT|LSAT|PSAT — promote to reference product]. Valid values are `SAT|ACT|GRE|GMAT|TOEFL|IELTS`',
    `test_version` STRING COMMENT 'Version or form code of the test administered. Different versions may have slightly different questions but are equated to the same scoring scale.',
    `writing_score` STRING COMMENT 'Optional writing or essay score component, if applicable for the test type (e.g., SAT Essay, ACT Writing, GRE Analytical Writing). Nullable for tests without writing components or when student did not take the writing section.',
    CONSTRAINT pk_student_test_score PRIMARY KEY(`student_test_score_id`)
) COMMENT 'Stores standardized test scores submitted by or on behalf of a student, including test type (SAT, ACT, GRE, GMAT, TOEFL, IELTS, AP, IB, CLEP, Duolingo English Test), test date, score components (e.g., SAT Evidence-Based Reading and Writing, SAT Math), composite score, percentile rank, score report date, score source (self-reported vs. official), official verification status, and superscore eligibility flag. Supports admissions evaluation and placement decisions.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`transfer_credit` (
    `transfer_credit_id` BIGINT COMMENT 'Unique identifier for the transfer credit evaluation record. Primary key.',
    `articulation_agreement_id` BIGINT COMMENT 'Identifier of the formal articulation agreement between the institution and the source institution, if applicable. Null if evaluated on a course-by-course basis without a standing agreement.',
    `employee_id` BIGINT COMMENT 'Identifier of the faculty member or registrar staff who performed the transfer credit evaluation. Links to employee or faculty record.',
    `course_id` BIGINT COMMENT 'Identifier of the institutional course to which the transfer credit has been articulated. Null if credit is awarded as elective or unassigned credit.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Transfer credit evaluation follows institutional articulation and credit acceptance policies. Credit evaluators apply documented policy criteria for equivalency determination. Essential for transfer c',
    `profile_id` BIGINT COMMENT 'Identifier of the student receiving the transfer credit. Links to the student master record.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Transfer credit evaluation is governed by state-mandated articulation laws and accreditation standards (e.g., state common course numbering requirements). transfer_credit has policy_id but no FK to re',
    `transfer_credit_eval_id` BIGINT COMMENT 'Foreign key linking to enrollment.transfer_credit_eval. Business justification: Transfer credit lifecycle management requires tracing a posted transfer credit record back to its originating pre-admission evaluation. Transfer credit appeals, articulation agreement audits, and accr',
    `transfer_equivalency_id` BIGINT COMMENT 'Foreign key linking to curriculum.transfer_equivalency. Business justification: Transfer credit evaluators apply a specific curriculum.transfer_equivalency rule when awarding credit to a student. Auditors and accreditors trace which institutional equivalency rule governed each aw',
    `appeal_date` DATE COMMENT 'Date when the student submitted an appeal of the transfer credit denial. Null if no appeal was filed.',
    `appeal_decision_date` DATE COMMENT 'Date when the appeal decision was rendered. Null if no appeal or appeal still pending.',
    `appeal_status` STRING COMMENT 'Status of student appeal process if the initial evaluation was denied: not appealed, appeal pending review, appeal approved (credit granted), or appeal denied (original decision upheld).. Valid values are `not_appealed|appeal_pending|appeal_approved|appeal_denied`',
    `applies_to_gpa` BOOLEAN COMMENT 'Indicates whether the transfer credit and grade are included in the institutional GPA calculation. Typically false for transfer credits per institutional policy.',
    `applies_to_residency_requirement` BOOLEAN COMMENT 'Indicates whether the transfer credit counts toward the minimum residency credit hour requirement for degree completion. Some institutions require a minimum number of credits earned in residence.',
    `awarded_credit_hours` DECIMAL(18,2) COMMENT 'Number of institutional credit hours awarded to the student after evaluation and conversion. May differ from source credit hours due to credit system conversion (e.g., quarter to semester).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transfer credit evaluation record was first created in the system. Used for audit trail and processing time analysis.',
    `denial_reason` STRING COMMENT 'Explanation provided when transfer credit is denied (e.g., course content not equivalent, grade below minimum threshold, credit too old per institutional policy). Null if approved.',
    `effective_term_code` STRING COMMENT 'Institutional term code when the transfer credit was officially posted to the student academic record (e.g., 202310 for Fall 2023).',
    `equivalent_course_title` STRING COMMENT 'Title of the institutional equivalent course. Null if awarded as elective credit.',
    `equivalent_credit_category` STRING COMMENT 'Category of degree requirement satisfied by the transfer credit: major requirement, minor requirement, general education, elective within major, prerequisite, or free elective.. Valid values are `major|minor|general_education|elective|prerequisite|free_elective`',
    `evaluation_date` DATE COMMENT 'Date when the transfer credit evaluation was completed and decision was rendered.',
    `evaluation_status` STRING COMMENT 'Current status of the transfer credit evaluation workflow: pending initial review, in review by evaluator, approved and posted, denied, under appeal, or expired (evaluation not completed within policy timeframe).. Valid values are `pending|in_review|approved|denied|appealed|expired`',
    `evaluator_name` STRING COMMENT 'Full name of the individual who evaluated the transfer credit. Stored for audit trail purposes.',
    `general_education_area` STRING COMMENT 'Specific general education requirement area satisfied (e.g., Quantitative Literacy, Humanities, Social Sciences, Natural Sciences). Null if not applied to general education.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the transfer credit evaluation record was last updated. Tracks changes through the evaluation workflow.',
    `maximum_age_policy_applied` BOOLEAN COMMENT 'Indicates whether the institution applied a maximum age policy to the transfer credit (e.g., credits older than 10 years may not transfer). True if age policy was a factor in evaluation.',
    `notes` STRING COMMENT 'Free-text notes recorded by the evaluator regarding special circumstances, conditions, or additional context for the transfer credit decision.',
    `posted_date` DATE COMMENT 'Date when the approved transfer credit was officially posted to the student transcript in the Student Information System.',
    `source_course_number` STRING COMMENT 'Original course number or code as listed on the source institution transcript (e.g., MATH 101, ENG 1A).',
    `source_course_title` STRING COMMENT 'Original course title as listed on the source institution transcript (e.g., Introduction to Calculus, Composition and Rhetoric).',
    `source_credit_hours` DECIMAL(18,2) COMMENT 'Number of credit hours or units awarded by the source institution for the original course. May be semester hours, quarter hours, or other unit systems.',
    `source_credit_type` STRING COMMENT 'Type of credit system used by the source institution (semester hours, quarter hours, trimester, or other).. Valid values are `semester|quarter|trimester|other`',
    `source_grade` STRING COMMENT 'Grade earned in the original course at the source institution (e.g., A, B+, 3.7, Pass). Format varies by source institution grading scale.',
    `source_institution_fice_code` STRING COMMENT 'Six-digit federal identification code assigned by the U.S. Department of Education to postsecondary institutions. Used for Title IV compliance and IPEDS reporting.. Valid values are `^[0-9]{6}$`',
    `source_institution_ipeds_unitid` STRING COMMENT 'Six-digit unique identifier assigned by IPEDS to postsecondary institutions for federal reporting and data collection.. Valid values are `^[0-9]{6}$`',
    `source_institution_name` STRING COMMENT 'Full name of the external institution where the credit was originally earned (e.g., community college, university, international institution).',
    `source_term` STRING COMMENT 'Academic term when the course was completed at the source institution (e.g., Fall 2020, Spring 2021).',
    `transcript_received_date` DATE COMMENT 'Date when the official transcript from the source institution was received by the registrar office. Used to track evaluation processing time.',
    `transcript_type` STRING COMMENT 'Format and authenticity level of the transcript received: official paper transcript, official electronic transcript (e.g., via National Student Clearinghouse), unofficial transcript, or self-reported by student (requires verification).. Valid values are `official_paper|official_electronic|unofficial|self_reported`',
    `transfer_credit_type` STRING COMMENT 'Category of transfer credit source: traditional coursework, Advanced Placement (AP), International Baccalaureate (IB), College-Level Examination Program (CLEP), military training, dual enrollment, proficiency examination, life experience credit, or other non-traditional pathway. [ENUM-REF-CANDIDATE: coursework|ap|ib|clep|military|dual_enrollment|proficiency_exam|life_experience|other — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_transfer_credit PRIMARY KEY(`transfer_credit_id`)
) COMMENT 'Records the evaluation and articulation of academic credits earned at external institutions or through non-traditional pathways (AP, IB, CLEP, military, dual enrollment). Captures source institution name, source institution FICE/IPEDS code, original course title, original course number, original grade, credit hours awarded, equivalent institutional course (if articulated), equivalent credit type (elective, major, general education), evaluation status, evaluator, evaluation date, and appeal status. Supports degree audit and transfer student onboarding.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`hold` (
    `hold_id` BIGINT COMMENT 'Unique identifier for the student hold record. Primary key.',
    `account_hold_id` BIGINT COMMENT 'Foreign key linking to billing.account_hold. Business justification: Financial holds in billing.account_hold directly cause student registration/transcript blocks in student.hold. Bursar and registrar offices need this traceability to coordinate hold placement and rele',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Financial holds reference specific AR ledger accounts for amounts owed (tuition, fees, library fines). Business process: bursar places holds when account balances exceed threshold; hold release requir',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Hold management, appeals routing, and compliance reporting require knowing which institutional org unit (registrar, financial aid, library) placed each hold. originating_office is a denormalized text ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Student hold management and FERPA audit trails require knowing which staff member placed each hold. placed_by is a denormalized text field; role-prefix placed_by_ is the natural business semantic fo',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Holds (registration, transcript, diploma blocks) are placed under institutional policy authority. Hold placement and release procedures follow documented policies. Required for hold appeals and policy',
    `profile_id` BIGINT COMMENT 'Identifier of the student on whom this hold is placed. Links to the student master record.',
    `registration_hold_id` BIGINT COMMENT 'Foreign key linking to enrollment.registration_hold. Business justification: Hold reconciliation and registration block auditing require linking the institutional hold record (student.hold) to the specific registration-blocking hold record (enrollment.registration_hold). Regis',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Certain holds are regulatory-mandated: Title IV disbursement blocks (34 CFR 668), immunization holds under state public health law, and Clery-related holds. hold already has policy_id but lacks the re',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Financial student holds (hold_type=financial, amount_owed) must reference the student_account for balance verification during hold resolution. Bursar offices need direct account reference on the hold ',
    `academic_year` STRING COMMENT 'Academic year associated with the hold in YYYY-YYYY format (e.g., 2023-2024). Null if the hold is not year-specific.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `amount_owed` DECIMAL(18,2) COMMENT 'Monetary amount owed by the student that triggered the hold, if applicable (e.g., outstanding tuition, fees, fines). Null for non-financial holds.',
    `appeal_date` DATE COMMENT 'Date on which the student submitted an appeal. Null if no appeal was submitted.',
    `appeal_status` STRING COMMENT 'Current status of the students appeal (pending, approved, denied, withdrawn). Null if no appeal was submitted.. Valid values are `pending|approved|denied|withdrawn`',
    `appeal_submitted` BOOLEAN COMMENT 'Indicates whether the student has submitted an appeal or request for review of the hold (True/False).',
    `comments` STRING COMMENT 'Free-text comments or notes related to the hold, providing additional context or instructions for staff or the student.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the amount_owed field (e.g., USD, CAD, GBP). Null if amount_owed is null.. Valid values are `^[A-Z]{3}$`',
    `diploma_block` BOOLEAN COMMENT 'Indicates whether this hold blocks the conferral or release of the diploma (True/False).',
    `disbursement_block` BOOLEAN COMMENT 'Indicates whether this hold blocks the disbursement of financial aid funds (True/False). Critical for Title IV compliance.',
    `effective_date` DATE COMMENT 'Date from which the hold becomes active and begins restricting services. May differ from placed_date if the hold is scheduled to take effect in the future.',
    `enrollment_verification_block` BOOLEAN COMMENT 'Indicates whether this hold blocks the issuance of enrollment verification letters (True/False).',
    `expiration_date` DATE COMMENT 'Date on which the hold automatically expires and is no longer active, if applicable. Null if the hold does not have an automatic expiration.',
    `ferpa_protected` BOOLEAN COMMENT 'Indicates whether the hold information is protected under FERPA and subject to restricted disclosure (True/False).',
    `grade_block` BOOLEAN COMMENT 'Indicates whether this hold blocks the student from viewing grades (True/False).',
    `hold_code` STRING COMMENT 'Institutional code representing the type of hold (e.g., FIN for financial, ACD for academic, DIS for disciplinary, IMM for immunization, LIB for library, PRK for parking, COM for compliance).. Valid values are `^[A-Z0-9]{2,10}$`',
    `hold_status` STRING COMMENT 'Current lifecycle status of the hold (active, released, expired, pending, suspended).. Valid values are `active|released|expired|pending|suspended`',
    `hold_type` STRING COMMENT 'Categorical classification of the hold indicating the functional area or reason category (financial, academic, disciplinary, immunization, library, parking, compliance, administrative, other). [ENUM-REF-CANDIDATE: financial|academic|disciplinary|immunization|library|parking|compliance|administrative|other — 9 candidates stripped; promote to reference product]',
    `ipeds_reportable` BOOLEAN COMMENT 'Indicates whether this hold affects data elements that must be reported to IPEDS (True/False), such as holds that prevent graduation or enrollment.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the staff member or system process that last modified the hold record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the hold record, supporting audit trail and data lineage.',
    `notification_date` DATE COMMENT 'Date on which the notification was sent to the student. Null if no notification was sent.',
    `notification_method` STRING COMMENT 'Method by which the student was notified of the hold (email, mail, portal, phone, sms, none).. Valid values are `email|mail|portal|phone|sms|none`',
    `notification_sent` BOOLEAN COMMENT 'Indicates whether a notification was sent to the student informing them of the hold (True/False).',
    `override_allowed` BOOLEAN COMMENT 'Indicates whether authorized staff are permitted to override this hold to allow restricted services (True/False).',
    `override_authority` STRING COMMENT 'Role or position authorized to override this hold (e.g., Registrar, Dean, Bursar, Department Chair). Null if override is not allowed.',
    `placed_date` DATE COMMENT 'Date on which the hold was placed on the student record.',
    `priority_level` STRING COMMENT 'Numeric priority level of the hold, used to determine processing order when multiple holds exist. Lower numbers typically indicate higher priority.',
    `reason` STRING COMMENT 'Detailed textual description of the reason the hold was placed, providing context for the restriction (e.g., outstanding tuition balance, missing immunization records, academic probation, library fines).',
    `registration_block` BOOLEAN COMMENT 'Indicates whether this hold blocks the student from registering for courses (True/False).',
    `release_reason` STRING COMMENT 'Textual description of the reason the hold was released (e.g., payment received, documentation submitted, appeal approved, administrative override).',
    `released_by` STRING COMMENT 'Username or identifier of the staff member or system process that released the hold. Null if the hold is still active.',
    `released_date` DATE COMMENT 'Date on which the hold was manually released or cleared. Null if the hold is still active.',
    `system_generated` BOOLEAN COMMENT 'Indicates whether the hold was automatically generated by a system process (True) or manually placed by staff (False).',
    `term_code` STRING COMMENT 'Academic term code associated with the hold, if the hold is term-specific (e.g., 202401 for Spring 2024). Null if the hold is not term-specific.. Valid values are `^[0-9]{6}$`',
    `transcript_block` BOOLEAN COMMENT 'Indicates whether this hold blocks the release of official transcripts (True/False).',
    CONSTRAINT pk_hold PRIMARY KEY(`hold_id`)
) COMMENT 'Tracks administrative, academic, and compliance holds placed on a students record that restrict institutional services such as registration, transcript release, diploma conferral, or financial aid disbursement. Captures hold type (financial, academic, disciplinary, immunization, library, parking, compliance), hold reason description, originating office, date placed, date released, release reason, release authority, service restrictions (registration block, transcript block, diploma block, disbursement block), and priority level. Supports Banner hold processing, student services workflows, and clearance verification for enrollment and graduation.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`leave_of_absence` (
    `leave_of_absence_id` BIGINT COMMENT 'Unique identifier for the leave of absence record. Primary key for the leave_of_absence product.',
    `academic_standing_id` BIGINT COMMENT 'Foreign key linking to student.academic_standing. Business justification: leave_of_absence currently carries academic_standing_at_leave as a denormalized STRING field capturing the students standing at the time of leave. Linking leave_of_absence to the authoritative academ',
    `campus_id` BIGINT COMMENT 'Foreign key linking to facility.campus. Business justification: Leave of absence processing, housing contract suspension, and re-enrollment eligibility are campus-specific at multi-campus institutions. Enrollment and financial aid impact calculations depend on the',
    `employee_id` BIGINT COMMENT 'Unique identifier of the faculty or staff member who approved the leave of absence. Links to employee or faculty record.',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: Leave of absence administration requires formal term linkage for leave start dates to calculate return eligibility, financial aid impact, and degree timeline adjustments. Current leave_start_term is a',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Institutional leave of absence policy governs approval criteria, return conditions, and enrollment hold rules. A registrar processing an LOA must cite the governing institutional policy version for au',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student taking the leave of absence. Links to the student master record.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: LOA processing under Title IV (34 CFR 668.22), HEROES Act military leave, and ADA medical leave each cite specific regulatory requirements. A financial aid/registrar compliance officer must trace each',
    `student_term_record_id` BIGINT COMMENT 'Foreign key linking to enrollment.student_term_record. Business justification: SAP clock management and enrollment status reconciliation require linking leave_of_absence to the student_term_record for the leave term. Financial aid offices use this link to verify SAP clock suspen',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Leave of absence records carry tuition_refund_eligibility_flag and tuition_refund_percentage. When a refund is issued, the bursar generates a credit AR invoice or adjustment. Linking the leave record ',
    `actual_return_date` DATE COMMENT 'Actual date when the student returned from leave and re-enrolled. Null if student has not yet returned. Used to measure leave duration accuracy and Title IV compliance.',
    `advisor_notified_flag` BOOLEAN COMMENT 'Indicates whether the students academic advisor was notified of the leave of absence. True if advisor notified, false otherwise. Important for continuity of advising relationship.',
    `approval_date` DATE COMMENT 'Date on which the leave of absence request was officially approved by the approving authority. Null if not yet approved or if denied.',
    `approving_authority` STRING COMMENT 'Name or title of the institutional official who approved the leave of absence request (e.g., Dean of Students, Registrar, Academic Advisor).',
    `comments` STRING COMMENT 'Additional administrative notes or comments about the leave of absence, including special circumstances, follow-up actions, or coordination with other offices.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this leave of absence record was first created in the system. Audit field for data lineage and compliance tracking.',
    `credits_earned_at_leave` DECIMAL(18,2) COMMENT 'Total number of credit hours the student had successfully completed at the time the leave of absence began. Used for degree progress tracking and SAP calculations.',
    `degree_timeline_impact_days` STRING COMMENT 'Number of days by which the leave of absence extends the students expected degree completion timeline. Used for academic planning and advising.',
    `enrollment_hold_flag` BOOLEAN COMMENT 'Indicates whether an enrollment hold is placed on the students record during the leave period, preventing registration until return conditions are met. True if hold is active, false otherwise.',
    `expected_return_date` DATE COMMENT 'Anticipated date when the student plans to return from leave and re-enroll. Used for planning and Title IV compliance tracking.',
    `expected_return_term` STRING COMMENT 'Academic term code when the student is expected to return from leave and resume enrollment. Follows institutional term coding convention.',
    `financial_aid_impact_flag` BOOLEAN COMMENT 'Indicates whether the leave of absence affects the students financial aid eligibility, Satisfactory Academic Progress (SAP) status, or Title IV aid clock. True if financial aid is impacted, false otherwise.',
    `gpa_at_leave` DECIMAL(18,2) COMMENT 'Students cumulative Grade Point Average (GPA) at the time the leave of absence began. Used to track academic standing and eligibility for return. Expressed on a 4.0 scale.',
    `housing_contract_status` STRING COMMENT 'Status of the students on-campus housing contract during the leave period. Active indicates contract remains in force, suspended indicates temporary pause, terminated indicates contract ended, not_applicable indicates student had no housing contract.. Valid values are `active|suspended|terminated|not_applicable`',
    `ipeds_reportable_flag` BOOLEAN COMMENT 'Indicates whether this leave of absence must be reported in IPEDS enrollment and retention surveys. True if reportable, false otherwise. Depends on leave duration and timing relative to census dates.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this leave of absence record was most recently updated. Audit field for change tracking and data quality monitoring.',
    `leave_end_date` DATE COMMENT 'Official end date of the approved leave of absence period. Represents the last day the student is on leave status before expected return.',
    `leave_start_date` DATE COMMENT 'Effective date when the leave of absence officially begins. Marks the first day the student is no longer enrolled.',
    `leave_status` STRING COMMENT 'Current status of the leave of absence request in its lifecycle. Pending indicates awaiting approval, approved indicates authorization granted, denied indicates request rejected, active indicates student is currently on leave, returned indicates student has resumed enrollment, withdrawn indicates student withdrew the request.. Valid values are `pending|approved|denied|active|returned|withdrawn`',
    `leave_type` STRING COMMENT 'Category of leave of absence granted to the student. Medical covers health-related absences, personal covers non-medical personal reasons, military covers active duty service, parental covers childbirth or adoption, research covers off-campus research opportunities, and academic covers study abroad or exchange programs.. Valid values are `medical|personal|military|parental|research|academic`',
    `meal_plan_status` STRING COMMENT 'Status of the students meal plan during the leave period. Active indicates plan continues, suspended indicates temporary pause, terminated indicates plan ended, not_applicable indicates student had no meal plan.. Valid values are `active|suspended|terminated|not_applicable`',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this leave of absence record. Audit field for accountability and compliance.',
    `re_enrollment_confirmed_flag` BOOLEAN COMMENT 'Indicates whether the student has confirmed their intent to re-enroll after the leave period. True if re-enrollment confirmed, false if not confirmed or student withdrew permanently.',
    `re_enrollment_term` STRING COMMENT 'Actual academic term code when the student re-enrolled after returning from leave. May differ from expected_return_term if student delayed return. Null if student has not yet re-enrolled.',
    `reason_description` STRING COMMENT 'Detailed narrative explanation provided by the student for requesting the leave of absence. May contain sensitive personal information. Classified as confidential to protect student privacy.',
    `request_date` DATE COMMENT 'Date on which the student submitted the leave of absence request. Represents the business event timestamp for the leave request initiation.',
    `return_conditions` STRING COMMENT 'Specific conditions or requirements the student must meet before being permitted to return from leave (e.g., medical clearance, academic advising meeting, financial holds resolved).',
    `sap_clock_stopped_flag` BOOLEAN COMMENT 'Indicates whether the Satisfactory Academic Progress (SAP) maximum timeframe clock is stopped during this leave period. True if SAP clock is paused, false if it continues to run. Critical for Title IV financial aid compliance.',
    `supporting_documentation_flag` BOOLEAN COMMENT 'Indicates whether supporting documentation (medical records, military orders, etc.) was submitted with the leave request. True if documentation provided, false otherwise.',
    `title_iv_compliant_flag` BOOLEAN COMMENT 'Indicates whether the leave of absence meets Title IV federal financial aid compliance requirements (duration limits, approval documentation, return expectations). True if compliant, false if non-compliant.',
    `tuition_refund_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the student is eligible for a tuition refund based on the timing of the leave relative to the institutional refund schedule. True if eligible for refund, false otherwise.',
    `tuition_refund_percentage` DECIMAL(18,2) COMMENT 'Percentage of tuition eligible for refund based on the leave start date and institutional refund schedule. Expressed as a decimal (e.g., 75.00 for 75% refund).',
    CONSTRAINT pk_leave_of_absence PRIMARY KEY(`leave_of_absence_id`)
) COMMENT 'Documents approved leaves of absence from academic study, including leave type (medical, personal, military, parental, research), leave start term, expected return term, actual return date, leave approval status, approving authority, conditions for return, impact on financial aid SAP clock, impact on degree completion timeline, and re-enrollment confirmation. Supports student lifecycle continuity tracking and Title IV leave-of-absence compliance requirements.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`ferpa_consent` (
    `ferpa_consent_id` BIGINT COMMENT 'Unique identifier for the FERPA consent record. Primary key for the ferpa_consent product.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: FERPA consents must align with institutional FERPA policy version. Consent forms reference specific policy language for legal compliance. Essential for consent validity verification and policy version',
    `employee_id` BIGINT COMMENT 'Unique identifier of the institutional staff member who processed and authorized this FERPA consent in the system. Links to the staff or employee master record.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student who granted or revoked FERPA consent. Links to the student master record in the Student Information System (SIS).',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: FERPA consent is directly governed by 20 U.S.C. § 1232g and 34 CFR Part 99. ferpa_consent has policy_id but no FK to the specific regulatory_requirement record. A FERPA compliance officer auditing con',
    `audit_trail_notes` STRING COMMENT 'Free-text field for institutional staff to record additional context, special circumstances, or compliance notes related to this FERPA consent.',
    `authorized_by_staff_name` STRING COMMENT 'Full name of the institutional staff member who processed this FERPA consent. Denormalized for audit trail purposes.',
    `authorized_party_email` STRING COMMENT 'Primary email address of the authorized party for communication regarding record disclosures.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `authorized_party_name` STRING COMMENT 'Full legal name of the individual or organization authorized to receive the students educational records under this FERPA consent.',
    `authorized_party_phone` STRING COMMENT 'Primary contact phone number for the authorized party.',
    `authorized_party_relationship` STRING COMMENT 'The relationship of the authorized party to the student. Indicates the basis for the disclosure authorization. [ENUM-REF-CANDIDATE: parent|legal_guardian|spouse|attorney|employer|financial_aid_agency|scholarship_provider|third_party_vendor|other — 9 candidates stripped; promote to reference product]',
    `banner_release_code` STRING COMMENT 'The specific FERPA release code activated in Ellucian Banner SIS for this consent. Maps to Banners GOBTPAC table release codes.',
    `consent_document_url` STRING COMMENT 'URL or file path to the digitally stored signed FERPA consent form or authorization document. Used for audit trail and compliance verification.',
    `consent_effective_date` DATE COMMENT 'The date from which the FERPA consent becomes enforceable and record disclosures may begin. May differ from grant date if consent is scheduled to start in the future.',
    `consent_expiration_date` DATE COMMENT 'The date on which the FERPA consent authorization expires and is no longer valid for record disclosure. Nullable for open-ended consents.',
    `consent_grant_date` DATE COMMENT 'The date on which the student formally granted FERPA consent to the authorized party. Marks the beginning of the consent period.',
    `consent_language` STRING COMMENT 'ISO 639-3 three-letter language code indicating the language in which the consent was provided and documented. Supports multilingual compliance.. Valid values are `^[A-Z]{3}$`',
    `consent_revocation_date` DATE COMMENT 'The date on which the student formally revoked the FERPA consent authorization. Nullable if consent has not been revoked.',
    `consent_status` STRING COMMENT 'Current lifecycle status of the FERPA consent authorization. Determines whether the consent is currently enforceable for record disclosure.. Valid values are `active|expired|revoked|pending|suspended`',
    `consent_type` STRING COMMENT 'The scope of educational records covered by this consent authorization. Defines which categories of student information may be disclosed to the authorized party.. Valid values are `full_record|financial_only|academic_only|directory_information|grade_only|attendance_only`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this FERPA consent record was first created in the system. Part of the audit trail for compliance tracking.',
    `disclosure_count` STRING COMMENT 'The total number of times educational records have been disclosed to the authorized party under this consent authorization. Supports compliance monitoring.',
    `disclosure_scope_description` STRING COMMENT 'Detailed narrative description of the specific educational records and information categories covered by this consent. Provides additional context beyond the consent_type field.',
    `institutional_policy_version` STRING COMMENT 'Version identifier of the institutions FERPA policy that was in effect when this consent was granted. Supports historical compliance tracking.',
    `last_disclosure_date` DATE COMMENT 'The most recent date on which educational records were disclosed to the authorized party under this consent. Used for audit tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this FERPA consent record was most recently updated in the system. Supports change tracking and audit compliance.',
    `purpose_of_disclosure` STRING COMMENT 'The stated purpose or reason for which the authorized party will use the disclosed educational records. Required for FERPA compliance documentation.',
    `requires_annual_renewal` BOOLEAN COMMENT 'Indicates whether this FERPA consent requires annual renewal by the student. Some institutions require periodic re-authorization for ongoing consents.',
    `revocation_reason` STRING COMMENT 'Narrative explanation provided by the student for revoking the FERPA consent authorization. Nullable if consent has not been revoked.',
    `third_party_redisclosure_allowed` BOOLEAN COMMENT 'Indicates whether the authorized party is permitted to further disclose the educational records to additional third parties. Critical for FERPA compliance.',
    `verification_date` DATE COMMENT 'The date on which the students identity and consent were verified by the institution.',
    `verification_method` STRING COMMENT 'The method by which the students identity and consent authorization were verified. Critical for FERPA compliance audits.. Valid values are `in_person|electronic_signature|notarized|mail|phone|portal`',
    CONSTRAINT pk_ferpa_consent PRIMARY KEY(`ferpa_consent_id`)
) COMMENT 'Manages FERPA (Family Educational Rights and Privacy Act) consent and disclosure authorizations for each student. Captures authorized party name, relationship to student, disclosure scope (full record, financial only, academic only, directory information), consent grant date, consent expiration date, consent revocation date, verification method (in-person, electronic, notarized), and the specific Banner FERPA release codes activated. Supports FERPA compliance audits and third-party record release workflows.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`residency_classification` (
    `residency_classification_id` BIGINT COMMENT 'Unique identifier for the residency classification record. Primary key for this entity.',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: Tuition billing and financial aid packaging require term-specific residency status for rate determination. Effective_term_code insufficient for automated billing integration; FK enables term census da',
    `employee_id` BIGINT COMMENT 'User ID of the registrar staff member or residency officer who performed the residency determination review. Supports accountability and audit trail requirements.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Residency determinations follow state-specific institutional policies. Appeals cite policy version; documentation requirements are policy-driven. Required for residency appeals and tuition classificat',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student to whom this residency classification applies. Links to the student master record in the Student Information System (SIS).',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Residency determinations are governed by state statutes and federal regulations (HEROES Act for military, HEA provisions). residency_classification has policy_id but no FK to regulatory_requirement. A',
    `appeal_decision_date` DATE COMMENT 'Date on which the residency appeal committee or officer rendered a final decision on the students appeal. NULL if appeal is still pending or no appeal was filed.',
    `appeal_decision_rationale` STRING COMMENT 'Textual explanation of the rationale behind the appeal decision, including key factors considered by the review committee. Provides transparency and documentation for audit and compliance purposes.',
    `appeal_status` STRING COMMENT 'Current status of any residency classification appeal filed by the student. Tracks whether the student has contested the initial determination and the outcome of that appeal process.. Valid values are `not_appealed|pending|approved|denied|withdrawn`',
    `appeal_submission_date` DATE COMMENT 'Date on which the student submitted a formal appeal of their residency classification. NULL if no appeal has been filed.',
    `classification_source` STRING COMMENT 'Source or process through which the residency classification was established. Indicates whether the classification originated from the admissions application, a registrar review, a student petition, an appeal decision, or other source.. Valid values are `admissions_application|registrar_review|student_petition|appeal_decision|system_default|data_migration`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this residency classification record was first created in the system. Supports audit trail and data lineage requirements.',
    `determination_date` DATE COMMENT 'Date on which the residency classification was officially determined by the registrar or residency officer. Represents the business event timestamp for this classification decision.',
    `documentation_received_date` DATE COMMENT 'Date on which the residency supporting documentation was received by the registrars office or residency review unit. Used to track processing timelines and compliance with submission deadlines.',
    `documentation_type` STRING COMMENT 'Type of supporting documentation provided by the student to substantiate their residency claim. Common types include drivers license, voter registration, tax returns, lease agreements, utility bills, military orders, or visa/I-20 for international students. [ENUM-REF-CANDIDATE: drivers_license|voter_registration|tax_return|lease_agreement|utility_bill|military_orders|visa_i20|other — 8 candidates stripped; promote to reference product]',
    `domicile_country_code` STRING COMMENT 'Three-letter ISO country code representing the students country of legal domicile. Primarily used for international students to distinguish country of origin for reporting and compliance purposes.. Valid values are `^[A-Z]{3}$`',
    `domicile_state_code` STRING COMMENT 'Two-letter US state code representing the students legal domicile for residency determination purposes. Used to assess eligibility for in-state tuition or reciprocity agreements. NULL for international students.. Valid values are `^[A-Z]{2}$`',
    `duration_of_residency_months` STRING COMMENT 'Number of months the student has maintained continuous legal domicile in the state, as documented and verified during the residency determination process. Used to assess eligibility for in-state status, which typically requires 12 consecutive months of domicile.',
    `expiration_date` DATE COMMENT 'Date on which this residency classification expires and must be re-evaluated. Some institutions require periodic re-verification of residency status, particularly for students claiming in-state status based on recent domicile establishment.',
    `ferpa_restriction_indicator` BOOLEAN COMMENT 'Indicates whether the student has requested FERPA directory information restrictions that limit disclosure of residency classification data. Ensures compliance with student privacy rights under FERPA.',
    `financial_independence_indicator` BOOLEAN COMMENT 'Indicates whether the student has been determined to be financially independent from out-of-state parents or guardians for residency purposes. Financial independence is often a prerequisite for establishing in-state residency for students whose parents reside out of state.',
    `ipeds_residency_code` STRING COMMENT 'Residency classification code mapped to IPEDS reporting categories for federal compliance reporting. IPEDS requires institutions to report enrollment by residency status (in-state, out-of-state, foreign) for fall enrollment surveys.. Valid values are `in_state|out_of_state|foreign`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this residency classification record is currently active and in effect for the student. Only one residency classification per student should be active at any given time. Historical records are retained with is_active set to false.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this residency classification record was most recently updated. Tracks the most recent modification to any field in the record for audit and data quality monitoring purposes.',
    `military_affiliation_type` STRING COMMENT 'Type of military affiliation that may qualify the student for special residency consideration or in-state tuition rates under federal or state veteran education benefits policies. [ENUM-REF-CANDIDATE: active_duty|veteran|reserve|national_guard|dependent|spouse|not_applicable — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text notes or comments recorded by the residency reviewer regarding special circumstances, documentation issues, or other relevant context for the classification decision. Supports case-by-case decision transparency.',
    `policy_version` STRING COMMENT 'Version identifier of the institutional residency policy that was applied to make this classification determination. Ensures traceability and consistency when policies are updated over time.',
    `prior_residency_status` STRING COMMENT 'The students residency classification in the immediately preceding term. Used to track residency status changes over time and to support audit and compliance reporting.. Valid values are `in_state|out_of_state|international|military_dependent|reciprocity_agreement|undetermined`',
    `reciprocity_agreement_code` STRING COMMENT 'Code identifying the interstate reciprocity agreement under which the student qualifies for reduced tuition (e.g., Midwest Student Exchange Program, Academic Common Market, Western Undergraduate Exchange). NULL if no reciprocity agreement applies.',
    `residency_status` STRING COMMENT 'Official residency classification for tuition assessment purposes. Determines whether the student qualifies for in-state, out-of-state, or other special tuition rates. Directly impacts tuition billing and IPEDS residency reporting.. Valid values are `in_state|out_of_state|international|military_dependent|reciprocity_agreement|undetermined`',
    `tuition_rate_category` STRING COMMENT 'Tuition rate category assigned based on the residency classification. Directly drives the tuition rate applied in the student billing system. May differ slightly from residency_status to accommodate special rate programs.. Valid values are `in_state|out_of_state|international|military|reciprocity|special`',
    CONSTRAINT pk_residency_classification PRIMARY KEY(`residency_classification_id`)
) COMMENT 'Stores the official in-state vs. out-of-state residency determination for tuition classification purposes. Captures residency status (in-state, out-of-state, international, military dependent, reciprocity agreement), determination date, effective term, supporting documentation type, domicile state, residency appeal status, appeal decision, and the institutional policy version applied. Directly drives tuition rate assessment in the billing domain and IPEDS residency reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`visa_immigration` (
    `visa_immigration_id` BIGINT COMMENT 'Unique identifier for the visa and immigration record. Primary key for the visa_immigration product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: SEVIS compliance and DHS reporting require tracking which Designated School Official (DSO) is responsible for each international students immigration record. dso_name and dso_email are denormalized; ',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Institutional international student policies (CPT/OPT authorization policy, reduced course load policy, full course of study policy) govern DSO decisions recorded in visa_immigration. visa_immigration',
    `profile_id` BIGINT COMMENT 'Unique identifier of the international student associated with this visa and immigration record. Links to the student master record in the Student Information System (SIS).',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: SEVIS reporting is a federal regulatory requirement under SEVP. Immigration status tracking directly supports compliance with F-1/J-1 visa regulations. Essential for SEVIS batch reporting and complian',
    `authorized_stay_end_date` DATE COMMENT 'The date until which the student is authorized to remain in the United States. For F-1 and J-1 students, this is typically D/S (Duration of Status) which extends through the program end date plus any grace period.',
    `country_of_birth` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code representing the students country of birth. Required for SEVIS reporting and visa applications.. Valid values are `^[A-Z]{3}$`',
    `country_of_citizenship` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code representing the students country of citizenship. This is the country that issued the students passport.. Valid values are `^[A-Z]{3}$`',
    `cpt_authorization_end_date` DATE COMMENT 'The end date of the Curricular Practical Training (CPT) period. Students must cease CPT employment by this date unless a new authorization is granted.',
    `cpt_authorization_start_date` DATE COMMENT 'The start date of the Curricular Practical Training (CPT) period for F-1 students. CPT allows students to engage in internships or employment that is an integral part of their curriculum while enrolled.',
    `cpt_type` STRING COMMENT 'Indicates whether the CPT authorization is for part-time employment (20 hours or less per week) or full-time employment (more than 20 hours per week). Full-time CPT for 12 months or more makes students ineligible for post-completion OPT.. Valid values are `part-time|full-time`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this visa and immigration record was first created in the system. Used for audit trail and data lineage tracking.',
    `ds2019_expiration_date` DATE COMMENT 'The program end date listed on the Form DS-2019, indicating when the exchange visitor is expected to complete their program. J-1 visitors must complete their program by this date or request an extension.',
    `ds2019_issue_date` DATE COMMENT 'The date on which the Certificate of Eligibility for Exchange Visitor Status (Form DS-2019) was issued to the J-1 exchange visitor by the institutions Responsible Officer (RO). Required for J-1 visa holders.',
    `ead_expiration_date` DATE COMMENT 'The date on which the Employment Authorization Document (EAD) expires. Students must cease employment or renew their EAD before this date.',
    `ead_issue_date` DATE COMMENT 'The date on which the Employment Authorization Document (EAD) was issued by USCIS.',
    `ead_number` STRING COMMENT 'The unique number on the Employment Authorization Document (EAD card, Form I-766) issued by USCIS. This card authorizes the student to work in the United States during OPT or other authorized employment periods.',
    `entry_date` DATE COMMENT 'The date on which the student most recently entered the United States. This date is recorded on the Form I-94 Arrival/Departure Record and is critical for calculating authorized stay periods.',
    `full_course_of_study_compliant` BOOLEAN COMMENT 'Boolean flag indicating whether the student is currently enrolled in a full course of study as required by their visa status. F-1 students must be enrolled full-time (typically 12 credit hours for undergraduates, 9 for graduates) to maintain status.',
    `grace_period_end_date` DATE COMMENT 'The date on which the students grace period ends. F-1 students receive a 60-day grace period after program completion or OPT end date. J-1 students receive a 30-day grace period. Students must depart the U.S. or change status by this date.',
    `i20_expiration_date` DATE COMMENT 'The program end date listed on the Form I-20, indicating when the student is expected to complete their academic program. Students must complete their program by this date or request an extension.',
    `i20_issue_date` DATE COMMENT 'The date on which the Certificate of Eligibility for Nonimmigrant Student Status (Form I-20) was issued to the F or M student by the institutions Designated School Official (DSO). Required for F-1 and M-1 visa holders.',
    `i94_number` STRING COMMENT 'The unique 11-digit admission number from the Form I-94 Arrival/Departure Record issued by U.S. Customs and Border Protection upon entry to the United States. This number is used to verify lawful admission and authorized stay.',
    `last_sevis_update_date` TIMESTAMP COMMENT 'The timestamp of the most recent update to the students SEVIS record. SEVIS records must be updated within 21 days of any change in student status, program, or personal information.',
    `next_sevis_report_due_date` DATE COMMENT 'The date by which the next mandatory SEVIS report is due. Schools must report certain events (enrollment verification, program completion, status changes) within specific timeframes to maintain SEVP certification.',
    `off_campus_employment_authorized` BOOLEAN COMMENT 'Boolean flag indicating whether the student is authorized to work off campus through CPT, OPT, severe economic hardship authorization, or other special circumstances.',
    `on_campus_employment_authorized` BOOLEAN COMMENT 'Boolean flag indicating whether the student is authorized to work on campus. F-1 students are generally authorized to work on campus up to 20 hours per week while school is in session and full-time during breaks.',
    `opt_authorization_end_date` DATE COMMENT 'The end date of the Optional Practical Training (OPT) period. Students must cease employment and depart the U.S. or change status by this date unless they have applied for a STEM extension or other status change.',
    `opt_authorization_start_date` DATE COMMENT 'The start date of the Optional Practical Training (OPT) period for F-1 students. OPT allows students to work in their field of study for up to 12 months (or 24 months for STEM extension) after completing their academic program.',
    `opt_type` STRING COMMENT 'The type of OPT authorization. Pre-completion OPT allows students to work part-time while enrolled. Post-completion OPT allows full-time work after graduation. STEM extension provides an additional 24 months for STEM degree holders.. Valid values are `pre-completion|post-completion|stem-extension`',
    `passport_expiration_date` DATE COMMENT 'The expiration date of the students passport. Students must maintain a valid passport (typically valid for at least 6 months into the future) to maintain legal status in the United States.',
    `passport_number` STRING COMMENT 'The passport number from the students valid passport. This field should be encrypted at rest to protect sensitive personal information. Required for SEVIS reporting and visa tracking.',
    `port_of_entry` STRING COMMENT 'The U.S. port of entry (airport, seaport, or land border crossing) through which the student most recently entered the United States. Examples include JFK (New York), LAX (Los Angeles), or ATL (Atlanta).',
    `reduced_course_load_authorized` BOOLEAN COMMENT 'Boolean flag indicating whether the student has been authorized by the Designated School Official (DSO) to take a reduced course load due to academic difficulties, medical reasons, or initial difficulty with English language or reading requirements.',
    `sevis_fee_amount` DECIMAL(18,2) COMMENT 'The amount of the SEVIS I-901 fee paid by the student in U.S. dollars. The fee amount varies by visa type (F/M students pay $350, J exchange visitors pay $220 as of recent rates).',
    `sevis_fee_paid_date` DATE COMMENT 'The date on which the student paid the SEVIS I-901 fee. This fee must be paid before applying for an F, J, or M visa and is required for SEVIS activation.',
    `sevis_number` STRING COMMENT 'The unique SEVIS identification number assigned by the U.S. Department of Homeland Security to track F and M nonimmigrant students and J nonimmigrant exchange visitors. Required for SEVP compliance and DHS reporting.. Valid values are `^N[0-9]{10}$`',
    `sevis_status` STRING COMMENT 'The current status of the student in the SEVIS system. Initial indicates the student has been issued an I-20 or DS-2019 but has not yet entered the U.S. Active indicates the student is enrolled and maintaining status. Completed indicates the student has finished their program.. Valid values are `initial|active|completed|terminated|withdrawn|suspended`',
    `transfer_pending` BOOLEAN COMMENT 'Boolean flag indicating whether the student has a pending SEVIS transfer to another institution. During a transfer, the students SEVIS record is released from the current school to the new school.',
    `transfer_release_date` DATE COMMENT 'The date on which the students SEVIS record was released to another institution for transfer. The student must report to the new school within 15 days of the program start date or the transfer release date, whichever is later.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this visa and immigration record was most recently updated. Used for audit trail and change tracking to ensure data quality and compliance.',
    `visa_expiration_date` DATE COMMENT 'The date on which the visa expires. Note that for F-1 and J-1 visas, students may remain in the U.S. beyond this date as long as they maintain valid status (D/S - Duration of Status).',
    `visa_issue_date` DATE COMMENT 'The date on which the visa was issued by the U.S. consulate or embassy. This is the date stamped on the visa in the students passport.',
    `visa_status` STRING COMMENT 'Current lifecycle status of the visa record. Active indicates the visa is valid and the student is in compliance. Expired indicates the visa has passed its expiration date. Terminated indicates the visa was ended due to program completion or violation.. Valid values are `active|expired|pending|terminated|suspended|withdrawn`',
    `visa_type` STRING COMMENT 'The type of visa held by the international student. F-1 is for academic students, J-1 for exchange visitors, M-1 for vocational students, H-1B for specialty occupation workers, and other categories for dependents and special cases. [ENUM-REF-CANDIDATE: F-1|F-2|J-1|J-2|M-1|M-2|H-1B|H-4|O-1|TN|L-1|B-1|B-2 — 13 candidates stripped; promote to reference product]',
    CONSTRAINT pk_visa_immigration PRIMARY KEY(`visa_immigration_id`)
) COMMENT 'Tracks immigration and visa status for international students, including visa type (F-1, J-1, M-1, H-1B, OPT, CPT), visa issue date, visa expiration date, I-20 or DS-2019 issue date, SEVIS ID, SEVIS status, authorized stay end date, OPT/CPT authorization period, employment authorization document number, country of citizenship, country of birth, passport number (encrypted), and SEVIS reporting compliance flags. Supports SEVP (Student and Exchange Visitor Program) compliance and DHS reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`graduation_application` (
    `graduation_application_id` BIGINT COMMENT 'Unique identifier for the graduation application record. Primary key for the graduation application entity.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Graduation clearance requires verifying the student completed requirements for a specific academic program. The registrar and degree audit staff link each graduation application to the governing progr',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: Degree conferral processing and commencement planning require term linkage for application deadlines, degree audit scheduling, and diploma ordering. Application_term_code alone insufficient for automa',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Graduation approval workflow requires tracking which registrar/advising staff member performed the degree audit. degree_audit_performed_by is a denormalized text field; role-prefix auditing_ disting',
    `campus_id` BIGINT COMMENT 'Foreign key linking to facility.campus. Business justification: Commencement ceremony planning, diploma logistics, and IPEDS graduation reporting require knowing which campus a student is graduating from. Multi-campus institutions run separate ceremonies per campu',
    `concentration_id` BIGINT COMMENT 'Foreign key linking to curriculum.concentration. Business justification: Graduation clearance must verify concentration-specific requirements are satisfied. The registrar links each graduation application to the official curriculum.concentration record to confirm completio',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Graduation applications carry a mandatory application fee (application_fee_amount, application_fee_paid_flag already on the record). Bursar offices generate an AR invoice for this fee; linking the app',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Graduation applications are governed by institutional graduation requirements policy (application deadlines, fee policy, diploma policy). graduation_application has regulatory_requirement_id but no FK',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student submitting the graduation application. Links to the student master record.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Degree conferral reporting to state and federal agencies is regulatory. Graduation data feeds IPEDS Completions survey and state authorization reports. Essential for regulatory filing preparation.',
    `student_term_record_id` BIGINT COMMENT 'Foreign key linking to enrollment.student_term_record. Business justification: Graduation auditors must verify the student_term_record for the application term to confirm enrollment status, credit hours attempted, and SAP compliance before approving a graduation application. Thi',
    `instructor_id` BIGINT COMMENT 'Foreign key linking to faculty.instructor. Business justification: Graduate degree graduation applications require thesis/dissertation advisor certification of completion — a named regulatory and accreditation process. The existing degree_audit_performed_by is a deno',
    `application_approved_date` DATE COMMENT 'Date the graduation application was approved by the registrar or academic dean. Null if not yet approved.',
    `application_fee_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the graduation application fee charged to the student. Null if no fee is charged by the institution.',
    `application_fee_paid_flag` BOOLEAN COMMENT 'Indicates whether the graduation application fee has been paid. True if paid, False if outstanding. Some institutions charge a fee for graduation application processing.',
    `application_number` STRING COMMENT 'Human-readable business identifier for the graduation application, typically displayed on student portals and official communications.',
    `application_status` STRING COMMENT 'Current workflow status of the graduation application. Pending indicates under review, Approved means cleared for degree conferral, Denied indicates requirements not met, Deferred means postponed to future term.. Valid values are `Pending|Approved|Denied|Deferred|Withdrawn|Cancelled`',
    `application_submitted_date` DATE COMMENT 'Date the student submitted the graduation application. Used to track application deadlines and processing timelines.',
    `cip_code` STRING COMMENT 'Six-digit CIP code classifying the field of study for federal IPEDS reporting. Format: XX.XXXX (e.g., 52.0201 for Business Administration).. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `commencement_ceremony_code` STRING COMMENT 'Code identifying the specific commencement ceremony the student will attend (e.g., College of Engineering ceremony, Graduate School ceremony). Null if not participating.',
    `commencement_participation_flag` BOOLEAN COMMENT 'Indicates whether the student intends to participate in the commencement ceremony. True if participating, False if not attending.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the graduation application record was first created in the system. Used for audit trail and data lineage tracking.',
    `degree_audit_date` DATE COMMENT 'Date the final degree audit was completed to verify all graduation requirements were met. Typically performed by the registrars office.',
    `degree_code` STRING COMMENT 'Institutional code representing the specific degree or credential being conferred (e.g., BA, BS, MBA, PhD, AA). Links to the degree catalog.',
    `degree_conferral_date` DATE COMMENT 'Official date the degree was conferred by the institution. This is the graduation date that appears on transcripts and is reported to IPEDS. Null until degree is officially awarded.',
    `degree_level` STRING COMMENT 'Level of degree or credential for which the student is applying (Associate, Bachelor, Master, Doctoral, Certificate, Diploma). Used for IPEDS Completions Survey reporting.. Valid values are `Associate|Bachelor|Master|Doctoral|Certificate|Diploma`',
    `degree_requirements_met_flag` BOOLEAN COMMENT 'Indicates whether all degree requirements have been satisfied (credit hours, GPA, major requirements, general education, residency). True if all requirements met, False if deficiencies exist.',
    `diploma_hold_flag` BOOLEAN COMMENT 'Indicates whether there is a hold preventing diploma release (e.g., outstanding financial obligations, unreturned library materials, conduct sanctions). True if hold exists, False if clear.',
    `diploma_hold_reason` STRING COMMENT 'Description of the reason for the diploma hold (e.g., Outstanding tuition balance, Library fines, Conduct sanction). Null if no hold exists.',
    `diploma_mailed_date` DATE COMMENT 'Date the diploma was mailed to the student. Used for tracking diploma fulfillment and student inquiries. Null until diploma is mailed.',
    `diploma_mailing_address_line1` STRING COMMENT 'First line of the mailing address where the diploma should be sent. Protected under FERPA as student directory information.',
    `diploma_mailing_address_line2` STRING COMMENT 'Second line of the mailing address (apartment, suite, building number). Optional field. Protected under FERPA.',
    `diploma_mailing_city` STRING COMMENT 'City for diploma mailing address. Protected under FERPA as student directory information.',
    `diploma_mailing_country_code` STRING COMMENT 'Three-letter ISO country code for diploma mailing address (e.g., USA, CAN, GBR). Protected under FERPA.. Valid values are `^[A-Z]{3}$`',
    `diploma_mailing_postal_code` STRING COMMENT 'Postal or ZIP code for diploma mailing address. Protected under FERPA as student directory information.',
    `diploma_mailing_state_province` STRING COMMENT 'State or province code for diploma mailing address (e.g., CA, TX, ON). Protected under FERPA.',
    `diploma_name` STRING COMMENT 'Full legal name as it should appear on the printed diploma. May differ from current student name due to name changes or preferred formatting. Protected under FERPA.',
    `diploma_print_date` DATE COMMENT 'Date the physical diploma was printed. Used for tracking diploma production and fulfillment workflows. Null until diploma is printed.',
    `graduation_gpa` DECIMAL(18,2) COMMENT 'Final cumulative GPA at the time of graduation. This is the official GPA that appears on the final transcript and diploma.',
    `honors_gpa` DECIMAL(18,2) COMMENT 'Cumulative GPA used to determine Latin honors eligibility. May differ from overall GPA if institution uses specific calculation rules (e.g., excluding transfer credits).',
    `institutional_credits_earned` DECIMAL(18,2) COMMENT 'Number of credit hours earned at the degree-granting institution (excluding transfer credits). Used for residency requirement verification.',
    `ipeds_reported_flag` BOOLEAN COMMENT 'Indicates whether this degree completion has been reported to IPEDS for the annual Completions Survey. True if reported, False if not yet reported.',
    `ipeds_reporting_year` STRING COMMENT 'Academic year for which this completion was reported to IPEDS (e.g., 2024 for 2023-2024 academic year). Null if not yet reported.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the graduation application record was last updated. Used for audit trail and change tracking.',
    `latin_honors_designation` STRING COMMENT 'Latin honors awarded based on cumulative GPA thresholds (Cum Laude, Magna Cum Laude, Summa Cum Laude). Null if student does not qualify for honors. Appears on diploma and transcript.. Valid values are `Cum Laude|Magna Cum Laude|Summa Cum Laude`',
    `special_recognition` STRING COMMENT 'Additional honors, awards, or recognitions to be noted on the diploma or transcript (e.g., Honors Program Graduate, Phi Beta Kappa, Deans List). Free-text field for institutional flexibility.',
    `total_credits_earned` DECIMAL(18,2) COMMENT 'Total number of credit hours earned by the student at the time of graduation, including transfer credits if applicable. Used to verify degree completion requirements.',
    `transfer_credits_accepted` DECIMAL(18,2) COMMENT 'Number of transfer credit hours accepted toward the degree from other institutions. Used for degree audit and IPEDS reporting.',
    CONSTRAINT pk_graduation_application PRIMARY KEY(`graduation_application_id`)
) COMMENT 'Records a students formal application to graduate, including application term, degree level, degree program, diploma name, diploma mailing address, commencement participation intent, commencement ceremony selection, application status (pending, approved, denied, deferred), degree conferral date, diploma print date, diploma hold flag, and Latin honors designation (cum laude, magna cum laude, summa cum laude). Drives the degree conferral workflow and IPEDS Completions Survey submissions.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`disability_accommodation` (
    `disability_accommodation_id` BIGINT COMMENT 'Unique identifier for the disability accommodation record. Primary key for the disability accommodation entity.',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: ADA accommodation delivery requires term-specific faculty notification and course-level accommodation tracking. Academic_term_code insufficient for automated faculty notification workflows tied to ter',
    `assignment_id` BIGINT COMMENT 'Foreign key linking to instruction.instruction_assignment. Business justification: ADA/Section 504 compliance requires disability services to track extended-time and alternative-format accommodations at the individual assignment level. Faculty notification letters reference specific',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Disability accommodations (interpreters, note-takers, assistive technology) are budgeted and expensed to disability services cost center. Business process: accommodation costs are tracked for budget m',
    `course_id` BIGINT COMMENT 'Reference to a specific course for which the accommodation is being applied. Null if the accommodation applies broadly across all courses rather than to a specific course.',
    `course_section_id` BIGINT COMMENT 'Foreign key linking to instruction.course_section. Business justification: Accommodations are implemented at the section level (extended exam time for specific instructor, note-taker assigned to particular meeting times). Delivery_status and faculty_notification_date fields ',
    `employee_id` BIGINT COMMENT 'Reference to the disability services staff member who approved the accommodation. Links to the staff or employee master record.',
    `instructor_id` BIGINT COMMENT 'Foreign key linking to faculty.instructor. Business justification: ADA/Section 504 compliance requires tracking which instructor received and acknowledged a disability accommodation notification. disability_accommodation already has faculty_notification_date and facu',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Disability accommodations are governed by the institutional ADA/Section 504 accommodation policy. disability_accommodation has regulatory_requirement_id but no FK to compliance.policy. A disability se',
    `profile_id` BIGINT COMMENT 'Reference to the student receiving the disability accommodation. Links to the student master record in the Student Information System (SIS).',
    `registration_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_registration. Business justification: Disability services offices must associate each accommodation with the specific course registration to track delivery status and faculty notification. ADA compliance reporting and accommodation effect',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: ADA Title II and Section 504 accommodations are regulatory requirements. Accommodation eligibility and delivery directly implement federal disability law obligations. Essential for OCR compliance audi',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Accommodations are physically delivered in specific rooms (testing centers, accessible classrooms with assistive technology). Disability services coordinates room assignments for extended-time exams, ',
    `accommodation_detail` STRING COMMENT 'Detailed description of the specific accommodation provided, including any special instructions, equipment requirements, or implementation guidelines for faculty and staff.',
    `accommodation_number` STRING COMMENT 'Business-facing unique identifier or case number assigned to the accommodation by the disability services office for tracking and reference purposes.',
    `accommodation_type` STRING COMMENT 'Primary type of academic accommodation approved for the student. Common types include extended time on exams, reduced distraction testing environment, note-taking assistance, real-time captioning, sign language interpreter, assistive technology, or other specialized accommodations. [ENUM-REF-CANDIDATE: extended_time|reduced_distraction_testing|note_taking_assistance|captioning|interpreter|assistive_technology|other — 7 candidates stripped; promote to reference product]',
    `ada_eligible_flag` BOOLEAN COMMENT 'Indicates whether the student has been determined eligible for accommodations under the Americans with Disabilities Act (ADA) Title II. True if eligible; false otherwise.',
    `approval_date` DATE COMMENT 'Date on which the accommodation was officially approved by the disability services office following review of supporting documentation and eligibility determination.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this accommodation record was first created in the system. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `delivery_status` STRING COMMENT 'Status of accommodation delivery at the course level. Tracks whether the accommodation has been implemented for the student in the specified course. Not started indicates no action taken; in progress indicates implementation underway; delivered indicates full implementation; partially delivered indicates incomplete implementation; not applicable indicates the accommodation does not apply to this course.. Valid values are `not_started|in_progress|delivered|partially_delivered|not_applicable`',
    `disability_accommodation_status` STRING COMMENT 'Current lifecycle status of the accommodation. Active accommodations are in effect; expired accommodations require renewal; suspended accommodations are temporarily on hold; pending review accommodations are under evaluation; revoked accommodations have been withdrawn; inactive accommodations are no longer applicable.. Valid values are `active|expired|suspended|pending_review|revoked|inactive`',
    `disability_category` STRING COMMENT 'Primary category of the documented disability. Classified as physical (mobility, motor), learning (dyslexia, ADHD), psychological (anxiety, depression), chronic health (diabetes, epilepsy), sensory (visual, hearing), or other.. Valid values are `physical|learning|psychological|chronic_health|sensory|other`',
    `disability_description` STRING COMMENT 'Detailed description of the specific disability or condition as documented by the disability services office. May include clinical diagnosis or functional limitations.',
    `documentation_expiration_date` DATE COMMENT 'Date on which the supporting documentation expires and requires updating. Applicable for conditions that may change over time or when institutional policy requires periodic re-evaluation.',
    `documentation_received_date` DATE COMMENT 'Date on which the disability services office received the supporting medical or psychological documentation from the student or healthcare provider.',
    `documentation_status` STRING COMMENT 'Status of the supporting medical or psychological documentation required to substantiate the disability and accommodation request. Complete documentation meets all institutional requirements; incomplete documentation is missing required elements; pending documentation is awaiting submission; expired documentation requires updating; under review documentation is being evaluated by disability services staff.. Valid values are `complete|incomplete|pending|expired|under_review`',
    `effective_date` DATE COMMENT 'Date from which the accommodation becomes active and available for use by the student in academic settings.',
    `eligibility_determination_date` DATE COMMENT 'Date on which the disability services office determined the student eligible for accommodations under ADA Title II and Section 504 regulations.',
    `expiration_date` DATE COMMENT 'Date on which the accommodation expires and requires renewal or re-evaluation. May be null for permanent accommodations or those without a defined end date.',
    `extended_time_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to standard exam time for students approved for extended time accommodations. Common values include 1.5 (time and a half) or 2.0 (double time). Null if extended time is not part of the accommodation.',
    `faculty_acknowledgment_date` DATE COMMENT 'Date on which the faculty member acknowledged receipt and understanding of the accommodation notification. Used to track compliance with accommodation implementation requirements.',
    `faculty_notification_date` DATE COMMENT 'Date on which faculty members were notified of the students approved accommodations. Faculty notification is typically sent by the disability services office at the start of each term or when accommodations are approved.',
    `ferpa_sensitive_flag` BOOLEAN COMMENT 'Indicates whether this accommodation record contains information that requires heightened FERPA protection due to its sensitive nature. True if the record contains sensitive health or disability information requiring restricted access; false otherwise.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this accommodation record is currently active in the system. True if active; false if logically deleted or archived. Used for soft delete functionality and historical record retention.',
    `last_renewal_date` DATE COMMENT 'Date of the most recent renewal or re-evaluation of the accommodation. Used to track renewal history and determine when the next renewal is due.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this accommodation record was last modified or updated in the system. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `next_renewal_due_date` DATE COMMENT 'Date by which the next renewal or re-evaluation of the accommodation must be completed. Calculated based on renewal frequency and last renewal date.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the accommodation, including implementation details, special considerations, student preferences, or coordination requirements. May contain sensitive health information.',
    `renewal_frequency_months` STRING COMMENT 'Number of months between required renewals for accommodations that require periodic re-evaluation. Common values include 12 (annual), 24 (biennial), or 36 (triennial). Null if renewal is not required.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether the accommodation requires periodic renewal or re-evaluation. True if renewal is required; false for permanent or indefinite accommodations.',
    `section_504_eligible_flag` BOOLEAN COMMENT 'Indicates whether the student has been determined eligible for accommodations under Section 504 of the Rehabilitation Act of 1973. True if eligible; false otherwise.',
    `source_system` STRING COMMENT 'Name or identifier of the source system from which this accommodation record originated. Typically the disability services module within the Student Information System (SIS) such as Ellucian Banner or a specialized accommodation management system.',
    CONSTRAINT pk_disability_accommodation PRIMARY KEY(`disability_accommodation_id`)
) COMMENT 'Manages disability-related academic accommodations approved through the institutions disability services office. Captures disability category (physical, learning, psychological, chronic health, sensory), accommodation type (extended time, reduced distraction testing, note-taking assistance, captioning, interpreter, assistive technology), accommodation effective date, accommodation expiration date, supporting documentation status, ADA/Section 504 eligibility determination, course-level accommodation delivery status, and renewal history.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`degree_conferral` (
    `degree_conferral_id` BIGINT COMMENT 'Unique identifier for the degree conferral record. Primary key for this entity. This is the permanent, immutable record of academic credential award once conferred.',
    `academic_program_id` BIGINT COMMENT 'Reference to the academic program from which the degree was conferred. Links to the curriculum domain program catalog.',
    `campus_id` BIGINT COMMENT 'Foreign key linking to facility.campus. Business justification: IPEDS degree completions reporting, accreditation submissions, and official transcript generation require the conferring campus. conferring_college is a plain-text field; a campus_id FK is the normali',
    `concentration_id` BIGINT COMMENT 'Foreign key linking to curriculum.concentration. Business justification: Official degree conferral records must reference the specific concentration completed for diploma printing, transcript notation, and IPEDS completions reporting. The registrar links each conferral to ',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: IPEDS degree completions reporting requires joining degree_conferral to the authoritative term record to obtain the official term dates, IPEDS term type code, and degree conferral date. degree_conferr',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: IPEDS degree completion reporting, accreditation, and institutional research require linking conferred degrees to the specific academic org unit. conferring_college and conferring_department are denor',
    `degree_progress_id` BIGINT COMMENT 'Foreign key linking to student.degree_progress. Business justification: degree_conferral is the culmination of a students degree_progress journey. Linking degree_conferral to the degree_progress record that was completed at conferral creates a direct audit trail from the',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or process that created this record. Used for audit trail and accountability.',
    `graduation_application_id` BIGINT COMMENT 'Foreign key linking to student.graduation_application. Business justification: A degree_conferral is the official outcome of a graduation_application — the conferral record documents that the degree was actually awarded following the application process. Linking degree_conferral',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Degree conferral is governed by institutional degree requirements policy (including posthumous degree policy and diploma hold policy). A registrar must cite the governing policy version at conferral f',
    `profile_id` BIGINT COMMENT 'Reference to the student who received the degree. Links to the student master record in the Student Information System (SIS).',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Degree conferral triggers IPEDS completions reporting (ipeds_reportable_flag, ipeds_submission_date on this product) and gainful employment disclosure requirements. A compliance officer must link each',
    `student_term_record_id` BIGINT COMMENT 'Foreign key linking to enrollment.student_term_record. Business justification: IPEDS degree completions reporting requires linking the degree_conferral record to the student_term_record for the conferral term to validate enrollment status and credit hours at time of degree award',
    `cip_code` STRING COMMENT 'Six-digit CIP code identifying the field of study. Required for IPEDS Completions Survey reporting and federal compliance.. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `commencement_ceremony_date` DATE COMMENT 'Date of the commencement ceremony the student attended or was eligible to attend. May differ from conferral date.',
    `commencement_ceremony_name` STRING COMMENT 'Name or identifier of the specific commencement ceremony (e.g., Spring 2023 Undergraduate Ceremony, College of Engineering Ceremony). Used when multiple ceremonies are held.',
    `commencement_participation_flag` BOOLEAN COMMENT 'Indicates whether the student participated in the commencement ceremony. Used for ceremony planning and alumni engagement.',
    `conferral_academic_year` STRING COMMENT 'Academic year in which the degree was conferred (e.g., 2022-2023). Used for annual reporting and trend analysis.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `conferral_date` DATE COMMENT 'Official date the degree was conferred by the institution. This is the authoritative date that appears on the diploma and transcript. Typically set by the Board of Trustees or Regents.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this degree conferral record was first created in the system. Used for audit trail and data lineage.',
    `degree_audit_date` DATE COMMENT 'Date the degree audit was completed and requirements were verified. Used for compliance tracking and process improvement.',
    `degree_audit_status` STRING COMMENT 'Status of the degree audit process verifying that all degree requirements have been satisfied. Critical gate before conferral approval.. Valid values are `not_started|in_progress|completed|requirements_met|requirements_not_met`',
    `degree_code` STRING COMMENT 'Institutional code representing the degree type. Used for internal classification and reporting.',
    `degree_level` STRING COMMENT 'Level of the degree conferred. Used for IPEDS reporting and institutional analytics.. Valid values are `associate|bachelor|master|doctoral|certificate|post_baccalaureate`',
    `degree_title` STRING COMMENT 'Official title of the degree as it appears on the diploma and transcript (e.g., Bachelor of Science in Computer Science, Master of Business Administration).',
    `degree_type` STRING COMMENT 'Type classification of the degree (e.g., BA, BS, MA, MS, MBA, PhD, EdD, Certificate). Distinguishes between degree variants at the same level.',
    `diploma_hold_flag` BOOLEAN COMMENT 'Indicates whether a hold is preventing diploma release. Holds may be financial, disciplinary, or administrative.',
    `diploma_hold_reason` STRING COMMENT 'Description of the reason for the diploma hold. Used for student communication and hold resolution tracking.',
    `diploma_mail_date` DATE COMMENT 'Date the diploma was mailed to the graduate. Used for tracking fulfillment and resolving delivery inquiries.',
    `diploma_number` STRING COMMENT 'Unique serial number printed on the physical diploma. Used for diploma verification and fraud prevention.',
    `diploma_print_date` DATE COMMENT 'Date the diploma was printed. Used for tracking diploma production timelines and fulfillment metrics.',
    `diploma_status` STRING COMMENT 'Current status of the physical diploma in the production and distribution workflow.. Valid values are `not_printed|printed|mailed|picked_up|held|reissued`',
    `ferpa_directory_hold_flag` BOOLEAN COMMENT 'Indicates whether the student has requested suppression of directory information including degree conferral. Used for FERPA compliance and privacy protection.',
    `gpa_at_conferral` DECIMAL(18,2) COMMENT 'Cumulative GPA at the time of degree conferral. Used to determine honors eligibility and for alumni records.',
    `honors_designation` STRING COMMENT 'Latin honors or institutional honors awarded with the degree based on cumulative GPA (Grade Point Average) or other academic achievement criteria. Appears on diploma and transcript.. Valid values are `summa_cum_laude|magna_cum_laude|cum_laude|honors|high_honors|highest_honors`',
    `institutional_credits_earned` DECIMAL(18,2) COMMENT 'Number of credit hours earned at the conferring institution, excluding transfer credits. Used to verify residency requirements.',
    `ipeds_reportable_flag` BOOLEAN COMMENT 'Indicates whether this degree conferral should be included in the IPEDS Completions Survey. Used for federal reporting compliance.',
    `ipeds_submission_date` DATE COMMENT 'Date this degree conferral record was included in an IPEDS Completions Survey submission. Used for audit trail and compliance verification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this degree conferral record was last updated. Used for audit trail and change tracking.',
    `major` STRING COMMENT 'Primary major or field of study for the degree. May differ from degree title in cases of interdisciplinary programs.',
    `minor` STRING COMMENT 'Secondary field of study or minor completed as part of the degree requirements, if applicable.',
    `notes` STRING COMMENT 'Free-text notes related to the degree conferral. May include special circumstances, exceptions, or administrative annotations.',
    `total_credits_earned` DECIMAL(18,2) COMMENT 'Total number of credit hours earned toward the degree at the time of conferral. Includes transfer credits if applicable.',
    CONSTRAINT pk_degree_conferral PRIMARY KEY(`degree_conferral_id`)
) COMMENT 'Official record of a degree, certificate, or credential lifecycle from application through conferral. Captures graduation application fields (application term, application status, commencement participation intent, commencement ceremony selection, diploma mailing address), degree details (degree type, degree title, CIP code, degree level), conferral fields (conferral date, conferral term, Latin honors awarded, institutional unit), diploma management (diploma number, diploma status, diploma hold flag, print date), and IPEDS Completions Survey submission status. This is the permanent, immutable record of academic credential award once conferred, and the authoritative source for transcript degree notation and commencement processing.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `education_ecm`.`student`.`academic_standing` ADD CONSTRAINT `fk_student_academic_standing_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`degree_progress` ADD CONSTRAINT `fk_student_degree_progress_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ADD CONSTRAINT `fk_student_enrollment_status_academic_standing_id` FOREIGN KEY (`academic_standing_id`) REFERENCES `education_ecm`.`student`.`academic_standing`(`academic_standing_id`);
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ADD CONSTRAINT `fk_student_enrollment_status_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ADD CONSTRAINT `fk_student_enrollment_status_residency_classification_id` FOREIGN KEY (`residency_classification_id`) REFERENCES `education_ecm`.`student`.`residency_classification`(`residency_classification_id`);
ALTER TABLE `education_ecm`.`student`.`academic_history` ADD CONSTRAINT `fk_student_academic_history_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`academic_history` ADD CONSTRAINT `fk_student_academic_history_transfer_credit_id` FOREIGN KEY (`transfer_credit_id`) REFERENCES `education_ecm`.`student`.`transfer_credit`(`transfer_credit_id`);
ALTER TABLE `education_ecm`.`student`.`student_test_score` ADD CONSTRAINT `fk_student_student_test_score_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ADD CONSTRAINT `fk_student_transfer_credit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`hold` ADD CONSTRAINT `fk_student_hold_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ADD CONSTRAINT `fk_student_leave_of_absence_academic_standing_id` FOREIGN KEY (`academic_standing_id`) REFERENCES `education_ecm`.`student`.`academic_standing`(`academic_standing_id`);
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ADD CONSTRAINT `fk_student_leave_of_absence_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ADD CONSTRAINT `fk_student_ferpa_consent_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`residency_classification` ADD CONSTRAINT `fk_student_residency_classification_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ADD CONSTRAINT `fk_student_visa_immigration_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`graduation_application` ADD CONSTRAINT `fk_student_graduation_application_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ADD CONSTRAINT `fk_student_degree_conferral_degree_progress_id` FOREIGN KEY (`degree_progress_id`) REFERENCES `education_ecm`.`student`.`degree_progress`(`degree_progress_id`);
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ADD CONSTRAINT `fk_student_degree_conferral_graduation_application_id` FOREIGN KEY (`graduation_application_id`) REFERENCES `education_ecm`.`student`.`graduation_application`(`graduation_application_id`);
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ADD CONSTRAINT `fk_student_degree_conferral_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= TAGS =========
ALTER SCHEMA `education_ecm`.`student` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `education_ecm`.`student` SET TAGS ('dbx_domain' = 'student');
ALTER TABLE `education_ecm`.`student`.`profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`student`.`profile` SET TAGS ('dbx_subdomain' = 'student_identity');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Profile ID');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `enrollment_applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Applicant Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `academic_standing` SET TAGS ('dbx_business_glossary_term' = 'Academic Standing');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `academic_standing` SET TAGS ('dbx_value_regex' = 'good_standing|academic_warning|academic_probation|academic_suspension|academic_dismissal');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_business_glossary_term' = 'Citizenship Status');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `country_of_citizenship` SET TAGS ('dbx_business_glossary_term' = 'Country of Citizenship');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `country_of_citizenship` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `country_of_citizenship` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status (ADA)');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `disability_status` SET TAGS ('dbx_value_regex' = 'none|documented|self_reported|prefer_not_to_disclose');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `ethnicity_hispanic_latino` SET TAGS ('dbx_business_glossary_term' = 'Hispanic or Latino Ethnicity');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `ethnicity_hispanic_latino` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `ethnicity_hispanic_latino` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `ferpa_consent_third_party` SET TAGS ('dbx_business_glossary_term' = 'FERPA Third-Party Consent');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `ferpa_directory_opt_out` SET TAGS ('dbx_business_glossary_term' = 'FERPA Directory Information Opt-Out');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `first_time_in_any_college` SET TAGS ('dbx_business_glossary_term' = 'First-Time-In-Any-College (FTIAC)');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_business_glossary_term' = 'Gender Identity');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|transgender|prefer_not_to_disclose|other');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `institutional_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Student ID (Banner PIDM)');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `institutional_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `institutional_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Legal First Name');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Middle Name');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `legal_middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 1');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 2');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `mailing_city` SET TAGS ('dbx_business_glossary_term' = 'Mailing City');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `mailing_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `mailing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `mailing_country` SET TAGS ('dbx_business_glossary_term' = 'Mailing Country');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `mailing_country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `mailing_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Postal Code');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Mailing State or Province');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `preferred_first_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred First Name');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `preferred_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `preferred_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `preferred_last_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Last Name');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `preferred_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `preferred_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `pronouns` SET TAGS ('dbx_business_glossary_term' = 'Preferred Pronouns');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `race_american_indian_alaska_native` SET TAGS ('dbx_business_glossary_term' = 'Race: American Indian or Alaska Native');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `race_american_indian_alaska_native` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `race_american_indian_alaska_native` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `race_asian` SET TAGS ('dbx_business_glossary_term' = 'Race: Asian');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `race_asian` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `race_asian` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `race_black_african_american` SET TAGS ('dbx_business_glossary_term' = 'Race: Black or African American');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `race_black_african_american` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `race_black_african_american` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `race_native_hawaiian_pacific_islander` SET TAGS ('dbx_business_glossary_term' = 'Race: Native Hawaiian or Other Pacific Islander');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `race_native_hawaiian_pacific_islander` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `race_native_hawaiian_pacific_islander` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `race_white` SET TAGS ('dbx_business_glossary_term' = 'Race: White');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `race_white` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `race_white` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `ssn` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `ssn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `veteran_status` SET TAGS ('dbx_business_glossary_term' = 'Veteran Status');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `veteran_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `veteran_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `visa_type` SET TAGS ('dbx_business_glossary_term' = 'Visa Type');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `visa_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `visa_type` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`student`.`academic_standing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`student`.`academic_standing` SET TAGS ('dbx_subdomain' = 'academic_progress');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `academic_standing_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Standing ID');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator ID');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term ID');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `student_term_record_id` SET TAGS ('dbx_business_glossary_term' = 'Student Term Record Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `academic_plan_required` SET TAGS ('dbx_business_glossary_term' = 'Academic Plan Required Indicator');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `appeal_decision` SET TAGS ('dbx_business_glossary_term' = 'Satisfactory Academic Progress (SAP) Appeal Decision');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `appeal_decision` SET TAGS ('dbx_value_regex' = 'approved|denied|pending|not_applicable');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Satisfactory Academic Progress (SAP) Appeal Decision Date');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `appeal_submitted` SET TAGS ('dbx_business_glossary_term' = 'Satisfactory Academic Progress (SAP) Appeal Submitted Indicator');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `completion_rate` SET TAGS ('dbx_business_glossary_term' = 'Completion Rate Percentage');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `credits_in_progress` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours In Progress');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `cumulative_credits_attempted` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Credit Hours Attempted');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `cumulative_credits_earned` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Credit Hours Earned');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `cumulative_gpa` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `gpa_threshold_met` SET TAGS ('dbx_business_glossary_term' = 'Grade Point Average (GPA) Threshold Met Indicator');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `institutional_standing` SET TAGS ('dbx_business_glossary_term' = 'Institutional Academic Standing');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `institutional_standing` SET TAGS ('dbx_value_regex' = 'good_standing|academic_probation|academic_suspension|academic_dismissal|deans_list|honors');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `ipeds_reportable` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Reportable Indicator');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `maximum_timeframe_exceeded` SET TAGS ('dbx_business_glossary_term' = 'Maximum Timeframe Exceeded Indicator');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Indicator');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `pace_threshold_met` SET TAGS ('dbx_business_glossary_term' = 'Pace Threshold Met Indicator');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `policy_version` SET TAGS ('dbx_business_glossary_term' = 'Policy Version');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `sap_status` SET TAGS ('dbx_business_glossary_term' = 'Satisfactory Academic Progress (SAP) Status');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `sap_status` SET TAGS ('dbx_value_regex' = 'satisfactory|warning|probation|suspension|reinstated');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `term_credits_attempted` SET TAGS ('dbx_business_glossary_term' = 'Term Credit Hours Attempted');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `term_credits_earned` SET TAGS ('dbx_business_glossary_term' = 'Term Credit Hours Earned');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `term_gpa` SET TAGS ('dbx_business_glossary_term' = 'Term Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `title_iv_eligible` SET TAGS ('dbx_business_glossary_term' = 'Title IV Financial Aid Eligible Indicator');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `transfer_gpa` SET TAGS ('dbx_business_glossary_term' = 'Transfer Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`student`.`degree_progress` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`student`.`degree_progress` SET TAGS ('dbx_subdomain' = 'academic_progress');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `degree_progress_id` SET TAGS ('dbx_business_glossary_term' = 'Degree Progress ID');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program ID');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `concentration_id` SET TAGS ('dbx_business_glossary_term' = 'Concentration Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `student_term_record_id` SET TAGS ('dbx_business_glossary_term' = 'Student Term Record Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `anticipated_graduation_term` SET TAGS ('dbx_business_glossary_term' = 'Anticipated Graduation Term');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `anticipated_graduation_term` SET TAGS ('dbx_value_regex' = '^(Fall|Spring|Summer)sd{4}$');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `catalog_year` SET TAGS ('dbx_business_glossary_term' = 'Catalog Year');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `catalog_year` SET TAGS ('dbx_value_regex' = '^d{4}-d{4}$');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^d{2}.d{4}$');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `credits_completed` SET TAGS ('dbx_business_glossary_term' = 'Credits Completed');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `credits_in_progress` SET TAGS ('dbx_business_glossary_term' = 'Credits In Progress');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `credits_remaining` SET TAGS ('dbx_business_glossary_term' = 'Credits Remaining');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `credits_transferred` SET TAGS ('dbx_business_glossary_term' = 'Credits Transferred');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `credits_waived` SET TAGS ('dbx_business_glossary_term' = 'Credits Waived');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `declaration_date` SET TAGS ('dbx_business_glossary_term' = 'Declaration Date');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `degree_audit_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Degree Audit Run Timestamp');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `degree_level` SET TAGS ('dbx_business_glossary_term' = 'Degree Level');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `degree_level` SET TAGS ('dbx_value_regex' = 'associate|bachelor|master|doctoral|certificate|diploma');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `degree_type` SET TAGS ('dbx_business_glossary_term' = 'Degree Type');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `elective_credits_completed` SET TAGS ('dbx_business_glossary_term' = 'Elective Credits Completed');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `elective_credits_required` SET TAGS ('dbx_business_glossary_term' = 'Elective Credits Required');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `general_education_credits_completed` SET TAGS ('dbx_business_glossary_term' = 'General Education Credits Completed');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `general_education_credits_required` SET TAGS ('dbx_business_glossary_term' = 'General Education Credits Required');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `major_code` SET TAGS ('dbx_business_glossary_term' = 'Major Code');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `major_credits_completed` SET TAGS ('dbx_business_glossary_term' = 'Major Credits Completed');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `major_credits_required` SET TAGS ('dbx_business_glossary_term' = 'Major Credits Required');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `major_name` SET TAGS ('dbx_business_glossary_term' = 'Major Name');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `minimum_gpa_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Grade Point Average (GPA) Required');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `minor_code` SET TAGS ('dbx_business_glossary_term' = 'Minor Code');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `minor_name` SET TAGS ('dbx_business_glossary_term' = 'Minor Name');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `program_gpa` SET TAGS ('dbx_business_glossary_term' = 'Program Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `progress_status` SET TAGS ('dbx_business_glossary_term' = 'Progress Status');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `progress_status` SET TAGS ('dbx_value_regex' = 'on_track|at_risk|behind|completed|withdrawn|suspended');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `residency_credits_completed` SET TAGS ('dbx_business_glossary_term' = 'Residency Credits Completed');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `residency_credits_required` SET TAGS ('dbx_business_glossary_term' = 'Residency Credits Required');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `sap_status` SET TAGS ('dbx_business_glossary_term' = 'Satisfactory Academic Progress (SAP) Status');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `sap_status` SET TAGS ('dbx_value_regex' = 'meeting|warning|suspension|probation');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `scenario_description` SET TAGS ('dbx_business_glossary_term' = 'Scenario Description');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `total_credits_required` SET TAGS ('dbx_business_glossary_term' = 'Total Credits Required');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `what_if_scenario_flag` SET TAGS ('dbx_business_glossary_term' = 'What-If Scenario Flag');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` SET TAGS ('dbx_subdomain' = 'academic_progress');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `enrollment_status_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status ID');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `academic_standing_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Standing Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Primary College Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `residency_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Residency Classification Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `student_term_record_id` SET TAGS ('dbx_business_glossary_term' = 'Student Term Record Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `athlete_indicator` SET TAGS ('dbx_business_glossary_term' = 'Student Athlete Indicator');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `census_date` SET TAGS ('dbx_business_glossary_term' = 'Census Date');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `cohort_year` SET TAGS ('dbx_business_glossary_term' = 'Cohort Year');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `credit_hours_attempted` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR) Attempted');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `credit_hours_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR) Enrolled');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `degree_seeking_indicator` SET TAGS ('dbx_business_glossary_term' = 'Degree-Seeking Indicator');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `enrollment_intensity` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Intensity');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `enrollment_intensity` SET TAGS ('dbx_value_regex' = 'full-time|part-time|less-than-half-time|not-enrolled');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `enrollment_level` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Level');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `enrollment_level` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|doctoral|professional|non-degree|post-baccalaureate');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|withdrawn|completed|leave-of-absence|dismissed|deceased');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `enrollment_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Verification Date');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `expected_graduation_term` SET TAGS ('dbx_business_glossary_term' = 'Expected Graduation Term');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `expected_graduation_term` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `ferpa_directory_hold_indicator` SET TAGS ('dbx_business_glossary_term' = 'FERPA (Family Educational Rights and Privacy Act) Directory Hold Indicator');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `financial_aid_recipient_indicator` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Recipient Indicator');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `fte_value` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Value');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `ftiac_indicator` SET TAGS ('dbx_business_glossary_term' = 'First-Time-In-Any-College (FTIAC) Indicator');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `honors_program_indicator` SET TAGS ('dbx_business_glossary_term' = 'Honors Program Indicator');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `housing_status` SET TAGS ('dbx_business_glossary_term' = 'Housing Status');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `housing_status` SET TAGS ('dbx_value_regex' = 'on-campus|off-campus|commuter|not-applicable');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `instructional_method` SET TAGS ('dbx_business_glossary_term' = 'Instructional Method');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `instructional_method` SET TAGS ('dbx_value_regex' = 'on-campus|online|hybrid|correspondence');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `ipeds_enrollment_category` SET TAGS ('dbx_business_glossary_term' = 'IPEDS (Integrated Postsecondary Education Data System) Enrollment Category');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `ipeds_enrollment_category` SET TAGS ('dbx_value_regex' = 'first-time|transfer|continuing|returning|non-degree');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `last_date_of_attendance` SET TAGS ('dbx_business_glossary_term' = 'Last Date of Attendance (LDA)');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `re_enrollment_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Re-Enrollment Eligibility Status');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `re_enrollment_eligibility` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|conditional|pending-review');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `sap_status` SET TAGS ('dbx_business_glossary_term' = 'Satisfactory Academic Progress (SAP) Status');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `sap_status` SET TAGS ('dbx_value_regex' = 'meeting|warning|suspension|appeal-approved|appeal-denied');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `veteran_status_indicator` SET TAGS ('dbx_business_glossary_term' = 'Veteran Status Indicator');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `withdrawal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason Code');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `withdrawal_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `education_ecm`.`student`.`academic_history` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`student`.`academic_history` SET TAGS ('dbx_subdomain' = 'academic_progress');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `academic_history_id` SET TAGS ('dbx_business_glossary_term' = 'Academic History ID');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course ID');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Section ID');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `final_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Final Grade Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `grade_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Entry Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Instructor ID');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Registration Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `service_learning_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Learning Placement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `student_term_record_id` SET TAGS ('dbx_business_glossary_term' = 'Student Term Record Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Term ID');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `transfer_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Credit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `academic_level` SET TAGS ('dbx_business_glossary_term' = 'Academic Level');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `academic_level` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|professional|doctoral|post_doctoral|continuing_education');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `academic_standing_impact` SET TAGS ('dbx_business_glossary_term' = 'Academic Standing Impact');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `academic_standing_impact` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|probation_trigger|dismissal_trigger');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'completed|incomplete|in_progress|withdrawn|failed|not_started');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `course_delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Course Delivery Mode');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `course_delivery_mode` SET TAGS ('dbx_value_regex' = 'in_person|online|hybrid|blended|synchronous|asynchronous');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `course_level` SET TAGS ('dbx_business_glossary_term' = 'Course Level');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `course_level` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `course_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Course Reference Number (CRN)');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `course_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `course_title` SET TAGS ('dbx_business_glossary_term' = 'Course Title');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `credit_hours_attempted` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR) Attempted');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `credit_hours_earned` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR) Earned');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `degree_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Degree Applicable Flag');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `financial_aid_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Eligible Flag');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `general_education_flag` SET TAGS ('dbx_business_glossary_term' = 'General Education Flag');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `gpa_included_flag` SET TAGS ('dbx_business_glossary_term' = 'GPA (Grade Point Average) Included Flag');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `grade_change_date` SET TAGS ('dbx_business_glossary_term' = 'Grade Change Date');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `grade_change_indicator` SET TAGS ('dbx_business_glossary_term' = 'Grade Change Indicator');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `grade_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Grade Change Reason');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `grade_earned` SET TAGS ('dbx_business_glossary_term' = 'Grade Earned');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `grade_earned` SET TAGS ('dbx_value_regex' = '^[A-F][+-]?|W|I|P|NP|AU|S|U|IP$');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `grade_points` SET TAGS ('dbx_business_glossary_term' = 'Grade Points');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `grade_replacement_flag` SET TAGS ('dbx_business_glossary_term' = 'Grade Replacement Flag');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `grading_mode` SET TAGS ('dbx_business_glossary_term' = 'Grading Mode');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `grading_mode` SET TAGS ('dbx_value_regex' = 'standard|pass_fail|audit|credit_no_credit|satisfactory_unsatisfactory|honors');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `honors_course_flag` SET TAGS ('dbx_business_glossary_term' = 'Honors Course Flag');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `major_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Major Requirement Flag');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `online_course_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Course Flag');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `quality_points` SET TAGS ('dbx_business_glossary_term' = 'Quality Points');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'registered|dropped|withdrawn|completed|in_progress|audit');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `repeat_count` SET TAGS ('dbx_business_glossary_term' = 'Repeat Count');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `repeat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Repeat Indicator');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `source_institution_code` SET TAGS ('dbx_business_glossary_term' = 'Source Institution Code');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `source_institution_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `source_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Source Institution Name');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `subject_code` SET TAGS ('dbx_business_glossary_term' = 'Subject Code');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `subject_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `transcript_display_flag` SET TAGS ('dbx_business_glossary_term' = 'Transcript Display Flag');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `transfer_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Transfer Credit Indicator');
ALTER TABLE `education_ecm`.`student`.`student_test_score` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`student`.`student_test_score` SET TAGS ('dbx_subdomain' = 'academic_progress');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `student_test_score_id` SET TAGS ('dbx_business_glossary_term' = 'Student Test Score Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `enrollment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Received By Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `composite_score` SET TAGS ('dbx_business_glossary_term' = 'Composite Score');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `official_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Official Verification Status');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `official_verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected|not_required');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `percentile_rank` SET TAGS ('dbx_business_glossary_term' = 'Percentile Rank');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|superseded|cancelled|archived');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `score_report_date` SET TAGS ('dbx_business_glossary_term' = 'Score Report Date');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `score_send_date` SET TAGS ('dbx_business_glossary_term' = 'Score Send Date');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `score_source` SET TAGS ('dbx_business_glossary_term' = 'Score Source');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `score_source` SET TAGS ('dbx_value_regex' = 'self_reported|official');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `score_use_purpose` SET TAGS ('dbx_business_glossary_term' = 'Score Use Purpose');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `score_use_purpose` SET TAGS ('dbx_value_regex' = 'admission|placement|scholarship|research');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `score_validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Score Validity End Date');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `section_1_name` SET TAGS ('dbx_business_glossary_term' = 'Section 1 Name');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `section_1_score` SET TAGS ('dbx_business_glossary_term' = 'Section 1 Score');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `section_2_name` SET TAGS ('dbx_business_glossary_term' = 'Section 2 Name');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `section_2_score` SET TAGS ('dbx_business_glossary_term' = 'Section 2 Score');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `section_3_name` SET TAGS ('dbx_business_glossary_term' = 'Section 3 Name');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `section_3_score` SET TAGS ('dbx_business_glossary_term' = 'Section 3 Score');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `section_4_name` SET TAGS ('dbx_business_glossary_term' = 'Section 4 Name');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `section_4_score` SET TAGS ('dbx_business_glossary_term' = 'Section 4 Score');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `superscore_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Superscore Eligible Flag');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `test_administration_code` SET TAGS ('dbx_business_glossary_term' = 'Test Administration Code');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `test_center_code` SET TAGS ('dbx_business_glossary_term' = 'Test Center Code');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `test_center_name` SET TAGS ('dbx_business_glossary_term' = 'Test Center Name');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'SAT|ACT|GRE|GMAT|TOEFL|IELTS');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `test_version` SET TAGS ('dbx_business_glossary_term' = 'Test Version');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `writing_score` SET TAGS ('dbx_business_glossary_term' = 'Writing Score');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` SET TAGS ('dbx_subdomain' = 'academic_progress');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `transfer_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Credit ID');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `articulation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Articulation Agreement ID');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator ID');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Equivalent Course ID');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `transfer_credit_eval_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Credit Eval Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `transfer_equivalency_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Equivalency Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Date');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_appealed|appeal_pending|appeal_approved|appeal_denied');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `applies_to_gpa` SET TAGS ('dbx_business_glossary_term' = 'Applies to Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `applies_to_residency_requirement` SET TAGS ('dbx_business_glossary_term' = 'Applies to Residency Requirement');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `awarded_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Awarded Credit Hours (CR)');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `effective_term_code` SET TAGS ('dbx_business_glossary_term' = 'Effective Term Code');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `equivalent_course_title` SET TAGS ('dbx_business_glossary_term' = 'Equivalent Course Title');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `equivalent_credit_category` SET TAGS ('dbx_business_glossary_term' = 'Equivalent Credit Category');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `equivalent_credit_category` SET TAGS ('dbx_value_regex' = 'major|minor|general_education|elective|prerequisite|free_elective');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|approved|denied|appealed|expired');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Name');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `general_education_area` SET TAGS ('dbx_business_glossary_term' = 'General Education Area');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `maximum_age_policy_applied` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age Policy Applied');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `posted_date` SET TAGS ('dbx_business_glossary_term' = 'Posted Date');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `source_course_number` SET TAGS ('dbx_business_glossary_term' = 'Source Course Number');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `source_course_title` SET TAGS ('dbx_business_glossary_term' = 'Source Course Title');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `source_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Source Credit Hours (CR)');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `source_credit_type` SET TAGS ('dbx_business_glossary_term' = 'Source Credit Type');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `source_credit_type` SET TAGS ('dbx_value_regex' = 'semester|quarter|trimester|other');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `source_grade` SET TAGS ('dbx_business_glossary_term' = 'Source Grade');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `source_institution_fice_code` SET TAGS ('dbx_business_glossary_term' = 'Source Institution Federal Interagency Committee on Education (FICE) Code');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `source_institution_fice_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `source_institution_ipeds_unitid` SET TAGS ('dbx_business_glossary_term' = 'Source Institution Integrated Postsecondary Education Data System (IPEDS) Unit ID');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `source_institution_ipeds_unitid` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `source_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Source Institution Name');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `source_term` SET TAGS ('dbx_business_glossary_term' = 'Source Term');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `transcript_received_date` SET TAGS ('dbx_business_glossary_term' = 'Transcript Received Date');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `transcript_type` SET TAGS ('dbx_business_glossary_term' = 'Transcript Type');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `transcript_type` SET TAGS ('dbx_value_regex' = 'official_paper|official_electronic|unofficial|self_reported');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `transfer_credit_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Credit Type');
ALTER TABLE `education_ecm`.`student`.`hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`student`.`hold` SET TAGS ('dbx_subdomain' = 'academic_progress');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `hold_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `account_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Account Hold Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Placed By Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `registration_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Hold Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `academic_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `amount_owed` SET TAGS ('dbx_business_glossary_term' = 'Amount Owed');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submission Date');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|withdrawn');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `appeal_submitted` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submitted Indicator');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Hold Comments');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `diploma_block` SET TAGS ('dbx_business_glossary_term' = 'Diploma Block Indicator');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `disbursement_block` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Disbursement Block Indicator');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Effective Date');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `enrollment_verification_block` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Verification Block Indicator');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiration Date');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `ferpa_protected` SET TAGS ('dbx_business_glossary_term' = 'Family Educational Rights and Privacy Act (FERPA) Protected Indicator');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `grade_block` SET TAGS ('dbx_business_glossary_term' = 'Grade Access Block Indicator');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `hold_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Code');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `hold_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|released|expired|pending|suspended');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `ipeds_reportable` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Reportable Indicator');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|mail|portal|phone|sms|none');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Indicator');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `override_allowed` SET TAGS ('dbx_business_glossary_term' = 'Override Allowed Indicator');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `override_authority` SET TAGS ('dbx_business_glossary_term' = 'Override Authority');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `placed_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Placed Date');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Hold Priority Level');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Description');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `registration_block` SET TAGS ('dbx_business_glossary_term' = 'Registration Block Indicator');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `release_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Reason');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `released_by` SET TAGS ('dbx_business_glossary_term' = 'Hold Released By User');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `released_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Released Date');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `system_generated` SET TAGS ('dbx_business_glossary_term' = 'System Generated Indicator');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Term Code');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `term_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `transcript_block` SET TAGS ('dbx_business_glossary_term' = 'Transcript Block Indicator');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` SET TAGS ('dbx_subdomain' = 'academic_progress');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `leave_of_absence_id` SET TAGS ('dbx_business_glossary_term' = 'Leave of Absence (LOA) Identifier');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `academic_standing_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Standing Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Start Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `student_term_record_id` SET TAGS ('dbx_business_glossary_term' = 'Student Term Record Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Tuition Refund Ar Invoice Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `actual_return_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return Date');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `advisor_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Academic Advisor Notified Flag');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Approval Date');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority Name');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Leave Comments');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `credits_earned_at_leave` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR) Earned at Leave');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `degree_timeline_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Degree Timeline Impact Days');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `enrollment_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Hold Flag');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `expected_return_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Return Date');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `expected_return_term` SET TAGS ('dbx_business_glossary_term' = 'Expected Return Term Code');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `financial_aid_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Impact Flag');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `gpa_at_leave` SET TAGS ('dbx_business_glossary_term' = 'Grade Point Average (GPA) at Leave');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `housing_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Housing Contract Status');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `housing_contract_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|not_applicable');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `ipeds_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Reportable Flag');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `leave_end_date` SET TAGS ('dbx_business_glossary_term' = 'Leave End Date');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `leave_start_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Start Date');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `leave_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Status');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `leave_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|active|returned|withdrawn');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `leave_type` SET TAGS ('dbx_value_regex' = 'medical|personal|military|parental|research|academic');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `meal_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Meal Plan Status');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `meal_plan_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|not_applicable');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `re_enrollment_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Re-Enrollment Confirmed Flag');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `re_enrollment_term` SET TAGS ('dbx_business_glossary_term' = 'Re-Enrollment Term Code');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Leave Reason Description');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `reason_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Date');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `return_conditions` SET TAGS ('dbx_business_glossary_term' = 'Return Conditions');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `sap_clock_stopped_flag` SET TAGS ('dbx_business_glossary_term' = 'Satisfactory Academic Progress (SAP) Clock Stopped Flag');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `supporting_documentation_flag` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Flag');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `title_iv_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Title IV Compliant Flag');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `tuition_refund_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Tuition Refund Eligibility Flag');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `tuition_refund_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tuition Refund Percentage');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` SET TAGS ('dbx_subdomain' = 'student_identity');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `ferpa_consent_id` SET TAGS ('dbx_business_glossary_term' = 'FERPA (Family Educational Rights and Privacy Act) Consent ID');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized By Staff ID');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `authorized_by_staff_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized By Staff Name');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `authorized_party_email` SET TAGS ('dbx_business_glossary_term' = 'Authorized Party Email Address');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `authorized_party_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `authorized_party_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `authorized_party_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `authorized_party_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Party Name');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `authorized_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `authorized_party_phone` SET TAGS ('dbx_business_glossary_term' = 'Authorized Party Phone Number');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `authorized_party_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `authorized_party_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `authorized_party_relationship` SET TAGS ('dbx_business_glossary_term' = 'Authorized Party Relationship');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `banner_release_code` SET TAGS ('dbx_business_glossary_term' = 'Ellucian Banner FERPA Release Code');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `consent_document_url` SET TAGS ('dbx_business_glossary_term' = 'Consent Document URL');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `consent_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `consent_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Effective Date');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `consent_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiration Date');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `consent_grant_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Grant Date');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language Code');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `consent_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `consent_revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Revocation Date');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'FERPA Consent Status');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'active|expired|revoked|pending|suspended');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'FERPA Consent Type');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'full_record|financial_only|academic_only|directory_information|grade_only|attendance_only');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `disclosure_count` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Count');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `disclosure_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Scope Description');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `institutional_policy_version` SET TAGS ('dbx_business_glossary_term' = 'Institutional FERPA Policy Version');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `last_disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Last Disclosure Date');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `purpose_of_disclosure` SET TAGS ('dbx_business_glossary_term' = 'Purpose of Disclosure');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `requires_annual_renewal` SET TAGS ('dbx_business_glossary_term' = 'Requires Annual Renewal Flag');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `third_party_redisclosure_allowed` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Redisclosure Allowed Flag');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Verification Date');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Verification Method');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'in_person|electronic_signature|notarized|mail|phone|portal');
ALTER TABLE `education_ecm`.`student`.`residency_classification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`student`.`residency_classification` SET TAGS ('dbx_subdomain' = 'student_identity');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `residency_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Residency Classification ID');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Effective Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer User ID');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `appeal_decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Rationale');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_appealed|pending|approved|denied|withdrawn');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `appeal_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submission Date');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `classification_source` SET TAGS ('dbx_business_glossary_term' = 'Classification Source');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `classification_source` SET TAGS ('dbx_value_regex' = 'admissions_application|registrar_review|student_petition|appeal_decision|system_default|data_migration');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `determination_date` SET TAGS ('dbx_business_glossary_term' = 'Determination Date');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `documentation_received_date` SET TAGS ('dbx_business_glossary_term' = 'Documentation Received Date');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `documentation_type` SET TAGS ('dbx_business_glossary_term' = 'Documentation Type');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `domicile_country_code` SET TAGS ('dbx_business_glossary_term' = 'Domicile Country Code');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `domicile_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `domicile_state_code` SET TAGS ('dbx_business_glossary_term' = 'Domicile State Code');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `domicile_state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `duration_of_residency_months` SET TAGS ('dbx_business_glossary_term' = 'Duration of Residency (Months)');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `ferpa_restriction_indicator` SET TAGS ('dbx_business_glossary_term' = 'FERPA (Family Educational Rights and Privacy Act) Restriction Indicator');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `financial_independence_indicator` SET TAGS ('dbx_business_glossary_term' = 'Financial Independence Indicator');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `ipeds_residency_code` SET TAGS ('dbx_business_glossary_term' = 'IPEDS (Integrated Postsecondary Education Data System) Residency Code');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `ipeds_residency_code` SET TAGS ('dbx_value_regex' = 'in_state|out_of_state|foreign');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `military_affiliation_type` SET TAGS ('dbx_business_glossary_term' = 'Military Affiliation Type');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `policy_version` SET TAGS ('dbx_business_glossary_term' = 'Policy Version');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `prior_residency_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Residency Status');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `prior_residency_status` SET TAGS ('dbx_value_regex' = 'in_state|out_of_state|international|military_dependent|reciprocity_agreement|undetermined');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `reciprocity_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Reciprocity Agreement Code');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `residency_status` SET TAGS ('dbx_business_glossary_term' = 'Residency Status');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `residency_status` SET TAGS ('dbx_value_regex' = 'in_state|out_of_state|international|military_dependent|reciprocity_agreement|undetermined');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `tuition_rate_category` SET TAGS ('dbx_business_glossary_term' = 'Tuition Rate Category');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `tuition_rate_category` SET TAGS ('dbx_value_regex' = 'in_state|out_of_state|international|military|reciprocity|special');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` SET TAGS ('dbx_subdomain' = 'student_identity');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `visa_immigration_id` SET TAGS ('dbx_business_glossary_term' = 'Visa Immigration Record ID');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Dso Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `authorized_stay_end_date` SET TAGS ('dbx_business_glossary_term' = 'Authorized Stay End Date');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `country_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Country of Birth');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `country_of_birth` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `country_of_citizenship` SET TAGS ('dbx_business_glossary_term' = 'Country of Citizenship');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `country_of_citizenship` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `country_of_citizenship` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `country_of_citizenship` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `cpt_authorization_end_date` SET TAGS ('dbx_business_glossary_term' = 'Curricular Practical Training (CPT) Authorization End Date');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `cpt_authorization_start_date` SET TAGS ('dbx_business_glossary_term' = 'Curricular Practical Training (CPT) Authorization Start Date');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `cpt_type` SET TAGS ('dbx_business_glossary_term' = 'Curricular Practical Training (CPT) Type');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `cpt_type` SET TAGS ('dbx_value_regex' = 'part-time|full-time');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `ds2019_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Form DS-2019 Program End Date');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `ds2019_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Form DS-2019 Issue Date');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `ead_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Employment Authorization Document (EAD) Expiration Date');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `ead_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Employment Authorization Document (EAD) Issue Date');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `ead_number` SET TAGS ('dbx_business_glossary_term' = 'Employment Authorization Document (EAD) Number');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `ead_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `ead_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'U.S. Entry Date');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `full_course_of_study_compliant` SET TAGS ('dbx_business_glossary_term' = 'Full Course of Study Compliance Flag');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `grace_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Grace Period End Date');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `i20_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Form I-20 Program End Date');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `i20_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Form I-20 Issue Date');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `i94_number` SET TAGS ('dbx_business_glossary_term' = 'Form I-94 Admission Number');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `i94_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `i94_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `last_sevis_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last SEVIS Update Timestamp');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `next_sevis_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next SEVIS Report Due Date');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `off_campus_employment_authorized` SET TAGS ('dbx_business_glossary_term' = 'Off-Campus Employment Authorization Flag');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `on_campus_employment_authorized` SET TAGS ('dbx_business_glossary_term' = 'On-Campus Employment Authorization Flag');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `opt_authorization_end_date` SET TAGS ('dbx_business_glossary_term' = 'Optional Practical Training (OPT) Authorization End Date');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `opt_authorization_start_date` SET TAGS ('dbx_business_glossary_term' = 'Optional Practical Training (OPT) Authorization Start Date');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `opt_type` SET TAGS ('dbx_business_glossary_term' = 'Optional Practical Training (OPT) Type');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `opt_type` SET TAGS ('dbx_value_regex' = 'pre-completion|post-completion|stem-extension');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `passport_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Passport Expiration Date');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `passport_expiration_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `passport_expiration_date` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `passport_number` SET TAGS ('dbx_business_glossary_term' = 'Passport Number');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `passport_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `passport_number` SET TAGS ('dbx_pii_passport' = 'true');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `port_of_entry` SET TAGS ('dbx_business_glossary_term' = 'Port of Entry');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `reduced_course_load_authorized` SET TAGS ('dbx_business_glossary_term' = 'Reduced Course Load Authorization Flag');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `sevis_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'SEVIS Fee Amount');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `sevis_fee_paid_date` SET TAGS ('dbx_business_glossary_term' = 'SEVIS Fee Payment Date');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `sevis_number` SET TAGS ('dbx_business_glossary_term' = 'Student and Exchange Visitor Information System (SEVIS) ID');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `sevis_number` SET TAGS ('dbx_value_regex' = '^N[0-9]{10}$');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `sevis_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `sevis_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `sevis_status` SET TAGS ('dbx_business_glossary_term' = 'SEVIS Status');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `sevis_status` SET TAGS ('dbx_value_regex' = 'initial|active|completed|terminated|withdrawn|suspended');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `transfer_pending` SET TAGS ('dbx_business_glossary_term' = 'SEVIS Transfer Pending Flag');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `transfer_release_date` SET TAGS ('dbx_business_glossary_term' = 'SEVIS Transfer Release Date');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `visa_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Visa Expiration Date');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `visa_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Visa Issue Date');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `visa_status` SET TAGS ('dbx_business_glossary_term' = 'Visa Status');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `visa_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending|terminated|suspended|withdrawn');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `visa_type` SET TAGS ('dbx_business_glossary_term' = 'Visa Type');
ALTER TABLE `education_ecm`.`student`.`graduation_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`student`.`graduation_application` SET TAGS ('dbx_subdomain' = 'degree_conferral');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `graduation_application_id` SET TAGS ('dbx_business_glossary_term' = 'Graduation Application ID');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Application Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditing Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `concentration_id` SET TAGS ('dbx_business_glossary_term' = 'Concentration Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Graduation Ar Invoice Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `student_term_record_id` SET TAGS ('dbx_business_glossary_term' = 'Student Term Record Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Thesis Advisor Instructor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `application_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Application Approved Date');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `application_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Application Fee Amount');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `application_fee_paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Application Fee Paid Flag');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Graduation Application Number');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Graduation Application Status');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `application_status` SET TAGS ('dbx_value_regex' = 'Pending|Approved|Denied|Deferred|Withdrawn|Cancelled');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `application_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submitted Date');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `commencement_ceremony_code` SET TAGS ('dbx_business_glossary_term' = 'Commencement Ceremony Code');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `commencement_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Commencement Participation Flag');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `degree_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Degree Audit Date');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `degree_code` SET TAGS ('dbx_business_glossary_term' = 'Degree Code');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `degree_conferral_date` SET TAGS ('dbx_business_glossary_term' = 'Degree Conferral Date');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `degree_level` SET TAGS ('dbx_business_glossary_term' = 'Degree Level');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `degree_level` SET TAGS ('dbx_value_regex' = 'Associate|Bachelor|Master|Doctoral|Certificate|Diploma');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `degree_requirements_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Degree Requirements Met Flag');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Diploma Hold Flag');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Diploma Hold Reason');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_mailed_date` SET TAGS ('dbx_business_glossary_term' = 'Diploma Mailed Date');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_mailing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Diploma Mailing Address Line 1');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_mailing_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_mailing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_mailing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Diploma Mailing Address Line 2');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_mailing_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_mailing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_mailing_city` SET TAGS ('dbx_business_glossary_term' = 'Diploma Mailing City');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_mailing_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_mailing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_mailing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Diploma Mailing Country Code');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_mailing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_mailing_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_mailing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_mailing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Diploma Mailing Postal Code');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_mailing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_mailing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_mailing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Diploma Mailing State or Province');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_mailing_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_mailing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_name` SET TAGS ('dbx_business_glossary_term' = 'Diploma Name');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `diploma_print_date` SET TAGS ('dbx_business_glossary_term' = 'Diploma Print Date');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `graduation_gpa` SET TAGS ('dbx_business_glossary_term' = 'Graduation Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `honors_gpa` SET TAGS ('dbx_business_glossary_term' = 'Honors Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `institutional_credits_earned` SET TAGS ('dbx_business_glossary_term' = 'Institutional Credits Earned');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `ipeds_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'IPEDS (Integrated Postsecondary Education Data System) Reported Flag');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `ipeds_reporting_year` SET TAGS ('dbx_business_glossary_term' = 'IPEDS (Integrated Postsecondary Education Data System) Reporting Year');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `latin_honors_designation` SET TAGS ('dbx_business_glossary_term' = 'Latin Honors Designation');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `latin_honors_designation` SET TAGS ('dbx_value_regex' = 'Cum Laude|Magna Cum Laude|Summa Cum Laude');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `special_recognition` SET TAGS ('dbx_business_glossary_term' = 'Special Recognition');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `total_credits_earned` SET TAGS ('dbx_business_glossary_term' = 'Total Credits Earned');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `transfer_credits_accepted` SET TAGS ('dbx_business_glossary_term' = 'Transfer Credits Accepted');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` SET TAGS ('dbx_subdomain' = 'student_identity');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `disability_accommodation_id` SET TAGS ('dbx_business_glossary_term' = 'Disability Accommodation Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `disability_accommodation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `disability_accommodation_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Instruction Assignment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Instructor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Registration Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `accommodation_detail` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Detail');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `accommodation_number` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Number');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `accommodation_type` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Type');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `ada_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Eligible Flag');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Approval Date');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Delivery Status');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|delivered|partially_delivered|not_applicable');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `disability_accommodation_status` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Status');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `disability_accommodation_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|pending_review|revoked|inactive');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `disability_accommodation_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `disability_accommodation_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `disability_category` SET TAGS ('dbx_business_glossary_term' = 'Disability Category');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `disability_category` SET TAGS ('dbx_value_regex' = 'physical|learning|psychological|chronic_health|sensory|other');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `disability_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `disability_category` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `disability_description` SET TAGS ('dbx_business_glossary_term' = 'Disability Description');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `disability_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `disability_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `documentation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Documentation Expiration Date');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `documentation_received_date` SET TAGS ('dbx_business_glossary_term' = 'Documentation Received Date');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `documentation_status` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Status');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `documentation_status` SET TAGS ('dbx_value_regex' = 'complete|incomplete|pending|expired|under_review');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Effective Date');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `eligibility_determination_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Determination Date');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Expiration Date');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `extended_time_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Extended Time Multiplier');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `faculty_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Faculty Acknowledgment Date');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `faculty_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Faculty Notification Date');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `ferpa_sensitive_flag` SET TAGS ('dbx_business_glossary_term' = 'Family Educational Rights and Privacy Act (FERPA) Sensitive Flag');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `next_renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Due Date');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Notes');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency in Months');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `section_504_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Section 504 Eligible Flag');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` SET TAGS ('dbx_subdomain' = 'degree_conferral');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `degree_conferral_id` SET TAGS ('dbx_business_glossary_term' = 'Degree Conferral Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `concentration_id` SET TAGS ('dbx_business_glossary_term' = 'Concentration Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Conferral Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Conferring Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `degree_progress_id` SET TAGS ('dbx_business_glossary_term' = 'Degree Progress Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `graduation_application_id` SET TAGS ('dbx_business_glossary_term' = 'Graduation Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `student_term_record_id` SET TAGS ('dbx_business_glossary_term' = 'Student Term Record Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `commencement_ceremony_date` SET TAGS ('dbx_business_glossary_term' = 'Commencement Ceremony Date');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `commencement_ceremony_name` SET TAGS ('dbx_business_glossary_term' = 'Commencement Ceremony Name');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `commencement_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Commencement Participation Flag');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `conferral_academic_year` SET TAGS ('dbx_business_glossary_term' = 'Conferral Academic Year');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `conferral_academic_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `conferral_date` SET TAGS ('dbx_business_glossary_term' = 'Degree Conferral Date');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `degree_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Degree Audit Completion Date');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `degree_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Degree Audit Status');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `degree_audit_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|requirements_met|requirements_not_met');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `degree_code` SET TAGS ('dbx_business_glossary_term' = 'Degree Code');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `degree_level` SET TAGS ('dbx_business_glossary_term' = 'Degree Level');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `degree_level` SET TAGS ('dbx_value_regex' = 'associate|bachelor|master|doctoral|certificate|post_baccalaureate');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `degree_title` SET TAGS ('dbx_business_glossary_term' = 'Degree Title');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `degree_type` SET TAGS ('dbx_business_glossary_term' = 'Degree Type');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `diploma_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Diploma Hold Flag');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `diploma_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Diploma Hold Reason');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `diploma_mail_date` SET TAGS ('dbx_business_glossary_term' = 'Diploma Mail Date');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `diploma_number` SET TAGS ('dbx_business_glossary_term' = 'Diploma Number');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `diploma_print_date` SET TAGS ('dbx_business_glossary_term' = 'Diploma Print Date');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `diploma_status` SET TAGS ('dbx_business_glossary_term' = 'Diploma Status');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `diploma_status` SET TAGS ('dbx_value_regex' = 'not_printed|printed|mailed|picked_up|held|reissued');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `ferpa_directory_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Family Educational Rights and Privacy Act (FERPA) Directory Hold Flag');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `gpa_at_conferral` SET TAGS ('dbx_business_glossary_term' = 'Grade Point Average (GPA) at Conferral');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `honors_designation` SET TAGS ('dbx_business_glossary_term' = 'Latin Honors Designation');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `honors_designation` SET TAGS ('dbx_value_regex' = 'summa_cum_laude|magna_cum_laude|cum_laude|honors|high_honors|highest_honors');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `institutional_credits_earned` SET TAGS ('dbx_business_glossary_term' = 'Institutional Credit Hours (CR) Earned');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `ipeds_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Reportable Flag');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `ipeds_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Submission Date');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `major` SET TAGS ('dbx_business_glossary_term' = 'Major Field of Study');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `minor` SET TAGS ('dbx_business_glossary_term' = 'Minor Field of Study');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Conferral Notes');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `total_credits_earned` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Hours (CR) Earned');
