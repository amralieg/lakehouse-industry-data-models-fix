-- Metric views for domain: care | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 18:36:19

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_gap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care gap analytics measuring quality measure compliance, gap closure rates, and risk-stratified gap management for HEDIS/Stars performance improvement."
  source: "`health_insurance_ecm`.`care`.`gap`"
  dimensions:
    - name: "gap_type"
      expr: gap_type
      comment: "Type of care gap (e.g., preventive screening, chronic condition management, immunization)."
    - name: "gap_status"
      expr: gap_status
      comment: "Current status of the care gap (open, closed, pending, excluded)."
    - name: "clinical_category"
      expr: clinical_category
      comment: "Clinical domain or category the gap belongs to (e.g., diabetes, cardiovascular, behavioral health)."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the gap for outreach and intervention targeting."
    - name: "is_critical"
      expr: CAST(is_critical AS STRING)
      comment: "Whether the gap is flagged as critical for member health or regulatory compliance."
    - name: "closure_method"
      expr: closure_method
      comment: "Method by which the gap was closed (e.g., claim, chart review, supplemental data)."
    - name: "hedis_measure_code"
      expr: hedis_measure_code
      comment: "HEDIS measure code associated with this care gap for quality reporting alignment."
    - name: "documentation_status"
      expr: documentation_status
      comment: "Status of clinical documentation supporting gap closure."
    - name: "gap_open_year"
      expr: YEAR(open_date)
      comment: "Year the care gap was identified/opened for trend analysis."
    - name: "gap_open_month"
      expr: DATE_TRUNC('month', open_date)
      comment: "Month the care gap was opened for seasonal and operational trending."
  measures:
    - name: "total_care_gaps"
      expr: COUNT(1)
      comment: "Total number of care gaps identified across the member population."
    - name: "open_care_gaps"
      expr: SUM(CASE WHEN gap_status = 'open' THEN 1 ELSE 0 END)
      comment: "Count of currently open care gaps requiring intervention or outreach."
    - name: "closed_care_gaps"
      expr: SUM(CASE WHEN gap_status = 'closed' THEN 1 ELSE 0 END)
      comment: "Count of care gaps that have been successfully closed."
    - name: "critical_open_gaps"
      expr: SUM(CASE WHEN is_critical = TRUE AND gap_status = 'open' THEN 1 ELSE 0 END)
      comment: "Count of critical open gaps requiring urgent intervention to mitigate member risk or regulatory exposure."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of members with care gaps, indicating population acuity for resource prioritization."
    - name: "avg_days_to_close"
      expr: AVG(CAST(DATEDIFF(actual_resolution_date, open_date) AS DOUBLE))
      comment: "Average number of days from gap identification to resolution, measuring operational efficiency of gap closure workflows."
    - name: "distinct_members_with_gaps"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct count of members with at least one care gap, measuring population reach of quality gaps."
    - name: "avg_measure_target_value"
      expr: AVG(CAST(measure_target_value AS DOUBLE))
      comment: "Average target value across care gap measures, representing benchmark performance expectations."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_hedis_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HEDIS quality measure results tracking numerator/denominator compliance, measure scores, and exclusion rates for Stars rating and regulatory reporting."
  source: "`health_insurance_ecm`.`care`.`hedis_result`"
  dimensions:
    - name: "measurement_year"
      expr: measurement_year
      comment: "HEDIS measurement year for annual quality performance comparison."
    - name: "measure_category"
      expr: measure_category
      comment: "Category of the HEDIS measure (e.g., effectiveness of care, access/availability, experience of care)."
    - name: "measure_type"
      expr: measure_type
      comment: "Type classification of the measure (e.g., process, outcome, structural)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Whether the member met compliance criteria for the measure."
    - name: "collection_method"
      expr: collection_method
      comment: "Data collection method used (e.g., administrative, hybrid, ECDS)."
    - name: "data_source"
      expr: data_source
      comment: "Source of data used for measure evaluation (claims, EHR, supplemental)."
    - name: "is_excluded"
      expr: CAST(is_excluded AS STRING)
      comment: "Whether the member was excluded from the measure denominator."
    - name: "measure_version"
      expr: measure_version
      comment: "Version of the HEDIS measure specification applied."
  measures:
    - name: "total_results"
      expr: COUNT(1)
      comment: "Total number of HEDIS measure result evaluations performed."
    - name: "numerator_compliant_count"
      expr: SUM(CASE WHEN numerator_criteria_met = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members meeting numerator criteria, representing successful quality measure compliance."
    - name: "denominator_eligible_count"
      expr: SUM(CASE WHEN denominator_criteria_met = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members meeting denominator eligibility criteria for the measure."
    - name: "excluded_count"
      expr: SUM(CASE WHEN is_excluded = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members excluded from measure evaluation due to valid exclusion criteria."
    - name: "avg_measure_score"
      expr: AVG(CAST(measure_score AS DOUBLE))
      comment: "Average measure score across evaluated members, indicating overall quality performance level."
    - name: "distinct_members_evaluated"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct members evaluated for HEDIS measures, representing quality measurement population reach."
    - name: "distinct_providers_evaluated"
      expr: COUNT(DISTINCT provider_id)
      comment: "Distinct providers associated with HEDIS results for provider-level quality accountability."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care management enrollment analytics tracking program participation, acuity distribution, and enrollment lifecycle for population health management."
  source: "`health_insurance_ecm`.`care`.`care_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status in the care management program (active, disenrolled, pending)."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (voluntary, auto-enrolled, referred, mandated)."
    - name: "acuity_level"
      expr: acuity_level
      comment: "Member acuity level determining intensity of care management services."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source that triggered the care enrollment (referral, predictive model, claims trigger, HRA)."
    - name: "consent_status"
      expr: consent_status
      comment: "Member consent status for participation in care management programs."
    - name: "program_tier"
      expr: program_tier
      comment: "Tier of the care management program (e.g., complex, moderate, wellness)."
    - name: "status_reason"
      expr: status_reason
      comment: "Reason for the current enrollment status, especially for disenrollments."
    - name: "enrollment_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month of enrollment start for cohort and trend analysis."
    - name: "enrollment_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year of enrollment start for annual program performance review."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total care management enrollment records for program volume tracking."
    - name: "active_enrollments"
      expr: SUM(CASE WHEN enrollment_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active care management enrollments representing engaged population."
    - name: "disenrolled_count"
      expr: SUM(CASE WHEN enrollment_status = 'disenrolled' THEN 1 ELSE 0 END)
      comment: "Count of disenrolled members for retention and program effectiveness analysis."
    - name: "distinct_enrolled_members"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct members enrolled in care management programs, measuring population penetration."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of enrolled members indicating population acuity and resource needs."
    - name: "avg_hcc_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average HCC score of enrolled members for risk adjustment and cost prediction alignment."
    - name: "avg_enrollment_duration_days"
      expr: AVG(CAST(DATEDIFF(COALESCE(effective_end_date, CURRENT_DATE()), effective_start_date) AS DOUBLE))
      comment: "Average duration in days members remain enrolled in care management, measuring engagement longevity."
    - name: "high_acuity_enrollments"
      expr: SUM(CASE WHEN acuity_level = 'high' THEN 1 ELSE 0 END)
      comment: "Count of high-acuity enrollments requiring intensive care management resources."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care plan analytics measuring plan creation, risk stratification, and active plan management for coordinated member care delivery."
  source: "`health_insurance_ecm`.`care`.`care_plan`"
  dimensions:
    - name: "care_plan_status"
      expr: care_plan_status
      comment: "Current status of the care plan (active, completed, draft, discontinued)."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of care plan (e.g., disease management, complex care, transitional care)."
    - name: "high_risk_flag"
      expr: CAST(high_risk_flag AS STRING)
      comment: "Whether the care plan is flagged for high-risk members requiring intensive management."
    - name: "plan_creation_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the care plan became effective for trend and cohort analysis."
    - name: "plan_creation_year"
      expr: YEAR(effective_start_date)
      comment: "Year the care plan became effective for annual program review."
    - name: "source_system"
      expr: source_system
      comment: "Originating system of the care plan record for data lineage tracking."
  measures:
    - name: "total_care_plans"
      expr: COUNT(1)
      comment: "Total number of care plans created across the member population."
    - name: "active_care_plans"
      expr: SUM(CASE WHEN care_plan_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active care plans representing ongoing coordinated care efforts."
    - name: "high_risk_care_plans"
      expr: SUM(CASE WHEN high_risk_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of care plans for high-risk members requiring intensive resource allocation."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across care plans indicating population complexity and resource requirements."
    - name: "distinct_members_with_plans"
      expr: COUNT(DISTINCT care_member_subscriber_id)
      comment: "Distinct members with care plans, measuring care management population coverage."
    - name: "distinct_coordinators_assigned"
      expr: COUNT(DISTINCT coordinator_id)
      comment: "Distinct coordinators managing care plans for workload distribution analysis."
    - name: "avg_plan_duration_days"
      expr: AVG(CAST(DATEDIFF(COALESCE(effective_end_date, CURRENT_DATE()), effective_start_date) AS DOUBLE))
      comment: "Average duration of care plans in days, indicating typical care management engagement length."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_star_rating_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS Star Rating performance analytics tracking measure-level scores, quality bonus eligibility, and improvement trends for Medicare Advantage plan quality management."
  source: "`health_insurance_ecm`.`care`.`star_rating_result`"
  dimensions:
    - name: "measurement_year"
      expr: measurement_year
      comment: "Star rating measurement year for annual performance comparison."
    - name: "star_domain"
      expr: star_domain
      comment: "CMS Star Rating domain (e.g., staying healthy, managing chronic conditions, member experience)."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type evaluated (e.g., MA-PD, PDP, MA-only) for segment-level performance."
    - name: "rating_status"
      expr: rating_status
      comment: "Status of the star rating result (final, preliminary, projected)."
    - name: "overall_star_rating"
      expr: overall_star_rating
      comment: "Overall star rating achieved for the plan contract."
    - name: "trend_direction"
      expr: trend_direction
      comment: "Direction of performance trend (improving, declining, stable) for strategic planning."
    - name: "quality_bonus_eligible"
      expr: CAST(quality_bonus_eligible AS STRING)
      comment: "Whether the measure contributes to quality bonus payment eligibility (4+ stars)."
    - name: "improvement_measure_flag"
      expr: CAST(improvement_measure_flag AS STRING)
      comment: "Whether this is an improvement measure tracked for year-over-year gains."
    - name: "measure_name"
      expr: measure_name
      comment: "Name of the specific Star Rating measure for drill-down analysis."
  measures:
    - name: "total_measures_evaluated"
      expr: COUNT(1)
      comment: "Total number of Star Rating measures evaluated across contracts and years."
    - name: "avg_measure_weight"
      expr: AVG(CAST(measure_weight AS DOUBLE))
      comment: "Average weight of evaluated measures indicating relative importance in overall star calculation."
    - name: "quality_bonus_eligible_measures"
      expr: SUM(CASE WHEN quality_bonus_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of measures meeting quality bonus eligibility threshold, directly impacting CMS bonus payments."
    - name: "avg_cutpoint_4_star"
      expr: AVG(CAST(cutpoint_4_star AS DOUBLE))
      comment: "Average 4-star cutpoint across measures, representing the performance threshold for quality bonus eligibility."
    - name: "avg_cutpoint_5_star"
      expr: AVG(CAST(cutpoint_5_star AS DOUBLE))
      comment: "Average 5-star cutpoint across measures, representing excellence threshold for top-tier performance."
    - name: "improving_measures_count"
      expr: SUM(CASE WHEN trend_direction = 'improving' THEN 1 ELSE 0 END)
      comment: "Count of measures showing improving trends, indicating positive quality trajectory."
    - name: "declining_measures_count"
      expr: SUM(CASE WHEN trend_direction = 'declining' THEN 1 ELSE 0 END)
      comment: "Count of measures showing declining trends requiring immediate intervention."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_cahps_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAHPS member experience survey analytics measuring satisfaction scores, response rates, and Star Rating impact for member experience improvement initiatives."
  source: "`health_insurance_ecm`.`care`.`cahps_survey`"
  dimensions:
    - name: "survey_year"
      expr: survey_year
      comment: "Survey administration year for annual experience trend analysis."
    - name: "survey_type"
      expr: survey_type
      comment: "Type of CAHPS survey (e.g., Medicare, Medicaid, Commercial)."
    - name: "survey_status"
      expr: survey_status
      comment: "Current status of the survey (completed, in-progress, not started)."
    - name: "survey_mode"
      expr: survey_mode
      comment: "Mode of survey administration (mail, phone, online, mixed)."
    - name: "administration_method"
      expr: administration_method
      comment: "Method used to administer the survey for response rate optimization."
    - name: "member_state"
      expr: member_state
      comment: "State of the surveyed member for geographic performance analysis."
    - name: "survey_language"
      expr: survey_language
      comment: "Language in which the survey was administered for equity analysis."
    - name: "survey_start_month"
      expr: DATE_TRUNC('month', survey_start_date)
      comment: "Month the survey period started for seasonal trending."
  measures:
    - name: "total_surveys"
      expr: COUNT(1)
      comment: "Total number of CAHPS surveys administered or tracked."
    - name: "avg_overall_satisfaction_score"
      expr: AVG(CAST(overall_satisfaction_score AS DOUBLE))
      comment: "Average overall member satisfaction score, a key driver of Star Ratings and member retention."
    - name: "avg_doctor_communication_score"
      expr: AVG(CAST(doctor_communication_score AS DOUBLE))
      comment: "Average doctor communication score measuring provider-member interaction quality."
    - name: "avg_getting_care_quickly_score"
      expr: AVG(CAST(getting_care_quickly_score AS DOUBLE))
      comment: "Average score for getting care quickly, measuring access and timeliness of care delivery."
    - name: "avg_getting_needed_care_score"
      expr: AVG(CAST(getting_needed_care_score AS DOUBLE))
      comment: "Average score for getting needed care, measuring adequacy of network and benefit access."
    - name: "avg_customer_service_score"
      expr: AVG(CAST(customer_service_score AS DOUBLE))
      comment: "Average customer service score measuring plan administrative and support quality."
    - name: "avg_response_rate"
      expr: AVG(CAST(response_rate AS DOUBLE))
      comment: "Average survey response rate indicating member engagement and survey methodology effectiveness."
    - name: "avg_star_rating_impact_score"
      expr: AVG(CAST(star_rating_impact_score AS DOUBLE))
      comment: "Average Star Rating impact score quantifying how CAHPS results influence overall Star performance."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_barrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Barrier-to-care analytics measuring identification, resolution, and severity of barriers impacting member health outcomes and care plan adherence."
  source: "`health_insurance_ecm`.`care`.`barrier`"
  dimensions:
    - name: "barrier_type"
      expr: barrier_type
      comment: "Type of barrier (e.g., transportation, financial, health literacy, language, social)."
    - name: "barrier_status"
      expr: barrier_status
      comment: "Current status of the barrier (identified, in-progress, resolved, unresolved)."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the barrier for prioritization of interventions."
    - name: "is_critical"
      expr: CAST(is_critical AS STRING)
      comment: "Whether the barrier is flagged as critical requiring immediate intervention."
    - name: "intervention_type"
      expr: intervention_type
      comment: "Type of intervention applied to address the barrier."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of barrier resolution efforts (resolved, partially resolved, unresolved)."
    - name: "identification_source"
      expr: identification_source
      comment: "Source that identified the barrier (HRA, care manager, claims analysis, member self-report)."
    - name: "hcc_impact"
      expr: CAST(hcc_impact AS STRING)
      comment: "Whether the barrier has potential HCC/risk adjustment impact."
    - name: "geographic_location"
      expr: geographic_location
      comment: "Geographic location of the member for regional barrier pattern analysis."
    - name: "identification_month"
      expr: DATE_TRUNC('month', identification_timestamp)
      comment: "Month the barrier was identified for trend analysis."
  measures:
    - name: "total_barriers"
      expr: COUNT(1)
      comment: "Total number of barriers to care identified across the managed population."
    - name: "open_barriers"
      expr: SUM(CASE WHEN barrier_status NOT IN ('resolved', 'closed') THEN 1 ELSE 0 END)
      comment: "Count of unresolved barriers requiring ongoing intervention and follow-up."
    - name: "resolved_barriers"
      expr: SUM(CASE WHEN barrier_status = 'resolved' THEN 1 ELSE 0 END)
      comment: "Count of successfully resolved barriers measuring intervention effectiveness."
    - name: "critical_barriers"
      expr: SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Count of critical barriers requiring urgent attention to prevent adverse health outcomes."
    - name: "avg_impact_score"
      expr: AVG(CAST(impact_score AS DOUBLE))
      comment: "Average impact score of barriers indicating severity of effect on member health outcomes."
    - name: "avg_days_to_resolve"
      expr: AVG(CAST(DATEDIFF(resolution_date, CAST(identification_timestamp AS DATE)) AS DOUBLE))
      comment: "Average days from barrier identification to resolution, measuring intervention turnaround time."
    - name: "distinct_members_with_barriers"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct members with identified barriers for population-level barrier prevalence analysis."
    - name: "hcc_impacting_barriers"
      expr: SUM(CASE WHEN hcc_impact = TRUE THEN 1 ELSE 0 END)
      comment: "Count of barriers with HCC/risk adjustment impact for revenue and quality intersection analysis."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_transition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transition of care analytics measuring care setting transitions, readmission risk, and discharge planning effectiveness for reducing avoidable readmissions."
  source: "`health_insurance_ecm`.`care`.`transition`"
  dimensions:
    - name: "transition_type"
      expr: transition_type
      comment: "Type of care transition (e.g., inpatient-to-home, inpatient-to-SNF, ED-to-home)."
    - name: "transition_status"
      expr: transition_status
      comment: "Current status of the transition (planned, in-progress, completed, cancelled)."
    - name: "from_setting"
      expr: from_setting
      comment: "Care setting the member is transitioning from (e.g., acute inpatient, ED, SNF)."
    - name: "to_setting"
      expr: to_setting
      comment: "Care setting the member is transitioning to (e.g., home, SNF, rehab, LTAC)."
    - name: "readmission_risk_flag"
      expr: CAST(readmission_risk_flag AS STRING)
      comment: "Whether the member is flagged as high risk for readmission within 30 days."
    - name: "is_critical_transition"
      expr: CAST(is_critical_transition AS STRING)
      comment: "Whether the transition is classified as critical requiring intensive coordination."
    - name: "discharge_planning_status"
      expr: discharge_planning_status
      comment: "Status of discharge planning activities for the transition."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the care transition (successful, readmitted, complications, etc.)."
    - name: "transition_month"
      expr: DATE_TRUNC('month', transition_timestamp)
      comment: "Month of the transition event for seasonal and operational trending."
  measures:
    - name: "total_transitions"
      expr: COUNT(1)
      comment: "Total number of care transitions managed across the population."
    - name: "high_readmission_risk_transitions"
      expr: SUM(CASE WHEN readmission_risk_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transitions flagged as high readmission risk requiring intensive post-discharge follow-up."
    - name: "critical_transitions"
      expr: SUM(CASE WHEN is_critical_transition = TRUE THEN 1 ELSE 0 END)
      comment: "Count of critical transitions requiring immediate and intensive care coordination."
    - name: "toc_plans_completed"
      expr: SUM(CASE WHEN toc_plan_completed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transitions with completed transition-of-care plans, measuring care coordination thoroughness."
    - name: "avg_readmission_risk_score"
      expr: AVG(CAST(readmission_risk_score AS DOUBLE))
      comment: "Average readmission risk score across transitions for population risk stratification."
    - name: "distinct_members_transitioned"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct members undergoing care transitions for population-level transition volume analysis."
    - name: "care_gap_flagged_transitions"
      expr: SUM(CASE WHEN care_gap_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transitions with associated care gaps requiring quality measure follow-up."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_snf_stay`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Skilled Nursing Facility stay analytics measuring admission patterns, length of stay, costs, and readmission rates for post-acute care management and cost containment."
  source: "`health_insurance_ecm`.`care`.`snf_stay`"
  dimensions:
    - name: "snf_stay_status"
      expr: snf_stay_status
      comment: "Current status of the SNF stay (admitted, discharged, in-review)."
    - name: "snf_type"
      expr: snf_type
      comment: "Type of SNF facility or stay classification."
    - name: "discharge_destination"
      expr: discharge_destination
      comment: "Destination upon SNF discharge (home, hospital, LTAC, hospice) for transition planning."
    - name: "discharge_planning_status"
      expr: discharge_planning_status
      comment: "Status of discharge planning for the SNF stay."
    - name: "readmission_within_30_days"
      expr: CAST(readmission_within_30_days AS STRING)
      comment: "Whether the member was readmitted within 30 days of SNF discharge."
    - name: "readmission_risk_flag"
      expr: CAST(readmission_risk_flag AS STRING)
      comment: "Whether the member is flagged as high risk for readmission."
    - name: "patient_condition_at_admission"
      expr: patient_condition_at_admission
      comment: "Patient condition severity at SNF admission for acuity-based analysis."
    - name: "admission_month"
      expr: DATE_TRUNC('month', admission_timestamp)
      comment: "Month of SNF admission for seasonal and capacity planning analysis."
  measures:
    - name: "total_snf_stays"
      expr: COUNT(1)
      comment: "Total number of SNF stays managed for post-acute care volume tracking."
    - name: "readmissions_within_30_days"
      expr: SUM(CASE WHEN readmission_within_30_days = TRUE THEN 1 ELSE 0 END)
      comment: "Count of 30-day readmissions from SNF, a key quality and cost metric for post-acute care."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount for SNF stays representing post-acute care spend."
    - name: "total_charge_amount"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total charges for SNF stays before adjustments for cost analysis."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts applied to SNF stays for financial reconciliation."
    - name: "avg_net_amount_per_stay"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net payment per SNF stay for cost benchmarking and contract negotiation."
    - name: "avg_hcc_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average HCC score of SNF patients indicating population complexity and expected cost."
    - name: "distinct_members_in_snf"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct members with SNF stays for population-level post-acute utilization analysis."
    - name: "care_gap_flagged_stays"
      expr: SUM(CASE WHEN care_gap_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of SNF stays with associated care gaps for quality measure follow-up."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_hra`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health Risk Assessment analytics measuring completion rates, risk stratification, SDOH identification, and population health screening effectiveness."
  source: "`health_insurance_ecm`.`care`.`hra`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the HRA (completed, in-progress, not started, expired)."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of health risk assessment administered."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier assigned based on HRA results for care management stratification."
    - name: "completion_channel"
      expr: completion_channel
      comment: "Channel through which the HRA was completed (phone, online, in-person, mail)."
    - name: "screening_tool"
      expr: screening_tool
      comment: "Screening tool or instrument used for the assessment."
    - name: "assessment_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of assessment for seasonal completion trending."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of assessment for annual completion rate tracking."
  measures:
    - name: "total_hras"
      expr: COUNT(1)
      comment: "Total number of HRAs administered or initiated across the population."
    - name: "completed_hras"
      expr: SUM(CASE WHEN assessment_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of completed HRAs measuring population screening penetration."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score from HRA results indicating population health acuity."
    - name: "avg_risk_score_percentile"
      expr: AVG(CAST(risk_score_percentile AS DOUBLE))
      comment: "Average risk score percentile for relative population risk positioning."
    - name: "sdoh_food_insecurity_count"
      expr: SUM(CASE WHEN sdoh_food_insecurity = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members identified with food insecurity through HRA screening."
    - name: "sdoh_housing_instability_count"
      expr: SUM(CASE WHEN sdoh_housing_instability = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members identified with housing instability through HRA screening."
    - name: "sdoh_transportation_count"
      expr: SUM(CASE WHEN sdoh_transportation = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members identified with transportation barriers through HRA screening."
    - name: "sdoh_social_isolation_count"
      expr: SUM(CASE WHEN sdoh_social_isolation = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members identified with social isolation through HRA screening."
    - name: "sdoh_financial_strain_count"
      expr: SUM(CASE WHEN sdoh_financial_strain = TRUE THEN 1 ELSE 0 END)
      comment: "Count of members identified with financial strain through HRA screening."
    - name: "distinct_members_assessed"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct members who received HRA screening for population coverage measurement."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_plan_goal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care plan goal analytics measuring goal attainment, progress tracking, and clinical outcome achievement for care management effectiveness evaluation."
  source: "`health_insurance_ecm`.`care`.`plan_goal`"
  dimensions:
    - name: "plan_goal_status"
      expr: plan_goal_status
      comment: "Current status of the care plan goal (active, achieved, not met, in-progress)."
    - name: "goal_category"
      expr: goal_category
      comment: "Category of the care plan goal (e.g., clinical, behavioral, functional, self-management)."
    - name: "priority"
      expr: priority
      comment: "Priority level of the goal for resource allocation and focus."
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement used to evaluate goal progress."
    - name: "goal_target_month"
      expr: DATE_TRUNC('month', target_date)
      comment: "Target month for goal achievement for timeline tracking."
  measures:
    - name: "total_goals"
      expr: COUNT(1)
      comment: "Total number of care plan goals established across the managed population."
    - name: "achieved_goals"
      expr: SUM(CASE WHEN plan_goal_status = 'achieved' THEN 1 ELSE 0 END)
      comment: "Count of goals successfully achieved, measuring care management effectiveness."
    - name: "active_goals"
      expr: SUM(CASE WHEN plan_goal_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active goals being worked toward."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across goals for benchmark setting."
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual value achieved across goals for performance measurement."
    - name: "compliant_goals"
      expr: SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of goals meeting compliance criteria for regulatory and quality reporting."
    - name: "distinct_care_plans_with_goals"
      expr: COUNT(DISTINCT care_plan_id)
      comment: "Distinct care plans with established goals measuring care planning thoroughness."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_member_outreach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member outreach analytics measuring contact rates, channel effectiveness, and engagement outcomes for care management and quality gap closure campaigns."
  source: "`health_insurance_ecm`.`care`.`member_outreach`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Outreach channel used (phone, mail, email, text, in-person) for channel optimization."
    - name: "member_outreach_status"
      expr: member_outreach_status
      comment: "Status of the outreach attempt (completed, attempted, scheduled, failed)."
    - name: "purpose"
      expr: purpose
      comment: "Purpose of the outreach (gap closure, care plan review, wellness, appointment reminder)."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the outreach attempt (reached, voicemail, no answer, refused, scheduled)."
    - name: "is_automated"
      expr: CAST(is_automated AS STRING)
      comment: "Whether the outreach was automated vs. manual for efficiency analysis."
    - name: "language_preference"
      expr: language_preference
      comment: "Member language preference for culturally competent outreach planning."
    - name: "outreach_month"
      expr: DATE_TRUNC('month', outreach_timestamp)
      comment: "Month of outreach for seasonal campaign effectiveness analysis."
  measures:
    - name: "total_outreach_attempts"
      expr: COUNT(1)
      comment: "Total number of member outreach attempts for campaign volume tracking."
    - name: "successful_contacts"
      expr: SUM(CASE WHEN outcome = 'reached' THEN 1 ELSE 0 END)
      comment: "Count of outreach attempts that successfully reached the member."
    - name: "follow_up_required_count"
      expr: SUM(CASE WHEN follow_up_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of outreach attempts requiring follow-up for workload planning."
    - name: "distinct_members_contacted"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct members contacted through outreach for population engagement measurement."
    - name: "automated_outreach_count"
      expr: SUM(CASE WHEN is_automated = TRUE THEN 1 ELSE 0 END)
      comment: "Count of automated outreach attempts for operational efficiency and cost analysis."
    - name: "consent_obtained_count"
      expr: SUM(CASE WHEN compliance_consent_obtained = TRUE THEN 1 ELSE 0 END)
      comment: "Count of outreach attempts where member consent was obtained for compliance tracking."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_condition_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Condition registry analytics measuring chronic condition prevalence, risk adjustment factors, and condition management for population health and HCC coding accuracy."
  source: "`health_insurance_ecm`.`care`.`condition_registry`"
  dimensions:
    - name: "condition_category"
      expr: condition_category
      comment: "Clinical category of the condition (e.g., diabetes, cardiovascular, respiratory, behavioral health)."
    - name: "severity"
      expr: severity
      comment: "Severity level of the condition for acuity-based population stratification."
    - name: "is_chronic"
      expr: CAST(is_chronic AS STRING)
      comment: "Whether the condition is classified as chronic for disease management program targeting."
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Confirmation status of the condition (confirmed, suspected, ruled-out)."
    - name: "risk_adjustment_flag"
      expr: CAST(risk_adjustment_flag AS STRING)
      comment: "Whether the condition is relevant for risk adjustment and HCC coding."
    - name: "active_flag"
      expr: CAST(active_flag AS STRING)
      comment: "Whether the condition is currently active for the member."
    - name: "population_segment"
      expr: population_segment
      comment: "Population segment the member belongs to for cohort-level condition analysis."
    - name: "identification_method"
      expr: identification_method
      comment: "Method used to identify the condition (claims, EHR, HRA, chart review)."
    - name: "hcc_code"
      expr: hcc_code
      comment: "HCC code associated with the condition for risk adjustment revenue analysis."
  measures:
    - name: "total_conditions"
      expr: COUNT(1)
      comment: "Total number of conditions in the registry for population health burden assessment."
    - name: "active_conditions"
      expr: SUM(CASE WHEN active_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of currently active conditions requiring ongoing management."
    - name: "chronic_conditions"
      expr: SUM(CASE WHEN is_chronic = TRUE THEN 1 ELSE 0 END)
      comment: "Count of chronic conditions for disease management program sizing and resource planning."
    - name: "risk_adjustment_conditions"
      expr: SUM(CASE WHEN risk_adjustment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of conditions flagged for risk adjustment, directly impacting HCC revenue capture."
    - name: "avg_raf_score"
      expr: AVG(CAST(raf_score AS DOUBLE))
      comment: "Average RAF score across conditions indicating risk adjustment revenue opportunity."
    - name: "distinct_members_with_conditions"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct members with registered conditions for population prevalence measurement."
    - name: "confirmed_conditions"
      expr: SUM(CASE WHEN confirmation_status = 'confirmed' THEN 1 ELSE 0 END)
      comment: "Count of confirmed conditions for accurate population health reporting."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_sdoh_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social Determinants of Health assessment analytics measuring SDOH screening rates, risk levels, and referral effectiveness for health equity and whole-person care."
  source: "`health_insurance_ecm`.`care`.`sdoh_assessment`"
  dimensions:
    - name: "sdoh_domain"
      expr: sdoh_domain
      comment: "SDOH domain assessed (e.g., housing, food, transportation, financial, social)."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level identified from the SDOH assessment (high, moderate, low)."
    - name: "sdoh_assessment_status"
      expr: sdoh_assessment_status
      comment: "Status of the SDOH assessment (completed, in-progress, declined)."
    - name: "screening_tool"
      expr: screening_tool
      comment: "Screening tool used for the SDOH assessment."
    - name: "follow_up_status"
      expr: follow_up_status
      comment: "Status of follow-up actions from the SDOH assessment."
    - name: "referral_made_flag"
      expr: CAST(referral_made_flag AS STRING)
      comment: "Whether a referral to community resources was made based on assessment findings."
    - name: "assessment_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of SDOH assessment for screening volume trending."
  measures:
    - name: "total_sdoh_assessments"
      expr: COUNT(1)
      comment: "Total number of SDOH assessments conducted for screening coverage measurement."
    - name: "completed_assessments"
      expr: SUM(CASE WHEN sdoh_assessment_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of completed SDOH assessments for screening penetration tracking."
    - name: "high_risk_assessments"
      expr: SUM(CASE WHEN risk_level = 'high' THEN 1 ELSE 0 END)
      comment: "Count of assessments identifying high SDOH risk requiring intensive intervention."
    - name: "referrals_made"
      expr: SUM(CASE WHEN referral_made_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of community resource referrals made from SDOH assessments measuring intervention activation."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average SDOH assessment score indicating population-level social risk burden."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor from SDOH assessments for cost prediction refinement."
    - name: "distinct_members_screened"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct members screened for SDOH factors measuring population screening coverage."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`care_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care management program analytics measuring program capacity, enrollment utilization, and operational status for program portfolio management and resource optimization."
  source: "`health_insurance_ecm`.`care`.`program`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Type of care management program (e.g., disease management, complex care, wellness, behavioral health)."
    - name: "program_category"
      expr: program_category
      comment: "Category classification of the program for portfolio-level analysis."
    - name: "program_status"
      expr: program_status
      comment: "Current operational status of the program (active, suspended, retired, pilot)."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business the program serves (Medicare, Medicaid, Commercial, Exchange)."
    - name: "target_population"
      expr: target_population
      comment: "Target population for the program for alignment with population health strategy."
    - name: "is_evidence_based"
      expr: CAST(is_evidence_based AS STRING)
      comment: "Whether the program is evidence-based for clinical effectiveness validation."
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Accreditation status of the program for regulatory compliance."
    - name: "program_name"
      expr: program_name
      comment: "Name of the care management program for identification."
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total number of care management programs in the portfolio."
    - name: "active_programs"
      expr: SUM(CASE WHEN program_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active programs for operational capacity assessment."
    - name: "total_enrollment_capacity"
      expr: SUM(CAST(enrollment_cap AS DOUBLE))
      comment: "Total enrollment capacity across all programs for resource planning."
    - name: "total_current_enrollment"
      expr: SUM(CAST(enrollment_current AS DOUBLE))
      comment: "Total current enrollment across all programs for utilization tracking."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across programs for cost and revenue alignment."
    - name: "evidence_based_programs"
      expr: SUM(CASE WHEN is_evidence_based = TRUE THEN 1 ELSE 0 END)
      comment: "Count of evidence-based programs for clinical quality and accreditation reporting."
$$;