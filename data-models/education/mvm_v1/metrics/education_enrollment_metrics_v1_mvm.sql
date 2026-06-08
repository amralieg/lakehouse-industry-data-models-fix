-- Metric views for domain: enrollment | Business: Education | Version: 1 | Generated on: 2026-05-06 15:08:33

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`enrollment_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the admissions funnel — tracks application volume, fee revenue, conversion signals, and pipeline quality across academic programs, terms, and applicant segments. Used by enrollment management leadership to steer recruitment strategy and forecast incoming class size."
  source: "`education_ecm`.`enrollment`.`enrollment_application`"
  dimensions:
    - name: "term_id"
      expr: term_id
      comment: "Foreign key to enrollment.term — enables slicing all application KPIs by academic term for trend and cohort analysis."
    - name: "academic_level"
      expr: academic_level
      comment: "Undergraduate, graduate, or professional level of the application — critical for segmenting pipeline by degree level."
    - name: "application_type"
      expr: application_type
      comment: "Type of application (e.g., freshman, transfer, readmit) — drives targeted recruitment and yield strategies."
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application (e.g., submitted, under review, decided) — used to monitor funnel stage distribution."
    - name: "decision_status"
      expr: decision_status
      comment: "Admissions decision outcome (e.g., admitted, denied, waitlisted) — key dimension for yield and selectivity reporting."
    - name: "residency_classification"
      expr: residency_classification
      comment: "In-state, out-of-state, or international residency — affects tuition revenue projections and state reporting."
    - name: "citizenship_status"
      expr: citizenship_status
      comment: "Citizenship classification of the applicant — used for international enrollment tracking and visa compliance."
    - name: "application_source"
      expr: application_source
      comment: "Channel or system through which the application was submitted — informs recruitment channel effectiveness."
    - name: "first_generation_flag"
      expr: first_generation_flag
      comment: "Indicates whether the applicant is a first-generation college student — used for equity and access reporting."
    - name: "early_decision_flag"
      expr: early_decision_flag
      comment: "Indicates early decision application — used to track binding commitment pipeline and forecast yield."
    - name: "early_action_flag"
      expr: early_action_flag
      comment: "Indicates early action application — used to monitor non-binding early pipeline volume."
    - name: "submitted_date"
      expr: DATE_TRUNC('month', submitted_date)
      comment: "Month of application submission — enables time-series analysis of application flow and deadline clustering."
    - name: "decision_date"
      expr: DATE_TRUNC('month', decision_date)
      comment: "Month of admissions decision — used to track decision cycle throughput and timeliness."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of applications received — the primary pipeline volume KPI for enrollment management."
    - name: "completed_applications"
      expr: COUNT(CASE WHEN checklist_complete_flag = TRUE THEN 1 END)
      comment: "Number of applications with all required materials submitted — measures pipeline readiness for admissions review."
    - name: "fee_waiver_applications"
      expr: COUNT(CASE WHEN fee_waiver_flag = TRUE THEN 1 END)
      comment: "Number of applications granted a fee waiver — used to monitor access and equity program utilization."
    - name: "fee_paid_applications"
      expr: COUNT(CASE WHEN fee_paid_flag = TRUE THEN 1 END)
      comment: "Number of applications with application fee paid — indicates serious applicant intent and revenue realization."
    - name: "total_application_fee_revenue"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total application fee revenue collected — a direct revenue KPI for the admissions office budget."
    - name: "avg_application_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average application fee per application — used to benchmark fee structures across program types."
    - name: "avg_high_school_gpa"
      expr: AVG(CAST(high_school_gpa AS DOUBLE))
      comment: "Average self-reported high school GPA of applicants — a key academic quality indicator for incoming class profiling."
    - name: "transfer_credit_hours_avg"
      expr: AVG(CAST(transfer_credit_hours AS DOUBLE))
      comment: "Average transfer credit hours among applicants — informs articulation agreement effectiveness and time-to-degree projections."
    - name: "distinct_applicants"
      expr: COUNT(DISTINCT enrollment_applicant_id)
      comment: "Count of unique applicants — deduplicates multi-program applicants to measure true headcount pipeline."
    - name: "scholarship_consideration_applications"
      expr: COUNT(CASE WHEN scholarship_consideration_flag = TRUE THEN 1 END)
      comment: "Number of applications flagged for scholarship consideration — used to size financial aid award pipeline."
    - name: "priority_deadline_applications"
      expr: COUNT(CASE WHEN priority_deadline_flag = TRUE THEN 1 END)
      comment: "Applications submitted by the priority deadline — a leading indicator of high-intent applicant volume and yield potential."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`enrollment_admission_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Admissions decision outcome KPIs — tracks admit rates, yield signals, conditional offers, scholarship awards, and decision cycle performance. Used by the VP of Enrollment and Provost to evaluate selectivity, yield strategy, and financial aid leverage."
  source: "`education_ecm`.`enrollment`.`admission_decision`"
  dimensions:
    - name: "term_id"
      expr: term_id
      comment: "Academic term of the admission decision — enables cohort-level yield and selectivity trending."
    - name: "decision_type"
      expr: decision_type
      comment: "Type of decision rendered (e.g., admit, deny, waitlist, defer) — primary dimension for funnel stage analysis."
    - name: "decision_status"
      expr: decision_status
      comment: "Current status of the decision record — used to filter active vs. rescinded or superseded decisions."
    - name: "decision_cycle"
      expr: decision_cycle
      comment: "Admissions cycle (e.g., Early Decision, Regular Decision) — used to compare yield rates across decision rounds."
    - name: "decision_authority_type"
      expr: decision_authority_type
      comment: "Who rendered the decision (committee, automated, individual reviewer) — used for process quality and compliance audits."
    - name: "applicant_response"
      expr: applicant_response
      comment: "Applicant's response to the offer (accept, decline, no response) — the core yield signal."
    - name: "is_conditional"
      expr: is_conditional
      comment: "Whether the admission offer carries conditions — used to track conditional admit pipeline and compliance risk."
    - name: "is_honors_eligible"
      expr: is_honors_eligible
      comment: "Whether the applicant was deemed eligible for honors programs — used for honors cohort planning."
    - name: "is_scholarship_eligible"
      expr: is_scholarship_eligible
      comment: "Whether the applicant qualifies for merit scholarship — used to size financial aid award budget."
    - name: "is_rescinded"
      expr: is_rescinded
      comment: "Whether the admission offer was rescinded — used to monitor rescission rates and associated risk."
    - name: "decision_date"
      expr: DATE_TRUNC('month', decision_date)
      comment: "Month of decision issuance — enables throughput and cycle-time trend analysis."
    - name: "applicant_response_date"
      expr: DATE_TRUNC('month', applicant_response_date)
      comment: "Month applicant responded to the offer — used to track yield confirmation timing relative to deadlines."
  measures:
    - name: "total_decisions"
      expr: COUNT(1)
      comment: "Total admissions decisions rendered — baseline volume KPI for the admissions decision pipeline."
    - name: "admit_decisions"
      expr: COUNT(CASE WHEN decision_type = 'Admit' THEN 1 END)
      comment: "Number of admit decisions — numerator for admit rate calculation and class size forecasting."
    - name: "deny_decisions"
      expr: COUNT(CASE WHEN decision_type = 'Deny' THEN 1 END)
      comment: "Number of deny decisions — used to compute selectivity and benchmark against peer institutions."
    - name: "waitlist_decisions"
      expr: COUNT(CASE WHEN decision_type = 'Waitlist' THEN 1 END)
      comment: "Number of waitlist decisions — used to manage enrollment buffer and yield uncertainty."
    - name: "accepted_responses"
      expr: COUNT(CASE WHEN applicant_response = 'Accept' THEN 1 END)
      comment: "Number of applicants who accepted their offer — the primary yield volume KPI."
    - name: "declined_responses"
      expr: COUNT(CASE WHEN applicant_response = 'Decline' THEN 1 END)
      comment: "Number of applicants who declined their offer — used to diagnose yield loss and inform competitive positioning."
    - name: "rescinded_decisions"
      expr: COUNT(CASE WHEN is_rescinded = TRUE THEN 1 END)
      comment: "Number of rescinded admission offers — a risk and compliance KPI monitored by the registrar and legal counsel."
    - name: "conditional_admits"
      expr: COUNT(CASE WHEN is_conditional = TRUE THEN 1 END)
      comment: "Number of conditional admission offers — used to track compliance follow-up workload and risk exposure."
    - name: "scholarship_eligible_admits"
      expr: COUNT(CASE WHEN is_scholarship_eligible = TRUE THEN 1 END)
      comment: "Number of admitted students eligible for merit scholarships — used to project financial aid budget obligations."
    - name: "total_scholarship_amount_awarded"
      expr: SUM(CAST(scholarship_amount AS DOUBLE))
      comment: "Total scholarship dollars committed in admission decisions — a direct financial aid budget KPI."
    - name: "avg_scholarship_amount"
      expr: AVG(CAST(scholarship_amount AS DOUBLE))
      comment: "Average scholarship award per eligible admit — used to benchmark aid leverage and net tuition revenue."
    - name: "total_enrollment_deposit_amount"
      expr: SUM(CAST(enrollment_deposit_amount AS DOUBLE))
      comment: "Total enrollment deposit revenue collected at decision stage — an early yield revenue signal."
    - name: "avg_holistic_review_score"
      expr: AVG(CAST(holistic_review_score AS DOUBLE))
      comment: "Average holistic review score among decided applicants — used to calibrate review standards and equity in admissions."
    - name: "distinct_applicants_decided"
      expr: COUNT(DISTINCT enrollment_applicant_id)
      comment: "Unique applicants who received a decision — deduplicates multi-program applicants for true headcount reporting."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`enrollment_matriculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Matriculation and new student enrollment KPIs — tracks confirmed enrollments, student demographics, transfer activity, and orientation completion. Used by enrollment management, academic affairs, and institutional research to monitor class composition and onboarding effectiveness."
  source: "`education_ecm`.`enrollment`.`matriculation`"
  dimensions:
    - name: "term_id"
      expr: term_id
      comment: "Academic term of matriculation — primary time dimension for cohort and trend analysis."
    - name: "admit_type"
      expr: admit_type
      comment: "Type of admit (e.g., freshman, transfer, readmit, graduate) — used to segment new student populations."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status of the matriculant — used to track active vs. withdrawn new students."
    - name: "matriculation_status"
      expr: matriculation_status
      comment: "Status of the matriculation record (e.g., confirmed, cancelled) — used to finalize headcount reporting."
    - name: "student_level"
      expr: student_level
      comment: "Academic level of the student (undergraduate, graduate, professional) — key segmentation for resource planning."
    - name: "residency_status"
      expr: residency_status
      comment: "Residency classification (in-state, out-of-state, international) — drives tuition revenue and state funding calculations."
    - name: "international_flag"
      expr: international_flag
      comment: "Indicates international student — used for visa compliance, international student services planning, and IPEDS reporting."
    - name: "first_generation_flag"
      expr: first_generation_flag
      comment: "First-generation college student indicator — used for equity, access, and retention program targeting."
    - name: "transfer_flag"
      expr: transfer_flag
      comment: "Indicates transfer student — used to segment transfer pipeline and evaluate articulation agreement effectiveness."
    - name: "ftiac_flag"
      expr: ftiac_flag
      comment: "First-time-in-any-college indicator — used for IPEDS cohort reporting and freshman class benchmarking."
    - name: "stem_flag"
      expr: stem_flag
      comment: "Indicates STEM program enrollment — used for STEM pipeline reporting and workforce development metrics."
    - name: "veteran_flag"
      expr: veteran_flag
      comment: "Indicates veteran student — used for veteran services planning and VA compliance reporting."
    - name: "orientation_status"
      expr: orientation_status
      comment: "Orientation completion status — used to track onboarding completion rates and identify at-risk new students."
    - name: "degree_type"
      expr: degree_type
      comment: "Type of degree being pursued — used for program-level enrollment planning and accreditation reporting."
    - name: "matriculation_date"
      expr: DATE_TRUNC('month', matriculation_date)
      comment: "Month of matriculation confirmation — used to track enrollment confirmation timing relative to term start."
  measures:
    - name: "total_matriculants"
      expr: COUNT(1)
      comment: "Total number of matriculation records — the primary new student headcount KPI for enrollment management."
    - name: "confirmed_matriculants"
      expr: COUNT(CASE WHEN matriculation_status = 'Confirmed' THEN 1 END)
      comment: "Number of students who confirmed enrollment — the definitive class size KPI used in budget and resource planning."
    - name: "deposit_paid_matriculants"
      expr: COUNT(CASE WHEN deposit_paid_flag = TRUE THEN 1 END)
      comment: "Number of matriculants who paid their enrollment deposit — a leading indicator of confirmed enrollment intent."
    - name: "transfer_matriculants"
      expr: COUNT(CASE WHEN transfer_flag = TRUE THEN 1 END)
      comment: "Number of transfer students who matriculated — used to evaluate transfer pipeline effectiveness and articulation agreements."
    - name: "international_matriculants"
      expr: COUNT(CASE WHEN international_flag = TRUE THEN 1 END)
      comment: "Number of international students who matriculated — used for visa compliance, international services staffing, and revenue planning."
    - name: "first_generation_matriculants"
      expr: COUNT(CASE WHEN first_generation_flag = TRUE THEN 1 END)
      comment: "Number of first-generation students who matriculated — used to measure equity and access program outcomes."
    - name: "ftiac_matriculants"
      expr: COUNT(CASE WHEN ftiac_flag = TRUE THEN 1 END)
      comment: "First-time-in-any-college matriculants — the IPEDS-reportable freshman cohort headcount."
    - name: "stem_matriculants"
      expr: COUNT(CASE WHEN stem_flag = TRUE THEN 1 END)
      comment: "Number of STEM-designated matriculants — used for STEM pipeline and workforce development reporting."
    - name: "orientation_completed_matriculants"
      expr: COUNT(CASE WHEN orientation_status = 'Completed' THEN 1 END)
      comment: "Number of matriculants who completed orientation — used to track onboarding effectiveness and predict early retention."
    - name: "financial_aid_applicant_matriculants"
      expr: COUNT(CASE WHEN financial_aid_applicant_flag = TRUE THEN 1 END)
      comment: "Number of matriculants who applied for financial aid — used to size aid processing workload and budget exposure."
    - name: "distinct_programs_enrolled"
      expr: COUNT(DISTINCT academic_program_id)
      comment: "Number of distinct academic programs represented in matriculations — used to assess program-level enrollment distribution."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`enrollment_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Course registration and enrollment KPIs — tracks credit hour load, FTE contribution, grade outcomes, and registration patterns. Used by the Registrar, academic deans, and institutional research for census reporting, IPEDS FTE calculations, and academic performance monitoring."
  source: "`education_ecm`.`enrollment`.`registration`"
  dimensions:
    - name: "term_id"
      expr: term_id
      comment: "Academic term of the registration — primary time dimension for enrollment census and trend reporting."
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the registration (e.g., enrolled, withdrawn, dropped) — used to filter active enrollment for census counts."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (e.g., credit, audit, non-credit) — used to segment credit-bearing enrollment for FTE and revenue calculations."
    - name: "student_level"
      expr: student_level
      comment: "Academic level of the registered student — used to segment undergraduate vs. graduate enrollment for resource allocation."
    - name: "grade_mode"
      expr: grade_mode
      comment: "Grading mode (e.g., letter grade, pass/fail, audit) — used to analyze academic rigor and grade distribution patterns."
    - name: "instructional_method"
      expr: instructional_method
      comment: "Delivery method (e.g., in-person, online, hybrid) — used to track modality mix and inform instructional capacity planning."
    - name: "census_enrolled_flag"
      expr: census_enrolled_flag
      comment: "Indicates enrollment as of the official census date — the authoritative flag for IPEDS and state enrollment reporting."
    - name: "financial_aid_eligible_flag"
      expr: financial_aid_eligible_flag
      comment: "Indicates whether the registration is eligible for financial aid — used for SAP and aid disbursement compliance."
    - name: "repeat_indicator"
      expr: repeat_indicator
      comment: "Indicates a repeated course registration — used to monitor repeat rates and their impact on financial aid eligibility."
    - name: "sap_applicable_flag"
      expr: sap_applicable_flag
      comment: "Indicates whether the registration is subject to Satisfactory Academic Progress evaluation — used for financial aid compliance."
    - name: "registration_source"
      expr: registration_source
      comment: "Channel through which the registration was submitted — used to evaluate self-service adoption and advising touchpoints."
    - name: "add_timestamp"
      expr: DATE_TRUNC('month', add_timestamp)
      comment: "Month the course was added — used to analyze registration timing patterns relative to term start and add deadlines."
  measures:
    - name: "total_registrations"
      expr: COUNT(1)
      comment: "Total course registration records — the baseline enrollment activity volume KPI."
    - name: "census_enrolled_registrations"
      expr: COUNT(CASE WHEN census_enrolled_flag = TRUE THEN 1 END)
      comment: "Registrations active as of the official census date — the IPEDS-reportable enrollment headcount basis."
    - name: "total_credit_hours_attempted"
      expr: SUM(CAST(credit_hours_attempted AS DOUBLE))
      comment: "Total credit hours attempted across all registrations — used for FTE calculation, tuition revenue projection, and workload analysis."
    - name: "avg_credit_hours_attempted"
      expr: AVG(CAST(credit_hours_attempted AS DOUBLE))
      comment: "Average credit hours attempted per registration — used to monitor student load intensity and full-time equivalency trends."
    - name: "total_fte_contribution"
      expr: SUM(CAST(fte_contribution AS DOUBLE))
      comment: "Total FTE units contributed by all registrations — the primary IPEDS FTE enrollment metric used for state funding and benchmarking."
    - name: "avg_fte_contribution"
      expr: AVG(CAST(fte_contribution AS DOUBLE))
      comment: "Average FTE contribution per registration — used to assess part-time vs. full-time enrollment mix."
    - name: "total_billing_hours"
      expr: SUM(CAST(billing_hours AS DOUBLE))
      comment: "Total billable credit hours across registrations — directly drives tuition revenue calculations."
    - name: "total_grade_points"
      expr: SUM(CAST(grade_points AS DOUBLE))
      comment: "Total grade points earned — used as the numerator in GPA calculations and academic performance monitoring."
    - name: "avg_grade_points"
      expr: AVG(CAST(grade_points AS DOUBLE))
      comment: "Average grade points per registration — a proxy for academic performance quality across courses and programs."
    - name: "repeat_registrations"
      expr: COUNT(CASE WHEN repeat_indicator = TRUE THEN 1 END)
      comment: "Number of repeat course registrations — used to monitor academic progress issues and financial aid SAP risk."
    - name: "distinct_enrolled_students"
      expr: COUNT(DISTINCT profile_id)
      comment: "Unique students with at least one registration — the unduplicated headcount enrollment KPI for institutional reporting."
    - name: "distinct_courses_registered"
      expr: COUNT(DISTINCT course_id)
      comment: "Number of distinct courses with active registrations — used to assess course demand and inform scheduling decisions."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`enrollment_student_term_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Per-term student academic performance and enrollment status KPIs — tracks GPA, credit hour progress, FTE, academic standing, and retention signals. Used by academic affairs, institutional research, and financial aid to monitor student success, SAP compliance, and IPEDS reporting."
  source: "`education_ecm`.`enrollment`.`student_term_record`"
  dimensions:
    - name: "term_id"
      expr: term_id
      comment: "Academic term of the student term record — primary time dimension for cohort performance trending."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Student enrollment status for the term (e.g., full-time, half-time, less than half-time) — used for IPEDS and financial aid reporting."
    - name: "academic_standing"
      expr: academic_standing
      comment: "Academic standing (e.g., good standing, probation, suspension) — a critical student success and retention KPI dimension."
    - name: "student_level"
      expr: student_level
      comment: "Academic level (undergraduate, graduate, professional) — used to segment performance metrics by degree level."
    - name: "class_level"
      expr: class_level
      comment: "Class level (freshman, sophomore, junior, senior) — used for cohort progression and retention analysis."
    - name: "attendance_type"
      expr: attendance_type
      comment: "Full-time or part-time attendance — used for FTE calculation and financial aid eligibility segmentation."
    - name: "residency_classification"
      expr: residency_classification
      comment: "Residency classification — used for tuition revenue segmentation and state funding calculations."
    - name: "international_flag"
      expr: international_flag
      comment: "International student indicator — used for visa compliance and international enrollment reporting."
    - name: "first_generation_flag"
      expr: first_generation_flag
      comment: "First-generation student indicator — used for equity program targeting and retention intervention prioritization."
    - name: "sap_status"
      expr: sap_status
      comment: "Satisfactory Academic Progress status — a financial aid compliance KPI dimension used to identify aid-at-risk students."
    - name: "registration_hold_flag"
      expr: registration_hold_flag
      comment: "Indicates a registration hold is active — used to monitor barriers to re-enrollment and advising intervention needs."
    - name: "veteran_flag"
      expr: veteran_flag
      comment: "Veteran student indicator — used for VA benefit compliance and veteran services resource planning."
    - name: "degree_type"
      expr: degree_type
      comment: "Type of degree being pursued — used for program-level performance and completion rate analysis."
    - name: "academic_year"
      expr: academic_year
      comment: "Academic year label — used for year-over-year performance comparisons and longitudinal cohort tracking."
  measures:
    - name: "total_student_term_records"
      expr: COUNT(1)
      comment: "Total student term records — the unduplicated per-term enrollment headcount basis for institutional reporting."
    - name: "students_in_good_standing"
      expr: COUNT(CASE WHEN academic_standing = 'Good Standing' THEN 1 END)
      comment: "Number of students in good academic standing — a key student success and retention health KPI."
    - name: "students_on_probation"
      expr: COUNT(CASE WHEN academic_standing = 'Probation' THEN 1 END)
      comment: "Number of students on academic probation — used to trigger early alert and intervention programs."
    - name: "students_with_registration_hold"
      expr: COUNT(CASE WHEN registration_hold_flag = TRUE THEN 1 END)
      comment: "Number of students with an active registration hold — used to monitor re-enrollment barriers and advising workload."
    - name: "total_term_credit_hours_attempted"
      expr: SUM(CAST(credit_hours_attempted AS DOUBLE))
      comment: "Total credit hours attempted in the term — used for FTE calculation and academic workload analysis."
    - name: "total_term_credit_hours_earned"
      expr: SUM(CAST(credit_hours_earned AS DOUBLE))
      comment: "Total credit hours earned in the term — used to measure academic progress and completion efficiency."
    - name: "avg_term_gpa"
      expr: AVG(CAST(term_gpa AS DOUBLE))
      comment: "Average term GPA across all students — a headline academic quality KPI for institutional benchmarking and accreditation."
    - name: "avg_cumulative_gpa"
      expr: AVG(CAST(cumulative_gpa AS DOUBLE))
      comment: "Average cumulative GPA — used to track longitudinal academic quality trends and graduation eligibility."
    - name: "total_fte_value"
      expr: SUM(CAST(fte_value AS DOUBLE))
      comment: "Total FTE value for the term — the primary IPEDS FTE metric used for state funding allocations and peer benchmarking."
    - name: "avg_fte_value"
      expr: AVG(CAST(fte_value AS DOUBLE))
      comment: "Average FTE per student term record — used to assess full-time vs. part-time enrollment mix trends."
    - name: "total_cumulative_credit_hours_earned"
      expr: SUM(CAST(cumulative_credit_hours_earned AS DOUBLE))
      comment: "Total cumulative credit hours earned across all students — used to project time-to-degree and graduation pipeline."
    - name: "avg_cumulative_credit_hours_earned"
      expr: AVG(CAST(cumulative_credit_hours_earned AS DOUBLE))
      comment: "Average cumulative credit hours earned per student — used to assess academic progress velocity and graduation readiness."
    - name: "total_transfer_credit_hours_accepted"
      expr: SUM(CAST(transfer_credit_hours_accepted AS DOUBLE))
      comment: "Total transfer credit hours accepted — used to evaluate articulation agreement impact on time-to-degree and tuition revenue."
    - name: "distinct_students"
      expr: COUNT(DISTINCT profile_id)
      comment: "Unique students with a term record — the unduplicated headcount enrollment KPI for IPEDS and state reporting."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`enrollment_add_drop_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Course add/drop transaction KPIs — tracks enrollment changes, credit hour adjustments, FTE impacts, financial aid risk, and withdrawal patterns. Used by the Registrar, financial aid office, and academic affairs to monitor enrollment stability, revenue risk, and compliance obligations."
  source: "`education_ecm`.`enrollment`.`add_drop_transaction`"
  dimensions:
    - name: "term_id"
      expr: term_id
      comment: "Academic term of the transaction — primary time dimension for add/drop activity trending."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction (add, drop, withdraw) — the primary dimension for categorizing enrollment change activity."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Processing status of the transaction — used to filter completed vs. pending transactions for accurate reporting."
    - name: "new_registration_status"
      expr: new_registration_status
      comment: "Registration status after the transaction — used to track enrollment state transitions."
    - name: "prior_registration_status"
      expr: prior_registration_status
      comment: "Registration status before the transaction — used to analyze transition patterns and identify at-risk behaviors."
    - name: "is_complete_withdrawal"
      expr: is_complete_withdrawal
      comment: "Indicates a complete term withdrawal — the highest-severity enrollment change, triggering R2T4 and financial aid recalculation."
    - name: "is_after_withdraw_deadline"
      expr: is_after_withdraw_deadline
      comment: "Indicates the transaction occurred after the withdrawal deadline — used for policy compliance and grade impact monitoring."
    - name: "is_before_refund_deadline"
      expr: is_before_refund_deadline
      comment: "Indicates the transaction occurred before the refund deadline — used to assess tuition refund liability."
    - name: "financial_aid_impact_flag"
      expr: financial_aid_impact_flag
      comment: "Indicates the transaction has a financial aid impact — used to trigger aid recalculation and R2T4 compliance workflows."
    - name: "r2t4_required_flag"
      expr: r2t4_required_flag
      comment: "Indicates Return to Title IV calculation is required — a critical federal financial aid compliance flag."
    - name: "dfw_flag"
      expr: dfw_flag
      comment: "Indicates a D, F, or W grade outcome associated with the transaction — used for academic performance and SAP risk monitoring."
    - name: "initiator_role"
      expr: initiator_role
      comment: "Role of the person who initiated the transaction (student, advisor, registrar) — used for process audit and policy compliance."
    - name: "processing_channel"
      expr: processing_channel
      comment: "Channel through which the transaction was processed — used to evaluate self-service adoption and staff workload."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the transaction took effect — used to analyze add/drop timing patterns relative to term milestones."
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total add/drop transactions — the baseline enrollment change activity volume KPI."
    - name: "complete_withdrawals"
      expr: COUNT(CASE WHEN is_complete_withdrawal = TRUE THEN 1 END)
      comment: "Number of complete term withdrawals — a critical retention and revenue risk KPI monitored by enrollment management."
    - name: "financial_aid_impacted_transactions"
      expr: COUNT(CASE WHEN financial_aid_impact_flag = TRUE THEN 1 END)
      comment: "Number of transactions with financial aid impact — used to size aid recalculation workload and compliance risk."
    - name: "r2t4_required_transactions"
      expr: COUNT(CASE WHEN r2t4_required_flag = TRUE THEN 1 END)
      comment: "Number of transactions requiring Return to Title IV calculation — a federal compliance volume KPI."
    - name: "after_deadline_transactions"
      expr: COUNT(CASE WHEN is_after_withdraw_deadline = TRUE THEN 1 END)
      comment: "Number of transactions processed after the withdrawal deadline — used to monitor policy exception volume and compliance risk."
    - name: "total_tuition_adjustment_amount"
      expr: SUM(CAST(tuition_adjustment_amount AS DOUBLE))
      comment: "Total tuition adjustment dollars from add/drop activity — a direct revenue impact KPI for the bursar and CFO."
    - name: "avg_tuition_adjustment_amount"
      expr: AVG(CAST(tuition_adjustment_amount AS DOUBLE))
      comment: "Average tuition adjustment per transaction — used to benchmark the financial impact of enrollment changes."
    - name: "total_credit_hours_change"
      expr: SUM(CAST(credit_hours_after AS DOUBLE) - CAST(credit_hours_before AS DOUBLE))
      comment: "Net change in credit hours across all transactions — measures the aggregate enrollment load impact of add/drop activity."
    - name: "total_fte_change"
      expr: SUM(CAST(fte_after AS DOUBLE) - CAST(fte_before AS DOUBLE))
      comment: "Net FTE change from add/drop transactions — used to monitor FTE revenue impact and state funding implications."
    - name: "avg_refund_percentage"
      expr: AVG(CAST(refund_percentage AS DOUBLE))
      comment: "Average refund percentage applied to drop transactions — used to assess tuition refund liability and policy effectiveness."
    - name: "override_transactions"
      expr: COUNT(CASE WHEN override_flag = TRUE THEN 1 END)
      comment: "Number of transactions processed with an override — used to monitor policy exception rates and administrative workload."
    - name: "distinct_students_with_changes"
      expr: COUNT(DISTINCT profile_id)
      comment: "Unique students who had an add/drop transaction — used to measure the breadth of enrollment instability in a term."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`enrollment_deposit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment deposit KPIs — tracks deposit revenue, yield confirmation, waiver utilization, and refund activity. Used by enrollment management and the bursar to forecast confirmed enrollment, monitor yield, and manage deposit revenue."
  source: "`education_ecm`.`enrollment`.`deposit`"
  dimensions:
    - name: "term_id"
      expr: term_id
      comment: "Academic term associated with the deposit — primary time dimension for yield and revenue trending."
    - name: "deposit_status"
      expr: deposit_status
      comment: "Current status of the deposit (e.g., paid, refunded, waived) — used to filter active yield confirmations."
    - name: "deposit_type"
      expr: deposit_type
      comment: "Type of deposit (e.g., enrollment, housing) — used to segment deposit revenue by purpose."
    - name: "admit_type"
      expr: admit_type
      comment: "Admit type of the depositing student — used to segment yield by freshman, transfer, graduate, etc."
    - name: "academic_level"
      expr: academic_level
      comment: "Academic level of the depositing student — used for degree-level yield analysis."
    - name: "is_waived"
      expr: is_waived
      comment: "Indicates the deposit was waived — used to monitor access program utilization and revenue impact."
    - name: "is_refunded"
      expr: is_refunded
      comment: "Indicates the deposit was refunded — used to track yield loss and associated revenue reversals."
    - name: "matriculation_confirmed"
      expr: matriculation_confirmed
      comment: "Indicates the student confirmed matriculation — the definitive yield confirmation signal."
    - name: "financial_aid_applicant"
      expr: financial_aid_applicant
      comment: "Indicates the depositing student applied for financial aid — used to assess aid-dependent yield patterns."
    - name: "first_generation_student"
      expr: first_generation_student
      comment: "First-generation student indicator — used for equity and access yield analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of deposit payment — used to monitor payment channel adoption and processing costs."
    - name: "payment_date"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of deposit payment — used to track yield confirmation timing relative to enrollment deadlines."
  measures:
    - name: "total_deposits"
      expr: COUNT(1)
      comment: "Total deposit records — the baseline yield confirmation volume KPI."
    - name: "paid_deposits"
      expr: COUNT(CASE WHEN deposit_status = 'Paid' THEN 1 END)
      comment: "Number of deposits with paid status — the primary yield headcount KPI for enrollment forecasting."
    - name: "waived_deposits"
      expr: COUNT(CASE WHEN is_waived = TRUE THEN 1 END)
      comment: "Number of waived deposits — used to quantify access program utilization and associated revenue foregone."
    - name: "refunded_deposits"
      expr: COUNT(CASE WHEN is_refunded = TRUE THEN 1 END)
      comment: "Number of refunded deposits — a yield loss KPI indicating students who withdrew their enrollment commitment."
    - name: "matriculation_confirmed_deposits"
      expr: COUNT(CASE WHEN matriculation_confirmed = TRUE THEN 1 END)
      comment: "Number of deposits with confirmed matriculation — the definitive enrolled headcount from the deposit pipeline."
    - name: "total_deposit_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total deposit amount assessed — the gross deposit revenue KPI."
    - name: "total_deposit_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total deposit revenue actually collected — the net realized deposit revenue KPI for the bursar."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total deposit refunds issued — used to quantify yield loss revenue impact and refund liability."
    - name: "avg_deposit_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average deposit amount — used to benchmark deposit structures across program types and admission categories."
    - name: "distinct_depositing_applicants"
      expr: COUNT(DISTINCT enrollment_applicant_id)
      comment: "Unique applicants who submitted a deposit — the unduplicated yield headcount for enrollment forecasting."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`enrollment_prospect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment pipeline and prospect funnel KPIs — tracks inquiry volume, prospect demographics, campus visit engagement, and recruitment stage progression. Used by enrollment management and recruitment leadership to evaluate pipeline health, channel effectiveness, and diversity goals."
  source: "`education_ecm`.`enrollment`.`prospect`"
  dimensions:
    - name: "degree_level"
      expr: degree_level
      comment: "Intended degree level of the prospect — used to segment recruitment pipeline by undergraduate, graduate, and professional."
    - name: "prospect_type"
      expr: prospect_type
      comment: "Type of prospect (e.g., inquiry, lead, suspect) — used to categorize pipeline stage and prioritize outreach."
    - name: "recruitment_stage"
      expr: recruitment_stage
      comment: "Current stage in the recruitment funnel — the primary dimension for funnel conversion analysis."
    - name: "inquiry_source"
      expr: inquiry_source
      comment: "Source of the initial inquiry (e.g., college fair, web, referral) — used to evaluate recruitment channel ROI."
    - name: "citizenship_status"
      expr: citizenship_status
      comment: "Citizenship status of the prospect — used for international recruitment pipeline tracking."
    - name: "first_generation_flag"
      expr: first_generation_flag
      comment: "First-generation college student indicator — used for equity and access recruitment pipeline monitoring."
    - name: "ftiac_flag"
      expr: ftiac_flag
      comment: "First-time-in-any-college indicator — used to segment freshman vs. transfer prospect pipeline."
    - name: "campus_visit_flag"
      expr: campus_visit_flag
      comment: "Indicates the prospect visited campus — a high-intent engagement signal correlated with application conversion."
    - name: "do_not_contact_flag"
      expr: do_not_contact_flag
      comment: "Indicates the prospect has opted out of contact — used to ensure compliance with communication preferences."
    - name: "intended_entry_term"
      expr: intended_entry_term
      comment: "Prospect's intended entry term — used to align recruitment activity with enrollment planning cycles."
    - name: "state_code"
      expr: state_code
      comment: "State of the prospect — used for geographic recruitment analysis and in-state vs. out-of-state pipeline tracking."
    - name: "country_code"
      expr: country_code
      comment: "Country of the prospect — used for international recruitment pipeline geographic analysis."
    - name: "inquiry_date"
      expr: DATE_TRUNC('month', inquiry_date)
      comment: "Month of initial inquiry — used to track inquiry volume trends and seasonal recruitment patterns."
  measures:
    - name: "total_prospects"
      expr: COUNT(1)
      comment: "Total prospect records — the top-of-funnel recruitment pipeline volume KPI."
    - name: "campus_visit_prospects"
      expr: COUNT(CASE WHEN campus_visit_flag = TRUE THEN 1 END)
      comment: "Number of prospects who visited campus — a high-intent engagement KPI correlated with application and yield rates."
    - name: "first_generation_prospects"
      expr: COUNT(CASE WHEN first_generation_flag = TRUE THEN 1 END)
      comment: "Number of first-generation prospects in the pipeline — used to monitor equity and access recruitment goal progress."
    - name: "avg_self_reported_gpa"
      expr: AVG(CAST(gpa_self_reported AS DOUBLE))
      comment: "Average self-reported GPA of prospects — used to assess academic quality of the recruitment pipeline."
    - name: "distinct_prospects"
      expr: COUNT(DISTINCT prospect_id)
      comment: "Unique prospect count — the unduplicated top-of-funnel headcount for recruitment pipeline reporting."
    - name: "contactable_prospects"
      expr: COUNT(CASE WHEN do_not_contact_flag = FALSE THEN 1 END)
      comment: "Number of prospects eligible for outreach — the actionable recruitment pipeline size for campaign planning."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`enrollment_waitlist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Admissions waitlist management KPIs — tracks waitlist volume, offer conversion, and disposition outcomes. Used by enrollment management to manage enrollment buffer, forecast yield uncertainty, and evaluate waitlist strategy effectiveness."
  source: "`education_ecm`.`enrollment`.`waitlist`"
  dimensions:
    - name: "term_id"
      expr: term_id
      comment: "Academic term of the waitlist record — primary time dimension for waitlist trend analysis."
    - name: "waitlist_status"
      expr: waitlist_status
      comment: "Current status of the waitlist record (e.g., active, offered, declined, expired) — primary dimension for waitlist funnel analysis."
    - name: "waitlist_type"
      expr: waitlist_type
      comment: "Type of waitlist (e.g., program, course, housing) — used to segment waitlist activity by category."
    - name: "academic_level"
      expr: academic_level
      comment: "Academic level of the waitlisted applicant — used to segment waitlist pipeline by degree level."
    - name: "applicant_response"
      expr: applicant_response
      comment: "Applicant's response to a waitlist offer — used to measure waitlist conversion and yield from the buffer pool."
    - name: "final_disposition"
      expr: final_disposition
      comment: "Final outcome of the waitlist record (e.g., admitted, declined, expired) — used for waitlist resolution reporting."
    - name: "residency_status"
      expr: residency_status
      comment: "Residency classification of the waitlisted applicant — used for revenue and equity analysis of waitlist outcomes."
    - name: "scholarship_eligibility"
      expr: scholarship_eligibility
      comment: "Indicates whether the waitlisted applicant is eligible for scholarship — used to assess financial aid implications of waitlist admits."
    - name: "waitlist_date"
      expr: DATE_TRUNC('month', waitlist_date)
      comment: "Month the applicant was placed on the waitlist — used to track waitlist build-up timing relative to enrollment deadlines."
  measures:
    - name: "total_waitlisted"
      expr: COUNT(1)
      comment: "Total waitlist records — the baseline waitlist pool size KPI for enrollment buffer management."
    - name: "offers_extended"
      expr: COUNT(CASE WHEN offer_extended_date IS NOT NULL THEN 1 END)
      comment: "Number of waitlist offers extended to applicants — used to track waitlist activation rate and enrollment gap filling."
    - name: "offers_accepted"
      expr: COUNT(CASE WHEN applicant_response = 'Accept' THEN 1 END)
      comment: "Number of waitlist offers accepted — the waitlist yield KPI used to measure buffer pool conversion effectiveness."
    - name: "scholarship_eligible_waitlisted"
      expr: COUNT(CASE WHEN scholarship_eligibility = TRUE THEN 1 END)
      comment: "Number of scholarship-eligible waitlisted applicants — used to project financial aid budget if waitlist is activated."
    - name: "distinct_waitlisted_applicants"
      expr: COUNT(DISTINCT enrollment_applicant_id)
      comment: "Unique applicants on the waitlist — the unduplicated waitlist headcount for enrollment planning."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`enrollment_transfer_credit_eval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transfer credit evaluation KPIs — tracks credit award rates, hours accepted, and evaluation throughput. Used by the Registrar and academic affairs to monitor articulation agreement effectiveness, time-to-degree impact, and transfer student onboarding efficiency."
  source: "`education_ecm`.`enrollment`.`transfer_credit_eval`"
  dimensions:
    - name: "eval_status"
      expr: eval_status
      comment: "Status of the transfer credit evaluation (e.g., pending, approved, denied) — primary dimension for evaluation pipeline monitoring."
    - name: "eval_type"
      expr: eval_type
      comment: "Type of evaluation (e.g., course-by-course, block transfer) — used to segment evaluation workload and outcomes."
    - name: "credit_type"
      expr: credit_type
      comment: "Type of credit awarded (e.g., elective, major requirement, general education) — used to assess degree applicability of transfer credits."
    - name: "credit_awarded_flag"
      expr: credit_awarded_flag
      comment: "Indicates whether credit was awarded — the primary outcome flag for transfer credit evaluation reporting."
    - name: "course_level"
      expr: course_level
      comment: "Level of the transferred course (e.g., lower division, upper division, graduate) — used to assess academic rigor alignment."
    - name: "appeal_flag"
      expr: appeal_flag
      comment: "Indicates the evaluation was appealed — used to monitor appeal volume and policy consistency."
    - name: "posted_to_transcript_flag"
      expr: posted_to_transcript_flag
      comment: "Indicates the credit was posted to the student transcript — used to track evaluation completion and student record accuracy."
    - name: "eval_date"
      expr: DATE_TRUNC('month', eval_date)
      comment: "Month of evaluation — used to track evaluation throughput and processing timeliness."
  measures:
    - name: "total_evaluations"
      expr: COUNT(1)
      comment: "Total transfer credit evaluations — the baseline evaluation workload volume KPI for the Registrar."
    - name: "credit_awarded_evaluations"
      expr: COUNT(CASE WHEN credit_awarded_flag = TRUE THEN 1 END)
      comment: "Number of evaluations where credit was awarded — used to compute credit award rate and assess articulation effectiveness."
    - name: "appealed_evaluations"
      expr: COUNT(CASE WHEN appeal_flag = TRUE THEN 1 END)
      comment: "Number of evaluations that were appealed — used to monitor policy consistency and student satisfaction with transfer decisions."
    - name: "posted_to_transcript_evaluations"
      expr: COUNT(CASE WHEN posted_to_transcript_flag = TRUE THEN 1 END)
      comment: "Number of evaluations posted to the student transcript — used to track evaluation completion throughput."
    - name: "total_awarded_credit_hours"
      expr: SUM(CAST(awarded_credit_hours AS DOUBLE))
      comment: "Total credit hours awarded through transfer evaluations — a direct time-to-degree impact KPI."
    - name: "avg_awarded_credit_hours"
      expr: AVG(CAST(awarded_credit_hours AS DOUBLE))
      comment: "Average credit hours awarded per evaluation — used to benchmark transfer credit generosity and articulation agreement terms."
    - name: "total_sending_credit_hours"
      expr: SUM(CAST(sending_credit_hours AS DOUBLE))
      comment: "Total credit hours submitted by sending institutions — used to compute the credit acceptance rate."
    - name: "distinct_transfer_students"
      expr: COUNT(DISTINCT profile_id)
      comment: "Unique transfer students with credit evaluations — the unduplicated transfer student headcount in the evaluation pipeline."
$$;