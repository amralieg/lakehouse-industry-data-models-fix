-- Metric views for domain: utilization | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 21:18:32

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`utilization_pa_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization request performance metrics tracking approval rates, turnaround times, and financial impact of authorization decisions"
  source: "`health_insurance_ecm`.`utilization`.`pa_request`"
  dimensions:
    - name: "request_year"
      expr: YEAR(request_timestamp)
      comment: "Year the prior authorization request was submitted"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month the prior authorization request was submitted"
    - name: "pa_request_status"
      expr: pa_request_status
      comment: "Current status of the prior authorization request (approved, denied, pending, etc.)"
    - name: "request_type"
      expr: request_type
      comment: "Type of prior authorization request (initial, urgent, expedited, etc.)"
    - name: "service_type"
      expr: service_type
      comment: "Category of service being requested for authorization"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Standardized code indicating reason for denial if request was denied"
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the authorization request was submitted (portal, phone, fax, etc.)"
    - name: "is_appealable"
      expr: is_appealable
      comment: "Flag indicating whether the authorization decision can be appealed"
    - name: "is_duplicate_request"
      expr: is_duplicate_request
      comment: "Flag indicating whether this is a duplicate of an existing request"
    - name: "patient_gender"
      expr: patient_gender
      comment: "Gender of the patient for demographic analysis"
  measures:
    - name: "total_pa_requests"
      expr: COUNT(1)
      comment: "Total number of prior authorization requests submitted"
    - name: "unique_members_requesting_pa"
      expr: COUNT(DISTINCT primary_pa_member_subscriber_id)
      comment: "Distinct count of members who submitted prior authorization requests"
    - name: "total_estimated_gross_amount"
      expr: SUM(CAST(estimated_gross_amount AS DOUBLE))
      comment: "Total estimated gross financial value of all authorization requests"
    - name: "total_estimated_net_amount"
      expr: SUM(CAST(estimated_net_amount AS DOUBLE))
      comment: "Total estimated net financial value after adjustments of all authorization requests"
    - name: "avg_estimated_gross_amount"
      expr: AVG(CAST(estimated_gross_amount AS DOUBLE))
      comment: "Average estimated gross financial value per authorization request"
    - name: "avg_turnaround_time_days"
      expr: AVG(CAST(turnaround_time_days AS DOUBLE))
      comment: "Average number of days from request submission to decision for prior authorizations"
    - name: "duplicate_request_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_duplicate_request = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prior authorization requests that are duplicates, indicating process inefficiency"
    - name: "appealable_decision_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_appealable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of authorization decisions that are eligible for appeal"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`utilization_pa_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization decision outcomes tracking approval rates, denial patterns, and clinical criteria compliance"
  source: "`health_insurance_ecm`.`utilization`.`pa_decision`"
  dimensions:
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year the prior authorization decision was made"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month the prior authorization decision was made"
    - name: "decision_status"
      expr: decision_status
      comment: "Final status of the authorization decision (approved, denied, partial, etc.)"
    - name: "decision_type"
      expr: decision_type
      comment: "Type of authorization decision (initial, appeal, reconsideration, etc.)"
    - name: "denial_reason_category"
      expr: denial_reason_category
      comment: "High-level category of denial reason for pattern analysis"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Specific code indicating reason for denial"
    - name: "criteria_met_flag"
      expr: criteria_met_flag
      comment: "Flag indicating whether clinical criteria were met for the authorization"
    - name: "appeal_eligibility_flag"
      expr: appeal_eligibility_flag
      comment: "Flag indicating whether the decision is eligible for appeal"
    - name: "is_urgent"
      expr: is_urgent
      comment: "Flag indicating whether the authorization was processed as urgent"
    - name: "is_telehealth"
      expr: is_telehealth
      comment: "Flag indicating whether the authorized service is telehealth"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating whether the decision meets regulatory compliance requirements"
    - name: "authorization_period_type"
      expr: authorization_period_type
      comment: "Type of authorization period (single visit, date range, ongoing, etc.)"
  measures:
    - name: "total_pa_decisions"
      expr: COUNT(1)
      comment: "Total number of prior authorization decisions rendered"
    - name: "unique_members_with_decisions"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members who received authorization decisions"
    - name: "approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN decision_status = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prior authorization requests that were approved, key quality and access metric"
    - name: "denial_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN decision_status = 'denied' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prior authorization requests that were denied, indicating potential access barriers"
    - name: "criteria_met_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN criteria_met_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of decisions where clinical criteria were met, measuring clinical appropriateness"
    - name: "urgent_decision_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_urgent = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of decisions processed as urgent, indicating care urgency patterns"
    - name: "telehealth_authorization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_telehealth = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of authorizations for telehealth services, tracking virtual care adoption"
    - name: "regulatory_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of decisions meeting regulatory compliance requirements, critical for audit readiness"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`utilization_auth_service_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Authorized service line detail metrics tracking approved quantities, pricing, and service-level authorization patterns"
  source: "`health_insurance_ecm`.`utilization`.`auth_service_line`"
  dimensions:
    - name: "authorization_year"
      expr: YEAR(authorized_start_date)
      comment: "Year the service authorization becomes effective"
    - name: "authorization_month"
      expr: DATE_TRUNC('MONTH', authorized_start_date)
      comment: "Month the service authorization becomes effective"
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current status of the service line authorization"
    - name: "service_category"
      expr: service_category
      comment: "Category of service authorized (inpatient, outpatient, DME, etc.)"
    - name: "cpt_code"
      expr: cpt_code
      comment: "CPT procedure code for the authorized service"
    - name: "hcpcs_code"
      expr: hcpcs_code
      comment: "HCPCS code for the authorized service or supply"
    - name: "place_of_service"
      expr: place_of_service
      comment: "Location where the authorized service will be delivered"
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flag indicating whether the authorized service is for emergency care"
    - name: "is_experimental"
      expr: is_experimental
      comment: "Flag indicating whether the authorized service is experimental or investigational"
    - name: "is_partial_approval"
      expr: is_partial_approval
      comment: "Flag indicating whether the authorization is a partial approval of the requested service"
    - name: "denial_reason"
      expr: denial_reason
      comment: "Reason for denial if service line was not fully authorized"
    - name: "diagnosis_icd_code"
      expr: diagnosis_icd_code
      comment: "ICD diagnosis code justifying the authorized service"
  measures:
    - name: "total_service_lines"
      expr: COUNT(1)
      comment: "Total number of authorized service lines"
    - name: "unique_members_authorized"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members with authorized service lines"
    - name: "total_authorized_quantity"
      expr: SUM(CAST(authorized_quantity AS DOUBLE))
      comment: "Total quantity of services authorized across all service lines"
    - name: "total_authorized_value"
      expr: SUM(CAST(authorized_price AS DOUBLE))
      comment: "Total financial value of all authorized services, key budget and forecasting metric"
    - name: "avg_authorized_price"
      expr: AVG(CAST(authorized_price AS DOUBLE))
      comment: "Average price per authorized service line"
    - name: "emergency_service_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_emergency = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of authorized services that are for emergency care"
    - name: "experimental_service_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_experimental = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of authorized services that are experimental, indicating innovation adoption"
    - name: "partial_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_partial_approval = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service lines that received partial approval, indicating negotiation patterns"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`utilization_inpatient_admission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inpatient admission utilization metrics tracking length of stay, readmissions, cost efficiency, and admission patterns"
  source: "`health_insurance_ecm`.`utilization`.`inpatient_admission`"
  dimensions:
    - name: "admission_year"
      expr: YEAR(admission_date)
      comment: "Year of inpatient admission"
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of inpatient admission"
    - name: "admission_type"
      expr: admission_type
      comment: "Type of admission (elective, emergency, urgent, etc.)"
    - name: "admission_status"
      expr: admission_status
      comment: "Current status of the admission (active, discharged, transferred, etc.)"
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Disposition of patient at discharge (home, SNF, rehab, expired, etc.)"
    - name: "drg_code"
      expr: drg_code
      comment: "Diagnosis Related Group code for the admission, used for case mix analysis"
    - name: "primary_diagnosis_code"
      expr: primary_diagnosis_code
      comment: "Primary ICD diagnosis code for the admission"
    - name: "is_readmission"
      expr: is_readmission
      comment: "Flag indicating whether this admission is a readmission"
    - name: "readmission_within_30_days"
      expr: readmission_within_30_days
      comment: "Flag indicating whether this is a readmission within 30 days, key quality metric"
    - name: "is_critical_care"
      expr: is_critical_care
      comment: "Flag indicating whether the admission involved critical care services"
    - name: "los_benchmark_met_flag"
      expr: los_benchmark_met_flag
      comment: "Flag indicating whether the length of stay met benchmark targets"
    - name: "payer_authorization_status"
      expr: payer_authorization_status
      comment: "Authorization status from payer perspective"
    - name: "review_decision"
      expr: review_decision
      comment: "Utilization review decision for the admission"
  measures:
    - name: "total_admissions"
      expr: COUNT(1)
      comment: "Total number of inpatient admissions, core utilization volume metric"
    - name: "unique_members_admitted"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct count of members with inpatient admissions"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost of all inpatient admissions, key financial metric"
    - name: "total_expected_cost"
      expr: SUM(CAST(expected_cost_amount AS DOUBLE))
      comment: "Total expected cost of all inpatient admissions based on benchmarks"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average actual cost per inpatient admission"
    - name: "avg_actual_los_days"
      expr: AVG(CAST(actual_los_days AS DOUBLE))
      comment: "Average actual length of stay in days, key efficiency and quality metric"
    - name: "avg_expected_los_days"
      expr: AVG(CAST(expected_los_days AS DOUBLE))
      comment: "Average expected length of stay in days based on benchmarks"
    - name: "readmission_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_readmission = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of admissions that are readmissions, critical quality and cost metric"
    - name: "thirty_day_readmission_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN readmission_within_30_days = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of admissions that are readmissions within 30 days, key CMS quality measure"
    - name: "critical_care_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_critical_care = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of admissions involving critical care, indicating acuity and cost"
    - name: "los_benchmark_met_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN los_benchmark_met_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of admissions meeting length of stay benchmarks, measuring efficiency"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`utilization_um_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utilization management case metrics tracking case volume, turnaround times, denial patterns, and UM program effectiveness"
  source: "`health_insurance_ecm`.`utilization`.`um_case`"
  dimensions:
    - name: "case_open_year"
      expr: YEAR(case_open_date)
      comment: "Year the utilization management case was opened"
    - name: "case_open_month"
      expr: DATE_TRUNC('MONTH', case_open_date)
      comment: "Month the utilization management case was opened"
    - name: "case_type"
      expr: case_type
      comment: "Type of utilization management case (prospective, concurrent, retrospective, etc.)"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the UM case (open, closed, pending, escalated, etc.)"
    - name: "case_priority"
      expr: case_priority
      comment: "Priority level of the case (high, medium, low)"
    - name: "case_severity"
      expr: case_severity
      comment: "Clinical severity level of the case"
    - name: "disposition_code"
      expr: disposition_code
      comment: "Final disposition code for the case outcome"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code if case resulted in denial"
    - name: "primary_diagnosis_code"
      expr: primary_diagnosis_code
      comment: "Primary diagnosis code associated with the UM case"
    - name: "prior_authorization_status"
      expr: prior_authorization_status
      comment: "Status of prior authorization associated with the case"
    - name: "appeal_indicator"
      expr: appeal_indicator
      comment: "Flag indicating whether the case involves an appeal"
    - name: "urgency_flag"
      expr: urgency_flag
      comment: "Flag indicating whether the case is urgent"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether the case meets compliance requirements"
  measures:
    - name: "total_um_cases"
      expr: COUNT(1)
      comment: "Total number of utilization management cases, core UM workload metric"
    - name: "unique_members_with_um_cases"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members with utilization management cases"
    - name: "avg_turnaround_time_days"
      expr: AVG(CAST(turnaround_time_days AS DOUBLE))
      comment: "Average turnaround time in days from case open to close, key efficiency metric"
    - name: "avg_actual_los"
      expr: AVG(CAST(length_of_stay_actual AS DOUBLE))
      comment: "Average actual length of stay for cases involving inpatient admissions"
    - name: "avg_target_los"
      expr: AVG(CAST(length_of_stay_target AS DOUBLE))
      comment: "Average target length of stay benchmark for cases"
    - name: "appeal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of UM cases that involve appeals, indicating decision quality and member satisfaction"
    - name: "urgent_case_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN urgency_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of UM cases flagged as urgent, indicating workload acuity"
    - name: "compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of UM cases meeting compliance requirements, critical for regulatory audit"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`utilization_concurrent_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Concurrent review metrics tracking ongoing inpatient stay management, length of stay variance, and discharge planning effectiveness"
  source: "`health_insurance_ecm`.`utilization`.`concurrent_review`"
  dimensions:
    - name: "admission_year"
      expr: YEAR(admission_date)
      comment: "Year of the admission being concurrently reviewed"
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of the admission being concurrently reviewed"
    - name: "concurrent_review_status"
      expr: concurrent_review_status
      comment: "Current status of the concurrent review (active, completed, escalated, etc.)"
    - name: "review_type"
      expr: review_type
      comment: "Type of concurrent review (initial, continued stay, discharge planning, etc.)"
    - name: "discharge_destination"
      expr: discharge_destination
      comment: "Planned or actual discharge destination (home, SNF, rehab, etc.)"
    - name: "discharge_barriers"
      expr: discharge_barriers
      comment: "Identified barriers to timely discharge"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the review is for a critical case"
    - name: "social_work_involved"
      expr: social_work_involved
      comment: "Flag indicating whether social work services are involved in discharge planning"
    - name: "benchmark_source"
      expr: benchmark_source
      comment: "Source of length of stay benchmark data (Milliman, InterQual, internal, etc.)"
  measures:
    - name: "total_concurrent_reviews"
      expr: COUNT(1)
      comment: "Total number of concurrent reviews performed, measuring UM workload"
    - name: "unique_admissions_reviewed"
      expr: COUNT(DISTINCT inpatient_admission_id)
      comment: "Distinct count of inpatient admissions undergoing concurrent review"
    - name: "unique_members_reviewed"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Distinct count of members with concurrent reviews"
    - name: "avg_current_los"
      expr: AVG(CAST(current_length_of_stay AS DOUBLE))
      comment: "Average current length of stay at time of review"
    - name: "avg_los_benchmark_mean"
      expr: AVG(CAST(los_benchmark_mean AS DOUBLE))
      comment: "Average benchmark mean length of stay for reviewed cases"
    - name: "avg_los_benchmark_outlier_threshold"
      expr: AVG(CAST(los_benchmark_outlier_threshold AS DOUBLE))
      comment: "Average outlier threshold for length of stay benchmarks"
    - name: "critical_case_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of concurrent reviews flagged as critical, indicating high-risk cases"
    - name: "social_work_involvement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN social_work_involved = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews involving social work, indicating complex discharge planning needs"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`utilization_retrospective_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retrospective review metrics tracking post-service medical necessity determinations, payment adjustments, and compliance outcomes"
  source: "`health_insurance_ecm`.`utilization`.`retrospective_review`"
  dimensions:
    - name: "service_year"
      expr: YEAR(service_date)
      comment: "Year the reviewed service was provided"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month the reviewed service was provided"
    - name: "review_status"
      expr: review_status
      comment: "Current status of the retrospective review (completed, pending, escalated, etc.)"
    - name: "review_type"
      expr: review_type
      comment: "Type of retrospective review (medical necessity, coding, billing, etc.)"
    - name: "medical_necessity_outcome"
      expr: medical_necessity_outcome
      comment: "Outcome of medical necessity determination (met, not met, partial, etc.)"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code if service was denied upon retrospective review"
    - name: "compliance_state"
      expr: compliance_state
      comment: "Compliance status of the reviewed service"
    - name: "documentation_completeness_flag"
      expr: documentation_completeness_flag
      comment: "Flag indicating whether documentation was complete for review"
    - name: "retro_review_deadline_flag"
      expr: retro_review_deadline_flag
      comment: "Flag indicating whether review was completed within regulatory deadline"
  measures:
    - name: "total_retrospective_reviews"
      expr: COUNT(1)
      comment: "Total number of retrospective reviews performed"
    - name: "unique_members_reviewed"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Distinct count of members with retrospective reviews"
    - name: "unique_claims_reviewed"
      expr: COUNT(DISTINCT claim_header_id)
      comment: "Distinct count of claims undergoing retrospective review"
    - name: "total_adjusted_amount"
      expr: SUM(CAST(adjusted_amount AS DOUBLE))
      comment: "Total financial adjustment amount from retrospective reviews, key cost recovery metric"
    - name: "avg_adjusted_amount"
      expr: AVG(CAST(adjusted_amount AS DOUBLE))
      comment: "Average financial adjustment per retrospective review"
    - name: "documentation_completeness_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN documentation_completeness_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews with complete documentation, indicating provider compliance quality"
    - name: "deadline_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN retro_review_deadline_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews completed within regulatory deadlines, critical for compliance"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`utilization_pa_required_service`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization requirement configuration metrics tracking which services require PA, gold card program effectiveness, and exemption patterns"
  source: "`health_insurance_ecm`.`utilization`.`pa_required_service`"
  dimensions:
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the PA requirement becomes effective"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the PA requirement becomes effective"
    - name: "pa_required_service_status"
      expr: pa_required_service_status
      comment: "Status of the PA requirement configuration (active, inactive, pending, etc.)"
    - name: "service_code"
      expr: service_code
      comment: "Service code (CPT/HCPCS) requiring prior authorization"
    - name: "service_description"
      expr: service_description
      comment: "Description of the service requiring prior authorization"
    - name: "pa_type"
      expr: pa_type
      comment: "Type of prior authorization required (standard, expedited, retrospective, etc.)"
    - name: "pa_required_flag"
      expr: pa_required_flag
      comment: "Flag indicating whether prior authorization is required for this service"
    - name: "gold_card_flag"
      expr: gold_card_flag
      comment: "Flag indicating whether service is eligible for gold card program (PA waiver for high-performing providers)"
    - name: "provider_specialty_exemption_flag"
      expr: provider_specialty_exemption_flag
      comment: "Flag indicating whether certain provider specialties are exempt from PA requirement"
    - name: "exemption_type"
      expr: exemption_type
      comment: "Type of exemption from PA requirement if applicable"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business to which the PA requirement applies (commercial, Medicare, Medicaid, etc.)"
  measures:
    - name: "total_pa_required_services"
      expr: COUNT(1)
      comment: "Total number of service configurations requiring prior authorization"
    - name: "unique_service_codes_requiring_pa"
      expr: COUNT(DISTINCT service_code)
      comment: "Distinct count of service codes requiring prior authorization"
    - name: "pa_requirement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pa_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service configurations where PA is actively required"
    - name: "gold_card_eligibility_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gold_card_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PA-required services eligible for gold card program, measuring provider incentive reach"
    - name: "specialty_exemption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN provider_specialty_exemption_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PA requirements with specialty exemptions, indicating targeted PA strategy"
    - name: "avg_gold_card_approval_threshold"
      expr: AVG(CAST(gold_card_approval_rate_threshold AS DOUBLE))
      comment: "Average approval rate threshold required for gold card eligibility"
    - name: "gold_card_threshold_met_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gold_card_approval_rate_met_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of services where providers have met gold card approval rate thresholds, measuring program success"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`utilization_um_reviewer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utilization management reviewer workforce metrics tracking credentials, qualifications, training compliance, and reviewer capacity"
  source: "`health_insurance_ecm`.`utilization`.`um_reviewer`"
  dimensions:
    - name: "reviewer_status"
      expr: reviewer_status
      comment: "Current employment status of the UM reviewer (active, inactive, terminated, etc.)"
    - name: "credential_type"
      expr: credential_type
      comment: "Type of clinical credential held by reviewer (MD, RN, PharmD, etc.)"
    - name: "specialty"
      expr: specialty
      comment: "Clinical specialty of the UM reviewer"
    - name: "license_state"
      expr: license_state
      comment: "State where reviewer holds professional license"
    - name: "delegation_authority_level"
      expr: delegation_authority_level
      comment: "Level of decision-making authority delegated to reviewer"
    - name: "ncqa_qualified_flag"
      expr: ncqa_qualified_flag
      comment: "Flag indicating whether reviewer meets NCQA qualification standards"
    - name: "urac_qualified_flag"
      expr: urac_qualified_flag
      comment: "Flag indicating whether reviewer meets URAC qualification standards"
    - name: "compliance_state"
      expr: compliance_state
      comment: "Compliance status of reviewer credentials and training"
  measures:
    - name: "total_um_reviewers"
      expr: COUNT(1)
      comment: "Total number of utilization management reviewers, measuring workforce capacity"
    - name: "active_reviewer_count"
      expr: SUM(CASE WHEN reviewer_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active UM reviewers available for case assignment"
    - name: "ncqa_qualified_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ncqa_qualified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviewers meeting NCQA qualification standards, critical for accreditation"
    - name: "urac_qualified_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN urac_qualified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviewers meeting URAC qualification standards, critical for accreditation"
$$;