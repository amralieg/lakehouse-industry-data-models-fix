-- Metric views for domain: student | Business: Education | Version: 1 | Generated on: 2026-05-06 12:16:12

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`student_academic_standing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Academic standing and satisfactory academic progress (SAP) metrics tracking student performance against institutional and Title IV eligibility thresholds"
  source: "`education_ecm`.`student`.`academic_standing`"
  dimensions:
    - name: "institutional_standing"
      expr: institutional_standing
      comment: "Current academic standing classification (Good Standing, Probation, Suspension, etc.)"
    - name: "sap_status"
      expr: sap_status
      comment: "Satisfactory Academic Progress status for financial aid eligibility"
    - name: "evaluation_year"
      expr: YEAR(evaluation_date)
      comment: "Year when academic standing was evaluated"
    - name: "evaluation_quarter"
      expr: CONCAT('Q', QUARTER(evaluation_date))
      comment: "Quarter when academic standing was evaluated"
    - name: "gpa_threshold_met_flag"
      expr: gpa_threshold_met
      comment: "Whether student met minimum GPA threshold"
    - name: "pace_threshold_met_flag"
      expr: pace_threshold_met
      comment: "Whether student met pace of completion threshold"
    - name: "title_iv_eligible_flag"
      expr: title_iv_eligible
      comment: "Whether student is eligible for Title IV federal financial aid"
    - name: "academic_plan_required_flag"
      expr: academic_plan_required
      comment: "Whether student is required to submit an academic improvement plan"
    - name: "appeal_submitted_flag"
      expr: appeal_submitted
      comment: "Whether student submitted an appeal of their standing determination"
  measures:
    - name: "total_students_evaluated"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of students with academic standing evaluations"
    - name: "avg_cumulative_gpa"
      expr: AVG(CAST(cumulative_gpa AS DOUBLE))
      comment: "Average cumulative GPA across evaluated students"
    - name: "avg_term_gpa"
      expr: AVG(CAST(term_gpa AS DOUBLE))
      comment: "Average term GPA for the evaluation period"
    - name: "avg_completion_rate"
      expr: AVG(CAST(completion_rate AS DOUBLE))
      comment: "Average completion rate (credits earned / credits attempted) as percentage"
    - name: "total_cumulative_credits_attempted"
      expr: SUM(CAST(cumulative_credits_attempted AS DOUBLE))
      comment: "Total cumulative credits attempted across all evaluated students"
    - name: "total_cumulative_credits_earned"
      expr: SUM(CAST(cumulative_credits_earned AS DOUBLE))
      comment: "Total cumulative credits earned across all evaluated students"
    - name: "title_iv_eligibility_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN title_iv_eligible = True THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of evaluated students eligible for Title IV federal financial aid"
    - name: "gpa_threshold_pass_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gpa_threshold_met = True THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of students meeting minimum GPA threshold"
    - name: "pace_threshold_pass_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pace_threshold_met = True THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of students meeting pace of completion threshold"
    - name: "academic_plan_requirement_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN academic_plan_required = True THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of students required to submit academic improvement plans"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`student_academic_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Course completion and academic performance metrics tracking student progress through curriculum"
  source: "`education_ecm`.`student`.`academic_history`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Course completion status (Completed, In Progress, Withdrawn, etc.)"
    - name: "grade_earned"
      expr: grade_earned
      comment: "Letter grade earned in the course"
    - name: "academic_level"
      expr: academic_level
      comment: "Academic level of the student (Freshman, Sophomore, Junior, Senior, Graduate)"
    - name: "course_level"
      expr: course_level
      comment: "Course level classification (100-level, 200-level, etc.)"
    - name: "subject_code"
      expr: subject_code
      comment: "Academic subject or discipline code"
    - name: "grading_mode"
      expr: grading_mode
      comment: "Grading mode (Letter Grade, Pass/Fail, Audit, etc.)"
    - name: "course_delivery_mode"
      expr: course_delivery_mode
      comment: "Course delivery method (In-Person, Online, Hybrid, etc.)"
    - name: "registration_status"
      expr: registration_status
      comment: "Registration status for the course"
    - name: "transfer_credit_flag"
      expr: transfer_credit_indicator
      comment: "Whether this is transfer credit from another institution"
    - name: "honors_course_flag"
      expr: honors_course_flag
      comment: "Whether this is an honors-level course"
    - name: "online_course_flag"
      expr: online_course_flag
      comment: "Whether this course was delivered online"
    - name: "repeat_flag"
      expr: repeat_indicator
      comment: "Whether this is a repeated course attempt"
    - name: "grade_change_year"
      expr: YEAR(grade_change_date)
      comment: "Year when grade was changed (if applicable)"
  measures:
    - name: "total_course_enrollments"
      expr: COUNT(1)
      comment: "Total number of course enrollment records"
    - name: "total_students"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of students with academic history"
    - name: "total_credit_hours_attempted"
      expr: SUM(CAST(credit_hours_attempted AS DOUBLE))
      comment: "Total credit hours attempted across all enrollments"
    - name: "total_credit_hours_earned"
      expr: SUM(CAST(credit_hours_earned AS DOUBLE))
      comment: "Total credit hours successfully earned"
    - name: "total_grade_points"
      expr: SUM(CAST(grade_points AS DOUBLE))
      comment: "Total grade points earned across all courses"
    - name: "total_quality_points"
      expr: SUM(CAST(quality_points AS DOUBLE))
      comment: "Total quality points for GPA calculation"
    - name: "avg_credit_hours_per_enrollment"
      expr: AVG(CAST(credit_hours_attempted AS DOUBLE))
      comment: "Average credit hours per course enrollment"
    - name: "course_completion_rate"
      expr: ROUND(100.0 * SUM(CAST(credit_hours_earned AS DOUBLE)) / NULLIF(SUM(CAST(credit_hours_attempted AS DOUBLE)), 0), 2)
      comment: "Percentage of attempted credit hours that were successfully earned"
    - name: "honors_course_participation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN honors_course_flag = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of course enrollments that are honors-level"
    - name: "online_course_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN online_course_flag = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of course enrollments delivered online"
    - name: "course_repeat_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN repeat_indicator = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of course enrollments that are repeat attempts"
    - name: "transfer_credit_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN transfer_credit_indicator = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of course records that are transfer credits"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`student_enrollment_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Student enrollment intensity, status, and full-time equivalency (FTE) metrics for institutional planning and IPEDS reporting"
  source: "`education_ecm`.`student`.`enrollment_status`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (Active, Withdrawn, Graduated, Leave of Absence, etc.)"
    - name: "enrollment_intensity"
      expr: enrollment_intensity
      comment: "Enrollment intensity classification (Full-Time, Part-Time, Less than Half-Time)"
    - name: "enrollment_level"
      expr: enrollment_level
      comment: "Academic level of enrollment (Undergraduate, Graduate, Professional, etc.)"
    - name: "academic_standing"
      expr: academic_standing
      comment: "Academic standing classification"
    - name: "term_code"
      expr: term_code
      comment: "Academic term code"
    - name: "cohort_year"
      expr: cohort_year
      comment: "Student cohort year for retention tracking"
    - name: "degree_seeking_flag"
      expr: degree_seeking_indicator
      comment: "Whether student is seeking a degree"
    - name: "ftiac_flag"
      expr: ftiac_indicator
      comment: "First-Time In Any College indicator for IPEDS reporting"
    - name: "financial_aid_recipient_flag"
      expr: financial_aid_recipient_indicator
      comment: "Whether student is receiving financial aid"
    - name: "athlete_flag"
      expr: athlete_indicator
      comment: "Whether student is a varsity athlete"
    - name: "honors_program_flag"
      expr: honors_program_indicator
      comment: "Whether student is enrolled in honors program"
    - name: "veteran_status_flag"
      expr: veteran_status_indicator
      comment: "Whether student is a military veteran"
    - name: "residency_status"
      expr: residency_status
      comment: "Residency classification for tuition purposes"
    - name: "housing_status"
      expr: housing_status
      comment: "Student housing status (On-Campus, Off-Campus, Commuter)"
    - name: "ipeds_enrollment_category"
      expr: ipeds_enrollment_category
      comment: "IPEDS enrollment category for federal reporting"
    - name: "sap_status"
      expr: sap_status
      comment: "Satisfactory Academic Progress status"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of enrollment"
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment"
  measures:
    - name: "total_enrolled_students"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of enrolled students"
    - name: "total_enrollment_records"
      expr: COUNT(1)
      comment: "Total number of enrollment status records"
    - name: "total_fte"
      expr: SUM(CAST(fte_value AS DOUBLE))
      comment: "Total full-time equivalency across all enrolled students"
    - name: "avg_fte_per_student"
      expr: AVG(CAST(fte_value AS DOUBLE))
      comment: "Average FTE value per student enrollment"
    - name: "total_credit_hours_enrolled"
      expr: SUM(CAST(credit_hours_enrolled AS DOUBLE))
      comment: "Total credit hours enrolled across all students"
    - name: "total_credit_hours_attempted"
      expr: SUM(CAST(credit_hours_attempted AS DOUBLE))
      comment: "Total credit hours attempted across all students"
    - name: "avg_credit_hours_per_student"
      expr: AVG(CAST(credit_hours_enrolled AS DOUBLE))
      comment: "Average credit hours enrolled per student"
    - name: "full_time_enrollment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN enrollment_intensity = 'Full-Time' THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of students enrolled full-time"
    - name: "degree_seeking_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN degree_seeking_indicator = True THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of students who are degree-seeking"
    - name: "financial_aid_recipient_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN financial_aid_recipient_indicator = True THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of students receiving financial aid"
    - name: "ftiac_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN ftiac_indicator = True THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of students who are first-time in any college (IPEDS metric)"
    - name: "veteran_enrollment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN veteran_status_indicator = True THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of students who are military veterans"
    - name: "honors_program_participation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN honors_program_indicator = True THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of students enrolled in honors programs"
    - name: "on_campus_housing_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN housing_status = 'On-Campus' THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of students living in on-campus housing"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`student_cohort_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Student cohort tracking and IPEDS completion metrics for retention, persistence, and graduation rate analysis"
  source: "`education_ecm`.`student`.`cohort_membership`"
  dimensions:
    - name: "cohort_type"
      expr: cohort_type
      comment: "Type of cohort (IPEDS, Retention, Custom, etc.)"
    - name: "cohort_year"
      expr: cohort_year
      comment: "Year the cohort was established"
    - name: "cohort_code"
      expr: cohort_code
      comment: "Unique cohort identifier code"
    - name: "membership_status"
      expr: membership_status
      comment: "Current cohort membership status (Active, Graduated, Withdrawn, etc.)"
    - name: "reporting_framework"
      expr: reporting_framework
      comment: "Reporting framework (IPEDS, State, Institutional)"
    - name: "ipeds_submission_year"
      expr: ipeds_submission_year
      comment: "IPEDS submission year for federal reporting"
    - name: "first_time_flag"
      expr: first_time_flag
      comment: "Whether student was first-time at entry"
    - name: "full_time_status_flag"
      expr: full_time_status_flag
      comment: "Whether student was full-time at cohort entry"
    - name: "degree_seeking_flag"
      expr: degree_seeking_flag
      comment: "Whether student was degree-seeking at entry"
    - name: "pell_recipient_flag"
      expr: pell_recipient_flag
      comment: "Whether student received Pell Grant at entry"
    - name: "subsidized_loan_recipient_flag"
      expr: subsidized_loan_recipient_flag
      comment: "Whether student received subsidized loan at entry"
    - name: "ipeds_cohort_flag"
      expr: ipeds_cohort_flag
      comment: "Whether this is an IPEDS-reportable cohort"
    - name: "entry_year"
      expr: YEAR(entry_date)
      comment: "Year student entered the cohort"
    - name: "graduation_year"
      expr: YEAR(graduation_date)
      comment: "Year student graduated (if applicable)"
  measures:
    - name: "total_cohort_members"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of students in cohorts"
    - name: "total_cohort_records"
      expr: COUNT(1)
      comment: "Total number of cohort membership records"
    - name: "graduation_rate_100pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN completion_within_100_pct_flag = True THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of cohort completing within 100% of normal time (IPEDS metric)"
    - name: "graduation_rate_150pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN completion_within_150_pct_flag = True THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of cohort completing within 150% of normal time (IPEDS metric)"
    - name: "graduation_rate_200pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN completion_within_200_pct_flag = True THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of cohort completing within 200% of normal time (IPEDS metric)"
    - name: "retention_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN retention_flag = True THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of cohort retained to next period"
    - name: "persistence_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN persistence_flag = True THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of cohort persisting in enrollment"
    - name: "pell_recipient_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pell_recipient_flag = True THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of cohort who were Pell Grant recipients at entry"
    - name: "subsidized_loan_recipient_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN subsidized_loan_recipient_flag = True THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of cohort who received subsidized loans at entry"
    - name: "full_time_cohort_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN full_time_status_flag = True THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of cohort who were full-time at entry"
    - name: "first_time_cohort_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN first_time_flag = True THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of cohort who were first-time students at entry"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`student_degree_conferral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Degree completion and conferral metrics tracking graduation outcomes, honors, and IPEDS reporting"
  source: "`education_ecm`.`student`.`degree_conferral`"
  dimensions:
    - name: "degree_level"
      expr: degree_level
      comment: "Level of degree conferred (Associate, Bachelor, Master, Doctoral, etc.)"
    - name: "degree_type"
      expr: degree_type
      comment: "Type of degree (BA, BS, MA, MS, PhD, etc.)"
    - name: "degree_code"
      expr: degree_code
      comment: "Institutional degree code"
    - name: "major"
      expr: major
      comment: "Primary major field of study"
    - name: "concentration"
      expr: concentration
      comment: "Degree concentration or specialization"
    - name: "cip_code"
      expr: cip_code
      comment: "Classification of Instructional Programs (CIP) code for federal reporting"
    - name: "conferring_college"
      expr: conferring_college
      comment: "College or school conferring the degree"
    - name: "conferring_department"
      expr: conferring_department
      comment: "Department conferring the degree"
    - name: "honors_designation"
      expr: honors_designation
      comment: "Latin honors designation (Summa Cum Laude, Magna Cum Laude, Cum Laude)"
    - name: "conferral_academic_year"
      expr: conferral_academic_year
      comment: "Academic year of degree conferral"
    - name: "conferral_term_code"
      expr: conferral_term_code
      comment: "Term code when degree was conferred"
    - name: "application_status"
      expr: application_status
      comment: "Status of graduation application"
    - name: "commencement_participation_flag"
      expr: commencement_participation_flag
      comment: "Whether student participated in commencement ceremony"
    - name: "ipeds_reportable_flag"
      expr: ipeds_reportable_flag
      comment: "Whether degree is reportable to IPEDS"
    - name: "diploma_hold_flag"
      expr: diploma_hold_flag
      comment: "Whether diploma is on hold"
    - name: "conferral_year"
      expr: YEAR(conferral_date)
      comment: "Year degree was conferred"
    - name: "conferral_month"
      expr: DATE_TRUNC('month', conferral_date)
      comment: "Month degree was conferred"
  measures:
    - name: "total_degrees_conferred"
      expr: COUNT(1)
      comment: "Total number of degrees conferred"
    - name: "total_graduates"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of students who received degrees"
    - name: "avg_gpa_at_conferral"
      expr: AVG(CAST(gpa_at_conferral AS DOUBLE))
      comment: "Average GPA at time of degree conferral"
    - name: "total_institutional_credits_earned"
      expr: SUM(CAST(institutional_credits_earned AS DOUBLE))
      comment: "Total institutional credits earned by graduates"
    - name: "total_credits_earned"
      expr: SUM(CAST(total_credits_earned AS DOUBLE))
      comment: "Total credits earned (including transfer) by graduates"
    - name: "avg_institutional_credits_per_graduate"
      expr: AVG(CAST(institutional_credits_earned AS DOUBLE))
      comment: "Average institutional credits earned per graduate"
    - name: "avg_total_credits_per_graduate"
      expr: AVG(CAST(total_credits_earned AS DOUBLE))
      comment: "Average total credits earned per graduate"
    - name: "honors_designation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN honors_designation IS NOT NULL AND honors_designation != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of degrees conferred with Latin honors designation"
    - name: "commencement_participation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN commencement_participation_flag = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of graduates who participated in commencement ceremony"
    - name: "ipeds_reportable_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ipeds_reportable_flag = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of degrees reportable to IPEDS"
    - name: "diploma_hold_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN diploma_hold_flag = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of degrees with diploma holds"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`student_early_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Early alert and intervention metrics tracking at-risk student identification, outreach effectiveness, and retention outcomes"
  source: "`education_ecm`.`student`.`student_early_alert`"
  dimensions:
    - name: "alert_type"
      expr: alert_type
      comment: "Type of early alert (Academic, Attendance, Behavioral, Financial, etc.)"
    - name: "alert_subtype"
      expr: alert_subtype
      comment: "Subtype or specific category of alert"
    - name: "alert_source"
      expr: alert_source
      comment: "Source system or person who generated the alert"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level classification (Low, Medium, High, Critical)"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the alert"
    - name: "outcome_category"
      expr: outcome_category
      comment: "Outcome category of the intervention"
    - name: "triggering_metric"
      expr: triggering_metric
      comment: "Metric or threshold that triggered the alert"
    - name: "priority_flag"
      expr: priority_flag
      comment: "Whether alert is marked as priority"
    - name: "follow_up_required_flag"
      expr: follow_up_required
      comment: "Whether follow-up action is required"
    - name: "retained_next_term_flag"
      expr: retained_next_term
      comment: "Whether student was retained to next term after intervention"
    - name: "alert_year"
      expr: YEAR(alert_date)
      comment: "Year alert was generated"
    - name: "alert_month"
      expr: DATE_TRUNC('month', alert_date)
      comment: "Month alert was generated"
    - name: "course_subject_code"
      expr: course_subject_code
      comment: "Subject code of course related to alert"
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total number of early alerts generated"
    - name: "total_students_alerted"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of students who received early alerts"
    - name: "avg_metric_value"
      expr: AVG(CAST(metric_value AS DOUBLE))
      comment: "Average value of the triggering metric"
    - name: "avg_term_gpa_post_intervention"
      expr: AVG(CAST(term_gpa_post_intervention AS DOUBLE))
      comment: "Average term GPA after intervention"
    - name: "alert_resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_status IN ('Resolved', 'Closed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts that have been resolved or closed"
    - name: "first_contact_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN first_contact_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts where first contact was made with student"
    - name: "retention_rate_post_alert"
      expr: ROUND(100.0 * COUNT(CASE WHEN retained_next_term = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerted students retained to next term (intervention effectiveness)"
    - name: "high_risk_alert_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_level IN ('High', 'Critical') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts classified as high or critical risk"
    - name: "priority_alert_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN priority_flag = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts marked as priority"
    - name: "avg_alerts_per_student"
      expr: ROUND(CAST(COUNT(1) AS DOUBLE) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Average number of alerts per student"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`student_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Student hold and restriction metrics tracking registration blocks, financial holds, and hold resolution effectiveness"
  source: "`education_ecm`.`student`.`hold`"
  dimensions:
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold (Financial, Academic, Administrative, Disciplinary, etc.)"
    - name: "hold_code"
      expr: hold_code
      comment: "Specific hold code"
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of hold (Active, Released, Expired)"
    - name: "originating_office"
      expr: originating_office
      comment: "Office or department that placed the hold"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the hold"
    - name: "registration_block_flag"
      expr: registration_block
      comment: "Whether hold blocks registration"
    - name: "transcript_block_flag"
      expr: transcript_block
      comment: "Whether hold blocks transcript release"
    - name: "diploma_block_flag"
      expr: diploma_block
      comment: "Whether hold blocks diploma release"
    - name: "grade_block_flag"
      expr: grade_block
      comment: "Whether hold blocks grade access"
    - name: "disbursement_block_flag"
      expr: disbursement_block
      comment: "Whether hold blocks financial aid disbursement"
    - name: "system_generated_flag"
      expr: system_generated
      comment: "Whether hold was automatically generated by system"
    - name: "override_allowed_flag"
      expr: override_allowed
      comment: "Whether hold can be overridden"
    - name: "appeal_submitted_flag"
      expr: appeal_submitted
      comment: "Whether student submitted an appeal"
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of hold appeal"
    - name: "placed_year"
      expr: YEAR(placed_date)
      comment: "Year hold was placed"
    - name: "released_year"
      expr: YEAR(released_date)
      comment: "Year hold was released"
    - name: "term_code"
      expr: term_code
      comment: "Academic term associated with hold"
  measures:
    - name: "total_holds"
      expr: COUNT(1)
      comment: "Total number of holds placed"
    - name: "total_students_with_holds"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of students with holds"
    - name: "total_amount_owed"
      expr: SUM(CAST(amount_owed AS DOUBLE))
      comment: "Total amount owed across all financial holds"
    - name: "avg_amount_owed_per_hold"
      expr: AVG(CAST(amount_owed AS DOUBLE))
      comment: "Average amount owed per financial hold"
    - name: "hold_release_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hold_status = 'Released' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds that have been released"
    - name: "registration_block_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN registration_block = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds that block registration"
    - name: "transcript_block_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN transcript_block = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds that block transcript release"
    - name: "diploma_block_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN diploma_block = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds that block diploma release"
    - name: "disbursement_block_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN disbursement_block = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds that block financial aid disbursement"
    - name: "system_generated_hold_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN system_generated = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds that were system-generated"
    - name: "appeal_submission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_submitted = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds where student submitted an appeal"
    - name: "avg_holds_per_student"
      expr: ROUND(CAST(COUNT(1) AS DOUBLE) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Average number of holds per student"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`student_transfer_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transfer credit evaluation and articulation metrics tracking credit acceptance, equivalency, and transfer student success"
  source: "`education_ecm`.`student`.`transfer_credit`"
  dimensions:
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Status of transfer credit evaluation (Pending, Approved, Denied, etc.)"
    - name: "transfer_credit_type"
      expr: transfer_credit_type
      comment: "Type of transfer credit (Course, Exam, Military, etc.)"
    - name: "source_institution_name"
      expr: source_institution_name
      comment: "Name of institution where credit was earned"
    - name: "source_credit_type"
      expr: source_credit_type
      comment: "Type of credit at source institution"
    - name: "equivalent_credit_category"
      expr: equivalent_credit_category
      comment: "Category of equivalent credit at receiving institution"
    - name: "general_education_area"
      expr: general_education_area
      comment: "General education area satisfied by transfer credit"
    - name: "applies_to_gpa_flag"
      expr: applies_to_gpa
      comment: "Whether transfer credit applies to GPA calculation"
    - name: "applies_to_residency_requirement_flag"
      expr: applies_to_residency_requirement
      comment: "Whether transfer credit applies to residency requirement"
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of transfer credit appeal"
    - name: "denial_reason"
      expr: denial_reason
      comment: "Reason for denial of transfer credit"
    - name: "transcript_type"
      expr: transcript_type
      comment: "Type of transcript received (Official, Unofficial)"
    - name: "evaluation_year"
      expr: YEAR(evaluation_date)
      comment: "Year transfer credit was evaluated"
    - name: "posted_year"
      expr: YEAR(posted_date)
      comment: "Year transfer credit was posted to student record"
  measures:
    - name: "total_transfer_credit_records"
      expr: COUNT(1)
      comment: "Total number of transfer credit evaluation records"
    - name: "total_transfer_students"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of students with transfer credit"
    - name: "total_source_credit_hours"
      expr: SUM(CAST(source_credit_hours AS DOUBLE))
      comment: "Total credit hours from source institutions"
    - name: "total_awarded_credit_hours"
      expr: SUM(CAST(awarded_credit_hours AS DOUBLE))
      comment: "Total credit hours awarded by receiving institution"
    - name: "avg_source_credit_hours_per_student"
      expr: AVG(CAST(source_credit_hours AS DOUBLE))
      comment: "Average source credit hours per transfer evaluation"
    - name: "avg_awarded_credit_hours_per_student"
      expr: AVG(CAST(awarded_credit_hours AS DOUBLE))
      comment: "Average awarded credit hours per transfer evaluation"
    - name: "transfer_credit_acceptance_rate"
      expr: ROUND(100.0 * SUM(CAST(awarded_credit_hours AS DOUBLE)) / NULLIF(SUM(CAST(source_credit_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of source credit hours accepted as transfer credit (credit yield)"
    - name: "evaluation_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN evaluation_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfer credit evaluations approved"
    - name: "gpa_applicable_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN applies_to_gpa = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfer credits that apply to GPA"
    - name: "residency_applicable_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN applies_to_residency_requirement = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfer credits that apply to residency requirement"
    - name: "appeal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_status IS NOT NULL AND appeal_status != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfer credit evaluations that were appealed"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`student_disability_accommodation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disability services and accommodation metrics tracking ADA compliance, accommodation delivery, and student support effectiveness"
  source: "`education_ecm`.`student`.`disability_accommodation`"
  dimensions:
    - name: "accommodation_type"
      expr: accommodation_type
      comment: "Type of accommodation provided"
    - name: "disability_category"
      expr: disability_category
      comment: "Category of disability"
    - name: "disability_accommodation_status"
      expr: disability_accommodation_status
      comment: "Current status of accommodation"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of accommodation"
    - name: "documentation_status"
      expr: documentation_status
      comment: "Status of disability documentation"
    - name: "ada_eligible_flag"
      expr: ada_eligible_flag
      comment: "Whether student is ADA-eligible"
    - name: "section_504_eligible_flag"
      expr: section_504_eligible_flag
      comment: "Whether student is Section 504-eligible"
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Whether accommodation requires periodic renewal"
    - name: "is_active_flag"
      expr: is_active
      comment: "Whether accommodation is currently active"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year accommodation was approved"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year accommodation became effective"
  measures:
    - name: "total_accommodations"
      expr: COUNT(1)
      comment: "Total number of accommodation records"
    - name: "total_students_with_accommodations"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of students receiving accommodations"
    - name: "avg_extended_time_multiplier"
      expr: AVG(CAST(extended_time_multiplier AS DOUBLE))
      comment: "Average extended time multiplier for testing accommodations"
    - name: "ada_eligibility_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN ada_eligible_flag = True THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of students who are ADA-eligible"
    - name: "section_504_eligibility_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN section_504_eligible_flag = True THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of students who are Section 504-eligible"
    - name: "accommodation_delivery_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_status = 'Delivered' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accommodations successfully delivered"
    - name: "faculty_acknowledgment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN faculty_acknowledgment_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accommodations acknowledged by faculty"
    - name: "documentation_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN documentation_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disability documentation approved"
    - name: "active_accommodation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accommodations currently active"
    - name: "avg_accommodations_per_student"
      expr: ROUND(CAST(COUNT(1) AS DOUBLE) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Average number of accommodations per student"
$$;