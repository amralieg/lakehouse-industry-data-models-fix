-- Metric views for domain: consent | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core consent record metrics tracking consent capture effectiveness, compliance rates, and consent lifecycle management across the health system."
  source: "`healthcare_ecm_v1`.`consent`.`consent_record`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_consent_records"
      expr: COUNT(1)
      comment: "Total number of consent records for volume tracking and capacity planning"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`consent_workflow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent workflow operational metrics tracking SLA compliance, escalation rates, and workflow throughput for consent management process optimization."
  source: "`healthcare_ecm_v1`.`consent`.`consent_workflow_tbl`"
  dimensions:
    - name: "workflow_type"
      expr: workflow_type
      comment: "Type of consent workflow (initial, renewal, revocation, amendment)"
    - name: "priority"
      expr: priority
      comment: "Workflow priority level for resource allocation analysis"
    - name: "consent_category"
      expr: consent_category
      comment: "Category of consent being processed"
    - name: "delivery_method"
      expr: delivery_method
      comment: "How consent materials are delivered to patient"
    - name: "signature_method"
      expr: signature_method
      comment: "Method of signature capture (wet ink, electronic, verbal)"
    - name: "language_code"
      expr: language_code
      comment: "Language of consent workflow for LEP compliance"
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_timestamp)
      comment: "Month workflow was initiated for trend analysis"
  measures:
    - name: "total_workflows"
      expr: COUNT(1)
      comment: "Total consent workflows for volume and capacity planning"
    - name: "unique_patients_in_workflow"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with active consent workflows for workload assessment"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`consent_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent verification metrics tracking point-of-care consent validation effectiveness, override rates, and compliance gaps for HIPAA and regulatory adherence."
  source: "`healthcare_ecm_v1`.`consent`.`consent_consent_verification`"
  dimensions:
    - name: "verification_result"
      expr: verification_result
      comment: "Outcome of verification check (valid, expired, not found, restricted)"
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify consent (electronic, manual, system-automated)"
    - name: "verification_source"
      expr: verification_source
      comment: "Source system where verification was performed"
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent being verified"
    - name: "consent_scope"
      expr: consent_scope
      comment: "Scope of consent being verified"
    - name: "override_flag"
      expr: override_flag
      comment: "Whether consent verification was overridden"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether verification met compliance requirements"
    - name: "restriction_flag"
      expr: restriction_flag
      comment: "Whether consent has restrictions that limit data access"
    - name: "verification_month"
      expr: DATE_TRUNC('MONTH', verification_timestamp)
      comment: "Month of verification for trend analysis"
  measures:
    - name: "total_verifications"
      expr: COUNT(1)
      comment: "Total consent verifications performed for system utilization tracking"
    - name: "override_count"
      expr: COUNT(CASE WHEN override_flag = TRUE THEN 1 END)
      comment: "Count of consent overrides requiring audit review and appropriateness assessment"
    - name: "non_compliant_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Count of non-compliant verifications indicating regulatory risk exposure"
    - name: "restricted_consent_count"
      expr: COUNT(CASE WHEN restriction_flag = TRUE THEN 1 END)
      comment: "Count of restricted consents requiring special handling for patient privacy preferences"
    - name: "notification_sent_count"
      expr: COUNT(CASE WHEN notification_sent_flag = TRUE THEN 1 END)
      comment: "Count of notifications triggered by verification for patient communication tracking"
    - name: "avg_verification_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average time to complete verification for workflow efficiency optimization"
    - name: "unique_patients_verified"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients whose consent was verified for coverage analysis"
    - name: "error_verification_count"
      expr: COUNT(CASE WHEN error_code IS NOT NULL THEN 1 END)
      comment: "Count of verification errors indicating system integration issues requiring IT intervention"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`consent_disclosure_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PHI disclosure tracking metrics for HIPAA Accounting of Disclosures compliance, minimum necessary standard adherence, and breach risk monitoring."
  source: "`healthcare_ecm_v1`.`consent`.`disclosure_log`"
  dimensions:
    - name: "disclosure_purpose"
      expr: disclosure_purpose
      comment: "Purpose of PHI disclosure (treatment, payment, operations, legal, research)"
    - name: "disclosure_purpose_category"
      expr: disclosure_purpose_category
      comment: "Broad category of disclosure purpose for regulatory reporting"
    - name: "disclosure_method"
      expr: disclosure_method
      comment: "Method of disclosure (electronic, fax, mail, verbal)"
    - name: "disclosure_status"
      expr: disclosure_status
      comment: "Status of the disclosure event"
    - name: "recipient_type"
      expr: recipient_type
      comment: "Type of recipient (provider, payer, patient, legal, research)"
    - name: "is_tpo_disclosure"
      expr: is_tpo_disclosure
      comment: "Whether disclosure is for Treatment/Payment/Operations (TPO exemption from accounting)"
    - name: "is_accounting_required"
      expr: is_accounting_required
      comment: "Whether disclosure must be included in Accounting of Disclosures per HIPAA"
    - name: "minimum_necessary_applied"
      expr: minimum_necessary_applied
      comment: "Whether minimum necessary standard was applied to the disclosure"
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for the disclosure (consent, court order, public health, etc.)"
    - name: "disclosure_month"
      expr: DATE_TRUNC('MONTH', disclosure_timestamp)
      comment: "Month of disclosure for trend and volume analysis"
  measures:
    - name: "total_disclosures"
      expr: COUNT(1)
      comment: "Total PHI disclosures for volume monitoring and HIPAA compliance reporting"
    - name: "accounting_required_disclosures"
      expr: COUNT(CASE WHEN is_accounting_required = TRUE THEN 1 END)
      comment: "Disclosures requiring Accounting of Disclosures entry per HIPAA §164.528"
    - name: "non_tpo_disclosures"
      expr: COUNT(CASE WHEN is_tpo_disclosure = FALSE THEN 1 END)
      comment: "Non-TPO disclosures requiring heightened scrutiny and documentation"
    - name: "minimum_necessary_not_applied_count"
      expr: COUNT(CASE WHEN minimum_necessary_applied = FALSE THEN 1 END)
      comment: "Disclosures where minimum necessary was not applied indicating potential over-disclosure risk"
    - name: "patient_notification_required_count"
      expr: COUNT(CASE WHEN patient_notification_required = TRUE THEN 1 END)
      comment: "Disclosures requiring patient notification for transparency compliance"
    - name: "unique_patients_disclosed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients whose PHI was disclosed for privacy impact assessment"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`consent_revocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent revocation metrics tracking patient withdrawal patterns, operational impact of revocations, and timeliness of revocation processing for patient rights compliance."
  source: "`healthcare_ecm_v1`.`consent`.`revocation`"
  dimensions:
    - name: "revocation_status"
      expr: revocation_status
      comment: "Current status of the revocation (pending, processed, rejected)"
    - name: "revocation_scope"
      expr: revocation_scope
      comment: "Scope of revocation (full, partial) indicating extent of consent withdrawal"
    - name: "revocation_method"
      expr: revocation_method
      comment: "Method used to submit revocation (written, electronic, verbal)"
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for revocation for pattern analysis"
    - name: "revocation_month"
      expr: DATE_TRUNC('MONTH', revocation_timestamp)
      comment: "Month of revocation for trend analysis"
  measures:
    - name: "total_revocations"
      expr: COUNT(1)
      comment: "Total consent revocations for patient rights compliance monitoring"
    - name: "processed_revocations"
      expr: COUNT(CASE WHEN revocation_status = 'processed' THEN 1 END)
      comment: "Successfully processed revocations for throughput tracking"
    - name: "pending_revocations"
      expr: COUNT(CASE WHEN revocation_status = 'pending' THEN 1 END)
      comment: "Pending revocations requiring action to meet regulatory timelines"
    - name: "data_access_restricted_count"
      expr: COUNT(CASE WHEN data_access_restricted_flag = TRUE THEN 1 END)
      comment: "Revocations where data access has been restricted confirming enforcement"
    - name: "disclosures_halted_count"
      expr: COUNT(CASE WHEN disclosures_halted_flag = TRUE THEN 1 END)
      comment: "Revocations where disclosures have been halted confirming compliance"
    - name: "legal_review_required_count"
      expr: COUNT(CASE WHEN legal_review_required_flag = TRUE THEN 1 END)
      comment: "Revocations requiring legal review indicating complexity or risk"
    - name: "unique_patients_revoking"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients who revoked consent for patient satisfaction and trust analysis"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`consent_expiration_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent expiration alert metrics tracking proactive renewal management, SLA compliance for alert resolution, and care continuity risk from expiring consents."
  source: "`healthcare_ecm_v1`.`consent`.`expiration_alert`"
  dimensions:
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the expiration alert (open, acknowledged, resolved, escalated)"
    - name: "alert_type"
      expr: alert_type
      comment: "Type of expiration alert for categorization"
    - name: "alert_priority"
      expr: alert_priority
      comment: "Priority level of the alert for triage"
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent approaching expiration"
    - name: "resolution_status"
      expr: resolution_status
      comment: "How the alert was resolved (renewed, expired, waived)"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether alert was escalated indicating process failure"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether SLA was breached for the alert resolution"
    - name: "alert_month"
      expr: DATE_TRUNC('MONTH', alert_generation_timestamp)
      comment: "Month alert was generated for volume trending"
  measures:
    - name: "total_expiration_alerts"
      expr: COUNT(1)
      comment: "Total expiration alerts generated for workload and capacity planning"
    - name: "sla_breached_alert_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Alerts where SLA was breached indicating staffing or process gaps"
    - name: "escalated_alert_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Escalated alerts indicating first-line resolution failure"
    - name: "care_impact_alert_count"
      expr: COUNT(CASE WHEN care_impact_flag = TRUE THEN 1 END)
      comment: "Alerts with potential care delivery impact requiring urgent resolution"
    - name: "auto_renewal_eligible_count"
      expr: COUNT(CASE WHEN auto_renewal_eligible_flag = TRUE THEN 1 END)
      comment: "Alerts eligible for auto-renewal reducing manual workload"
    - name: "patient_contact_attempted_count"
      expr: COUNT(CASE WHEN patient_contact_attempted_flag = TRUE THEN 1 END)
      comment: "Alerts where patient contact was attempted for outreach effectiveness tracking"
    - name: "unique_patients_with_expiring_consent"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with expiring consents for care continuity risk assessment"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`consent_deficiency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent deficiency metrics tracking documentation gaps, remediation timeliness, and patient safety impact for quality improvement and regulatory compliance."
  source: "`healthcare_ecm_v1`.`consent`.`deficiency`"
  dimensions:
    - name: "deficiency_type"
      expr: deficiency_type
      comment: "Type of consent deficiency (missing signature, expired, incomplete, wrong form)"
    - name: "deficiency_category"
      expr: deficiency_category
      comment: "Category of deficiency for root cause analysis"
    - name: "deficiency_status"
      expr: deficiency_status
      comment: "Current status of deficiency (open, remediated, waived, escalated)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the deficiency for prioritization"
    - name: "discovery_method"
      expr: discovery_method
      comment: "How deficiency was discovered (audit, pre-procedure check, system alert)"
    - name: "patient_safety_impact_flag"
      expr: patient_safety_impact_flag
      comment: "Whether deficiency has patient safety implications"
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Whether deficiency has regulatory compliance implications"
    - name: "discovery_month"
      expr: DATE_TRUNC('MONTH', discovery_timestamp)
      comment: "Month deficiency was discovered for trend analysis"
  measures:
    - name: "total_deficiencies"
      expr: COUNT(1)
      comment: "Total consent deficiencies for quality monitoring and benchmarking"
    - name: "open_deficiency_count"
      expr: COUNT(CASE WHEN deficiency_status = 'open' THEN 1 END)
      comment: "Currently open deficiencies requiring remediation action"
    - name: "patient_safety_impact_count"
      expr: COUNT(CASE WHEN patient_safety_impact_flag = TRUE THEN 1 END)
      comment: "Deficiencies with patient safety impact requiring immediate intervention"
    - name: "regulatory_impact_count"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Deficiencies with regulatory impact for compliance risk assessment"
    - name: "escalation_required_count"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END)
      comment: "Deficiencies requiring escalation indicating systemic issues"
    - name: "remediation_required_count"
      expr: COUNT(CASE WHEN remediation_required_flag = TRUE THEN 1 END)
      comment: "Deficiencies requiring active remediation for workload planning"
    - name: "unique_patients_with_deficiency"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients affected by consent deficiencies for risk exposure assessment"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`consent_behavioral_health_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "42 CFR Part 2 behavioral health consent metrics tracking substance use and mental health consent compliance, redisclosure prohibition adherence, and specialized consent management."
  source: "`healthcare_ecm_v1`.`consent`.`behavioral_health_consent`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of behavioral health consent (substance use, mental health, combined)"
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the behavioral health consent"
    - name: "disclosure_purpose_category"
      expr: disclosure_purpose_category
      comment: "Category of authorized disclosure purpose"
    - name: "authorized_recipient_type"
      expr: authorized_recipient_type
      comment: "Type of authorized recipient for disclosure"
    - name: "state_jurisdiction"
      expr: state_jurisdiction
      comment: "State jurisdiction for state-specific behavioral health consent laws"
    - name: "legal_authority_type"
      expr: legal_authority_type
      comment: "Legal authority basis for consent (42 CFR Part 2, state law, court order)"
    - name: "substance_abuse_records_included_flag"
      expr: substance_abuse_records_included_flag
      comment: "Whether SUD records are included requiring 42 CFR Part 2 protections"
    - name: "psychotherapy_notes_included_flag"
      expr: psychotherapy_notes_included_flag
      comment: "Whether psychotherapy notes are included requiring heightened HIPAA protections"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month consent became effective for trend analysis"
  measures:
    - name: "total_bh_consents"
      expr: COUNT(1)
      comment: "Total behavioral health consents for 42 CFR Part 2 compliance volume tracking"
    - name: "active_bh_consent_count"
      expr: COUNT(CASE WHEN consent_status = 'active' THEN 1 END)
      comment: "Active behavioral health consents indicating current authorized disclosures"
    - name: "sud_records_included_count"
      expr: COUNT(CASE WHEN substance_abuse_records_included_flag = TRUE THEN 1 END)
      comment: "Consents including SUD records requiring strict 42 CFR Part 2 compliance"
    - name: "psychotherapy_notes_count"
      expr: COUNT(CASE WHEN psychotherapy_notes_included_flag = TRUE THEN 1 END)
      comment: "Consents including psychotherapy notes requiring heightened privacy protections"
    - name: "capacity_assessment_performed_count"
      expr: COUNT(CASE WHEN capacity_assessment_performed_flag = TRUE THEN 1 END)
      comment: "Consents where capacity was assessed for vulnerable population compliance"
    - name: "interpreter_required_count"
      expr: COUNT(CASE WHEN interpreter_required_flag = TRUE THEN 1 END)
      comment: "BH consents requiring interpreter for language access compliance"
    - name: "legal_representative_count"
      expr: COUNT(CASE WHEN legal_representative_flag = TRUE THEN 1 END)
      comment: "Consents obtained from legal representative for guardianship tracking"
    - name: "unique_bh_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with behavioral health consents for population coverage"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`consent_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent exception metrics tracking emergency and legally-mandated exceptions to normal consent requirements for audit compliance and appropriateness review."
  source: "`healthcare_ecm_v1`.`consent`.`consent_consent_exception`"
  dimensions:
    - name: "consent_exception_type"
      expr: consent_exception_type
      comment: "Type of exception (emergency, public health, law enforcement, imminent danger)"
    - name: "consent_exception_status"
      expr: consent_exception_status
      comment: "Current status of the exception"
    - name: "legal_basis_code"
      expr: legal_basis_code
      comment: "Legal basis for the exception per HIPAA or state law"
    - name: "emergency_treatment_flag"
      expr: emergency_treatment_flag
      comment: "Whether exception was for emergency treatment"
    - name: "imminent_danger_flag"
      expr: imminent_danger_flag
      comment: "Whether exception was invoked for imminent danger to patient or others"
    - name: "reviewed_by_privacy_officer_flag"
      expr: reviewed_by_privacy_officer_flag
      comment: "Whether privacy officer reviewed the exception"
    - name: "exception_month"
      expr: DATE_TRUNC('MONTH', invoked_timestamp)
      comment: "Month exception was invoked for trend analysis"
  measures:
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Total consent exceptions for audit and compliance monitoring"
    - name: "emergency_treatment_exceptions"
      expr: COUNT(CASE WHEN emergency_treatment_flag = TRUE THEN 1 END)
      comment: "Emergency treatment exceptions for appropriateness review"
    - name: "imminent_danger_exceptions"
      expr: COUNT(CASE WHEN imminent_danger_flag = TRUE THEN 1 END)
      comment: "Imminent danger exceptions for safety and legal compliance"
    - name: "privacy_officer_reviewed_count"
      expr: COUNT(CASE WHEN reviewed_by_privacy_officer_flag = TRUE THEN 1 END)
      comment: "Exceptions reviewed by privacy officer for governance compliance"
    - name: "unreviewed_exception_count"
      expr: COUNT(CASE WHEN reviewed_by_privacy_officer_flag = FALSE THEN 1 END)
      comment: "Exceptions not yet reviewed by privacy officer indicating review backlog"
    - name: "disputed_exception_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Disputed exceptions requiring resolution for patient rights compliance"
    - name: "active_exception_count"
      expr: COUNT(CASE WHEN active_flag = TRUE THEN 1 END)
      comment: "Currently active exceptions for ongoing monitoring"
    - name: "unique_patients_with_exceptions"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with consent exceptions for risk exposure tracking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`consent_treatment_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Treatment and procedure consent metrics tracking informed consent completeness, capacity assessment compliance, and surgical/procedural consent readiness."
  source: "`healthcare_ecm_v1`.`consent`.`treatment_consent`"
  dimensions:
    - name: "consent_method"
      expr: consent_method
      comment: "Method of obtaining treatment consent (written, electronic, verbal)"
    - name: "capacity_determination"
      expr: capacity_determination
      comment: "Patient capacity determination outcome for informed consent validity"
    - name: "interpreter_required_flag"
      expr: interpreter_required_flag
      comment: "Whether interpreter was required for informed consent discussion"
    - name: "legal_representative_required_flag"
      expr: legal_representative_required_flag
      comment: "Whether legal representative was required for consent"
    - name: "witness_required_flag"
      expr: witness_required_flag
      comment: "Whether witness was required for consent validity"
    - name: "emergency_exception_flag"
      expr: emergency_exception_flag
      comment: "Whether emergency exception was invoked bypassing normal consent"
    - name: "consent_month"
      expr: DATE_TRUNC('MONTH', created_datetime)
      comment: "Month consent was created for trend analysis"
  measures:
    - name: "total_treatment_consents"
      expr: COUNT(1)
      comment: "Total treatment consents for surgical and procedural volume tracking"
    - name: "emergency_exception_count"
      expr: COUNT(CASE WHEN emergency_exception_flag = TRUE THEN 1 END)
      comment: "Emergency exceptions to treatment consent for appropriateness audit"
    - name: "interpreter_required_count"
      expr: COUNT(CASE WHEN interpreter_required_flag = TRUE THEN 1 END)
      comment: "Treatment consents requiring interpreter for language access compliance"
    - name: "legal_representative_required_count"
      expr: COUNT(CASE WHEN legal_representative_required_flag = TRUE THEN 1 END)
      comment: "Consents requiring legal representative for vulnerable population tracking"
    - name: "patient_questions_addressed_count"
      expr: COUNT(CASE WHEN patient_questions_addressed_flag = TRUE THEN 1 END)
      comment: "Consents where patient questions were documented as addressed for informed consent quality"
    - name: "unique_patients_treatment_consent"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with treatment consents for procedural volume analysis"
$$;