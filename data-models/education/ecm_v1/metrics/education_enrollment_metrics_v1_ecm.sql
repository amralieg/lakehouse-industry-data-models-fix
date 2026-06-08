-- Metric views for domain: enrollment | Business: Education | Version: 1 | Generated on: 2026-05-06 12:16:12

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`enrollment_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core enrollment and registration metrics tracking student course enrollments, credit hours, FTE contribution, and academic performance across terms and programs."
  source: "`education_ecm`.`enrollment`.`enrollment_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the registration (e.g., enrolled, dropped, withdrawn)"
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (e.g., regular, audit, pass/fail)"
    - name: "grade_mode"
      expr: grade_mode
      comment: "Grading mode for the registration (e.g., standard, pass/fail, audit)"
    - name: "student_level"
      expr: student_level
      comment: "Academic level of the student (e.g., undergraduate, graduate, doctoral)"
    - name: "instructional_method"
      expr: instructional_method
      comment: "Method of instruction delivery (e.g., in-person, online, hybrid)"
    - name: "course_subject"
      expr: course_subject
      comment: "Subject area or discipline of the course"
    - name: "college_code"
      expr: college_code
      comment: "College or school code for the course"
    - name: "department_code"
      expr: department_code
      comment: "Academic department offering the course"
    - name: "registration_year"
      expr: YEAR(registration_timestamp)
      comment: "Year when the registration occurred"
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_timestamp)
      comment: "Month when the registration occurred"
    - name: "census_enrolled_flag"
      expr: census_enrolled_flag
      comment: "Whether the student was enrolled at census date for official reporting"
    - name: "financial_aid_eligible_flag"
      expr: financial_aid_eligible_flag
      comment: "Whether the registration is eligible for financial aid"
    - name: "repeat_indicator"
      expr: repeat_indicator
      comment: "Whether this is a repeat of a previously taken course"
  measures:
    - name: "total_registrations"
      expr: COUNT(1)
      comment: "Total number of course registrations"
    - name: "unique_students"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of students with registrations"
    - name: "total_credit_hours_attempted"
      expr: SUM(CAST(credit_hours_attempted AS DOUBLE))
      comment: "Sum of all credit hours attempted across registrations"
    - name: "total_billing_hours"
      expr: SUM(CAST(billing_hours AS DOUBLE))
      comment: "Sum of all billable credit hours"
    - name: "total_fte_contribution"
      expr: SUM(CAST(fte_contribution AS DOUBLE))
      comment: "Sum of FTE (Full-Time Equivalent) contributions from all registrations"
    - name: "avg_credit_hours_per_registration"
      expr: AVG(CAST(credit_hours_attempted AS DOUBLE))
      comment: "Average credit hours attempted per registration"
    - name: "total_grade_points"
      expr: SUM(CAST(grade_points AS DOUBLE))
      comment: "Sum of grade points earned across all registrations"
    - name: "avg_grade_points"
      expr: AVG(CAST(grade_points AS DOUBLE))
      comment: "Average grade points per registration"
    - name: "census_enrollment_count"
      expr: COUNT(CASE WHEN census_enrolled_flag = TRUE THEN 1 END)
      comment: "Count of registrations enrolled at census date for official headcount reporting"
    - name: "financial_aid_eligible_count"
      expr: COUNT(CASE WHEN financial_aid_eligible_flag = TRUE THEN 1 END)
      comment: "Count of registrations eligible for financial aid"
    - name: "repeat_course_count"
      expr: COUNT(CASE WHEN repeat_indicator = TRUE THEN 1 END)
      comment: "Count of course repeat registrations"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`enrollment_student_term_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Student academic performance and progression metrics by term, tracking GPA, credit hours, academic standing, retention, and completion rates."
  source: "`education_ecm`.`enrollment`.`student_term_record`"
  dimensions:
    - name: "academic_year"
      expr: academic_year
      comment: "Academic year of the term record"
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Student enrollment status for the term (e.g., enrolled, withdrawn, graduated)"
    - name: "academic_standing"
      expr: academic_standing
      comment: "Academic standing status (e.g., good standing, probation, suspension)"
    - name: "student_level"
      expr: student_level
      comment: "Academic level (e.g., freshman, sophomore, junior, senior, graduate)"
    - name: "class_level"
      expr: class_level
      comment: "Classification level of the student"
    - name: "attendance_type"
      expr: attendance_type
      comment: "Full-time or part-time attendance status"
    - name: "college_code"
      expr: college_code
      comment: "College or school code"
    - name: "department_code"
      expr: department_code
      comment: "Primary academic department"
    - name: "residency_classification"
      expr: residency_classification
      comment: "Residency status (e.g., in-state, out-of-state, international)"
    - name: "first_generation_flag"
      expr: first_generation_flag
      comment: "Whether the student is first-generation college student"
    - name: "ftiac_flag"
      expr: ftiac_flag
      comment: "First-Time-In-Any-College indicator"
    - name: "international_flag"
      expr: international_flag
      comment: "Whether the student is international"
    - name: "veteran_flag"
      expr: veteran_flag
      comment: "Whether the student is a veteran"
    - name: "athlete_flag"
      expr: athlete_flag
      comment: "Whether the student is a student-athlete"
    - name: "sap_status"
      expr: sap_status
      comment: "Satisfactory Academic Progress status for financial aid eligibility"
  measures:
    - name: "total_student_terms"
      expr: COUNT(1)
      comment: "Total number of student-term records"
    - name: "unique_students"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of students"
    - name: "total_term_credit_hours_attempted"
      expr: SUM(CAST(credit_hours_attempted AS DOUBLE))
      comment: "Sum of credit hours attempted in the term"
    - name: "total_term_credit_hours_earned"
      expr: SUM(CAST(credit_hours_earned AS DOUBLE))
      comment: "Sum of credit hours successfully earned in the term"
    - name: "total_cumulative_credit_hours_attempted"
      expr: SUM(CAST(cumulative_credit_hours_attempted AS DOUBLE))
      comment: "Sum of cumulative credit hours attempted across all students"
    - name: "total_cumulative_credit_hours_earned"
      expr: SUM(CAST(cumulative_credit_hours_earned AS DOUBLE))
      comment: "Sum of cumulative credit hours earned across all students"
    - name: "avg_term_gpa"
      expr: AVG(CAST(term_gpa AS DOUBLE))
      comment: "Average term GPA across all student-term records"
    - name: "avg_cumulative_gpa"
      expr: AVG(CAST(cumulative_gpa AS DOUBLE))
      comment: "Average cumulative GPA across all students"
    - name: "total_term_fte"
      expr: SUM(CAST(fte_value AS DOUBLE))
      comment: "Sum of FTE values for the term"
    - name: "total_quality_points_term"
      expr: SUM(CAST(quality_points_term AS DOUBLE))
      comment: "Sum of quality points earned in the term"
    - name: "total_quality_points_cumulative"
      expr: SUM(CAST(quality_points_cumulative AS DOUBLE))
      comment: "Sum of cumulative quality points"
    - name: "students_with_holds"
      expr: COUNT(CASE WHEN registration_hold_flag = TRUE THEN 1 END)
      comment: "Count of students with registration holds"
    - name: "financial_aid_applicants"
      expr: COUNT(CASE WHEN financial_aid_applicant_flag = TRUE THEN 1 END)
      comment: "Count of students who applied for financial aid"
    - name: "first_generation_students"
      expr: COUNT(CASE WHEN first_generation_flag = TRUE THEN 1 END)
      comment: "Count of first-generation college students"
    - name: "ftiac_students"
      expr: COUNT(CASE WHEN ftiac_flag = TRUE THEN 1 END)
      comment: "Count of first-time-in-any-college students"
    - name: "international_students"
      expr: COUNT(CASE WHEN international_flag = TRUE THEN 1 END)
      comment: "Count of international students"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`enrollment_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Admissions funnel and application metrics tracking application volume, conversion rates, decision outcomes, and applicant characteristics."
  source: "`education_ecm`.`enrollment`.`enrollment_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application (e.g., submitted, under review, complete)"
    - name: "application_type"
      expr: application_type
      comment: "Type of application (e.g., freshman, transfer, graduate, international)"
    - name: "decision_status"
      expr: decision_status
      comment: "Admissions decision outcome (e.g., admitted, denied, waitlisted, deferred)"
    - name: "academic_level"
      expr: academic_level
      comment: "Academic level applied for (e.g., undergraduate, graduate, doctoral)"
    - name: "residency_classification"
      expr: residency_classification
      comment: "Residency status of applicant (e.g., in-state, out-of-state, international)"
    - name: "citizenship_status"
      expr: citizenship_status
      comment: "Citizenship status of applicant"
    - name: "application_source"
      expr: application_source
      comment: "Source or channel of the application (e.g., common app, direct, coalition)"
    - name: "enrollment_intent"
      expr: enrollment_intent
      comment: "Applicant's stated intent to enroll"
    - name: "submitted_year"
      expr: YEAR(submitted_date)
      comment: "Year the application was submitted"
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_date)
      comment: "Month the application was submitted"
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year the admissions decision was made"
    - name: "first_generation_flag"
      expr: first_generation_flag
      comment: "Whether applicant is first-generation college student"
    - name: "athletics_recruit_flag"
      expr: athletics_recruit_flag
      comment: "Whether applicant is an athletics recruit"
    - name: "early_action_flag"
      expr: early_action_flag
      comment: "Whether application was submitted under early action"
    - name: "early_decision_flag"
      expr: early_decision_flag
      comment: "Whether application was submitted under early decision"
    - name: "fee_waiver_flag"
      expr: fee_waiver_flag
      comment: "Whether application fee was waived"
    - name: "scholarship_consideration_flag"
      expr: scholarship_consideration_flag
      comment: "Whether applicant is being considered for scholarships"
    - name: "test_optional_flag"
      expr: test_optional_flag
      comment: "Whether applicant applied under test-optional policy"
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of applications submitted"
    - name: "unique_applicants"
      expr: COUNT(DISTINCT enrollment_applicant_id)
      comment: "Distinct count of applicants"
    - name: "applications_with_decisions"
      expr: COUNT(CASE WHEN decision_status IS NOT NULL THEN 1 END)
      comment: "Count of applications that have received an admissions decision"
    - name: "applications_admitted"
      expr: COUNT(CASE WHEN decision_status = 'admitted' THEN 1 END)
      comment: "Count of applications that were admitted"
    - name: "applications_denied"
      expr: COUNT(CASE WHEN decision_status = 'denied' THEN 1 END)
      comment: "Count of applications that were denied"
    - name: "applications_waitlisted"
      expr: COUNT(CASE WHEN decision_status = 'waitlisted' THEN 1 END)
      comment: "Count of applications placed on waitlist"
    - name: "applications_fee_paid"
      expr: COUNT(CASE WHEN fee_paid_flag = TRUE THEN 1 END)
      comment: "Count of applications with fee paid"
    - name: "applications_fee_waived"
      expr: COUNT(CASE WHEN fee_waiver_flag = TRUE THEN 1 END)
      comment: "Count of applications with fee waiver granted"
    - name: "total_application_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Sum of all application fees collected"
    - name: "avg_high_school_gpa"
      expr: AVG(CAST(high_school_gpa AS DOUBLE))
      comment: "Average high school GPA of applicants"
    - name: "avg_sat_score"
      expr: AVG(CAST(sat_total_score AS DOUBLE))
      comment: "Average SAT total score of applicants"
    - name: "avg_transfer_credit_hours"
      expr: AVG(CAST(transfer_credit_hours AS DOUBLE))
      comment: "Average transfer credit hours for transfer applicants"
    - name: "first_generation_applicants"
      expr: COUNT(CASE WHEN first_generation_flag = TRUE THEN 1 END)
      comment: "Count of first-generation college applicants"
    - name: "athletics_recruits"
      expr: COUNT(CASE WHEN athletics_recruit_flag = TRUE THEN 1 END)
      comment: "Count of athletics recruit applicants"
    - name: "scholarship_consideration_applicants"
      expr: COUNT(CASE WHEN scholarship_consideration_flag = TRUE THEN 1 END)
      comment: "Count of applicants being considered for scholarships"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`enrollment_matriculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Matriculation and yield metrics tracking admitted students who enroll, deposit paid, orientation completion, and cohort characteristics."
  source: "`education_ecm`.`enrollment`.`matriculation`"
  dimensions:
    - name: "matriculation_status"
      expr: matriculation_status
      comment: "Status of matriculation (e.g., confirmed, pending, cancelled)"
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Enrollment status of the matriculated student"
    - name: "admit_type"
      expr: admit_type
      comment: "Type of admission (e.g., freshman, transfer, readmit)"
    - name: "entry_level"
      expr: entry_level
      comment: "Entry level of the student (e.g., freshman, sophomore, graduate)"
    - name: "student_level"
      expr: student_level
      comment: "Academic level (e.g., undergraduate, graduate, doctoral)"
    - name: "instructional_method"
      expr: instructional_method
      comment: "Primary instructional method (e.g., in-person, online, hybrid)"
    - name: "residency_status"
      expr: residency_status
      comment: "Residency classification (e.g., in-state, out-of-state, international)"
    - name: "college_code"
      expr: college_code
      comment: "College or school code"
    - name: "department_code"
      expr: department_code
      comment: "Academic department code"
    - name: "cohort_code"
      expr: cohort_code
      comment: "Cohort identifier for tracking student groups"
    - name: "matriculation_year"
      expr: YEAR(matriculation_date)
      comment: "Year of matriculation"
    - name: "matriculation_month"
      expr: DATE_TRUNC('MONTH', matriculation_date)
      comment: "Month of matriculation"
    - name: "orientation_status"
      expr: orientation_status
      comment: "Status of orientation completion"
    - name: "housing_intent"
      expr: housing_intent
      comment: "Student's housing intent (e.g., on-campus, off-campus, commuter)"
    - name: "deposit_paid_flag"
      expr: deposit_paid_flag
      comment: "Whether enrollment deposit was paid"
    - name: "first_generation_flag"
      expr: first_generation_flag
      comment: "Whether student is first-generation college student"
    - name: "ftiac_flag"
      expr: ftiac_flag
      comment: "First-Time-In-Any-College indicator"
    - name: "transfer_flag"
      expr: transfer_flag
      comment: "Whether student is a transfer student"
    - name: "international_flag"
      expr: international_flag
      comment: "Whether student is international"
    - name: "veteran_flag"
      expr: veteran_flag
      comment: "Whether student is a veteran"
    - name: "stem_flag"
      expr: stem_flag
      comment: "Whether student is in a STEM program"
    - name: "financial_aid_applicant_flag"
      expr: financial_aid_applicant_flag
      comment: "Whether student applied for financial aid"
  measures:
    - name: "total_matriculations"
      expr: COUNT(1)
      comment: "Total number of matriculation records"
    - name: "unique_matriculated_students"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of students who matriculated"
    - name: "deposits_paid"
      expr: COUNT(CASE WHEN deposit_paid_flag = TRUE THEN 1 END)
      comment: "Count of students who paid enrollment deposit"
    - name: "orientation_completed"
      expr: COUNT(CASE WHEN orientation_status = 'completed' THEN 1 END)
      comment: "Count of students who completed orientation"
    - name: "first_generation_matriculants"
      expr: COUNT(CASE WHEN first_generation_flag = TRUE THEN 1 END)
      comment: "Count of first-generation students who matriculated"
    - name: "ftiac_matriculants"
      expr: COUNT(CASE WHEN ftiac_flag = TRUE THEN 1 END)
      comment: "Count of first-time-in-any-college students who matriculated"
    - name: "transfer_matriculants"
      expr: COUNT(CASE WHEN transfer_flag = TRUE THEN 1 END)
      comment: "Count of transfer students who matriculated"
    - name: "international_matriculants"
      expr: COUNT(CASE WHEN international_flag = TRUE THEN 1 END)
      comment: "Count of international students who matriculated"
    - name: "veteran_matriculants"
      expr: COUNT(CASE WHEN veteran_flag = TRUE THEN 1 END)
      comment: "Count of veteran students who matriculated"
    - name: "stem_matriculants"
      expr: COUNT(CASE WHEN stem_flag = TRUE THEN 1 END)
      comment: "Count of students matriculated into STEM programs"
    - name: "financial_aid_applicant_matriculants"
      expr: COUNT(CASE WHEN financial_aid_applicant_flag = TRUE THEN 1 END)
      comment: "Count of matriculated students who applied for financial aid"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`enrollment_census`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Official enrollment census metrics for regulatory reporting, tracking headcount, FTE, and enrollment composition by term and student characteristics."
  source: "`education_ecm`.`enrollment`.`census`"
  dimensions:
    - name: "academic_year"
      expr: academic_year
      comment: "Academic year of the census"
    - name: "census_type"
      expr: census_type
      comment: "Type of census (e.g., fall, spring, summer, annual)"
    - name: "census_status"
      expr: census_status
      comment: "Status of the census (e.g., preliminary, final, certified)"
    - name: "student_level"
      expr: student_level
      comment: "Academic level (e.g., undergraduate, graduate, professional)"
    - name: "attendance_type"
      expr: attendance_type
      comment: "Full-time or part-time attendance status"
    - name: "residency_status"
      expr: residency_status
      comment: "Residency classification (e.g., in-state, out-of-state, international)"
    - name: "instructional_method"
      expr: instructional_method
      comment: "Primary instructional delivery method"
    - name: "reporting_level"
      expr: reporting_level
      comment: "Level of aggregation for reporting (e.g., institution, college, department)"
    - name: "census_date"
      expr: census_date
      comment: "Official census date for the snapshot"
    - name: "census_year"
      expr: YEAR(census_date)
      comment: "Year of the census date"
    - name: "accreditation_submission_flag"
      expr: accreditation_submission_flag
      comment: "Whether this census is for accreditation submission"
  measures:
    - name: "total_census_records"
      expr: COUNT(1)
      comment: "Total number of census records"
    - name: "total_headcount"
      expr: SUM(CAST(headcount AS DOUBLE))
      comment: "Sum of official headcount across all census records"
    - name: "total_fte"
      expr: SUM(CAST(fte_count AS DOUBLE))
      comment: "Sum of Full-Time Equivalent enrollment"
    - name: "total_undergraduate_fte"
      expr: SUM(CAST(undergraduate_fte AS DOUBLE))
      comment: "Sum of undergraduate FTE"
    - name: "total_graduate_fte"
      expr: SUM(CAST(graduate_fte AS DOUBLE))
      comment: "Sum of graduate FTE"
    - name: "total_credit_hours"
      expr: SUM(CAST(credit_hours_total AS DOUBLE))
      comment: "Sum of total credit hours enrolled at census"
    - name: "total_full_time_headcount"
      expr: SUM(CAST(full_time_headcount AS DOUBLE))
      comment: "Sum of full-time student headcount"
    - name: "total_part_time_headcount"
      expr: SUM(CAST(part_time_headcount AS DOUBLE))
      comment: "Sum of part-time student headcount"
    - name: "total_new_student_headcount"
      expr: SUM(CAST(new_student_headcount AS DOUBLE))
      comment: "Sum of new student headcount"
    - name: "total_continuing_headcount"
      expr: SUM(CAST(continuing_headcount AS DOUBLE))
      comment: "Sum of continuing student headcount"
    - name: "total_ftiac_headcount"
      expr: SUM(CAST(ftiac_headcount AS DOUBLE))
      comment: "Sum of first-time-in-any-college student headcount"
    - name: "total_transfer_headcount"
      expr: SUM(CAST(transfer_headcount AS DOUBLE))
      comment: "Sum of transfer student headcount"
    - name: "total_international_headcount"
      expr: SUM(CAST(international_headcount AS DOUBLE))
      comment: "Sum of international student headcount"
    - name: "total_in_state_headcount"
      expr: SUM(CAST(in_state_headcount AS DOUBLE))
      comment: "Sum of in-state student headcount"
    - name: "total_out_of_state_headcount"
      expr: SUM(CAST(out_of_state_headcount AS DOUBLE))
      comment: "Sum of out-of-state student headcount"
    - name: "total_online_exclusive_headcount"
      expr: SUM(CAST(online_exclusive_headcount AS DOUBLE))
      comment: "Sum of exclusively online student headcount"
    - name: "total_stem_headcount"
      expr: SUM(CAST(stem_headcount AS DOUBLE))
      comment: "Sum of students enrolled in STEM programs"
    - name: "total_pell_eligible_headcount"
      expr: SUM(CAST(pell_eligible_headcount AS DOUBLE))
      comment: "Sum of Pell-eligible student headcount"
    - name: "total_first_generation_headcount"
      expr: SUM(CAST(first_generation_headcount AS DOUBLE))
      comment: "Sum of first-generation college student headcount"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`enrollment_add_drop_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Course add/drop activity metrics tracking registration changes, credit hour adjustments, financial impacts, and withdrawal patterns."
  source: "`education_ecm`.`enrollment`.`add_drop_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction (e.g., add, drop, withdraw, swap)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the transaction (e.g., pending, approved, denied, processed)"
    - name: "new_registration_status"
      expr: new_registration_status
      comment: "Registration status after the transaction"
    - name: "prior_registration_status"
      expr: prior_registration_status
      comment: "Registration status before the transaction"
    - name: "processing_channel"
      expr: processing_channel
      comment: "Channel through which transaction was processed (e.g., web, advisor, registrar)"
    - name: "initiator_role"
      expr: initiator_role
      comment: "Role of person who initiated the transaction (e.g., student, advisor, registrar)"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the transaction"
    - name: "reason_description"
      expr: reason_description
      comment: "Description of the reason for the transaction"
    - name: "course_subject_code"
      expr: course_subject_code
      comment: "Subject area of the course"
    - name: "academic_period_week"
      expr: academic_period_week
      comment: "Week of the academic period when transaction occurred"
    - name: "transaction_year"
      expr: YEAR(transaction_timestamp)
      comment: "Year of the transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of the transaction"
    - name: "is_complete_withdrawal"
      expr: is_complete_withdrawal
      comment: "Whether this transaction represents a complete withdrawal from the term"
    - name: "is_after_withdraw_deadline"
      expr: is_after_withdraw_deadline
      comment: "Whether transaction occurred after the withdrawal deadline"
    - name: "is_before_refund_deadline"
      expr: is_before_refund_deadline
      comment: "Whether transaction occurred before the refund deadline"
    - name: "financial_aid_impact_flag"
      expr: financial_aid_impact_flag
      comment: "Whether transaction impacts financial aid eligibility"
    - name: "r2t4_required_flag"
      expr: r2t4_required_flag
      comment: "Whether Return of Title IV funds calculation is required"
    - name: "sap_impact_flag"
      expr: sap_impact_flag
      comment: "Whether transaction impacts Satisfactory Academic Progress"
    - name: "override_flag"
      expr: override_flag
      comment: "Whether an override was used for this transaction"
    - name: "dfw_flag"
      expr: dfw_flag
      comment: "Whether this is a D/F/W (drop/fail/withdraw) transaction"
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of add/drop transactions"
    - name: "unique_students"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of students with add/drop activity"
    - name: "unique_courses_affected"
      expr: COUNT(DISTINCT course_section_id)
      comment: "Distinct count of course sections affected by transactions"
    - name: "total_credit_hours_added"
      expr: SUM(CAST(CASE WHEN transaction_type = 'add' THEN credit_hours_after ELSE 0 END AS DOUBLE))
      comment: "Sum of credit hours added through add transactions"
    - name: "total_credit_hours_dropped"
      expr: SUM(CAST(CASE WHEN transaction_type IN ('drop', 'withdraw') THEN credit_hours_before ELSE 0 END AS DOUBLE))
      comment: "Sum of credit hours dropped through drop/withdraw transactions"
    - name: "total_fte_change"
      expr: SUM((CAST(fte_after AS DOUBLE)) - (CAST(fte_before AS DOUBLE)))
      comment: "Net change in FTE from all transactions"
    - name: "total_tuition_adjustments"
      expr: SUM(CAST(tuition_adjustment_amount AS DOUBLE))
      comment: "Sum of tuition adjustment amounts from all transactions"
    - name: "avg_refund_percentage"
      expr: AVG(CAST(refund_percentage AS DOUBLE))
      comment: "Average refund percentage across transactions"
    - name: "complete_withdrawals"
      expr: COUNT(CASE WHEN is_complete_withdrawal = TRUE THEN 1 END)
      comment: "Count of complete term withdrawals"
    - name: "late_withdrawals"
      expr: COUNT(CASE WHEN is_after_withdraw_deadline = TRUE THEN 1 END)
      comment: "Count of withdrawals after the deadline"
    - name: "transactions_with_financial_aid_impact"
      expr: COUNT(CASE WHEN financial_aid_impact_flag = TRUE THEN 1 END)
      comment: "Count of transactions impacting financial aid"
    - name: "transactions_requiring_r2t4"
      expr: COUNT(CASE WHEN r2t4_required_flag = TRUE THEN 1 END)
      comment: "Count of transactions requiring Return of Title IV calculation"
    - name: "transactions_with_sap_impact"
      expr: COUNT(CASE WHEN sap_impact_flag = TRUE THEN 1 END)
      comment: "Count of transactions impacting Satisfactory Academic Progress"
    - name: "transactions_with_override"
      expr: COUNT(CASE WHEN override_flag = TRUE THEN 1 END)
      comment: "Count of transactions requiring an override"
    - name: "dfw_transactions"
      expr: COUNT(CASE WHEN dfw_flag = TRUE THEN 1 END)
      comment: "Count of D/F/W (drop/fail/withdraw) transactions"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`enrollment_deposit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment deposit metrics tracking deposit payments, waivers, refunds, and matriculation confirmation for admitted students."
  source: "`education_ecm`.`enrollment`.`deposit`"
  dimensions:
    - name: "deposit_status"
      expr: deposit_status
      comment: "Status of the deposit (e.g., pending, paid, waived, refunded)"
    - name: "deposit_type"
      expr: deposit_type
      comment: "Type of deposit (e.g., enrollment, housing, orientation)"
    - name: "academic_level"
      expr: academic_level
      comment: "Academic level of the student"
    - name: "admit_type"
      expr: admit_type
      comment: "Type of admission (e.g., freshman, transfer, graduate)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g., credit card, check, wire transfer)"
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was made (e.g., online, in-person, mail)"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year the deposit was paid"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month the deposit was paid"
    - name: "is_waived"
      expr: is_waived
      comment: "Whether the deposit was waived"
    - name: "waiver_reason"
      expr: waiver_reason
      comment: "Reason for deposit waiver"
    - name: "is_refunded"
      expr: is_refunded
      comment: "Whether the deposit was refunded"
    - name: "refund_reason"
      expr: refund_reason
      comment: "Reason for deposit refund"
    - name: "matriculation_confirmed"
      expr: matriculation_confirmed
      comment: "Whether matriculation was confirmed"
    - name: "financial_aid_applicant"
      expr: financial_aid_applicant
      comment: "Whether student applied for financial aid"
    - name: "first_generation_student"
      expr: first_generation_student
      comment: "Whether student is first-generation"
    - name: "scholarship_recipient"
      expr: scholarship_recipient
      comment: "Whether student is a scholarship recipient"
  measures:
    - name: "total_deposits"
      expr: COUNT(1)
      comment: "Total number of deposit records"
    - name: "unique_students_with_deposits"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of students with deposit records"
    - name: "deposits_paid"
      expr: COUNT(CASE WHEN deposit_status = 'paid' THEN 1 END)
      comment: "Count of deposits that have been paid"
    - name: "deposits_waived"
      expr: COUNT(CASE WHEN is_waived = TRUE THEN 1 END)
      comment: "Count of deposits that were waived"
    - name: "deposits_refunded"
      expr: COUNT(CASE WHEN is_refunded = TRUE THEN 1 END)
      comment: "Count of deposits that were refunded"
    - name: "matriculations_confirmed"
      expr: COUNT(CASE WHEN matriculation_confirmed = TRUE THEN 1 END)
      comment: "Count of students who confirmed matriculation"
    - name: "total_deposit_amount_due"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Sum of total deposit amounts due"
    - name: "total_deposit_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Sum of deposit amounts actually paid"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Sum of deposit refund amounts"
    - name: "avg_deposit_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average deposit amount"
$$;