-- Metric views for domain: compliance | Business: Sports Entertainment | Version: 1 | Generated on: 2026-05-09 01:35:39

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`compliance_doping_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Anti-doping violation metrics tracking prohibited substance cases, sanctions, appeals, and reinstatement outcomes for athlete integrity monitoring"
  source: "`sports_entertainment_ecm`.`compliance`.`doping_violation`"
  dimensions:
    - name: "violation_status"
      expr: violation_status
      comment: "Current status of the doping violation case (open, closed, under appeal, etc.)"
    - name: "violation_type"
      expr: violation_type
      comment: "Type of anti-doping rule violation (presence of prohibited substance, tampering, refusal to test, etc.)"
    - name: "prohibited_substance_category"
      expr: prohibited_substance_category
      comment: "WADA category of the prohibited substance (anabolic agents, stimulants, hormones, etc.)"
    - name: "sanction_type"
      expr: sanction_type
      comment: "Type of sanction imposed (suspension, fine, disqualification, lifetime ban)"
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal filed (pending, upheld, overturned, withdrawn)"
    - name: "sport_discipline"
      expr: sport_discipline
      comment: "Sport or discipline in which the violation occurred"
    - name: "governing_body_code"
      expr: governing_body_code
      comment: "Code of the governing body handling the case (WADA, national federation, league)"
    - name: "in_competition_flag"
      expr: in_competition_flag
      comment: "Whether the violation occurred during competition (true) or out-of-competition (false)"
    - name: "cas_outcome"
      expr: cas_outcome
      comment: "Court of Arbitration for Sport decision outcome if appealed to CAS"
    - name: "violation_year"
      expr: YEAR(sample_collection_date)
      comment: "Year the sample was collected for trend analysis"
    - name: "violation_quarter"
      expr: CONCAT('Q', QUARTER(sample_collection_date), '-', YEAR(sample_collection_date))
      comment: "Quarter and year of sample collection for seasonal trend analysis"
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of doping violations recorded"
    - name: "unique_athletes_violated"
      expr: COUNT(DISTINCT athlete_profile_id)
      comment: "Count of unique athletes with doping violations for recidivism tracking"
    - name: "avg_ban_duration_months"
      expr: AVG(CAST(ban_duration_months AS DOUBLE))
      comment: "Average suspension duration in months across all violations"
    - name: "total_ban_months_imposed"
      expr: SUM(CAST(ban_duration_months AS DOUBLE))
      comment: "Total months of suspension imposed across all violations"
    - name: "appeal_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN appeal_filed_date IS NOT NULL THEN doping_violation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations that were appealed by athletes"
    - name: "b_sample_request_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN b_sample_requested_flag = true THEN doping_violation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of positive A-samples where athlete requested B-sample analysis"
    - name: "public_disclosure_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN public_disclosure_flag = true THEN doping_violation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations publicly disclosed for transparency monitoring"
    - name: "results_disqualified_count"
      expr: COUNT(DISTINCT CASE WHEN results_disqualified_flag = true THEN doping_violation_id END)
      comment: "Number of cases where competitive results were disqualified"
    - name: "therapeutic_exemption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN therapeutic_use_exemption_flag = true THEN doping_violation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations involving therapeutic use exemption claims"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`compliance_incident_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance incident tracking metrics covering data breaches, safety events, regulatory violations, and response effectiveness"
  source: "`sports_entertainment_ecm`.`compliance`.`incident_report`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Category of compliance incident (data breach, safety violation, regulatory non-compliance, etc.)"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (open, investigating, remediated, closed)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification (critical, high, medium, low) for prioritization"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Applicable regulatory framework (GDPR, CCPA, OSHA, WADA, etc.)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction where the incident occurred"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the incident"
    - name: "authority_notified"
      expr: authority_notified
      comment: "Whether regulatory authority was notified"
    - name: "gdpr_72hr_deadline_met"
      expr: gdpr_72hr_deadline_met
      comment: "Whether GDPR 72-hour breach notification deadline was met"
    - name: "osha_recordable"
      expr: osha_recordable
      comment: "Whether incident is OSHA recordable for workplace safety compliance"
    - name: "is_repeat_incident"
      expr: is_repeat_incident
      comment: "Whether this is a repeat occurrence of a similar incident"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', occurrence_timestamp)
      comment: "Month of incident occurrence for trend analysis"
    - name: "detection_lag_days"
      expr: DATEDIFF(detection_timestamp, occurrence_timestamp)
      comment: "Days between incident occurrence and detection for control effectiveness"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of compliance incidents reported"
    - name: "critical_incidents"
      expr: COUNT(DISTINCT CASE WHEN severity_level = 'critical' THEN incident_report_id END)
      comment: "Count of critical severity incidents requiring immediate executive attention"
    - name: "avg_estimated_financial_impact"
      expr: AVG(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Average estimated financial impact per incident for risk quantification"
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial impact across all incidents"
    - name: "avg_affected_records"
      expr: AVG(CAST(affected_records_count AS DOUBLE))
      comment: "Average number of records affected per data breach incident"
    - name: "total_affected_records"
      expr: SUM(CAST(affected_records_count AS DOUBLE))
      comment: "Total records affected across all data breach incidents"
    - name: "authority_notification_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN authority_notification_timestamp IS NOT NULL THEN incident_report_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents where regulatory authority was notified"
    - name: "gdpr_deadline_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gdpr_72hr_deadline_met = true THEN incident_report_id END) / NULLIF(COUNT(DISTINCT CASE WHEN regulatory_framework = 'GDPR' THEN incident_report_id END), 0), 2)
      comment: "Percentage of GDPR incidents meeting 72-hour notification deadline"
    - name: "repeat_incident_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_repeat_incident = true THEN incident_report_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that are repeat occurrences indicating control gaps"
    - name: "avg_detection_lag_days"
      expr: AVG(DATEDIFF(detection_timestamp, occurrence_timestamp))
      comment: "Average days between incident occurrence and detection for control effectiveness"
    - name: "data_subject_notification_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN data_subject_notified = true THEN incident_report_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents where affected data subjects were notified"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding remediation metrics tracking control deficiencies, risk ratings, remediation progress, and repeat findings"
  source: "`sports_entertainment_ecm`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the audit finding (open, in remediation, closed, accepted risk)"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk severity rating (critical, high, medium, low) for prioritization"
    - name: "finding_category"
      expr: finding_category
      comment: "Category of audit finding (control deficiency, policy violation, process gap, etc.)"
    - name: "control_domain"
      expr: control_domain
      comment: "Control domain affected (financial reporting, IT security, operations, compliance)"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework related to the finding (SOX, GDPR, PCI-DSS, etc.)"
    - name: "auditor_type"
      expr: auditor_type
      comment: "Type of auditor who identified the finding (internal, external, regulatory)"
    - name: "repeat_finding"
      expr: repeat_finding
      comment: "Whether this is a repeat finding from prior audits indicating persistent control weakness"
    - name: "escalation_required"
      expr: escalation_required
      comment: "Whether finding requires escalation to senior management or board"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether finding must be reported to regulatory authority"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category (process, people, technology, policy) for systemic analysis"
    - name: "finding_year"
      expr: YEAR(identified_date)
      comment: "Year the finding was identified for trend analysis"
    - name: "remediation_overdue"
      expr: CASE WHEN target_remediation_date < CURRENT_DATE() AND finding_status != 'closed' THEN true ELSE false END
      comment: "Whether finding remediation is past target date"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings identified"
    - name: "open_findings"
      expr: COUNT(DISTINCT CASE WHEN finding_status IN ('open', 'in remediation') THEN audit_finding_id END)
      comment: "Count of findings not yet closed requiring management attention"
    - name: "critical_high_findings"
      expr: COUNT(DISTINCT CASE WHEN risk_rating IN ('critical', 'high') THEN audit_finding_id END)
      comment: "Count of critical and high-risk findings requiring immediate action"
    - name: "repeat_finding_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN repeat_finding = true THEN audit_finding_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are repeats indicating systemic control failures"
    - name: "avg_remediation_days"
      expr: AVG(DATEDIFF(actual_remediation_date, identified_date))
      comment: "Average days to remediate findings for process efficiency measurement"
    - name: "overdue_findings"
      expr: COUNT(DISTINCT CASE WHEN target_remediation_date < CURRENT_DATE() AND finding_status != 'closed' THEN audit_finding_id END)
      comment: "Count of findings past target remediation date"
    - name: "overdue_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN target_remediation_date < CURRENT_DATE() AND finding_status != 'closed' THEN audit_finding_id END) / NULLIF(COUNT(DISTINCT CASE WHEN finding_status != 'closed' THEN audit_finding_id END), 0), 2)
      comment: "Percentage of open findings that are overdue for escalation tracking"
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN escalation_required = true THEN audit_finding_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings requiring escalation to senior management"
    - name: "regulatory_notification_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN regulatory_notification_required = true THEN audit_finding_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings requiring regulatory notification"
    - name: "accepted_risk_count"
      expr: COUNT(DISTINCT CASE WHEN finding_status = 'accepted risk' THEN audit_finding_id END)
      comment: "Count of findings where management accepted the risk without remediation"
    - name: "remediation_closure_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN finding_status = 'closed' THEN audit_finding_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings successfully remediated and closed"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing compliance metrics tracking submission timeliness, approval rates, penalties, and recurring obligation management"
  source: "`sports_entertainment_ecm`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the regulatory filing (draft, submitted, approved, rejected, overdue)"
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (financial report, compliance certification, license renewal, etc.)"
    - name: "filing_category"
      expr: filing_category
      comment: "Category of filing (mandatory, voluntary, ad-hoc, recurring)"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework requiring the filing (SEC, FCC, WADA, state gaming commission, etc.)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction where filing is required"
    - name: "is_recurring"
      expr: is_recurring
      comment: "Whether this is a recurring filing obligation"
    - name: "is_amendment"
      expr: is_amendment
      comment: "Whether this filing is an amendment to a prior submission"
    - name: "penalty_risk_flag"
      expr: penalty_risk_flag
      comment: "Whether filing carries penalty risk if late or non-compliant"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the filing"
    - name: "filing_year"
      expr: YEAR(due_date)
      comment: "Year the filing is due for trend analysis"
    - name: "filing_quarter"
      expr: CONCAT('Q', QUARTER(due_date), '-', YEAR(due_date))
      comment: "Quarter and year of filing due date"
    - name: "overdue_flag"
      expr: CASE WHEN due_date < CURRENT_DATE() AND filing_status NOT IN ('submitted', 'approved') THEN true ELSE false END
      comment: "Whether filing is past due date and not yet submitted"
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total number of regulatory filings tracked"
    - name: "overdue_filings"
      expr: COUNT(DISTINCT CASE WHEN due_date < CURRENT_DATE() AND filing_status NOT IN ('submitted', 'approved') THEN regulatory_filing_id END)
      comment: "Count of filings past due date not yet submitted indicating compliance risk"
    - name: "on_time_submission_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN submission_timestamp <= due_date THEN regulatory_filing_id END) / NULLIF(COUNT(DISTINCT CASE WHEN submission_timestamp IS NOT NULL THEN regulatory_filing_id END), 0), 2)
      comment: "Percentage of filings submitted by due date for compliance performance tracking"
    - name: "approval_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN filing_status = 'approved' THEN regulatory_filing_id END) / NULLIF(COUNT(DISTINCT CASE WHEN filing_status IN ('approved', 'rejected') THEN regulatory_filing_id END), 0), 2)
      comment: "Percentage of submitted filings approved on first submission"
    - name: "rejection_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN filing_status = 'rejected' THEN regulatory_filing_id END) / NULLIF(COUNT(DISTINCT CASE WHEN filing_status IN ('approved', 'rejected') THEN regulatory_filing_id END), 0), 2)
      comment: "Percentage of submitted filings rejected requiring resubmission"
    - name: "avg_days_overdue"
      expr: AVG(CAST(days_overdue AS DOUBLE))
      comment: "Average days overdue for late filings to measure severity of delays"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalties incurred for late or non-compliant filings"
    - name: "penalty_incidence_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN penalty_amount > 0 THEN regulatory_filing_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings that incurred penalties"
    - name: "amendment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_amendment = true THEN regulatory_filing_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings that are amendments indicating initial submission quality issues"
    - name: "avg_submission_lead_days"
      expr: AVG(DATEDIFF(due_date, submission_timestamp))
      comment: "Average days filings are submitted before due date for process efficiency"
    - name: "recurring_filing_count"
      expr: COUNT(DISTINCT CASE WHEN is_recurring = true THEN regulatory_filing_id END)
      comment: "Count of recurring filing obligations for workload planning"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`compliance_sanction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sanction enforcement metrics tracking penalties, fines, suspensions, appeals, and enforcement effectiveness across regulatory frameworks"
  source: "`sports_entertainment_ecm`.`compliance`.`sanction`"
  dimensions:
    - name: "sanction_type"
      expr: sanction_type
      comment: "Type of sanction imposed (fine, suspension, disqualification, warning, lifetime ban)"
    - name: "sanctioned_entity_type"
      expr: sanctioned_entity_type
      comment: "Type of entity sanctioned (athlete, team, franchise, vendor, employee)"
    - name: "violation_type"
      expr: violation_type
      comment: "Type of violation leading to sanction (doping, financial, conduct, safety, etc.)"
    - name: "enforcement_status"
      expr: enforcement_status
      comment: "Current enforcement status (active, completed, stayed, under appeal)"
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal filed (pending, upheld, overturned, withdrawn)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction where sanction was imposed"
    - name: "regulatory_basis"
      expr: regulatory_basis
      comment: "Regulatory framework or rule basis for the sanction"
    - name: "is_public_disclosure"
      expr: is_public_disclosure
      comment: "Whether sanction was publicly disclosed for transparency"
    - name: "is_lifetime_ban"
      expr: is_lifetime_ban
      comment: "Whether sanction is a lifetime ban"
    - name: "fine_payment_status"
      expr: fine_payment_status
      comment: "Payment status of any monetary fine (paid, outstanding, waived)"
    - name: "sanction_year"
      expr: YEAR(decision_date)
      comment: "Year sanction was decided for trend analysis"
    - name: "sport_discipline"
      expr: sport_discipline
      comment: "Sport or discipline where violation occurred"
  measures:
    - name: "total_sanctions"
      expr: COUNT(1)
      comment: "Total number of sanctions imposed"
    - name: "unique_sanctioned_entities"
      expr: COUNT(DISTINCT sanctioned_entity_reference)
      comment: "Count of unique entities sanctioned for recidivism tracking"
    - name: "total_fine_amount"
      expr: SUM(CAST(fine_amount AS DOUBLE))
      comment: "Total monetary fines imposed across all sanctions"
    - name: "avg_fine_amount"
      expr: AVG(CAST(fine_amount AS DOUBLE))
      comment: "Average fine amount per sanction for penalty severity analysis"
    - name: "avg_suspension_days"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average suspension duration in days across all sanctions"
    - name: "total_suspension_days"
      expr: SUM(CAST(duration_days AS DOUBLE))
      comment: "Total suspension days imposed across all sanctions"
    - name: "appeal_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN appeal_filed_date IS NOT NULL THEN sanction_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sanctions appealed by sanctioned parties"
    - name: "appeal_overturn_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN appeal_status = 'overturned' THEN sanction_id END) / NULLIF(COUNT(DISTINCT CASE WHEN appeal_status IN ('upheld', 'overturned') THEN sanction_id END), 0), 2)
      comment: "Percentage of appeals that resulted in sanction being overturned"
    - name: "fine_collection_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN fine_payment_status = 'paid' THEN sanction_id END) / NULLIF(COUNT(DISTINCT CASE WHEN fine_amount > 0 THEN sanction_id END), 0), 2)
      comment: "Percentage of fines successfully collected for enforcement effectiveness"
    - name: "public_disclosure_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_public_disclosure = true THEN sanction_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sanctions publicly disclosed for transparency measurement"
    - name: "lifetime_ban_count"
      expr: COUNT(DISTINCT CASE WHEN is_lifetime_ban = true THEN sanction_id END)
      comment: "Count of lifetime bans imposed for severe violation tracking"
    - name: "stayed_sanction_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_sanction_stayed = true THEN sanction_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sanctions stayed pending appeal or other proceedings"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`compliance_privacy_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data subject rights request metrics tracking GDPR/CCPA compliance, fulfillment timeliness, and regulatory deadline adherence"
  source: "`sports_entertainment_ecm`.`compliance`.`privacy_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of privacy request (access, erasure, rectification, portability, opt-out, consent withdrawal)"
    - name: "request_status"
      expr: request_status
      comment: "Current status of the request (received, in progress, fulfilled, rejected, withdrawn)"
    - name: "applicable_regulation"
      expr: applicable_regulation
      comment: "Applicable privacy regulation (GDPR, CCPA, CPRA, LGPD, etc.)"
    - name: "data_subject_jurisdiction"
      expr: data_subject_jurisdiction
      comment: "Jurisdiction of the data subject making the request"
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which request was submitted (web form, email, phone, in-person)"
    - name: "identity_verification_status"
      expr: identity_verification_status
      comment: "Status of identity verification (verified, pending, failed)"
    - name: "dpo_review_required"
      expr: dpo_review_required
      comment: "Whether Data Protection Officer review is required"
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Whether data is under legal hold preventing fulfillment"
    - name: "is_authorized_agent"
      expr: is_authorized_agent
      comment: "Whether request was submitted by an authorized agent on behalf of data subject"
    - name: "response_outcome"
      expr: response_outcome
      comment: "Outcome of the request (fulfilled, partially fulfilled, rejected, withdrawn)"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', submitted_at)
      comment: "Month request was submitted for trend analysis"
    - name: "overdue_flag"
      expr: CASE WHEN regulatory_deadline < CURRENT_DATE() AND request_status NOT IN ('fulfilled', 'rejected', 'withdrawn') THEN true ELSE false END
      comment: "Whether request is past regulatory deadline"
  measures:
    - name: "total_requests"
      expr: COUNT(1)
      comment: "Total number of data subject rights requests received"
    - name: "unique_data_subjects"
      expr: COUNT(DISTINCT fan_profile_id)
      comment: "Count of unique data subjects making requests"
    - name: "avg_fulfillment_days"
      expr: AVG(DATEDIFF(fulfillment_date, submitted_at))
      comment: "Average days to fulfill requests for process efficiency measurement"
    - name: "on_time_fulfillment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN fulfillment_date <= regulatory_deadline THEN privacy_request_id END) / NULLIF(COUNT(DISTINCT CASE WHEN fulfillment_date IS NOT NULL THEN privacy_request_id END), 0), 2)
      comment: "Percentage of requests fulfilled within regulatory deadline for compliance performance"
    - name: "overdue_requests"
      expr: COUNT(DISTINCT CASE WHEN regulatory_deadline < CURRENT_DATE() AND request_status NOT IN ('fulfilled', 'rejected', 'withdrawn') THEN privacy_request_id END)
      comment: "Count of requests past regulatory deadline indicating compliance risk"
    - name: "fulfillment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN request_status = 'fulfilled' THEN privacy_request_id END) / NULLIF(COUNT(DISTINCT CASE WHEN request_status IN ('fulfilled', 'rejected') THEN privacy_request_id END), 0), 2)
      comment: "Percentage of requests successfully fulfilled vs rejected"
    - name: "rejection_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN request_status = 'rejected' THEN privacy_request_id END) / NULLIF(COUNT(DISTINCT CASE WHEN request_status IN ('fulfilled', 'rejected') THEN privacy_request_id END), 0), 2)
      comment: "Percentage of requests rejected for validity or legal hold reasons"
    - name: "identity_verification_failure_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN identity_verification_status = 'failed' THEN privacy_request_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests failing identity verification"
    - name: "dpo_review_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN dpo_review_required = true THEN privacy_request_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests requiring DPO review for complexity assessment"
    - name: "legal_hold_conflict_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN legal_hold_flag = true THEN privacy_request_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests conflicting with legal hold obligations"
    - name: "authorized_agent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_authorized_agent = true THEN privacy_request_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests submitted by authorized agents"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`compliance_breach_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data breach notification compliance metrics tracking GDPR 72-hour deadline adherence, affected records, authority response, and notification outcomes"
  source: "`sports_entertainment_ecm`.`compliance`.`breach_notification`"
  dimensions:
    - name: "notification_status"
      expr: notification_status
      comment: "Current status of the breach notification (draft, submitted, acknowledged, under investigation)"
    - name: "notification_type"
      expr: notification_type
      comment: "Type of notification (initial, supplementary, final)"
    - name: "breach_category"
      expr: breach_category
      comment: "Category of data breach (unauthorized access, loss, theft, accidental disclosure, ransomware)"
    - name: "breach_cause"
      expr: breach_cause
      comment: "Root cause of the breach (human error, system failure, malicious attack, third-party)"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework requiring notification (GDPR, CCPA, HIPAA, state breach laws)"
    - name: "notified_authority_jurisdiction"
      expr: notified_authority_jurisdiction
      comment: "Jurisdiction of the notified supervisory authority"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level to data subjects (high, medium, low)"
    - name: "is_within_72hr_deadline"
      expr: is_within_72hr_deadline
      comment: "Whether notification was submitted within GDPR 72-hour deadline"
    - name: "affected_special_category_flag"
      expr: affected_special_category_flag
      comment: "Whether special category (sensitive) personal data was affected"
    - name: "third_party_processor_involved"
      expr: third_party_processor_involved
      comment: "Whether a third-party data processor was involved in the breach"
    - name: "pci_dss_scope_flag"
      expr: pci_dss_scope_flag
      comment: "Whether breach involved payment card data under PCI-DSS scope"
    - name: "regulatory_penalty_risk_flag"
      expr: regulatory_penalty_risk_flag
      comment: "Whether breach carries significant regulatory penalty risk"
    - name: "notification_month"
      expr: DATE_TRUNC('MONTH', notification_submitted_timestamp)
      comment: "Month notification was submitted for trend analysis"
  measures:
    - name: "total_breach_notifications"
      expr: COUNT(1)
      comment: "Total number of data breach notifications submitted to authorities"
    - name: "total_affected_data_subjects"
      expr: SUM(CAST(affected_data_subjects_count AS DOUBLE))
      comment: "Total number of data subjects affected across all breaches"
    - name: "avg_affected_data_subjects"
      expr: AVG(CAST(affected_data_subjects_count AS DOUBLE))
      comment: "Average number of data subjects affected per breach"
    - name: "total_affected_records"
      expr: SUM(CAST(affected_records_count AS DOUBLE))
      comment: "Total number of records affected across all breaches"
    - name: "avg_affected_records"
      expr: AVG(CAST(affected_records_count AS DOUBLE))
      comment: "Average number of records affected per breach"
    - name: "gdpr_72hr_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_within_72hr_deadline = true THEN breach_notification_id END) / NULLIF(COUNT(DISTINCT CASE WHEN regulatory_framework = 'GDPR' THEN breach_notification_id END), 0), 2)
      comment: "Percentage of GDPR breaches notified within 72-hour deadline for compliance performance"
    - name: "avg_notification_lag_hours"
      expr: AVG((UNIX_TIMESTAMP(notification_submitted_timestamp) - UNIX_TIMESTAMP(breach_detected_timestamp)) / 3600)
      comment: "Average hours between breach detection and authority notification"
    - name: "high_risk_breach_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN risk_level = 'high' THEN breach_notification_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of breaches classified as high risk to data subjects"
    - name: "special_category_breach_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN affected_special_category_flag = true THEN breach_notification_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of breaches involving sensitive personal data"
    - name: "third_party_breach_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN third_party_processor_involved = true THEN breach_notification_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of breaches involving third-party processors for vendor risk assessment"
    - name: "data_subject_notification_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN data_subject_notification_date IS NOT NULL THEN breach_notification_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of breaches where affected data subjects were directly notified"
    - name: "authority_acknowledgment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN authority_acknowledgment_date IS NOT NULL THEN breach_notification_id END) / NULLIF(COUNT(DISTINCT CASE WHEN notification_submitted_timestamp IS NOT NULL THEN breach_notification_id END), 0), 2)
      comment: "Percentage of notifications acknowledged by supervisory authority"
    - name: "pci_dss_breach_count"
      expr: COUNT(DISTINCT CASE WHEN pci_dss_scope_flag = true THEN breach_notification_id END)
      comment: "Count of breaches involving payment card data requiring PCI-DSS incident response"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`compliance_license_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "License and permit management metrics tracking renewal timeliness, expiration risk, fee management, and regulatory compliance status"
  source: "`sports_entertainment_ecm`.`compliance`.`license_permit`"
  dimensions:
    - name: "license_status"
      expr: license_status
      comment: "Current status of the license or permit (active, expired, pending renewal, suspended, revoked)"
    - name: "license_type"
      expr: license_type
      comment: "Type of license or permit (business license, liquor license, gaming license, broadcast license, etc.)"
    - name: "license_category"
      expr: license_category
      comment: "Category of license (operational, regulatory, professional, facility)"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the license (FCC, state gaming commission, ABC board, etc.)"
    - name: "jurisdiction_country"
      expr: jurisdiction_country
      comment: "Country jurisdiction where license is issued"
    - name: "jurisdiction_region"
      expr: jurisdiction_region
      comment: "State or regional jurisdiction where license is issued"
    - name: "is_recurring"
      expr: is_recurring
      comment: "Whether license requires recurring renewal"
    - name: "is_conditional"
      expr: is_conditional
      comment: "Whether license has compliance conditions attached"
    - name: "is_transferable"
      expr: is_transferable
      comment: "Whether license can be transferred to another entity"
    - name: "renewal_status"
      expr: renewal_status
      comment: "Status of renewal process (not due, pending, submitted, approved, overdue)"
    - name: "penalty_risk_flag"
      expr: penalty_risk_flag
      comment: "Whether license carries penalty risk if expired or non-compliant"
    - name: "expiration_risk"
      expr: CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND license_status = 'active' THEN 'expiring_90_days' WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 30) AND license_status = 'active' THEN 'expiring_30_days' WHEN expiry_date < CURRENT_DATE() THEN 'expired' ELSE 'current' END
      comment: "Expiration risk category for proactive renewal management"
  measures:
    - name: "total_licenses"
      expr: COUNT(1)
      comment: "Total number of licenses and permits tracked"
    - name: "active_licenses"
      expr: COUNT(DISTINCT CASE WHEN license_status = 'active' THEN license_permit_id END)
      comment: "Count of currently active licenses"
    - name: "expired_licenses"
      expr: COUNT(DISTINCT CASE WHEN license_status = 'expired' THEN license_permit_id END)
      comment: "Count of expired licenses requiring immediate renewal action"
    - name: "expiring_within_90_days"
      expr: COUNT(DISTINCT CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND expiry_date > CURRENT_DATE() AND license_status = 'active' THEN license_permit_id END)
      comment: "Count of licenses expiring within 90 days for proactive renewal planning"
    - name: "expiring_within_30_days"
      expr: COUNT(DISTINCT CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 30) AND expiry_date > CURRENT_DATE() AND license_status = 'active' THEN license_permit_id END)
      comment: "Count of licenses expiring within 30 days requiring urgent renewal action"
    - name: "total_license_fees"
      expr: SUM(CAST(license_fee_amount AS DOUBLE))
      comment: "Total license and permit fees paid or due"
    - name: "avg_license_fee"
      expr: AVG(CAST(license_fee_amount AS DOUBLE))
      comment: "Average license fee amount for budgeting"
    - name: "on_time_renewal_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN renewal_submission_date <= renewal_due_date THEN license_permit_id END) / NULLIF(COUNT(DISTINCT CASE WHEN renewal_submission_date IS NOT NULL THEN license_permit_id END), 0), 2)
      comment: "Percentage of licenses renewed by due date for compliance performance"
    - name: "overdue_renewal_count"
      expr: COUNT(DISTINCT CASE WHEN renewal_due_date < CURRENT_DATE() AND renewal_status NOT IN ('approved', 'submitted') THEN license_permit_id END)
      comment: "Count of licenses with overdue renewals indicating compliance risk"
    - name: "conditional_license_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_conditional = true THEN license_permit_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of licenses with compliance conditions requiring monitoring"
    - name: "penalty_risk_license_count"
      expr: COUNT(DISTINCT CASE WHEN penalty_risk_flag = true THEN license_permit_id END)
      comment: "Count of licenses carrying penalty risk if non-compliant"
    - name: "recurring_license_count"
      expr: COUNT(DISTINCT CASE WHEN is_recurring = true THEN license_permit_id END)
      comment: "Count of recurring licenses for ongoing compliance workload planning"
$$;