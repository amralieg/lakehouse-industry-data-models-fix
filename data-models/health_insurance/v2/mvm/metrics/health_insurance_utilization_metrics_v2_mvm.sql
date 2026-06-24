-- Metric views for domain: utilization | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 01:44:05

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_pa_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization request metrics tracking volume, financial exposure, and operational efficiency of PA submissions across service types, request types, and submission channels."
  source: "`vibe_health_insurance_v1`.`utilization`.`pa_request`"
  dimensions:
    - name: "pa_request_status"
      expr: pa_request_status
      comment: "Current status of the prior authorization request (e.g., Pending, Approved, Denied, Withdrawn) — primary operational grouping dimension."
    - name: "request_type"
      expr: request_type
      comment: "Type of PA request (e.g., Prospective, Concurrent, Retrospective) — used to segment authorization workload by review stage."
    - name: "service_type"
      expr: service_type
      comment: "Clinical service type associated with the PA request — enables analysis of authorization patterns by care category."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the PA request was submitted (e.g., Portal, Fax, Phone, EDI) — used to track digital adoption and operational efficiency."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for PA denial — critical for identifying denial patterns and clinical criteria gaps."
    - name: "is_appealable"
      expr: is_appealable
      comment: "Flag indicating whether the PA decision is eligible for appeal — used to assess member rights exposure."
    - name: "is_duplicate_request"
      expr: is_duplicate_request
      comment: "Flag indicating whether the request is a duplicate submission — used to measure operational waste and provider behavior."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month in which the PA request was submitted — used for trend analysis and workload forecasting."
    - name: "decision_maker_role"
      expr: decision_maker_role
      comment: "Role of the individual who made the PA decision (e.g., Nurse Reviewer, Medical Director) — used to analyze decision authority distribution."
    - name: "service_code"
      expr: service_code
      comment: "Procedure or service code associated with the PA request — enables high-frequency service identification."
  measures:
    - name: "total_pa_requests"
      expr: COUNT(1)
      comment: "Total number of prior authorization requests submitted — baseline volume KPI for workload and capacity planning."
    - name: "total_estimated_gross_amount"
      expr: SUM(CAST(estimated_gross_amount AS DOUBLE))
      comment: "Total estimated gross financial exposure across all PA requests — key metric for medical cost forecasting and budget management."
    - name: "total_estimated_net_amount"
      expr: SUM(CAST(estimated_net_amount AS DOUBLE))
      comment: "Total estimated net financial liability after adjustments across all PA requests — used for actuarial and financial reserve planning."
    - name: "total_estimated_adjustment_amount"
      expr: SUM(CAST(estimated_adjustment_amount AS DOUBLE))
      comment: "Total estimated adjustment amounts across PA requests — measures the financial impact of pricing and contract adjustments on authorized services."
    - name: "avg_estimated_net_amount"
      expr: AVG(CAST(estimated_net_amount AS DOUBLE))
      comment: "Average estimated net amount per PA request — used to benchmark cost per authorization and identify high-cost service patterns."
    - name: "duplicate_request_count"
      expr: COUNT(CASE WHEN is_duplicate_request = TRUE THEN 1 END)
      comment: "Number of duplicate PA requests submitted — measures operational inefficiency and provider submission quality."
    - name: "appealable_request_count"
      expr: COUNT(CASE WHEN is_appealable = TRUE THEN 1 END)
      comment: "Number of PA requests eligible for appeal — used to assess regulatory compliance exposure and member rights risk."
    - name: "distinct_members_requesting_pa"
      expr: COUNT(DISTINCT plan_election_id)
      comment: "Count of distinct plan elections (proxy for unique member-plan combinations) submitting PA requests — measures breadth of utilization management activity across the enrolled population."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_pa_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization decision metrics tracking approval rates, denial patterns, clinical criteria compliance, and turnaround performance — core UM quality and regulatory KPIs."
  source: "`vibe_health_insurance_v1`.`utilization`.`pa_decision`"
  dimensions:
    - name: "decision_status"
      expr: decision_status
      comment: "Outcome status of the PA decision (e.g., Approved, Denied, Partially Approved, Pended) — primary dimension for authorization outcome analysis."
    - name: "decision_type"
      expr: decision_type
      comment: "Type of PA decision (e.g., Initial, Appeal, Expedited) — used to segment decision outcomes by review pathway."
    - name: "denial_reason_category"
      expr: denial_reason_category
      comment: "High-level category of denial reason (e.g., Medical Necessity, Benefit Exclusion, Administrative) — used for denial root cause analysis."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Specific denial reason code — enables granular denial pattern tracking and regulatory reporting."
    - name: "criteria_met_flag"
      expr: criteria_met_flag
      comment: "Flag indicating whether clinical criteria were met for the PA decision — key quality indicator for evidence-based UM."
    - name: "is_urgent"
      expr: is_urgent
      comment: "Flag indicating whether the PA request was urgent/expedited — used to track compliance with expedited review turnaround requirements."
    - name: "is_telehealth"
      expr: is_telehealth
      comment: "Flag indicating whether the authorized service is telehealth — used to monitor telehealth utilization trends."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating whether the decision met regulatory compliance requirements — critical for CMS and state DOI audit readiness."
    - name: "appeal_eligibility_flag"
      expr: appeal_eligibility_flag
      comment: "Flag indicating whether the member is eligible to appeal the decision — used to assess member rights exposure and grievance risk."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month in which the PA decision was rendered — used for trend analysis and regulatory turnaround reporting."
    - name: "authorization_period_type"
      expr: authorization_period_type
      comment: "Type of authorization period granted (e.g., Single Episode, Ongoing, Annual) — used to analyze authorization duration patterns."
  measures:
    - name: "total_pa_decisions"
      expr: COUNT(1)
      comment: "Total number of PA decisions rendered — baseline volume KPI for UM decision throughput and staffing capacity."
    - name: "approved_decision_count"
      expr: COUNT(CASE WHEN decision_status = 'Approved' THEN 1 END)
      comment: "Number of PA decisions resulting in approval — used to calculate approval rates and benchmark against industry standards."
    - name: "denied_decision_count"
      expr: COUNT(CASE WHEN decision_status = 'Denied' THEN 1 END)
      comment: "Number of PA decisions resulting in denial — key metric for medical necessity management and cost containment effectiveness."
    - name: "criteria_met_decision_count"
      expr: COUNT(CASE WHEN criteria_met_flag = TRUE THEN 1 END)
      comment: "Number of decisions where clinical criteria were met — measures evidence-based decision-making compliance across the UM program."
    - name: "regulatory_non_compliant_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = FALSE THEN 1 END)
      comment: "Number of PA decisions flagged as non-compliant with regulatory requirements — critical risk metric for CMS audits and state regulatory reporting."
    - name: "urgent_decision_count"
      expr: COUNT(CASE WHEN is_urgent = TRUE THEN 1 END)
      comment: "Number of urgent/expedited PA decisions — used to monitor compliance with expedited review turnaround time mandates (typically 72 hours)."
    - name: "appeal_eligible_decision_count"
      expr: COUNT(CASE WHEN appeal_eligibility_flag = TRUE THEN 1 END)
      comment: "Number of decisions eligible for member appeal — measures downstream grievance and appeals workload exposure."
    - name: "total_clinical_rationale_score"
      expr: SUM(CAST(clinical_rationale AS DOUBLE))
      comment: "Sum of clinical rationale scores across all PA decisions — used as a proxy for clinical documentation completeness and quality."
    - name: "avg_clinical_rationale_score"
      expr: AVG(CAST(clinical_rationale AS DOUBLE))
      comment: "Average clinical rationale score per PA decision — benchmarks clinical documentation quality across reviewers and service types."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_auth_service_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Authorized service line metrics tracking financial authorization amounts, approval/denial patterns, and clinical service utilization at the line-item level — core medical cost management KPIs."
  source: "`vibe_health_insurance_v1`.`utilization`.`auth_service_line`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Status of the authorized service line (e.g., Approved, Denied, Partially Approved) — primary dimension for authorization outcome analysis."
    - name: "service_category"
      expr: service_category
      comment: "Clinical service category of the authorized line (e.g., Inpatient, Outpatient, DME, Behavioral Health) — used for utilization analysis by care setting."
    - name: "cpt_code"
      expr: cpt_code
      comment: "CPT procedure code for the authorized service — enables high-frequency procedure identification and cost benchmarking."
    - name: "hcpcs_code"
      expr: hcpcs_code
      comment: "HCPCS code for the authorized service — used for DME, drug, and ancillary service utilization analysis."
    - name: "place_of_service"
      expr: place_of_service
      comment: "Place of service code for the authorized service — used to analyze care setting utilization patterns and site-of-care optimization opportunities."
    - name: "denial_reason"
      expr: denial_reason
      comment: "Reason for service line denial — used for denial root cause analysis and clinical criteria gap identification."
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flag indicating whether the service was emergency-related — used to separate emergency from elective utilization in cost analysis."
    - name: "is_experimental"
      expr: is_experimental
      comment: "Flag indicating whether the service is classified as experimental — used to monitor experimental treatment authorization exposure."
    - name: "is_partial_approval"
      expr: is_partial_approval
      comment: "Flag indicating whether the service line received only partial approval — used to measure partial authorization rates and financial impact."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for authorized amounts — used for multi-currency financial reporting normalization."
    - name: "authorized_start_month"
      expr: DATE_TRUNC('MONTH', authorized_start_date)
      comment: "Month of authorization start date — used for trend analysis of authorized service volumes and financial exposure over time."
    - name: "diagnosis_icd_code"
      expr: diagnosis_icd_code
      comment: "ICD diagnosis code associated with the authorized service — enables disease-based utilization and cost analysis."
  measures:
    - name: "total_authorized_service_lines"
      expr: COUNT(1)
      comment: "Total number of authorized service lines — baseline volume KPI for authorization workload and medical cost exposure tracking."
    - name: "total_authorized_price"
      expr: SUM(CAST(authorized_price AS DOUBLE))
      comment: "Total authorized dollar amount across all service lines — primary financial KPI for medical cost management and budget variance analysis."
    - name: "total_authorized_quantity"
      expr: SUM(CAST(authorized_quantity AS DOUBLE))
      comment: "Total authorized service units across all lines — used to measure service volume authorized and benchmark against clinical guidelines."
    - name: "avg_authorized_price"
      expr: AVG(CAST(authorized_price AS DOUBLE))
      comment: "Average authorized price per service line — used to benchmark unit cost of authorized services and identify high-cost outliers."
    - name: "avg_authorized_quantity"
      expr: AVG(CAST(authorized_quantity AS DOUBLE))
      comment: "Average authorized quantity per service line — used to assess whether authorized service volumes align with clinical criteria benchmarks."
    - name: "emergency_service_line_count"
      expr: COUNT(CASE WHEN is_emergency = TRUE THEN 1 END)
      comment: "Number of emergency service lines authorized — used to monitor emergency utilization trends and assess avoidable ER utilization."
    - name: "partial_approval_count"
      expr: COUNT(CASE WHEN is_partial_approval = TRUE THEN 1 END)
      comment: "Number of service lines receiving partial approval — measures the frequency and financial impact of partial authorization decisions."
    - name: "experimental_service_line_count"
      expr: COUNT(CASE WHEN is_experimental = TRUE THEN 1 END)
      comment: "Number of experimental service lines authorized — used to monitor experimental treatment exposure and associated financial risk."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_inpatient_admission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inpatient admission metrics tracking hospital utilization, cost performance, readmission risk, and length-of-stay benchmark compliance — critical KPIs for medical management and value-based care programs."
  source: "`vibe_health_insurance_v1`.`utilization`.`inpatient_admission`"
  dimensions:
    - name: "admission_status"
      expr: admission_status
      comment: "Current status of the inpatient admission (e.g., Active, Discharged, Transferred) — primary operational grouping dimension."
    - name: "admission_type"
      expr: admission_type
      comment: "Type of inpatient admission (e.g., Elective, Emergency, Urgent, Newborn) — used to segment utilization by clinical urgency and care planning."
    - name: "drg_code"
      expr: drg_code
      comment: "Diagnosis Related Group code — primary clinical grouper for inpatient cost benchmarking and case mix analysis."
    - name: "primary_diagnosis_code"
      expr: primary_diagnosis_code
      comment: "Primary ICD diagnosis code for the admission — used for disease-based utilization and cost analysis."
    - name: "payer_authorization_status"
      expr: payer_authorization_status
      comment: "Payer authorization status for the admission — used to track authorization compliance and denial risk."
    - name: "review_decision"
      expr: review_decision
      comment: "UM review decision for the admission (e.g., Approved, Denied, Pended) — used to analyze concurrent review outcomes."
    - name: "review_status"
      expr: review_status
      comment: "Current status of the UM review for the admission — used to track open review workload and timeliness."
    - name: "is_readmission"
      expr: is_readmission
      comment: "Flag indicating whether the admission is a readmission — key quality indicator for care transition effectiveness."
    - name: "readmission_within_30_days"
      expr: readmission_within_30_days
      comment: "Flag indicating readmission within 30 days of prior discharge — CMS quality measure and value-based contract performance indicator."
    - name: "is_critical_care"
      expr: is_critical_care
      comment: "Flag indicating whether the admission involved critical care — used to segment high-acuity utilization and associated cost."
    - name: "los_benchmark_met_flag"
      expr: los_benchmark_met_flag
      comment: "Flag indicating whether the actual length of stay met the benchmark target — used to measure LOS efficiency and identify outlier cases."
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of admission date — used for inpatient utilization trend analysis and seasonal pattern identification."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for cost amounts — used for multi-currency financial reporting normalization."
  measures:
    - name: "total_admissions"
      expr: COUNT(1)
      comment: "Total number of inpatient admissions — baseline volume KPI for hospital utilization tracking and capacity planning."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual inpatient cost across all admissions — primary financial KPI for medical cost management and budget variance analysis."
    - name: "total_expected_cost"
      expr: SUM(CAST(expected_cost_amount AS DOUBLE))
      comment: "Total expected inpatient cost based on DRG benchmarks — used to calculate cost efficiency and identify over/under-performing facilities."
    - name: "avg_actual_cost_per_admission"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average actual cost per inpatient admission — used to benchmark unit cost performance against DRG targets and peer facilities."
    - name: "avg_expected_cost_per_admission"
      expr: AVG(CAST(expected_cost_amount AS DOUBLE))
      comment: "Average expected cost per inpatient admission — used as the benchmark baseline for cost efficiency ratio calculations."
    - name: "readmission_count"
      expr: COUNT(CASE WHEN is_readmission = TRUE THEN 1 END)
      comment: "Number of admissions classified as readmissions — key quality and cost metric; high readmission rates indicate care transition failures and drive penalty risk under value-based contracts."
    - name: "readmission_within_30_days_count"
      expr: COUNT(CASE WHEN readmission_within_30_days = TRUE THEN 1 END)
      comment: "Number of admissions with a readmission within 30 days — CMS Hospital Readmissions Reduction Program (HRRP) quality measure; directly impacts value-based payment penalties."
    - name: "critical_care_admission_count"
      expr: COUNT(CASE WHEN is_critical_care = TRUE THEN 1 END)
      comment: "Number of critical care admissions — used to monitor high-acuity utilization trends and associated cost concentration."
    - name: "los_benchmark_met_count"
      expr: COUNT(CASE WHEN los_benchmark_met_flag = TRUE THEN 1 END)
      comment: "Number of admissions where length of stay met the benchmark target — measures LOS management effectiveness and clinical efficiency."
    - name: "distinct_members_admitted"
      expr: COUNT(DISTINCT policy_id)
      comment: "Count of distinct member policies with inpatient admissions — measures inpatient utilization penetration across the insured population."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_concurrent_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Concurrent review metrics tracking inpatient review outcomes, length-of-stay benchmark performance, readmission risk stratification, and discharge planning effectiveness — key UM operational and quality KPIs."
  source: "`vibe_health_insurance_v1`.`utilization`.`concurrent_review`"
  dimensions:
    - name: "concurrent_review_status"
      expr: concurrent_review_status
      comment: "Current status of the concurrent review (e.g., Open, Closed, Escalated) — primary operational dimension for review workload management."
    - name: "review_type"
      expr: review_type
      comment: "Type of concurrent review (e.g., Initial, Continued Stay, Discharge Planning) — used to segment review activity by stage of care."
    - name: "readmission_risk_category"
      expr: readmission_risk_category
      comment: "Risk category for readmission (e.g., Low, Medium, High) — used to prioritize care management interventions and discharge planning resources."
    - name: "discharge_destination"
      expr: CAST(discharge_destination AS STRING)
      comment: "Planned discharge destination code — used to analyze post-acute care utilization patterns and discharge planning effectiveness."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the concurrent review case is critical — used to prioritize high-acuity case management resources."
    - name: "social_work_involved"
      expr: social_work_involved
      comment: "Flag indicating whether social work was involved in the concurrent review — used to measure social determinants of health intervention rates."
    - name: "benchmark_source"
      expr: benchmark_source
      comment: "Source of the LOS benchmark used (e.g., Milliman, InterQual, MCG) — used to track benchmark methodology consistency across reviews."
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of admission for the concurrent review — used for trend analysis of inpatient review volumes and LOS performance."
    - name: "next_review_month"
      expr: DATE_TRUNC('MONTH', next_review_date)
      comment: "Month of the next scheduled review — used for workload forecasting and review scheduling capacity planning."
  measures:
    - name: "total_concurrent_reviews"
      expr: COUNT(1)
      comment: "Total number of concurrent reviews conducted — baseline volume KPI for UM inpatient review workload and staffing capacity."
    - name: "total_los_benchmark_mean"
      expr: SUM(CAST(los_benchmark_mean AS DOUBLE))
      comment: "Sum of LOS benchmark mean values across all reviews — used as denominator component for LOS efficiency ratio calculations."
    - name: "avg_los_benchmark_mean"
      expr: AVG(CAST(los_benchmark_mean AS DOUBLE))
      comment: "Average benchmark mean length of stay across concurrent reviews — used to assess whether the patient population's expected LOS aligns with industry norms."
    - name: "avg_los_benchmark_target"
      expr: AVG(CAST(los_benchmark_target AS DOUBLE))
      comment: "Average target length of stay from benchmark — used to set LOS management goals and evaluate clinical efficiency against targets."
    - name: "avg_readmission_risk_score"
      expr: AVG(CAST(readmission_risk_score AS DOUBLE))
      comment: "Average readmission risk score across concurrent reviews — used to monitor population-level readmission risk and prioritize care management interventions."
    - name: "critical_review_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of concurrent reviews flagged as critical — used to monitor high-acuity case volume and ensure adequate clinical reviewer capacity."
    - name: "social_work_involved_count"
      expr: COUNT(CASE WHEN social_work_involved = TRUE THEN 1 END)
      comment: "Number of concurrent reviews with social work involvement — measures social determinants of health intervention rates and discharge complexity."
    - name: "high_readmission_risk_count"
      expr: COUNT(CASE WHEN readmission_risk_category = 'High' THEN 1 END)
      comment: "Number of concurrent reviews with high readmission risk classification — used to prioritize post-discharge care management and reduce preventable readmissions."
    - name: "avg_los_benchmark_outlier_threshold"
      expr: AVG(CAST(los_benchmark_outlier_threshold AS DOUBLE))
      comment: "Average LOS outlier threshold from benchmark — used to identify cases at risk of exceeding benchmark thresholds and triggering escalated review."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_episode_of_care`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Episode of care metrics tracking total cost, claim outcomes, prior authorization compliance, and utilization review decisions across care episodes — strategic KPIs for value-based care and medical cost management."
  source: "`vibe_health_insurance_v1`.`utilization`.`episode_of_care`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Status of the claim associated with the episode (e.g., Approved, Denied, Pending, Adjusted) — primary financial outcome dimension."
    - name: "prior_authorization_status"
      expr: prior_authorization_status
      comment: "Prior authorization status for the episode — used to measure PA compliance rates and identify episodes with authorization gaps."
    - name: "utilization_review_status"
      expr: utilization_review_status
      comment: "Status of the utilization review for the episode — used to track UM review completion and outcomes."
    - name: "utilization_review_decision"
      expr: utilization_review_decision
      comment: "Decision from the utilization review (e.g., Approved, Denied, Modified) — used to analyze UM decision patterns across episode types."
    - name: "medical_necessity_decision"
      expr: medical_necessity_decision
      comment: "Medical necessity determination for the episode — key clinical quality dimension for UM program effectiveness analysis."
    - name: "classification_or_type"
      expr: classification_or_type
      comment: "Clinical classification or type of the episode (e.g., Inpatient, Outpatient, Behavioral Health) — used to segment cost and utilization by care category."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the episode (e.g., Open, Closed, Suspended) — used to track active vs. completed episode workload."
    - name: "claim_denial_reason"
      expr: claim_denial_reason
      comment: "Reason for claim denial associated with the episode — used for denial root cause analysis and provider education."
    - name: "primary_diagnosis_code"
      expr: primary_diagnosis_code
      comment: "Primary ICD diagnosis code for the episode — enables disease-based cost and utilization analysis."
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of episode admission date — used for trend analysis of episode volume and cost over time."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the episode became effective — used for cohort-based episode cost and utilization analysis."
  measures:
    - name: "total_episodes"
      expr: COUNT(1)
      comment: "Total number of care episodes — baseline volume KPI for utilization management workload and population health program reach."
    - name: "total_charges"
      expr: SUM(CAST(total_charges AS DOUBLE))
      comment: "Total billed charges across all episodes — primary financial exposure KPI for medical cost management and budget planning."
    - name: "total_payments"
      expr: SUM(CAST(total_payments AS DOUBLE))
      comment: "Total payments made across all episodes — measures actual medical cost outflow and is the primary metric for medical loss ratio analysis."
    - name: "total_adjustments"
      expr: SUM(CAST(total_adjustments AS DOUBLE))
      comment: "Total adjustment amounts across all episodes — measures the financial impact of claim adjustments, recoveries, and corrections."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due across all episodes — represents outstanding financial liability and is used for accounts payable and reserve management."
    - name: "avg_charges_per_episode"
      expr: AVG(CAST(total_charges AS DOUBLE))
      comment: "Average billed charges per episode — used to benchmark episode cost intensity and identify high-cost episode types."
    - name: "avg_payments_per_episode"
      expr: AVG(CAST(total_payments AS DOUBLE))
      comment: "Average payment per episode — used to calculate average episode cost and benchmark against value-based contract targets."
    - name: "denied_episode_count"
      expr: COUNT(CASE WHEN claim_status = 'Denied' THEN 1 END)
      comment: "Number of episodes with denied claims — used to measure denial rates and identify systemic authorization or billing issues."
    - name: "pa_non_compliant_episode_count"
      expr: COUNT(CASE WHEN prior_authorization_status = 'Not Authorized' THEN 1 END)
      comment: "Number of episodes where prior authorization was not obtained — measures PA compliance gaps and associated financial risk from retrospective denials."
    - name: "distinct_members_with_episodes"
      expr: COUNT(DISTINCT identity_id)
      comment: "Count of distinct members with care episodes — measures the breadth of utilization management program reach across the member population."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_um_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utilization management case metrics tracking case volume, turnaround compliance, denial patterns, and case severity distribution — operational KPIs for UM program performance and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`utilization`.`um_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the UM case (e.g., Open, Closed, Pending, Escalated) — primary operational dimension for case workload management."
    - name: "case_type"
      expr: case_type
      comment: "Type of UM case (e.g., Prior Authorization, Concurrent Review, Retrospective Review, Appeals) — used to segment workload by review type."
    - name: "case_priority"
      expr: case_priority
      comment: "Priority level of the UM case (e.g., Routine, Urgent, Expedited) — used to monitor compliance with priority-based turnaround time requirements."
    - name: "case_severity"
      expr: case_severity
      comment: "Severity classification of the UM case — used to stratify case complexity and allocate clinical reviewer resources appropriately."
    - name: "prior_authorization_status"
      expr: prior_authorization_status
      comment: "Prior authorization status associated with the UM case — used to track PA decision outcomes at the case level."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Denial reason code for the UM case — used for denial pattern analysis and clinical criteria gap identification."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Final disposition code for the UM case — used to analyze case resolution patterns and outcomes."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether the UM case met regulatory compliance requirements — critical for CMS and state DOI audit readiness."
    - name: "urgency_flag"
      expr: urgency_flag
      comment: "Flag indicating whether the UM case was flagged as urgent — used to monitor expedited review volumes and turnaround compliance."
    - name: "appeal_indicator"
      expr: appeal_indicator
      comment: "Flag indicating whether the UM case involves an appeal — used to track appeals volume and associated regulatory obligations."
    - name: "case_open_month"
      expr: DATE_TRUNC('MONTH', case_open_date)
      comment: "Month the UM case was opened — used for trend analysis of case intake volume and workload forecasting."
    - name: "primary_diagnosis_code"
      expr: primary_diagnosis_code
      comment: "Primary diagnosis code associated with the UM case — enables disease-based utilization management analysis."
  measures:
    - name: "total_um_cases"
      expr: COUNT(1)
      comment: "Total number of UM cases — baseline volume KPI for utilization management workload, staffing capacity, and program reach."
    - name: "open_case_count"
      expr: COUNT(CASE WHEN case_status = 'Open' THEN 1 END)
      comment: "Number of currently open UM cases — operational KPI for real-time workload management and reviewer capacity planning."
    - name: "urgent_case_count"
      expr: COUNT(CASE WHEN urgency_flag = TRUE THEN 1 END)
      comment: "Number of urgent UM cases — used to monitor expedited review volumes and ensure compliance with regulatory turnaround time mandates."
    - name: "appeal_case_count"
      expr: COUNT(CASE WHEN appeal_indicator = TRUE THEN 1 END)
      comment: "Number of UM cases involving appeals — measures appeals workload and regulatory compliance obligations under member grievance requirements."
    - name: "non_compliant_case_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Number of UM cases flagged as non-compliant — critical risk metric for regulatory audits, CMS oversight, and state DOI reporting."
    - name: "denied_case_count"
      expr: COUNT(CASE WHEN prior_authorization_status = 'Denied' THEN 1 END)
      comment: "Number of UM cases resulting in PA denial — used to calculate denial rates and assess medical necessity management effectiveness."
    - name: "distinct_providers_in_um_cases"
      expr: COUNT(DISTINCT provider_id)
      comment: "Count of distinct providers involved in UM cases — used to identify high-volume providers for targeted outreach, education, and network management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_medical_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical policy metrics tracking policy coverage configuration, prior auth requirements, experimental and telehealth coverage, and policy lifecycle status — governance KPIs for UM program design and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`utilization`.`medical_policy`"
  dimensions:
    - name: "medical_policy_status"
      expr: medical_policy_status
      comment: "Current status of the medical policy (e.g., Active, Inactive, Under Review) — primary dimension for policy governance and lifecycle management."
    - name: "policy_type"
      expr: policy_type
      comment: "Type of medical policy (e.g., Coverage, Prior Authorization, Benefit Exclusion) — used to segment policy inventory by governance category."
    - name: "clinical_category"
      expr: clinical_category
      comment: "Clinical category of the medical policy (e.g., Oncology, Behavioral Health, Musculoskeletal) — used to analyze policy coverage by clinical domain."
    - name: "is_prior_auth_required"
      expr: is_prior_auth_required
      comment: "Flag indicating whether prior authorization is required under this policy — used to assess PA burden and identify opportunities for PA reduction programs."
    - name: "is_telehealth_covered"
      expr: is_telehealth_covered
      comment: "Flag indicating whether telehealth services are covered under this policy — used to monitor telehealth coverage expansion and regulatory compliance."
    - name: "is_experimental_covered"
      expr: is_experimental_covered
      comment: "Flag indicating whether experimental treatments are covered — used to assess coverage risk and manage experimental treatment authorization exposure."
    - name: "is_emergency_covered"
      expr: is_emergency_covered
      comment: "Flag indicating whether emergency services are covered — used to verify regulatory compliance with emergency coverage mandates."
    - name: "is_exempt"
      expr: is_exempt
      comment: "Flag indicating whether the policy is exempt from standard UM requirements — used to track exemption rates and ensure appropriate oversight."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the medical policy — used for policy governance audits and regulatory reporting."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the medical policy became effective — used for policy lifecycle trend analysis and coverage change management."
    - name: "coverage_limit_currency"
      expr: coverage_limit_currency
      comment: "Currency of the coverage limit amount — used for multi-currency policy financial analysis."
  measures:
    - name: "total_medical_policies"
      expr: COUNT(1)
      comment: "Total number of medical policies in the policy library — baseline governance KPI for policy inventory management and coverage breadth assessment."
    - name: "prior_auth_required_policy_count"
      expr: COUNT(CASE WHEN is_prior_auth_required = TRUE THEN 1 END)
      comment: "Number of medical policies requiring prior authorization — used to assess PA program scope and identify opportunities for PA reduction to improve member experience."
    - name: "telehealth_covered_policy_count"
      expr: COUNT(CASE WHEN is_telehealth_covered = TRUE THEN 1 END)
      comment: "Number of medical policies covering telehealth services — measures telehealth coverage breadth and regulatory compliance with telehealth parity mandates."
    - name: "experimental_covered_policy_count"
      expr: COUNT(CASE WHEN is_experimental_covered = TRUE THEN 1 END)
      comment: "Number of medical policies covering experimental treatments — used to monitor experimental coverage exposure and associated financial and regulatory risk."
    - name: "non_compliant_policy_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of medical policies with non-compliant status — critical governance KPI for regulatory audit readiness and policy remediation prioritization."
    - name: "total_coverage_limit_amount"
      expr: SUM(CAST(coverage_limit_amount AS DOUBLE))
      comment: "Total coverage limit amounts across all medical policies — used to assess aggregate financial exposure from policy coverage limits."
    - name: "avg_coverage_limit_amount"
      expr: AVG(CAST(coverage_limit_amount AS DOUBLE))
      comment: "Average coverage limit amount per medical policy — used to benchmark coverage generosity and identify outlier policies with unusually high or low limits."
    - name: "exempt_policy_count"
      expr: COUNT(CASE WHEN is_exempt = TRUE THEN 1 END)
      comment: "Number of medical policies exempt from standard UM requirements — used to monitor exemption rates and ensure appropriate clinical oversight is maintained."
$$;