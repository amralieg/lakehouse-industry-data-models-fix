-- Schema for Domain: student | Business: Education | Version: v1_ecm
-- Generated on: 2026-05-06 12:28:03

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `education_ecm`.`student` COMMENT 'Single source of truth for all student identity, demographics, academic standing, enrollment status, degree progress, academic history, and FERPA-protected records. Manages the student lifecycle from prospect through alumnus, supporting GPA calculations, SAP status, IPEDS reporting, Title IV compliance, and SIS integration with Ellucian Banner.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `education_ecm`.`student`.`profile` (
    `profile_id` BIGINT COMMENT 'Unique identifier for the student profile record. Primary key for the student profile entity.',
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
    `policy_id` BIGINT COMMENT 'Identifier of the academic improvement plan assigned to the student, if applicable. Links to the academic plan document or record detailing required actions, milestones, and support services.',
    `term_id` BIGINT COMMENT 'Identifier of the academic term for which this standing evaluation was performed. Links to the term reference table.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student being evaluated for academic standing. Links to the student master record in the Student Information System (SIS).',
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
    `accreditation_review_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_review. Business justification: Program-level degree audits support accreditation evidence. Accreditors require demonstration of degree requirement enforcement and student progress monitoring. Essential for accreditation self-study ',
    `profile_id` BIGINT COMMENT 'Unique identifier for the student whose degree progress is being tracked. Links to the student master record.',
    `anticipated_graduation_term` STRING COMMENT 'The academic term in which the student is expected to complete all degree requirements and graduate (e.g., Spring 2025).. Valid values are `^(Fall|Spring|Summer)sd{4}$`',
    `audit_notes` STRING COMMENT 'Free-text notes or comments from the degree audit system regarding exceptions, substitutions, or special conditions affecting degree progress.',
    `catalog_year` STRING COMMENT 'The academic catalog year under which the student is pursuing the degree (e.g., 2023-2024). Determines the set of degree requirements applicable to the student.. Valid values are `^d{4}-d{4}$`',
    `cip_code` STRING COMMENT 'The six-digit CIP code that classifies the instructional program according to the National Center for Education Statistics taxonomy (e.g., 11.0701 for Computer Science).. Valid values are `^d{2}.d{4}$`',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of degree requirements completed, calculated as (credits completed + transferred + waived) / total credits required * 100.',
    `concentration_code` STRING COMMENT 'The institutional code for the students declared concentration or specialization within the major, if applicable.',
    `concentration_name` STRING COMMENT 'The full name of the students declared concentration or specialization (e.g., Data Science, Finance), if applicable.',
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
    `graduation_application_date` DATE COMMENT 'The date on which the student submitted their application for graduation.',
    `graduation_application_status` STRING COMMENT 'Current status of the students application for graduation. Indicates whether the student has applied, been approved, denied, or had the degree conferred.. Valid values are `not_applied|applied|approved|denied|conferred`',
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
    `campus_id` BIGINT COMMENT 'Foreign key linking to facility.campus. Business justification: Primary campus enrollment drives IPEDS reporting, tuition residency determination, student services allocation, and facilities capacity planning. Normalizes primary_campus_code text field to structu',
    `profile_id` BIGINT COMMENT 'Unique identifier for the student. Links to the student master record in the Student Information System (SIS).',
    `academic_standing` STRING COMMENT 'Students academic standing status at the beginning of this term. Determines enrollment eligibility and academic intervention requirements.. Valid values are `good-standing|probation|suspension|dismissal|warning`',
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
    `primary_college_code` STRING COMMENT 'Code identifying the primary academic college or school in which the student is enrolled. Used for college-level enrollment reporting and resource allocation.. Valid values are `^[A-Z0-9]{2,6}$`',
    `primary_major_code` STRING COMMENT 'Institutional code for the students primary declared major or program of study for this term. Maps to CIP code for federal reporting.. Valid values are `^[A-Z0-9]{2,10}$`',
    `re_enrollment_eligibility` STRING COMMENT 'Indicates whether the student is eligible to re-enroll in a future term based on academic standing, conduct status, and financial obligations.. Valid values are `eligible|ineligible|conditional|pending-review`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment status record was first created in the Student Information System. Used for audit trail and data lineage tracking.',
    `record_updated_by` STRING COMMENT 'User ID or system identifier of the person or process that last updated this enrollment status record. Used for audit trail and accountability.. Valid values are `^[A-Za-z0-9._-]{1,50}$`',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment status record was last modified. Used for change tracking and data synchronization with downstream systems.',
    `residency_status` STRING COMMENT 'Students residency classification for tuition and fee assessment purposes. Determines in-state vs out-of-state tuition rates.. Valid values are `in-state|out-of-state|international|reciprocity`',
    `sap_status` STRING COMMENT 'Students SAP status for Title IV financial aid eligibility. Evaluated based on GPA, completion rate, and maximum timeframe standards.. Valid values are `meeting|warning|suspension|appeal-approved|appeal-denied`',
    `term_code` STRING COMMENT 'Six-digit code identifying the academic term (e.g., 202401 for Spring 2024). Format: YYYYTT where YYYY is year and TT is term sequence.. Valid values are `^[0-9]{6}$`',
    `veteran_status_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the student is a military veteran or active duty service member. Used for veteran services and GI Bill administration.',
    `withdrawal_date` DATE COMMENT 'Date the student officially withdrew from all courses in this term. Triggers Title IV Return of Funds calculation and impacts academic standing.',
    `withdrawal_reason_code` STRING COMMENT 'Institutional code indicating the reason for student withdrawal. Used for retention analysis and intervention program design.. Valid values are `^[A-Z0-9]{2,6}$`',
    CONSTRAINT pk_enrollment_status PRIMARY KEY(`enrollment_status_id`)
) COMMENT 'Authoritative record of a students enrollment status for each academic term. Captures full-time/part-time classification, FTE value, enrollment level (undergraduate, graduate, doctoral, professional, non-degree), primary campus, instructional method (on-campus, online, hybrid), enrollment date, last date of attendance, withdrawal date, withdrawal reason code, re-enrollment eligibility, and IPEDS enrollment category. One record per student per term. This is the SSOT for enrollment headcount and FTE reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`academic_history` (
    `academic_history_id` BIGINT COMMENT 'Unique identifier for each academic history record. Primary key for the academic history product.',
    `accreditation_standard_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_standard. Business justification: Course-level outcomes and grade distributions are accreditation evidence. Accreditation standards require evidence of learning outcomes assessment at course level. Essential for accreditation standard',
    `course_id` BIGINT COMMENT 'Unique identifier for the course taken. Links to the course catalog master record.',
    `course_section_id` BIGINT COMMENT 'Identifier for the specific section of the course in which the student was enrolled.',
    `instructor_id` BIGINT COMMENT 'Unique identifier for the instructor of record who taught this section. Links to the faculty master record.',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to technology.it_asset. Business justification: Tracks which lab computer, assistive device, or proctoring workstation was used for course delivery. Essential for IT asset utilization reporting, maintenance scheduling tied to academic calendar, and',
    `profile_id` BIGINT COMMENT 'Unique identifier for the student to whom this academic history record belongs. Links to the student master record.',
    `irb_protocol_id` BIGINT COMMENT 'Foreign key linking to research.irb_protocol. Business justification: Students in research methods courses, clinical practicums, or psychology labs often participate as subjects or researchers under specific IRB protocols; required for human subjects compliance tracking',
    `principal_investigator_id` BIGINT COMMENT 'Foreign key linking to research.principal_investigator. Business justification: Faculty who teach courses are often PIs; linking course instructor to PI record enables analysis of research productivity by teaching load, required for faculty workload planning and tenure review pro',
    `term_id` BIGINT COMMENT 'Identifier for the academic term in which the course was taken (e.g., Fall 2023, Spring 2024).',
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
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Test score reporting for admissions transparency is regulatory under state authorization and accreditation. Test score policies must comply with state disclosure requirements. Essential for state auth',
    `composite_score` STRING COMMENT 'Overall composite or total score for the test. Scale varies by test type (e.g., SAT 400-1600, ACT 1-36, GRE 260-340, TOEFL 0-120, IELTS 0-9).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test score record was first created in the system. Used for audit trail and data lineage tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the test score record was last updated or modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments about the test score record. May include information about score discrepancies, special circumstances, or additional context for admissions review.',
    `official_verification_status` STRING COMMENT 'Status of official verification for the test score. Indicates whether an official score report has been received and validated by the institution. Pending indicates awaiting official report, verified indicates official report received and matched, rejected indicates discrepancy between self-reported and official scores, not_required indicates official verification is not needed for this use case.. Valid values are `pending|verified|rejected|not_required`',
    `percentile_rank` STRING COMMENT 'Percentile rank of the students composite score compared to all test takers in the reference population. Value ranges from 1 to 99, indicating the percentage of test takers who scored at or below this score.',
    `received_by` STRING COMMENT 'Name or identifier of the staff member or system that received and recorded the test score. Used for audit trail and accountability purposes.',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Transfer credit evaluation is a registrar function with associated labor and operational costs. Business process: evaluation staff time is allocated to registrar cost center for budget tracking and wo',
    `employee_id` BIGINT COMMENT 'Identifier of the faculty member or registrar staff who performed the transfer credit evaluation. Links to employee or faculty record.',
    `course_id` BIGINT COMMENT 'Identifier of the institutional course to which the transfer credit has been articulated. Null if credit is awarded as elective or unassigned credit.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Transfer credit evaluation follows institutional articulation and credit acceptance policies. Credit evaluators apply documented policy criteria for equivalency determination. Essential for transfer c',
    `profile_id` BIGINT COMMENT 'Identifier of the student receiving the transfer credit. Links to the student master record.',
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
    `conduct_record_id` BIGINT COMMENT 'Foreign key linking to student.conduct_record. Business justification: Conduct violations frequently result in administrative holds being placed on student records (e.g., disciplinary probation hold, suspension hold preventing registration, transcript hold during investi',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Financial holds reference specific AR ledger accounts for amounts owed (tuition, fees, library fines). Business process: bursar places holds when account balances exceed threshold; hold release requir',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Holds (registration, transcript, diploma blocks) are placed under institutional policy authority. Hold placement and release procedures follow documented policies. Required for hold appeals and policy',
    `profile_id` BIGINT COMMENT 'Identifier of the student on whom this hold is placed. Links to the student master record.',
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
    `originating_office` STRING COMMENT 'Name or code of the institutional office or department that placed the hold (e.g., Bursar, Registrar, Student Health, Library, Parking Services, Dean of Students).',
    `override_allowed` BOOLEAN COMMENT 'Indicates whether authorized staff are permitted to override this hold to allow restricted services (True/False).',
    `override_authority` STRING COMMENT 'Role or position authorized to override this hold (e.g., Registrar, Dean, Bursar, Department Chair). Null if override is not allowed.',
    `placed_by` STRING COMMENT 'Username or identifier of the staff member or system process that placed the hold.',
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
    `employee_id` BIGINT COMMENT 'Unique identifier of the faculty or staff member who approved the leave of absence. Links to employee or faculty record.',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: Leave of absence administration requires formal term linkage for leave start dates to calculate return eligibility, financial aid impact, and degree timeline adjustments. Current leave_start_term is a',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student taking the leave of absence. Links to the student master record.',
    `academic_standing_at_leave` STRING COMMENT 'Students academic standing status at the time the leave of absence began. Good standing indicates satisfactory academic performance, academic probation indicates below-standard performance with conditions, academic suspension indicates temporary removal from enrollment, academic dismissal indicates permanent removal.. Valid values are `good_standing|academic_probation|academic_suspension|academic_dismissal`',
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

CREATE OR REPLACE TABLE `education_ecm`.`student`.`cohort_membership` (
    `cohort_membership_id` BIGINT COMMENT 'Unique identifier for the cohort membership record. Primary key for this entity.',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: IPEDS cohort reporting requires precise entry term linkage for 100%/150%/200% completion calculations, retention rates, and graduation rates. Entry_term_code alone insufficient for census date determi',
    `profile_id` BIGINT COMMENT 'Reference to the student who is a member of this cohort. Links to the student master record in the Student Information System (SIS).',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: IPEDS cohort tracking is a federal reporting requirement. Cohort definitions and tracking methodology are driven by IPEDS regulatory requirements. Essential for IPEDS Graduation Rates and Outcome Meas',
    `cohort_code` STRING COMMENT 'Business identifier code for the cohort. Used for reporting and operational reference (e.g., FTIAC_2023, PELL_2024, STEM_FALL22).. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `cohort_name` STRING COMMENT 'Human-readable descriptive name for the cohort (e.g., Fall 2023 First-Time Full-Time Freshmen, Pell Grant Recipients 2024, STEM Majors Fall 2022).',
    `cohort_notes` STRING COMMENT 'Free-text notes documenting special circumstances, data quality issues, or additional context for this cohort membership record. Used by institutional research staff for audit trails and data stewardship.',
    `cohort_type` STRING COMMENT 'Classification of the cohort based on institutional or federal reporting requirements. FTIAC (First-Time-In-Any-College) is the primary IPEDS cohort type. Other types support retention analysis, equity reporting, and program evaluation. [ENUM-REF-CANDIDATE: FTIAC|Transfer|Pell Recipient|First-Generation|STEM|Athlete|Veteran|International|Honors|Underrepresented Minority — 10 candidates stripped; promote to reference product]',
    `cohort_year` STRING COMMENT 'The calendar year or academic year in which the cohort was established. Used for multi-year tracking and longitudinal analysis (e.g., 2023 for Fall 2023 cohort).',
    `completion_within_100_pct_flag` BOOLEAN COMMENT 'Indicates whether the student completed their degree within 100% of normal time (e.g., 4 years for a bachelors degree). Used for on-time graduation rate reporting.',
    `completion_within_150_pct_flag` BOOLEAN COMMENT 'Indicates whether the student completed their degree within 150% of normal time (e.g., 6 years for a bachelors degree). This is the standard IPEDS graduation rate metric.',
    `completion_within_200_pct_flag` BOOLEAN COMMENT 'Indicates whether the student completed their degree within 200% of normal time (e.g., 8 years for a bachelors degree). Used for extended completion rate analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cohort membership record was first created in the system. Used for audit trails and data lineage tracking.',
    `data_quality_flag` STRING COMMENT 'Indicator of the data quality status for this cohort membership record. Used by institutional research and data stewardship teams to track records requiring validation or correction before IPEDS submission.. Valid values are `Valid|Under Review|Incomplete|Corrected|Flagged for Audit`',
    `degree_seeking_flag` BOOLEAN COMMENT 'Indicates whether the student was degree-seeking at cohort entry. IPEDS cohorts include only degree-seeking students; non-degree students are excluded from graduation rate calculations.',
    `entry_date` DATE COMMENT 'The specific date the student was added to the cohort. Typically the census date or official enrollment date for the entry term. Critical for IPEDS 150% graduation rate calculations.',
    `exclusion_date` DATE COMMENT 'The date the student was excluded from the cohort, if applicable. Used to document when the exclusion event occurred for audit and compliance purposes.',
    `exclusion_reason` STRING COMMENT 'The reason a student was excluded from the cohort per IPEDS allowable exclusions. Students who die, become permanently disabled, or leave for military/foreign aid/church service may be excluded from the denominator of graduation rate calculations. None indicates no exclusion applies.. Valid values are `Death|Permanent Disability|Military Service|Foreign Aid Service|Official Church Mission|None`',
    `first_time_flag` BOOLEAN COMMENT 'Indicates whether the student was first-time (no prior postsecondary enrollment) at cohort entry. The FTIAC (First-Time-In-Any-College) cohort requires this flag to be true.',
    `full_time_status_flag` BOOLEAN COMMENT 'Indicates whether the student was enrolled full-time at cohort entry. Critical for IPEDS cohort definition, which requires full-time status for the standard graduation rate cohort.',
    `graduation_date` DATE COMMENT 'The date the student graduated from the institution, if the membership status is Graduated. Used to calculate time-to-degree and determine whether graduation occurred within 100%, 150%, or 200% of normal time.',
    `graduation_term_code` STRING COMMENT 'The academic term code in which the student graduated, in Banner YYYYTT format (e.g., 202305 for Spring 2023). Used for term-based graduation rate reporting.. Valid values are `^[0-9]{6}$`',
    `ipeds_cohort_flag` BOOLEAN COMMENT 'Boolean indicator whether this cohort membership is part of the official IPEDS Graduation Rate Survey cohort. True for FTIAC full-time degree-seeking students entering in the fall term.',
    `ipeds_submission_year` STRING COMMENT 'The IPEDS collection year in which this cohort membership was reported to the U.S. Department of Education. Used to track historical submissions and support multi-year trend analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cohort membership record was last updated. Used for change tracking and data quality monitoring.',
    `membership_status` STRING COMMENT 'Current status of the student within this cohort. Active indicates the student is still being tracked. Graduated, Transferred Out, Withdrawn, and Deceased are terminal outcomes. Still Enrolled indicates the student remains enrolled beyond the standard completion timeframe. Excluded indicates the student was removed from cohort tracking per IPEDS exclusion rules (e.g., death, permanent disability, military service). [ENUM-REF-CANDIDATE: Active|Graduated|Transferred Out|Still Enrolled|Withdrawn|Deceased|Excluded — 7 candidates stripped; promote to reference product]',
    `outcome_determination_date` DATE COMMENT 'The date on which the final cohort outcome status was determined. For IPEDS reporting, this is typically 150% of normal program completion time from the cohort entry date (e.g., 6 years for a 4-year degree program).',
    `pell_recipient_flag` BOOLEAN COMMENT 'Indicates whether the student received a Federal Pell Grant in the cohort entry year. IPEDS requires disaggregation of graduation rates by Pell recipient status for equity reporting.',
    `persistence_flag` BOOLEAN COMMENT 'Indicates whether the student persisted to the next term (term-to-term persistence). True if the student enrolled in the immediately following term. Used for early intervention and student success initiatives.',
    `reporting_framework` STRING COMMENT 'The regulatory or institutional reporting framework that this cohort supports. IPEDS is the federal standard. Institutional cohorts support internal retention and completion tracking. State frameworks support state performance funding. Accreditation cohorts support regional or programmatic accreditor requirements. NCAA cohorts track student-athlete graduation rates. VSA (Voluntary System of Accountability) cohorts support transparency initiatives. [ENUM-REF-CANDIDATE: IPEDS|Institutional|State|Accreditation|Federal Title IV|NCAA|VSA — 7 candidates stripped; promote to reference product]',
    `retention_flag` BOOLEAN COMMENT 'Indicates whether the student was retained to the next fall term (one-year retention). True if the student enrolled in the fall term one year after cohort entry. Critical metric for institutional performance and accreditation.',
    `source_system` STRING COMMENT 'The system of record from which this cohort membership data originated. Typically Ellucian Banner SIS for operational cohorts, or Institutional Research systems for analytical cohorts.. Valid values are `Banner SIS|Institutional Research|Manual Entry|Data Warehouse|External Feed`',
    `subsidized_loan_recipient_flag` BOOLEAN COMMENT 'Indicates whether the student received a Direct Subsidized Loan (but not a Pell Grant) in the cohort entry year. IPEDS requires disaggregation by loan recipient status.',
    `transfer_out_date` DATE COMMENT 'The date the student transferred out to another institution, if the membership status is Transferred Out. Used for IPEDS transfer-out reporting and to adjust retention calculations.',
    `withdrawal_date` DATE COMMENT 'The date the student withdrew from the institution, if the membership status is Withdrawn. Used for retention analysis and stop-out tracking.',
    CONSTRAINT pk_cohort_membership PRIMARY KEY(`cohort_membership_id`)
) COMMENT 'Associates students with institutional cohorts used for retention tracking, IPEDS graduation rate reporting, and federal compliance. Captures cohort type (FTIAC, transfer, Pell recipient, first-generation, STEM, athlete, veteran), cohort entry term, cohort year, cohort status (active, graduated, transferred out, still enrolled, withdrawn), outcome determination date, and the federal/institutional reporting framework the cohort supports. Enables 150% graduation rate and retention rate calculations per IPEDS methodology.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`ferpa_consent` (
    `ferpa_consent_id` BIGINT COMMENT 'Unique identifier for the FERPA consent record. Primary key for the ferpa_consent product.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: FERPA consents must align with institutional FERPA policy version. Consent forms reference specific policy language for legal compliance. Essential for consent validity verification and policy version',
    `employee_id` BIGINT COMMENT 'Unique identifier of the institutional staff member who processed and authorized this FERPA consent in the system. Links to the staff or employee master record.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student who granted or revoked FERPA consent. Links to the student master record in the Student Information System (SIS).',
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
    `export_control_review_id` BIGINT COMMENT 'Foreign key linking to research.export_control_review. Business justification: Export control reviews must document foreign national students with access to controlled technology or data; regulatory requirement under EAR/ITAR for universities conducting defense or dual-use resea',
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
    `dso_email` STRING COMMENT 'The email address of the Designated School Official (DSO) responsible for this students SEVIS record. Used for official communications regarding the students immigration status.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `dso_name` STRING COMMENT 'The name of the Designated School Official (DSO) who is the primary point of contact for this students SEVIS record. The DSO is responsible for maintaining the students record and ensuring compliance with SEVP regulations.',
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
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: Degree conferral processing and commencement planning require term linkage for application deadlines, degree audit scheduling, and diploma ordering. Application_term_code alone insufficient for automa',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student submitting the graduation application. Links to the student master record.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Degree conferral reporting to state and federal agencies is regulatory. Graduation data feeds IPEDS Completions survey and state authorization reports. Essential for regulatory filing preparation.',
    `application_approved_date` DATE COMMENT 'Date the graduation application was approved by the registrar or academic dean. Null if not yet approved.',
    `application_fee_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the graduation application fee charged to the student. Null if no fee is charged by the institution.',
    `application_fee_paid_flag` BOOLEAN COMMENT 'Indicates whether the graduation application fee has been paid. True if paid, False if outstanding. Some institutions charge a fee for graduation application processing.',
    `application_number` STRING COMMENT 'Human-readable business identifier for the graduation application, typically displayed on student portals and official communications.',
    `application_status` STRING COMMENT 'Current workflow status of the graduation application. Pending indicates under review, Approved means cleared for degree conferral, Denied indicates requirements not met, Deferred means postponed to future term.. Valid values are `Pending|Approved|Denied|Deferred|Withdrawn|Cancelled`',
    `application_submitted_date` DATE COMMENT 'Date the student submitted the graduation application. Used to track application deadlines and processing timelines.',
    `cip_code` STRING COMMENT 'Six-digit CIP code classifying the field of study for federal IPEDS reporting. Format: XX.XXXX (e.g., 52.0201 for Business Administration).. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `commencement_ceremony_code` STRING COMMENT 'Code identifying the specific commencement ceremony the student will attend (e.g., College of Engineering ceremony, Graduate School ceremony). Null if not participating.',
    `commencement_participation_flag` BOOLEAN COMMENT 'Indicates whether the student intends to participate in the commencement ceremony. True if participating, False if not attending.',
    `concentration_code` STRING COMMENT 'Optional code identifying the academic concentration, specialization, or track within the program (e.g., Finance concentration within Business major).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the graduation application record was first created in the system. Used for audit trail and data lineage tracking.',
    `degree_audit_date` DATE COMMENT 'Date the final degree audit was completed to verify all graduation requirements were met. Typically performed by the registrars office.',
    `degree_audit_performed_by` STRING COMMENT 'Name or identifier of the registrar staff member who performed the final degree audit. Used for accountability and audit trail purposes.',
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
    `program_code` STRING COMMENT 'Code identifying the academic program (major) from which the student is graduating. Links to the curriculum program catalog.',
    `special_recognition` STRING COMMENT 'Additional honors, awards, or recognitions to be noted on the diploma or transcript (e.g., Honors Program Graduate, Phi Beta Kappa, Deans List). Free-text field for institutional flexibility.',
    `total_credits_earned` DECIMAL(18,2) COMMENT 'Total number of credit hours earned by the student at the time of graduation, including transfer credits if applicable. Used to verify degree completion requirements.',
    `transfer_credits_accepted` DECIMAL(18,2) COMMENT 'Number of transfer credit hours accepted toward the degree from other institutions. Used for degree audit and IPEDS reporting.',
    CONSTRAINT pk_graduation_application PRIMARY KEY(`graduation_application_id`)
) COMMENT 'Records a students formal application to graduate, including application term, degree level, degree program, diploma name, diploma mailing address, commencement participation intent, commencement ceremony selection, application status (pending, approved, denied, deferred), degree conferral date, diploma print date, diploma hold flag, and Latin honors designation (cum laude, magna cum laude, summa cum laude). Drives the degree conferral workflow and IPEDS Completions Survey submissions.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`advising_note` (
    `advising_note_id` BIGINT COMMENT 'Unique identifier for the advising note record. Primary key for the advising note entity.',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: Academic advising and early alert systems require term context for intervention timing, course-specific concerns, and retention analytics. Academic_term_code insufficient for term-based reporting dash',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Advising services are budgeted to academic advising or college-specific cost centers. Business process: advisor FTE and program costs are allocated to cost centers for budget management and resource a',
    `course_section_id` BIGINT COMMENT 'Foreign key linking to instruction.course_section. Business justification: Advising notes frequently document course-specific academic concerns, performance issues, and interventions. Advisors need to reference the exact section when discussing attendance problems, grade con',
    `employee_id` BIGINT COMMENT 'The system user identifier of the person who created the advising note record. Supports accountability and audit trails.',
    `identity_account_id` BIGINT COMMENT 'The system user identifier of the person who last modified the advising note record. Supports change tracking and accountability.',
    `instructor_id` BIGINT COMMENT 'Identifier of the faculty or staff member who created this advising note. Links to the faculty or staff record.',
    `profile_id` BIGINT COMMENT 'Identifier of the student who is the subject of this advising note. Links to the student master record.',
    `service_request_id` BIGINT COMMENT 'Foreign key linking to technology.service_request. Business justification: Advisors document IT barriers preventing student success (LMS access failures, software licensing issues, network connectivity problems). Enables holistic student support by connecting academic advisi',
    `action_items_assigned` STRING COMMENT 'Specific tasks, commitments, or next steps assigned to the student or advisor as a result of the advising session. Supports accountability and follow-up tracking.',
    `alert_source` STRING COMMENT 'The origin or initiator of the alert or advising interaction. Identifies who raised the concern or initiated the contact.. Valid values are `faculty_referral|system_generated|self_referral|peer_referral|staff_referral`',
    `alert_trigger` STRING COMMENT 'The specific condition or event that prompted the creation of this advising note, particularly for early alert interventions. None indicates a proactive or scheduled interaction.. Valid values are `attendance|grade|engagement|financial|behavioral|none`',
    `case_resolution_status` STRING COMMENT 'The current state of the advising case or intervention. Indicates whether the matter is still active, has been resolved, or has been transferred to another advisor or service.. Valid values are `open|closed|pending|transferred`',
    `course_of_concern` STRING COMMENT 'The specific course code or identifier that is the subject of the advising note, particularly for early alerts related to course performance. May be null for non-course-specific interactions.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the advising note record was first created in the system. Used for audit trails and data lineage.',
    `credits_earned_at_time_of_note` DECIMAL(18,2) COMMENT 'The total number of credit hours the student had successfully completed at the time of the advising note. Provides degree progress context.',
    `ferpa_sensitive_flag` BOOLEAN COMMENT 'Indicates whether this advising note contains particularly sensitive information that requires additional access controls beyond standard FERPA protections. Used for managing disclosure and privacy compliance.',
    `follow_up_date` DATE COMMENT 'The scheduled date for the next advising interaction or check-in with the student. Used for case management and ensuring continuity of support.',
    `gpa_at_time_of_note` DECIMAL(18,2) COMMENT 'The students cumulative GPA at the time the advising note was created. Provides academic context for the intervention and supports outcome analysis.',
    `intervention_outcome` STRING COMMENT 'The result or status of the intervention or advising session. Tracks effectiveness of student success efforts and case resolution.. Valid values are `resolved|in_progress|escalated|no_response|declined`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this advising note record is currently active or has been logically deleted or archived. Supports soft-delete patterns and historical record retention.',
    `meeting_date` DATE COMMENT 'The date on which the advising interaction or meeting occurred. Used for tracking student engagement frequency and intervention timing.',
    `meeting_duration_minutes` STRING COMMENT 'The length of the advising session in minutes. Used for workload analysis and resource planning.',
    `meeting_modality` STRING COMMENT 'The mode or channel through which the advising interaction took place. Supports analysis of engagement preferences and accessibility.. Valid values are `in_person|virtual|phone|email|text`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the advising note record was last updated. Supports change tracking and audit compliance.',
    `note_text` STRING COMMENT 'The detailed narrative content of the advising note, including observations, student statements, advisor recommendations, and interaction details. Contains FERPA-protected educational records.',
    `note_type` STRING COMMENT 'Classification of the advising note indicating the primary purpose or focus of the interaction. Supports categorization for reporting and intervention tracking.. Valid values are `academic_plan|early_alert|degree_audit_review|probation_counseling|career_advising|retention_intervention`',
    `note_visibility` STRING COMMENT 'Controls who can view this advising note within the institution. Supports privacy management and appropriate information sharing among support staff.. Valid values are `private|shared_with_advisors|shared_with_faculty|public`',
    `referral_made` STRING COMMENT 'Indicates whether the student was referred to another campus support service or resource as part of the advising interaction. Supports coordinated care and holistic student support. [ENUM-REF-CANDIDATE: tutoring|counseling|financial_aid|career_services|disability_services|health_services|none — 7 candidates stripped; promote to reference product]',
    `risk_level` STRING COMMENT 'Assessment of the students risk level for academic difficulty, attrition, or non-completion at the time of the note. Used for prioritizing interventions and retention efforts.. Valid values are `low|moderate|high|critical`',
    `sap_status_at_time_of_note` STRING COMMENT 'The students SAP status at the time of the advising note, indicating compliance with federal financial aid academic progress requirements. Critical for Title IV compliance and intervention targeting.. Valid values are `satisfactory|warning|probation|suspension`',
    `source_system` STRING COMMENT 'The originating system or platform from which this advising note was captured. Supports data lineage and integration management across SIS, LMS, and student success platforms.. Valid values are `banner|starfish|navigate|peoplesoft|custom`',
    `student_attendance_status` STRING COMMENT 'Indicates whether the student attended the scheduled advising appointment. Used for engagement tracking and no-show analysis.. Valid values are `attended|no_show|cancelled|rescheduled`',
    `topics_discussed` STRING COMMENT 'Free-text description of the subjects, concerns, or issues addressed during the advising session. Provides context for the interaction and supports case management.',
    CONSTRAINT pk_advising_note PRIMARY KEY(`advising_note_id`)
) COMMENT 'Captures academic advising interactions, early alert interventions, and student success case management records. Includes note type (academic plan, early alert, degree audit review, probation counseling, career advising, retention intervention), alert trigger (attendance, grade, engagement, financial, behavioral), alert source, risk level, meeting modality (in-person, virtual, phone, email), meeting date and duration, topics discussed, action items assigned, follow-up date, intervention outcome, referral made (to tutoring, counseling, financial aid), case resolution status, and FERPA-sensitive flag. Supports early alert systems, student success platforms (Starfish, EAB Navigate), and retention intervention tracking.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`student_early_alert` (
    `student_early_alert_id` BIGINT COMMENT 'Unique identifier for the student early alert record. Primary key for the student early alert entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Early alert programs are funded retention initiatives with dedicated budgets. Business process: program costs (staff, technology, interventions) are tracked to retention services cost center for ROI a',
    `employee_id` BIGINT COMMENT 'Unique identifier of the staff member (advisor, counselor, success coach, or faculty member) assigned to follow up on this alert and coordinate intervention efforts.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student for whom this early alert was raised. Links to the student master record in the Student Information System (SIS).',
    `service_request_id` BIGINT COMMENT 'Foreign key linking to technology.service_request. Business justification: Early alert systems flag students with repeated IT service requests (login failures, software access issues) as at-risk indicators. Used in predictive retention models and intervention workflows where',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: Early alert intervention tracking requires term linkage for alert timing, follow-up scheduling, and retention outcome measurement. Term_code alone insufficient for automated alert escalation rules tie',
    `alert_date` DATE COMMENT 'The date on which the early alert was raised or the triggering event was observed. This is the business event date, distinct from system audit timestamps.',
    `alert_description` STRING COMMENT 'Detailed narrative description of the concern or triggering event provided by the alert originator. May include specific observations, context, and recommended actions. Free-text field for qualitative information.',
    `alert_notes` STRING COMMENT 'Additional free-text notes, observations, or case management documentation related to the alert. May include follow-up summaries, student comments, or contextual information for future reference.',
    `alert_number` STRING COMMENT 'Human-readable business identifier for the early alert, typically formatted as EA-YYYYNNNN for tracking and reference purposes.. Valid values are `^EA-[0-9]{8}$`',
    `alert_source` STRING COMMENT 'Origin or role of the individual or system that raised the early alert. Faculty indicates instructor-initiated; LMS analytics indicates system-generated from Canvas or other Learning Management System; automated_system indicates rule-based triggers from predictive models or threshold monitoring. [ENUM-REF-CANDIDATE: faculty|academic_advisor|lms_analytics|peer_mentor|financial_aid_office|residence_life|athletics|counseling_center|registrar|automated_system — 10 candidates stripped; promote to reference product]',
    `alert_subtype` STRING COMMENT 'Detailed classification within the alert type, such as excessive absences, failing midterm, no LMS login 14 days, past due balance, academic integrity violation, or mental health concern. Provides granular context for intervention planning.',
    `alert_timestamp` TIMESTAMP COMMENT 'Precise date and time when the early alert was created in the system, including time zone information. Used for sequencing and time-sensitive intervention workflows.',
    `alert_type` STRING COMMENT 'Primary category of the early alert trigger. Attendance indicates missed classes or low participation; academic_performance indicates poor grades or failing assignments; engagement indicates lack of LMS activity or course interaction; financial indicates outstanding balances or FAFSA issues; behavioral indicates conduct concerns; health_wellness indicates personal or mental health concerns.. Valid values are `attendance|academic_performance|engagement|financial|behavioral|health_wellness`',
    `assigned_date` DATE COMMENT 'Date when the alert was assigned to a case owner for follow-up. Used to track response time and case management efficiency.',
    `contact_method` STRING COMMENT 'Primary communication channel used for initial student outreach. Tracks effectiveness of different contact strategies for at-risk student engagement.. Valid values are `email|phone|in_person|text_message|video_conference|no_contact_yet`',
    `course_number` STRING COMMENT 'Numeric course identifier within the subject area (e.g., 101, 2301, 4550A). Combined with subject code, identifies the specific course catalog entry.. Valid values are `^[0-9]{3,4}[A-Z]?$`',
    `course_reference_number` STRING COMMENT 'Five-digit unique identifier for the specific course section associated with this alert, if applicable. Used when the alert is course-specific (e.g., attendance or grade concerns in a particular class).. Valid values are `^[0-9]{5}$`',
    `course_subject_code` STRING COMMENT 'Abbreviated subject area code for the course related to this alert (e.g., MATH, ENGL, BIOL, CHEM). Enables analysis of at-risk patterns by discipline.. Valid values are `^[A-Z]{2,4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System audit timestamp indicating when this early alert record was first created in the database. Used for data lineage, audit trails, and compliance reporting.',
    `ferpa_restriction_flag` BOOLEAN COMMENT 'Indicates whether the student has requested directory information suppression or other FERPA privacy restrictions that may limit information sharing with parents, external parties, or certain campus offices. True if restrictions are in place; false otherwise.',
    `final_course_grade` STRING COMMENT 'The final grade earned by the student in the course associated with this alert, if applicable. Used to measure intervention effectiveness and contribution to DFW (D-grade, F-grade, Withdrawal) rate reduction. Includes letter grades (A through F with optional plus/minus), W for withdrawal, I for incomplete, P/NP for pass/no-pass, and AU for audit.. Valid values are `^[A-F][+-]?$|^W$|^I$|^P$|^NP$|^AU$`',
    `first_contact_date` DATE COMMENT 'Date of the first outreach attempt or successful contact with the student regarding this alert. Key metric for measuring intervention timeliness.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether additional follow-up actions are needed. True if the case remains open and requires ongoing monitoring or further intervention; false if the alert has been resolved or closed.',
    `intervention_actions` STRING COMMENT 'Detailed description of intervention steps taken, such as academic coaching sessions, tutoring referrals, financial aid counseling, mental health referrals, course withdrawal guidance, or academic probation planning. Free-text narrative of case management activities.',
    `metric_value` DECIMAL(18,2) COMMENT 'The actual value of the triggering metric at the time of alert creation (e.g., 1.85 for GPA, 4 for absences, 16 for days since last login). Stored as string to accommodate various metric types.',
    `next_follow_up_date` DATE COMMENT 'Scheduled date for the next check-in or intervention activity with the student. Used for case management workflow and ensuring timely follow-up.',
    `outcome_category` STRING COMMENT 'Final outcome classification for the student following the alert and intervention. Retained_improved indicates student remained enrolled with improved performance; retained_stable indicates student remained enrolled without significant change; withdrew_course indicates student dropped the specific course; withdrew_institution indicates student left the institution; transferred indicates student moved to another institution; no_outcome_yet indicates outcome not yet determined.. Valid values are `retained_improved|retained_stable|withdrew_course|withdrew_institution|transferred|no_outcome_yet`',
    `priority_flag` BOOLEAN COMMENT 'Indicates whether this alert requires expedited attention or immediate intervention. True for time-sensitive cases such as financial holds before registration, imminent withdrawal risk, or safety concerns.',
    `referral_services` STRING COMMENT 'Comma-separated list of campus support services to which the student was referred, such as Tutoring Center, Writing Lab, Counseling Center, Financial Aid Office, Disability Services, Career Services, or Academic Success Coaching.',
    `resolution_date` DATE COMMENT 'Date when the alert was marked as resolved or closed. Used to calculate case duration and measure intervention cycle time.',
    `resolution_status` STRING COMMENT 'Current state of the alert case. Open indicates newly created; in_progress indicates active intervention underway; resolved_improved indicates student performance improved; resolved_no_change indicates case closed without improvement; resolved_withdrew indicates student withdrew from course or institution; closed_no_action indicates alert closed without intervention (e.g., duplicate or error).. Valid values are `open|in_progress|resolved_improved|resolved_no_change|resolved_withdrew|closed_no_action`',
    `retained_next_term` BOOLEAN COMMENT 'Indicates whether the student enrolled in the subsequent academic term. True if the student continued enrollment; false if the student did not return. Key metric for measuring early alert program effectiveness on retention rates.',
    `risk_level` STRING COMMENT 'Assessed severity of the students at-risk status. Low indicates early warning signs; moderate indicates multiple concerns or declining performance; high indicates significant risk of course failure or withdrawal; critical indicates imminent risk of stop-out or severe academic/personal crisis.. Valid values are `low|moderate|high|critical`',
    `sap_status_post_alert` STRING COMMENT 'The students SAP status following the term in which the alert was raised. SAP is required for Title IV federal financial aid eligibility. Satisfactory indicates meeting all requirements; warning indicates first term of non-compliance; probation indicates on academic plan; suspension indicates loss of aid eligibility; not_applicable for students not receiving Title IV aid.. Valid values are `satisfactory|warning|probation|suspension|not_applicable`',
    `student_response` STRING COMMENT 'Students level of engagement with intervention efforts. Engaged indicates active participation in recommended actions; partially_engaged indicates some but incomplete follow-through; non_responsive indicates no reply to outreach; declined_services indicates student acknowledged but refused assistance; withdrew indicates student dropped the course or left the institution.. Valid values are `engaged|partially_engaged|non_responsive|declined_services|withdrew`',
    `term_gpa_post_intervention` DECIMAL(18,2) COMMENT 'The students term GPA at the end of the term in which the alert was raised, measured after intervention activities. Used to assess the impact of early alert programs on academic performance. Scale is 0.00 to 4.00.',
    `triggering_metric` STRING COMMENT 'Specific quantitative or qualitative measure that triggered the alert, such as GPA below 2.0, missed 4 consecutive classes, no LMS login for 14 days, midterm grade D or F, or outstanding balance over $1000.',
    `updated_timestamp` TIMESTAMP COMMENT 'System audit timestamp indicating when this early alert record was last modified. Used for change tracking, data quality monitoring, and audit compliance.',
    CONSTRAINT pk_student_early_alert PRIMARY KEY(`student_early_alert_id`)
) COMMENT 'Tracks early warning signals and intervention records for at-risk students. Captures alert trigger type (attendance, grade, engagement, financial, behavioral), alert source (faculty, advisor, LMS analytics, peer mentor), alert date, risk level, assigned case owner, intervention actions taken, student response, resolution status, and outcome (retained, withdrew, improved standing). Supports student success programs, retention initiatives, and DFW rate reduction efforts.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`disability_accommodation` (
    `disability_accommodation_id` BIGINT COMMENT 'Unique identifier for the disability accommodation record. Primary key for the disability accommodation entity.',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: ADA accommodation delivery requires term-specific faculty notification and course-level accommodation tracking. Academic_term_code insufficient for automated faculty notification workflows tied to ter',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Disability accommodations (interpreters, note-takers, assistive technology) are budgeted and expensed to disability services cost center. Business process: accommodation costs are tracked for budget m',
    `course_id` BIGINT COMMENT 'Reference to a specific course for which the accommodation is being applied. Null if the accommodation applies broadly across all courses rather than to a specific course.',
    `course_section_id` BIGINT COMMENT 'Foreign key linking to instruction.course_section. Business justification: Accommodations are implemented at the section level (extended exam time for specific instructor, note-taker assigned to particular meeting times). Delivery_status and faculty_notification_date fields ',
    `employee_id` BIGINT COMMENT 'Reference to the disability services staff member who approved the accommodation. Links to the staff or employee master record.',
    `identity_account_id` BIGINT COMMENT 'User identifier of the disability services staff member or system user who created this accommodation record. Used for audit trail and accountability purposes.',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to technology.it_asset. Business justification: Links assistive technology devices (screen readers, adaptive keyboards, FM systems) to accommodation records. Required for ADA compliance tracking, device assignment/checkout workflows, maintenance co',
    `modified_by_user_identity_account_id` BIGINT COMMENT 'User identifier of the disability services staff member or system user who last modified this accommodation record. Used for audit trail and accountability purposes.',
    `profile_id` BIGINT COMMENT 'Reference to the student receiving the disability accommodation. Links to the student master record in the Student Information System (SIS).',
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

CREATE OR REPLACE TABLE `education_ecm`.`student`.`student_sap_evaluation` (
    `student_sap_evaluation_id` BIGINT COMMENT 'Unique identifier for each formal SAP evaluation record. Primary key for the student SAP evaluation entity.',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: Title IV satisfactory academic progress evaluations occur at term end for financial aid eligibility determination. Evaluation_term_code insufficient for automated SAP evaluation scheduling tied to ter',
    `identity_account_id` BIGINT COMMENT 'User ID of the system user who created this SAP evaluation record. Part of audit trail for compliance and accountability.',
    `last_modified_by_user_identity_account_id` BIGINT COMMENT 'User ID of the system user who last modified this SAP evaluation record. Part of audit trail for compliance and accountability.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the financial aid counselor or staff member who conducted this SAP evaluation. Links to staff/employee master record.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student being evaluated for Satisfactory Academic Progress. Links to the student master record.',
    `academic_plan_attached` BOOLEAN COMMENT 'Indicates whether a formal academic plan document has been attached to this SAP evaluation record. True if plan is on file.',
    `academic_plan_required` BOOLEAN COMMENT 'Indicates whether an academic plan is required as a condition of the SAP appeal approval or probation status. True if academic plan is mandatory.',
    `academic_plan_url` STRING COMMENT 'URL or file path to the stored academic plan document outlining the students path to return to satisfactory academic progress. Null if no plan exists.',
    `academic_year` STRING COMMENT 'Academic year for which this SAP evaluation applies (e.g., 2023-2024). Used for multi-year SAP tracking and IPEDS reporting.',
    `aid_reinstatement_date` DATE COMMENT 'Date on which Title IV financial aid was reinstated following successful SAP appeal or academic plan completion. Null if aid was not reinstated.',
    `aid_suspension_date` DATE COMMENT 'Date on which Title IV financial aid was suspended due to SAP failure. Null if aid was not suspended.',
    `appeal_decision` STRING COMMENT 'Decision outcome of the SAP appeal: approved (appeal granted, aid continues under academic plan), denied (appeal rejected, aid remains suspended), pending (under review), or withdrawn (student withdrew appeal).. Valid values are `approved|denied|pending|withdrawn`',
    `appeal_decision_date` DATE COMMENT 'Date on which the SAP appeal decision was rendered. Null if appeal is pending or no appeal was submitted.',
    `appeal_reason` STRING COMMENT 'Primary reason cited by the student for the SAP appeal (e.g., medical emergency, family crisis, death of relative, military deployment). Free-text field capturing mitigating circumstances.',
    `appeal_submission_date` DATE COMMENT 'Date on which the student submitted their SAP appeal. Null if no appeal was submitted.',
    `appeal_submitted` BOOLEAN COMMENT 'Indicates whether the student submitted a formal SAP appeal following suspension or warning. True if appeal was submitted.',
    `comments` STRING COMMENT 'Free-text comments or notes from the evaluating counselor regarding this SAP evaluation, including special circumstances, exceptions, or additional context.',
    `completion_rate` DECIMAL(18,2) COMMENT 'Percentage of attempted credits that the student has successfully completed (credits_earned / credits_attempted * 100). Represents the quantitative measure (pace) of SAP.',
    `completion_rate_threshold` DECIMAL(18,2) COMMENT 'Minimum completion rate (pace) percentage required for satisfactory academic progress. Federal regulations typically require at least 67% completion rate.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SAP evaluation record was first created in the system. Part of audit trail for compliance and data lineage.',
    `credits_attempted` DECIMAL(18,2) COMMENT 'Total cumulative credit hours attempted by the student at the time of this SAP evaluation. Includes all enrolled credits regardless of completion or grade outcome.',
    `credits_earned` DECIMAL(18,2) COMMENT 'Total cumulative credit hours successfully completed (earned) by the student at the time of this SAP evaluation. Used to calculate pace/completion rate.',
    `cumulative_gpa` DECIMAL(18,2) COMMENT 'Students cumulative GPA at the time of this SAP evaluation. Used to assess qualitative measure of academic progress against institutional minimum GPA threshold.',
    `evaluation_date` DATE COMMENT 'The date on which this SAP evaluation was formally conducted and recorded. Critical for Title IV compliance audit trails.',
    `evaluation_type` STRING COMMENT 'Type of SAP evaluation conducted: annual (end-of-year standard review), mid-year (mid-term checkpoint), appeal (student-initiated review following suspension), reinstatement (review after academic plan completion), probation_review (review during probation period), or warning_review (review during warning period).. Valid values are `annual|mid-year|appeal|reinstatement|probation_review|warning_review`',
    `financial_aid_eligibility` STRING COMMENT 'Current Title IV financial aid eligibility status resulting from this SAP evaluation: eligible (aid continues), suspended (aid stopped), reinstated (aid resumed after appeal), or conditional (aid continues under academic plan).. Valid values are `eligible|suspended|reinstated|conditional`',
    `gpa_requirement_met` BOOLEAN COMMENT 'Indicates whether the student met the minimum cumulative GPA requirement for SAP at the time of evaluation. True if cumulative_gpa >= gpa_threshold.',
    `gpa_threshold` DECIMAL(18,2) COMMENT 'Minimum cumulative GPA required for satisfactory academic progress at the time of this evaluation. Threshold may vary by student level (undergraduate, graduate) and program.',
    `ipeds_reportable` BOOLEAN COMMENT 'Indicates whether this SAP evaluation record should be included in IPEDS reporting submissions. True if reportable.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this SAP evaluation record is currently active and represents the most recent evaluation for the student in the given term. True if active, false if superseded or voided.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SAP evaluation record was last modified. Critical for tracking changes to SAP status and appeal decisions.',
    `maximum_timeframe_credits` DECIMAL(18,2) COMMENT 'Maximum number of credit hours allowed for the student to complete their program (typically 150% of published program length). Once exceeded, student loses Title IV eligibility.',
    `maximum_timeframe_met` BOOLEAN COMMENT 'Indicates whether the student is within the maximum timeframe allowed to complete their program. True if credits_attempted < maximum_timeframe_credits and student can mathematically complete within maximum timeframe.',
    `notification_date` DATE COMMENT 'Date on which the student was notified of their SAP evaluation results. Critical for compliance documentation.',
    `notification_method` STRING COMMENT 'Method by which the student was notified of SAP results: email, mail (postal), portal (student information system), or in_person (face-to-face meeting).. Valid values are `email|mail|portal|in_person`',
    `notification_sent` BOOLEAN COMMENT 'Indicates whether the student was formally notified of their SAP evaluation results. True if notification was sent.',
    `overall_sap_status` STRING COMMENT 'Overall SAP status determination: satisfactory (all requirements met), warning (first failure, aid continues), probation (appeal approved with academic plan, aid continues), suspension (aid suspended), or reinstatement (aid reinstated after successful appeal or plan completion).. Valid values are `satisfactory|warning|probation|suspension|reinstatement`',
    `pace_requirement_met` BOOLEAN COMMENT 'Indicates whether the student met the minimum completion rate (pace) requirement for SAP. True if completion_rate >= completion_rate_threshold.',
    `source_system` STRING COMMENT 'Name of the source system from which this SAP evaluation record originated (e.g., Ellucian Banner Financial Aid module). Used for data lineage and integration tracking.',
    CONSTRAINT pk_student_sap_evaluation PRIMARY KEY(`student_sap_evaluation_id`)
) COMMENT 'Records each formal Satisfactory Academic Progress (SAP) evaluation conducted for Title IV financial aid eligibility. Captures evaluation term, evaluation type (annual, mid-year, appeal), SAP component results (GPA threshold met, pace/completion rate met, maximum timeframe met), overall SAP status (satisfactory, warning, probation, suspension), financial aid impact (aid continued, aid suspended, aid reinstated), appeal submission date, appeal decision, academic plan attached flag, and evaluating financial aid counselor. Directly governs Title IV disbursement eligibility.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`degree_conferral` (
    `degree_conferral_id` BIGINT COMMENT 'Unique identifier for the degree conferral record. Primary key for this entity. This is the permanent, immutable record of academic credential award once conferred.',
    `academic_program_id` BIGINT COMMENT 'Reference to the academic program from which the degree was conferred. Links to the curriculum domain program catalog.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or process that created this record. Used for audit trail and accountability.',
    `identity_account_id` BIGINT COMMENT 'Identifier of the system user or process that last modified this record. Used for audit trail and accountability.',
    `profile_id` BIGINT COMMENT 'Reference to the student who received the degree. Links to the student master record in the Student Information System (SIS).',
    `scholarly_output_id` BIGINT COMMENT 'Foreign key linking to research.scholarly_output. Business justification: Doctoral and masters degrees often require thesis/dissertation as scholarly output; linking degree conferral to the resulting publication enables completion tracking, embargo management, and institut',
    `application_date` DATE COMMENT 'Date the student submitted their graduation application. Used to track application processing timelines and compliance with institutional deadlines.',
    `application_status` STRING COMMENT 'Current status of the graduation application. Tracks the application through the degree audit and conferral workflow.. Valid values are `pending|approved|denied|withdrawn|deferred|conferred`',
    `application_term_code` STRING COMMENT 'Academic term code in which the student applied for graduation. May differ from conferral term if application was submitted early or deferred.',
    `cip_code` STRING COMMENT 'Six-digit CIP code identifying the field of study. Required for IPEDS Completions Survey reporting and federal compliance.. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `commencement_ceremony_date` DATE COMMENT 'Date of the commencement ceremony the student attended or was eligible to attend. May differ from conferral date.',
    `commencement_ceremony_name` STRING COMMENT 'Name or identifier of the specific commencement ceremony (e.g., Spring 2023 Undergraduate Ceremony, College of Engineering Ceremony). Used when multiple ceremonies are held.',
    `commencement_participation_flag` BOOLEAN COMMENT 'Indicates whether the student participated in the commencement ceremony. Used for ceremony planning and alumni engagement.',
    `concentration` STRING COMMENT 'Specific concentration, specialization, or track within the major, if applicable. Appears on transcript and diploma when awarded.',
    `conferral_academic_year` STRING COMMENT 'Academic year in which the degree was conferred (e.g., 2022-2023). Used for annual reporting and trend analysis.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `conferral_date` DATE COMMENT 'Official date the degree was conferred by the institution. This is the authoritative date that appears on the diploma and transcript. Typically set by the Board of Trustees or Regents.',
    `conferral_term_code` STRING COMMENT 'Academic term code in which the degree was conferred (e.g., 202305 for Spring 2023). Used for cohort analysis and IPEDS reporting.',
    `conferring_college` STRING COMMENT 'Name of the college, school, or academic unit that conferred the degree (e.g., College of Engineering, School of Business). Used for organizational reporting.',
    `conferring_department` STRING COMMENT 'Academic department responsible for the program from which the degree was conferred. Used for departmental analytics and accreditation reporting.',
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

CREATE OR REPLACE TABLE `education_ecm`.`student`.`conduct_record` (
    `conduct_record_id` BIGINT COMMENT 'Unique identifier for the student conduct record. Primary key for the conduct record entity.',
    `term_id` BIGINT COMMENT 'Foreign key linking to enrollment.term. Business justification: Student conduct administration requires term context for sanction timing, enrollment impact assessment, and Clery Act reporting. Academic_term_code insufficient for automated hold placement tied to te',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Incident location is mandatory for Clery Act geographic reporting, Title IX compliance, and campus safety resource allocation. Structured building FK enables proper crime statistics by campus geograph',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Student conduct office operations (hearings, investigations, case management) are budgeted to specific cost center. Business process: conduct staff time and hearing costs are allocated to conduct affa',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Conduct violations are adjudicated under specific student conduct policies. Every conduct case cites the policy violated; sanctions and procedures are policy-driven. Essential for conduct case managem',
    `profile_id` BIGINT COMMENT 'Reference to the student who is the subject of this conduct record. Links to the student profile entity.',
    `appeal_conduct_record_id` BIGINT COMMENT 'Self-referencing FK on conduct_record (appeal_conduct_record_id)',
    `appeal_decision_date` DATE COMMENT 'The date on which the appeals authority rendered a final decision on the students appeal, concluding the appeals process.',
    `appeal_decision_rationale` STRING COMMENT 'Detailed explanation of the reasoning and justification for the appeals decision, documenting the basis for upholding, modifying, or overturning the original finding.',
    `appeal_grounds` STRING COMMENT 'The basis or rationale cited by the student for appealing the conduct finding or sanction (e.g., procedural error, new evidence, disproportionate sanction).',
    `appeal_status` STRING COMMENT 'Current status of the appeal, indicating the stage of review and whether the original finding or sanction has been affirmed, modified, or reversed.. Valid values are `pending|under_review|upheld|overturned|modified|denied`',
    `appeal_submission_date` DATE COMMENT 'The date on which the student formally submitted an appeal of the conduct finding or sanction to the appropriate appeals authority.',
    `appeal_submitted_flag` BOOLEAN COMMENT 'Indicates whether the student has submitted a formal appeal of the conduct finding or sanction, triggering the appeals review process.',
    `case_status` STRING COMMENT 'Current lifecycle status of the conduct case, tracking its progression through the institutional conduct process from report to resolution. [ENUM-REF-CANDIDATE: reported|under_investigation|pending_hearing|hearing_scheduled|resolved|closed|appealed — 7 candidates stripped; promote to reference product]',
    `clery_reportable_flag` BOOLEAN COMMENT 'Indicates whether this conduct incident meets the criteria for inclusion in the institutions annual Clery Act crime statistics report.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this conduct record was first created in the system, marking the initial capture of the case information.',
    `expungement_date` DATE COMMENT 'The date on which this conduct record was expunged or removed from the students permanent disciplinary record, if applicable.',
    `expungement_eligible_flag` BOOLEAN COMMENT 'Indicates whether this conduct record is eligible for expungement from the students permanent record based on institutional policy and time elapsed.',
    `ferpa_restriction_flag` BOOLEAN COMMENT 'Indicates whether this conduct record is subject to heightened FERPA privacy restrictions, limiting disclosure even beyond standard education record protections.',
    `finding` STRING COMMENT 'The official determination or verdict rendered by the hearing body regarding whether the student is responsible for the alleged conduct violation.. Valid values are `responsible|not_responsible|insufficient_evidence|no_violation`',
    `finding_date` DATE COMMENT 'The date on which the official finding or verdict was rendered by the hearing body or conduct officer.',
    `hearing_body` STRING COMMENT 'The specific entity or group responsible for conducting the hearing and rendering a decision (e.g., Student Conduct Board, Dean of Students, Conduct Officer).',
    `hearing_date` DATE COMMENT 'The scheduled or actual date of the formal conduct hearing where the case is adjudicated and a finding is determined.',
    `hearing_officer_name` STRING COMMENT 'Name of the primary hearing officer or administrator who presided over the conduct hearing and facilitated the adjudication process.',
    `hearing_required_flag` BOOLEAN COMMENT 'Indicates whether a formal conduct hearing is required for adjudication of this case, based on severity and institutional policy.',
    `hearing_type` STRING COMMENT 'The format or structure of the conduct hearing, indicating the adjudication process used for this case.. Valid values are `administrative|conduct_board|dean_review|expedited`',
    `incident_date` DATE COMMENT 'The date on which the alleged conduct violation occurred. This is the principal business event timestamp for the conduct record.',
    `incident_number` STRING COMMENT 'Externally-known unique identifier or case number assigned to this conduct incident for tracking and reference purposes.',
    `incident_time` TIMESTAMP COMMENT 'The specific time at which the alleged conduct violation occurred, providing precise temporal context for the incident.',
    `investigation_completion_date` DATE COMMENT 'The date on which the investigation was completed and findings were documented, marking readiness for adjudication.',
    `investigation_start_date` DATE COMMENT 'The date on which the formal investigation of the conduct incident was initiated by the conduct office or designated investigator.',
    `investigation_status` STRING COMMENT 'Current status of the investigation phase of the conduct case, indicating progress in gathering evidence and interviewing parties.. Valid values are `not_started|in_progress|completed|suspended|closed`',
    `investigator_name` STRING COMMENT 'Name of the staff member or official assigned to investigate the conduct incident and gather evidence.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this conduct record was most recently updated or modified, supporting audit trail and data lineage tracking.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or contextual information related to the conduct case, investigation, hearing, or sanction enforcement.',
    `report_date` DATE COMMENT 'The date on which the conduct incident was formally reported to the institution or conduct office.',
    `reporting_party_name` STRING COMMENT 'Name of the individual or entity who reported the conduct incident (e.g., faculty member, resident assistant, campus security).',
    `reporting_party_role` STRING COMMENT 'The role or affiliation of the individual who reported the conduct incident within the institutional community. [ENUM-REF-CANDIDATE: student|faculty|staff|campus_security|resident_assistant|external|anonymous — 7 candidates stripped; promote to reference product]',
    `sanction_completion_status` STRING COMMENT 'Current status indicating whether the student has fulfilled the requirements of the imposed sanction, tracking compliance and completion.. Valid values are `pending|in_progress|completed|not_completed|waived`',
    `sanction_description` STRING COMMENT 'Detailed description of the sanction imposed, including specific terms, conditions, requirements, and any additional stipulations the student must fulfill.',
    `sanction_end_date` DATE COMMENT 'The date on which the imposed sanction expires or is completed. Nullable for permanent sanctions such as expulsion.',
    `sanction_start_date` DATE COMMENT 'The effective date on which the imposed sanction begins. Marks the commencement of the disciplinary penalty or corrective action period.',
    `sanction_type` STRING COMMENT 'The primary type of disciplinary sanction imposed on the student as a result of a responsible finding. Defines the nature of the penalty or corrective action. [ENUM-REF-CANDIDATE: warning|probation|suspension|expulsion|community_service|educational_program|restitution|no_contact_order — 8 candidates stripped; promote to reference product]',
    `title_ix_related_flag` BOOLEAN COMMENT 'Indicates whether this conduct case involves allegations of sex-based discrimination, sexual harassment, or sexual violence covered under Title IX regulations.',
    `violation_code` STRING COMMENT 'Specific code or section reference from the institutional conduct code that was allegedly violated. Provides precise policy citation.',
    `violation_description` STRING COMMENT 'Detailed narrative description of the alleged conduct violation, including circumstances, actions, and context of the incident.',
    `violation_type` STRING COMMENT 'Primary category of the conduct code violation. Classifies the nature of the alleged misconduct for reporting and analysis purposes. [ENUM-REF-CANDIDATE: academic_integrity|behavioral|substance|harassment|violence|property_damage|policy — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_conduct_record PRIMARY KEY(`conduct_record_id`)
) COMMENT 'Tracks student disciplinary incidents, conduct code violations, investigations, hearings, sanctions, and outcomes. Captures incident date, violation type (academic integrity, behavioral, substance, harassment), reporting party, investigation status, hearing date, hearing body (conduct board, dean of students), finding (responsible, not responsible), sanction type (warning, probation, suspension, expulsion), sanction start and end dates, appeal status, and expungement eligibility. Supports Title IX coordination, Clery Act reporting, and student conduct history for readmission decisions.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`student_enrollment` (
    `student_enrollment_id` BIGINT COMMENT 'Primary key for student_enrollment',
    `course_section_id` BIGINT COMMENT 'Foreign key linking to the course section in which the student is enrolled',
    `enrollment_registration_id` BIGINT COMMENT 'Unique identifier for this enrollment record. Primary key for the enrollment association.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to the student profile who is enrolled in the course section',
    `term_id` BIGINT COMMENT 'Reference to the academic term for this enrollment. Denormalized from course_section for query performance and to support historical enrollment queries when section records may be archived.',
    `add_authorization_code` STRING COMMENT 'Authorization code provided by instructor or department to allow enrollment in a closed or restricted section. Captured from detection phase relationship data.',
    `add_date` DATE COMMENT 'Date when the student was added to the course section. Part of add/drop tracking mentioned in detection phase.',
    `credit_hours_attempted` DECIMAL(18,2) COMMENT 'Number of credit hours the student is attempting for this specific enrollment. May differ from the sections standard credit hours if student is taking for variable credit. Captured from detection phase relationship data.',
    `drop_date` DATE COMMENT 'Date when the student dropped or withdrew from the course section. Null if still enrolled. Part of add/drop tracking mentioned in detection phase.',
    `grade_mode` STRING COMMENT 'Grading scheme the student has selected for this enrollment. Captured from detection phase relationship data. Values: letter (standard A-F), pass_fail, audit (no grade), satisfactory_unsatisfactory.',
    `repeat_indicator` BOOLEAN COMMENT 'Indicates whether this enrollment is a repeat of a previously taken course. Used for grade replacement policies and academic standing calculations. Captured from detection phase relationship data.',
    `student_enrollment_date` TIMESTAMP COMMENT 'Timestamp when the student enrolled in this course section. Captured from the detection phase relationship data as enrollment_date.',
    `student_enrollment_status` STRING COMMENT 'Current status of the enrollment. Captured from detection phase as enrollment_status and registration_status. Values: enrolled (active), dropped (removed before census), withdrawn (removed after census), completed (finished course).',
    `waitlist_position` STRING COMMENT 'Position of the student on the waitlist if enrollment status is waitlisted. Null if student is enrolled or not on waitlist. Captured from detection phase relationship data.',
    CONSTRAINT pk_student_enrollment PRIMARY KEY(`student_enrollment_id`)
) COMMENT 'This association product represents the enrollment event between a student profile and a course section. It captures the operational record of a students registration in a specific course section for a specific term. Each record links one student to one course section with attributes that exist only in the context of this enrollment relationship, including registration status, grade mode, credit hours attempted, and waitlist information.. Existence Justification: Student enrollment in course sections is a canonical many-to-many relationship in higher education. One student enrolls in multiple course sections per term (typically 4-6 courses), and one course section has multiple enrolled students (typically 20-300 depending on course level and delivery mode). The enrollment relationship itself is a first-class business entity that the institution actively manages through registration workflows, add/drop processes, waitlist management, and grade mode selection.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`student_submission` (
    `student_submission_id` BIGINT COMMENT 'Primary key for student_submission',
    `instruction_assignment_id` BIGINT COMMENT 'Foreign key linking to the academic assignment being submitted',
    `instructor_id` BIGINT COMMENT 'Reference to the faculty or TA user who graded this submission. Used for grading workflow tracking and audit.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to the student profile who submitted the assignment',
    `instruction_submission_id` BIGINT COMMENT 'Primary key for the submission record. Uniquely identifies each student submission event.',
    `attempt_number` STRING COMMENT 'Sequential attempt number for this submission. Increments with each resubmission. Used when assignment allows multiple attempts.',
    `comments` STRING COMMENT 'Feedback comments provided by the grader to the student about their submission. May include suggestions for improvement or explanations of scoring.',
    `file_upload_path` STRING COMMENT 'Storage path or URL to the submitted file(s) in the institutional file system or LMS. Used for retrieval and archival.',
    `grade` STRING COMMENT 'The letter grade or qualitative assessment assigned to this submission (e.g., A, B+, Pass, Fail). Format depends on assignment.grading_type.',
    `graded_timestamp` TIMESTAMP COMMENT 'The date and time when the instructor or grader evaluated and scored this submission. Null if submission is not yet graded.',
    `is_excused` BOOLEAN COMMENT 'Indicates whether the student has been excused from this assignment due to accommodations, illness, or other approved reasons. Excused submissions do not count against grade.',
    `is_late` BOOLEAN COMMENT 'Indicates whether the submission was received after the assignment due_date. Automatically calculated by comparing submission_timestamp to due_date.',
    `score` DECIMAL(18,2) COMMENT 'The numeric score awarded to the student for this submission. Must be less than or equal to assignment.points_possible.',
    `submission_timestamp` TIMESTAMP COMMENT 'The exact date and time when the student submitted their work. Used to determine late status by comparing against assignment due_date.',
    `submission_type` STRING COMMENT 'The method by which the student submitted their work. Must align with the allowed submission_type on the assignment.',
    `turnitin_score` DECIMAL(18,2) COMMENT 'Percentage similarity score from Turnitin or similar plagiarism detection service. Null if plagiarism checking is not enabled for this assignment.',
    `workflow_state` STRING COMMENT 'Current state of the submission in the grading workflow. Tracks progression from submission through grading to return.',
    CONSTRAINT pk_student_submission PRIMARY KEY(`student_submission_id`)
) COMMENT 'This association product represents the submission event between a student profile and an academic assignment. It captures the act of a student submitting work for evaluation, including submission timing, attempt tracking, grading outcomes, and late/excused status. Each record links one student to one assignment submission instance with attributes that exist only in the context of this specific submission event.. Existence Justification: Student assignment submission is a genuine operational M:N relationship. In real academic operations, one student submits work to many assignments across multiple courses throughout a term, and one assignment receives submissions from many enrolled students. The submission itself is a recognized business event that faculty and students actively manage, with distinct attributes (submission timing, attempt number, score, late status, grading feedback) that belong to neither the student profile nor the assignment alone.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`checkout` (
    `checkout_id` BIGINT COMMENT 'Unique identifier for this checkout transaction. Primary key for the checkout association.',
    `it_asset_id` BIGINT COMMENT 'Foreign key to technology.it_asset.it_asset_id identifying the asset that was checked out',
    `profile_id` BIGINT COMMENT 'Foreign key to student.profile.profile_id identifying the student who checked out the asset',
    `employee_id` BIGINT COMMENT 'Foreign key to the IT staff employee who processed the checkout transaction and is responsible for condition assessment and compliance tracking',
    `checkout_date` TIMESTAMP COMMENT 'Date and time when the student checked out the IT asset from the lending facility',
    `checkout_status` STRING COMMENT 'Current status of the checkout transaction tracking the lifecycle from active checkout through return or loss',
    `condition_at_checkout` STRING COMMENT 'Assessment of the IT assets physical and functional condition at the time of checkout, documented to establish baseline for return comparison',
    `condition_at_return` STRING COMMENT 'Assessment of the IT assets physical and functional condition at the time of return, compared against checkout condition to identify damage',
    `damage_fee_assessed` DECIMAL(18,2) COMMENT 'Monetary fee assessed to the student for damage to the IT asset beyond normal wear and tear, determined by comparing checkout and return conditions',
    `expected_return_date` DATE COMMENT 'Date by which the student is expected to return the IT asset, used for compliance tracking and overdue notifications',
    `location` STRING COMMENT 'Physical location (building/room) where the checkout transaction occurred, typically an IT help desk or equipment lending office',
    `purpose` STRING COMMENT 'Business reason or purpose for the checkout (e.g., coursework, research project, temporary replacement, semester loan, emergency access)',
    `return_date` TIMESTAMP COMMENT 'Date and time when the student returned the IT asset to the lending facility. Null if asset is still checked out.',
    CONSTRAINT pk_checkout PRIMARY KEY(`checkout_id`)
) COMMENT 'This association product represents the lending transaction between a student and an IT asset. It captures the operational checkout process managed by IT departments for equipment lending (laptops, tablets, hotspots, lab equipment). Each record links one student to one IT asset for a specific checkout period with attributes that exist only in the context of this lending relationship, including checkout/return dates, condition assessments, damage fees, and responsible staff.. Existence Justification: In higher education IT operations, students check out multiple IT assets over time (laptops, tablets, hotspots, lab equipment for coursework or temporary needs), and each IT asset is checked out by multiple students across semesters and academic years. IT departments actively manage this lending operation as a core service, tracking each checkout transaction with temporal attributes (checkout/return dates), condition assessments at both checkout and return, damage fees, responsible staff, and compliance status. This is an operational business process where the checkout itself is a managed entity.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`student_training_completion` (
    `student_training_completion_id` BIGINT COMMENT 'Primary key for student_training_completion',
    `profile_id` BIGINT COMMENT 'Foreign key linking to the student profile who completed or is assigned the training',
    `compliance_training_completion_id` BIGINT COMMENT 'Unique identifier for this training completion record. Primary key for the association.',
    `training_program_id` BIGINT COMMENT 'Foreign key linking to the compliance training program that was completed',
    `assessment_score` DECIMAL(18,2) COMMENT 'Percentage score achieved on the training assessment (0.00 to 100.00). Null if training has not been attempted or does not include an assessment. Compared against training_program.passing_score_percentage to determine pass/fail. Explicitly identified in detection phase relationship data.',
    `assignment_date` DATE COMMENT 'Date when this training was assigned to the student. Used to calculate completion deadline based on training_program.completion_deadline_days.',
    `attempt_number` STRING COMMENT 'Sequential attempt number for this training assignment. Increments each time the student retakes the training (e.g., after failure or for recertification). First attempt is 1. Explicitly identified in detection phase relationship data.',
    `certificate_number` STRING COMMENT 'Unique certificate number issued upon successful completion of the training. Only populated if training_program.certificate_issued_flag is true and completion_status is completed. Used for audit and verification purposes. Explicitly identified in detection phase relationship data.',
    `completion_date` DATE COMMENT 'Date when the student successfully completed the training program. Null if training is not yet completed. Explicitly identified in detection phase relationship data.',
    `completion_status` STRING COMMENT 'Current status of the training completion. Values: assigned (not started), in_progress (started but not finished), completed (successfully finished), failed (did not pass assessment), expired (deadline passed without completion), waived (exempted by compliance office). Explicitly identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training completion record was created in the system.',
    `expiration_date` DATE COMMENT 'Date when this training completion expires and recertification is required. Calculated as completion_date plus training_program.recertification_frequency_months. Null if training does not require recertification. Explicitly identified in detection phase relationship data.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this training completion record was last modified.',
    `time_spent_minutes` STRING COMMENT 'Total time in minutes the student spent on the training content, tracked by the LMS. Used for audit compliance and to verify engagement.',
    `waiver_approved_by` STRING COMMENT 'Name or ID of the compliance officer who approved the training waiver. Only populated if completion_status is waived.',
    `waiver_approved_date` DATE COMMENT 'Date when the training waiver was approved. Only populated if completion_status is waived.',
    `waiver_reason` STRING COMMENT 'Explanation for why the training requirement was waived for this student. Only populated if completion_status is waived. Examples: prior training at another institution, role exemption, medical accommodation.',
    CONSTRAINT pk_student_training_completion PRIMARY KEY(`student_training_completion_id`)
) COMMENT 'This association product represents the completion event between a student profile and a compliance training program. It captures the students participation in mandatory compliance training, including completion status, assessment scores, certificate issuance, and recertification tracking. Each record links one student to one training program with attributes that exist only in the context of this specific training completion.. Existence Justification: In higher education compliance operations, students are required to complete multiple mandatory training programs (Title IX, FERPA, Clery Act, academic integrity, research ethics), and each training program is completed by many students across different cohorts and time periods. The compliance office actively manages these training completions as a distinct business process, tracking assignment, progress, scores, certificates, and recertification cycles for audit and regulatory reporting purposes.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`student_housing_assignment` (
    `student_housing_assignment_id` BIGINT COMMENT 'Primary key for student_housing_assignment',
    `studentlife_housing_assignment_id` BIGINT COMMENT 'Unique identifier for this housing assignment record. Primary key.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to the student profile who is assigned to the room',
    `room_id` BIGINT COMMENT 'Foreign key linking to the residential room being assigned',
    `access_level` STRING COMMENT 'The level of physical access the student has to the assigned room. Full access for standard occupants, restricted for probationary status, guest for temporary visitors, suspended for disciplinary holds.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the housing assignment. Pending for future assignments, active for current occupancy, completed for past assignments, cancelled for withdrawn assignments, no-show for students who never moved in.',
    `assignment_type` STRING COMMENT 'Classification of the housing assignment period (academic year, semester, summer session, temporary, break housing). Determines billing cycle and contract terms.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this housing assignment record was created.',
    `end_date` DATE COMMENT 'The date when the students housing assignment ends and they must vacate the room. Used for move-out scheduling and billing end. May be null for ongoing assignments.',
    `key_card_issued` BOOLEAN COMMENT 'Indicates whether a physical key card or access credential has been issued to the student for this room assignment. Used for key inventory management and security audits.',
    `key_card_number` STRING COMMENT 'The unique identifier of the physical key card issued to the student for room access. Used for lost key tracking and replacement billing.',
    `meal_plan_code` STRING COMMENT 'The meal plan associated with this housing assignment, if required. Many residential halls require meal plan enrollment. Links to dining services billing.',
    `primary_occupant_flag` BOOLEAN COMMENT 'Indicates whether this student is designated as the primary occupant of the room (true) or a secondary roommate (false). Used for billing responsibility and room preference priority in multi-occupancy rooms.',
    `room_rate_code` STRING COMMENT 'The billing rate code applied to this specific assignment, which may vary based on room type, assignment duration, and student financial aid status. Links to housing billing system.',
    `special_accommodations` STRING COMMENT 'Description of any ADA or medical accommodations approved for this housing assignment (e.g., ground floor, private bathroom, emotional support animal). Sensitive data requiring FERPA protection.',
    `start_date` DATE COMMENT 'The date when the students housing assignment begins and they are authorized to occupy the room. Used for move-in scheduling and billing start.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this housing assignment record was last modified.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this assignment record.',
    CONSTRAINT pk_student_housing_assignment PRIMARY KEY(`student_housing_assignment_id`)
) COMMENT 'This association product represents the assignment of a student to a residential room within campus housing. It captures the operational relationship between students and their assigned living spaces across academic terms. Each record links one student profile to one room with attributes that track assignment dates, occupancy type, access credentials, and roommate designation. This is the authoritative source for residential life operations, key management, and housing billing.. Existence Justification: Student housing assignment is a true operational many-to-many relationship in higher education. Students are assigned to multiple rooms over their academic career (freshman dorm, sophomore suite, off-campus return, summer housing), and rooms house multiple students both simultaneously (doubles, triples, suites with 2-4 occupants) and sequentially across terms. Residential Life actively manages these assignments as discrete operational records with assignment dates, key issuance, access levels, billing rates, and roommate designations.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`access_authorization` (
    `access_authorization_id` BIGINT COMMENT 'Unique identifier for this building access authorization record. Primary key for the association.',
    `building_id` BIGINT COMMENT 'Foreign key linking to the building for which access is authorized',
    `profile_id` BIGINT COMMENT 'Foreign key linking to the student profile who is authorized for building access',
    `access_level` STRING COMMENT 'Level of access granted within the building indicating which areas the student can access (basic common areas, restricted labs/studios, full building access, emergency exits only). Determines which card readers will grant entry.',
    `access_type` STRING COMMENT 'Type of access authorization indicating the business reason for access (research project, student employment, academic program requirement, administrative role, athletic facility use). Determines authorization workflow and approval requirements.',
    `after_hours_access` BOOLEAN COMMENT 'Indicates whether the student is authorized for building access outside of normal operating hours (evenings, weekends, holidays). Requires additional approval for security and safety reasons.',
    `authorization_end_date` DATE COMMENT 'Date on which the students building access authorization expires. Card access is automatically disabled after this date. May be extended through reauthorization process.',
    `authorization_start_date` DATE COMMENT 'Date on which the students building access authorization becomes active. Card access is enabled starting on this date.',
    `authorization_status` STRING COMMENT 'Current lifecycle status of the access authorization indicating whether it is active, expired, revoked for cause, temporarily suspended, or pending approval.',
    `authorizing_department` STRING COMMENT 'Academic department, research lab, or administrative unit that requested and approved this access authorization. Responsible for periodic review and reauthorization.',
    `card_access_enabled` BOOLEAN COMMENT 'Indicates whether card access is currently active for this authorization. May be temporarily disabled for security holds, disciplinary actions, or system maintenance without deleting the authorization record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this access authorization record was created in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this access authorization record.',
    `revocation_reason` STRING COMMENT 'Reason for access revocation if authorization was terminated before the end date (project completion, employment termination, security violation, graduation, program withdrawal).',
    `supervisor_name` STRING COMMENT 'Name of the faculty member, principal investigator, or supervisor who authorized this access. Required for research and employment-based access.',
    CONSTRAINT pk_access_authorization PRIMARY KEY(`access_authorization_id`)
) COMMENT 'This association product represents the authorization relationship between students and buildings for physical access control. It captures time-bound, role-specific access permissions for research students, graduate assistants, and student employees who require card access to lab buildings, libraries, studios, and other facilities. Each record links one student profile to one building with authorization dates, access levels, and permission types that exist only in the context of this access relationship. Critical for campus security, facilities access management, and compliance with physical security policies.. Existence Justification: In higher education operations, students require physical access to multiple buildings simultaneously based on their research projects, employment positions, and academic program requirements (labs, libraries, studios, athletic facilities). Conversely, each building grants access to many students with varying authorization types, access levels, and time periods. Building access authorization is an actively managed operational process where facilities and campus security create, review, extend, and revoke access permissions with specific attributes (dates, access levels, after-hours permissions) that belong to each student-building authorization relationship.';

CREATE OR REPLACE TABLE `education_ecm`.`student`.`participation` (
    `participation_id` BIGINT COMMENT 'Unique identifier for this student-protocol participation record. Primary key for the participation association.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to the student profile who is participating as a human subject in the research protocol.',
    `irb_protocol_id` BIGINT COMMENT 'Foreign key linking to the IRB protocol in which the student is participating.',
    `adverse_event_flag` BOOLEAN COMMENT 'Indicates whether this student experienced any adverse events during their participation in this protocol. Adverse events must be reported to the IRB within specified timeframes and tracked for safety monitoring.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Total monetary compensation paid to the student for their participation in the research study. Must be disclosed in informed consent and tracked for IRB compliance and financial reporting.',
    `compensation_paid_date` DATE COMMENT 'Date on which compensation was paid to the student participant. Used for financial reconciliation and to ensure timely payment per IRB-approved protocol.',
    `completion_date` DATE COMMENT 'Date on which the student completed all study procedures and their participation ended normally. Used for protocol closeout reporting and to calculate actual vs. planned study duration.',
    `consent_date` DATE COMMENT 'Date on which the student provided informed consent to participate in the research protocol. Required for IRB compliance and must be on or after the protocol approval date. Critical for OHRP audits.',
    `enrollment_date` DATE COMMENT 'Date on which the student was formally enrolled as a participant in the research study. Typically the same as or shortly after consent_date. Used to track actual enrollment against estimated enrollment in the IRB protocol.',
    `participation_role` STRING COMMENT 'The role in which the student is participating in the research protocol. Most commonly subject for human subjects research, but can also include co-investigator or research_assistant for students who are part of the research team.',
    `participation_status` STRING COMMENT 'Current lifecycle status of this students participation in the protocol. Tracks progression from enrollment through completion or withdrawal. Used for continuing review reporting and protocol closeout.',
    `withdrawal_date` DATE COMMENT 'Date on which the student withdrew from the research study prior to completion. Withdrawal is a participant right under IRB regulations. Used to track attrition rates and must be reported in continuing reviews.',
    `withdrawal_reason` STRING COMMENT 'Narrative or coded reason for the students withdrawal from the study (e.g., participant request, adverse event, lost to follow-up, protocol violation). Required for IRB continuing review and safety monitoring.',
    CONSTRAINT pk_participation PRIMARY KEY(`participation_id`)
) COMMENT 'This association product represents the participation relationship between a student profile and an IRB research protocol. It captures the operational record of a students involvement as a human subject in an IRB-approved research study. Each record links one student to one research protocol with attributes that track consent, enrollment timing, participation status, role, and adverse events specific to that students participation in that specific study. Required for IRB compliance, continuing review, OHRP reporting, and protocol closeout.. Existence Justification: In higher education research operations, students participate as human subjects in multiple IRB-approved research protocols (psychology studies, clinical trials, educational research), and each protocol enrolls multiple student participants. Universities actively manage these participation relationships through IRB compliance workflows including consent tracking, enrollment monitoring, adverse event reporting, continuing review, and protocol closeout. The participation relationship is an operational business entity with specific attributes (consent dates, enrollment status, adverse events, compensation) that belong to neither the student profile nor the protocol alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `education_ecm`.`student`.`academic_standing` ADD CONSTRAINT `fk_student_academic_standing_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`degree_progress` ADD CONSTRAINT `fk_student_degree_progress_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ADD CONSTRAINT `fk_student_enrollment_status_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`academic_history` ADD CONSTRAINT `fk_student_academic_history_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`student_test_score` ADD CONSTRAINT `fk_student_student_test_score_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ADD CONSTRAINT `fk_student_transfer_credit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`hold` ADD CONSTRAINT `fk_student_hold_conduct_record_id` FOREIGN KEY (`conduct_record_id`) REFERENCES `education_ecm`.`student`.`conduct_record`(`conduct_record_id`);
ALTER TABLE `education_ecm`.`student`.`hold` ADD CONSTRAINT `fk_student_hold_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ADD CONSTRAINT `fk_student_leave_of_absence_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ADD CONSTRAINT `fk_student_cohort_membership_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ADD CONSTRAINT `fk_student_ferpa_consent_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`residency_classification` ADD CONSTRAINT `fk_student_residency_classification_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ADD CONSTRAINT `fk_student_visa_immigration_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`graduation_application` ADD CONSTRAINT `fk_student_graduation_application_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`advising_note` ADD CONSTRAINT `fk_student_advising_note_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ADD CONSTRAINT `fk_student_student_early_alert_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ADD CONSTRAINT `fk_student_disability_accommodation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ADD CONSTRAINT `fk_student_student_sap_evaluation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ADD CONSTRAINT `fk_student_degree_conferral_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`conduct_record` ADD CONSTRAINT `fk_student_conduct_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`conduct_record` ADD CONSTRAINT `fk_student_conduct_record_appeal_conduct_record_id` FOREIGN KEY (`appeal_conduct_record_id`) REFERENCES `education_ecm`.`student`.`conduct_record`(`conduct_record_id`);
ALTER TABLE `education_ecm`.`student`.`student_enrollment` ADD CONSTRAINT `fk_student_student_enrollment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`student_submission` ADD CONSTRAINT `fk_student_student_submission_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`checkout` ADD CONSTRAINT `fk_student_checkout_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`student_training_completion` ADD CONSTRAINT `fk_student_student_training_completion_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ADD CONSTRAINT `fk_student_student_housing_assignment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`access_authorization` ADD CONSTRAINT `fk_student_access_authorization_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);
ALTER TABLE `education_ecm`.`student`.`participation` ADD CONSTRAINT `fk_student_participation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `education_ecm`.`student`.`profile`(`profile_id`);

-- ========= TAGS =========
ALTER SCHEMA `education_ecm`.`student` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `education_ecm`.`student` SET TAGS ('dbx_domain' = 'student');
ALTER TABLE `education_ecm`.`student`.`profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`student`.`profile` SET TAGS ('dbx_subdomain' = 'academic_records');
ALTER TABLE `education_ecm`.`student`.`profile` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Profile ID');
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
ALTER TABLE `education_ecm`.`student`.`academic_standing` SET TAGS ('dbx_subdomain' = 'academic_records');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `academic_standing_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Standing ID');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator ID');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Plan ID');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term ID');
ALTER TABLE `education_ecm`.`student`.`academic_standing` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
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
ALTER TABLE `education_ecm`.`student`.`degree_progress` SET TAGS ('dbx_subdomain' = 'academic_records');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `degree_progress_id` SET TAGS ('dbx_business_glossary_term' = 'Degree Progress ID');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program ID');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `accreditation_review_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Review Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `anticipated_graduation_term` SET TAGS ('dbx_business_glossary_term' = 'Anticipated Graduation Term');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `anticipated_graduation_term` SET TAGS ('dbx_value_regex' = '^(Fall|Spring|Summer)sd{4}$');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `catalog_year` SET TAGS ('dbx_business_glossary_term' = 'Catalog Year');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `catalog_year` SET TAGS ('dbx_value_regex' = '^d{4}-d{4}$');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^d{2}.d{4}$');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `concentration_code` SET TAGS ('dbx_business_glossary_term' = 'Concentration Code');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `concentration_name` SET TAGS ('dbx_business_glossary_term' = 'Concentration Name');
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
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `graduation_application_date` SET TAGS ('dbx_business_glossary_term' = 'Graduation Application Date');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `graduation_application_status` SET TAGS ('dbx_business_glossary_term' = 'Graduation Application Status');
ALTER TABLE `education_ecm`.`student`.`degree_progress` ALTER COLUMN `graduation_application_status` SET TAGS ('dbx_value_regex' = 'not_applied|applied|approved|denied|conferred');
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
ALTER TABLE `education_ecm`.`student`.`enrollment_status` SET TAGS ('dbx_subdomain' = 'academic_records');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `enrollment_status_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status ID');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `academic_standing` SET TAGS ('dbx_business_glossary_term' = 'Academic Standing');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `academic_standing` SET TAGS ('dbx_value_regex' = 'good-standing|probation|suspension|dismissal|warning');
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
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `primary_college_code` SET TAGS ('dbx_business_glossary_term' = 'Primary College Code');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `primary_college_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `primary_major_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Major Code');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `primary_major_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `re_enrollment_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Re-Enrollment Eligibility Status');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `re_enrollment_eligibility` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|conditional|pending-review');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `record_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User ID');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `record_updated_by` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._-]{1,50}$');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `residency_status` SET TAGS ('dbx_business_glossary_term' = 'Residency Status');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `residency_status` SET TAGS ('dbx_value_regex' = 'in-state|out-of-state|international|reciprocity');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `sap_status` SET TAGS ('dbx_business_glossary_term' = 'Satisfactory Academic Progress (SAP) Status');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `sap_status` SET TAGS ('dbx_value_regex' = 'meeting|warning|suspension|appeal-approved|appeal-denied');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Code');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `term_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `veteran_status_indicator` SET TAGS ('dbx_business_glossary_term' = 'Veteran Status Indicator');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `withdrawal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason Code');
ALTER TABLE `education_ecm`.`student`.`enrollment_status` ALTER COLUMN `withdrawal_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `education_ecm`.`student`.`academic_history` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`student`.`academic_history` SET TAGS ('dbx_subdomain' = 'academic_records');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `academic_history_id` SET TAGS ('dbx_business_glossary_term' = 'Academic History ID');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `accreditation_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Accreditation Standard Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course ID');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Section ID');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Instructor ID');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'It Asset Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `irb_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Research Irb Protocol Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Research Principal Investigator Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`academic_history` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Term ID');
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
ALTER TABLE `education_ecm`.`student`.`student_test_score` SET TAGS ('dbx_subdomain' = 'academic_records');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `student_test_score_id` SET TAGS ('dbx_business_glossary_term' = 'Student Test Score Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `enrollment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `composite_score` SET TAGS ('dbx_business_glossary_term' = 'Composite Score');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `official_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Official Verification Status');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `official_verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected|not_required');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `percentile_rank` SET TAGS ('dbx_business_glossary_term' = 'Percentile Rank');
ALTER TABLE `education_ecm`.`student`.`student_test_score` ALTER COLUMN `received_by` SET TAGS ('dbx_business_glossary_term' = 'Received By');
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
ALTER TABLE `education_ecm`.`student`.`transfer_credit` SET TAGS ('dbx_subdomain' = 'academic_records');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `transfer_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Credit ID');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `articulation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Articulation Agreement ID');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator ID');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Equivalent Course ID');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`transfer_credit` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
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
ALTER TABLE `education_ecm`.`student`.`hold` SET TAGS ('dbx_subdomain' = 'compliance_services');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `hold_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `conduct_record_id` SET TAGS ('dbx_business_glossary_term' = 'Conduct Record Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
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
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `originating_office` SET TAGS ('dbx_business_glossary_term' = 'Originating Office');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `override_allowed` SET TAGS ('dbx_business_glossary_term' = 'Override Allowed Indicator');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `override_authority` SET TAGS ('dbx_business_glossary_term' = 'Override Authority');
ALTER TABLE `education_ecm`.`student`.`hold` ALTER COLUMN `placed_by` SET TAGS ('dbx_business_glossary_term' = 'Hold Placed By User');
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
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` SET TAGS ('dbx_subdomain' = 'compliance_services');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `leave_of_absence_id` SET TAGS ('dbx_business_glossary_term' = 'Leave of Absence (LOA) Identifier');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Start Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `academic_standing_at_leave` SET TAGS ('dbx_business_glossary_term' = 'Academic Standing at Leave');
ALTER TABLE `education_ecm`.`student`.`leave_of_absence` ALTER COLUMN `academic_standing_at_leave` SET TAGS ('dbx_value_regex' = 'good_standing|academic_probation|academic_suspension|academic_dismissal');
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
ALTER TABLE `education_ecm`.`student`.`cohort_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` SET TAGS ('dbx_subdomain' = 'compliance_services');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `cohort_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Cohort Membership Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Entry Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `cohort_code` SET TAGS ('dbx_business_glossary_term' = 'Cohort Code');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `cohort_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `cohort_name` SET TAGS ('dbx_business_glossary_term' = 'Cohort Name');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `cohort_notes` SET TAGS ('dbx_business_glossary_term' = 'Cohort Membership Notes');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `cohort_type` SET TAGS ('dbx_business_glossary_term' = 'Cohort Type');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `cohort_year` SET TAGS ('dbx_business_glossary_term' = 'Cohort Year');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `completion_within_100_pct_flag` SET TAGS ('dbx_business_glossary_term' = 'Completion Within 100 Percent Time Flag');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `completion_within_150_pct_flag` SET TAGS ('dbx_business_glossary_term' = 'Completion Within 150 Percent Time Flag');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `completion_within_200_pct_flag` SET TAGS ('dbx_business_glossary_term' = 'Completion Within 200 Percent Time Flag');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'Valid|Under Review|Incomplete|Corrected|Flagged for Audit');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `degree_seeking_flag` SET TAGS ('dbx_business_glossary_term' = 'Degree-Seeking Flag');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Cohort Entry Date');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `exclusion_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Date');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'IPEDS Exclusion Reason');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_value_regex' = 'Death|Permanent Disability|Military Service|Foreign Aid Service|Official Church Mission|None');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `first_time_flag` SET TAGS ('dbx_business_glossary_term' = 'First-Time Student Flag');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `full_time_status_flag` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Status Flag');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `graduation_date` SET TAGS ('dbx_business_glossary_term' = 'Graduation Date');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `graduation_term_code` SET TAGS ('dbx_business_glossary_term' = 'Graduation Term Code');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `graduation_term_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `ipeds_cohort_flag` SET TAGS ('dbx_business_glossary_term' = 'IPEDS (Integrated Postsecondary Education Data System) Cohort Flag');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `ipeds_submission_year` SET TAGS ('dbx_business_glossary_term' = 'IPEDS (Integrated Postsecondary Education Data System) Submission Year');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Cohort Membership Status');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `outcome_determination_date` SET TAGS ('dbx_business_glossary_term' = 'Outcome Determination Date');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `pell_recipient_flag` SET TAGS ('dbx_business_glossary_term' = 'Pell Grant Recipient Flag');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `persistence_flag` SET TAGS ('dbx_business_glossary_term' = 'Persistence Flag');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'Reporting Framework');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `retention_flag` SET TAGS ('dbx_business_glossary_term' = 'Retention Flag');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Banner SIS|Institutional Research|Manual Entry|Data Warehouse|External Feed');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `subsidized_loan_recipient_flag` SET TAGS ('dbx_business_glossary_term' = 'Subsidized Loan Recipient Flag');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `transfer_out_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Out Date');
ALTER TABLE `education_ecm`.`student`.`cohort_membership` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` SET TAGS ('dbx_subdomain' = 'compliance_services');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `ferpa_consent_id` SET TAGS ('dbx_business_glossary_term' = 'FERPA (Family Educational Rights and Privacy Act) Consent ID');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized By Staff ID');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`ferpa_consent` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
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
ALTER TABLE `education_ecm`.`student`.`residency_classification` SET TAGS ('dbx_subdomain' = 'academic_records');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `residency_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Residency Classification ID');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Effective Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer User ID');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`residency_classification` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
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
ALTER TABLE `education_ecm`.`student`.`visa_immigration` SET TAGS ('dbx_subdomain' = 'compliance_services');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `visa_immigration_id` SET TAGS ('dbx_business_glossary_term' = 'Visa Immigration Record ID');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `export_control_review_id` SET TAGS ('dbx_business_glossary_term' = 'Export Control Review Id (Foreign Key)');
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
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `dso_email` SET TAGS ('dbx_business_glossary_term' = 'Designated School Official (DSO) Email Address');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `dso_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `dso_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `dso_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`student`.`visa_immigration` ALTER COLUMN `dso_name` SET TAGS ('dbx_business_glossary_term' = 'Designated School Official (DSO) Name');
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
ALTER TABLE `education_ecm`.`student`.`graduation_application` SET TAGS ('dbx_subdomain' = 'academic_records');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `graduation_application_id` SET TAGS ('dbx_business_glossary_term' = 'Graduation Application ID');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Application Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
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
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `concentration_code` SET TAGS ('dbx_business_glossary_term' = 'Concentration Code');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `degree_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Degree Audit Date');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `degree_audit_performed_by` SET TAGS ('dbx_business_glossary_term' = 'Degree Audit Performed By');
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
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Code');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `special_recognition` SET TAGS ('dbx_business_glossary_term' = 'Special Recognition');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `total_credits_earned` SET TAGS ('dbx_business_glossary_term' = 'Total Credits Earned');
ALTER TABLE `education_ecm`.`student`.`graduation_application` ALTER COLUMN `transfer_credits_accepted` SET TAGS ('dbx_business_glossary_term' = 'Transfer Credits Accepted');
ALTER TABLE `education_ecm`.`student`.`advising_note` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`student`.`advising_note` SET TAGS ('dbx_subdomain' = 'support_interventions');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `advising_note_id` SET TAGS ('dbx_business_glossary_term' = 'Advising Note Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Advisor Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `action_items_assigned` SET TAGS ('dbx_business_glossary_term' = 'Action Items Assigned');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `alert_source` SET TAGS ('dbx_business_glossary_term' = 'Alert Source');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `alert_source` SET TAGS ('dbx_value_regex' = 'faculty_referral|system_generated|self_referral|peer_referral|staff_referral');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `alert_trigger` SET TAGS ('dbx_business_glossary_term' = 'Alert Trigger');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `alert_trigger` SET TAGS ('dbx_value_regex' = 'attendance|grade|engagement|financial|behavioral|none');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `case_resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Case Resolution Status');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `case_resolution_status` SET TAGS ('dbx_value_regex' = 'open|closed|pending|transferred');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `course_of_concern` SET TAGS ('dbx_business_glossary_term' = 'Course of Concern');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `credits_earned_at_time_of_note` SET TAGS ('dbx_business_glossary_term' = 'Credits Earned at Time of Note');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `ferpa_sensitive_flag` SET TAGS ('dbx_business_glossary_term' = 'FERPA (Family Educational Rights and Privacy Act) Sensitive Flag');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `gpa_at_time_of_note` SET TAGS ('dbx_business_glossary_term' = 'Grade Point Average (GPA) at Time of Note');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `intervention_outcome` SET TAGS ('dbx_business_glossary_term' = 'Intervention Outcome');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `intervention_outcome` SET TAGS ('dbx_value_regex' = 'resolved|in_progress|escalated|no_response|declined');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Meeting Date');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `meeting_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Meeting Duration in Minutes');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `meeting_modality` SET TAGS ('dbx_business_glossary_term' = 'Meeting Modality');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `meeting_modality` SET TAGS ('dbx_value_regex' = 'in_person|virtual|phone|email|text');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `note_text` SET TAGS ('dbx_business_glossary_term' = 'Note Text');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `note_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `note_type` SET TAGS ('dbx_business_glossary_term' = 'Note Type');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `note_type` SET TAGS ('dbx_value_regex' = 'academic_plan|early_alert|degree_audit_review|probation_counseling|career_advising|retention_intervention');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `note_visibility` SET TAGS ('dbx_business_glossary_term' = 'Note Visibility');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `note_visibility` SET TAGS ('dbx_value_regex' = 'private|shared_with_advisors|shared_with_faculty|public');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `referral_made` SET TAGS ('dbx_business_glossary_term' = 'Referral Made');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `sap_status_at_time_of_note` SET TAGS ('dbx_business_glossary_term' = 'Satisfactory Academic Progress (SAP) Status at Time of Note');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `sap_status_at_time_of_note` SET TAGS ('dbx_value_regex' = 'satisfactory|warning|probation|suspension');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'banner|starfish|navigate|peoplesoft|custom');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `student_attendance_status` SET TAGS ('dbx_business_glossary_term' = 'Student Attendance Status');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `student_attendance_status` SET TAGS ('dbx_value_regex' = 'attended|no_show|cancelled|rescheduled');
ALTER TABLE `education_ecm`.`student`.`advising_note` ALTER COLUMN `topics_discussed` SET TAGS ('dbx_business_glossary_term' = 'Topics Discussed');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` SET TAGS ('dbx_subdomain' = 'support_interventions');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `student_early_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Student Early Alert ID');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Case Owner ID');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `alert_date` SET TAGS ('dbx_business_glossary_term' = 'Alert Date');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `alert_description` SET TAGS ('dbx_business_glossary_term' = 'Alert Description');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `alert_notes` SET TAGS ('dbx_business_glossary_term' = 'Alert Notes');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `alert_number` SET TAGS ('dbx_business_glossary_term' = 'Alert Number');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `alert_number` SET TAGS ('dbx_value_regex' = '^EA-[0-9]{8}$');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `alert_source` SET TAGS ('dbx_business_glossary_term' = 'Alert Source');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `alert_subtype` SET TAGS ('dbx_business_glossary_term' = 'Alert Subtype');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `alert_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Timestamp');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_business_glossary_term' = 'Alert Type');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_value_regex' = 'attendance|academic_performance|engagement|financial|behavioral|health_wellness');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `contact_method` SET TAGS ('dbx_business_glossary_term' = 'Contact Method');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|in_person|text_message|video_conference|no_contact_yet');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `course_number` SET TAGS ('dbx_business_glossary_term' = 'Course Number');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `course_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3,4}[A-Z]?$');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `course_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Course Reference Number (CRN)');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `course_reference_number` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `course_subject_code` SET TAGS ('dbx_business_glossary_term' = 'Course Subject Code');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `course_subject_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `ferpa_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Family Educational Rights and Privacy Act (FERPA) Restriction Flag');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `final_course_grade` SET TAGS ('dbx_business_glossary_term' = 'Final Course Grade');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `final_course_grade` SET TAGS ('dbx_value_regex' = '^[A-F][+-]?$|^W$|^I$|^P$|^NP$|^AU$');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `first_contact_date` SET TAGS ('dbx_business_glossary_term' = 'First Contact Date');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `intervention_actions` SET TAGS ('dbx_business_glossary_term' = 'Intervention Actions');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `metric_value` SET TAGS ('dbx_business_glossary_term' = 'Metric Value');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `next_follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Next Follow-Up Date');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `outcome_category` SET TAGS ('dbx_business_glossary_term' = 'Outcome Category');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `outcome_category` SET TAGS ('dbx_value_regex' = 'retained_improved|retained_stable|withdrew_course|withdrew_institution|transferred|no_outcome_yet');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Flag');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `referral_services` SET TAGS ('dbx_business_glossary_term' = 'Referral Services');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved_improved|resolved_no_change|resolved_withdrew|closed_no_action');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `retained_next_term` SET TAGS ('dbx_business_glossary_term' = 'Retained Next Term');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `sap_status_post_alert` SET TAGS ('dbx_business_glossary_term' = 'Satisfactory Academic Progress (SAP) Status Post-Alert');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `sap_status_post_alert` SET TAGS ('dbx_value_regex' = 'satisfactory|warning|probation|suspension|not_applicable');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `student_response` SET TAGS ('dbx_business_glossary_term' = 'Student Response');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `student_response` SET TAGS ('dbx_value_regex' = 'engaged|partially_engaged|non_responsive|declined_services|withdrew');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `term_gpa_post_intervention` SET TAGS ('dbx_business_glossary_term' = 'Term Grade Point Average (GPA) Post-Intervention');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `triggering_metric` SET TAGS ('dbx_business_glossary_term' = 'Triggering Metric');
ALTER TABLE `education_ecm`.`student`.`student_early_alert` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` SET TAGS ('dbx_subdomain' = 'compliance_services');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `disability_accommodation_id` SET TAGS ('dbx_business_glossary_term' = 'Disability Accommodation Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `disability_accommodation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `disability_accommodation_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Staff Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'It Asset Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `modified_by_user_identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `modified_by_user_identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `modified_by_user_identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`disability_accommodation` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
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
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` SET TAGS ('dbx_subdomain' = 'compliance_services');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `student_sap_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Student Satisfactory Academic Progress (SAP) Evaluation ID');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `last_modified_by_user_identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `last_modified_by_user_identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `last_modified_by_user_identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluating Financial Aid Counselor ID');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `academic_plan_attached` SET TAGS ('dbx_business_glossary_term' = 'Academic Plan Attached Flag');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `academic_plan_required` SET TAGS ('dbx_business_glossary_term' = 'Academic Plan Required Flag');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `academic_plan_url` SET TAGS ('dbx_business_glossary_term' = 'Academic Plan Document URL');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `aid_reinstatement_date` SET TAGS ('dbx_business_glossary_term' = 'Aid Reinstatement Date');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `aid_suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Aid Suspension Date');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `appeal_decision` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `appeal_decision` SET TAGS ('dbx_value_regex' = 'approved|denied|pending|withdrawn');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `appeal_reason` SET TAGS ('dbx_business_glossary_term' = 'Appeal Reason');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `appeal_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submission Date');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `appeal_submitted` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submitted Flag');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Comments');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `completion_rate` SET TAGS ('dbx_business_glossary_term' = 'Completion Rate (Pace)');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `completion_rate_threshold` SET TAGS ('dbx_business_glossary_term' = 'Completion Rate Threshold (Pace Threshold)');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `credits_attempted` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Credits Attempted');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `credits_earned` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Credits Earned');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `cumulative_gpa` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Type');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_value_regex' = 'annual|mid-year|appeal|reinstatement|probation_review|warning_review');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `financial_aid_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Eligibility Status');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `financial_aid_eligibility` SET TAGS ('dbx_value_regex' = 'eligible|suspended|reinstated|conditional');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `gpa_requirement_met` SET TAGS ('dbx_business_glossary_term' = 'Grade Point Average (GPA) Requirement Met');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `gpa_threshold` SET TAGS ('dbx_business_glossary_term' = 'Grade Point Average (GPA) Threshold');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `ipeds_reportable` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Reportable Flag');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `maximum_timeframe_credits` SET TAGS ('dbx_business_glossary_term' = 'Maximum Timeframe Credits');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `maximum_timeframe_met` SET TAGS ('dbx_business_glossary_term' = 'Maximum Timeframe Requirement Met');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|mail|portal|in_person');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `overall_sap_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Satisfactory Academic Progress (SAP) Status');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `overall_sap_status` SET TAGS ('dbx_value_regex' = 'satisfactory|warning|probation|suspension|reinstatement');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `pace_requirement_met` SET TAGS ('dbx_business_glossary_term' = 'Pace Requirement Met');
ALTER TABLE `education_ecm`.`student`.`student_sap_evaluation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` SET TAGS ('dbx_subdomain' = 'academic_records');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `degree_conferral_id` SET TAGS ('dbx_business_glossary_term' = 'Degree Conferral Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `scholarly_output_id` SET TAGS ('dbx_business_glossary_term' = 'Research Output Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Graduation Application Date');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Graduation Application Status');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `application_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|withdrawn|deferred|conferred');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `application_term_code` SET TAGS ('dbx_business_glossary_term' = 'Graduation Application Term Code');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `commencement_ceremony_date` SET TAGS ('dbx_business_glossary_term' = 'Commencement Ceremony Date');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `commencement_ceremony_name` SET TAGS ('dbx_business_glossary_term' = 'Commencement Ceremony Name');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `commencement_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Commencement Participation Flag');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `concentration` SET TAGS ('dbx_business_glossary_term' = 'Concentration or Specialization');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `conferral_academic_year` SET TAGS ('dbx_business_glossary_term' = 'Conferral Academic Year');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `conferral_academic_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `conferral_date` SET TAGS ('dbx_business_glossary_term' = 'Degree Conferral Date');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `conferral_term_code` SET TAGS ('dbx_business_glossary_term' = 'Conferral Term Code');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `conferring_college` SET TAGS ('dbx_business_glossary_term' = 'Conferring College or School');
ALTER TABLE `education_ecm`.`student`.`degree_conferral` ALTER COLUMN `conferring_department` SET TAGS ('dbx_business_glossary_term' = 'Conferring Department');
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
ALTER TABLE `education_ecm`.`student`.`conduct_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`student`.`conduct_record` SET TAGS ('dbx_subdomain' = 'compliance_services');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `conduct_record_id` SET TAGS ('dbx_business_glossary_term' = 'Conduct Record Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `appeal_conduct_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `appeal_decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Rationale');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `appeal_decision_rationale` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `appeal_grounds` SET TAGS ('dbx_business_glossary_term' = 'Appeal Grounds');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'pending|under_review|upheld|overturned|modified|denied');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `appeal_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submission Date');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `appeal_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submitted Flag');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `clery_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Clery Act Reportable Flag');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `expungement_date` SET TAGS ('dbx_business_glossary_term' = 'Expungement Date');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `expungement_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Expungement Eligible Flag');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `ferpa_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'FERPA (Family Educational Rights and Privacy Act) Restriction Flag');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `finding` SET TAGS ('dbx_business_glossary_term' = 'Finding');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `finding` SET TAGS ('dbx_value_regex' = 'responsible|not_responsible|insufficient_evidence|no_violation');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `finding_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Date');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `hearing_body` SET TAGS ('dbx_business_glossary_term' = 'Hearing Body');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `hearing_date` SET TAGS ('dbx_business_glossary_term' = 'Hearing Date');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `hearing_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Hearing Officer Name');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `hearing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Hearing Required Flag');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `hearing_type` SET TAGS ('dbx_business_glossary_term' = 'Hearing Type');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `hearing_type` SET TAGS ('dbx_value_regex' = 'administrative|conduct_board|dean_review|expedited');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `incident_time` SET TAGS ('dbx_business_glossary_term' = 'Incident Time');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|suspended|closed');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Investigator Name');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `report_date` SET TAGS ('dbx_business_glossary_term' = 'Report Date');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `reporting_party_name` SET TAGS ('dbx_business_glossary_term' = 'Reporting Party Name');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `reporting_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `reporting_party_role` SET TAGS ('dbx_business_glossary_term' = 'Reporting Party Role');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `sanction_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Sanction Completion Status');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `sanction_completion_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|not_completed|waived');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `sanction_description` SET TAGS ('dbx_business_glossary_term' = 'Sanction Description');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `sanction_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `sanction_end_date` SET TAGS ('dbx_business_glossary_term' = 'Sanction End Date');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `sanction_start_date` SET TAGS ('dbx_business_glossary_term' = 'Sanction Start Date');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `sanction_type` SET TAGS ('dbx_business_glossary_term' = 'Sanction Type');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `title_ix_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Title IX Related Flag');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `violation_code` SET TAGS ('dbx_business_glossary_term' = 'Violation Code');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `violation_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`conduct_record` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Violation Type');
ALTER TABLE `education_ecm`.`student`.`student_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`student`.`student_enrollment` SET TAGS ('dbx_subdomain' = 'support_interventions');
ALTER TABLE `education_ecm`.`student`.`student_enrollment` SET TAGS ('dbx_association_edges' = 'student.profile,instruction.course_section');
ALTER TABLE `education_ecm`.`student`.`student_enrollment` ALTER COLUMN `student_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'student_enrollment Identifier');
ALTER TABLE `education_ecm`.`student`.`student_enrollment` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Course Section Id');
ALTER TABLE `education_ecm`.`student`.`student_enrollment` ALTER COLUMN `enrollment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Identifier');
ALTER TABLE `education_ecm`.`student`.`student_enrollment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Profile Id');
ALTER TABLE `education_ecm`.`student`.`student_enrollment` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Identifier');
ALTER TABLE `education_ecm`.`student`.`student_enrollment` ALTER COLUMN `add_authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Add Authorization Code');
ALTER TABLE `education_ecm`.`student`.`student_enrollment` ALTER COLUMN `add_date` SET TAGS ('dbx_business_glossary_term' = 'Add Date');
ALTER TABLE `education_ecm`.`student`.`student_enrollment` ALTER COLUMN `credit_hours_attempted` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours Attempted');
ALTER TABLE `education_ecm`.`student`.`student_enrollment` ALTER COLUMN `drop_date` SET TAGS ('dbx_business_glossary_term' = 'Drop Date');
ALTER TABLE `education_ecm`.`student`.`student_enrollment` ALTER COLUMN `grade_mode` SET TAGS ('dbx_business_glossary_term' = 'Grade Mode');
ALTER TABLE `education_ecm`.`student`.`student_enrollment` ALTER COLUMN `repeat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Repeat Course Indicator');
ALTER TABLE `education_ecm`.`student`.`student_enrollment` ALTER COLUMN `student_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `education_ecm`.`student`.`student_enrollment` ALTER COLUMN `student_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `education_ecm`.`student`.`student_enrollment` ALTER COLUMN `waitlist_position` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Position');
ALTER TABLE `education_ecm`.`student`.`student_submission` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`student`.`student_submission` SET TAGS ('dbx_subdomain' = 'support_interventions');
ALTER TABLE `education_ecm`.`student`.`student_submission` SET TAGS ('dbx_association_edges' = 'student.profile,instruction.assignment');
ALTER TABLE `education_ecm`.`student`.`student_submission` ALTER COLUMN `student_submission_id` SET TAGS ('dbx_business_glossary_term' = 'student_submission Identifier');
ALTER TABLE `education_ecm`.`student`.`student_submission` ALTER COLUMN `instruction_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Submission - Assignment Id');
ALTER TABLE `education_ecm`.`student`.`student_submission` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Grader Identifier');
ALTER TABLE `education_ecm`.`student`.`student_submission` ALTER COLUMN `instructor_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`student_submission` ALTER COLUMN `instructor_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`student_submission` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Submission - Profile Id');
ALTER TABLE `education_ecm`.`student`.`student_submission` ALTER COLUMN `instruction_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Identifier');
ALTER TABLE `education_ecm`.`student`.`student_submission` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Attempt Number');
ALTER TABLE `education_ecm`.`student`.`student_submission` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Submission Comments');
ALTER TABLE `education_ecm`.`student`.`student_submission` ALTER COLUMN `file_upload_path` SET TAGS ('dbx_business_glossary_term' = 'Submission File Path');
ALTER TABLE `education_ecm`.`student`.`student_submission` ALTER COLUMN `grade` SET TAGS ('dbx_business_glossary_term' = 'Letter Grade');
ALTER TABLE `education_ecm`.`student`.`student_submission` ALTER COLUMN `graded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Grading Date and Time');
ALTER TABLE `education_ecm`.`student`.`student_submission` ALTER COLUMN `is_excused` SET TAGS ('dbx_business_glossary_term' = 'Excused Submission Flag');
ALTER TABLE `education_ecm`.`student`.`student_submission` ALTER COLUMN `is_late` SET TAGS ('dbx_business_glossary_term' = 'Late Submission Flag');
ALTER TABLE `education_ecm`.`student`.`student_submission` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Raw Score');
ALTER TABLE `education_ecm`.`student`.`student_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Date and Time');
ALTER TABLE `education_ecm`.`student`.`student_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `education_ecm`.`student`.`student_submission` ALTER COLUMN `turnitin_score` SET TAGS ('dbx_business_glossary_term' = 'Plagiarism Similarity Score');
ALTER TABLE `education_ecm`.`student`.`student_submission` ALTER COLUMN `workflow_state` SET TAGS ('dbx_business_glossary_term' = 'Submission Workflow State');
ALTER TABLE `education_ecm`.`student`.`checkout` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`student`.`checkout` SET TAGS ('dbx_subdomain' = 'support_interventions');
ALTER TABLE `education_ecm`.`student`.`checkout` SET TAGS ('dbx_association_edges' = 'student.profile,technology.it_asset');
ALTER TABLE `education_ecm`.`student`.`checkout` ALTER COLUMN `checkout_id` SET TAGS ('dbx_business_glossary_term' = 'Checkout Transaction ID');
ALTER TABLE `education_ecm`.`student`.`checkout` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'IT Asset ID');
ALTER TABLE `education_ecm`.`student`.`checkout` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Profile ID');
ALTER TABLE `education_ecm`.`student`.`checkout` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible IT Staff Employee ID');
ALTER TABLE `education_ecm`.`student`.`checkout` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`student`.`checkout` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`checkout` ALTER COLUMN `checkout_date` SET TAGS ('dbx_business_glossary_term' = 'Checkout Date');
ALTER TABLE `education_ecm`.`student`.`checkout` ALTER COLUMN `checkout_status` SET TAGS ('dbx_business_glossary_term' = 'Checkout Status');
ALTER TABLE `education_ecm`.`student`.`checkout` ALTER COLUMN `condition_at_checkout` SET TAGS ('dbx_business_glossary_term' = 'Condition at Checkout');
ALTER TABLE `education_ecm`.`student`.`checkout` ALTER COLUMN `condition_at_return` SET TAGS ('dbx_business_glossary_term' = 'Condition at Return');
ALTER TABLE `education_ecm`.`student`.`checkout` ALTER COLUMN `damage_fee_assessed` SET TAGS ('dbx_business_glossary_term' = 'Damage Fee Assessed');
ALTER TABLE `education_ecm`.`student`.`checkout` ALTER COLUMN `expected_return_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Return Date');
ALTER TABLE `education_ecm`.`student`.`checkout` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Checkout Location');
ALTER TABLE `education_ecm`.`student`.`checkout` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Checkout Purpose');
ALTER TABLE `education_ecm`.`student`.`checkout` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Date');
ALTER TABLE `education_ecm`.`student`.`student_training_completion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`student`.`student_training_completion` SET TAGS ('dbx_subdomain' = 'support_interventions');
ALTER TABLE `education_ecm`.`student`.`student_training_completion` SET TAGS ('dbx_association_edges' = 'student.profile,compliance.training_program');
ALTER TABLE `education_ecm`.`student`.`student_training_completion` ALTER COLUMN `student_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'student_training_completion Identifier');
ALTER TABLE `education_ecm`.`student`.`student_training_completion` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion - Profile Id');
ALTER TABLE `education_ecm`.`student`.`student_training_completion` ALTER COLUMN `compliance_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion ID');
ALTER TABLE `education_ecm`.`student`.`student_training_completion` ALTER COLUMN `training_program_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion - Compliance Training Id');
ALTER TABLE `education_ecm`.`student`.`student_training_completion` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Training Assessment Score');
ALTER TABLE `education_ecm`.`student`.`student_training_completion` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Training Assignment Date');
ALTER TABLE `education_ecm`.`student`.`student_training_completion` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Attempt Number');
ALTER TABLE `education_ecm`.`student`.`student_training_completion` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `education_ecm`.`student`.`student_training_completion` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `education_ecm`.`student`.`student_training_completion` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Status');
ALTER TABLE `education_ecm`.`student`.`student_training_completion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`student_training_completion` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Training Expiration Date');
ALTER TABLE `education_ecm`.`student`.`student_training_completion` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `education_ecm`.`student`.`student_training_completion` ALTER COLUMN `time_spent_minutes` SET TAGS ('dbx_business_glossary_term' = 'Time Spent in Minutes');
ALTER TABLE `education_ecm`.`student`.`student_training_completion` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `education_ecm`.`student`.`student_training_completion` ALTER COLUMN `waiver_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Date');
ALTER TABLE `education_ecm`.`student`.`student_training_completion` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` SET TAGS ('dbx_subdomain' = 'support_interventions');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` SET TAGS ('dbx_association_edges' = 'student.profile,facility.room');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ALTER COLUMN `student_housing_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'student_housing_assignment Identifier');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ALTER COLUMN `studentlife_housing_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Housing Assignment Identifier');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Housing Assignment - Profile Id');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Housing Assignment - Room Id');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Room Access Level');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ALTER COLUMN `key_card_issued` SET TAGS ('dbx_business_glossary_term' = 'Key Card Issued Flag');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ALTER COLUMN `key_card_number` SET TAGS ('dbx_business_glossary_term' = 'Key Card Number');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ALTER COLUMN `key_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ALTER COLUMN `key_card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ALTER COLUMN `meal_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Meal Plan Code');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ALTER COLUMN `primary_occupant_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Occupant Flag');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ALTER COLUMN `room_rate_code` SET TAGS ('dbx_business_glossary_term' = 'Room Rate Code');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ALTER COLUMN `special_accommodations` SET TAGS ('dbx_business_glossary_term' = 'Special Accommodations');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ALTER COLUMN `special_accommodations` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `education_ecm`.`student`.`student_housing_assignment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Creator');
ALTER TABLE `education_ecm`.`student`.`access_authorization` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`student`.`access_authorization` SET TAGS ('dbx_subdomain' = 'support_interventions');
ALTER TABLE `education_ecm`.`student`.`access_authorization` SET TAGS ('dbx_association_edges' = 'student.profile,facility.building');
ALTER TABLE `education_ecm`.`student`.`access_authorization` ALTER COLUMN `access_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Access Authorization Identifier');
ALTER TABLE `education_ecm`.`student`.`access_authorization` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Access Authorization - Building Id');
ALTER TABLE `education_ecm`.`student`.`access_authorization` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Access Authorization - Profile Id');
ALTER TABLE `education_ecm`.`student`.`access_authorization` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `education_ecm`.`student`.`access_authorization` ALTER COLUMN `access_type` SET TAGS ('dbx_business_glossary_term' = 'Access Type');
ALTER TABLE `education_ecm`.`student`.`access_authorization` ALTER COLUMN `after_hours_access` SET TAGS ('dbx_business_glossary_term' = 'After Hours Access');
ALTER TABLE `education_ecm`.`student`.`access_authorization` ALTER COLUMN `authorization_end_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization End Date');
ALTER TABLE `education_ecm`.`student`.`access_authorization` ALTER COLUMN `authorization_start_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Start Date');
ALTER TABLE `education_ecm`.`student`.`access_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `education_ecm`.`student`.`access_authorization` ALTER COLUMN `authorizing_department` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Department');
ALTER TABLE `education_ecm`.`student`.`access_authorization` ALTER COLUMN `card_access_enabled` SET TAGS ('dbx_business_glossary_term' = 'Card Access Enabled');
ALTER TABLE `education_ecm`.`student`.`access_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`student`.`access_authorization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`student`.`access_authorization` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `education_ecm`.`student`.`access_authorization` ALTER COLUMN `supervisor_name` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Name');
ALTER TABLE `education_ecm`.`student`.`participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`student`.`participation` SET TAGS ('dbx_subdomain' = 'support_interventions');
ALTER TABLE `education_ecm`.`student`.`participation` SET TAGS ('dbx_association_edges' = 'student.profile,research.irb_protocol');
ALTER TABLE `education_ecm`.`student`.`participation` ALTER COLUMN `participation_id` SET TAGS ('dbx_business_glossary_term' = 'Participation Record Identifier');
ALTER TABLE `education_ecm`.`student`.`participation` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Participation - Profile Id');
ALTER TABLE `education_ecm`.`student`.`participation` ALTER COLUMN `irb_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Participation - Research Irb Protocol Id');
ALTER TABLE `education_ecm`.`student`.`participation` ALTER COLUMN `adverse_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Indicator');
ALTER TABLE `education_ecm`.`student`.`participation` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Participant Compensation Amount');
ALTER TABLE `education_ecm`.`student`.`participation` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`participation` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`student`.`participation` ALTER COLUMN `compensation_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Compensation Payment Date');
ALTER TABLE `education_ecm`.`student`.`participation` ALTER COLUMN `compensation_paid_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`student`.`participation` ALTER COLUMN `compensation_paid_date` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`student`.`participation` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Study Completion Date');
ALTER TABLE `education_ecm`.`student`.`participation` ALTER COLUMN `completion_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`participation` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Date');
ALTER TABLE `education_ecm`.`student`.`participation` ALTER COLUMN `consent_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`participation` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Study Enrollment Date');
ALTER TABLE `education_ecm`.`student`.`participation` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`participation` ALTER COLUMN `participation_role` SET TAGS ('dbx_business_glossary_term' = 'Participation Role');
ALTER TABLE `education_ecm`.`student`.`participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `education_ecm`.`student`.`participation` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Study Withdrawal Date');
ALTER TABLE `education_ecm`.`student`.`participation` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`student`.`participation` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
