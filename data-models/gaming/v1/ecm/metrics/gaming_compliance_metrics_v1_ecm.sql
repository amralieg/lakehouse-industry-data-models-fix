-- Metric views for domain: compliance | Business: Gaming | Version: 1 | Generated on: 2026-05-08 07:57:15

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key regulatory filing metrics tracking submission performance, approval rates, and penalty exposure across jurisdictions and authorities"
  source: "`gaming_ecm`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (e.g., age rating, privacy, financial)"
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing (submitted, approved, rejected, pending)"
    - name: "jurisdiction"
      expr: jurisdiction_id
      comment: "Jurisdiction where filing is required"
    - name: "regulatory_authority"
      expr: regulatory_authority_id
      comment: "Authority receiving the filing"
    - name: "game_title"
      expr: game_title_id
      comment: "Game title associated with the filing"
    - name: "filing_year"
      expr: YEAR(submission_date)
      comment: "Year of filing submission"
    - name: "filing_quarter"
      expr: CONCAT('Q', QUARTER(submission_date))
      comment: "Quarter of filing submission"
    - name: "age_rating_assigned"
      expr: age_rating_assigned
      comment: "Age rating assigned through the filing"
    - name: "penalty_imposed"
      expr: penalty_imposed_flag
      comment: "Whether a penalty was imposed on this filing"
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total number of regulatory filings submitted"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total monetary penalties imposed across all filings"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per filing where penalties were imposed"
    - name: "filings_with_penalties"
      expr: COUNT(CASE WHEN penalty_imposed_flag = TRUE THEN 1 END)
      comment: "Count of filings that resulted in penalties"
    - name: "approved_filings"
      expr: COUNT(CASE WHEN filing_status = 'approved' THEN 1 END)
      comment: "Count of filings that were approved"
    - name: "rejected_filings"
      expr: COUNT(CASE WHEN filing_status = 'rejected' THEN 1 END)
      comment: "Count of filings that were rejected"
    - name: "avg_approval_days"
      expr: AVG(CAST(DATEDIFF(approval_date, submission_date) AS DOUBLE))
      comment: "Average days from submission to approval for approved filings"
    - name: "overdue_filings"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE() AND filing_status NOT IN ('approved', 'rejected') THEN 1 END)
      comment: "Count of filings past their due date and still pending"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`compliance_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Critical compliance incident metrics tracking breach severity, financial impact, remediation effectiveness, and regulatory notification performance"
  source: "`gaming_ecm`.`compliance`.`compliance_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of compliance incident (data breach, privacy violation, age verification failure, etc.)"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (open, investigating, remediated, closed)"
    - name: "severity_rating"
      expr: severity_rating
      comment: "Severity classification of the incident (critical, high, medium, low)"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level to which incident has been escalated"
    - name: "discovery_channel"
      expr: discovery_channel
      comment: "How the incident was discovered (internal audit, player report, regulator notification, etc.)"
    - name: "discovery_year"
      expr: YEAR(discovery_date)
      comment: "Year the incident was discovered"
    - name: "discovery_quarter"
      expr: CONCAT('Q', QUARTER(discovery_date))
      comment: "Quarter the incident was discovered"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required_flag
      comment: "Whether regulatory notification was required"
    - name: "player_notification_required"
      expr: player_notification_required_flag
      comment: "Whether player notification was required"
    - name: "external_counsel_engaged"
      expr: external_counsel_engaged_flag
      comment: "Whether external legal counsel was engaged"
    - name: "insurance_claim_filed"
      expr: insurance_claim_filed_flag
      comment: "Whether an insurance claim was filed"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of compliance incidents"
    - name: "critical_incidents"
      expr: COUNT(CASE WHEN severity_rating = 'critical' THEN 1 END)
      comment: "Count of critical severity incidents"
    - name: "total_estimated_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial impact across all incidents"
    - name: "total_actual_impact"
      expr: SUM(CAST(actual_financial_impact AS DOUBLE))
      comment: "Total actual financial impact across all incidents"
    - name: "avg_estimated_impact"
      expr: AVG(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Average estimated financial impact per incident"
    - name: "avg_actual_impact"
      expr: AVG(CAST(actual_financial_impact AS DOUBLE))
      comment: "Average actual financial impact per incident"
    - name: "total_affected_players"
      expr: SUM(CAST(affected_player_count AS DOUBLE))
      comment: "Total number of players affected across all incidents"
    - name: "avg_affected_players"
      expr: AVG(CAST(affected_player_count AS DOUBLE))
      comment: "Average number of players affected per incident"
    - name: "incidents_requiring_regulator_notification"
      expr: COUNT(CASE WHEN regulatory_notification_required_flag = TRUE THEN 1 END)
      comment: "Count of incidents requiring regulatory notification"
    - name: "incidents_with_player_notification"
      expr: COUNT(CASE WHEN player_notification_required_flag = TRUE THEN 1 END)
      comment: "Count of incidents requiring player notification"
    - name: "avg_time_to_resolution_days"
      expr: AVG(CAST(DATEDIFF(resolution_date, discovery_date) AS DOUBLE))
      comment: "Average days from discovery to resolution for closed incidents"
    - name: "open_incidents"
      expr: COUNT(CASE WHEN incident_status IN ('open', 'investigating') THEN 1 END)
      comment: "Count of incidents currently open or under investigation"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding metrics tracking control deficiencies, remediation progress, financial exposure, and recurrence patterns"
  source: "`gaming_ecm`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_category"
      expr: finding_category
      comment: "Category of audit finding (control deficiency, policy violation, process gap, etc.)"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the finding (critical, high, medium, low)"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Current remediation status (open, in progress, completed, overdue)"
    - name: "regulatory_area"
      expr: regulatory_area
      comment: "Regulatory area affected by the finding"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the finding has been escalated"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a recurring finding from previous audits"
    - name: "identified_year"
      expr: YEAR(identified_date)
      comment: "Year the finding was identified"
    - name: "identified_quarter"
      expr: CONCAT('Q', QUARTER(identified_date))
      comment: "Quarter the finding was identified"
    - name: "jurisdiction"
      expr: jurisdiction_id
      comment: "Jurisdiction where the finding applies"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings"
    - name: "critical_findings"
      expr: COUNT(CASE WHEN risk_rating = 'critical' THEN 1 END)
      comment: "Count of critical risk findings"
    - name: "high_risk_findings"
      expr: COUNT(CASE WHEN risk_rating = 'high' THEN 1 END)
      comment: "Count of high risk findings"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Total estimated financial impact of all findings"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Average estimated financial impact per finding"
    - name: "recurring_findings"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Count of findings that are recurrences from previous audits"
    - name: "escalated_findings"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Count of findings that have been escalated"
    - name: "overdue_remediations"
      expr: COUNT(CASE WHEN remediation_due_date < CURRENT_DATE() AND remediation_status NOT IN ('completed', 'verified') THEN 1 END)
      comment: "Count of findings with overdue remediation actions"
    - name: "completed_remediations"
      expr: COUNT(CASE WHEN remediation_status = 'completed' THEN 1 END)
      comment: "Count of findings with completed remediation"
    - name: "avg_remediation_days"
      expr: AVG(CAST(DATEDIFF(remediation_completion_date, identified_date) AS DOUBLE))
      comment: "Average days from identification to remediation completion"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`compliance_data_subject_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data subject request metrics tracking GDPR/CCPA compliance, response timeliness, request fulfillment rates, and SLA adherence"
  source: "`gaming_ecm`.`compliance`.`data_subject_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of data subject request (access, erasure, portability, rectification, objection)"
    - name: "request_status"
      expr: request_status
      comment: "Current status of the request (submitted, in progress, completed, rejected)"
    - name: "applicable_regulation"
      expr: applicable_regulation
      comment: "Regulation under which request was made (GDPR, CCPA, etc.)"
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which request was submitted (web form, email, phone, etc.)"
    - name: "jurisdiction"
      expr: jurisdiction_code
      comment: "Jurisdiction code of the data subject"
    - name: "identity_verified"
      expr: identity_verified_flag
      comment: "Whether identity verification was completed"
    - name: "extension_granted"
      expr: extension_granted_flag
      comment: "Whether a deadline extension was granted"
    - name: "legal_hold"
      expr: legal_hold_flag
      comment: "Whether request is subject to legal hold"
    - name: "minor_flag"
      expr: minor_flag
      comment: "Whether the data subject is a minor"
    - name: "submission_year"
      expr: YEAR(submission_timestamp)
      comment: "Year the request was submitted"
    - name: "submission_quarter"
      expr: CONCAT('Q', QUARTER(submission_timestamp))
      comment: "Quarter the request was submitted"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the request"
  measures:
    - name: "total_requests"
      expr: COUNT(1)
      comment: "Total number of data subject requests received"
    - name: "erasure_requests"
      expr: COUNT(CASE WHEN request_type = 'erasure' THEN 1 END)
      comment: "Count of erasure (right to be forgotten) requests"
    - name: "access_requests"
      expr: COUNT(CASE WHEN request_type = 'access' THEN 1 END)
      comment: "Count of data access requests"
    - name: "portability_requests"
      expr: COUNT(CASE WHEN request_type = 'portability' THEN 1 END)
      comment: "Count of data portability requests"
    - name: "completed_requests"
      expr: COUNT(CASE WHEN request_status = 'completed' THEN 1 END)
      comment: "Count of requests successfully completed"
    - name: "rejected_requests"
      expr: COUNT(CASE WHEN request_status = 'rejected' THEN 1 END)
      comment: "Count of requests rejected"
    - name: "overdue_requests"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE() AND request_status NOT IN ('completed', 'rejected') THEN 1 END)
      comment: "Count of requests past their due date and still open"
    - name: "avg_completion_days"
      expr: AVG(CAST(DATEDIFF(completion_timestamp, submission_timestamp) AS DOUBLE))
      comment: "Average days from submission to completion for fulfilled requests"
    - name: "requests_requiring_extension"
      expr: COUNT(CASE WHEN extension_granted_flag = TRUE THEN 1 END)
      comment: "Count of requests that required deadline extensions"
    - name: "requests_with_legal_hold"
      expr: COUNT(CASE WHEN legal_hold_flag = TRUE THEN 1 END)
      comment: "Count of requests subject to legal hold"
    - name: "minor_requests"
      expr: COUNT(CASE WHEN minor_flag = TRUE THEN 1 END)
      comment: "Count of requests from minors requiring special handling"
    - name: "total_records_retrieved"
      expr: SUM(CAST(records_retrieved_count AS DOUBLE))
      comment: "Total number of records retrieved across all requests"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`compliance_age_verification_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Age verification metrics tracking verification success rates, failure patterns, parental consent compliance, and age gate effectiveness"
  source: "`gaming_ecm`.`compliance`.`age_verification_event`"
  dimensions:
    - name: "verification_outcome"
      expr: verification_outcome
      comment: "Outcome of the verification attempt (passed, failed, pending, error)"
    - name: "verification_method"
      expr: verification_method
      comment: "Method used for age verification (document upload, credit card, third-party service, etc.)"
    - name: "verification_channel"
      expr: verification_channel
      comment: "Channel where verification occurred (web, mobile app, console, etc.)"
    - name: "verification_trigger"
      expr: verification_trigger
      comment: "What triggered the verification (account creation, purchase attempt, content access, etc.)"
    - name: "third_party_provider"
      expr: third_party_provider
      comment: "Third-party age verification provider used"
    - name: "game_rating"
      expr: game_rating
      comment: "Age rating of the game being accessed"
    - name: "jurisdiction"
      expr: jurisdiction_id
      comment: "Jurisdiction where verification occurred"
    - name: "consent_given"
      expr: consent_given
      comment: "Whether parental consent was given (for minors)"
    - name: "verification_year"
      expr: YEAR(verification_timestamp)
      comment: "Year of verification attempt"
    - name: "verification_quarter"
      expr: CONCAT('Q', QUARTER(verification_timestamp))
      comment: "Quarter of verification attempt"
    - name: "failure_reason"
      expr: failure_reason
      comment: "Reason for verification failure"
  measures:
    - name: "total_verification_attempts"
      expr: COUNT(1)
      comment: "Total number of age verification attempts"
    - name: "successful_verifications"
      expr: COUNT(CASE WHEN verification_outcome = 'passed' THEN 1 END)
      comment: "Count of successful age verifications"
    - name: "failed_verifications"
      expr: COUNT(CASE WHEN verification_outcome = 'failed' THEN 1 END)
      comment: "Count of failed age verifications"
    - name: "unique_players_verified"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Distinct count of players who completed verification"
    - name: "verifications_with_parental_consent"
      expr: COUNT(CASE WHEN consent_given = TRUE THEN 1 END)
      comment: "Count of verifications where parental consent was obtained"
    - name: "avg_retry_count"
      expr: AVG(CAST(retry_count AS DOUBLE))
      comment: "Average number of retry attempts per verification event"
    - name: "verifications_requiring_retry"
      expr: COUNT(CASE WHEN CAST(retry_count AS INT) > 0 THEN 1 END)
      comment: "Count of verifications that required one or more retries"
    - name: "expired_verifications"
      expr: COUNT(CASE WHEN verification_expiry_date < CURRENT_DATE() AND is_active = TRUE THEN 1 END)
      comment: "Count of verifications that have expired and need renewal"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`compliance_remediation_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Remediation action metrics tracking corrective action effectiveness, cost, timeliness, and risk reduction outcomes"
  source: "`gaming_ecm`.`compliance`.`remediation_action`"
  dimensions:
    - name: "remediation_status"
      expr: remediation_action_status
      comment: "Current status of the remediation action (planned, in progress, completed, overdue, cancelled)"
    - name: "remediation_type"
      expr: remediation_type
      comment: "Type of remediation action (process change, system update, policy revision, training, etc.)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the remediation action"
    - name: "risk_level_before"
      expr: risk_level_before
      comment: "Risk level before remediation"
    - name: "risk_level_after"
      expr: risk_level_after
      comment: "Risk level after remediation"
    - name: "escalation_required"
      expr: escalation_required
      comment: "Whether escalation was required"
    - name: "external_consultant_engaged"
      expr: external_consultant_engaged
      comment: "Whether external consultants were engaged"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework driving the remediation"
    - name: "jurisdiction"
      expr: jurisdiction_id
      comment: "Jurisdiction where remediation applies"
    - name: "assigned_department"
      expr: assigned_department
      comment: "Department responsible for remediation"
    - name: "target_year"
      expr: YEAR(target_completion_date)
      comment: "Year of target completion"
    - name: "target_quarter"
      expr: CONCAT('Q', QUARTER(target_completion_date))
      comment: "Quarter of target completion"
  measures:
    - name: "total_remediation_actions"
      expr: COUNT(1)
      comment: "Total number of remediation actions"
    - name: "completed_actions"
      expr: COUNT(CASE WHEN remediation_action_status = 'completed' THEN 1 END)
      comment: "Count of completed remediation actions"
    - name: "overdue_actions"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE() AND remediation_action_status NOT IN ('completed', 'cancelled') THEN 1 END)
      comment: "Count of remediation actions past their target completion date"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all remediation actions"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of completed remediation actions"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per remediation action"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per completed remediation action"
    - name: "actions_requiring_escalation"
      expr: COUNT(CASE WHEN escalation_required = TRUE THEN 1 END)
      comment: "Count of actions that required escalation"
    - name: "actions_with_external_consultants"
      expr: COUNT(CASE WHEN external_consultant_engaged = TRUE THEN 1 END)
      comment: "Count of actions requiring external consultant engagement"
    - name: "avg_completion_days"
      expr: AVG(CAST(DATEDIFF(actual_completion_date, created_timestamp) AS DOUBLE))
      comment: "Average days from creation to completion for completed actions"
    - name: "high_priority_actions"
      expr: COUNT(CASE WHEN priority IN ('critical', 'high') THEN 1 END)
      comment: "Count of high and critical priority remediation actions"
$$;

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`compliance_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory obligation metrics tracking compliance status, implementation progress, audit readiness, and penalty exposure"
  source: "`gaming_ecm`.`compliance`.`regulatory_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (reporting, disclosure, consent, data protection, etc.)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (compliant, non-compliant, in progress, not applicable)"
    - name: "implementation_status"
      expr: implementation_status
      comment: "Implementation status of the obligation"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level if obligation is not met"
    - name: "is_active"
      expr: is_active
      comment: "Whether the obligation is currently active"
    - name: "requires_age_verification"
      expr: requires_age_verification
      comment: "Whether age verification is required"
    - name: "requires_player_consent"
      expr: requires_player_consent
      comment: "Whether player consent is required"
    - name: "requires_disclosure"
      expr: requires_disclosure
      comment: "Whether disclosure is required"
    - name: "requires_data_retention"
      expr: requires_data_retention
      comment: "Whether data retention policies are required"
    - name: "requires_right_to_erasure"
      expr: requires_right_to_erasure
      comment: "Whether right to erasure must be supported"
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Required reporting frequency"
    - name: "audit_frequency"
      expr: audit_frequency
      comment: "Required audit frequency"
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory body governing this obligation"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of regulatory obligations"
    - name: "active_obligations"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active obligations"
    - name: "compliant_obligations"
      expr: COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END)
      comment: "Count of obligations in compliant status"
    - name: "non_compliant_obligations"
      expr: COUNT(CASE WHEN compliance_status = 'non-compliant' THEN 1 END)
      comment: "Count of obligations in non-compliant status"
    - name: "high_risk_obligations"
      expr: COUNT(CASE WHEN risk_level IN ('critical', 'high') THEN 1 END)
      comment: "Count of high and critical risk obligations"
    - name: "total_maximum_penalty_exposure"
      expr: SUM(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Total maximum penalty exposure across all obligations"
    - name: "avg_maximum_penalty"
      expr: AVG(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Average maximum penalty per obligation"
    - name: "total_implementation_cost"
      expr: SUM(CAST(estimated_implementation_cost AS DOUBLE))
      comment: "Total estimated implementation cost across all obligations"
    - name: "obligations_past_implementation_deadline"
      expr: COUNT(CASE WHEN implementation_deadline < CURRENT_DATE() AND implementation_status NOT IN ('completed', 'implemented') THEN 1 END)
      comment: "Count of obligations past their implementation deadline"
    - name: "obligations_requiring_audit"
      expr: COUNT(CASE WHEN last_audit_date < DATE_SUB(CURRENT_DATE(), 365) OR last_audit_date IS NULL THEN 1 END)
      comment: "Count of obligations requiring audit (last audit over 1 year ago or never audited)"
$$;