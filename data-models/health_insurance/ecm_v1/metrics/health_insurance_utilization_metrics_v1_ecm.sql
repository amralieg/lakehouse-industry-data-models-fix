-- Metric views for domain: utilization | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 18:36:19

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`utilization_pa_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior Authorization Request metrics tracking volume, financial impact, and operational efficiency of the PA process - the core workflow of utilization management."
  source: "`health_insurance_ecm`.`utilization`.`pa_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of prior authorization request (e.g., standard, urgent, retrospective)"
    - name: "pa_request_status"
      expr: pa_request_status
      comment: "Current status of the PA request in its lifecycle"
    - name: "service_type"
      expr: service_type
      comment: "Type of healthcare service being requested for authorization"
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the PA request was submitted (e.g., portal, fax, phone)"
    - name: "decision_maker_role"
      expr: decision_maker_role
      comment: "Role of the person making the authorization decision"
    - name: "diagnosis_code"
      expr: diagnosis_code
      comment: "Primary diagnosis code associated with the PA request"
    - name: "is_appealable"
      expr: is_appealable
      comment: "Whether the PA decision is eligible for appeal"
    - name: "is_duplicate_request"
      expr: is_duplicate_request
      comment: "Flag indicating if this is a duplicate submission"
    - name: "request_month"
      expr: DATE_TRUNC('month', request_timestamp)
      comment: "Month in which the PA request was submitted"
    - name: "source_system"
      expr: source_system
      comment: "Originating system of the PA request"
  measures:
    - name: "total_pa_requests"
      expr: COUNT(1)
      comment: "Total number of prior authorization requests submitted - baseline volume indicator for UM workload planning"
    - name: "total_estimated_gross_amount"
      expr: SUM(CAST(estimated_gross_amount AS DOUBLE))
      comment: "Total estimated gross dollar amount of services under PA review - measures financial exposure in the authorization pipeline"
    - name: "total_estimated_net_amount"
      expr: SUM(CAST(estimated_net_amount AS DOUBLE))
      comment: "Total estimated net dollar amount after adjustments for services under PA review"
    - name: "total_estimated_adjustment_amount"
      expr: SUM(CAST(estimated_adjustment_amount AS DOUBLE))
      comment: "Total estimated adjustment amounts across PA requests - indicates potential cost avoidance through UM intervention"
    - name: "avg_estimated_gross_amount"
      expr: AVG(CAST(estimated_gross_amount AS DOUBLE))
      comment: "Average estimated gross amount per PA request - indicates typical service cost under review"
    - name: "distinct_members_requesting_pa"
      expr: COUNT(DISTINCT pa_member_subscriber_id)
      comment: "Unique members with PA requests - measures member impact breadth of UM program"
    - name: "distinct_providers_submitting"
      expr: COUNT(DISTINCT pa_provider_id)
      comment: "Unique providers submitting PA requests - measures provider engagement with UM process"
    - name: "duplicate_request_count"
      expr: SUM(CASE WHEN is_duplicate_request = true THEN 1 ELSE 0 END)
      comment: "Count of duplicate PA requests - indicates process inefficiency and provider friction"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`utilization_pa_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior Authorization Decision metrics measuring approval rates, denial patterns, and clinical criteria adherence - critical for regulatory compliance and network adequacy."
  source: "`health_insurance_ecm`.`utilization`.`pa_decision`"
  dimensions:
    - name: "decision_type"
      expr: decision_type
      comment: "Type of PA decision rendered (e.g., approval, denial, partial approval, pend)"
    - name: "decision_status"
      expr: decision_status
      comment: "Current status of the PA decision"
    - name: "denial_reason_category"
      expr: denial_reason_category
      comment: "Category of denial reason for denied PA requests"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Specific denial reason code for regulatory reporting"
    - name: "clinical_criteria_set"
      expr: clinical_criteria_set
      comment: "Clinical criteria set used for the decision (e.g., InterQual, MCG)"
    - name: "is_urgent"
      expr: is_urgent
      comment: "Whether the PA request was flagged as urgent"
    - name: "is_telehealth"
      expr: is_telehealth
      comment: "Whether the service is delivered via telehealth"
    - name: "criteria_met_flag"
      expr: criteria_met_flag
      comment: "Whether clinical criteria were met for the authorization"
    - name: "appeal_eligibility_flag"
      expr: appeal_eligibility_flag
      comment: "Whether the decision is eligible for appeal"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the decision meets regulatory compliance requirements"
    - name: "decision_month"
      expr: DATE_TRUNC('month', decision_date)
      comment: "Month in which the PA decision was rendered"
  measures:
    - name: "total_decisions"
      expr: COUNT(1)
      comment: "Total number of PA decisions rendered - baseline for decision volume and throughput analysis"
    - name: "approval_count"
      expr: SUM(CASE WHEN decision_type = 'approval' THEN 1 ELSE 0 END)
      comment: "Number of PA requests approved - numerator for approval rate calculation"
    - name: "denial_count"
      expr: SUM(CASE WHEN decision_type = 'denial' THEN 1 ELSE 0 END)
      comment: "Number of PA requests denied - key indicator for access-to-care monitoring and regulatory scrutiny"
    - name: "criteria_met_count"
      expr: SUM(CASE WHEN criteria_met_flag = true THEN 1 ELSE 0 END)
      comment: "Number of decisions where clinical criteria were met - measures clinical appropriateness of requested services"
    - name: "regulatory_compliant_count"
      expr: SUM(CASE WHEN regulatory_compliance_flag = true THEN 1 ELSE 0 END)
      comment: "Number of decisions meeting regulatory compliance - critical for avoiding penalties and maintaining accreditation"
    - name: "urgent_decision_count"
      expr: SUM(CASE WHEN is_urgent = true THEN 1 ELSE 0 END)
      comment: "Number of urgent PA decisions - monitors expedited review workload and compliance with urgent TAT requirements"
    - name: "appeal_eligible_denial_count"
      expr: SUM(CASE WHEN decision_type = 'denial' AND appeal_eligibility_flag = true THEN 1 ELSE 0 END)
      comment: "Denials eligible for appeal - forecasts downstream appeal workload and potential overturn risk"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`utilization_tat_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Turnaround Time Compliance metrics measuring adherence to regulatory and contractual decision timeframes - a primary regulatory KPI for health plan UM operations."
  source: "`health_insurance_ecm`.`utilization`.`tat_compliance_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of TAT compliance event being tracked"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the TAT event"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean flag indicating whether TAT was met"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification of the request (standard, urgent, expedited)"
    - name: "review_type"
      expr: review_type
      comment: "Type of utilization review (prospective, concurrent, retrospective)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "State or regulatory jurisdiction governing the TAT requirement"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (commercial, Medicare, Medicaid) with different TAT standards"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for TAT non-compliance events"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the TAT compliance event"
  measures:
    - name: "total_tat_events"
      expr: COUNT(1)
      comment: "Total TAT compliance events tracked - baseline for compliance monitoring volume"
    - name: "compliant_event_count"
      expr: SUM(CASE WHEN compliance_flag = true THEN 1 ELSE 0 END)
      comment: "Number of events meeting TAT requirements - numerator for compliance rate calculation"
    - name: "non_compliant_event_count"
      expr: SUM(CASE WHEN compliance_flag = false THEN 1 ELSE 0 END)
      comment: "Number of events failing TAT requirements - triggers corrective action and regulatory reporting"
    - name: "avg_variance_days"
      expr: AVG(CAST(variance_days AS DOUBLE))
      comment: "Average variance in days from TAT standard - positive values indicate late decisions, negative indicate early"
    - name: "avg_variance_hours"
      expr: AVG(CAST(variance_hours AS DOUBLE))
      comment: "Average variance in hours from TAT standard - granular measure for urgent request compliance"
    - name: "max_variance_days"
      expr: MAX(CAST(variance_days AS DOUBLE))
      comment: "Maximum TAT variance in days - identifies worst-case outliers requiring immediate intervention"
    - name: "total_variance_days"
      expr: SUM(CAST(variance_days AS DOUBLE))
      comment: "Total accumulated variance days - aggregate measure of TAT debt across the organization"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`utilization_inpatient_admission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inpatient Admission metrics tracking admission volume, cost management, length of stay performance, and readmission patterns - highest-cost utilization category requiring close management."
  source: "`health_insurance_ecm`.`utilization`.`inpatient_admission`"
  dimensions:
    - name: "admission_type"
      expr: admission_type
      comment: "Type of inpatient admission (e.g., elective, emergency, urgent)"
    - name: "admission_status"
      expr: admission_status
      comment: "Current status of the admission in the review lifecycle"
    - name: "review_status"
      expr: review_status
      comment: "Status of the utilization review for this admission"
    - name: "review_decision"
      expr: review_decision
      comment: "UM review decision for the admission (approved, denied, pended)"
    - name: "drg_code"
      expr: drg_code
      comment: "Diagnosis Related Group code - primary cost and clinical grouping for inpatient stays"
    - name: "primary_diagnosis_code"
      expr: primary_diagnosis_code
      comment: "Primary ICD diagnosis code for the admission"
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Disposition at discharge (home, SNF, rehab, etc.) - key for post-acute planning"
    - name: "is_readmission"
      expr: is_readmission
      comment: "Whether this admission is a readmission"
    - name: "readmission_within_30_days"
      expr: readmission_within_30_days
      comment: "Whether this is a 30-day readmission - CMS quality measure"
    - name: "is_critical_care"
      expr: is_critical_care
      comment: "Whether the admission involves critical/intensive care"
    - name: "los_benchmark_met_flag"
      expr: los_benchmark_met_flag
      comment: "Whether the length of stay met the benchmark target"
    - name: "payer_authorization_status"
      expr: payer_authorization_status
      comment: "Authorization status from the payer perspective"
    - name: "admission_month"
      expr: DATE_TRUNC('month', admission_date)
      comment: "Month of admission for trend analysis"
  measures:
    - name: "total_admissions"
      expr: COUNT(1)
      comment: "Total inpatient admissions - primary volume indicator for inpatient utilization management"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost of inpatient admissions - key financial metric for medical cost management"
    - name: "total_expected_cost"
      expr: SUM(CAST(expected_cost_amount AS DOUBLE))
      comment: "Total expected cost based on benchmarks - comparison basis for cost efficiency analysis"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average actual cost per admission - monitors cost trends and identifies outlier facilities"
    - name: "readmission_count"
      expr: SUM(CASE WHEN is_readmission = true THEN 1 ELSE 0 END)
      comment: "Count of readmissions - quality indicator and potential avoidable cost"
    - name: "thirty_day_readmission_count"
      expr: SUM(CASE WHEN readmission_within_30_days = true THEN 1 ELSE 0 END)
      comment: "Count of 30-day readmissions - CMS reportable quality metric with financial penalties"
    - name: "los_benchmark_met_count"
      expr: SUM(CASE WHEN los_benchmark_met_flag = true THEN 1 ELSE 0 END)
      comment: "Admissions meeting LOS benchmark - measures effectiveness of concurrent review and discharge planning"
    - name: "denial_count"
      expr: SUM(CASE WHEN review_decision = 'denied' THEN 1 ELSE 0 END)
      comment: "Admissions denied upon review - measures medical necessity screening effectiveness"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`utilization_concurrent_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Concurrent Review metrics measuring active inpatient stay management effectiveness, LOS optimization, and discharge planning - the real-time UM intervention point."
  source: "`health_insurance_ecm`.`utilization`.`concurrent_review`"
  dimensions:
    - name: "concurrent_review_status"
      expr: concurrent_review_status
      comment: "Current status of the concurrent review"
    - name: "review_type"
      expr: review_type
      comment: "Type of concurrent review being performed"
    - name: "readmission_risk_category"
      expr: readmission_risk_category
      comment: "Risk category for potential readmission (low, moderate, high)"
    - name: "discharge_destination"
      expr: discharge_destination
      comment: "Planned discharge destination for post-acute care coordination"
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the case is flagged as critical requiring escalated review"
    - name: "social_work_involved"
      expr: social_work_involved
      comment: "Whether social work services are involved in discharge planning"
    - name: "benchmark_source"
      expr: benchmark_source
      comment: "Source of LOS benchmark data (e.g., Milliman, internal)"
    - name: "review_month"
      expr: DATE_TRUNC('month', review_start_timestamp)
      comment: "Month the concurrent review was initiated"
  measures:
    - name: "total_concurrent_reviews"
      expr: COUNT(1)
      comment: "Total concurrent reviews performed - measures UM nurse workload and active case volume"
    - name: "avg_los_benchmark_target"
      expr: AVG(CAST(los_benchmark_target AS DOUBLE))
      comment: "Average LOS benchmark target across reviews - baseline for efficiency measurement"
    - name: "avg_los_benchmark_mean"
      expr: AVG(CAST(los_benchmark_mean AS DOUBLE))
      comment: "Average LOS benchmark mean - population-level expected stay duration"
    - name: "avg_readmission_risk_score"
      expr: AVG(CAST(readmission_risk_score AS DOUBLE))
      comment: "Average readmission risk score - population risk indicator for care transition planning"
    - name: "critical_case_count"
      expr: SUM(CASE WHEN is_critical = true THEN 1 ELSE 0 END)
      comment: "Number of critical concurrent reviews - measures high-acuity workload requiring physician review"
    - name: "social_work_involved_count"
      expr: SUM(CASE WHEN social_work_involved = true THEN 1 ELSE 0 END)
      comment: "Reviews with social work involvement - indicates complex discharge planning needs and social determinant barriers"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`utilization_um_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utilization Management Case metrics providing end-to-end case lifecycle visibility including case volume, priority distribution, and disposition outcomes."
  source: "`health_insurance_ecm`.`utilization`.`um_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current lifecycle status of the UM case"
    - name: "case_type"
      expr: case_type
      comment: "Type of UM case (e.g., inpatient, outpatient, behavioral health)"
    - name: "case_priority"
      expr: case_priority
      comment: "Priority level assigned to the case"
    - name: "case_severity"
      expr: case_severity
      comment: "Clinical severity classification of the case"
    - name: "disposition_code"
      expr: disposition_code
      comment: "Final disposition code of the UM case"
    - name: "prior_authorization_status"
      expr: prior_authorization_status
      comment: "PA status associated with the UM case"
    - name: "primary_diagnosis_code"
      expr: primary_diagnosis_code
      comment: "Primary diagnosis driving the UM case"
    - name: "urgency_flag"
      expr: urgency_flag
      comment: "Whether the case is flagged as urgent"
    - name: "appeal_indicator"
      expr: appeal_indicator
      comment: "Whether the case involves an appeal"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the case meets compliance requirements"
    - name: "case_open_month"
      expr: DATE_TRUNC('month', case_open_date)
      comment: "Month the UM case was opened"
  measures:
    - name: "total_um_cases"
      expr: COUNT(1)
      comment: "Total UM cases - primary workload and volume indicator for utilization management operations"
    - name: "urgent_case_count"
      expr: SUM(CASE WHEN urgency_flag = true THEN 1 ELSE 0 END)
      comment: "Number of urgent UM cases - measures expedited review demand and staffing pressure"
    - name: "appeal_case_count"
      expr: SUM(CASE WHEN appeal_indicator = true THEN 1 ELSE 0 END)
      comment: "Number of cases in appeal - indicates member/provider dissatisfaction and potential overturn risk"
    - name: "compliant_case_count"
      expr: SUM(CASE WHEN compliance_flag = true THEN 1 ELSE 0 END)
      comment: "Cases meeting compliance standards - numerator for case-level compliance rate"
    - name: "distinct_members"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Unique members with UM cases - measures member impact and potential access concerns"
    - name: "distinct_providers"
      expr: COUNT(DISTINCT primary_provider_id)
      comment: "Unique providers associated with UM cases - measures provider network engagement with UM"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`utilization_retrospective_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retrospective Review metrics measuring post-service utilization review outcomes, cost recovery, and documentation compliance - key for claims accuracy and cost containment."
  source: "`health_insurance_ecm`.`utilization`.`retrospective_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the retrospective review"
    - name: "review_type"
      expr: review_type
      comment: "Type of retrospective review (e.g., medical necessity, level of care)"
    - name: "medical_necessity_outcome"
      expr: medical_necessity_outcome
      comment: "Outcome of medical necessity determination"
    - name: "compliance_state"
      expr: compliance_state
      comment: "State jurisdiction governing the review compliance requirements"
    - name: "documentation_completeness_flag"
      expr: documentation_completeness_flag
      comment: "Whether documentation was complete for the review"
    - name: "retro_review_deadline_flag"
      expr: retro_review_deadline_flag
      comment: "Whether the review was completed within the required deadline"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for denied retrospective reviews"
    - name: "review_initiation_month"
      expr: DATE_TRUNC('month', review_initiation_date)
      comment: "Month the retrospective review was initiated"
  measures:
    - name: "total_retrospective_reviews"
      expr: COUNT(1)
      comment: "Total retrospective reviews conducted - measures post-service review volume"
    - name: "total_adjusted_amount"
      expr: SUM(CAST(adjusted_amount AS DOUBLE))
      comment: "Total dollar amount adjusted through retrospective review - primary cost recovery metric"
    - name: "avg_adjusted_amount"
      expr: AVG(CAST(adjusted_amount AS DOUBLE))
      comment: "Average adjustment per retrospective review - measures per-case recovery efficiency"
    - name: "documentation_complete_count"
      expr: SUM(CASE WHEN documentation_completeness_flag = true THEN 1 ELSE 0 END)
      comment: "Reviews with complete documentation - measures provider documentation quality"
    - name: "deadline_met_count"
      expr: SUM(CASE WHEN retro_review_deadline_flag = true THEN 1 ELSE 0 END)
      comment: "Reviews completed within regulatory deadline - compliance metric for timely filing"
    - name: "distinct_members_reviewed"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Unique members subject to retrospective review - monitors review concentration and potential member impact"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`utilization_episode_of_care`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Episode of Care metrics providing holistic view of care episodes including financial outcomes, authorization effectiveness, and utilization review decisions across the full care continuum."
  source: "`health_insurance_ecm`.`utilization`.`episode_of_care`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the episode of care"
    - name: "classification_or_type"
      expr: classification_or_type
      comment: "Classification or type of the care episode"
    - name: "prior_authorization_status"
      expr: prior_authorization_status
      comment: "PA status for the episode"
    - name: "utilization_review_status"
      expr: utilization_review_status
      comment: "UM review status for the episode"
    - name: "utilization_review_decision"
      expr: utilization_review_decision
      comment: "UM review decision outcome"
    - name: "medical_necessity_decision"
      expr: medical_necessity_decision
      comment: "Medical necessity determination for the episode"
    - name: "claim_status"
      expr: claim_status
      comment: "Claims processing status for the episode"
    - name: "primary_diagnosis_code"
      expr: primary_diagnosis_code
      comment: "Primary diagnosis code for the episode"
    - name: "admission_month"
      expr: DATE_TRUNC('month', admission_date)
      comment: "Month of admission for the episode"
  measures:
    - name: "total_episodes"
      expr: COUNT(1)
      comment: "Total episodes of care - measures care delivery volume across the continuum"
    - name: "total_charges"
      expr: SUM(CAST(total_charges AS DOUBLE))
      comment: "Total charges across all episodes - gross cost exposure before adjustments"
    - name: "total_payments"
      expr: SUM(CAST(total_payments AS DOUBLE))
      comment: "Total payments made for episodes - actual cost of care delivered"
    - name: "total_adjustments"
      expr: SUM(CAST(total_adjustments AS DOUBLE))
      comment: "Total adjustments applied to episodes - measures contractual and UM-driven cost reductions"
    - name: "avg_net_amount_due"
      expr: AVG(CAST(net_amount_due AS DOUBLE))
      comment: "Average net amount due per episode - measures per-episode cost efficiency"
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due across episodes - bottom-line financial liability"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`utilization_bed_day_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bed Day Review metrics measuring daily inpatient stay justification, clinical criteria adherence, and readmission risk - granular operational control for LOS management."
  source: "`health_insurance_ecm`.`utilization`.`bed_day_review`"
  dimensions:
    - name: "bed_day_review_status"
      expr: bed_day_review_status
      comment: "Current status of the bed day review"
    - name: "approval_decision"
      expr: approval_decision
      comment: "Approval decision for the continued stay day"
    - name: "clinical_status"
      expr: clinical_status
      comment: "Clinical status of the patient during the review"
    - name: "readmission_risk_category"
      expr: readmission_risk_category
      comment: "Readmission risk classification for discharge planning"
    - name: "clinical_criteria_met_flag"
      expr: clinical_criteria_met_flag
      comment: "Whether clinical criteria were met for the continued stay"
    - name: "length_of_stay_benchmark_met_flag"
      expr: length_of_stay_benchmark_met_flag
      comment: "Whether the LOS benchmark was met at time of review"
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the patient is in critical condition"
    - name: "social_work_involved"
      expr: social_work_involved
      comment: "Whether social work is involved in the case"
    - name: "review_month"
      expr: DATE_TRUNC('month', review_timestamp)
      comment: "Month of the bed day review"
  measures:
    - name: "total_bed_day_reviews"
      expr: COUNT(1)
      comment: "Total bed day reviews performed - measures daily review workload and inpatient monitoring intensity"
    - name: "criteria_met_count"
      expr: SUM(CASE WHEN clinical_criteria_met_flag = true THEN 1 ELSE 0 END)
      comment: "Reviews where clinical criteria were met - measures medical necessity of continued stays"
    - name: "criteria_not_met_count"
      expr: SUM(CASE WHEN clinical_criteria_met_flag = false THEN 1 ELSE 0 END)
      comment: "Reviews where criteria were NOT met - identifies potentially avoidable bed days and cost savings opportunity"
    - name: "los_benchmark_met_count"
      expr: SUM(CASE WHEN length_of_stay_benchmark_met_flag = true THEN 1 ELSE 0 END)
      comment: "Reviews where LOS benchmark was met - measures discharge planning effectiveness"
    - name: "avg_readmission_risk_score"
      expr: AVG(CAST(readmission_risk_score AS DOUBLE))
      comment: "Average readmission risk score across bed day reviews - population risk indicator for transition planning"
$$;