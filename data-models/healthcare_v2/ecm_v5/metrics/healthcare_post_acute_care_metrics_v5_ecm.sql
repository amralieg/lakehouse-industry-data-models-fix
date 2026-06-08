-- Metric views for domain: post_acute_care | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`post_acute_care_post_acute_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core post-acute care episode metrics tracking financial performance, clinical outcomes, readmission rates, and episode efficiency for SNF, home health, and hospice settings."
  source: "`healthcare_ecm_v1`.`post_acute_care`.`post_acute_episode`"
  dimensions:
    - name: "episode_type"
      expr: episode_type
      comment: "Type of post-acute care episode (SNF, home health, hospice, LTACH, IRF)"
    - name: "episode_status"
      expr: episode_status
      comment: "Current status of the episode (active, discharged, transferred, expired)"
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Disposition at discharge indicating where patient went next"
    - name: "referral_source"
      expr: referral_source
      comment: "Source of the referral into post-acute care"
    - name: "is_telehealth"
      expr: CAST(is_telehealth AS STRING)
      comment: "Whether episode includes telehealth modality"
    - name: "readmission_flag"
      expr: CAST(readmission_flag AS STRING)
      comment: "Whether patient was readmitted during or after episode"
    - name: "is_eligible_for_quality_measure"
      expr: CAST(is_eligible_for_quality_measure AS STRING)
      comment: "Whether episode qualifies for quality measure reporting"
    - name: "episode_start_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month when the post-acute episode began for trend analysis"
    - name: "primary_diagnosis_code"
      expr: primary_diagnosis_code
      comment: "Primary diagnosis code driving the post-acute episode"
  measures:
    - name: "total_episodes"
      expr: COUNT(1)
      comment: "Total number of post-acute care episodes"
    - name: "total_charges"
      expr: SUM(CAST(total_charges AS DOUBLE))
      comment: "Total charges across all post-acute episodes for revenue analysis"
    - name: "total_payments"
      expr: SUM(CAST(total_payments AS DOUBLE))
      comment: "Total payments received for post-acute episodes"
    - name: "total_reimbursement"
      expr: SUM(CAST(reimbursement_amount AS DOUBLE))
      comment: "Total reimbursement amount for post-acute care services"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average patient risk score across episodes for acuity monitoring"
    - name: "avg_functional_status_score"
      expr: AVG(CAST(functional_status_score AS DOUBLE))
      comment: "Average functional status score indicating patient independence level"
    - name: "avg_outcome_score"
      expr: AVG(CAST(outcome_score AS DOUBLE))
      comment: "Average clinical outcome score measuring care effectiveness"
    - name: "avg_quality_measure_score"
      expr: AVG(CAST(quality_measure_score AS DOUBLE))
      comment: "Average quality measure score for value-based program reporting"
    - name: "readmission_count"
      expr: SUM(CASE WHEN readmission_within_30_days = TRUE THEN 1 ELSE 0 END)
      comment: "Count of episodes with 30-day readmission for CMS penalty tracking"
    - name: "net_responsibility_total"
      expr: SUM(CAST(net_responsibility AS DOUBLE))
      comment: "Total net financial responsibility across episodes"
    - name: "telehealth_episode_count"
      expr: SUM(CASE WHEN is_telehealth = TRUE THEN 1 ELSE 0 END)
      comment: "Count of episodes utilizing telehealth modality"
    - name: "avg_episode_number"
      expr: AVG(CAST(episode_number AS DOUBLE))
      comment: "Average episode sequence number indicating repeat utilization patterns"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`post_acute_care_readmission_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Readmission event metrics for CMS Hospital Readmissions Reduction Program (HRRP) tracking, cost analysis, and root cause identification."
  source: "`healthcare_ecm_v1`.`post_acute_care`.`readmission_event`"
  dimensions:
    - name: "readmission_type"
      expr: readmission_type
      comment: "Classification of readmission (planned, unplanned, potentially preventable)"
    - name: "readmission_reason_code"
      expr: readmission_reason_code
      comment: "Coded reason for readmission for root cause analysis"
    - name: "readmission_reason_description"
      expr: readmission_reason_description
      comment: "Description of readmission reason for reporting"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the readmission event"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility where readmission occurred"
    - name: "readmission_outcome"
      expr: readmission_outcome
      comment: "Outcome of the readmission episode"
    - name: "readmission_payment_status"
      expr: readmission_payment_status
      comment: "Payment status indicating if readmission was reimbursed or penalized"
    - name: "is_within_30_days"
      expr: CAST(is_readmission_within_30_days AS STRING)
      comment: "Whether readmission occurred within CMS 30-day window"
    - name: "is_within_90_days"
      expr: CAST(is_readmission_within_90_days AS STRING)
      comment: "Whether readmission occurred within 90-day window"
    - name: "discharge_disposition_code"
      expr: discharge_disposition_code
      comment: "Discharge disposition from original stay"
    - name: "readmission_month"
      expr: DATE_TRUNC('MONTH', readmission_timestamp)
      comment: "Month of readmission for trend analysis"
  measures:
    - name: "total_readmissions"
      expr: COUNT(1)
      comment: "Total readmission events for volume tracking"
    - name: "total_readmission_cost"
      expr: SUM(CAST(readmission_cost AS DOUBLE))
      comment: "Total cost of readmissions for financial impact analysis"
    - name: "avg_readmission_cost"
      expr: AVG(CAST(readmission_cost AS DOUBLE))
      comment: "Average cost per readmission event"
    - name: "readmissions_within_30_days"
      expr: SUM(CASE WHEN is_readmission_within_30_days = TRUE THEN 1 ELSE 0 END)
      comment: "Count of readmissions within 30 days for CMS HRRP penalty calculation"
    - name: "readmissions_within_90_days"
      expr: SUM(CASE WHEN is_readmission_within_90_days = TRUE THEN 1 ELSE 0 END)
      comment: "Count of readmissions within 90 days for bundled payment tracking"
    - name: "potentially_preventable_count"
      expr: SUM(CASE WHEN is_duplicate_event = FALSE AND is_readmission_within_30_days = TRUE THEN 1 ELSE 0 END)
      comment: "Count of unique 30-day readmissions that are potentially preventable"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`post_acute_care_service_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service delivery metrics tracking volume, revenue, and operational efficiency of post-acute care services across settings."
  source: "`healthcare_ecm_v1`.`post_acute_care`.`service_delivery`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of post-acute service delivered (PT, OT, ST, nursing, social work)"
    - name: "service_delivery_status"
      expr: service_delivery_status
      comment: "Status of service delivery (completed, cancelled, no-show, in-progress)"
    - name: "care_setting"
      expr: care_setting
      comment: "Setting where service was delivered (home, facility, telehealth)"
    - name: "service_date_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of service delivery for trend analysis"
    - name: "billing_flag"
      expr: CAST(billing_flag AS STRING)
      comment: "Whether service is billable"
    - name: "followup_required"
      expr: CAST(followup_required AS STRING)
      comment: "Whether follow-up is required after service delivery"
    - name: "referral_source"
      expr: referral_source
      comment: "Source of referral for the service"
  measures:
    - name: "total_services_delivered"
      expr: COUNT(1)
      comment: "Total number of services delivered across all settings"
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charges for services delivered"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue after adjustments for services delivered"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to service charges"
    - name: "avg_charge_per_service"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge per service delivery for pricing analysis"
    - name: "billable_service_count"
      expr: SUM(CASE WHEN billing_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of billable services for revenue capture analysis"
    - name: "completed_service_count"
      expr: SUM(CASE WHEN service_delivery_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of completed services for productivity tracking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`post_acute_care_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post-acute care referral metrics tracking conversion rates, timeliness, and referral pipeline health for care coordination."
  source: "`healthcare_ecm_v1`.`post_acute_care`.`referral`"
  dimensions:
    - name: "referral_type"
      expr: referral_type
      comment: "Type of post-acute referral (SNF, home health, hospice, rehab)"
    - name: "referral_status"
      expr: referral_status
      comment: "Current status of the referral (pending, accepted, declined, completed)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the referral (routine, urgent, emergent)"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Clinical urgency level driving referral timing"
    - name: "authorization_status"
      expr: authorization_status
      comment: "Prior authorization status for the referral"
    - name: "outcome_status"
      expr: outcome_status
      comment: "Final outcome of the referral (accepted, declined, expired)"
    - name: "referral_source"
      expr: referral_source
      comment: "Source of the referral (hospital, physician, self)"
    - name: "channel"
      expr: channel
      comment: "Channel through which referral was received (electronic, fax, phone)"
    - name: "referral_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Month of referral for volume trend analysis"
  measures:
    - name: "total_referrals"
      expr: COUNT(1)
      comment: "Total referral volume for capacity planning"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated cost of referred services for financial forecasting"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Average estimated cost per referral"
    - name: "authorization_required_count"
      expr: SUM(CASE WHEN authorization_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of referrals requiring prior authorization"
    - name: "followup_required_count"
      expr: SUM(CASE WHEN follow_up_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of referrals requiring follow-up for care coordination tracking"
    - name: "distinct_patients_referred"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients referred to post-acute care"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`post_acute_care_outcome_measure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical outcome measurement metrics for post-acute care quality reporting, value-based purchasing, and patient functional improvement tracking."
  source: "`healthcare_ecm_v1`.`post_acute_care`.`outcome_measure`"
  dimensions:
    - name: "measure_type"
      expr: measure_type
      comment: "Type of outcome measure (functional, clinical, patient-reported, process)"
    - name: "outcome_status"
      expr: outcome_status
      comment: "Status of the outcome (met, not met, in progress, excluded)"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category for risk-adjusted outcome reporting"
    - name: "achieved_flag"
      expr: CAST(achieved_flag AS STRING)
      comment: "Whether the target outcome was achieved"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measurement for the outcome value"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of measurement for trend analysis"
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total outcome measurements recorded"
    - name: "avg_measure_value"
      expr: AVG(CAST(measure_value AS DOUBLE))
      comment: "Average outcome measure value for performance trending"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value for benchmarking"
    - name: "goals_achieved_count"
      expr: SUM(CASE WHEN achieved_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of outcomes where target was achieved for quality reporting"
    - name: "distinct_patients_measured"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients with outcome measurements for population coverage"
    - name: "distinct_episodes_measured"
      expr: COUNT(DISTINCT post_acute_episode_id)
      comment: "Unique episodes with outcome measurements"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`post_acute_care_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post-acute care plan metrics tracking plan utilization, telehealth adoption, and care coordination effectiveness."
  source: "`healthcare_ecm_v1`.`post_acute_care`.`post_acute_care_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of post-acute care plan (rehabilitation, maintenance, palliative)"
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the care plan (active, completed, suspended, cancelled)"
    - name: "risk_level"
      expr: risk_level
      comment: "Patient risk level assigned to the care plan"
    - name: "insurance_coverage_type"
      expr: insurance_coverage_type
      comment: "Insurance coverage type for payer mix analysis"
    - name: "is_telehealth_allowed"
      expr: CAST(is_telehealth_allowed AS STRING)
      comment: "Whether telehealth is permitted under this care plan"
    - name: "plan_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when care plan became effective"
  measures:
    - name: "total_care_plans"
      expr: COUNT(1)
      comment: "Total post-acute care plans for volume tracking"
    - name: "active_care_plans"
      expr: SUM(CASE WHEN plan_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active care plans for capacity management"
    - name: "telehealth_enabled_plans"
      expr: SUM(CASE WHEN is_telehealth_allowed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of plans with telehealth enabled for digital health adoption tracking"
    - name: "distinct_patients_with_plans"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients with post-acute care plans"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`post_acute_care_service_bundle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service bundle metrics for bundled payment program management, cost analysis, and episode-based reimbursement tracking."
  source: "`healthcare_ecm_v1`.`post_acute_care`.`service_bundle`"
  dimensions:
    - name: "bundle_type"
      expr: bundle_type
      comment: "Type of service bundle (BPCI-A, CJR, custom)"
    - name: "service_bundle_status"
      expr: service_bundle_status
      comment: "Status of the service bundle (active, retired, draft)"
    - name: "reimbursement_model"
      expr: reimbursement_model
      comment: "Reimbursement model (bundled, fee-for-service, capitated)"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting for the bundle (inpatient, outpatient, home)"
    - name: "patient_acuity_level"
      expr: patient_acuity_level
      comment: "Patient acuity level the bundle is designed for"
    - name: "is_evidence_based"
      expr: CAST(is_evidence_based AS STRING)
      comment: "Whether bundle is based on clinical evidence guidelines"
    - name: "requires_prior_authorization"
      expr: CAST(requires_prior_authorization AS STRING)
      comment: "Whether bundle requires prior authorization"
  measures:
    - name: "total_bundles"
      expr: COUNT(1)
      comment: "Total service bundles defined for program management"
    - name: "avg_bundled_payment_amount"
      expr: AVG(CAST(bundled_payment_amount AS DOUBLE))
      comment: "Average bundled payment amount for financial benchmarking"
    - name: "total_bundled_payment_amount"
      expr: SUM(CAST(bundled_payment_amount AS DOUBLE))
      comment: "Total bundled payment amounts across all bundles"
    - name: "avg_cost_estimate"
      expr: AVG(CAST(cost_estimate_amount AS DOUBLE))
      comment: "Average estimated cost per bundle for margin analysis"
    - name: "avg_minimum_staff_fte"
      expr: AVG(CAST(minimum_staff_fte AS DOUBLE))
      comment: "Average minimum staffing FTE required per bundle for workforce planning"
    - name: "composite_bundle_count"
      expr: SUM(CASE WHEN is_composite_bundle = TRUE THEN 1 ELSE 0 END)
      comment: "Count of composite bundles combining multiple service types"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`post_acute_care_post_acute_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post-acute care location metrics for network adequacy, quality monitoring, and facility performance management."
  source: "`healthcare_ecm_v1`.`post_acute_care`.`post_acute_location`"
  dimensions:
    - name: "location_type"
      expr: location_type
      comment: "Type of post-acute location (SNF, home health agency, hospice, LTACH)"
    - name: "post_acute_location_status"
      expr: post_acute_location_status
      comment: "Operational status of the location (active, inactive, suspended)"
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Accreditation status for quality and compliance monitoring"
    - name: "state_province"
      expr: state_province
      comment: "State/province for geographic network analysis"
    - name: "city"
      expr: city
      comment: "City for local market analysis"
    - name: "has_emergency_services"
      expr: CAST(has_emergency_services AS STRING)
      comment: "Whether location has emergency services capability"
    - name: "wheelchair_accessible"
      expr: CAST(wheelchair_accessible AS STRING)
      comment: "ADA accessibility status"
  measures:
    - name: "total_locations"
      expr: COUNT(1)
      comment: "Total post-acute care locations in the network"
    - name: "avg_inspection_score"
      expr: AVG(CAST(inspection_score AS DOUBLE))
      comment: "Average inspection score across locations for quality benchmarking"
    - name: "active_location_count"
      expr: SUM(CASE WHEN post_acute_location_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active locations for network adequacy reporting"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`post_acute_care_care_plan_update`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care plan update metrics tracking plan modification frequency, critical changes, and care coordination activity."
  source: "`healthcare_ecm_v1`.`post_acute_care`.`care_plan_update`"
  dimensions:
    - name: "update_type"
      expr: update_type
      comment: "Type of care plan update (status change, goal modification, service adjustment)"
    - name: "change_reason"
      expr: change_reason
      comment: "Reason for the care plan change"
    - name: "new_status"
      expr: new_status
      comment: "New status after the update"
    - name: "previous_status"
      expr: previous_status
      comment: "Status before the update for transition analysis"
    - name: "is_critical"
      expr: CAST(is_critical AS STRING)
      comment: "Whether the update represents a critical change requiring immediate attention"
    - name: "update_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of care plan update for trend analysis"
  measures:
    - name: "total_updates"
      expr: COUNT(1)
      comment: "Total care plan updates for care coordination activity monitoring"
    - name: "critical_update_count"
      expr: SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Count of critical care plan updates requiring escalation"
    - name: "distinct_patients_updated"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients with care plan modifications"
    - name: "distinct_plans_updated"
      expr: COUNT(DISTINCT post_acute_care_plan_id)
      comment: "Unique care plans modified for plan stability analysis"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`post_acute_care_provider_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider assignment metrics for workforce utilization, credentialing compliance, and care team management in post-acute settings."
  source: "`healthcare_ecm_v1`.`post_acute_care`.`post_acute_provider_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the provider assignment (active, inactive, pending)"
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Provider credentialing status for compliance monitoring"
    - name: "is_primary_provider"
      expr: CAST(is_primary_provider AS STRING)
      comment: "Whether this is the primary provider assignment"
    - name: "scope_of_practice_flag"
      expr: CAST(scope_of_practice_flag AS STRING)
      comment: "Whether provider is operating within scope of practice"
    - name: "assignment_start_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month when assignment became effective"
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total provider assignments for workforce capacity tracking"
    - name: "active_assignments"
      expr: SUM(CASE WHEN assignment_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active provider assignments"
    - name: "primary_provider_assignments"
      expr: SUM(CASE WHEN is_primary_provider = TRUE THEN 1 ELSE 0 END)
      comment: "Count of primary provider designations for panel management"
    - name: "distinct_providers_assigned"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Unique providers with post-acute assignments for workforce planning"
    - name: "distinct_episodes_covered"
      expr: COUNT(DISTINCT post_acute_episode_id)
      comment: "Unique episodes with provider coverage"
$$;