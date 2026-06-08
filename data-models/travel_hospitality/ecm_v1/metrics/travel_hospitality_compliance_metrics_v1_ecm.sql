-- Metric views for domain: compliance | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 03:54:25

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance audit performance and cost metrics across properties and audit types"
  source: "`travel_hospitality_ecm`.`compliance`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of compliance audit conducted (internal, external, regulatory, certification)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (scheduled, in-progress, completed, cancelled)"
    - name: "overall_audit_result"
      expr: overall_audit_result
      comment: "Overall result classification of the audit (pass, fail, conditional, pending)"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned based on audit findings (low, medium, high, critical)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction where the audit applies"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework or standard being audited against"
    - name: "certification_awarded"
      expr: certification_awarded
      comment: "Whether certification was awarded as a result of the audit"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective actions are required based on audit findings"
    - name: "follow_up_audit_required"
      expr: follow_up_audit_required
      comment: "Whether a follow-up audit is required"
    - name: "audit_year"
      expr: YEAR(scheduled_date)
      comment: "Year the audit was scheduled"
    - name: "audit_quarter"
      expr: CONCAT('Q', QUARTER(scheduled_date))
      comment: "Quarter the audit was scheduled"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of compliance audits conducted"
    - name: "total_audit_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost of all audits in local currency"
    - name: "avg_audit_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per audit"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall audit score across all audits"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS BIGINT))
      comment: "Total number of critical findings identified across all audits"
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS BIGINT))
      comment: "Total number of major findings identified across all audits"
    - name: "total_minor_findings"
      expr: SUM(CAST(minor_findings_count AS BIGINT))
      comment: "Total number of minor findings identified across all audits"
    - name: "avg_critical_findings_per_audit"
      expr: AVG(CAST(critical_findings_count AS DOUBLE))
      comment: "Average number of critical findings per audit"
    - name: "certification_award_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN certification_awarded = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits that resulted in certification being awarded"
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring corrective action"
    - name: "follow_up_audit_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_audit_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring follow-up audits"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding severity, remediation, and risk metrics for compliance management"
  source: "`travel_hospitality_ecm`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_category"
      expr: finding_category
      comment: "Category classification of the audit finding"
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding (open, in-progress, closed, verified)"
    - name: "compliance_domain"
      expr: compliance_domain
      comment: "Compliance domain the finding relates to (safety, privacy, financial, operational)"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required for this finding"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the finding has been escalated to senior management"
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether the finding must be reported to regulatory authorities"
    - name: "repeat_finding_flag"
      expr: repeat_finding_flag
      comment: "Whether this is a repeat finding from previous audits"
    - name: "guest_impact_flag"
      expr: guest_impact_flag
      comment: "Whether the finding has potential guest impact"
    - name: "root_cause_classification"
      expr: root_cause_classification
      comment: "Root cause classification of the finding"
    - name: "finding_year"
      expr: YEAR(identified_date)
      comment: "Year the finding was identified"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings identified"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Total estimated financial impact of all findings"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Average estimated financial impact per finding"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all findings"
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that have been escalated"
    - name: "repeat_finding_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN repeat_finding_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are repeat occurrences from prior audits"
    - name: "regulatory_reporting_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings requiring regulatory reporting"
    - name: "guest_impact_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN guest_impact_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings with potential guest impact"
    - name: "corrective_action_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings requiring corrective action"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`compliance_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action effectiveness, cost, and completion metrics for compliance remediation"
  source: "`travel_hospitality_ecm`.`compliance`.`corrective_action`"
  dimensions:
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Current status of the corrective action (planned, in-progress, completed, verified, overdue)"
    - name: "capa_type"
      expr: capa_type
      comment: "Type of corrective and preventive action (corrective, preventive, both)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the corrective action (low, medium, high, critical)"
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category the action addresses"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework the action supports"
    - name: "escalation_required"
      expr: escalation_required
      comment: "Whether escalation is required for this action"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether regulatory notification is required"
    - name: "recurrence_detected"
      expr: recurrence_detected
      comment: "Whether recurrence of the issue has been detected"
    - name: "effectiveness_rating"
      expr: effectiveness_rating
      comment: "Effectiveness rating of the corrective action after review"
    - name: "action_year"
      expr: YEAR(target_completion_date)
      comment: "Year the corrective action is targeted for completion"
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of corrective actions initiated"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all corrective actions"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of completed corrective actions"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per corrective action"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per completed corrective action"
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions requiring escalation"
    - name: "recurrence_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN recurrence_detected = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions where issue recurrence was detected"
    - name: "regulatory_notification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_notification_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions requiring regulatory notification"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`compliance_health_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health and safety incident severity, frequency, and impact metrics for risk management"
  source: "`travel_hospitality_ecm`.`compliance`.`health_safety_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of health and safety incident (slip/fall, injury, illness, exposure, near-miss)"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident investigation and remediation"
    - name: "injury_severity"
      expr: injury_severity
      comment: "Severity classification of the injury (minor, moderate, severe, fatal)"
    - name: "person_type_involved"
      expr: person_type_involved
      comment: "Type of person involved (guest, employee, contractor, vendor, visitor)"
    - name: "medical_treatment_provided_flag"
      expr: medical_treatment_provided_flag
      comment: "Whether medical treatment was provided"
    - name: "osha_recordable_flag"
      expr: osha_recordable_flag
      comment: "Whether the incident is OSHA recordable"
    - name: "liability_claim_filed_flag"
      expr: liability_claim_filed_flag
      comment: "Whether a liability claim has been filed"
    - name: "workers_compensation_claim_flag"
      expr: workers_compensation_claim_flag
      comment: "Whether a workers compensation claim has been filed"
    - name: "regulatory_notification_required_flag"
      expr: regulatory_notification_required_flag
      comment: "Whether regulatory notification is required"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year the incident occurred"
    - name: "incident_quarter"
      expr: CONCAT('Q', QUARTER(incident_date))
      comment: "Quarter the incident occurred"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of health and safety incidents reported"
    - name: "total_days_away_from_work"
      expr: SUM(CAST(days_away_from_work AS BIGINT))
      comment: "Total days away from work due to incidents"
    - name: "total_restricted_work_days"
      expr: SUM(CAST(restricted_work_days AS BIGINT))
      comment: "Total restricted work days due to incidents"
    - name: "avg_days_away_per_incident"
      expr: AVG(CAST(days_away_from_work AS DOUBLE))
      comment: "Average days away from work per incident"
    - name: "osha_recordable_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN osha_recordable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that are OSHA recordable"
    - name: "medical_treatment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN medical_treatment_provided_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents requiring medical treatment"
    - name: "liability_claim_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN liability_claim_filed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents resulting in liability claims"
    - name: "workers_comp_claim_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN workers_compensation_claim_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents resulting in workers compensation claims"
    - name: "regulatory_notification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_notification_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents requiring regulatory notification"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`compliance_privacy_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy incident severity, breach notification, and regulatory penalty metrics for data protection"
  source: "`travel_hospitality_ecm`.`compliance`.`privacy_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of privacy incident (breach, unauthorized access, loss, disclosure, misuse)"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the privacy incident investigation and remediation"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the privacy incident (low, medium, high, critical)"
    - name: "breach_notification_required_flag"
      expr: breach_notification_required_flag
      comment: "Whether breach notification to affected individuals is required"
    - name: "subject_notification_required_flag"
      expr: subject_notification_required_flag
      comment: "Whether data subject notification is required"
    - name: "dpo_notified_flag"
      expr: dpo_notified_flag
      comment: "Whether the Data Protection Officer has been notified"
    - name: "legal_counsel_engaged_flag"
      expr: legal_counsel_engaged_flag
      comment: "Whether legal counsel has been engaged"
    - name: "regulatory_penalty_imposed_flag"
      expr: regulatory_penalty_imposed_flag
      comment: "Whether a regulatory penalty has been imposed"
    - name: "litigation_filed_flag"
      expr: litigation_filed_flag
      comment: "Whether litigation has been filed related to the incident"
    - name: "discovery_method"
      expr: discovery_method
      comment: "Method by which the incident was discovered"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year the privacy incident occurred"
  measures:
    - name: "total_privacy_incidents"
      expr: COUNT(1)
      comment: "Total number of privacy incidents reported"
    - name: "total_estimated_subjects_affected"
      expr: SUM(CAST(estimated_subjects_affected AS BIGINT))
      comment: "Total estimated number of data subjects affected across all incidents"
    - name: "total_confirmed_subjects_affected"
      expr: SUM(CAST(confirmed_subjects_affected AS BIGINT))
      comment: "Total confirmed number of data subjects affected across all incidents"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total regulatory penalty amount imposed for privacy incidents"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average regulatory penalty amount per incident where penalty was imposed"
    - name: "breach_notification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN breach_notification_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents requiring breach notification"
    - name: "regulatory_penalty_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_penalty_imposed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents resulting in regulatory penalties"
    - name: "litigation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN litigation_filed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents resulting in litigation"
    - name: "legal_counsel_engagement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN legal_counsel_engaged_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents requiring legal counsel engagement"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`compliance_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Permit compliance, renewal, and violation metrics for regulatory license management"
  source: "`travel_hospitality_ecm`.`compliance`.`permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (business license, health permit, liquor license, building permit, environmental)"
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit (active, expired, suspended, revoked, pending)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction that issued the permit"
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the permit"
    - name: "holder_type"
      expr: holder_type
      comment: "Type of permit holder (property, corporate, individual)"
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Whether periodic inspection is required for this permit"
    - name: "permit_year"
      expr: YEAR(issue_date)
      comment: "Year the permit was issued"
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of permits held"
    - name: "total_permit_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total permit fees paid"
    - name: "total_renewal_fees"
      expr: SUM(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Total renewal fees paid"
    - name: "avg_permit_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average permit fee per permit"
    - name: "avg_renewal_fee"
      expr: AVG(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Average renewal fee per permit"
    - name: "total_violations"
      expr: SUM(CAST(violation_count AS BIGINT))
      comment: "Total number of violations recorded across all permits"
    - name: "avg_violations_per_permit"
      expr: AVG(CAST(violation_count AS DOUBLE))
      comment: "Average number of violations per permit"
    - name: "inspection_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN inspection_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits requiring periodic inspection"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`compliance_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance training completion, pass rates, and certification metrics for workforce compliance"
  source: "`travel_hospitality_ecm`.`compliance`.`compliance_training_completion`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the training completion (compliant, non-compliant, expired, pending)"
    - name: "pass_fail_result"
      expr: pass_fail_result
      comment: "Pass or fail result of the training"
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Whether the training is mandatory"
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Whether renewal of the training is required"
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Whether a waiver was granted for this training"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of training delivery (online, in-person, hybrid, self-study)"
    - name: "regulatory_category"
      expr: regulatory_category
      comment: "Regulatory category the training addresses"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year the training was completed"
  measures:
    - name: "total_training_completions"
      expr: COUNT(1)
      comment: "Total number of training completions recorded"
    - name: "total_training_cost"
      expr: SUM(CAST(training_cost_amount AS DOUBLE))
      comment: "Total cost of all training completions"
    - name: "avg_training_cost"
      expr: AVG(CAST(training_cost_amount AS DOUBLE))
      comment: "Average cost per training completion"
    - name: "total_training_hours"
      expr: SUM(CAST(training_duration_hours AS DOUBLE))
      comment: "Total training hours delivered"
    - name: "avg_training_hours"
      expr: AVG(CAST(training_duration_hours AS DOUBLE))
      comment: "Average training hours per completion"
    - name: "avg_score_achieved"
      expr: AVG(CAST(score_achieved AS DOUBLE))
      comment: "Average score achieved across all training completions"
    - name: "avg_passing_threshold"
      expr: AVG(CAST(passing_score_threshold AS DOUBLE))
      comment: "Average passing score threshold across all trainings"
    - name: "pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_result = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training completions that resulted in a pass"
    - name: "waiver_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN waiver_granted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training completions where a waiver was granted"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`compliance_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance risk identification, scoring, and mitigation effectiveness metrics for enterprise risk management"
  source: "`travel_hospitality_ecm`.`compliance`.`risk_register`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of compliance risk (regulatory, operational, financial, reputational, strategic)"
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Subcategory of the compliance risk"
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (identified, assessed, mitigated, closed, monitoring)"
    - name: "impact_rating"
      expr: impact_rating
      comment: "Impact rating of the risk (low, medium, high, critical)"
    - name: "likelihood_rating"
      expr: likelihood_rating
      comment: "Likelihood rating of the risk occurring (rare, unlikely, possible, likely, almost certain)"
    - name: "residual_impact_rating"
      expr: residual_impact_rating
      comment: "Residual impact rating after mitigation controls"
    - name: "residual_likelihood_rating"
      expr: residual_likelihood_rating
      comment: "Residual likelihood rating after mitigation controls"
    - name: "control_effectiveness"
      expr: control_effectiveness
      comment: "Effectiveness rating of control measures (ineffective, partially effective, effective, highly effective)"
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether escalation is required for this risk"
    - name: "scope_level"
      expr: scope_level
      comment: "Scope level of the risk (property, regional, enterprise)"
    - name: "risk_year"
      expr: YEAR(identification_date)
      comment: "Year the risk was identified"
  measures:
    - name: "total_risks"
      expr: COUNT(1)
      comment: "Total number of compliance risks in the register"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total estimated financial impact of all risks"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average estimated financial impact per risk"
    - name: "total_mitigation_cost"
      expr: SUM(CAST(mitigation_cost_estimate AS DOUBLE))
      comment: "Total estimated cost of mitigation measures"
    - name: "avg_mitigation_cost"
      expr: AVG(CAST(mitigation_cost_estimate AS DOUBLE))
      comment: "Average estimated mitigation cost per risk"
    - name: "total_related_incidents"
      expr: SUM(CAST(related_incident_count AS BIGINT))
      comment: "Total number of incidents related to identified risks"
    - name: "avg_related_incidents"
      expr: AVG(CAST(related_incident_count AS DOUBLE))
      comment: "Average number of related incidents per risk"
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risks requiring escalation to senior management"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing timeliness, penalty, and acceptance metrics for compliance reporting"
  source: "`travel_hospitality_ecm`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (annual report, tax filing, environmental report, safety report)"
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing (draft, submitted, accepted, rejected, amended)"
    - name: "filing_method"
      expr: filing_method
      comment: "Method used to submit the filing (electronic, paper, portal, email)"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction code where the filing is required"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body receiving the filing"
    - name: "penalty_assessed_flag"
      expr: penalty_assessed_flag
      comment: "Whether a penalty was assessed for late or non-compliant filing"
    - name: "penalty_paid_flag"
      expr: penalty_paid_flag
      comment: "Whether assessed penalty has been paid"
    - name: "regulatory_response_received_flag"
      expr: regulatory_response_received_flag
      comment: "Whether a response has been received from the regulatory body"
    - name: "filing_year"
      expr: YEAR(due_date)
      comment: "Year the filing was due"
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total number of regulatory filings"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount assessed for all filings"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per filing where penalty was assessed"
    - name: "penalty_assessment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN penalty_assessed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings that resulted in penalty assessment"
    - name: "penalty_payment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN penalty_paid_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN penalty_assessed_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of assessed penalties that have been paid"
    - name: "regulatory_response_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_response_received_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings that received a regulatory response"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`compliance_policy_acknowledgment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy acknowledgment completion, timeliness, and waiver metrics for policy compliance tracking"
  source: "`travel_hospitality_ecm`.`compliance`.`policy_acknowledgment`"
  dimensions:
    - name: "acknowledgment_status"
      expr: acknowledgment_status
      comment: "Status of the policy acknowledgment (pending, completed, overdue, waived)"
    - name: "acknowledgment_method"
      expr: acknowledgment_method
      comment: "Method used to acknowledge the policy (electronic signature, click-through, paper, verbal)"
    - name: "acknowledgment_channel"
      expr: acknowledgment_channel
      comment: "Channel through which acknowledgment was captured (portal, email, mobile app, in-person)"
    - name: "re_acknowledgment_required_flag"
      expr: re_acknowledgment_required_flag
      comment: "Whether periodic re-acknowledgment is required"
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Whether a waiver was granted for this acknowledgment"
    - name: "department_code"
      expr: department_code
      comment: "Department code of the acknowledging employee"
    - name: "job_role_code"
      expr: job_role_code
      comment: "Job role code of the acknowledging employee"
    - name: "acknowledgment_year"
      expr: YEAR(acknowledgment_date)
      comment: "Year the policy was acknowledged"
  measures:
    - name: "total_acknowledgments"
      expr: COUNT(1)
      comment: "Total number of policy acknowledgments recorded"
    - name: "total_reminders_sent"
      expr: SUM(CAST(reminder_sent_count AS BIGINT))
      comment: "Total number of reminder notifications sent"
    - name: "avg_reminders_per_acknowledgment"
      expr: AVG(CAST(reminder_sent_count AS DOUBLE))
      comment: "Average number of reminders sent per acknowledgment"
    - name: "waiver_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN waiver_granted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of acknowledgments where a waiver was granted"
    - name: "re_acknowledgment_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN re_acknowledgment_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of acknowledgments requiring periodic re-acknowledgment"
$$;