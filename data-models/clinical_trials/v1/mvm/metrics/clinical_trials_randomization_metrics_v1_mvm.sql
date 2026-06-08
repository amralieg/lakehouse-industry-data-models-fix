-- Metric views for domain: randomization | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-07 02:29:00

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`randomization_subject_randomization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core randomization event metrics tracking subject assignment throughput, eligibility confirmation rates, unblinding incidence, and rerandomization activity. This is the primary operational KPI surface for randomization performance across studies and sites."
  source: "`clinical_trials_ecm`.`randomization`.`subject_randomization`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier — primary grouping dimension for all randomization KPIs to enable cross-study benchmarking."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Site identifier — enables site-level randomization performance analysis and identification of under-enrolling sites."
    - name: "randomization_status"
      expr: randomization_status
      comment: "Current status of the randomization event (e.g., Randomized, Cancelled, Pending) — used to filter active vs. failed randomizations."
    - name: "randomization_type"
      expr: randomization_type
      comment: "Type of randomization (e.g., Initial, Re-randomization) — distinguishes first-time assignments from protocol-driven re-assignments."
    - name: "randomization_method"
      expr: randomization_method
      comment: "Algorithm used for randomization (e.g., Permuted Block, Minimization) — supports method-level quality and balance analysis."
    - name: "treatment_arm_id"
      expr: treatment_arm_id
      comment: "Treatment arm assigned — enables allocation balance monitoring across arms."
    - name: "blinding_type"
      expr: blinding_type
      comment: "Blinding level applied at randomization (e.g., Double-blind, Open-label) — contextualizes unblinding risk metrics."
    - name: "country_code"
      expr: country_code
      comment: "Country of the randomization event — supports geographic enrollment and compliance analysis."
    - name: "randomization_month"
      expr: DATE_TRUNC('MONTH', randomization_date)
      comment: "Month of randomization — enables trend analysis of enrollment velocity over time."
    - name: "randomization_year"
      expr: DATE_TRUNC('YEAR', randomization_date)
      comment: "Year of randomization — supports annual enrollment target tracking."
    - name: "irt_system_name"
      expr: irt_system_name
      comment: "IRT/RTSM system used to execute the randomization — supports system-level reliability and error rate analysis."
    - name: "source_system"
      expr: source_system
      comment: "Source system originating the randomization record — supports data lineage and reconciliation."
    - name: "stratification_cell_id"
      expr: stratification_cell_id
      comment: "Stratification cell assigned — enables balance monitoring across stratification strata."
    - name: "epoch_id"
      expr: epoch_id
      comment: "Study epoch of the randomization — supports epoch-level enrollment tracking in multi-period trials."
  measures:
    - name: "total_randomizations"
      expr: COUNT(1)
      comment: "Total number of randomization events. Baseline throughput KPI used to track enrollment velocity against study targets."
    - name: "unique_randomized_subjects"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Count of distinct subjects who have been randomized. Directly measures enrollment progress toward study sample size targets — a primary executive KPI."
    - name: "unique_randomized_sites"
      expr: COUNT(DISTINCT study_site_id)
      comment: "Count of distinct sites that have randomized at least one subject. Indicates site activation effectiveness and geographic spread of enrollment."
    - name: "confirmed_eligible_randomizations"
      expr: COUNT(CASE WHEN eligibility_confirmed = TRUE THEN 1 END)
      comment: "Number of randomizations where eligibility was formally confirmed prior to assignment. Measures protocol compliance at the point of randomization."
    - name: "eligibility_confirmation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN eligibility_confirmed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of randomizations with confirmed eligibility. A compliance KPI — low rates signal eligibility verification process failures that risk data integrity and regulatory findings."
    - name: "cancelled_randomizations"
      expr: COUNT(CASE WHEN randomization_status = 'Cancelled' THEN 1 END)
      comment: "Number of randomization events that were cancelled. Elevated cancellation rates indicate IRT system issues, eligibility failures, or site process problems requiring intervention."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN randomization_status = 'Cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of randomization events that were cancelled. A quality KPI — high rates trigger investigation of site training, IRT configuration, or eligibility screening processes."
    - name: "unblinded_subjects"
      expr: COUNT(CASE WHEN is_unblinded = TRUE THEN 1 END)
      comment: "Number of subjects whose randomization assignment has been unblinded. A critical safety and data integrity KPI — unexpected unblinding events require immediate sponsor and regulatory notification."
    - name: "unblinding_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_unblinded = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of randomized subjects who have been unblinded. Benchmarked against protocol-expected unblinding rates; excess unblinding threatens trial integrity and may require regulatory disclosure."
    - name: "rerandomizations"
      expr: COUNT(CASE WHEN randomization_type = 'Re-randomization' THEN 1 END)
      comment: "Count of re-randomization events. Tracks protocol deviations or adaptive design re-assignments; elevated counts may indicate eligibility or IRT process failures."
    - name: "rerandomization_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN randomization_type = 'Re-randomization' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of randomization events that are re-randomizations. Monitors protocol adherence — high rates may signal systemic eligibility screening or IRT configuration issues."
    - name: "avg_stratification_factor_1_value"
      expr: AVG(CAST(stratification_factor_1_value AS DOUBLE))
      comment: "Average value of stratification factor 1 across randomized subjects. Monitors balance of the primary stratification variable across the randomized population — imbalance triggers adaptive allocation review."
    - name: "avg_stratification_factor_2_value"
      expr: AVG(CAST(stratification_factor_2_value AS DOUBLE))
      comment: "Average value of stratification factor 2 across randomized subjects. Monitors balance of the secondary stratification variable — supports statistical analysis plan compliance."
    - name: "avg_stratification_factor_3_value"
      expr: AVG(CAST(stratification_factor_3_value AS DOUBLE))
      comment: "Average value of stratification factor 3 across randomized subjects. Monitors balance of the tertiary stratification variable — supports SAP compliance and DSMB reporting."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`randomization_irt_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IRT/RTSM system transaction metrics covering dispensing activity, query flags, SDV compliance, and transaction failure rates. Provides operational visibility into IRT system performance and drug dispensing execution quality."
  source: "`clinical_trials_ecm`.`randomization`.`irt_transaction`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier — primary grouping for IRT transaction analysis across studies."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Site identifier — enables site-level IRT transaction quality and dispensing compliance monitoring."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of IRT transaction (e.g., Randomization, Dispensing, Return, Cancellation) — segments transaction volume by operational category."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the IRT transaction (e.g., Completed, Failed, Pending) — used to isolate failed transactions for root cause analysis."
    - name: "transaction_outcome"
      expr: transaction_outcome
      comment: "Outcome of the IRT transaction — provides granular success/failure classification beyond status."
    - name: "irt_system_name"
      expr: irt_system_name
      comment: "Name of the IRT/RTSM system — enables cross-system performance benchmarking."
    - name: "blinding_status"
      expr: blinding_status
      comment: "Blinding status at the time of the transaction — monitors blinding integrity across dispensing events."
    - name: "randomization_method"
      expr: randomization_method
      comment: "Randomization method applied in the transaction — supports method-level quality analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the transaction — supports geographic dispensing compliance analysis."
    - name: "kit_type"
      expr: kit_type
      comment: "Type of investigational kit dispensed — enables kit-level dispensing volume and failure analysis."
    - name: "dispensing_month"
      expr: DATE_TRUNC('MONTH', dispensing_date)
      comment: "Month of dispensing — enables trend analysis of dispensing activity over time."
    - name: "epoch_id"
      expr: epoch_id
      comment: "Study epoch of the transaction — supports epoch-level dispensing activity tracking."
    - name: "treatment_arm_id"
      expr: treatment_arm_id
      comment: "Treatment arm associated with the transaction — enables arm-level dispensing balance monitoring."
    - name: "operator_role"
      expr: operator_role
      comment: "Role of the operator executing the transaction — supports training compliance and role-based error analysis."
  measures:
    - name: "total_irt_transactions"
      expr: COUNT(1)
      comment: "Total IRT transaction volume. Baseline operational throughput KPI for IRT system activity monitoring."
    - name: "unique_subjects_dispensed"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Count of distinct subjects who received at least one IRT dispensing transaction. Measures active treatment coverage across the trial population."
    - name: "unique_sites_transacting"
      expr: COUNT(DISTINCT study_site_id)
      comment: "Count of distinct sites with IRT transaction activity. Monitors site-level IRT engagement and identifies inactive sites."
    - name: "failed_transactions"
      expr: COUNT(CASE WHEN transaction_status = 'Failed' THEN 1 END)
      comment: "Number of failed IRT transactions. A critical system reliability KPI — high failure rates indicate IRT configuration issues, connectivity problems, or training gaps requiring immediate remediation."
    - name: "transaction_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN transaction_status = 'Failed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IRT transactions that failed. Benchmarked against SLA thresholds; excess failure rates trigger IRT vendor escalation and may delay subject dosing."
    - name: "electronically_signed_transactions"
      expr: COUNT(CASE WHEN electronic_signature_flag = TRUE THEN 1 END)
      comment: "Number of transactions with electronic signatures captured. Measures 21 CFR Part 11 / Annex 11 compliance for electronic records — a regulatory audit KPI."
    - name: "electronic_signature_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN electronic_signature_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IRT transactions with electronic signatures. Regulatory compliance KPI — gaps trigger GCP findings and may require paper-based remediation."
    - name: "sdv_completed_transactions"
      expr: COUNT(CASE WHEN sdv_flag = TRUE THEN 1 END)
      comment: "Number of IRT transactions with source data verification completed. Measures monitoring visit compliance and data quality assurance coverage."
    - name: "sdv_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sdv_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IRT transactions with SDV completed. A monitoring quality KPI — low rates indicate CRA visit backlogs or risk-based monitoring gaps."
    - name: "query_flagged_transactions"
      expr: COUNT(CASE WHEN query_flag = TRUE THEN 1 END)
      comment: "Number of IRT transactions with open data queries. Elevated query rates signal data entry errors, IRT configuration issues, or site training deficiencies."
    - name: "query_flag_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN query_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of IRT transactions with data queries raised. A data quality KPI — high rates increase database lock timelines and regulatory submission risk."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`randomization_kit_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investigational kit assignment and dispensing compliance metrics covering dispensing confirmation rates, protocol deviation incidence, temperature excursion events, and return compliance. Directly supports supply chain quality and GCP compliance monitoring."
  source: "`clinical_trials_ecm`.`randomization`.`kit_assignment`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier — primary grouping for kit assignment analysis."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Site identifier — enables site-level dispensing compliance and deviation monitoring."
    - name: "treatment_arm_id"
      expr: treatment_arm_id
      comment: "Treatment arm of the kit assignment — supports arm-level dispensing balance and compliance analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the kit assignment (e.g., Assigned, Dispensed, Returned, Cancelled) — segments kit lifecycle stages."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of kit assignment (e.g., Initial, Replacement, Rescue) — distinguishes standard from exception dispensing events."
    - name: "kit_type"
      expr: kit_type
      comment: "Type of investigational kit — enables kit-type-level compliance and deviation analysis."
    - name: "blinding_status"
      expr: blinding_status
      comment: "Blinding status of the kit assignment — monitors blinding integrity at the dispensing level."
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form of the dispensed kit — supports formulation-level dispensing analysis."
    - name: "dose_level"
      expr: dose_level
      comment: "Dose level dispensed — enables dose-level compliance and protocol adherence monitoring."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration for the dispensed kit — supports protocol compliance monitoring by administration route."
    - name: "return_status"
      expr: return_status
      comment: "Status of kit return (e.g., Returned, Pending, Not Required) — monitors drug accountability compliance."
    - name: "dispensing_month"
      expr: DATE_TRUNC('MONTH', dispensing_date)
      comment: "Month of dispensing — enables trend analysis of dispensing activity and compliance over time."
    - name: "irt_system_name"
      expr: irt_system_name
      comment: "IRT system used for the kit assignment — supports system-level dispensing quality analysis."
  measures:
    - name: "total_kit_assignments"
      expr: COUNT(1)
      comment: "Total number of kit assignment records. Baseline dispensing throughput KPI for supply chain and IRT operations."
    - name: "unique_subjects_assigned_kits"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Count of distinct subjects who have been assigned investigational kits. Measures active treatment coverage and supply utilization breadth."
    - name: "dispensing_confirmed_count"
      expr: COUNT(CASE WHEN dispensing_confirmed = TRUE THEN 1 END)
      comment: "Number of kit assignments with dispensing confirmed in the IRT system. Measures drug accountability compliance — unconfirmed dispensing events are a GCP finding."
    - name: "dispensing_confirmation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispensing_confirmed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of kit assignments with dispensing confirmed. A critical drug accountability KPI — rates below 100% trigger site investigation and may require regulatory disclosure."
    - name: "protocol_deviation_assignments"
      expr: COUNT(CASE WHEN protocol_deviation_flag = TRUE THEN 1 END)
      comment: "Number of kit assignments associated with a protocol deviation. Measures dispensing-related GCP compliance failures — elevated counts trigger CAPA and regulatory reporting obligations."
    - name: "protocol_deviation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN protocol_deviation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of kit assignments with protocol deviations. A regulatory compliance KPI — high rates at a site or study level trigger sponsor and IRB/IEC notification requirements."
    - name: "temperature_excursion_assignments"
      expr: COUNT(CASE WHEN temperature_excursion_flag = TRUE THEN 1 END)
      comment: "Number of kit assignments with temperature excursion events recorded. Measures cold chain compliance failures — excursions may render investigational product unusable and require QA disposition."
    - name: "temperature_excursion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_excursion_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of kit assignments with temperature excursions. A supply quality KPI — high rates indicate depot or site storage failures requiring immediate corrective action."
    - name: "compliance_kit_assignments"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Number of kit assignments meeting all compliance criteria. Measures overall dispensing process quality — the complement of deviation and excursion events."
    - name: "overall_dispensing_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of kit assignments fully compliant with protocol requirements. A composite quality KPI used in sponsor oversight dashboards and regulatory inspection readiness assessments."
    - name: "unblinded_kit_assignments"
      expr: COUNT(CASE WHEN unblinding_date IS NOT NULL THEN 1 END)
      comment: "Number of kit assignments where unblinding has occurred. Monitors blinding integrity at the dispensing level — unexpected unblinding events require immediate sponsor notification."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`randomization_unblinding_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Unblinding request lifecycle metrics covering request volume, urgency distribution, approval cycle times, DSMB referral rates, and blinding breach incidence. A critical safety and regulatory compliance KPI surface for sponsor oversight and inspection readiness."
  source: "`clinical_trials_ecm`.`randomization`.`unblinding_request`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier — primary grouping for unblinding request analysis across studies."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Site identifier — enables site-level unblinding request pattern analysis."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the unblinding request (e.g., Submitted, Approved, Rejected, Withdrawn) — segments requests by lifecycle stage."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification of the unblinding request (e.g., Emergency, Urgent, Routine) — critical for SLA monitoring and safety signal detection."
    - name: "unblinding_reason"
      expr: unblinding_reason
      comment: "Stated reason for the unblinding request — enables root cause analysis of unblinding drivers (SAE, SUSAR, protocol deviation)."
    - name: "unblinding_scope"
      expr: unblinding_scope
      comment: "Scope of the unblinding request (e.g., Single Subject, Cohort, Full Study) — distinguishes individual safety events from systemic unblinding."
    - name: "requestor_role"
      expr: requestor_role
      comment: "Role of the person submitting the unblinding request — supports role-based compliance and training analysis."
    - name: "final_outcome"
      expr: final_outcome
      comment: "Final decision outcome of the unblinding request (e.g., Approved, Rejected, Withdrawn) — measures approval rate and decision patterns."
    - name: "source_system"
      expr: source_system
      comment: "Source system originating the unblinding request — supports data lineage and reconciliation."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month the unblinding request was submitted — enables trend analysis of unblinding request frequency over time."
    - name: "treatment_arm_id"
      expr: treatment_arm_id
      comment: "Treatment arm associated with the unblinding request — monitors arm-level unblinding incidence for safety signal detection."
  measures:
    - name: "total_unblinding_requests"
      expr: COUNT(1)
      comment: "Total number of unblinding requests submitted. Baseline safety and compliance KPI — elevated request volumes signal safety signals or site process failures requiring sponsor escalation."
    - name: "unique_subjects_with_unblinding_requests"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Count of distinct subjects with at least one unblinding request. Measures the breadth of blinding integrity risk across the trial population."
    - name: "emergency_unblinding_requests"
      expr: COUNT(CASE WHEN urgency_level = 'Emergency' THEN 1 END)
      comment: "Number of emergency unblinding requests. A critical patient safety KPI — each emergency request requires immediate sponsor and potentially regulatory authority notification."
    - name: "emergency_unblinding_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN urgency_level = 'Emergency' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of unblinding requests classified as emergency. Benchmarked against protocol-expected rates; excess emergency rates may indicate safety signals requiring DSMB review."
    - name: "approved_unblinding_requests"
      expr: COUNT(CASE WHEN final_outcome = 'Approved' THEN 1 END)
      comment: "Number of unblinding requests that received final approval. Measures actual blinding breaches — each approved request represents a confirmed unblinding event with regulatory implications."
    - name: "unblinding_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN final_outcome = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of unblinding requests that were approved. Monitors the proportion of requests resulting in actual blinding breaches — a key trial integrity KPI."
    - name: "blinding_broken_events"
      expr: COUNT(CASE WHEN blinding_broken_flag = TRUE THEN 1 END)
      comment: "Number of requests where blinding was definitively broken. The most critical unblinding integrity KPI — each event requires regulatory disclosure and may impact trial validity."
    - name: "blinding_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN blinding_broken_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of unblinding requests resulting in a confirmed blinding breach. A regulatory inspection readiness KPI — rates above protocol thresholds trigger DSMB review and potential trial suspension."
    - name: "dsmb_dmc_referrals"
      expr: COUNT(CASE WHEN dsmb_dmc_referral_flag = TRUE THEN 1 END)
      comment: "Number of unblinding requests escalated to the DSMB/DMC. Measures the volume of safety events requiring independent committee oversight — a governance and patient safety KPI."
    - name: "dsmb_referral_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dsmb_dmc_referral_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of unblinding requests referred to the DSMB/DMC. Monitors the severity distribution of unblinding events and DSMB workload — elevated rates may signal emerging safety concerns."
    - name: "irb_iec_notification_required_count"
      expr: COUNT(CASE WHEN irb_iec_notification_required = TRUE THEN 1 END)
      comment: "Number of unblinding requests requiring IRB/IEC notification. Measures regulatory notification obligations arising from unblinding events — non-compliance with notification requirements is a critical GCP finding."
    - name: "protocol_deviations_raised_from_unblinding"
      expr: COUNT(CASE WHEN protocol_deviation_raised = TRUE THEN 1 END)
      comment: "Number of unblinding requests that triggered a protocol deviation. Measures the downstream compliance impact of unblinding events — each deviation requires CAPA and may require regulatory reporting."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`randomization_unblinding_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Unblinding approval decision metrics covering approval turnaround times, GCP compliance confirmation rates, emergency unblinding incidence, and IRB/IEC notification compliance. Supports sponsor oversight, inspection readiness, and safety governance."
  source: "`clinical_trials_ecm`.`randomization`.`unblinding_approval`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier — primary grouping for unblinding approval analysis."
    - name: "study_site_id"
      expr: study_site_id
      comment: "Site identifier — enables site-level approval compliance and turnaround analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Current status of the unblinding approval (e.g., Approved, Rejected, Pending) — segments approvals by decision outcome."
    - name: "approval_level"
      expr: approval_level
      comment: "Level of approval authority (e.g., Medical Monitor, Sponsor, Regulatory) — supports governance and escalation analysis."
    - name: "approver_role"
      expr: approver_role
      comment: "Role of the approver — enables role-based compliance and delegation of authority analysis."
    - name: "unblinding_reason_category"
      expr: unblinding_reason_category
      comment: "Categorized reason for unblinding (e.g., SAE, SUSAR, Protocol Deviation) — supports root cause analysis of unblinding drivers."
    - name: "emergency_unblinding"
      expr: emergency_unblinding
      comment: "Flag indicating whether the approval was for an emergency unblinding — critical for SLA and patient safety monitoring."
    - name: "blinding_maintained"
      expr: blinding_maintained
      comment: "Flag indicating whether blinding was maintained despite the approval process — monitors blinding integrity outcomes."
    - name: "source_system"
      expr: source_system
      comment: "Source system of the approval record — supports data lineage and audit trail completeness."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_timestamp)
      comment: "Month of the approval decision — enables trend analysis of unblinding approval activity over time."
  measures:
    - name: "total_unblinding_approvals"
      expr: COUNT(1)
      comment: "Total number of unblinding approval decisions. Baseline governance KPI for unblinding oversight activity volume."
    - name: "unique_subjects_with_approvals"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Count of distinct subjects with unblinding approval decisions. Measures the breadth of blinding integrity events across the trial population."
    - name: "emergency_unblinding_approvals"
      expr: COUNT(CASE WHEN emergency_unblinding = TRUE THEN 1 END)
      comment: "Number of approvals for emergency unblinding events. A patient safety KPI — each emergency approval represents a critical safety event requiring immediate regulatory notification."
    - name: "emergency_unblinding_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN emergency_unblinding = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of unblinding approvals classified as emergency. Monitors the severity distribution of approved unblinding events — elevated rates signal safety signal escalation requirements."
    - name: "gcp_compliant_approvals"
      expr: COUNT(CASE WHEN gcp_compliance_confirmed = TRUE THEN 1 END)
      comment: "Number of unblinding approvals with GCP compliance confirmed. Measures regulatory compliance at the approval decision level — non-compliant approvals are a critical inspection finding."
    - name: "gcp_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gcp_compliance_confirmed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of unblinding approvals with GCP compliance confirmed. A regulatory inspection readiness KPI — rates below 100% require immediate CAPA and may trigger regulatory authority notification."
    - name: "irb_iec_notification_required_approvals"
      expr: COUNT(CASE WHEN irb_iec_notification_required = TRUE THEN 1 END)
      comment: "Number of approvals requiring IRB/IEC notification. Measures the regulatory notification burden arising from unblinding approvals — non-compliance with notification timelines is a GCP violation."
    - name: "irb_iec_notified_approvals"
      expr: COUNT(CASE WHEN notification_sent = TRUE THEN 1 END)
      comment: "Number of approvals where IRB/IEC notification was actually sent. Measures notification compliance execution — gaps between required and sent notifications are regulatory findings."
    - name: "irb_iec_notification_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN notification_sent = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN irb_iec_notification_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required IRB/IEC notifications that were actually sent. A critical regulatory compliance KPI — rates below 100% represent GCP violations requiring immediate remediation and regulatory disclosure."
    - name: "avg_approval_response_time_hours"
      expr: AVG(CAST(response_time_hours AS DOUBLE))
      comment: "Average time in hours from unblinding request to approval decision. A governance efficiency KPI — benchmarked against protocol-defined SLAs; excess response times for emergency unblinding events are patient safety risks."
    - name: "blinding_maintained_post_approval"
      expr: COUNT(CASE WHEN blinding_maintained = TRUE THEN 1 END)
      comment: "Number of approval decisions where blinding was maintained despite the approval process. Measures the effectiveness of blinding protection procedures — a trial integrity KPI."
    - name: "blinding_maintenance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN blinding_maintained = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of unblinding approval events where blinding was ultimately maintained. Monitors the effectiveness of blinding protection protocols — a key trial integrity and regulatory submission quality KPI."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`randomization_rand_scheme`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Randomization scheme design and governance metrics covering scheme activation rates, stratification complexity, regulatory submission compliance, and IRT system alignment. Supports protocol design quality and regulatory readiness assessment."
  source: "`clinical_trials_ecm`.`randomization`.`rand_scheme`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier — primary grouping for randomization scheme analysis."
    - name: "scheme_status"
      expr: scheme_status
      comment: "Current status of the randomization scheme (e.g., Active, Retired, Draft) — segments schemes by lifecycle stage."
    - name: "blinding_type"
      expr: blinding_type
      comment: "Blinding type of the scheme (e.g., Double-blind, Single-blind, Open-label) — enables blinding strategy analysis across studies."
    - name: "allocation_algorithm"
      expr: allocation_algorithm
      comment: "Randomization algorithm used (e.g., Permuted Block, Minimization, Simple) — supports algorithm-level quality and balance analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the scheme (e.g., Global, Regional, Country-specific) — supports geographic stratification analysis."
    - name: "generation_software"
      expr: generation_software
      comment: "Software used to generate the randomization scheme — supports validation and audit trail analysis."
    - name: "is_centralized"
      expr: is_centralized
      comment: "Flag indicating whether the scheme uses centralized randomization — distinguishes centralized IRT from site-level randomization."
    - name: "is_stratified_by_site"
      expr: is_stratified_by_site
      comment: "Flag indicating site-stratified randomization — monitors use of site stratification which impacts balance analysis."
    - name: "is_variable_block"
      expr: is_variable_block
      comment: "Flag indicating variable block size randomization — monitors use of variable blocks which affects unblinding risk."
    - name: "activation_year"
      expr: DATE_TRUNC('YEAR', activation_date)
      comment: "Year of scheme activation — enables trend analysis of scheme deployment over time."
  measures:
    - name: "total_rand_schemes"
      expr: COUNT(1)
      comment: "Total number of randomization schemes. Baseline governance KPI for scheme portfolio management."
    - name: "active_rand_schemes"
      expr: COUNT(CASE WHEN scheme_status = 'Active' THEN 1 END)
      comment: "Number of currently active randomization schemes. Measures the operational scheme portfolio — supports IRT configuration management and study oversight."
    - name: "regulatory_submission_schemes"
      expr: COUNT(CASE WHEN regulatory_submission_flag = TRUE THEN 1 END)
      comment: "Number of schemes flagged for regulatory submission. Measures the regulatory documentation burden — each submission scheme requires validated documentation for health authority review."
    - name: "regulatory_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_submission_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of randomization schemes requiring regulatory submission. A regulatory readiness KPI — monitors the proportion of schemes with formal submission obligations."
    - name: "irb_iec_approval_required_schemes"
      expr: COUNT(CASE WHEN irb_iec_approval_required = TRUE THEN 1 END)
      comment: "Number of schemes requiring IRB/IEC approval. Measures the ethics committee approval workload — schemes without required approvals cannot be activated without GCP violations."
    - name: "stratified_schemes"
      expr: COUNT(CASE WHEN is_stratified_by_site = TRUE THEN 1 END)
      comment: "Number of schemes using site-level stratification. Monitors the prevalence of site-stratified designs — relevant for balance analysis and statistical power assessments."
    - name: "avg_minimization_probability"
      expr: AVG(CAST(minimization_probability AS DOUBLE))
      comment: "Average minimization probability across minimization-based randomization schemes. Monitors the balance-randomness tradeoff in minimization designs — a statistical design quality KPI reviewed by biostatistics leadership."
    - name: "total_randomization_slots_sum"
      expr: COUNT(1)
      comment: "Count of randomization scheme records as a proxy for scheme portfolio size. Used for scheme portfolio governance and IRT capacity planning."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`randomization_stratification_cell`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stratification cell enrollment balance metrics tracking actual vs. target enrollment, cell balance status, and enrollment closure rates. Directly supports DSMB reporting, adaptive randomization oversight, and statistical analysis plan compliance."
  source: "`clinical_trials_ecm`.`randomization`.`stratification_cell`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier — primary grouping for stratification cell analysis."
    - name: "rand_scheme_id"
      expr: rand_scheme_id
      comment: "Randomization scheme identifier — enables scheme-level stratification balance analysis."
    - name: "treatment_arm_id"
      expr: treatment_arm_id
      comment: "Treatment arm associated with the cell — enables arm-level stratification balance monitoring."
    - name: "cell_status"
      expr: cell_status
      comment: "Current status of the stratification cell (e.g., Open, Closed, Suspended) — segments cells by enrollment availability."
    - name: "cell_balance_status"
      expr: cell_balance_status
      comment: "Balance status of the cell (e.g., Balanced, Imbalanced, At Risk) — a primary DSMB and sponsor oversight KPI dimension."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the stratification cell — enables regional balance analysis."
    - name: "randomization_method"
      expr: randomization_method
      comment: "Randomization method applied within the cell — supports method-level balance analysis."
    - name: "is_active_for_enrollment"
      expr: is_active_for_enrollment
      comment: "Flag indicating whether the cell is currently open for enrollment — distinguishes active from closed cells."
    - name: "is_primary_defining_factor"
      expr: is_primary_defining_factor
      comment: "Flag indicating whether this cell is defined by the primary stratification factor — supports primary vs. secondary factor balance analysis."
    - name: "enrollment_open_month"
      expr: DATE_TRUNC('MONTH', enrollment_open_date)
      comment: "Month enrollment opened for the cell — enables trend analysis of cell activation over time."
  measures:
    - name: "total_stratification_cells"
      expr: COUNT(1)
      comment: "Total number of stratification cells defined. Baseline governance KPI for stratification design complexity."
    - name: "active_enrollment_cells"
      expr: COUNT(CASE WHEN is_active_for_enrollment = TRUE THEN 1 END)
      comment: "Number of stratification cells currently open for enrollment. Monitors enrollment capacity across the stratification design — closed cells may indicate enrollment completion or protocol-driven suspension."
    - name: "avg_balance_tolerance_pct"
      expr: AVG(CAST(balance_tolerance_pct AS DOUBLE))
      comment: "Average balance tolerance percentage across stratification cells. Monitors the stringency of balance requirements in the randomization design — a statistical design quality KPI reviewed by biostatistics."
    - name: "avg_factor_level_value"
      expr: AVG(CAST(factor_level_value AS DOUBLE))
      comment: "Average factor level value across stratification cells. Monitors the distribution of stratification factor values — supports balance assessment and SAP compliance."
    - name: "avg_sdtm_stratum_value"
      expr: AVG(CAST(sdtm_stratum_value AS DOUBLE))
      comment: "Average SDTM stratum value across cells. Supports CDISC SDTM submission compliance monitoring — a regulatory data standards KPI."
    - name: "imbalanced_cells"
      expr: COUNT(CASE WHEN cell_balance_status = 'Imbalanced' THEN 1 END)
      comment: "Number of stratification cells with imbalanced enrollment. A critical statistical integrity KPI — imbalanced cells reduce statistical power and may require adaptive allocation adjustments reviewed by the DSMB."
    - name: "cell_imbalance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cell_balance_status = 'Imbalanced' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stratification cells with enrollment imbalance. Benchmarked against protocol-defined tolerance thresholds — excess imbalance rates trigger adaptive randomization review and DSMB notification."
    - name: "closed_enrollment_cells"
      expr: COUNT(CASE WHEN cell_status = 'Closed' THEN 1 END)
      comment: "Number of stratification cells closed for enrollment. Monitors enrollment completion progress across the stratification design — supports study closeout planning."
    - name: "enrollment_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cell_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stratification cells closed for enrollment. A study completion KPI — high closure rates indicate enrollment target achievement and support database lock planning."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`randomization_treatment_arm`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Treatment arm design and allocation metrics covering arm portfolio composition, blinding configuration, allocation target compliance, and regulatory submission readiness. Supports protocol design governance and sponsor oversight."
  source: "`clinical_trials_ecm`.`randomization`.`treatment_arm`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Study identifier — primary grouping for treatment arm analysis."
    - name: "arm_status"
      expr: arm_status
      comment: "Current status of the treatment arm (e.g., Active, Suspended, Completed) — segments arms by operational state."
    - name: "arm_type"
      expr: arm_type
      comment: "Type of treatment arm (e.g., Experimental, Control, Placebo) — enables arm-type-level analysis."
    - name: "randomization_method"
      expr: randomization_method
      comment: "Randomization method applied to the arm — supports method-level allocation analysis."
    - name: "dose_level"
      expr: dose_level
      comment: "Dose level of the treatment arm — enables dose-level allocation and safety analysis."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of administration for the arm — supports protocol compliance monitoring by administration route."
    - name: "is_control_arm"
      expr: is_control_arm
      comment: "Flag indicating whether the arm is a control arm — distinguishes experimental from control arms for allocation balance analysis."
    - name: "is_blinded_to_investigator"
      expr: is_blinded_to_investigator
      comment: "Flag indicating investigator blinding — monitors blinding configuration compliance at the arm level."
    - name: "is_blinded_to_subject"
      expr: is_blinded_to_subject
      comment: "Flag indicating subject blinding — monitors subject-level blinding configuration compliance."
    - name: "regulatory_submission_flag"
      expr: regulatory_submission_flag
      comment: "Flag indicating regulatory submission requirement for the arm — supports regulatory documentation planning."
    - name: "arm_start_year"
      expr: DATE_TRUNC('YEAR', arm_start_date)
      comment: "Year the treatment arm opened — enables trend analysis of arm activation over time."
  measures:
    - name: "total_treatment_arms"
      expr: COUNT(1)
      comment: "Total number of treatment arms defined. Baseline governance KPI for trial design complexity — more arms increase IRT configuration and supply chain complexity."
    - name: "active_treatment_arms"
      expr: COUNT(CASE WHEN arm_status = 'Active' THEN 1 END)
      comment: "Number of currently active treatment arms. Monitors operational arm portfolio — suspended or completed arms reduce enrollment capacity and may require protocol amendment."
    - name: "blinded_to_investigator_arms"
      expr: COUNT(CASE WHEN is_blinded_to_investigator = TRUE THEN 1 END)
      comment: "Number of arms with investigator blinding enforced. Measures blinding configuration compliance — arms without required investigator blinding represent GCP violations."
    - name: "investigator_blinding_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_blinded_to_investigator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of treatment arms with investigator blinding. A protocol compliance KPI — rates below protocol-specified blinding requirements trigger regulatory findings."
    - name: "regulatory_submission_arms"
      expr: COUNT(CASE WHEN regulatory_submission_flag = TRUE THEN 1 END)
      comment: "Number of treatment arms requiring regulatory submission documentation. Measures the regulatory documentation burden for the trial arm portfolio."
    - name: "avg_target_allocation_pct"
      expr: AVG(CAST(target_allocation_pct AS DOUBLE))
      comment: "Average target allocation percentage across treatment arms. Monitors the intended allocation balance — deviations from equal allocation require statistical justification in the SAP."
    - name: "avg_sdtm_arm_value"
      expr: AVG(CAST(sdtm_arm_value AS DOUBLE))
      comment: "Average SDTM arm value across treatment arms. Supports CDISC SDTM submission compliance monitoring — a regulatory data standards KPI for submission readiness."
    - name: "control_arms"
      expr: COUNT(CASE WHEN is_control_arm = TRUE THEN 1 END)
      comment: "Number of control arms in the trial design. Monitors the control arm portfolio — absence of control arms in confirmatory trials is a regulatory concern."
    - name: "suspended_arms"
      expr: COUNT(CASE WHEN arm_status = 'Suspended' THEN 1 END)
      comment: "Number of suspended treatment arms. A safety and operational KPI — arm suspensions may indicate safety signals, supply failures, or protocol amendments requiring regulatory notification."
$$;