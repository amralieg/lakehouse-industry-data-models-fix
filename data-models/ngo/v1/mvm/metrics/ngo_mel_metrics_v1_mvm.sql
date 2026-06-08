-- Metric views for domain: mel | Business: Ngo | Version: 1 | Generated on: 2026-05-07 03:19:07

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`mel_indicator_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core performance tracking metric view over indicator results. Measures achievement against targets, data quality, and cumulative progress — the primary KPI layer for program performance management."
  source: "`ngo_ecm`.`mel`.`indicator_result`"
  dimensions:
    - name: "indicator_level"
      expr: indicator_level
      comment: "Logframe level of the indicator (output, outcome, impact) for results chain analysis."
    - name: "result_status"
      expr: result_status
      comment: "Current status of the indicator result (e.g., on-track, off-track, achieved) for pipeline monitoring."
    - name: "disaggregation_sex"
      expr: disaggregation_sex
      comment: "Sex disaggregation dimension enabling gender-responsive performance analysis."
    - name: "disaggregation_age_group"
      expr: disaggregation_age_group
      comment: "Age group disaggregation for age-sensitive program performance analysis."
    - name: "disaggregation_displacement_status"
      expr: disaggregation_displacement_status
      comment: "Displacement status disaggregation (e.g., IDP, refugee, host community) for targeting analysis."
    - name: "disaggregation_disability"
      expr: disaggregation_disability
      comment: "Disability disaggregation for inclusive programming performance tracking."
    - name: "geographic_level"
      expr: geographic_level
      comment: "Geographic granularity of the result (national, regional, district) for spatial performance analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the indicator result, enabling like-for-like aggregation."
    - name: "verification_status"
      expr: verification_status
      comment: "Whether the result has been independently verified — critical for donor reporting credibility."
    - name: "reported_to_donor"
      expr: reported_to_donor
      comment: "Flag indicating whether this result has been included in donor reporting."
    - name: "collection_date_month"
      expr: DATE_TRUNC('MONTH', collection_date)
      comment: "Month of data collection for trend analysis of results over time."
    - name: "collection_date_year"
      expr: YEAR(collection_date)
      comment: "Year of data collection for annual performance review."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect the result data (survey, observation, administrative records) for methodology analysis."
    - name: "is_milestone"
      expr: is_milestone
      comment: "Flags milestone results for tracking critical program checkpoints."
  measures:
    - name: "total_result_value"
      expr: SUM(CAST(result_value AS DOUBLE))
      comment: "Sum of all indicator result values — the primary measure of program output and outcome achievement."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of all indicator targets against which results are measured — denominator for achievement rate."
    - name: "total_cumulative_result"
      expr: SUM(CAST(cumulative_result AS DOUBLE))
      comment: "Sum of cumulative results to date, reflecting total program reach and impact over the project lifecycle."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across all results — a governance KPI for MEL system integrity."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance from target across all indicators — signals systemic over- or under-performance."
    - name: "total_variance_from_target"
      expr: SUM(CAST(variance_from_target AS DOUBLE))
      comment: "Aggregate absolute variance from target — quantifies the total performance gap for corrective action planning."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value across indicators — provides context for interpreting result magnitude."
    - name: "count_results"
      expr: COUNT(1)
      comment: "Total number of indicator results recorded — measures MEL system activity and reporting completeness."
    - name: "count_verified_results"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END)
      comment: "Number of results that have been independently verified — a data credibility KPI for donor accountability."
    - name: "count_reported_to_donor"
      expr: COUNT(CASE WHEN reported_to_donor = TRUE THEN 1 END)
      comment: "Number of results formally reported to donors — tracks donor reporting compliance."
    - name: "count_distinct_indicators"
      expr: COUNT(DISTINCT indicator_id)
      comment: "Number of distinct indicators with results — measures breadth of performance monitoring coverage."
    - name: "count_milestone_results"
      expr: COUNT(CASE WHEN is_milestone = TRUE THEN 1 END)
      comment: "Number of milestone results achieved — tracks progress against critical program checkpoints."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`mel_indicator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic indicator portfolio metric view. Tracks the composition, coverage, and quality of the indicator framework — essential for MEL system design governance and donor compliance."
  source: "`ngo_ecm`.`mel`.`indicator`"
  dimensions:
    - name: "indicator_type"
      expr: indicator_type
      comment: "Type of indicator (output, outcome, impact, process) for results chain portfolio analysis."
    - name: "indicator_category"
      expr: indicator_category
      comment: "Thematic category of the indicator (health, education, WASH, etc.) for sector performance analysis."
    - name: "indicator_status"
      expr: indicator_status
      comment: "Current lifecycle status of the indicator (active, inactive, archived) for portfolio management."
    - name: "logframe_level"
      expr: logframe_level
      comment: "Position in the results chain (input, activity, output, outcome, impact) for theory of change alignment."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "How often the indicator is reported (monthly, quarterly, annually) for reporting burden analysis."
    - name: "data_collection_frequency"
      expr: data_collection_frequency
      comment: "Frequency of data collection for operational planning of MEL activities."
    - name: "sector"
      expr: sector
      comment: "Sector alignment of the indicator (health, livelihoods, protection) for cross-sector portfolio analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG goal alignment for strategic reporting to global frameworks."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the indicator is mandatory (donor-required) — critical for compliance tracking."
    - name: "is_custom"
      expr: is_custom
      comment: "Whether the indicator is custom-designed vs. standard — informs indicator harmonization strategy."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the indicator for aggregation and comparability analysis."
    - name: "direction_of_change"
      expr: direction_of_change
      comment: "Expected direction of change (increase/decrease) for performance interpretation."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the indicator became effective — for cohort and vintage analysis of the indicator portfolio."
  measures:
    - name: "count_indicators"
      expr: COUNT(1)
      comment: "Total number of indicators in the portfolio — measures MEL framework scope and complexity."
    - name: "count_mandatory_indicators"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Number of donor-mandated indicators — tracks compliance obligations in the indicator framework."
    - name: "count_custom_indicators"
      expr: COUNT(CASE WHEN is_custom = TRUE THEN 1 END)
      comment: "Number of custom indicators — measures organizational investment in bespoke performance measurement."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value across indicators — provides portfolio-level context for target-setting."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across indicators — benchmarks ambition level of the indicator portfolio."
    - name: "count_distinct_sectors"
      expr: COUNT(DISTINCT sector)
      comment: "Number of distinct sectors covered by indicators — measures breadth of programmatic monitoring."
    - name: "count_sdg_aligned_indicators"
      expr: COUNT(CASE WHEN sdg_alignment IS NOT NULL AND sdg_alignment <> '' THEN 1 END)
      comment: "Number of indicators aligned to SDGs — tracks strategic alignment to global development frameworks."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`mel_data_quality_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data quality governance metric view. Tracks DQA scores, corrective action status, and assessment coverage — the primary KPI layer for MEL system integrity and donor accountability."
  source: "`ngo_ecm`.`mel`.`data_quality_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of data quality assessment (routine, triggered, donor-requested) for assessment portfolio analysis."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the DQA (planned, in-progress, completed) for pipeline monitoring."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions arising from DQA findings — tracks remediation progress."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the DQA (critical, high, medium, low) for risk-based quality management."
    - name: "data_source_type"
      expr: data_source_type
      comment: "Type of data source assessed (primary, secondary, administrative) for source-level quality analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the DQA was conducted for geographic quality benchmarking."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the assessment for spatial quality analysis."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify data quality (spot check, re-interview, document review) for methodology analysis."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment for trend analysis of data quality over time."
    - name: "assessment_date_year"
      expr: YEAR(assessment_date)
      comment: "Year of assessment for annual data quality review."
    - name: "dac_criteria_assessed"
      expr: dac_criteria_assessed
      comment: "DAC evaluation criteria covered by the assessment for donor alignment analysis."
  measures:
    - name: "avg_overall_dqa_score"
      expr: AVG(CAST(overall_dqa_score_percentage AS DOUBLE))
      comment: "Average overall DQA score — the headline data quality KPI for MEL system governance."
    - name: "avg_accuracy_score"
      expr: AVG(CAST(accuracy_score_percentage AS DOUBLE))
      comment: "Average accuracy score across assessments — measures correctness of reported data."
    - name: "avg_completeness_score"
      expr: AVG(CAST(completeness_score_percentage AS DOUBLE))
      comment: "Average completeness score — measures the proportion of required data fields populated."
    - name: "avg_consistency_score"
      expr: AVG(CAST(consistency_score_percentage AS DOUBLE))
      comment: "Average consistency score — measures internal coherence of data across sources and time periods."
    - name: "avg_timeliness_score"
      expr: AVG(CAST(timeliness_score_percentage AS DOUBLE))
      comment: "Average timeliness score — measures whether data is collected and reported within required timeframes."
    - name: "count_assessments"
      expr: COUNT(1)
      comment: "Total number of DQAs conducted — measures MEL quality assurance activity level."
    - name: "count_critical_priority_assessments"
      expr: COUNT(CASE WHEN priority_level = 'Critical' THEN 1 END)
      comment: "Number of critical-priority DQAs — flags high-risk data quality situations requiring immediate leadership attention."
    - name: "count_open_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_status NOT IN ('Completed', 'Closed') AND corrective_action_status IS NOT NULL THEN 1 END)
      comment: "Number of assessments with open corrective actions — tracks remediation backlog for quality improvement."
    - name: "count_completed_assessments"
      expr: COUNT(CASE WHEN assessment_status = 'Completed' THEN 1 END)
      comment: "Number of completed DQAs — measures quality assurance throughput."
    - name: "count_distinct_countries"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries with DQA coverage — measures geographic reach of quality assurance."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`mel_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Evaluation portfolio metric view. Tracks evaluation quality ratings, cost efficiency, and management response compliance — the primary KPI layer for organizational learning and accountability."
  source: "`ngo_ecm`.`mel`.`evaluation`"
  dimensions:
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of evaluation (mid-term, final, real-time, impact) for portfolio composition analysis."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the evaluation (planned, in-progress, completed, disseminated) for pipeline management."
    - name: "evaluator_type"
      expr: evaluator_type
      comment: "Whether the evaluation was conducted internally or externally — informs independence and credibility."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall quality rating of the evaluation for portfolio-level quality benchmarking."
    - name: "effectiveness_rating"
      expr: effectiveness_rating
      comment: "DAC effectiveness rating — measures whether the intervention achieved its objectives."
    - name: "impact_rating"
      expr: impact_rating
      comment: "DAC impact rating — measures the broader changes attributable to the intervention."
    - name: "sustainability_rating"
      expr: sustainability_rating
      comment: "DAC sustainability rating — measures likelihood of benefits continuing after project closure."
    - name: "management_response_status"
      expr: management_response_status
      comment: "Status of management response to evaluation findings — tracks accountability and learning uptake."
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Geographic scope of the evaluation for spatial portfolio analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of evaluation costs for financial analysis."
    - name: "ethics_approval_obtained"
      expr: ethics_approval_obtained
      comment: "Whether ethics approval was obtained — a compliance dimension for ethical evaluation governance."
    - name: "quality_assurance_conducted"
      expr: quality_assurance_conducted
      comment: "Whether quality assurance was conducted on the evaluation — tracks evaluation quality standards."
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the evaluation was planned to start — for cohort and pipeline analysis."
    - name: "dac_criteria_assessed"
      expr: dac_criteria_assessed
      comment: "DAC criteria covered by the evaluation for donor alignment and learning portfolio analysis."
  measures:
    - name: "count_evaluations"
      expr: COUNT(1)
      comment: "Total number of evaluations — measures organizational investment in learning and accountability."
    - name: "total_evaluation_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated to evaluations — measures financial investment in organizational learning."
    - name: "total_evaluation_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of evaluations — enables budget vs. actual analysis for evaluation cost management."
    - name: "avg_evaluation_budget"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average evaluation budget — benchmarks cost of evaluations for planning and efficiency analysis."
    - name: "avg_evaluation_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual evaluation cost — tracks cost efficiency of the evaluation function."
    - name: "count_completed_evaluations"
      expr: COUNT(CASE WHEN evaluation_status = 'Completed' THEN 1 END)
      comment: "Number of completed evaluations — measures evaluation throughput and learning pipeline delivery."
    - name: "count_with_management_response"
      expr: COUNT(CASE WHEN management_response_status IS NOT NULL AND management_response_status <> '' THEN 1 END)
      comment: "Number of evaluations with a management response — tracks accountability and learning uptake rate."
    - name: "count_ethics_approved"
      expr: COUNT(CASE WHEN ethics_approval_obtained = TRUE THEN 1 END)
      comment: "Number of evaluations with ethics approval — tracks compliance with ethical research standards."
    - name: "count_external_evaluations"
      expr: COUNT(CASE WHEN evaluator_type = 'External' THEN 1 END)
      comment: "Number of externally conducted evaluations — measures investment in independent accountability."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`mel_evaluation_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Evaluation findings and recommendations tracking metric view. Monitors implementation progress of evaluation recommendations — the primary KPI for organizational learning uptake and accountability."
  source: "`ngo_ecm`.`mel`.`evaluation_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of finding (recommendation, lesson learned, good practice, risk) for learning portfolio analysis."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Current implementation status of the recommendation (not started, in progress, completed) for action tracking."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the finding (critical, high, medium, low) for risk-based action management."
    - name: "dac_criterion"
      expr: dac_criterion
      comment: "DAC evaluation criterion the finding relates to for thematic learning analysis."
    - name: "sector"
      expr: sector
      comment: "Sector the finding relates to for cross-sector learning analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the finding for spatial learning analysis."
    - name: "cross_cutting_theme"
      expr: cross_cutting_theme
      comment: "Cross-cutting theme (gender, protection, environment) for thematic learning portfolio analysis."
    - name: "beneficiary_category"
      expr: beneficiary_category
      comment: "Beneficiary category the finding relates to for population-specific learning."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether the finding is visible to donors — tracks transparency and accountability obligations."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the finding for global framework reporting."
    - name: "finding_date_year"
      expr: YEAR(finding_date)
      comment: "Year the finding was recorded for trend analysis of evaluation learning over time."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the finding for information governance."
  measures:
    - name: "count_findings"
      expr: COUNT(1)
      comment: "Total number of evaluation findings — measures volume of organizational learning generated."
    - name: "avg_implementation_progress"
      expr: AVG(CAST(implementation_progress_percentage AS DOUBLE))
      comment: "Average implementation progress percentage across all findings — the headline KPI for learning uptake and accountability."
    - name: "count_completed_findings"
      expr: COUNT(CASE WHEN implementation_status = 'Completed' THEN 1 END)
      comment: "Number of findings with completed implementation — measures organizational follow-through on evaluation recommendations."
    - name: "count_critical_priority_findings"
      expr: COUNT(CASE WHEN priority_level = 'Critical' THEN 1 END)
      comment: "Number of critical-priority findings — flags high-risk issues requiring immediate leadership attention."
    - name: "count_donor_visible_findings"
      expr: COUNT(CASE WHEN donor_visibility_flag = TRUE THEN 1 END)
      comment: "Number of findings visible to donors — tracks transparency and external accountability obligations."
    - name: "count_distinct_evaluations"
      expr: COUNT(DISTINCT evaluation_id)
      comment: "Number of distinct evaluations contributing findings — measures breadth of learning portfolio."
    - name: "count_overdue_findings"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE() AND implementation_status <> 'Completed' THEN 1 END)
      comment: "Number of findings past their target completion date without completion — a critical accountability KPI for leadership escalation."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`mel_indicator_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Indicator target-setting and planning metric view. Tracks target ambition, disaggregation coverage, and target portfolio composition — essential for program planning and donor compliance."
  source: "`ngo_ecm`.`mel`.`indicator_target`"
  dimensions:
    - name: "target_type"
      expr: target_type
      comment: "Type of target (annual, cumulative, milestone) for target portfolio composition analysis."
    - name: "target_status"
      expr: target_status
      comment: "Current status of the target (draft, approved, revised, closed) for target lifecycle management."
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "Frequency at which the target is measured for reporting burden and planning analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the target for aggregation and comparability."
    - name: "disaggregation_sex"
      expr: disaggregation_sex
      comment: "Sex disaggregation of the target for gender-responsive planning analysis."
    - name: "disaggregation_age_group"
      expr: disaggregation_age_group
      comment: "Age group disaggregation of the target for age-sensitive planning."
    - name: "disaggregation_disability_status"
      expr: disaggregation_disability_status
      comment: "Disability status disaggregation for inclusive programming target analysis."
    - name: "disaggregation_displacement_status"
      expr: disaggregation_displacement_status
      comment: "Displacement status disaggregation for population-specific target planning."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the target for global framework reporting."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "DAC sector code for donor-aligned sector reporting."
    - name: "target_date_year"
      expr: YEAR(target_date)
      comment: "Year the target is due for annual planning and pipeline analysis."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Data collection method planned for target verification."
  measures:
    - name: "count_targets"
      expr: COUNT(1)
      comment: "Total number of indicator targets — measures scope of the results framework."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of all target values — measures total programmatic ambition across the portfolio."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value per indicator — benchmarks ambition level for target-setting quality review."
    - name: "total_baseline_value"
      expr: SUM(CAST(baseline_value AS DOUBLE))
      comment: "Sum of baseline values — provides aggregate starting point context for target ambition analysis."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value — benchmarks starting conditions for target-setting quality review."
    - name: "count_approved_targets"
      expr: COUNT(CASE WHEN target_status = 'Approved' THEN 1 END)
      comment: "Number of approved targets — tracks target governance and readiness for implementation."
    - name: "count_sdg_aligned_targets"
      expr: COUNT(CASE WHEN sdg_alignment IS NOT NULL AND sdg_alignment <> '' THEN 1 END)
      comment: "Number of targets aligned to SDGs — measures strategic alignment to global development frameworks."
    - name: "count_distinct_indicators_targeted"
      expr: COUNT(DISTINCT indicator_id)
      comment: "Number of distinct indicators with targets set — measures completeness of the results framework."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`mel_meal_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MEL plan portfolio metric view. Tracks MEL plan budget allocation, coverage, and strategic alignment — the primary KPI layer for MEL system investment and governance."
  source: "`ngo_ecm`.`mel`.`meal_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the MEL plan (draft, approved, active, closed) for portfolio pipeline management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the MEL plan budget for financial analysis."
    - name: "dac_criteria_coverage"
      expr: dac_criteria_coverage
      comment: "DAC criteria covered by the MEL plan for donor alignment analysis."
    - name: "rbm_framework_alignment"
      expr: rbm_framework_alignment
      comment: "Results-based management framework alignment for strategic governance analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the MEL plan for global framework reporting."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the MEL plan became effective for cohort and vintage analysis."
    - name: "chs_commitment_alignment"
      expr: chs_commitment_alignment
      comment: "Core Humanitarian Standard commitment alignment for humanitarian accountability analysis."
  measures:
    - name: "count_meal_plans"
      expr: COUNT(1)
      comment: "Total number of MEL plans — measures organizational investment in structured monitoring and evaluation."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total budget allocated to MEL plans — the primary financial KPI for MEL investment analysis."
    - name: "avg_budget_allocated"
      expr: AVG(CAST(budget_allocated AS DOUBLE))
      comment: "Average MEL plan budget — benchmarks per-intervention MEL investment for resource allocation decisions."
    - name: "count_active_plans"
      expr: COUNT(CASE WHEN plan_status = 'Active' THEN 1 END)
      comment: "Number of currently active MEL plans — measures operational MEL coverage across the portfolio."
    - name: "count_approved_plans"
      expr: COUNT(CASE WHEN plan_status = 'Approved' THEN 1 END)
      comment: "Number of approved MEL plans — tracks governance readiness of the MEL function."
    - name: "count_distinct_interventions"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Number of distinct interventions with MEL plans — measures MEL coverage breadth across the program portfolio."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`mel_qualitative_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Qualitative data collection metric view. Tracks qualitative evidence generation, participant reach, consent compliance, and data quality — essential for accountability and learning."
  source: "`ngo_ecm`.`mel`.`qualitative_record`"
  dimensions:
    - name: "collection_method_type"
      expr: collection_method_type
      comment: "Type of qualitative method used (FGD, KII, case study, observation) for methodology portfolio analysis."
    - name: "qualitative_record_status"
      expr: qualitative_record_status
      comment: "Current status of the qualitative record (draft, reviewed, finalized) for data pipeline management."
    - name: "primary_theme"
      expr: primary_theme
      comment: "Primary thematic focus of the qualitative record for learning portfolio analysis."
    - name: "data_quality_rating"
      expr: data_quality_rating
      comment: "Quality rating of the qualitative record for data governance analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the qualitative data was collected for geographic analysis."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level (e.g., province/state) for sub-national geographic analysis."
    - name: "language_used"
      expr: language_used
      comment: "Language used during data collection for linguistic coverage analysis."
    - name: "informed_consent_obtained"
      expr: informed_consent_obtained
      comment: "Whether informed consent was obtained — a critical ethical compliance dimension."
    - name: "translation_required"
      expr: translation_required
      comment: "Whether translation was required — informs language access and inclusion analysis."
    - name: "collection_date_month"
      expr: DATE_TRUNC('MONTH', collection_date)
      comment: "Month of data collection for trend analysis of qualitative evidence generation."
    - name: "collection_date_year"
      expr: YEAR(collection_date)
      comment: "Year of data collection for annual qualitative evidence review."
    - name: "informant_role"
      expr: informant_role
      comment: "Role of the key informant or participant for stakeholder coverage analysis."
  measures:
    - name: "count_qualitative_records"
      expr: COUNT(1)
      comment: "Total number of qualitative records — measures volume of qualitative evidence generated."
    - name: "count_consent_obtained"
      expr: COUNT(CASE WHEN informed_consent_obtained = TRUE THEN 1 END)
      comment: "Number of records with informed consent obtained — tracks ethical compliance in qualitative data collection."
    - name: "count_records_requiring_translation"
      expr: COUNT(CASE WHEN translation_required = TRUE THEN 1 END)
      comment: "Number of records requiring translation — informs language access investment and inclusion analysis."
    - name: "count_distinct_project_sites"
      expr: COUNT(DISTINCT project_site_id)
      comment: "Number of distinct project sites with qualitative data — measures geographic coverage of qualitative evidence."
    - name: "count_distinct_interventions"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Number of distinct interventions with qualitative evidence — measures breadth of qualitative learning coverage."
    - name: "count_finalized_records"
      expr: COUNT(CASE WHEN qualitative_record_status = 'Finalized' THEN 1 END)
      comment: "Number of finalized qualitative records — measures qualitative evidence pipeline completion rate."
    - name: "count_distinct_countries"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries with qualitative data — measures geographic reach of qualitative MEL activities."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`mel_reporting_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reporting period governance metric view. Tracks reporting calendar compliance, period coverage, and MEL cycle scheduling — essential for donor reporting and MEL operational planning."
  source: "`ngo_ecm`.`mel`.`reporting_period`"
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Type of reporting period (monthly, quarterly, annual, project) for reporting calendar analysis."
    - name: "period_status"
      expr: period_status
      comment: "Current status of the reporting period (open, closed, overdue) for reporting pipeline management."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of reporting for this period for donor reporting compliance analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the reporting period for annual planning and financial alignment."
    - name: "calendar_year"
      expr: calendar_year
      comment: "Calendar year of the reporting period for cross-fiscal-year analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the reporting period is currently active — for operational dashboard filtering."
    - name: "baseline_period_flag"
      expr: baseline_period_flag
      comment: "Flags baseline reporting periods for results chain analysis."
    - name: "midline_period_flag"
      expr: midline_period_flag
      comment: "Flags midline reporting periods for mid-term evaluation scheduling."
    - name: "endline_period_flag"
      expr: endline_period_flag
      comment: "Flags endline reporting periods for final evaluation and project closure planning."
    - name: "donor_reporting_cycle"
      expr: donor_reporting_cycle
      comment: "Donor reporting cycle alignment for compliance tracking."
    - name: "data_quality_audit_flag"
      expr: data_quality_audit_flag
      comment: "Flags periods scheduled for data quality audits for MEL governance planning."
    - name: "start_date_year"
      expr: YEAR(start_date)
      comment: "Year the reporting period starts for annual portfolio analysis."
  measures:
    - name: "count_reporting_periods"
      expr: COUNT(1)
      comment: "Total number of reporting periods — measures reporting calendar scope and complexity."
    - name: "count_active_periods"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active reporting periods — tracks live reporting obligations."
    - name: "count_closed_periods"
      expr: COUNT(CASE WHEN period_status = 'Closed' THEN 1 END)
      comment: "Number of closed reporting periods — measures reporting cycle completion rate."
    - name: "count_dqa_scheduled_periods"
      expr: COUNT(CASE WHEN data_quality_audit_flag = TRUE THEN 1 END)
      comment: "Number of periods with DQA scheduled — tracks data quality governance coverage across the reporting calendar."
    - name: "count_baseline_periods"
      expr: COUNT(CASE WHEN baseline_period_flag = TRUE THEN 1 END)
      comment: "Number of baseline reporting periods — measures baseline data collection coverage."
    - name: "count_endline_periods"
      expr: COUNT(CASE WHEN endline_period_flag = TRUE THEN 1 END)
      comment: "Number of endline reporting periods — tracks final evaluation and project closure readiness."
    - name: "count_overdue_submissions"
      expr: COUNT(CASE WHEN report_submission_deadline < CURRENT_DATE() AND period_status <> 'Closed' THEN 1 END)
      comment: "Number of reporting periods past their submission deadline without closure — a critical compliance KPI for donor accountability."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`mel_data_collection_tool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data collection tool portfolio metric view. Tracks tool deployment coverage, ethical compliance, and quality governance — essential for MEL operational management."
  source: "`ngo_ecm`.`mel`.`data_collection_tool`"
  dimensions:
    - name: "tool_type"
      expr: tool_type
      comment: "Type of data collection tool (survey, observation checklist, interview guide) for methodology portfolio analysis."
    - name: "tool_status"
      expr: tool_status
      comment: "Current status of the tool (draft, approved, deployed, retired) for tool lifecycle management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the tool for governance compliance tracking."
    - name: "ethical_review_status"
      expr: ethical_review_status
      comment: "Ethical review status of the tool — a critical compliance dimension for research ethics governance."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Data collection method the tool supports (CAPI, PAPI, ODK, KoBoToolbox) for technology portfolio analysis."
    - name: "data_protection_compliance"
      expr: data_protection_compliance
      comment: "Data protection compliance status for GDPR and humanitarian data protection governance."
    - name: "consent_mechanism"
      expr: consent_mechanism
      comment: "Consent mechanism used by the tool for ethical compliance analysis."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the tool for language access and inclusion analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of tool deployment for spatial coverage analysis."
    - name: "respondent_type"
      expr: respondent_type
      comment: "Type of respondent the tool targets (beneficiary, staff, community leader) for stakeholder coverage analysis."
    - name: "deployment_start_year"
      expr: YEAR(deployment_start_date)
      comment: "Year of tool deployment start for cohort and vintage analysis."
  measures:
    - name: "count_tools"
      expr: COUNT(1)
      comment: "Total number of data collection tools — measures MEL data collection infrastructure scope."
    - name: "count_approved_tools"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved tools — tracks governance readiness of the data collection toolkit."
    - name: "count_ethically_reviewed_tools"
      expr: COUNT(CASE WHEN ethical_review_status = 'Approved' THEN 1 END)
      comment: "Number of tools with ethical review approval — tracks compliance with research ethics standards."
    - name: "count_deployed_tools"
      expr: COUNT(CASE WHEN tool_status = 'Deployed' THEN 1 END)
      comment: "Number of currently deployed tools — measures active data collection infrastructure."
    - name: "count_data_protection_compliant_tools"
      expr: COUNT(CASE WHEN data_protection_compliance = 'Compliant' THEN 1 END)
      comment: "Number of tools meeting data protection compliance requirements — a critical governance KPI."
    - name: "count_distinct_languages"
      expr: COUNT(DISTINCT primary_language)
      comment: "Number of distinct languages covered by tools — measures language access and inclusion in data collection."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`mel_logframe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Logframe portfolio metric view. Tracks results framework coverage, target achievement, and theory of change alignment — the strategic backbone of program performance management."
  source: "`ngo_ecm`.`mel`.`logframe`"
  dimensions:
    - name: "results_chain_level"
      expr: results_chain_level
      comment: "Level in the results chain (input, activity, output, outcome, impact) for theory of change analysis."
    - name: "mel_logframe_status"
      expr: mel_logframe_status
      comment: "Current status of the logframe (draft, approved, active, closed) for portfolio management."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Reporting frequency for logframe indicators for operational planning."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the logframe for global framework reporting."
    - name: "dac_evaluation_criterion"
      expr: dac_evaluation_criterion
      comment: "DAC evaluation criterion alignment for donor reporting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for logframe indicators for aggregation and comparability."
    - name: "is_mandatory_donor_indicator"
      expr: is_mandatory_donor_indicator
      comment: "Whether the logframe entry is a mandatory donor indicator — tracks compliance obligations."
    - name: "is_custom_indicator"
      expr: is_custom_indicator
      comment: "Whether the logframe entry uses a custom indicator — informs indicator harmonization strategy."
    - name: "theory_of_change_component"
      expr: theory_of_change_component
      comment: "Theory of change component the logframe entry maps to for strategic alignment analysis."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the logframe entry became effective for cohort analysis."
    - name: "donor_template_type"
      expr: donor_template_type
      comment: "Donor template type used for the logframe for donor compliance analysis."
  measures:
    - name: "count_logframe_entries"
      expr: COUNT(1)
      comment: "Total number of logframe entries — measures results framework scope and complexity."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of all logframe target values — measures total programmatic ambition in the results framework."
    - name: "total_actual_value"
      expr: SUM(CAST(actual_value AS DOUBLE))
      comment: "Sum of all logframe actual values — measures total program achievement against the results framework."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average logframe target value — benchmarks ambition level per results chain entry."
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average logframe actual value — benchmarks achievement level per results chain entry."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value across logframe entries — provides context for interpreting target ambition."
    - name: "count_mandatory_donor_indicators"
      expr: COUNT(CASE WHEN is_mandatory_donor_indicator = TRUE THEN 1 END)
      comment: "Number of mandatory donor indicators in the logframe — tracks compliance obligations."
    - name: "count_approved_logframes"
      expr: COUNT(CASE WHEN mel_logframe_status = 'Approved' THEN 1 END)
      comment: "Number of approved logframe entries — tracks governance readiness of the results framework."
    - name: "count_distinct_interventions"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Number of distinct interventions with logframe entries — measures results framework coverage breadth."
$$;