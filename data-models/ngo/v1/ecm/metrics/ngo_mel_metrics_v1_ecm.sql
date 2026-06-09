-- Metric views for domain: mel | Business: Ngo | Version: 1 | Generated on: 2026-05-07 01:23:35

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`mel_indicator_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core MEL performance metrics tracking indicator achievement, variance, and data quality across programs, partners, and geographic areas"
  source: "`ngo_ecm`.`mel`.`indicator_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Status of the indicator result (e.g., draft, verified, reported)"
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect the indicator data (e.g., survey, administrative records, observation)"
    - name: "disaggregation_sex"
      expr: disaggregation_sex
      comment: "Sex disaggregation dimension (male, female, other)"
    - name: "disaggregation_age_group"
      expr: disaggregation_age_group
      comment: "Age group disaggregation (e.g., 0-5, 6-17, 18-59, 60+)"
    - name: "disaggregation_disability"
      expr: disaggregation_disability
      comment: "Disability status disaggregation"
    - name: "disaggregation_displacement_status"
      expr: disaggregation_displacement_status
      comment: "Displacement status (e.g., IDP, refugee, host community, returnee)"
    - name: "geographic_level"
      expr: geographic_level
      comment: "Geographic level of the result (e.g., country, region, district, site)"
    - name: "indicator_level"
      expr: indicator_level
      comment: "Logframe level of the indicator (e.g., output, outcome, impact)"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the result (e.g., pending, verified, rejected)"
    - name: "is_milestone"
      expr: is_milestone
      comment: "Flag indicating whether this result represents a milestone achievement"
    - name: "reported_to_donor"
      expr: reported_to_donor
      comment: "Flag indicating whether this result has been reported to the donor"
    - name: "collection_year"
      expr: YEAR(collection_date)
      comment: "Year when the indicator data was collected"
    - name: "collection_quarter"
      expr: CONCAT('Q', QUARTER(collection_date))
      comment: "Quarter when the indicator data was collected"
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_date)
      comment: "Month when the indicator data was collected"
    - name: "reporting_period_year"
      expr: YEAR(reporting_period_start_date)
      comment: "Year of the reporting period"
  measures:
    - name: "total_indicator_results"
      expr: COUNT(1)
      comment: "Total number of indicator result records"
    - name: "total_result_value"
      expr: SUM(CAST(result_value AS DOUBLE))
      comment: "Sum of all indicator result values achieved"
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of all indicator target values"
    - name: "total_baseline_value"
      expr: SUM(CAST(baseline_value AS DOUBLE))
      comment: "Sum of all indicator baseline values"
    - name: "total_cumulative_result"
      expr: SUM(CAST(cumulative_result AS DOUBLE))
      comment: "Sum of cumulative indicator results across all records"
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average indicator result value per record"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average indicator target value per record"
    - name: "avg_variance_from_target"
      expr: AVG(CAST(variance_from_target AS DOUBLE))
      comment: "Average variance from target across all indicator results"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage from target"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across all indicator results"
    - name: "target_achievement_rate"
      expr: ROUND(100.0 * SUM(CAST(result_value AS DOUBLE)) / NULLIF(SUM(CAST(target_value AS DOUBLE)), 0), 2)
      comment: "Percentage of target achieved (total result value divided by total target value)"
    - name: "verified_results_count"
      expr: COUNT(CASE WHEN verification_status = 'verified' THEN 1 END)
      comment: "Count of indicator results that have been verified"
    - name: "milestone_results_count"
      expr: COUNT(CASE WHEN is_milestone = TRUE THEN 1 END)
      comment: "Count of indicator results that represent milestones"
    - name: "donor_reported_results_count"
      expr: COUNT(CASE WHEN reported_to_donor = TRUE THEN 1 END)
      comment: "Count of indicator results that have been reported to donors"
    - name: "distinct_indicators"
      expr: COUNT(DISTINCT indicator_id)
      comment: "Number of unique indicators with results"
    - name: "distinct_interventions"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Number of unique interventions with indicator results"
    - name: "distinct_partners"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of unique partner organizations reporting indicator results"
    - name: "distinct_project_sites"
      expr: COUNT(DISTINCT project_site_id)
      comment: "Number of unique project sites with indicator results"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`mel_data_quality_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data quality and verification metrics tracking accuracy, completeness, consistency, and timeliness of MEL data across programs and partners"
  source: "`ngo_ecm`.`mel`.`data_quality_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the data quality assessment (e.g., planned, in progress, completed, closed)"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of data quality assessment (e.g., routine DQA, audit, verification)"
    - name: "data_source_type"
      expr: data_source_type
      comment: "Type of data source being assessed (e.g., program records, partner reports, field monitoring)"
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify data quality (e.g., document review, field visit, triangulation)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the assessment or findings (e.g., high, medium, low)"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions (e.g., not started, in progress, completed, overdue)"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the assessment (e.g., country, region, district, site)"
    - name: "country_code"
      expr: country_code
      comment: "ISO country code where the assessment was conducted"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year when the data quality assessment was conducted"
    - name: "assessment_quarter"
      expr: CONCAT('Q', QUARTER(assessment_date))
      comment: "Quarter when the data quality assessment was conducted"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month when the data quality assessment was conducted"
  measures:
    - name: "total_dqa_assessments"
      expr: COUNT(1)
      comment: "Total number of data quality assessments conducted"
    - name: "avg_overall_dqa_score"
      expr: AVG(CAST(overall_dqa_score_percentage AS DOUBLE))
      comment: "Average overall data quality assessment score across all assessments"
    - name: "avg_accuracy_score"
      expr: AVG(CAST(accuracy_score_percentage AS DOUBLE))
      comment: "Average accuracy score measuring correctness of data"
    - name: "avg_completeness_score"
      expr: AVG(CAST(completeness_score_percentage AS DOUBLE))
      comment: "Average completeness score measuring presence of required data"
    - name: "avg_consistency_score"
      expr: AVG(CAST(consistency_score_percentage AS DOUBLE))
      comment: "Average consistency score measuring internal coherence of data"
    - name: "avg_timeliness_score"
      expr: AVG(CAST(timeliness_score_percentage AS DOUBLE))
      comment: "Average timeliness score measuring whether data was reported on schedule"
    - name: "completed_assessments_count"
      expr: COUNT(CASE WHEN assessment_status = 'completed' THEN 1 END)
      comment: "Number of data quality assessments that have been completed"
    - name: "high_priority_assessments_count"
      expr: COUNT(CASE WHEN priority_level = 'high' THEN 1 END)
      comment: "Number of high-priority data quality assessments"
    - name: "corrective_actions_completed_count"
      expr: COUNT(CASE WHEN corrective_action_status = 'completed' THEN 1 END)
      comment: "Number of assessments with completed corrective actions"
    - name: "corrective_actions_overdue_count"
      expr: COUNT(CASE WHEN corrective_action_status = 'overdue' THEN 1 END)
      comment: "Number of assessments with overdue corrective actions"
    - name: "corrective_action_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_status = 'completed' THEN 1 END) / NULLIF(COUNT(CASE WHEN corrective_action_status IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of corrective actions that have been completed"
    - name: "distinct_partners_assessed"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of unique partner organizations that have undergone data quality assessments"
    - name: "distinct_interventions_assessed"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Number of unique interventions that have undergone data quality assessments"
    - name: "distinct_indicators_assessed"
      expr: COUNT(DISTINCT indicator_id)
      comment: "Number of unique indicators that have undergone data quality assessments"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`mel_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Evaluation performance and learning metrics tracking evaluation completion, cost efficiency, and DAC criteria ratings across programs"
  source: "`ngo_ecm`.`mel`.`evaluation`"
  dimensions:
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Status of the evaluation (e.g., planned, ongoing, completed, disseminated)"
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of evaluation (e.g., midterm, endline, impact, formative, summative)"
    - name: "evaluator_type"
      expr: evaluator_type
      comment: "Type of evaluator (e.g., external, internal, mixed)"
    - name: "evaluation_scope"
      expr: evaluation_scope
      comment: "Scope of the evaluation (e.g., project, program, portfolio, thematic)"
    - name: "methodology"
      expr: methodology
      comment: "Evaluation methodology used (e.g., mixed methods, quantitative, qualitative, RCT)"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall evaluation rating or conclusion"
    - name: "relevance_rating"
      expr: relevance_rating
      comment: "DAC relevance criterion rating"
    - name: "effectiveness_rating"
      expr: effectiveness_rating
      comment: "DAC effectiveness criterion rating"
    - name: "efficiency_rating"
      expr: efficiency_rating
      comment: "DAC efficiency criterion rating"
    - name: "impact_rating"
      expr: impact_rating
      comment: "DAC impact criterion rating"
    - name: "sustainability_rating"
      expr: sustainability_rating
      comment: "DAC sustainability criterion rating"
    - name: "coherence_rating"
      expr: coherence_rating
      comment: "DAC coherence criterion rating"
    - name: "management_response_status"
      expr: management_response_status
      comment: "Status of management response to evaluation (e.g., pending, submitted, accepted)"
    - name: "ethics_approval_obtained"
      expr: ethics_approval_obtained
      comment: "Flag indicating whether ethics approval was obtained for the evaluation"
    - name: "quality_assurance_conducted"
      expr: quality_assurance_conducted
      comment: "Flag indicating whether quality assurance was conducted on the evaluation"
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Geographic coverage of the evaluation"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for evaluation budget and costs"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year when the evaluation was planned to start"
    - name: "actual_start_year"
      expr: YEAR(actual_start_date)
      comment: "Year when the evaluation actually started"
    - name: "dissemination_year"
      expr: YEAR(dissemination_date)
      comment: "Year when the evaluation was disseminated"
  measures:
    - name: "total_evaluations"
      expr: COUNT(1)
      comment: "Total number of evaluations"
    - name: "completed_evaluations_count"
      expr: COUNT(CASE WHEN evaluation_status = 'completed' THEN 1 END)
      comment: "Number of completed evaluations"
    - name: "ongoing_evaluations_count"
      expr: COUNT(CASE WHEN evaluation_status = 'ongoing' THEN 1 END)
      comment: "Number of ongoing evaluations"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount for all evaluations"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for all evaluations"
    - name: "avg_budget_amount"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budgeted amount per evaluation"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per evaluation"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_cost AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of evaluation budget actually spent (cost efficiency metric)"
    - name: "external_evaluations_count"
      expr: COUNT(CASE WHEN evaluator_type = 'external' THEN 1 END)
      comment: "Number of evaluations conducted by external evaluators"
    - name: "ethics_approved_evaluations_count"
      expr: COUNT(CASE WHEN ethics_approval_obtained = TRUE THEN 1 END)
      comment: "Number of evaluations that obtained ethics approval"
    - name: "quality_assured_evaluations_count"
      expr: COUNT(CASE WHEN quality_assurance_conducted = TRUE THEN 1 END)
      comment: "Number of evaluations that underwent quality assurance"
    - name: "management_response_submitted_count"
      expr: COUNT(CASE WHEN management_response_status = 'submitted' THEN 1 END)
      comment: "Number of evaluations with submitted management responses"
    - name: "management_response_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN management_response_status = 'submitted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of evaluations with submitted management responses"
    - name: "distinct_interventions_evaluated"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Number of unique interventions that have been evaluated"
    - name: "distinct_partners_evaluated"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of unique partner organizations that have been evaluated"
    - name: "distinct_awards_evaluated"
      expr: COUNT(DISTINCT award_id)
      comment: "Number of unique awards that have been evaluated"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`mel_indicator_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Indicator target-setting and planning metrics tracking baseline values, target values, and target achievement planning across programs and partners"
  source: "`ngo_ecm`.`mel`.`indicator_target`"
  dimensions:
    - name: "target_status"
      expr: target_status
      comment: "Status of the indicator target (e.g., draft, approved, active, revised, closed)"
    - name: "target_type"
      expr: target_type
      comment: "Type of target (e.g., annual, cumulative, milestone, stretch)"
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "Frequency of measurement for the target (e.g., monthly, quarterly, annually)"
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method for collecting data against the target"
    - name: "disaggregation_sex"
      expr: disaggregation_sex
      comment: "Sex disaggregation for the target"
    - name: "disaggregation_age_group"
      expr: disaggregation_age_group
      comment: "Age group disaggregation for the target"
    - name: "disaggregation_disability_status"
      expr: disaggregation_disability_status
      comment: "Disability status disaggregation for the target"
    - name: "disaggregation_displacement_status"
      expr: disaggregation_displacement_status
      comment: "Displacement status disaggregation for the target"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the target (e.g., number, percentage, ratio)"
    - name: "donor_reporting_requirement"
      expr: donor_reporting_requirement
      comment: "Donor reporting requirement associated with the target"
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "Sustainable Development Goal alignment for the target"
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "DAC sector code for the target"
    - name: "target_year"
      expr: YEAR(target_date)
      comment: "Year when the target is expected to be achieved"
    - name: "baseline_year"
      expr: YEAR(baseline_date)
      comment: "Year when the baseline was established"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year when the target was approved"
  measures:
    - name: "total_indicator_targets"
      expr: COUNT(1)
      comment: "Total number of indicator targets set"
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of all indicator target values"
    - name: "total_baseline_value"
      expr: SUM(CAST(baseline_value AS DOUBLE))
      comment: "Sum of all indicator baseline values"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average indicator target value per target"
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average indicator baseline value per target"
    - name: "target_ambition_ratio"
      expr: ROUND(SUM(CAST(target_value AS DOUBLE)) / NULLIF(SUM(CAST(baseline_value AS DOUBLE)), 0), 2)
      comment: "Ratio of total target value to total baseline value, indicating ambition level of targets"
    - name: "approved_targets_count"
      expr: COUNT(CASE WHEN target_status = 'approved' THEN 1 END)
      comment: "Number of approved indicator targets"
    - name: "active_targets_count"
      expr: COUNT(CASE WHEN target_status = 'active' THEN 1 END)
      comment: "Number of active indicator targets"
    - name: "revised_targets_count"
      expr: COUNT(CASE WHEN target_status = 'revised' THEN 1 END)
      comment: "Number of indicator targets that have been revised"
    - name: "target_revision_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN target_status = 'revised' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of indicator targets that have been revised"
    - name: "distinct_indicators_with_targets"
      expr: COUNT(DISTINCT indicator_id)
      comment: "Number of unique indicators with targets set"
    - name: "distinct_interventions_with_targets"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Number of unique interventions with indicator targets"
    - name: "distinct_partners_with_targets"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of unique partner organizations with indicator targets"
    - name: "distinct_awards_with_targets"
      expr: COUNT(DISTINCT award_id)
      comment: "Number of unique awards with indicator targets"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`mel_evaluation_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Evaluation learning and accountability metrics tracking findings, recommendations, and corrective action implementation across programs"
  source: "`ngo_ecm`.`mel`.`evaluation_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of evaluation finding (e.g., strength, weakness, lesson learned, recommendation)"
    - name: "dac_criterion"
      expr: dac_criterion
      comment: "DAC evaluation criterion the finding relates to (relevance, effectiveness, efficiency, impact, sustainability, coherence)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the finding (e.g., high, medium, low)"
    - name: "implementation_status"
      expr: implementation_status
      comment: "Status of implementing the finding or recommendation (e.g., not started, in progress, completed, closed)"
    - name: "rating"
      expr: rating
      comment: "Rating or severity of the finding"
    - name: "cross_cutting_theme"
      expr: cross_cutting_theme
      comment: "Cross-cutting theme the finding relates to (e.g., gender, protection, environment)"
    - name: "sector"
      expr: sector
      comment: "Sector the finding relates to"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the finding"
    - name: "beneficiary_category"
      expr: beneficiary_category
      comment: "Beneficiary category the finding relates to"
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Data collection method that generated the finding"
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Flag indicating whether the finding is visible to donors"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality level of the finding"
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the finding"
    - name: "finding_year"
      expr: YEAR(finding_date)
      comment: "Year when the finding was documented"
    - name: "finding_quarter"
      expr: CONCAT('Q', QUARTER(finding_date))
      comment: "Quarter when the finding was documented"
  measures:
    - name: "total_evaluation_findings"
      expr: COUNT(1)
      comment: "Total number of evaluation findings documented"
    - name: "high_priority_findings_count"
      expr: COUNT(CASE WHEN priority_level = 'high' THEN 1 END)
      comment: "Number of high-priority evaluation findings"
    - name: "completed_findings_count"
      expr: COUNT(CASE WHEN implementation_status = 'completed' THEN 1 END)
      comment: "Number of evaluation findings with completed implementation"
    - name: "in_progress_findings_count"
      expr: COUNT(CASE WHEN implementation_status = 'in progress' THEN 1 END)
      comment: "Number of evaluation findings currently being implemented"
    - name: "not_started_findings_count"
      expr: COUNT(CASE WHEN implementation_status = 'not started' THEN 1 END)
      comment: "Number of evaluation findings not yet started"
    - name: "finding_implementation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN implementation_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of evaluation findings that have been fully implemented"
    - name: "avg_implementation_progress"
      expr: AVG(CAST(implementation_progress_percentage AS DOUBLE))
      comment: "Average implementation progress percentage across all findings"
    - name: "donor_visible_findings_count"
      expr: COUNT(CASE WHEN donor_visibility_flag = TRUE THEN 1 END)
      comment: "Number of evaluation findings visible to donors"
    - name: "distinct_evaluations_with_findings"
      expr: COUNT(DISTINCT evaluation_id)
      comment: "Number of unique evaluations that have documented findings"
    - name: "distinct_interventions_with_findings"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Number of unique interventions with evaluation findings"
    - name: "distinct_partners_with_findings"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of unique partner organizations with evaluation findings"
    - name: "distinct_action_owners"
      expr: COUNT(DISTINCT action_owner_staff_member_id)
      comment: "Number of unique staff members assigned as action owners for findings"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`mel_learning_agenda`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Organizational learning and evidence generation metrics tracking learning questions, research completion, and knowledge dissemination"
  source: "`ngo_ecm`.`mel`.`learning_agenda`"
  dimensions:
    - name: "learning_agenda_status"
      expr: learning_agenda_status
      comment: "Status of the learning agenda item (e.g., planned, ongoing, completed, disseminated)"
    - name: "learning_question_type"
      expr: learning_question_type
      comment: "Type of learning question (e.g., effectiveness, efficiency, scalability, sustainability)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the learning question (e.g., high, medium, low)"
    - name: "evidence_generation_method"
      expr: evidence_generation_method
      comment: "Method used to generate evidence (e.g., evaluation, research study, pilot, case study)"
    - name: "data_source"
      expr: data_source
      comment: "Data source for the learning agenda"
    - name: "ethics_approval_required"
      expr: ethics_approval_required
      comment: "Flag indicating whether ethics approval is required"
    - name: "donor_reporting_requirement"
      expr: donor_reporting_requirement
      comment: "Flag indicating whether the learning agenda is a donor reporting requirement"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the learning agenda"
    - name: "target_population"
      expr: target_population
      comment: "Target population for the learning agenda"
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the learning agenda"
    - name: "responsible_team"
      expr: responsible_team
      comment: "Team responsible for the learning agenda"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for learning agenda budget"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year when the learning agenda is planned to start"
    - name: "actual_start_year"
      expr: YEAR(actual_start_date)
      comment: "Year when the learning agenda actually started"
    - name: "planned_completion_year"
      expr: YEAR(planned_completion_date)
      comment: "Year when the learning agenda is planned to be completed"
  measures:
    - name: "total_learning_agenda_items"
      expr: COUNT(1)
      comment: "Total number of learning agenda items"
    - name: "completed_learning_items_count"
      expr: COUNT(CASE WHEN learning_agenda_status = 'completed' THEN 1 END)
      comment: "Number of completed learning agenda items"
    - name: "ongoing_learning_items_count"
      expr: COUNT(CASE WHEN learning_agenda_status = 'ongoing' THEN 1 END)
      comment: "Number of ongoing learning agenda items"
    - name: "disseminated_learning_items_count"
      expr: COUNT(CASE WHEN learning_agenda_status = 'disseminated' THEN 1 END)
      comment: "Number of learning agenda items that have been disseminated"
    - name: "learning_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN learning_agenda_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of learning agenda items that have been completed"
    - name: "learning_dissemination_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN learning_agenda_status = 'disseminated' THEN 1 END) / NULLIF(COUNT(CASE WHEN learning_agenda_status = 'completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed learning items that have been disseminated"
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total budget allocated for learning agenda items"
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent AS DOUBLE))
      comment: "Total budget spent on learning agenda items"
    - name: "avg_budget_allocated"
      expr: AVG(CAST(budget_allocated AS DOUBLE))
      comment: "Average budget allocated per learning agenda item"
    - name: "avg_budget_spent"
      expr: AVG(CAST(budget_spent AS DOUBLE))
      comment: "Average budget spent per learning agenda item"
    - name: "learning_budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(budget_spent AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated learning budget that has been spent"
    - name: "high_priority_learning_items_count"
      expr: COUNT(CASE WHEN priority_level = 'high' THEN 1 END)
      comment: "Number of high-priority learning agenda items"
    - name: "ethics_approval_required_count"
      expr: COUNT(CASE WHEN ethics_approval_required = TRUE THEN 1 END)
      comment: "Number of learning agenda items requiring ethics approval"
    - name: "donor_required_learning_count"
      expr: COUNT(CASE WHEN donor_reporting_requirement = TRUE THEN 1 END)
      comment: "Number of learning agenda items required by donors"
    - name: "distinct_interventions_with_learning"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Number of unique interventions with learning agenda items"
    - name: "distinct_partners_with_learning"
      expr: COUNT(DISTINCT partner_org_id)
      comment: "Number of unique partner organizations with learning agenda items"
$$;