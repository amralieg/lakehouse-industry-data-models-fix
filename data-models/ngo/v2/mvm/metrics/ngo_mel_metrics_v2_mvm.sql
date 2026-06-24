-- Metric views for domain: mel | Business: Ngo | Version: 2 | Generated on: 2026-06-23 02:03:19

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_indicator_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core MEL performance tracking view measuring indicator achievement, target attainment rates, data quality, and cumulative results across programs, partners, and reporting periods. Primary KPI surface for program steering and donor reporting."
  source: "`vibe_ngo_v1`.`mel`.`indicator_result`"
  dimensions:
    - name: "reporting_period_id"
      expr: reporting_period_id
      comment: "Foreign key to reporting period — enables slicing KPIs by quarter, fiscal year, or donor cycle."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Foreign key to intervention — enables program-level performance analysis."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Foreign key to partner organisation — enables partner-level performance benchmarking."
    - name: "indicator_id"
      expr: indicator_id
      comment: "Foreign key to indicator — enables indicator-level drill-down."
    - name: "result_status"
      expr: result_status
      comment: "Status of the result record (e.g. Verified, Pending, Rejected) — used to filter dashboards to confirmed results."
    - name: "verification_status"
      expr: verification_status
      comment: "Whether the result has been independently verified — critical for donor reporting quality gates."
    - name: "disaggregation_sex"
      expr: disaggregation_sex
      comment: "Sex disaggregation dimension — enables gender-responsive programming analysis."
    - name: "disaggregation_age_group"
      expr: disaggregation_age_group
      comment: "Age group disaggregation — enables age-sensitive analysis of program reach."
    - name: "disaggregation_displacement_status"
      expr: disaggregation_displacement_status
      comment: "Displacement status disaggregation — enables analysis of reach to displaced vs. host populations."
    - name: "disaggregation_disability"
      expr: disaggregation_disability
      comment: "Disability disaggregation — enables inclusion analysis for persons with disabilities."
    - name: "geographic_level"
      expr: geographic_level
      comment: "Geographic granularity of the result (national, regional, district) — enables spatial performance analysis."
    - name: "indicator_level"
      expr: indicator_level
      comment: "Results chain level of the indicator (output, outcome, impact) — enables theory-of-change performance tracking."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the result value — ensures correct aggregation context."
    - name: "collection_date"
      expr: DATE_TRUNC('month', collection_date)
      comment: "Month of data collection — enables trend analysis of result reporting cadence."
    - name: "reported_to_donor"
      expr: reported_to_donor
      comment: "Boolean flag indicating whether this result has been reported to the donor — used for donor reporting completeness tracking."
    - name: "is_milestone"
      expr: is_milestone
      comment: "Boolean flag indicating whether this result represents a programme milestone — used to highlight strategic checkpoints."
  measures:
    - name: "total_result_value"
      expr: SUM(CAST(result_value AS DOUBLE))
      comment: "Total aggregated result value across selected dimensions. Core programme output/outcome volume metric used in donor reports and steering reviews."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Total aggregated target value across selected dimensions. Denominator for target achievement rate calculations."
    - name: "total_cumulative_result"
      expr: SUM(CAST(cumulative_result AS DOUBLE))
      comment: "Sum of cumulative results — represents total programme achievement to date across all reporting periods."
    - name: "avg_target_achievement_pct"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage from target across result records — indicates overall programme performance against plan. Negative values signal underperformance requiring management action."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across result records — a proxy for evidence reliability. Low scores trigger data quality improvement interventions."
    - name: "total_variance_from_target"
      expr: SUM(CAST(variance_from_target AS DOUBLE))
      comment: "Total absolute variance from target — quantifies the aggregate gap between planned and actual results, informing resource reallocation decisions."
    - name: "count_verified_results"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END)
      comment: "Number of results that have been independently verified — measures evidence quality and donor reporting readiness."
    - name: "count_results"
      expr: COUNT(1)
      comment: "Total number of result records — baseline volume metric for reporting completeness monitoring."
    - name: "count_distinct_indicators"
      expr: COUNT(DISTINCT indicator_id)
      comment: "Number of distinct indicators with results reported — measures breadth of programme monitoring coverage."
    - name: "count_donor_reported_results"
      expr: COUNT(CASE WHEN reported_to_donor = TRUE THEN 1 END)
      comment: "Number of results formally reported to donors — tracks donor reporting compliance and completeness."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value across indicators — provides context for interpreting result magnitude relative to starting conditions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_indicator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Indicator portfolio management view covering indicator design quality, target-setting, and alignment to strategic frameworks (SDGs, DAC criteria). Used by MEL leads to govern the indicator library and ensure strategic coherence."
  source: "`vibe_ngo_v1`.`mel`.`indicator`"
  dimensions:
    - name: "intervention_id"
      expr: intervention_id
      comment: "Foreign key to intervention — enables indicator portfolio analysis by programme."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Foreign key to partner organisation — enables partner-level indicator ownership analysis."
    - name: "indicator_type"
      expr: indicator_type
      comment: "Type of indicator (output, outcome, impact, process) — enables results-chain portfolio analysis."
    - name: "indicator_status"
      expr: indicator_status
      comment: "Current status of the indicator (Active, Archived, Draft) — used to filter to live indicators."
    - name: "sector"
      expr: sector
      comment: "Sector the indicator belongs to (Health, Education, WASH, etc.) — enables cross-sector portfolio comparison."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG goal alignment of the indicator — used for SDG contribution reporting to donors and governing bodies."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "How frequently this indicator is reported (monthly, quarterly, annually) — informs data collection planning."
    - name: "data_collection_frequency"
      expr: data_collection_frequency
      comment: "Frequency of data collection for this indicator — used to assess monitoring burden and resource requirements."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Boolean flag for mandatory donor indicators — ensures compliance indicators are tracked separately."
    - name: "is_custom"
      expr: is_custom
      comment: "Boolean flag for custom (non-standard) indicators — enables analysis of indicator standardisation across the portfolio."
    - name: "direction_of_change"
      expr: direction_of_change
      comment: "Expected direction of change (increase/decrease) — used to correctly interpret performance against target."
    - name: "dac_criteria_alignment"
      expr: dac_criteria_alignment
      comment: "DAC evaluation criteria alignment (relevance, effectiveness, efficiency, impact, sustainability) — used for evaluation framework coverage analysis."
    - name: "baseline_date"
      expr: DATE_TRUNC('year', baseline_date)
      comment: "Year of baseline measurement — enables cohort analysis of indicator maturity."
    - name: "target_date"
      expr: DATE_TRUNC('year', target_date)
      comment: "Year the indicator target is due — enables forward-looking pipeline analysis of upcoming target deadlines."
  measures:
    - name: "count_active_indicators"
      expr: COUNT(CASE WHEN indicator_status = 'Active' THEN 1 END)
      comment: "Number of active indicators in the portfolio — measures monitoring scope and MEL system coverage."
    - name: "count_mandatory_indicators"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Number of mandatory donor indicators — tracks compliance obligations and reporting burden."
    - name: "count_custom_indicators"
      expr: COUNT(CASE WHEN is_custom = TRUE THEN 1 END)
      comment: "Number of custom (non-standard) indicators — high counts may signal fragmentation; informs indicator harmonisation decisions."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across indicators — provides a portfolio-level view of ambition and scale of planned results."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value across indicators — contextualises target ambition relative to starting conditions."
    - name: "count_indicators_with_sdg"
      expr: COUNT(CASE WHEN sdg_alignment IS NOT NULL AND sdg_alignment <> '' THEN 1 END)
      comment: "Number of indicators aligned to SDGs — measures strategic coherence with global development frameworks for donor and board reporting."
    - name: "count_distinct_sectors"
      expr: COUNT(DISTINCT sector)
      comment: "Number of distinct sectors covered by the indicator portfolio — measures programme breadth and cross-sectoral integration."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Evaluation portfolio performance view tracking evaluation quality ratings, budget vs. actual cost, and DAC criteria coverage. Used by MEL directors and senior management to assess programme effectiveness and learning quality."
  source: "`vibe_ngo_v1`.`mel`.`evaluation`"
  dimensions:
    - name: "intervention_id"
      expr: intervention_id
      comment: "Foreign key to intervention — enables evaluation performance analysis by programme."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Foreign key to partner organisation — enables partner-level evaluation quality benchmarking."
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of evaluation (midterm, endline, real-time, thematic) — enables portfolio analysis by evaluation modality."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the evaluation (Planned, In Progress, Completed, Disseminated) — used to track evaluation pipeline."
    - name: "evaluator_type"
      expr: evaluator_type
      comment: "Whether the evaluation was conducted internally or externally — informs independence and credibility of findings."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall DAC quality rating of the evaluation — primary executive KPI for programme performance."
    - name: "effectiveness_rating"
      expr: effectiveness_rating
      comment: "DAC effectiveness rating — measures whether the programme achieved its intended outcomes."
    - name: "impact_rating"
      expr: impact_rating
      comment: "DAC impact rating — measures broader and longer-term effects of the programme."
    - name: "sustainability_rating"
      expr: sustainability_rating
      comment: "DAC sustainability rating — measures likelihood of benefits continuing after programme closure."
    - name: "management_response_status"
      expr: management_response_status
      comment: "Status of management response to evaluation findings — tracks organisational accountability and learning uptake."
    - name: "ethics_approval_obtained"
      expr: ethics_approval_obtained
      comment: "Boolean flag for ethics approval — ensures evaluations meet ethical standards required by donors and governing bodies."
    - name: "quality_assurance_conducted"
      expr: quality_assurance_conducted
      comment: "Boolean flag for QA process completion — measures evaluation quality assurance compliance."
    - name: "actual_start_date"
      expr: DATE_TRUNC('year', actual_start_date)
      comment: "Year the evaluation started — enables cohort analysis of evaluation portfolio by year."
    - name: "dissemination_date"
      expr: DATE_TRUNC('year', dissemination_date)
      comment: "Year of evaluation dissemination — tracks learning dissemination pipeline."
  measures:
    - name: "total_evaluation_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated to evaluations — informs MEL investment decisions and resource planning."
    - name: "total_evaluation_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of evaluations — used alongside budget to assess evaluation cost efficiency."
    - name: "avg_evaluation_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average cost per evaluation — benchmarks evaluation investment and informs future budgeting."
    - name: "avg_geographic_coverage"
      expr: AVG(CAST(geographic_coverage AS DOUBLE))
      comment: "Average geographic coverage of evaluations — measures spatial representativeness of the evaluation portfolio."
    - name: "count_evaluations"
      expr: COUNT(1)
      comment: "Total number of evaluations — baseline volume metric for evaluation portfolio management."
    - name: "count_completed_evaluations"
      expr: COUNT(CASE WHEN evaluation_status = 'Completed' THEN 1 END)
      comment: "Number of completed evaluations — tracks evaluation pipeline throughput and learning generation rate."
    - name: "count_ethics_approved_evaluations"
      expr: COUNT(CASE WHEN ethics_approval_obtained = TRUE THEN 1 END)
      comment: "Number of evaluations with ethics approval — measures compliance with ethical research standards."
    - name: "count_qa_conducted_evaluations"
      expr: COUNT(CASE WHEN quality_assurance_conducted = TRUE THEN 1 END)
      comment: "Number of evaluations where QA was conducted — measures quality assurance compliance across the evaluation portfolio."
    - name: "avg_scope"
      expr: AVG(CAST(scope AS DOUBLE))
      comment: "Average scope value of evaluations — measures breadth of evaluation coverage across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_evaluation_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Evaluation findings and recommendations tracking view measuring implementation progress, priority distribution, and accountability for management responses. Used by MEL and programme leadership to drive learning uptake and corrective action."
  source: "`vibe_ngo_v1`.`mel`.`evaluation_finding`"
  dimensions:
    - name: "evaluation_id"
      expr: evaluation_id
      comment: "Foreign key to evaluation — enables finding analysis by evaluation."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Foreign key to intervention — enables programme-level finding analysis."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Foreign key to partner organisation — enables partner accountability tracking."
    - name: "finding_type"
      expr: finding_type
      comment: "Type of finding (recommendation, lesson learned, good practice, risk) — enables structured learning portfolio analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the finding (High, Medium, Low) — used to focus management attention on critical issues."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Status of recommendation implementation (Not Started, In Progress, Completed, Dropped) — tracks accountability for learning uptake."
    - name: "dac_criterion"
      expr: dac_criterion
      comment: "DAC evaluation criterion the finding relates to — enables analysis of where programme weaknesses cluster."
    - name: "sector"
      expr: sector
      comment: "Sector the finding relates to — enables cross-sector learning analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the finding — enables strategic learning analysis against global goals."
    - name: "responsible_unit"
      expr: responsible_unit
      comment: "Organisational unit responsible for implementing the recommendation — enables accountability tracking by team."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Boolean flag indicating whether the finding is visible to donors — used to manage donor communication and transparency."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the finding — enables spatial analysis of programme weaknesses and lessons."
    - name: "finding_date"
      expr: DATE_TRUNC('month', finding_date)
      comment: "Month the finding was recorded — enables trend analysis of learning generation over time."
    - name: "target_completion_date"
      expr: DATE_TRUNC('quarter', target_completion_date)
      comment: "Quarter the recommendation is due for completion — enables pipeline management of outstanding actions."
  measures:
    - name: "count_findings"
      expr: COUNT(1)
      comment: "Total number of evaluation findings — baseline metric for learning portfolio volume."
    - name: "count_high_priority_findings"
      expr: COUNT(CASE WHEN priority_level = 'High' THEN 1 END)
      comment: "Number of high-priority findings — executive alert metric; high counts signal systemic programme risks requiring immediate management action."
    - name: "count_completed_recommendations"
      expr: COUNT(CASE WHEN implementation_status = 'Completed' THEN 1 END)
      comment: "Number of recommendations fully implemented — measures organisational learning uptake and accountability."
    - name: "avg_implementation_progress_pct"
      expr: AVG(CAST(implementation_progress_percentage AS DOUBLE))
      comment: "Average implementation progress percentage across all findings — tracks overall recommendation follow-through rate for management accountability reviews."
    - name: "count_overdue_recommendations"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE AND implementation_status <> 'Completed' THEN 1 END)
      comment: "Number of recommendations past their target completion date and not yet completed — critical accountability metric for steering meetings."
    - name: "count_donor_visible_findings"
      expr: COUNT(CASE WHEN donor_visibility_flag = TRUE THEN 1 END)
      comment: "Number of findings visible to donors — tracks transparency obligations and donor relationship management."
    - name: "count_distinct_evaluations_with_findings"
      expr: COUNT(DISTINCT evaluation_id)
      comment: "Number of distinct evaluations that have generated findings — measures evaluation learning productivity."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_indicator_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Indicator target-setting and planning quality view tracking target ambition, disaggregation coverage, and donor alignment. Used by MEL planners and programme managers to govern target-setting quality and donor compliance."
  source: "`vibe_ngo_v1`.`mel`.`indicator_target`"
  dimensions:
    - name: "indicator_id"
      expr: indicator_id
      comment: "Foreign key to indicator — enables target analysis by indicator."
    - name: "intervention_id"
      expr: intervention_id
      comment: "Foreign key to intervention — enables programme-level target portfolio analysis."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Foreign key to partner organisation — enables partner-level target accountability."
    - name: "reporting_period_id"
      expr: reporting_period_id
      comment: "Foreign key to reporting period — enables target analysis by reporting cycle."
    - name: "target_type"
      expr: target_type
      comment: "Type of target (annual, cumulative, milestone) — enables analysis of target structure across the portfolio."
    - name: "target_status"
      expr: target_status
      comment: "Current status of the target (Draft, Approved, Revised, Closed) — tracks target lifecycle management."
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "Frequency of measurement for this target — informs data collection planning and resource requirements."
    - name: "disaggregation_sex"
      expr: disaggregation_sex
      comment: "Sex disaggregation planned for this target — measures gender-responsive planning quality."
    - name: "disaggregation_age_group"
      expr: disaggregation_age_group
      comment: "Age group disaggregation planned — measures age-sensitive planning quality."
    - name: "disaggregation_disability_status"
      expr: disaggregation_disability_status
      comment: "Disability status disaggregation planned — measures inclusion planning quality."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the target — enables strategic coherence analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "DAC sector code for the target — enables donor-aligned sector reporting."
    - name: "target_date"
      expr: DATE_TRUNC('year', target_date)
      comment: "Year the target is due — enables forward-looking pipeline analysis of upcoming target deadlines."
    - name: "approval_date"
      expr: DATE_TRUNC('year', approval_date)
      comment: "Year the target was approved — enables analysis of target approval timeliness."
  measures:
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Total planned target value across the portfolio — measures aggregate programme ambition and scale of planned results."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value per indicator-period — benchmarks target ambition and identifies outliers requiring scrutiny."
    - name: "total_baseline_value"
      expr: SUM(CAST(baseline_value AS DOUBLE))
      comment: "Total baseline value across targets — provides aggregate starting-point context for interpreting target ambition."
    - name: "count_approved_targets"
      expr: COUNT(CASE WHEN target_status = 'Approved' THEN 1 END)
      comment: "Number of approved targets — measures planning completeness and governance compliance."
    - name: "count_targets"
      expr: COUNT(1)
      comment: "Total number of indicator targets — baseline volume metric for planning portfolio management."
    - name: "count_targets_with_sex_disaggregation"
      expr: COUNT(CASE WHEN disaggregation_sex IS NOT NULL AND disaggregation_sex <> '' THEN 1 END)
      comment: "Number of targets with sex disaggregation planned — measures gender-responsive planning compliance."
    - name: "count_targets_with_sdg_alignment"
      expr: COUNT(CASE WHEN sdg_alignment IS NOT NULL AND sdg_alignment <> '' THEN 1 END)
      comment: "Number of targets aligned to SDGs — measures strategic coherence of the target portfolio with global frameworks."
    - name: "count_distinct_indicators_targeted"
      expr: COUNT(DISTINCT indicator_id)
      comment: "Number of distinct indicators with targets set — measures planning coverage of the indicator portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_reporting_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reporting period governance view tracking reporting cycle health, deadline compliance, and data quality audit scheduling. Used by MEL coordinators and programme managers to manage reporting calendars and ensure timely data submission."
  source: "`vibe_ngo_v1`.`mel`.`reporting_period`"
  dimensions:
    - name: "intervention_id"
      expr: intervention_id
      comment: "Foreign key to intervention — enables reporting period analysis by programme."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Foreign key to partner organisation — enables partner-level reporting compliance analysis."
    - name: "period_type"
      expr: period_type
      comment: "Type of reporting period (monthly, quarterly, annual, baseline, endline) — enables analysis by reporting cadence."
    - name: "period_status"
      expr: period_status
      comment: "Current status of the reporting period (Open, Closed, Overdue) — used to identify periods requiring management attention."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Reporting frequency for this period — enables analysis of reporting burden by frequency type."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the reporting period — enables annual performance cycle analysis."
    - name: "calendar_year"
      expr: calendar_year
      comment: "Calendar year of the reporting period — enables calendar-year trend analysis."
    - name: "quarter_number"
      expr: quarter_number
      comment: "Quarter number within the year — enables quarterly performance cycle analysis."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag for currently active reporting periods — used to filter dashboards to live periods."
    - name: "baseline_period_flag"
      expr: baseline_period_flag
      comment: "Boolean flag for baseline periods — used to isolate baseline data collection periods."
    - name: "midline_period_flag"
      expr: midline_period_flag
      comment: "Boolean flag for midline periods — used to isolate midline evaluation periods."
    - name: "endline_period_flag"
      expr: endline_period_flag
      comment: "Boolean flag for endline periods — used to isolate endline evaluation periods."
    - name: "data_quality_audit_flag"
      expr: data_quality_audit_flag
      comment: "Boolean flag indicating a data quality audit is scheduled for this period — used to track DQA compliance."
    - name: "donor_reporting_cycle"
      expr: donor_reporting_cycle
      comment: "Donor reporting cycle this period belongs to — enables donor-aligned reporting compliance analysis."
    - name: "start_date"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the reporting period starts — enables temporal distribution analysis of reporting periods."
    - name: "report_submission_deadline"
      expr: DATE_TRUNC('month', report_submission_deadline)
      comment: "Month the report submission is due — enables deadline pipeline management."
  measures:
    - name: "count_reporting_periods"
      expr: COUNT(1)
      comment: "Total number of reporting periods — baseline metric for reporting calendar management."
    - name: "count_active_periods"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active reporting periods — measures concurrent reporting workload across the organisation."
    - name: "count_overdue_periods"
      expr: COUNT(CASE WHEN period_status = 'Overdue' THEN 1 END)
      comment: "Number of overdue reporting periods — critical compliance metric; high counts signal systemic reporting delays requiring management intervention."
    - name: "count_dqa_scheduled_periods"
      expr: COUNT(CASE WHEN data_quality_audit_flag = TRUE THEN 1 END)
      comment: "Number of periods with data quality audits scheduled — measures DQA compliance planning across the reporting calendar."
    - name: "count_endline_periods"
      expr: COUNT(CASE WHEN endline_period_flag = TRUE THEN 1 END)
      comment: "Number of endline reporting periods — tracks programme closure and final evaluation pipeline."
    - name: "count_distinct_interventions_reporting"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Number of distinct interventions with reporting periods — measures breadth of active programme monitoring coverage."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_meal_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MEAL plan quality and investment view tracking MEL budget allocation, indicator coverage, and strategic framework alignment. Used by MEL directors and programme managers to govern MEL system design quality and resource adequacy."
  source: "`vibe_ngo_v1`.`mel`.`meal_plan`"
  dimensions:
    - name: "intervention_id"
      expr: intervention_id
      comment: "Foreign key to intervention — enables MEAL plan analysis by programme."
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the MEAL plan (Draft, Approved, Active, Archived) — used to filter to live plans."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the MEAL plan — measures strategic coherence with global development frameworks."
    - name: "chs_commitment_alignment"
      expr: chs_commitment_alignment
      comment: "Core Humanitarian Standard commitment alignment — measures accountability to affected populations standards."
    - name: "rbm_framework_alignment"
      expr: rbm_framework_alignment
      comment: "Results-Based Management framework alignment — measures adherence to RBM principles."
    - name: "approval_date"
      expr: DATE_TRUNC('year', approval_date)
      comment: "Year the MEAL plan was approved — enables cohort analysis of plan quality by approval year."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the MEAL plan became effective — enables temporal analysis of MEL system coverage."
  measures:
    - name: "total_mel_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total MEL budget allocated across MEAL plans — measures organisational investment in monitoring, evaluation, accountability, and learning."
    - name: "avg_mel_budget_allocated"
      expr: AVG(CAST(budget_allocated AS DOUBLE))
      comment: "Average MEL budget per MEAL plan — benchmarks MEL investment adequacy across programmes."
    - name: "avg_beneficiary_feedback_channels"
      expr: AVG(CAST(beneficiary_feedback_channels AS DOUBLE))
      comment: "Average number of beneficiary feedback channels per MEAL plan — measures accountability to affected populations (AAP) system quality."
    - name: "avg_dac_criteria_coverage"
      expr: AVG(CAST(dac_criteria_coverage AS DOUBLE))
      comment: "Average DAC criteria coverage score across MEAL plans — measures evaluation framework comprehensiveness for donor compliance."
    - name: "count_approved_meal_plans"
      expr: COUNT(CASE WHEN plan_status = 'Approved' THEN 1 END)
      comment: "Number of approved MEAL plans — measures MEL governance compliance across the programme portfolio."
    - name: "count_meal_plans"
      expr: COUNT(1)
      comment: "Total number of MEAL plans — baseline metric for MEL system coverage."
    - name: "count_plans_with_sdg_alignment"
      expr: COUNT(CASE WHEN sdg_alignment IS NOT NULL AND sdg_alignment <> '' THEN 1 END)
      comment: "Number of MEAL plans with SDG alignment documented — measures strategic coherence of MEL systems with global frameworks."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_data_collection_tool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data collection tool governance view tracking tool deployment status, ethical compliance, and data protection standards. Used by MEL coordinators and data managers to govern the quality and compliance of data collection instruments."
  source: "`vibe_ngo_v1`.`mel`.`data_collection_tool`"
  dimensions:
    - name: "intervention_id"
      expr: intervention_id
      comment: "Foreign key to intervention — enables tool analysis by programme."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Foreign key to partner organisation — enables partner-level tool compliance analysis."
    - name: "reporting_period_id"
      expr: reporting_period_id
      comment: "Foreign key to reporting period — enables tool deployment analysis by reporting cycle."
    - name: "tool_type"
      expr: tool_type
      comment: "Type of data collection tool (survey, KII guide, FGD guide, observation checklist) — enables analysis of methodological diversity."
    - name: "tool_status"
      expr: tool_status
      comment: "Current status of the tool (Draft, Approved, Deployed, Retired) — used to filter to active instruments."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the tool — measures governance compliance of data collection instruments."
    - name: "ethical_review_status"
      expr: ethical_review_status
      comment: "Ethical review status of the tool — critical compliance dimension for research ethics governance."
    - name: "data_protection_compliance"
      expr: data_protection_compliance
      comment: "Data protection compliance status — measures adherence to data privacy standards (GDPR, organisational policy)."
    - name: "consent_mechanism"
      expr: consent_mechanism
      comment: "Type of consent mechanism used (informed consent, verbal consent) — measures ethical data collection standards."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the tool — enables analysis of linguistic accessibility and localisation coverage."
    - name: "respondent_type"
      expr: respondent_type
      comment: "Type of respondent the tool targets (beneficiary, key informant, community leader) — enables analysis of data source diversity."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Data collection method (face-to-face, phone, digital, paper) — enables analysis of data collection modality mix."
    - name: "deployment_start_date"
      expr: DATE_TRUNC('month', deployment_start_date)
      comment: "Month the tool was deployed — enables temporal analysis of data collection activity."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of tool deployment — enables spatial analysis of data collection coverage."
  measures:
    - name: "count_tools"
      expr: COUNT(1)
      comment: "Total number of data collection tools — baseline metric for MEL instrument portfolio management."
    - name: "count_approved_tools"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved data collection tools — measures governance compliance of the instrument portfolio."
    - name: "count_ethically_reviewed_tools"
      expr: COUNT(CASE WHEN ethical_review_status = 'Approved' THEN 1 END)
      comment: "Number of tools with ethics approval — measures ethical compliance of data collection instruments; critical for donor and IRB reporting."
    - name: "count_deployed_tools"
      expr: COUNT(CASE WHEN tool_status = 'Deployed' THEN 1 END)
      comment: "Number of currently deployed tools — measures active data collection capacity across the programme portfolio."
    - name: "count_distinct_interventions_with_tools"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Number of distinct interventions with data collection tools — measures MEL instrument coverage across the programme portfolio."
    - name: "count_distinct_tool_types"
      expr: COUNT(DISTINCT tool_type)
      comment: "Number of distinct tool types in use — measures methodological diversity of the data collection portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`mel_logframe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MEL logframe quality and results chain view tracking logframe completeness, target ambition, and strategic alignment. Used by MEL architects and programme directors to govern results framework quality and donor compliance."
  source: "`vibe_ngo_v1`.`mel`.`mel_logframe`"
  dimensions:
    - name: "intervention_id"
      expr: intervention_id
      comment: "Foreign key to intervention — enables logframe analysis by programme."
    - name: "partner_org_id"
      expr: partner_org_id
      comment: "Foreign key to partner organisation — enables partner-level logframe quality analysis."
    - name: "results_chain_level"
      expr: results_chain_level
      comment: "Results chain level (input, activity, output, outcome, impact) — enables analysis of logframe completeness across the results chain."
    - name: "mel_logframe_status"
      expr: mel_logframe_status
      comment: "Current status of the logframe (Draft, Approved, Active, Archived) — used to filter to live logframes."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Reporting frequency for this logframe row — informs data collection planning."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the logframe row — measures strategic coherence with global development frameworks."
    - name: "donor_template_type"
      expr: donor_template_type
      comment: "Donor template type the logframe conforms to — enables donor-specific compliance analysis."
    - name: "is_mandatory_donor_indicator"
      expr: is_mandatory_donor_indicator
      comment: "Boolean flag for mandatory donor indicators — ensures compliance indicators are tracked separately."
    - name: "is_custom_indicator"
      expr: is_custom_indicator
      comment: "Boolean flag for custom indicators — enables analysis of indicator standardisation."
    - name: "theory_of_change_component"
      expr: theory_of_change_component
      comment: "Theory of change component this logframe row maps to — enables ToC coverage analysis."
    - name: "baseline_date"
      expr: DATE_TRUNC('year', baseline_date)
      comment: "Year of baseline measurement — enables cohort analysis of logframe maturity."
    - name: "target_date"
      expr: DATE_TRUNC('year', target_date)
      comment: "Year the logframe target is due — enables forward-looking pipeline analysis."
  measures:
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Total planned target value across logframe rows — measures aggregate programme ambition in the results framework."
    - name: "total_actual_value"
      expr: SUM(CAST(actual_value AS DOUBLE))
      comment: "Total actual value achieved across logframe rows — measures aggregate programme performance against the results framework."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value per logframe row — benchmarks target ambition across the results framework."
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual value per logframe row — benchmarks achievement across the results framework."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value per logframe row — contextualises target ambition relative to starting conditions."
    - name: "count_logframe_rows"
      expr: COUNT(1)
      comment: "Total number of logframe rows — baseline metric for results framework completeness."
    - name: "count_mandatory_donor_indicators"
      expr: COUNT(CASE WHEN is_mandatory_donor_indicator = TRUE THEN 1 END)
      comment: "Number of mandatory donor indicators in the logframe — tracks donor compliance obligations."
    - name: "count_logframes_with_sdg_alignment"
      expr: COUNT(CASE WHEN sdg_alignment IS NOT NULL AND sdg_alignment <> '' THEN 1 END)
      comment: "Number of logframe rows with SDG alignment — measures strategic coherence of the results framework with global goals."
    - name: "count_distinct_results_chain_levels"
      expr: COUNT(DISTINCT results_chain_level)
      comment: "Number of distinct results chain levels covered — measures completeness of the results framework across the theory of change."
$$;