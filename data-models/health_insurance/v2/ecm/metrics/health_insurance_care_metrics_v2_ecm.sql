-- Metric views for domain: care | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 00:30:14

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks active care program enrollment volume, acuity distribution, and risk profile across programs and coordinators. Core operational KPI for care management capacity planning."
  source: "`vibe_health_insurance_v1`.`care`.`care_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (active, disenrolled, pending) for cohort segmentation."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (voluntary, auto-enrolled, referral) to understand intake channel mix."
    - name: "acuity_level"
      expr: acuity_level
      comment: "Member acuity level driving resource allocation decisions."
    - name: "program_tier"
      expr: program_tier
      comment: "Program tier assignment indicating intensity of care management services."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source channel that generated the enrollment (claims, HRA, referral, etc.)."
    - name: "effective_start_year"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year of enrollment start for trend analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month of enrollment start for seasonal pattern analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total care program enrollment records. Baseline volume KPI for capacity planning."
    - name: "active_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'active' THEN 1 END)
      comment: "Count of currently active enrollments. Primary operational headcount metric."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average member risk score across enrolled population. Drives resource allocation and program intensity decisions."
    - name: "avg_hcc_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average HCC (Hierarchical Condition Category) score for enrolled members. Directly tied to risk adjustment revenue."
    - name: "disenrollment_count"
      expr: COUNT(CASE WHEN disenrollment_date IS NOT NULL THEN 1 END)
      comment: "Count of disenrolled members. Tracks program retention and identifies dropout patterns."
    - name: "disenrollment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN disenrollment_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that resulted in disenrollment. Key retention KPI for program effectiveness."
    - name: "high_acuity_enrollment_count"
      expr: COUNT(CASE WHEN acuity_level IN ('high', 'critical', 'complex') THEN 1 END)
      comment: "Count of high-acuity enrollments requiring intensive care management. Drives staffing and cost projections."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_program_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures program enrollment performance, engagement quality, medication adherence, and graduation outcomes. Strategic KPI for care program ROI and effectiveness evaluation."
  source: "`vibe_health_insurance_v1`.`care`.`program_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status for cohort filtering."
    - name: "program_phase"
      expr: program_phase
      comment: "Phase of the care program (intake, active, graduation) for lifecycle analysis."
    - name: "acuity_level"
      expr: acuity_level
      comment: "Member acuity level for risk stratification reporting."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk stratification tier for population health segmentation."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source channel generating the enrollment for intake funnel analysis."
    - name: "enrollment_method"
      expr: enrollment_method
      comment: "Method of enrollment (auto, manual, referral) for process efficiency analysis."
    - name: "risk_stratification_level"
      expr: risk_stratification_level
      comment: "Risk stratification level for population segmentation and resource targeting."
    - name: "enrollment_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month of enrollment start for trend and seasonality analysis."
  measures:
    - name: "total_program_enrollments"
      expr: COUNT(1)
      comment: "Total program enrollment records. Baseline volume for program capacity management."
    - name: "active_program_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'active' THEN 1 END)
      comment: "Active program enrollments. Core operational headcount for staffing decisions."
    - name: "avg_engagement_score"
      expr: AVG(CAST(engagement_score AS DOUBLE))
      comment: "Average member engagement score. Predicts program completion and outcome achievement."
    - name: "avg_medication_adherence_score"
      expr: AVG(CAST(medication_adherence_score AS DOUBLE))
      comment: "Average medication adherence score. Directly linked to clinical outcomes and readmission risk."
    - name: "avg_complexity_score"
      expr: AVG(CAST(complexity_score AS DOUBLE))
      comment: "Average case complexity score. Drives care coordinator workload and resource allocation."
    - name: "graduation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN graduation_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that graduated from the program. Primary program effectiveness KPI."
    - name: "readmission_risk_count"
      expr: COUNT(CASE WHEN readmission_risk_flag = TRUE THEN 1 END)
      comment: "Count of members flagged for readmission risk. Drives targeted intervention prioritization."
    - name: "readmission_risk_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN readmission_risk_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrolled members with readmission risk flag. Key quality and cost containment metric."
    - name: "avg_participation_rate"
      expr: AVG(CAST(participation_rate AS DOUBLE))
      comment: "Average member participation rate in program activities. Measures program engagement effectiveness."
    - name: "voluntary_enrollment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_voluntary = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of voluntary enrollments vs. auto-enrolled. Indicates member receptivity and program appeal."
    - name: "avg_total_goals_count"
      expr: AVG(CAST(total_goals_count AS DOUBLE))
      comment: "Average number of care goals per enrollment. Measures care plan comprehensiveness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_hedis_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks HEDIS measure performance rates, compliance status, and quality scores by plan and measurement year. Core quality reporting KPI for Star Ratings and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`care`.`hedis_result`"
  dimensions:
    - name: "measurement_year"
      expr: measurement_year
      comment: "HEDIS measurement year for year-over-year quality trend analysis."
    - name: "measure_category"
      expr: measure_category
      comment: "HEDIS measure category (preventive care, chronic disease management, etc.) for domain-level quality reporting."
    - name: "measure_type"
      expr: measure_type
      comment: "Type of HEDIS measure for classification and benchmarking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the measure result for regulatory reporting."
    - name: "collection_method"
      expr: collection_method
      comment: "Data collection method (administrative, hybrid, survey) affecting measure reliability."
    - name: "data_source"
      expr: data_source
      comment: "Source system providing the measure data for data quality governance."
    - name: "result_month"
      expr: DATE_TRUNC('month', result_timestamp)
      comment: "Month of result calculation for trend monitoring."
  measures:
    - name: "total_measure_results"
      expr: COUNT(1)
      comment: "Total HEDIS measure result records. Baseline for quality reporting completeness."
    - name: "numerator_met_count"
      expr: COUNT(CASE WHEN numerator_criteria_met = TRUE THEN 1 END)
      comment: "Count of members meeting the HEDIS numerator criteria. Numerator for measure rate calculation."
    - name: "denominator_met_count"
      expr: COUNT(CASE WHEN denominator_criteria_met = TRUE THEN 1 END)
      comment: "Count of members meeting the HEDIS denominator criteria. Denominator for measure rate calculation."
    - name: "measure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN numerator_criteria_met = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN denominator_criteria_met = TRUE THEN 1 END), 0), 2)
      comment: "HEDIS measure performance rate (numerator/denominator). Primary quality KPI for Star Ratings and accreditation."
    - name: "exclusion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_excluded = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of members excluded from the measure. High exclusion rates may indicate data quality issues."
    - name: "avg_measure_score"
      expr: AVG(CAST(measure_score AS DOUBLE))
      comment: "Average measure score across all results. Tracks quality performance trajectory for executive reporting."
    - name: "compliant_result_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measure results in compliant status. Regulatory compliance KPI for CMS and state reporting."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_hedis_measure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides a catalog-level view of HEDIS measure definitions, benchmarks, and star rating impact weights. Used by quality leadership to prioritize improvement investments."
  source: "`vibe_health_insurance_v1`.`care`.`hedis_measure`"
  dimensions:
    - name: "measure_domain"
      expr: measure_domain
      comment: "Clinical domain of the HEDIS measure (e.g., preventive care, behavioral health) for portfolio analysis."
    - name: "measure_status"
      expr: measure_status
      comment: "Active/retired status of the measure for current-year reporting scope."
    - name: "measure_scoring_method"
      expr: measure_scoring_method
      comment: "Scoring methodology (rate, ratio, continuous variable) for measure interpretation."
    - name: "measure_reporting_frequency"
      expr: measure_reporting_frequency
      comment: "Reporting frequency (annual, biennial) for planning submission calendars."
    - name: "measurement_year"
      expr: measurement_year
      comment: "Measurement year for year-over-year benchmark comparison."
    - name: "measure_star_rating_impact"
      expr: measure_star_rating_impact
      comment: "Star rating domain this measure impacts for prioritization of improvement efforts."
  measures:
    - name: "total_active_measures"
      expr: COUNT(CASE WHEN measure_status = 'active' THEN 1 END)
      comment: "Count of active HEDIS measures in scope. Defines the quality reporting portfolio size."
    - name: "avg_national_benchmark"
      expr: AVG(CAST(measure_national_benchmark AS DOUBLE))
      comment: "Average national benchmark across all measures. Provides baseline for gap-to-benchmark analysis."
    - name: "avg_state_benchmark"
      expr: AVG(CAST(measure_state_benchmark AS DOUBLE))
      comment: "Average state benchmark across all measures. Used for state-level competitive positioning."
    - name: "avg_target_value"
      expr: AVG(CAST(measure_target_value AS DOUBLE))
      comment: "Average target value across measures. Tracks ambition level of quality improvement goals."
    - name: "avg_raf_impact"
      expr: AVG(CAST(measure_related_raf AS DOUBLE))
      comment: "Average RAF (Risk Adjustment Factor) impact across measures. Links quality performance to risk revenue."
    - name: "measures_with_star_impact_count"
      expr: COUNT(CASE WHEN measure_star_rating_impact IS NOT NULL AND measure_star_rating_impact != '' THEN 1 END)
      comment: "Count of measures with direct Star Rating impact. Prioritizes quality investment for bonus payment eligibility."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_gap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks care gaps by status, type, and clinical category. Core quality improvement KPI for HEDIS gap closure rates and risk-adjusted care management performance."
  source: "`vibe_health_insurance_v1`.`care`.`gap`"
  dimensions:
    - name: "gap_status"
      expr: gap_status
      comment: "Current gap status (open, closed, in-progress) for operational prioritization."
    - name: "gap_type"
      expr: gap_type
      comment: "Type of care gap (preventive, chronic, medication) for clinical category analysis."
    - name: "clinical_category"
      expr: clinical_category
      comment: "Clinical category of the gap for domain-level quality reporting."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the gap for resource allocation and intervention sequencing."
    - name: "closure_method"
      expr: closure_method
      comment: "Method used to close the gap (claim, supplemental data, outreach) for process effectiveness analysis."
    - name: "documentation_status"
      expr: documentation_status
      comment: "Documentation completeness status for data quality governance."
    - name: "open_month"
      expr: DATE_TRUNC('month', open_date)
      comment: "Month gap was opened for trend and seasonality analysis."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating critical gaps requiring immediate intervention."
  measures:
    - name: "total_gaps"
      expr: COUNT(1)
      comment: "Total care gap records. Baseline volume for quality improvement program scope."
    - name: "open_gaps"
      expr: COUNT(CASE WHEN gap_status = 'open' THEN 1 END)
      comment: "Count of currently open care gaps. Primary quality improvement backlog metric."
    - name: "gap_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gap_status = 'closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gaps that have been closed. Core HEDIS quality improvement KPI tied to Star Ratings."
    - name: "critical_gap_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of critical care gaps. Drives urgent intervention prioritization and escalation."
    - name: "critical_gap_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gaps classified as critical. Indicates severity of quality deficiencies in the population."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of members with open gaps. Prioritizes high-risk gap closure for maximum clinical and financial impact."
    - name: "avg_measure_target_value"
      expr: AVG(CAST(measure_target_value AS DOUBLE))
      comment: "Average measure target value across gaps. Benchmarks gap closure ambition against quality targets."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_star_rating_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks CMS Star Rating scores by measure, domain, and year. Strategic KPI for quality bonus payment eligibility and competitive market positioning."
  source: "`vibe_health_insurance_v1`.`care`.`star_rating_result`"
  dimensions:
    - name: "measurement_year"
      expr: measurement_year
      comment: "Star rating measurement year for year-over-year performance tracking."
    - name: "star_domain"
      expr: star_domain
      comment: "Star rating domain (quality, patient experience, access) for domain-level performance analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Health plan type (MA, PDP, MAPD) for plan-level star rating comparison."
    - name: "rating_status"
      expr: rating_status
      comment: "Current rating status for reporting completeness tracking."
    - name: "trend_direction"
      expr: trend_direction
      comment: "Year-over-year trend direction (improving, declining, stable) for executive performance narrative."
    - name: "quality_bonus_eligible"
      expr: quality_bonus_eligible
      comment: "Flag indicating eligibility for CMS quality bonus payment. Directly tied to revenue."
    - name: "improvement_measure_flag"
      expr: improvement_measure_flag
      comment: "Flag for measures receiving improvement bonus weighting."
  measures:
    - name: "total_rated_measures"
      expr: COUNT(1)
      comment: "Total star-rated measure records. Defines the scope of the star rating portfolio."
    - name: "quality_bonus_eligible_count"
      expr: COUNT(CASE WHEN quality_bonus_eligible = TRUE THEN 1 END)
      comment: "Count of measures qualifying for CMS quality bonus payment. Directly drives bonus revenue eligibility."
    - name: "quality_bonus_eligible_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_bonus_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measures qualifying for quality bonus. Key strategic KPI for CMS revenue optimization."
    - name: "avg_measure_weight"
      expr: AVG(CAST(measure_weight AS DOUBLE))
      comment: "Average measure weight in star rating calculation. Identifies high-leverage measures for investment prioritization."
    - name: "improving_measure_count"
      expr: COUNT(CASE WHEN trend_direction = 'improving' THEN 1 END)
      comment: "Count of measures with improving trend. Tracks quality improvement program momentum."
    - name: "declining_measure_count"
      expr: COUNT(CASE WHEN trend_direction = 'declining' THEN 1 END)
      comment: "Count of measures with declining trend. Triggers intervention and root cause analysis."
    - name: "avg_cutpoint_4_star"
      expr: AVG(CAST(cutpoint_4_star AS DOUBLE))
      comment: "Average 4-star cutpoint threshold across measures. Benchmarks performance gap to bonus-eligible threshold."
    - name: "avg_cutpoint_5_star"
      expr: AVG(CAST(cutpoint_5_star AS DOUBLE))
      comment: "Average 5-star cutpoint threshold across measures. Benchmarks performance gap to maximum bonus threshold."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_cahps_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks CAHPS member experience survey scores across key domains. Strategic KPI for Star Ratings patient experience component and member satisfaction management."
  source: "`vibe_health_insurance_v1`.`care`.`cahps_survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of CAHPS survey (MA, PDP, health plan) for survey portfolio segmentation."
    - name: "survey_year"
      expr: survey_year
      comment: "Survey year for year-over-year member experience trend analysis."
    - name: "survey_status"
      expr: survey_status
      comment: "Survey completion status for response rate monitoring."
    - name: "survey_mode"
      expr: survey_mode
      comment: "Survey administration mode (mail, phone, web) for channel effectiveness analysis."
    - name: "member_state"
      expr: member_state
      comment: "Member state for geographic variation analysis in member experience."
    - name: "survey_language"
      expr: survey_language
      comment: "Survey language for health equity and language access reporting."
    - name: "survey_start_month"
      expr: DATE_TRUNC('month', survey_start_date)
      comment: "Month survey was administered for timing and seasonality analysis."
  measures:
    - name: "total_surveys"
      expr: COUNT(1)
      comment: "Total CAHPS survey records. Baseline for response rate and sample size adequacy."
    - name: "avg_overall_satisfaction_score"
      expr: AVG(CAST(overall_satisfaction_score AS DOUBLE))
      comment: "Average overall member satisfaction score. Primary CAHPS KPI for Star Ratings patient experience domain."
    - name: "avg_getting_care_quickly_score"
      expr: AVG(CAST(getting_care_quickly_score AS DOUBLE))
      comment: "Average score for getting care quickly composite. Measures access to care performance."
    - name: "avg_getting_needed_care_score"
      expr: AVG(CAST(getting_needed_care_score AS DOUBLE))
      comment: "Average score for getting needed care composite. Measures care access and authorization effectiveness."
    - name: "avg_doctor_communication_score"
      expr: AVG(CAST(doctor_communication_score AS DOUBLE))
      comment: "Average doctor communication score. Measures provider quality from member perspective."
    - name: "avg_customer_service_score"
      expr: AVG(CAST(customer_service_score AS DOUBLE))
      comment: "Average customer service score. Measures health plan administrative experience quality."
    - name: "avg_response_rate"
      expr: AVG(CAST(response_rate AS DOUBLE))
      comment: "Average survey response rate. Low response rates threaten statistical validity and CMS submission eligibility."
    - name: "avg_star_rating_impact_score"
      expr: AVG(CAST(star_rating_impact_score AS DOUBLE))
      comment: "Average star rating impact score across surveys. Quantifies CAHPS contribution to overall star rating."
    - name: "regulatory_reporting_count"
      expr: COUNT(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 END)
      comment: "Count of surveys flagged for regulatory reporting. Ensures CMS submission completeness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_hra`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks Health Risk Assessment completion rates, risk scores, and SDOH flag prevalence. Core population health KPI for risk stratification and care program targeting."
  source: "`vibe_health_insurance_v1`.`care`.`hra`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "HRA completion status for completion rate monitoring."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of HRA (initial, annual, follow-up) for assessment lifecycle analysis."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier assigned from HRA results for population stratification."
    - name: "completion_channel"
      expr: completion_channel
      comment: "Channel through which HRA was completed (web, phone, in-person) for access analysis."
    - name: "assessment_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of HRA completion for trend and outreach campaign effectiveness analysis."
    - name: "compliance_cms_required"
      expr: compliance_cms_required
      comment: "Flag for CMS-required HRAs for regulatory compliance tracking."
  measures:
    - name: "total_hras"
      expr: COUNT(1)
      comment: "Total HRA records. Baseline for completion rate and population coverage analysis."
    - name: "completed_hras"
      expr: COUNT(CASE WHEN assessment_status = 'completed' THEN 1 END)
      comment: "Count of completed HRAs. Primary metric for population health assessment coverage."
    - name: "hra_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN assessment_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "HRA completion rate. Regulatory compliance KPI for Medicare Advantage and Medicaid programs."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average HRA risk score across assessed population. Drives care program enrollment targeting."
    - name: "avg_risk_score_percentile"
      expr: AVG(CAST(risk_score_percentile AS DOUBLE))
      comment: "Average risk score percentile. Enables relative risk comparison across population segments."
    - name: "sdoh_food_insecurity_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sdoh_food_insecurity = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of members with food insecurity SDOH flag. Drives community resource referral programs."
    - name: "sdoh_housing_instability_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sdoh_housing_instability = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of members with housing instability SDOH flag. Informs social determinants intervention strategy."
    - name: "sdoh_transportation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sdoh_transportation = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of members with transportation barrier SDOH flag. Drives non-emergency medical transportation program investment."
    - name: "cms_required_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_cms_required = TRUE AND assessment_status = 'completed' THEN 1 END) / NULLIF(COUNT(CASE WHEN compliance_cms_required = TRUE THEN 1 END), 0), 2)
      comment: "Completion rate for CMS-required HRAs. Regulatory compliance KPI with direct CMS audit implications."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_member_risk_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks member risk tier distribution, risk score trends, and PMPM cost bands. Strategic KPI for population health investment prioritization and actuarial planning."
  source: "`vibe_health_insurance_v1`.`care`.`member_risk_tier`"
  dimensions:
    - name: "tier_name"
      expr: tier_name
      comment: "Risk tier name (low, medium, high, complex) for population stratification reporting."
    - name: "tier_code"
      expr: tier_code
      comment: "Risk tier code for system integration and reporting consistency."
    - name: "tier_band"
      expr: tier_band
      comment: "Risk tier band for cost band analysis."
    - name: "model_type"
      expr: model_type
      comment: "Risk stratification model type for model performance comparison."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign risk tier (predictive model, clinical review) for methodology governance."
    - name: "demographic_group"
      expr: demographic_group
      comment: "Demographic group for health equity and disparity analysis."
    - name: "is_current"
      expr: is_current
      comment: "Flag for current active tier assignment for point-in-time population analysis."
    - name: "assignment_month"
      expr: DATE_TRUNC('month', assignment_date)
      comment: "Month of tier assignment for trend analysis."
  measures:
    - name: "total_tier_assignments"
      expr: COUNT(1)
      comment: "Total risk tier assignment records. Baseline for population stratification coverage."
    - name: "current_tier_assignments"
      expr: COUNT(CASE WHEN is_current = TRUE THEN 1 END)
      comment: "Count of current active tier assignments. Defines the stratified population for care management targeting."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across tier assignments. Tracks population risk trajectory for actuarial planning."
    - name: "avg_hcc_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average HCC score across tier assignments. Directly linked to risk adjustment revenue projections."
    - name: "avg_pmpm_cost_band"
      expr: AVG(CAST(pmpm_cost_band AS DOUBLE))
      comment: "Average PMPM cost band across risk tiers. Core actuarial metric for premium adequacy and medical cost forecasting."
    - name: "avg_risk_factor_weight"
      expr: AVG(CAST(risk_factor_weight AS DOUBLE))
      comment: "Average risk factor weight. Measures the relative contribution of risk factors to tier assignment."
    - name: "chronic_condition_flag_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN chronic_condition_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of members with chronic condition flags. Drives disease management program investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_condition_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks chronic condition prevalence, HCC coding completeness, and risk adjustment flag rates. Core KPI for risk adjustment revenue optimization and population health management."
  source: "`vibe_health_insurance_v1`.`care`.`condition_registry`"
  dimensions:
    - name: "condition_category"
      expr: condition_category
      comment: "Clinical category of the condition for disease burden analysis."
    - name: "condition_code"
      expr: condition_code
      comment: "Diagnosis code for condition-level prevalence reporting."
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Confirmation status (confirmed, suspected, resolved) for data quality governance."
    - name: "severity"
      expr: severity
      comment: "Condition severity for clinical prioritization and resource allocation."
    - name: "identification_method"
      expr: identification_method
      comment: "Method of condition identification (claims, clinical, HRA) for data completeness analysis."
    - name: "is_chronic"
      expr: is_chronic
      comment: "Flag for chronic conditions driving ongoing care management needs."
    - name: "risk_adjustment_flag"
      expr: risk_adjustment_flag
      comment: "Flag for conditions eligible for risk adjustment. Directly tied to CMS risk revenue."
    - name: "population_segment"
      expr: population_segment
      comment: "Population segment for health equity and disparity analysis."
    - name: "identification_month"
      expr: DATE_TRUNC('month', identification_date)
      comment: "Month of condition identification for disease surveillance trend analysis."
  measures:
    - name: "total_conditions"
      expr: COUNT(1)
      comment: "Total condition registry records. Baseline for disease burden and coding completeness analysis."
    - name: "active_conditions"
      expr: COUNT(CASE WHEN active_flag = TRUE THEN 1 END)
      comment: "Count of currently active conditions. Defines the active disease burden for care management targeting."
    - name: "chronic_condition_count"
      expr: COUNT(CASE WHEN is_chronic = TRUE THEN 1 END)
      comment: "Count of chronic conditions. Primary driver of care management program enrollment and resource allocation."
    - name: "risk_adjustment_eligible_count"
      expr: COUNT(CASE WHEN risk_adjustment_flag = TRUE THEN 1 END)
      comment: "Count of conditions eligible for risk adjustment. Directly tied to CMS risk adjustment revenue."
    - name: "risk_adjustment_capture_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_adjustment_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of conditions flagged for risk adjustment. Measures HCC coding completeness and revenue capture opportunity."
    - name: "avg_raf_score"
      expr: AVG(CAST(raf_score AS DOUBLE))
      comment: "Average RAF score across registered conditions. Quantifies risk adjustment revenue contribution of the condition portfolio."
    - name: "hcc_coded_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hcc_code IS NOT NULL AND hcc_code != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of conditions with HCC codes assigned. Measures risk adjustment coding completeness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks care plan creation, status, and risk profile. Operational KPI for care management program quality and coordinator workload management."
  source: "`vibe_health_insurance_v1`.`care`.`care_plan`"
  dimensions:
    - name: "care_plan_status"
      expr: care_plan_status
      comment: "Current care plan status (active, completed, suspended) for operational monitoring."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of care plan (chronic disease, transitional, preventive) for program mix analysis."
    - name: "high_risk_flag"
      expr: high_risk_flag
      comment: "Flag for high-risk care plans requiring intensive management."
    - name: "privacy_consent_flag"
      expr: privacy_consent_flag
      comment: "Privacy consent status for HIPAA compliance monitoring."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month care plan became effective for trend analysis."
  measures:
    - name: "total_care_plans"
      expr: COUNT(1)
      comment: "Total care plan records. Baseline for care management program volume."
    - name: "active_care_plans"
      expr: COUNT(CASE WHEN care_plan_status = 'active' THEN 1 END)
      comment: "Count of active care plans. Core operational metric for coordinator workload management."
    - name: "high_risk_plan_count"
      expr: COUNT(CASE WHEN high_risk_flag = TRUE THEN 1 END)
      comment: "Count of high-risk care plans. Drives intensive care management resource allocation."
    - name: "high_risk_plan_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN high_risk_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of care plans classified as high-risk. Measures acuity intensity of the care management population."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across care plans. Tracks population risk trajectory for program intensity calibration."
    - name: "consent_obtained_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN privacy_consent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of care plans with privacy consent obtained. HIPAA compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_plan_goal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks care plan goal achievement rates, target vs. actual values, and compliance. KPI for care management program effectiveness and clinical outcome measurement."
  source: "`vibe_health_insurance_v1`.`care`.`plan_goal`"
  dimensions:
    - name: "plan_goal_status"
      expr: plan_goal_status
      comment: "Current goal status (active, achieved, not-met, abandoned) for goal achievement tracking."
    - name: "goal_category"
      expr: goal_category
      comment: "Clinical category of the goal (medication adherence, weight management, etc.) for outcome domain analysis."
    - name: "goal_code"
      expr: goal_code
      comment: "Standardized goal code for cross-program benchmarking."
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement used to assess goal achievement."
    - name: "priority"
      expr: priority
      comment: "Goal priority level for resource allocation and intervention sequencing."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag for goals tied to regulatory compliance requirements."
    - name: "target_month"
      expr: DATE_TRUNC('month', target_date)
      comment: "Month goal is targeted for completion for timeline adherence analysis."
  measures:
    - name: "total_goals"
      expr: COUNT(1)
      comment: "Total care plan goals. Baseline for goal portfolio management."
    - name: "achieved_goals"
      expr: COUNT(CASE WHEN plan_goal_status = 'achieved' THEN 1 END)
      comment: "Count of achieved goals. Primary clinical outcome KPI for care management program effectiveness."
    - name: "goal_achievement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN plan_goal_status = 'achieved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of care plan goals achieved. Core program effectiveness KPI for executive reporting."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across goals. Benchmarks ambition level of care management interventions."
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual achieved value across goals. Measures clinical outcome attainment."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score associated with goals. Prioritizes high-risk goal achievement for maximum clinical impact."
    - name: "compliance_goal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goals tied to regulatory compliance. Tracks compliance-driven care management activity."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_member_outreach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks member outreach volume, channel effectiveness, and outcome rates. Operational KPI for care management engagement strategy and coordinator productivity."
  source: "`vibe_health_insurance_v1`.`care`.`member_outreach`"
  dimensions:
    - name: "member_outreach_status"
      expr: member_outreach_status
      comment: "Outreach status (completed, attempted, failed) for engagement funnel analysis."
    - name: "channel"
      expr: channel
      comment: "Outreach channel (phone, mail, portal, SMS) for channel effectiveness comparison."
    - name: "purpose"
      expr: purpose
      comment: "Purpose of outreach (gap closure, enrollment, follow-up) for activity categorization."
    - name: "outcome"
      expr: outcome
      comment: "Outreach outcome (reached, voicemail, refused) for conversion analysis."
    - name: "is_automated"
      expr: is_automated
      comment: "Flag for automated vs. manual outreach for cost-per-contact analysis."
    - name: "language_preference"
      expr: language_preference
      comment: "Member language preference for health equity and language access reporting."
    - name: "outreach_month"
      expr: DATE_TRUNC('month', outreach_timestamp)
      comment: "Month of outreach for trend and campaign effectiveness analysis."
  measures:
    - name: "total_outreach_attempts"
      expr: COUNT(1)
      comment: "Total outreach attempts. Baseline for engagement volume and coordinator productivity."
    - name: "successful_outreach_count"
      expr: COUNT(CASE WHEN member_outreach_status = 'completed' THEN 1 END)
      comment: "Count of successful outreach contacts. Primary engagement effectiveness KPI."
    - name: "outreach_success_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN member_outreach_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach attempts resulting in successful contact. Drives channel strategy and timing optimization."
    - name: "consent_obtained_count"
      expr: COUNT(CASE WHEN compliance_consent_obtained = TRUE THEN 1 END)
      comment: "Count of outreach contacts where consent was obtained. HIPAA compliance and program enrollment KPI."
    - name: "consent_obtained_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_consent_obtained = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach contacts resulting in consent. Measures enrollment conversion effectiveness."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required = TRUE THEN 1 END)
      comment: "Count of outreach contacts requiring follow-up. Drives coordinator workload planning."
    - name: "automated_outreach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_automated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach conducted via automated channels. Measures operational efficiency and cost reduction."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_snf_stay`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks SNF (Skilled Nursing Facility) stay volume, readmission risk, and financial metrics. Strategic KPI for post-acute care cost management and quality improvement."
  source: "`vibe_health_insurance_v1`.`care`.`snf_stay`"
  dimensions:
    - name: "snf_stay_status"
      expr: snf_stay_status
      comment: "Current SNF stay status for operational monitoring."
    - name: "snf_type"
      expr: snf_type
      comment: "Type of SNF stay for clinical category analysis."
    - name: "admission_diagnosis_code"
      expr: admission_diagnosis_code
      comment: "Primary admission diagnosis code for clinical pattern analysis."
    - name: "drg_code"
      expr: drg_code
      comment: "DRG code for episode-level cost analysis."
    - name: "readmission_risk_flag"
      expr: readmission_risk_flag
      comment: "Flag for members at risk of readmission within 30 days."
    - name: "readmission_within_30_days"
      expr: readmission_within_30_days
      comment: "Flag for actual 30-day readmission. Core quality and cost KPI."
    - name: "is_eligible_for_medicare"
      expr: is_eligible_for_medicare
      comment: "Medicare eligibility flag for benefit coordination analysis."
    - name: "admission_month"
      expr: DATE_TRUNC('month', admission_timestamp)
      comment: "Month of SNF admission for trend and seasonality analysis."
  measures:
    - name: "total_snf_stays"
      expr: COUNT(1)
      comment: "Total SNF stay records. Baseline for post-acute utilization volume."
    - name: "readmission_within_30_days_count"
      expr: COUNT(CASE WHEN readmission_within_30_days = TRUE THEN 1 END)
      comment: "Count of SNF stays resulting in 30-day readmission. Core quality and cost containment KPI."
    - name: "readmission_30_day_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN readmission_within_30_days = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "30-day readmission rate from SNF stays. Directly tied to CMS quality penalties and Star Ratings."
    - name: "total_charge_amount"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total SNF stay charges. Core financial KPI for post-acute cost management."
    - name: "avg_charge_per_stay"
      expr: AVG(CAST(total_charge_amount AS DOUBLE))
      comment: "Average charge per SNF stay. Benchmarks cost efficiency of post-acute care."
    - name: "avg_hcc_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average HCC score for SNF patients. Links post-acute utilization to risk adjustment revenue."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor for SNF stays. Quantifies risk-adjusted cost of post-acute care."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount for SNF stays. Actual financial liability for post-acute care."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_transition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks care transitions (hospital to home, SNF to home, etc.) for readmission risk, DME coordination, and transition of care plan completion. KPI for post-acute quality and cost management."
  source: "`vibe_health_insurance_v1`.`care`.`transition`"
  dimensions:
    - name: "transition_type"
      expr: transition_type
      comment: "Type of care transition (hospital discharge, SNF discharge, etc.) for transition pattern analysis."
    - name: "transition_status"
      expr: transition_status
      comment: "Current transition status for operational monitoring."
    - name: "from_setting"
      expr: from_setting
      comment: "Care setting transitioned from for transition pathway analysis."
    - name: "to_setting"
      expr: to_setting
      comment: "Care setting transitioned to for post-acute utilization analysis."
    - name: "readmission_risk_flag"
      expr: readmission_risk_flag
      comment: "Flag for members at high readmission risk during transition."
    - name: "is_critical_transition"
      expr: is_critical_transition
      comment: "Flag for critical transitions requiring intensive care coordination."
    - name: "toc_plan_completed"
      expr: toc_plan_completed
      comment: "Flag for transition of care plan completion. Quality KPI for CMS transition care management."
    - name: "transition_month"
      expr: DATE_TRUNC('month', transition_timestamp)
      comment: "Month of transition for trend and seasonality analysis."
  measures:
    - name: "total_transitions"
      expr: COUNT(1)
      comment: "Total care transition records. Baseline for transition of care program volume."
    - name: "toc_plan_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN toc_plan_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transitions with completed transition of care plans. CMS quality KPI for Transitional Care Management billing."
    - name: "readmission_risk_count"
      expr: COUNT(CASE WHEN readmission_risk_flag = TRUE THEN 1 END)
      comment: "Count of transitions with high readmission risk. Drives targeted post-discharge intervention."
    - name: "readmission_risk_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN readmission_risk_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transitions flagged for readmission risk. Key quality and cost containment metric."
    - name: "critical_transition_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical_transition = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transitions classified as critical. Drives intensive care coordination resource allocation."
    - name: "avg_readmission_risk_score"
      expr: AVG(CAST(readmission_risk_score AS DOUBLE))
      comment: "Average readmission risk score across transitions. Quantifies population-level readmission risk for intervention prioritization."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor for transitioning members. Links transition care management to risk revenue."
    - name: "dme_coordination_required_count"
      expr: COUNT(CASE WHEN dme_coordination_status IS NOT NULL AND dme_coordination_status != '' THEN 1 END)
      comment: "Count of transitions requiring DME coordination. Drives DME vendor management and cost oversight."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_sdoh_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks SDOH (Social Determinants of Health) assessment completion, risk levels, and referral rates. Strategic KPI for health equity programs and social needs intervention effectiveness."
  source: "`vibe_health_insurance_v1`.`care`.`sdoh_assessment`"
  dimensions:
    - name: "sdoh_assessment_status"
      expr: sdoh_assessment_status
      comment: "Assessment completion status for coverage monitoring."
    - name: "sdoh_domain"
      expr: sdoh_domain
      comment: "SDOH domain assessed (housing, food, transportation, etc.) for social needs portfolio analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "SDOH risk level for population stratification and intervention prioritization."
    - name: "screening_tool"
      expr: screening_tool
      comment: "Screening tool used for assessment standardization analysis."
    - name: "follow_up_status"
      expr: follow_up_status
      comment: "Follow-up status for intervention completion tracking."
    - name: "assessment_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of assessment for trend and program effectiveness analysis."
  measures:
    - name: "total_sdoh_assessments"
      expr: COUNT(1)
      comment: "Total SDOH assessment records. Baseline for social needs screening coverage."
    - name: "high_risk_sdoh_count"
      expr: COUNT(CASE WHEN risk_level IN ('high', 'critical') THEN 1 END)
      comment: "Count of high-risk SDOH assessments. Drives social needs intervention program investment."
    - name: "high_risk_sdoh_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_level IN ('high', 'critical') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments identifying high social risk. Measures social determinants burden in the population."
    - name: "referral_made_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN referral_made_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments resulting in community resource referral. Measures social needs intervention activation rate."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average SDOH assessment score. Tracks population-level social risk burden for program investment decisions."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor from SDOH assessments. Links social risk to clinical risk and revenue implications."
    - name: "consent_obtained_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN confidentiality_consent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SDOH assessments with confidentiality consent obtained. HIPAA compliance KPI for sensitive social data."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_barrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks care barriers by type, severity, and resolution rates. Operational KPI for care management intervention effectiveness and member engagement strategy."
  source: "`vibe_health_insurance_v1`.`care`.`barrier`"
  dimensions:
    - name: "barrier_status"
      expr: barrier_status
      comment: "Current barrier status (open, resolved, escalated) for operational monitoring."
    - name: "barrier_type"
      expr: barrier_type
      comment: "Type of barrier (financial, transportation, language, clinical) for intervention strategy analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Barrier severity level for prioritization and resource allocation."
    - name: "intervention_type"
      expr: intervention_type
      comment: "Type of intervention applied for effectiveness analysis."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag for critical barriers requiring immediate escalation."
    - name: "hcc_impact"
      expr: hcc_impact
      comment: "Flag for barriers with HCC/risk adjustment impact for revenue-linked prioritization."
    - name: "identification_source"
      expr: identification_source
      comment: "Source that identified the barrier (HRA, outreach, clinical) for detection channel analysis."
    - name: "identification_month"
      expr: DATE_TRUNC('month', identification_timestamp)
      comment: "Month barrier was identified for trend analysis."
  measures:
    - name: "total_barriers"
      expr: COUNT(1)
      comment: "Total care barrier records. Baseline for barrier management program scope."
    - name: "open_barriers"
      expr: COUNT(CASE WHEN barrier_status = 'open' THEN 1 END)
      comment: "Count of currently open barriers. Operational backlog metric for care management teams."
    - name: "barrier_resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN barrier_status = 'resolved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of barriers resolved. Measures care management intervention effectiveness."
    - name: "critical_barrier_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of barriers classified as critical. Drives escalation protocol and resource prioritization."
    - name: "avg_impact_score"
      expr: AVG(CAST(impact_score AS DOUBLE))
      comment: "Average barrier impact score. Quantifies the clinical and financial burden of unresolved barriers."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor associated with barriers. Links barrier resolution to risk revenue optimization."
    - name: "follow_up_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of barriers requiring follow-up. Drives coordinator workload planning and capacity management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_coordinator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks care coordinator capacity, caseload, and workforce metrics. Operational KPI for care management staffing adequacy and coordinator performance management."
  source: "`vibe_health_insurance_v1`.`care`.`coordinator`"
  dimensions:
    - name: "coordinator_status"
      expr: coordinator_status
      comment: "Current coordinator status (active, on-leave, terminated) for workforce availability analysis."
    - name: "role_type"
      expr: role_type
      comment: "Coordinator role type (RN, SW, CHW) for workforce composition analysis."
    - name: "specialty_area"
      expr: specialty_area
      comment: "Clinical specialty area for matching coordinator expertise to member needs."
    - name: "employment_status"
      expr: employment_status
      comment: "Employment status (full-time, part-time, contractor) for workforce cost analysis."
    - name: "assigned_lob"
      expr: assigned_lob
      comment: "Line of business assigned for LOB-level capacity planning."
    - name: "organization_unit"
      expr: organization_unit
      comment: "Organizational unit for departmental capacity analysis."
  measures:
    - name: "total_coordinators"
      expr: COUNT(1)
      comment: "Total care coordinator records. Baseline for workforce capacity analysis."
    - name: "active_coordinators"
      expr: COUNT(CASE WHEN coordinator_status = 'active' THEN 1 END)
      comment: "Count of active care coordinators. Primary staffing adequacy KPI."
    - name: "avg_caseload_weight"
      expr: AVG(CAST(caseload_weight AS DOUBLE))
      comment: "Average caseload weight per coordinator. Measures workload intensity and burnout risk."
    - name: "coordinators_at_capacity_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN coordinator_status = 'active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of coordinators in active status. Tracks workforce availability for member assignment."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_coordinator_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks care coordinator assignment patterns, caseload distribution, and assignment effectiveness. KPI for care management capacity planning and member-coordinator matching quality."
  source: "`vibe_health_insurance_v1`.`care`.`coordinator_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current assignment status (active, ended, transferred) for operational monitoring."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (primary, secondary, temporary) for assignment structure analysis."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method of assignment (auto, manual, referral) for process efficiency analysis."
    - name: "assignment_role"
      expr: assignment_role
      comment: "Role of coordinator in the assignment for team composition analysis."
    - name: "is_primary_coordinator"
      expr: is_primary_coordinator
      comment: "Flag for primary coordinator designation for accountability tracking."
    - name: "is_active"
      expr: is_active
      comment: "Flag for currently active assignments for point-in-time capacity analysis."
    - name: "assignment_month"
      expr: DATE_TRUNC('month', assignment_date)
      comment: "Month of assignment for trend and workload distribution analysis."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total coordinator assignment records. Baseline for assignment volume and coordinator utilization."
    - name: "active_assignments"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active coordinator assignments. Core capacity utilization KPI."
    - name: "primary_coordinator_assignment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_primary_coordinator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments designated as primary coordinator. Measures care accountability coverage."
    - name: "avg_caseload_weight"
      expr: AVG(CAST(caseload_weight AS DOUBLE))
      comment: "Average caseload weight per assignment. Measures workload intensity for staffing adequacy decisions."
    - name: "assignment_end_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN assignment_end_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments that have ended. Tracks assignment turnover and member continuity of care."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks care program portfolio, enrollment capacity utilization, and program performance. Strategic KPI for care management program investment and expansion decisions."
  source: "`vibe_health_insurance_v1`.`care`.`program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current program status (active, pilot, discontinued) for portfolio management."
    - name: "program_type"
      expr: program_type
      comment: "Type of care program (disease management, case management, wellness) for portfolio mix analysis."
    - name: "program_category"
      expr: program_category
      comment: "Program category for clinical domain classification."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business served by the program for LOB-level investment analysis."
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Program accreditation status for quality and regulatory compliance tracking."
    - name: "is_evidence_based"
      expr: is_evidence_based
      comment: "Flag for evidence-based programs for quality investment prioritization."
    - name: "program_start_year"
      expr: DATE_TRUNC('year', start_date)
      comment: "Year program launched for portfolio age and maturity analysis."
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total care program records. Baseline for program portfolio scope."
    - name: "active_programs"
      expr: COUNT(CASE WHEN program_status = 'active' THEN 1 END)
      comment: "Count of active care programs. Defines the operational program portfolio."
    - name: "total_enrollment_capacity"
      expr: SUM(CAST(enrollment_cap AS DOUBLE))
      comment: "Total enrollment capacity across all programs. Drives capacity planning and expansion decisions."
    - name: "total_current_enrollment"
      expr: SUM(CAST(enrollment_current AS DOUBLE))
      comment: "Total current enrollment across all programs. Measures program utilization."
    - name: "enrollment_capacity_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(enrollment_current AS DOUBLE)) / NULLIF(SUM(CAST(enrollment_cap AS DOUBLE)), 0), 2)
      comment: "Percentage of enrollment capacity utilized across programs. Drives capacity expansion investment decisions."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across programs. Links program portfolio to risk revenue contribution."
    - name: "evidence_based_program_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_evidence_based = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of programs that are evidence-based. Measures quality of care management program portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_program_obligation_mapping`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks care program regulatory obligation compliance status and mapping completeness. KPI for regulatory compliance governance and program accreditation readiness."
  source: "`vibe_health_insurance_v1`.`care`.`program_obligation_mapping`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (CMS, NCQA, state) for compliance domain analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status for regulatory risk monitoring."
    - name: "is_active"
      expr: is_active
      comment: "Flag for active obligation mappings for current compliance scope."
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month obligation mapping became effective for compliance timeline analysis."
  measures:
    - name: "total_obligation_mappings"
      expr: COUNT(1)
      comment: "Total program obligation mapping records. Baseline for regulatory compliance coverage."
    - name: "compliant_mapping_count"
      expr: COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END)
      comment: "Count of compliant obligation mappings. Measures regulatory compliance achievement."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of program obligation mappings in compliant status. Core regulatory compliance KPI for accreditation and CMS oversight."
    - name: "non_compliant_count"
      expr: COUNT(CASE WHEN compliance_status = 'non_compliant' THEN 1 END)
      comment: "Count of non-compliant obligation mappings. Drives corrective action planning and regulatory risk mitigation."
    - name: "active_mapping_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligation mappings that are currently active. Measures compliance program currency."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_program_accreditation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks care program accreditation status, levels, and expiration timelines. KPI for quality accreditation governance and regulatory compliance readiness."
  source: "`vibe_health_insurance_v1`.`care`.`program_accreditation`"
  dimensions:
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Current accreditation status (accredited, conditional, denied) for compliance monitoring."
    - name: "accreditation_type"
      expr: accreditation_type
      comment: "Type of accreditation (NCQA, URAC, JCAHO) for accreditation body analysis."
    - name: "accreditation_level"
      expr: accreditation_level
      comment: "Level of accreditation achieved for quality tier analysis."
    - name: "accreditation_body"
      expr: accreditation_body
      comment: "Accrediting organization for portfolio management by accreditor."
    - name: "is_current"
      expr: is_current
      comment: "Flag for currently active accreditations for compliance scope definition."
    - name: "accreditation_year"
      expr: DATE_TRUNC('year', accreditation_date)
      comment: "Year of accreditation for renewal cycle planning."
  measures:
    - name: "total_accreditations"
      expr: COUNT(1)
      comment: "Total program accreditation records. Baseline for accreditation portfolio scope."
    - name: "active_accreditations"
      expr: COUNT(CASE WHEN is_current = TRUE THEN 1 END)
      comment: "Count of currently active accreditations. Defines the accredited program portfolio."
    - name: "accreditation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN accreditation_status = 'accredited' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of programs with full accreditation status. Strategic quality KPI for market differentiation and regulatory compliance."
    - name: "expiring_accreditations_count"
      expr: COUNT(CASE WHEN expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND is_current = TRUE THEN 1 END)
      comment: "Count of accreditations expiring within 90 days. Drives renewal prioritization to prevent compliance gaps."
    - name: "conditional_accreditation_count"
      expr: COUNT(CASE WHEN accreditation_status = 'conditional' THEN 1 END)
      comment: "Count of programs with conditional accreditation. Identifies programs requiring remediation to achieve full accreditation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_measure_obligation_mapping`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks HEDIS measure regulatory obligation mapping completeness and compliance status. KPI for quality reporting regulatory governance and CMS submission readiness."
  source: "`vibe_health_insurance_v1`.`care`.`measure_obligation_mapping`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (CMS, NCQA, state) for compliance domain analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status for regulatory risk monitoring."
    - name: "is_active"
      expr: is_active
      comment: "Flag for active obligation mappings for current compliance scope."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for annual compliance cycle analysis."
  measures:
    - name: "total_measure_obligation_mappings"
      expr: COUNT(1)
      comment: "Total measure obligation mapping records. Baseline for quality reporting regulatory coverage."
    - name: "compliant_mapping_count"
      expr: COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END)
      comment: "Count of compliant measure obligation mappings. Measures regulatory compliance achievement for quality reporting."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measure obligation mappings in compliant status. Core regulatory compliance KPI for CMS quality reporting."
    - name: "active_mapping_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of active measure obligation mappings. Defines the current regulatory compliance scope for quality reporting."
    - name: "non_compliant_count"
      expr: COUNT(CASE WHEN compliance_status = 'non_compliant' THEN 1 END)
      comment: "Count of non-compliant measure obligation mappings. Drives corrective action for CMS quality reporting compliance."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_gap_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks care gap regulatory obligation compliance and resolution status. KPI for quality improvement regulatory governance and gap closure accountability."
  source: "`vibe_health_insurance_v1`.`care`.`gap_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation driving the gap for compliance domain analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status for regulatory risk monitoring."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the gap obligation for closure tracking."
    - name: "is_resolved"
      expr: is_resolved
      comment: "Flag for resolved gap obligations for completion rate analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for intervention sequencing and resource allocation."
    - name: "due_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month obligation is due for deadline management and escalation planning."
  measures:
    - name: "total_gap_obligations"
      expr: COUNT(1)
      comment: "Total gap obligation records. Baseline for regulatory compliance gap management scope."
    - name: "resolved_obligation_count"
      expr: COUNT(CASE WHEN is_resolved = TRUE THEN 1 END)
      comment: "Count of resolved gap obligations. Measures regulatory compliance gap closure achievement."
    - name: "resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_resolved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gap obligations resolved. Core regulatory compliance KPI for quality improvement governance."
    - name: "compliant_obligation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gap obligations in compliant status. Measures regulatory compliance achievement for gap management."
    - name: "overdue_obligation_count"
      expr: COUNT(CASE WHEN is_resolved = FALSE AND due_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of overdue unresolved gap obligations. Drives escalation and corrective action for regulatory risk mitigation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_population_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks population segment size, cost distribution, and risk tier composition. Strategic KPI for population health investment targeting and actuarial planning."
  source: "`vibe_health_insurance_v1`.`care`.`population_segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of population segment for classification and analysis."
    - name: "segment_code"
      expr: segment_code
      comment: "Segment code for system integration and reporting consistency."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier of the segment for population stratification analysis."
    - name: "population_segment_status"
      expr: population_segment_status
      comment: "Current segment status for active population scope definition."
    - name: "recommended_care_program"
      expr: recommended_care_program
      comment: "Recommended care program for the segment for program targeting analysis."
    - name: "is_default"
      expr: is_default
      comment: "Flag for default segments for baseline population analysis."
    - name: "effective_start_year"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year segment became effective for trend analysis."
  measures:
    - name: "total_segments"
      expr: COUNT(1)
      comment: "Total population segment records. Baseline for segmentation model scope."
    - name: "total_population_count"
      expr: SUM(CAST(population_count AS DOUBLE))
      comment: "Total members across all population segments. Measures population health program reach."
    - name: "avg_pmpm_cost_band"
      expr: AVG(CAST(pmpm_cost_band AS DOUBLE))
      comment: "Average PMPM cost band across segments. Core actuarial metric for premium adequacy and medical cost forecasting."
    - name: "avg_average_pmpm_cost"
      expr: AVG(CAST(average_pmpm_cost AS DOUBLE))
      comment: "Average PMPM cost across population segments. Drives medical cost management and care program ROI analysis."
    - name: "total_segment_population"
      expr: SUM(CAST(population_count AS DOUBLE))
      comment: "Total population count across all segments. Measures population health program coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_dme_coordination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks DME (Durable Medical Equipment) coordination volume, prior authorization compliance, and delivery performance. Operational KPI for post-acute supply chain and cost management."
  source: "`vibe_health_insurance_v1`.`care`.`dme_coordination`"
  dimensions:
    - name: "coordination_status"
      expr: coordination_status
      comment: "Current DME coordination status for operational monitoring."
    - name: "dme_type"
      expr: dme_type
      comment: "Type of DME equipment for utilization and cost analysis by equipment category."
    - name: "prior_authorization_required"
      expr: prior_authorization_required
      comment: "Flag for DME requiring prior authorization for compliance monitoring."
    - name: "prior_authorization_status"
      expr: prior_authorization_status
      comment: "Prior authorization status for approval rate analysis."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level for prioritization and turnaround time analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Compliance flag for regulatory adherence monitoring."
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month DME was ordered for trend and volume analysis."
  measures:
    - name: "total_dme_coordinations"
      expr: COUNT(1)
      comment: "Total DME coordination records. Baseline for post-acute supply chain volume."
    - name: "prior_auth_required_count"
      expr: COUNT(CASE WHEN prior_authorization_required = TRUE THEN 1 END)
      comment: "Count of DME orders requiring prior authorization. Drives PA workflow capacity planning."
    - name: "prior_auth_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN prior_authorization_status = 'approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN prior_authorization_required = TRUE THEN 1 END), 0), 2)
      comment: "Prior authorization approval rate for DME. Measures medical necessity review effectiveness."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DME coordinations meeting compliance requirements. Regulatory adherence KPI."
    - name: "delivered_count"
      expr: COUNT(CASE WHEN delivery_date IS NOT NULL THEN 1 END)
      comment: "Count of DME orders with confirmed delivery. Measures supply chain fulfillment effectiveness."
    - name: "delivery_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DME orders with confirmed delivery. Measures post-acute supply chain performance."
$$;