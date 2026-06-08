-- Metric views for domain: student | Business: Education | Version: 1 | Generated on: 2026-05-06 15:08:33

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`student_academic_standing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Academic standing KPIs tracking student GPA health, SAP compliance, credit pace, and financial aid eligibility across the student population. Used by academic affairs, financial aid, and retention leadership to identify at-risk students and drive intervention strategies."
  source: "`education_ecm`.`student`.`academic_standing`"
  dimensions:
    - name: "institutional_standing"
      expr: institutional_standing
      comment: "Student's current institutional academic standing (e.g., Good Standing, Academic Probation, Academic Suspension). Primary grouping for at-risk cohort analysis."
    - name: "sap_status"
      expr: sap_status
      comment: "Satisfactory Academic Progress status determining Title IV financial aid eligibility. Critical for financial aid compliance reporting."
    - name: "gpa_threshold_met"
      expr: gpa_threshold_met
      comment: "Boolean flag indicating whether the student met the minimum GPA threshold for their standing policy. Used to segment compliant vs. non-compliant students."
    - name: "pace_threshold_met"
      expr: pace_threshold_met
      comment: "Boolean flag indicating whether the student met the credit completion pace requirement. Key SAP dimension for financial aid risk segmentation."
    - name: "title_iv_eligible"
      expr: title_iv_eligible
      comment: "Boolean flag indicating Title IV federal financial aid eligibility. Drives financial aid disbursement and compliance decisions."
    - name: "maximum_timeframe_exceeded"
      expr: maximum_timeframe_exceeded
      comment: "Boolean flag indicating whether the student has exceeded the maximum allowable timeframe for degree completion under SAP policy."
    - name: "appeal_submitted"
      expr: appeal_submitted
      comment: "Boolean flag indicating whether the student submitted a SAP or standing appeal. Used to track appeal volume and outcomes."
    - name: "appeal_decision"
      expr: appeal_decision
      comment: "Outcome of the student's academic standing or SAP appeal (e.g., Approved, Denied, Pending). Used to evaluate appeal approval rates."
    - name: "ipeds_reportable"
      expr: ipeds_reportable
      comment: "Boolean flag indicating whether this standing record is reportable to IPEDS. Used for federal compliance reporting segmentation."
    - name: "evaluation_date_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of the academic standing evaluation. Enables trend analysis of standing changes over time."
  measures:
    - name: "total_students_evaluated"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total number of distinct students with an academic standing evaluation. Baseline headcount for all standing-based KPIs."
    - name: "avg_cumulative_gpa"
      expr: AVG(CAST(cumulative_gpa AS DOUBLE))
      comment: "Average cumulative GPA across evaluated students. Core academic health indicator used by academic affairs leadership to monitor institutional GPA trends."
    - name: "avg_term_gpa"
      expr: AVG(CAST(term_gpa AS DOUBLE))
      comment: "Average term GPA for the evaluation period. Tracks semester-level academic performance trends and early warning signals."
    - name: "avg_completion_rate"
      expr: AVG(CAST(completion_rate AS DOUBLE))
      comment: "Average credit completion rate (credits earned / credits attempted) across students. Core SAP metric used by financial aid to assess pace compliance."
    - name: "total_cumulative_credits_attempted"
      expr: SUM(CAST(cumulative_credits_attempted AS DOUBLE))
      comment: "Total cumulative credit hours attempted across all evaluated students. Indicates overall academic load and enrollment intensity."
    - name: "total_cumulative_credits_earned"
      expr: SUM(CAST(cumulative_credits_earned AS DOUBLE))
      comment: "Total cumulative credit hours earned across all evaluated students. Paired with credits attempted to compute institutional completion rate."
    - name: "avg_transfer_gpa"
      expr: AVG(CAST(transfer_gpa AS DOUBLE))
      comment: "Average GPA from transfer institutions. Used by admissions and academic affairs to benchmark transfer student academic preparation."
    - name: "total_credits_in_progress"
      expr: SUM(CAST(credits_in_progress AS DOUBLE))
      comment: "Total credit hours currently in progress across evaluated students. Indicates current enrollment load and projected future earned credits."
    - name: "students_on_academic_plan"
      expr: COUNT(DISTINCT CASE WHEN academic_plan_required = TRUE THEN profile_id END)
      comment: "Number of distinct students required to follow an academic improvement plan. Key retention intervention metric for academic affairs."
    - name: "students_exceeding_max_timeframe"
      expr: COUNT(DISTINCT CASE WHEN maximum_timeframe_exceeded = TRUE THEN profile_id END)
      comment: "Number of distinct students who have exceeded the maximum timeframe for degree completion. Drives SAP suspension decisions and financial aid risk."
    - name: "students_with_appeal_submitted"
      expr: COUNT(DISTINCT CASE WHEN appeal_submitted = TRUE THEN profile_id END)
      comment: "Number of distinct students who submitted an academic standing or SAP appeal. Tracks appeal volume for workload planning and policy review."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`student_enrollment_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment KPIs measuring headcount, FTE, credit load, and enrollment intensity across terms, programs, and campuses. Used by enrollment management, institutional research, and finance leadership for IPEDS reporting, tuition revenue forecasting, and retention analysis."
  source: "`education_ecm`.`student`.`enrollment_status`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status of the student (e.g., Full-Time, Part-Time, Withdrawn, Stopped Out). Primary dimension for headcount segmentation."
    - name: "enrollment_intensity"
      expr: enrollment_intensity
      comment: "Enrollment intensity classification (e.g., Full-Time, Half-Time, Less Than Half-Time). Used for financial aid eligibility and IPEDS reporting."
    - name: "enrollment_level"
      expr: enrollment_level
      comment: "Academic level of enrollment (e.g., Undergraduate, Graduate, Doctoral). Enables program-level headcount and revenue analysis."
    - name: "ipeds_enrollment_category"
      expr: ipeds_enrollment_category
      comment: "IPEDS-defined enrollment category for federal reporting. Ensures compliance with NCES enrollment reporting standards."
    - name: "degree_seeking_indicator"
      expr: degree_seeking_indicator
      comment: "Boolean flag indicating whether the student is enrolled in a degree-seeking program. Separates degree-seeking from non-degree/continuing education headcount."
    - name: "instructional_method"
      expr: instructional_method
      comment: "Mode of instruction (e.g., In-Person, Online, Hybrid). Used to track online vs. on-campus enrollment trends."
    - name: "cohort_year"
      expr: cohort_year
      comment: "Entering cohort year of the student. Enables longitudinal retention and graduation rate analysis by cohort."
    - name: "ftiac_indicator"
      expr: ftiac_indicator
      comment: "Boolean flag for First-Time-In-Any-College students. Critical for IPEDS graduation rate cohort tracking and retention reporting."
    - name: "veteran_status_indicator"
      expr: veteran_status_indicator
      comment: "Boolean flag indicating veteran or military-affiliated student status. Required for veteran services reporting and benefit compliance."
    - name: "financial_aid_recipient_indicator"
      expr: financial_aid_recipient_indicator
      comment: "Boolean flag indicating whether the student received financial aid. Used to analyze aid dependency and enrollment sustainability."
    - name: "sap_status"
      expr: sap_status
      comment: "Satisfactory Academic Progress status at time of enrollment record. Links enrollment health to financial aid compliance."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment. Enables trend analysis of enrollment activity over time."
    - name: "expected_graduation_term"
      expr: expected_graduation_term
      comment: "Expected graduation term for the student. Used for graduation pipeline forecasting and capacity planning."
    - name: "housing_status"
      expr: housing_status
      comment: "Student housing status (e.g., On-Campus, Off-Campus, Commuter). Used for housing demand planning and student services analysis."
  measures:
    - name: "total_enrolled_students"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total number of distinct enrolled students. Primary headcount KPI for enrollment management, IPEDS reporting, and tuition revenue forecasting."
    - name: "total_fte"
      expr: SUM(CAST(fte_value AS DOUBLE))
      comment: "Total Full-Time Equivalent enrollment. Standard metric for state funding formulas, IPEDS reporting, and institutional capacity planning."
    - name: "avg_fte_per_student"
      expr: AVG(CAST(fte_value AS DOUBLE))
      comment: "Average FTE value per enrollment record. Indicates average enrollment intensity and is used to benchmark part-time vs. full-time enrollment mix."
    - name: "total_credit_hours_enrolled"
      expr: SUM(CAST(credit_hours_enrolled AS DOUBLE))
      comment: "Total credit hours enrolled across all students. Drives tuition revenue calculations and instructional resource planning."
    - name: "avg_credit_hours_enrolled"
      expr: AVG(CAST(credit_hours_enrolled AS DOUBLE))
      comment: "Average credit hours enrolled per student. Indicates enrollment intensity and is used to monitor full-time vs. part-time enrollment trends."
    - name: "total_credit_hours_attempted"
      expr: SUM(CAST(credit_hours_attempted AS DOUBLE))
      comment: "Total credit hours attempted by enrolled students. Used alongside earned hours to compute institutional completion rates."
    - name: "students_with_holds"
      expr: COUNT(DISTINCT CASE WHEN ferpa_directory_hold_indicator = TRUE THEN profile_id END)
      comment: "Number of distinct students with a FERPA directory hold. Indicates students who have opted out of directory information disclosure."
    - name: "degree_seeking_headcount"
      expr: COUNT(DISTINCT CASE WHEN degree_seeking_indicator = TRUE THEN profile_id END)
      comment: "Number of distinct degree-seeking students. Core IPEDS headcount metric and primary driver of graduation rate denominators."
    - name: "ftiac_headcount"
      expr: COUNT(DISTINCT CASE WHEN ftiac_indicator = TRUE THEN profile_id END)
      comment: "Number of distinct First-Time-In-Any-College students. Defines the IPEDS graduation rate cohort and is a key admissions funnel metric."
    - name: "withdrawn_students"
      expr: COUNT(DISTINCT CASE WHEN withdrawal_date IS NOT NULL THEN profile_id END)
      comment: "Number of distinct students with a recorded withdrawal date. Key retention risk metric used by student success and enrollment management."
    - name: "financial_aid_recipients"
      expr: COUNT(DISTINCT CASE WHEN financial_aid_recipient_indicator = TRUE THEN profile_id END)
      comment: "Number of distinct students receiving financial aid. Used to assess aid dependency, budget exposure, and enrollment sustainability."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`student_degree_conferral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Degree conferral KPIs measuring graduation outcomes, honors attainment, GPA at conferral, and IPEDS reportability. Used by institutional research, academic affairs, and the registrar to track graduation rates, program completion, and federal reporting compliance."
  source: "`education_ecm`.`student`.`degree_conferral`"
  dimensions:
    - name: "degree_level"
      expr: degree_level
      comment: "Level of the conferred degree (e.g., Associate, Bachelor, Master, Doctoral). Primary dimension for graduation analysis by program level."
    - name: "degree_type"
      expr: degree_type
      comment: "Type of degree conferred (e.g., B.S., B.A., M.S., Ph.D.). Used to analyze graduation mix by degree type."
    - name: "major"
      expr: major
      comment: "Major field of study at time of degree conferral. Enables program-level graduation rate and outcome analysis."
    - name: "cip_code"
      expr: cip_code
      comment: "Classification of Instructional Programs code for the conferred degree. Required for IPEDS completions reporting and federal program classification."
    - name: "conferral_academic_year"
      expr: conferral_academic_year
      comment: "Academic year in which the degree was conferred. Enables year-over-year graduation trend analysis."
    - name: "honors_designation"
      expr: honors_designation
      comment: "Latin honors designation (e.g., Cum Laude, Magna Cum Laude, Summa Cum Laude). Used to track honors graduation rates and academic excellence."
    - name: "ipeds_reportable_flag"
      expr: ipeds_reportable_flag
      comment: "Boolean flag indicating whether the conferral is reportable to IPEDS. Ensures federal completions data accuracy."
    - name: "commencement_participation_flag"
      expr: commencement_participation_flag
      comment: "Boolean flag indicating whether the graduate participated in commencement. Used for ceremony planning and alumni engagement."
    - name: "diploma_hold_flag"
      expr: diploma_hold_flag
      comment: "Boolean flag indicating a hold preventing diploma release. Tracks outstanding obligations (financial, academic) at graduation."
    - name: "degree_audit_status"
      expr: degree_audit_status
      comment: "Status of the degree audit at time of conferral (e.g., Complete, Pending, Exception). Used to monitor audit completion rates."
    - name: "conferral_date_month"
      expr: DATE_TRUNC('MONTH', conferral_date)
      comment: "Month of degree conferral. Enables monthly and seasonal graduation trend analysis."
  measures:
    - name: "total_degrees_conferred"
      expr: COUNT(degree_conferral_id)
      comment: "Total number of degrees conferred. Primary graduation output metric for IPEDS completions reporting and institutional performance dashboards."
    - name: "total_graduates"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total number of distinct students who received a degree. Unduplicated graduate headcount for graduation rate calculations."
    - name: "avg_gpa_at_conferral"
      expr: AVG(CAST(gpa_at_conferral AS DOUBLE))
      comment: "Average GPA of students at time of degree conferral. Indicates academic quality of graduating cohorts and program rigor."
    - name: "avg_total_credits_earned"
      expr: AVG(CAST(total_credits_earned AS DOUBLE))
      comment: "Average total credit hours earned by graduates. Used to assess time-to-degree efficiency and excess credit accumulation."
    - name: "total_institutional_credits_earned"
      expr: SUM(CAST(institutional_credits_earned AS DOUBLE))
      comment: "Total institutional credit hours earned by graduates. Measures instructional output and is used in state funding and accreditation reporting."
    - name: "graduates_with_honors"
      expr: COUNT(DISTINCT CASE WHEN honors_designation IS NOT NULL AND honors_designation <> '' THEN profile_id END)
      comment: "Number of distinct graduates receiving a Latin honors designation. Tracks academic excellence rates across graduating cohorts."
    - name: "graduates_with_diploma_hold"
      expr: COUNT(DISTINCT CASE WHEN diploma_hold_flag = TRUE THEN profile_id END)
      comment: "Number of distinct graduates with a diploma hold at conferral. Indicates unresolved financial or academic obligations at graduation."
    - name: "ipeds_reportable_completions"
      expr: COUNT(CASE WHEN ipeds_reportable_flag = TRUE THEN degree_conferral_id END)
      comment: "Total IPEDS-reportable degree completions. Direct input to federal IPEDS completions survey submission."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`student_degree_progress`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Degree progress KPIs measuring student advancement toward degree completion, credit accumulation, GPA against requirements, and graduation pipeline health. Used by academic advisors, department chairs, and institutional research to identify students at risk of not completing and to forecast graduation pipelines."
  source: "`education_ecm`.`student`.`degree_progress`"
  dimensions:
    - name: "degree_level"
      expr: degree_level
      comment: "Level of the degree being pursued (e.g., Associate, Bachelor, Master, Doctoral). Primary dimension for progress analysis by program level."
    - name: "degree_type"
      expr: degree_type
      comment: "Type of degree being pursued (e.g., B.S., B.A., M.S.). Used to segment progress metrics by degree type."
    - name: "major_name"
      expr: major_name
      comment: "Name of the student's declared major. Enables program-level completion rate and progress analysis."
    - name: "progress_status"
      expr: progress_status
      comment: "Current degree progress status (e.g., On Track, Behind, At Risk, Completed). Primary operational dimension for advising intervention prioritization."
    - name: "sap_status"
      expr: sap_status
      comment: "Satisfactory Academic Progress status associated with the degree progress record. Links academic progress to financial aid compliance."
    - name: "anticipated_graduation_term"
      expr: anticipated_graduation_term
      comment: "Anticipated term of graduation. Used for graduation pipeline forecasting and capacity planning."
    - name: "catalog_year"
      expr: catalog_year
      comment: "Catalog year under which the student is completing degree requirements. Used to track policy version impacts on completion rates."
    - name: "what_if_scenario_flag"
      expr: what_if_scenario_flag
      comment: "Boolean flag indicating whether this is a what-if scenario audit vs. an official degree audit. Filters operational metrics to official records only."
    - name: "cip_code"
      expr: cip_code
      comment: "Classification of Instructional Programs code for the degree program. Required for federal program-level reporting."
  measures:
    - name: "total_students_in_progress"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total number of distinct students with an active degree progress record. Baseline for graduation pipeline and advising caseload analysis."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average degree completion percentage across students. Core progress KPI used by academic affairs to monitor graduation pipeline health."
    - name: "avg_credits_remaining"
      expr: AVG(CAST(credits_remaining AS DOUBLE))
      comment: "Average credit hours remaining to degree completion. Used to estimate time-to-graduation and advising intervention urgency."
    - name: "total_credits_completed"
      expr: SUM(CAST(credits_completed AS DOUBLE))
      comment: "Total credit hours completed across all degree progress records. Measures cumulative instructional output toward degree requirements."
    - name: "total_credits_in_progress"
      expr: SUM(CAST(credits_in_progress AS DOUBLE))
      comment: "Total credit hours currently in progress. Indicates near-term credit completion pipeline for graduation forecasting."
    - name: "total_credits_transferred"
      expr: SUM(CAST(credits_transferred AS DOUBLE))
      comment: "Total transfer credit hours applied toward degree requirements. Used to assess transfer credit impact on time-to-degree and program completion."
    - name: "avg_program_gpa"
      expr: AVG(CAST(program_gpa AS DOUBLE))
      comment: "Average program GPA across students in progress. Indicates academic health of the degree-seeking population relative to minimum GPA requirements."
    - name: "students_below_min_gpa"
      expr: COUNT(DISTINCT CASE WHEN program_gpa < minimum_gpa_required THEN profile_id END)
      comment: "Number of distinct students whose program GPA falls below the minimum required GPA for their degree. Critical at-risk indicator for academic advising intervention."
    - name: "avg_major_credits_completed"
      expr: AVG(CAST(major_credits_completed AS DOUBLE))
      comment: "Average major-specific credit hours completed. Used to assess depth of major completion and identify students lagging in core requirements."
    - name: "avg_general_education_credits_completed"
      expr: AVG(CAST(general_education_credits_completed AS DOUBLE))
      comment: "Average general education credit hours completed. Tracks general education requirement fulfillment across the student population."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`student_academic_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Academic history KPIs measuring course completion, grade performance, credit accumulation, and academic quality at the course-enrollment level. Used by institutional research, academic affairs, and the registrar to analyze grade distributions, repeat rates, transfer credit impact, and honors participation."
  source: "`education_ecm`.`student`.`academic_history`"
  dimensions:
    - name: "academic_level"
      expr: academic_level
      comment: "Academic level of the course enrollment (e.g., Undergraduate, Graduate). Primary dimension for grade and credit analysis by student level."
    - name: "course_level"
      expr: course_level
      comment: "Level of the course (e.g., 100, 200, 300, 400-level). Used to analyze grade distributions and completion rates by course difficulty."
    - name: "subject_code"
      expr: subject_code
      comment: "Academic subject/discipline code (e.g., MATH, ENGL, BIOL). Enables department-level grade and completion analysis."
    - name: "completion_status"
      expr: completion_status
      comment: "Completion status of the course enrollment (e.g., Completed, Withdrawn, Incomplete). Used to compute course completion and withdrawal rates."
    - name: "grading_mode"
      expr: grading_mode
      comment: "Grading mode for the course (e.g., Letter Grade, Pass/Fail, Audit). Used to segment grade metrics to letter-graded courses only."
    - name: "course_delivery_mode"
      expr: course_delivery_mode
      comment: "Delivery mode of the course (e.g., In-Person, Online, Hybrid). Used to compare academic outcomes across delivery modalities."
    - name: "transfer_credit_indicator"
      expr: transfer_credit_indicator
      comment: "Boolean flag indicating whether this history record represents a transfer credit. Separates institutional vs. transfer credit in academic history analysis."
    - name: "repeat_indicator"
      expr: repeat_indicator
      comment: "Boolean flag indicating whether this is a repeated course enrollment. Used to compute course repeat rates and policy compliance."
    - name: "honors_course_flag"
      expr: honors_course_flag
      comment: "Boolean flag indicating enrollment in an honors course. Used to track honors program participation and academic excellence."
    - name: "online_course_flag"
      expr: online_course_flag
      comment: "Boolean flag indicating an online course enrollment. Used to analyze online learning outcomes vs. in-person outcomes."
    - name: "degree_applicable_flag"
      expr: degree_applicable_flag
      comment: "Boolean flag indicating whether the course is applicable toward a degree requirement. Filters credit analysis to degree-relevant coursework."
    - name: "general_education_flag"
      expr: general_education_flag
      comment: "Boolean flag indicating whether the course fulfills a general education requirement. Used to track general education completion rates."
    - name: "registration_status"
      expr: registration_status
      comment: "Registration status of the course enrollment (e.g., Registered, Dropped, Withdrawn). Used to analyze enrollment activity and drop rates."
    - name: "academic_standing_impact"
      expr: academic_standing_impact
      comment: "Indicates whether this course record impacts the student's academic standing calculation. Used to isolate standing-relevant coursework."
  measures:
    - name: "total_course_enrollments"
      expr: COUNT(academic_history_id)
      comment: "Total number of course enrollment records in academic history. Baseline volume metric for course demand and instructional load analysis."
    - name: "total_credit_hours_attempted"
      expr: SUM(CAST(credit_hours_attempted AS DOUBLE))
      comment: "Total credit hours attempted across all academic history records. Core metric for enrollment intensity and SAP compliance calculations."
    - name: "total_credit_hours_earned"
      expr: SUM(CAST(credit_hours_earned AS DOUBLE))
      comment: "Total credit hours earned across all academic history records. Measures successful course completion and degree progress."
    - name: "total_quality_points"
      expr: SUM(CAST(quality_points AS DOUBLE))
      comment: "Total quality points earned across all academic history records. Used as the numerator in GPA calculations at the institutional level."
    - name: "avg_grade_points"
      expr: AVG(CAST(grade_points AS DOUBLE))
      comment: "Average grade points per course enrollment. Proxy for average course-level GPA performance across the student population."
    - name: "total_repeat_enrollments"
      expr: COUNT(CASE WHEN repeat_indicator = TRUE THEN academic_history_id END)
      comment: "Total number of repeated course enrollments. Indicates course repeat volume, which drives excess credit accumulation and time-to-degree delays."
    - name: "total_grade_changes"
      expr: COUNT(CASE WHEN grade_change_indicator = TRUE THEN academic_history_id END)
      comment: "Total number of grade change records. Used by the registrar and academic affairs to monitor grade change frequency and policy compliance."
    - name: "honors_course_enrollments"
      expr: COUNT(CASE WHEN honors_course_flag = TRUE THEN academic_history_id END)
      comment: "Total number of honors course enrollments. Tracks honors program participation volume and academic excellence engagement."
    - name: "transfer_credit_records"
      expr: COUNT(CASE WHEN transfer_credit_indicator = TRUE THEN academic_history_id END)
      comment: "Total number of transfer credit records in academic history. Used to assess transfer credit volume and its contribution to degree completion."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`student_graduation_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Graduation application KPIs tracking application volume, approval rates, GPA at graduation, honors attainment, and IPEDS reporting compliance. Used by the registrar, academic affairs, and institutional research to manage graduation pipelines and federal reporting."
  source: "`education_ecm`.`student`.`graduation_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the graduation application (e.g., Submitted, Approved, Denied, Pending). Primary dimension for pipeline stage analysis."
    - name: "degree_level"
      expr: degree_level
      comment: "Level of the degree being applied for (e.g., Associate, Bachelor, Master, Doctoral). Used to segment graduation applications by program level."
    - name: "degree_code"
      expr: degree_code
      comment: "Institutional degree code for the graduation application. Used for program-level graduation application analysis."
    - name: "cip_code"
      expr: cip_code
      comment: "Classification of Instructional Programs code. Required for IPEDS completions reporting alignment."
    - name: "latin_honors_designation"
      expr: latin_honors_designation
      comment: "Latin honors designation on the graduation application (e.g., Cum Laude, Magna Cum Laude, Summa Cum Laude). Tracks honors graduation rates."
    - name: "commencement_participation_flag"
      expr: commencement_participation_flag
      comment: "Boolean flag indicating whether the applicant plans to participate in commencement. Used for ceremony capacity planning."
    - name: "degree_requirements_met_flag"
      expr: degree_requirements_met_flag
      comment: "Boolean flag indicating whether all degree requirements have been met at time of application. Key quality gate for graduation approval workflow."
    - name: "diploma_hold_flag"
      expr: diploma_hold_flag
      comment: "Boolean flag indicating a hold on diploma release. Tracks unresolved obligations at graduation application stage."
    - name: "ipeds_reported_flag"
      expr: ipeds_reported_flag
      comment: "Boolean flag indicating whether the graduation application has been reported to IPEDS. Used for federal reporting completeness audits."
    - name: "ipeds_reporting_year"
      expr: ipeds_reporting_year
      comment: "IPEDS reporting year for the graduation application. Used to segment completions data by federal reporting cycle."
    - name: "application_submitted_date_month"
      expr: DATE_TRUNC('MONTH', application_submitted_date)
      comment: "Month of graduation application submission. Enables trend analysis of application volume over time."
  measures:
    - name: "total_graduation_applications"
      expr: COUNT(graduation_application_id)
      comment: "Total number of graduation applications submitted. Primary volume metric for graduation pipeline management and registrar workload planning."
    - name: "total_applicants"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total number of distinct students who submitted a graduation application. Unduplicated applicant count for graduation rate analysis."
    - name: "approved_applications"
      expr: COUNT(CASE WHEN application_status = 'Approved' THEN graduation_application_id END)
      comment: "Total number of approved graduation applications. Used to compute approval rates and monitor graduation pipeline throughput."
    - name: "avg_graduation_gpa"
      expr: AVG(CAST(graduation_gpa AS DOUBLE))
      comment: "Average GPA of students at time of graduation application. Indicates academic quality of the graduating cohort."
    - name: "avg_total_credits_earned"
      expr: AVG(CAST(total_credits_earned AS DOUBLE))
      comment: "Average total credit hours earned by graduation applicants. Used to assess time-to-degree efficiency and excess credit accumulation."
    - name: "total_application_fee_revenue"
      expr: SUM(CAST(application_fee_amount AS DOUBLE))
      comment: "Total graduation application fee revenue collected. Used by finance to track graduation fee income and budget projections."
    - name: "applications_with_diploma_hold"
      expr: COUNT(CASE WHEN diploma_hold_flag = TRUE THEN graduation_application_id END)
      comment: "Number of graduation applications with a diploma hold. Tracks unresolved financial or academic obligations blocking diploma release."
    - name: "applications_requirements_met"
      expr: COUNT(CASE WHEN degree_requirements_met_flag = TRUE THEN graduation_application_id END)
      comment: "Number of graduation applications where all degree requirements are confirmed met. Measures graduation audit completion rate and readiness."
    - name: "avg_transfer_credits_accepted"
      expr: AVG(CAST(transfer_credits_accepted AS DOUBLE))
      comment: "Average transfer credits accepted toward degree for graduation applicants. Used to assess transfer credit impact on graduation outcomes."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`student_transfer_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transfer credit KPIs measuring credit evaluation volume, awarded hours, approval rates, and source institution diversity. Used by the registrar, admissions, and academic affairs to manage transfer credit policy, articulation agreement effectiveness, and time-to-degree impact."
  source: "`education_ecm`.`student`.`transfer_credit`"
  dimensions:
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Status of the transfer credit evaluation (e.g., Approved, Denied, Pending, In Review). Primary dimension for transfer credit pipeline analysis."
    - name: "transfer_credit_type"
      expr: transfer_credit_type
      comment: "Type of transfer credit (e.g., Course Equivalency, Block Credit, Elective). Used to segment transfer credit volume by type."
    - name: "equivalent_credit_category"
      expr: equivalent_credit_category
      comment: "Category of the equivalent credit at the receiving institution (e.g., Major, General Education, Elective). Used to assess degree applicability of transfer credits."
    - name: "source_institution_name"
      expr: source_institution_name
      comment: "Name of the institution from which the credit was transferred. Used to analyze transfer credit volume and approval rates by sending institution."
    - name: "source_credit_type"
      expr: source_credit_type
      comment: "Type of credit at the source institution (e.g., Semester, Quarter). Used to normalize credit hour conversions."
    - name: "applies_to_gpa"
      expr: applies_to_gpa
      comment: "Boolean flag indicating whether the transfer credit is included in GPA calculations. Used to assess GPA impact of transfer credits."
    - name: "general_education_area"
      expr: general_education_area
      comment: "General education area fulfilled by the transfer credit. Used to track general education requirement fulfillment via transfer."
    - name: "transcript_type"
      expr: transcript_type
      comment: "Type of transcript received (e.g., Official, Unofficial, Electronic). Used to monitor documentation compliance in transfer credit evaluation."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal filed for a denied transfer credit evaluation. Used to track appeal volume and outcomes."
    - name: "evaluation_date_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of transfer credit evaluation. Enables trend analysis of evaluation workload over time."
  measures:
    - name: "total_transfer_credit_evaluations"
      expr: COUNT(transfer_credit_id)
      comment: "Total number of transfer credit evaluation records. Baseline volume metric for registrar workload and articulation agreement utilization."
    - name: "total_students_with_transfer_credit"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total number of distinct students with transfer credit records. Used to assess the scale of transfer student population and credit portability."
    - name: "total_awarded_credit_hours"
      expr: SUM(CAST(awarded_credit_hours AS DOUBLE))
      comment: "Total credit hours awarded through transfer credit evaluations. Measures the volume of credit accepted and its contribution to degree completion."
    - name: "total_source_credit_hours"
      expr: SUM(CAST(source_credit_hours AS DOUBLE))
      comment: "Total credit hours attempted at source institutions. Used alongside awarded hours to compute transfer credit acceptance rates."
    - name: "avg_awarded_credit_hours"
      expr: AVG(CAST(awarded_credit_hours AS DOUBLE))
      comment: "Average credit hours awarded per transfer credit evaluation. Indicates typical transfer credit value and articulation agreement generosity."
    - name: "approved_evaluations"
      expr: COUNT(CASE WHEN evaluation_status = 'Approved' THEN transfer_credit_id END)
      comment: "Total number of approved transfer credit evaluations. Used to compute approval rates and assess articulation agreement effectiveness."
    - name: "denied_evaluations"
      expr: COUNT(CASE WHEN evaluation_status = 'Denied' THEN transfer_credit_id END)
      comment: "Total number of denied transfer credit evaluations. Used to identify denial patterns and inform articulation agreement expansion."
    - name: "evaluations_with_appeal"
      expr: COUNT(CASE WHEN appeal_status IS NOT NULL AND appeal_status <> '' THEN transfer_credit_id END)
      comment: "Number of transfer credit evaluations with an associated appeal. Tracks appeal volume as an indicator of student dissatisfaction with evaluation decisions."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`student_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Student hold KPIs measuring hold volume, financial exposure, block types, and resolution rates. Used by the registrar, student accounts, and compliance to manage enrollment barriers, financial obligations, and regulatory holds."
  source: "`education_ecm`.`student`.`hold`"
  dimensions:
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold placed on the student account (e.g., Financial, Academic, Administrative, Compliance). Primary dimension for hold categorization and root cause analysis."
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the hold (e.g., Active, Released, Expired). Used to segment active vs. resolved holds."
    - name: "hold_code"
      expr: hold_code
      comment: "Institutional code identifying the specific hold reason. Used for granular hold analysis and policy compliance tracking."
    - name: "registration_block"
      expr: registration_block
      comment: "Boolean flag indicating whether the hold blocks course registration. Critical dimension for enrollment barrier analysis."
    - name: "diploma_block"
      expr: diploma_block
      comment: "Boolean flag indicating whether the hold blocks diploma release. Used to track graduation barriers."
    - name: "transcript_block"
      expr: transcript_block
      comment: "Boolean flag indicating whether the hold blocks transcript release. Used to monitor compliance with transcript release policies."
    - name: "disbursement_block"
      expr: disbursement_block
      comment: "Boolean flag indicating whether the hold blocks financial aid disbursement. Critical for financial aid compliance and student financial health."
    - name: "system_generated"
      expr: system_generated
      comment: "Boolean flag indicating whether the hold was system-generated vs. manually placed. Used to distinguish automated compliance holds from manual interventions."
    - name: "ipeds_reportable"
      expr: ipeds_reportable
      comment: "Boolean flag indicating whether the hold is reportable to IPEDS. Used for federal compliance reporting."
    - name: "academic_year"
      expr: academic_year
      comment: "Academic year in which the hold was placed. Enables year-over-year hold trend analysis."
    - name: "placed_date_month"
      expr: DATE_TRUNC('MONTH', placed_date)
      comment: "Month the hold was placed. Enables trend analysis of hold placement activity over time."
  measures:
    - name: "total_active_holds"
      expr: COUNT(CASE WHEN hold_status = 'Active' THEN hold_id END)
      comment: "Total number of currently active holds. Primary operational metric for registrar and student accounts to manage enrollment barriers."
    - name: "total_students_with_active_holds"
      expr: COUNT(DISTINCT CASE WHEN hold_status = 'Active' THEN profile_id END)
      comment: "Number of distinct students with at least one active hold. Measures the breadth of enrollment barriers across the student population."
    - name: "total_amount_owed"
      expr: SUM(CAST(amount_owed AS DOUBLE))
      comment: "Total outstanding financial obligation associated with holds. Key metric for student accounts and finance to quantify financial hold exposure."
    - name: "avg_amount_owed"
      expr: AVG(CAST(amount_owed AS DOUBLE))
      comment: "Average financial obligation per hold record. Used to benchmark typical financial hold amounts and identify outliers."
    - name: "registration_blocked_students"
      expr: COUNT(DISTINCT CASE WHEN registration_block = TRUE AND hold_status = 'Active' THEN profile_id END)
      comment: "Number of distinct students currently blocked from registration due to an active hold. Critical enrollment barrier metric for registration period management."
    - name: "diploma_blocked_students"
      expr: COUNT(DISTINCT CASE WHEN diploma_block = TRUE AND hold_status = 'Active' THEN profile_id END)
      comment: "Number of distinct students with an active diploma block. Tracks graduation barriers requiring resolution before degree conferral."
    - name: "disbursement_blocked_students"
      expr: COUNT(DISTINCT CASE WHEN disbursement_block = TRUE AND hold_status = 'Active' THEN profile_id END)
      comment: "Number of distinct students with an active financial aid disbursement block. Critical for financial aid compliance and student financial health monitoring."
    - name: "holds_with_appeal"
      expr: COUNT(CASE WHEN appeal_submitted = TRUE THEN hold_id END)
      comment: "Total number of holds with a submitted appeal. Tracks appeal volume as an indicator of hold dispute activity and policy fairness."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`student_leave_of_absence`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave of absence KPIs measuring leave volume, types, financial aid impact, GPA at leave, and return rates. Used by student affairs, financial aid, and academic affairs to manage student retention risk, Title IV compliance, and re-enrollment planning."
  source: "`education_ecm`.`student`.`leave_of_absence`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave of absence (e.g., Medical, Personal, Military, Academic). Primary dimension for leave analysis by reason category."
    - name: "leave_status"
      expr: leave_status
      comment: "Current status of the leave (e.g., Approved, Pending, Returned, Withdrawn). Used to track leave pipeline and return outcomes."
    - name: "financial_aid_impact_flag"
      expr: financial_aid_impact_flag
      comment: "Boolean flag indicating whether the leave impacts financial aid. Critical for Title IV compliance and financial aid return-to-title-IV calculations."
    - name: "title_iv_compliant_flag"
      expr: title_iv_compliant_flag
      comment: "Boolean flag indicating Title IV compliance for the leave. Used by financial aid to ensure regulatory compliance during student leaves."
    - name: "tuition_refund_eligibility_flag"
      expr: tuition_refund_eligibility_flag
      comment: "Boolean flag indicating whether the student is eligible for a tuition refund upon leave. Used by student accounts for refund processing."
    - name: "re_enrollment_confirmed_flag"
      expr: re_enrollment_confirmed_flag
      comment: "Boolean flag indicating whether the student has confirmed re-enrollment after leave. Key retention metric for student affairs."
    - name: "sap_clock_stopped_flag"
      expr: sap_clock_stopped_flag
      comment: "Boolean flag indicating whether the SAP clock was stopped during the leave. Used for financial aid SAP compliance tracking."
    - name: "ipeds_reportable_flag"
      expr: ipeds_reportable_flag
      comment: "Boolean flag indicating whether the leave is reportable to IPEDS. Used for federal enrollment reporting accuracy."
    - name: "leave_start_date_month"
      expr: DATE_TRUNC('MONTH', leave_start_date)
      comment: "Month the leave of absence began. Enables trend analysis of leave volume over time."
    - name: "expected_return_term"
      expr: expected_return_term
      comment: "Expected term of student return from leave. Used for re-enrollment planning and capacity forecasting."
  measures:
    - name: "total_leaves_of_absence"
      expr: COUNT(leave_of_absence_id)
      comment: "Total number of leave of absence records. Baseline volume metric for student affairs workload and retention risk monitoring."
    - name: "total_students_on_leave"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total number of distinct students who have taken a leave of absence. Used to assess the scale of leave activity and its impact on enrollment headcount."
    - name: "avg_gpa_at_leave"
      expr: AVG(CAST(gpa_at_leave AS DOUBLE))
      comment: "Average GPA of students at the time of leave. Indicates academic health of students taking leave and informs early intervention strategies."
    - name: "avg_credits_earned_at_leave"
      expr: AVG(CAST(credits_earned_at_leave AS DOUBLE))
      comment: "Average credit hours earned by students at the time of leave. Used to assess academic progress of students taking leave and estimate re-enrollment readiness."
    - name: "total_tuition_refund_percentage"
      expr: AVG(CAST(tuition_refund_percentage AS DOUBLE))
      comment: "Average tuition refund percentage for leave-eligible students. Used by finance to estimate tuition refund liability associated with leaves of absence."
    - name: "students_with_financial_aid_impact"
      expr: COUNT(DISTINCT CASE WHEN financial_aid_impact_flag = TRUE THEN profile_id END)
      comment: "Number of distinct students whose leave impacts financial aid. Critical for Title IV compliance monitoring and return-to-title-IV calculation workload."
    - name: "students_confirmed_returning"
      expr: COUNT(DISTINCT CASE WHEN re_enrollment_confirmed_flag = TRUE THEN profile_id END)
      comment: "Number of distinct students who have confirmed re-enrollment after leave. Key retention recovery metric for student affairs and enrollment management."
    - name: "title_iv_non_compliant_leaves"
      expr: COUNT(CASE WHEN title_iv_compliant_flag = FALSE THEN leave_of_absence_id END)
      comment: "Number of leave records that are not Title IV compliant. Flags regulatory risk requiring immediate financial aid office intervention."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`student_disability_accommodation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disability accommodation KPIs measuring accommodation volume, types, ADA/504 eligibility, delivery status, and renewal compliance. Used by disability services, compliance, and academic affairs to ensure equitable access, regulatory compliance, and accommodation delivery effectiveness."
  source: "`education_ecm`.`student`.`disability_accommodation`"
  dimensions:
    - name: "accommodation_type"
      expr: accommodation_type
      comment: "Type of accommodation provided (e.g., Extended Time, Note-Taking, Captioning). Primary dimension for accommodation demand analysis."
    - name: "disability_category"
      expr: disability_category
      comment: "Category of disability associated with the accommodation (e.g., Physical, Learning, Psychological). Used for disability services program planning."
    - name: "disability_accommodation_status"
      expr: disability_accommodation_status
      comment: "Current status of the accommodation (e.g., Active, Expired, Pending, Denied). Used to track accommodation pipeline and compliance."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Status of accommodation delivery to the student (e.g., Delivered, Pending, Not Delivered). Used to monitor accommodation fulfillment rates."
    - name: "ada_eligible_flag"
      expr: ada_eligible_flag
      comment: "Boolean flag indicating ADA eligibility for the accommodation. Used for ADA compliance reporting and legal risk management."
    - name: "section_504_eligible_flag"
      expr: section_504_eligible_flag
      comment: "Boolean flag indicating Section 504 eligibility. Used for Section 504 compliance reporting alongside ADA."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the accommodation is currently active. Used to filter to currently active accommodations for operational reporting."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Boolean flag indicating whether the accommodation requires periodic renewal. Used to manage renewal workload and compliance deadlines."
    - name: "documentation_status"
      expr: documentation_status
      comment: "Status of supporting documentation for the accommodation (e.g., Received, Pending, Expired). Used to track documentation compliance."
  measures:
    - name: "total_accommodations"
      expr: COUNT(disability_accommodation_id)
      comment: "Total number of disability accommodation records. Baseline volume metric for disability services workload and program scale."
    - name: "total_students_with_accommodations"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total number of distinct students with disability accommodations. Used to assess the scale of the disability services population and resource planning."
    - name: "active_accommodations"
      expr: COUNT(CASE WHEN is_active = TRUE THEN disability_accommodation_id END)
      comment: "Total number of currently active accommodations. Operational metric for disability services to manage current accommodation delivery workload."
    - name: "avg_extended_time_multiplier"
      expr: AVG(CAST(extended_time_multiplier AS DOUBLE))
      comment: "Average extended time multiplier across accommodations. Used to assess the typical testing time extension granted and its impact on exam scheduling."
    - name: "accommodations_pending_renewal"
      expr: COUNT(CASE WHEN renewal_required_flag = TRUE AND is_active = TRUE THEN disability_accommodation_id END)
      comment: "Number of active accommodations requiring renewal. Used by disability services to manage renewal compliance deadlines and prevent lapses."
    - name: "ada_eligible_students"
      expr: COUNT(DISTINCT CASE WHEN ada_eligible_flag = TRUE THEN profile_id END)
      comment: "Number of distinct students with ADA-eligible accommodations. Used for ADA compliance reporting and legal risk management."
    - name: "accommodations_not_delivered"
      expr: COUNT(CASE WHEN delivery_status = 'Not Delivered' THEN disability_accommodation_id END)
      comment: "Number of accommodations not yet delivered to the student. Critical compliance metric — undelivered accommodations represent legal and equity risk."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`student_visa_immigration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "International student visa and immigration KPIs measuring SEVIS compliance, visa status, employment authorization, and reporting deadlines. Used by the Designated School Official (DSO), international student services, and compliance to manage SEVIS obligations and regulatory risk."
  source: "`education_ecm`.`student`.`visa_immigration`"
  dimensions:
    - name: "visa_type"
      expr: visa_type
      comment: "Type of student visa (e.g., F-1, J-1, M-1). Primary dimension for international student population segmentation and SEVIS reporting."
    - name: "visa_status"
      expr: visa_status
      comment: "Current status of the student's visa (e.g., Active, Expired, Terminated, Completed). Used to monitor visa compliance across the international student population."
    - name: "sevis_status"
      expr: sevis_status
      comment: "Current SEVIS record status (e.g., Active, Terminated, Completed, Deferred). Primary compliance dimension for DSO reporting obligations."
    - name: "country_of_citizenship"
      expr: country_of_citizenship
      comment: "Country of citizenship of the international student. Used for geographic diversity analysis and country-level compliance tracking."
    - name: "full_course_of_study_compliant"
      expr: full_course_of_study_compliant
      comment: "Boolean flag indicating whether the student is maintaining full course of study as required by visa regulations. Critical SEVIS compliance indicator."
    - name: "off_campus_employment_authorized"
      expr: off_campus_employment_authorized
      comment: "Boolean flag indicating off-campus employment authorization. Used to track CPT/OPT authorization compliance."
    - name: "on_campus_employment_authorized"
      expr: on_campus_employment_authorized
      comment: "Boolean flag indicating on-campus employment authorization. Used to monitor on-campus employment eligibility compliance."
    - name: "transfer_pending"
      expr: transfer_pending
      comment: "Boolean flag indicating a pending SEVIS transfer to another institution. Used to manage transfer release timelines and SEVIS record handoffs."
    - name: "reduced_course_load_authorized"
      expr: reduced_course_load_authorized
      comment: "Boolean flag indicating authorization for a reduced course load. Used to track exceptions to full course of study requirements."
    - name: "opt_type"
      expr: opt_type
      comment: "Type of Optional Practical Training authorization (e.g., Pre-Completion, Post-Completion, STEM Extension). Used to analyze OPT utilization patterns."
    - name: "visa_issue_date_year"
      expr: DATE_TRUNC('YEAR', visa_issue_date)
      comment: "Year of visa issuance. Enables year-over-year trend analysis of international student visa issuance."
  measures:
    - name: "total_international_students"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total number of distinct international students with visa/immigration records. Baseline headcount for international student services and SEVIS reporting."
    - name: "total_visa_records"
      expr: COUNT(visa_immigration_id)
      comment: "Total number of visa and immigration records. Used to track SEVIS record volume and DSO workload."
    - name: "students_not_full_course_compliant"
      expr: COUNT(DISTINCT CASE WHEN full_course_of_study_compliant = FALSE THEN profile_id END)
      comment: "Number of distinct international students not maintaining full course of study. Critical SEVIS compliance risk metric requiring immediate DSO intervention."
    - name: "students_with_opt_authorization"
      expr: COUNT(DISTINCT CASE WHEN opt_authorization_start_date IS NOT NULL THEN profile_id END)
      comment: "Number of distinct students with OPT authorization. Used to track OPT utilization rates and post-graduation employment outcomes."
    - name: "students_with_cpt_authorization"
      expr: COUNT(DISTINCT CASE WHEN cpt_authorization_start_date IS NOT NULL THEN profile_id END)
      comment: "Number of distinct students with CPT authorization. Used to monitor curricular practical training utilization and compliance."
    - name: "total_sevis_fee_collected"
      expr: SUM(CAST(sevis_fee_amount AS DOUBLE))
      comment: "Total SEVIS fee amounts collected from international students. Used by finance to track SEVIS fee revenue and ensure fee payment compliance."
    - name: "students_with_pending_transfer"
      expr: COUNT(DISTINCT CASE WHEN transfer_pending = TRUE THEN profile_id END)
      comment: "Number of distinct students with a pending SEVIS transfer. Used by the DSO to manage transfer release timelines and prevent SEVIS record gaps."
    - name: "students_with_expired_visa"
      expr: COUNT(DISTINCT CASE WHEN visa_expiration_date < CURRENT_DATE() THEN profile_id END)
      comment: "Number of distinct students with an expired visa. Critical compliance risk metric for international student services and immigration compliance."
$$;