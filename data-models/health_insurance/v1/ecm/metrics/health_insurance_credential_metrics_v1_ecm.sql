-- Metric views for domain: credential | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 18:36:19

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`credential_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credentialing application metrics tracking volume, processing efficiency, urgency, and delegation patterns to monitor intake pipeline health and compliance readiness."
  source: "`health_insurance_ecm`.`credential`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the credentialing application (e.g., Pending, Approved, Denied)."
    - name: "application_type"
      expr: application_type
      comment: "Type of credentialing application (e.g., Initial, Recredentialing)."
    - name: "committee_decision"
      expr: committee_decision
      comment: "Decision rendered by the credentialing committee."
    - name: "credentialing_cycle_year"
      expr: credentialing_cycle_year
      comment: "Year of the credentialing cycle for annual cohort analysis."
    - name: "ncqa_cycle"
      expr: ncqa_cycle
      comment: "NCQA accreditation cycle associated with the application."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the application was submitted (e.g., Portal, Fax, Mail)."
    - name: "is_delegated"
      expr: CAST(is_delegated AS STRING)
      comment: "Whether the application is processed through a delegated credentialing entity."
    - name: "is_urgent"
      expr: CAST(is_urgent AS STRING)
      comment: "Whether the application is flagged as urgent/expedited."
    - name: "sanction_screening_status"
      expr: sanction_screening_status
      comment: "Status of OIG/SAM sanction screening for the applicant."
    - name: "primary_psv_status"
      expr: primary_psv_status
      comment: "Status of primary source verification for the application."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the credentialing application."
    - name: "application_year"
      expr: YEAR(application_date)
      comment: "Year the application was submitted for trend analysis."
    - name: "application_month"
      expr: DATE_TRUNC('month', application_date)
      comment: "Month the application was submitted for trend analysis."
    - name: "source_system"
      expr: source_system
      comment: "Originating system of record for the application."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of credentialing applications submitted — baseline volume metric for pipeline capacity planning."
    - name: "urgent_application_count"
      expr: COUNT(CASE WHEN is_urgent = TRUE THEN 1 END)
      comment: "Number of applications flagged as urgent, indicating network access pressure or clinical need."
    - name: "delegated_application_count"
      expr: COUNT(CASE WHEN is_delegated = TRUE THEN 1 END)
      comment: "Number of applications processed via delegated entities — monitors delegation volume and oversight burden."
    - name: "malpractice_flagged_count"
      expr: COUNT(CASE WHEN malpractice_history_flag = TRUE THEN 1 END)
      comment: "Applications with malpractice history flags requiring additional review — risk indicator."
    - name: "pending_additional_docs_count"
      expr: COUNT(CASE WHEN requires_additional_documents = TRUE THEN 1 END)
      comment: "Applications awaiting additional documentation — bottleneck indicator for processing throughput."
    - name: "hospital_privileges_verified_count"
      expr: COUNT(CASE WHEN hospital_privileges_verified = TRUE THEN 1 END)
      comment: "Applications with verified hospital privileges — completeness indicator for PSV workflow."
    - name: "avg_days_to_decision"
      expr: AVG(CAST(DATEDIFF(decision_date, application_date) AS DOUBLE))
      comment: "Average calendar days from application submission to committee decision — key TAT metric for NCQA compliance (typically ≤180 days)."
    - name: "avg_days_to_target_completion"
      expr: AVG(CAST(DATEDIFF(target_completion_date, application_date) AS DOUBLE))
      comment: "Average planned processing window in days — measures scheduling efficiency and SLA adherence."
    - name: "urgent_application_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_urgent = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications flagged as urgent — monitors network access pressure and expedited processing demand."
    - name: "delegated_application_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_delegated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications handled by delegated entities — tracks delegation utilization and oversight requirements."
    - name: "malpractice_flag_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN malpractice_history_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications with malpractice history — risk exposure indicator for credentialing committee."
    - name: "distinct_provider_count"
      expr: COUNT(DISTINCT provider_id)
      comment: "Unique providers with applications in pipeline — measures network onboarding breadth."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`credential_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credentialing record metrics tracking provider credential status, compliance posture, recredentialing timeliness, and risk indicators across the credentialed provider population."
  source: "`health_insurance_ecm`.`credential`.`record`"
  dimensions:
    - name: "credential_status"
      expr: credential_status
      comment: "Current status of the provider credential (e.g., Active, Expired, Suspended, Revoked)."
    - name: "credential_type"
      expr: credential_type
      comment: "Type of credential held (e.g., MD, DO, NP, PA)."
    - name: "credential_tier"
      expr: credential_tier
      comment: "Tier classification of the credential for network adequacy analysis."
    - name: "credentialing_committee_outcome"
      expr: credentialing_committee_outcome
      comment: "Outcome of the credentialing committee review (e.g., Approved, Denied, Deferred)."
    - name: "credential_entity_code"
      expr: credential_entity_code
      comment: "Entity code identifying the credentialing organization or plan."
    - name: "delegated_credential_flag"
      expr: CAST(delegated_credential_flag AS STRING)
      comment: "Whether the credential was processed through a delegated entity."
    - name: "ncqa_compliance_flag"
      expr: CAST(ncqa_compliance_flag AS STRING)
      comment: "Whether the credential record meets NCQA compliance standards."
    - name: "malpractice_history_flag"
      expr: CAST(malpractice_history_flag AS STRING)
      comment: "Whether the provider has malpractice history on record."
    - name: "sanctions_screened_flag"
      expr: CAST(sanctions_screened_flag AS STRING)
      comment: "Whether the provider has been screened against OIG/SAM sanction databases."
    - name: "hospital_privileges_flag"
      expr: CAST(hospital_privileges_flag AS STRING)
      comment: "Whether the provider holds hospital privileges."
    - name: "credential_source_system"
      expr: credential_source_system
      comment: "Source system of record for the credential."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the credential became effective for cohort analysis."
    - name: "credential_version"
      expr: credential_version
      comment: "Version of the credential record for audit trail tracking."
  measures:
    - name: "total_credential_records"
      expr: COUNT(1)
      comment: "Total credentialing records — baseline measure of credentialed provider population size."
    - name: "distinct_credentialed_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Unique providers with credential records — measures network size and credentialing coverage."
    - name: "ncqa_compliant_count"
      expr: COUNT(CASE WHEN ncqa_compliance_flag = TRUE THEN 1 END)
      comment: "Credentials meeting NCQA compliance — critical for accreditation readiness."
    - name: "ncqa_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncqa_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credentials that are NCQA compliant — key accreditation readiness KPI."
    - name: "delegated_credential_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN delegated_credential_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credentials processed via delegation — monitors delegation program utilization."
    - name: "malpractice_history_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN malpractice_history_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credentialed providers with malpractice history — risk exposure metric for medical directors."
    - name: "sanctions_screened_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sanctions_screened_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of providers with completed sanction screening — regulatory compliance completeness indicator."
    - name: "suspended_credential_count"
      expr: COUNT(CASE WHEN credential_status = 'Suspended' THEN 1 END)
      comment: "Number of currently suspended credentials — operational risk and network disruption indicator."
    - name: "avg_days_to_expiration"
      expr: AVG(CAST(DATEDIFF(expiration_date, CURRENT_DATE()) AS DOUBLE))
      comment: "Average days until credential expiration — forward-looking recredentialing workload indicator."
    - name: "avg_days_to_next_recredentialing"
      expr: AVG(CAST(DATEDIFF(next_recredentialing_due, CURRENT_DATE()) AS DOUBLE))
      comment: "Average days until next recredentialing is due — workforce planning metric for credentialing staff."
    - name: "overdue_recredentialing_count"
      expr: COUNT(CASE WHEN next_recredentialing_due < CURRENT_DATE() THEN 1 END)
      comment: "Credentials past their recredentialing due date — compliance risk and regulatory exposure metric."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`credential_committee_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Committee review metrics tracking decision throughput, compliance flag rates, quorum adherence, and review outcomes to ensure credentialing governance integrity."
  source: "`health_insurance_ecm`.`credential`.`committee_review`"
  dimensions:
    - name: "committee_review_status"
      expr: committee_review_status
      comment: "Current status of the committee review (e.g., Scheduled, Completed, Pending)."
    - name: "decision_type"
      expr: decision_type
      comment: "Type of decision rendered (e.g., Approved, Denied, Deferred, Tabled)."
    - name: "review_type"
      expr: review_type
      comment: "Type of review conducted (e.g., Initial, Recredentialing, Focused)."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for denial decisions — root cause analysis for denial trends."
    - name: "quorum_indicator"
      expr: CAST(quorum_indicator AS STRING)
      comment: "Whether the committee meeting achieved quorum for valid decision-making."
    - name: "meeting_year_month"
      expr: DATE_TRUNC('month', meeting_timestamp)
      comment: "Month of the committee meeting for trend analysis."
    - name: "chair_name"
      expr: chair_name
      comment: "Name of the committee chair presiding over the review."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total committee reviews conducted — measures governance throughput and committee workload."
    - name: "distinct_providers_reviewed"
      expr: COUNT(DISTINCT record_id)
      comment: "Unique credentialing records reviewed — measures committee coverage of the provider population."
    - name: "approval_count"
      expr: COUNT(CASE WHEN decision_type = 'Approved' THEN 1 END)
      comment: "Number of approved decisions — tracks positive credentialing outcomes."
    - name: "denial_count"
      expr: COUNT(CASE WHEN decision_type = 'Denied' THEN 1 END)
      comment: "Number of denied decisions — monitors denial volume for appeal forecasting and quality concerns."
    - name: "approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision_type = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews resulting in approval — key quality and network access indicator."
    - name: "denial_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision_type = 'Denied' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews resulting in denial — risk and quality gating effectiveness metric."
    - name: "quorum_met_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quorum_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of meetings achieving quorum — governance validity and compliance indicator."
    - name: "oig_sanction_flag_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag_oig_sanction = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews with OIG sanction compliance flags — federal exclusion risk indicator."
    - name: "state_license_invalid_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag_state_license_valid = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews where state license was flagged as invalid — licensure compliance gap indicator."
    - name: "malpractice_flag_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag_malpractice_history = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews with malpractice history flags — risk exposure in reviewed population."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`credential_psv_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Primary Source Verification metrics tracking verification completeness, pass rates, and element coverage to ensure NCQA-compliant credentialing verification workflows."
  source: "`health_insurance_ecm`.`credential`.`psv_verification`"
  dimensions:
    - name: "credential_element_type"
      expr: credential_element_type
      comment: "Type of credential element being verified (e.g., License, DEA, Board Certification, Education)."
    - name: "element_category"
      expr: element_category
      comment: "Category grouping of the credential element for aggregate analysis."
    - name: "element_status"
      expr: element_status
      comment: "Current status of the credential element (e.g., Active, Expired, Pending)."
    - name: "verification_result"
      expr: verification_result
      comment: "Outcome of the primary source verification (e.g., Verified, Discrepancy, Unable to Verify)."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used for verification (e.g., Online, Phone, Written)."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the credential being verified."
    - name: "board_certification"
      expr: board_certification
      comment: "Board certification status of the provider."
    - name: "verification_year_month"
      expr: DATE_TRUNC('month', verification_date)
      comment: "Month of verification for trend and throughput analysis."
  measures:
    - name: "total_verifications"
      expr: COUNT(1)
      comment: "Total PSV verification attempts — measures verification workflow volume and throughput."
    - name: "distinct_providers_verified"
      expr: COUNT(DISTINCT provider_id)
      comment: "Unique providers with PSV verifications — measures verification coverage across the network."
    - name: "verified_count"
      expr: COUNT(CASE WHEN verification_result = 'Verified' THEN 1 END)
      comment: "Number of successfully verified credential elements."
    - name: "verification_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_result = 'Verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PSV attempts that result in successful verification — data quality and provider compliance indicator."
    - name: "discrepancy_count"
      expr: COUNT(CASE WHEN verification_result = 'Discrepancy' THEN 1 END)
      comment: "Number of verifications with discrepancies — triggers follow-up and potential credentialing delays."
    - name: "discrepancy_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_result = 'Discrepancy' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verifications with discrepancies — quality indicator for provider-submitted data accuracy."
    - name: "avg_malpractice_insurance_limit"
      expr: AVG(CAST(malpractice_insurance_limit AS DOUBLE))
      comment: "Average malpractice insurance coverage limit — risk adequacy indicator for network providers."
    - name: "distinct_credential_elements_verified"
      expr: COUNT(DISTINCT credential_element_identifier)
      comment: "Unique credential elements verified — measures breadth of verification coverage per provider."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`credential_sanction_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sanction screening metrics tracking screening volume, hit rates, severity distribution, and resolution status to ensure federal/state exclusion compliance and risk mitigation."
  source: "`health_insurance_ecm`.`credential`.`sanction_screening`"
  dimensions:
    - name: "screening_result"
      expr: screening_result
      comment: "Result of the sanction screening (e.g., Clear, Hit, Pending Review)."
    - name: "overall_status"
      expr: overall_status
      comment: "Overall status of the screening process."
    - name: "sanction_type"
      expr: sanction_type
      comment: "Type of sanction identified (e.g., OIG Exclusion, State Action, DEA Revocation)."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the sanction finding."
    - name: "sanctioning_authority"
      expr: sanctioning_authority
      comment: "Authority that imposed the sanction (e.g., OIG, State Board, DEA)."
    - name: "screening_event_type"
      expr: screening_event_type
      comment: "Type of screening event (e.g., Initial, Monthly Monitoring, Ad Hoc)."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of identified sanctions."
    - name: "impact_on_credential_status"
      expr: impact_on_credential_status
      comment: "Impact the screening result has on the provider credential status."
    - name: "screening_year_month"
      expr: DATE_TRUNC('month', screening_timestamp)
      comment: "Month of screening for trend analysis."
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total sanction screenings performed — measures compliance monitoring volume."
    - name: "distinct_providers_screened"
      expr: COUNT(DISTINCT provider_id)
      comment: "Unique providers screened — measures screening coverage across the network."
    - name: "sanction_hit_count"
      expr: COUNT(CASE WHEN screening_result = 'Hit' THEN 1 END)
      comment: "Number of screenings with positive sanction findings — immediate risk indicator requiring action."
    - name: "sanction_hit_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN screening_result = 'Hit' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings with positive findings — network risk exposure metric."
    - name: "clear_screening_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN screening_result = 'Clear' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings with clear results — network health indicator."
    - name: "unresolved_sanction_count"
      expr: COUNT(CASE WHEN resolution_status != 'Resolved' OR resolution_status IS NULL THEN 1 END)
      comment: "Screenings with unresolved sanctions — open risk items requiring follow-up action."
    - name: "resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_status = 'Resolved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sanction findings that have been resolved — operational effectiveness of risk remediation."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`credential_recredential_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recredentialing cycle metrics tracking timeliness, completion rates, escalation patterns, and outreach effectiveness to ensure continuous NCQA-compliant provider network maintenance."
  source: "`health_insurance_ecm`.`credential`.`recredential_cycle`"
  dimensions:
    - name: "cycle_status"
      expr: cycle_status
      comment: "Current status of the recredentialing cycle (e.g., In Progress, Completed, Overdue)."
    - name: "cycle_type"
      expr: cycle_type
      comment: "Type of recredentialing cycle (e.g., Standard, Expedited, Focused)."
    - name: "cycle_priority"
      expr: cycle_priority
      comment: "Priority level of the recredentialing cycle."
    - name: "escalation_flag"
      expr: CAST(escalation_flag AS STRING)
      comment: "Whether the cycle has been escalated due to delays or non-response."
    - name: "cycle_due_year_month"
      expr: DATE_TRUNC('month', cycle_due_date)
      comment: "Month the recredentialing cycle is due for workload forecasting."
    - name: "source_system"
      expr: source_system
      comment: "Source system of record for the recredentialing cycle."
  measures:
    - name: "total_recredential_cycles"
      expr: COUNT(1)
      comment: "Total recredentialing cycles — measures recredentialing workload volume."
    - name: "distinct_providers_in_cycle"
      expr: COUNT(DISTINCT provider_id)
      comment: "Unique providers in recredentialing cycles — measures recredentialing population size."
    - name: "completed_cycle_count"
      expr: COUNT(CASE WHEN cycle_status = 'Completed' THEN 1 END)
      comment: "Number of completed recredentialing cycles."
    - name: "completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cycle_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recredentialing cycles completed — key operational effectiveness and NCQA compliance metric."
    - name: "overdue_cycle_count"
      expr: COUNT(CASE WHEN cycle_due_date < CURRENT_DATE() AND cycle_status != 'Completed' THEN 1 END)
      comment: "Recredentialing cycles past due date and not completed — compliance risk and regulatory exposure metric."
    - name: "escalated_cycle_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated recredentialing cycles — indicates process bottlenecks or provider non-responsiveness."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycles requiring escalation — operational efficiency and provider engagement indicator."
    - name: "avg_cycle_duration_days"
      expr: AVG(CAST(DATEDIFF(cycle_completion_date, cycle_start_date) AS DOUBLE))
      comment: "Average days to complete a recredentialing cycle — turnaround time efficiency metric."
    - name: "avg_days_until_due"
      expr: AVG(CAST(DATEDIFF(cycle_due_date, CURRENT_DATE()) AS DOUBLE))
      comment: "Average days until cycle due date — forward-looking workload planning metric."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`credential_delegated_entity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delegated entity metrics tracking delegation program size, compliance posture, audit readiness, and NCQA accreditation status for oversight of outsourced credentialing functions."
  source: "`health_insurance_ecm`.`credential`.`delegated_entity`"
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

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`credential_delegation_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delegation audit metrics tracking audit outcomes, compliance rates, corrective action requirements, and file review volumes to ensure effective oversight of delegated credentialing entities."
  source: "`health_insurance_ecm`.`credential`.`delegation_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the delegation audit (e.g., Completed, In Progress, Scheduled)."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted (e.g., Annual, Focused, For-Cause)."
    - name: "audit_disposition"
      expr: audit_disposition
      comment: "Final disposition of the audit (e.g., Pass, Conditional Pass, Fail)."
    - name: "audit_scope"
      expr: audit_scope
      comment: "Scope of the delegation audit."
    - name: "audit_year"
      expr: audit_year
      comment: "Year the audit was conducted for annual trend analysis."
    - name: "corrective_action_required"
      expr: CAST(corrective_action_required AS STRING)
      comment: "Whether corrective action was required as a result of the audit."
    - name: "delegation_entity_name"
      expr: delegation_entity_name
      comment: "Name of the delegated entity being audited."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total delegation audits conducted — measures oversight program activity."
    - name: "avg_compliance_rate"
      expr: AVG(CAST(overall_compliance_rate AS DOUBLE))
      comment: "Average overall compliance rate across audits — key delegation oversight quality metric."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Audits requiring corrective action — indicates delegation quality gaps."
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring corrective action — delegation program risk indicator."
    - name: "audit_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_disposition = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits with passing disposition — delegation program health metric."
    - name: "avg_files_reviewed"
      expr: AVG(CAST(files_reviewed_count AS DOUBLE))
      comment: "Average number of files reviewed per audit — measures audit thoroughness and sample size adequacy."
    - name: "overdue_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE AND corrective_action_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Audits with overdue corrective actions — compliance risk requiring immediate attention."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`credential_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credentialing appeal metrics tracking appeal volume, outcomes, escalation patterns, and resolution timeliness to monitor due process compliance and provider dispute management."
  source: "`health_insurance_ecm`.`credential`.`credential_appeal`"
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
    - name: "distinct_providers_appealing"
      expr: COUNT(DISTINCT provider_id)
      comment: "Unique providers with appeals — measures breadth of provider dissatisfaction."
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

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`credential_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credential lifecycle event metrics tracking status transitions, escalation patterns, risk scoring, and critical event volumes to monitor credentialing workflow health and compliance posture."
  source: "`health_insurance_ecm`.`credential`.`credential_lifecycle_event`"
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
    - name: "distinct_providers_with_events"
      expr: COUNT(DISTINCT provider_id)
      comment: "Unique providers with lifecycle events — measures breadth of credentialing activity across the network."
    - name: "avg_resolution_time_days"
      expr: AVG(CAST(DATEDIFF(resolution_timestamp, event_timestamp) AS DOUBLE))
      comment: "Average days from event occurrence to resolution — operational responsiveness metric."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`credential_outreach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credentialing outreach metrics tracking communication volume, response rates, SLA adherence, and outreach effectiveness to optimize provider engagement during the credentialing process."
  source: "`health_insurance_ecm`.`credential`.`credential_outreach`"
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
    - name: "distinct_providers_contacted"
      expr: COUNT(DISTINCT provider_id)
      comment: "Unique providers contacted — measures outreach coverage."
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

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`credential_expedited_credential`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Expedited credentialing metrics tracking provisional approval volume, conversion rates, verification completeness, and financial impact to monitor fast-track credentialing for urgent network needs."
  source: "`health_insurance_ecm`.`credential`.`expedited_credential`"
  dimensions:
    - name: "expedited_credential_status"
      expr: expedited_credential_status
      comment: "Current status of the expedited credentialing request."
    - name: "expedited_reason_code"
      expr: expedited_reason_code
      comment: "Reason code for expedited processing (e.g., Network Gap, Clinical Urgency)."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification of the expedited request."
    - name: "final_credentialing_outcome"
      expr: final_credentialing_outcome
      comment: "Final outcome after full credentialing review of the expedited provider."
    - name: "requesting_entity_type"
      expr: requesting_entity_type
      comment: "Type of entity requesting expedited credentialing."
    - name: "request_year_month"
      expr: DATE_TRUNC('month', request_timestamp)
      comment: "Month of the expedited request for trend analysis."
  measures:
    - name: "total_expedited_requests"
      expr: COUNT(1)
      comment: "Total expedited credentialing requests — measures urgent network access demand."
    - name: "distinct_expedited_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Unique providers with expedited requests — measures breadth of urgent credentialing need."
    - name: "provisional_approved_count"
      expr: COUNT(CASE WHEN expedited_credential_status = 'Approved' THEN 1 END)
      comment: "Number of provisionally approved expedited requests."
    - name: "full_credential_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN final_credentialing_outcome = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of expedited credentials that convert to full credentialing approval — quality indicator for expedited process."
    - name: "malpractice_flagged_count"
      expr: COUNT(CASE WHEN malpractice_history_flag = TRUE THEN 1 END)
      comment: "Expedited requests with malpractice history — risk indicator in fast-track population."
    - name: "total_provisional_fees"
      expr: SUM(CAST(provisional_fee_amount AS DOUBLE))
      comment: "Total provisional fee amounts for expedited credentialing — financial impact metric."
    - name: "psv_verified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN psv_verification_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of expedited requests with completed PSV verification — verification completeness in fast-track process."
    - name: "sanction_screening_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sanction_screening_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of expedited requests with completed sanction screening — compliance safeguard metric for expedited process."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`credential_npdb_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NPDB query metrics tracking query volume, report findings, malpractice exposure, and HCQIA compliance to monitor National Practitioner Data Bank verification effectiveness."
  source: "`health_insurance_ecm`.`credential`.`npdb_query`"
  dimensions:
    - name: "npdb_query_status"
      expr: npdb_query_status
      comment: "Current status of the NPDB query (e.g., Submitted, Response Received, Reviewed)."
    - name: "query_type"
      expr: query_type
      comment: "Type of NPDB query (e.g., Initial, Continuous, Proactive Disclosure)."
    - name: "internal_review_disposition"
      expr: internal_review_disposition
      comment: "Internal disposition after reviewing NPDB results."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the NPDB query."
    - name: "is_continuous_enrollment"
      expr: CAST(is_continuous_enrollment AS STRING)
      comment: "Whether the provider is enrolled in NPDB continuous query."
    - name: "hcqia_compliance_flag"
      expr: CAST(hcqia_compliance_flag AS STRING)
      comment: "Whether the query meets HCQIA compliance requirements."
  measures:
    - name: "total_npdb_queries"
      expr: COUNT(1)
      comment: "Total NPDB queries submitted — measures verification volume and compliance activity."
    - name: "distinct_providers_queried"
      expr: COUNT(DISTINCT provider_id)
      comment: "Unique providers queried in NPDB — measures verification coverage."
    - name: "continuous_enrollment_count"
      expr: COUNT(CASE WHEN is_continuous_enrollment = TRUE THEN 1 END)
      comment: "Providers enrolled in NPDB continuous query — proactive monitoring coverage."
    - name: "continuous_enrollment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_continuous_enrollment = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of queries for continuously enrolled providers — proactive risk monitoring adoption rate."
    - name: "hcqia_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hcqia_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of queries meeting HCQIA compliance — federal regulatory compliance metric."
    - name: "total_malpractice_exposure"
      expr: SUM(CAST(total_malpractice_amount AS DOUBLE))
      comment: "Total malpractice payment amounts from NPDB reports — aggregate financial risk exposure metric."
    - name: "avg_malpractice_amount"
      expr: AVG(CAST(total_malpractice_amount AS DOUBLE))
      comment: "Average malpractice payment amount per query — per-provider risk severity indicator."
$$;