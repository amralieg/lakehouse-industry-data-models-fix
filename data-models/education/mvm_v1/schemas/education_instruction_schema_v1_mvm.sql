-- Schema for Domain: instruction | Business: Education | Version: v1_mvm
-- Generated on: 2026-05-06 15:14:03

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `education_ecm`.`instruction` COMMENT 'Covers the delivery of teaching and learning including course sections, faculty assignments, class schedules, room bookings, LMS course shells in Canvas, SCORM content, grading, and academic assessment. Owns the operational execution of the curriculum as defined in the curriculum domain and manages gradebook, assignments, and learning analytics.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `education_ecm`.`instruction`.`course_section` (
    `course_section_id` BIGINT COMMENT 'Unique identifier for the course section. Primary key for this operational instance of a course offering.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Program-level enrollment reporting, IPEDS submissions, and accreditation self-studies require knowing which academic program each section belongs to. Registrars and academic affairs offices filter sec',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Course scheduling systems must validate building availability, accessibility compliance, and campus location for registration display and facility coordination. Building reference required for room sc',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Course sections are delivered by academic departments that are cost centers. Essential for departmental budget reports, cost allocation, financial planning, and IPEDS finance surveys that aggregate in',
    `course_id` BIGINT COMMENT 'Reference to the parent course catalog definition from the curriculum domain. Links this operational section to its canonical course definition.',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.fee_schedule. Business justification: Fee assessment process: course sections are assessed fees per the applicable fee schedule (lab fees, course-specific fees). course_section.fee_amount is a denormalized rate from fee_schedule. A higher',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Tuition revenue recognition, IPEDS financial reporting, and period-close processes require mapping course sections to fiscal periods. course_section carries tuition_amount and fee_amount that must',
    `lms_course_shell_id` BIGINT COMMENT 'External identifier linking this section to its Canvas LMS course shell. Used for integration and analytics.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: IPEDS reporting, budget allocation, and accreditation require every course section to be attributed to its owning academic department/college org unit. college_code is a denormalized representation of',
    `prerequisite_rule_id` BIGINT COMMENT 'Foreign key linking to curriculum.prerequisite_rule. Business justification: SIS registration enforcement requires knowing which prerequisite rule governs each section offering. Banner and PeopleSoft systems link sections to prerequisite rules to enforce enrollment restriction',
    `instructor_id` BIGINT COMMENT 'Reference to the faculty member designated as the primary instructor of record for this section. Responsible for grading and course management.',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Primary meeting location for course sections drives registration systems, student schedules, and facility utilization reporting. Core scheduling relationship required for room conflict detection and c',
    `student_org_id` BIGINT COMMENT 'Foreign key linking to studentlife.student_org. Business justification: Student organizations sponsor course sections (Greek life leadership seminars, honor society colloquia). Registrar systems track org-affiliated sections for co-curricular transcript notation, restrict',
    `term_id` BIGINT COMMENT 'Reference to the academic term in which this section is offered (e.g., Fall 2024, Spring 2025).',
    `campus_code` STRING COMMENT 'Code identifying the campus where this section is primarily offered. Used for multi-campus institutions.. Valid values are `^[A-Z]{2,4}$`',
    `cip_code` STRING COMMENT 'Six-digit CIP code classifying the subject matter of this section for federal IPEDS reporting. Format: XX.XXXX.. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `contact_hours` DECIMAL(18,2) COMMENT 'Total number of instructional contact hours per week for this section. Used for workload calculation and accreditation reporting.',
    `course_level` STRING COMMENT 'Academic level of the course section: undergraduate, graduate, professional (law, medicine), or continuing education.. Valid values are `undergraduate|graduate|professional|continuing_education`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this course section record was first created in the system.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Number of academic credit hours awarded upon successful completion of this section. May differ from catalog default for variable-credit courses.',
    `crn` STRING COMMENT 'Five-digit Banner-specific course reference number that uniquely identifies this section within a term. The externally-known business identifier used by students and faculty for registration.. Valid values are `^[0-9]{5}$`',
    `cross_listed_sections` STRING COMMENT 'Comma-separated list of CRNs for sections cross-listed with this section. Students in cross-listed sections attend the same class but receive credit under different course numbers.',
    `delivery_mode` STRING COMMENT 'Method by which instruction is delivered: in-person (traditional classroom), online (fully remote), hybrid (mix of in-person and online), HyFlex (students choose attendance mode per session), or blended.. Valid values are `in_person|online|hybrid|hyflex|blended`',
    `end_date` DATE COMMENT 'Date when instruction concludes for this section. May differ from term end date for sub-term or module-based courses.',
    `end_time` TIMESTAMP COMMENT 'Time when the class session ends in 24-hour format (HH:MM). Null for asynchronous online sections.',
    `enrollment_actual` STRING COMMENT 'Current number of students enrolled in this section. Updated in real-time during registration periods.',
    `enrollment_capacity` STRING COMMENT 'Maximum number of students who can enroll in this section. Determined by room capacity, pedagogical considerations, or accreditation requirements.',
    `grade_mode` STRING COMMENT 'Grading scheme used for this section: standard letter grades, pass/fail, audit (no grade), or honors designation.. Valid values are `standard|pass_fail|audit|honors`',
    `instructional_method` STRING COMMENT 'Pedagogical approach used for instruction (e.g., lecture, laboratory, seminar, studio, independent study, practicum). Distinct from delivery mode.. Valid values are `lecture|lab|seminar|studio|independent_study|practicum`',
    `meeting_days` STRING COMMENT 'Days of the week when the section meets using standard abbreviations: M=Monday, T=Tuesday, W=Wednesday, R=Thursday, F=Friday, S=Saturday, U=Sunday.. Valid values are `^[MTWRFSU]+$`',
    `meeting_pattern` STRING COMMENT 'Days and times when the section meets (e.g., MWF 10:00-10:50, TR 14:00-15:15). Encoded string representing the schedule.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this course section record was last updated. Used for audit trail and data synchronization.',
    `registration_end_date` DATE COMMENT 'Date when student registration closes for this section. Typically the add/drop deadline.',
    `registration_start_date` DATE COMMENT 'Date when student registration opens for this section. May vary by student population or priority group.',
    `section_number` STRING COMMENT 'Section identifier within the course and term (e.g., 001, 002, A, B, W01). Distinguishes multiple offerings of the same course in the same term.. Valid values are `^[A-Z0-9]{1,3}$`',
    `section_status` STRING COMMENT 'Current lifecycle status of the course section indicating whether it is available for enrollment, has been cancelled, is in progress, or has concluded.. Valid values are `active|cancelled|completed|pending`',
    `section_title` STRING COMMENT 'Optional section-specific title that may differ from the catalog course title. Used when a section focuses on a particular topic or theme.',
    `special_approval_required` BOOLEAN COMMENT 'Indicates whether students need instructor, advisor, or departmental permission to register for this section.',
    `start_date` DATE COMMENT 'Date when instruction begins for this section. May differ from term start date for sub-term or module-based courses.',
    `start_time` TIMESTAMP COMMENT 'Time when the class session begins in 24-hour format (HH:MM). Null for asynchronous online sections.',
    `tuition_amount` DECIMAL(18,2) COMMENT 'Base tuition charge for this section in US dollars. May vary by student residency, program, or fee structure.',
    `waitlist_actual` STRING COMMENT 'Current number of students on the waitlist for this section.',
    `waitlist_capacity` STRING COMMENT 'Maximum number of students allowed on the waitlist when the section reaches enrollment capacity. Zero indicates no waitlist is available.',
    `withdrawal_deadline_date` DATE COMMENT 'Last date students can withdraw from this section without academic penalty. After this date, withdrawals may result in a W grade.',
    CONSTRAINT pk_course_section PRIMARY KEY(`course_section_id`)
) COMMENT 'Operational instance of a course offering for a specific term, representing the scheduled class that students enroll in. Captures section number, delivery mode (in-person, online, hybrid, HyFlex), meeting pattern, enrollment capacity, waitlist capacity, section status, credit hours, instructional method, CIP code, Canvas course shell reference, and Banner CRN. This is the primary operational unit of instruction delivery and the anchor entity for all instructional activity — faculty assignments, meetings, grades, and assessments all reference this product. Distinct from the curriculum domains course catalog definition.';

CREATE OR REPLACE TABLE `education_ecm`.`instruction`.`section_meeting` (
    `section_meeting_id` BIGINT COMMENT 'Unique identifier for the section meeting record. Primary key.',
    `building_id` BIGINT COMMENT 'FK to facility.building',
    `course_section_id` BIGINT COMMENT 'Reference to the parent course section for which this meeting pattern is scheduled. A single section may have multiple meeting records (e.g., lecture MWF plus lab T).',
    `instructor_id` BIGINT COMMENT 'Reference to the primary instructor assigned to this meeting. A meeting may have multiple instructors; this captures the primary instructor.',
    `lms_course_shell_id` BIGINT COMMENT 'Identifier of the Canvas LMS course shell associated with this section meeting. Used for integration between SIS and LMS.',
    `accessibility_features` STRING COMMENT 'Comma-separated list of accessibility features available in the assigned room (e.g., wheelchair accessible, hearing loop, adjustable desks). Supports ADA compliance.',
    `begin_time` TIMESTAMP COMMENT 'Time at which the meeting begins, in 24-hour HH:MM format. Null for arranged or online asynchronous meetings.',
    `campus_code` STRING COMMENT 'Code identifying the campus where the meeting is held (e.g., MAIN, NORTH, ONLINE).. Valid values are `^[A-Z]{1,5}$`',
    `conflict_flag` BOOLEAN COMMENT 'Indicates whether this meeting has a detected scheduling conflict (room double-booked or instructor double-booked). Used for schedule validation.',
    `contact_hours_per_week` DECIMAL(18,2) COMMENT 'Number of contact hours per week for this meeting pattern. Critical for accreditation reporting and faculty workload calculation.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this meeting record was first created in the system.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Number of credit hours associated with this meeting. Denormalized from section for reporting convenience.',
    `crn` STRING COMMENT 'Five-digit unique identifier for the course section within a term. Denormalized from section for reporting convenience.. Valid values are `^[0-9]{5}$`',
    `end_date` DATE COMMENT 'Last date on which this meeting pattern is effective. May differ from term end date for modules or sub-term courses.',
    `end_time` TIMESTAMP COMMENT 'Time at which the meeting ends, in 24-hour HH:MM format. Null for arranged or online asynchronous meetings.',
    `friday_flag` BOOLEAN COMMENT 'Indicates whether this meeting occurs on Fridays.',
    `meeting_number` STRING COMMENT 'Sequential number identifying this meeting within the section. Used to distinguish multiple meeting patterns for the same section (e.g., 1 for lecture, 2 for lab).',
    `meeting_schedule_type` STRING COMMENT 'Indicates whether the meeting follows a fixed schedule, is arranged by instructor, is fully online, or is to be announced (TBA).. Valid values are `scheduled|arranged|online|tba`',
    `meeting_status` STRING COMMENT 'Current status of the meeting pattern. Active meetings are in effect; cancelled meetings have been removed from the schedule; rescheduled meetings have been moved; completed meetings have concluded.. Valid values are `active|cancelled|rescheduled|completed`',
    `meeting_type` STRING COMMENT 'Type of instructional meeting. Distinguishes between lecture, lab, recitation, and other instructional modalities. Critical for contact hour calculation and accreditation reporting. [ENUM-REF-CANDIDATE: lecture|lab|recitation|seminar|studio|clinical|practicum|independent_study|online_synchronous|online_asynchronous|hybrid — 11 candidates stripped; promote to reference product]',
    `modified_by` STRING COMMENT 'User ID of the person or system process that last modified this meeting record.',
    `modified_date` TIMESTAMP COMMENT 'Timestamp when this meeting record was last modified.',
    `monday_flag` BOOLEAN COMMENT 'Indicates whether this meeting occurs on Mondays.',
    `online_meeting_url` STRING COMMENT 'URL for synchronous online meetings (e.g., Zoom, Teams). Populated for online synchronous and hybrid meeting types.',
    `published_flag` BOOLEAN COMMENT 'Indicates whether this meeting has been published to the public class schedule. Unpublished meetings are visible only to administrators.',
    `room_capacity` STRING COMMENT 'Maximum seating capacity of the assigned room. Used for enrollment cap validation and space utilization analysis.',
    `room_code` STRING COMMENT 'Code identifying the specific room within the building. Null for online or arranged meetings.. Valid values are `^[A-Z0-9]{1,10}$`',
    `room_setup_type` STRING COMMENT 'Physical configuration of the room (e.g., lecture hall, seminar table, lab benches). Used for room assignment validation and space planning. [ENUM-REF-CANDIDATE: lecture|seminar|lab|computer_lab|studio|auditorium|conference — 7 candidates stripped; promote to reference product]',
    `saturday_flag` BOOLEAN COMMENT 'Indicates whether this meeting occurs on Saturdays.',
    `source_system` STRING COMMENT 'System of record from which this meeting data originated (Banner for section scheduling, Archibus for room assignments, or manual entry).. Valid values are `banner|archibus|manual`',
    `start_date` DATE COMMENT 'First date on which this meeting pattern is effective. May differ from term start date for modules or sub-term courses.',
    `sunday_flag` BOOLEAN COMMENT 'Indicates whether this meeting occurs on Sundays.',
    `technology_features` STRING COMMENT 'Comma-separated list of technology features available in the assigned room (e.g., projector, smartboard, video conferencing, recording capability).',
    `term_code` STRING COMMENT 'Six-digit code identifying the academic term (e.g., 202401 for Spring 2024). Denormalized from section for reporting convenience.. Valid values are `^[0-9]{6}$`',
    `thursday_flag` BOOLEAN COMMENT 'Indicates whether this meeting occurs on Thursdays.',
    `tuesday_flag` BOOLEAN COMMENT 'Indicates whether this meeting occurs on Tuesdays.',
    `wednesday_flag` BOOLEAN COMMENT 'Indicates whether this meeting occurs on Wednesdays.',
    `created_by` STRING COMMENT 'User ID of the person or system process that created this meeting record.',
    CONSTRAINT pk_section_meeting PRIMARY KEY(`section_meeting_id`)
) COMMENT 'Scheduled meeting pattern for a course section, capturing the specific days, times, start and end dates, building, room, and meeting type (lecture, lab, recitation, online synchronous). A single course section may have multiple meeting records (e.g., lecture MWF + lab T). Sourced from Banner SSRMEET and Archibus room scheduling. Supports class schedule publication, room conflict detection, and accreditation contact-hour reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`instruction`.`faculty_assignment` (
    `faculty_assignment_id` BIGINT COMMENT 'Unique identifier for the faculty assignment record. Primary key for the faculty assignment entity.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: AACSB faculty sufficiency reports and program-level workload analysis require knowing which academic program each faculty assignment supports. Accreditation bodies mandate program-level faculty qualif',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Faculty effort reporting, payroll cost allocation, and IPEDS instructional expenditure reporting require linking faculty assignments to cost centers. The existing org_unit FK is not equivalent to cost',
    `course_section_id` BIGINT COMMENT 'Identifier of the course section to which the faculty member is assigned. Links to the course section entity in the instruction domain.',
    `grant_account_id` BIGINT COMMENT 'Foreign key linking to finance.grant_account. Business justification: Effort reporting and OMB Uniform Guidance (2 CFR 200) compliance require linking faculty assignments to grant accounts. Grant-funded faculty effort must be certified against specific grant accounts. ',
    `instructor_id` BIGINT COMMENT 'Identifier of the faculty member or instructor assigned to the course section. Links to the faculty master data entity in the faculty domain.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Faculty office location assignment drives space allocation, office hour scheduling, and HR-facilities coordination. Real process: institutions track faculty office buildings for workload planning, stu',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Faculty office room assignment required for space allocation systems, office hour publishing, student advising logistics, and facilities space utilization reporting. Real process: HR and facilities jo',
    `employee_id` BIGINT COMMENT 'Identifier of the user (typically department chair or dean) who approved this faculty assignment. Links to the user or employee entity.',
    `assignment_id` BIGINT COMMENT 'The native assignment identifier from Ellucian Banner Student Information System. Used for cross-system reconciliation and data lineage tracking.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the academic department responsible for this faculty assignment. May differ from the faculty members home department in cases of cross-departmental teaching.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Accreditors (HLC Criteria 4.A, SACSCOC) require institutions to document that faculty meet minimum qualification standards per specific regulatory requirements. Linking faculty_assignment to the gover',
    `term_id` BIGINT COMMENT 'Identifier of the academic term (semester, quarter, session) during which the faculty assignment is active. Links to the term entity.',
    `tertiary_faculty_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this faculty assignment record. Links to the user or employee entity for audit purposes.',
    `appointment_type` STRING COMMENT 'The type of faculty appointment held by the instructor at the time of assignment. Reflects the employment classification and tenure status. [ENUM-REF-CANDIDATE: tenure_track|tenured|adjunct|visiting|emeritus|clinical|research|lecturer — 8 candidates stripped; promote to reference product]',
    `assignment_approval_date` DATE COMMENT 'The date on which the faculty assignment was officially approved by the department chair or authorized administrator.',
    `assignment_end_date` DATE COMMENT 'The date on which the faculty assignment concludes. Typically aligns with the term end date but may differ for early departures or extended grading periods.',
    `assignment_notes` STRING COMMENT 'Free-text notes or comments regarding this faculty assignment. May include special arrangements, accommodations, or administrative remarks.',
    `assignment_role` STRING COMMENT 'The instructional role the faculty member fulfills for this course section. Defines the type of teaching responsibility.. Valid values are `primary_instructor|co_instructor|teaching_assistant|guest_lecturer|lab_instructor|recitation_leader`',
    `assignment_start_date` DATE COMMENT 'The date on which the faculty assignment becomes effective. Typically aligns with the term start date but may differ for late assignments or mid-term changes.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'The monetary compensation amount for this specific assignment, if applicable. Null for assignments covered under base salary. Stored in institutional base currency (USD).',
    `compensation_type` STRING COMMENT 'The method by which the faculty member is compensated for this assignment. Indicates whether the assignment is part of base salary, overload pay, or other compensation arrangement.. Valid values are `salary|overload|stipend|course_rate|volunteer`',
    `contract_number` STRING COMMENT 'The contract or agreement number associated with this faculty assignment, if applicable. Relevant for adjunct and visiting faculty with specific contractual arrangements.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this faculty assignment record was first created in the system. Supports audit trail and data lineage tracking.',
    `fte_contribution` DECIMAL(18,2) COMMENT 'The portion of a full-time equivalent position this assignment represents. Used for FTE reporting to IPEDS and internal resource planning. Values typically range from 0.0000 to 1.0000.',
    `grant_funded_percentage` DECIMAL(18,2) COMMENT 'Percentage of this faculty assignments compensation funded by external grants or sponsored research. Values range from 0.00 to 100.00. Null if not grant-funded.',
    `ipeds_reporting_category` STRING COMMENT 'The IPEDS functional expense category to which this faculty assignments effort should be allocated for federal reporting purposes.. Valid values are `instruction|research|public_service|academic_support|student_services|institutional_support`',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this faculty assignment record is currently active in the system. True if active, False if logically deleted or archived.',
    `is_grading_authority` BOOLEAN COMMENT 'Boolean flag indicating whether this faculty member has authority to submit final grades for the course section. True if authorized, False otherwise.',
    `is_primary_instructor` BOOLEAN COMMENT 'Boolean flag indicating whether this faculty member is the primary instructor of record for the course section. True if primary instructor, False otherwise.',
    `is_team_taught` BOOLEAN COMMENT 'Boolean flag indicating whether this course section is team-taught by multiple instructors. True if team-taught, False if single instructor.',
    `lms_instructor_role` STRING COMMENT 'The role assigned to the faculty member in the Canvas Learning Management System course shell. Determines LMS permissions and capabilities.. Valid values are `teacher|ta|designer|observer|grader`',
    `office_hours_required` DECIMAL(18,2) COMMENT 'Number of office hours per week the faculty member is required to hold for students in this course section. Measured in hours per week.',
    `percent_responsibility` DECIMAL(18,2) COMMENT 'Percentage of instructional responsibility allocated to this faculty member for the course section. Used when multiple instructors share teaching duties. Values range from 0.00 to 100.00.',
    `teaching_modality` STRING COMMENT 'The instructional delivery mode for this faculty assignment. Indicates whether teaching is conducted in-person, online, or in a hybrid format.. Valid values are `in_person|online|hybrid|hyflex|synchronous_online|asynchronous_online`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this faculty assignment record was last modified. Supports audit trail and change tracking.',
    `workload_credit_hours` DECIMAL(18,2) COMMENT 'Number of credit hours counted toward the faculty members teaching load for this assignment. May differ from course credit hours based on institutional workload policies and percent responsibility.',
    CONSTRAINT pk_faculty_assignment PRIMARY KEY(`faculty_assignment_id`)
) COMMENT 'Assignment of a faculty member or instructor to a course section for a given term, capturing role (primary instructor, co-instructor, teaching assistant, guest lecturer), percent responsibility, assignment status, workload credit hours, and Banner/Workday identifiers. Represents the instructional staffing record for a section. Supports teaching load calculation, FTE reporting, and IPEDS faculty activity reporting. References faculty master data owned by the faculty domain.';

CREATE OR REPLACE TABLE `education_ecm`.`instruction`.`lms_course_shell` (
    `lms_course_shell_id` BIGINT COMMENT 'Unique identifier for the LMS course shell record. Primary key for the Canvas course shell entity representing the digital instructional container.',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Hybrid and HyFlex courses require building reference in LMS for in-person session locations, campus resource access instructions, and student wayfinding. Real process: LMS displays building location f',
    `term_id` BIGINT COMMENT 'Reference to the academic term in which this course shell is active (e.g., Fall 2024, Spring 2025). Links to the term master data.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: LMS governance and IT access-control require each course shell to be provisioned under the owning academic org unit (department sub-account in Canvas/Blackboard). LMS administrators and compliance aud',
    `allow_student_discussion_editing` BOOLEAN COMMENT 'Indicates whether students can edit their own discussion posts after submission. True if editing is allowed; false if posts are locked after creation.',
    `allow_student_discussion_topics` BOOLEAN COMMENT 'Indicates whether students are permitted to create their own discussion topics in the course. True if students can create discussions; false if only instructors can create discussions.',
    `allow_student_forum_attachments` BOOLEAN COMMENT 'Indicates whether students can attach files to discussion posts. True if attachments are allowed; false if disabled.',
    `apply_assignment_group_weights` BOOLEAN COMMENT 'Indicates whether assignment group weights are used in final grade calculation. True if weighted grading is enabled (e.g., exams 40%, homework 30%, participation 30%); false if all assignments are equally weighted.',
    `concluded_timestamp` TIMESTAMP COMMENT 'Timestamp when the course shell transitioned to completed workflow state. Marks the official conclusion of the course and archival of active instruction.',
    `course_code` STRING COMMENT 'Short alphanumeric code identifying the course in Canvas, typically derived from the SIS course code (e.g., MATH-101-01-FALL2024). Displayed in Canvas UI and used for sorting and searching.',
    `course_format` STRING COMMENT 'Instructional delivery format for the course. On-campus indicates traditional face-to-face instruction; online indicates fully remote delivery; blended indicates hybrid instruction combining both modalities.. Valid values are `on_campus|online|blended`',
    `course_name` STRING COMMENT 'Full descriptive name of the course shell as displayed to students and faculty in Canvas (e.g., Introduction to Calculus - Section 01).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the course shell record was first created in Canvas. Represents the initial provisioning of the digital instructional container.',
    `default_view` STRING COMMENT 'The landing page students see when entering the course shell. Options include activity feed, wiki front page, modules list, syllabus, or assignments list.. Valid values are `feed|wiki|modules|syllabus|assignments`',
    `end_date` DATE COMMENT 'Date when the course shell concludes and transitions to completed state. Typically aligns with the last day of the academic term or course section end date.',
    `grading_standard_ref` BIGINT COMMENT 'Reference to the grading standard (grading scheme) applied to this course shell. Defines letter grade thresholds and GPA calculation rules. Null if using default institutional grading standard.',
    `hide_final_grades` BOOLEAN COMMENT 'Indicates whether final course grades are hidden from students in the Canvas gradebook. True if final grades are hidden; false if visible to students.',
    `homeroom_course` BOOLEAN COMMENT 'Indicates whether this course shell is designated as a homeroom course for K-12 or advisory purposes. True if homeroom; false if regular academic course.',
    `integration_ref` STRING COMMENT 'External integration identifier used for third-party system synchronization. Supports integration with external tools, SIS systems, or other enterprise applications.',
    `is_blueprint` BOOLEAN COMMENT 'Indicates whether this course shell itself is a blueprint master course. True if this is a blueprint template; false if it is a regular course or blueprint-associated course.',
    `is_public` BOOLEAN COMMENT 'Indicates whether the course shell is publicly visible to unauthenticated users. True if the course is open to public view; false if restricted to enrolled users only.',
    `is_public_to_auth_users` BOOLEAN COMMENT 'Indicates whether the course shell is visible to all authenticated institution users regardless of enrollment. True if any logged-in user can view; false if restricted to enrolled users only.',
    `last_sis_sync_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful synchronization with the Student Information System (Banner). Used for monitoring integration health and data freshness.',
    `license` STRING COMMENT 'Intellectual property license applied to course content. Defines usage rights for course materials. Common values include Creative Commons licenses or institutional copyright policies.',
    `lms_account_ref` BIGINT COMMENT 'Reference to the Canvas account (organizational unit) that owns this course shell. Accounts represent colleges, schools, departments, or other organizational hierarchies within the institution.',
    `lms_root_account_ref` BIGINT COMMENT 'Reference to the top-level Canvas account in the organizational hierarchy. Typically represents the institution itself. Used for multi-tenant Canvas instances.',
    `public_syllabus` BOOLEAN COMMENT 'Indicates whether the course syllabus is publicly accessible without authentication. True if syllabus is public; false if restricted to enrolled users.',
    `public_syllabus_to_auth` BOOLEAN COMMENT 'Indicates whether the course syllabus is visible to all authenticated institution users. True if any logged-in user can view syllabus; false if restricted to enrolled users.',
    `restrict_enrollments_to_dates` BOOLEAN COMMENT 'Indicates whether student access is restricted to the start and end date range. True if access is date-restricted; false if students can access the course outside the defined date range.',
    `sis_import_ref` BIGINT COMMENT 'Reference to the SIS import batch that created or last updated this course shell. Used for tracking data lineage and synchronization history with Banner.',
    `start_date` DATE COMMENT 'Date when the course shell becomes active and accessible to enrolled students. Typically aligns with the first day of the academic term or course section start date.',
    `storage_quota_mb` DECIMAL(18,2) COMMENT 'Maximum storage space allocated to this course shell for file uploads, measured in megabytes. Instructors and students cannot upload files exceeding this quota.',
    `storage_used_mb` DECIMAL(18,2) COMMENT 'Current storage space consumed by files uploaded to this course shell, measured in megabytes. Used for monitoring quota utilization and capacity planning.',
    `syllabus_body` STRING COMMENT 'HTML content of the course syllabus. Contains course description, learning outcomes, grading policies, schedule, and other syllabus information as authored by the instructor.',
    `template_applied` STRING COMMENT 'Name or identifier of the course template that was applied during course shell creation. Templates provide standardized structure, content, and settings for new courses. Null if no template was used.',
    `time_zone` STRING COMMENT 'Time zone setting for the course shell, used for displaying due dates and scheduling. Typically inherits from the institution or can be customized per course (e.g., America/New_York, America/Chicago).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the course shell record was last modified in Canvas. Tracks the most recent change to course settings, content, or metadata.',
    `workflow_state` STRING COMMENT 'Current lifecycle state of the course shell in Canvas. Unpublished courses are not visible to students; available courses are active; completed courses are archived; deleted courses are soft-deleted.. Valid values are `unpublished|available|completed|deleted`',
    CONSTRAINT pk_lms_course_shell PRIMARY KEY(`lms_course_shell_id`)
) COMMENT 'Canvas LMS course shell record corresponding to a course section or standalone learning environment. Captures Canvas course ID, SIS course ID, enrollment term, course state (unpublished, available, completed, deleted), visibility settings, blueprint course linkage, template applied, storage quota, and integration sync status with Banner. Represents the digital instructional container where content, assignments, discussions, and gradebook live. Owned by the instruction domain as the operational LMS record.';

CREATE OR REPLACE TABLE `education_ecm`.`instruction`.`assignment` (
    `assignment_id` BIGINT COMMENT 'Unique identifier for the assignment record. Primary key for the assignment entity.',
    `campus_event_id` BIGINT COMMENT 'Foreign key linking to studentlife.campus_event. Business justification: Event-Based Assignment: faculty routinely create assignments requiring attendance at a specific campus event (attend lecture, write reflection). Linking instruction_assignment to campus_event enables ',
    `course_section_id` BIGINT COMMENT 'Reference to the course section in which this assignment is created. Links assignment to the specific section offering where students will complete the work.',
    `employee_id` BIGINT COMMENT 'Reference to the faculty or staff member who originally created the assignment. Used for accountability and support workflows.',
    `instructor_id` BIGINT COMMENT 'Reference to the faculty member who serves as the moderator and selects the final grade when moderated grading is enabled. Null if not applicable.',
    `map_id` BIGINT COMMENT 'Foreign key linking to curriculum.curriculum_map. Business justification: Curriculum maps specify which assignments assess which PLOs/SLOs in which courses. Linking assignment to curriculum_map enables verification that planned assessment instruments are deployed, supports ',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Proctored exams, lab practicals, and place-based assessments require specific room assignments. Real process: exam scheduling systems coordinate room bookings for final exams and lab assignments requi',
    `rubric_id` BIGINT COMMENT 'Reference to the grading rubric associated with this assignment. Rubrics provide structured criteria and performance levels for consistent assessment.',
    `slo_id` BIGINT COMMENT 'Foreign key linking to curriculum.slo. Business justification: Instructors map assignments to specific SLOs for direct outcomes assessment. This link enables SLO attainment reporting, accreditation evidence collection (AACSB, ABET, HLC), and curriculum effectiven',
    `allowed_attempts` STRING COMMENT 'Number of times a student may submit or resubmit the assignment. Null or -1 indicates unlimited attempts. Used for quiz retakes and iterative assignments.',
    `allowed_file_extensions` STRING COMMENT 'Comma-separated list of file extensions that students are permitted to upload for this assignment. Examples: pdf,docx,xlsx. Null indicates no restriction.',
    `assignment_description` STRING COMMENT 'Detailed instructions, requirements, and expectations for the assignment. May include rich text, HTML formatting, embedded media, and rubric details.',
    `assignment_name` STRING COMMENT 'The title or name of the assignment as displayed to students and faculty. Should clearly communicate the assignment purpose and topic.',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the assignment. Draft assignments are not visible to students; published assignments are active and available.. Valid values are `draft|published|unpublished|deleted`',
    `assignment_type` STRING COMMENT 'Classification of the assignment by pedagogical format and delivery method. Determines workflow, submission requirements, and assessment approach. [ENUM-REF-CANDIDATE: homework|quiz|exam|project|discussion|lab_report|presentation|case_study|essay|problem_set|group_work — 11 candidates stripped; promote to reference product]',
    `available_from_date` TIMESTAMP COMMENT 'The date and time when the assignment becomes visible and accessible to students. Controls release timing for scaffolded learning and pacing.',
    `canvas_assignment_ref` STRING COMMENT 'External identifier from the Canvas LMS system. Used for integration and synchronization with the source system of record.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the assignment record was first created in the system. Used for audit trail and assignment lifecycle tracking.',
    `due_date` TIMESTAMP COMMENT 'The date and time by which students must submit the assignment. Used for late penalty calculation and student planning. Aligns with academic calendar and course schedule.',
    `external_tool_url` STRING COMMENT 'URL of the external Learning Tools Interoperability (LTI) tool used for this assignment. Applicable when submission_type is external_tool. Enables integration with third-party assessment platforms.',
    `grade_group_students_individually` BOOLEAN COMMENT 'For group assignments, indicates whether each group member receives an individual grade rather than a shared group grade. Supports differentiated assessment within groups.',
    `grader_count` STRING COMMENT 'Number of independent graders assigned to assess each submission when moderated grading is enabled. Null if moderated grading is not used.',
    `grading_type` STRING COMMENT 'The method by which student performance on this assignment will be evaluated and recorded. Determines gradebook display and transcript reporting format.. Valid values are `points|percentage|letter_grade|pass_fail|not_graded|gpa_scale`',
    `group_category_ref` BIGINT COMMENT 'Reference to the group category that defines which student groups will collaborate on this assignment. Null if not a group assignment.',
    `group_ref` BIGINT COMMENT 'Reference to the assignment group (category) for grade weighting purposes. Examples include Homework, Exams, Projects. Used for weighted final grade calculation.',
    `is_anonymous_grading` BOOLEAN COMMENT 'Indicates whether student identities are hidden from graders during assessment. Reduces grading bias and supports equitable evaluation practices.',
    `is_anonymous_peer_review` BOOLEAN COMMENT 'Indicates whether peer reviewers identities are hidden from submission authors. Reduces bias and encourages honest feedback.',
    `is_group_assignment` BOOLEAN COMMENT 'Indicates whether this assignment is completed collaboratively by student groups rather than individually. Affects submission workflow and grade distribution.',
    `is_omit_from_final_grade` BOOLEAN COMMENT 'Indicates whether this assignment should be excluded from final grade calculations. Used for practice assignments, extra credit, or formative assessments.',
    `is_only_visible_to_overrides` BOOLEAN COMMENT 'Indicates whether the assignment is visible only to students with specific assignment overrides (differentiated due dates or access). Supports accommodations and differentiated instruction.',
    `is_peer_review_enabled` BOOLEAN COMMENT 'Indicates whether students will evaluate and provide feedback on each others submissions. Supports collaborative learning and critical thinking development.',
    `is_published` BOOLEAN COMMENT 'Indicates whether the assignment is currently visible and accessible to students. Unpublished assignments are visible only to instructors.',
    `is_rubric_for_grading` BOOLEAN COMMENT 'Indicates whether the rubric is used to calculate the assignment grade or is informational only. When true, rubric scores determine the final grade.',
    `lock_date` TIMESTAMP COMMENT 'The date and time after which students can no longer submit the assignment. Enforces hard deadlines and prevents late submissions beyond instructor policy.',
    `moderated_grading_enabled` BOOLEAN COMMENT 'Indicates whether multiple graders will independently assess submissions with a moderator reconciling scores. Used for high-stakes assessments and inter-rater reliability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the assignment record was last updated. Tracks changes to assignment settings, dates, or content.',
    `peer_review_count` STRING COMMENT 'Number of peer submissions each student must review. Null if peer review is not enabled. Ensures balanced participation in peer assessment.',
    `peer_review_due_date` TIMESTAMP COMMENT 'The date and time by which students must complete their peer reviews. Typically set after the assignment submission due date.',
    `points_possible` DECIMAL(18,2) COMMENT 'Maximum number of points a student can earn on this assignment. Used for grading scale calculation and weighted grade computation in the gradebook.',
    `position` STRING COMMENT 'Ordinal position of this assignment within its assignment group or course module. Controls display order in the gradebook and course navigation.',
    `submission_type` STRING COMMENT 'The mechanism by which students will submit their completed work. Determines workflow, file handling, and integration requirements with external tools. [ENUM-REF-CANDIDATE: online_upload|online_text_entry|online_url|on_paper|external_tool|media_recording|student_annotation|none — 8 candidates stripped; promote to reference product]',
    `turnitin_enabled` BOOLEAN COMMENT 'Indicates whether submissions will be checked for plagiarism using Turnitin or similar originality detection service. Supports academic integrity enforcement.',
    `vericite_enabled` BOOLEAN COMMENT 'Indicates whether submissions will be checked for plagiarism using VeriCite originality detection service. Alternative to Turnitin for academic integrity.',
    CONSTRAINT pk_assignment PRIMARY KEY(`assignment_id`)
) COMMENT 'Academic assignment or assessment task created within a course section, capturing assignment name, type (homework, quiz, exam, project, discussion, lab report, presentation), due date, available date, lock date, points possible, grading type (points, percentage, letter grade, pass/fail, not graded), submission type (online, on-paper, external tool), allowed attempts, group assignment flag, peer review flag, and Canvas assignment ID. Represents the instructional assessment unit within a course shell.';

CREATE OR REPLACE TABLE `education_ecm`.`instruction`.`submission` (
    `submission_id` BIGINT COMMENT 'Unique identifier for the student submission record. Primary key for the submission entity.',
    `assignment_id` BIGINT COMMENT 'Reference to the assignment for which this submission was made. Links to the assignment entity in the instruction domain.',
    `course_section_id` BIGINT COMMENT 'Reference to the course section in which this submission was made. Links to the course section entity in the instruction domain.',
    `instructor_id` BIGINT COMMENT 'Reference to the faculty member or teaching assistant who graded this submission. Links to the faculty entity in the faculty domain.',
    `profile_id` BIGINT COMMENT 'Reference to the student who made this submission. Links to the student entity in the student domain.',
    `anonymous_ref` STRING COMMENT 'An anonymized identifier used for anonymous grading. Masks the student identity during the grading process to reduce bias.',
    `attempt_number` STRING COMMENT 'The sequential attempt number for this submission. Indicates which attempt this represents if multiple submissions are allowed for the assignment.',
    `body` STRING COMMENT 'The text content of the submission for online text entry submissions. Contains the students written response or essay.',
    `cached_due_date` TIMESTAMP COMMENT 'The due date for the assignment at the time of submission, cached for historical accuracy. Accounts for differentiated due dates and extensions.',
    `canvas_submission_ref` STRING COMMENT 'External identifier from the Canvas Learning Management System (LMS) for this submission. Used for integration and reconciliation with the source system.',
    `comments_count` STRING COMMENT 'The number of comments associated with this submission. Used for engagement analytics and feedback tracking.',
    `created_at` TIMESTAMP COMMENT 'The date and time when the submission record was first created in the system. Represents the initial capture of the submission entity.',
    `entered_grade` STRING COMMENT 'The grade as originally entered by the instructor before any late penalties or adjustments were applied.',
    `entered_score` DECIMAL(18,2) COMMENT 'The numeric score as originally entered by the instructor before any late penalties or adjustments were applied.',
    `extra_attempts` STRING COMMENT 'The number of additional attempts granted to the student beyond the standard allowed attempts for the assignment. Used for accommodations and special circumstances.',
    `grade` STRING COMMENT 'The grade assigned to this submission by the instructor. May be a letter grade, percentage, points, or pass/fail depending on the grading scheme.',
    `graded_at` TIMESTAMP COMMENT 'The date and time when the submission was graded by the instructor. Represents a distinct lifecycle event in the submission workflow.',
    `grading_period_ref` BIGINT COMMENT 'Reference to the grading period during which this submission was made. Used for term-based grade calculations and academic reporting.',
    `group_ref` BIGINT COMMENT 'Reference to the student group if this is a group assignment submission. Links to the group entity in the instruction domain.',
    `history_count` STRING COMMENT 'The total number of submission versions in the history for this assignment. Tracks the number of times the student has submitted or resubmitted work.',
    `is_anonymous_grading` BOOLEAN COMMENT 'Boolean flag indicating whether this submission is being graded anonymously. When true, the grader does not see the students identity.',
    `is_excused` BOOLEAN COMMENT 'Boolean flag indicating whether the submission has been excused by the instructor. Excused submissions are not counted against the student in grade calculations.',
    `is_late` BOOLEAN COMMENT 'Boolean flag indicating whether the submission was submitted after the assignment due date. Used for late policy enforcement and academic analytics.',
    `is_missing` BOOLEAN COMMENT 'Boolean flag indicating whether the submission is missing (not submitted by the student). Used for DFW (D-grade, F-grade, Withdrawal) early warning analytics and student success interventions.',
    `last_activity_at` TIMESTAMP COMMENT 'The date and time of the last student activity related to this submission. Used for engagement tracking and Title IV last-date-of-attendance determination for financial aid compliance.',
    `late_policy_status` STRING COMMENT 'The status of the submission with respect to the late policy. Indicates whether no late policy applies, the submission is late, the submission is missing, or the student has been granted an extension.. Valid values are `none|late|missing|extended`',
    `originality_score` DECIMAL(18,2) COMMENT 'The originality or similarity score from plagiarism detection tools, expressed as a percentage. Used for academic integrity review and flagging potential violations.',
    `points_deducted` DECIMAL(18,2) COMMENT 'The number of points deducted from the submission score due to late submission penalties. Used in conjunction with late policy enforcement.',
    `posted_at` TIMESTAMP COMMENT 'The date and time when the grade was posted and made visible to the student. Represents the point at which the student can view their grade.',
    `preview_url` STRING COMMENT 'The URL for previewing the submission content within the Canvas LMS interface. Used for inline viewing of submission materials.',
    `redo_request` BOOLEAN COMMENT 'Boolean flag indicating whether the instructor has requested that the student redo or resubmit the assignment. Used for feedback loops and iterative learning.',
    `rubric_assessment_ref` BIGINT COMMENT 'Reference to the rubric assessment used to grade this submission. Links to the rubric assessment entity for detailed criterion-based grading.',
    `score` DECIMAL(18,2) COMMENT 'The numeric score assigned to this submission. Represents the points earned by the student on this assignment.',
    `seconds_late` BIGINT COMMENT 'The number of seconds the submission was late, calculated as the difference between the submission timestamp and the assignment due date. Used for late penalty calculations and policy enforcement.',
    `submission_type` STRING COMMENT 'The method by which the student submitted their work. Indicates whether the submission was a text entry, file upload, URL link, media recording, annotation, or external tool submission. [ENUM-REF-CANDIDATE: online_text_entry|online_url|online_upload|media_recording|student_annotation|basic_lti_launch|none — 7 candidates stripped; promote to reference product]',
    `submitted_at` TIMESTAMP COMMENT 'The date and time when the student submitted their work. This is the principal business event timestamp for the submission transaction. Critical for late policy enforcement and Title IV last-date-of-attendance determination for financial aid purposes.',
    `turnitin_data` STRING COMMENT 'JSON or structured data containing plagiarism detection results from Turnitin or similar academic integrity tools. Supports academic integrity monitoring and policy enforcement.',
    `updated_at` TIMESTAMP COMMENT 'The date and time when the submission record was last modified. Used for audit trails and change tracking.',
    `url` STRING COMMENT 'The URL submitted by the student for online URL submissions. Contains the web link to external content submitted as part of the assignment.',
    `workflow_state` STRING COMMENT 'Current state of the submission in the grading workflow. Indicates whether the submission has been submitted, is awaiting grading, has been graded, or is pending review.. Valid values are `submitted|unsubmitted|graded|pending_review`',
    CONSTRAINT pk_submission PRIMARY KEY(`submission_id`)
) COMMENT 'Student submission record for an assignment, capturing submission timestamp, submission type (file upload, text entry, URL, media recording, annotation), attempt number, late flag, missing flag, excused flag, workflow state, and Canvas submission ID. Represents the transactional event of a student submitting work for evaluation. Supports late policy enforcement, academic integrity monitoring, DFW early warning analytics, and Title IV last-date-of-attendance determination for financial aid purposes.';

CREATE OR REPLACE TABLE `education_ecm`.`instruction`.`grade_entry` (
    `grade_entry_id` BIGINT COMMENT 'Unique identifier for the grade entry record. Primary key for the grade entry entity.',
    `assignment_id` BIGINT COMMENT 'Identifier of the specific assignment or assessment for which this grade was awarded. Links to the assignment definition.',
    `course_section_id` BIGINT COMMENT 'Identifier of the course section in which this grade was awarded. Links to the course section offering.',
    `instructor_id` BIGINT COMMENT 'Identifier of the faculty member, teaching assistant, or automated system that assigned this grade. Links to the faculty or system user record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Links grade modifications to specific employees for registrar audit trails, grade appeal investigations, and FERPA compliance. Current modified_by is text; need FK to employee for accountability. Role',
    `profile_id` BIGINT COMMENT 'Identifier of the student who received this grade. Links to the student master record.',
    `rubric_id` BIGINT COMMENT 'Identifier of the rubric used to grade this assignment. Links to the rubric definition with criteria and scoring levels.',
    `slo_id` BIGINT COMMENT 'Foreign key linking to curriculum.slo. Business justification: Outcomes-based assessment reporting requires linking individual grade entries to SLOs. grade_entry.slo_alignment is a denormalized text field; replacing it with a proper FK enables aggregated SLO perf',
    `submission_id` BIGINT COMMENT 'Foreign key linking to instruction.instruction_submission. Business justification: A grade_entry records the score awarded for a specific student submission. Linking grade_entry.instruction_submission_id → instruction_submission.instruction_submission_id establishes the direct trace',
    `academic_year` STRING COMMENT 'Academic year during which this grade was awarded (e.g., 2023-2024). Used for longitudinal analysis and annual reporting.',
    `attempt_number` STRING COMMENT 'Sequential number indicating which attempt this grade represents if multiple submissions are allowed. First submission is attempt 1.',
    `canvas_grade_object_ref` STRING COMMENT 'External identifier from Canvas LMS for this grade entry. Used for synchronization and reconciliation with the source LMS system.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this grade entry record was first created in the system. Used for audit trail and data lineage.',
    `due_date` TIMESTAMP COMMENT 'Date and time when the assignment was originally due. Used to calculate late submissions and apply late penalties.',
    `extra_credit_flag` BOOLEAN COMMENT 'Flag indicating whether this assignment is designated as extra credit. Extra credit assignments may be treated differently in grade calculation.',
    `grade_appeal_status` STRING COMMENT 'Status of any grade appeal filed by the student for this assignment. Tracks the lifecycle of grade dispute resolution.. Valid values are `no_appeal|appeal_pending|appeal_approved|appeal_denied`',
    `grade_entry_source` STRING COMMENT 'System or method through which this grade was entered. Indicates whether the grade originated from Canvas LMS, Banner SIS, manual entry, SCORM content, or external integration.. Valid values are `canvas_lms|banner_sis|manual_entry|scorm_package|external_tool|api_integration`',
    `grade_letter` STRING COMMENT 'Letter grade assigned to the student for this assignment (e.g., A, B+, C-, F). May include pass/fail, withdrawal, incomplete, or audit designations.. Valid values are `A+|A|A-|B+|B|B-|C+|C|C-|D+|D|D-|F|P|NP|W|I|IP|AU|S|U|NG`',
    `grade_override_flag` BOOLEAN COMMENT 'Flag indicating whether this grade was manually overridden by an instructor or administrator. True if the grade differs from the calculated or original grade.',
    `grade_percentage` DECIMAL(18,2) COMMENT 'Percentage grade calculated from the score and maximum score. Represents the students performance as a percentage (0.00 to 100.00).',
    `graded_timestamp` TIMESTAMP COMMENT 'Date and time when the grade was assigned or last modified by the grader. Represents the authoritative grading event timestamp.',
    `grader_comments` STRING COMMENT 'Textual feedback provided by the grader to the student. Contains qualitative assessment, suggestions for improvement, and explanations of the grade.',
    `grading_status` STRING COMMENT 'Current status of the grading process for this assignment submission. Indicates whether the grade is final, pending review, or not yet assigned.. Valid values are `not_graded|graded|pending_review|excused|missing|late`',
    `is_excused` BOOLEAN COMMENT 'Flag indicating whether the student was excused from this assignment. Excused assignments do not count toward the final grade calculation.',
    `is_final_attempt` BOOLEAN COMMENT 'Flag indicating whether this is the final graded attempt for the assignment. True if no further submissions are allowed or if this is the last attempt used for grade calculation.',
    `is_late` BOOLEAN COMMENT 'Flag indicating whether the assignment was submitted after the due date. True if submission timestamp exceeds due date.',
    `is_missing` BOOLEAN COMMENT 'Flag indicating whether the student failed to submit the assignment. Missing assignments may receive a zero or be excluded from grade calculation based on policy.',
    `late_penalty_applied` DECIMAL(18,2) COMMENT 'Point deduction applied to the score due to late submission. Represents the numeric penalty subtracted from the raw score.',
    `max_score` DECIMAL(18,2) COMMENT 'Maximum possible score for this assignment. Used to calculate percentage and relative performance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this grade entry record was last modified. Used for audit trail and change tracking.',
    `override_reason` STRING COMMENT 'Explanation for why the grade was overridden. Provides audit trail and justification for manual grade adjustments.',
    `plo_alignment` STRING COMMENT 'Mapping of this grade entry to specific Program Learning Outcomes (PLOs) assessed by this assignment. Used for program-level assessment and accreditation reporting.',
    `posted_timestamp` TIMESTAMP COMMENT 'Date and time when the grade was released to the student. Null if the grade has not yet been posted.',
    `posted_to_student` BOOLEAN COMMENT 'Flag indicating whether the grade has been released and is visible to the student. False if the grade is being held for batch release or pending review.',
    `rubric_score_breakdown` STRING COMMENT 'Detailed breakdown of scores by rubric criteria. Stored as a structured text representation (e.g., JSON or delimited format) showing points earned for each rubric dimension.',
    `score` DECIMAL(18,2) COMMENT 'Numeric score awarded to the student for this assignment. Represents the raw points earned before any scaling or weighting.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the student submitted the assignment. Used to determine late penalties and compliance with due dates.',
    `term_code` STRING COMMENT 'Academic term code during which this grade was awarded. Used for temporal analysis and reporting by semester or quarter.',
    `weight_in_final_grade` DECIMAL(18,2) COMMENT 'Percentage weight of this assignment in the final course grade calculation. Represents the contribution of this grade to the overall course grade (0.00 to 100.00).',
    CONSTRAINT pk_grade_entry PRIMARY KEY(`grade_entry_id`)
) COMMENT 'Gradebook entry recording the score or grade awarded to a student for a specific assignment or assessment, capturing score, grade (letter or percentage), graded timestamp, grader identifier, grading status (not_graded, graded, pending_review), rubric score breakdown, late penalty applied, and Canvas grade object ID. Represents the authoritative transactional record of academic performance at the assignment level. Feeds into final grade calculation and SLO assessment.';

CREATE OR REPLACE TABLE `education_ecm`.`instruction`.`final_grade` (
    `final_grade_id` BIGINT COMMENT 'Unique identifier for the final grade record. Primary key for this entity.',
    `course_section_id` BIGINT COMMENT 'Unique identifier for the specific course section in which this grade was awarded. Links to the course section master record.',
    `instructor_id` BIGINT COMMENT 'Unique identifier for the primary instructor of record who assigned this final grade. Links to the faculty master record.',
    `lms_course_shell_id` BIGINT COMMENT 'Unique identifier for the corresponding course shell in the Canvas Learning Management System. Used to link Banner grades with LMS gradebook and analytics.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: IPEDS graduation and completion reporting, academic standing calculations, and transcript production all require final grades to be attributed to the owning academic org unit (department). Registrar a',
    `profile_id` BIGINT COMMENT 'Unique identifier for the student who received this final grade. Links to the student master record.',
    `registration_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_registration. Business justification: Transcript posting, grade change workflows, and FERPA compliance require linking a posted final grade to the specific enrollment registration that generated it. A higher-ed registrar expects final_gra',
    `student_term_record_id` BIGINT COMMENT 'Foreign key linking to enrollment.student_term_record. Business justification: Term GPA calculation, academic standing determination, and SAP evaluation require rolling up all final grades into the student_term_record. A registrar or financial aid officer expects final_grade to ',
    `academic_standing_impact` STRING COMMENT 'Impact of this grade on the students academic standing for the term. Values include good standing, probation, suspension, dismissal, deans list, honors, or no impact. [ENUM-REF-CANDIDATE: good_standing|probation|suspension|dismissal|deans_list|honors|no_impact — 7 candidates stripped; promote to reference product]',
    `course_number` STRING COMMENT 'Three or four digit numeric code identifying the specific course within a subject, optionally followed by a letter suffix (e.g., 101, 2050, 301A).. Valid values are `^[0-9]{3,4}[A-Z]?$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this final grade record was first created in the system. Part of standard audit trail.',
    `credit_hours_attempted` DECIMAL(18,2) COMMENT 'Number of credit hours the student attempted for this course. Used in GPA calculation and academic progress tracking.',
    `credit_hours_earned` DECIMAL(18,2) COMMENT 'Number of credit hours the student successfully earned for this course. Zero for failing grades, withdrawals, or incomplete grades.',
    `crn` STRING COMMENT 'Five-digit Course Reference Number uniquely identifying the course section within a term. Banner-specific identifier.. Valid values are `^[0-9]{5}$`',
    `degree_applicable_flag` BOOLEAN COMMENT 'Boolean indicator whether this course and grade apply toward degree requirements. False for developmental courses, audit enrollments, or courses taken for personal enrichment.',
    `ferpa_protected_flag` BOOLEAN COMMENT 'Boolean indicator whether this grade record is subject to enhanced FERPA privacy protection due to student directory information suppression request or other privacy hold.',
    `grade_change_date` DATE COMMENT 'Date on which the grade was changed from its original value. Null if no grade change has occurred.',
    `grade_change_flag` BOOLEAN COMMENT 'Boolean indicator whether this grade has been changed after initial posting. True if the grade was modified from its original value.',
    `grade_change_reason_code` STRING COMMENT 'Standardized code indicating the reason for a grade change. Required when grade_change_flag is true. Values include calculation error, incomplete resolved, grade appeal, administrative correction, instructor error, or data entry error.. Valid values are `calculation_error|incomplete_resolved|grade_appeal|administrative_correction|instructor_error|data_entry_error`',
    `grade_mode` STRING COMMENT 'Grading mode under which the student enrolled in the course. Standard uses letter grades A-F; pass/fail uses P/NP; audit uses AU; honors may use H suffix; satisfactory/unsatisfactory uses S/U.. Valid values are `standard|pass_fail|audit|honors|satisfactory_unsatisfactory`',
    `grade_point_value` DECIMAL(18,2) COMMENT 'Grade point value assigned to the letter grade on a 4.0 scale (e.g., A=4.0, B=3.0, C=2.0, D=1.0, F=0.0). Null for non-graded modes.',
    `grade_posted_date` DATE COMMENT 'Date on which the final grade was officially posted to the students academic record by the instructor or registrar.',
    `grade_posting_status` STRING COMMENT 'Current status of the grade in the Banner grade posting workflow. Not posted indicates grade not yet submitted; posted indicates grade submitted by instructor; verified indicates grade reviewed by registrar; locked indicates grade finalized and cannot be changed without special approval; pending approval indicates grade change awaiting authorization.. Valid values are `not_posted|posted|verified|locked|pending_approval`',
    `grade_source_system` STRING COMMENT 'System or process from which this final grade originated. Values include Banner (direct entry), Canvas LMS (imported from learning management system), manual entry, transfer evaluation, or prior learning assessment.. Valid values are `banner|canvas_lms|manual_entry|transfer_evaluation|prior_learning_assessment`',
    `grade_submission_method` STRING COMMENT 'Method by which the instructor submitted the final grade. Values include web entry (Banner self-service), LMS import (Canvas gradebook sync), batch upload (spreadsheet), API integration, or scantron (optical scan form).. Valid values are `web_entry|lms_import|batch_upload|api_integration|scantron`',
    `grade_verified_date` DATE COMMENT 'Date on which the grade was verified and approved by the registrars office as part of the grade finalization process.',
    `incomplete_deadline_date` DATE COMMENT 'Date by which the student must complete outstanding coursework to resolve an incomplete grade. After this date, the incomplete typically converts to a failing grade per institutional policy.',
    `incomplete_extension_granted_flag` BOOLEAN COMMENT 'Boolean indicator whether an extension beyond the standard incomplete deadline has been granted by the instructor or academic dean.',
    `incomplete_flag` BOOLEAN COMMENT 'Boolean indicator whether this grade is an incomplete (I grade). True if the student has not completed all course requirements and has been granted an extension.',
    `last_attendance_date` DATE COMMENT 'Last date the student attended or participated in an academically-related activity for this course. Required for Title IV financial aid return calculations and academic engagement tracking.',
    `letter_grade` STRING COMMENT 'Official letter grade awarded to the student. Standard values include A through F with plus/minus modifiers, P (Pass), NP (No Pass), W (Withdrawal), I (Incomplete), IP (In Progress), AU (Audit), S (Satisfactory), U (Unsatisfactory), NG (No Grade Submitted).. Valid values are `A|A-|B+|B|B-|C+|C|C-|D+|D|D-|F|P|NP|W|I|IP|AU|S|U|NG`',
    `numeric_grade` DECIMAL(18,2) COMMENT 'Numeric representation of the final grade on a 0-100 scale. May be null for pass/fail, audit, or incomplete grades.',
    `original_letter_grade` STRING COMMENT 'The original letter grade that was posted before any grade change occurred. Null if no grade change has occurred. Retained for audit trail purposes.',
    `quality_points` DECIMAL(18,2) COMMENT 'Total quality points earned for this course, calculated as grade point value multiplied by credit hours attempted. Used in GPA (Grade Point Average) calculation.',
    `repeat_course_flag` BOOLEAN COMMENT 'Boolean indicator whether this course enrollment is a repeat of a previously taken course. Used in repeat course policy enforcement and GPA calculation.',
    `repeat_course_include_flag` BOOLEAN COMMENT 'Boolean indicator whether this repeated course grade should be included in GPA calculation. Depends on institutional repeat course policy (e.g., replace previous grade, average grades, or include both).',
    `sap_eligible_flag` BOOLEAN COMMENT 'Boolean indicator whether this course grade counts toward Satisfactory Academic Progress evaluation for federal financial aid eligibility. Some grades (e.g., audit, withdrawn after census) do not count.',
    `section_number` STRING COMMENT 'Two or three character alphanumeric code identifying the specific section of a course (e.g., 01, 02, A1, W01 for web sections).. Valid values are `^[0-9A-Z]{2,3}$`',
    `subject_code` STRING COMMENT 'Two to four character alphabetic code representing the academic subject or discipline (e.g., MATH, ENGL, BIOL, CS).. Valid values are `^[A-Z]{2,4}$`',
    `term_code` STRING COMMENT 'Six-digit code identifying the academic term in which the grade was awarded (e.g., 202401 for Spring 2024). Format: YYYYTT where TT is term sequence.. Valid values are `^[0-9]{6}$`',
    `transfer_credit_flag` BOOLEAN COMMENT 'Boolean indicator whether this grade represents transfer credit accepted from another institution. Transfer grades typically do not calculate into institutional GPA.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this final grade record was last modified. Updated whenever any field in the record changes. Part of standard audit trail.',
    `withdrawal_date` DATE COMMENT 'Date on which the student officially withdrew from the course. Populated only when letter_grade is W (Withdrawal).',
    CONSTRAINT pk_final_grade PRIMARY KEY(`final_grade_id`)
) COMMENT 'Official final grade awarded to a student for a course section at the end of a term, capturing letter grade, numeric grade, quality points, credit hours attempted, credit hours earned, grade mode (standard, pass/fail, audit, incomplete), incomplete deadline date, grade change flag, grade change reason, Banner grade posting status, and FERPA-protected access flag. This is the authoritative academic record grade that feeds GPA calculation and academic standing. Sourced from Banner SHRTCKN.';

CREATE OR REPLACE TABLE `education_ecm`.`instruction`.`attendance_record` (
    `attendance_record_id` BIGINT COMMENT 'Unique identifier for the attendance record. Primary key for the attendance tracking system.',
    `course_section_id` BIGINT COMMENT 'Identifier of the course section for which attendance is being recorded. Links to the course section master record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user (faculty, staff, or system) who last modified the attendance record. Links to the user master record. Used for audit trail and accountability.',
    `instructor_id` BIGINT COMMENT 'Identifier of the faculty member or instructor who recorded the attendance. Links to the faculty master record.',
    `profile_id` BIGINT COMMENT 'Identifier of the student whose attendance is being recorded. Links to the student master record.',
    `registration_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_registration. Business justification: Title IV last-date-of-attendance reporting and R2T4 financial aid return calculations require linking each attendance record to the specific enrollment registration. Early alert systems and attendance',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Title IV federal regulations mandate last-date-of-attendance tracking for R2T4 calculations. attendance_record already has title_iv_eligible_flag and last_date_of_attendance_flag. Linking to the gover',
    `room_id` BIGINT COMMENT 'Identifier of the physical room or virtual space where the class meeting occurred. Links to the facilities room master record. Used for space utilization analytics and attendance verification.',
    `section_meeting_id` BIGINT COMMENT 'Identifier of the specific class meeting or session for which attendance is recorded. Links to the scheduled meeting instance.',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Title IV Return of Funds (R2T4) regulatory process requires linking a students last-date-of-attendance record directly to their billing account. The attendance_record.title_iv_eligible_flag and last_',
    `term_id` BIGINT COMMENT 'Identifier of the academic term in which the attendance was recorded. Links to the term master record. Used for term-level attendance reporting and SAP evaluation.',
    `academic_activity_type` STRING COMMENT 'The type of academic activity for which attendance is being recorded. Values: lecture, lab, discussion, exam, quiz, presentation, field_trip, online_activity, hybrid. Used to differentiate attendance requirements across different instructional modalities. [ENUM-REF-CANDIDATE: lecture|lab|discussion|exam|quiz|presentation|field_trip|online_activity|hybrid — 9 candidates stripped; promote to reference product]',
    `attendance_date` DATE COMMENT 'The calendar date on which the class meeting occurred and attendance was taken. Used for Title IV last-date-of-attendance determination and Return of Title IV Funds (R2T4) calculations.',
    `attendance_percentage_to_date` DECIMAL(18,2) COMMENT 'The cumulative attendance percentage for the student in this course section as of this record. Calculated as (total minutes present / total scheduled minutes) * 100. Used for early alert thresholds and SAP monitoring.',
    `attendance_policy_violation` BOOLEAN COMMENT 'Indicates whether this attendance record represents a violation of the institutional or course-specific attendance policy (e.g., exceeded maximum allowed absences). True if violation occurred, False otherwise.',
    `attendance_status` STRING COMMENT 'The attendance status of the student for this meeting. Values: present (student attended), absent (student did not attend), tardy (student arrived late), excused (absence approved by instructor or policy), late_excused (tardy with excuse), early_departure (left before end). Required for Satisfactory Academic Progress (SAP) compliance and Title IV attendance verification.. Valid values are `present|absent|tardy|excused|late_excused|early_departure`',
    `comments` STRING COMMENT 'Additional free-text comments or annotations related to the attendance record. May include administrative notes, student explanations, or system-generated messages.',
    `consecutive_absences_count` STRING COMMENT 'The number of consecutive class meetings the student has been absent as of this record. Used to trigger early alert interventions and administrative withdrawal processes.',
    `early_alert_timestamp` TIMESTAMP COMMENT 'The date and time when an early alert was triggered based on this attendance record. Used for tracking intervention timeliness and student success analytics.',
    `early_alert_triggered` BOOLEAN COMMENT 'Indicates whether this attendance record triggered an early alert intervention flag based on institutional thresholds (e.g., three consecutive absences, cumulative absence percentage). True if alert was triggered, False otherwise.',
    `excuse_documentation_provided` BOOLEAN COMMENT 'Indicates whether the student provided supporting documentation for an excused absence (e.g., medical note, court summons, travel itinerary). True if documentation was provided, False otherwise.',
    `excuse_reason` STRING COMMENT 'The documented reason for an excused absence or tardy, such as illness, family emergency, university-sanctioned activity, religious observance, or military duty. Required for compliance with institutional attendance policies and NCAA eligibility tracking.',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'The latitude coordinate of the students location at the time of attendance check-in via mobile app or card swipe. Used for location-based attendance verification.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'The longitude coordinate of the students location at the time of attendance check-in via mobile app or card swipe. Used for location-based attendance verification.',
    `instructor_notes` STRING COMMENT 'Free-text notes entered by the instructor regarding the attendance record. May include reasons for absence, behavioral observations, or other contextual information relevant to early alert intervention.',
    `ip_address` STRING COMMENT 'The IP address from which the student accessed the LMS or checked in via mobile app. Used for location verification and fraud detection in online attendance tracking.',
    `last_date_of_attendance_flag` BOOLEAN COMMENT 'Indicates whether this record represents the last documented date of attendance for the student in this course section. True if this is the last attendance, False otherwise. Critical for Return of Title IV Funds (R2T4) calculations when a student withdraws.',
    `lms_activity_indicator` BOOLEAN COMMENT 'Indicates whether the attendance record was derived from or corroborated by student activity in the Canvas LMS (e.g., assignment submission, discussion post, quiz attempt). True if LMS activity was detected, False otherwise.',
    `lms_activity_timestamp` TIMESTAMP COMMENT 'The date and time of the most recent LMS activity that contributed to this attendance record. Used for online and hybrid course attendance verification.',
    `minutes_absent` STRING COMMENT 'The number of minutes the student was absent during the class meeting. Used for calculating total absence time for SAP and early alert triggers.',
    `minutes_present` STRING COMMENT 'The number of minutes the student was present during the class meeting. Used for partial attendance tracking and FTE (Full-Time Equivalent) verification for state funding.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the attendance record was last modified. Used for audit trail and data quality monitoring.',
    `recorded_timestamp` TIMESTAMP COMMENT 'The date and time when the attendance record was captured in the system. Used for audit trail and to determine timeliness of attendance reporting for Title IV compliance.',
    `recording_method` STRING COMMENT 'The method by which attendance was captured. Values: manual (instructor manually recorded), lms_activity (derived from LMS activity in Canvas), clicker (student response system), card_swipe (physical card reader), biometric (fingerprint or facial recognition), mobile_app (student check-in via mobile application).. Valid values are `manual|lms_activity|clicker|card_swipe|biometric|mobile_app`',
    `source_system` STRING COMMENT 'The system of record from which the attendance data originated. Values: banner (Ellucian Banner SIS), canvas (Canvas LMS), slate (Slate CRM), manual (instructor entry), mobile_app (student check-in app), card_reader (physical access system), clicker (student response system). [ENUM-REF-CANDIDATE: banner|canvas|slate|manual|mobile_app|card_reader|clicker — 7 candidates stripped; promote to reference product]',
    `source_system_record_ref` STRING COMMENT 'The unique identifier of this attendance record in the source system. Used for data lineage and reconciliation between systems.',
    `title_iv_eligible_flag` BOOLEAN COMMENT 'Indicates whether the student is receiving Title IV federal financial aid for this course section, making attendance tracking mandatory for compliance. True if Title IV eligible, False otherwise.',
    `total_absences_count` STRING COMMENT 'The total number of absences (excused and unexcused) the student has accumulated in this course section as of this record. Used for attendance policy enforcement and grade impact calculations.',
    `verification_status` STRING COMMENT 'The verification status of the attendance record. Values: unverified (not yet reviewed), verified (confirmed accurate by instructor), disputed (student contested the record), corrected (record was amended after review). Used for data quality assurance and FERPA compliance.. Valid values are `unverified|verified|disputed|corrected`',
    `verification_timestamp` TIMESTAMP COMMENT 'The date and time when the attendance record was verified or corrected. Used for audit trail and compliance reporting.',
    CONSTRAINT pk_attendance_record PRIMARY KEY(`attendance_record_id`)
) COMMENT 'Attendance tracking record for a student in a course section meeting, capturing attendance status (present, absent, tardy, excused), recorded timestamp, recording method (manual, LMS activity, clicker, card swipe), and instructor notes. Required for Title IV financial aid attendance verification, Satisfactory Academic Progress (SAP) compliance, last-date-of-attendance determination for Return of Title IV Funds (R2T4) calculations, early alert intervention triggers, and state funding FTE verification.';

CREATE OR REPLACE TABLE `education_ecm`.`instruction`.`rubric` (
    `rubric_id` BIGINT COMMENT 'Unique identifier for the grading rubric. Primary key.',
    `course_id` BIGINT COMMENT 'Identifier of the course in which this rubric was originally created or is primarily used. Links the rubric to its originating academic context.',
    `employee_id` BIGINT COMMENT 'Identifier of the faculty member or administrator who originally created this rubric. Used for attribution and ownership tracking.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Accreditation bodies require rubrics to be owned and governed at the program/department level. Curriculum committees and accreditation coordinators need to identify which org unit created and maintain',
    `plo_id` BIGINT COMMENT 'Foreign key linking to curriculum.plo. Business justification: Accreditation bodies (HLC, SACSCOC, AACSB) require direct evidence that rubrics assess program-level outcomes (PLOs). Rubric already links to SLO; PLO-level rubric alignment is a distinct accreditatio',
    `slo_id` BIGINT COMMENT 'Foreign key linking to curriculum.slo. Business justification: Rubric criteria operationalize SLO assessment by defining performance levels. This link supports outcomes assessment workflows, accreditation reporting (mapping rubric rows to SLO statements), and clo',
    `alignment_outcome_group_ref` BIGINT COMMENT 'Identifier of the outcome group (collection of Student Learning Outcomes or Program Learning Outcomes) that this rubric is aligned to. Used for outcomes-based assessment and accreditation reporting.',
    `archived_at` TIMESTAMP COMMENT 'The date and time when this rubric was archived or retired from active use. Null if the rubric is still active.',
    `assessment_count` STRING COMMENT 'The total number of times this rubric has been used to assess student work. Indicates the rubrics usage frequency and adoption.',
    `canvas_rubric_ref` STRING COMMENT 'External identifier for the rubric in the Canvas Learning Management System (LMS). Used for integration and synchronization with the source system.',
    `context_code` STRING COMMENT 'A composite code identifying the specific context instance (e.g., course code, account code) where this rubric is defined. Used for cross-referencing and reporting.',
    `context_type` STRING COMMENT 'The organizational context in which this rubric is defined. Course indicates the rubric is specific to a single course, Account indicates it is shared at the department or college level, and Program indicates it is used across an academic program.. Valid values are `Course|Account|Program`',
    `created_at` TIMESTAMP COMMENT 'The date and time when this rubric was first created in the system. Supports audit trail and lifecycle tracking.',
    `criteria_count` STRING COMMENT 'The total number of criteria (rows) defined in this rubric. Each criterion represents a distinct dimension of performance being evaluated.',
    `free_form_criterion_comments` BOOLEAN COMMENT 'Indicates whether instructors can add free-form text comments to individual rubric criteria when grading. True enables qualitative feedback alongside quantitative scores.',
    `hide_points` BOOLEAN COMMENT 'Indicates whether individual criterion point values are hidden from students. True hides point values for each performance level, focusing student attention on qualitative descriptors rather than numeric scores.',
    `hide_score_total` BOOLEAN COMMENT 'Indicates whether the total score is hidden from students when viewing rubric feedback. True hides the numeric total, emphasizing qualitative feedback over quantitative scores. Used for formative assessment and developmental feedback.',
    `lms_account_ref` BIGINT COMMENT 'Identifier of the institutional account (department, college, or institution-level) that owns or governs this rubric. Used for rubric sharing and governance at the organizational level.',
    `public` BOOLEAN COMMENT 'Indicates whether this rubric is publicly visible and shareable across the institution. True allows other faculty to discover and adopt the rubric for their own courses.',
    `published_at` TIMESTAMP COMMENT 'The date and time when this rubric was published and made available for use in grading. Null if the rubric is still in draft status.',
    `read_only` BOOLEAN COMMENT 'Indicates whether this rubric is locked from further editing. True prevents modifications to the rubric structure or criteria, ensuring consistency after grading has begun.',
    `reusable` BOOLEAN COMMENT 'Indicates whether this rubric is marked as reusable across multiple assignments, courses, or terms. True allows the rubric to be shared and applied to multiple assessment contexts, promoting consistency in grading standards.',
    `rubric_description` STRING COMMENT 'Detailed explanation of the rubrics purpose, scope, and intended use. May include instructions for faculty on how to apply the rubric to student work.',
    `rubric_status` STRING COMMENT 'Current lifecycle status of the rubric. Draft indicates the rubric is under development, active indicates it is published and available for use, archived indicates it is retired but retained for historical reference, and deleted indicates it has been soft-deleted.. Valid values are `draft|active|archived|deleted`',
    `rubric_type` STRING COMMENT 'Classification of the rubric scoring methodology. Points-based rubrics assign numeric scores, percentage-based rubrics use percentages, outcome-aligned rubrics map to Student Learning Outcomes (SLO) or Program Learning Outcomes (PLO), holistic rubrics provide a single overall score, analytic rubrics break down performance into multiple criteria, and checklist rubrics use binary yes/no indicators.. Valid values are `points|percentage|outcome_aligned|holistic|analytic|checklist`',
    `scoring_method` STRING COMMENT 'The method used to calculate and display scores from the rubric. Determines whether the rubric outputs numeric points, percentages, letter grades, or pass/fail indicators.. Valid values are `points|percentage|letter_grade|pass_fail`',
    `title` STRING COMMENT 'The name or title of the rubric as displayed to faculty and students. Provides a concise identifier for the rubrics purpose.',
    `total_points_possible` DECIMAL(18,2) COMMENT 'The maximum number of points that can be earned on this rubric. Calculated as the sum of maximum points across all criteria. Used for grade normalization and weighting.',
    `updated_at` TIMESTAMP COMMENT 'The date and time when this rubric was last modified. Supports change tracking and version control.',
    `use_range` BOOLEAN COMMENT 'Indicates whether this rubric uses point ranges for each performance level rather than fixed point values. True allows instructors to assign any value within a defined range for each criterion level.',
    `workflow_state` STRING COMMENT 'The current workflow state of the rubric in the Canvas LMS system. Tracks the rubric through its lifecycle from creation to deletion.. Valid values are `draft|active|deleted`',
    CONSTRAINT pk_rubric PRIMARY KEY(`rubric_id`)
) COMMENT 'Grading rubric defining the criteria and performance levels used to evaluate student work for an assignment or course. Captures rubric title, description, rubric type (points, percentage, outcome-aligned), free-form ratings flag, hide score total flag, reusable flag, and Canvas rubric ID. Each rubric contains multiple criteria rows with performance level descriptors and point values. Supports consistent, transparent grading and SLO/PLO assessment alignment.';

CREATE OR REPLACE TABLE `education_ecm`.`instruction`.`slo_assessment` (
    `slo_assessment_id` BIGINT COMMENT 'Unique identifier for the student learning outcome assessment record.',
    `accreditation_review_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_review. Business justification: SLO assessments are submitted as direct evidence artifacts during accreditation reviews (SACSCOC CS 8.2, HLC 4.B). Linking slo_assessment to the specific accreditation_review cycle for which the asses',
    `assignment_id` BIGINT COMMENT 'External identifier for the Canvas LMS assignment or activity associated with this SLO assessment.',
    `accreditation_standard_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_standard. Business justification: SLO assessment results provide direct evidence of compliance with accreditation standards. Programs map learning outcomes to specific standards and aggregate assessment data for self-studies, interim ',
    `course_section_id` BIGINT COMMENT 'Reference to the course section in which this SLO assessment was conducted.',
    `grade_entry_id` BIGINT COMMENT 'Foreign key linking to instruction.grade_entry. Business justification: An SLO assessment measures student learning outcome performance, and the evidence artifact for that assessment is typically a graded assignment submission captured in grade_entry. Linking slo_assessme',
    `map_id` BIGINT COMMENT 'Reference to the curriculum map entry linking this SLO to the course and program structure.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: SACSCOC, HLC, and discipline-specific accreditors require SLO assessment results aggregated and reported at the program/department (org unit) level. Accreditation coordinators and institutional effect',
    `plo_id` BIGINT COMMENT 'Reference to the program learning outcome to which this SLO maps, supporting program-level assessment rollup.',
    `instructor_id` BIGINT COMMENT 'Reference to the faculty member or evaluator who conducted the SLO assessment.',
    `profile_id` BIGINT COMMENT 'Reference to the student whose performance is being assessed. Null if this is a cohort-level assessment.',
    `rubric_id` BIGINT COMMENT 'Reference to the assessment rubric used to evaluate this SLO, if applicable.',
    `service_learning_placement_id` BIGINT COMMENT 'Foreign key linking to studentlife.service_learning_placement. Business justification: SLO assessments measure learning outcomes achieved through service placements. Accreditation bodies (AACSB, ABET) require evidence linking community engagement experiences to academic achievement for ',
    `slo_id` BIGINT COMMENT 'Reference to the specific student learning outcome being assessed.',
    `student_term_record_id` BIGINT COMMENT 'Foreign key linking to enrollment.student_term_record. Business justification: SACSCOC and HLC accreditation reporting require aggregating SLO assessment outcomes by student cohort and term. Linking slo_assessment to student_term_record enables direct cohort-level outcome analys',
    `accreditation_body` STRING COMMENT 'The accreditation agency for which this assessment data is being collected (e.g., HLC, SACSCOC, ABET, AACSB). [ENUM-REF-CANDIDATE: HLC|SACSCOC|MSCHE|NWCCU|NECHE|WSCUC|ABET|AACSB|ABA|LCME|other — 11 candidates stripped; promote to reference product]',
    `assessment_cycle` STRING COMMENT 'Academic year cycle for continuous improvement reporting (e.g., 2023-2024), used for accreditation reporting.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `assessment_date` DATE COMMENT 'The date on which the SLO assessment was conducted or the student performance was evaluated.',
    `assessment_method` STRING COMMENT 'The method or instrument used to assess the student learning outcome (e.g., exam, project, presentation, portfolio, rubric-based evaluation). [ENUM-REF-CANDIDATE: exam|project|presentation|portfolio|rubric|capstone|lab_practical|case_study|other — 9 candidates stripped; promote to reference product]',
    `assessment_notes` STRING COMMENT 'Free-text notes or comments from the assessor regarding the student performance, context, or assessment conditions.',
    `assessment_status` STRING COMMENT 'Current workflow status of the assessment record (draft, submitted, reviewed, approved, archived).. Valid values are `draft|submitted|reviewed|approved|archived`',
    `cohort_flag` BOOLEAN COMMENT 'Indicates whether this assessment record represents a cohort-level aggregate assessment (true) or an individual student assessment (false).',
    `cohort_size` STRING COMMENT 'Number of students included in the cohort assessment, if this is a cohort-level record. Null for individual assessments.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this SLO assessment record was first created in the system.',
    `evidence_artifact_reference` STRING COMMENT 'Reference identifier or URI to the evidence artifact supporting this assessment (e.g., document ID, LMS assignment link, portfolio entry).',
    `improvement_action_description` STRING COMMENT 'Description of the improvement action planned or taken in response to this assessment result.',
    `improvement_action_required` BOOLEAN COMMENT 'Indicates whether this assessment result triggered a need for curriculum or instructional improvement action.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this SLO assessment record was last modified.',
    `performance_level` STRING COMMENT 'The level of achievement demonstrated by the student or cohort against the SLO (exemplary, proficient, developing, unsatisfactory, not assessed).. Valid values are `exemplary|proficient|developing|unsatisfactory|not_assessed`',
    `proficiency_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to achieve proficiency level for this SLO assessment.',
    `reviewed_timestamp` TIMESTAMP COMMENT 'Date and time when the assessment record was reviewed and approved.',
    `score_maximum` DECIMAL(18,2) COMMENT 'Maximum possible score for the assessment, providing context for the numeric score.',
    `score_numeric` DECIMAL(18,2) COMMENT 'Numeric score achieved on the assessment, if applicable. Scale and interpretation depend on the assessment method.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the assessment record was submitted for review or finalized.',
    `term_code` STRING COMMENT 'Six-digit term code identifying the academic term in which the assessment occurred (e.g., 202401 for Spring 2024).. Valid values are `^[0-9]{6}$`',
    CONSTRAINT pk_slo_assessment PRIMARY KEY(`slo_assessment_id`)
) COMMENT 'Student Learning Outcome (SLO) assessment record capturing the measured performance of a student or cohort against a defined SLO for a course section in a given term. Captures SLO identifier, assessment method, performance level achieved (exemplary, proficient, developing, unsatisfactory), evidence artifact reference, assessment date, and assessor. Supports program-level PLO rollup, accreditation continuous improvement cycles, and curriculum mapping validation.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `education_ecm`.`instruction`.`course_section` ADD CONSTRAINT `fk_instruction_course_section_lms_course_shell_id` FOREIGN KEY (`lms_course_shell_id`) REFERENCES `education_ecm`.`instruction`.`lms_course_shell`(`lms_course_shell_id`);
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ADD CONSTRAINT `fk_instruction_section_meeting_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ADD CONSTRAINT `fk_instruction_section_meeting_lms_course_shell_id` FOREIGN KEY (`lms_course_shell_id`) REFERENCES `education_ecm`.`instruction`.`lms_course_shell`(`lms_course_shell_id`);
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ADD CONSTRAINT `fk_instruction_faculty_assignment_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `education_ecm`.`instruction`.`assignment`(`assignment_id`);
ALTER TABLE `education_ecm`.`instruction`.`assignment` ADD CONSTRAINT `fk_instruction_assignment_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`instruction`.`assignment` ADD CONSTRAINT `fk_instruction_assignment_rubric_id` FOREIGN KEY (`rubric_id`) REFERENCES `education_ecm`.`instruction`.`rubric`(`rubric_id`);
ALTER TABLE `education_ecm`.`instruction`.`submission` ADD CONSTRAINT `fk_instruction_submission_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `education_ecm`.`instruction`.`assignment`(`assignment_id`);
ALTER TABLE `education_ecm`.`instruction`.`submission` ADD CONSTRAINT `fk_instruction_submission_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ADD CONSTRAINT `fk_instruction_grade_entry_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `education_ecm`.`instruction`.`assignment`(`assignment_id`);
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ADD CONSTRAINT `fk_instruction_grade_entry_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ADD CONSTRAINT `fk_instruction_grade_entry_rubric_id` FOREIGN KEY (`rubric_id`) REFERENCES `education_ecm`.`instruction`.`rubric`(`rubric_id`);
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ADD CONSTRAINT `fk_instruction_grade_entry_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `education_ecm`.`instruction`.`submission`(`submission_id`);
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ADD CONSTRAINT `fk_instruction_final_grade_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ADD CONSTRAINT `fk_instruction_final_grade_lms_course_shell_id` FOREIGN KEY (`lms_course_shell_id`) REFERENCES `education_ecm`.`instruction`.`lms_course_shell`(`lms_course_shell_id`);
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ADD CONSTRAINT `fk_instruction_attendance_record_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ADD CONSTRAINT `fk_instruction_attendance_record_section_meeting_id` FOREIGN KEY (`section_meeting_id`) REFERENCES `education_ecm`.`instruction`.`section_meeting`(`section_meeting_id`);
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ADD CONSTRAINT `fk_instruction_slo_assessment_assignment_id` FOREIGN KEY (`assignment_id`) REFERENCES `education_ecm`.`instruction`.`assignment`(`assignment_id`);
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ADD CONSTRAINT `fk_instruction_slo_assessment_course_section_id` FOREIGN KEY (`course_section_id`) REFERENCES `education_ecm`.`instruction`.`course_section`(`course_section_id`);
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ADD CONSTRAINT `fk_instruction_slo_assessment_grade_entry_id` FOREIGN KEY (`grade_entry_id`) REFERENCES `education_ecm`.`instruction`.`grade_entry`(`grade_entry_id`);
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ADD CONSTRAINT `fk_instruction_slo_assessment_rubric_id` FOREIGN KEY (`rubric_id`) REFERENCES `education_ecm`.`instruction`.`rubric`(`rubric_id`);

-- ========= TAGS =========
ALTER SCHEMA `education_ecm`.`instruction` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `education_ecm`.`instruction` SET TAGS ('dbx_domain' = 'instruction');
ALTER TABLE `education_ecm`.`instruction`.`course_section` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`instruction`.`course_section` SET TAGS ('dbx_subdomain' = 'course_delivery');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course Catalog Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `lms_course_shell_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Management System (LMS) Course Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `prerequisite_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Rule Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Instructor Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `student_org_id` SET TAGS ('dbx_business_glossary_term' = 'Student Org Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `campus_code` SET TAGS ('dbx_business_glossary_term' = 'Campus Code');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `campus_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `contact_hours` SET TAGS ('dbx_business_glossary_term' = 'Contact Hours');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `course_level` SET TAGS ('dbx_business_glossary_term' = 'Course Level');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `course_level` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|professional|continuing_education');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR)');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `crn` SET TAGS ('dbx_business_glossary_term' = 'Course Reference Number (CRN)');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `crn` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `cross_listed_sections` SET TAGS ('dbx_business_glossary_term' = 'Cross-Listed Section Identifiers');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Instructional Delivery Mode');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_value_regex' = 'in_person|online|hybrid|hyflex|blended');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Section End Date');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Class End Time');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `enrollment_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Enrollment Count');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `enrollment_capacity` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Capacity');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `grade_mode` SET TAGS ('dbx_business_glossary_term' = 'Grading Mode');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `grade_mode` SET TAGS ('dbx_value_regex' = 'standard|pass_fail|audit|honors');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `instructional_method` SET TAGS ('dbx_business_glossary_term' = 'Instructional Method');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `instructional_method` SET TAGS ('dbx_value_regex' = 'lecture|lab|seminar|studio|independent_study|practicum');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `meeting_days` SET TAGS ('dbx_business_glossary_term' = 'Meeting Days');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `meeting_days` SET TAGS ('dbx_value_regex' = '^[MTWRFSU]+$');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `meeting_pattern` SET TAGS ('dbx_business_glossary_term' = 'Meeting Pattern');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `registration_end_date` SET TAGS ('dbx_business_glossary_term' = 'Registration End Date');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `registration_start_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Start Date');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `section_number` SET TAGS ('dbx_business_glossary_term' = 'Section Number');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `section_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,3}$');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `section_status` SET TAGS ('dbx_business_glossary_term' = 'Section Status');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `section_status` SET TAGS ('dbx_value_regex' = 'active|cancelled|completed|pending');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `section_title` SET TAGS ('dbx_business_glossary_term' = 'Section Title');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `special_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Special Approval Required Flag');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Section Start Date');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Class Start Time');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `tuition_amount` SET TAGS ('dbx_business_glossary_term' = 'Tuition Amount');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `waitlist_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Waitlist Count');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `waitlist_capacity` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Capacity');
ALTER TABLE `education_ecm`.`instruction`.`course_section` ALTER COLUMN `withdrawal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Deadline Date');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` SET TAGS ('dbx_subdomain' = 'course_delivery');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `section_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Section Meeting Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `building_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Instructor Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `lms_course_shell_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Management System (LMS) Course Shell Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `accessibility_features` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Features');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `begin_time` SET TAGS ('dbx_business_glossary_term' = 'Meeting Begin Time');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `campus_code` SET TAGS ('dbx_business_glossary_term' = 'Campus Code');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `campus_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,5}$');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `conflict_flag` SET TAGS ('dbx_business_glossary_term' = 'Room Conflict Indicator');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `contact_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Contact Hours Per Week');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR)');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `crn` SET TAGS ('dbx_business_glossary_term' = 'Course Reference Number (CRN)');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `crn` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Meeting End Date');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Meeting End Time');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `friday_flag` SET TAGS ('dbx_business_glossary_term' = 'Friday Meeting Indicator');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `meeting_number` SET TAGS ('dbx_business_glossary_term' = 'Meeting Sequence Number');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `meeting_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Meeting Schedule Type');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `meeting_schedule_type` SET TAGS ('dbx_value_regex' = 'scheduled|arranged|online|tba');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `meeting_status` SET TAGS ('dbx_business_glossary_term' = 'Meeting Status');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `meeting_status` SET TAGS ('dbx_value_regex' = 'active|cancelled|rescheduled|completed');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `meeting_type` SET TAGS ('dbx_business_glossary_term' = 'Meeting Type');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `monday_flag` SET TAGS ('dbx_business_glossary_term' = 'Monday Meeting Indicator');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `online_meeting_url` SET TAGS ('dbx_business_glossary_term' = 'Online Meeting Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `published_flag` SET TAGS ('dbx_business_glossary_term' = 'Published to Schedule Indicator');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `room_capacity` SET TAGS ('dbx_business_glossary_term' = 'Room Capacity');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `room_code` SET TAGS ('dbx_business_glossary_term' = 'Room Code');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `room_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `room_setup_type` SET TAGS ('dbx_business_glossary_term' = 'Room Setup Type');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `saturday_flag` SET TAGS ('dbx_business_glossary_term' = 'Saturday Meeting Indicator');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'banner|archibus|manual');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Meeting Start Date');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `sunday_flag` SET TAGS ('dbx_business_glossary_term' = 'Sunday Meeting Indicator');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `technology_features` SET TAGS ('dbx_business_glossary_term' = 'Technology Features');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Code');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `term_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `thursday_flag` SET TAGS ('dbx_business_glossary_term' = 'Thursday Meeting Indicator');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `tuesday_flag` SET TAGS ('dbx_business_glossary_term' = 'Tuesday Meeting Indicator');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `wednesday_flag` SET TAGS ('dbx_business_glossary_term' = 'Wednesday Meeting Indicator');
ALTER TABLE `education_ecm`.`instruction`.`section_meeting` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` SET TAGS ('dbx_subdomain' = 'course_delivery');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `faculty_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Assignment Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Office Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Office Room Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Ellucian Banner Assignment Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Department Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `tertiary_faculty_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `tertiary_faculty_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `tertiary_faculty_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Faculty Appointment Type');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `assignment_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Approval Date');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_business_glossary_term' = 'Faculty Assignment Role');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_value_regex' = 'primary_instructor|co_instructor|teaching_assistant|guest_lecturer|lab_instructor|recitation_leader');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `compensation_type` SET TAGS ('dbx_value_regex' = 'salary|overload|stipend|course_rate|volunteer');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `fte_contribution` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Contribution');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `grant_funded_percentage` SET TAGS ('dbx_business_glossary_term' = 'Grant Funded Percentage');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `ipeds_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Reporting Category');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `ipeds_reporting_category` SET TAGS ('dbx_value_regex' = 'instruction|research|public_service|academic_support|student_services|institutional_support');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Record Flag');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `is_grading_authority` SET TAGS ('dbx_business_glossary_term' = 'Is Grading Authority Flag');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `is_primary_instructor` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Instructor Flag');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `is_team_taught` SET TAGS ('dbx_business_glossary_term' = 'Is Team Taught Flag');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `lms_instructor_role` SET TAGS ('dbx_business_glossary_term' = 'Learning Management System (LMS) Instructor Role');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `lms_instructor_role` SET TAGS ('dbx_value_regex' = 'teacher|ta|designer|observer|grader');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `office_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Office Hours Required');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `percent_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Percent Responsibility');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `teaching_modality` SET TAGS ('dbx_business_glossary_term' = 'Teaching Modality');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `teaching_modality` SET TAGS ('dbx_value_regex' = 'in_person|online|hybrid|hyflex|synchronous_online|asynchronous_online');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`faculty_assignment` ALTER COLUMN `workload_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Workload Credit Hours');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` SET TAGS ('dbx_subdomain' = 'course_delivery');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `lms_course_shell_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Management System (LMS) Course Shell ID');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Term ID');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `allow_student_discussion_editing` SET TAGS ('dbx_business_glossary_term' = 'Allow Student Discussion Editing');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `allow_student_discussion_topics` SET TAGS ('dbx_business_glossary_term' = 'Allow Student Discussion Topics');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `allow_student_forum_attachments` SET TAGS ('dbx_business_glossary_term' = 'Allow Student Forum Attachments');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `apply_assignment_group_weights` SET TAGS ('dbx_business_glossary_term' = 'Apply Assignment Group Weights');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `concluded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Concluded Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `course_format` SET TAGS ('dbx_business_glossary_term' = 'Course Format');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `course_format` SET TAGS ('dbx_value_regex' = 'on_campus|online|blended');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `course_name` SET TAGS ('dbx_business_glossary_term' = 'Course Name');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `default_view` SET TAGS ('dbx_business_glossary_term' = 'Default View');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `default_view` SET TAGS ('dbx_value_regex' = 'feed|wiki|modules|syllabus|assignments');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `grading_standard_ref` SET TAGS ('dbx_business_glossary_term' = 'Grading Standard ID');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `hide_final_grades` SET TAGS ('dbx_business_glossary_term' = 'Hide Final Grades');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `homeroom_course` SET TAGS ('dbx_business_glossary_term' = 'Homeroom Course');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `integration_ref` SET TAGS ('dbx_business_glossary_term' = 'Integration ID');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `is_blueprint` SET TAGS ('dbx_business_glossary_term' = 'Is Blueprint');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `is_public` SET TAGS ('dbx_business_glossary_term' = 'Is Public');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `is_public_to_auth_users` SET TAGS ('dbx_business_glossary_term' = 'Is Public to Authenticated Users');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `last_sis_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Student Information System (SIS) Sync Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `license` SET TAGS ('dbx_business_glossary_term' = 'License');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `lms_account_ref` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `lms_root_account_ref` SET TAGS ('dbx_business_glossary_term' = 'Root Account ID');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `public_syllabus` SET TAGS ('dbx_business_glossary_term' = 'Public Syllabus');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `public_syllabus_to_auth` SET TAGS ('dbx_business_glossary_term' = 'Public Syllabus to Authenticated Users');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `restrict_enrollments_to_dates` SET TAGS ('dbx_business_glossary_term' = 'Restrict Enrollments to Dates');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `sis_import_ref` SET TAGS ('dbx_business_glossary_term' = 'Student Information System (SIS) Import ID');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `storage_quota_mb` SET TAGS ('dbx_business_glossary_term' = 'Storage Quota (MB)');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `storage_used_mb` SET TAGS ('dbx_business_glossary_term' = 'Storage Used (MB)');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `syllabus_body` SET TAGS ('dbx_business_glossary_term' = 'Syllabus Body');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `template_applied` SET TAGS ('dbx_business_glossary_term' = 'Template Applied');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `workflow_state` SET TAGS ('dbx_business_glossary_term' = 'Workflow State');
ALTER TABLE `education_ecm`.`instruction`.`lms_course_shell` ALTER COLUMN `workflow_state` SET TAGS ('dbx_value_regex' = 'unpublished|available|completed|deleted');
ALTER TABLE `education_ecm`.`instruction`.`assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`instruction`.`assignment` SET TAGS ('dbx_subdomain' = 'assessment_grading');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `campus_event_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Event Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Final Grader Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `map_id` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Map Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `rubric_id` SET TAGS ('dbx_business_glossary_term' = 'Rubric Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `slo_id` SET TAGS ('dbx_business_glossary_term' = 'Slo Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `allowed_attempts` SET TAGS ('dbx_business_glossary_term' = 'Allowed Attempts');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `allowed_file_extensions` SET TAGS ('dbx_business_glossary_term' = 'Allowed File Extensions');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `assignment_description` SET TAGS ('dbx_business_glossary_term' = 'Assignment Description');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `assignment_name` SET TAGS ('dbx_business_glossary_term' = 'Assignment Name');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'draft|published|unpublished|deleted');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `available_from_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Available From Date');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `canvas_assignment_ref` SET TAGS ('dbx_business_glossary_term' = 'Canvas Learning Management System (LMS) Assignment Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Due Date');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `external_tool_url` SET TAGS ('dbx_business_glossary_term' = 'External Tool Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `grade_group_students_individually` SET TAGS ('dbx_business_glossary_term' = 'Grade Group Students Individually Indicator');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `grader_count` SET TAGS ('dbx_business_glossary_term' = 'Grader Count');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `grading_type` SET TAGS ('dbx_business_glossary_term' = 'Grading Type');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `grading_type` SET TAGS ('dbx_value_regex' = 'points|percentage|letter_grade|pass_fail|not_graded|gpa_scale');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `group_category_ref` SET TAGS ('dbx_business_glossary_term' = 'Group Category Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `group_ref` SET TAGS ('dbx_business_glossary_term' = 'Assignment Group Identifier (ID)');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `is_anonymous_grading` SET TAGS ('dbx_business_glossary_term' = 'Anonymous Grading Indicator');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `is_anonymous_peer_review` SET TAGS ('dbx_business_glossary_term' = 'Anonymous Peer Review Indicator');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `is_group_assignment` SET TAGS ('dbx_business_glossary_term' = 'Group Assignment Indicator');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `is_omit_from_final_grade` SET TAGS ('dbx_business_glossary_term' = 'Omit From Final Grade Indicator');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `is_only_visible_to_overrides` SET TAGS ('dbx_business_glossary_term' = 'Only Visible to Overrides Indicator');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `is_peer_review_enabled` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Enabled Indicator');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `is_published` SET TAGS ('dbx_business_glossary_term' = 'Published Indicator');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `is_rubric_for_grading` SET TAGS ('dbx_business_glossary_term' = 'Rubric Used for Grading Indicator');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `lock_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Lock Date');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `moderated_grading_enabled` SET TAGS ('dbx_business_glossary_term' = 'Moderated Grading Enabled Indicator');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Modified Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `peer_review_count` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Count');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `peer_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Due Date');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `points_possible` SET TAGS ('dbx_business_glossary_term' = 'Points Possible');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `position` SET TAGS ('dbx_business_glossary_term' = 'Assignment Position');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `turnitin_enabled` SET TAGS ('dbx_business_glossary_term' = 'Turnitin Plagiarism Detection Enabled Indicator');
ALTER TABLE `education_ecm`.`instruction`.`assignment` ALTER COLUMN `vericite_enabled` SET TAGS ('dbx_business_glossary_term' = 'VeriCite Plagiarism Detection Enabled Indicator');
ALTER TABLE `education_ecm`.`instruction`.`submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`instruction`.`submission` SET TAGS ('dbx_subdomain' = 'assessment_grading');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission ID');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment ID');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section ID');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Grader ID');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `anonymous_ref` SET TAGS ('dbx_business_glossary_term' = 'Anonymous ID');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Attempt Number');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `body` SET TAGS ('dbx_business_glossary_term' = 'Submission Body');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `cached_due_date` SET TAGS ('dbx_business_glossary_term' = 'Cached Due Date');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `canvas_submission_ref` SET TAGS ('dbx_business_glossary_term' = 'Canvas Submission ID');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `comments_count` SET TAGS ('dbx_business_glossary_term' = 'Submission Comments Count');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `entered_grade` SET TAGS ('dbx_business_glossary_term' = 'Entered Grade');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `entered_score` SET TAGS ('dbx_business_glossary_term' = 'Entered Score');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `extra_attempts` SET TAGS ('dbx_business_glossary_term' = 'Extra Attempts');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `grade` SET TAGS ('dbx_business_glossary_term' = 'Grade');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `graded_at` SET TAGS ('dbx_business_glossary_term' = 'Graded At Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `grading_period_ref` SET TAGS ('dbx_business_glossary_term' = 'Grading Period ID');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `group_ref` SET TAGS ('dbx_business_glossary_term' = 'Group ID');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `history_count` SET TAGS ('dbx_business_glossary_term' = 'Submission History Count');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `is_anonymous_grading` SET TAGS ('dbx_business_glossary_term' = 'Is Anonymous Grading Flag');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `is_excused` SET TAGS ('dbx_business_glossary_term' = 'Is Excused Flag');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `is_late` SET TAGS ('dbx_business_glossary_term' = 'Is Late Flag');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `is_missing` SET TAGS ('dbx_business_glossary_term' = 'Is Missing Flag');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `last_activity_at` SET TAGS ('dbx_business_glossary_term' = 'Last Activity At Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `late_policy_status` SET TAGS ('dbx_business_glossary_term' = 'Late Policy Status');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `late_policy_status` SET TAGS ('dbx_value_regex' = 'none|late|missing|extended');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `originality_score` SET TAGS ('dbx_business_glossary_term' = 'Originality Score');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `points_deducted` SET TAGS ('dbx_business_glossary_term' = 'Points Deducted');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `posted_at` SET TAGS ('dbx_business_glossary_term' = 'Posted At Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `preview_url` SET TAGS ('dbx_business_glossary_term' = 'Preview URL');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `redo_request` SET TAGS ('dbx_business_glossary_term' = 'Redo Request Flag');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `rubric_assessment_ref` SET TAGS ('dbx_business_glossary_term' = 'Rubric Assessment ID');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Score');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `seconds_late` SET TAGS ('dbx_business_glossary_term' = 'Seconds Late');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `submitted_at` SET TAGS ('dbx_business_glossary_term' = 'Submitted At Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `turnitin_data` SET TAGS ('dbx_business_glossary_term' = 'Turnitin Data');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Submission URL');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `workflow_state` SET TAGS ('dbx_business_glossary_term' = 'Workflow State');
ALTER TABLE `education_ecm`.`instruction`.`submission` ALTER COLUMN `workflow_state` SET TAGS ('dbx_value_regex' = 'submitted|unsubmitted|graded|pending_review');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` SET TAGS ('dbx_subdomain' = 'assessment_grading');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `grade_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Entry ID');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment ID');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section ID');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Grader ID');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `rubric_id` SET TAGS ('dbx_business_glossary_term' = 'Rubric ID');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `slo_id` SET TAGS ('dbx_business_glossary_term' = 'Slo Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Instruction Submission Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Attempt Number');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `canvas_grade_object_ref` SET TAGS ('dbx_business_glossary_term' = 'Canvas Grade Object ID');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `extra_credit_flag` SET TAGS ('dbx_business_glossary_term' = 'Extra Credit Flag');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `grade_appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Grade Appeal Status');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `grade_appeal_status` SET TAGS ('dbx_value_regex' = 'no_appeal|appeal_pending|appeal_approved|appeal_denied');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `grade_entry_source` SET TAGS ('dbx_business_glossary_term' = 'Grade Entry Source');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `grade_entry_source` SET TAGS ('dbx_value_regex' = 'canvas_lms|banner_sis|manual_entry|scorm_package|external_tool|api_integration');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `grade_letter` SET TAGS ('dbx_business_glossary_term' = 'Grade Letter');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `grade_letter` SET TAGS ('dbx_value_regex' = 'A+|A|A-|B+|B|B-|C+|C|C-|D+|D|D-|F|P|NP|W|I|IP|AU|S|U|NG');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `grade_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Grade Override Flag');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `grade_percentage` SET TAGS ('dbx_business_glossary_term' = 'Grade Percentage');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `graded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Graded Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `grader_comments` SET TAGS ('dbx_business_glossary_term' = 'Grader Comments');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `grading_status` SET TAGS ('dbx_business_glossary_term' = 'Grading Status');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `grading_status` SET TAGS ('dbx_value_regex' = 'not_graded|graded|pending_review|excused|missing|late');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `is_excused` SET TAGS ('dbx_business_glossary_term' = 'Is Excused');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `is_final_attempt` SET TAGS ('dbx_business_glossary_term' = 'Is Final Attempt');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `is_late` SET TAGS ('dbx_business_glossary_term' = 'Is Late');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `is_missing` SET TAGS ('dbx_business_glossary_term' = 'Is Missing');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `late_penalty_applied` SET TAGS ('dbx_business_glossary_term' = 'Late Penalty Applied');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `max_score` SET TAGS ('dbx_business_glossary_term' = 'Maximum Score');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `plo_alignment` SET TAGS ('dbx_business_glossary_term' = 'Program Learning Outcome (PLO) Alignment');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `posted_to_student` SET TAGS ('dbx_business_glossary_term' = 'Posted to Student');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `rubric_score_breakdown` SET TAGS ('dbx_business_glossary_term' = 'Rubric Score Breakdown');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Score');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Term Code');
ALTER TABLE `education_ecm`.`instruction`.`grade_entry` ALTER COLUMN `weight_in_final_grade` SET TAGS ('dbx_business_glossary_term' = 'Weight in Final Grade');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` SET TAGS ('dbx_subdomain' = 'assessment_grading');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `final_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Final Grade ID');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section ID');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Instructor ID');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `lms_course_shell_id` SET TAGS ('dbx_business_glossary_term' = 'LMS (Learning Management System) Course ID');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Registration Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `student_term_record_id` SET TAGS ('dbx_business_glossary_term' = 'Student Term Record Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `academic_standing_impact` SET TAGS ('dbx_business_glossary_term' = 'Academic Standing Impact');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `course_number` SET TAGS ('dbx_business_glossary_term' = 'Course Number');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `course_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3,4}[A-Z]?$');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `credit_hours_attempted` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR) Attempted');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `credit_hours_earned` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR) Earned');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `crn` SET TAGS ('dbx_business_glossary_term' = 'Course Reference Number (CRN)');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `crn` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `degree_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Degree Applicable Flag');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `ferpa_protected_flag` SET TAGS ('dbx_business_glossary_term' = 'FERPA (Family Educational Rights and Privacy Act) Protected Flag');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `grade_change_date` SET TAGS ('dbx_business_glossary_term' = 'Grade Change Date');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `grade_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Grade Change Flag');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `grade_change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Grade Change Reason Code');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `grade_change_reason_code` SET TAGS ('dbx_value_regex' = 'calculation_error|incomplete_resolved|grade_appeal|administrative_correction|instructor_error|data_entry_error');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `grade_mode` SET TAGS ('dbx_business_glossary_term' = 'Grade Mode');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `grade_mode` SET TAGS ('dbx_value_regex' = 'standard|pass_fail|audit|honors|satisfactory_unsatisfactory');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `grade_point_value` SET TAGS ('dbx_business_glossary_term' = 'Grade Point Value');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `grade_posted_date` SET TAGS ('dbx_business_glossary_term' = 'Grade Posted Date');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `grade_posting_status` SET TAGS ('dbx_business_glossary_term' = 'Grade Posting Status');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `grade_posting_status` SET TAGS ('dbx_value_regex' = 'not_posted|posted|verified|locked|pending_approval');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `grade_source_system` SET TAGS ('dbx_business_glossary_term' = 'Grade Source System');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `grade_source_system` SET TAGS ('dbx_value_regex' = 'banner|canvas_lms|manual_entry|transfer_evaluation|prior_learning_assessment');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `grade_submission_method` SET TAGS ('dbx_business_glossary_term' = 'Grade Submission Method');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `grade_submission_method` SET TAGS ('dbx_value_regex' = 'web_entry|lms_import|batch_upload|api_integration|scantron');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `grade_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Grade Verified Date');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `incomplete_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Incomplete Deadline Date');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `incomplete_extension_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Incomplete Extension Granted Flag');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `incomplete_flag` SET TAGS ('dbx_business_glossary_term' = 'Incomplete Flag');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `last_attendance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Attendance Date');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `letter_grade` SET TAGS ('dbx_business_glossary_term' = 'Letter Grade');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `letter_grade` SET TAGS ('dbx_value_regex' = 'A|A-|B+|B|B-|C+|C|C-|D+|D|D-|F|P|NP|W|I|IP|AU|S|U|NG');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `numeric_grade` SET TAGS ('dbx_business_glossary_term' = 'Numeric Grade');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `original_letter_grade` SET TAGS ('dbx_business_glossary_term' = 'Original Letter Grade');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `quality_points` SET TAGS ('dbx_business_glossary_term' = 'Quality Points');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `repeat_course_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Course Flag');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `repeat_course_include_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Course Include Flag');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `sap_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'SAP (Satisfactory Academic Progress) Eligible Flag');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `section_number` SET TAGS ('dbx_business_glossary_term' = 'Section Number');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `section_number` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{2,3}$');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `subject_code` SET TAGS ('dbx_business_glossary_term' = 'Subject Code');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `subject_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Term Code');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `term_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `transfer_credit_flag` SET TAGS ('dbx_business_glossary_term' = 'Transfer Credit Flag');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`final_grade` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` SET TAGS ('dbx_subdomain' = 'assessment_grading');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `attendance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Attendance Record ID');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section ID');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By Faculty ID');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Registration Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `section_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting ID');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Term ID');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `academic_activity_type` SET TAGS ('dbx_business_glossary_term' = 'Academic Activity Type');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `attendance_date` SET TAGS ('dbx_business_glossary_term' = 'Attendance Date');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `attendance_percentage_to_date` SET TAGS ('dbx_business_glossary_term' = 'Attendance Percentage To Date');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `attendance_policy_violation` SET TAGS ('dbx_business_glossary_term' = 'Attendance Policy Violation');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `attendance_status` SET TAGS ('dbx_business_glossary_term' = 'Attendance Status');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `attendance_status` SET TAGS ('dbx_value_regex' = 'present|absent|tardy|excused|late_excused|early_departure');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `consecutive_absences_count` SET TAGS ('dbx_business_glossary_term' = 'Consecutive Absences Count');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `early_alert_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Early Alert Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `early_alert_triggered` SET TAGS ('dbx_business_glossary_term' = 'Early Alert Triggered');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `excuse_documentation_provided` SET TAGS ('dbx_business_glossary_term' = 'Excuse Documentation Provided');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `excuse_reason` SET TAGS ('dbx_business_glossary_term' = 'Excuse Reason');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `instructor_notes` SET TAGS ('dbx_business_glossary_term' = 'Instructor Notes');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP (Internet Protocol) Address');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `last_date_of_attendance_flag` SET TAGS ('dbx_business_glossary_term' = 'Last Date of Attendance Flag');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `lms_activity_indicator` SET TAGS ('dbx_business_glossary_term' = 'LMS (Learning Management System) Activity Indicator');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `lms_activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'LMS (Learning Management System) Activity Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `minutes_absent` SET TAGS ('dbx_business_glossary_term' = 'Minutes Absent');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `minutes_present` SET TAGS ('dbx_business_glossary_term' = 'Minutes Present');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `recorded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recorded Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `recording_method` SET TAGS ('dbx_business_glossary_term' = 'Recording Method');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `recording_method` SET TAGS ('dbx_value_regex' = 'manual|lms_activity|clicker|card_swipe|biometric|mobile_app');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `source_system_record_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `title_iv_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Title IV Eligible Flag');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `total_absences_count` SET TAGS ('dbx_business_glossary_term' = 'Total Absences Count');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|verified|disputed|corrected');
ALTER TABLE `education_ecm`.`instruction`.`attendance_record` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`rubric` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`instruction`.`rubric` SET TAGS ('dbx_subdomain' = 'assessment_grading');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `rubric_id` SET TAGS ('dbx_business_glossary_term' = 'Rubric ID');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course ID');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `plo_id` SET TAGS ('dbx_business_glossary_term' = 'Plo Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `slo_id` SET TAGS ('dbx_business_glossary_term' = 'Slo Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `alignment_outcome_group_ref` SET TAGS ('dbx_business_glossary_term' = 'Alignment Outcome Group ID');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `archived_at` SET TAGS ('dbx_business_glossary_term' = 'Archived At Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `assessment_count` SET TAGS ('dbx_business_glossary_term' = 'Assessment Count');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `canvas_rubric_ref` SET TAGS ('dbx_business_glossary_term' = 'Canvas Rubric ID');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `context_code` SET TAGS ('dbx_business_glossary_term' = 'Context Code');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `context_type` SET TAGS ('dbx_business_glossary_term' = 'Context Type');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `context_type` SET TAGS ('dbx_value_regex' = 'Course|Account|Program');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Created At Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `criteria_count` SET TAGS ('dbx_business_glossary_term' = 'Criteria Count');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `free_form_criterion_comments` SET TAGS ('dbx_business_glossary_term' = 'Free-Form Criterion Comments Flag');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `hide_points` SET TAGS ('dbx_business_glossary_term' = 'Hide Points Flag');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `hide_score_total` SET TAGS ('dbx_business_glossary_term' = 'Hide Score Total Flag');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `lms_account_ref` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `public` SET TAGS ('dbx_business_glossary_term' = 'Public Flag');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `published_at` SET TAGS ('dbx_business_glossary_term' = 'Published At Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `read_only` SET TAGS ('dbx_business_glossary_term' = 'Read-Only Flag');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `reusable` SET TAGS ('dbx_business_glossary_term' = 'Reusable Flag');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `rubric_description` SET TAGS ('dbx_business_glossary_term' = 'Rubric Description');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `rubric_status` SET TAGS ('dbx_business_glossary_term' = 'Rubric Status');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `rubric_status` SET TAGS ('dbx_value_regex' = 'draft|active|archived|deleted');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `rubric_type` SET TAGS ('dbx_business_glossary_term' = 'Rubric Type');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `rubric_type` SET TAGS ('dbx_value_regex' = 'points|percentage|outcome_aligned|holistic|analytic|checklist');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `scoring_method` SET TAGS ('dbx_business_glossary_term' = 'Scoring Method');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `scoring_method` SET TAGS ('dbx_value_regex' = 'points|percentage|letter_grade|pass_fail');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Rubric Title');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `total_points_possible` SET TAGS ('dbx_business_glossary_term' = 'Total Points Possible');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Updated At Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `use_range` SET TAGS ('dbx_business_glossary_term' = 'Use Range Flag');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `workflow_state` SET TAGS ('dbx_business_glossary_term' = 'Workflow State');
ALTER TABLE `education_ecm`.`instruction`.`rubric` ALTER COLUMN `workflow_state` SET TAGS ('dbx_value_regex' = 'draft|active|deleted');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` SET TAGS ('dbx_subdomain' = 'assessment_grading');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `slo_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Student Learning Outcome (SLO) Assessment ID');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `accreditation_review_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Review Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Management System (LMS) Assignment ID');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `accreditation_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Accreditation Standard Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section ID');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `grade_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Entry Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `map_id` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Map ID');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `plo_id` SET TAGS ('dbx_business_glossary_term' = 'Program Learning Outcome (PLO) ID');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor ID');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `rubric_id` SET TAGS ('dbx_business_glossary_term' = 'Rubric ID');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `service_learning_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Learning Placement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `slo_id` SET TAGS ('dbx_business_glossary_term' = 'Student Learning Outcome (SLO) ID');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `student_term_record_id` SET TAGS ('dbx_business_glossary_term' = 'Student Term Record Id (Foreign Key)');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `assessment_cycle` SET TAGS ('dbx_business_glossary_term' = 'Assessment Cycle');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `assessment_cycle` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|reviewed|approved|archived');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `cohort_flag` SET TAGS ('dbx_business_glossary_term' = 'Cohort Assessment Flag');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `cohort_size` SET TAGS ('dbx_business_glossary_term' = 'Cohort Size');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `evidence_artifact_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Artifact Reference');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `improvement_action_description` SET TAGS ('dbx_business_glossary_term' = 'Improvement Action Description');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `improvement_action_required` SET TAGS ('dbx_business_glossary_term' = 'Improvement Action Required Flag');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `performance_level` SET TAGS ('dbx_business_glossary_term' = 'Performance Level');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `performance_level` SET TAGS ('dbx_value_regex' = 'exemplary|proficient|developing|unsatisfactory|not_assessed');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `proficiency_threshold` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Threshold');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `score_maximum` SET TAGS ('dbx_business_glossary_term' = 'Maximum Score');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `score_numeric` SET TAGS ('dbx_business_glossary_term' = 'Numeric Score');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Code');
ALTER TABLE `education_ecm`.`instruction`.`slo_assessment` ALTER COLUMN `term_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
