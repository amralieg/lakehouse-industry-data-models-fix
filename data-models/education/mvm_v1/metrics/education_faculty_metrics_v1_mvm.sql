-- Metric views for domain: faculty | Business: Education | Version: 1 | Generated on: 2026-05-06 15:08:33

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_instructor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core faculty headcount and profile metrics. Provides executive-level visibility into faculty composition by rank, tenure status, and employment classification — essential for accreditation reporting, workforce planning, and diversity initiatives."
  source: "`education_ecm`.`faculty`.`instructor`"
  dimensions:
    - name: "faculty_rank"
      expr: faculty_rank
      comment: "Academic rank of the instructor (e.g., Assistant Professor, Associate Professor, Professor) — primary grouping for workforce composition analysis."
    - name: "tenure_status"
      expr: tenure_status
      comment: "Current tenure status (e.g., Tenured, Tenure-Track, Non-Tenure-Track) — critical for workforce stability and accreditation reporting."
    - name: "employment_classification"
      expr: employment_classification
      comment: "Employment classification (e.g., Full-Time, Part-Time, Adjunct) — used to assess instructional capacity and cost structure."
    - name: "primary_college_code"
      expr: primary_college_code
      comment: "College or school the instructor is primarily affiliated with — enables college-level workforce analysis."
    - name: "graduate_faculty_status"
      expr: graduate_faculty_status
      comment: "Indicates whether the instructor holds graduate faculty status — relevant for graduate program capacity planning."
    - name: "highest_degree_earned"
      expr: highest_degree_earned
      comment: "Highest academic degree earned by the instructor — used for credential analysis and accreditation qualification tracking."
    - name: "faculty_status"
      expr: faculty_status
      comment: "Current active/inactive status of the faculty member — used to filter active headcount."
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year the instructor was hired — enables cohort and retention trend analysis."
    - name: "phd_advisor_eligible_flag"
      expr: phd_advisor_eligible_flag
      comment: "Whether the instructor is eligible to serve as a PhD advisor — relevant for doctoral program capacity."
  measures:
    - name: "total_faculty_headcount"
      expr: COUNT(DISTINCT instructor_id)
      comment: "Total number of distinct faculty members. Baseline headcount KPI used in accreditation reports, workforce planning, and executive dashboards."
    - name: "tenured_faculty_count"
      expr: COUNT(DISTINCT CASE WHEN tenure_status = 'Tenured' THEN instructor_id END)
      comment: "Number of tenured faculty. Tracks institutional stability and long-term academic commitment — a key accreditation and governance metric."
    - name: "tenure_track_faculty_count"
      expr: COUNT(DISTINCT CASE WHEN tenure_status = 'Tenure-Track' THEN instructor_id END)
      comment: "Number of tenure-track faculty. Indicates pipeline strength for future tenured positions — used in strategic hiring plans."
    - name: "phd_advisor_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN phd_advisor_eligible_flag = TRUE THEN instructor_id END)
      comment: "Number of faculty eligible to advise PhD students. Directly constrains doctoral program enrollment capacity — a critical graduate program planning metric."
    - name: "avg_teaching_load_fte"
      expr: AVG(CAST(teaching_load_fte AS DOUBLE))
      comment: "Average teaching load FTE across faculty. Measures instructional workload distribution — used to identify overloaded departments and inform hiring decisions."
    - name: "total_teaching_load_fte"
      expr: SUM(CAST(teaching_load_fte AS DOUBLE))
      comment: "Total teaching load FTE across all faculty. Represents aggregate instructional capacity — used in budget and staffing models."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Faculty appointment financial and structural metrics. Tracks salary investment, FTE allocation, and appointment composition — essential for budget stewardship, equity analysis, and workforce planning."
  source: "`education_ecm`.`faculty`.`appointment`"
  dimensions:
    - name: "academic_rank"
      expr: academic_rank
      comment: "Academic rank at the time of appointment — enables salary equity analysis by rank."
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of appointment (e.g., Tenure-Track, Visiting, Adjunct) — used to segment workforce cost and composition."
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the appointment (e.g., Active, Terminated) — used to filter active appointments for budget analysis."
    - name: "tenure_status"
      expr: tenure_status
      comment: "Tenure status associated with the appointment — used for compensation equity analysis by tenure track."
    - name: "primary_department_code"
      expr: primary_department_code
      comment: "Department code for the appointment — enables department-level salary and FTE analysis."
    - name: "salary_basis"
      expr: salary_basis
      comment: "Basis on which salary is paid (e.g., 9-month, 12-month) — affects total compensation comparisons."
    - name: "grant_funded_flag"
      expr: grant_funded_flag
      comment: "Whether the appointment is funded by a grant — used to distinguish externally funded vs. institutionally funded positions."
    - name: "joint_appointment_flag"
      expr: joint_appointment_flag
      comment: "Whether the appointment spans multiple departments — relevant for cross-departmental resource allocation analysis."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the appointment began — used for cohort and trend analysis of new appointments."
  measures:
    - name: "total_annual_salary"
      expr: SUM(CAST(annual_salary_amount AS DOUBLE))
      comment: "Total annual salary commitment across all appointments. Primary financial KPI for faculty budget stewardship and compensation equity reviews."
    - name: "avg_annual_salary"
      expr: AVG(CAST(annual_salary_amount AS DOUBLE))
      comment: "Average annual salary per appointment. Used in compensation equity analysis by rank, department, and tenure status."
    - name: "total_fte_allocated"
      expr: SUM(CAST(fte_allocation AS DOUBLE))
      comment: "Total FTE allocated across all appointments. Measures aggregate instructional and research capacity committed — used in workforce planning."
    - name: "avg_fte_allocation"
      expr: AVG(CAST(fte_allocation AS DOUBLE))
      comment: "Average FTE per appointment. Identifies part-time vs. full-time appointment patterns across departments."
    - name: "total_teaching_load_credit_hours"
      expr: SUM(CAST(teaching_load_credit_hours AS DOUBLE))
      comment: "Total contracted teaching load credit hours across all appointments. Measures instructional obligation — used to assess departmental teaching capacity."
    - name: "grant_funded_appointment_count"
      expr: COUNT(DISTINCT CASE WHEN grant_funded_flag = TRUE THEN appointment_id END)
      comment: "Number of grant-funded appointments. Tracks external funding dependency in faculty workforce — relevant for financial risk and research strategy."
    - name: "active_appointment_count"
      expr: COUNT(DISTINCT CASE WHEN appointment_status = 'Active' THEN appointment_id END)
      comment: "Number of currently active appointments. Baseline for active workforce sizing and budget forecasting."
    - name: "avg_research_expectation_pct"
      expr: AVG(CAST(research_expectation_percentage AS DOUBLE))
      comment: "Average research expectation percentage across appointments. Indicates how much of faculty time is allocated to research — used in research productivity benchmarking."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_compensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Faculty compensation analytics covering base salary, total compensation, overload pay, and market equity adjustments. Supports compensation equity reviews, budget forecasting, and regulatory compliance reporting."
  source: "`education_ecm`.`faculty`.`compensation`"
  dimensions:
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of appointment associated with the compensation record — used to segment compensation by faculty category."
    - name: "rank_at_compensation"
      expr: rank_at_compensation
      comment: "Academic rank at the time of the compensation record — enables rank-based salary equity analysis."
    - name: "tenure_track_status"
      expr: tenure_track_status
      comment: "Tenure track status at time of compensation — used for equity analysis between tenured and non-tenured faculty."
    - name: "salary_basis"
      expr: salary_basis
      comment: "Basis of salary payment (e.g., 9-month, 12-month) — required for normalized compensation comparisons."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade classification — used for compensation band analysis and market benchmarking."
    - name: "compensation_status"
      expr: compensation_status
      comment: "Status of the compensation record (e.g., Active, Historical) — used to filter current compensation records."
    - name: "terminal_degree_flag"
      expr: terminal_degree_flag
      comment: "Whether the faculty member holds a terminal degree — used to analyze compensation premium for terminal degree holders."
    - name: "market_equity_adjustment_flag"
      expr: market_equity_adjustment_flag
      comment: "Whether a market equity adjustment was applied — used to track equity correction actions across the faculty."
    - name: "last_salary_action_type"
      expr: last_salary_action_type
      comment: "Type of the most recent salary action (e.g., Merit, Equity, Promotion) — used to analyze compensation change drivers."
    - name: "cip_code"
      expr: cip_code
      comment: "Classification of Instructional Programs code — enables discipline-level compensation benchmarking."
  measures:
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary across all compensation records. Primary budget line item for faculty compensation — used in financial planning and equity audits."
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary per compensation record. Core metric for compensation equity analysis by rank, discipline, and tenure status."
    - name: "total_compensation"
      expr: SUM(CAST(total_compensation_amount AS DOUBLE))
      comment: "Total all-in compensation including base, stipends, and summer salary. Represents true cost of faculty workforce — used in budget forecasting."
    - name: "avg_total_compensation"
      expr: AVG(CAST(total_compensation_amount AS DOUBLE))
      comment: "Average total compensation per faculty member. Used in market benchmarking and compensation strategy reviews."
    - name: "total_administrative_stipend"
      expr: SUM(CAST(administrative_stipend_amount AS DOUBLE))
      comment: "Total administrative stipend payments. Tracks cost of administrative roles (e.g., department chairs, program directors) held by faculty."
    - name: "total_summer_salary"
      expr: SUM(CAST(summer_salary_amount AS DOUBLE))
      comment: "Total summer salary paid to faculty. Measures supplemental compensation cost — relevant for budget planning and grant cost allocation."
    - name: "total_market_equity_adjustment"
      expr: SUM(CAST(market_equity_adjustment_amount AS DOUBLE))
      comment: "Total market equity adjustment amounts paid. Tracks institutional investment in correcting compensation inequities — a key HR and governance metric."
    - name: "avg_overload_pay_rate"
      expr: AVG(CAST(overload_pay_rate AS DOUBLE))
      comment: "Average overload pay rate. Used to benchmark and govern overload compensation policies across departments."
    - name: "avg_contract_months"
      expr: AVG(CAST(contract_months AS DOUBLE))
      comment: "Average contract length in months. Indicates the mix of 9-month vs. 12-month appointments — relevant for total compensation normalization."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_teaching_load`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Faculty teaching load and instructional productivity metrics. Tracks credit hour delivery, overload, release time, and student credit hour generation — essential for accreditation, workload equity, and instructional efficiency analysis."
  source: "`education_ecm`.`faculty`.`teaching_load`"
  dimensions:
    - name: "faculty_rank"
      expr: faculty_rank
      comment: "Academic rank of the instructor — used to analyze teaching load distribution by rank."
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of appointment — used to compare teaching loads across full-time, part-time, and adjunct faculty."
    - name: "tenure_track_status"
      expr: tenure_track_status
      comment: "Tenure track status — used to analyze whether tenure-track faculty carry equitable teaching loads."
    - name: "college_code"
      expr: college_code
      comment: "College or school associated with the teaching load — enables college-level instructional capacity analysis."
    - name: "load_balance_status"
      expr: load_balance_status
      comment: "Status indicating whether the teaching load is balanced, overloaded, or underloaded — used for workload equity monitoring."
    - name: "graduate_course_flag"
      expr: graduate_course_flag
      comment: "Whether the course is a graduate-level course — used to distinguish graduate vs. undergraduate teaching load."
    - name: "online_course_flag"
      expr: online_course_flag
      comment: "Whether the course is delivered online — used to analyze online vs. in-person instructional load distribution."
    - name: "accreditation_qualified_flag"
      expr: accreditation_qualified_flag
      comment: "Whether the instructor is accreditation-qualified for the course — critical for SACSCOC and regional accreditation compliance."
    - name: "terminal_degree_flag"
      expr: terminal_degree_flag
      comment: "Whether the instructor holds a terminal degree — used to analyze instructional quality indicators."
    - name: "record_effective_from_date"
      expr: DATE_TRUNC('month', record_effective_from_date)
      comment: "Month the teaching load record became effective — used for trend analysis of teaching load over time."
  measures:
    - name: "total_actual_credit_hours_taught"
      expr: SUM(CAST(actual_credit_hours_taught AS DOUBLE))
      comment: "Total credit hours actually taught across all faculty. Primary measure of instructional output — used in accreditation reports and productivity benchmarking."
    - name: "total_contracted_credit_hours"
      expr: SUM(CAST(contracted_credit_hours AS DOUBLE))
      comment: "Total contracted credit hours across all faculty. Represents the institutional teaching obligation — used to measure fulfillment against contract."
    - name: "total_overload_credit_hours"
      expr: SUM(CAST(overload_credit_hours AS DOUBLE))
      comment: "Total overload credit hours taught beyond contracted load. Tracks supplemental teaching burden and associated compensation liability."
    - name: "total_student_credit_hours_generated"
      expr: SUM(CAST(student_credit_hours_generated AS DOUBLE))
      comment: "Total student credit hours generated by faculty instruction. A key productivity and revenue-proxy metric used in state funding formulas and accreditation."
    - name: "total_research_release_hours"
      expr: SUM(CAST(research_release_hours AS DOUBLE))
      comment: "Total teaching hours released for research activities. Measures institutional investment in research productivity — used in research strategy and budget analysis."
    - name: "total_administrative_release_hours"
      expr: SUM(CAST(administrative_release_hours AS DOUBLE))
      comment: "Total teaching hours released for administrative duties. Tracks the cost of administrative service in terms of instructional capacity foregone."
    - name: "avg_load_variance_hours"
      expr: AVG(CAST(load_variance_hours AS DOUBLE))
      comment: "Average variance between contracted and actual teaching hours. Identifies systemic over- or under-delivery of teaching load — used in workload equity reviews."
    - name: "avg_faculty_to_student_ratio"
      expr: AVG(CAST(faculty_to_student_ratio AS DOUBLE))
      comment: "Average faculty-to-student ratio across teaching assignments. A key accreditation and instructional quality metric used in program reviews."
    - name: "accreditation_qualified_section_count"
      expr: COUNT(DISTINCT CASE WHEN accreditation_qualified_flag = TRUE THEN teaching_load_id END)
      comment: "Number of teaching load records where the instructor is accreditation-qualified. Used to demonstrate compliance with accreditor faculty qualification requirements."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_tenure_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tenure review process metrics tracking case outcomes, review timelines, and committee decision patterns. Supports governance oversight, equity analysis, and accreditation reporting on faculty tenure processes."
  source: "`education_ecm`.`faculty`.`tenure_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the tenure case (e.g., In Review, Approved, Denied) — primary grouping for pipeline and outcome analysis."
    - name: "final_outcome"
      expr: final_outcome
      comment: "Final decision on the tenure case (e.g., Granted, Denied, Withdrawn) — used for outcome rate analysis and equity audits."
    - name: "review_type"
      expr: review_type
      comment: "Type of review (e.g., Tenure, Promotion, Post-Tenure) — used to segment cases by review category."
    - name: "current_rank"
      expr: current_rank
      comment: "Academic rank at the time of the tenure case — used to analyze tenure outcomes by rank."
    - name: "proposed_rank"
      expr: proposed_rank
      comment: "Rank proposed upon successful tenure — used to track promotion patterns."
    - name: "review_cycle_year"
      expr: review_cycle_year
      comment: "Academic year of the review cycle — used for year-over-year tenure pipeline trend analysis."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Whether an appeal was filed — used to monitor contested tenure decisions and governance risk."
    - name: "board_approval_status"
      expr: board_approval_status
      comment: "Status of board-level approval — used to track cases pending final institutional approval."
    - name: "final_outcome_year"
      expr: YEAR(final_outcome_date)
      comment: "Year the final tenure outcome was determined — used for cohort and trend analysis."
  measures:
    - name: "total_tenure_cases"
      expr: COUNT(DISTINCT tenure_case_id)
      comment: "Total number of tenure cases initiated. Baseline metric for tenure pipeline volume — used in governance and accreditation reporting."
    - name: "tenure_granted_count"
      expr: COUNT(DISTINCT CASE WHEN final_outcome = 'Granted' THEN tenure_case_id END)
      comment: "Number of tenure cases resulting in tenure being granted. Used to calculate tenure success rates and benchmark against peer institutions."
    - name: "tenure_denied_count"
      expr: COUNT(DISTINCT CASE WHEN final_outcome = 'Denied' THEN tenure_case_id END)
      comment: "Number of tenure cases resulting in denial. Used in equity audits and governance reviews to identify potential bias patterns."
    - name: "appeal_filed_count"
      expr: COUNT(DISTINCT CASE WHEN appeal_filed_flag = TRUE THEN tenure_case_id END)
      comment: "Number of tenure cases where an appeal was filed. Tracks contested decisions — a governance risk and process quality indicator."
    - name: "avg_tenure_clock_years_elapsed"
      expr: AVG(CAST(tenure_clock_years_elapsed AS DOUBLE))
      comment: "Average number of years elapsed on the tenure clock at time of review. Used to assess whether faculty are progressing through tenure on schedule."
    - name: "external_review_required_count"
      expr: COUNT(DISTINCT CASE WHEN external_review_required_flag = TRUE THEN tenure_case_id END)
      comment: "Number of cases requiring external peer review. Tracks compliance with tenure policy requirements for external evaluation."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_annual_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Faculty annual performance review metrics covering teaching, research, and service ratings, merit pay decisions, and grant productivity. Supports performance management, merit allocation, and research output benchmarking."
  source: "`education_ecm`.`faculty`.`annual_review`"
  dimensions:
    - name: "overall_performance_rating"
      expr: overall_performance_rating
      comment: "Overall performance rating assigned during the annual review — primary dimension for performance distribution analysis."
    - name: "teaching_rating"
      expr: teaching_rating
      comment: "Teaching performance rating — used to analyze instructional quality distribution across faculty."
    - name: "research_rating"
      expr: research_rating
      comment: "Research performance rating — used to benchmark research productivity and identify high performers."
    - name: "service_rating"
      expr: service_rating
      comment: "Service performance rating — used to assess faculty contribution to institutional governance and community."
    - name: "tenure_track_status"
      expr: tenure_track_status
      comment: "Tenure track status at time of review — used to compare performance ratings between tenured and tenure-track faculty."
    - name: "merit_pay_recommended_flag"
      expr: merit_pay_recommended_flag
      comment: "Whether merit pay was recommended — used to analyze merit pay distribution patterns and equity."
    - name: "review_status"
      expr: review_status
      comment: "Status of the review process (e.g., Complete, Pending) — used to track review completion rates."
    - name: "review_period_start_year"
      expr: YEAR(review_period_start_date)
      comment: "Year the review period began — used for year-over-year performance trend analysis."
  measures:
    - name: "avg_course_evaluation_score"
      expr: AVG(CAST(average_course_evaluation_score AS DOUBLE))
      comment: "Average student course evaluation score across faculty reviews. Key instructional quality indicator used in promotion, tenure, and merit decisions."
    - name: "total_merit_pay_amount"
      expr: SUM(CAST(merit_pay_amount AS DOUBLE))
      comment: "Total merit pay awarded across all reviews. Tracks institutional investment in performance-based compensation — used in budget and equity analysis."
    - name: "avg_merit_pay_percentage"
      expr: AVG(CAST(merit_pay_percentage AS DOUBLE))
      comment: "Average merit pay percentage awarded. Used to benchmark merit pay generosity and equity across departments and ranks."
    - name: "total_grant_funding_amount"
      expr: SUM(CAST(grant_funding_amount AS DOUBLE))
      comment: "Total grant funding amount reported in annual reviews. Measures research revenue generation by faculty — a key research productivity and financial KPI."
    - name: "merit_pay_recommended_count"
      expr: COUNT(DISTINCT CASE WHEN merit_pay_recommended_flag = TRUE THEN annual_review_id END)
      comment: "Number of faculty recommended for merit pay. Used to analyze merit pay eligibility rates and distribution equity."
    - name: "avg_teaching_load_credit_hours"
      expr: AVG(CAST(teaching_load_credit_hours AS DOUBLE))
      comment: "Average teaching load credit hours reported in annual reviews. Used to validate teaching load compliance and benchmark across departments."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_hire_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Faculty hiring pipeline and onboarding metrics. Tracks hiring volume, initial salary investment, startup packages, diversity hiring, and tenure-track appointment patterns — essential for strategic workforce planning and DEI reporting."
  source: "`education_ecm`.`faculty`.`hire_event`"
  dimensions:
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of appointment for the hire (e.g., Tenure-Track, Visiting, Adjunct) — used to segment hiring activity by appointment category."
    - name: "initial_rank"
      expr: initial_rank
      comment: "Academic rank at time of hire — used to analyze entry-level rank distribution and hiring strategy."
    - name: "tenure_track_status"
      expr: tenure_track_status
      comment: "Tenure track status at hire — used to track tenure-track vs. non-tenure-track hiring trends."
    - name: "hire_status"
      expr: hire_status
      comment: "Status of the hire event (e.g., Completed, Rescinded) — used to filter successful hires."
    - name: "diversity_hire_flag"
      expr: diversity_hire_flag
      comment: "Whether the hire was classified as a diversity hire — used in DEI reporting and affirmative action compliance."
    - name: "external_hire_flag"
      expr: external_hire_flag
      comment: "Whether the hire was external (vs. internal promotion) — used to analyze build vs. buy talent strategy."
    - name: "terminal_degree_flag"
      expr: terminal_degree_flag
      comment: "Whether the hire holds a terminal degree — used to track credential quality of incoming faculty."
    - name: "search_type"
      expr: search_type
      comment: "Type of search conducted (e.g., National, Regional, Internal) — used to analyze recruiting reach and cost."
    - name: "actual_start_year"
      expr: YEAR(actual_start_date)
      comment: "Year the faculty member actually started — used for cohort-based hiring trend analysis."
  measures:
    - name: "total_hires"
      expr: COUNT(DISTINCT hire_event_id)
      comment: "Total number of faculty hire events. Baseline hiring volume metric used in workforce planning and accreditation reporting."
    - name: "total_initial_annual_salary"
      expr: SUM(CAST(initial_annual_salary AS DOUBLE))
      comment: "Total initial annual salary committed across all hires. Measures new salary budget obligation — used in financial planning and compensation equity analysis."
    - name: "avg_initial_annual_salary"
      expr: AVG(CAST(initial_annual_salary AS DOUBLE))
      comment: "Average initial annual salary for new hires. Used to benchmark starting salaries by rank, discipline, and search type."
    - name: "total_startup_package_amount"
      expr: SUM(CAST(startup_package_amount AS DOUBLE))
      comment: "Total startup package investment for new faculty hires. Tracks one-time research investment cost — used in budget planning and ROI analysis for faculty recruitment."
    - name: "total_relocation_assistance"
      expr: SUM(CAST(relocation_assistance_amount AS DOUBLE))
      comment: "Total relocation assistance paid to new hires. Tracks recruitment cost component — used in total cost-of-hire analysis."
    - name: "diversity_hire_count"
      expr: COUNT(DISTINCT CASE WHEN diversity_hire_flag = TRUE THEN hire_event_id END)
      comment: "Number of hires classified as diversity hires. Core DEI metric used in affirmative action plans and board-level diversity reporting."
    - name: "avg_research_load_percentage"
      expr: AVG(CAST(research_load_percentage AS DOUBLE))
      comment: "Average research load percentage negotiated at hire. Indicates the research intensity of incoming faculty — used in research strategy and capacity planning."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_leave_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Faculty leave utilization and compliance metrics. Tracks leave duration, FMLA usage, paid vs. unpaid leave, and tenure clock impacts — essential for HR compliance, workforce availability planning, and regulatory reporting."
  source: "`education_ecm`.`faculty`.`leave_record`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave taken (e.g., FMLA, Sabbatical, Medical, Personal) — primary dimension for leave pattern analysis."
    - name: "leave_subtype"
      expr: leave_subtype
      comment: "Subtype of leave for more granular classification — used for detailed leave reporting."
    - name: "leave_status"
      expr: leave_status
      comment: "Current status of the leave record (e.g., Approved, Active, Returned) — used to filter active vs. historical leave."
    - name: "paid_leave_flag"
      expr: paid_leave_flag
      comment: "Whether the leave is paid — used to analyze paid vs. unpaid leave distribution and associated cost."
    - name: "fmla_eligible_flag"
      expr: fmla_eligible_flag
      comment: "Whether the leave qualifies under FMLA — used for federal compliance reporting."
    - name: "tenure_clock_stop_flag"
      expr: tenure_clock_stop_flag
      comment: "Whether the leave stopped the tenure clock — used to track tenure timeline impacts of leave events."
    - name: "college_code"
      expr: college_code
      comment: "College associated with the leave record — enables college-level leave utilization analysis."
    - name: "approved_start_year"
      expr: YEAR(approved_start_date)
      comment: "Year the leave was approved to begin — used for year-over-year leave trend analysis."
  measures:
    - name: "total_leave_records"
      expr: COUNT(DISTINCT leave_record_id)
      comment: "Total number of faculty leave records. Baseline leave volume metric used in HR compliance and workforce availability planning."
    - name: "total_leave_duration_weeks"
      expr: SUM(CAST(leave_duration_weeks AS DOUBLE))
      comment: "Total weeks of leave taken across all faculty. Measures aggregate instructional and research capacity lost to leave — used in workforce availability modeling."
    - name: "avg_leave_duration_weeks"
      expr: AVG(CAST(leave_duration_weeks AS DOUBLE))
      comment: "Average leave duration in weeks per leave event. Used to benchmark leave patterns and identify outliers requiring HR intervention."
    - name: "total_fmla_hours_used"
      expr: SUM(CAST(fmla_hours_used AS DOUBLE))
      comment: "Total FMLA hours consumed across all faculty leave records. Core federal compliance metric — used in FMLA utilization reporting and legal risk management."
    - name: "tenure_clock_stop_count"
      expr: COUNT(DISTINCT CASE WHEN tenure_clock_stop_flag = TRUE THEN leave_record_id END)
      comment: "Number of leave events that stopped the tenure clock. Tracks tenure timeline disruptions — used in tenure planning and equity analysis."
    - name: "avg_reduced_schedule_fte"
      expr: AVG(CAST(reduced_schedule_fte AS DOUBLE))
      comment: "Average FTE during reduced schedule leave. Measures partial capacity during leave periods — used in instructional coverage planning."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_rank_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Faculty rank progression and promotion metrics. Tracks promotion patterns, time-in-rank, salary changes at promotion, and cumulative service — essential for faculty development strategy, equity analysis, and accreditation reporting."
  source: "`education_ecm`.`faculty`.`rank_history`"
  dimensions:
    - name: "prior_rank"
      expr: prior_rank
      comment: "Academic rank before the change — used to analyze promotion pathways and rank transition patterns."
    - name: "new_rank"
      expr: new_rank
      comment: "Academic rank after the change — used to track promotion destinations and rank distribution over time."
    - name: "change_reason"
      expr: change_reason
      comment: "Reason for the rank change (e.g., Promotion, Initial Appointment, Hire) — used to distinguish promotions from other rank changes."
    - name: "tenure_track_status"
      expr: tenure_track_status
      comment: "Tenure track status at time of rank change — used to analyze promotion rates by tenure track."
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of appointment at time of rank change — used to segment promotion analysis by appointment category."
    - name: "college_code"
      expr: college_code
      comment: "College associated with the rank change — enables college-level promotion rate analysis."
    - name: "terminal_degree_flag"
      expr: terminal_degree_flag
      comment: "Whether the faculty member holds a terminal degree at time of rank change — used to analyze credential impact on promotion."
    - name: "external_hire_flag"
      expr: external_hire_flag
      comment: "Whether the faculty member was an external hire — used to compare promotion rates between internal and external hires."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the rank change became effective — used for year-over-year promotion trend analysis."
  measures:
    - name: "total_rank_changes"
      expr: COUNT(DISTINCT rank_history_id)
      comment: "Total number of rank change events. Baseline promotion activity metric used in faculty development and workforce planning."
    - name: "avg_years_in_prior_rank"
      expr: AVG(CAST(years_in_prior_rank AS DOUBLE))
      comment: "Average years spent in the prior rank before promotion. Key metric for assessing promotion velocity and identifying potential equity issues in time-to-promotion."
    - name: "avg_cumulative_years_of_service"
      expr: AVG(CAST(cumulative_years_of_service AS DOUBLE))
      comment: "Average cumulative years of service at time of rank change. Used to benchmark promotion timing against institutional and national norms."
    - name: "avg_salary_at_change"
      expr: AVG(CAST(salary_at_change AS DOUBLE))
      comment: "Average salary at the time of rank change. Used in compensation equity analysis to assess whether promotion salary adjustments are consistent across demographics and departments."
    - name: "total_salary_at_change"
      expr: SUM(CAST(salary_at_change AS DOUBLE))
      comment: "Total salary commitment at time of rank changes. Measures aggregate compensation impact of promotion decisions — used in budget forecasting."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_credential`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Faculty credential quality and compliance metrics. Tracks terminal degree attainment, credential verification status, and accreditation qualification — essential for SACSCOC and regional accreditation compliance reporting."
  source: "`education_ecm`.`faculty`.`credential`"
  dimensions:
    - name: "credential_type"
      expr: credential_type
      comment: "Type of credential (e.g., Degree, License, Certification) — primary grouping for credential portfolio analysis."
    - name: "credential_level"
      expr: credential_level
      comment: "Level of the credential (e.g., Doctoral, Masters, Bachelors) — used to assess faculty qualification levels."
    - name: "degree_type"
      expr: degree_type
      comment: "Specific degree type (e.g., PhD, EdD, JD, MD) — used for discipline-specific accreditation qualification analysis."
    - name: "field_of_study"
      expr: field_of_study
      comment: "Field of study for the credential — used to match faculty credentials to teaching disciplines for accreditation."
    - name: "terminal_degree_flag"
      expr: terminal_degree_flag
      comment: "Whether this credential is a terminal degree — primary accreditation qualification indicator."
    - name: "verification_status"
      expr: verification_status
      comment: "Status of credential verification (e.g., Verified, Pending, Failed) — used to track compliance with credential verification requirements."
    - name: "record_status"
      expr: record_status
      comment: "Active/inactive status of the credential record — used to filter current credentials."
    - name: "awarding_institution_country"
      expr: awarding_institution_country
      comment: "Country of the awarding institution — used to identify international credentials requiring additional verification."
    - name: "conferral_year"
      expr: YEAR(conferral_date)
      comment: "Year the credential was conferred — used for credential recency analysis."
  measures:
    - name: "total_credentials"
      expr: COUNT(DISTINCT credential_id)
      comment: "Total number of faculty credentials on file. Baseline credential inventory metric used in accreditation documentation."
    - name: "terminal_degree_count"
      expr: COUNT(DISTINCT CASE WHEN terminal_degree_flag = TRUE THEN credential_id END)
      comment: "Number of terminal degree credentials. Core accreditation metric — SACSCOC and regional accreditors require minimum percentages of faculty with terminal degrees."
    - name: "verified_credential_count"
      expr: COUNT(DISTINCT CASE WHEN verification_status = 'Verified' THEN credential_id END)
      comment: "Number of credentials with verified status. Tracks compliance with credential verification policies — unverified credentials create accreditation risk."
    - name: "transcript_on_file_count"
      expr: COUNT(DISTINCT CASE WHEN transcript_on_file_flag = TRUE THEN credential_id END)
      comment: "Number of credentials with transcripts on file. Accreditation bodies require official transcripts — this metric tracks documentation compliance."
    - name: "primary_credential_count"
      expr: COUNT(DISTINCT CASE WHEN primary_credential_flag = TRUE THEN credential_id END)
      comment: "Number of primary credentials designated per instructor. Used to ensure each faculty member has a designated primary qualifying credential for accreditation purposes."
$$;