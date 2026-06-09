-- Metric views for domain: workforce | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 03:54:25

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`workforce_learning_course`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic learning and development KPIs tracking course portfolio effectiveness, compliance coverage, cost efficiency, and certification outcomes to inform L&D investment and regulatory readiness decisions."
  source: "`travel_hospitality_ecm`.`workforce`.`learning_course`"
  dimensions:
    - name: "course_category"
      expr: course_category
      comment: "Learning course category for portfolio segmentation and investment allocation analysis"
    - name: "course_type"
      expr: course_type
      comment: "Type of learning course (e.g., technical, leadership, compliance) for strategic program mix analysis"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Course delivery method (e.g., online, in-person, hybrid) for modality effectiveness and cost analysis"
    - name: "compliance_requirement_flag"
      expr: compliance_requirement_flag
      comment: "Indicates whether course fulfills regulatory or compliance requirements, critical for risk management"
    - name: "certification_issued_flag"
      expr: certification_issued_flag
      comment: "Indicates whether course issues professional certification, key for talent development strategy"
    - name: "course_status"
      expr: course_status
      comment: "Current status of course (active, retired, under development) for portfolio health monitoring"
    - name: "vendor_name"
      expr: vendor_name
      comment: "External vendor providing course content, used for vendor performance and cost analysis"
    - name: "target_audience"
      expr: target_audience
      comment: "Intended audience segment for course, enables targeted L&D investment by workforce segment"
    - name: "language_code"
      expr: language_code
      comment: "Language of course delivery for global workforce coverage and localization strategy"
    - name: "assessment_required_flag"
      expr: assessment_required_flag
      comment: "Indicates whether course requires formal assessment, impacts quality assurance and completion tracking"
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year course became effective, for portfolio evolution and vintage analysis"
    - name: "effective_start_quarter"
      expr: CONCAT('Q', QUARTER(effective_start_date), '-', YEAR(effective_start_date))
      comment: "Quarter course became effective, for launch timing and seasonal planning analysis"
  measures:
    - name: "total_course_count"
      expr: COUNT(1)
      comment: "Total number of learning courses in portfolio, baseline measure for portfolio size and growth tracking"
    - name: "total_learning_investment"
      expr: SUM(CAST(cost_per_learner AS DOUBLE))
      comment: "Total cost per learner across all courses, critical for L&D budget planning and ROI analysis"
    - name: "avg_cost_per_learner"
      expr: AVG(CAST(cost_per_learner AS DOUBLE))
      comment: "Average cost per learner per course, key efficiency metric for cost benchmarking and vendor negotiation"
    - name: "total_training_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total training hours across portfolio, measures workforce time investment and capacity planning needs"
    - name: "avg_course_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average course duration in hours, informs time commitment expectations and scheduling efficiency"
    - name: "total_continuing_education_credits"
      expr: SUM(CAST(continuing_education_credits AS DOUBLE))
      comment: "Total continuing education credits offered, critical for professional development and regulatory compliance tracking"
    - name: "avg_continuing_education_credits"
      expr: AVG(CAST(continuing_education_credits AS DOUBLE))
      comment: "Average continuing education credits per course, measures professional development value and accreditation strength"
    - name: "compliance_course_count"
      expr: COUNT(CASE WHEN compliance_requirement_flag = TRUE THEN 1 END)
      comment: "Number of compliance-required courses, essential for regulatory risk management and audit readiness"
    - name: "certification_course_count"
      expr: COUNT(CASE WHEN certification_issued_flag = TRUE THEN 1 END)
      comment: "Number of courses issuing certifications, measures talent development capability and career progression support"
    - name: "assessed_course_count"
      expr: COUNT(CASE WHEN assessment_required_flag = TRUE THEN 1 END)
      comment: "Number of courses requiring formal assessment, indicates quality assurance rigor and competency validation"
    - name: "avg_passing_score"
      expr: AVG(CAST(passing_score AS DOUBLE))
      comment: "Average passing score threshold across assessed courses, measures quality standards and competency bar"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_name)
      comment: "Number of unique external vendors, critical for vendor concentration risk and sourcing strategy"
    - name: "distinct_category_count"
      expr: COUNT(DISTINCT course_category)
      comment: "Number of distinct course categories, measures portfolio diversity and coverage breadth for strategic planning"
    - name: "distinct_language_count"
      expr: COUNT(DISTINCT language_code)
      comment: "Number of languages supported, measures global workforce accessibility and localization investment"
$$;