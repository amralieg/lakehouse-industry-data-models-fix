-- Metric views for domain: credential | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 00:30:14

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credentialing application pipeline metrics tracking application volume, cycle times, approval rates, and compliance flags. Supports operational steering of the credentialing intake process."
  source: "`vibe_health_insurance_v1`.`credential`.`application`"
  dimensions:
    - name: "application_type"
      expr: application_type
      comment: "Type of credentialing application (initial, recredential, expedited, etc.) for pipeline segmentation."
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application (pending, approved, denied, withdrawn) for funnel analysis."
    - name: "committee_decision"
      expr: committee_decision
      comment: "Final committee decision on the application for outcome reporting."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the application was submitted (portal, paper, delegated) for channel mix analysis."
    - name: "is_delegated"
      expr: is_delegated
      comment: "Whether the application is processed by a delegated entity, enabling delegated vs. direct volume comparison."
    - name: "is_urgent"
      expr: is_urgent
      comment: "Whether the application was flagged as urgent, supporting expedited queue monitoring."
    - name: "credentialing_cycle_year"
      expr: credentialing_cycle_year
      comment: "Credentialing cycle year for year-over-year trend analysis."
    - name: "ncqa_cycle"
      expr: ncqa_cycle
      comment: "NCQA credentialing cycle designation for regulatory compliance reporting."
    - name: "primary_psv_status"
      expr: primary_psv_status
      comment: "Primary source verification status to segment applications by PSV completion."
    - name: "sanction_screening_status"
      expr: sanction_screening_status
      comment: "Sanction screening status to identify applications with compliance risk."
    - name: "application_month"
      expr: DATE_TRUNC('month', application_date)
      comment: "Month of application submission for trend and seasonality analysis."
    - name: "decision_month"
      expr: DATE_TRUNC('month', decision_date)
      comment: "Month of committee decision for throughput and backlog reporting."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of credentialing applications submitted. Baseline volume KPI for capacity planning and pipeline management."
    - name: "approved_applications"
      expr: COUNT(CASE WHEN application_status = 'approved' THEN 1 END)
      comment: "Count of applications with approved status. Numerator for approval rate calculation."
    - name: "denied_applications"
      expr: COUNT(CASE WHEN application_status = 'denied' THEN 1 END)
      comment: "Count of denied applications. Tracks denial volume for quality and compliance review."
    - name: "pending_applications"
      expr: COUNT(CASE WHEN application_status = 'pending' THEN 1 END)
      comment: "Count of applications still in pending status. Key operational backlog indicator."
    - name: "urgent_applications"
      expr: COUNT(CASE WHEN is_urgent = TRUE THEN 1 END)
      comment: "Count of applications flagged as urgent. Drives expedited queue prioritization."
    - name: "delegated_applications"
      expr: COUNT(CASE WHEN is_delegated = TRUE THEN 1 END)
      comment: "Count of applications processed through delegated entities. Supports delegation oversight."
    - name: "applications_with_sanctions"
      expr: COUNT(CASE WHEN sanction_screening_status NOT IN ('clear', 'passed') AND sanction_screening_status IS NOT NULL THEN 1 END)
      comment: "Count of applications with non-clear sanction screening results. Critical compliance risk indicator."
    - name: "applications_requiring_additional_docs"
      expr: COUNT(CASE WHEN requires_additional_documents = TRUE THEN 1 END)
      comment: "Count of applications requiring additional documentation. Identifies bottlenecks in the intake process."
    - name: "applications_with_malpractice_flag"
      expr: COUNT(CASE WHEN malpractice_history_flag = TRUE THEN 1 END)
      comment: "Count of applications with malpractice history flags. Risk management and quality oversight metric."
    - name: "avg_days_to_decision"
      expr: AVG(DATEDIFF(decision_date, application_date))
      comment: "Average calendar days from application submission to committee decision. Core TAT (turnaround time) KPI for NCQA compliance and operational efficiency."
    - name: "avg_days_to_target_completion"
      expr: AVG(DATEDIFF(target_completion_date, application_date))
      comment: "Average days from application date to target completion date. Measures planned processing window against NCQA 180-day standard."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credentialing record master metrics tracking active credential status, expiration risk, compliance flags, and recredentialing pipeline. The primary governance dashboard for the credentialing program."
  source: "`vibe_health_insurance_v1`.`credential`.`record`"
  dimensions:
    - name: "credential_status"
      expr: credential_status
      comment: "Current status of the credential (active, suspended, revoked, expired) for portfolio health monitoring."
    - name: "credential_type"
      expr: credential_type
      comment: "Type of credential (MD, DO, NP, PA, etc.) for specialty and credential-type segmentation."
    - name: "credential_tier"
      expr: credential_tier
      comment: "Tier classification of the credential for risk stratification."
    - name: "delegated_credential_flag"
      expr: delegated_credential_flag
      comment: "Whether the credential is managed by a delegated entity, enabling delegation oversight reporting."
    - name: "ncqa_compliance_flag"
      expr: ncqa_compliance_flag
      comment: "NCQA compliance indicator for regulatory reporting and accreditation readiness."
    - name: "hospital_privileges_flag"
      expr: hospital_privileges_flag
      comment: "Whether the provider holds hospital privileges, for network adequacy and privileging analysis."
    - name: "malpractice_history_flag"
      expr: malpractice_history_flag
      comment: "Malpractice history indicator for risk-stratified credentialing oversight."
    - name: "sanctions_screened_flag"
      expr: sanctions_screened_flag
      comment: "Whether sanctions screening has been completed, for compliance gap identification."
    - name: "credentialing_committee_outcome"
      expr: credentialing_committee_outcome
      comment: "Committee outcome (approved, denied, deferred) for outcome distribution analysis."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the credential became effective for cohort and vintage analysis."
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month of credential expiration for proactive renewal pipeline management."
    - name: "next_recredentialing_month"
      expr: DATE_TRUNC('month', next_recredentialing_due)
      comment: "Month when recredentialing is due, enabling workload forecasting."
  measures:
    - name: "total_credential_records"
      expr: COUNT(1)
      comment: "Total credentialing records in the system. Baseline for network size and credentialing program scope."
    - name: "active_credentials"
      expr: COUNT(CASE WHEN credential_status = 'active' THEN 1 END)
      comment: "Count of currently active credentials. Core network participation metric."
    - name: "suspended_credentials"
      expr: COUNT(CASE WHEN credential_status = 'suspended' THEN 1 END)
      comment: "Count of suspended credentials. Operational risk and compliance alert metric."
    - name: "revoked_credentials"
      expr: COUNT(CASE WHEN credential_status = 'revoked' THEN 1 END)
      comment: "Count of revoked credentials. Critical compliance and patient safety indicator."
    - name: "credentials_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Credentials expiring within 90 days. Proactive renewal pipeline KPI to prevent lapses."
    - name: "credentials_past_expiration"
      expr: COUNT(CASE WHEN expiration_date < CURRENT_DATE AND credential_status = 'active' THEN 1 END)
      comment: "Active credentials past their expiration date. Critical compliance gap indicator requiring immediate action."
    - name: "ncqa_compliant_credentials"
      expr: COUNT(CASE WHEN ncqa_compliance_flag = TRUE THEN 1 END)
      comment: "Count of credentials meeting NCQA compliance requirements. Accreditation readiness metric."
    - name: "credentials_with_malpractice_history"
      expr: COUNT(CASE WHEN malpractice_history_flag = TRUE THEN 1 END)
      comment: "Count of credentialed providers with malpractice history. Risk portfolio management metric."
    - name: "credentials_pending_recredentialing"
      expr: COUNT(CASE WHEN next_recredentialing_due <= DATE_ADD(CURRENT_DATE, 180) AND credential_status = 'active' THEN 1 END)
      comment: "Active credentials due for recredentialing within 180 days. Workload planning and NCQA cycle management KPI."
    - name: "delegated_credentials"
      expr: COUNT(CASE WHEN delegated_credential_flag = TRUE THEN 1 END)
      comment: "Count of credentials managed through delegated entities. Delegation program scope metric."
    - name: "credentials_sanctions_not_screened"
      expr: COUNT(CASE WHEN sanctions_screened_flag = FALSE OR sanctions_screened_flag IS NULL THEN 1 END)
      comment: "Credentials without completed sanctions screening. Compliance gap metric requiring remediation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_recredential_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recredentialing cycle performance metrics tracking cycle completion rates, TAT, escalation rates, and outreach effectiveness. Supports NCQA 3-year cycle compliance and operational throughput management."
  source: "`vibe_health_insurance_v1`.`credential`.`recredential_cycle`"
  dimensions:
    - name: "cycle_status"
      expr: cycle_status
      comment: "Current status of the recredentialing cycle (open, in-progress, complete, overdue) for pipeline monitoring."
    - name: "cycle_type"
      expr: cycle_type
      comment: "Type of recredentialing cycle (standard, expedited, delegated) for workload segmentation."
    - name: "cycle_priority"
      expr: cycle_priority
      comment: "Priority level of the cycle for queue management and resource allocation."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the cycle has been escalated, for escalation rate monitoring."
    - name: "cycle_due_month"
      expr: DATE_TRUNC('month', cycle_due_date)
      comment: "Month the cycle is due for workload forecasting and capacity planning."
    - name: "cycle_start_year"
      expr: YEAR(cycle_start_date)
      comment: "Year the recredentialing cycle started for cohort and trend analysis."
  measures:
    - name: "total_recredential_cycles"
      expr: COUNT(1)
      comment: "Total recredentialing cycles initiated. Baseline volume for capacity planning."
    - name: "completed_cycles"
      expr: COUNT(CASE WHEN cycle_status = 'complete' THEN 1 END)
      comment: "Count of completed recredentialing cycles. Throughput KPI for operational performance."
    - name: "overdue_cycles"
      expr: COUNT(CASE WHEN cycle_due_date < CURRENT_DATE AND cycle_status != 'complete' THEN 1 END)
      comment: "Cycles past their due date without completion. Critical NCQA compliance risk indicator."
    - name: "escalated_cycles"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Count of escalated recredentialing cycles. Operational risk and exception management metric."
    - name: "avg_cycle_duration_days"
      expr: AVG(DATEDIFF(cycle_completion_date, cycle_start_date))
      comment: "Average days to complete a recredentialing cycle. Core TAT KPI benchmarked against NCQA 180-day standard."
    - name: "avg_outreach_attempts"
      expr: AVG(CAST(outreach_attempt_count AS DOUBLE))
      comment: "Average number of outreach attempts per cycle. Measures provider responsiveness and outreach efficiency."
    - name: "cycles_with_application_received"
      expr: COUNT(CASE WHEN application_received_date IS NOT NULL THEN 1 END)
      comment: "Cycles where the provider has returned the application. Measures application return rate for pipeline health."
    - name: "avg_days_from_due_to_completion"
      expr: AVG(DATEDIFF(cycle_completion_date, cycle_due_date))
      comment: "Average days between cycle due date and actual completion. Positive values indicate late completions; negative values indicate early completions."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_sanction_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sanction screening program metrics tracking screening volume, hit rates, severity distribution, and resolution status. Critical compliance and patient safety dashboard for OIG/SAM/state exclusion monitoring."
  source: "`vibe_health_insurance_v1`.`credential`.`sanction_screening`"
  dimensions:
    - name: "screening_result"
      expr: screening_result
      comment: "Result of the sanction screening (clear, match, potential match) for hit rate analysis."
    - name: "overall_status"
      expr: overall_status
      comment: "Overall screening status for pipeline and compliance reporting."
    - name: "sanction_type"
      expr: sanction_type
      comment: "Type of sanction identified (exclusion, debarment, license action) for risk categorization."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the sanction finding for risk-stratified response management."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the sanction finding for open-item tracking."
    - name: "screening_event_type"
      expr: screening_event_type
      comment: "Type of screening event (initial, routine, triggered) for event-type analysis."
    - name: "sanctioning_authority"
      expr: sanctioning_authority
      comment: "Authority that issued the sanction (OIG, SAM, state board) for source analysis."
    - name: "screening_month"
      expr: DATE_TRUNC('month', screening_timestamp)
      comment: "Month of screening event for trend and volume analysis."
    - name: "impact_on_credential_status"
      expr: impact_on_credential_status
      comment: "Impact of the sanction on the provider's credential status for downstream action tracking."
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total sanction screenings performed. Baseline compliance program activity metric."
    - name: "screenings_with_matches"
      expr: COUNT(CASE WHEN screening_result IN ('match', 'potential match') THEN 1 END)
      comment: "Count of screenings returning a match or potential match. Numerator for sanction hit rate."
    - name: "screenings_clear"
      expr: COUNT(CASE WHEN screening_result = 'clear' THEN 1 END)
      comment: "Count of screenings returning a clear result. Denominator complement for hit rate analysis."
    - name: "high_severity_findings"
      expr: COUNT(CASE WHEN severity_level IN ('high', 'critical') THEN 1 END)
      comment: "Count of high or critical severity sanction findings. Immediate escalation and patient safety metric."
    - name: "unresolved_sanction_findings"
      expr: COUNT(CASE WHEN resolution_status NOT IN ('resolved', 'closed') AND screening_result IN ('match', 'potential match') THEN 1 END)
      comment: "Count of unresolved sanction matches. Open compliance risk requiring active remediation."
    - name: "screenings_impacting_credential_status"
      expr: COUNT(CASE WHEN impact_on_credential_status IS NOT NULL AND impact_on_credential_status != 'none' THEN 1 END)
      comment: "Screenings that resulted in a change to credential status. Measures downstream compliance enforcement effectiveness."
    - name: "distinct_providers_screened"
      expr: COUNT(DISTINCT record_id)
      comment: "Count of distinct credentialing records screened. Measures breadth of sanction screening program coverage."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_psv_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Primary Source Verification (PSV) metrics tracking verification completion rates, element-level pass rates, and expiration risk. Core NCQA credentialing standard compliance dashboard."
  source: "`vibe_health_insurance_v1`.`credential`.`psv_verification`"
  dimensions:
    - name: "credential_element_type"
      expr: credential_element_type
      comment: "Type of credential element being verified (license, board cert, DEA, malpractice) for element-level analysis."
    - name: "element_category"
      expr: element_category
      comment: "Category of the credential element for grouping and compliance reporting."
    - name: "element_status"
      expr: element_status
      comment: "Current status of the credential element (active, expired, suspended) for portfolio health."
    - name: "verification_result"
      expr: verification_result
      comment: "Result of the PSV verification (verified, failed, pending) for pass rate analysis."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used for verification (online, phone, written) for process efficiency analysis."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the credential being verified for source-level analysis."
    - name: "verification_month"
      expr: DATE_TRUNC('month', verification_date)
      comment: "Month of verification for trend and throughput analysis."
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month of element expiration for proactive renewal pipeline management."
  measures:
    - name: "total_psv_verifications"
      expr: COUNT(1)
      comment: "Total PSV verification events performed. Baseline activity metric for the PSV program."
    - name: "verified_elements"
      expr: COUNT(CASE WHEN verification_result = 'verified' THEN 1 END)
      comment: "Count of successfully verified credential elements. Numerator for PSV pass rate."
    - name: "failed_verifications"
      expr: COUNT(CASE WHEN verification_result = 'failed' THEN 1 END)
      comment: "Count of failed PSV verifications. Critical quality and compliance risk indicator."
    - name: "pending_verifications"
      expr: COUNT(CASE WHEN verification_result = 'pending' THEN 1 END)
      comment: "Count of PSV verifications still pending. Backlog and TAT management metric."
    - name: "elements_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Credential elements expiring within 90 days. Proactive renewal pipeline KPI."
    - name: "distinct_providers_with_psv"
      expr: COUNT(DISTINCT record_id)
      comment: "Count of distinct credentialing records with at least one PSV verification. Measures PSV program coverage breadth."
    - name: "total_malpractice_insurance_limit"
      expr: SUM(CAST(malpractice_insurance_limit AS DOUBLE))
      comment: "Total malpractice insurance coverage limit across verified providers. Risk exposure portfolio metric."
    - name: "avg_malpractice_insurance_limit"
      expr: AVG(CAST(malpractice_insurance_limit AS DOUBLE))
      comment: "Average malpractice insurance limit per verification record. Benchmarks coverage adequacy against plan requirements."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_committee_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credentialing committee review metrics tracking decision throughput, compliance flag rates, denial rates, and quorum compliance. Supports governance oversight of the credentialing committee process."
  source: "`vibe_health_insurance_v1`.`credential`.`committee_review`"
  dimensions:
    - name: "committee_review_status"
      expr: committee_review_status
      comment: "Status of the committee review (pending, complete, deferred) for pipeline monitoring."
    - name: "decision_type"
      expr: decision_type
      comment: "Type of committee decision (approve, deny, defer, provisional) for outcome distribution analysis."
    - name: "review_type"
      expr: review_type
      comment: "Type of review (initial, recredential, appeal, expedited) for workload segmentation."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for denial decisions for root cause and pattern analysis."
    - name: "quorum_indicator"
      expr: quorum_indicator
      comment: "Whether quorum was achieved for the meeting. Governance compliance metric."
    - name: "compliance_flag_oig_sanction"
      expr: compliance_flag_oig_sanction
      comment: "OIG sanction compliance flag for risk-stratified review analysis."
    - name: "compliance_flag_state_license_valid"
      expr: compliance_flag_state_license_valid
      comment: "State license validity compliance flag for licensing compliance monitoring."
    - name: "meeting_month"
      expr: DATE_TRUNC('month', meeting_timestamp)
      comment: "Month of committee meeting for throughput trend analysis."
    - name: "decision_effective_month"
      expr: DATE_TRUNC('month', decision_effective_date)
      comment: "Month the decision becomes effective for downstream network impact analysis."
  measures:
    - name: "total_committee_reviews"
      expr: COUNT(1)
      comment: "Total committee reviews conducted. Baseline governance activity metric."
    - name: "approved_reviews"
      expr: COUNT(CASE WHEN decision_type = 'approve' THEN 1 END)
      comment: "Count of committee approvals. Numerator for committee approval rate."
    - name: "denied_reviews"
      expr: COUNT(CASE WHEN decision_type = 'deny' THEN 1 END)
      comment: "Count of committee denials. Quality and risk management metric."
    - name: "deferred_reviews"
      expr: COUNT(CASE WHEN decision_type = 'defer' THEN 1 END)
      comment: "Count of deferred decisions. Measures committee decisiveness and backlog creation."
    - name: "reviews_with_oig_sanction_flag"
      expr: COUNT(CASE WHEN compliance_flag_oig_sanction = TRUE THEN 1 END)
      comment: "Reviews where OIG sanction compliance flag was raised. Critical patient safety and compliance metric."
    - name: "reviews_without_quorum"
      expr: COUNT(CASE WHEN quorum_indicator = FALSE THEN 1 END)
      comment: "Reviews conducted without quorum. Governance compliance risk indicator."
    - name: "total_providers_reviewed"
      expr: SUM(CAST(total_providers_reviewed AS DOUBLE))
      comment: "Total number of providers reviewed across all committee sessions. Throughput and capacity metric."
    - name: "avg_providers_per_meeting"
      expr: AVG(CAST(total_providers_reviewed AS DOUBLE))
      comment: "Average providers reviewed per committee meeting. Capacity utilization and efficiency metric."
    - name: "reviews_with_license_compliance_issue"
      expr: COUNT(CASE WHEN compliance_flag_state_license_valid = FALSE THEN 1 END)
      comment: "Reviews where state license validity was flagged as non-compliant. Regulatory risk metric."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_delegation_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delegation oversight audit metrics tracking compliance rates, corrective action requirements, and audit disposition. Supports NCQA delegation oversight program governance."
  source: "`vibe_health_insurance_v1`.`credential`.`delegation_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the delegation audit (scheduled, in-progress, complete) for pipeline monitoring."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of delegation audit (initial, annual, for-cause) for audit program analysis."
    - name: "audit_disposition"
      expr: audit_disposition
      comment: "Final disposition of the audit (pass, fail, conditional) for compliance outcome reporting."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether a corrective action plan was required. Key delegation compliance risk indicator."
    - name: "audit_year"
      expr: audit_year
      comment: "Year of the audit for year-over-year compliance trend analysis."
    - name: "audit_month"
      expr: DATE_TRUNC('month', audit_date)
      comment: "Month of audit for scheduling and throughput analysis."
  measures:
    - name: "total_delegation_audits"
      expr: COUNT(1)
      comment: "Total delegation audits conducted. Baseline oversight program activity metric."
    - name: "audits_passed"
      expr: COUNT(CASE WHEN audit_disposition = 'pass' THEN 1 END)
      comment: "Count of audits with passing disposition. Numerator for delegation compliance rate."
    - name: "audits_failed"
      expr: COUNT(CASE WHEN audit_disposition = 'fail' THEN 1 END)
      comment: "Count of failed delegation audits. Critical oversight and corrective action trigger metric."
    - name: "audits_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of audits requiring a corrective action plan. Delegation risk management metric."
    - name: "avg_compliance_rate"
      expr: AVG(CAST(overall_compliance_rate AS DOUBLE))
      comment: "Average overall compliance rate across delegation audits. Portfolio-level delegation quality metric."
    - name: "distinct_delegated_entities_audited"
      expr: COUNT(DISTINCT delegated_entity_id)
      comment: "Count of distinct delegated entities audited. Measures breadth of delegation oversight program coverage."
    - name: "corrective_actions_past_due"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE AND corrective_action_due_date < CURRENT_DATE THEN 1 END)
      comment: "Corrective action plans past their due date. Escalation and compliance enforcement metric."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_npdb_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NPDB (National Practitioner Data Bank) query metrics tracking query volume, report rates, malpractice exposure, and HCQIA compliance. Supports credentialing risk management and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`credential`.`npdb_query`"
  dimensions:
    - name: "npdb_query_status"
      expr: npdb_query_status
      comment: "Status of the NPDB query (submitted, response received, pending) for pipeline monitoring."
    - name: "query_type"
      expr: query_type
      comment: "Type of NPDB query (one-time, continuous enrollment) for query program analysis."
    - name: "hcqia_compliance_flag"
      expr: hcqia_compliance_flag
      comment: "Whether the query meets HCQIA compliance requirements. Regulatory compliance indicator."
    - name: "is_continuous_enrollment"
      expr: is_continuous_enrollment
      comment: "Whether the provider is enrolled in continuous NPDB monitoring. Ongoing surveillance coverage metric."
    - name: "internal_review_disposition"
      expr: internal_review_disposition
      comment: "Internal disposition of NPDB report findings for downstream action tracking."
    - name: "query_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month of NPDB query submission for trend and volume analysis."
  measures:
    - name: "total_npdb_queries"
      expr: COUNT(1)
      comment: "Total NPDB queries submitted. Baseline credentialing compliance activity metric."
    - name: "queries_with_reports"
      expr: COUNT(CASE WHEN CAST(number_of_reports AS INT) > 0 THEN 1 END)
      comment: "Count of NPDB queries returning at least one report. Numerator for NPDB hit rate."
    - name: "hcqia_compliant_queries"
      expr: COUNT(CASE WHEN hcqia_compliance_flag = TRUE THEN 1 END)
      comment: "Count of queries meeting HCQIA compliance requirements. Regulatory compliance metric."
    - name: "continuous_enrollment_providers"
      expr: COUNT(CASE WHEN is_continuous_enrollment = TRUE THEN 1 END)
      comment: "Count of providers enrolled in continuous NPDB monitoring. Ongoing surveillance coverage metric."
    - name: "total_malpractice_exposure"
      expr: SUM(CAST(total_malpractice_amount AS DOUBLE))
      comment: "Total malpractice payment amounts reported via NPDB. Portfolio-level financial risk exposure metric."
    - name: "avg_malpractice_amount_per_query"
      expr: AVG(CAST(total_malpractice_amount AS DOUBLE))
      comment: "Average malpractice payment amount per NPDB query. Per-provider risk benchmarking metric."
    - name: "distinct_providers_queried"
      expr: COUNT(DISTINCT record_id)
      comment: "Count of distinct credentialing records with NPDB queries. Measures NPDB program coverage."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_expedited_credential`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Expedited credentialing metrics tracking provisional approval rates, urgency distribution, and outcome quality. Supports governance of the expedited credentialing exception process."
  source: "`vibe_health_insurance_v1`.`credential`.`expedited_credential`"
  dimensions:
    - name: "expedited_credential_status"
      expr: expedited_credential_status
      comment: "Current status of the expedited credentialing request for pipeline monitoring."
    - name: "expedited_reason_code"
      expr: expedited_reason_code
      comment: "Reason code for the expedited request (clinical urgency, new hire, locum) for exception analysis."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level of the expedited request for prioritization and resource allocation."
    - name: "final_credentialing_outcome"
      expr: final_credentialing_outcome
      comment: "Final outcome of the expedited credentialing process for quality and risk analysis."
    - name: "psv_verification_flag"
      expr: psv_verification_flag
      comment: "Whether PSV was completed before provisional approval. Compliance risk indicator."
    - name: "sanction_screening_flag"
      expr: sanction_screening_flag
      comment: "Whether sanction screening was completed. Patient safety compliance indicator."
    - name: "request_month"
      expr: DATE_TRUNC('month', request_timestamp)
      comment: "Month of expedited credentialing request for trend and volume analysis."
  measures:
    - name: "total_expedited_requests"
      expr: COUNT(1)
      comment: "Total expedited credentialing requests. Baseline exception process volume metric."
    - name: "expedited_with_psv_completed"
      expr: COUNT(CASE WHEN psv_verification_flag = TRUE THEN 1 END)
      comment: "Expedited requests where PSV was completed prior to provisional approval. Compliance quality metric."
    - name: "expedited_without_sanction_screening"
      expr: COUNT(CASE WHEN sanction_screening_flag = FALSE OR sanction_screening_flag IS NULL THEN 1 END)
      comment: "Expedited approvals without completed sanction screening. Critical patient safety risk metric."
    - name: "total_provisional_fee_amount"
      expr: SUM(CAST(provisional_fee_amount AS DOUBLE))
      comment: "Total provisional credentialing fees collected. Financial performance metric for the expedited program."
    - name: "avg_provisional_duration_days"
      expr: AVG(CAST(provisional_duration_days AS DOUBLE))
      comment: "Average provisional credentialing duration in days. Measures exposure window for provisionally credentialed providers."
    - name: "avg_days_to_outcome"
      expr: AVG(DATEDIFF(outcome_date, request_timestamp))
      comment: "Average days from expedited request to final outcome. TAT metric for the expedited credentialing process."
    - name: "malpractice_flagged_expedited"
      expr: COUNT(CASE WHEN malpractice_history_flag = TRUE THEN 1 END)
      comment: "Expedited requests for providers with malpractice history. Risk concentration metric for exception approvals."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_credential_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credentialing appeal metrics tracking appeal volume, outcomes, escalation rates, and financial exposure. Supports due process compliance and governance of the credentialing appeals program."
  source: "`vibe_health_insurance_v1`.`credential`.`credential_appeal`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal (pending, in-review, decided, withdrawn) for pipeline monitoring."
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal (denial, suspension, revocation) for outcome analysis by appeal category."
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Outcome of the appeal decision (upheld, overturned, modified) for quality and fairness analysis."
    - name: "original_decision_type"
      expr: original_decision_type
      comment: "Type of original decision being appealed for root cause analysis."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the appeal was escalated. Governance risk and due process compliance indicator."
    - name: "hearing_panel_type"
      expr: hearing_panel_type
      comment: "Type of hearing panel convened for the appeal for process analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month of appeal submission for trend and volume analysis."
  measures:
    - name: "total_credential_appeals"
      expr: COUNT(1)
      comment: "Total credentialing appeals filed. Baseline due process activity metric."
    - name: "appeals_overturned"
      expr: COUNT(CASE WHEN decision_outcome = 'overturned' THEN 1 END)
      comment: "Count of appeals where the original decision was overturned. Quality of initial credentialing decisions metric."
    - name: "appeals_upheld"
      expr: COUNT(CASE WHEN decision_outcome = 'upheld' THEN 1 END)
      comment: "Count of appeals where the original decision was upheld. Measures consistency of credentialing decisions."
    - name: "escalated_appeals"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Count of escalated appeals. Governance risk and due process compliance metric."
    - name: "total_appeal_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total appeal fees collected. Financial performance metric for the appeals program."
    - name: "avg_days_to_appeal_decision"
      expr: AVG(DATEDIFF(decision_date, submission_timestamp))
      comment: "Average days from appeal submission to decision. TAT metric benchmarked against regulatory due process requirements."
    - name: "appeals_past_review_deadline"
      expr: COUNT(CASE WHEN review_deadline < CURRENT_DATE AND appeal_status NOT IN ('decided', 'withdrawn') THEN 1 END)
      comment: "Open appeals past their review deadline. Critical regulatory compliance and due process risk metric."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_cvo_relationship`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CVO (Credentialing Verification Organization) relationship metrics tracking NCQA certification status, contract compliance, and financial terms. Supports vendor governance of delegated credentialing verification."
  source: "`vibe_health_insurance_v1`.`credential`.`cvo_relationship`"
  dimensions:
    - name: "cvo_relationship_status"
      expr: cvo_relationship_status
      comment: "Current status of the CVO relationship (active, terminated, under review) for portfolio monitoring."
    - name: "relationship_type"
      expr: relationship_type
      comment: "Type of CVO relationship (full delegation, partial, oversight only) for scope analysis."
    - name: "ncqa_certified"
      expr: ncqa_certified
      comment: "Whether the CVO holds NCQA certification. Critical quality and compliance indicator."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Whether the CVO relationship is exclusive. Contract governance metric."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Compliance flag for the CVO relationship. Risk and oversight indicator."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of CVO contract for contract portfolio analysis."
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year the CVO relationship became effective for cohort analysis."
    - name: "ncqa_expiration_month"
      expr: DATE_TRUNC('month', ncqa_certification_expiration)
      comment: "Month of NCQA certification expiration for proactive renewal management."
  measures:
    - name: "total_cvo_relationships"
      expr: COUNT(1)
      comment: "Total CVO relationships. Baseline vendor portfolio metric."
    - name: "active_cvo_relationships"
      expr: COUNT(CASE WHEN cvo_relationship_status = 'active' THEN 1 END)
      comment: "Count of active CVO relationships. Current vendor portfolio size metric."
    - name: "ncqa_certified_cvos"
      expr: COUNT(CASE WHEN ncqa_certified = TRUE THEN 1 END)
      comment: "Count of CVO relationships with NCQA-certified vendors. Quality assurance metric for delegation oversight."
    - name: "cvos_with_expiring_ncqa_cert"
      expr: COUNT(CASE WHEN ncqa_certification_expiration BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "CVOs with NCQA certification expiring within 90 days. Proactive compliance risk management metric."
    - name: "total_cvo_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total CVO contract fees. Financial spend management metric for credentialing vendor program."
    - name: "avg_cvo_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average CVO contract fee. Benchmarking metric for vendor contract negotiations."
    - name: "cvo_relationships_with_compliance_flag"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "CVO relationships with active compliance flags. Vendor risk management metric."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_obligation_mapping`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credentialing obligation mapping metrics tracking compliance status, obligation type distribution, and expiration risk. Supports regulatory obligation fulfillment monitoring for the credentialing program. (VREQ-024 stub-fix: full data attributes derived from business context.)"
  source: "`vibe_health_insurance_v1`.`credential`.`obligation_mapping`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory or contractual obligation mapped to the credential record (NCQA, state, CMS, etc.)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the obligation mapping (compliant, non-compliant, pending review)."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the obligation mapping became effective for cohort analysis."
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the obligation mapping expires for proactive renewal management."
  measures:
    - name: "total_obligation_mappings"
      expr: COUNT(1)
      comment: "Total obligation mappings across all credential records. Baseline regulatory compliance program scope metric."
    - name: "compliant_obligation_mappings"
      expr: COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END)
      comment: "Count of obligation mappings in compliant status. Numerator for obligation compliance rate."
    - name: "non_compliant_obligation_mappings"
      expr: COUNT(CASE WHEN compliance_status = 'non-compliant' THEN 1 END)
      comment: "Count of non-compliant obligation mappings. Critical regulatory risk indicator requiring remediation."
    - name: "obligation_mappings_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Obligation mappings expiring within 90 days. Proactive compliance renewal pipeline metric."
    - name: "distinct_records_with_obligations"
      expr: COUNT(DISTINCT record_id)
      comment: "Count of distinct credential records with at least one obligation mapping. Measures regulatory obligation coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credentialing audit finding metrics tracking finding volume, severity distribution, resolution rates, and compliance risk. Supports quality improvement and corrective action management. (VREQ-024 stub-fix: full data attributes derived from business context.)"
  source: "`vibe_health_insurance_v1`.`credential`.`finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of credentialing finding (documentation gap, PSV failure, sanction, license issue) for root cause analysis."
    - name: "finding_severity"
      expr: finding_severity
      comment: "Severity of the finding (critical, high, medium, low) for risk-stratified response management."
    - name: "severity_level"
      expr: severity_level
      comment: "Detailed severity level classification for granular risk analysis."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the finding (open, in-progress, resolved, closed) for open-item tracking."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the finding has a compliance implication. Regulatory risk indicator."
    - name: "finding_month"
      expr: DATE_TRUNC('month', finding_date)
      comment: "Month the finding was identified for trend and volume analysis."
    - name: "identified_month"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month the finding was formally identified for detection lag analysis."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total credentialing findings identified. Baseline quality and compliance program metric."
    - name: "critical_findings"
      expr: COUNT(CASE WHEN finding_severity IN ('critical', 'high') THEN 1 END)
      comment: "Count of critical or high severity findings. Immediate escalation and patient safety metric."
    - name: "open_findings"
      expr: COUNT(CASE WHEN resolution_status IN ('open', 'in-progress') THEN 1 END)
      comment: "Count of unresolved findings. Open compliance risk requiring active remediation."
    - name: "resolved_findings"
      expr: COUNT(CASE WHEN resolution_status IN ('resolved', 'closed') THEN 1 END)
      comment: "Count of resolved findings. Numerator for finding resolution rate."
    - name: "compliance_flagged_findings"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Findings with regulatory compliance implications. Compliance risk portfolio metric."
    - name: "distinct_records_with_findings"
      expr: COUNT(DISTINCT record_id)
      comment: "Count of distinct credential records with at least one finding. Measures breadth of quality issues across the provider portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_contract_link`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credential-to-contract linkage metrics tracking contract coverage, link status, and expiration risk. Supports governance of the relationship between credentialing records and vendor/provider contracts. (VREQ-024 stub-fix: full data attributes derived from business context.)"
  source: "`vibe_health_insurance_v1`.`credential`.`contract_link`"
  dimensions:
    - name: "link_status"
      expr: link_status
      comment: "Current status of the credential-contract link (active, expired, terminated) for portfolio monitoring."
    - name: "contract_role"
      expr: contract_role
      comment: "Role of the credential in the contract context (primary, secondary, delegated) for relationship analysis."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the contract link became effective for cohort analysis."
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the contract link expires for proactive renewal management."
  measures:
    - name: "total_contract_links"
      expr: COUNT(1)
      comment: "Total credential-to-contract links. Baseline metric for contract coverage of the credentialed provider network."
    - name: "active_contract_links"
      expr: COUNT(CASE WHEN link_status = 'active' THEN 1 END)
      comment: "Count of active credential-contract links. Current contract coverage metric."
    - name: "contract_links_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Contract links expiring within 90 days. Proactive contract renewal pipeline metric."
    - name: "distinct_records_with_contract_links"
      expr: COUNT(DISTINCT record_id)
      comment: "Count of distinct credential records with at least one active contract link. Measures contract coverage breadth across the credentialed network."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credentialing appeal metrics tracking appeal volume, outcomes, escalation patterns, and resolution timeliness to monitor due process compliance and provider dispute management."
  source: "`vibe_health_insurance_v1`.`credential`.`credential_appeal`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal (e.g., Open, Under Review, Resolved)."
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal filed (e.g., Denial, Termination, Suspension)."
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Final outcome of the appeal decision (e.g., Upheld, Overturned, Modified)."
    - name: "original_decision_type"
      expr: original_decision_type
      comment: "Original credentialing decision being appealed."
    - name: "hearing_panel_type"
      expr: hearing_panel_type
      comment: "Type of hearing panel convened for the appeal."
    - name: "escalation_flag"
      expr: CAST(escalation_flag AS STRING)
      comment: "Whether the appeal has been escalated."
    - name: "submission_year_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month the appeal was submitted for trend analysis."
  measures:
    - name: "total_appeals"
      expr: COUNT(1)
      comment: "Total credentialing appeals filed — measures dispute volume and due process workload."
    - name: "overturned_count"
      expr: COUNT(CASE WHEN decision_outcome = 'Overturned' THEN 1 END)
      comment: "Appeals where original decision was overturned — indicates potential quality issues in initial credentialing decisions."
    - name: "overturn_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision_outcome = 'Overturned' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appeals resulting in overturned decisions — quality indicator for initial credentialing process."
    - name: "escalated_appeal_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated appeals — indicates complex or high-risk disputes."
    - name: "total_appeal_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total appeal fee amounts — financial impact of the appeals process."
    - name: "avg_days_to_decision"
      expr: AVG(CAST(DATEDIFF(decision_date, CAST(submission_timestamp AS DATE)) AS DOUBLE))
      comment: "Average days from appeal submission to decision — due process timeliness metric."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credential lifecycle event metrics tracking status transitions, escalation patterns, risk scoring, and critical event volumes to monitor credentialing workflow health and compliance posture."
  source: "`vibe_health_insurance_v1`.`credential`.`credential_lifecycle_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of lifecycle event (e.g., Status Change, Verification Complete, Expiration Warning)."
    - name: "event_category"
      expr: event_category
      comment: "Category of the lifecycle event for aggregate analysis."
    - name: "new_status"
      expr: new_status
      comment: "New credential status after the event."
    - name: "prior_status"
      expr: prior_status
      comment: "Credential status before the event."
    - name: "is_critical"
      expr: CAST(is_critical AS STRING)
      comment: "Whether the event is classified as critical requiring immediate attention."
    - name: "is_escalated"
      expr: CAST(is_escalated AS STRING)
      comment: "Whether the event triggered an escalation."
    - name: "compliance_flag"
      expr: CAST(compliance_flag AS STRING)
      comment: "Whether the event has compliance implications."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the lifecycle event."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the event."
    - name: "event_year_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the event for trend analysis."
  measures:
    - name: "total_lifecycle_events"
      expr: COUNT(1)
      comment: "Total credential lifecycle events — measures overall credentialing workflow activity volume."
    - name: "critical_event_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical lifecycle events — immediate risk and attention indicator."
    - name: "critical_event_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events classified as critical — overall credentialing risk intensity metric."
    - name: "escalated_event_count"
      expr: COUNT(CASE WHEN is_escalated = TRUE THEN 1 END)
      comment: "Number of escalated events — measures process bottlenecks and exception handling volume."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_escalated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events requiring escalation — operational efficiency and exception rate indicator."
    - name: "compliance_flagged_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events with compliance implications — regulatory risk exposure metric."
    - name: "unresolved_event_count"
      expr: COUNT(CASE WHEN resolution_status != 'Resolved' OR resolution_status IS NULL THEN 1 END)
      comment: "Lifecycle events not yet resolved — open work items requiring follow-up."
    - name: "avg_resolution_time_days"
      expr: AVG(CAST(DATEDIFF(resolution_timestamp, event_timestamp) AS DOUBLE))
      comment: "Average days from event occurrence to resolution — operational responsiveness metric."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_outreach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credentialing outreach metrics tracking communication volume, response rates, SLA adherence, and outreach effectiveness to optimize provider engagement during the credentialing process."
  source: "`vibe_health_insurance_v1`.`credential`.`credential_outreach`"
  dimensions:
    - name: "credential_outreach_status"
      expr: credential_outreach_status
      comment: "Current status of the outreach attempt."
    - name: "outreach_type"
      expr: outreach_type
      comment: "Type of outreach (e.g., Document Request, Follow-up, Reminder)."
    - name: "outreach_method"
      expr: outreach_method
      comment: "Method of outreach (e.g., Email, Phone, Fax, Mail)."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the outreach attempt (e.g., Responded, No Response, Partial)."
    - name: "priority"
      expr: priority
      comment: "Priority level of the outreach."
    - name: "sla_met"
      expr: CAST(sla_met AS STRING)
      comment: "Whether the outreach SLA was met."
    - name: "outreach_year_month"
      expr: DATE_TRUNC('month', outreach_timestamp)
      comment: "Month of outreach for trend analysis."
  measures:
    - name: "total_outreach_attempts"
      expr: COUNT(1)
      comment: "Total outreach attempts — measures communication volume and provider engagement effort."
    - name: "response_received_count"
      expr: COUNT(CASE WHEN response_received_date IS NOT NULL THEN 1 END)
      comment: "Outreach attempts that received a response — measures provider responsiveness."
    - name: "response_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN response_received_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach attempts receiving a response — provider engagement effectiveness metric."
    - name: "sla_met_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outreach attempts meeting SLA targets — operational timeliness and compliance metric."
    - name: "avg_response_time_days"
      expr: AVG(CAST(DATEDIFF(response_received_date, CAST(outreach_timestamp AS DATE)) AS DOUBLE))
      comment: "Average days from outreach to provider response — measures provider engagement speed."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`credential_delegated_entity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delegated entity metrics tracking delegation program size, compliance posture, audit readiness, and NCQA accreditation status for oversight of outsourced credentialing functions."
  source: "`vibe_health_insurance_v1`.`credential`.`delegated_entity`"
  dimensions:
    - name: "delegated_entity_status"
      expr: delegated_entity_status
      comment: "Current status of the delegated entity (e.g., Active, Terminated, Under Review)."
    - name: "delegation_type"
      expr: delegation_type
      comment: "Type of delegation arrangement (e.g., Full, Partial)."
    - name: "delegation_scope"
      expr: delegation_scope
      comment: "Scope of delegated credentialing activities."
    - name: "ncqa_accreditation_status"
      expr: ncqa_accreditation_status
      comment: "NCQA accreditation status of the delegated entity."
    - name: "audit_result"
      expr: audit_result
      comment: "Result of the most recent oversight audit."
    - name: "organization_name"
      expr: organization_name
      comment: "Name of the delegated credentialing organization."
  measures:
    - name: "total_delegated_entities"
      expr: COUNT(1)
      comment: "Total delegated entities — measures delegation program scope and oversight burden."
    - name: "active_delegated_entities"
      expr: COUNT(CASE WHEN delegated_entity_status = 'Active' THEN 1 END)
      comment: "Number of currently active delegated entities."
    - name: "ncqa_accredited_count"
      expr: COUNT(CASE WHEN ncqa_accreditation_status = 'Accredited' THEN 1 END)
      comment: "Delegated entities with NCQA accreditation — quality assurance indicator."
    - name: "ncqa_accreditation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncqa_accreditation_status = 'Accredited' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delegated entities with NCQA accreditation — delegation quality and compliance readiness metric."
    - name: "overdue_audit_count"
      expr: COUNT(CASE WHEN last_audit_date IS NOT NULL AND DATEDIFF(CURRENT_DATE(), last_audit_date) > 365 THEN 1 END)
      comment: "Delegated entities with audits older than 12 months — oversight compliance gap indicator."
    - name: "terminated_entity_count"
      expr: COUNT(CASE WHEN delegated_entity_status = 'Terminated' THEN 1 END)
      comment: "Number of terminated delegated entities — monitors delegation program churn and risk events."
$$;