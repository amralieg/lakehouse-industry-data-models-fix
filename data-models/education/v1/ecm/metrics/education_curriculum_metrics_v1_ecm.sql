-- Metric views for domain: curriculum | Business: Education | Version: 1 | Generated on: 2026-05-06 12:16:12

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`curriculum_academic_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for academic program performance, quality, and outcomes tracking"
  source: "`education_ecm`.`curriculum`.`academic_program`"
  dimensions:
    - name: "degree_level"
      expr: degree_level
      comment: "Academic degree level (undergraduate, graduate, doctoral, certificate)"
    - name: "degree_designation"
      expr: degree_designation
      comment: "Specific degree designation (BA, BS, MA, MS, PhD, etc.)"
    - name: "delivery_modality"
      expr: delivery_modality
      comment: "Program delivery mode (online, hybrid, in-person)"
    - name: "program_status"
      expr: program_status
      comment: "Current operational status of the program"
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Program accreditation standing"
    - name: "is_stem_designated"
      expr: is_stem_designated
      comment: "Whether program is designated as STEM for federal reporting"
    - name: "title_iv_eligible"
      expr: title_iv_eligible
      comment: "Federal financial aid eligibility flag"
    - name: "catalog_year"
      expr: catalog_year
      comment: "Academic catalog year for curriculum version"
    - name: "ipeds_award_level"
      expr: ipeds_award_level
      comment: "IPEDS standardized award level for federal reporting"
    - name: "program_format"
      expr: program_format
      comment: "Program format classification"
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total count of academic programs"
    - name: "avg_six_year_graduation_rate"
      expr: AVG(CAST(six_year_graduation_rate AS DOUBLE))
      comment: "Average six-year graduation rate across programs - key quality and retention metric"
    - name: "avg_dfw_rate"
      expr: AVG(CAST(dfw_rate AS DOUBLE))
      comment: "Average DFW (D grade, F grade, Withdrawal) rate - critical student success indicator"
    - name: "avg_min_gpa_required"
      expr: AVG(CAST(min_gpa_required AS DOUBLE))
      comment: "Average minimum GPA requirement for program admission"
    - name: "total_stem_programs"
      expr: SUM(CASE WHEN is_stem_designated = TRUE THEN 1 ELSE 0 END)
      comment: "Count of STEM-designated programs - strategic for federal funding and workforce alignment"
    - name: "total_title_iv_eligible_programs"
      expr: SUM(CASE WHEN title_iv_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of Title IV eligible programs - critical for student financial aid access"
    - name: "total_gainful_employment_programs"
      expr: SUM(CASE WHEN gainful_employment_applicable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of programs subject to gainful employment regulations - compliance and outcomes metric"
    - name: "total_accredited_programs"
      expr: SUM(CASE WHEN accreditation_status IN ('Accredited', 'Fully Accredited', 'Active') THEN 1 ELSE 0 END)
      comment: "Count of programs with active accreditation - quality assurance metric"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`curriculum_course`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Course portfolio and curriculum design KPIs for academic planning and resource allocation"
  source: "`education_ecm`.`curriculum`.`course`"
  dimensions:
    - name: "course_level"
      expr: course_level
      comment: "Course level classification (100-level, 200-level, graduate, etc.)"
    - name: "course_status"
      expr: course_status
      comment: "Current operational status of the course"
    - name: "delivery_modality"
      expr: delivery_modality
      comment: "Course delivery mode (online, hybrid, in-person)"
    - name: "subject_code"
      expr: subject_code
      comment: "Academic subject or discipline code"
    - name: "course_type"
      expr: course_type
      comment: "Course type classification"
    - name: "grading_basis"
      expr: grading_basis
      comment: "Grading method (letter grade, pass/fail, etc.)"
    - name: "gen_ed_category"
      expr: gen_ed_category
      comment: "General education requirement category"
    - name: "stem_designated"
      expr: stem_designated
      comment: "STEM designation flag for federal reporting"
    - name: "oer_designated"
      expr: oer_designated
      comment: "Open Educational Resources adoption flag - cost savings indicator"
    - name: "writing_intensive"
      expr: writing_intensive
      comment: "Writing-intensive course flag for curriculum requirements"
    - name: "honors_eligible"
      expr: honors_eligible
      comment: "Honors program eligibility flag"
    - name: "repeatable"
      expr: repeatable
      comment: "Whether course can be repeated for credit"
  measures:
    - name: "total_courses"
      expr: COUNT(1)
      comment: "Total count of courses in the catalog"
    - name: "avg_credit_hours"
      expr: AVG(CAST(credit_hours AS DOUBLE))
      comment: "Average credit hours per course - curriculum design metric"
    - name: "total_credit_hours"
      expr: SUM(CAST(credit_hours AS DOUBLE))
      comment: "Total credit hours across all courses - capacity planning metric"
    - name: "avg_contact_hours"
      expr: AVG(CAST(contact_hours AS DOUBLE))
      comment: "Average contact hours per course - instructional workload indicator"
    - name: "avg_lecture_hours"
      expr: AVG(CAST(lecture_hours AS DOUBLE))
      comment: "Average lecture hours per course"
    - name: "avg_lab_hours"
      expr: AVG(CAST(lab_hours AS DOUBLE))
      comment: "Average lab hours per course - facility and equipment planning metric"
    - name: "total_oer_courses"
      expr: SUM(CASE WHEN oer_designated = TRUE THEN 1 ELSE 0 END)
      comment: "Count of courses using Open Educational Resources - student affordability metric"
    - name: "total_stem_courses"
      expr: SUM(CASE WHEN stem_designated = TRUE THEN 1 ELSE 0 END)
      comment: "Count of STEM-designated courses - strategic workforce alignment metric"
    - name: "total_writing_intensive_courses"
      expr: SUM(CASE WHEN writing_intensive = TRUE THEN 1 ELSE 0 END)
      comment: "Count of writing-intensive courses - general education compliance metric"
    - name: "total_honors_eligible_courses"
      expr: SUM(CASE WHEN honors_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of honors-eligible courses - high-achieving student pathway metric"
    - name: "avg_max_repeat_hours"
      expr: AVG(CAST(max_repeat_hours AS DOUBLE))
      comment: "Average maximum repeatable credit hours"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`curriculum_articulation_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transfer pathway and articulation agreement effectiveness KPIs for enrollment growth and student mobility"
  source: "`education_ecm`.`curriculum`.`articulation_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the articulation agreement"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of articulation agreement (2+2, reverse transfer, etc.)"
    - name: "partner_institution_type"
      expr: partner_institution_type
      comment: "Type of partner institution (community college, university, etc.)"
    - name: "degree_level_from"
      expr: degree_level_from
      comment: "Degree level students transfer from"
    - name: "degree_level_to"
      expr: degree_level_to
      comment: "Degree level students transfer to"
    - name: "governing_state"
      expr: governing_state
      comment: "State jurisdiction governing the agreement"
    - name: "guaranteed_admission_flag"
      expr: guaranteed_admission_flag
      comment: "Whether agreement guarantees admission"
    - name: "scholarship_eligibility_flag"
      expr: scholarship_eligibility_flag
      comment: "Whether transfer students are eligible for scholarships"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether agreement auto-renews"
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total count of articulation agreements"
    - name: "avg_min_gpa_required"
      expr: AVG(CAST(min_gpa_required AS DOUBLE))
      comment: "Average minimum GPA required for transfer - selectivity indicator"
    - name: "avg_total_credit_hours_transferable"
      expr: AVG(CAST(total_credit_hours_transferable AS DOUBLE))
      comment: "Average transferable credit hours - student time-to-degree impact metric"
    - name: "total_credit_hours_transferable"
      expr: SUM(CAST(total_credit_hours_transferable AS DOUBLE))
      comment: "Total transferable credit hours across all agreements"
    - name: "avg_residency_requirement_credit_hours"
      expr: AVG(CAST(residency_requirement_credit_hours AS DOUBLE))
      comment: "Average residency credit hours required - revenue and completion metric"
    - name: "total_guaranteed_admission_agreements"
      expr: SUM(CASE WHEN guaranteed_admission_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of agreements with guaranteed admission - enrollment pipeline strength metric"
    - name: "total_scholarship_eligible_agreements"
      expr: SUM(CASE WHEN scholarship_eligibility_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of agreements with scholarship eligibility - competitive advantage metric"
    - name: "total_auto_renewal_agreements"
      expr: SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of auto-renewing agreements - partnership stability metric"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`curriculum_assessment_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Learning outcomes assessment and continuous improvement KPIs for accreditation and quality assurance"
  source: "`education_ecm`.`curriculum`.`assessment_cycle`"
  dimensions:
    - name: "academic_year"
      expr: academic_year
      comment: "Academic year of the assessment cycle"
    - name: "cycle_status"
      expr: cycle_status
      comment: "Current status of the assessment cycle"
    - name: "assessment_method_type"
      expr: assessment_method_type
      comment: "Type of assessment method used"
    - name: "degree_level"
      expr: degree_level
      comment: "Degree level being assessed"
    - name: "accreditation_body"
      expr: accreditation_body
      comment: "Accrediting body requiring the assessment"
    - name: "benchmark_met_flag"
      expr: benchmark_met_flag
      comment: "Whether the assessment benchmark was met - quality indicator"
    - name: "catalog_year"
      expr: catalog_year
      comment: "Catalog year for curriculum version"
  measures:
    - name: "total_assessment_cycles"
      expr: COUNT(1)
      comment: "Total count of assessment cycles"
    - name: "avg_actual_proficiency_pct"
      expr: AVG(CAST(actual_proficiency_pct AS DOUBLE))
      comment: "Average actual student proficiency percentage - learning effectiveness metric"
    - name: "avg_target_benchmark_pct"
      expr: AVG(CAST(target_benchmark_pct AS DOUBLE))
      comment: "Average target benchmark percentage - quality standard metric"
    - name: "avg_actual_mean_score"
      expr: AVG(CAST(actual_mean_score AS DOUBLE))
      comment: "Average actual mean assessment score"
    - name: "avg_proficiency_threshold_score"
      expr: AVG(CAST(proficiency_threshold_score AS DOUBLE))
      comment: "Average proficiency threshold score"
    - name: "avg_proficiency_scale_max"
      expr: AVG(CAST(proficiency_scale_max AS DOUBLE))
      comment: "Average maximum proficiency scale value"
    - name: "total_benchmarks_met"
      expr: SUM(CASE WHEN benchmark_met_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assessment cycles where benchmarks were met - quality achievement metric"
    - name: "benchmark_achievement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN benchmark_met_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessment cycles meeting benchmarks - overall quality performance metric"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`curriculum_program_accreditation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accreditation status and compliance KPIs for regulatory standing and institutional reputation"
  source: "`education_ecm`.`curriculum`.`program_accreditation`"
  dimensions:
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Current accreditation status"
    - name: "accreditation_type"
      expr: accreditation_type
      comment: "Type of accreditation (programmatic, specialized, etc.)"
    - name: "accrediting_body"
      expr: accrediting_body
      comment: "Name of the accrediting organization"
    - name: "accreditation_level"
      expr: accreditation_level
      comment: "Level of accreditation granted"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status with accreditation standards"
    - name: "annual_report_required"
      expr: annual_report_required
      comment: "Whether annual reporting is required"
    - name: "interim_report_required"
      expr: interim_report_required
      comment: "Whether interim reporting is required"
    - name: "substantive_change_approval_required"
      expr: substantive_change_approval_required
      comment: "Whether substantive change approval is required"
    - name: "teach_out_plan_required"
      expr: teach_out_plan_required
      comment: "Whether a teach-out plan is required - risk indicator"
    - name: "appeal_filed"
      expr: appeal_filed
      comment: "Whether an appeal has been filed - risk indicator"
  measures:
    - name: "total_accreditations"
      expr: COUNT(1)
      comment: "Total count of program accreditations"
    - name: "avg_accreditation_fees_annual"
      expr: AVG(CAST(accreditation_fees_annual AS DOUBLE))
      comment: "Average annual accreditation fees - cost of quality metric"
    - name: "total_accreditation_fees_annual"
      expr: SUM(CAST(accreditation_fees_annual AS DOUBLE))
      comment: "Total annual accreditation fees across all programs - institutional cost metric"
    - name: "avg_review_fees_estimated"
      expr: AVG(CAST(review_fees_estimated AS DOUBLE))
      comment: "Average estimated review fees - budgeting metric"
    - name: "total_review_fees_estimated"
      expr: SUM(CAST(review_fees_estimated AS DOUBLE))
      comment: "Total estimated review fees - institutional budgeting metric"
    - name: "total_annual_report_required"
      expr: SUM(CASE WHEN annual_report_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accreditations requiring annual reports - compliance workload metric"
    - name: "total_interim_report_required"
      expr: SUM(CASE WHEN interim_report_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accreditations requiring interim reports - compliance workload metric"
    - name: "total_teach_out_plans_required"
      expr: SUM(CASE WHEN teach_out_plan_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of programs requiring teach-out plans - institutional risk metric"
    - name: "total_appeals_filed"
      expr: SUM(CASE WHEN appeal_filed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accreditation appeals filed - risk and dispute metric"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`curriculum_transfer_equivalency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transfer credit evaluation and acceptance KPIs for student mobility and enrollment growth"
  source: "`education_ecm`.`curriculum`.`transfer_equivalency`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the transfer equivalency"
    - name: "equivalency_type"
      expr: equivalency_type
      comment: "Type of transfer equivalency (direct, elective, etc.)"
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current evaluation status"
    - name: "course_content_match_level"
      expr: course_content_match_level
      comment: "Level of content match between courses"
    - name: "applies_to_degree_level"
      expr: applies_to_degree_level
      comment: "Degree level the equivalency applies to"
    - name: "counts_toward_residency"
      expr: counts_toward_residency
      comment: "Whether transfer credit counts toward residency requirement"
    - name: "is_reciprocal"
      expr: is_reciprocal
      comment: "Whether equivalency is reciprocal between institutions"
    - name: "prerequisite_waived"
      expr: prerequisite_waived
      comment: "Whether prerequisite requirements are waived"
  measures:
    - name: "total_transfer_equivalencies"
      expr: COUNT(1)
      comment: "Total count of transfer equivalencies"
    - name: "avg_credit_hours_awarded"
      expr: AVG(CAST(credit_hours_awarded AS DOUBLE))
      comment: "Average credit hours awarded per transfer equivalency - student time-to-degree metric"
    - name: "total_credit_hours_awarded"
      expr: SUM(CAST(credit_hours_awarded AS DOUBLE))
      comment: "Total credit hours awarded via transfer - enrollment efficiency metric"
    - name: "avg_sending_course_credit_hours"
      expr: AVG(CAST(sending_course_credit_hours AS DOUBLE))
      comment: "Average credit hours of sending institution courses"
    - name: "avg_max_credit_applicable"
      expr: AVG(CAST(max_credit_applicable AS DOUBLE))
      comment: "Average maximum credit hours applicable toward degree"
    - name: "total_reciprocal_equivalencies"
      expr: SUM(CASE WHEN is_reciprocal = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reciprocal transfer equivalencies - partnership strength metric"
    - name: "total_residency_applicable_equivalencies"
      expr: SUM(CASE WHEN counts_toward_residency = TRUE THEN 1 ELSE 0 END)
      comment: "Count of equivalencies counting toward residency - revenue impact metric"
    - name: "total_prerequisite_waivers"
      expr: SUM(CASE WHEN prerequisite_waived = TRUE THEN 1 ELSE 0 END)
      comment: "Count of prerequisite waivers granted - student progression metric"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`curriculum_prerequisite_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prerequisite enforcement and student progression KPIs for academic success and retention"
  source: "`education_ecm`.`curriculum`.`prerequisite_rule`"
  dimensions:
    - name: "rule_status"
      expr: rule_status
      comment: "Current status of the prerequisite rule"
    - name: "rule_type"
      expr: rule_type
      comment: "Type of prerequisite rule"
    - name: "boolean_operator"
      expr: boolean_operator
      comment: "Logical operator for rule evaluation (AND, OR)"
    - name: "advisory_only_flag"
      expr: advisory_only_flag
      comment: "Whether rule is advisory only (not enforced)"
    - name: "concurrent_enrollment_allowed"
      expr: concurrent_enrollment_allowed
      comment: "Whether concurrent enrollment is allowed"
    - name: "sis_enforcement_flag"
      expr: sis_enforcement_flag
      comment: "Whether rule is enforced in the student information system"
    - name: "override_requires_documentation"
      expr: override_requires_documentation
      comment: "Whether override requires documentation"
    - name: "dfw_impact_flag"
      expr: dfw_impact_flag
      comment: "Whether rule is designed to reduce DFW rates - student success indicator"
    - name: "transfer_credit_applicable"
      expr: transfer_credit_applicable
      comment: "Whether transfer credit can satisfy the prerequisite"
    - name: "ap_credit_applicable"
      expr: ap_credit_applicable
      comment: "Whether AP credit can satisfy the prerequisite"
  measures:
    - name: "total_prerequisite_rules"
      expr: COUNT(1)
      comment: "Total count of prerequisite rules"
    - name: "avg_minimum_gpa"
      expr: AVG(CAST(minimum_gpa AS DOUBLE))
      comment: "Average minimum GPA required by prerequisite rules - academic rigor metric"
    - name: "avg_minimum_credit_hours"
      expr: AVG(CAST(minimum_credit_hours AS DOUBLE))
      comment: "Average minimum credit hours required"
    - name: "avg_minimum_grade_points"
      expr: AVG(CAST(minimum_grade_points AS DOUBLE))
      comment: "Average minimum grade points required"
    - name: "avg_minimum_test_score"
      expr: AVG(CAST(minimum_test_score AS DOUBLE))
      comment: "Average minimum test score required"
    - name: "total_sis_enforced_rules"
      expr: SUM(CASE WHEN sis_enforcement_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of rules enforced in SIS - registration control metric"
    - name: "total_dfw_impact_rules"
      expr: SUM(CASE WHEN dfw_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of rules designed to reduce DFW rates - student success intervention metric"
    - name: "total_concurrent_allowed_rules"
      expr: SUM(CASE WHEN concurrent_enrollment_allowed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of rules allowing concurrent enrollment - student flexibility metric"
    - name: "total_transfer_credit_applicable_rules"
      expr: SUM(CASE WHEN transfer_credit_applicable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of rules accepting transfer credit - transfer student support metric"
    - name: "total_ap_credit_applicable_rules"
      expr: SUM(CASE WHEN ap_credit_applicable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of rules accepting AP credit - high school partnership metric"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`curriculum_program_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "New program development and approval pipeline KPIs for strategic growth and innovation"
  source: "`education_ecm`.`curriculum`.`program_proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the program proposal"
    - name: "proposal_type"
      expr: proposal_type
      comment: "Type of program proposal (new, modification, closure)"
    - name: "proposed_degree_level"
      expr: proposed_degree_level
      comment: "Proposed degree level"
    - name: "proposed_delivery_modality"
      expr: proposed_delivery_modality
      comment: "Proposed delivery modality"
    - name: "is_stem_designated"
      expr: is_stem_designated
      comment: "Whether proposed program is STEM-designated"
    - name: "accreditation_required"
      expr: accreditation_required
      comment: "Whether specialized accreditation is required"
    - name: "hlc_substantive_change_required"
      expr: hlc_substantive_change_required
      comment: "Whether HLC substantive change approval is required"
    - name: "state_authorization_required"
      expr: state_authorization_required
      comment: "Whether state authorization is required"
    - name: "curriculum_committee_vote_result"
      expr: curriculum_committee_vote_result
      comment: "Curriculum committee vote outcome"
    - name: "faculty_senate_vote_result"
      expr: faculty_senate_vote_result
      comment: "Faculty senate vote outcome"
  measures:
    - name: "total_program_proposals"
      expr: COUNT(1)
      comment: "Total count of program proposals - innovation pipeline metric"
    - name: "avg_estimated_startup_cost"
      expr: AVG(CAST(estimated_startup_cost AS DOUBLE))
      comment: "Average estimated startup cost per proposal - investment planning metric"
    - name: "total_estimated_startup_cost"
      expr: SUM(CAST(estimated_startup_cost AS DOUBLE))
      comment: "Total estimated startup cost across all proposals - capital budgeting metric"
    - name: "avg_estimated_annual_operating_cost"
      expr: AVG(CAST(estimated_annual_operating_cost AS DOUBLE))
      comment: "Average estimated annual operating cost - sustainability metric"
    - name: "total_estimated_annual_operating_cost"
      expr: SUM(CAST(estimated_annual_operating_cost AS DOUBLE))
      comment: "Total estimated annual operating cost - operational budgeting metric"
    - name: "avg_estimated_annual_revenue"
      expr: AVG(CAST(estimated_annual_revenue AS DOUBLE))
      comment: "Average estimated annual revenue per proposal - ROI metric"
    - name: "total_estimated_annual_revenue"
      expr: SUM(CAST(estimated_annual_revenue AS DOUBLE))
      comment: "Total estimated annual revenue across all proposals - growth potential metric"
    - name: "avg_estimated_new_faculty_fte"
      expr: AVG(CAST(estimated_new_faculty_fte AS DOUBLE))
      comment: "Average estimated new faculty FTE required - hiring planning metric"
    - name: "total_estimated_new_faculty_fte"
      expr: SUM(CAST(estimated_new_faculty_fte AS DOUBLE))
      comment: "Total estimated new faculty FTE required - workforce planning metric"
    - name: "total_stem_proposals"
      expr: SUM(CASE WHEN is_stem_designated = TRUE THEN 1 ELSE 0 END)
      comment: "Count of STEM-designated proposals - strategic alignment metric"
    - name: "total_accreditation_required_proposals"
      expr: SUM(CASE WHEN accreditation_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of proposals requiring specialized accreditation - complexity metric"
    - name: "total_hlc_substantive_change_proposals"
      expr: SUM(CASE WHEN hlc_substantive_change_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of proposals requiring HLC substantive change - regulatory complexity metric"
$$;