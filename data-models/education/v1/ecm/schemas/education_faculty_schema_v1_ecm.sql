-- Schema for Domain: faculty | Business: Education | Version: v1_ecm
-- Generated on: 2026-05-06 12:28:01

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `education_ecm`.`faculty` COMMENT 'Owns faculty and instructor master data including academic appointments, tenure track status, rank, teaching load, credentials, scholarly activity, and departmental affiliations. Supports faculty evaluation, promotion and tenure processes, CUPA-HR reporting, and accreditation qualification tracking. SSOT for instructional personnel referenced by instruction, curriculum, and research domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`instructor` (
    `instructor_id` BIGINT COMMENT 'Unique identifier for the instructor record. Primary key for the instructor entity. Serves as the authoritative reference for all instructional personnel across instruction, curriculum, research, and enrollment domains.',
    `alumnus_id` BIGINT COMMENT 'Foreign key linking to advancement.alumnus. Business justification: Many faculty are alumni of the institution. Advancement tracks faculty-alumni for affinity scoring, major gift prioritization, reunion engagement, and recognition. Real business process: advancement o',
    `donor_id` BIGINT COMMENT 'Foreign key linking to advancement.donor. Business justification: Faculty are donors themselves. Tracked for faculty giving campaigns, recognition societies (Presidents Circle), peer-to-peer solicitation, and lifetime giving totals. Real business process: annual fa',
    `identity_account_id` BIGINT COMMENT 'Foreign key linking to technology.identity_account. Business justification: Every faculty member requires a university network identity (NetID) for email, LMS access, HR systems, research systems. Identity provisioning is a core onboarding process. Instructor.canvas_user_id s',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Faculty office assignments are core operational data for directory services, space cost allocation, utilization reporting, and facilities planning. Currently stored as text in office_location; normali',
    `patron_id` BIGINT COMMENT 'Foreign key linking to library.patron. Business justification: Faculty hold library borrowing privileges as patrons. Linking instructor to patron enables unified reporting of library services usage, identification of overdue materials in annual faculty reviews, t',
    `appointment_end_date` DATE COMMENT 'End date of the instructors current appointment or contract period. Null for tenured faculty with indefinite appointments. Critical for adjunct and visiting faculty contract management and renewal planning.',
    `appointment_start_date` DATE COMMENT 'Start date of the instructors current appointment or contract period. May differ from hire_date for faculty with multiple appointment types or breaks in service. Used for contract renewal tracking.',
    `banner_pidm` BIGINT COMMENT 'Internal person identifier from Ellucian Banner Student Information System. Links instructor to Banner person master for academic history, course assignments, and student interactions. PIDM is the Banner system key for all person entities.',
    `canvas_user_code` STRING COMMENT 'Unique user identifier for the instructor in the Canvas LMS. Links instructor record to course shells, gradebooks, and student interactions in the learning management system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the instructor record was first created in the system. Audit field for data lineage and record lifecycle tracking.',
    `diversity_self_identification` STRING COMMENT 'Voluntary self-identification of demographic characteristics for diversity reporting and equity analysis. Collected per EEOC and IPEDS requirements. Confidential and used only for aggregate reporting, never individual evaluation.',
    `email_address` STRING COMMENT 'Primary institutional email address for the instructor. Used for official communications, LMS notifications, and student contact. Must be active institutional domain email.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emplid` STRING COMMENT 'Employee identifier from Workday HCM system. Links instructor record to human resources master data for payroll, benefits, and talent management. Required for all faculty with employment relationship.. Valid values are `^[A-Z0-9]{6,10}$`',
    `employment_classification` STRING COMMENT 'Employment status classification of the instructor. Determines teaching load expectations, benefits eligibility, and governance participation rights. Full-time includes tenure-track and non-tenure-track faculty. Adjunct refers to part-time instructors hired per course. Visiting indicates temporary appointments. Emeritus denotes retired faculty with honorary status. Affiliate covers joint appointments and courtesy faculty.. Valid values are `full-time|part-time|adjunct|visiting|emeritus|affiliate`',
    `faculty_rank` STRING COMMENT 'Current academic rank of the instructor within the institutional hierarchy. Reflects seniority, credentials, and scholarly achievement. Instructor and Lecturer ranks typically non-tenure-track. Assistant, Associate, and Full Professor ranks typically tenure-track or tenured. Distinguished Professor is highest honor rank. [ENUM-REF-CANDIDATE: instructor|assistant-professor|associate-professor|professor|distinguished-professor|lecturer|senior-lecturer — 7 candidates stripped; promote to reference product]',
    `faculty_status` STRING COMMENT 'Current employment and activity status of the instructor. Active indicates currently teaching or available for assignment. On-leave includes medical, personal, or professional development leave. Sabbatical indicates approved scholarly leave. Retired includes emeritus faculty. Terminated covers resignations and dismissals. Deceased for memorial records.. Valid values are `active|on-leave|sabbatical|retired|terminated|deceased`',
    `first_name` STRING COMMENT 'Legal first name of the instructor as recorded in official personnel records. Used for formal communications, course rosters, and accreditation documentation.',
    `graduate_faculty_status` STRING COMMENT 'Approval status for teaching graduate courses and serving on doctoral committees. Full status allows chairing dissertations. Associate status allows committee membership. Not-approved restricts to undergraduate teaching only. Determined by graduate council review of credentials and scholarly activity.. Valid values are `full|associate|not-approved`',
    `highest_degree_earned` STRING COMMENT 'Highest academic degree earned by the instructor. Doctorate includes PhD, EdD, DBA, etc. Professional includes MD, JD, DDS, etc. Critical for accreditation qualification tracking and faculty credential reporting.. Valid values are `bachelor|master|doctorate|professional|other`',
    `highest_degree_field` STRING COMMENT 'Academic discipline or field of study for the instructors highest degree. Used to assess teaching qualification alignment with course content for accreditation purposes.',
    `highest_degree_institution` STRING COMMENT 'Name of the institution that awarded the instructors highest degree. Used for faculty diversity analysis and accreditation documentation of faculty credentials.',
    `highest_degree_year` STRING COMMENT 'Year in which the instructor completed their highest degree. Used for career stage analysis and intellectual currency assessment for accreditation.',
    `hire_date` DATE COMMENT 'Date the instructor was first hired by the institution in any capacity. Used for service credit calculations, benefits vesting, and anniversary recognition. For rehires, reflects most recent continuous service start date.',
    `last_name` STRING COMMENT 'Legal last name (surname/family name) of the instructor as recorded in official personnel records. Primary sorting and indexing field for instructor directories.',
    `last_promotion_date` DATE COMMENT 'Date of the instructors most recent promotion in academic rank. Used for promotion cycle tracking and eligibility calculations for next rank advancement.',
    `middle_name` STRING COMMENT 'Middle name or initial of the instructor. Optional field used for formal identification and disambiguation of common names.',
    `office_hours` STRING COMMENT 'Scheduled office hours when the instructor is available for student consultation. Free-text field accommodating various formats (e.g., MWF 2-4pm, By appointment). Published in syllabi and LMS.',
    `orcid_identifier` STRING COMMENT 'Unique persistent digital identifier for the instructor as a researcher. Format: XXXX-XXXX-XXXX-XXXX. Links to global research output and disambiguates author identity across publications. Increasingly required by funding agencies and publishers.. Valid values are `^[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{3}[0-9X]$`',
    `phd_advisor_eligible_flag` BOOLEAN COMMENT 'Boolean indicator of whether the instructor is approved to serve as primary advisor (chair) for doctoral students. True indicates full graduate faculty status with dissertation chair privileges. False for associate graduate faculty or undergraduate-only faculty.',
    `phone_number` STRING COMMENT 'Primary office or contact phone number for the instructor. Published in faculty directories and course syllabi for student and administrative contact.',
    `preferred_name` STRING COMMENT 'Name the instructor prefers to use in professional and academic contexts. May differ from legal name. Used in course catalogs, syllabi, and student-facing communications.',
    `primary_college_code` STRING COMMENT 'Code identifying the instructors primary college or school affiliation. Higher-level organizational unit above department. Used for college-level reporting and resource allocation.. Valid values are `^[A-Z]{2,4}$`',
    `primary_research_cip_code` STRING COMMENT 'Six-digit CIP code classifying the instructors primary research area using the federal Classification of Instructional Programs taxonomy. Format: XX.XXXX. Used for research portfolio analysis and interdisciplinary collaboration identification.. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `principal_investigator_id` BIGINT COMMENT 'Foreign key linking to research.principal_investigator. Business justification: Faculty instructors who conduct sponsored research are registered as principal investigators. Essential for: grant eligibility verification, effort reporting, compliance tracking (COI, export control)',
    `professional_licensure` STRING COMMENT 'Professional licenses, certifications, or credentials held by the instructor relevant to their teaching discipline. Examples: CPA, PE, RN, JD bar admission, medical board certification. Critical for accreditation of professional programs.',
    `record_source_system` STRING COMMENT 'System of origin for the instructor record. Workday for HR-sourced faculty, Banner for academic appointments, Manual for direct data entry, Import for bulk loads. Used for data lineage and reconciliation.. Valid values are `workday|banner|manual|import`',
    `research_interests` STRING COMMENT 'Narrative description of the instructors research interests, scholarly focus areas, and areas of expertise. Used for faculty directory profiles, research collaboration matching, and graduate student advisor assignment. Free-text field allowing comprehensive description.',
    `sabbatical_eligible_date` DATE COMMENT 'Date on which the instructor becomes eligible for their next sabbatical leave. Calculated based on institutional sabbatical policy (typically 6-7 years of service). Null for non-tenure-track faculty ineligible for sabbatical.',
    `teaching_load_fte` DECIMAL(18,2) COMMENT 'Full-time equivalent teaching load assignment for the instructor. 1.0 represents full-time teaching load per institutional standards. Reduced for research appointments, administrative duties, or part-time status. Used for workload planning and IPEDS faculty FTE reporting.',
    `tenure_date` DATE COMMENT 'Date on which tenure was officially awarded to the instructor. Null for non-tenured faculty. Critical for seniority calculations, sabbatical eligibility, and governance voting rights.',
    `tenure_status` STRING COMMENT 'Current tenure status of the instructor. Tenured indicates permanent appointment with academic freedom protections. Tenure-track indicates probationary period toward tenure review. Non-tenure-track includes lecturers, instructors, and clinical faculty. Not-applicable for adjunct, visiting, and affiliate appointments.. Valid values are `tenured|tenure-track|non-tenure-track|not-applicable`',
    `union_affiliation` STRING COMMENT 'Name of faculty union or collective bargaining unit to which the instructor belongs, if applicable. Null for non-unionized faculty. Used for contract administration and labor relations reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the instructor record was last modified. Audit field for change tracking and data quality monitoring. Updated on any field modification.',
    CONSTRAINT pk_instructor PRIMARY KEY(`instructor_id`)
) COMMENT 'Core master record for all faculty and instructional personnel at the institution. Serves as the SSOT for faculty identity, biographical data, academic credentials summary, employment classification (full-time, part-time, adjunct, visiting), current rank (Assistant Professor through Distinguished Professor), tenure status, primary department affiliation, research interests and expertise areas (with CIP/NSF classification codes), EMPLID from Workday HCM, and Banner person ID. Referenced by instruction, curriculum, research, and enrollment domains as the authoritative source for instructional personnel identity.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`appointment` (
    `appointment_id` BIGINT COMMENT 'Unique identifier for the faculty appointment record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Reference to the college or school within which the appointing department resides. Used for higher-level budget allocation and strategic planning.',
    `hire_event_id` BIGINT COMMENT 'Foreign key linking to faculty.hire_event. Business justification: hire_event captures the formal faculty hiring transaction (position requisition, search type, offer date, acceptance date, diversity hire flag, etc.). appointment is the resulting employment record. T',
    `instructor_id` BIGINT COMMENT 'Reference to the faculty member receiving this appointment. Links to the faculty master record.',
    `org_unit_id` BIGINT COMMENT 'Reference to the academic department to which this appointment is primarily assigned. Determines budget responsibility, teaching assignments, and administrative reporting line.',
    `academic_rank` STRING COMMENT 'Faculty rank at the time of this appointment. Reflects the hierarchical position within the academic career ladder and influences salary, teaching load, and committee assignments. [ENUM-REF-CANDIDATE: professor|associate-professor|assistant-professor|instructor|lecturer|senior-lecturer|distinguished-professor|endowed-chair — 8 candidates stripped; promote to reference product]',
    `annual_salary_amount` DECIMAL(18,2) COMMENT 'Base salary amount for the appointment, annualized for comparison purposes. For academic-year appointments, this represents the 9-month salary; for per-course or hourly, this is calculated based on expected load. Used for CUPA-HR reporting and budget planning.',
    `appointment_number` STRING COMMENT 'Human-readable business identifier for the appointment, typically generated by the HR system. Used in official correspondence and HR documentation.',
    `appointment_status` STRING COMMENT 'Current lifecycle status of the appointment. Active indicates the faculty member is currently serving in the role; on-leave indicates approved absence; terminated or completed indicates the appointment has ended.. Valid values are `active|on-leave|suspended|terminated|completed|pending`',
    `appointment_type` STRING COMMENT 'Classification of the faculty appointment indicating the nature of the academic position and employment relationship. Determines eligibility for tenure review, benefits, and institutional privileges. [ENUM-REF-CANDIDATE: tenure-track|tenured|clinical|research|adjunct|visiting|emeritus|lecturer|instructor|postdoctoral — 10 candidates stripped; promote to reference product]',
    `approval_date` DATE COMMENT 'Date when the appointment was formally approved by the appropriate institutional authority (department chair, dean, provost, or board of trustees, depending on rank and type). Used for governance audit and compliance tracking.',
    `approved_by` STRING COMMENT 'Name or identifier of the institutional officer or body that approved this appointment (e.g., Provost, Board of Trustees, Dean of College of Engineering). Used for governance transparency and audit trail.',
    `benefits_eligible_flag` BOOLEAN COMMENT 'Indicates whether the appointment qualifies the faculty member for institutional benefits (health insurance, retirement contributions, tuition remission). Typically based on FTE threshold and appointment type.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this appointment record was first created in the system. Used for data lineage, audit trail, and record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the salary amount (e.g., USD, CAD, EUR). Supports international faculty appointments and multi-currency reporting.. Valid values are `^[A-Z]{3}$`',
    `end_date` DATE COMMENT 'Scheduled or actual date when the appointment concludes. Null for open-ended tenured appointments. Populated for term-limited appointments (visiting, adjunct, fixed-term contracts).',
    `endowed_chair_name` STRING COMMENT 'Name of the endowed chair or professorship associated with this appointment, if applicable. Null for non-endowed positions. Used for donor stewardship reporting and prestige tracking.',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Proportion of full-time effort allocated to this appointment, expressed as a decimal (e.g., 1.0000 for full-time, 0.5000 for half-time). Used for workload planning, IPEDS reporting, and salary proration.',
    `grant_funded_flag` BOOLEAN COMMENT 'Indicates whether this appointment is wholly or partially funded by external grant or contract funds (e.g., NSF, NIH). True for grant-funded research faculty; false for institutionally funded positions. Critical for Facilities and Administrative (F&A) cost recovery and effort reporting.',
    `joint_appointment_flag` BOOLEAN COMMENT 'Indicates whether this is a joint appointment spanning multiple departments or colleges. True if the faculty member holds concurrent appointments with split FTE across units; false for single-unit appointments.',
    `last_modified_by` STRING COMMENT 'Identifier of the system user or process that most recently modified this appointment record. Used for accountability and audit purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this appointment record was most recently updated. Used for change tracking, data freshness assessment, and audit trail.',
    `primary_department_code` STRING COMMENT 'Code identifying the instructors primary academic department affiliation. Determines budget responsibility, teaching assignments, and governance participation. Follows institutional department coding standards. [Moved from instructor: This attribute represents the instructors primary departmental affiliation, which is a specific instance of the instructor-cost_center relationship. In a properly normalized model, this should be derived from the appointment association where primary_affiliation_flag=true, rather than denormalized on the instructor record. However, it may be retained on instructor for query performance if the business frequently needs primary department without joining to appointments.]. Valid values are `^[A-Z]{3,6}$`',
    `research_expectation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the faculty members effort expected to be devoted to research and scholarly activity under this appointment. Complements teaching and service expectations to total 100% of FTE.',
    `sabbatical_eligible_flag` BOOLEAN COMMENT 'Indicates whether the faculty member is eligible for sabbatical leave under this appointment. Typically true for tenured and tenure-track faculty; false for adjunct, visiting, and non-tenure-track appointments.',
    `salary_basis` STRING COMMENT 'Compensation structure for the appointment. Annual indicates 12-month salary; academic-year indicates 9-month; per-course and hourly are typical for adjunct faculty; stipend is used for postdoctoral and some research appointments.. Valid values are `annual|academic-year|per-course|hourly|stipend`',
    `service_expectation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the faculty members effort expected to be devoted to institutional service, committee work, and administrative duties. Used for workload planning and promotion/tenure evaluation.',
    `start_date` DATE COMMENT 'Official date when the faculty appointment becomes effective. Used for tenure clock calculations, benefits eligibility, and seniority determination.',
    `teaching_load_credit_hours` DECIMAL(18,2) COMMENT 'Expected teaching load for this appointment, expressed in credit hours per academic year or term. Used for workload equity analysis and accreditation reporting of instructional capacity.',
    `tenure_status` STRING COMMENT 'Indicates whether the appointment carries tenure, is on a tenure-track path, or is non-tenure-track. Critical for promotion and tenure processes and accreditation qualification tracking.. Valid values are `tenured|tenure-track|non-tenure-track|not-applicable`',
    `termination_date` DATE COMMENT 'Actual date when the appointment was terminated, if applicable. Distinct from appointment_end_date (which may be scheduled). Populated when an appointment ends early due to resignation, dismissal, or other cause. Used for turnover analysis and exit process tracking.',
    `termination_reason` STRING COMMENT 'Classification of the reason for appointment termination. Populated only when termination_date is set. Used for turnover analysis, retention strategy, and compliance with employment law documentation requirements. [ENUM-REF-CANDIDATE: resignation|retirement|dismissal|non-renewal|end-of-contract|death|other — 7 candidates stripped; promote to reference product]',
    `union_affiliation_code` STRING COMMENT 'Code identifying the labor union or collective bargaining unit to which this appointment is subject, if applicable. Null for non-unionized positions. Used for contract compliance and labor relations reporting.',
    `visa_sponsorship_required_flag` BOOLEAN COMMENT 'Indicates whether the institution is sponsoring a work visa (H-1B, J-1, O-1, etc.) for this appointment. True for international faculty requiring visa sponsorship; false for U.S. citizens, permanent residents, or those with independent work authorization. Used for immigration compliance tracking.',
    `created_by` STRING COMMENT 'Identifier of the system user or process that created this appointment record. Used for accountability and audit purposes.',
    CONSTRAINT pk_appointment PRIMARY KEY(`appointment_id`)
) COMMENT 'Represents a formal academic appointment record for a faculty member, capturing appointment type (tenure-track, tenured, clinical, research, adjunct, visiting, emeritus), FTE allocation, appointment start and end dates, salary basis, appointing department, college, and academic rank at time of appointment. For initial appointments (hires): additionally captures search type (national, internal, emergency), offer and acceptance dates, search committee chair, position requisition reference, and diversity hire tracking flag. Tracks the official employment relationship between the institution and the faculty member as managed in Workday HCM. Supports CUPA-HR reporting, IPEDS HR survey, EEO compliance, and accreditation qualification tracking.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`tenure_case` (
    `tenure_case_id` BIGINT COMMENT 'Unique identifier for the promotion and tenure review case. Primary key for the tenure case entity.',
    `instructor_id` BIGINT COMMENT 'Identifier of the faculty member undergoing promotion and tenure review. Links to the faculty master data entity.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the academic department in which the faculty member holds their primary appointment and where the tenure case originates.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Tenure cases must follow institutional tenure and promotion policies that define criteria, timelines, committee composition, and appeal procedures. Provosts and deans reference policy during case revi',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the faculty member filed a formal appeal of a negative promotion and tenure decision.',
    `appeal_outcome` STRING COMMENT 'The outcome of any appeal filed regarding the promotion and tenure decision.. Valid values are `upheld|overturned|remanded|withdrawn|pending`',
    `board_approval_date` DATE COMMENT 'The date the board of trustees formally approved or denied the promotion and tenure case.',
    `board_approval_status` STRING COMMENT 'The approval status from the institutions board of trustees, which typically has final authority over tenure and promotion decisions.. Valid values are `pending|approved|denied|deferred`',
    `case_initiation_date` DATE COMMENT 'The date on which the promotion and tenure case was formally initiated and entered into the review workflow.',
    `case_number` STRING COMMENT 'Human-readable business identifier for the promotion and tenure case, typically formatted as year-department-sequence (e.g., 2024-ENG-003).',
    `case_status` STRING COMMENT 'Current lifecycle status of the promotion and tenure case within the institutional review workflow. [ENUM-REF-CANDIDATE: initiated|in_progress|committee_review|dean_review|provost_review|board_review|approved|denied|withdrawn|deferred — 10 candidates stripped; promote to reference product]',
    `college_committee_recommendation` STRING COMMENT 'The college-level promotion and tenure committees formal recommendation regarding the case.. Valid values are `strongly_support|support|support_with_reservations|do_not_support|strongly_oppose`',
    `college_committee_vote_date` DATE COMMENT 'The date on which the college-level promotion and tenure committee conducted its vote on the case.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this tenure case record was first created in the system.',
    `current_rank` STRING COMMENT 'The faculty members current academic rank at the time the tenure case is initiated. [ENUM-REF-CANDIDATE: instructor|assistant_professor|associate_professor|professor|distinguished_professor|clinical_assistant|clinical_associate|clinical_professor — 8 candidates stripped; promote to reference product]',
    `dean_recommendation` STRING COMMENT 'The deans formal recommendation regarding the promotion and tenure case.. Valid values are `strongly_support|support|support_with_reservations|do_not_support|strongly_oppose`',
    `dean_recommendation_date` DATE COMMENT 'The date the dean submitted their formal recommendation letter.',
    `department_chair_recommendation` STRING COMMENT 'The department chairs formal recommendation regarding the promotion and tenure case.. Valid values are `strongly_support|support|support_with_reservations|do_not_support|strongly_oppose`',
    `department_chair_recommendation_date` DATE COMMENT 'The date the department chair submitted their formal recommendation letter.',
    `department_committee_vote_abstain` STRING COMMENT 'The number of department committee members who abstained from voting on the tenure case.',
    `department_committee_vote_against` STRING COMMENT 'The number of department committee members who voted against granting promotion and/or tenure.',
    `department_committee_vote_date` DATE COMMENT 'The date on which the departmental promotion and tenure committee conducted its vote on the case.',
    `department_committee_vote_for` STRING COMMENT 'The number of department committee members who voted in favor of granting promotion and/or tenure.',
    `dossier_submission_date` DATE COMMENT 'The date the faculty member submitted their complete promotion and tenure dossier (including curriculum vitae, teaching portfolio, research statement, and supporting materials).',
    `effective_date` DATE COMMENT 'The date on which the granted promotion and/or tenure becomes effective, typically the start of the next academic year following approval.',
    `external_review_required_flag` BOOLEAN COMMENT 'Indicates whether external peer review letters from scholars at other institutions are required for this tenure case. Typically true for tenure and promotion to full professor.',
    `external_reviewers_solicited_count` STRING COMMENT 'The number of external reviewers who were contacted and asked to provide evaluation letters for this tenure case.',
    `external_reviews_received_count` STRING COMMENT 'The number of external review letters actually received and included in the tenure dossier.',
    `final_outcome` STRING COMMENT 'The final outcome of the promotion and tenure review process after all levels of review and approval are complete. [ENUM-REF-CANDIDATE: tenure_granted|tenure_denied|promotion_granted|promotion_denied|both_granted|both_denied|withdrawn|deferred — 8 candidates stripped; promote to reference product]',
    `final_outcome_date` DATE COMMENT 'The date the final promotion and tenure outcome was determined and communicated to the faculty member.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special circumstances, or administrative remarks related to the tenure case.',
    `proposed_rank` STRING COMMENT 'The academic rank being sought through this promotion and tenure review process. May be the same as current rank if only tenure (not promotion) is being sought.. Valid values are `assistant_professor|associate_professor|professor|distinguished_professor|clinical_associate|clinical_professor`',
    `provost_decision` STRING COMMENT 'The provosts formal decision on the promotion and tenure case. In many institutions, the provost makes the final administrative recommendation to the board of trustees.. Valid values are `approve|deny|defer|return_for_additional_review`',
    `provost_decision_date` DATE COMMENT 'The date the provost rendered their formal decision on the tenure case.',
    `review_cycle_year` STRING COMMENT 'The academic year in which the promotion and tenure review is conducted, typically represented as the ending year (e.g., 2024 for 2023-2024 academic year).',
    `review_type` STRING COMMENT 'The type of faculty review being conducted: third-year review (formative mid-probationary assessment), pre-tenure review (final probationary review before tenure decision), tenure review (formal tenure decision), promotion review (rank advancement without tenure), post-tenure review (periodic evaluation of tenured faculty), or comprehensive review (combined promotion and tenure).. Valid values are `third_year_review|pre_tenure_review|tenure_review|promotion_review|post_tenure_review|comprehensive_review`',
    `tenure_clock_start_date` DATE COMMENT 'The official start date of the tenure clock for this faculty member, which may differ from appointment date due to prior service credit or negotiated adjustments.',
    `tenure_clock_stop_count` STRING COMMENT 'The total number of tenure clock extensions or stops granted to the faculty member (e.g., for parental leave, medical leave, or other approved circumstances).',
    `tenure_clock_years_elapsed` DECIMAL(18,2) COMMENT 'The number of years that have elapsed on the tenure clock at the time of review, accounting for any stops or extensions. Typically ranges from 0 to 7 years.',
    `tenure_track_appointment_date` DATE COMMENT 'The date the faculty member began their tenure-track appointment, establishing the start of the probationary period and tenure clock.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this tenure case record was last modified in the system.',
    CONSTRAINT pk_tenure_case PRIMARY KEY(`tenure_case_id`)
) COMMENT 'Tracks the formal promotion and tenure review process for a faculty member, including the review cycle year, tenure clock start date, tenure clock extensions granted, current review stage (third-year review, pre-tenure review, tenure review, post-tenure review), committee assignments, external reviewer status, dean recommendation, provost decision, board approval status, and final outcome. Supports the institutions faculty evaluation and promotion and tenure (P&T) governance process.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`rank_history` (
    `rank_history_id` BIGINT COMMENT 'Unique identifier for this rank change record. Primary key for the rank history entity.',
    `instructor_id` BIGINT COMMENT 'Identifier of the faculty member whose rank changed. Links to the faculty master record.',
    `tenure_case_id` BIGINT COMMENT 'Foreign key linking to faculty.tenure_case. Business justification: rank_history.tenure_case_reference is currently a STRING field. When a rank change results from a promotion and tenure case, we should link it properly via FK to tenure_case.tenure_case_id. This allow',
    `accreditation_qualified_flag` BOOLEAN COMMENT 'Boolean indicator of whether the faculty member met accreditation body qualification standards (e.g., AACSB, ABET) at this rank. Used for accreditation reporting and program review.',
    `appointment_type` STRING COMMENT 'The employment appointment type associated with this rank. Distinguishes between full-time, part-time, adjunct, visiting, and emeritus appointments.. Valid values are `Full-Time|Part-Time|Adjunct|Visiting|Emeritus`',
    `approval_date` DATE COMMENT 'The date on which the rank change was formally approved by the approving authority. May differ from the effective date if approval occurs in advance of the effective date.',
    `approving_authority` STRING COMMENT 'The name or title of the individual or body that approved this rank change. Typically includes Provost, Board of Trustees, President, or Promotion and Tenure Committee.',
    `change_reason` STRING COMMENT 'The business reason or trigger for this rank change. Common reasons include promotion through tenure and promotion process, initial appointment at hire, reclassification due to role change, or administrative adjustment.. Valid values are `Promotion|Initial Appointment|Reclassification|Demotion|Administrative Adjustment|Tenure Award`',
    `college_code` STRING COMMENT 'The code of the college or school in which the faculty member held this rank at the time of the change. Enables college-level faculty progression analysis.',
    `contract_months` STRING COMMENT 'The number of months in the faculty members annual contract at this rank. Common values are 9 (academic year) or 12 (calendar year).',
    `cumulative_years_of_service` DECIMAL(18,2) COMMENT 'The total number of years of service at the institution at the time of this rank change. Includes all prior appointments and ranks. Used for seniority and tenure clock calculations.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the salary amount. Typically USD for U.S. institutions.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'The code of the academic department in which the faculty member held this rank at the time of the change. Supports departmental reporting and accreditation tracking.',
    `effective_date` DATE COMMENT 'The date on which the new rank officially became effective. This is the authoritative date for calculating time-in-rank for future promotion eligibility and for accreditation reporting.',
    `external_hire_flag` BOOLEAN COMMENT 'Boolean indicator of whether this rank change represents an initial appointment from outside the institution (external hire) versus an internal promotion. Used to distinguish hiring patterns from internal progression.',
    `fte` DECIMAL(18,2) COMMENT 'The Full-Time Equivalent (FTE) value representing the proportion of a full-time workload assigned to this faculty member at this rank. Used for IPEDS reporting and workload analysis.',
    `new_rank` STRING COMMENT 'The academic rank assigned to the faculty member as a result of this change. Represents the current rank following promotion, initial appointment, or reclassification.. Valid values are `Instructor|Assistant Professor|Associate Professor|Professor|Distinguished Professor|Lecturer`',
    `prior_institution_name` STRING COMMENT 'The name of the institution where the faculty member was employed immediately before this appointment, if applicable. Captured for external hires to track faculty mobility and recruitment sources.',
    `prior_rank` STRING COMMENT 'The academic rank held by the faculty member immediately before this change. Standard academic ranks include Instructor, Assistant Professor, Associate Professor, Professor, Distinguished Professor, and Lecturer.. Valid values are `Instructor|Assistant Professor|Associate Professor|Professor|Distinguished Professor|Lecturer`',
    `promotion_eligibility_date` DATE COMMENT 'The earliest date on which the faculty member becomes eligible for consideration for the next rank, based on institutional time-in-rank policies. Calculated from the effective date of this rank change.',
    `rank_change_notes` STRING COMMENT 'Free-text notes providing additional context or details about this rank change. May include special circumstances, conditions, or administrative remarks.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this rank history record was first created in the source system. Used for audit trail and data lineage tracking.',
    `record_current_flag` BOOLEAN COMMENT 'Boolean indicator of whether this is the most recent and currently active rank history record for the faculty member. Used to simplify queries for current state analysis.',
    `record_effective_from_date` DATE COMMENT 'The date from which this rank history record is considered valid and effective in the data warehouse. Supports slowly changing dimension (SCD) Type 2 historization.',
    `record_effective_to_date` DATE COMMENT 'The date until which this rank history record is considered valid and effective in the data warehouse. Null indicates the record is currently active. Supports slowly changing dimension (SCD) Type 2 historization.',
    `record_source_system` STRING COMMENT 'The name of the source system from which this rank history record originated. Typically Workday HCM, Ellucian Banner HR, or PeopleSoft HCM.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this rank history record was last updated in the source system. Used for change tracking and data freshness assessment.',
    `salary_at_change` DECIMAL(18,2) COMMENT 'The annual base salary assigned to the faculty member at the time of this rank change. Captured for historical compensation analysis and equity studies.',
    `tenure_track_status` STRING COMMENT 'The tenure track classification associated with this rank at the time of the change. Indicates whether the position is tenure-track, tenured, or non-tenure track (e.g., clinical, research, or teaching track).. Valid values are `Tenure Track|Tenured|Non-Tenure Track|Clinical Track|Research Track`',
    `terminal_degree_flag` BOOLEAN COMMENT 'Boolean indicator of whether the faculty member held a terminal degree in their discipline at the time of this rank change. Terminal degree is typically a PhD, EdD, or equivalent highest degree in the field.',
    `years_in_prior_rank` DECIMAL(18,2) COMMENT 'The number of years the faculty member served in the prior rank before this change. Calculated from the prior ranks effective date to this changes effective date. Used for promotion velocity analysis.',
    CONSTRAINT pk_rank_history PRIMARY KEY(`rank_history_id`)
) COMMENT 'Immutable historical record of all academic rank changes for a faculty member, capturing prior rank, new rank, effective date, reason for change (promotion, initial appointment, reclassification), approving authority, and associated tenure case reference. Enables longitudinal tracking of faculty career progression and supports accreditation reporting on faculty qualifications over time.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`department_affiliation` (
    `department_affiliation_id` BIGINT COMMENT 'Unique identifier for the department affiliation record. Primary key for this association entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Joint appointments and departmental affiliations split salary and budget across multiple cost centers based on FTE and salary_allocation_percentage. Links enable split-funded position tracking, cross-',
    `org_unit_id` BIGINT COMMENT 'Identifier of the academic department to which the faculty member is affiliated. References the department master record.',
    `instructor_id` BIGINT COMMENT 'Identifier of the faculty member holding this departmental affiliation. References the faculty master record.',
    `accreditation_qualified_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the faculty member meets the accreditation bodys qualification standards for this departmental affiliation. Critical for AACSB, ABET, and other specialized accreditation reporting. True if the faculty member holds appropriate terminal degree and meets scholarly activity requirements.',
    `affiliation_notes` STRING COMMENT 'Free-text notes documenting special conditions, arrangements, or context for this departmental affiliation. May include details about joint appointment agreements, temporary assignments, or unique workload arrangements.',
    `affiliation_status` STRING COMMENT 'Current lifecycle status of the departmental affiliation. Active indicates the affiliation is in effect. Pending indicates approval in progress. Inactive indicates temporary suspension. Suspended indicates administrative hold. Terminated indicates the affiliation has ended.. Valid values are `active|inactive|pending|suspended|terminated`',
    `affiliation_type` STRING COMMENT 'Type of affiliation the faculty member holds with the department. Teaching indicates instructional responsibilities, research indicates research program participation, administrative indicates leadership or service roles, clinical indicates patient care or clinical supervision, joint indicates shared appointment, and courtesy indicates honorary or collaborative affiliation without formal FTE allocation.. Valid values are `teaching|research|administrative|clinical|joint|courtesy`',
    `appointment_designation` STRING COMMENT 'Designation indicating whether this is the faculty members primary home department or a secondary/joint appointment. Primary indicates the main administrative home and tenure home if applicable. Secondary and joint indicate additional departmental affiliations. Adjunct and affiliate indicate non-tenure-track or courtesy relationships.. Valid values are `primary|secondary|joint|adjunct|affiliate`',
    `approval_date` DATE COMMENT 'Date on which the departmental affiliation was formally approved by the department chair or appropriate authority. Used for compliance tracking and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this departmental affiliation record was first created in the system. Used for audit trails and data lineage tracking.',
    `departmental_email` STRING COMMENT 'Department-specific email address for the faculty member. May differ from the primary institutional email if the department uses a specialized domain or alias structure. Used for departmental communications and student contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `doctoral_committee_eligibility` BOOLEAN COMMENT 'Boolean flag indicating whether the faculty member is eligible to serve on or chair doctoral dissertation committees within this departmental affiliation. Used for graduate program administration and student advising assignment.',
    `effective_end_date` DATE COMMENT 'Date on which this departmental affiliation ended or is scheduled to end. Null for active, ongoing affiliations. Used to track historical affiliations and support time-based queries for accreditation and reporting.',
    `effective_start_date` DATE COMMENT 'Date on which this departmental affiliation became effective. Marks the beginning of the faculty members formal association with the department for this appointment.',
    `fte_percentage` DECIMAL(18,2) COMMENT 'Percentage of the faculty members full-time equivalent effort allocated to this department. For primary appointments typically 100.00, for joint appointments the sum across all departments equals 100.00. Used for workload planning, budgeting, and IPEDS reporting.',
    `graduate_faculty_status` STRING COMMENT 'Status indicating the faculty members eligibility to teach graduate courses, chair dissertation committees, and participate in graduate program governance within this department. Full status allows all graduate activities, associate allows limited participation, none indicates undergraduate-only appointment.. Valid values are `full|associate|none`',
    `last_modified_by` STRING COMMENT 'Username or identifier of the system user who most recently modified this departmental affiliation record. Used for audit trails and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this departmental affiliation record was most recently updated. Used for change tracking and audit trails.',
    `office_location` STRING COMMENT 'Physical office location assigned to the faculty member within this departmental affiliation. Includes building name and room number. Used for directory services, space planning, and student advising.',
    `office_phone` STRING COMMENT 'Office telephone number for the faculty member at this departmental location. Used for directory services and student contact. May differ across multiple affiliations if the faculty member maintains offices in multiple departments.',
    `qualification_category` STRING COMMENT 'Accreditation qualification category for the faculty member within this affiliation. Scholarly Academic indicates terminal degree with sustained scholarly research. Practice Academic indicates terminal degree with sustained professional practice. Scholarly Practitioner indicates professional experience with scholarly contributions. Instructional Practitioner indicates teaching expertise. Additional indicates supplemental instructional support. Used for AACSB and specialized accreditation reporting.. Valid values are `scholarly_academic|practice_academic|scholarly_practitioner|instructional_practitioner|additional`',
    `research_load_percentage` DECIMAL(18,2) COMMENT 'Percentage of the faculty members effort within this affiliation allocated to research activities. Used for research productivity tracking and grant budgeting. Particularly important for research-intensive institutions and NSF/NIH reporting.',
    `salary_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the faculty members total salary charged to this departments budget. For joint appointments, the sum across all affiliations equals 100.00. Used for financial reporting and cost distribution.',
    `service_load_percentage` DECIMAL(18,2) COMMENT 'Percentage of the faculty members effort within this affiliation allocated to service and administrative responsibilities. Includes committee work, departmental governance, and institutional service. Used for workload equity analysis and promotion review.',
    `teaching_load_percentage` DECIMAL(18,2) COMMENT 'Percentage of the faculty members effort within this affiliation allocated to teaching responsibilities. Used for workload planning and accreditation reporting. May differ from overall FTE percentage if the affiliation includes research or administrative duties.',
    `tenure_home_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this department is the faculty members tenure home. True if this is the department responsible for tenure review and promotion decisions. A faculty member can have only one tenure home at a time.',
    `voting_rights_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the faculty member has voting rights in departmental governance for this affiliation. Typically true for primary appointments and tenure-track faculty, false for courtesy or adjunct affiliations. Used for meeting quorum calculations and election eligibility.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this departmental affiliation record. Used for audit trails and accountability.',
    CONSTRAINT pk_department_affiliation PRIMARY KEY(`department_affiliation_id`)
) COMMENT 'Association entity capturing a faculty members formal affiliations with academic departments, schools, and colleges, including primary vs. secondary/joint appointment designation, affiliation type (teaching, research, administrative), FTE percentage allocated to each unit, effective dates, and the department chair who approved the affiliation. A single faculty member may hold joint appointments across multiple departments, making this a critical many-to-many relationship with its own business attributes.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`credential` (
    `credential_id` BIGINT COMMENT 'Unique identifier for the faculty credential record. Primary key.',
    `accreditation_standard_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_standard. Business justification: Faculty credentials are evaluated against specific accreditation standards (AACSB requires doctoral degrees in discipline, ABET requires professional experience). Accreditation officers map credential',
    `instructor_id` BIGINT COMMENT 'Reference to the faculty member who holds this credential. Links to the faculty master data product.',
    `accreditation_qualifier` STRING COMMENT 'Indicates whether this credential qualifies the faculty member to teach in their assigned discipline per accreditation standards (qualified, provisionally qualified, not qualified, under review).. Valid values are `qualified|provisionally_qualified|not_qualified|under_review`',
    `awarding_institution` STRING COMMENT 'Name of the college, university, or certifying body that conferred the credential.',
    `awarding_institution_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the awarding institution (e.g., USA, CAN, GBR, AUS).. Valid values are `^[A-Z]{3}$`',
    `cip_code` STRING COMMENT 'Six-digit CIP code representing the field of study (format: XX.XXXX). Used for IPEDS reporting and accreditation qualification tracking.. Valid values are `^d{2}.d{4}$`',
    `conferral_date` DATE COMMENT 'Date on which the credential was officially conferred or awarded to the faculty member.',
    `continuing_education_required_flag` BOOLEAN COMMENT 'Indicates whether the credential requires ongoing continuing education or professional development to maintain validity (True/False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this credential record was first created in the system.',
    `credential_level` STRING COMMENT 'Hierarchical level of the credential (doctoral, masters, bachelors, associate, certificate, license, other). Used for faculty qualification analysis. [ENUM-REF-CANDIDATE: doctoral|masters|bachelors|associate|certificate|license|other — 7 candidates stripped; promote to reference product]',
    `credential_name` STRING COMMENT 'Full official name or title of the credential as conferred by the awarding institution or body (e.g., Doctor of Philosophy in Educational Leadership, Certified Public Accountant, Professional Engineer License).',
    `credential_type` STRING COMMENT 'Classification of the credential (e.g., academic degree, professional certification, state license, professional designation, fellowship, other).. Valid values are `degree|certification|license|professional_designation|fellowship|other`',
    `degree_type` STRING COMMENT 'Specific type of academic degree earned (e.g., PhD, EdD, DBA, JD, MD, MBA, MFA, MS, MA, MEd, MPA, MPH, BS, BA, AA). Null for non-degree credentials. [ENUM-REF-CANDIDATE: PhD|EdD|DBA|JD|MD|MBA|MFA|MS|MA|MEd|MPA|MPH|BS|BA|AA|other — 16 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date from which this credential record is effective for faculty qualification purposes. May differ from conferral date if credential was added to the system retroactively.',
    `end_date` DATE COMMENT 'Date on which this credential record is no longer effective for faculty qualification purposes. Null for currently active credentials.',
    `expiration_date` DATE COMMENT 'Date on which the credential expires and requires renewal. Applicable for licenses and certifications with time-limited validity. Null for degrees and permanent credentials.',
    `field_of_study` STRING COMMENT 'Academic discipline or professional field in which the credential was earned (e.g., Computer Science, Business Administration, Nursing, Mechanical Engineering).',
    `issuing_body_accreditation_status` STRING COMMENT 'Accreditation status of the institution or body that awarded the credential (regionally accredited, nationally accredited, internationally recognized, not accredited, unknown). Critical for determining credential validity.. Valid values are `regionally_accredited|nationally_accredited|internationally_recognized|not_accredited|unknown`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this credential record was last updated in the system.',
    `license_number` STRING COMMENT 'Official license or certification number assigned by the issuing authority. Applicable for professional licenses and certifications. Null for academic degrees.',
    `license_state` STRING COMMENT 'Two-letter US state code where the professional license was issued (e.g., CA, TX, NY). Applicable for state-issued licenses. Null for non-US or non-license credentials.. Valid values are `^[A-Z]{2}$`',
    `notes` STRING COMMENT 'Free-text field for additional information about the credential, verification process, or special circumstances (e.g., Degree from foreign institution, equivalency evaluated by WES, ABD status - dissertation in progress).',
    `primary_credential_flag` BOOLEAN COMMENT 'Indicates whether this is the faculty members primary or highest credential used for qualification purposes (True/False). Typically the terminal degree in their teaching discipline.',
    `record_status` STRING COMMENT 'Current status of this credential record in the system (active, inactive, archived, deleted). Active records are used for qualification tracking and reporting.. Valid values are `active|inactive|archived|deleted`',
    `renewal_date` DATE COMMENT 'Most recent date on which the credential was renewed. Applicable for time-limited credentials. Null for degrees and credentials that do not require renewal.',
    `source_system` STRING COMMENT 'Name of the source system from which this credential record was ingested (e.g., Workday HCM, Banner HR, Manual Entry).',
    `source_system_code` STRING COMMENT 'Unique identifier for this credential record in the source system. Used for data lineage and reconciliation.',
    `teaching_discipline_alignment` STRING COMMENT 'Indicates how closely the credential aligns with the faculty members teaching assignment (direct match, related field, unrelated, not applicable).. Valid values are `direct_match|related_field|unrelated|not_applicable`',
    `terminal_degree_flag` BOOLEAN COMMENT 'Indicates whether this credential is considered a terminal degree in the faculty members discipline (True/False). Terminal degrees vary by field (e.g., PhD in sciences, MFA in fine arts, JD in law).',
    `transcript_on_file_flag` BOOLEAN COMMENT 'Indicates whether an official transcript for this credential is on file in the faculty members personnel record (True/False). Required for accreditation documentation.',
    `verification_date` DATE COMMENT 'Date on which the credential was verified by the institution or third-party verification service. Null if not yet verified.',
    `verification_method` STRING COMMENT 'Method used to verify the credential (e.g., official transcript, diploma copy, third-party verification service, license lookup, direct contact with awarding institution, self-reported).. Valid values are `transcript|diploma|third_party_service|license_lookup|direct_contact|self_reported`',
    `verification_source` STRING COMMENT 'Entity or service that verified the credential (e.g., National Student Clearinghouse, Direct from Institution, State Licensing Board, Professional Association).',
    `verification_status` STRING COMMENT 'Current status of credential verification (verified, pending verification, not verified, expired, revoked). Critical for accreditation compliance.. Valid values are `verified|pending|not_verified|expired|revoked`',
    CONSTRAINT pk_credential PRIMARY KEY(`credential_id`)
) COMMENT 'Stores verified academic credentials and professional certifications held by faculty, including degree type (PhD, EdD, MFA, JD, MD, MBA), awarding institution, field of study, CIP code, conferral date, verification status, verification date, and verification source. Supports accreditation qualification tracking (SACSCOC, HLC, ABET, AACSB) by providing evidence that instructors meet the minimum credential requirements for the courses they teach. Sourced from Workday HCM education records.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`teaching_load` (
    `teaching_load_id` BIGINT COMMENT 'Unique identifier for the teaching load record. Primary key for the teaching load entity.',
    `instructor_id` BIGINT COMMENT 'Identifier of the faculty member to whom this teaching load is assigned. Links to the faculty master data entity.',
    `academic_term_code` STRING COMMENT 'Six-digit code representing the academic term for this teaching load assignment (e.g., 202401 for Spring 2024). Standard Banner term code format.. Valid values are `^[0-9]{6}$`',
    `accreditation_qualified_flag` BOOLEAN COMMENT 'Indicates whether the faculty member meets accreditation body qualifications (e.g., AACSB (Association to Advance Collegiate Schools of Business), ABET (Accreditation Board for Engineering and Technology)) to teach courses in this teaching load assignment. Critical for accreditation compliance reporting.',
    `actual_credit_hours_taught` DECIMAL(18,2) COMMENT 'The actual credit hours (CR) taught by the faculty member during this term, calculated from assigned course sections and their credit hour values.',
    `adjusted_contracted_hours` DECIMAL(18,2) COMMENT 'Contracted credit hours minus total release hours, representing the effective teaching load expectation after all reductions are applied.',
    `administrative_release_hours` DECIMAL(18,2) COMMENT 'Credit hours of teaching load reduction granted for administrative duties such as department chair, program director, or committee leadership roles.',
    `appointment_type` STRING COMMENT 'Type of faculty appointment for this teaching load assignment. Determines workload expectations and compensation rules. [ENUM-REF-CANDIDATE: tenure_track|tenured|clinical|adjunct|visiting|lecturer|research|emeritus — 8 candidates stripped; promote to reference product]',
    `collective_bargaining_compliant_flag` BOOLEAN COMMENT 'Indicates whether this teaching load assignment complies with applicable collective bargaining agreement provisions regarding workload, overload compensation, and release time.',
    `college_code` STRING COMMENT 'Code identifying the college or school to which the department belongs.. Valid values are `^[A-Z]{2,4}$`',
    `contract_months` STRING COMMENT 'Number of months in the faculty members annual contract (e.g., 9 for academic year, 12 for calendar year). Influences term-based teaching load distribution.',
    `contracted_credit_hours` DECIMAL(18,2) COMMENT 'The total credit hours (CR) the faculty member is contractually obligated to teach during this academic term, as specified in their employment agreement or collective bargaining contract.',
    `dean_approval_date` DATE COMMENT 'Date on which the college dean approved this teaching load assignment.',
    `dean_approval_flag` BOOLEAN COMMENT 'Indicates whether the college dean has approved this teaching load assignment, typically required for overload or significant release time.',
    `department_chair_approval_date` DATE COMMENT 'Date on which the department chair approved this teaching load assignment.',
    `department_chair_approval_flag` BOOLEAN COMMENT 'Indicates whether the department chair has approved this teaching load assignment and any associated overload or release time.',
    `department_code` STRING COMMENT 'Code identifying the academic department responsible for this teaching load assignment.. Valid values are `^[A-Z]{2,6}$`',
    `faculty_rank` STRING COMMENT 'Academic rank of the faculty member at the time of this teaching load assignment. May influence workload expectations and compensation. [ENUM-REF-CANDIDATE: professor|associate_professor|assistant_professor|instructor|lecturer|adjunct|visiting|emeritus — 8 candidates stripped; promote to reference product]',
    `faculty_to_student_ratio` DECIMAL(18,2) COMMENT 'Ratio of faculty FTE to total student enrollment for this teaching load assignment. Used for accreditation reporting and workload equity analysis.',
    `fte` DECIMAL(18,2) COMMENT 'Full-Time Equivalent (FTE) appointment percentage for the faculty member during this term (e.g., 1.00 for full-time, 0.50 for half-time). Affects teaching load expectations.',
    `graduate_course_flag` BOOLEAN COMMENT 'Indicates whether any of the assigned course sections are graduate-level courses. Graduate teaching may carry different workload weights in some institutions.',
    `hybrid_course_flag` BOOLEAN COMMENT 'Indicates whether any of the assigned course sections are delivered in a hybrid format (combination of in-person and online instruction).',
    `load_assignment_notes` STRING COMMENT 'Free-text notes providing additional context about this teaching load assignment, such as special circumstances, course development activities, or workload adjustments.',
    `load_balance_status` STRING COMMENT 'Indicates whether the faculty members actual teaching load is balanced with their adjusted contracted hours, under the expected load, over the expected load, or fully released from teaching.. Valid values are `balanced|underload|overload|release_only`',
    `load_variance_hours` DECIMAL(18,2) COMMENT 'Difference between actual credit hours taught and adjusted contracted hours. Positive values indicate overload; negative values indicate underload.',
    `number_of_sections_assigned` STRING COMMENT 'The total count of course sections assigned to the faculty member for this academic term.',
    `online_course_flag` BOOLEAN COMMENT 'Indicates whether any of the assigned course sections are delivered fully online. May affect workload calculations and compensation in some institutions.',
    `other_release_hours` DECIMAL(18,2) COMMENT 'Credit hours of teaching load reduction granted for reasons not categorized as research, administrative, or sabbatical (e.g., professional development, special projects, course development).',
    `overload_credit_hours` DECIMAL(18,2) COMMENT 'Credit hours (CR) taught beyond the contracted teaching load, typically compensated at an overload rate per collective bargaining agreement or institutional policy.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this teaching load record was first created in the system.',
    `record_current_flag` BOOLEAN COMMENT 'Indicates whether this is the current active teaching load record for the faculty member and term. Supports Type 2 slowly changing dimension tracking.',
    `record_effective_from_date` DATE COMMENT 'Date from which this teaching load record is effective. Supports temporal tracking of teaching load assignments.',
    `record_effective_to_date` DATE COMMENT 'Date until which this teaching load record is effective. Null indicates the record is currently active.',
    `record_source_system` STRING COMMENT 'Identifies the source system from which this teaching load record originated (e.g., Banner, Workday HCM, manual entry, integrated data feed).. Valid values are `banner|workday|manual_entry|integrated_feed`',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this teaching load record was last updated in the system.',
    `research_release_hours` DECIMAL(18,2) COMMENT 'Credit hours of teaching load reduction granted for research activities, grant-funded projects, or scholarly work. Reduces the contracted teaching obligation.',
    `sabbatical_release_hours` DECIMAL(18,2) COMMENT 'Credit hours of teaching load reduction granted due to approved sabbatical leave during this term.',
    `student_credit_hours_generated` DECIMAL(18,2) COMMENT 'Total student credit hours (SCH) generated by the faculty members assigned course sections during this term. Calculated as sum of (course credit hours × enrollment count) across all sections. Used for productivity and faculty-to-student ratio analysis.',
    `tenure_track_status` STRING COMMENT 'Indicates whether the faculty member is on a tenure track, has achieved tenure, or is in a non-tenure-track position at the time of this teaching load assignment.. Valid values are `tenure_track|tenured|non_tenure_track|not_applicable`',
    `terminal_degree_flag` BOOLEAN COMMENT 'Indicates whether the faculty member holds a terminal degree in their discipline (e.g., PhD, MFA, JD) at the time of this teaching load assignment. Used for accreditation and faculty qualification reporting.',
    `total_enrollment_count` STRING COMMENT 'Total number of students enrolled across all course sections assigned to the faculty member for this term.',
    `total_release_hours` DECIMAL(18,2) COMMENT 'Sum of all release hours (research, administrative, sabbatical, other) granted for this term. Used to calculate adjusted teaching load expectations.',
    CONSTRAINT pk_teaching_load PRIMARY KEY(`teaching_load_id`)
) COMMENT 'Tracks the assigned and actual teaching load for a faculty member by academic term, including contracted credit hours, actual credit hours taught, number of course sections assigned, overload credit hours, release time granted (research release, administrative release, sabbatical), load balance status, and department chair approval. Supports workload equity analysis, collective bargaining compliance, and accreditation faculty-to-student ratio reporting. Aligned with Banner and Workday HCM term-based assignment data.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`scholarly_activity` (
    `scholarly_activity_id` BIGINT COMMENT 'Unique identifier for the scholarly activity record. Primary key for the scholarly activity entity.',
    `bib_record_id` BIGINT COMMENT 'Foreign key linking to library.bib_record. Business justification: Faculty publications are cataloged in institutional repositories and library discovery systems. Linking scholarly_activity to bib_record enables tenure review dossiers, institutional research impact r',
    `donor_id` BIGINT COMMENT 'Foreign key linking to advancement.donor. Business justification: Research outputs often enabled by donor-funded labs, equipment, or endowed chairs. Stewardship requires linking publications/patents to donors for impact reports. Real business process: annual donor s',
    `endowment_id` BIGINT COMMENT 'Foreign key linking to advancement.endowment. Business justification: Research funded by endowment distributions (endowed chairs, research funds) requires linkage for stewardship. Real business process: endowment stewardship reports to donors cite publications, patents,',
    `gift_id` BIGINT COMMENT 'Foreign key linking to advancement.gift. Business justification: Specific restricted gifts fund specific research projects. Grant accounting and gift compliance require direct linkage between scholarly outputs and gift IDs. Real business process: restricted gift ag',
    `grant_account_id` BIGINT COMMENT 'Foreign key linking to finance.grant_account. Business justification: Grant-funded scholarly activities (publications, conferences, research) must link to the specific grant account for allowability verification, effort reporting, cost allocation, and sponsor reporting.',
    `instructor_id` BIGINT COMMENT 'Identifier of the faculty member who performed or participated in this scholarly activity. Links to the faculty master data.',
    `scholarly_output_id` BIGINT COMMENT 'Foreign key linking to research.scholarly_output. Business justification: Faculty scholarly activities (publications, presentations) are the same entities tracked in research output repository. Required for: promotion/tenure dossiers, accreditation reports (AACSB, ABET), RA',
    `accreditation_qualified_flag` BOOLEAN COMMENT 'Indicates whether this scholarly activity contributes to the faculty members accreditation qualification status for AACSB, ABET, or other specialized accreditation bodies.',
    `activity_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for the scholarly activity, including registration fees, travel, materials, or publication charges. Supports faculty development budget tracking.',
    `activity_date` DATE COMMENT 'Date when the scholarly activity occurred, was published, presented, or completed. Primary business event timestamp for the activity.',
    `activity_notes` STRING COMMENT 'Additional notes, context, or commentary about the scholarly activity. Captures qualitative information for annual review and dossier preparation.',
    `activity_subtype` STRING COMMENT 'Detailed classification within the activity type. Examples: journal article, book chapter, conference paper, poster presentation, invited lecture, juried exhibition, recital, utility patent, design patent, CEU workshop, professional certification.',
    `activity_title` STRING COMMENT 'Full title of the scholarly activity, publication, presentation, creative work, or professional development program.',
    `activity_type` STRING COMMENT 'Classification of the scholarly activity. Distinguishes between publications, presentations, creative works, professional development, and intellectual property contributions. [ENUM-REF-CANDIDATE: publication|presentation|exhibition|performance|patent|workshop|conference|training|certification|grant — 10 candidates stripped; promote to reference product]',
    `author_sequence` STRING COMMENT 'Position of the faculty member in the author list. First author, corresponding author, or other position. Important for promotion and tenure evaluation of research contribution.',
    `certification_issuing_body` STRING COMMENT 'Organization or professional body that issued the certification or credential. Validates professional qualifications.',
    `certification_name` STRING COMMENT 'Name of the professional certification or credential earned. Examples: PMP, CPA, PE, board certification. Supports faculty qualification tracking.',
    `citation_count` STRING COMMENT 'Number of times the scholarly work has been cited by other researchers. Measures scholarly impact and influence.',
    `co_authors_or_participants` STRING COMMENT 'Names of co-authors, co-presenters, co-investigators, or other collaborators on the scholarly activity. Supports collaboration tracking and interdisciplinary research reporting.',
    `college_code` STRING COMMENT 'Code of the college or school to which the faculty member belonged at the time of the activity. Supports college-level scholarly productivity analysis.',
    `conference_location` STRING COMMENT 'City and country where the conference or event took place. Supports travel reporting and international engagement tracking.',
    `conference_name` STRING COMMENT 'Full name of the conference, symposium, or professional meeting where the activity was presented.',
    `corresponding_author_flag` BOOLEAN COMMENT 'Indicates whether the faculty member was the corresponding author for the publication. Demonstrates leadership in research dissemination.',
    `credit_hours_or_ceus` DECIMAL(18,2) COMMENT 'Number of credit hours or CEUs earned for professional development activities such as workshops, training programs, or certifications. Used for faculty development tracking and accreditation qualification.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the activity cost. Examples: USD, EUR, GBP.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Code of the academic department to which the faculty member belonged at the time of the activity. Supports departmental productivity reporting.',
    `discipline_or_cip_code` STRING COMMENT 'CIP code or discipline classification for the scholarly activity. Aligns faculty scholarly work with program accreditation and IPEDS reporting.',
    `doi` STRING COMMENT 'Digital Object Identifier for publications and scholarly works. Provides persistent link to the published work and supports citation tracking.',
    `externally_funded_flag` BOOLEAN COMMENT 'Indicates whether the scholarly activity was supported by external funding from NSF, NIH, or other sponsors. Links scholarly productivity to research grant success.',
    `impact_factor` DECIMAL(18,2) COMMENT 'Journal impact factor or citation index score for the publication venue. Used for research quality assessment and promotion and tenure evaluation.',
    `included_in_promotion_dossier_flag` BOOLEAN COMMENT 'Indicates whether this scholarly activity was included in a promotion and tenure dossier. Supports faculty evaluation and career progression tracking.',
    `institutional_affiliation_at_time` TIMESTAMP COMMENT 'Name of the institution with which the faculty member was affiliated when the scholarly activity was completed. Tracks mobility and prior institutional contributions.',
    `intellectual_contribution_type` STRING COMMENT 'AACSB classification of the intellectual contribution: Learning and Pedagogical (PED), Contributions to Practice (PRA), Discipline-Based Scholarship (DIS). Used for AACSB accreditation reporting and faculty qualification.',
    `isbn` STRING COMMENT 'International Standard Book Number for books and book chapters. Used for cataloging and verification of published works.',
    `issn` STRING COMMENT 'International Standard Serial Number for journal publications. Used for journal identification and indexing verification.',
    `open_access_flag` BOOLEAN COMMENT 'Indicates whether the publication is available as open access. Supports institutional open access policies and public dissemination goals.',
    `patent_number` STRING COMMENT 'Patent number assigned by the patent office for intellectual property contributions. Used for technology transfer and commercialization tracking.',
    `patent_status` STRING COMMENT 'Current status of the patent application or grant. Tracks progression of intellectual property from filing to commercialization.. Valid values are `filed|pending|granted|expired|abandoned`',
    `peer_review_status` STRING COMMENT 'Indicates whether the activity underwent peer review, was invited, juried, or editorial. Critical for AACSB intellectual contributions classification and promotion and tenure evaluation.. Valid values are `peer_reviewed|invited|juried|non_peer_reviewed|editorial|not_applicable`',
    `presentation_type` STRING COMMENT 'Type of presentation for conference or symposium activities. Examples: keynote, invited talk, panel discussion, poster, workshop facilitator.',
    `publication_year` STRING COMMENT 'Calendar year of publication or presentation. Used for annual faculty review cycles and accreditation reporting periods.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this scholarly activity record was first created in the system. Supports data lineage and audit trail.',
    `record_source_system` STRING COMMENT 'Name of the source system from which this scholarly activity record originated. Examples: faculty activity reporting system, CV management system, research administration system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this scholarly activity record was last updated. Tracks data currency and modification history.',
    `venue_or_publisher` STRING COMMENT 'Name of the journal, publisher, conference, gallery, venue, or institution where the activity was published, presented, exhibited, or conducted.',
    CONSTRAINT pk_scholarly_activity PRIMARY KEY(`scholarly_activity_id`)
) COMMENT 'Records all faculty scholarly, creative, and professional development activities including publications (journal articles, books, book chapters, conference papers), presentations, exhibitions, performances, patents, workshops attended, conferences attended, training programs completed, certifications earned, and other intellectual or professional contributions. Captures activity type, title, venue or publisher, date, co-authors or co-participants, peer-review status, DOI or identifier, whether externally funded, credit hours or CEUs earned (for development activities), cost, and funding source. Supports annual faculty review, promotion and tenure dossier preparation, accreditation reporting on faculty scholarly productivity (RAE, AACSB AoL), and continuous improvement evidence.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`annual_review` (
    `annual_review_id` BIGINT COMMENT 'Unique identifier for the faculty annual performance review record. Primary key for the annual review entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Merit pay recommendations in annual reviews directly impact departmental salary budgets tracked by cost centers. Links enable budget planning, merit pool allocation by department/college, and reconcil',
    `instructor_id` BIGINT COMMENT 'Identifier of the faculty member being reviewed. Links to the faculty master data entity.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Annual faculty evaluations follow institutional evaluation policies that define review criteria, rating scales, timelines, and merit pay procedures. Department chairs and deans reference policy during',
    `academic_rank` STRING COMMENT 'The faculty members academic rank at the time of the review, reflecting their position in the academic hierarchy. [ENUM-REF-CANDIDATE: professor|associate_professor|assistant_professor|instructor|lecturer|clinical_professor|research_professor|adjunct_professor — 8 candidates stripped; promote to reference product]',
    `appointment_type` STRING COMMENT 'The type of faculty appointment held during the review period, indicating employment status and workload expectations.. Valid values are `full_time|part_time|adjunct|visiting|emeritus`',
    `approving_authority` STRING COMMENT 'Name or identifier of the administrative authority (typically dean or provost) who provided final approval of the annual review.',
    `average_course_evaluation_score` DECIMAL(18,2) COMMENT 'Mean student course evaluation score across all courses taught during the review period, typically on a 5-point scale.',
    `chair_review_submitted_date` DATE COMMENT 'The date on which the department chair completed and submitted their evaluation of the faculty member.',
    `committee_assignments_count` STRING COMMENT 'Total number of departmental, college, university, and professional organization committee assignments held during the review period.',
    `courses_taught_count` STRING COMMENT 'Total number of distinct courses taught by the faculty member during the review period.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for merit pay amount (e.g., USD for United States Dollar).. Valid values are `^[A-Z]{3}$`',
    `dean_review_submitted_date` DATE COMMENT 'The date on which the dean completed and submitted their review and approval of the faculty annual review.',
    `department_chair_narrative` STRING COMMENT 'Comprehensive written evaluation and commentary provided by the department chair, summarizing the faculty members performance, strengths, areas for development, and contributions to the department.',
    `faculty_self_evaluation_narrative` STRING COMMENT 'The faculty members self-assessment narrative describing their accomplishments, challenges, professional development activities, and goals for the review period.',
    `faculty_self_evaluation_submitted_date` DATE COMMENT 'The date on which the faculty member submitted their self-evaluation materials for the annual review.',
    `final_approval_date` DATE COMMENT 'The date on which the annual review was officially approved and closed, completing the review cycle.',
    `fte` DECIMAL(18,2) COMMENT 'The Full-Time Equivalent (FTE) percentage representing the faculty members workload commitment during the review period, where 1.000 equals full-time.',
    `goals_for_next_period` STRING COMMENT 'Faculty members stated goals and objectives for the upcoming review period, including teaching, research, and service priorities.',
    `graduate_students_advised_count` STRING COMMENT 'Total number of graduate students for whom the faculty member served as primary advisor or dissertation/thesis committee chair during the review period.',
    `grant_funding_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of external research funding awarded to the faculty member during the review period.',
    `grants_awarded_count` STRING COMMENT 'Total number of research grants awarded to the faculty member as Principal Investigator (PI) or Co-PI during the review period.',
    `grants_submitted_count` STRING COMMENT 'Total number of research grant proposals submitted by the faculty member as Principal Investigator (PI) or Co-PI during the review period.',
    `merit_pay_amount` DECIMAL(18,2) COMMENT 'The recommended dollar amount for merit-based salary increase, calculated based on performance rating and institutional merit pool allocation.',
    `merit_pay_percentage` DECIMAL(18,2) COMMENT 'The recommended percentage increase for merit-based salary adjustment, expressed as a percentage of current base salary.',
    `merit_pay_recommended_flag` BOOLEAN COMMENT 'Indicates whether the faculty member is recommended for merit-based salary increase based on performance during the review period.',
    `overall_performance_rating` STRING COMMENT 'The comprehensive performance rating assigned to the faculty member for the review period, reflecting aggregate performance across all evaluation dimensions.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `presentations_count` STRING COMMENT 'Total number of conference presentations, invited talks, and other scholarly presentations delivered during the review period.',
    `professional_development_activities` STRING COMMENT 'Description of professional development activities undertaken during the review period, including workshops, certifications, conferences attended, and skill development initiatives.',
    `publications_count` STRING COMMENT 'Total number of peer-reviewed publications, books, book chapters, and other scholarly works produced during the review period.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this annual review record was first created in the data platform.',
    `record_source_system` STRING COMMENT 'The source system from which this annual review record originated, typically Workday HCM Performance Management Module.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this annual review record was last updated in the data platform.',
    `research_rating` STRING COMMENT 'Performance rating for research and scholarly activity, including publications, grants, presentations, creative works, and contributions to the discipline.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_applicable`',
    `review_notes` STRING COMMENT 'Additional notes, comments, or administrative remarks related to the annual review process, including any special circumstances or follow-up actions required.',
    `review_period_end_date` DATE COMMENT 'The ending date of the performance period being evaluated in this annual review, typically the end of the academic or fiscal year.',
    `review_period_start_date` DATE COMMENT 'The beginning date of the performance period being evaluated in this annual review, typically the start of the academic or fiscal year.',
    `review_status` STRING COMMENT 'Current workflow status of the annual review process, tracking progression from initiation through final approval. [ENUM-REF-CANDIDATE: not_started|in_progress|self_evaluation_submitted|chair_review_submitted|dean_review_submitted|approved|closed — 7 candidates stripped; promote to reference product]',
    `service_rating` STRING COMMENT 'Performance rating for service contributions, including departmental service, university committee work, professional organization involvement, and community engagement.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_applicable`',
    `student_enrollment_count` STRING COMMENT 'Total number of students enrolled in courses taught by the faculty member during the review period.',
    `teaching_load_credit_hours` DECIMAL(18,2) COMMENT 'Total credit hours (CR) taught by the faculty member during the review period, used to assess teaching workload and productivity.',
    `teaching_rating` STRING COMMENT 'Performance rating for teaching effectiveness, including course delivery, student learning outcomes (SLO), course evaluations, and instructional innovation.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_applicable`',
    `tenure_track_status` STRING COMMENT 'The faculty members tenure classification at the time of the review, indicating whether they are on a tenure track, have achieved tenure, or hold a non-tenure appointment.. Valid values are `tenure_track|tenured|non_tenure_track|clinical_track|research_track`',
    CONSTRAINT pk_annual_review PRIMARY KEY(`annual_review_id`)
) COMMENT 'Captures the formal annual performance review record for a faculty member, including review period, overall performance rating, ratings across teaching, research/scholarship, and service dimensions, department chair narrative, faculty self-evaluation submission date, merit pay recommendation, and final approval status. Serves as the primary record for faculty performance management and merit compensation decisions in Workday HCM performance module.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`sabbatical` (
    `sabbatical_id` BIGINT COMMENT 'Unique identifier for the sabbatical leave record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sabbaticals have direct budget impact through continued salary payments (pay_continuation_percentage), replacement faculty costs, and teaching load redistribution. Cost center link enables sabbatical ',
    `donor_id` BIGINT COMMENT 'Foreign key linking to advancement.donor. Business justification: Sabbaticals often endowed or donor-funded (named sabbatical funds, research leave supplements). Stewardship requires tracking. Real business process: named sabbatical funds require annual reports to d',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Sabbatical requests must comply with institutional sabbatical policies defining eligibility (years of service), duration (semester vs. year), pay continuation percentage, and return-to-service obligat',
    `instructor_id` BIGINT COMMENT 'Identifier of the department chair who reviewed and approved or denied the leave request at the department level.',
    `employee_id` BIGINT COMMENT 'Identifier of the dean who reviewed and approved or denied the leave request at the college level.',
    `sabbatical_instructor_id` BIGINT COMMENT 'Identifier of the faculty member taking sabbatical leave. Links to faculty master data.',
    `sabbatical_provost_employee_id` BIGINT COMMENT 'Identifier of the provost or chief academic officer who provided final approval or denial of the leave request at the institutional level.',
    `sabbatical_replacement_faculty_instructor_id` BIGINT COMMENT 'Identifier of the replacement faculty member (adjunct, visiting, or internal) hired or assigned to cover teaching and service duties during the leave.',
    `actual_return_date` DATE COMMENT 'Actual date the faculty member returned from leave. Populated when leave is completed.',
    `actual_start_date` DATE COMMENT 'Actual date the faculty member began the leave. Populated when leave becomes active.',
    `approved_end_date` DATE COMMENT 'Officially approved end date of the leave period. May differ from requested date.',
    `approved_start_date` DATE COMMENT 'Officially approved start date of the leave period. May differ from requested date.',
    `benefits_continuation_flag` BOOLEAN COMMENT 'Indicates whether health and other benefits continue during the leave period.',
    `cancellation_reason` STRING COMMENT 'Explanation provided when an approved leave is cancelled before or during the leave period.',
    `case_number` STRING COMMENT 'Human-readable business identifier for the sabbatical leave case as assigned by HR or academic affairs.',
    `dean_approval_date` DATE COMMENT 'Date the dean approved or denied the leave request.',
    `dean_decision` STRING COMMENT 'Dean decision on the leave request.. Valid values are `approved|denied|pending`',
    `denial_reason` STRING COMMENT 'Explanation provided when a leave request is denied at any approval stage. Captures rationale for denial decision.',
    `department_chair_approval_date` DATE COMMENT 'Date the department chair approved or denied the leave request.',
    `department_chair_decision` STRING COMMENT 'Department chair decision on the leave request.. Valid values are `approved|denied|pending`',
    `expected_return_date` DATE COMMENT 'Expected date of return to active service. Used for planning and workload management.',
    `hr_case_reference` STRING COMMENT 'Reference number or identifier of the HR case or absence case in Workday HCM that tracks this leave event.',
    `leave_notes` STRING COMMENT 'Additional notes, comments, or special circumstances related to the leave event. Free-text field for case-specific information.',
    `leave_request_submitted_date` DATE COMMENT 'Date the faculty member submitted the leave request application.',
    `leave_status` STRING COMMENT 'Current lifecycle status of the leave request and execution. Tracks progression through approval workflow and leave period. [ENUM-REF-CANDIDATE: requested|pending_chair|pending_dean|pending_provost|approved|denied|active|completed|cancelled — 9 candidates stripped; promote to reference product]',
    `leave_type` STRING COMMENT 'Type of faculty leave. Sabbatical is the primary focus; other leave types (FMLA, medical, parental, military, administrative, unpaid) are also tracked in this product. [ENUM-REF-CANDIDATE: sabbatical|fmla|medical|parental|military|administrative|unpaid — 7 candidates stripped; promote to reference product]',
    `pay_continuation_percentage` DECIMAL(18,2) COMMENT 'Percentage of regular salary continued during the leave period. For full-year sabbatical at half pay this would be 50.00; for half-year at full pay this would be 100.00.',
    `post_sabbatical_report_due_date` DATE COMMENT 'Date by which the post-sabbatical report must be submitted. Typically 30-90 days after return from sabbatical.',
    `post_sabbatical_report_status` STRING COMMENT 'Status of the post-sabbatical report submission and review. Faculty are typically required to submit a report documenting sabbatical outcomes and scholarly productivity.. Valid values are `not_required|required|submitted|under_review|accepted|overdue`',
    `post_sabbatical_report_submitted_date` DATE COMMENT 'Date the faculty member submitted the post-sabbatical report.',
    `project_description` STRING COMMENT 'Detailed narrative description of the sabbatical project, research agenda, or professional development activities. Submitted as part of sabbatical application.',
    `provost_approval_date` DATE COMMENT 'Date the provost approved or denied the leave request.',
    `provost_decision` STRING COMMENT 'Provost decision on the leave request. Final institutional approval authority.. Valid values are `approved|denied|pending`',
    `purpose` STRING COMMENT 'Primary purpose category of the sabbatical leave. Applicable only when leave_type is sabbatical. [ENUM-REF-CANDIDATE: research|writing|professional_development|creative_work|field_study|collaboration|other — 7 candidates stripped; promote to reference product]',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sabbatical leave record was first created in the system.',
    `record_source_system` STRING COMMENT 'Name of the source system from which this record originated. Typically Workday HCM Absence Management module.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this sabbatical leave record was last modified.',
    `requested_end_date` DATE COMMENT 'Date the faculty member requested the leave to end.',
    `requested_start_date` DATE COMMENT 'Date the faculty member requested the leave to begin.',
    `return_to_service_commitment_months` STRING COMMENT 'Number of months the faculty member commits to return to active service following sabbatical. Typically one year (12 months) or two years (24 months) depending on institutional policy.',
    `sabbatical_type` STRING COMMENT 'Specific sabbatical arrangement: full academic year at half pay, half academic year at full pay, or other negotiated arrangement. Applicable only when leave_type is sabbatical.. Valid values are `full_year_half_pay|half_year_full_pay|other`',
    `teaching_load_impact_description` STRING COMMENT 'Narrative description of how the leave impacts teaching assignments, course coverage, and departmental workload distribution.',
    `tenure_clock_extension_granted_flag` BOOLEAN COMMENT 'Indicates whether a tenure clock extension (stop-the-clock) was granted in conjunction with this leave. Applicable for tenure-track faculty.',
    `tenure_clock_extension_months` STRING COMMENT 'Number of months by which the tenure clock was extended due to this leave. Typically 12 months for qualifying leaves.',
    CONSTRAINT pk_sabbatical PRIMARY KEY(`sabbatical_id`)
) COMMENT 'Manages all faculty leave events including sabbatical leave, FMLA leave, medical leave, parental leave, military leave, administrative leave, and unpaid leave. For sabbaticals: captures sabbatical type (full-year at half pay, half-year at full pay), purpose and project description, return-to-service commitment, and post-sabbatical report status. For all leave types: captures leave type, requested and approved dates, expected and actual return dates, approval chain status (department chair, dean, provost as applicable), HR case reference, and impact on tenure clock (whether a tenure clock extension was granted). Tracks the full lifecycle of faculty absence as managed in Workday HCM Absence Management module.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`service_assignment` (
    `service_assignment_id` BIGINT COMMENT 'Unique identifier for the faculty service assignment record. Primary key.',
    `access_entitlement_id` BIGINT COMMENT 'Foreign key linking to technology.access_entitlement. Business justification: Faculty service roles (IRB member, curriculum committee chair, department chair, graduate program director) require specific system access entitlements. Real business process: appointment to IRB grant',
    `affinity_group_id` BIGINT COMMENT 'Foreign key linking to advancement.affinity_group. Business justification: Faculty serve as advisors/liaisons to alumni chapters, regional clubs, and affinity groups (e.g., engineering alumni society, law school alumni board). Real business process: affinity group management',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Service assignments with compensation or course releases have budget impact on departmental cost centers. Links enable tracking of service-related costs, budget allocation for committee stipends, and ',
    `event_id` BIGINT COMMENT 'Foreign key linking to advancement.advancement_event. Business justification: Faculty serve as speakers, hosts, honorees at advancement events (galas, donor dinners, groundbreakings, campaign launches). Real business process: event planning tracks faculty participants for invit',
    `instructor_id` BIGINT COMMENT 'Identifier of the faculty member assigned to this service commitment. Links to the faculty master record.',
    `accreditation_service_flag` BOOLEAN COMMENT 'Indicates whether this service assignment is related to institutional or program accreditation activities (e.g., self-study committee, site visit team, accreditation liaison). Used for accreditation reporting and compliance tracking.',
    `appointment_authority` STRING COMMENT 'Name or title of the individual or body that appointed the faculty member to this service role (e.g., Provost, Dean, Faculty Senate, Department Chair, External Organization).',
    `appointment_date` DATE COMMENT 'Date on which the appointment was officially made or approved by the appointing authority.',
    `appointment_end_date` DATE COMMENT 'Date on which the faculty members service assignment ends. Nullable for ongoing or indefinite assignments.',
    `appointment_start_date` DATE COMMENT 'Date on which the faculty members service assignment begins. Effective start of the service commitment.',
    `assignment_notes` STRING COMMENT 'Free-text notes providing additional context, special conditions, or details about the service assignment. May include information about specific responsibilities, deliverables, or recognition received.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the service assignment. Indicates whether the assignment is currently active, has been completed, is temporarily suspended, or was cancelled.. Valid values are `active|completed|suspended|cancelled`',
    `committee_name` STRING COMMENT 'Full name of the committee, board, council, senate, or professional body to which the faculty member is assigned.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Monetary compensation or stipend provided for this service assignment, if any. Nullable for uncompensated service.',
    `compensation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation amount (e.g., USD, EUR, GBP). Applicable only when compensation is provided.. Valid values are `^[A-Z]{3}$`',
    `course_release_units` DECIMAL(18,2) COMMENT 'Number of course units or credit hours released from teaching load in recognition of this service assignment. Used in workload planning and faculty load balancing.',
    `elected_position_flag` BOOLEAN COMMENT 'Indicates whether the faculty member was elected to this service role by peers or members, as opposed to being appointed. Elected positions often carry greater weight in promotion and tenure review.',
    `irb_service_flag` BOOLEAN COMMENT 'Indicates whether this service assignment involves Institutional Review Board (IRB) responsibilities for human subjects research review. IRB service is tracked separately for compliance and workload purposes.',
    `leadership_role_flag` BOOLEAN COMMENT 'Indicates whether the faculty member holds a leadership position within the service assignment (e.g., Chair, President, Editor-in-Chief). Leadership roles are weighted more heavily in annual review and promotion dossiers.',
    `meeting_frequency` STRING COMMENT 'Expected frequency of meetings or activities for this service assignment. Provides context for time commitment estimation.. Valid values are `weekly|biweekly|monthly|quarterly|annually|as_needed`',
    `national_prominence_flag` BOOLEAN COMMENT 'Indicates whether the service assignment is with a nationally or internationally prominent organization or body. Used in promotion and tenure evaluation to assess the prestige and impact of service contributions.',
    `organization_name` STRING COMMENT 'Name of the external professional association, journal, funding agency, or community organization for which the service is performed. Applicable only to external service assignments.',
    `organization_type` STRING COMMENT 'Type of external organization for which the service is performed. Used to categorize external service contributions for promotion and tenure review.. Valid values are `professional_association|journal|funding_agency|accreditation_body|community_organization|government_agency`',
    `promotion_tenure_credit_flag` BOOLEAN COMMENT 'Indicates whether this service assignment is eligible for consideration in promotion and tenure review. Some service activities may be excluded from formal evaluation.',
    `record_created_by` STRING COMMENT 'User identifier or system account that created this service assignment record. Used for audit and accountability purposes.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service assignment record was first created in the system. Used for audit trail and data lineage tracking.',
    `record_source_system` STRING COMMENT 'Name of the source system from which this service assignment record originated (e.g., Workday HCM, Faculty Activity Reporting System, Manual Entry).',
    `record_updated_by` STRING COMMENT 'User identifier or system account that last modified this service assignment record. Used for audit and accountability purposes.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this service assignment record was last modified. Used for audit trail and change tracking.',
    `renewable_flag` BOOLEAN COMMENT 'Indicates whether the service assignment is renewable for additional terms upon expiration. Used to distinguish term-limited from potentially ongoing service commitments.',
    `role_title` STRING COMMENT 'Title or role held by the faculty member within the service assignment (e.g., Chair, Vice Chair, Member, Secretary, Ex-Officio, Officer, Editor, Reviewer).',
    `service_scope` STRING COMMENT 'Scope of the service assignment: internal (institutional governance and committees), external (professional associations, editorial boards, grant review panels), or community (public service and outreach).. Valid values are `internal|external|community`',
    `service_type` STRING COMMENT 'Category of service commitment. Distinguishes between governance, committee, review board, accreditation, and professional service roles. [ENUM-REF-CANDIDATE: faculty_senate|curriculum_committee|search_committee|irb|accreditation_self_study|editorial_board|professional_association_officer|advisory_board|peer_review_panel|grant_review_panel|community_service|student_organization_advisor — promote to reference product]. Valid values are `faculty_senate|curriculum_committee|search_committee|irb|accreditation_self_study|editorial_board`',
    `term_length_years` STRING COMMENT 'Standard length of the service term in years, if the assignment has a defined term (e.g., 2-year term for faculty senate, 3-year term for editorial board). Nullable for indefinite or ad-hoc assignments.',
    `time_commitment_hours_per_year` DECIMAL(18,2) COMMENT 'Estimated annual time commitment in hours required for this service assignment. Used for workload planning and annual review documentation.',
    `workload_credit_percentage` DECIMAL(18,2) COMMENT 'Percentage of the faculty members total workload allocated to this service assignment. Used in workload distribution calculations across teaching, research, and service.',
    CONSTRAINT pk_service_assignment PRIMARY KEY(`service_assignment_id`)
) COMMENT 'Records faculty service commitments to institutional governance and professional communities, including service type (faculty senate, curriculum committee, search committee, IRB, accreditation self-study, editorial board, professional association officer), committee or body name, role held, appointment start and end dates, time commitment estimate, and whether the service is internal (institutional) or external (professional/community). Supports annual review documentation and promotion and tenure dossier service section.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`accreditation_qualification` (
    `accreditation_qualification_id` BIGINT COMMENT 'Unique identifier for the accreditation qualification record. Primary key for this entity.',
    `academic_program_id` BIGINT COMMENT 'Identifier of the academic program for which the faculty qualification is being evaluated. Nullable if qualification applies to course-level teaching rather than program oversight.',
    `accreditation_review_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_review. Business justification: Faculty qualifications are verified and documented during accreditation reviews. Self-study teams compile qualification records for site visits. Accreditors assess whether faculty collectively meet st',
    `coach_id` BIGINT COMMENT 'Foreign key linking to athletics.coach. Business justification: Coaches teaching credit-bearing courses (kinesiology, sports management, coaching theory) must meet accreditation body standards (CAATE, COSMA, AACSB). Accreditation reviews require documentation of i',
    `course_id` BIGINT COMMENT 'Identifier of the specific course for which the faculty qualification is being evaluated. Nullable if qualification applies to program-level teaching rather than a specific course.',
    `employee_id` BIGINT COMMENT 'Identifier of the individual (typically department chair, dean, or credentialing officer) who reviewed and determined the faculty members qualification status.',
    `instructor_id` BIGINT COMMENT 'Identifier of the faculty member whose qualification is being assessed. Links to the faculty master record.',
    `accreditation_body` STRING COMMENT 'The accrediting agency or body whose qualification standards are being applied. Includes regional accreditors (SACSCOC, HLC, MSCHE, NWCCU, NECHE, WSCUC) and specialized/programmatic accreditors (ABET, AACSB, ABA, LCME, etc.). [ENUM-REF-CANDIDATE: SACSCOC|HLC|MSCHE|NWCCU|NECHE|WSCUC|ABET|AACSB|ABA|LCME|ACEN|CCNE|NAACLS|APA|CSWE|CEPH|CAHME|ACPE|JRCERT|CAATE|Other — 21 candidates stripped; promote to reference product]',
    `accreditation_visit_cycle` STRING COMMENT 'The accreditation review cycle or visit year for which this qualification determination was prepared. Used to organize qualification documentation for self-study and site visit preparation.',
    `approval_date` DATE COMMENT 'The date on which the qualification determination was formally approved by the reviewing authority. May differ from determination_date if multi-level approval is required.',
    `determination_date` DATE COMMENT 'The date on which the qualification determination was officially made by the reviewing authority.',
    `effective_end_date` DATE COMMENT 'The date on which the qualification determination expires or is no longer valid. Nullable for qualifications that do not expire (e.g., terminal degree qualifications).',
    `effective_start_date` DATE COMMENT 'The date from which the qualification determination is effective. Typically aligns with the start of the academic term or appointment period.',
    `expiration_date` DATE COMMENT 'The date on which time-limited qualifications (e.g., professional licensure, industry certifications, provisional qualifications) expire and require renewal or re-evaluation. Nullable for permanent qualifications.',
    `graduate_hours_in_discipline` STRING COMMENT 'The number of graduate-level credit hours the faculty member has completed in the specific teaching discipline. Relevant for qualification pathways requiring masters degree plus 18 graduate hours.',
    `industry_certification_date` DATE COMMENT 'The date on which the industry certification was awarded to the faculty member.',
    `industry_certification_expiration_date` DATE COMMENT 'The date on which the industry certification expires and requires renewal. Nullable for certifications that do not expire.',
    `industry_certification_issuing_body` STRING COMMENT 'The organization or body that issued the industry certification (e.g., PMI, CFA Institute, ISC2, Amazon Web Services).',
    `industry_certification_name` STRING COMMENT 'The name of the industry certification held by the faculty member that qualifies them to teach in the discipline (e.g., PMP, CFA, CISSP, AWS Certified Solutions Architect). Relevant when qualification pathway is industry certification.',
    `next_review_date` DATE COMMENT 'The date on which the qualification determination should be reviewed or renewed. Applicable for time-limited qualifications or when periodic review is required by policy.',
    `professional_experience_description` STRING COMMENT 'Narrative description of the faculty members relevant professional experience that supports their qualification to teach in the discipline. Includes roles, responsibilities, and achievements.',
    `professional_license_expiration_date` DATE COMMENT 'The date on which the professional license expires and requires renewal. Critical for maintaining qualification status for license-based pathways.',
    `professional_license_number` STRING COMMENT 'The license number or credential identifier for the faculty members professional license. Used for verification purposes.',
    `professional_license_state` STRING COMMENT 'The U.S. state or jurisdiction that issued the professional license. Uses two-letter state abbreviation (e.g., CA, TX, NY).',
    `professional_license_type` STRING COMMENT 'The type of professional license held by the faculty member that qualifies them to teach in the discipline (e.g., CPA, PE, RN, JD with bar admission). Relevant when qualification pathway is professional licensure.',
    `qualification_category` STRING COMMENT 'The faculty qualification category as defined by the accreditation body. Primarily used by AACSB: Scholarly Academic (SA), Practice Academic (PA), Instructional Practitioner (IP), or Additional (A). Other accreditors may use different taxonomies.. Valid values are `Scholarly Academic|Practice Academic|Instructional Practitioner|Additional|Other`',
    `qualification_notes` STRING COMMENT 'Additional notes, comments, or context regarding the qualification determination. May include special circumstances, conditions, or reviewer observations.',
    `qualification_pathway` STRING COMMENT 'The specific pathway or criterion by which the faculty member meets the accreditation bodys qualification standards. Examples include terminal degree in the teaching discipline, masters degree plus 18 graduate hours in the discipline, professional licensure, industry certification, or documented equivalent experience. [ENUM-REF-CANDIDATE: Terminal Degree in Discipline|Terminal Degree in Related Field|ABD with Progress|Masters plus 18 Graduate Hours|Professional Licensure|Industry Certification|Equivalent Professional Experience|Tested Experience|Other — 9 candidates stripped; promote to reference product]',
    `qualification_status` STRING COMMENT 'Current status of the faculty members qualification determination for the specified course or program under the given accreditation bodys standards.. Valid values are `Qualified|Provisionally Qualified|Not Qualified|Under Review|Expired|Pending Documentation`',
    `record_created_by` STRING COMMENT 'The user ID or system identifier of the individual or process that created this qualification record.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this qualification record was first created in the system.',
    `record_source_system` STRING COMMENT 'The source system or application from which this qualification record originated (e.g., Faculty Credentialing System, HR System, Accreditation Management System).',
    `record_updated_by` STRING COMMENT 'The user ID or system identifier of the individual or process that last updated this qualification record.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this qualification record was last updated in the system.',
    `requalification_required_flag` BOOLEAN COMMENT 'Indicates whether the faculty member will need to undergo requalification review in the future. True for time-limited qualifications (e.g., based on expiring licenses or certifications); False for permanent qualifications (e.g., terminal degree).',
    `reviewer_name` STRING COMMENT 'Full name of the individual who reviewed and approved the qualification determination. Captured for audit trail purposes.',
    `reviewer_title` STRING COMMENT 'Official title or role of the reviewer at the time of qualification determination (e.g., Department Chair, Associate Dean for Academic Affairs, Provost).',
    `scholarly_activity_summary` STRING COMMENT 'Summary of the faculty members scholarly and professional contributions that support their qualification status. May include publications, presentations, grants, creative works, or other intellectual contributions relevant to the teaching discipline.',
    `supporting_evidence_references` STRING COMMENT 'References to supporting documentation that substantiates the qualification determination. May include document repository paths, file names, or identifiers for transcripts, diplomas, licenses, certifications, CVs, or other credentials.',
    `terminal_degree_field` STRING COMMENT 'The academic discipline or field of study in which the faculty member holds their terminal degree (e.g., PhD in Economics, JD, MD, MFA in Creative Writing). Relevant when qualification pathway is based on terminal degree.',
    `terminal_degree_institution` STRING COMMENT 'The name of the institution that conferred the faculty members terminal degree. Used for verification and accreditation documentation.',
    `terminal_degree_year` STRING COMMENT 'The year in which the faculty members terminal degree was conferred. Used to assess recency of academic preparation.',
    `years_professional_experience` STRING COMMENT 'The number of years of relevant professional experience in the teaching discipline. Used to support qualification pathways based on equivalent professional experience or tested experience.',
    CONSTRAINT pk_accreditation_qualification PRIMARY KEY(`accreditation_qualification_id`)
) COMMENT 'Tracks whether a faculty member meets the qualification standards required by specific accreditation bodies (SACSCOC, HLC, ABET, AACSB, ABA, LCME) for each course or program they are assigned to teach. Captures the accreditation body, qualification pathway used (terminal degree, equivalent experience, professional licensure, industry certification), qualification determination date, reviewer, expiration date if applicable, and supporting evidence references. Critical for accreditation self-study and compliance audits.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`hire_event` (
    `hire_event_id` BIGINT COMMENT 'Unique identifier for the faculty hire event transaction. Primary key for the hire_event product.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Startup packages and relocation assistance must be charged to specific ledger accounts for financial tracking and budget control. Currently only has string budget_account_code; proper FK enables encum',
    `employee_id` BIGINT COMMENT 'Reference to the faculty member who chaired the search committee for this hire. Null for emergency or non-committee hires.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: New faculty hires require budget authorization from specific cost centers for salary, startup packages, and relocation. Links hiring decisions to budget availability, enables tracking of hiring costs ',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Faculty hiring follows institutional hiring policies governing search procedures, committee composition, diversity requirements, approval workflows, and offer authorization. Provost and HR verify poli',
    `instructor_id` BIGINT COMMENT 'Reference to the faculty member who was hired through this event. Links to the faculty master data product.',
    `service_request_id` BIGINT COMMENT 'Foreign key linking to technology.service_request. Business justification: New faculty hire events trigger IT onboarding service requests for account creation, equipment provisioning, office phone setup, building access. This tracks the IT service ticket that fulfills techno',
    `org_unit_id` BIGINT COMMENT 'Reference to the academic department that initiated and owns this faculty hire. The tenure home for tenure-track appointments.',
    `recruitment_requisition_id` BIGINT COMMENT 'Foreign key linking to hr.recruitment_requisition. Business justification: Hire events are outcomes of recruitment requisitions; this link is mandatory for recruitment analytics (time-to-fill, offer acceptance rates), hiring funnel reporting, EEO compliance tracking, and req',
    `accreditation_qualified_flag` BOOLEAN COMMENT 'Indicates whether the faculty member meets the qualification standards of the relevant programmatic accreditor (AACSB, ABET, ABA, etc.) at the time of hire.',
    `actual_start_date` DATE COMMENT 'The actual date on which the faculty member commenced their duties. May differ from negotiated start date due to onboarding delays or early starts.',
    `appointment_type` STRING COMMENT 'Classification of the appointment: regular (standard faculty line), visiting (temporary appointment), adjunct (part-time non-tenure), emeritus (retired with title), joint (shared across departments), or courtesy (unpaid affiliation).. Valid values are `regular|visiting|adjunct|emeritus|joint|courtesy`',
    `candidate_source` STRING COMMENT 'The primary channel through which the candidate was identified and recruited. Used for recruitment effectiveness analysis and diversity pipeline tracking. [ENUM-REF-CANDIDATE: academic_job_board|professional_network|internal_referral|conference_recruitment|direct_application|search_firm|diversity_program|other — 8 candidates stripped; promote to reference product]',
    `contract_months` DECIMAL(18,2) COMMENT 'The number of months per year covered by the faculty contract (typically 9.0 for academic year or 12.0 for calendar year appointments).',
    `degree_granting_institution` STRING COMMENT 'The name of the institution that awarded the faculty members highest degree. Used for accreditation documentation and alumni network analysis.',
    `diversity_hire_flag` BOOLEAN COMMENT 'Indicates whether this hire was tracked under institutional diversity and equity hiring goals. Used for EEO and affirmative action reporting.',
    `doctoral_committee_eligibility` BOOLEAN COMMENT 'Indicates whether the faculty member is eligible to serve on doctoral dissertation committees at the time of hire. Requires terminal degree and graduate faculty status.',
    `external_hire_flag` BOOLEAN COMMENT 'Indicates whether the hire was an external candidate (true) or an internal promotion/transfer (false). Used for talent pipeline analytics.',
    `fte` DECIMAL(18,2) COMMENT 'The full-time equivalent percentage of the appointment (1.000 for full-time, 0.500 for half-time, etc.). Used for workload and IPEDS reporting.',
    `graduate_faculty_status` STRING COMMENT 'Indicates the level of graduate faculty privileges granted at hire: full (can chair dissertations), associate (can serve on committees), or none (undergraduate teaching only).. Valid values are `full|associate|none`',
    `highest_degree_earned` STRING COMMENT 'The highest academic degree held by the faculty member at the time of hire. Used for accreditation qualification and IPEDS reporting. [ENUM-REF-CANDIDATE: phd|edd|md|jd|mfa|dma|dba|pharmd|dpt|dnp|masters|bachelors|other — 13 candidates stripped; promote to reference product]',
    `hire_notes` STRING COMMENT 'Free-text field for additional context about the hire, including special negotiated terms, strategic hiring initiatives, or unique circumstances.',
    `hire_status` STRING COMMENT 'Current status of the hire event in its lifecycle: offer_extended (awaiting candidate response), offer_accepted (candidate accepted), onboarding (pre-start activities), active (faculty member started), offer_declined (candidate rejected offer), or hire_cancelled (position withdrawn).. Valid values are `offer_extended|offer_accepted|onboarding|active|offer_declined|hire_cancelled`',
    `initial_annual_salary` DECIMAL(18,2) COMMENT 'The negotiated annual base salary offered at the time of hire, excluding benefits, bonuses, or summer salary supplements.',
    `initial_rank` STRING COMMENT 'The academic rank offered and accepted at the time of hire. Determines initial salary band, tenure eligibility, and academic responsibilities. [ENUM-REF-CANDIDATE: professor|associate_professor|assistant_professor|instructor|lecturer|clinical_professor|clinical_associate_professor|clinical_assistant_professor|research_professor|research_associate_professor|research_assistant_professor|professor_of_practice|visiting_professor|adjunct_professor — 14 candidates stripped; promote to reference product]',
    `negotiated_start_date` DATE COMMENT 'The agreed-upon date on which the faculty member will begin their appointment, as negotiated during the offer process.',
    `offer_accepted_date` DATE COMMENT 'The date on which the candidate formally accepted the employment offer.',
    `offer_date` DATE COMMENT 'The date on which the formal employment offer was extended to the candidate.',
    `prior_institution_name` STRING COMMENT 'The name of the institution where the faculty member was employed immediately prior to this hire. Null for new PhDs or career changers.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this hire event record was first created in the source system. Used for audit trail and data lineage tracking.',
    `record_source_system` STRING COMMENT 'The operational system from which this hire event record was sourced. Typically Workday HCM Recruiting or Slate CRM for candidate pipeline data.. Valid values are `workday_hcm|slate_crm|banner|manual_entry`',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this hire event record was last modified in the source system. Used for change tracking and incremental data loading.',
    `relocation_assistance_amount` DECIMAL(18,2) COMMENT 'The dollar amount provided to assist the faculty member with relocation expenses. May be taxable or non-taxable depending on institutional policy.',
    `research_load_percentage` DECIMAL(18,2) COMMENT 'The percentage of the faculty members workload allocated to research and scholarly activity at the time of hire (typically 40-60% for research-intensive roles).',
    `salary_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the initial salary (e.g., USD, CAD, EUR). Supports international faculty hires.. Valid values are `^[A-Z]{3}$`',
    `search_type` STRING COMMENT 'Classification of the search process used to fill this position: national (open competitive search), internal (internal candidate only), emergency (expedited hire), targeted (specific candidate recruitment), failed_search_rehire (position reopened after failed search), or visiting (temporary appointment).. Valid values are `national|internal|emergency|targeted|failed_search_rehire|visiting`',
    `service_load_percentage` DECIMAL(18,2) COMMENT 'The percentage of the faculty members workload allocated to service activities (committee work, advising, outreach) at the time of hire.',
    `startup_package_amount` DECIMAL(18,2) COMMENT 'The total dollar value of the startup package negotiated for research equipment, lab setup, graduate student support, and other initial resources. Common for STEM and research-intensive hires.',
    `teaching_load_percentage` DECIMAL(18,2) COMMENT 'The percentage of the faculty members workload allocated to teaching responsibilities at the time of hire (typically 40-100% for teaching-focused roles).',
    `tenure_track_status` STRING COMMENT 'Indicates whether the position is on the tenure track, already tenured at hire, or a non-tenure track appointment (clinical, research, or teaching-focused).. Valid values are `tenure_track|tenured|non_tenure_track|clinical_track|research_track`',
    `terminal_degree_flag` BOOLEAN COMMENT 'Indicates whether the faculty member holds a terminal degree in their field (PhD, MFA, JD, MD, etc.) at the time of hire. Critical for accreditation qualification tracking.',
    `visa_sponsorship_required_flag` BOOLEAN COMMENT 'Indicates whether the institution is sponsoring a work visa (H-1B, J-1, O-1, etc.) for this international faculty hire. Used for compliance tracking and immigration reporting.',
    `visa_type` STRING COMMENT 'The type of work authorization or visa status for international hires. Null or not_applicable for US citizens and permanent residents. [ENUM-REF-CANDIDATE: h1b|j1|o1|tn|green_card|citizen|not_applicable — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_hire_event PRIMARY KEY(`hire_event_id`)
) COMMENT 'Captures the formal faculty hiring transaction including position requisition reference, search type (national, internal, emergency hire), offer date, accepted date, negotiated start date, initial rank offered, initial salary offered, hiring department, search committee chair, and whether the hire was a diversity hire tracked under institutional equity goals. Sourced from Workday HCM Recruiting module and Slate CRM for candidate pipeline data. Supports CUPA-HR reporting and EEO compliance.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`compensation` (
    `compensation_id` BIGINT COMMENT 'Unique identifier for the faculty compensation record. Primary key for the compensation data product.',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to faculty.appointment. Business justification: compensation.appointment_period_id is BIGINT but not currently linked to any table. Compensation records are tied to specific appointment periods. The appointment table is the authoritative source for',
    `instructor_id` BIGINT COMMENT 'Identifier of the faculty member to whom this compensation record applies. Links to the faculty master data product.',
    `research_award_id` BIGINT COMMENT 'Identifier of the research grant or sponsored project funding this compensation, if applicable. Links to the research grant master data. Null for non-grant-funded compensation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Faculty salary is the largest expense for academic departments; each compensation record must link to the cost center funding it for budget tracking, variance analysis, and financial reporting. Enable',
    `accreditation_qualified_flag` BOOLEAN COMMENT 'Indicates whether the faculty member meets the qualification standards of the relevant specialized accreditor (AACSB, ABET, ABA, etc.) at the time of this compensation record.',
    `administrative_stipend_amount` DECIMAL(18,2) COMMENT 'Additional compensation paid for administrative duties such as department chair, program director, or other leadership roles.',
    `appointment_type` STRING COMMENT 'The type of faculty appointment. Common values include regular, visiting, adjunct, emeritus, postdoctoral, lecturer, clinical, or research faculty. [ENUM-REF-CANDIDATE: regular|visiting|adjunct|emeritus|postdoc|lecturer|clinical|research — 8 candidates stripped; promote to reference product]',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'The base annual salary amount for the faculty member during this appointment period, excluding stipends, overload, and other supplemental compensation.',
    `budget_account_code` STRING COMMENT 'The general ledger account code or budget string from which this compensation is funded. Critical for financial reporting and budget tracking.',
    `cip_code` STRING COMMENT 'The six-digit CIP code representing the primary instructional discipline for this faculty members compensation. Used for CUPA-HR salary benchmarking by discipline.. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `compensation_status` STRING COMMENT 'The current status of this compensation record. Active indicates currently in effect; suspended or on_leave indicates temporary interruption; terminated indicates ended; pending indicates approved but not yet effective.. Valid values are `active|suspended|terminated|pending|on_leave`',
    `contract_months` DECIMAL(18,2) COMMENT 'The number of months covered by the faculty members contract for this compensation period. Typically 9.0 for academic year appointments, 12.0 for calendar year appointments.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which compensation amounts are denominated. Typically USD for U.S. institutions.. Valid values are `USD|CAD|EUR|GBP|AUD`',
    `effective_date` DATE COMMENT 'The date from which this compensation arrangement becomes effective. Critical for tracking salary history and changes over time.',
    `end_date` DATE COMMENT 'The date on which this compensation arrangement ends or ended. Null for currently active compensation records.',
    `fte` DECIMAL(18,2) COMMENT 'The full-time equivalent percentage for this compensation record. 1.0000 represents full-time; values less than 1.0 represent part-time appointments.',
    `funding_source` STRING COMMENT 'The primary source of funds for this compensation. Common values include state appropriation, tuition revenue, endowment income, research grant, contract, auxiliary enterprise, or philanthropic gift. [ENUM-REF-CANDIDATE: state_appropriation|tuition_revenue|endowment|grant|contract|auxiliary|gift — 7 candidates stripped; promote to reference product]',
    `last_salary_action_date` DATE COMMENT 'The date of the most recent salary action affecting this compensation record, such as a merit increase, promotion adjustment, or equity correction.',
    `last_salary_action_type` STRING COMMENT 'The type of the most recent salary action. Common values include merit increase, promotion, equity adjustment, cost-of-living adjustment, retention adjustment, or initial appointment.. Valid values are `merit_increase|promotion|equity_adjustment|cost_of_living|retention|initial_appointment`',
    `market_equity_adjustment_amount` DECIMAL(18,2) COMMENT 'The dollar amount of any market equity adjustment applied to this compensation record. Null if no adjustment was made.',
    `market_equity_adjustment_flag` BOOLEAN COMMENT 'Indicates whether this compensation record includes a market equity adjustment to bring the faculty members salary in line with external market benchmarks.',
    `notes` STRING COMMENT 'Free-text notes providing additional context about this compensation record, such as special conditions, funding constraints, or administrative remarks.',
    `overload_courses_count` STRING COMMENT 'The number of courses taught as overload during this compensation period. Used in conjunction with overload_pay_rate to calculate total overload compensation.',
    `overload_pay_rate` DECIMAL(18,2) COMMENT 'The per-course or per-credit-hour rate paid to faculty for teaching beyond their standard load. Null if no overload teaching occurred during this period.',
    `pay_grade` STRING COMMENT 'The institutional pay grade or salary band assigned to this faculty position. Used for internal equity analysis and compensation planning.',
    `rank_at_compensation` STRING COMMENT 'The academic rank of the faculty member at the time this compensation record was effective. Captured here for historical accuracy even if rank changes later. [ENUM-REF-CANDIDATE: professor|associate_professor|assistant_professor|instructor|lecturer|adjunct|emeritus — 7 candidates stripped; promote to reference product]',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this compensation record was first created in the lakehouse silver layer. Used for data lineage and audit purposes.',
    `record_current_flag` BOOLEAN COMMENT 'Indicates whether this is the current version of the compensation record in the lakehouse. True for the current version, false for historical versions. Used for Type 2 slowly changing dimension tracking.',
    `record_effective_from_date` DATE COMMENT 'The date from which this version of the compensation record is effective in the lakehouse. Used for Type 2 slowly changing dimension tracking.',
    `record_effective_to_date` DATE COMMENT 'The date until which this version of the compensation record is effective in the lakehouse. Null for the current version. Used for Type 2 slowly changing dimension tracking.',
    `record_source_system` STRING COMMENT 'The name of the source system from which this compensation record was extracted. Typically Workday HCM Compensation module.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this compensation record was most recently updated in the lakehouse silver layer. Used for data lineage and audit purposes.',
    `salary_action_reason` STRING COMMENT 'Free-text explanation or justification for the most recent salary action. May reference performance evaluation, market analysis, or retention concerns.',
    `salary_basis` STRING COMMENT 'The time basis on which the base salary is calculated. Common values include 9-month (academic year), 10-month, 12-month (calendar year), or hourly for adjunct faculty.. Valid values are `9-month|10-month|11-month|12-month|hourly|daily`',
    `salary_step` STRING COMMENT 'The step within the pay grade, if the institution uses a step-based salary structure. Common in unionized environments.',
    `summer_salary_amount` DECIMAL(18,2) COMMENT 'The total summer salary amount paid to the faculty member during this compensation period, typically funded by research grants or summer teaching assignments.',
    `summer_salary_eligible_flag` BOOLEAN COMMENT 'Indicates whether the faculty member is eligible to receive additional summer salary compensation beyond their base contract period. Typically true for 9-month faculty.',
    `tenure_track_status` STRING COMMENT 'The tenure track status of the faculty member at the time of this compensation record. Critical for AACSB and other accreditation reporting.. Valid values are `tenure_track|tenured|non_tenure_track|clinical_track|research_track`',
    `terminal_degree_flag` BOOLEAN COMMENT 'Indicates whether the faculty member holds a terminal degree in their field (typically PhD, EdD, MFA, JD, MD, or equivalent) at the time of this compensation record.',
    `total_compensation_amount` DECIMAL(18,2) COMMENT 'The total compensation amount for this period, including base salary, summer salary, administrative stipends, overload pay, and any other supplemental compensation.',
    CONSTRAINT pk_compensation PRIMARY KEY(`compensation_id`)
) COMMENT 'Stores faculty compensation records by appointment period, including base salary, salary basis (9-month, 10-month, 12-month), summer salary eligibility, administrative stipend amounts, overload pay rate, total compensation, pay grade, market equity adjustment flag, and last salary action date and type. Sourced from Workday HCM Compensation module. Supports CUPA-HR salary benchmarking, equity analysis, and budget planning. Distinct from payroll transaction records owned by the HR domain.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`leave_record` (
    `leave_record_id` BIGINT COMMENT 'Unique identifier for the faculty leave record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the HR administrator, department chair, or dean who approved the leave request. Links to employee or faculty master data.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Leave requests (FMLA, medical, parental, sabbatical) must comply with institutional leave policies defining eligibility, duration, pay continuation, and tenure clock impacts. HR and department chairs ',
    `instructor_id` BIGINT COMMENT 'Reference to the faculty member taking leave. Links to the faculty master data product.',
    `actual_return_date` DATE COMMENT 'Date the faculty member actually returned to active duty. Null if leave is still in progress or faculty has not yet returned. Used to calculate actual leave duration and tenure clock impact.',
    `approval_date` DATE COMMENT 'Date the leave request was officially approved by the approving authority. Null if leave is still pending or was denied.',
    `approved_start_date` DATE COMMENT 'Date the leave was officially approved to begin. This is the authoritative start date for payroll, benefits, and tenure clock calculations.',
    `benefits_continuation_flag` BOOLEAN COMMENT 'Indicates whether health and welfare benefits continued during the leave period (true) or were suspended (false). FMLA requires benefits continuation; unpaid leave may not.',
    `college_code` STRING COMMENT 'Code identifying the college or school of the faculty member at the time of leave. Used for institutional reporting and resource allocation.',
    `denial_reason` STRING COMMENT 'Explanation provided when a leave request is denied. Null if leave was approved or is still pending. Confidential HR information.',
    `department_code` STRING COMMENT 'Code identifying the academic department of the faculty member at the time of leave. Used for workload impact analysis and course coverage planning.',
    `disability_accommodation_flag` BOOLEAN COMMENT 'Indicates whether ADA (Americans with Disabilities Act) accommodations were requested or provided in connection with this leave (true) or not (false).',
    `expected_return_date` DATE COMMENT 'Anticipated date the faculty member will return to active duty. Used for course scheduling, committee assignments, and workload planning.',
    `fmla_eligible_flag` BOOLEAN COMMENT 'Indicates whether the faculty member was eligible for FMLA protection at the time of leave (true) or not (false). Eligibility requires 12 months of service and 1,250 hours worked.',
    `fmla_hours_used` DECIMAL(18,2) COMMENT 'Number of FMLA-protected hours consumed by this leave event. FMLA provides up to 480 hours (12 weeks) of protected leave per rolling 12-month period.',
    `hr_case_reference` STRING COMMENT 'Reference number or identifier for the HR case file associated with this leave. Links to Workday HCM case management for documentation, approvals, and correspondence.',
    `intermittent_leave_flag` BOOLEAN COMMENT 'Indicates whether this is an intermittent leave arrangement (true) allowing periodic absences, or a continuous block of leave (false). Intermittent FMLA is common for chronic conditions or ongoing treatment.',
    `leave_duration_days` STRING COMMENT 'Total number of calendar days of approved leave. Calculated from approved start date to expected return date, or to actual return date if completed.',
    `leave_duration_weeks` DECIMAL(18,2) COMMENT 'Total leave duration expressed in weeks (decimal). Supports FMLA reporting which is measured in 12-week increments.',
    `leave_notes` STRING COMMENT 'Free-text notes and comments regarding the leave event. May include special arrangements, coverage plans, or administrative details. Confidential HR information.',
    `leave_status` STRING COMMENT 'Current lifecycle state of the leave request. Requested indicates pending review, approved indicates authorization granted, denied indicates rejection, in_progress indicates leave is currently active, completed indicates faculty has returned, cancelled indicates withdrawal of request.. Valid values are `requested|approved|denied|in_progress|completed|cancelled`',
    `leave_subtype` STRING COMMENT 'Detailed classification within the primary leave type (e.g., maternity, paternity, adoption, serious health condition, caregiver, short-term disability, long-term disability, jury duty, bereavement). Provides granular categorization for HR reporting and policy compliance.',
    `leave_type` STRING COMMENT 'Classification of the leave event. FMLA (Family and Medical Leave Act) for federally protected family/medical leave, medical for non-FMLA health-related leave, parental for childbirth or adoption, military for active duty or training, administrative for institutional suspension or investigation, unpaid for voluntary leave without pay.. Valid values are `fmla|medical|parental|military|administrative|unpaid`',
    `medical_certification_received_date` DATE COMMENT 'Date the required medical certification was received by HR. Null if not required or not yet received. Affects leave approval timeline.',
    `medical_certification_required_flag` BOOLEAN COMMENT 'Indicates whether medical certification or documentation was required to support the leave request (true) or not (false). Required for FMLA and medical leave types.',
    `paid_leave_flag` BOOLEAN COMMENT 'Indicates whether the leave is paid (true) or unpaid (false). Affects payroll processing and benefits continuation.',
    `partial_pay_percentage` DECIMAL(18,2) COMMENT 'Percentage of regular salary paid during leave (0-100). Null if fully paid or fully unpaid. Used for short-term disability or phased return arrangements.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this leave record was first created in the source system. Audit trail for data lineage and compliance.',
    `record_source_system` STRING COMMENT 'Name of the source system from which this leave record was extracted. Typically Workday HCM Absence Management module.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this leave record was last modified in the source system. Tracks changes to leave status, dates, or other attributes.',
    `reduced_schedule_flag` BOOLEAN COMMENT 'Indicates whether the leave involves a reduced work schedule (true) rather than full absence (false). Common for phased return or accommodation arrangements.',
    `reduced_schedule_fte` DECIMAL(18,2) COMMENT 'FTE percentage during reduced schedule leave (0.000-1.000). For example, 0.500 indicates half-time work during leave period. Null if not a reduced schedule arrangement.',
    `requested_start_date` DATE COMMENT 'Date the faculty member initially requested to begin leave. May differ from approved start date if HR or department negotiated timing.',
    `return_to_work_certification_received_date` DATE COMMENT 'Date the return-to-work medical clearance was received by HR. Null if not required or not yet received. Must be on file before faculty can resume duties.',
    `return_to_work_certification_required_flag` BOOLEAN COMMENT 'Indicates whether medical clearance is required before the faculty member can return to active duty (true) or not (false). Common for medical and disability leave.',
    `teaching_coverage_required_flag` BOOLEAN COMMENT 'Indicates whether teaching coverage or course substitution was required during the leave period (true) or not (false). Drives adjunct hiring and course reassignment decisions.',
    `tenure_clock_extension_months` STRING COMMENT 'Number of months the tenure clock was extended as a result of this leave. Typically 12 months for parental or medical leave. Null if no extension granted.',
    `tenure_clock_stop_flag` BOOLEAN COMMENT 'Indicates whether the tenure probationary clock was stopped during this leave (true) or continued to run (false). Critical for promotion and tenure timeline calculations.',
    `workers_compensation_claim_number` STRING COMMENT 'Reference number for the associated workers compensation claim. Null if leave is not workers compensation related. Links to risk management and insurance systems.',
    `workers_compensation_flag` BOOLEAN COMMENT 'Indicates whether this leave is related to a workers compensation claim for work-related injury or illness (true) or not (false).',
    CONSTRAINT pk_leave_record PRIMARY KEY(`leave_record_id`)
) COMMENT 'Tracks all faculty leave events beyond sabbatical, including FMLA leave, medical leave, parental leave, military leave, administrative leave, and unpaid leave. Captures leave type, requested start date, approved start date, expected return date, actual return date, leave approval status, HR case reference, and impact on tenure clock (whether a tenure clock extension was granted as a result). Sourced from Workday HCM Absence Management module.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`advising_assignment` (
    `advising_assignment_id` BIGINT COMMENT 'Unique identifier for the advising assignment record. Primary key for the advising assignment entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the person or office that approved this advising assignment, typically a department chair or graduate dean.',
    `instructor_id` BIGINT COMMENT 'Unique identifier of the faculty member serving as advisor. References the faculty domain SSOT for faculty identity.',
    `mentorship_match_id` BIGINT COMMENT 'Foreign key linking to advancement.mentorship_match. Business justification: Faculty academic advisors coordinate with alumni career mentors in formal mentorship programs for holistic student support. Real business process: mentorship program staff link faculty advisors to alu',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student being advised. References the student domain SSOT for student identity.',
    `academic_program_code` STRING COMMENT 'Code identifying the academic program in which the student is enrolled and for which this advising relationship applies.',
    `accreditation_reportable_flag` BOOLEAN COMMENT 'Indicates whether this advising assignment must be reported for accreditation purposes, particularly for specialized program accreditation.',
    `actual_end_date` DATE COMMENT 'Actual date when the advising assignment concluded, which may differ from the expected end date due to early completion, transfer, or other circumstances.',
    `advising_credit_hours` DECIMAL(18,2) COMMENT 'Number of credit hours or teaching equivalency units assigned to the faculty member for this advising assignment, used in workload calculations.',
    `advising_load_count` DECIMAL(18,2) COMMENT 'Quantitative measure of the advising workload credit assigned to this relationship, used for faculty workload calculation and resource allocation. May be fractional for committee memberships.',
    `advising_type` STRING COMMENT 'Classification of the advising relationship indicating the nature and scope of the faculty members advisory role with the student.. Valid values are `academic_advisor|thesis_advisor|dissertation_chair|dissertation_committee_member|capstone_supervisor|research_mentor`',
    `approval_date` DATE COMMENT 'Date when the advising assignment was formally approved by the designated authority.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this advising assignment required formal approval from department chair, graduate school, or other authority.',
    `assignment_notes` STRING COMMENT 'Free-text notes providing additional context, special circumstances, or important details about this advising assignment.',
    `assignment_reason` STRING COMMENT 'Business reason or context for establishing this advising assignment, such as initial program assignment, advisor change, or committee formation.',
    `assignment_start_date` DATE COMMENT 'Date when the advising assignment officially began and the faculty member assumed advisory responsibilities for the student.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the advising assignment indicating whether the relationship is currently active or has ended.. Valid values are `active|inactive|pending|completed|terminated|on_hold`',
    `college_code` STRING COMMENT 'Code identifying the college or school responsible for this advising assignment, providing higher-level organizational context.',
    `committee_role` STRING COMMENT 'Specific role the faculty member plays on a thesis or dissertation committee, applicable when advising_type indicates committee membership.. Valid values are `chair|co_chair|member|external_member|reader|observer`',
    `compensation_eligible_flag` BOOLEAN COMMENT 'Indicates whether the faculty member is eligible for additional compensation or stipend for this advising assignment beyond regular salary.',
    `department_code` STRING COMMENT 'Code identifying the academic department responsible for this advising assignment, typically the department offering the students program.',
    `expected_end_date` DATE COMMENT 'Anticipated date when the advising assignment is expected to conclude, typically aligned with student graduation or program completion.',
    `last_contact_date` DATE COMMENT 'Most recent date when documented contact or advising meeting occurred between the faculty advisor and student.',
    `meeting_frequency_requirement` STRING COMMENT 'Expected frequency of advising meetings between faculty advisor and student as defined by program policy or advising agreement.. Valid values are `weekly|biweekly|monthly|quarterly|as_needed|per_program_policy`',
    `primary_advisor_flag` BOOLEAN COMMENT 'Indicates whether this faculty member is the students primary academic advisor, as students may have multiple concurrent advising relationships.',
    `qualified_advisor_flag` BOOLEAN COMMENT 'Indicates whether the faculty member meets institutional and accreditation requirements to serve in this advising capacity, including terminal degree and expertise requirements.',
    `record_created_by` STRING COMMENT 'User identifier or system process that created this advising assignment record.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this advising assignment record was first created in the system.',
    `record_current_flag` BOOLEAN COMMENT 'Indicates whether this is the current active version of the advising assignment record in a slowly changing dimension implementation.',
    `record_effective_from_date` DATE COMMENT 'Date from which this version of the advising assignment record is effective, supporting temporal data management and historical tracking.',
    `record_effective_to_date` DATE COMMENT 'Date until which this version of the advising assignment record is effective, supporting temporal data management and historical tracking.',
    `record_source_system` STRING COMMENT 'Name of the source system from which this advising assignment record originated, such as SIS, graduate school system, or advising platform.',
    `record_updated_by` STRING COMMENT 'User identifier or system process that most recently updated this advising assignment record.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this advising assignment record was most recently updated or modified.',
    `research_area` STRING COMMENT 'Primary research area or field of study focus for this advising relationship, particularly relevant for thesis and dissertation advising.',
    `student_level` STRING COMMENT 'Academic level of the student at the time of advising assignment, distinguishing between undergraduate, graduate, and professional program students.. Valid values are `undergraduate|graduate_masters|graduate_doctoral|post_doctoral|professional`',
    `termination_reason` STRING COMMENT 'Reason for ending the advising assignment, such as graduation, advisor change, student withdrawal, or faculty departure.',
    `thesis_dissertation_title` STRING COMMENT 'Title of the thesis, dissertation, or capstone project for which this advising relationship was established, applicable for graduate advising.',
    CONSTRAINT pk_advising_assignment PRIMARY KEY(`advising_assignment_id`)
) COMMENT 'Records formal faculty advising relationships with graduate and undergraduate students, including advisee student ID, advising type (academic advisor, thesis advisor, dissertation chair, dissertation committee member, capstone supervisor), assignment start date, expected end date, actual end date, and advising load count. Supports graduate program oversight, faculty workload calculation (advising credit), and accreditation reporting on student mentorship. Cross-references the student domain SSOT for student identity.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`professional_development` (
    `professional_development_id` BIGINT COMMENT 'Unique identifier for the professional development activity record. Primary key for the professional development product.',
    `donor_id` BIGINT COMMENT 'Foreign key linking to advancement.donor. Business justification: Professional development often donor-funded (conference travel, sabbatical supplements, certification programs). Stewardship requires attribution. Real business process: donor impact reports show facu',
    `employee_id` BIGINT COMMENT 'Identifier of the department chair, dean, or administrator who approved the faculty members participation in the professional development activity.',
    `grant_account_id` BIGINT COMMENT 'Identifier of the research grant that funded the professional development activity, if applicable. Links to research administration systems.',
    `instructor_id` BIGINT COMMENT 'Identifier of the faculty member who participated in the professional development activity. Links to the faculty master data.',
    `accreditation_body` STRING COMMENT 'Name of the accreditation agency or body for which this professional development activity provides qualifying evidence (e.g., AACSB, ABET, HLC, SACSCOC).',
    `accreditation_relevant_flag` BOOLEAN COMMENT 'Indicates whether the professional development activity contributes to accreditation continuous improvement evidence or faculty qualification requirements.',
    `activity_cost` DECIMAL(18,2) COMMENT 'Total cost or fee for the professional development activity, including registration, materials, and any associated expenses.',
    `activity_name` STRING COMMENT 'The full name or title of the professional development activity, workshop, conference, training program, or certification course.',
    `activity_notes` STRING COMMENT 'Free-text notes or comments about the professional development activity, including learning outcomes, reflections, or special circumstances.',
    `activity_type` STRING COMMENT 'Classification of the professional development activity. Distinguishes between workshops, conferences attended (not presented), training programs, certifications earned, online courses completed, and institutional development programs. [ENUM-REF-CANDIDATE: workshop|conference_attendance|training_program|certification|online_course|teaching_center_program|leadership_academy|seminar|symposium|webinar — 10 candidates stripped; promote to reference product]',
    `annual_review_included_flag` BOOLEAN COMMENT 'Indicates whether this professional development activity was included in the faculty members annual performance review documentation.',
    `approval_date` DATE COMMENT 'Date when the professional development activity participation was officially approved by the appropriate authority.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether institutional or departmental approval was required before the faculty member could participate in the professional development activity.',
    `certification_earned` STRING COMMENT 'Name of the professional certification, credential, or certificate earned upon completion of the activity. Null if no formal certification was awarded.',
    `certification_expiration_date` DATE COMMENT 'Date when the earned certification or credential expires and requires renewal. Null for certifications without expiration.',
    `certification_number` STRING COMMENT 'Unique certification or credential number issued by the provider upon successful completion. Used for verification and accreditation documentation.',
    `ceu_earned` DECIMAL(18,2) COMMENT 'Number of Continuing Education Units earned for the professional development activity. One CEU typically equals 10 contact hours of participation in an organized continuing education experience.',
    `college_code` STRING COMMENT 'Code of the college or school with which the professional development activity is associated.',
    `completion_date` DATE COMMENT 'The date when the faculty member completed the professional development activity or received certification. Null if activity is ongoing or incomplete.',
    `completion_status` STRING COMMENT 'Current status of the faculty members participation in the professional development activity, tracking progression from registration through completion.. Valid values are `completed|in_progress|registered|cancelled|withdrawn|incomplete`',
    `credit_hours` DECIMAL(18,2) COMMENT 'Number of credit hours or contact hours earned for completing the professional development activity. Used for tracking continuing education requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the activity cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Code of the academic department with which the professional development activity is associated or that approved the participation.',
    `discipline_area` STRING COMMENT 'Academic discipline or subject area focus of the professional development activity (e.g., pedagogy, research methods, technology integration, leadership).',
    `funding_account_code` STRING COMMENT 'Financial account or budget code from which the professional development activity was funded. Links to institutional financial systems for expense tracking.',
    `funding_source` STRING COMMENT 'Source of funding that covered the cost of the professional development activity. Indicates whether the expense was institutional, grant-funded, departmental, personally paid, or externally sponsored.. Valid values are `institutional|grant|departmental|personal|external_sponsor|professional_development_fund`',
    `location_city` STRING COMMENT 'City where the professional development activity was held, if conducted in-person or hybrid. Null for fully online activities.',
    `location_country` STRING COMMENT 'Three-letter ISO country code for the country where the professional development activity was held. Null for fully online activities.. Valid values are `^[A-Z]{3}$`',
    `location_state` STRING COMMENT 'State or province where the professional development activity was held. Null for fully online activities.',
    `location_type` STRING COMMENT 'Classification of where the professional development activity took place: on-campus, off-campus, fully online, or hybrid format.. Valid values are `on_campus|off_campus|online|hybrid`',
    `promotion_tenure_relevant_flag` BOOLEAN COMMENT 'Indicates whether this professional development activity is relevant to promotion and tenure review processes and dossier documentation.',
    `provider_name` STRING COMMENT 'Name of the organization, institution, or entity that provided or hosted the professional development activity.',
    `provider_type` STRING COMMENT 'Classification of the provider organization type, indicating whether the activity was provided by a university, professional association, commercial vendor, government agency, nonprofit, or internal institutional unit.. Valid values are `university|professional_association|commercial_vendor|government_agency|nonprofit_organization|internal_institutional`',
    `record_created_by` STRING COMMENT 'Username or identifier of the person who created this professional development activity record.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this professional development activity record was first created in the system.',
    `record_source_system` STRING COMMENT 'Name of the source system from which this professional development record originated (e.g., Workday HCM, faculty self-service portal, departmental tracking system).',
    `record_updated_by` STRING COMMENT 'Username or identifier of the person who last updated this professional development activity record.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this professional development activity record was last modified or updated.',
    `relevance_to_research` BOOLEAN COMMENT 'Indicates whether the professional development activity is directly relevant to enhancing research skills, methodologies, or scholarly productivity.',
    `relevance_to_service` BOOLEAN COMMENT 'Indicates whether the professional development activity is directly relevant to institutional service, committee work, or administrative responsibilities.',
    `relevance_to_teaching` BOOLEAN COMMENT 'Indicates whether the professional development activity is directly relevant to improving teaching effectiveness and instructional practices.',
    `start_date` DATE COMMENT 'The date when the professional development activity began or was first attended by the faculty member.',
    CONSTRAINT pk_professional_development PRIMARY KEY(`professional_development_id`)
) COMMENT 'Tracks faculty participation in professional development activities including workshops, conferences attended (not presented), training programs, certifications earned, online courses completed, and institutional development programs (teaching center workshops, leadership academies). Captures activity name, provider, activity type, completion date, credit hours or CEUs earned, cost, and funding source (institutional, grant, personal). Supports annual review documentation and accreditation continuous improvement evidence.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`endowed_position` (
    `endowed_position_id` BIGINT COMMENT 'Unique identifier for the endowed or named faculty position record. Primary key.',
    `donor_id` BIGINT COMMENT 'Foreign key reference to the donor record in the advancement system for stewardship reporting and relationship management.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Endowed positions are funded by specific endowment funds with spending policies, distribution rules, and donor restrictions. Links endowed chair appointments to the financial fund for distribution tra',
    `endowment_id` BIGINT COMMENT 'Foreign key linking to advancement.endowment. Business justification: Endowed positions are funded by specific endowments. Business requires tracking market value, spending policy, and stewardship obligations. Real business process: annual endowment reports to donors sh',
    `instructor_id` BIGINT COMMENT 'Foreign key reference to the faculty member currently appointed to this endowed position. Null if the position is vacant.',
    `org_unit_id` BIGINT COMMENT 'Foreign key reference to the academic department that administratively houses this endowed position.',
    `appointment_end_date` DATE COMMENT 'The date on which the current appointment to this endowed position is scheduled to end. Null for indefinite appointments.',
    `appointment_start_date` DATE COMMENT 'The date on which the current faculty holder began their appointment to this endowed position.',
    `appointment_term_years` STRING COMMENT 'The standard term length in years for appointments to this endowed position as specified in the donor agreement or institutional policy.',
    `approval_authority` STRING COMMENT 'The institutional role or committee responsible for approving appointments to this endowed position (e.g., Provost, Board of Trustees, Dean).',
    `cip_code` STRING COMMENT 'Six-digit CIP code identifying the instructional program area aligned with this endowed position for federal reporting.. Valid values are `^d{2}.d{4}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts associated with this endowed position (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `discipline_area` STRING COMMENT 'The academic discipline or field of study that this endowed position is designated to support (e.g., Economics, Engineering, Medicine).',
    `discretionary_fund_amount` DECIMAL(18,2) COMMENT 'Annual discretionary funding amount available to the position holder for research, travel, professional development, or other scholarly activities.',
    `donor_recognition_level` STRING COMMENT 'The institutional recognition tier assigned to the donor based on the gift amount establishing this endowed position, used for stewardship and engagement planning.. Valid values are `transformational|major|principal|leadership|patron`',
    `donor_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the donor agreement requires periodic reporting on the activities and accomplishments of the position holder.',
    `establishment_date` DATE COMMENT 'The date on which the endowed position was formally established by the institution, typically aligned with donor gift acceptance.',
    `gift_amount` DECIMAL(18,2) COMMENT 'The original principal amount of the donor gift that established the endowment fund supporting this position.',
    `gift_date` DATE COMMENT 'The date on which the donor gift establishing the endowment was received and accepted by the institution.',
    `last_review_date` DATE COMMENT 'The date on which the endowed position and its holder were last reviewed for compliance with donor obligations and institutional standards.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next review of the endowed position and its holder for compliance with donor obligations and institutional standards.',
    `position_notes` STRING COMMENT 'Free-text field for additional notes, historical context, or special considerations related to this endowed position.',
    `position_status` STRING COMMENT 'Current lifecycle status of the endowed position indicating whether it is filled, vacant, or otherwise unavailable.. Valid values are `active|vacant|suspended|terminated|pending_approval`',
    `position_title` STRING COMMENT 'The formal title of the endowed position as established by the donor or institution (e.g., John Smith Chair in Economics, Distinguished Professor of Engineering).',
    `position_type` STRING COMMENT 'Classification of the endowed position indicating the level and nature of the appointment.. Valid values are `endowed_chair|named_professorship|distinguished_professorship|visiting_chair|presidential_chair|university_professorship`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this endowed position record was first created in the data platform.',
    `record_current_flag` BOOLEAN COMMENT 'Indicates whether this is the current active version of the endowed position record in a Type 2 slowly changing dimension implementation.',
    `record_effective_from_date` DATE COMMENT 'The date from which this version of the endowed position record is effective, supporting Type 2 slowly changing dimension tracking.',
    `record_effective_to_date` DATE COMMENT 'The date until which this version of the endowed position record is effective. Null for the current active record.',
    `record_source_system` STRING COMMENT 'The name of the source system from which this endowed position record originated (e.g., Blackbaud Raisers Edge, Workday HCM, custom endowment tracking system).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this endowed position record was last modified in the data platform.',
    `renewable_flag` BOOLEAN COMMENT 'Indicates whether the appointment to this endowed position is eligible for renewal at the end of the term.',
    `reporting_frequency` STRING COMMENT 'The frequency with which stewardship reports must be provided to the donor regarding the endowed position holder and their activities.. Valid values are `annual|semi_annual|quarterly|none`',
    `research_requirement_flag` BOOLEAN COMMENT 'Indicates whether the position holder is required to maintain an active research program as a condition of the endowed appointment.',
    `salary_supplement_amount` DECIMAL(18,2) COMMENT 'Annual salary supplement or stipend provided to the position holder from the endowment distribution, above their base faculty salary.',
    `selection_criteria` STRING COMMENT 'Detailed description of the qualifications, expertise, and criteria required for faculty appointment to this endowed position as specified by the donor or institution.',
    `service_requirement_flag` BOOLEAN COMMENT 'Indicates whether the position holder is required to perform specific service activities (e.g., committee work, community engagement) as a condition of the endowed appointment.',
    `special_obligations` STRING COMMENT 'Detailed description of any unique obligations, expectations, or deliverables required of the position holder as specified in the donor agreement.',
    `teaching_requirement_flag` BOOLEAN COMMENT 'Indicates whether the position holder is required to maintain a teaching load as a condition of the endowed appointment.',
    CONSTRAINT pk_endowed_position PRIMARY KEY(`endowed_position_id`)
) COMMENT 'Tracks named and endowed faculty positions (endowed chairs, named professorships, distinguished professorships) including position title, endowment fund reference, donor name, award criteria, annual distribution amount, current holder faculty ID, appointment start date, and renewal terms. Supports advancement and donor stewardship reporting by linking faculty recognition to philanthropic gifts. Distinct from the standard appointment record as endowed positions carry unique donor obligations and reporting requirements.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`external_engagement` (
    `external_engagement_id` BIGINT COMMENT 'Unique identifier for the external professional engagement record.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: External engagements (consulting, board service, equity holdings) must comply with institutional conflict of interest policies. Faculty disclose engagements; compliance officers review against policy ',
    `donor_id` BIGINT COMMENT 'Foreign key linking to advancement.donor. Business justification: Faculty consulting/board service for donor organizations requires conflict-of-interest and stewardship tracking. Real business process: major gift officers review faculty external engagements with pro',
    `instructor_id` BIGINT COMMENT 'Identifier of the faculty member participating in the external engagement.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the academic department to which the faculty member belongs at the time of this external engagement.',
    `accreditation_reportable_flag` BOOLEAN COMMENT 'Indicates whether this external engagement qualifies as reportable intellectual contribution evidence for accreditation purposes (AACSB, ABET, etc.).',
    `approval_conditions` STRING COMMENT 'Any conditions, restrictions, or stipulations attached to the institutional approval of this external engagement.',
    `approval_date` DATE COMMENT 'Date when institutional approval was granted for this external engagement.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Monetary compensation amount disclosed by the faculty member for this external engagement. Null if no compensation or not disclosed.',
    `compensation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `compensation_disclosed_flag` BOOLEAN COMMENT 'Indicates whether the faculty member disclosed receiving compensation for this external engagement.',
    `compensation_type` STRING COMMENT 'Form or nature of compensation received for the external engagement.. Valid values are `honorarium|consulting_fee|retainer|equity|in_kind|none`',
    `conflict_of_interest_description` STRING COMMENT 'Narrative description of the disclosed conflict of interest, including nature, scope, and potential impact on institutional duties.',
    `conflict_of_interest_disclosed_flag` BOOLEAN COMMENT 'Indicates whether the faculty member disclosed a potential or actual conflict of interest related to this external engagement.',
    `conflict_of_interest_mitigation_plan` STRING COMMENT 'Description of the management or mitigation plan established to address the disclosed conflict of interest.',
    `disclosure_date` DATE COMMENT 'Date when the faculty member initially disclosed this external engagement to the institution.',
    `end_date` DATE COMMENT 'Date when the external engagement concluded or is scheduled to conclude. Null for ongoing engagements without a defined end date.',
    `engagement_notes` STRING COMMENT 'Additional free-text notes, comments, or context regarding this external engagement.',
    `engagement_number` STRING COMMENT 'Business identifier or reference number assigned to this external engagement for tracking and reporting purposes.',
    `engagement_status` STRING COMMENT 'Current lifecycle status of the external engagement indicating approval and activity state. [ENUM-REF-CANDIDATE: pending_approval|approved|active|completed|declined|cancelled|suspended — 7 candidates stripped; promote to reference product]',
    `engagement_type` STRING COMMENT 'Category of external professional engagement. [ENUM-REF-CANDIDATE: consulting|expert_witness|board_membership|advisory_board|media_appearance|policy_advisory|professional_service|editorial_board|peer_review|conference_organizer|grant_reviewer|accreditation_reviewer|other — promote to reference product]',
    `estimated_time_commitment_hours` DECIMAL(18,2) COMMENT 'Estimated total number of hours the faculty member will dedicate to this external engagement over its duration.',
    `impact_on_teaching_load_flag` BOOLEAN COMMENT 'Indicates whether this external engagement is expected to impact the faculty members teaching load or course assignments.',
    `institutional_approval_required_flag` BOOLEAN COMMENT 'Indicates whether institutional approval is required for this type of external engagement per university policy.',
    `institutional_approval_status` STRING COMMENT 'Current status of the institutional approval process for this external engagement.. Valid values are `not_required|pending|approved|denied|conditional`',
    `institutional_resources_description` STRING COMMENT 'Description of the institutional resources to be used in support of the external engagement, if applicable.',
    `intellectual_contribution_category` STRING COMMENT 'AACSB classification of the intellectual contribution type represented by this external engagement for accreditation reporting.. Valid values are `basic_research|applied_research|teaching_learning|practice_academic`',
    `last_review_date` DATE COMMENT 'Date of the most recent institutional review or re-certification of this external engagement.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or re-certification of this external engagement.',
    `organization_name` STRING COMMENT 'Name of the external organization, company, agency, or entity with which the faculty member is engaged.',
    `organization_type` STRING COMMENT 'Classification of the external organization by sector or entity type.. Valid values are `corporate|nonprofit|government|academic|professional_association|media`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this external engagement record was first created in the system.',
    `record_current_flag` BOOLEAN COMMENT 'Indicates whether this is the current active version of the external engagement record in a Type 2 slowly changing dimension.',
    `record_effective_from_date` DATE COMMENT 'Start date of the validity period for this version of the external engagement record in a Type 2 slowly changing dimension.',
    `record_effective_to_date` DATE COMMENT 'End date of the validity period for this version of the external engagement record. Null for the current active version.',
    `record_source_system` STRING COMMENT 'Name of the source system or module from which this external engagement record originated (e.g., Workday HCM, Kuali Research, manual disclosure form).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this external engagement record was last modified or updated.',
    `role_description` STRING COMMENT 'Detailed narrative description of the faculty members responsibilities, activities, and scope of work in the external engagement.',
    `role_title` STRING COMMENT 'Title or designation of the faculty members role within the external engagement (e.g., Board Member, Consultant, Expert Witness).',
    `start_date` DATE COMMENT 'Date when the external engagement officially began or is scheduled to begin.',
    `time_commitment_period` STRING COMMENT 'Time period over which the estimated time commitment is measured or averaged.. Valid values are `per_week|per_month|per_semester|per_year|total_engagement`',
    `use_of_institutional_resources_flag` BOOLEAN COMMENT 'Indicates whether the faculty member will use institutional resources (facilities, equipment, staff, intellectual property) in support of this external engagement.',
    CONSTRAINT pk_external_engagement PRIMARY KEY(`external_engagement_id`)
) COMMENT 'Records faculty external professional engagements including consulting agreements, expert witness roles, board memberships, industry advisory roles, media appearances, and policy advisory positions. Captures engagement type, organization name, role description, start and end dates, estimated time commitment, disclosed compensation (if any), conflict of interest disclosure status, and institutional approval status. Supports conflict of interest management, accreditation external engagement evidence, and AACSB intellectual contributions tracking.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`faculty_training_completion` (
    `faculty_training_completion_id` BIGINT COMMENT 'Primary key for faculty_training_completion',
    `employee_id` BIGINT COMMENT 'Identifier of the compliance officer or system administrator who assigned this training to the instructor. Used for audit trail and accountability. May be system-generated for automatic assignments based on role or policy.',
    `instructor_id` BIGINT COMMENT 'Foreign key linking to the instructor who completed or is assigned the training program',
    `compliance_training_completion_id` BIGINT COMMENT 'Unique identifier for this training completion record. Primary key for the association.',
    `training_program_id` BIGINT COMMENT 'Foreign key linking to the specific compliance training program completed or assigned',
    `waived_by_user_employee_id` BIGINT COMMENT 'Identifier of the compliance officer who approved the training waiver. Null unless completion_status is waived. Used for audit trail and accountability.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Percentage score achieved by the instructor on the training assessment or quiz. Used to determine whether passing_score_percentage threshold was met. Null if training does not include assessment or has not been attempted.',
    `assignment_date` DATE COMMENT 'Date on which this training program was assigned to the instructor. Used to calculate due_date and track compliance timeline. Set when training is initially assigned or when recertification is triggered.',
    `attempt_number` STRING COMMENT 'Sequential number indicating which attempt this represents for this instructor-training combination. Increments when instructor retakes training for recertification or after previous failure. Used to track training history and identify instructors requiring additional support.',
    `certificate_number` STRING COMMENT 'Unique certificate identifier issued upon successful completion of the training program. Used for audit verification and compliance reporting. Null if training does not issue certificates or has not been completed.',
    `completion_date` DATE COMMENT 'Date on which the instructor successfully completed the training program and met all requirements including passing assessment score. Null if training is assigned but not yet completed.',
    `completion_status` STRING COMMENT 'Current status of the training completion record. Assigned indicates training has been assigned but not started; in_progress indicates instructor has begun but not completed; completed indicates successful completion with passing score; expired indicates completion has passed recertification date; overdue indicates assigned training past due date; waived indicates training requirement waived by compliance officer.',
    `due_date` DATE COMMENT 'Date by which the instructor must complete the assigned training program. Calculated as assignment_date plus completion_deadline_days from the training program. Used to identify overdue training and escalate compliance issues.',
    `expiration_date` DATE COMMENT 'Date on which this training completion expires and recertification is required. Calculated as completion_date plus recertification_frequency_months from the training program. Used to trigger recertification notifications and compliance reporting.',
    `last_access_date` TIMESTAMP COMMENT 'Timestamp of the most recent time the instructor accessed the training content. Used to identify stalled or abandoned training attempts and trigger follow-up reminders.',
    `last_notification_date` DATE COMMENT 'Date of the most recent reminder notification sent to the instructor. Used to manage notification frequency and avoid over-communication.',
    `notification_sent_count` STRING COMMENT 'Number of reminder notifications sent to the instructor regarding this training assignment. Used to track communication attempts and escalation procedures.',
    `time_spent_minutes` STRING COMMENT 'Total time in minutes the instructor spent on the training content, tracked by the LMS or training platform. Used for engagement analysis and to verify minimum time requirements if applicable.',
    `waiver_date` DATE COMMENT 'Date on which the training waiver was approved. Null unless completion_status is waived. Used for compliance reporting and audit documentation.',
    `waiver_reason` STRING COMMENT 'Explanation for why the training requirement was waived for this instructor. Null unless completion_status is waived. Used for compliance documentation and audit purposes.',
    CONSTRAINT pk_faculty_training_completion PRIMARY KEY(`faculty_training_completion_id`)
) COMMENT 'This association product represents the completion event between instructor and training_program. It captures the compliance training completion lifecycle for faculty members, including completion status, assessment results, certification details, and recertification tracking. Each record links one instructor to one training_program with attributes that exist only in the context of this specific completion instance.. Existence Justification: In higher education compliance operations, instructors are required to complete multiple mandatory training programs (Title IX, FERPA, research ethics, cybersecurity, safety) throughout their employment, and each training program is completed by many instructors across the institution. The business actively manages training completion as a distinct operational entity with lifecycle tracking (assigned, in-progress, completed, expired, overdue), assessment results, certification issuance, and recertification scheduling. Compliance officers query and manage these completion records to ensure regulatory adherence and generate audit reports.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`event_participation` (
    `event_participation_id` BIGINT COMMENT 'Unique identifier for this faculty event participation record. Primary key for the association.',
    `event_id` BIGINT COMMENT 'Foreign key linking to the advancement event in which the instructor is participating',
    `instructor_id` BIGINT COMMENT 'Foreign key linking to the instructor participating in the advancement event',
    `honoree_flag` BOOLEAN COMMENT 'Indicates whether the faculty member is being honored or recognized at this event (e.g., distinguished professor award, endowed chair announcement). Explicitly identified in detection reasoning.',
    `invitation_date` DATE COMMENT 'Date when the faculty member was invited to participate in the advancement event. Used for tracking response time and planning timelines.',
    `notes` STRING COMMENT 'Free-text notes about the faculty members participation including special requirements, dietary restrictions, AV needs, or post-event feedback.',
    `participation_status` STRING COMMENT 'Current status of the faculty members participation in the event. Tracks progression from invitation through attendance. Explicitly identified in detection reasoning.',
    `presentation_duration_minutes` STRING COMMENT 'Scheduled duration in minutes for the faculty members presentation or remarks. Used for event agenda planning.',
    `presentation_title` STRING COMMENT 'Title of the presentation, speech, or remarks delivered by the faculty member at the event. Null for non-speaking roles. Explicitly identified in detection reasoning.',
    `response_date` DATE COMMENT 'Date when the faculty member responded to the participation invitation. Used for event planning and follow-up.',
    `role_type` STRING COMMENT 'The role in which the faculty member participates in the advancement event. Determines expectations, compensation, and recognition. Explicitly identified in detection reasoning.',
    `service_credit_hours` DECIMAL(18,2) COMMENT 'Number of service hours credited to the faculty member for this event participation. Used for faculty service tracking and promotion/tenure documentation.',
    `speaker_fee_amount` DECIMAL(18,2) COMMENT 'Monetary compensation paid to the faculty member for their participation in the event. May be zero for voluntary participation. Explicitly identified in detection reasoning.',
    `travel_reimbursed_flag` BOOLEAN COMMENT 'Indicates whether the institution reimburses travel expenses for the faculty member to attend this event. Relevant for regional or off-campus events. Explicitly identified in detection reasoning.',
    CONSTRAINT pk_event_participation PRIMARY KEY(`event_participation_id`)
) COMMENT 'This association product represents the participation relationship between instructors and advancement events. It captures faculty involvement in donor cultivation and stewardship activities including speaking engagements, honoree recognition, and hosting duties. Each record links one instructor to one advancement_event with attributes that describe the nature, compensation, and logistics of their participation.. Existence Justification: Faculty members participate in multiple advancement events throughout their careers (galas, donor dinners, campaign launches, named lecture series), and each advancement event involves multiple faculty members in various capacities (speakers, honorees, hosts, panelists). The advancement office actively manages faculty rosters for each event, tracking invitation status, roles, compensation, and service credit. This is an operational business process, not an analytical correlation.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`resource_evaluation` (
    `resource_evaluation_id` BIGINT COMMENT 'Unique identifier for this evaluation record. Primary key.',
    `electronic_resource_id` BIGINT COMMENT 'Foreign key linking to the electronic resource being evaluated',
    `instructor_id` BIGINT COMMENT 'Foreign key linking to the instructor who evaluated the resource',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this evaluation record was created in the library system.',
    `evaluation_comments` STRING COMMENT 'Free-text comments from the instructor regarding resource quality, usability, content coverage, and value proposition.',
    `evaluation_date` DATE COMMENT 'Date when the instructor submitted their evaluation feedback to the library.',
    `recommendation` STRING COMMENT 'Instructors recommendation regarding whether the institution should acquire or subscribe to this electronic resource.',
    `subject_relevance_rating` STRING COMMENT 'Instructors rating of how relevant the resource is to their discipline and teaching/research needs. Scale 1-5 where 5 is highly relevant.',
    `trial_evaluation_role` STRING COMMENT 'Role in which the instructor evaluated the resource. Indicates whether they were solicited as primary evaluator, department representative, or provided unsolicited feedback.',
    `usage_commitment` STRING COMMENT 'Instructors statement of how they intend to use the resource (e.g., required reading for HIST 301, supplemental research for graduate seminars, reference for thesis advising).',
    CONSTRAINT pk_resource_evaluation PRIMARY KEY(`resource_evaluation_id`)
) COMMENT 'This association product represents the evaluation event between instructor and electronic_resource during trial periods. It captures faculty feedback solicited by the library to inform collection development and acquisition decisions. Each record links one instructor to one electronic_resource trial with evaluation metadata including role, recommendation, and subject relevance assessment.. Existence Justification: In higher education library operations, electronic resource trial evaluations are a formal collection development process where the library solicits feedback from multiple faculty across relevant departments before making acquisition decisions. One instructor evaluates multiple database trials across their disciplines, and each resource trial is evaluated by multiple faculty to gather diverse perspectives on relevance, usability, and value. The evaluation relationship is an operational business entity that library staff actively create, track, and aggregate to inform renewal decisions and cost-per-use analysis.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`project_participation` (
    `project_participation_id` BIGINT COMMENT 'Unique identifier for this faculty project participation record. Primary key.',
    `instructor_id` BIGINT COMMENT 'Foreign key linking to the instructor participating in the IT project',
    `it_project_id` BIGINT COMMENT 'Foreign key linking to the IT project in which the instructor is participating',
    `assigned_date` DATE COMMENT 'Date when the instructor was formally assigned to participate in this IT project by governance or project management. May precede actual start_date.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether this faculty participation is billable to the project budget (true) or contributed as in-kind effort (false). Used for project cost accounting and faculty compensation tracking.',
    `effort_percentage` DECIMAL(18,2) COMMENT 'Percentage of the instructors time allocated to this IT project participation. Used for workload planning and effort tracking across concurrent project engagements.',
    `end_date` DATE COMMENT 'Date when the instructors participation in this IT project ended or is scheduled to end. Null for ongoing active participation.',
    `participation_status` STRING COMMENT 'Current status of the instructors participation in this IT project. Active indicates ongoing engagement, completed indicates role fulfilled, on_hold indicates temporary suspension, withdrawn indicates early termination.',
    `role_on_project` STRING COMMENT 'The specific role or capacity in which the instructor is participating in the IT project. Determines expectations and responsibilities for this engagement.',
    `start_date` DATE COMMENT 'Date when the instructors participation in this IT project began. Marks the start of their engagement in the specified role.',
    CONSTRAINT pk_project_participation PRIMARY KEY(`project_participation_id`)
) COMMENT 'This association product represents the participation relationship between faculty instructors and institutional IT projects. It captures faculty involvement as subject matter experts, pilot users, governance representatives, or advisory committee members across technology initiatives. Each record links one instructor to one IT project with role, effort allocation, and participation timeline attributes that exist only in the context of this specific project engagement.. Existence Justification: In higher education IT governance, faculty members routinely participate in multiple concurrent IT projects (LMS upgrades, research computing initiatives, ERP implementations) in various capacities such as subject matter experts, pilot users, or governance representatives. Simultaneously, each IT project requires participation from multiple faculty members across different departments to ensure stakeholder representation, domain expertise, and user acceptance. Universities actively manage these participation assignments to balance faculty workload, ensure adequate project staffing, and track effort allocation for budget and compensation purposes.';

CREATE OR REPLACE TABLE `education_ecm`.`faculty`.`faculty_application_access` (
    `faculty_application_access_id` BIGINT COMMENT 'Primary key for faculty_application_access',
    `access_entitlement_id` BIGINT COMMENT 'Unique identifier for this application access record. Primary key for the application_access association.',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to the enterprise application for which access has been provisioned',
    `instructor_id` BIGINT COMMENT 'Foreign key linking to the instructor who has been provisioned access to the enterprise application',
    `access_expiration_date` DATE COMMENT 'Date when this access grant expires and requires renewal or review. Null for permanent access grants. Used for periodic access recertification.',
    `access_level` STRING COMMENT 'Level of access granted to the instructor for this application, indicating scope and permissions (e.g., full, restricted, read_only, department_scoped).',
    `access_status` STRING COMMENT 'Current status of the instructors access to this application (active, suspended, expired, pending_approval, revoked). Used for access governance and security management.',
    `approved_by` STRING COMMENT 'Identifier of the person who approved this application access request. Used for compliance and audit trail.',
    `cost_center_code` STRING COMMENT 'Cost center or department code to which this application access license cost is allocated. Used for chargeback and budget management.',
    `deprovisioning_date` DATE COMMENT 'Date when access to this application was revoked or deprovisioned for the instructor. Null for active access. Used for access lifecycle tracking.',
    `deprovisioning_reason` STRING COMMENT 'Reason for access revocation (e.g., termination, role_change, license_optimization, security_incident). Used for audit and analysis.',
    `last_login_date` TIMESTAMP COMMENT 'Timestamp of the instructors most recent login to this application. Used for license optimization, inactive account identification, and usage analytics.',
    `license_type` STRING COMMENT 'Type of license assigned to the instructor for this application (e.g., named_user, concurrent, site_license). Used for license cost allocation and optimization.',
    `provisioning_date` DATE COMMENT 'Date when access to this application was initially provisioned for the instructor. Used for access lifecycle tracking and compliance auditing.',
    `requested_by` STRING COMMENT 'Identifier of the person (typically department chair or IT staff) who requested this application access for the instructor. Used for audit trail.',
    `training_completed_flag` BOOLEAN COMMENT 'Boolean indicator of whether the instructor has completed required training for this application. Used for compliance tracking and support planning.',
    `training_completion_date` DATE COMMENT 'Date when the instructor completed required training for this application. Null if training not yet completed.',
    `user_role` STRING COMMENT 'Role assigned to the instructor within this specific application, determining functional permissions and capabilities (e.g., admin, instructor, researcher, standard_user).',
    CONSTRAINT pk_faculty_application_access PRIMARY KEY(`faculty_application_access_id`)
) COMMENT 'This association product represents the access provisioning relationship between instructors and enterprise applications. It captures user access management, role assignments, and usage tracking for faculty members across the institutional application portfolio. Each record links one instructor to one enterprise application with attributes that exist only in the context of this access relationship, including role, access level, provisioning dates, and training status.. Existence Justification: In higher education IT operations, instructors require access to multiple enterprise applications (Canvas LMS, Banner, research administration systems, library systems, HR self-service portals) to perform their teaching, research, and administrative duties. Each application has hundreds or thousands of faculty users with varying roles and access levels. The university actively manages this many-to-many relationship through IT provisioning processes, tracking access grants, roles, training completion, last login dates, and license assignments for compliance, security auditing, and cost optimization.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `education_ecm`.`faculty`.`appointment` ADD CONSTRAINT `fk_faculty_appointment_hire_event_id` FOREIGN KEY (`hire_event_id`) REFERENCES `education_ecm`.`faculty`.`hire_event`(`hire_event_id`);
ALTER TABLE `education_ecm`.`faculty`.`appointment` ADD CONSTRAINT `fk_faculty_appointment_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ADD CONSTRAINT `fk_faculty_tenure_case_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ADD CONSTRAINT `fk_faculty_rank_history_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ADD CONSTRAINT `fk_faculty_rank_history_tenure_case_id` FOREIGN KEY (`tenure_case_id`) REFERENCES `education_ecm`.`faculty`.`tenure_case`(`tenure_case_id`);
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ADD CONSTRAINT `fk_faculty_department_affiliation_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`credential` ADD CONSTRAINT `fk_faculty_credential_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ADD CONSTRAINT `fk_faculty_teaching_load_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ADD CONSTRAINT `fk_faculty_scholarly_activity_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ADD CONSTRAINT `fk_faculty_annual_review_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ADD CONSTRAINT `fk_faculty_sabbatical_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ADD CONSTRAINT `fk_faculty_sabbatical_sabbatical_instructor_id` FOREIGN KEY (`sabbatical_instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ADD CONSTRAINT `fk_faculty_sabbatical_sabbatical_replacement_faculty_instructor_id` FOREIGN KEY (`sabbatical_replacement_faculty_instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ADD CONSTRAINT `fk_faculty_service_assignment_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ADD CONSTRAINT `fk_faculty_accreditation_qualification_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ADD CONSTRAINT `fk_faculty_hire_event_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`compensation` ADD CONSTRAINT `fk_faculty_compensation_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `education_ecm`.`faculty`.`appointment`(`appointment_id`);
ALTER TABLE `education_ecm`.`faculty`.`compensation` ADD CONSTRAINT `fk_faculty_compensation_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ADD CONSTRAINT `fk_faculty_leave_record_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ADD CONSTRAINT `fk_faculty_advising_assignment_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ADD CONSTRAINT `fk_faculty_professional_development_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ADD CONSTRAINT `fk_faculty_endowed_position_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ADD CONSTRAINT `fk_faculty_external_engagement_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ADD CONSTRAINT `fk_faculty_faculty_training_completion_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`event_participation` ADD CONSTRAINT `fk_faculty_event_participation_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`resource_evaluation` ADD CONSTRAINT `fk_faculty_resource_evaluation_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`project_participation` ADD CONSTRAINT `fk_faculty_project_participation_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` ADD CONSTRAINT `fk_faculty_faculty_application_access_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `education_ecm`.`faculty`.`instructor`(`instructor_id`);

-- ========= TAGS =========
ALTER SCHEMA `education_ecm`.`faculty` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `education_ecm`.`faculty` SET TAGS ('dbx_domain' = 'faculty');
ALTER TABLE `education_ecm`.`faculty`.`instructor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`faculty`.`instructor` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Instructor Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Office Room Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `patron_id` SET TAGS ('dbx_business_glossary_term' = 'Patron Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `appointment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Current Appointment End Date');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `appointment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Current Appointment Start Date');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `banner_pidm` SET TAGS ('dbx_business_glossary_term' = 'Banner Person Internal Identification Master (PIDM)');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `banner_pidm` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `banner_pidm` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `canvas_user_code` SET TAGS ('dbx_business_glossary_term' = 'Canvas Learning Management System (LMS) User Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `canvas_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `canvas_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `diversity_self_identification` SET TAGS ('dbx_business_glossary_term' = 'Diversity Self-Identification');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `diversity_self_identification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Instructor Email Address');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `emplid` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (EMPLID)');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `emplid` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `emplid` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `emplid` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `employment_classification` SET TAGS ('dbx_business_glossary_term' = 'Employment Classification');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `employment_classification` SET TAGS ('dbx_value_regex' = 'full-time|part-time|adjunct|visiting|emeritus|affiliate');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `faculty_rank` SET TAGS ('dbx_business_glossary_term' = 'Faculty Rank');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `faculty_status` SET TAGS ('dbx_business_glossary_term' = 'Faculty Status');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `faculty_status` SET TAGS ('dbx_value_regex' = 'active|on-leave|sabbatical|retired|terminated|deceased');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor First Name');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `graduate_faculty_status` SET TAGS ('dbx_business_glossary_term' = 'Graduate Faculty Status');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `graduate_faculty_status` SET TAGS ('dbx_value_regex' = 'full|associate|not-approved');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `highest_degree_earned` SET TAGS ('dbx_business_glossary_term' = 'Highest Degree Earned');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `highest_degree_earned` SET TAGS ('dbx_value_regex' = 'bachelor|master|doctorate|professional|other');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `highest_degree_field` SET TAGS ('dbx_business_glossary_term' = 'Highest Degree Field of Study');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `highest_degree_institution` SET TAGS ('dbx_business_glossary_term' = 'Highest Degree Granting Institution');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `highest_degree_year` SET TAGS ('dbx_business_glossary_term' = 'Highest Degree Completion Year');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Instructor Hire Date');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Last Name');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `last_promotion_date` SET TAGS ('dbx_business_glossary_term' = 'Last Promotion Date');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Middle Name');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `office_hours` SET TAGS ('dbx_business_glossary_term' = 'Office Hours Schedule');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `orcid_identifier` SET TAGS ('dbx_business_glossary_term' = 'Open Researcher and Contributor Identifier (ORCID)');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `orcid_identifier` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{3}[0-9X]$');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `phd_advisor_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'PhD Advisor Eligible Flag');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Instructor Phone Number');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Preferred Name');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `primary_college_code` SET TAGS ('dbx_business_glossary_term' = 'Primary College Code');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `primary_college_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `primary_research_cip_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Research Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `primary_research_cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `professional_licensure` SET TAGS ('dbx_business_glossary_term' = 'Professional Licensure and Certifications');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `record_source_system` SET TAGS ('dbx_value_regex' = 'workday|banner|manual|import');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `research_interests` SET TAGS ('dbx_business_glossary_term' = 'Research Interests and Expertise Areas');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `sabbatical_eligible_date` SET TAGS ('dbx_business_glossary_term' = 'Sabbatical Eligibility Date');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `teaching_load_fte` SET TAGS ('dbx_business_glossary_term' = 'Teaching Load Full-Time Equivalent (FTE)');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `tenure_date` SET TAGS ('dbx_business_glossary_term' = 'Tenure Award Date');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `tenure_status` SET TAGS ('dbx_business_glossary_term' = 'Tenure Status');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `tenure_status` SET TAGS ('dbx_value_regex' = 'tenured|tenure-track|non-tenure-track|not-applicable');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Faculty Union Affiliation');
ALTER TABLE `education_ecm`.`faculty`.`instructor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`appointment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`faculty`.`appointment` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'College Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `hire_event_id` SET TAGS ('dbx_business_glossary_term' = 'Hire Event Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Member Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Department Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `academic_rank` SET TAGS ('dbx_business_glossary_term' = 'Academic Rank');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `annual_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Salary Amount');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `annual_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `appointment_number` SET TAGS ('dbx_business_glossary_term' = 'Appointment Number');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `appointment_status` SET TAGS ('dbx_value_regex' = 'active|on-leave|suspended|terminated|completed|pending');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Approval Date');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Appointment Approved By');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `benefits_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Benefits Eligible Flag');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment End Date');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `endowed_chair_name` SET TAGS ('dbx_business_glossary_term' = 'Endowed Chair Name');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `grant_funded_flag` SET TAGS ('dbx_business_glossary_term' = 'Grant Funded Flag');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `joint_appointment_flag` SET TAGS ('dbx_business_glossary_term' = 'Joint Appointment Flag');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `primary_department_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Department Code');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `primary_department_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,6}$');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `research_expectation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Research Expectation Percentage');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `sabbatical_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Sabbatical Eligible Flag');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `salary_basis` SET TAGS ('dbx_business_glossary_term' = 'Salary Basis');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `salary_basis` SET TAGS ('dbx_value_regex' = 'annual|academic-year|per-course|hourly|stipend');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `salary_basis` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `salary_basis` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `service_expectation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Expectation Percentage');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Start Date');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `teaching_load_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Teaching Load Credit Hours (CR)');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `tenure_status` SET TAGS ('dbx_business_glossary_term' = 'Tenure Status');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `tenure_status` SET TAGS ('dbx_value_regex' = 'tenured|tenure-track|non-tenure-track|not-applicable');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `union_affiliation_code` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation Code');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `visa_sponsorship_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Visa Sponsorship Required Flag');
ALTER TABLE `education_ecm`.`faculty`.`appointment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `tenure_case_id` SET TAGS ('dbx_business_glossary_term' = 'Tenure Case Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Member Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Home Department Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Tenure Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|overturned|remanded|withdrawn|pending');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `board_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Board of Trustees Approval Date');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `board_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Board of Trustees Approval Status');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `board_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|deferred');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `case_initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Case Initiation Date');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Tenure Case Number');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Tenure Case Status');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `college_committee_recommendation` SET TAGS ('dbx_business_glossary_term' = 'College Committee Recommendation');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `college_committee_recommendation` SET TAGS ('dbx_value_regex' = 'strongly_support|support|support_with_reservations|do_not_support|strongly_oppose');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `college_committee_vote_date` SET TAGS ('dbx_business_glossary_term' = 'College Committee Vote Date');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `current_rank` SET TAGS ('dbx_business_glossary_term' = 'Current Faculty Rank');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `dean_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Dean Recommendation');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `dean_recommendation` SET TAGS ('dbx_value_regex' = 'strongly_support|support|support_with_reservations|do_not_support|strongly_oppose');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `dean_recommendation_date` SET TAGS ('dbx_business_glossary_term' = 'Dean Recommendation Date');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `department_chair_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Department Chair Recommendation');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `department_chair_recommendation` SET TAGS ('dbx_value_regex' = 'strongly_support|support|support_with_reservations|do_not_support|strongly_oppose');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `department_chair_recommendation_date` SET TAGS ('dbx_business_glossary_term' = 'Department Chair Recommendation Date');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `department_committee_vote_abstain` SET TAGS ('dbx_business_glossary_term' = 'Department Committee Abstentions');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `department_committee_vote_against` SET TAGS ('dbx_business_glossary_term' = 'Department Committee Votes Against');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `department_committee_vote_date` SET TAGS ('dbx_business_glossary_term' = 'Department Committee Vote Date');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `department_committee_vote_for` SET TAGS ('dbx_business_glossary_term' = 'Department Committee Votes in Favor');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `dossier_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Dossier Submission Date');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion and Tenure Effective Date');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `external_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'External Review Required Flag');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `external_reviewers_solicited_count` SET TAGS ('dbx_business_glossary_term' = 'External Reviewers Solicited Count');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `external_reviews_received_count` SET TAGS ('dbx_business_glossary_term' = 'External Reviews Received Count');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `final_outcome` SET TAGS ('dbx_business_glossary_term' = 'Final Promotion and Tenure (P&T) Outcome');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `final_outcome_date` SET TAGS ('dbx_business_glossary_term' = 'Final Outcome Date');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Case Notes');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `proposed_rank` SET TAGS ('dbx_business_glossary_term' = 'Proposed Faculty Rank');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `proposed_rank` SET TAGS ('dbx_value_regex' = 'assistant_professor|associate_professor|professor|distinguished_professor|clinical_associate|clinical_professor');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `provost_decision` SET TAGS ('dbx_business_glossary_term' = 'Provost Decision');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `provost_decision` SET TAGS ('dbx_value_regex' = 'approve|deny|defer|return_for_additional_review');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `provost_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Provost Decision Date');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `review_cycle_year` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Academic Year');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Promotion and Tenure (P&T) Review Type');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'third_year_review|pre_tenure_review|tenure_review|promotion_review|post_tenure_review|comprehensive_review');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `tenure_clock_start_date` SET TAGS ('dbx_business_glossary_term' = 'Tenure Clock Start Date');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `tenure_clock_stop_count` SET TAGS ('dbx_business_glossary_term' = 'Tenure Clock Stop Count');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `tenure_clock_years_elapsed` SET TAGS ('dbx_business_glossary_term' = 'Tenure Clock Years Elapsed');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `tenure_track_appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Tenure Track Appointment Start Date');
ALTER TABLE `education_ecm`.`faculty`.`tenure_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `rank_history_id` SET TAGS ('dbx_business_glossary_term' = 'Rank History ID');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty ID');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `tenure_case_id` SET TAGS ('dbx_business_glossary_term' = 'Tenure Case Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `accreditation_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Qualified Flag');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `appointment_type` SET TAGS ('dbx_value_regex' = 'Full-Time|Part-Time|Adjunct|Visiting|Emeritus');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Rank Change Approval Date');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Rank Change Reason');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `change_reason` SET TAGS ('dbx_value_regex' = 'Promotion|Initial Appointment|Reclassification|Demotion|Administrative Adjustment|Tenure Award');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `college_code` SET TAGS ('dbx_business_glossary_term' = 'College Code');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `contract_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Months');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `cumulative_years_of_service` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Years of Service');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rank Change Effective Date');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `external_hire_flag` SET TAGS ('dbx_business_glossary_term' = 'External Hire Flag');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `fte` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE)');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `new_rank` SET TAGS ('dbx_business_glossary_term' = 'New Academic Rank');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `new_rank` SET TAGS ('dbx_value_regex' = 'Instructor|Assistant Professor|Associate Professor|Professor|Distinguished Professor|Lecturer');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `prior_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Prior Institution Name');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `prior_rank` SET TAGS ('dbx_business_glossary_term' = 'Prior Academic Rank');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `prior_rank` SET TAGS ('dbx_value_regex' = 'Instructor|Assistant Professor|Associate Professor|Professor|Distinguished Professor|Lecturer');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `promotion_eligibility_date` SET TAGS ('dbx_business_glossary_term' = 'Next Promotion Eligibility Date');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `rank_change_notes` SET TAGS ('dbx_business_glossary_term' = 'Rank Change Notes');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `record_current_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Current Flag');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `record_effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective From Date');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `record_effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective To Date');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `salary_at_change` SET TAGS ('dbx_business_glossary_term' = 'Salary at Rank Change');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `salary_at_change` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `tenure_track_status` SET TAGS ('dbx_business_glossary_term' = 'Tenure Track Status');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `tenure_track_status` SET TAGS ('dbx_value_regex' = 'Tenure Track|Tenured|Non-Tenure Track|Clinical Track|Research Track');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `terminal_degree_flag` SET TAGS ('dbx_business_glossary_term' = 'Terminal Degree Flag');
ALTER TABLE `education_ecm`.`faculty`.`rank_history` ALTER COLUMN `years_in_prior_rank` SET TAGS ('dbx_business_glossary_term' = 'Years in Prior Rank');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `department_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Department Affiliation Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `accreditation_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Qualified Flag');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `affiliation_notes` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Notes');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `affiliation_status` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Status');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `affiliation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `affiliation_type` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Type');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `affiliation_type` SET TAGS ('dbx_value_regex' = 'teaching|research|administrative|clinical|joint|courtesy');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `appointment_designation` SET TAGS ('dbx_business_glossary_term' = 'Appointment Designation');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `appointment_designation` SET TAGS ('dbx_value_regex' = 'primary|secondary|joint|adjunct|affiliate');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `departmental_email` SET TAGS ('dbx_business_glossary_term' = 'Departmental Email Address');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `departmental_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `departmental_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `departmental_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `doctoral_committee_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Doctoral Committee Eligibility Flag');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `graduate_faculty_status` SET TAGS ('dbx_business_glossary_term' = 'Graduate Faculty Status');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `graduate_faculty_status` SET TAGS ('dbx_value_regex' = 'full|associate|none');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `office_phone` SET TAGS ('dbx_business_glossary_term' = 'Office Phone Number');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `office_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `office_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `qualification_category` SET TAGS ('dbx_business_glossary_term' = 'Qualification Category');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `qualification_category` SET TAGS ('dbx_value_regex' = 'scholarly_academic|practice_academic|scholarly_practitioner|instructional_practitioner|additional');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `research_load_percentage` SET TAGS ('dbx_business_glossary_term' = 'Research Load Percentage');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `salary_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Salary Allocation Percentage');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `salary_allocation_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `service_load_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Load Percentage');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `teaching_load_percentage` SET TAGS ('dbx_business_glossary_term' = 'Teaching Load Percentage');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `tenure_home_flag` SET TAGS ('dbx_business_glossary_term' = 'Tenure Home Flag');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `voting_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Voting Rights Flag');
ALTER TABLE `education_ecm`.`faculty`.`department_affiliation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `education_ecm`.`faculty`.`credential` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`faculty`.`credential` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `credential_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `accreditation_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Accreditation Standard Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `accreditation_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Qualifier Status');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `accreditation_qualifier` SET TAGS ('dbx_value_regex' = 'qualified|provisionally_qualified|not_qualified|under_review');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `awarding_institution` SET TAGS ('dbx_business_glossary_term' = 'Awarding Institution');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `awarding_institution_country` SET TAGS ('dbx_business_glossary_term' = 'Awarding Institution Country Code');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `awarding_institution_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^d{2}.d{4}$');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `conferral_date` SET TAGS ('dbx_business_glossary_term' = 'Conferral Date');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `continuing_education_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Required Flag');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `credential_level` SET TAGS ('dbx_business_glossary_term' = 'Credential Level');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `credential_name` SET TAGS ('dbx_business_glossary_term' = 'Credential Name');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Type');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `credential_type` SET TAGS ('dbx_value_regex' = 'degree|certification|license|professional_designation|fellowship|other');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `degree_type` SET TAGS ('dbx_business_glossary_term' = 'Degree Type');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `field_of_study` SET TAGS ('dbx_business_glossary_term' = 'Field of Study');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `issuing_body_accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body Accreditation Status');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `issuing_body_accreditation_status` SET TAGS ('dbx_value_regex' = 'regionally_accredited|nationally_accredited|internationally_recognized|not_accredited|unknown');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `license_state` SET TAGS ('dbx_business_glossary_term' = 'License State Code');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Credential Notes');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `primary_credential_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Credential Flag');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|deleted');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Credential Source System');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Credential Source System Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `teaching_discipline_alignment` SET TAGS ('dbx_business_glossary_term' = 'Teaching Discipline Alignment');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `teaching_discipline_alignment` SET TAGS ('dbx_value_regex' = 'direct_match|related_field|unrelated|not_applicable');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `terminal_degree_flag` SET TAGS ('dbx_business_glossary_term' = 'Terminal Degree Flag');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `transcript_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'Transcript on File Flag');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'transcript|diploma|third_party_service|license_lookup|direct_contact|self_reported');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `verification_source` SET TAGS ('dbx_business_glossary_term' = 'Verification Source');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `education_ecm`.`faculty`.`credential` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|not_verified|expired|revoked');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` SET TAGS ('dbx_subdomain' = 'academic_responsibilities');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `teaching_load_id` SET TAGS ('dbx_business_glossary_term' = 'Teaching Load ID');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty ID');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `academic_term_code` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Code');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `academic_term_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `accreditation_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Qualified Flag');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `actual_credit_hours_taught` SET TAGS ('dbx_business_glossary_term' = 'Actual Credit Hours (CR) Taught');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `adjusted_contracted_hours` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Contracted Hours');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `administrative_release_hours` SET TAGS ('dbx_business_glossary_term' = 'Administrative Release Hours');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `collective_bargaining_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Compliant Flag');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `college_code` SET TAGS ('dbx_business_glossary_term' = 'College Code');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `college_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `contract_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Months');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `contracted_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Contracted Credit Hours (CR)');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `dean_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Dean Approval Date');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `dean_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Dean Approval Flag');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `department_chair_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Department Chair Approval Date');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `department_chair_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Department Chair Approval Flag');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `faculty_rank` SET TAGS ('dbx_business_glossary_term' = 'Faculty Rank');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `faculty_to_student_ratio` SET TAGS ('dbx_business_glossary_term' = 'Faculty-to-Student Ratio');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `fte` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE)');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `graduate_course_flag` SET TAGS ('dbx_business_glossary_term' = 'Graduate Course Flag');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `hybrid_course_flag` SET TAGS ('dbx_business_glossary_term' = 'Hybrid Course Flag');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `load_assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Load Assignment Notes');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `load_balance_status` SET TAGS ('dbx_business_glossary_term' = 'Load Balance Status');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `load_balance_status` SET TAGS ('dbx_value_regex' = 'balanced|underload|overload|release_only');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `load_variance_hours` SET TAGS ('dbx_business_glossary_term' = 'Load Variance Hours');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `number_of_sections_assigned` SET TAGS ('dbx_business_glossary_term' = 'Number of Course Sections Assigned');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `online_course_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Course Flag');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `other_release_hours` SET TAGS ('dbx_business_glossary_term' = 'Other Release Hours');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `overload_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Overload Credit Hours (CR)');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `record_current_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Current Flag');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `record_effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective From Date');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `record_effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective To Date');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `record_source_system` SET TAGS ('dbx_value_regex' = 'banner|workday|manual_entry|integrated_feed');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `research_release_hours` SET TAGS ('dbx_business_glossary_term' = 'Research Release Hours');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `sabbatical_release_hours` SET TAGS ('dbx_business_glossary_term' = 'Sabbatical Release Hours');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `student_credit_hours_generated` SET TAGS ('dbx_business_glossary_term' = 'Student Credit Hours (SCH) Generated');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `tenure_track_status` SET TAGS ('dbx_business_glossary_term' = 'Tenure Track Status');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `tenure_track_status` SET TAGS ('dbx_value_regex' = 'tenure_track|tenured|non_tenure_track|not_applicable');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `terminal_degree_flag` SET TAGS ('dbx_business_glossary_term' = 'Terminal Degree Flag');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `total_enrollment_count` SET TAGS ('dbx_business_glossary_term' = 'Total Enrollment Count');
ALTER TABLE `education_ecm`.`faculty`.`teaching_load` ALTER COLUMN `total_release_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Release Hours');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` SET TAGS ('dbx_subdomain' = 'academic_responsibilities');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `scholarly_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Scholarly Activity ID');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `bib_record_id` SET TAGS ('dbx_business_glossary_term' = 'Bib Record Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `endowment_id` SET TAGS ('dbx_business_glossary_term' = 'Endowment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `gift_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty ID');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `scholarly_output_id` SET TAGS ('dbx_business_glossary_term' = 'Research Output Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `accreditation_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Qualified Flag');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `activity_cost` SET TAGS ('dbx_business_glossary_term' = 'Activity Cost');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `activity_date` SET TAGS ('dbx_business_glossary_term' = 'Activity Date');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `activity_notes` SET TAGS ('dbx_business_glossary_term' = 'Activity Notes');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `activity_subtype` SET TAGS ('dbx_business_glossary_term' = 'Activity Subtype');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `activity_title` SET TAGS ('dbx_business_glossary_term' = 'Activity Title');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `author_sequence` SET TAGS ('dbx_business_glossary_term' = 'Author Sequence');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `certification_issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Issuing Body');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `citation_count` SET TAGS ('dbx_business_glossary_term' = 'Citation Count');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `co_authors_or_participants` SET TAGS ('dbx_business_glossary_term' = 'Co-Authors or Participants');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `college_code` SET TAGS ('dbx_business_glossary_term' = 'College Code');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `conference_location` SET TAGS ('dbx_business_glossary_term' = 'Conference Location');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `conference_name` SET TAGS ('dbx_business_glossary_term' = 'Conference Name');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `corresponding_author_flag` SET TAGS ('dbx_business_glossary_term' = 'Corresponding Author Flag');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `credit_hours_or_ceus` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours or Continuing Education Units (CEUs)');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `discipline_or_cip_code` SET TAGS ('dbx_business_glossary_term' = 'Discipline or Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `doi` SET TAGS ('dbx_business_glossary_term' = 'Digital Object Identifier (DOI)');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `externally_funded_flag` SET TAGS ('dbx_business_glossary_term' = 'Externally Funded Flag');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `impact_factor` SET TAGS ('dbx_business_glossary_term' = 'Impact Factor');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `included_in_promotion_dossier_flag` SET TAGS ('dbx_business_glossary_term' = 'Included in Promotion Dossier Flag');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `institutional_affiliation_at_time` SET TAGS ('dbx_business_glossary_term' = 'Institutional Affiliation at Time');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `intellectual_contribution_type` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Contribution Type');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `isbn` SET TAGS ('dbx_business_glossary_term' = 'International Standard Book Number (ISBN)');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `issn` SET TAGS ('dbx_business_glossary_term' = 'International Standard Serial Number (ISSN)');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `open_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Access Flag');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `patent_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Number');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `patent_status` SET TAGS ('dbx_business_glossary_term' = 'Patent Status');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `patent_status` SET TAGS ('dbx_value_regex' = 'filed|pending|granted|expired|abandoned');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `peer_review_status` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Status');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `peer_review_status` SET TAGS ('dbx_value_regex' = 'peer_reviewed|invited|juried|non_peer_reviewed|editorial|not_applicable');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `presentation_type` SET TAGS ('dbx_business_glossary_term' = 'Presentation Type');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `publication_year` SET TAGS ('dbx_business_glossary_term' = 'Publication Year');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`scholarly_activity` ALTER COLUMN `venue_or_publisher` SET TAGS ('dbx_business_glossary_term' = 'Venue or Publisher');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` SET TAGS ('dbx_subdomain' = 'academic_responsibilities');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `annual_review_id` SET TAGS ('dbx_business_glossary_term' = 'Annual Review ID');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty ID');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Review Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `academic_rank` SET TAGS ('dbx_business_glossary_term' = 'Academic Rank');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `appointment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|adjunct|visiting|emeritus');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `average_course_evaluation_score` SET TAGS ('dbx_business_glossary_term' = 'Average Course Evaluation Score');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `chair_review_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Chair Review Submitted Date');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `committee_assignments_count` SET TAGS ('dbx_business_glossary_term' = 'Committee Assignments Count');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `courses_taught_count` SET TAGS ('dbx_business_glossary_term' = 'Courses Taught Count');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `dean_review_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Dean Review Submitted Date');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `department_chair_narrative` SET TAGS ('dbx_business_glossary_term' = 'Department Chair Narrative');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `faculty_self_evaluation_narrative` SET TAGS ('dbx_business_glossary_term' = 'Faculty Self-Evaluation Narrative');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `faculty_self_evaluation_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Faculty Self-Evaluation Submitted Date');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `final_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Date');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `fte` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE)');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `goals_for_next_period` SET TAGS ('dbx_business_glossary_term' = 'Goals for Next Period');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `graduate_students_advised_count` SET TAGS ('dbx_business_glossary_term' = 'Graduate Students Advised Count');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `grant_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Grant Funding Amount');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `grants_awarded_count` SET TAGS ('dbx_business_glossary_term' = 'Grants Awarded Count');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `grants_submitted_count` SET TAGS ('dbx_business_glossary_term' = 'Grants Submitted Count');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `merit_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Merit Pay Amount');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `merit_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `merit_pay_percentage` SET TAGS ('dbx_business_glossary_term' = 'Merit Pay Percentage');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `merit_pay_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `merit_pay_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Merit Pay Recommended Flag');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `overall_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `overall_performance_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `presentations_count` SET TAGS ('dbx_business_glossary_term' = 'Presentations Count');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `professional_development_activities` SET TAGS ('dbx_business_glossary_term' = 'Professional Development Activities');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `publications_count` SET TAGS ('dbx_business_glossary_term' = 'Publications Count');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `research_rating` SET TAGS ('dbx_business_glossary_term' = 'Research and Scholarship Rating');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `research_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_applicable');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `service_rating` SET TAGS ('dbx_business_glossary_term' = 'Service Rating');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `service_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_applicable');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `student_enrollment_count` SET TAGS ('dbx_business_glossary_term' = 'Student Enrollment Count');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `teaching_load_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Teaching Load Credit Hours (CR)');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `teaching_rating` SET TAGS ('dbx_business_glossary_term' = 'Teaching Rating');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `teaching_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_applicable');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `tenure_track_status` SET TAGS ('dbx_business_glossary_term' = 'Tenure Track Status');
ALTER TABLE `education_ecm`.`faculty`.`annual_review` ALTER COLUMN `tenure_track_status` SET TAGS ('dbx_value_regex' = 'tenure_track|tenured|non_tenure_track|clinical_track|research_track');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` SET TAGS ('dbx_subdomain' = 'academic_responsibilities');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `sabbatical_id` SET TAGS ('dbx_business_glossary_term' = 'Sabbatical ID');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Sabbatical Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Department Chair ID');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Dean ID');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `sabbatical_instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty ID');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `sabbatical_provost_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Provost ID');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `sabbatical_provost_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `sabbatical_provost_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `sabbatical_replacement_faculty_instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Faculty ID');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `actual_return_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return Date');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `approved_end_date` SET TAGS ('dbx_business_glossary_term' = 'Approved End Date');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `approved_start_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Start Date');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `benefits_continuation_flag` SET TAGS ('dbx_business_glossary_term' = 'Benefits Continuation Flag');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Sabbatical Case Number');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `dean_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Dean Approval Date');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `dean_decision` SET TAGS ('dbx_business_glossary_term' = 'Dean Decision');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `dean_decision` SET TAGS ('dbx_value_regex' = 'approved|denied|pending');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `department_chair_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Department Chair Approval Date');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `department_chair_decision` SET TAGS ('dbx_business_glossary_term' = 'Department Chair Decision');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `department_chair_decision` SET TAGS ('dbx_value_regex' = 'approved|denied|pending');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `expected_return_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Return Date');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `hr_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Case Reference');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `leave_notes` SET TAGS ('dbx_business_glossary_term' = 'Leave Notes');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `leave_request_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Submitted Date');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `leave_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Status');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `pay_continuation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pay Continuation Percentage');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `post_sabbatical_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Sabbatical Report Due Date');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `post_sabbatical_report_status` SET TAGS ('dbx_business_glossary_term' = 'Post-Sabbatical Report Status');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `post_sabbatical_report_status` SET TAGS ('dbx_value_regex' = 'not_required|required|submitted|under_review|accepted|overdue');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `post_sabbatical_report_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Sabbatical Report Submitted Date');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Sabbatical Project Description');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `provost_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Provost Approval Date');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `provost_decision` SET TAGS ('dbx_business_glossary_term' = 'Provost Decision');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `provost_decision` SET TAGS ('dbx_value_regex' = 'approved|denied|pending');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Sabbatical Purpose');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `requested_end_date` SET TAGS ('dbx_business_glossary_term' = 'Requested End Date');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `requested_start_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Start Date');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `return_to_service_commitment_months` SET TAGS ('dbx_business_glossary_term' = 'Return to Service Commitment (Months)');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `sabbatical_type` SET TAGS ('dbx_business_glossary_term' = 'Sabbatical Type');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `sabbatical_type` SET TAGS ('dbx_value_regex' = 'full_year_half_pay|half_year_full_pay|other');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `teaching_load_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Teaching Load Impact Description');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `tenure_clock_extension_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Tenure Clock Extension Granted Flag');
ALTER TABLE `education_ecm`.`faculty`.`sabbatical` ALTER COLUMN `tenure_clock_extension_months` SET TAGS ('dbx_business_glossary_term' = 'Tenure Clock Extension (Months)');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` SET TAGS ('dbx_subdomain' = 'academic_responsibilities');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `service_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Assignment Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `access_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Access Entitlement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `affinity_group_id` SET TAGS ('dbx_business_glossary_term' = 'Affinity Group Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Advancement Event Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `accreditation_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Service Flag');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `appointment_authority` SET TAGS ('dbx_business_glossary_term' = 'Appointing Authority');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Date');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `appointment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment End Date');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `appointment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Start Date');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|completed|suspended|cancelled');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `committee_name` SET TAGS ('dbx_business_glossary_term' = 'Committee or Body Name');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `course_release_units` SET TAGS ('dbx_business_glossary_term' = 'Course Release Units');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `elected_position_flag` SET TAGS ('dbx_business_glossary_term' = 'Elected Position Flag');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `irb_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Service Flag');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `leadership_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Leadership Role Flag');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `meeting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Meeting Frequency');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `meeting_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly|annually|as_needed');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `national_prominence_flag` SET TAGS ('dbx_business_glossary_term' = 'National Prominence Flag');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `organization_name` SET TAGS ('dbx_business_glossary_term' = 'External Organization Name');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `organization_type` SET TAGS ('dbx_business_glossary_term' = 'External Organization Type');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `organization_type` SET TAGS ('dbx_value_regex' = 'professional_association|journal|funding_agency|accreditation_body|community_organization|government_agency');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `promotion_tenure_credit_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion and Tenure Credit Flag');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `record_created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `record_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `renewable_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Flag');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `role_title` SET TAGS ('dbx_business_glossary_term' = 'Role Title');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `service_scope` SET TAGS ('dbx_business_glossary_term' = 'Service Scope');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `service_scope` SET TAGS ('dbx_value_regex' = 'internal|external|community');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'faculty_senate|curriculum_committee|search_committee|irb|accreditation_self_study|editorial_board');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `term_length_years` SET TAGS ('dbx_business_glossary_term' = 'Term Length in Years');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `time_commitment_hours_per_year` SET TAGS ('dbx_business_glossary_term' = 'Time Commitment Hours Per Year');
ALTER TABLE `education_ecm`.`faculty`.`service_assignment` ALTER COLUMN `workload_credit_percentage` SET TAGS ('dbx_business_glossary_term' = 'Workload Credit Percentage');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` SET TAGS ('dbx_subdomain' = 'academic_responsibilities');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `accreditation_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Qualification Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `accreditation_review_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Review Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `coach_id` SET TAGS ('dbx_business_glossary_term' = 'Coach Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `accreditation_visit_cycle` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Visit Cycle');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Approval Date');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `determination_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Determination Date');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Effective End Date');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Effective Start Date');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiration Date');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `graduate_hours_in_discipline` SET TAGS ('dbx_business_glossary_term' = 'Graduate Credit Hours in Teaching Discipline');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `industry_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Industry Certification Date');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `industry_certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Industry Certification Expiration Date');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `industry_certification_issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Industry Certification Issuing Body');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `industry_certification_name` SET TAGS ('dbx_business_glossary_term' = 'Industry Certification Name');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Qualification Review Date');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `professional_experience_description` SET TAGS ('dbx_business_glossary_term' = 'Professional Experience Description');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `professional_license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Professional License Expiration Date');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `professional_license_number` SET TAGS ('dbx_business_glossary_term' = 'Professional License Number');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `professional_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `professional_license_state` SET TAGS ('dbx_business_glossary_term' = 'Professional License Issuing State');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `professional_license_type` SET TAGS ('dbx_business_glossary_term' = 'Professional License Type');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `qualification_category` SET TAGS ('dbx_business_glossary_term' = 'Qualification Category');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `qualification_category` SET TAGS ('dbx_value_regex' = 'Scholarly Academic|Practice Academic|Instructional Practitioner|Additional|Other');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `qualification_notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `qualification_pathway` SET TAGS ('dbx_business_glossary_term' = 'Qualification Pathway');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'Qualified|Provisionally Qualified|Not Qualified|Under Review|Expired|Pending Documentation');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `record_created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `record_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `requalification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Requalification Required Flag');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `reviewer_title` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Title');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `scholarly_activity_summary` SET TAGS ('dbx_business_glossary_term' = 'Scholarly Activity Summary');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `supporting_evidence_references` SET TAGS ('dbx_business_glossary_term' = 'Supporting Evidence References');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `terminal_degree_field` SET TAGS ('dbx_business_glossary_term' = 'Terminal Degree Field');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `terminal_degree_institution` SET TAGS ('dbx_business_glossary_term' = 'Terminal Degree Institution');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `terminal_degree_year` SET TAGS ('dbx_business_glossary_term' = 'Terminal Degree Conferral Year');
ALTER TABLE `education_ecm`.`faculty`.`accreditation_qualification` ALTER COLUMN `years_professional_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Professional Experience');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `hire_event_id` SET TAGS ('dbx_business_glossary_term' = 'Hire Event Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Search Committee Chair Faculty Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Service Request Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Department Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Requisition Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `accreditation_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Qualified Flag');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `appointment_type` SET TAGS ('dbx_value_regex' = 'regular|visiting|adjunct|emeritus|joint|courtesy');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `candidate_source` SET TAGS ('dbx_business_glossary_term' = 'Candidate Source');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `contract_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Months');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `degree_granting_institution` SET TAGS ('dbx_business_glossary_term' = 'Degree Granting Institution');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `diversity_hire_flag` SET TAGS ('dbx_business_glossary_term' = 'Diversity Hire Flag');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `doctoral_committee_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Doctoral Committee Eligibility Flag');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `external_hire_flag` SET TAGS ('dbx_business_glossary_term' = 'External Hire Flag');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `fte` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE)');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `graduate_faculty_status` SET TAGS ('dbx_business_glossary_term' = 'Graduate Faculty Status');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `graduate_faculty_status` SET TAGS ('dbx_value_regex' = 'full|associate|none');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `highest_degree_earned` SET TAGS ('dbx_business_glossary_term' = 'Highest Degree Earned');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `hire_notes` SET TAGS ('dbx_business_glossary_term' = 'Hire Notes');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `hire_status` SET TAGS ('dbx_business_glossary_term' = 'Hire Status');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `hire_status` SET TAGS ('dbx_value_regex' = 'offer_extended|offer_accepted|onboarding|active|offer_declined|hire_cancelled');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `initial_annual_salary` SET TAGS ('dbx_business_glossary_term' = 'Initial Annual Salary');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `initial_annual_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `initial_rank` SET TAGS ('dbx_business_glossary_term' = 'Initial Faculty Rank');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `negotiated_start_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Start Date');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `offer_accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Accepted Date');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Date');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `prior_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Prior Institution Name');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `record_source_system` SET TAGS ('dbx_value_regex' = 'workday_hcm|slate_crm|banner|manual_entry');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `relocation_assistance_amount` SET TAGS ('dbx_business_glossary_term' = 'Relocation Assistance Amount');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `relocation_assistance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `research_load_percentage` SET TAGS ('dbx_business_glossary_term' = 'Research Load Percentage');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `search_type` SET TAGS ('dbx_business_glossary_term' = 'Faculty Search Type');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `search_type` SET TAGS ('dbx_value_regex' = 'national|internal|emergency|targeted|failed_search_rehire|visiting');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `service_load_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Load Percentage');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `startup_package_amount` SET TAGS ('dbx_business_glossary_term' = 'Startup Package Amount');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `startup_package_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `teaching_load_percentage` SET TAGS ('dbx_business_glossary_term' = 'Teaching Load Percentage');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `tenure_track_status` SET TAGS ('dbx_business_glossary_term' = 'Tenure Track Status');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `tenure_track_status` SET TAGS ('dbx_value_regex' = 'tenure_track|tenured|non_tenure_track|clinical_track|research_track');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `terminal_degree_flag` SET TAGS ('dbx_business_glossary_term' = 'Terminal Degree Flag');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `visa_sponsorship_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Visa Sponsorship Required Flag');
ALTER TABLE `education_ecm`.`faculty`.`hire_event` ALTER COLUMN `visa_type` SET TAGS ('dbx_business_glossary_term' = 'Visa Type');
ALTER TABLE `education_ecm`.`faculty`.`compensation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`faculty`.`compensation` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation ID');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty ID');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Award ID');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Salary Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `accreditation_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Qualified Flag');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `administrative_stipend_amount` SET TAGS ('dbx_business_glossary_term' = 'Administrative Stipend Amount');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `administrative_stipend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `budget_account_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Account Code');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_business_glossary_term' = 'Compensation Status');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending|on_leave');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `contract_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Months');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|AUD');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Compensation Effective Date');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Compensation End Date');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `fte` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE)');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `last_salary_action_date` SET TAGS ('dbx_business_glossary_term' = 'Last Salary Action Date');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `last_salary_action_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `last_salary_action_date` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `last_salary_action_type` SET TAGS ('dbx_business_glossary_term' = 'Last Salary Action Type');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `last_salary_action_type` SET TAGS ('dbx_value_regex' = 'merit_increase|promotion|equity_adjustment|cost_of_living|retention|initial_appointment');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `last_salary_action_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `last_salary_action_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `market_equity_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Market Equity Adjustment Amount');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `market_equity_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `market_equity_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Market Equity Adjustment Flag');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compensation Notes');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `overload_courses_count` SET TAGS ('dbx_business_glossary_term' = 'Overload Courses Count');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `overload_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Overload Pay Rate');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `overload_pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `rank_at_compensation` SET TAGS ('dbx_business_glossary_term' = 'Rank at Compensation');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `rank_at_compensation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `rank_at_compensation` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `record_current_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Current Flag');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `record_effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective From Date');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `record_effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective To Date');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `salary_action_reason` SET TAGS ('dbx_business_glossary_term' = 'Salary Action Reason');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `salary_action_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `salary_action_reason` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `salary_basis` SET TAGS ('dbx_business_glossary_term' = 'Salary Basis');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `salary_basis` SET TAGS ('dbx_value_regex' = '9-month|10-month|11-month|12-month|hourly|daily');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `salary_basis` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `salary_basis` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `salary_step` SET TAGS ('dbx_business_glossary_term' = 'Salary Step');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `salary_step` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `salary_step` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `summer_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Summer Salary Amount');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `summer_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `summer_salary_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Summer Salary Eligible Flag');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `summer_salary_eligible_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `summer_salary_eligible_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `tenure_track_status` SET TAGS ('dbx_business_glossary_term' = 'Tenure Track Status');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `tenure_track_status` SET TAGS ('dbx_value_regex' = 'tenure_track|tenured|non_tenure_track|clinical_track|research_track');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `terminal_degree_flag` SET TAGS ('dbx_business_glossary_term' = 'Terminal Degree Flag');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `total_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Compensation Amount');
ALTER TABLE `education_ecm`.`faculty`.`compensation` ALTER COLUMN `total_compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` SET TAGS ('dbx_subdomain' = 'academic_responsibilities');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `leave_record_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Record Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `actual_return_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return Date');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `approved_start_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Start Date');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `benefits_continuation_flag` SET TAGS ('dbx_business_glossary_term' = 'Benefits Continuation Flag');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `college_code` SET TAGS ('dbx_business_glossary_term' = 'College Code');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `denial_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `disability_accommodation_flag` SET TAGS ('dbx_business_glossary_term' = 'Disability Accommodation Flag');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `disability_accommodation_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `disability_accommodation_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `expected_return_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Return Date');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `fmla_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Eligible Flag');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `fmla_hours_used` SET TAGS ('dbx_business_glossary_term' = 'Family and Medical Leave Act (FMLA) Hours Used');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `hr_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Case Reference');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `hr_case_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `intermittent_leave_flag` SET TAGS ('dbx_business_glossary_term' = 'Intermittent Leave Flag');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `leave_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Leave Duration in Days');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `leave_duration_weeks` SET TAGS ('dbx_business_glossary_term' = 'Leave Duration in Weeks');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `leave_notes` SET TAGS ('dbx_business_glossary_term' = 'Leave Notes');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `leave_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `leave_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Status');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `leave_status` SET TAGS ('dbx_value_regex' = 'requested|approved|denied|in_progress|completed|cancelled');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `leave_subtype` SET TAGS ('dbx_business_glossary_term' = 'Leave Subtype');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `leave_type` SET TAGS ('dbx_value_regex' = 'fmla|medical|parental|military|administrative|unpaid');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `medical_certification_received_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Received Date');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `medical_certification_received_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `medical_certification_received_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `medical_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Required Flag');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `medical_certification_required_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `medical_certification_required_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `paid_leave_flag` SET TAGS ('dbx_business_glossary_term' = 'Paid Leave Flag');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `partial_pay_percentage` SET TAGS ('dbx_business_glossary_term' = 'Partial Pay Percentage');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `reduced_schedule_flag` SET TAGS ('dbx_business_glossary_term' = 'Reduced Schedule Flag');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `reduced_schedule_fte` SET TAGS ('dbx_business_glossary_term' = 'Reduced Schedule Full-Time Equivalent (FTE)');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `requested_start_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Start Date');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `return_to_work_certification_received_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Certification Received Date');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `return_to_work_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Certification Required Flag');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `teaching_coverage_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Teaching Coverage Required Flag');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `tenure_clock_extension_months` SET TAGS ('dbx_business_glossary_term' = 'Tenure Clock Extension in Months');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `tenure_clock_stop_flag` SET TAGS ('dbx_business_glossary_term' = 'Tenure Clock Stop Flag');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `workers_compensation_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Claim Number');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `workers_compensation_claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `workers_compensation_flag` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Flag');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `workers_compensation_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`leave_record` ALTER COLUMN `workers_compensation_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` SET TAGS ('dbx_subdomain' = 'academic_responsibilities');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `advising_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Advising Assignment Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `mentorship_match_id` SET TAGS ('dbx_business_glossary_term' = 'Mentorship Match Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `academic_program_code` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Code');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `accreditation_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Reportable Flag');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `advising_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Advising Credit Hours');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `advising_load_count` SET TAGS ('dbx_business_glossary_term' = 'Advising Load Count');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `advising_type` SET TAGS ('dbx_business_glossary_term' = 'Advising Type');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `advising_type` SET TAGS ('dbx_value_regex' = 'academic_advisor|thesis_advisor|dissertation_chair|dissertation_committee_member|capstone_supervisor|research_mentor');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|completed|terminated|on_hold');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `college_code` SET TAGS ('dbx_business_glossary_term' = 'College Code');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `committee_role` SET TAGS ('dbx_business_glossary_term' = 'Committee Role');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `committee_role` SET TAGS ('dbx_value_regex' = 'chair|co_chair|member|external_member|reader|observer');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `compensation_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Eligible Flag');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `compensation_eligible_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `compensation_eligible_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `expected_end_date` SET TAGS ('dbx_business_glossary_term' = 'Expected End Date');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `meeting_frequency_requirement` SET TAGS ('dbx_business_glossary_term' = 'Meeting Frequency Requirement');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `meeting_frequency_requirement` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly|as_needed|per_program_policy');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `primary_advisor_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Advisor Flag');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `qualified_advisor_flag` SET TAGS ('dbx_business_glossary_term' = 'Qualified Advisor Flag');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `record_created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `record_current_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Current Flag');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `record_effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective From Date');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `record_effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective To Date');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `record_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `research_area` SET TAGS ('dbx_business_glossary_term' = 'Research Area');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `student_level` SET TAGS ('dbx_business_glossary_term' = 'Student Level');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `student_level` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate_masters|graduate_doctoral|post_doctoral|professional');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `education_ecm`.`faculty`.`advising_assignment` ALTER COLUMN `thesis_dissertation_title` SET TAGS ('dbx_business_glossary_term' = 'Thesis or Dissertation Title');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` SET TAGS ('dbx_subdomain' = 'academic_responsibilities');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `professional_development_id` SET TAGS ('dbx_business_glossary_term' = 'Professional Development Activity ID');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority ID');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Research Grant ID');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Member ID');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body Name');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `accreditation_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Relevant Flag');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `activity_cost` SET TAGS ('dbx_business_glossary_term' = 'Activity Cost Amount');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `activity_name` SET TAGS ('dbx_business_glossary_term' = 'Professional Development Activity Name');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `activity_notes` SET TAGS ('dbx_business_glossary_term' = 'Activity Notes');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Professional Development Activity Type');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `annual_review_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Annual Review Included Flag');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `certification_earned` SET TAGS ('dbx_business_glossary_term' = 'Certification Name Earned');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiration Date');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `ceu_earned` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Units (CEU) Earned');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `college_code` SET TAGS ('dbx_business_glossary_term' = 'College or School Code');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Activity Completion Date');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Completion Status');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|registered|cancelled|withdrawn|incomplete');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Professional Development Credit Hours');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `discipline_area` SET TAGS ('dbx_business_glossary_term' = 'Discipline or Subject Area');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `funding_account_code` SET TAGS ('dbx_business_glossary_term' = 'Funding Account Code');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Type');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'institutional|grant|departmental|personal|external_sponsor|professional_development_fund');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'Activity Location City');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `location_country` SET TAGS ('dbx_business_glossary_term' = 'Activity Location Country');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `location_state` SET TAGS ('dbx_business_glossary_term' = 'Activity Location State or Province');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Location Type');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'on_campus|off_campus|online|hybrid');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `promotion_tenure_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion and Tenure Relevant Flag');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Activity Provider Name');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Provider Type');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `provider_type` SET TAGS ('dbx_value_regex' = 'university|professional_association|commercial_vendor|government_agency|nonprofit_organization|internal_institutional');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `record_created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `record_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `relevance_to_research` SET TAGS ('dbx_business_glossary_term' = 'Relevance to Research Flag');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `relevance_to_service` SET TAGS ('dbx_business_glossary_term' = 'Relevance to Service Flag');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `relevance_to_teaching` SET TAGS ('dbx_business_glossary_term' = 'Relevance to Teaching Flag');
ALTER TABLE `education_ecm`.`faculty`.`professional_development` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Activity Start Date');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `endowed_position_id` SET TAGS ('dbx_business_glossary_term' = 'Endowed Position Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Endowment Finance Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `endowment_id` SET TAGS ('dbx_business_glossary_term' = 'Endowment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Current Holder Faculty Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `appointment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment End Date');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `appointment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Start Date');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `appointment_term_years` SET TAGS ('dbx_business_glossary_term' = 'Appointment Term Years');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^d{2}.d{4}$');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `discipline_area` SET TAGS ('dbx_business_glossary_term' = 'Discipline Area');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `discretionary_fund_amount` SET TAGS ('dbx_business_glossary_term' = 'Discretionary Fund Amount');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `discretionary_fund_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `donor_recognition_level` SET TAGS ('dbx_business_glossary_term' = 'Donor Recognition Level');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `donor_recognition_level` SET TAGS ('dbx_value_regex' = 'transformational|major|principal|leadership|patron');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `donor_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Reporting Required Flag');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `establishment_date` SET TAGS ('dbx_business_glossary_term' = 'Position Establishment Date');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `gift_amount` SET TAGS ('dbx_business_glossary_term' = 'Gift Amount');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `gift_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `gift_date` SET TAGS ('dbx_business_glossary_term' = 'Gift Date');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `position_notes` SET TAGS ('dbx_business_glossary_term' = 'Position Notes');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Endowed Position Status');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'active|vacant|suspended|terminated|pending_approval');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `position_title` SET TAGS ('dbx_business_glossary_term' = 'Endowed Position Title');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Endowed Position Type');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'endowed_chair|named_professorship|distinguished_professorship|visiting_chair|presidential_chair|university_professorship');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `record_current_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Current Flag');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `record_effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective From Date');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `record_effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective To Date');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `renewable_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Flag');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|none');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `research_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Research Requirement Flag');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `salary_supplement_amount` SET TAGS ('dbx_business_glossary_term' = 'Salary Supplement Amount');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `salary_supplement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `selection_criteria` SET TAGS ('dbx_business_glossary_term' = 'Selection Criteria');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `service_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Requirement Flag');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `special_obligations` SET TAGS ('dbx_business_glossary_term' = 'Special Obligations');
ALTER TABLE `education_ecm`.`faculty`.`endowed_position` ALTER COLUMN `teaching_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Teaching Requirement Flag');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` SET TAGS ('dbx_subdomain' = 'academic_responsibilities');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `external_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'External Engagement ID');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coi Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty ID');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `accreditation_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Reportable Flag');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `approval_conditions` SET TAGS ('dbx_business_glossary_term' = 'Approval Conditions');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `compensation_disclosed_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Disclosed Flag');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `compensation_disclosed_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `compensation_disclosed_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `compensation_type` SET TAGS ('dbx_value_regex' = 'honorarium|consulting_fee|retainer|equity|in_kind|none');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `conflict_of_interest_description` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest (COI) Description');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `conflict_of_interest_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `conflict_of_interest_disclosed_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest (COI) Disclosed Flag');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `conflict_of_interest_mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest (COI) Mitigation Plan');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `conflict_of_interest_mitigation_plan` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Date');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `engagement_notes` SET TAGS ('dbx_business_glossary_term' = 'Engagement Notes');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `engagement_number` SET TAGS ('dbx_business_glossary_term' = 'Engagement Number');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Type');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `estimated_time_commitment_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time Commitment Hours');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `impact_on_teaching_load_flag` SET TAGS ('dbx_business_glossary_term' = 'Impact on Teaching Load Flag');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `institutional_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Institutional Approval Required Flag');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `institutional_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Institutional Approval Status');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `institutional_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|denied|conditional');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `institutional_resources_description` SET TAGS ('dbx_business_glossary_term' = 'Institutional Resources Description');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `intellectual_contribution_category` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Contribution Category');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `intellectual_contribution_category` SET TAGS ('dbx_value_regex' = 'basic_research|applied_research|teaching_learning|practice_academic');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `organization_name` SET TAGS ('dbx_business_glossary_term' = 'Organization Name');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `organization_type` SET TAGS ('dbx_business_glossary_term' = 'Organization Type');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `organization_type` SET TAGS ('dbx_value_regex' = 'corporate|nonprofit|government|academic|professional_association|media');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `record_current_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Current Flag');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `record_effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective From Date');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `record_effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective To Date');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `role_description` SET TAGS ('dbx_business_glossary_term' = 'Role Description');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `role_title` SET TAGS ('dbx_business_glossary_term' = 'Role Title');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `time_commitment_period` SET TAGS ('dbx_business_glossary_term' = 'Time Commitment Period');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `time_commitment_period` SET TAGS ('dbx_value_regex' = 'per_week|per_month|per_semester|per_year|total_engagement');
ALTER TABLE `education_ecm`.`faculty`.`external_engagement` ALTER COLUMN `use_of_institutional_resources_flag` SET TAGS ('dbx_business_glossary_term' = 'Use of Institutional Resources Flag');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` SET TAGS ('dbx_subdomain' = 'academic_responsibilities');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` SET TAGS ('dbx_association_edges' = 'faculty.instructor,compliance.training_program');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `faculty_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'faculty_training_completion Identifier');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Training Assigned By User');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion - Instructor Id');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `compliance_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Identifier');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `training_program_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion - Compliance Training Id');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `waived_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Training Waived By User');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `waived_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `waived_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Training Assessment Score');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Training Assignment Date');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Training Attempt Number');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Training Certificate Number');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Status');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Due Date');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Training Certification Expiration Date');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `last_access_date` SET TAGS ('dbx_business_glossary_term' = 'Training Last Access Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `last_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Training Last Notification Date');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `notification_sent_count` SET TAGS ('dbx_business_glossary_term' = 'Training Notification Count');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `time_spent_minutes` SET TAGS ('dbx_business_glossary_term' = 'Training Time Spent');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Training Waiver Date');
ALTER TABLE `education_ecm`.`faculty`.`faculty_training_completion` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Training Waiver Reason');
ALTER TABLE `education_ecm`.`faculty`.`event_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`faculty`.`event_participation` SET TAGS ('dbx_subdomain' = 'external_relations');
ALTER TABLE `education_ecm`.`faculty`.`event_participation` SET TAGS ('dbx_association_edges' = 'faculty.instructor,advancement.advancement_event');
ALTER TABLE `education_ecm`.`faculty`.`event_participation` ALTER COLUMN `event_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Event Participation ID');
ALTER TABLE `education_ecm`.`faculty`.`event_participation` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Event Participation - Advancement Event Id');
ALTER TABLE `education_ecm`.`faculty`.`event_participation` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Event Participation - Instructor Id');
ALTER TABLE `education_ecm`.`faculty`.`event_participation` ALTER COLUMN `honoree_flag` SET TAGS ('dbx_business_glossary_term' = 'Honoree Flag');
ALTER TABLE `education_ecm`.`faculty`.`event_participation` ALTER COLUMN `invitation_date` SET TAGS ('dbx_business_glossary_term' = 'Invitation Date');
ALTER TABLE `education_ecm`.`faculty`.`event_participation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Participation Notes');
ALTER TABLE `education_ecm`.`faculty`.`event_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `education_ecm`.`faculty`.`event_participation` ALTER COLUMN `presentation_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Presentation Duration');
ALTER TABLE `education_ecm`.`faculty`.`event_participation` ALTER COLUMN `presentation_title` SET TAGS ('dbx_business_glossary_term' = 'Presentation Title');
ALTER TABLE `education_ecm`.`faculty`.`event_participation` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `education_ecm`.`faculty`.`event_participation` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Participation Role Type');
ALTER TABLE `education_ecm`.`faculty`.`event_participation` ALTER COLUMN `service_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Credit Hours');
ALTER TABLE `education_ecm`.`faculty`.`event_participation` ALTER COLUMN `speaker_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Speaker Fee Amount');
ALTER TABLE `education_ecm`.`faculty`.`event_participation` ALTER COLUMN `travel_reimbursed_flag` SET TAGS ('dbx_business_glossary_term' = 'Travel Reimbursed Flag');
ALTER TABLE `education_ecm`.`faculty`.`resource_evaluation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`faculty`.`resource_evaluation` SET TAGS ('dbx_subdomain' = 'external_relations');
ALTER TABLE `education_ecm`.`faculty`.`resource_evaluation` SET TAGS ('dbx_association_edges' = 'faculty.instructor,library.electronic_resource');
ALTER TABLE `education_ecm`.`faculty`.`resource_evaluation` ALTER COLUMN `resource_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Evaluation Identifier');
ALTER TABLE `education_ecm`.`faculty`.`resource_evaluation` ALTER COLUMN `electronic_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Evaluation - Electronic Resource Id');
ALTER TABLE `education_ecm`.`faculty`.`resource_evaluation` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Evaluation - Instructor Id');
ALTER TABLE `education_ecm`.`faculty`.`resource_evaluation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `education_ecm`.`faculty`.`resource_evaluation` ALTER COLUMN `evaluation_comments` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Comments');
ALTER TABLE `education_ecm`.`faculty`.`resource_evaluation` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `education_ecm`.`faculty`.`resource_evaluation` ALTER COLUMN `recommendation` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Recommendation');
ALTER TABLE `education_ecm`.`faculty`.`resource_evaluation` ALTER COLUMN `subject_relevance_rating` SET TAGS ('dbx_business_glossary_term' = 'Subject Relevance Rating');
ALTER TABLE `education_ecm`.`faculty`.`resource_evaluation` ALTER COLUMN `trial_evaluation_role` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Role');
ALTER TABLE `education_ecm`.`faculty`.`resource_evaluation` ALTER COLUMN `usage_commitment` SET TAGS ('dbx_business_glossary_term' = 'Usage Commitment');
ALTER TABLE `education_ecm`.`faculty`.`project_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`faculty`.`project_participation` SET TAGS ('dbx_subdomain' = 'external_relations');
ALTER TABLE `education_ecm`.`faculty`.`project_participation` SET TAGS ('dbx_association_edges' = 'faculty.instructor,technology.it_project');
ALTER TABLE `education_ecm`.`faculty`.`project_participation` ALTER COLUMN `project_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Project Participation Identifier');
ALTER TABLE `education_ecm`.`faculty`.`project_participation` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Project Participation - Instructor Id');
ALTER TABLE `education_ecm`.`faculty`.`project_participation` ALTER COLUMN `it_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Participation - It Project Id');
ALTER TABLE `education_ecm`.`faculty`.`project_participation` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `education_ecm`.`faculty`.`project_participation` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Participation Flag');
ALTER TABLE `education_ecm`.`faculty`.`project_participation` ALTER COLUMN `effort_percentage` SET TAGS ('dbx_business_glossary_term' = 'Effort Allocation Percentage');
ALTER TABLE `education_ecm`.`faculty`.`project_participation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Participation End Date');
ALTER TABLE `education_ecm`.`faculty`.`project_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `education_ecm`.`faculty`.`project_participation` ALTER COLUMN `role_on_project` SET TAGS ('dbx_business_glossary_term' = 'Project Role');
ALTER TABLE `education_ecm`.`faculty`.`project_participation` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Start Date');
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` SET TAGS ('dbx_subdomain' = 'external_relations');
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` SET TAGS ('dbx_association_edges' = 'faculty.instructor,technology.enterprise_application');
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` ALTER COLUMN `faculty_application_access_id` SET TAGS ('dbx_business_glossary_term' = 'faculty_application_access Identifier');
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` ALTER COLUMN `access_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Application Access Identifier');
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Access - Enterprise Application Id');
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Application Access - Instructor Id');
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` ALTER COLUMN `access_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Access Expiration Date');
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` ALTER COLUMN `access_status` SET TAGS ('dbx_business_glossary_term' = 'Access Status');
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` ALTER COLUMN `deprovisioning_date` SET TAGS ('dbx_business_glossary_term' = 'Deprovisioning Date');
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` ALTER COLUMN `deprovisioning_reason` SET TAGS ('dbx_business_glossary_term' = 'Deprovisioning Reason');
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` ALTER COLUMN `last_login_date` SET TAGS ('dbx_business_glossary_term' = 'Last Login Date');
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` ALTER COLUMN `provisioning_date` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Date');
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` ALTER COLUMN `requested_by` SET TAGS ('dbx_business_glossary_term' = 'Requested By');
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` ALTER COLUMN `training_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Completed Flag');
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `education_ecm`.`faculty`.`faculty_application_access` ALTER COLUMN `user_role` SET TAGS ('dbx_business_glossary_term' = 'User Role');
