-- Metric views for domain: randomization | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-06 23:23:25

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`randomization_subject_randomization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core randomization metrics tracking subject enrollment into treatment arms, randomization rates, unblinding events, and eligibility confirmation across studies and sites."
  source: "`clinical_trials_ecm`.`randomization`.`subject_randomization`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier for grouping randomization metrics by clinical trial"
    - name: "study_site_id"
      expr: study_site_id
      comment: "Study site identifier for site-level randomization performance analysis"
    - name: "treatment_arm_id"
      expr: treatment_arm_id
      comment: "Treatment arm identifier for allocation balance monitoring"
    - name: "randomization_status"
      expr: randomization_status
      comment: "Current status of the randomization (e.g., randomized, cancelled, pending)"
    - name: "randomization_type"
      expr: randomization_type
      comment: "Type of randomization (e.g., initial, re-randomization)"
    - name: "randomization_method"
      expr: randomization_method
      comment: "Method used for randomization (e.g., IRT, manual, centralized)"
    - name: "blinding_type"
      expr: blinding_type
      comment: "Blinding level applied (e.g., double-blind, single-blind, open-label)"
    - name: "country_code"
      expr: country_code
      comment: "Country code for geographic analysis of randomization distribution"
    - name: "irt_system_name"
      expr: irt_system_name
      comment: "IRT system used for randomization for system performance tracking"
    - name: "randomization_month"
      expr: DATE_TRUNC('month', randomization_date)
      comment: "Month of randomization for enrollment trend analysis"
    - name: "randomization_quarter"
      expr: DATE_TRUNC('quarter', randomization_date)
      comment: "Quarter of randomization for quarterly enrollment reporting"
  measures:
    - name: "total_subjects_randomized"
      expr: COUNT(1)
      comment: "Total number of subject randomization records, representing enrollment volume into treatment arms"
    - name: "active_randomizations"
      expr: COUNT(CASE WHEN randomization_status = 'randomized' THEN 1 END)
      comment: "Count of subjects with active/confirmed randomization status"
    - name: "cancelled_randomizations"
      expr: COUNT(CASE WHEN randomization_status = 'cancelled' THEN 1 END)
      comment: "Count of cancelled randomizations indicating protocol deviations or withdrawals"
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN randomization_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of randomizations that were cancelled — key quality indicator for enrollment integrity"
    - name: "unblinded_subjects"
      expr: COUNT(CASE WHEN is_unblinded = TRUE THEN 1 END)
      comment: "Count of subjects whose treatment assignment has been unblinded"
    - name: "unblinding_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_unblinded = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of randomized subjects who have been unblinded — critical for trial integrity monitoring"
    - name: "eligibility_confirmed_count"
      expr: COUNT(CASE WHEN eligibility_confirmed = TRUE THEN 1 END)
      comment: "Count of subjects with confirmed eligibility at randomization"
    - name: "eligibility_confirmation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN eligibility_confirmed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of randomized subjects with confirmed eligibility — compliance and data quality indicator"
    - name: "rerandomized_subjects"
      expr: COUNT(CASE WHEN randomization_type = 're-randomization' THEN 1 END)
      comment: "Count of subjects who underwent re-randomization, indicating protocol complexity or adaptive design"
    - name: "distinct_treatment_arms_used"
      expr: COUNT(DISTINCT treatment_arm_id)
      comment: "Number of distinct treatment arms with assigned subjects — monitors allocation breadth"
    - name: "distinct_sites_randomizing"
      expr: COUNT(DISTINCT study_site_id)
      comment: "Number of distinct sites actively randomizing subjects — operational reach indicator"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`randomization_rand_deviation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Randomization deviation metrics tracking protocol violations in the randomization process, severity distribution, resolution rates, and regulatory reporting requirements."
  source: "`clinical_trials_ecm`.`randomization`.`rand_deviation`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier for deviation analysis by clinical trial"
    - name: "investigational_site_id"
      expr: investigational_site_id
      comment: "Site identifier for identifying sites with high deviation rates"
    - name: "deviation_type"
      expr: deviation_type
      comment: "Classification of the deviation (e.g., wrong treatment dispensed, stratification error)"
    - name: "deviation_status"
      expr: deviation_status
      comment: "Current status of the deviation (e.g., open, resolved, closed)"
    - name: "severity"
      expr: severity
      comment: "Severity level of the deviation (e.g., critical, major, minor)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification for systemic issue identification"
    - name: "blinding_impact"
      expr: blinding_impact
      comment: "Impact on blinding integrity (e.g., none, partial, full unblinding)"
    - name: "population_impact"
      expr: population_impact
      comment: "Impact on analysis population (e.g., ITT, per-protocol exclusion)"
    - name: "discovery_month"
      expr: DATE_TRUNC('month', discovery_date)
      comment: "Month of deviation discovery for trend analysis"
    - name: "regulatory_reportable"
      expr: regulatory_reportable
      comment: "Whether the deviation requires regulatory authority notification"
    - name: "irb_iec_reportable"
      expr: irb_iec_reportable
      comment: "Whether the deviation requires IRB/IEC notification"
  measures:
    - name: "total_deviations"
      expr: COUNT(1)
      comment: "Total number of randomization deviations — primary quality metric for randomization process"
    - name: "critical_deviations"
      expr: COUNT(CASE WHEN severity = 'critical' THEN 1 END)
      comment: "Count of critical severity deviations requiring immediate intervention"
    - name: "major_deviations"
      expr: COUNT(CASE WHEN severity = 'major' THEN 1 END)
      comment: "Count of major severity deviations with significant protocol impact"
    - name: "open_deviations"
      expr: COUNT(CASE WHEN deviation_status = 'open' THEN 1 END)
      comment: "Count of unresolved deviations requiring corrective action"
    - name: "resolved_deviations"
      expr: COUNT(CASE WHEN deviation_status = 'resolved' OR deviation_status = 'closed' THEN 1 END)
      comment: "Count of deviations that have been resolved or closed"
    - name: "resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deviation_status = 'resolved' OR deviation_status = 'closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deviations resolved — operational efficiency and compliance indicator"
    - name: "blinding_compromised_count"
      expr: COUNT(CASE WHEN blinding_impact != 'none' AND blinding_impact IS NOT NULL THEN 1 END)
      comment: "Count of deviations that compromised blinding integrity — critical trial validity metric"
    - name: "regulatory_reportable_count"
      expr: COUNT(CASE WHEN regulatory_reportable = TRUE THEN 1 END)
      comment: "Count of deviations requiring regulatory authority reporting — compliance risk indicator"
    - name: "subject_safety_impacted_count"
      expr: COUNT(CASE WHEN subject_safety_impact IS NOT NULL AND subject_safety_impact != 'none' THEN 1 END)
      comment: "Count of deviations with potential subject safety impact — patient safety metric"
    - name: "distinct_sites_with_deviations"
      expr: COUNT(DISTINCT investigational_site_id)
      comment: "Number of distinct sites with randomization deviations — identifies systemic vs isolated issues"
    - name: "sponsor_notified_count"
      expr: COUNT(CASE WHEN sponsor_notified = TRUE THEN 1 END)
      comment: "Count of deviations where sponsor has been notified — communication compliance metric"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`randomization_unblinding_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Unblinding request metrics tracking emergency and planned unblinding events, approval turnaround, urgency distribution, and blinding integrity across studies."
  source: "`clinical_trials_ecm`.`randomization`.`unblinding_request`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier for unblinding analysis by clinical trial"
    - name: "study_site_id"
      expr: study_site_id
      comment: "Site identifier for site-level unblinding frequency analysis"
    - name: "request_status"
      expr: request_status
      comment: "Current status of the unblinding request (e.g., pending, approved, denied, withdrawn)"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification (e.g., emergency, urgent, routine)"
    - name: "unblinding_reason"
      expr: unblinding_reason
      comment: "Reason for unblinding request (e.g., SAE, medical emergency, regulatory requirement)"
    - name: "unblinding_scope"
      expr: unblinding_scope
      comment: "Scope of unblinding (e.g., individual subject, treatment arm, full study)"
    - name: "final_outcome"
      expr: final_outcome
      comment: "Final outcome of the unblinding request"
    - name: "requestor_role"
      expr: requestor_role
      comment: "Role of the person requesting unblinding for access pattern analysis"
    - name: "submitted_month"
      expr: DATE_TRUNC('month', submitted_timestamp)
      comment: "Month of request submission for trend analysis"
  measures:
    - name: "total_unblinding_requests"
      expr: COUNT(1)
      comment: "Total number of unblinding requests — key indicator of trial safety events and blinding pressure"
    - name: "approved_requests"
      expr: COUNT(CASE WHEN request_status = 'approved' OR final_outcome = 'approved' THEN 1 END)
      comment: "Count of approved unblinding requests"
    - name: "denied_requests"
      expr: COUNT(CASE WHEN request_status = 'denied' OR final_outcome = 'denied' THEN 1 END)
      comment: "Count of denied unblinding requests — indicates inappropriate request patterns"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN request_status = 'approved' OR final_outcome = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of unblinding requests approved — balance between safety needs and trial integrity"
    - name: "emergency_requests"
      expr: COUNT(CASE WHEN urgency_level = 'emergency' THEN 1 END)
      comment: "Count of emergency unblinding requests — critical safety event indicator"
    - name: "blinding_broken_count"
      expr: COUNT(CASE WHEN blinding_broken_flag = TRUE THEN 1 END)
      comment: "Count of requests where blinding was actually broken — irreversible trial integrity impact"
    - name: "blinding_break_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN blinding_broken_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests resulting in actual blinding break — trial integrity risk metric"
    - name: "dsmb_referral_count"
      expr: COUNT(CASE WHEN dsmb_dmc_referral_flag = TRUE THEN 1 END)
      comment: "Count of requests escalated to DSMB/DMC — indicates serious safety signal patterns"
    - name: "protocol_deviation_raised_count"
      expr: COUNT(CASE WHEN protocol_deviation_raised = TRUE THEN 1 END)
      comment: "Count of unblinding requests that triggered protocol deviations"
    - name: "avg_response_time_hours"
      expr: AVG(CAST(TIMESTAMPDIFF(HOUR, submitted_timestamp, COALESCE(approver_1_timestamp, updated_timestamp)) AS DOUBLE))
      comment: "Average time in hours from request submission to first approver decision — SLA compliance metric"
    - name: "distinct_subjects_requesting"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of distinct subjects with unblinding requests — patient safety exposure metric"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`randomization_kit_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Kit assignment metrics tracking investigational product dispensing, compliance, temperature excursions, and return rates across studies and sites."
  source: "`clinical_trials_ecm`.`randomization`.`kit_assignment`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier for kit dispensing analysis by clinical trial"
    - name: "study_site_id"
      expr: study_site_id
      comment: "Site identifier for site-level dispensing performance"
    - name: "treatment_arm_id"
      expr: treatment_arm_id
      comment: "Treatment arm for allocation balance verification"
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the kit assignment (e.g., dispensed, returned, expired)"
    - name: "kit_type"
      expr: kit_type
      comment: "Type of kit dispensed for supply planning analysis"
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form of the dispensed medication"
    - name: "dose_level"
      expr: dose_level
      comment: "Dose level assigned for dose-response analysis"
    - name: "blinding_status"
      expr: blinding_status
      comment: "Blinding status of the kit assignment"
    - name: "return_status"
      expr: return_status
      comment: "Return status of the kit (e.g., returned, not returned, partially returned)"
    - name: "dispensing_month"
      expr: DATE_TRUNC('month', dispensing_date)
      comment: "Month of dispensing for supply trend analysis"
  measures:
    - name: "total_kit_assignments"
      expr: COUNT(1)
      comment: "Total number of kit assignments — primary supply chain and dispensing volume metric"
    - name: "dispensing_confirmed_count"
      expr: COUNT(CASE WHEN dispensing_confirmed = TRUE THEN 1 END)
      comment: "Count of kit assignments with confirmed dispensing to subjects"
    - name: "dispensing_confirmation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispensing_confirmed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of kit assignments with confirmed dispensing — supply chain reliability metric"
    - name: "compliance_flag_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Count of kit assignments flagged for compliance issues"
    - name: "non_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of kit assignments with compliance issues — GCP adherence indicator"
    - name: "protocol_deviation_flag_count"
      expr: COUNT(CASE WHEN protocol_deviation_flag = TRUE THEN 1 END)
      comment: "Count of kit assignments with associated protocol deviations"
    - name: "temperature_excursion_count"
      expr: COUNT(CASE WHEN temperature_excursion_flag = TRUE THEN 1 END)
      comment: "Count of kit assignments with temperature excursions — product integrity and cold chain metric"
    - name: "temperature_excursion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_excursion_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of kit assignments with temperature excursions — supply quality risk indicator"
    - name: "unblinded_kits"
      expr: COUNT(CASE WHEN unblinding_date IS NOT NULL THEN 1 END)
      comment: "Count of kit assignments where unblinding occurred"
    - name: "distinct_subjects_dispensed"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of distinct subjects who received kit dispensing — treatment coverage metric"
    - name: "distinct_sites_dispensing"
      expr: COUNT(DISTINCT study_site_id)
      comment: "Number of distinct sites actively dispensing kits — operational footprint metric"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`randomization_irt_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IRT system transaction metrics tracking interactive response technology operations, transaction success rates, and system reliability for randomization and dispensing workflows."
  source: "`clinical_trials_ecm`.`randomization`.`irt_transaction`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier for IRT performance analysis by trial"
    - name: "study_site_id"
      expr: study_site_id
      comment: "Site identifier for site-level IRT usage patterns"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of IRT transaction (e.g., randomization, dispensing, unblinding, screening)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the transaction (e.g., completed, failed, cancelled)"
    - name: "transaction_outcome"
      expr: transaction_outcome
      comment: "Outcome of the transaction for success/failure analysis"
    - name: "irt_system_name"
      expr: irt_system_name
      comment: "IRT system name for vendor performance comparison"
    - name: "blinding_status"
      expr: blinding_status
      comment: "Blinding status maintained during transaction"
    - name: "randomization_method"
      expr: randomization_method
      comment: "Randomization method used in the transaction"
    - name: "country_code"
      expr: country_code
      comment: "Country code for geographic IRT usage analysis"
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_timestamp)
      comment: "Month of transaction for volume trend analysis"
  measures:
    - name: "total_irt_transactions"
      expr: COUNT(1)
      comment: "Total IRT transactions — system utilization and operational volume metric"
    - name: "successful_transactions"
      expr: COUNT(CASE WHEN transaction_status = 'completed' OR transaction_outcome = 'success' THEN 1 END)
      comment: "Count of successfully completed IRT transactions"
    - name: "failed_transactions"
      expr: COUNT(CASE WHEN transaction_status = 'failed' OR transaction_outcome = 'failure' THEN 1 END)
      comment: "Count of failed IRT transactions requiring investigation or retry"
    - name: "transaction_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN transaction_status = 'completed' OR transaction_outcome = 'success' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IRT transactions completed successfully — system reliability KPI"
    - name: "transaction_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN transaction_status = 'failed' OR transaction_outcome = 'failure' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of failed IRT transactions — system quality and vendor performance indicator"
    - name: "cancelled_transactions"
      expr: COUNT(CASE WHEN transaction_status = 'cancelled' THEN 1 END)
      comment: "Count of cancelled IRT transactions — user experience and workflow efficiency indicator"
    - name: "sdv_completed_count"
      expr: COUNT(CASE WHEN sdv_flag = TRUE THEN 1 END)
      comment: "Count of transactions with source data verification completed — data quality assurance metric"
    - name: "sdv_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sdv_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IRT transactions with completed SDV — monitoring oversight metric"
    - name: "query_flagged_count"
      expr: COUNT(CASE WHEN query_flag = TRUE THEN 1 END)
      comment: "Count of transactions flagged with data queries — data cleaning workload indicator"
    - name: "distinct_subjects_transacted"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of distinct subjects with IRT transactions — subject engagement metric"
    - name: "distinct_sites_active"
      expr: COUNT(DISTINCT study_site_id)
      comment: "Number of distinct sites with IRT activity — operational site activation metric"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`randomization_rand_validation_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Randomization validation run metrics tracking UAT/validation testing outcomes, defect rates, and sign-off status to ensure IRT system readiness before go-live."
  source: "`clinical_trials_ecm`.`randomization`.`rand_validation_run`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier for validation analysis by clinical trial"
    - name: "run_status"
      expr: run_status
      comment: "Status of the validation run (e.g., passed, failed, in-progress)"
    - name: "run_type"
      expr: run_type
      comment: "Type of validation run (e.g., initial, revalidation, regression)"
    - name: "overall_sign_off_status"
      expr: overall_sign_off_status
      comment: "Sign-off status indicating formal approval of validation results"
    - name: "test_environment"
      expr: test_environment
      comment: "Test environment used (e.g., UAT, staging, production-mirror)"
    - name: "run_month"
      expr: DATE_TRUNC('month', run_date)
      comment: "Month of validation run for timeline tracking"
  measures:
    - name: "total_validation_runs"
      expr: COUNT(1)
      comment: "Total number of randomization validation runs executed"
    - name: "passed_runs"
      expr: COUNT(CASE WHEN run_status = 'passed' THEN 1 END)
      comment: "Count of validation runs that passed — system readiness indicator"
    - name: "failed_runs"
      expr: COUNT(CASE WHEN run_status = 'failed' THEN 1 END)
      comment: "Count of validation runs that failed — identifies system quality issues before go-live"
    - name: "first_pass_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN run_status = 'passed' AND run_type = 'initial' THEN 1 END) / NULLIF(COUNT(CASE WHEN run_type = 'initial' THEN 1 END), 0), 2)
      comment: "Percentage of initial validation runs that pass on first attempt — development quality metric"
    - name: "revalidation_required_count"
      expr: COUNT(CASE WHEN revalidation_required = TRUE THEN 1 END)
      comment: "Count of runs requiring revalidation — change management and regression risk indicator"
    - name: "total_critical_defects"
      expr: SUM(CAST(critical_defects_count AS BIGINT))
      comment: "Total critical defects found across validation runs — blocking issues for go-live"
    - name: "total_major_defects"
      expr: SUM(CAST(major_defects_count AS BIGINT))
      comment: "Total major defects found across validation runs — significant quality issues"
    - name: "signed_off_runs"
      expr: COUNT(CASE WHEN overall_sign_off_status = 'signed_off' OR overall_sign_off_status = 'approved' THEN 1 END)
      comment: "Count of validation runs with formal sign-off — regulatory readiness metric"
    - name: "unblinding_procedure_tested_count"
      expr: COUNT(CASE WHEN unblinding_procedure_tested = TRUE THEN 1 END)
      comment: "Count of runs where unblinding procedures were validated — safety procedure assurance"
$$;