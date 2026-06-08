-- Metric views for domain: compliance | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-06 23:23:25

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key audit performance and risk metrics for clinical trial compliance oversight, tracking audit outcomes, findings severity, and CAPA requirements."
  source: "`clinical_trials_ecm`.`compliance`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted (e.g., for-cause, routine, directed)"
    - name: "audit_category"
      expr: audit_category
      comment: "Category classification of the audit"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (e.g., planned, in-progress, completed)"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier classification assigned to the audit"
    - name: "outcome"
      expr: outcome
      comment: "Final outcome/result of the audit"
    - name: "auditee_country"
      expr: auditee_country
      comment: "Country where the auditee is located"
    - name: "capa_required"
      expr: capa_required
      comment: "Whether corrective and preventive action is required"
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Whether a follow-up audit is required"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the audit was planned to start"
    - name: "planned_start_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month the audit was planned to start"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits conducted"
    - name: "audits_requiring_capa"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Number of audits that resulted in CAPA requirements, indicating significant compliance gaps"
    - name: "audits_requiring_follow_up"
      expr: COUNT(CASE WHEN follow_up_required = TRUE THEN 1 END)
      comment: "Number of audits requiring follow-up, indicating unresolved findings"
    - name: "capa_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN capa_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring CAPA — key quality indicator for compliance leadership"
    - name: "follow_up_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring follow-up — measures first-pass resolution effectiveness"
    - name: "sponsor_notification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sponsor_notified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits where sponsor was notified — tracks escalation frequency"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding severity, resolution, and escalation metrics to track GCP compliance risk exposure."
  source: "`clinical_trials_ecm`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the audit finding (e.g., documentation, process, data integrity)"
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding (open, closed, pending response)"
    - name: "process_area"
      expr: process_area
      comment: "Process area where the finding was identified"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification for trending analysis"
    - name: "patient_safety_impact"
      expr: patient_safety_impact
      comment: "Assessment of impact on patient safety"
    - name: "data_integrity_impact"
      expr: data_integrity_impact
      comment: "Assessment of impact on data integrity"
    - name: "repeat_finding_flag"
      expr: repeat_finding_flag
      comment: "Whether this is a repeat finding from a prior audit"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the finding was escalated"
    - name: "identified_year"
      expr: YEAR(identified_date)
      comment: "Year the finding was identified"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings"
    - name: "repeat_findings"
      expr: COUNT(CASE WHEN repeat_finding_flag = TRUE THEN 1 END)
      comment: "Number of repeat findings — indicates systemic issues not addressed by prior CAPAs"
    - name: "repeat_finding_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN repeat_finding_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are repeats — critical CAPA effectiveness indicator"
    - name: "escalated_findings"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated findings requiring senior management attention"
    - name: "findings_requiring_capa"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Number of findings requiring corrective/preventive action"
    - name: "open_findings"
      expr: COUNT(CASE WHEN finding_status = 'Open' THEN 1 END)
      comment: "Number of currently open findings requiring resolution"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`compliance_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAPA lifecycle and effectiveness metrics tracking corrective/preventive action closure, timeliness, and recurrence for GCP compliance."
  source: "`clinical_trials_ecm`.`compliance`.`compliance_capa`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (corrective vs preventive)"
    - name: "compliance_capa_status"
      expr: compliance_capa_status
      comment: "Current lifecycle status of the CAPA"
    - name: "priority"
      expr: priority
      comment: "Priority level of the CAPA"
    - name: "source_type"
      expr: source_type
      comment: "Source that triggered the CAPA (audit, inspection, deviation, etc.)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification for trending"
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for CAPA execution"
    - name: "effectiveness_check_result"
      expr: effectiveness_check_result
      comment: "Result of the effectiveness verification check"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this CAPA addresses a recurring issue"
    - name: "initiation_month"
      expr: DATE_TRUNC('month', initiation_date)
      comment: "Month the CAPA was initiated"
  measures:
    - name: "total_capas"
      expr: COUNT(1)
      comment: "Total number of CAPAs in the system"
    - name: "open_capas"
      expr: COUNT(CASE WHEN compliance_capa_status NOT IN ('Closed', 'Completed') THEN 1 END)
      comment: "Number of open CAPAs requiring attention"
    - name: "overdue_capas"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE AND compliance_capa_status NOT IN ('Closed', 'Completed') THEN 1 END)
      comment: "Number of CAPAs past their target completion date — critical for inspection readiness"
    - name: "recurrence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPAs addressing recurring issues — measures systemic quality failure"
    - name: "regulatory_reportable_capas"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Number of CAPAs that are regulatory reportable — high-risk compliance exposure"
    - name: "subject_safety_impacting_capas"
      expr: COUNT(CASE WHEN subject_safety_impact_flag = TRUE THEN 1 END)
      comment: "Number of CAPAs with subject safety impact — highest priority for resolution"
    - name: "effectiveness_check_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN effectiveness_check_result = 'Effective' THEN 1 END) / NULLIF(COUNT(CASE WHEN effectiveness_check_result IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of effectiveness checks that passed — validates CAPA quality"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`compliance_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory inspection outcome metrics tracking findings severity, Form 483 issuance, and warning letters for inspection readiness management."
  source: "`clinical_trials_ecm`.`compliance`.`compliance_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of regulatory inspection"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection"
    - name: "inspecting_agency"
      expr: inspecting_agency
      comment: "Regulatory agency conducting the inspection (FDA, EMA, etc.)"
    - name: "classification"
      expr: classification
      comment: "FDA classification outcome (NAI, VAI, OAI)"
    - name: "country"
      expr: country
      comment: "Country where inspection took place"
    - name: "inspected_entity_type"
      expr: inspected_entity_type
      comment: "Type of entity inspected (site, sponsor, CRO, lab)"
    - name: "inspection_scope"
      expr: inspection_scope
      comment: "Scope of the inspection"
    - name: "repeat_inspection"
      expr: repeat_inspection
      comment: "Whether this is a repeat inspection"
    - name: "actual_start_year"
      expr: YEAR(actual_start_date)
      comment: "Year the inspection started"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of regulatory inspections"
    - name: "form_483_issued_count"
      expr: COUNT(CASE WHEN form_483_issued = TRUE THEN 1 END)
      comment: "Number of inspections resulting in Form 483 — key FDA compliance indicator"
    - name: "form_483_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN form_483_issued = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in Form 483 issuance"
    - name: "warning_letter_count"
      expr: COUNT(CASE WHEN warning_letter_issued = TRUE THEN 1 END)
      comment: "Number of inspections resulting in warning letters — most severe regulatory action"
    - name: "warning_letter_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN warning_letter_issued = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in warning letters — critical risk metric"
    - name: "inspections_requiring_capa"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Number of inspections requiring corrective action"
    - name: "repeat_inspection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN repeat_inspection = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of repeat inspections — indicates unresolved prior findings"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`compliance_protocol_deviation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protocol deviation metrics tracking frequency, severity, root causes, and reporting compliance for GCP adherence and data quality."
  source: "`clinical_trials_ecm`.`compliance`.`protocol_deviation`"
  dimensions:
    - name: "deviation_category"
      expr: deviation_category
      comment: "Category of protocol deviation"
    - name: "deviation_type"
      expr: deviation_type
      comment: "Specific type of deviation"
    - name: "deviation_status"
      expr: deviation_status
      comment: "Current status of the deviation"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification for trending"
    - name: "data_integrity_impact"
      expr: data_integrity_impact
      comment: "Assessment of impact on data integrity"
    - name: "detected_by"
      expr: detected_by
      comment: "Who detected the deviation (monitor, site, sponsor, etc.)"
    - name: "repeat_deviation_flag"
      expr: repeat_deviation_flag
      comment: "Whether this is a repeat deviation"
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Whether regulatory reporting is required"
    - name: "occurrence_month"
      expr: DATE_TRUNC('month', occurrence_date)
      comment: "Month the deviation occurred"
  measures:
    - name: "total_deviations"
      expr: COUNT(1)
      comment: "Total number of protocol deviations"
    - name: "repeat_deviations"
      expr: COUNT(CASE WHEN repeat_deviation_flag = TRUE THEN 1 END)
      comment: "Number of repeat deviations — indicates systemic training or process gaps"
    - name: "repeat_deviation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN repeat_deviation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deviations that are repeats — key site quality indicator"
    - name: "regulatory_reportable_deviations"
      expr: COUNT(CASE WHEN regulatory_reporting_required = TRUE THEN 1 END)
      comment: "Number of deviations requiring regulatory reporting — high compliance risk"
    - name: "irb_reportable_deviations"
      expr: COUNT(CASE WHEN irb_iec_reporting_required = TRUE THEN 1 END)
      comment: "Number of deviations requiring IRB/IEC reporting"
    - name: "per_protocol_exclusions"
      expr: COUNT(CASE WHEN subject_excluded_from_pp_flag = TRUE THEN 1 END)
      comment: "Number of deviations causing per-protocol population exclusion — impacts statistical analysis"
    - name: "csr_reportable_deviations"
      expr: COUNT(CASE WHEN include_in_csr_flag = TRUE THEN 1 END)
      comment: "Number of deviations to be included in Clinical Study Report"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`compliance_quality_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality event metrics tracking error rates, severity distribution, and resolution for operational quality management."
  source: "`clinical_trials_ecm`.`compliance`.`quality_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of quality event"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the quality event"
    - name: "severity"
      expr: severity
      comment: "Severity classification of the event"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification"
    - name: "affected_process"
      expr: affected_process
      comment: "Business process affected by the quality event"
    - name: "identification_source"
      expr: identification_source
      comment: "How the quality event was identified"
    - name: "qc_outcome"
      expr: qc_outcome
      comment: "QC review outcome"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a recurring quality event"
    - name: "identified_month"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month the quality event was identified"
  measures:
    - name: "total_quality_events"
      expr: COUNT(1)
      comment: "Total number of quality events"
    - name: "events_with_subject_safety_impact"
      expr: COUNT(CASE WHEN subject_safety_impact = TRUE THEN 1 END)
      comment: "Number of quality events impacting subject safety — highest priority"
    - name: "events_with_data_integrity_impact"
      expr: COUNT(CASE WHEN data_integrity_impact = TRUE THEN 1 END)
      comment: "Number of quality events impacting data integrity — affects submission readiness"
    - name: "events_requiring_capa"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Number of quality events escalated to CAPA"
    - name: "recurrence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recurring quality events — measures effectiveness of prior corrective actions"
    - name: "avg_error_rate"
      expr: AVG(CAST(error_rate AS DOUBLE))
      comment: "Average error rate across quality events — operational quality benchmark"
    - name: "regulatory_reportable_events"
      expr: COUNT(CASE WHEN regulatory_reportability = 'Yes' THEN 1 END)
      comment: "Number of quality events requiring regulatory reporting"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`compliance_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk assessment metrics tracking inherent vs residual risk scores, risk acceptance decisions, and remediation status for proactive compliance risk management."
  source: "`clinical_trials_ecm`.`compliance`.`risk_assessment`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of compliance risk"
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Subcategory for granular risk analysis"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the risk assessment"
    - name: "inherent_risk_rating"
      expr: inherent_risk_rating
      comment: "Inherent risk rating before controls"
    - name: "residual_risk_rating"
      expr: residual_risk_rating
      comment: "Residual risk rating after controls"
    - name: "risk_acceptance_decision"
      expr: risk_acceptance_decision
      comment: "Decision on risk acceptance (accept, mitigate, transfer, avoid)"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of risk remediation activities"
    - name: "risk_owner_department"
      expr: risk_owner_department
      comment: "Department owning the risk"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the risk assessment was performed"
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total number of risk assessments performed"
    - name: "avg_inherent_risk_score"
      expr: ROUND(AVG(CAST(inherent_risk_score AS DOUBLE)), 2)
      comment: "Average inherent risk score — baseline risk exposure before controls"
    - name: "avg_residual_risk_score"
      expr: ROUND(AVG(CAST(residual_risk_score AS DOUBLE)), 2)
      comment: "Average residual risk score — remaining risk after controls applied"
    - name: "risk_reduction_effectiveness_pct"
      expr: ROUND(100.0 * (SUM(CAST(inherent_risk_score AS DOUBLE)) - SUM(CAST(residual_risk_score AS DOUBLE))) / NULLIF(SUM(CAST(inherent_risk_score AS DOUBLE)), 0), 2)
      comment: "Percentage reduction from inherent to residual risk — measures control effectiveness"
    - name: "assessments_requiring_capa"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Number of risk assessments triggering CAPA requirements"
    - name: "subject_safety_risks"
      expr: COUNT(CASE WHEN subject_safety_impact_flag = TRUE THEN 1 END)
      comment: "Number of risks with subject safety impact — highest priority for mitigation"
    - name: "gcp_impacting_risks"
      expr: COUNT(CASE WHEN gcp_impact_flag = TRUE THEN 1 END)
      comment: "Number of risks impacting GCP compliance — regulatory inspection exposure"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`compliance_sop_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SOP training compliance metrics tracking completion rates, assessment pass rates, and overdue training for inspection readiness."
  source: "`clinical_trials_ecm`.`compliance`.`sop_training_record`"
  dimensions:
    - name: "training_status"
      expr: training_status
      comment: "Current status of the training record"
    - name: "training_type"
      expr: training_type
      comment: "Type of training delivered"
    - name: "training_method"
      expr: training_method
      comment: "Method of training delivery (classroom, e-learning, etc.)"
    - name: "sop_category"
      expr: sop_category
      comment: "Category of the SOP being trained on"
    - name: "department"
      expr: department
      comment: "Department of the trainee"
    - name: "staff_role"
      expr: staff_role
      comment: "Role of the staff member being trained"
    - name: "assessment_passed"
      expr: assessment_passed
      comment: "Whether the training assessment was passed"
    - name: "is_current_version_training"
      expr: is_current_version_training
      comment: "Whether training is on the current SOP version"
    - name: "completion_month"
      expr: DATE_TRUNC('month', completion_date)
      comment: "Month training was completed"
  measures:
    - name: "total_training_records"
      expr: COUNT(1)
      comment: "Total number of SOP training records"
    - name: "completed_trainings"
      expr: COUNT(CASE WHEN training_status = 'Completed' THEN 1 END)
      comment: "Number of completed training records"
    - name: "overdue_trainings"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE AND training_status NOT IN ('Completed', 'Waived') THEN 1 END)
      comment: "Number of overdue training assignments — critical for inspection readiness"
    - name: "training_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training assignments completed — key compliance KPI"
    - name: "assessment_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN assessment_passed = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN assessment_passed IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of training assessments passed — measures training effectiveness"
    - name: "avg_assessment_score"
      expr: ROUND(AVG(CAST(assessment_score AS DOUBLE)), 2)
      comment: "Average assessment score across training records"
    - name: "current_version_training_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_current_version_training = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training on current SOP versions — measures version currency compliance"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`compliance_ethics_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ethics/IRB submission metrics tracking approval rates, decision timelines, and submission volumes for regulatory compliance oversight."
  source: "`clinical_trials_ecm`.`compliance`.`ethics_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of ethics submission (initial, amendment, continuing review, etc.)"
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission"
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "IRB/IEC decision outcome (approved, modifications required, disapproved)"
    - name: "submission_category"
      expr: submission_category
      comment: "Category of the submission"
    - name: "submission_country"
      expr: submission_country
      comment: "Country where submission was made"
    - name: "review_type"
      expr: review_type
      comment: "Type of review (full board, expedited, exempt)"
    - name: "submission_method"
      expr: submission_method
      comment: "Method of submission (electronic, paper, portal)"
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month the submission was made"
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of ethics submissions"
    - name: "approved_submissions"
      expr: COUNT(CASE WHEN decision_outcome = 'Approved' THEN 1 END)
      comment: "Number of submissions approved on first review"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision_outcome = 'Approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN decision_outcome IS NOT NULL THEN 1 END), 0), 2)
      comment: "First-pass approval rate — measures submission quality and completeness"
    - name: "pending_submissions"
      expr: COUNT(CASE WHEN submission_status IN ('Submitted', 'Under Review', 'Pending') THEN 1 END)
      comment: "Number of submissions awaiting decision — pipeline visibility"
    - name: "enrollment_authorized_submissions"
      expr: COUNT(CASE WHEN subject_enrollment_authorized = TRUE THEN 1 END)
      comment: "Number of submissions with enrollment authorization — tracks study activation readiness"
    - name: "overdue_responses"
      expr: COUNT(CASE WHEN response_due_date < CURRENT_DATE AND response_submitted_date IS NULL THEN 1 END)
      comment: "Number of submissions with overdue responses to IRB queries — compliance risk"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`compliance_regulatory_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory commitment tracking metrics for post-inspection obligations, measuring on-time completion and compliance with regulatory authority requirements."
  source: "`clinical_trials_ecm`.`compliance`.`regulatory_commitment`"
  dimensions:
    - name: "commitment_type"
      expr: commitment_type
      comment: "Type of regulatory commitment"
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current status of the commitment"
    - name: "priority"
      expr: priority
      comment: "Priority level of the commitment"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority the commitment is made to"
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for fulfilling the commitment"
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the originating finding"
    - name: "originating_action_type"
      expr: originating_action_type
      comment: "Type of action that originated the commitment"
    - name: "initiation_month"
      expr: DATE_TRUNC('month', initiation_date)
      comment: "Month the commitment was initiated"
  measures:
    - name: "total_commitments"
      expr: COUNT(1)
      comment: "Total number of regulatory commitments"
    - name: "open_commitments"
      expr: COUNT(CASE WHEN commitment_status NOT IN ('Closed', 'Completed') THEN 1 END)
      comment: "Number of open regulatory commitments requiring action"
    - name: "overdue_commitments"
      expr: COUNT(CASE WHEN committed_completion_date < CURRENT_DATE AND commitment_status NOT IN ('Closed', 'Completed') THEN 1 END)
      comment: "Number of overdue regulatory commitments — highest compliance risk, potential enforcement action"
    - name: "on_time_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_completion_date <= committed_completion_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_completion_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of commitments completed on or before deadline — key regulatory relationship metric"
    - name: "subject_safety_impacting_commitments"
      expr: COUNT(CASE WHEN subject_safety_impact_flag = TRUE THEN 1 END)
      comment: "Number of commitments with subject safety implications"
    - name: "recurring_commitments"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of commitments addressing recurring issues — indicates systemic compliance failures"
$$;