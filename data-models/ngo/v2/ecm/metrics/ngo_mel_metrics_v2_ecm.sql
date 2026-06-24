-- Metric views for domain: mel | Business: Ngo | Version: 2 | Generated on: 2026-06-23 01:23:48

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_indicator_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core MEL performance metric view over indicator results — the primary fact table for tracking actual vs. target achievement across all programs and awards. Supports DHIS2, KoboToolbox, and eTools reporting stacks (VREQ-024). Disaggregation dimensions (sex, age, disability, displacement) enable IASC and donor-required breakdowns. PII note: disaggregation_sex and disaggregation_age_group are aggregate-level demographic splits, not individual PII, but should be tagged pii_beneficiary_protected in Unity Catalog (VREQ-029)."
  source: "`vibe_ngo_v1`.`mel`.`indicator_result`"
  dimensions:
    - name: "indicator_level"
      expr: indicator_level
      comment: "Logframe level of the indicator (output, outcome, impact) — enables portfolio-level roll-up analysis."
    - name: "result_status"
      expr: result_status
      comment: "Status of the result record (verified, pending, rejected) — used to filter dashboards to verified data only."
    - name: "verification_status"
      expr: verification_status
      comment: "Whether the result has been independently verified — critical for donor reporting quality gates."
    - name: "disaggregation_sex"
      expr: disaggregation_sex
      comment: "Sex disaggregation dimension (male/female/other/unknown) — mandatory for IASC, ECHO, and USAID gender reporting. Tag: pii_beneficiary_protected."
    - name: "disaggregation_age_group"
      expr: disaggregation_age_group
      comment: "Age group disaggregation — required for child-focused donor reporting (UNICEF, Save the Children). Tag: pii_beneficiary_protected."
    - name: "disaggregation_disability"
      expr: disaggregation_disability
      comment: "Disability disaggregation — required for CRPD-aligned reporting and Washington Group indicator compliance."
    - name: "disaggregation_displacement_status"
      expr: disaggregation_displacement_status
      comment: "Displacement status disaggregation (IDP, refugee, host community) — mandatory for UNHCR and humanitarian cluster reporting."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect the result (survey, observation, administrative data) — used to assess data quality by method."
    - name: "geographic_level"
      expr: geographic_level
      comment: "Geographic granularity of the result (national, regional, district, community) — enables spatial performance analysis."
    - name: "reporting_period_start_date"
      expr: DATE_TRUNC('quarter', reporting_period_start_date)
      comment: "Reporting quarter bucket — enables quarterly trend analysis aligned to donor reporting cycles."
    - name: "reported_to_donor"
      expr: reported_to_donor
      comment: "Flag indicating whether this result has been included in a donor report — used to track reporting completeness."
    - name: "is_milestone"
      expr: is_milestone
      comment: "Flag for milestone results — enables milestone tracking dashboards for program management."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the result value — required for correct aggregation and display in dashboards."
  measures:
    - name: "total_result_value"
      expr: SUM(CAST(result_value AS DOUBLE))
      comment: "Sum of all reported result values — the primary output volume metric. Executives use this to assess total program reach and output delivery against commitments."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of all indicator targets — the denominator for achievement rate calculations. Drives resource allocation decisions when targets are under-resourced."
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average result value per reporting record — used to identify outlier sites or periods that are over- or under-performing relative to the portfolio mean."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value per reporting record — baseline for per-record achievement rate computation in BI layer."
    - name: "avg_variance_from_target"
      expr: AVG(CAST(variance_from_target AS DOUBLE))
      comment: "Average absolute variance between result and target — a negative average signals systematic under-delivery requiring management intervention."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance from target — the primary KPI for program performance reviews. Triggers corrective action when below threshold (e.g. -20%)."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across all results — used to assess reliability of reported figures before donor submission. Low scores trigger DQA reviews."
    - name: "total_cumulative_result"
      expr: SUM(CAST(cumulative_result AS DOUBLE))
      comment: "Sum of cumulative result values — tracks total program-to-date achievement for multi-year awards. Critical for end-of-award reporting."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value across indicators — used to contextualize result values and compute change-from-baseline in BI layer."
    - name: "verified_result_count"
      expr: COUNT(CASE WHEN verification_status = 'verified' THEN 1 END)
      comment: "Count of independently verified results — the numerator for verification rate KPI. Donor audits require minimum verification thresholds."
    - name: "total_result_count"
      expr: COUNT(1)
      comment: "Total number of result records — denominator for verification rate and reporting completeness calculations."
    - name: "donor_reported_result_count"
      expr: COUNT(CASE WHEN reported_to_donor = TRUE THEN 1 END)
      comment: "Count of results included in donor reports — used to track reporting completeness and identify unreported results before submission deadlines."
    - name: "milestone_result_count"
      expr: COUNT(CASE WHEN is_milestone = TRUE THEN 1 END)
      comment: "Count of milestone results achieved — used in program steering meetings to track progress against key program milestones."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_indicator_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metric view over indicator targets — the planning baseline for all MEL performance measurement. Enables target-setting quality analysis, disaggregation coverage, and alignment to donor requirements. Supports results-based management (RBM) frameworks used by UN agencies (IPSAS-aligned) and INGOs (US GAAP ASC 958) alike (VREQ-021). Cross-references DHIS2 target-setting and eTools programme planning (VREQ-024)."
  source: "`vibe_ngo_v1`.`mel`.`indicator_target`"
  dimensions:
    - name: "target_type"
      expr: target_type
      comment: "Type of target (annual, cumulative, milestone, endline) — used to segment target portfolios for planning reviews."
    - name: "target_status"
      expr: target_status
      comment: "Status of the target (draft, approved, revised, closed) — filters dashboards to approved targets only for reporting."
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "How frequently the indicator is measured (monthly, quarterly, annually) — used to plan data collection resource requirements."
    - name: "disaggregation_sex"
      expr: disaggregation_sex
      comment: "Sex disaggregation planned for this target — used to assess gender-responsive planning coverage. Tag: pii_beneficiary_protected."
    - name: "disaggregation_age_group"
      expr: disaggregation_age_group
      comment: "Age group disaggregation planned — used to assess child-focused targeting coverage."
    - name: "disaggregation_disability_status"
      expr: disaggregation_disability_status
      comment: "Disability disaggregation planned — used to assess inclusion-responsive planning."
    - name: "disaggregation_displacement_status"
      expr: disaggregation_displacement_status
      comment: "Displacement status disaggregation planned — used to assess humanitarian targeting coverage."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG goal alignment of the target — used to aggregate portfolio contribution to global development goals."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code — used for donor reporting and IATI publication alignment."
    - name: "target_date"
      expr: DATE_TRUNC('year', target_date)
      comment: "Target achievement year — enables multi-year target planning analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the target — required for correct aggregation and display."
    - name: "donor_reporting_requirement"
      expr: donor_reporting_requirement
      comment: "Donor reporting requirement associated with this target — used to prioritize data collection for mandatory indicators."
  measures:
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of all planned target values — the primary planning volume metric. Executives use this to assess total program ambition and resource requirements."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value per indicator-period — used to identify outlier targets that may be unrealistic or under-ambitious."
    - name: "total_baseline_value"
      expr: SUM(CAST(baseline_value AS DOUBLE))
      comment: "Sum of baseline values — used to compute aggregate change-from-baseline across the indicator portfolio."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value — contextualizes target ambition relative to starting conditions."
    - name: "total_indicator_targets"
      expr: COUNT(1)
      comment: "Total number of indicator targets — used to assess planning completeness and MEL workload."
    - name: "approved_target_count"
      expr: COUNT(CASE WHEN target_status = 'approved' THEN 1 END)
      comment: "Count of approved targets — the numerator for target approval rate. Low approval rates signal planning delays that risk program start-up."
    - name: "disaggregated_target_count"
      expr: COUNT(CASE WHEN disaggregation_sex IS NOT NULL AND disaggregation_sex != '' THEN 1 END)
      comment: "Count of targets with sex disaggregation planned — used to assess gender-responsive planning compliance against donor requirements."
    - name: "sdg_aligned_target_count"
      expr: COUNT(CASE WHEN sdg_alignment IS NOT NULL AND sdg_alignment != '' THEN 1 END)
      comment: "Count of targets with SDG alignment documented — used to report portfolio contribution to global goals in annual reports and donor communications."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic metric view over evaluations — tracks evaluation portfolio quality, cost efficiency, and DAC criteria ratings. Evaluations are the primary accountability mechanism for donors and boards. Supports OECD DAC evaluation standards and UN UNEG norms. Relevant to both IPSAS-reporting UN agencies and US GAAP ASC 958 INGOs (VREQ-021). Evaluation costs tracked in local and award currency."
  source: "`vibe_ngo_v1`.`mel`.`evaluation`"
  dimensions:
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of evaluation (mid-term, final, real-time, impact) — used to segment evaluation portfolio by purpose."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the evaluation (planned, in-progress, completed, disseminated) — used to track evaluation pipeline."
    - name: "evaluator_type"
      expr: evaluator_type
      comment: "Whether the evaluation is internal, external, or joint — used to assess independence and credibility of findings."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall DAC evaluation rating (highly satisfactory, satisfactory, unsatisfactory) — the primary quality signal for program performance."
    - name: "relevance_rating"
      expr: relevance_rating
      comment: "DAC relevance criterion rating — used to assess whether programs remain aligned to beneficiary needs."
    - name: "effectiveness_rating"
      expr: effectiveness_rating
      comment: "DAC effectiveness criterion rating — used to assess whether programs are achieving their objectives."
    - name: "efficiency_rating"
      expr: efficiency_rating
      comment: "DAC efficiency criterion rating — used to assess cost-effectiveness of program delivery."
    - name: "impact_rating"
      expr: impact_rating
      comment: "DAC impact criterion rating — used to assess long-term change attributable to the program."
    - name: "sustainability_rating"
      expr: sustainability_rating
      comment: "DAC sustainability criterion rating — used to assess likelihood of benefits continuing after program closure."
    - name: "management_response_status"
      expr: management_response_status
      comment: "Status of management response to evaluation findings — accountability metric for organizational learning."
    - name: "ethics_approval_obtained"
      expr: ethics_approval_obtained
      comment: "Whether ethics approval was obtained — compliance gate for evaluations involving human subjects."
    - name: "planned_start_date"
      expr: DATE_TRUNC('year', planned_start_date)
      comment: "Evaluation start year — enables multi-year evaluation portfolio planning analysis."
    - name: "quality_assurance_conducted"
      expr: quality_assurance_conducted
      comment: "Whether quality assurance was conducted on the evaluation — used to assess evaluation quality management."
  measures:
    - name: "total_evaluation_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated to evaluations — used by leadership to assess investment in accountability and learning. Tracked under IPSAS 17 / ASC 958 program expense (VREQ-021)."
    - name: "total_evaluation_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of evaluations — compared to budget to assess evaluation cost management."
    - name: "avg_evaluation_budget"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average evaluation budget — used to benchmark evaluation investment per program type."
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual evaluation cost — used to plan future evaluation budgets and assess cost efficiency."
    - name: "total_evaluations"
      expr: COUNT(1)
      comment: "Total number of evaluations — used to assess evaluation coverage across the program portfolio."
    - name: "completed_evaluation_count"
      expr: COUNT(CASE WHEN evaluation_status = 'completed' THEN 1 END)
      comment: "Count of completed evaluations — numerator for evaluation completion rate. Donor agreements often require minimum evaluation completion rates."
    - name: "management_response_completed_count"
      expr: COUNT(CASE WHEN management_response_status = 'completed' THEN 1 END)
      comment: "Count of evaluations with completed management responses — tracks organizational accountability for acting on evaluation findings."
    - name: "ethics_approved_count"
      expr: COUNT(CASE WHEN ethics_approval_obtained = TRUE THEN 1 END)
      comment: "Count of evaluations with ethics approval — compliance metric for research ethics governance."
    - name: "avg_geographic_coverage"
      expr: AVG(CAST(geographic_coverage AS DOUBLE))
      comment: "Average geographic coverage score of evaluations — used to assess whether evaluations are representative of program geography."
    - name: "avg_scope"
      expr: AVG(CAST(scope AS DOUBLE))
      comment: "Average scope value of evaluations — used to assess breadth of evaluation coverage across program components."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_evaluation_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metric view over evaluation findings and recommendations — tracks organizational learning uptake, management response quality, and corrective action implementation. Critical for donor accountability, CHS commitment 6 (complaints and feedback), and board governance. High-priority unimplemented findings are a key risk indicator."
  source: "`vibe_ngo_v1`.`mel`.`evaluation_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of finding (recommendation, lesson learned, good practice, risk) — used to segment the learning portfolio."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the finding (critical, high, medium, low) — used to triage management response and resource allocation."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Status of recommendation implementation (not started, in progress, completed, cancelled) — the primary accountability tracking dimension."
    - name: "dac_criterion"
      expr: dac_criterion
      comment: "DAC evaluation criterion the finding relates to — used to identify systemic weaknesses across the evaluation portfolio."
    - name: "sector"
      expr: sector
      comment: "Sector the finding applies to (health, WASH, protection, food security) — used to identify sector-specific learning patterns."
    - name: "cross_cutting_theme"
      expr: cross_cutting_theme
      comment: "Cross-cutting theme (gender, protection, accountability) — used to assess mainstreaming of cross-cutting issues."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the finding — used to identify location-specific patterns in program performance."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether the finding is visible to donors — used to manage donor communication and transparency."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the finding — used to control access and sharing of sensitive findings."
    - name: "finding_date"
      expr: DATE_TRUNC('quarter', finding_date)
      comment: "Quarter the finding was recorded — enables trend analysis of evaluation findings over time."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the finding — used to link learning to global development framework contributions."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of evaluation findings — used to assess volume of organizational learning generated."
    - name: "high_priority_finding_count"
      expr: COUNT(CASE WHEN priority_level IN ('critical', 'high') THEN 1 END)
      comment: "Count of critical and high priority findings — the primary risk indicator for program quality. Unimplemented high-priority findings are escalated to leadership."
    - name: "implemented_finding_count"
      expr: COUNT(CASE WHEN implementation_status = 'completed' THEN 1 END)
      comment: "Count of fully implemented recommendations — numerator for learning uptake rate. Low rates signal organizational learning failures."
    - name: "overdue_finding_count"
      expr: COUNT(CASE WHEN implementation_status NOT IN ('completed', 'cancelled') AND target_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of overdue findings where target completion date has passed — critical risk metric for donor audits and CHS self-assessments."
    - name: "avg_implementation_progress_percentage"
      expr: AVG(CAST(implementation_progress_percentage AS DOUBLE))
      comment: "Average implementation progress percentage across all findings — used in quarterly steering meetings to track organizational learning uptake."
    - name: "donor_visible_finding_count"
      expr: COUNT(CASE WHEN donor_visibility_flag = TRUE THEN 1 END)
      comment: "Count of findings visible to donors — used to manage transparency and donor relationship expectations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_data_quality_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metric view over data quality assessments (DQAs) — the primary mechanism for validating MEL data reliability before donor reporting. DQA scores directly affect donor confidence and audit outcomes. Supports USAID ADS 203, ECHO, and UN OIOS data quality standards. Low DQA scores trigger corrective action plans and can delay disbursements. Relevant to both IPSAS and US GAAP reporting frameworks (VREQ-021)."
  source: "`vibe_ngo_v1`.`mel`.`data_quality_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of DQA (routine, triggered, pre-reporting, external) — used to segment DQA portfolio by purpose."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the DQA (planned, in-progress, completed, action-required) — used to track DQA pipeline."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the DQA (critical, high, medium, low) — used to triage corrective action resources."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions from the DQA — the primary accountability tracking dimension for data quality improvement."
    - name: "data_source_type"
      expr: data_source_type
      comment: "Type of data source assessed (primary, secondary, administrative) — used to identify data source quality patterns."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify data (spot check, re-interview, document review) — used to assess rigor of DQA process."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the DQA — used to identify geographic patterns in data quality."
    - name: "assessment_date"
      expr: DATE_TRUNC('quarter', assessment_date)
      comment: "Quarter of DQA — enables trend analysis of data quality over time."
    - name: "donor_reporting_requirement"
      expr: donor_reporting_requirement
      comment: "Donor reporting requirement driving the DQA — used to prioritize DQAs for mandatory donor indicators."
    - name: "dac_criteria_assessed"
      expr: dac_criteria_assessed
      comment: "DAC criteria assessed in the DQA — used to align data quality work with evaluation standards."
  measures:
    - name: "avg_overall_dqa_score"
      expr: AVG(CAST(overall_dqa_score_percentage AS DOUBLE))
      comment: "Average overall DQA score — the headline data quality KPI. Scores below 70% typically trigger mandatory corrective action plans and can delay donor reporting."
    - name: "avg_accuracy_score"
      expr: AVG(CAST(accuracy_score_percentage AS DOUBLE))
      comment: "Average accuracy score — measures whether reported data correctly reflects actual program results. Critical for donor audit compliance."
    - name: "avg_completeness_score"
      expr: AVG(CAST(completeness_score_percentage AS DOUBLE))
      comment: "Average completeness score — measures whether all required data fields are populated. Low completeness triggers data collection process reviews."
    - name: "avg_consistency_score"
      expr: AVG(CAST(consistency_score_percentage AS DOUBLE))
      comment: "Average consistency score — measures whether data is consistent across sources and time periods. Inconsistency is a red flag for data manipulation."
    - name: "avg_timeliness_score"
      expr: AVG(CAST(timeliness_score_percentage AS DOUBLE))
      comment: "Average timeliness score — measures whether data is collected and reported on schedule. Low timeliness scores risk donor reporting deadline breaches."
    - name: "total_dqa_count"
      expr: COUNT(1)
      comment: "Total number of DQAs conducted — used to assess DQA coverage across the indicator portfolio."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_status NOT IN ('completed', 'not_required') AND corrective_action_status IS NOT NULL THEN 1 END)
      comment: "Count of DQAs with open corrective actions — the primary risk metric for data quality management. Open actions at reporting time are a donor audit risk."
    - name: "high_quality_dqa_count"
      expr: COUNT(CASE WHEN overall_dqa_score_percentage >= 80 THEN 1 END)
      comment: "Count of DQAs scoring 80% or above — numerator for high-quality data rate. Used to report data quality improvement trends to leadership."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_indicator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metric view over the indicator master registry — tracks indicator portfolio composition, SDG alignment, disaggregation coverage, and donor compliance. The indicator registry is the backbone of the MEL system, referenced by DHIS2, eTools, and KoboToolbox (VREQ-024). Indicator quality directly affects program credibility with donors and cluster coordination bodies."
  source: "`vibe_ngo_v1`.`mel`.`indicator`"
  dimensions:
    - name: "indicator_type"
      expr: indicator_type
      comment: "Type of indicator (output, outcome, impact, process) — used to assess logframe balance and results chain coverage."
    - name: "indicator_category"
      expr: indicator_category
      comment: "Category of indicator (standard, custom, donor-mandatory) — used to segment the indicator portfolio by origin and obligation."
    - name: "indicator_status"
      expr: indicator_status
      comment: "Status of the indicator (active, inactive, retired) — used to filter dashboards to active indicators only."
    - name: "logframe_level"
      expr: logframe_level
      comment: "Logframe level (goal, purpose, output, activity) — used to assess results chain coverage and balance."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "How frequently the indicator is reported (monthly, quarterly, annually) — used to plan data collection and reporting workload."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Primary data collection method — used to assess methodological diversity and resource requirements."
    - name: "sector"
      expr: sector
      comment: "Sector the indicator belongs to (health, WASH, protection, education) — used for sector-level portfolio analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG goal alignment — used to report portfolio contribution to global development goals in annual reports."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the indicator is mandatory (donor-required) — used to prioritize data collection resources."
    - name: "is_custom"
      expr: is_custom
      comment: "Whether the indicator is custom (program-specific) vs. standard — used to assess standardization level of the indicator portfolio."
    - name: "direction_of_change"
      expr: direction_of_change
      comment: "Expected direction of change (increase, decrease, maintain) — used to correctly interpret result vs. target comparisons."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure — required for correct aggregation and display in dashboards."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the indicator became effective — used to track indicator portfolio evolution over time."
  measures:
    - name: "total_indicators"
      expr: COUNT(1)
      comment: "Total number of indicators in the registry — used to assess MEL system scope and data collection workload."
    - name: "active_indicator_count"
      expr: COUNT(CASE WHEN indicator_status = 'active' THEN 1 END)
      comment: "Count of active indicators — the operational indicator portfolio size. Used to plan MEL staffing and data collection budgets."
    - name: "mandatory_indicator_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Count of mandatory (donor-required) indicators — used to assess compliance reporting burden and prioritize data collection."
    - name: "sdg_aligned_indicator_count"
      expr: COUNT(CASE WHEN sdg_alignment IS NOT NULL AND sdg_alignment != '' THEN 1 END)
      comment: "Count of indicators with SDG alignment documented — used to report portfolio contribution to global goals."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across indicators — used to benchmark program ambition and identify outlier targets."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value — contextualizes target ambition relative to starting conditions across the portfolio."
    - name: "custom_indicator_count"
      expr: COUNT(CASE WHEN is_custom = TRUE THEN 1 END)
      comment: "Count of custom indicators — high custom indicator counts signal potential standardization gaps that complicate cross-program comparison."
    - name: "disaggregated_indicator_count"
      expr: COUNT(CASE WHEN disaggregation_dimensions IS NOT NULL AND disaggregation_dimensions != '' THEN 1 END)
      comment: "Count of indicators with disaggregation dimensions defined — used to assess gender and inclusion mainstreaming in the indicator framework."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_meal_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metric view over MEAL plans — the strategic planning document for monitoring, evaluation, accountability, and learning. MEAL plans are required by most institutional donors (USAID, ECHO, FCDO, UN agencies) and are the primary reference for MEL budget allocation. Tracks plan quality, budget utilization, and alignment to CHS commitments and RBM frameworks. Relevant to both IPSAS and US GAAP program expense tracking (VREQ-021)."
  source: "`vibe_ngo_v1`.`mel`.`meal_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the MEAL plan (draft, approved, active, closed) — used to filter dashboards to active plans."
    - name: "chs_commitment_alignment"
      expr: chs_commitment_alignment
      comment: "Core Humanitarian Standard commitment alignment — used to assess accountability framework coverage."
    - name: "rbm_framework_alignment"
      expr: rbm_framework_alignment
      comment: "Results-based management framework alignment — used to assess alignment to UN RBM standards."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the MEAL plan — used to report portfolio contribution to global goals."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the MEAL plan became effective — used to track MEAL planning coverage over time."
    - name: "plan_version"
      expr: plan_version
      comment: "Version of the MEAL plan — used to track plan revisions and ensure current version is in use."
  measures:
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total MEL budget allocated across all plans — used by leadership to assess investment in accountability and learning. Typically benchmarked at 3-7% of program budget per USAID and ECHO norms."
    - name: "avg_budget_allocated"
      expr: AVG(CAST(budget_allocated AS DOUBLE))
      comment: "Average MEL budget per plan — used to benchmark MEL investment across programs and identify under-resourced plans."
    - name: "total_meal_plans"
      expr: COUNT(1)
      comment: "Total number of MEAL plans — used to assess MEL planning coverage across the program portfolio."
    - name: "active_meal_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'active' THEN 1 END)
      comment: "Count of active MEAL plans — used to assess current MEL operational coverage."
    - name: "avg_beneficiary_feedback_channels"
      expr: AVG(CAST(beneficiary_feedback_channels AS DOUBLE))
      comment: "Average number of beneficiary feedback channels per MEAL plan — CHS commitment 4 requires accessible feedback mechanisms. Low scores trigger accountability improvement plans."
    - name: "avg_evaluation_strategy"
      expr: AVG(CAST(evaluation_strategy AS DOUBLE))
      comment: "Average evaluation strategy score per MEAL plan — used to assess quality of evaluation planning across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_dhis2_aggregate_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metric view over DHIS2 aggregate reports — tracks data submission completeness, timeliness, and quality for national health information system reporting. DHIS2 is the primary health and nutrition data platform for UN agencies (WHO, UNICEF, WFP) and national governments (VREQ-024). Low completeness and validation violations are escalated to cluster coordinators and national health authorities."
  source: "`vibe_ngo_v1`.`mel`.`dhis2_aggregate_report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Status of the DHIS2 report (draft, submitted, approved, rejected) — used to track submission pipeline."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the report — used to filter dashboards to approved data only."
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Type of reporting period (monthly, quarterly, annual) — used to segment reports by reporting cycle."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Flag indicating data quality issues — used to identify reports requiring review before use in decision-making."
    - name: "data_set_name"
      expr: data_set_name
      comment: "Name of the DHIS2 data set — used to segment reports by program area (health, nutrition, WASH)."
    - name: "reporting_period_start_date"
      expr: DATE_TRUNC('month', reporting_period_start_date)
      comment: "Reporting month — enables monthly trend analysis of DHIS2 submission performance."
    - name: "submission_date"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of submission — used to track submission timeliness relative to reporting deadlines."
  measures:
    - name: "avg_completeness_percentage"
      expr: AVG(CAST(completeness_percentage AS DOUBLE))
      comment: "Average data completeness percentage across DHIS2 reports — the primary DHIS2 quality KPI. WHO and national health authorities require minimum 80% completeness for data to be used in national statistics."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score — used to assess overall DHIS2 data reliability for national health decision-making."
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of DHIS2 aggregate reports — used to assess reporting coverage across facilities and periods."
    - name: "approved_report_count"
      expr: COUNT(CASE WHEN approval_status = 'approved' THEN 1 END)
      comment: "Count of approved reports — numerator for approval rate. Low approval rates signal data quality or workflow bottlenecks."
    - name: "flagged_report_count"
      expr: COUNT(CASE WHEN data_quality_flag = TRUE THEN 1 END)
      comment: "Count of reports with data quality flags — used to prioritize data quality review resources and assess systemic data issues."
    - name: "avg_integration_status"
      expr: AVG(CAST(integration_status AS DOUBLE))
      comment: "Average integration status score — used to assess DHIS2 system integration health and identify technical issues affecting data flow."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_qualitative_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metric view over qualitative data records (FGDs, KIIs, case studies, observations) — tracks qualitative data collection coverage, consent compliance, and quality. Qualitative data is essential for understanding program theory of change and capturing beneficiary voices (CHS commitment 4). PII note: participant counts and demographic distributions are aggregate-level; verbatim_quotes and informant_role may contain identifiable information and must be tagged pii_beneficiary_protected in Unity Catalog (VREQ-029). Supports KoboToolbox and Primero data collection workflows (VREQ-024)."
  source: "`vibe_ngo_v1`.`mel`.`qualitative_record`"
  dimensions:
    - name: "collection_method_type"
      expr: collection_method_type
      comment: "Type of qualitative method (FGD, KII, observation, case study) — used to segment qualitative portfolio by method."
    - name: "qualitative_record_status"
      expr: qualitative_record_status
      comment: "Status of the record (draft, reviewed, approved, archived) — used to filter dashboards to quality-assured data."
    - name: "data_quality_rating"
      expr: data_quality_rating
      comment: "Quality rating of the qualitative record — used to assess reliability of qualitative evidence base."
    - name: "primary_theme"
      expr: primary_theme
      comment: "Primary theme of the qualitative record — used to aggregate qualitative evidence by thematic area."
    - name: "informed_consent_obtained"
      expr: informed_consent_obtained
      comment: "Whether informed consent was obtained — mandatory compliance metric for ethical data collection. Records without consent must be excluded from analysis."
    - name: "translation_required"
      expr: translation_required
      comment: "Whether translation was required — used to assess language access and inclusion in data collection."
    - name: "recording_consent_obtained"
      expr: recording_consent_obtained
      comment: "Whether consent for recording was obtained — compliance metric for audio/video data protection."
    - name: "collection_date"
      expr: DATE_TRUNC('quarter', collection_date)
      comment: "Quarter of data collection — enables trend analysis of qualitative data collection over time."
    - name: "language_used"
      expr: language_used
      comment: "Language used in data collection — used to assess language diversity and inclusion in qualitative research."
    - name: "informant_role"
      expr: informant_role
      comment: "Role of the informant (community leader, beneficiary, staff, partner) — used to assess stakeholder diversity in qualitative evidence. Tag: pii_beneficiary_protected for beneficiary informants (VREQ-029)."
  measures:
    - name: "total_qualitative_records"
      expr: COUNT(1)
      comment: "Total number of qualitative records — used to assess qualitative data collection coverage across programs."
    - name: "consent_compliant_record_count"
      expr: COUNT(CASE WHEN informed_consent_obtained = TRUE THEN 1 END)
      comment: "Count of records with informed consent obtained — the primary ethics compliance metric. Non-compliant records must be excluded from analysis and reported to ethics review boards."
    - name: "approved_record_count"
      expr: COUNT(CASE WHEN qualitative_record_status = 'approved' THEN 1 END)
      comment: "Count of quality-approved qualitative records — numerator for qualitative data quality rate. Only approved records should be used in evaluation reports."
    - name: "distinct_intervention_count"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Count of distinct interventions with qualitative data — used to assess qualitative coverage across the program portfolio."
    - name: "distinct_country_count"
      expr: COUNT(DISTINCT country_id)
      comment: "Count of distinct countries with qualitative data — used to assess geographic coverage of qualitative evidence base."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_needs_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metric view over MEL needs assessments — tracks assessment coverage, nutrition screening rates, and needs prioritization across geographic areas. Needs assessments are the evidence base for program design and resource allocation. GAM and SAM rates are critical nutrition indicators for UNICEF, WFP, and cluster coordination. Supports KoboToolbox and field assessment workflows (VREQ-024)."
  source: "`vibe_ngo_v1`.`mel`.`mel_needs_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of needs assessment (rapid, comprehensive, sectoral, multi-sectoral) — used to segment assessment portfolio by depth and purpose."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the assessment (planned, in-progress, completed, validated) — used to track assessment pipeline."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the assessment — used to filter dashboards to validated data only."
    - name: "health_needs_priority"
      expr: health_needs_priority
      comment: "Health needs priority level — used to prioritize health sector resource allocation."
    - name: "nutrition_needs_priority"
      expr: nutrition_needs_priority
      comment: "Nutrition needs priority level — used to prioritize nutrition program targeting."
    - name: "protection_needs_priority"
      expr: protection_needs_priority
      comment: "Protection needs priority level — used to prioritize protection programming and safeguarding resources."
    - name: "wash_needs_priority"
      expr: wash_needs_priority
      comment: "WASH needs priority level — used to prioritize water, sanitation, and hygiene programming."
    - name: "shelter_needs_priority"
      expr: shelter_needs_priority
      comment: "Shelter needs priority level — used to prioritize shelter and NFI programming."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code — used for donor reporting and IATI publication alignment."
    - name: "assessment_start_date"
      expr: DATE_TRUNC('quarter', assessment_start_date)
      comment: "Quarter of assessment — enables trend analysis of needs assessment coverage over time."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the assessment — used to link needs evidence to global development framework."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of MEL needs assessments — used to assess evidence base coverage for program design decisions."
    - name: "avg_gam_rate_percentage"
      expr: AVG(CAST(gam_rate_percentage AS DOUBLE))
      comment: "Average Global Acute Malnutrition (GAM) rate — the primary nutrition emergency indicator. GAM rates above 15% trigger emergency nutrition response. Critical for UNICEF, WFP, and cluster coordination decisions."
    - name: "avg_sam_rate_percentage"
      expr: AVG(CAST(sam_rate_percentage AS DOUBLE))
      comment: "Average Severe Acute Malnutrition (SAM) rate — the primary severe nutrition crisis indicator. SAM rates above 2% trigger therapeutic feeding program scale-up. Used by WFP and UNICEF for resource allocation."
    - name: "validated_assessment_count"
      expr: COUNT(CASE WHEN validation_status = 'validated' THEN 1 END)
      comment: "Count of validated assessments — numerator for assessment quality rate. Only validated assessments should be used for program design and donor reporting."
    - name: "distinct_country_count"
      expr: COUNT(DISTINCT country_id)
      comment: "Count of distinct countries with needs assessments — used to assess geographic coverage of the evidence base."
    - name: "high_protection_priority_count"
      expr: COUNT(CASE WHEN protection_needs_priority IN ('critical', 'high') THEN 1 END)
      comment: "Count of assessments identifying high or critical protection needs — used to prioritize protection programming and safeguarding resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_geographic_scope`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metric view over geographic scope registry — tracks program geographic coverage, population reach, vulnerability indices, and access constraints. Geographic scope is the spatial backbone of MEL systems, linking indicators, results, and assessments to locations. Conflict-affected, hard-to-reach, and disaster-prone flags are critical for humanitarian access planning and donor reporting."
  source: "`vibe_ngo_v1`.`mel`.`geographic_scope`"
  dimensions:
    - name: "scope_type"
      expr: scope_type
      comment: "Type of geographic scope (country, region, district, community) — used to segment geographic analysis by administrative level."
    - name: "scope_status"
      expr: scope_status
      comment: "Status of the geographic scope (active, inactive, merged) — used to filter dashboards to active geographies."
    - name: "administrative_level"
      expr: administrative_level
      comment: "Administrative level of the scope — used to aggregate data at appropriate geographic granularity."
    - name: "conflict_affected_flag"
      expr: conflict_affected_flag
      comment: "Whether the area is conflict-affected — used to segment program coverage by humanitarian context and assess access risk."
    - name: "hard_to_reach_flag"
      expr: hard_to_reach_flag
      comment: "Whether the area is hard to reach — used to assess access constraints and plan remote monitoring strategies."
    - name: "disaster_prone_flag"
      expr: disaster_prone_flag
      comment: "Whether the area is disaster-prone — used to assess risk exposure and plan contingency programming."
    - name: "urban_rural_classification"
      expr: urban_rural_classification
      comment: "Urban/rural classification — used to segment program coverage and assess equity of geographic reach."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the geographic scope became effective — used to track program geographic expansion over time."
  measures:
    - name: "total_geographic_scopes"
      expr: COUNT(1)
      comment: "Total number of geographic scopes in the registry — used to assess program geographic footprint."
    - name: "total_population_estimate"
      expr: SUM(CAST(population_estimate AS DOUBLE))
      comment: "Total estimated population across all geographic scopes — the primary reach metric for program coverage reporting. Used to calculate beneficiary coverage rates."
    - name: "avg_population_estimate"
      expr: AVG(CAST(population_estimate AS DOUBLE))
      comment: "Average population per geographic scope — used to assess relative scale of program geographies."
    - name: "conflict_affected_scope_count"
      expr: COUNT(CASE WHEN conflict_affected_flag = TRUE THEN 1 END)
      comment: "Count of conflict-affected geographic scopes — used to assess humanitarian access risk and plan remote monitoring strategies."
    - name: "hard_to_reach_scope_count"
      expr: COUNT(CASE WHEN hard_to_reach_flag = TRUE THEN 1 END)
      comment: "Count of hard-to-reach geographic scopes — used to plan access strategies and budget for remote monitoring costs."
    - name: "avg_vulnerability_index"
      expr: AVG(CAST(vulnerability_index AS DOUBLE))
      comment: "Average vulnerability index across geographic scopes — used to assess whether program targeting is reaching the most vulnerable populations."
    - name: "total_area_square_km"
      expr: SUM(CAST(area_square_km AS DOUBLE))
      comment: "Total area covered by program geographic scopes — used to assess program geographic scale and plan field monitoring coverage."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_reporting_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metric view over reporting periods — tracks reporting cycle management, deadline compliance, and data collection scheduling. Reporting periods are the temporal backbone of MEL systems, governing when data must be collected, verified, and submitted to donors. Missed deadlines trigger donor relationship issues and can affect disbursements. Supports both IPSAS fiscal year reporting (UN agencies) and US GAAP calendar/fiscal year reporting (INGOs) (VREQ-021)."
  source: "`vibe_ngo_v1`.`mel`.`reporting_period`"
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Type of reporting period (monthly, quarterly, semi-annual, annual) — used to segment reporting workload by cycle."
    - name: "period_status"
      expr: period_status
      comment: "Status of the reporting period (open, closed, locked) — used to control data entry and track reporting cycle completion."
    - name: "is_active"
      expr: is_active
      comment: "Whether the reporting period is currently active — used to filter dashboards to current reporting cycle."
    - name: "baseline_period_flag"
      expr: baseline_period_flag
      comment: "Whether this is a baseline period — used to identify baseline data collection periods for indicator tracking."
    - name: "midline_period_flag"
      expr: midline_period_flag
      comment: "Whether this is a midline period — used to identify midline evaluation periods."
    - name: "endline_period_flag"
      expr: endline_period_flag
      comment: "Whether this is an endline period — used to identify final evaluation periods for program closeout."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the reporting period — used to align MEL reporting with financial reporting cycles (IPSAS and US GAAP) (VREQ-021)."
    - name: "donor_reporting_cycle"
      expr: donor_reporting_cycle
      comment: "Donor reporting cycle associated with this period — used to track compliance with donor-specific reporting schedules."
    - name: "data_quality_audit_flag"
      expr: data_quality_audit_flag
      comment: "Whether a data quality audit is scheduled for this period — used to plan DQA resources."
    - name: "start_date"
      expr: DATE_TRUNC('year', start_date)
      comment: "Year of the reporting period — enables multi-year reporting cycle analysis."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of reporting for this period — used to assess reporting burden and plan MEL staffing."
  measures:
    - name: "total_reporting_periods"
      expr: COUNT(1)
      comment: "Total number of reporting periods — used to assess reporting cycle complexity and MEL workload."
    - name: "active_period_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active reporting periods — used to assess current reporting workload and resource requirements."
    - name: "closed_period_count"
      expr: COUNT(CASE WHEN period_status = 'closed' THEN 1 END)
      comment: "Count of closed reporting periods — used to track reporting cycle completion rate."
    - name: "dqa_scheduled_period_count"
      expr: COUNT(CASE WHEN data_quality_audit_flag = TRUE THEN 1 END)
      comment: "Count of periods with DQA scheduled — used to plan data quality assurance resources and ensure DQA coverage meets donor requirements."
    - name: "distinct_donor_cycle_count"
      expr: COUNT(DISTINCT donor_reporting_cycle)
      comment: "Count of distinct donor reporting cycles — used to assess reporting complexity and plan MEL team capacity for concurrent donor deadlines."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_learning_agenda`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metric view over learning agendas — tracks organizational learning investment, question coverage, and evidence generation progress. Learning agendas are required by USAID (ADS 201), FCDO, and UN agencies as part of adaptive management frameworks. Budget utilization and completion rates are key accountability metrics for learning investments. Supports IPSAS and US GAAP program expense tracking (VREQ-021)."
  source: "`vibe_ngo_v1`.`mel`.`learning_agenda`"
  dimensions:
    - name: "learning_agenda_status"
      expr: learning_agenda_status
      comment: "Status of the learning agenda (draft, active, completed, archived) — used to filter dashboards to active learning work."
    - name: "learning_question_type"
      expr: learning_question_type
      comment: "Type of learning question (effectiveness, efficiency, relevance, sustainability) — used to segment learning portfolio by DAC criteria."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the learning question — used to allocate learning resources to highest-priority questions."
    - name: "donor_reporting_requirement"
      expr: donor_reporting_requirement
      comment: "Whether the learning question is a donor reporting requirement — used to prioritize mandatory learning activities."
    - name: "ethics_approval_required"
      expr: ethics_approval_required
      comment: "Whether ethics approval is required — used to track ethics compliance for learning activities involving human subjects."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the learning question — used to link learning to global development framework."
    - name: "planned_start_date"
      expr: DATE_TRUNC('year', planned_start_date)
      comment: "Year the learning activity is planned to start — used for multi-year learning portfolio planning."
  measures:
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total budget allocated to learning agenda activities — used to assess organizational investment in adaptive management and learning."
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent AS DOUBLE))
      comment: "Total budget spent on learning agenda activities — compared to allocated budget to assess learning investment utilization."
    - name: "avg_budget_allocated"
      expr: AVG(CAST(budget_allocated AS DOUBLE))
      comment: "Average budget per learning question — used to benchmark learning investment and identify under-resourced questions."
    - name: "total_learning_questions"
      expr: COUNT(1)
      comment: "Total number of learning questions — used to assess breadth of organizational learning agenda."
    - name: "completed_learning_count"
      expr: COUNT(CASE WHEN learning_agenda_status = 'completed' THEN 1 END)
      comment: "Count of completed learning agenda items — numerator for learning completion rate. Low rates signal adaptive management gaps."
    - name: "donor_required_learning_count"
      expr: COUNT(CASE WHEN donor_reporting_requirement = TRUE THEN 1 END)
      comment: "Count of donor-required learning questions — used to prioritize mandatory learning activities and track compliance."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_sdg_indicator_alignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metric view over SDG indicator alignment records — tracks portfolio contribution to the 2030 Agenda for Sustainable Development. SDG alignment reporting is required by UN agencies (UNDS reform), major institutional donors, and is increasingly expected in annual reports and IATI publications. Tier classification (I, II, III) indicates data availability and methodological maturity of SDG indicators."
  source: "`vibe_ngo_v1`.`mel`.`mel_sdg_indicator_alignment`"
  dimensions:
    - name: "sdg_goal_number"
      expr: sdg_goal_number
      comment: "SDG goal number (1-17) — used to aggregate portfolio contribution by global goal."
    - name: "sdg_goal_name"
      expr: sdg_goal_name
      comment: "SDG goal name — used for human-readable reporting in annual reports and donor communications."
    - name: "sdg_target_code"
      expr: sdg_target_code
      comment: "SDG target code — used to report contribution at target level for IATI and UN reporting."
    - name: "tier_classification"
      expr: tier_classification
      comment: "SDG indicator tier (I, II, III) — Tier I indicators have established methodology and data; Tier III are aspirational. Used to assess data quality of SDG reporting."
    - name: "alignment_type"
      expr: alignment_type
      comment: "Type of alignment (direct, indirect, contributory) — used to assess strength of program contribution to SDG targets."
    - name: "alignment_status"
      expr: alignment_status
      comment: "Status of the alignment record (active, inactive, under review) — used to filter dashboards to current alignments."
    - name: "mel_sdg_indicator_alignment_status"
      expr: mel_sdg_indicator_alignment_status
      comment: "Overall status of the SDG alignment — used to track alignment documentation completeness."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the alignment became effective — used to track SDG alignment portfolio evolution."
  measures:
    - name: "total_sdg_alignments"
      expr: COUNT(1)
      comment: "Total number of SDG indicator alignments — used to assess breadth of portfolio contribution to the 2030 Agenda."
    - name: "distinct_sdg_goal_count"
      expr: COUNT(DISTINCT sdg_goal_number)
      comment: "Count of distinct SDG goals covered — used to report portfolio breadth of SDG contribution in annual reports and UN reporting."
    - name: "distinct_indicator_count"
      expr: COUNT(DISTINCT indicator_id)
      comment: "Count of distinct indicators with SDG alignment — used to assess what proportion of the indicator portfolio is SDG-aligned."
    - name: "tier_one_alignment_count"
      expr: COUNT(CASE WHEN tier_classification = 'I' THEN 1 END)
      comment: "Count of Tier I SDG indicator alignments — Tier I alignments have the strongest methodological basis and are most credible for UN and donor reporting."
    - name: "active_alignment_count"
      expr: COUNT(CASE WHEN alignment_status = 'active' THEN 1 END)
      comment: "Count of active SDG alignments — used to assess current portfolio SDG coverage for reporting purposes."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_data_collection_tool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metric view over data collection tools — tracks tool portfolio quality, deployment coverage, ethical compliance, and system integration. Data collection tools (surveys, forms, observation checklists) are the operational instruments of MEL systems. Tool quality directly affects data quality and donor confidence. Supports KoboToolbox, ODK, and DHIS2 tool deployment workflows (VREQ-024). Ethical review status is a compliance gate for tools involving human subjects."
  source: "`vibe_ngo_v1`.`mel`.`data_collection_tool`"
  dimensions:
    - name: "tool_type"
      expr: tool_type
      comment: "Type of data collection tool (survey, observation checklist, interview guide, registration form) — used to segment tool portfolio by purpose."
    - name: "tool_status"
      expr: tool_status
      comment: "Status of the tool (draft, approved, deployed, retired) — used to filter dashboards to active tools."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the tool — used to ensure only approved tools are deployed in the field."
    - name: "ethical_review_status"
      expr: ethical_review_status
      comment: "Ethical review status — compliance gate for tools involving human subjects. Tools without ethical approval must not be deployed."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Data collection method (CAPI, CATI, paper, observation) — used to assess methodological diversity and technology adoption."
    - name: "consent_mechanism"
      expr: consent_mechanism
      comment: "Consent mechanism used (verbal, written, digital) — used to assess consent quality and compliance with data protection requirements."
    - name: "respondent_type"
      expr: respondent_type
      comment: "Type of respondent (beneficiary, community member, staff, partner) — used to segment tool portfolio by target population."
    - name: "deployment_start_date"
      expr: DATE_TRUNC('quarter', deployment_start_date)
      comment: "Quarter of tool deployment — enables trend analysis of tool deployment over time."
    - name: "data_protection_compliance"
      expr: data_protection_compliance
      comment: "Data protection compliance status — used to assess GDPR, national data protection law, and organizational policy compliance."
  measures:
    - name: "total_tools"
      expr: COUNT(1)
      comment: "Total number of data collection tools — used to assess MEL tool portfolio size and management complexity."
    - name: "deployed_tool_count"
      expr: COUNT(CASE WHEN tool_status = 'deployed' THEN 1 END)
      comment: "Count of currently deployed tools — used to assess active data collection operations and field workload."
    - name: "ethics_approved_tool_count"
      expr: COUNT(CASE WHEN ethical_review_status = 'approved' THEN 1 END)
      comment: "Count of tools with ethics approval — compliance metric for research ethics governance. Non-approved tools in deployment are a critical compliance risk."
    - name: "approved_tool_count"
      expr: COUNT(CASE WHEN approval_status = 'approved' THEN 1 END)
      comment: "Count of approved tools — numerator for tool approval rate. Unapproved tools in deployment signal quality control failures."
    - name: "distinct_intervention_count"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Count of distinct interventions with data collection tools — used to assess MEL tool coverage across the program portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_indicator_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core MEL performance metrics tracking indicator achievement, variance, and data quality across programs, partners, and geographic areas"
  source: "`vibe_ngo_v1`.`mel`.`indicator_result`"
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