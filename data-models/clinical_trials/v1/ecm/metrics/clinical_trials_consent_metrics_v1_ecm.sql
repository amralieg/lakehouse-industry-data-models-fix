-- Metric views for domain: consent | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-06 23:23:25

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`consent_subject_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core consent metrics tracking informed consent rates, methods, compliance, and withdrawal patterns across clinical trial subjects."
  source: "`clinical_trials_ecm`.`consent`.`subject_consent`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the subject consent (e.g., signed, pending, withdrawn)"
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent obtained (e.g., main study, optional sub-study, genetic)"
    - name: "consent_method"
      expr: consent_method
      comment: "Method used to obtain consent (e.g., wet-ink, eConsent, remote)"
    - name: "consent_year_month"
      expr: DATE_TRUNC('month', consent_date)
      comment: "Month in which consent was obtained for trend analysis"
    - name: "icf_version_number"
      expr: icf_version_number
      comment: "ICF version number used at time of consent"
    - name: "reconsent_required_flag"
      expr: CASE WHEN reconsent_required = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether reconsent is required for this subject"
    - name: "lar_involved_flag"
      expr: CASE WHEN lar_involved = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether a Legally Authorized Representative was involved"
    - name: "gdpr_lawful_basis"
      expr: gdpr_lawful_basis
      comment: "GDPR lawful basis for data processing"
    - name: "consenting_staff_role"
      expr: consenting_staff_role
      comment: "Role of the staff member who obtained consent"
    - name: "translation_language"
      expr: translation_language
      comment: "Language in which consent was provided"
  measures:
    - name: "total_consents"
      expr: COUNT(1)
      comment: "Total number of consent records across all statuses"
    - name: "active_consents"
      expr: SUM(CASE WHEN consent_status = 'signed' THEN 1 ELSE 0 END)
      comment: "Number of currently active/signed consents"
    - name: "withdrawn_consents"
      expr: SUM(CASE WHEN consent_status = 'withdrawn' THEN 1 ELSE 0 END)
      comment: "Number of consents that have been withdrawn"
    - name: "withdrawal_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_status = 'withdrawn' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents that resulted in withdrawal — key retention indicator"
    - name: "econsent_adoption_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_method = 'eConsent' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents obtained via eConsent platform — digital transformation KPI"
    - name: "reconsent_pending_count"
      expr: SUM(CASE WHEN reconsent_required = TRUE AND consent_status != 'withdrawn' THEN 1 ELSE 0 END)
      comment: "Number of active subjects requiring reconsent — compliance risk indicator"
    - name: "avg_comprehension_score"
      expr: AVG(CAST(comprehension_assessment_score AS DOUBLE))
      comment: "Average comprehension assessment score — quality of consent process indicator"
    - name: "hipaa_authorization_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hipaa_authorization_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents with HIPAA authorization obtained — US regulatory compliance"
    - name: "lar_involvement_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN lar_involved = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents involving a Legally Authorized Representative — vulnerable population indicator"
    - name: "distinct_subjects_consented"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique trial subjects who have provided consent"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`consent_deviation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent deviation metrics tracking protocol non-compliance, severity, resolution timelines, and regulatory reporting obligations."
  source: "`clinical_trials_ecm`.`consent`.`consent_deviation`"
  dimensions:
    - name: "deviation_type"
      expr: deviation_type
      comment: "Classification of the consent deviation (e.g., missed reconsent, wrong version)"
    - name: "deviation_status"
      expr: deviation_status
      comment: "Current status of the deviation (e.g., open, resolved, closed)"
    - name: "severity"
      expr: severity
      comment: "Severity level of the deviation (e.g., minor, major, critical)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for deviation trending and CAPA analysis"
    - name: "discovery_month"
      expr: DATE_TRUNC('month', discovery_date)
      comment: "Month of deviation discovery for trend analysis"
    - name: "regulatory_reportable_flag"
      expr: CASE WHEN regulatory_reportable = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether the deviation requires regulatory reporting"
    - name: "subject_rights_impacted_flag"
      expr: CASE WHEN subject_rights_impacted = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether subject rights were impacted by the deviation"
    - name: "reconsent_required_flag"
      expr: CASE WHEN reconsent_required = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether reconsent is required as corrective action"
  measures:
    - name: "total_deviations"
      expr: COUNT(1)
      comment: "Total number of consent deviations recorded"
    - name: "open_deviations"
      expr: SUM(CASE WHEN deviation_status = 'open' THEN 1 ELSE 0 END)
      comment: "Number of unresolved consent deviations — active compliance risk"
    - name: "critical_deviations"
      expr: SUM(CASE WHEN severity = 'critical' THEN 1 ELSE 0 END)
      comment: "Number of critical severity deviations requiring immediate attention"
    - name: "regulatory_reportable_count"
      expr: SUM(CASE WHEN regulatory_reportable = TRUE THEN 1 ELSE 0 END)
      comment: "Number of deviations requiring regulatory authority notification"
    - name: "subject_rights_impacted_count"
      expr: SUM(CASE WHEN subject_rights_impacted = TRUE THEN 1 ELSE 0 END)
      comment: "Number of deviations that impacted subject rights — ethical risk indicator"
    - name: "data_integrity_impacted_count"
      expr: SUM(CASE WHEN data_integrity_impacted = TRUE THEN 1 ELSE 0 END)
      comment: "Number of deviations impacting data integrity — study validity risk"
    - name: "reconsent_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reconsent_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deviations requiring reconsent as corrective action"
    - name: "avg_resolution_days"
      expr: AVG(CAST(DATEDIFF(resolution_date, discovery_date) AS DOUBLE))
      comment: "Average days from discovery to resolution — operational efficiency metric"
    - name: "distinct_affected_subjects"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects affected by consent deviations"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`consent_econsent_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "eConsent session metrics tracking digital consent completion, comprehension, technical reliability, and session quality."
  source: "`clinical_trials_ecm`.`consent`.`econsent_session`"
  dimensions:
    - name: "session_status"
      expr: session_status
      comment: "Status of the eConsent session (e.g., completed, abandoned, in-progress)"
    - name: "session_modality"
      expr: session_modality
      comment: "Modality of the session (e.g., in-person, remote, hybrid)"
    - name: "device_type"
      expr: device_type
      comment: "Type of device used for eConsent (e.g., tablet, phone, desktop)"
    - name: "session_language"
      expr: session_language
      comment: "Language used during the eConsent session"
    - name: "session_month"
      expr: DATE_TRUNC('month', session_start_timestamp)
      comment: "Month of session start for trend analysis"
    - name: "consenter_role"
      expr: consenter_role
      comment: "Role of the person consenting (e.g., subject, LAR)"
    - name: "subject_location_country"
      expr: subject_location_country
      comment: "Country where the subject was located during session"
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of eConsent sessions initiated"
    - name: "completed_sessions"
      expr: SUM(CASE WHEN session_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Number of sessions completed successfully"
    - name: "session_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN session_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions that completed successfully — platform effectiveness KPI"
    - name: "consent_granted_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_granted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions resulting in consent granted — recruitment effectiveness"
    - name: "comprehension_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN comprehension_overall_passed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions where subject passed comprehension check — ICF quality indicator"
    - name: "technical_issue_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN technical_issue_encountered = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions with technical issues — platform reliability metric"
    - name: "remediation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN remediation_provided = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions requiring remediation — ICF complexity indicator"
    - name: "esignature_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN esignature_captured = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions with e-signature captured — process completion indicator"
    - name: "distinct_subjects"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects who participated in eConsent sessions"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`consent_withdrawal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent withdrawal metrics tracking subject attrition, withdrawal patterns, safety follow-up compliance, and study impact."
  source: "`clinical_trials_ecm`.`consent`.`withdrawal`"
  dimensions:
    - name: "withdrawal_type"
      expr: withdrawal_type
      comment: "Type of withdrawal (e.g., full, partial, specific consent element)"
    - name: "withdrawal_status"
      expr: withdrawal_status
      comment: "Current processing status of the withdrawal"
    - name: "reason_category"
      expr: reason_category
      comment: "Categorized reason for withdrawal for trend analysis"
    - name: "withdrawal_method"
      expr: withdrawal_method
      comment: "Method by which withdrawal was communicated"
    - name: "initiated_by"
      expr: initiated_by
      comment: "Who initiated the withdrawal (e.g., subject, investigator, sponsor)"
    - name: "withdrawal_month"
      expr: DATE_TRUNC('month', withdrawal_timestamp)
      comment: "Month of withdrawal for trend analysis"
    - name: "safety_follow_up_required_flag"
      expr: CASE WHEN safety_follow_up_required = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether safety follow-up is required post-withdrawal"
    - name: "data_retention_status"
      expr: data_retention_status
      comment: "Status of data retention decision post-withdrawal"
  measures:
    - name: "total_withdrawals"
      expr: COUNT(1)
      comment: "Total number of consent withdrawals recorded"
    - name: "subject_initiated_withdrawals"
      expr: SUM(CASE WHEN initiated_by = 'subject' THEN 1 ELSE 0 END)
      comment: "Number of withdrawals initiated by the subject — patient experience indicator"
    - name: "safety_follow_up_required_count"
      expr: SUM(CASE WHEN safety_follow_up_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of withdrawals requiring safety follow-up — regulatory obligation tracking"
    - name: "protocol_deviation_triggered_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN protocol_deviation_triggered = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of withdrawals that triggered a protocol deviation — compliance impact"
    - name: "reconsent_attempted_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reconsent_attempted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of withdrawals where reconsent was attempted before finalization — retention effort indicator"
    - name: "distinct_withdrawn_subjects"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects who withdrew consent"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`consent_reconsent_trigger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reconsent trigger metrics tracking compliance with reconsent obligations, completion rates, and timeliness of reconsent processes."
  source: "`clinical_trials_ecm`.`consent`.`reconsent_trigger`"
  dimensions:
    - name: "trigger_type"
      expr: trigger_type
      comment: "Type of event that triggered reconsent (e.g., protocol amendment, safety update, regulatory)"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the reconsent trigger"
    - name: "consent_method"
      expr: consent_method
      comment: "Method used for reconsent (e.g., wet-ink, eConsent)"
    - name: "trigger_month"
      expr: DATE_TRUNC('month', trigger_date)
      comment: "Month when the reconsent trigger was raised"
    - name: "escalation_required_flag"
      expr: CASE WHEN escalation_required = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether escalation was required for this trigger"
    - name: "subject_scope"
      expr: subject_scope
      comment: "Scope of subjects affected (e.g., all active, specific cohort)"
  measures:
    - name: "total_reconsent_triggers"
      expr: COUNT(1)
      comment: "Total number of reconsent triggers raised"
    - name: "resolved_triggers"
      expr: SUM(CASE WHEN resolution_status = 'resolved' THEN 1 ELSE 0 END)
      comment: "Number of reconsent triggers fully resolved"
    - name: "resolution_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN resolution_status = 'resolved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reconsent triggers resolved — compliance completion KPI"
    - name: "overdue_reconsents"
      expr: SUM(CASE WHEN reconsent_deadline < CURRENT_DATE() AND resolution_status != 'resolved' THEN 1 ELSE 0 END)
      comment: "Number of reconsent triggers past deadline and unresolved — critical compliance risk"
    - name: "subject_withdrawal_count"
      expr: SUM(CASE WHEN subject_withdrawal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of triggers that resulted in subject withdrawal — retention impact"
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of triggers requiring escalation — process efficiency indicator"
    - name: "avg_days_to_resolution"
      expr: AVG(CAST(DATEDIFF(reconsent_completed_date, trigger_date) AS DOUBLE))
      comment: "Average days from trigger to reconsent completion — operational speed metric"
    - name: "distinct_affected_subjects"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects affected by reconsent triggers"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`consent_capacity_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity assessment metrics tracking vulnerable population consent processes, assessment outcomes, and compliance with capacity evaluation requirements."
  source: "`clinical_trials_ecm`.`consent`.`capacity_assessment`"
  dimensions:
    - name: "assessment_outcome"
      expr: assessment_outcome
      comment: "Outcome of the capacity assessment (e.g., capable, incapable, borderline)"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of capacity assessment performed"
    - name: "assessment_tool"
      expr: assessment_tool
      comment: "Tool/instrument used for capacity assessment"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment record"
    - name: "vulnerability_category"
      expr: vulnerability_category
      comment: "Category of vulnerability for the assessed subject"
    - name: "assessor_role"
      expr: assessor_role
      comment: "Role of the person performing the assessment"
    - name: "assessment_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of assessment for trend analysis"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of capacity assessments performed"
    - name: "capable_outcome_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN assessment_outcome = 'capable' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments resulting in capable outcome — population characterization"
    - name: "incapable_outcome_count"
      expr: SUM(CASE WHEN assessment_outcome = 'incapable' THEN 1 ELSE 0 END)
      comment: "Number of assessments resulting in incapable outcome — LAR requirement trigger"
    - name: "lar_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN lar_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments requiring LAR involvement"
    - name: "reassessment_required_count"
      expr: SUM(CASE WHEN reassessment_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of assessments flagging need for reassessment — ongoing monitoring burden"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average capacity assessment score across all assessments"
    - name: "vulnerable_population_count"
      expr: SUM(CASE WHEN vulnerable_population_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of assessments for vulnerable populations — regulatory scrutiny indicator"
    - name: "distinct_subjects_assessed"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects who underwent capacity assessment"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`consent_gdpr_data_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GDPR and data privacy consent metrics tracking regulatory compliance, data subject rights requests, and privacy consent status across jurisdictions."
  source: "`clinical_trials_ecm`.`consent`.`gdpr_data_consent`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the GDPR data consent"
    - name: "legal_basis"
      expr: legal_basis
      comment: "GDPR lawful basis for processing (e.g., consent, legitimate interest)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction/country governing the data consent"
    - name: "consent_collection_method"
      expr: consent_collection_method
      comment: "Method used to collect GDPR consent"
    - name: "consent_month"
      expr: DATE_TRUNC('month', consent_date)
      comment: "Month of consent collection for trend analysis"
    - name: "privacy_notice_version"
      expr: privacy_notice_version
      comment: "Version of privacy notice provided to subject"
  measures:
    - name: "total_gdpr_consents"
      expr: COUNT(1)
      comment: "Total number of GDPR data consent records"
    - name: "active_consents"
      expr: SUM(CASE WHEN consent_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of currently active GDPR consents"
    - name: "withdrawn_consents"
      expr: SUM(CASE WHEN consent_status = 'withdrawn' THEN 1 ELSE 0 END)
      comment: "Number of withdrawn GDPR consents — data subject rights exercise"
    - name: "data_erasure_request_count"
      expr: SUM(CASE WHEN data_erasure_requested = TRUE THEN 1 ELSE 0 END)
      comment: "Number of data erasure (right to be forgotten) requests — GDPR Art 17 compliance"
    - name: "secondary_research_consent_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN secondary_research_consent = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subjects consenting to secondary research use — future research value"
    - name: "biobanking_consent_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN biobanking_consent = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subjects consenting to biobanking — sample repository value"
    - name: "reconsent_required_count"
      expr: SUM(CASE WHEN re_consent_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of GDPR consents requiring reconsent — compliance workload indicator"
    - name: "distinct_subjects"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects with GDPR consent records"
$$;