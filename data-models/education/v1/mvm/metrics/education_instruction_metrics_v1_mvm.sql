-- Metric views for domain: instruction | Business: Education | Version: 1 | Generated on: 2026-05-06 15:08:33

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_course_section`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and capacity metrics for course sections, enabling academic leadership to monitor enrollment health, fill rates, credit-hour production, and section delivery mix across terms and campuses."
  source: "`education_ecm`.`instruction`.`course_section`"
  dimensions:
    - name: "term_id"
      expr: term_id
      comment: "Foreign key to enrollment term; used to slice all section metrics by academic term."
    - name: "campus_code"
      expr: campus_code
      comment: "Campus identifier enabling multi-campus enrollment and capacity comparisons."
    - name: "delivery_mode"
      expr: delivery_mode
      comment: "Delivery modality (e.g., in-person, online, hybrid) for analyzing enrollment and capacity by instructional format."
    - name: "instructional_method"
      expr: instructional_method
      comment: "Instructional method (e.g., lecture, lab, seminar) for workload and capacity analysis."
    - name: "course_level"
      expr: course_level
      comment: "Course level (e.g., undergraduate, graduate) for stratifying section metrics by academic level."
    - name: "section_status"
      expr: section_status
      comment: "Current status of the section (e.g., open, closed, cancelled) for operational monitoring."
    - name: "grade_mode"
      expr: grade_mode
      comment: "Grading mode (e.g., letter, pass/fail) for academic policy analysis."
    - name: "start_date"
      expr: DATE_TRUNC('month', start_date)
      comment: "Section start month for trend analysis of section offerings over time."
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit (department/college) for departmental section and enrollment reporting."
  measures:
    - name: "total_sections"
      expr: COUNT(DISTINCT course_section_id)
      comment: "Total number of distinct course sections offered; baseline KPI for academic capacity planning."
    - name: "total_enrollment_capacity"
      expr: SUM(CAST(enrollment_capacity AS BIGINT))
      comment: "Aggregate seat capacity across all sections; drives facility and staffing planning decisions. Note: enrollment_capacity is stored as STRING and cast to BIGINT for summation."
    - name: "total_enrollment_actual"
      expr: SUM(CAST(enrollment_actual AS BIGINT))
      comment: "Aggregate actual enrollment across all sections; core metric for revenue and resource allocation. Note: enrollment_actual is stored as STRING and cast to BIGINT."
    - name: "avg_section_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(enrollment_actual AS BIGINT)) / NULLIF(SUM(CAST(enrollment_capacity AS BIGINT)), 0), 2)
      comment: "Average section fill rate as a percentage of capacity; critical KPI for identifying under-enrolled sections and optimizing course offerings."
    - name: "total_credit_hours_offered"
      expr: SUM(CAST(credit_hours AS DOUBLE))
      comment: "Total credit hours offered across all sections; directly tied to tuition revenue potential and IPEDS reporting."
    - name: "avg_credit_hours_per_section"
      expr: AVG(CAST(credit_hours AS DOUBLE))
      comment: "Average credit hours per section; informs workload distribution and curriculum structure decisions."
    - name: "total_contact_hours_offered"
      expr: SUM(CAST(contact_hours AS DOUBLE))
      comment: "Total contact hours offered; used for accreditation compliance and faculty workload reporting."
    - name: "total_tuition_revenue_potential"
      expr: SUM(CAST(tuition_amount AS DOUBLE))
      comment: "Aggregate tuition amount across sections; proxy for gross tuition revenue potential before enrollment adjustments."
    - name: "sections_with_waitlist"
      expr: COUNT(DISTINCT CASE WHEN CAST(waitlist_actual AS BIGINT) > 0 THEN course_section_id END)
      comment: "Number of sections with active waitlist students; signals demand exceeding capacity and informs section expansion decisions."
    - name: "total_waitlist_students"
      expr: SUM(CAST(waitlist_actual AS BIGINT))
      comment: "Total students on waitlists across all sections; quantifies unmet enrollment demand for capacity planning."
    - name: "cancelled_sections_count"
      expr: COUNT(DISTINCT CASE WHEN section_status = 'Cancelled' THEN course_section_id END)
      comment: "Number of cancelled sections; operational KPI for monitoring course delivery reliability and student impact."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_attendance_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Student attendance and engagement metrics enabling early intervention, Title IV compliance monitoring, and academic risk identification at the section and term level."
  source: "`education_ecm`.`instruction`.`attendance_record`"
  dimensions:
    - name: "term_id"
      expr: term_id
      comment: "Academic term for longitudinal attendance trend analysis."
    - name: "course_section_id"
      expr: course_section_id
      comment: "Course section for section-level attendance monitoring."
    - name: "attendance_status"
      expr: attendance_status
      comment: "Attendance status (e.g., present, absent, excused) for disaggregated reporting."
    - name: "attendance_date"
      expr: DATE_TRUNC('week', attendance_date)
      comment: "Week of attendance date for weekly trend analysis and early alert monitoring."
    - name: "recording_method"
      expr: recording_method
      comment: "Method used to record attendance (e.g., manual, LMS, biometric) for data quality auditing."
    - name: "academic_activity_type"
      expr: academic_activity_type
      comment: "Type of academic activity (e.g., lecture, lab, clinical) for attendance analysis by activity type."
    - name: "excuse_reason"
      expr: excuse_reason
      comment: "Reason for excused absence; informs student support and policy compliance analysis."
    - name: "title_iv_eligible_flag"
      expr: title_iv_eligible_flag
      comment: "Indicates Title IV financial aid eligibility; critical for federal compliance attendance reporting."
  measures:
    - name: "total_attendance_records"
      expr: COUNT(1)
      comment: "Total attendance records; baseline volume metric for attendance data completeness monitoring."
    - name: "distinct_students_tracked"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique students with attendance records; measures breadth of attendance monitoring coverage."
    - name: "total_absences"
      expr: COUNT(CASE WHEN attendance_status = 'Absent' THEN 1 END)
      comment: "Total absence events; primary KPI for academic risk and early alert triggering."
    - name: "excused_absence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN attendance_status = 'Absent' AND excuse_documentation_provided = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN attendance_status = 'Absent' THEN 1 END), 0), 2)
      comment: "Percentage of absences that are excused with documentation; informs policy compliance and student support quality."
    - name: "early_alert_trigger_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN early_alert_triggered = TRUE THEN 1 END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of tracked students who triggered an early alert; key retention intervention metric for academic leadership."
    - name: "avg_attendance_percentage_to_date"
      expr: AVG(CAST(attendance_percentage_to_date AS DOUBLE))
      comment: "Average cumulative attendance percentage across all student-section records; headline KPI for academic engagement monitoring."
    - name: "attendance_policy_violation_count"
      expr: COUNT(CASE WHEN attendance_policy_violation = TRUE THEN 1 END)
      comment: "Number of attendance policy violations; drives academic standing reviews and compliance reporting."
    - name: "title_iv_at_risk_students"
      expr: COUNT(DISTINCT CASE WHEN title_iv_eligible_flag = TRUE AND last_date_of_attendance_flag = TRUE THEN profile_id END)
      comment: "Distinct Title IV-eligible students flagged as last date of attendance; critical for federal financial aid compliance and return-of-funds calculations."
    - name: "lms_active_engagement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lms_activity_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attendance records with confirmed LMS activity; measures online engagement as a proxy for student participation in hybrid/online sections."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_final_grade`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Student academic outcome metrics derived from final grades, enabling analysis of GPA trends, pass rates, withdrawal patterns, and grade integrity across courses, terms, and programs."
  source: "`education_ecm`.`instruction`.`final_grade`"
  dimensions:
    - name: "term_code"
      expr: term_code
      comment: "Academic term code for longitudinal grade outcome analysis."
    - name: "course_section_id"
      expr: course_section_id
      comment: "Course section for section-level grade distribution analysis."
    - name: "letter_grade"
      expr: letter_grade
      comment: "Final letter grade for grade distribution reporting."
    - name: "grade_mode"
      expr: grade_mode
      comment: "Grading mode (letter, pass/fail, audit) for stratified outcome analysis."
    - name: "subject_code"
      expr: subject_code
      comment: "Subject/discipline code for cross-departmental grade outcome benchmarking."
    - name: "grade_posting_status"
      expr: grade_posting_status
      comment: "Grade posting status for monitoring grade submission compliance and timeliness."
    - name: "degree_applicable_flag"
      expr: degree_applicable_flag
      comment: "Indicates whether the course counts toward a degree; filters for degree-progress analysis."
    - name: "repeat_course_flag"
      expr: repeat_course_flag
      comment: "Flags repeated course attempts; used for academic policy and GPA recalculation analysis."
    - name: "grade_posted_date"
      expr: DATE_TRUNC('month', grade_posted_date)
      comment: "Month grades were posted; monitors grade submission timeliness trends."
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit for departmental grade outcome reporting."
  measures:
    - name: "total_grade_records"
      expr: COUNT(1)
      comment: "Total final grade records; baseline for grade completeness and submission monitoring."
    - name: "distinct_students_graded"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique students receiving final grades; measures academic throughput."
    - name: "avg_grade_point_value"
      expr: AVG(CAST(grade_point_value AS DOUBLE))
      comment: "Average grade point value across all graded records; headline GPA proxy metric for academic quality monitoring."
    - name: "total_credit_hours_attempted"
      expr: SUM(CAST(credit_hours_attempted AS DOUBLE))
      comment: "Total credit hours attempted; core metric for enrollment intensity and IPEDS reporting."
    - name: "total_credit_hours_earned"
      expr: SUM(CAST(credit_hours_earned AS DOUBLE))
      comment: "Total credit hours successfully earned; directly tied to degree progression and SAP compliance."
    - name: "credit_hour_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(credit_hours_earned AS DOUBLE)) / NULLIF(SUM(CAST(credit_hours_attempted AS DOUBLE)), 0), 2)
      comment: "Ratio of credit hours earned to attempted; key SAP (Satisfactory Academic Progress) and retention KPI used in financial aid compliance."
    - name: "total_quality_points"
      expr: SUM(CAST(quality_points AS DOUBLE))
      comment: "Total quality points earned; used in institutional GPA calculations and academic standing determinations."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN grade_point_value >= 1.0 AND incomplete_flag = FALSE THEN 1 END) / NULLIF(COUNT(CASE WHEN degree_applicable_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of degree-applicable grade records with a passing grade point value; critical course success KPI for academic program review."
    - name: "withdrawal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN withdrawal_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grade records with a recorded withdrawal; key retention and student success KPI."
    - name: "incomplete_grade_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN incomplete_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grades recorded as incomplete; signals student academic difficulty and informs advising resource allocation."
    - name: "grade_change_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN grade_change_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of final grades that were subsequently changed; grade integrity KPI for academic policy and audit purposes."
    - name: "avg_numeric_grade"
      expr: AVG(CAST(numeric_grade AS DOUBLE))
      comment: "Average numeric grade score across all graded records; supports fine-grained academic performance benchmarking."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_grade_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assignment-level grading performance and assessment quality metrics, enabling faculty effectiveness analysis, grading timeliness monitoring, and learning outcome alignment evaluation."
  source: "`education_ecm`.`instruction`.`grade_entry`"
  dimensions:
    - name: "course_section_id"
      expr: course_section_id
      comment: "Course section for section-level grading performance analysis."
    - name: "assignment_id"
      expr: assignment_id
      comment: "Assignment identifier for assignment-level grade distribution analysis."
    - name: "grading_status"
      expr: grading_status
      comment: "Current grading status (e.g., graded, pending, excused) for grading workflow monitoring."
    - name: "term_code"
      expr: term_code
      comment: "Academic term for longitudinal grading trend analysis."
    - name: "grade_entry_source"
      expr: grade_entry_source
      comment: "Source system or method of grade entry for data provenance and quality analysis."
    - name: "is_late"
      expr: is_late
      comment: "Indicates whether the submission was late; used to analyze late submission patterns and policy impact."
    - name: "is_missing"
      expr: is_missing
      comment: "Indicates whether the submission is missing; key signal for student engagement and early alert analysis."
    - name: "extra_credit_flag"
      expr: extra_credit_flag
      comment: "Flags extra credit assignments for exclusion or inclusion in grade analysis."
    - name: "graded_timestamp"
      expr: DATE_TRUNC('week', graded_timestamp)
      comment: "Week of grading for monitoring grading turnaround time trends."
  measures:
    - name: "total_grade_entries"
      expr: COUNT(1)
      comment: "Total grade entry records; baseline for grading volume and completeness monitoring."
    - name: "distinct_students_assessed"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique students with grade entries; measures assessment coverage."
    - name: "avg_grade_percentage"
      expr: AVG(CAST(grade_percentage AS DOUBLE))
      comment: "Average grade percentage across all graded entries; headline assignment performance KPI for faculty and curriculum review."
    - name: "avg_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average raw score across all grade entries; supports assignment difficulty calibration."
    - name: "avg_max_score"
      expr: AVG(CAST(max_score AS DOUBLE))
      comment: "Average maximum possible score; used alongside avg_score to compute effective difficulty index."
    - name: "late_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_late = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grade entries flagged as late submissions; informs late policy effectiveness and student time-management interventions."
    - name: "missing_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_missing = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of expected grade entries flagged as missing; critical early warning KPI for student disengagement and at-risk identification."
    - name: "grade_override_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN grade_override_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grade entries with manual overrides; grade integrity and academic policy compliance KPI."
    - name: "avg_late_penalty_applied"
      expr: AVG(CASE WHEN is_late = TRUE THEN late_penalty_applied END)
      comment: "Average late penalty deducted on late submissions; informs late policy calibration and student equity analysis."
    - name: "total_weight_in_final_grade"
      expr: SUM(CAST(weight_in_final_grade AS DOUBLE))
      comment: "Total weight of graded entries contributing to final grade; used to verify grade weighting completeness and curriculum design integrity."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_faculty_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Faculty workload, compensation, and instructional assignment metrics enabling academic HR, budget, and accreditation reporting on faculty deployment, FTE utilization, and teaching load distribution."
  source: "`education_ecm`.`instruction`.`faculty_assignment`"
  dimensions:
    - name: "term_id"
      expr: term_id
      comment: "Academic term for longitudinal faculty workload and assignment trend analysis."
    - name: "appointment_type"
      expr: appointment_type
      comment: "Faculty appointment type (e.g., tenure-track, adjunct, visiting) for workforce composition analysis."
    - name: "assignment_role"
      expr: assignment_role
      comment: "Role of the faculty member in the assignment (e.g., primary, co-instructor) for workload attribution."
    - name: "teaching_modality"
      expr: teaching_modality
      comment: "Teaching modality (e.g., in-person, online) for delivery mode workforce analysis."
    - name: "compensation_type"
      expr: compensation_type
      comment: "Compensation type (e.g., salary, overload, stipend) for budget and payroll analysis."
    - name: "ipeds_reporting_category"
      expr: ipeds_reporting_category
      comment: "IPEDS faculty category for federal reporting compliance."
    - name: "is_primary_instructor"
      expr: is_primary_instructor
      comment: "Flags primary instructor assignments for workload and accountability analysis."
    - name: "is_team_taught"
      expr: is_team_taught
      comment: "Indicates team-taught sections for collaborative instruction analysis and workload splitting."
    - name: "academic_program_id"
      expr: academic_program_id
      comment: "Academic program for program-level faculty deployment and sufficiency analysis."
  measures:
    - name: "total_faculty_assignments"
      expr: COUNT(1)
      comment: "Total faculty assignment records; baseline for instructional staffing volume monitoring."
    - name: "distinct_instructors_assigned"
      expr: COUNT(DISTINCT instructor_id)
      comment: "Number of unique instructors with active assignments; measures instructional workforce breadth."
    - name: "total_workload_credit_hours"
      expr: SUM(CAST(workload_credit_hours AS DOUBLE))
      comment: "Total workload credit hours across all faculty assignments; primary faculty workload KPI for accreditation and HR reporting."
    - name: "avg_workload_credit_hours_per_instructor"
      expr: AVG(CAST(workload_credit_hours AS DOUBLE))
      comment: "Average workload credit hours per assignment record; informs equitable workload distribution and overload identification."
    - name: "total_fte_contribution"
      expr: SUM(CAST(fte_contribution AS DOUBLE))
      comment: "Total FTE contribution across all faculty assignments; core metric for workforce planning and budget allocation."
    - name: "avg_percent_responsibility"
      expr: AVG(CAST(percent_responsibility AS DOUBLE))
      comment: "Average percentage of instructional responsibility per assignment; used to analyze shared teaching arrangements and workload equity."
    - name: "total_compensation_amount"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total compensation committed across all faculty assignments; direct instructional cost KPI for budget management."
    - name: "avg_compensation_per_credit_hour"
      expr: ROUND(SUM(CAST(compensation_amount AS DOUBLE)) / NULLIF(SUM(CAST(workload_credit_hours AS DOUBLE)), 0), 2)
      comment: "Average compensation cost per workload credit hour; efficiency KPI for instructional cost benchmarking across departments and appointment types."
    - name: "grant_funded_assignment_count"
      expr: COUNT(CASE WHEN grant_funded_percentage > 0 THEN 1 END)
      comment: "Number of assignments with grant funding contribution; informs research-instruction balance and grant compliance reporting."
    - name: "avg_grant_funded_percentage"
      expr: AVG(CASE WHEN grant_funded_percentage > 0 THEN grant_funded_percentage END)
      comment: "Average grant-funded percentage among grant-supported assignments; used for sponsored research cost allocation analysis."
    - name: "total_office_hours_required"
      expr: SUM(CAST(office_hours_required AS DOUBLE))
      comment: "Total required office hours across all assignments; student access and faculty obligation compliance metric."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Student assignment submission behavior and academic integrity metrics, enabling analysis of submission timeliness, originality risk, grading throughput, and student engagement at the assignment and section level."
  source: "`education_ecm`.`instruction`.`submission`"
  dimensions:
    - name: "course_section_id"
      expr: course_section_id
      comment: "Course section for section-level submission behavior analysis."
    - name: "assignment_id"
      expr: assignment_id
      comment: "Assignment identifier for assignment-level submission pattern analysis."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of submission (e.g., file upload, online text, media) for format and technology usage analysis."
    - name: "workflow_state"
      expr: workflow_state
      comment: "Submission workflow state (e.g., submitted, graded, pending_review) for grading pipeline monitoring."
    - name: "late_policy_status"
      expr: late_policy_status
      comment: "Late policy applied to the submission for policy impact analysis."
    - name: "is_late"
      expr: is_late
      comment: "Indicates late submission for timeliness trend analysis."
    - name: "is_missing"
      expr: is_missing
      comment: "Indicates missing submission for student engagement and at-risk monitoring."
    - name: "submitted_at"
      expr: DATE_TRUNC('week', submitted_at)
      comment: "Week of submission for temporal submission volume and deadline compliance analysis."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total submission records; baseline for submission volume and assignment completion monitoring."
    - name: "distinct_students_submitting"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique students who submitted; measures assignment participation breadth."
    - name: "on_time_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_late = FALSE AND is_missing = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions made on time; key student engagement and academic discipline KPI."
    - name: "missing_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_missing = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of expected submissions that are missing; primary early alert and at-risk student identification KPI."
    - name: "avg_submission_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average submission score across all graded submissions; headline assignment performance metric."
    - name: "avg_originality_score"
      expr: AVG(CAST(originality_score AS DOUBLE))
      comment: "Average Turnitin/originality score across submissions; academic integrity monitoring KPI for identifying plagiarism risk."
    - name: "high_originality_risk_count"
      expr: COUNT(CASE WHEN originality_score >= 25.0 THEN 1 END)
      comment: "Number of submissions with originality score at or above 25%; academic integrity risk volume metric for faculty and academic affairs review."
    - name: "avg_points_deducted"
      expr: AVG(CASE WHEN points_deducted > 0 THEN points_deducted END)
      comment: "Average points deducted (e.g., for late penalties) among penalized submissions; informs late policy calibration and student equity analysis."
    - name: "avg_seconds_late"
      expr: AVG(CASE WHEN is_late = TRUE THEN seconds_late END)
      comment: "Average seconds past deadline for late submissions; quantifies severity of lateness to inform deadline policy design."
    - name: "graded_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN workflow_state = 'graded' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions that have been graded; grading throughput and timeliness KPI for faculty accountability."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_slo_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Student Learning Outcome (SLO) assessment metrics enabling program review, accreditation reporting, and continuous improvement analysis by measuring proficiency attainment, assessment coverage, and improvement action rates."
  source: "`education_ecm`.`instruction`.`slo_assessment`"
  dimensions:
    - name: "term_code"
      expr: term_code
      comment: "Academic term for longitudinal SLO attainment trend analysis."
    - name: "slo_id"
      expr: slo_id
      comment: "Student Learning Outcome identifier for SLO-level performance analysis."
    - name: "assessment_method"
      expr: assessment_method
      comment: "Assessment method (e.g., direct, indirect, embedded) for methodology-stratified outcome analysis."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the assessment (e.g., complete, pending, in-review) for assessment cycle monitoring."
    - name: "performance_level"
      expr: performance_level
      comment: "Performance level achieved (e.g., exceeds, meets, below) for proficiency distribution reporting."
    - name: "accreditation_body"
      expr: accreditation_body
      comment: "Accrediting body associated with the assessment; enables accreditation-specific outcome reporting."
    - name: "assessment_cycle"
      expr: assessment_cycle
      comment: "Assessment cycle (e.g., annual, biennial) for cyclical program review alignment."
    - name: "org_unit_id"
      expr: org_unit_id
      comment: "Organizational unit for departmental SLO attainment benchmarking."
    - name: "assessment_date"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of assessment for temporal SLO data collection trend analysis."
  measures:
    - name: "total_slo_assessments"
      expr: COUNT(1)
      comment: "Total SLO assessment records; baseline for assessment coverage and data completeness monitoring."
    - name: "distinct_students_assessed"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique students assessed against SLOs; measures assessment breadth for accreditation evidence."
    - name: "distinct_slos_assessed"
      expr: COUNT(DISTINCT slo_id)
      comment: "Number of unique SLOs with assessment data; measures curriculum assessment coverage for program review."
    - name: "avg_slo_score"
      expr: AVG(CAST(score_numeric AS DOUBLE))
      comment: "Average SLO assessment score; headline learning outcome attainment KPI for program review and accreditation."
    - name: "avg_proficiency_threshold"
      expr: AVG(CAST(proficiency_threshold AS DOUBLE))
      comment: "Average proficiency threshold set for SLO assessments; used alongside avg_slo_score to evaluate attainment relative to targets."
    - name: "proficiency_attainment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN score_numeric >= proficiency_threshold THEN 1 END) / NULLIF(COUNT(CASE WHEN proficiency_threshold IS NOT NULL AND score_numeric IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of SLO assessments where the student met or exceeded the proficiency threshold; primary accreditation and program quality KPI."
    - name: "improvement_action_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN improvement_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SLO assessments triggering a required improvement action; closing-the-loop KPI for continuous improvement and accreditation compliance."
    - name: "avg_score_to_maximum_ratio"
      expr: ROUND(AVG(CAST(score_numeric AS DOUBLE)) / NULLIF(AVG(CAST(score_maximum AS DOUBLE)), 0), 4)
      comment: "Ratio of average score to average maximum score; normalized SLO performance index enabling cross-SLO and cross-program comparisons."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assignment design and configuration metrics enabling curriculum quality analysis, assessment strategy evaluation, and LMS alignment monitoring across course sections."
  source: "`education_ecm`.`instruction`.`assignment`"
  dimensions:
    - name: "course_section_id"
      expr: course_section_id
      comment: "Course section for section-level assignment portfolio analysis."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (e.g., exam, project, discussion) for assessment strategy analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the assignment (e.g., published, unpublished, deleted) for LMS content governance."
    - name: "grading_type"
      expr: grading_type
      comment: "Grading type (e.g., points, percentage, pass/fail) for assessment design analysis."
    - name: "submission_type"
      expr: submission_type
      comment: "Expected submission type (e.g., online, paper, media) for technology and format analysis."
    - name: "is_published"
      expr: is_published
      comment: "Indicates whether the assignment is published to students; LMS content readiness monitoring."
    - name: "is_group_assignment"
      expr: is_group_assignment
      comment: "Indicates collaborative assignments; used to analyze collaborative learning design prevalence."
    - name: "due_date"
      expr: DATE_TRUNC('week', due_date)
      comment: "Week of assignment due date for workload distribution and deadline clustering analysis."
  measures:
    - name: "total_assignments"
      expr: COUNT(DISTINCT assignment_id)
      comment: "Total distinct assignments; baseline for course assessment portfolio size monitoring."
    - name: "total_points_possible"
      expr: SUM(CAST(points_possible AS DOUBLE))
      comment: "Total points possible across all assignments; measures overall assessment weight and grading scale design."
    - name: "avg_points_possible"
      expr: AVG(CAST(points_possible AS DOUBLE))
      comment: "Average points possible per assignment; informs assessment calibration and grading equity analysis."
    - name: "published_assignment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_published = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments published to students; LMS course readiness and faculty preparation KPI."
    - name: "peer_review_enabled_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_peer_review_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments with peer review enabled; measures active learning and collaborative assessment design prevalence."
    - name: "rubric_graded_assignment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_rubric_for_grading = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments graded using a rubric; assessment transparency and SLO alignment quality KPI."
    - name: "anonymous_grading_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_anonymous_grading = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments using anonymous grading; grading bias mitigation and equity policy compliance metric."
$$;