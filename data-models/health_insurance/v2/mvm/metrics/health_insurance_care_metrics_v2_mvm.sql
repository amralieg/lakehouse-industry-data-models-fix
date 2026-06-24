-- Metric views for domain: care | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 01:44:05

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for care program enrollment — tracks active enrollment volume, risk profile, acuity distribution, and program tier mix to guide care management resource allocation and population health investment decisions."
  source: "`vibe_health_insurance_v1`.`care`.`care_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the care enrollment (e.g., Active, Disenrolled, Pending) — primary filter for operational dashboards."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of care enrollment (e.g., Voluntary, Mandatory, Referral) — used to segment enrollment mix and evaluate outreach effectiveness."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Channel or system that originated the enrollment (e.g., Claims-triggered, Provider referral, Member self-enroll) — informs channel ROI analysis."
    - name: "program_tier"
      expr: program_tier
      comment: "Tier level of the care program the member is enrolled in (e.g., Tier 1 High-Touch, Tier 2 Standard) — drives resource intensity and cost planning."
    - name: "acuity_level"
      expr: acuity_level
      comment: "Clinical acuity classification of the enrolled member — used to stratify population risk and prioritize care manager workload."
    - name: "consent_status"
      expr: consent_status
      comment: "Member consent status for care management participation — critical for compliance and outreach eligibility."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the enrollment became effective — enables trend analysis of enrollment volume over time."
    - name: "disenrollment_month"
      expr: DATE_TRUNC('MONTH', disenrollment_date)
      comment: "Month the member disenrolled — used to track attrition trends and identify seasonal or program-driven churn."
  measures:
    - name: "total_active_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'Active' THEN care_enrollment_id END)
      comment: "Count of currently active care enrollments — primary volume KPI for care management capacity planning and program reach."
    - name: "total_enrollments"
      expr: COUNT(care_enrollment_id)
      comment: "Total count of all care enrollments regardless of status — baseline denominator for enrollment rate and conversion calculations."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average member risk score across enrollments — tracks whether the program is successfully targeting high-risk members; rising scores indicate appropriate targeting."
    - name: "avg_hcc_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average HCC (Hierarchical Condition Category) score for enrolled members — directly tied to risk-adjusted revenue and capitation rate accuracy."
    - name: "high_risk_enrollment_count"
      expr: COUNT(CASE WHEN risk_score > 2.0 THEN care_enrollment_id END)
      comment: "Count of enrollments with risk score above 2.0 — identifies the highest-acuity cohort requiring intensive care management resources."
    - name: "consent_obtained_rate_numerator"
      expr: COUNT(CASE WHEN consent_status = 'Obtained' THEN care_enrollment_id END)
      comment: "Numerator for consent rate: count of enrollments where member consent has been obtained. Divide by total_enrollments in BI to compute consent rate — low consent rates block outreach and inflate compliance risk."
    - name: "disenrollment_count"
      expr: COUNT(CASE WHEN enrollment_status = 'Disenrolled' THEN care_enrollment_id END)
      comment: "Count of disenrolled members — tracks program attrition; high disenrollment signals engagement or eligibility issues requiring intervention."
    - name: "sum_risk_score"
      expr: SUM(CAST(risk_score AS DOUBLE))
      comment: "Sum of risk scores across all enrollments — used with total_enrollments to compute average risk score at any aggregation level in BI."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and quality KPIs for care plans — measures plan volume, high-risk coverage, FHIR compliance status, and plan type distribution to support care coordination quality and regulatory reporting."
  source: "`vibe_health_insurance_v1`.`care`.`care_plan`"
  dimensions:
    - name: "care_plan_status"
      expr: care_plan_status
      comment: "Current lifecycle status of the care plan (e.g., Active, Completed, Cancelled) — primary operational filter."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of care plan (e.g., Chronic Disease, Preventive, Transitional Care) — used to analyze plan mix and resource allocation by clinical category."
    - name: "fhir_status"
      expr: fhir_status
      comment: "FHIR interoperability status of the care plan — tracks regulatory compliance with CMS interoperability mandates."
    - name: "fhir_intent"
      expr: fhir_intent
      comment: "FHIR intent classification (e.g., proposal, plan, order) — used for clinical workflow and interoperability quality reporting."
    - name: "high_risk_flag"
      expr: CAST(high_risk_flag AS STRING)
      comment: "Indicates whether the care plan is flagged as high-risk — enables segmentation of high-risk plan volume for executive risk dashboards."
    - name: "privacy_consent_flag"
      expr: CAST(privacy_consent_flag AS STRING)
      comment: "Indicates whether privacy consent has been recorded on the care plan — critical for HIPAA compliance monitoring."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the care plan became effective — enables trend analysis of new plan creation volume."
    - name: "barriers_to_care"
      expr: barriers_to_care
      comment: "Documented barriers to care (e.g., Transportation, Financial, Language) — used to identify systemic gaps and target social determinants of health interventions."
  measures:
    - name: "total_active_care_plans"
      expr: COUNT(CASE WHEN care_plan_status = 'Active' THEN care_plan_id END)
      comment: "Count of currently active care plans — primary volume KPI for care coordination capacity and program reach."
    - name: "total_care_plans"
      expr: COUNT(care_plan_id)
      comment: "Total count of all care plans — baseline denominator for plan completion rate and high-risk coverage calculations."
    - name: "high_risk_plan_count"
      expr: COUNT(CASE WHEN high_risk_flag = TRUE THEN care_plan_id END)
      comment: "Count of care plans flagged as high-risk — directly informs resource prioritization and executive risk exposure reporting."
    - name: "fhir_compliant_plan_count"
      expr: COUNT(CASE WHEN fhir_status IS NOT NULL AND fhir_status != '' THEN care_plan_id END)
      comment: "Count of care plans with a populated FHIR status — proxy for interoperability compliance; low counts signal CMS mandate risk."
    - name: "privacy_consent_obtained_count"
      expr: COUNT(CASE WHEN privacy_consent_flag = TRUE THEN care_plan_id END)
      comment: "Count of care plans with privacy consent recorded — HIPAA compliance KPI; gaps trigger regulatory and audit risk."
    - name: "completed_plan_count"
      expr: COUNT(CASE WHEN care_plan_status = 'Completed' THEN care_plan_id END)
      comment: "Count of completed care plans — measures care coordination throughput and program effectiveness; low completion rates signal engagement or clinical barriers."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_condition_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Population health KPIs derived from the condition registry — tracks chronic condition prevalence, risk adjustment scores, and condition identification quality to support clinical program targeting and RAF revenue optimization."
  source: "`vibe_health_insurance_v1`.`care`.`condition_registry`"
  dimensions:
    - name: "condition_category"
      expr: condition_category
      comment: "Clinical category of the condition (e.g., Cardiovascular, Diabetes, Behavioral Health) — primary grouping for population health program targeting."
    - name: "condition_code"
      expr: condition_code
      comment: "Standardized condition code (ICD-10 or SNOMED) — enables drill-down to specific diagnoses for clinical and risk adjustment analysis."
    - name: "is_chronic"
      expr: CAST(is_chronic AS STRING)
      comment: "Indicates whether the condition is classified as chronic — used to segment chronic vs. acute condition burden for care program eligibility."
    - name: "active_flag"
      expr: CAST(active_flag AS STRING)
      comment: "Indicates whether the condition record is currently active — primary filter for active disease burden analysis."
    - name: "severity"
      expr: severity
      comment: "Clinical severity classification of the condition — used to prioritize high-severity populations for intensive care management."
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Confirmation status of the condition (e.g., Confirmed, Suspected, Refuted) — filters for clinically validated conditions in risk adjustment reporting."
    - name: "identification_method"
      expr: identification_method
      comment: "Method by which the condition was identified (e.g., Claims, EHR, Lab) — used to assess data completeness and source reliability."
    - name: "population_segment"
      expr: population_segment
      comment: "Population segment associated with the condition record — enables stratified analysis by member cohort for program design."
    - name: "risk_adjustment_flag"
      expr: CAST(risk_adjustment_flag AS STRING)
      comment: "Indicates whether the condition is flagged for risk adjustment — directly tied to HCC capture rate and RAF revenue."
    - name: "onset_year"
      expr: YEAR(onset_date)
      comment: "Year the condition onset was recorded — enables longitudinal disease burden trend analysis."
  measures:
    - name: "total_active_conditions"
      expr: COUNT(CASE WHEN active_flag = TRUE THEN condition_registry_id END)
      comment: "Count of active condition records — measures total active disease burden across the population; drives care program sizing and clinical resource planning."
    - name: "chronic_condition_count"
      expr: COUNT(CASE WHEN is_chronic = TRUE THEN condition_registry_id END)
      comment: "Count of chronic condition records — primary KPI for chronic disease management program targeting and capitation rate justification."
    - name: "risk_adjustment_eligible_count"
      expr: COUNT(CASE WHEN risk_adjustment_flag = TRUE THEN condition_registry_id END)
      comment: "Count of conditions flagged for risk adjustment — directly tied to HCC capture completeness and RAF revenue optimization; gaps represent recoverable revenue."
    - name: "avg_raf_score"
      expr: AVG(CAST(raf_score AS DOUBLE))
      comment: "Average Risk Adjustment Factor (RAF) score across condition records — tracks risk-adjusted revenue potential; declining scores signal under-coding or population health improvement."
    - name: "sum_raf_score"
      expr: SUM(CAST(raf_score AS DOUBLE))
      comment: "Total RAF score across all condition records — aggregate risk adjustment revenue signal used in financial forecasting and capitation negotiations."
    - name: "confirmed_condition_count"
      expr: COUNT(CASE WHEN confirmation_status = 'Confirmed' THEN condition_registry_id END)
      comment: "Count of clinically confirmed conditions — quality KPI for condition registry accuracy; low confirmation rates indicate data quality issues that inflate risk scores."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_gap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HEDIS and clinical gap closure KPIs — tracks open gap volume, critical gap exposure, closure rates, and risk scores to drive quality improvement programs and Star Ratings performance."
  source: "`vibe_health_insurance_v1`.`care`.`gap`"
  dimensions:
    - name: "gap_status"
      expr: gap_status
      comment: "Current status of the care gap (e.g., Open, Closed, In Progress) — primary operational filter for gap closure workflow management."
    - name: "gap_type"
      expr: gap_type
      comment: "Type of care gap (e.g., Preventive, Chronic, Medication Adherence) — used to prioritize gap closure programs by clinical category."
    - name: "clinical_category"
      expr: clinical_category
      comment: "Clinical domain of the gap (e.g., Cardiovascular, Diabetes, Behavioral Health) — enables program-level gap analysis and resource targeting."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the gap (e.g., High, Medium, Low) — used to triage care coordinator workload and focus on highest-impact closures."
    - name: "is_critical"
      expr: CAST(is_critical AS STRING)
      comment: "Indicates whether the gap is classified as critical — executive-level flag for gaps with the highest Star Rating or clinical risk impact."
    - name: "closure_method"
      expr: closure_method
      comment: "Method used to close the gap (e.g., Claim, Supplemental Data, Manual) — used to evaluate closure channel effectiveness and data completeness."
    - name: "documentation_status"
      expr: documentation_status
      comment: "Documentation completeness status for the gap — tracks evidence submission quality for HEDIS audit readiness."
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the gap was opened — enables trend analysis of gap identification volume and seasonal patterns."
    - name: "close_month"
      expr: DATE_TRUNC('MONTH', close_date)
      comment: "Month the gap was closed — used to measure closure velocity and identify bottlenecks in the gap closure workflow."
  measures:
    - name: "total_open_gaps"
      expr: COUNT(CASE WHEN gap_status = 'Open' THEN gap_id END)
      comment: "Count of currently open care gaps — primary KPI for quality program workload and Star Ratings risk exposure; high open gap counts directly depress HEDIS scores."
    - name: "total_gaps"
      expr: COUNT(gap_id)
      comment: "Total count of all gaps regardless of status — baseline denominator for gap closure rate calculations."
    - name: "critical_open_gap_count"
      expr: COUNT(CASE WHEN is_critical = TRUE AND gap_status = 'Open' THEN gap_id END)
      comment: "Count of open gaps classified as critical — highest-priority executive KPI for Star Ratings and clinical risk; each unresolved critical gap has direct revenue and quality implications."
    - name: "closed_gap_count"
      expr: COUNT(CASE WHEN gap_status = 'Closed' THEN gap_id END)
      comment: "Count of closed gaps — measures quality program throughput and care coordinator effectiveness; used as numerator for gap closure rate."
    - name: "avg_gap_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score associated with open gaps — tracks whether gap closure efforts are focused on the highest-risk members; low scores indicate misaligned prioritization."
    - name: "avg_measure_target_value"
      expr: AVG(CAST(measure_target_value AS DOUBLE))
      comment: "Average HEDIS measure target value across gaps — provides context for how far the population is from benchmark performance thresholds."
    - name: "distinct_members_with_open_gaps"
      expr: COUNT(DISTINCT CASE WHEN gap_status = 'Open' THEN policy_id END)
      comment: "Count of unique members with at least one open gap — measures breadth of quality gap exposure across the membership; drives outreach prioritization."
    - name: "high_priority_open_gap_count"
      expr: COUNT(CASE WHEN priority_level = 'High' AND gap_status = 'Open' THEN gap_id END)
      comment: "Count of high-priority open gaps — operational KPI for care coordinator daily workqueue management and escalation tracking."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_hedis_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HEDIS performance measurement KPIs — tracks numerator/denominator compliance, measure scores, exclusion rates, and compliance status to drive Star Ratings improvement and regulatory quality reporting."
  source: "`vibe_health_insurance_v1`.`care`.`hedis_result`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "HEDIS compliance status for the result record (e.g., Compliant, Non-Compliant, Excluded) — primary dimension for quality performance reporting."
    - name: "measure_category"
      expr: measure_category
      comment: "Clinical category of the HEDIS measure (e.g., Effectiveness of Care, Access, Utilization) — used to analyze performance by NCQA domain."
    - name: "measure_type"
      expr: measure_type
      comment: "Type of HEDIS measure (e.g., Rate, Ratio, Continuous Variable) — used to apply correct aggregation logic in performance analysis."
    - name: "measurement_year"
      expr: measurement_year
      comment: "Measurement year for the HEDIS result — enables year-over-year performance trend analysis and benchmark comparison."
    - name: "collection_method"
      expr: collection_method
      comment: "Data collection method used (e.g., Administrative, Hybrid, Survey) — used to assess data source reliability and NCQA audit readiness."
    - name: "data_source"
      expr: data_source
      comment: "Source system providing the HEDIS result data (e.g., Claims, EHR, Lab) — used to evaluate data completeness and identify supplemental data opportunities."
    - name: "is_excluded"
      expr: CAST(is_excluded AS STRING)
      comment: "Indicates whether the member was excluded from the HEDIS measure denominator — tracks exclusion rate which affects measure denominators and reported rates."
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_timestamp)
      comment: "Month the HEDIS result was recorded — enables trend analysis of result submission volume and data lag monitoring."
  measures:
    - name: "total_hedis_results"
      expr: COUNT(hedis_result_id)
      comment: "Total count of HEDIS result records — baseline volume KPI for measurement completeness and data pipeline monitoring."
    - name: "numerator_met_count"
      expr: COUNT(CASE WHEN numerator_criteria_met = TRUE THEN hedis_result_id END)
      comment: "Count of results where the HEDIS numerator criteria were met — directly measures compliant care delivery; this is the primary driver of HEDIS rates and Star Ratings."
    - name: "denominator_met_count"
      expr: COUNT(CASE WHEN denominator_criteria_met = TRUE THEN hedis_result_id END)
      comment: "Count of results where the HEDIS denominator criteria were met — defines the eligible population for each measure; used as denominator in HEDIS rate calculations."
    - name: "excluded_member_count"
      expr: COUNT(CASE WHEN is_excluded = TRUE THEN hedis_result_id END)
      comment: "Count of members excluded from HEDIS measure denominators — high exclusion rates can artificially inflate reported rates; monitored for NCQA audit compliance."
    - name: "avg_measure_score"
      expr: AVG(CAST(measure_score AS DOUBLE))
      comment: "Average HEDIS measure score across all result records — composite quality performance indicator; directly tied to Star Ratings, bonus payments, and regulatory standing."
    - name: "compliant_result_count"
      expr: COUNT(CASE WHEN compliance_status = 'Compliant' THEN hedis_result_id END)
      comment: "Count of compliant HEDIS results — numerator for overall compliance rate; used to track quality improvement program effectiveness over time."
    - name: "sum_measure_score"
      expr: SUM(CAST(measure_score AS DOUBLE))
      comment: "Sum of all HEDIS measure scores — used with total_hedis_results to compute weighted average scores at any aggregation level in BI."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_member_risk_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member risk stratification KPIs — tracks risk tier distribution, HCC scores, PMPM cost bands, and chronic condition flags to support population health program targeting, capitation rate setting, and care management investment decisions."
  source: "`vibe_health_insurance_v1`.`care`.`member_risk_tier`"
  dimensions:
    - name: "tier_name"
      expr: tier_name
      comment: "Name of the risk tier (e.g., High Risk, Rising Risk, Low Risk) — primary stratification dimension for population health program targeting."
    - name: "tier_band"
      expr: tier_band
      comment: "Numeric or categorical band of the risk tier — enables ordered segmentation of the population by risk intensity."
    - name: "tier_code"
      expr: tier_code
      comment: "Standardized code for the risk tier — used for system integration and cross-program tier mapping."
    - name: "segment_name"
      expr: segment_name
      comment: "Population segment name associated with the risk tier — used to analyze risk distribution across clinical or demographic cohorts."
    - name: "demographic_group"
      expr: demographic_group
      comment: "Demographic group of the member (e.g., age band, gender) — enables equity analysis of risk tier distribution across member populations."
    - name: "chronic_condition_flag"
      expr: CAST(chronic_condition_flag AS STRING)
      comment: "Indicates whether the member has a chronic condition — used to segment chronic vs. non-chronic risk tier populations for program eligibility."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign the risk tier (e.g., Predictive Model, Clinical Review, Claims-based) — used to evaluate model performance and tier assignment consistency."
    - name: "model_type"
      expr: model_type
      comment: "Predictive model type used for risk tier assignment — tracks model version adoption and enables A/B comparison of risk stratification approaches."
    - name: "is_current"
      expr: CAST(is_current AS STRING)
      comment: "Indicates whether this is the current active risk tier assignment for the member — primary filter for point-in-time population risk analysis."
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month the risk tier was assigned — enables trend analysis of tier migration patterns and model refresh cycles."
  measures:
    - name: "total_current_risk_assignments"
      expr: COUNT(CASE WHEN is_current = TRUE THEN member_risk_tier_id END)
      comment: "Count of current active risk tier assignments — measures total stratified population size; baseline for program capacity planning and per-tier resource allocation."
    - name: "high_risk_member_count"
      expr: COUNT(CASE WHEN is_current = TRUE AND chronic_condition_flag = TRUE THEN member_risk_tier_id END)
      comment: "Count of current members with chronic condition flag set — proxy for high-complexity population requiring intensive care management; drives staffing and program investment decisions."
    - name: "avg_hcc_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average HCC score across risk tier assignments — tracks population-level risk-adjusted revenue potential; used in capitation rate negotiations and financial forecasting."
    - name: "avg_pmpm_cost_band"
      expr: AVG(CAST(pmpm_cost_band AS DOUBLE))
      comment: "Average Per Member Per Month (PMPM) cost band across risk assignments — directly informs medical cost trend analysis and care management ROI calculations."
    - name: "avg_risk_factor_weight"
      expr: AVG(CAST(risk_factor_weight AS DOUBLE))
      comment: "Average risk factor weight across tier assignments — measures the relative clinical complexity of the stratified population; used to validate model calibration."
    - name: "sum_hcc_score"
      expr: SUM(CAST(hcc_score AS DOUBLE))
      comment: "Total HCC score across all risk assignments — aggregate risk-adjusted revenue signal used in financial planning and capitation adequacy assessments."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care program portfolio KPIs — tracks program enrollment capacity utilization, evidence-based program adoption, and program status distribution to support program investment, expansion, and retirement decisions."
  source: "`vibe_health_insurance_v1`.`care`.`program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current operational status of the care program (e.g., Active, Inactive, Pilot) — primary filter for active program portfolio analysis."
    - name: "program_type"
      expr: program_type
      comment: "Type of care program (e.g., Disease Management, Case Management, Wellness) — used to analyze program mix and investment allocation by category."
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Accreditation status of the program (e.g., Accredited, Pending, Expired) — regulatory compliance dimension; unaccredited programs carry audit and contract risk."
    - name: "is_evidence_based"
      expr: CAST(is_evidence_based AS STRING)
      comment: "Indicates whether the program is evidence-based — used to track adoption of clinically validated programs; regulators and accreditors favor evidence-based program portfolios."
    - name: "target_population"
      expr: target_population
      comment: "Target population for the program (e.g., Diabetic members, High-risk elderly) — used to align program capacity with population health strategy."
    - name: "program_start_year"
      expr: YEAR(start_date)
      comment: "Year the program launched — enables cohort analysis of program performance by vintage and supports program lifecycle management."
  measures:
    - name: "total_active_programs"
      expr: COUNT(CASE WHEN program_status = 'Active' THEN program_id END)
      comment: "Count of currently active care programs — measures program portfolio breadth; used to assess organizational care management capability and regulatory compliance coverage."
    - name: "total_enrollment_capacity"
      expr: SUM(CAST(enrollment_cap AS DOUBLE))
      comment: "Total enrollment capacity across all programs — measures maximum program reach; compared against current enrollment to identify capacity constraints or underutilization."
    - name: "total_current_enrollment"
      expr: SUM(CAST(enrollment_current AS DOUBLE))
      comment: "Total current enrollment across all programs — measures actual program reach; primary KPI for program utilization and population health coverage."
    - name: "avg_enrollment_utilization_pct"
      expr: AVG(CAST(enrollment_current AS DOUBLE) / NULLIF(CAST(enrollment_cap AS DOUBLE), 0)) * 100
      comment: "Average enrollment utilization rate (current/capacity) across programs — identifies over-capacity programs at risk of quality degradation and under-utilized programs with expansion opportunity."
    - name: "evidence_based_program_count"
      expr: COUNT(CASE WHEN is_evidence_based = TRUE THEN program_id END)
      comment: "Count of evidence-based programs in the portfolio — tracks clinical quality of the program portfolio; accreditors (NCQA, URAC) require evidence-based program adoption for health plan accreditation."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across programs — measures the risk-adjusted financial impact of the program portfolio; used in capitation and value-based contract negotiations."
    - name: "programs_at_capacity_count"
      expr: COUNT(CASE WHEN enrollment_current >= enrollment_cap AND program_status = 'Active' THEN program_id END)
      comment: "Count of active programs at or above enrollment capacity — operational risk KPI; programs at capacity cannot accept new high-risk members, creating care access gaps."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`care_plan_goal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care plan goal attainment KPIs — tracks goal completion rates, target vs. actual value achievement, compliance, and risk scores to measure care coordination effectiveness and member health outcome improvement."
  source: "`vibe_health_insurance_v1`.`care`.`plan_goal`"
  dimensions:
    - name: "plan_goal_status"
      expr: plan_goal_status
      comment: "Current status of the care plan goal (e.g., Active, Achieved, Not Met, Cancelled) — primary dimension for goal attainment analysis."
    - name: "goal_category"
      expr: goal_category
      comment: "Clinical or behavioral category of the goal (e.g., Medication Adherence, Weight Management, Blood Pressure Control) — used to analyze goal mix and identify high-failure categories."
    - name: "goal_name"
      expr: goal_name
      comment: "Name of the care plan goal — enables drill-down analysis to specific goal types for clinical program refinement."
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement used to track goal progress (e.g., Numeric, Boolean, Qualitative) — used to segment goals by measurability and data quality."
    - name: "priority"
      expr: priority
      comment: "Priority level of the goal (e.g., High, Medium, Low) — used to weight goal attainment analysis toward highest-impact clinical objectives."
    - name: "compliance_flag"
      expr: CAST(compliance_flag AS STRING)
      comment: "Indicates whether the member is compliant with the goal — primary compliance KPI dimension for care coordinator performance and member engagement analysis."
    - name: "target_month"
      expr: DATE_TRUNC('MONTH', target_date)
      comment: "Month the goal is targeted for completion — enables pipeline analysis of upcoming goal deadlines and proactive intervention planning."
  measures:
    - name: "total_active_goals"
      expr: COUNT(CASE WHEN plan_goal_status = 'Active' THEN plan_goal_id END)
      comment: "Count of currently active care plan goals — measures care coordination workload and program engagement depth; used to assess coordinator capacity."
    - name: "achieved_goal_count"
      expr: COUNT(CASE WHEN plan_goal_status = 'Achieved' THEN plan_goal_id END)
      comment: "Count of achieved care plan goals — primary outcome KPI for care coordination effectiveness; directly measures member health improvement program success."
    - name: "total_goals"
      expr: COUNT(plan_goal_id)
      comment: "Total count of all care plan goals — baseline denominator for goal achievement rate calculations."
    - name: "compliant_goal_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN plan_goal_id END)
      comment: "Count of goals where the member is compliant — measures member engagement and adherence; low compliance rates trigger care coordinator outreach and program redesign."
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual measured value across goals — tracks clinical outcome achievement; compared against avg_target_value to assess population-level goal attainment."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across goals — provides the benchmark for avg_actual_value comparison; used to assess whether goals are appropriately ambitious or systematically unachievable."
    - name: "avg_goal_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score associated with care plan goals — measures whether goal-setting is appropriately targeting high-risk members; low scores indicate goals are concentrated in low-risk populations."
    - name: "high_priority_goal_count"
      expr: COUNT(CASE WHEN priority = 'High' THEN plan_goal_id END)
      comment: "Count of high-priority care plan goals — used to assess clinical focus intensity and ensure care coordinators are prioritizing the most impactful interventions."
$$;