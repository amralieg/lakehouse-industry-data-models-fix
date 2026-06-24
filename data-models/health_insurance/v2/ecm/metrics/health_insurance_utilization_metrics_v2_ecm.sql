-- Metric views for domain: utilization | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 00:30:14

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_pa_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization request metrics tracking approval rates, turnaround times, and financial impact for utilization management decision-making"
  source: "`vibe_health_insurance_v1`.`utilization`.`pa_request`"
  dimensions:
    - name: "request_status"
      expr: pa_request_status
      comment: "Current status of the prior authorization request (approved, denied, pending, etc.)"
    - name: "request_type"
      expr: request_type
      comment: "Type of prior authorization request (inpatient, outpatient, pharmacy, etc.)"
    - name: "service_type"
      expr: service_type
      comment: "Category of service being requested for authorization"
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the PA request was submitted (portal, fax, phone, EDI)"
    - name: "denial_reason"
      expr: denial_reason_code
      comment: "Reason code for denial if request was not approved"
    - name: "is_appealable"
      expr: is_appealable
      comment: "Flag indicating whether the PA decision can be appealed"
    - name: "is_duplicate"
      expr: is_duplicate_request
      comment: "Flag indicating whether this is a duplicate request"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month when the PA request was submitted"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', prior_auth_decision_date)
      comment: "Month when the PA decision was made"
  measures:
    - name: "total_pa_requests"
      expr: COUNT(1)
      comment: "Total number of prior authorization requests submitted"
    - name: "total_estimated_gross_amount"
      expr: SUM(CAST(estimated_gross_amount AS DOUBLE))
      comment: "Total estimated gross financial amount across all PA requests"
    - name: "total_estimated_net_amount"
      expr: SUM(CAST(estimated_net_amount AS DOUBLE))
      comment: "Total estimated net financial amount after adjustments across all PA requests"
    - name: "total_estimated_adjustment_amount"
      expr: SUM(CAST(estimated_adjustment_amount AS DOUBLE))
      comment: "Total estimated adjustment amount across all PA requests"
    - name: "avg_estimated_gross_amount"
      expr: AVG(CAST(estimated_gross_amount AS DOUBLE))
      comment: "Average estimated gross amount per PA request"
    - name: "avg_turnaround_time_days"
      expr: AVG(CAST(turnaround_time_days AS DOUBLE))
      comment: "Average turnaround time in days from request to decision"
    - name: "distinct_providers"
      expr: COUNT(DISTINCT pa_requesting_provider_practice_location_id)
      comment: "Number of unique provider locations submitting PA requests"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_pa_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization decision metrics tracking approval rates, denial patterns, and authorization utilization for UM performance management"
  source: "`vibe_health_insurance_v1`.`utilization`.`pa_decision`"
  dimensions:
    - name: "decision_status"
      expr: decision_status
      comment: "Final status of the PA decision (approved, denied, partial approval)"
    - name: "decision_type"
      expr: decision_type
      comment: "Type of PA decision (initial, reconsideration, appeal)"
    - name: "denial_reason_category"
      expr: denial_reason_category
      comment: "High-level category of denial reason"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Specific denial reason code"
    - name: "is_urgent"
      expr: is_urgent
      comment: "Flag indicating whether this was an urgent/expedited PA decision"
    - name: "is_telehealth"
      expr: is_telehealth
      comment: "Flag indicating whether the authorized service is telehealth"
    - name: "criteria_met"
      expr: criteria_met_flag
      comment: "Flag indicating whether clinical criteria were met"
    - name: "appeal_eligible"
      expr: appeal_eligibility_flag
      comment: "Flag indicating whether the decision is eligible for appeal"
    - name: "regulatory_compliant"
      expr: regulatory_compliance_flag
      comment: "Flag indicating whether the decision meets regulatory compliance requirements"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month when the PA decision was made"
    - name: "authorization_start_month"
      expr: DATE_TRUNC('MONTH', authorization_start_date)
      comment: "Month when the authorization period begins"
  measures:
    - name: "total_pa_decisions"
      expr: COUNT(1)
      comment: "Total number of PA decisions made"
    - name: "total_authorized_quantity"
      expr: SUM(CAST(authorization_quantity AS DOUBLE))
      comment: "Total authorized quantity across all PA decisions"
    - name: "avg_authorized_quantity"
      expr: AVG(CAST(authorization_quantity AS DOUBLE))
      comment: "Average authorized quantity per PA decision"
    - name: "distinct_providers_with_decisions"
      expr: COUNT(DISTINCT practice_location_id)
      comment: "Number of unique provider locations with PA decisions"
    - name: "distinct_pa_requests"
      expr: COUNT(DISTINCT pa_request_id)
      comment: "Number of unique PA requests that received decisions"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_inpatient_admission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inpatient admission metrics tracking length of stay, readmissions, cost variance, and authorization compliance for hospital utilization management"
  source: "`vibe_health_insurance_v1`.`utilization`.`inpatient_admission`"
  dimensions:
    - name: "admission_status"
      expr: admission_status
      comment: "Current status of the inpatient admission"
    - name: "admission_type"
      expr: admission_type
      comment: "Type of admission (emergency, elective, urgent, etc.)"
    - name: "authorization_status"
      expr: payer_authorization_status
      comment: "Authorization status from payer perspective"
    - name: "review_decision"
      expr: review_decision
      comment: "Utilization review decision for the admission"
    - name: "is_readmission"
      expr: is_readmission
      comment: "Flag indicating whether this is a readmission"
    - name: "readmission_within_30_days"
      expr: readmission_within_30_days
      comment: "Flag indicating whether this is a readmission within 30 days"
    - name: "is_critical_care"
      expr: is_critical_care
      comment: "Flag indicating whether critical care was provided"
    - name: "los_benchmark_met"
      expr: los_benchmark_met_flag
      comment: "Flag indicating whether length of stay met benchmark targets"
    - name: "drg_code"
      expr: drg_code
      comment: "Diagnosis Related Group code for the admission"
    - name: "primary_diagnosis"
      expr: primary_diagnosis_code
      comment: "Primary diagnosis code for the admission"
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of admission"
    - name: "review_decision_month"
      expr: DATE_TRUNC('MONTH', review_decision_date)
      comment: "Month when review decision was made"
  measures:
    - name: "total_admissions"
      expr: COUNT(1)
      comment: "Total number of inpatient admissions"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost across all admissions"
    - name: "total_expected_cost"
      expr: SUM(CAST(expected_cost_amount AS DOUBLE))
      comment: "Total expected cost across all admissions"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average actual cost per admission"
    - name: "avg_expected_cost"
      expr: AVG(CAST(expected_cost_amount AS DOUBLE))
      comment: "Average expected cost per admission"
    - name: "avg_actual_los_days"
      expr: AVG(CAST(actual_los_days AS DOUBLE))
      comment: "Average actual length of stay in days"
    - name: "avg_expected_los_days"
      expr: AVG(CAST(expected_los_days AS DOUBLE))
      comment: "Average expected length of stay in days"
    - name: "avg_los_target_days"
      expr: AVG(CAST(los_target_days AS DOUBLE))
      comment: "Average target length of stay in days based on benchmarks"
    - name: "distinct_facilities"
      expr: COUNT(DISTINCT facility_npi)
      comment: "Number of unique facilities with admissions"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_concurrent_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Concurrent review metrics tracking ongoing inpatient stay management, length of stay variance, and discharge planning effectiveness"
  source: "`vibe_health_insurance_v1`.`utilization`.`concurrent_review`"
  dimensions:
    - name: "review_status"
      expr: concurrent_review_status
      comment: "Current status of the concurrent review"
    - name: "review_type"
      expr: review_type
      comment: "Type of concurrent review being performed"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether this is a critical case requiring urgent attention"
    - name: "social_work_involved"
      expr: social_work_involved
      comment: "Flag indicating whether social work services are involved in discharge planning"
    - name: "readmission_risk_category"
      expr: readmission_risk_category
      comment: "Category of readmission risk (low, medium, high)"
    - name: "review_start_month"
      expr: DATE_TRUNC('MONTH', review_start_timestamp)
      comment: "Month when concurrent review started"
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of the associated admission"
  measures:
    - name: "total_concurrent_reviews"
      expr: COUNT(1)
      comment: "Total number of concurrent reviews performed"
    - name: "avg_current_los"
      expr: AVG(CAST(current_length_of_stay AS DOUBLE))
      comment: "Average current length of stay across active reviews"
    - name: "avg_approved_los"
      expr: AVG(CAST(approved_length_of_stay AS DOUBLE))
      comment: "Average approved length of stay"
    - name: "avg_los_benchmark_mean"
      expr: AVG(CAST(los_benchmark_mean AS DOUBLE))
      comment: "Average benchmark mean length of stay"
    - name: "avg_los_benchmark_target"
      expr: AVG(CAST(los_benchmark_target AS DOUBLE))
      comment: "Average benchmark target length of stay"
    - name: "avg_readmission_risk_score"
      expr: AVG(CAST(readmission_risk_score AS DOUBLE))
      comment: "Average readmission risk score across reviews"
    - name: "distinct_facilities_under_review"
      expr: COUNT(DISTINCT practice_location_id)
      comment: "Number of unique facilities with concurrent reviews"
    - name: "distinct_um_cases"
      expr: COUNT(DISTINCT um_case_id)
      comment: "Number of unique UM cases associated with concurrent reviews"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_episode_of_care`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Episode of care metrics tracking bundled payment episodes, total cost of care, and utilization review outcomes for value-based care management"
  source: "`vibe_health_insurance_v1`.`utilization`.`episode_of_care`"
  dimensions:
    - name: "episode_classification"
      expr: classification_or_type
      comment: "Classification or type of the episode of care"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the episode"
    - name: "claim_status"
      expr: claim_status
      comment: "Status of claims associated with the episode"
    - name: "prior_auth_status"
      expr: prior_authorization_status
      comment: "Prior authorization status for the episode"
    - name: "utilization_review_status"
      expr: utilization_review_status
      comment: "Status of utilization review for the episode"
    - name: "utilization_review_decision"
      expr: utilization_review_decision
      comment: "Decision outcome of utilization review"
    - name: "medical_necessity_decision"
      expr: medical_necessity_decision
      comment: "Medical necessity determination for the episode"
    - name: "primary_diagnosis"
      expr: primary_diagnosis_code
      comment: "Primary diagnosis code for the episode"
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of admission for the episode"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month when the episode became effective"
  measures:
    - name: "total_episodes"
      expr: COUNT(1)
      comment: "Total number of episodes of care"
    - name: "total_charges"
      expr: SUM(CAST(total_charges AS DOUBLE))
      comment: "Total charges across all episodes"
    - name: "total_payments"
      expr: SUM(CAST(total_payments AS DOUBLE))
      comment: "Total payments made across all episodes"
    - name: "total_adjustments"
      expr: SUM(CAST(total_adjustments AS DOUBLE))
      comment: "Total adjustments applied across all episodes"
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due across all episodes"
    - name: "avg_charges_per_episode"
      expr: AVG(CAST(total_charges AS DOUBLE))
      comment: "Average charges per episode of care"
    - name: "avg_payments_per_episode"
      expr: AVG(CAST(total_payments AS DOUBLE))
      comment: "Average payments per episode of care"
    - name: "avg_los_days"
      expr: AVG(CAST(length_of_stay_days AS DOUBLE))
      comment: "Average length of stay in days per episode"
    - name: "distinct_members"
      expr: COUNT(DISTINCT identity_id)
      comment: "Number of unique members with episodes of care"
    - name: "distinct_providers"
      expr: COUNT(DISTINCT practice_location_id)
      comment: "Number of unique provider locations managing episodes"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_um_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utilization management case metrics tracking case volume, turnaround times, denial rates, and clinical outcomes for UM program performance"
  source: "`vibe_health_insurance_v1`.`utilization`.`um_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the UM case"
    - name: "case_type"
      expr: case_type
      comment: "Type of utilization management case"
    - name: "case_priority"
      expr: case_priority
      comment: "Priority level of the case (low, medium, high, urgent)"
    - name: "case_severity"
      expr: case_severity
      comment: "Clinical severity level of the case"
    - name: "prior_auth_status"
      expr: prior_authorization_status
      comment: "Prior authorization status for the case"
    - name: "denial_reason"
      expr: denial_reason_code
      comment: "Reason code if the case resulted in a denial"
    - name: "disposition_code"
      expr: disposition_code
      comment: "Final disposition code for the case"
    - name: "appeal_indicator"
      expr: appeal_indicator
      comment: "Flag indicating whether the case has an associated appeal"
    - name: "urgency_flag"
      expr: urgency_flag
      comment: "Flag indicating whether this is an urgent case"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether the case meets compliance requirements"
    - name: "primary_diagnosis"
      expr: primary_diagnosis_code
      comment: "Primary diagnosis code for the case"
    - name: "case_open_month"
      expr: DATE_TRUNC('MONTH', case_open_date)
      comment: "Month when the case was opened"
    - name: "case_close_month"
      expr: DATE_TRUNC('MONTH', case_close_date)
      comment: "Month when the case was closed"
  measures:
    - name: "total_um_cases"
      expr: COUNT(1)
      comment: "Total number of utilization management cases"
    - name: "avg_turnaround_time_days"
      expr: AVG(CAST(turnaround_time_days AS DOUBLE))
      comment: "Average turnaround time in days from case open to close"
    - name: "avg_actual_los"
      expr: AVG(CAST(length_of_stay_actual AS DOUBLE))
      comment: "Average actual length of stay for cases"
    - name: "avg_target_los"
      expr: AVG(CAST(length_of_stay_target AS DOUBLE))
      comment: "Average target length of stay for cases"
    - name: "distinct_providers_with_cases"
      expr: COUNT(DISTINCT practice_location_id)
      comment: "Number of unique provider locations with UM cases"
    - name: "distinct_um_programs"
      expr: COUNT(DISTINCT um_program_id)
      comment: "Number of unique UM programs managing cases"
    - name: "distinct_episodes"
      expr: COUNT(DISTINCT episode_of_care_id)
      comment: "Number of unique episodes of care associated with UM cases"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_tat_compliance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Turnaround time compliance metrics tracking regulatory TAT adherence, variance analysis, and root cause patterns for quality assurance and regulatory reporting"
  source: "`vibe_health_insurance_v1`.`utilization`.`tat_compliance_event`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Status of TAT compliance (compliant, non-compliant, at-risk)"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean flag indicating whether TAT compliance was met"
    - name: "event_type"
      expr: event_type
      comment: "Type of TAT compliance event"
    - name: "review_type"
      expr: review_type
      comment: "Type of review associated with the TAT event"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level of the request (standard, urgent, expedited)"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the TAT event"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction governing the TAT requirement"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level category of root cause for TAT non-compliance"
    - name: "root_cause_detail"
      expr: root_cause_detail
      comment: "Detailed root cause description for TAT non-compliance"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month when the TAT compliance event occurred"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_timestamp)
      comment: "Month when the decision was made"
  measures:
    - name: "total_tat_events"
      expr: COUNT(1)
      comment: "Total number of TAT compliance events tracked"
    - name: "avg_variance_days"
      expr: AVG(CAST(variance_days AS DOUBLE))
      comment: "Average variance in days from TAT standard (positive = late, negative = early)"
    - name: "avg_variance_hours"
      expr: AVG(CAST(variance_hours AS DOUBLE))
      comment: "Average variance in hours from TAT standard"
    - name: "avg_tat_standard_days"
      expr: AVG(CAST(tat_standard_days AS DOUBLE))
      comment: "Average TAT standard in days across events"
    - name: "avg_tat_standard_hours"
      expr: AVG(CAST(tat_standard_hours AS DOUBLE))
      comment: "Average TAT standard in hours across events"
    - name: "distinct_pa_requests"
      expr: COUNT(DISTINCT pa_request_id)
      comment: "Number of unique PA requests with TAT compliance events"
    - name: "distinct_providers"
      expr: COUNT(DISTINCT practice_location_id)
      comment: "Number of unique provider locations with TAT compliance events"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_retrospective_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retrospective review metrics tracking post-service medical necessity determinations, claim adjustments, and documentation compliance for payment integrity"
  source: "`vibe_health_insurance_v1`.`utilization`.`retrospective_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the retrospective review"
    - name: "review_type"
      expr: review_type
      comment: "Type of retrospective review performed"
    - name: "medical_necessity_outcome"
      expr: medical_necessity_outcome
      comment: "Outcome of medical necessity determination"
    - name: "denial_reason"
      expr: denial_reason_code
      comment: "Reason code if services were denied upon retrospective review"
    - name: "documentation_complete"
      expr: documentation_completeness_flag
      comment: "Flag indicating whether documentation was complete"
    - name: "retro_review_deadline_met"
      expr: retro_review_deadline_flag
      comment: "Flag indicating whether retrospective review deadline was met"
    - name: "compliance_state"
      expr: compliance_state
      comment: "State compliance jurisdiction for the review"
    - name: "review_initiation_month"
      expr: DATE_TRUNC('MONTH', review_initiation_date)
      comment: "Month when retrospective review was initiated"
    - name: "review_completion_month"
      expr: DATE_TRUNC('MONTH', review_completion_date)
      comment: "Month when retrospective review was completed"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month when the reviewed service was provided"
  measures:
    - name: "total_retrospective_reviews"
      expr: COUNT(1)
      comment: "Total number of retrospective reviews performed"
    - name: "total_adjusted_amount"
      expr: SUM(CAST(adjusted_amount AS DOUBLE))
      comment: "Total amount adjusted as a result of retrospective reviews"
    - name: "avg_adjusted_amount"
      expr: AVG(CAST(adjusted_amount AS DOUBLE))
      comment: "Average adjustment amount per retrospective review"
    - name: "distinct_providers_reviewed"
      expr: COUNT(DISTINCT practice_location_id)
      comment: "Number of unique provider locations subject to retrospective review"
    - name: "distinct_um_reviewers"
      expr: COUNT(DISTINCT um_reviewer_id)
      comment: "Number of unique UM reviewers performing retrospective reviews"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_um_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utilization management program metrics tracking program enrollment, accreditation status, and regulatory compliance for UM governance and oversight"
  source: "`vibe_health_insurance_v1`.`utilization`.`um_program`"
  dimensions:
    - name: "program_status"
      expr: um_program_status
      comment: "Current status of the UM program"
    - name: "program_type"
      expr: program_type
      comment: "Type of utilization management program"
    - name: "program_code"
      expr: program_code
      comment: "Unique code identifying the UM program"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business covered by the UM program"
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Current accreditation status of the UM program"
    - name: "accreditation_category"
      expr: accreditation_category
      comment: "Category of accreditation (NCQA, URAC, etc.)"
    - name: "gap_analysis_status"
      expr: gap_analysis_status
      comment: "Status of gap analysis for the UM program"
    - name: "pa_required"
      expr: pa_required_flag
      comment: "Flag indicating whether prior authorization is required under this program"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month when the UM program became effective"
    - name: "accreditation_survey_month"
      expr: DATE_TRUNC('MONTH', accreditation_survey_date)
      comment: "Month of the most recent accreditation survey"
  measures:
    - name: "total_um_programs"
      expr: COUNT(1)
      comment: "Total number of utilization management programs"
    - name: "distinct_health_plans"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Number of unique health plans with UM programs"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_bed_day_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bed Day Review metrics measuring daily inpatient stay justification, clinical criteria adherence, and readmission risk - granular operational control for LOS management."
  source: "`vibe_health_insurance_v1`.`utilization`.`bed_day_review`"
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

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`utilization_tat_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Turnaround Time Compliance metrics measuring adherence to regulatory and contractual decision timeframes - a primary regulatory KPI for health plan UM operations."
  source: "`vibe_health_insurance_v1`.`utilization`.`tat_compliance_event`"
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