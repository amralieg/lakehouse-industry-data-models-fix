-- Metric views for domain: compliance | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 17:46:18

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`compliance_regulatory_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key metrics for regulatory inspections including inspection outcomes, findings, and response timeliness"
  source: "`pharmaceuticals_ecm`.`compliance`.`regulatory_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of regulatory inspection (e.g., routine, for-cause, pre-approval)"
    - name: "inspecting_authority"
      expr: inspecting_authority
      comment: "Regulatory authority conducting the inspection"
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Final outcome of the inspection"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection"
    - name: "is_announced"
      expr: is_announced
      comment: "Whether the inspection was announced or unannounced"
    - name: "form_483_issued"
      expr: form_483_issued
      comment: "Whether FDA Form 483 was issued"
    - name: "inspection_year"
      expr: YEAR(actual_start_date)
      comment: "Year the inspection started"
    - name: "inspection_quarter"
      expr: CONCAT('Q', QUARTER(actual_start_date))
      comment: "Quarter the inspection started"
    - name: "authority_country_code"
      expr: authority_country_code
      comment: "Country code of the inspecting authority"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of regulatory inspections"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS BIGINT))
      comment: "Total count of critical findings across all inspections"
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS BIGINT))
      comment: "Total count of major findings across all inspections"
    - name: "total_minor_findings"
      expr: SUM(CAST(minor_findings_count AS BIGINT))
      comment: "Total count of minor findings across all inspections"
    - name: "avg_inspection_duration_days"
      expr: AVG(CAST(inspection_duration_days AS DOUBLE))
      comment: "Average duration of inspections in days"
    - name: "inspections_requiring_capa"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Number of inspections requiring corrective and preventive action"
    - name: "inspections_with_form_483"
      expr: COUNT(CASE WHEN form_483_issued = TRUE THEN 1 END)
      comment: "Number of inspections where FDA Form 483 was issued"
    - name: "inspections_requiring_followup"
      expr: COUNT(CASE WHEN follow_up_inspection_required = TRUE THEN 1 END)
      comment: "Number of inspections requiring follow-up inspection"
    - name: "avg_response_time_days"
      expr: AVG(DATEDIFF(response_submitted_date, response_due_date))
      comment: "Average days between response due date and submission (negative means early)"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`compliance_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance incident metrics tracking severity, resolution time, and regulatory impact"
  source: "`pharmaceuticals_ecm`.`compliance`.`incident`"
  dimensions:
    - name: "incident_category"
      expr: incident_category
      comment: "Category of compliance incident"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the incident"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the incident"
    - name: "reportable_to_authority"
      expr: reportable_to_authority
      comment: "Whether incident must be reported to regulatory authority"
    - name: "capa_required"
      expr: capa_required
      comment: "Whether corrective and preventive action is required"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Category of root cause identified"
    - name: "affected_regulation"
      expr: affected_regulation
      comment: "Regulation affected by the incident"
    - name: "incident_year"
      expr: YEAR(occurrence_date)
      comment: "Year the incident occurred"
    - name: "incident_quarter"
      expr: CONCAT('Q', QUARTER(occurrence_date))
      comment: "Quarter the incident occurred"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of compliance incidents"
    - name: "reportable_incidents"
      expr: COUNT(CASE WHEN reportable_to_authority = TRUE THEN 1 END)
      comment: "Number of incidents reportable to regulatory authorities"
    - name: "incidents_requiring_capa"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Number of incidents requiring corrective and preventive action"
    - name: "avg_time_to_closure_days"
      expr: AVG(DATEDIFF(actual_closure_date, discovery_date))
      comment: "Average days from incident discovery to closure"
    - name: "avg_time_to_target_closure_days"
      expr: AVG(DATEDIFF(actual_closure_date, target_closure_date))
      comment: "Average days between target and actual closure (negative means early)"
    - name: "escalated_incidents"
      expr: COUNT(CASE WHEN escalation_date IS NOT NULL THEN 1 END)
      comment: "Number of incidents that were escalated"
    - name: "avg_discovery_to_report_days"
      expr: AVG(DATEDIFF(authority_notification_date, discovery_date))
      comment: "Average days from discovery to authority notification"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`compliance_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and preventive action metrics tracking effectiveness and completion"
  source: "`pharmaceuticals_ecm`.`compliance`.`compliance_capa`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (corrective or preventive)"
    - name: "capa_status"
      expr: capa_status
      comment: "Current status of the CAPA"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the CAPA"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the CAPA"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Category of root cause identified"
    - name: "root_cause_analysis_method"
      expr: root_cause_analysis_method
      comment: "Method used for root cause analysis"
    - name: "effectiveness_check_result"
      expr: effectiveness_check_result
      comment: "Result of effectiveness check"
    - name: "regulatory_response_required_flag"
      expr: regulatory_response_required_flag
      comment: "Whether regulatory response is required"
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether escalation is required"
    - name: "capa_year"
      expr: YEAR(created_timestamp)
      comment: "Year the CAPA was created"
  measures:
    - name: "total_capas"
      expr: COUNT(1)
      comment: "Total number of corrective and preventive actions"
    - name: "capas_requiring_regulatory_response"
      expr: COUNT(CASE WHEN regulatory_response_required_flag = TRUE THEN 1 END)
      comment: "Number of CAPAs requiring regulatory response"
    - name: "capas_requiring_escalation"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END)
      comment: "Number of CAPAs requiring escalation"
    - name: "avg_time_to_completion_days"
      expr: AVG(DATEDIFF(actual_completion_date, created_timestamp))
      comment: "Average days from CAPA creation to completion"
    - name: "avg_completion_vs_target_days"
      expr: AVG(DATEDIFF(actual_completion_date, target_completion_date))
      comment: "Average days between target and actual completion (negative means early)"
    - name: "capas_with_effectiveness_check"
      expr: COUNT(CASE WHEN effectiveness_check_date IS NOT NULL THEN 1 END)
      comment: "Number of CAPAs with completed effectiveness checks"
    - name: "avg_time_to_effectiveness_check_days"
      expr: AVG(DATEDIFF(effectiveness_check_date, actual_completion_date))
      comment: "Average days from CAPA completion to effectiveness check"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`compliance_warning_letter`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warning letter metrics tracking regulatory actions and response effectiveness"
  source: "`pharmaceuticals_ecm`.`compliance`.`warning_letter`"
  dimensions:
    - name: "letter_type"
      expr: letter_type
      comment: "Type of warning letter"
    - name: "letter_status"
      expr: letter_status
      comment: "Current status of the warning letter"
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the warning letter"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the warning letter"
    - name: "regulatory_action_risk"
      expr: regulatory_action_risk
      comment: "Risk of further regulatory action"
    - name: "consent_decree_related_flag"
      expr: consent_decree_related_flag
      comment: "Whether related to a consent decree"
    - name: "import_alert_flag"
      expr: import_alert_flag
      comment: "Whether an import alert was issued"
    - name: "product_impact_flag"
      expr: product_impact_flag
      comment: "Whether products were impacted"
    - name: "reinspection_required_flag"
      expr: reinspection_required_flag
      comment: "Whether reinspection is required"
    - name: "letter_year"
      expr: YEAR(issue_date)
      comment: "Year the warning letter was issued"
  measures:
    - name: "total_warning_letters"
      expr: COUNT(1)
      comment: "Total number of warning letters received"
    - name: "warning_letters_with_import_alert"
      expr: COUNT(CASE WHEN import_alert_flag = TRUE THEN 1 END)
      comment: "Number of warning letters resulting in import alerts"
    - name: "warning_letters_with_product_impact"
      expr: COUNT(CASE WHEN product_impact_flag = TRUE THEN 1 END)
      comment: "Number of warning letters impacting products"
    - name: "warning_letters_requiring_reinspection"
      expr: COUNT(CASE WHEN reinspection_required_flag = TRUE THEN 1 END)
      comment: "Number of warning letters requiring reinspection"
    - name: "avg_response_time_days"
      expr: AVG(DATEDIFF(response_submission_date, response_due_date))
      comment: "Average days between response due date and submission (negative means early)"
    - name: "avg_time_to_closure_days"
      expr: AVG(DATEDIFF(closure_date, issue_date))
      comment: "Average days from warning letter issue to closure"
    - name: "avg_time_to_completion_days"
      expr: AVG(DATEDIFF(actual_completion_date, issue_date))
      comment: "Average days from issue to actual completion of remediation"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`compliance_internal_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Internal control effectiveness metrics for SOX, GxP, and data integrity compliance"
  source: "`pharmaceuticals_ecm`.`compliance`.`internal_control`"
  dimensions:
    - name: "control_type"
      expr: control_type
      comment: "Type of internal control"
    - name: "control_category"
      expr: control_category
      comment: "Category of the control"
    - name: "control_effectiveness_rating"
      expr: control_effectiveness_rating
      comment: "Effectiveness rating of the control"
    - name: "control_status"
      expr: control_status
      comment: "Current status of the control"
    - name: "automation_level"
      expr: automation_level
      comment: "Level of automation for the control"
    - name: "key_control_flag"
      expr: key_control_flag
      comment: "Whether this is a key control"
    - name: "sox_applicable_flag"
      expr: sox_applicable_flag
      comment: "Whether SOX compliance applies"
    - name: "gxp_applicable_flag"
      expr: gxp_applicable_flag
      comment: "Whether GxP compliance applies"
    - name: "data_integrity_control_flag"
      expr: data_integrity_control_flag
      comment: "Whether this is a data integrity control"
    - name: "material_weakness_flag"
      expr: material_weakness_flag
      comment: "Whether a material weakness exists"
    - name: "significant_deficiency_flag"
      expr: significant_deficiency_flag
      comment: "Whether a significant deficiency exists"
  measures:
    - name: "total_controls"
      expr: COUNT(1)
      comment: "Total number of internal controls"
    - name: "key_controls"
      expr: COUNT(CASE WHEN key_control_flag = TRUE THEN 1 END)
      comment: "Number of key controls"
    - name: "sox_controls"
      expr: COUNT(CASE WHEN sox_applicable_flag = TRUE THEN 1 END)
      comment: "Number of SOX-applicable controls"
    - name: "gxp_controls"
      expr: COUNT(CASE WHEN gxp_applicable_flag = TRUE THEN 1 END)
      comment: "Number of GxP-applicable controls"
    - name: "data_integrity_controls"
      expr: COUNT(CASE WHEN data_integrity_control_flag = TRUE THEN 1 END)
      comment: "Number of data integrity controls"
    - name: "controls_with_material_weakness"
      expr: COUNT(CASE WHEN material_weakness_flag = TRUE THEN 1 END)
      comment: "Number of controls with material weaknesses"
    - name: "controls_with_significant_deficiency"
      expr: COUNT(CASE WHEN significant_deficiency_flag = TRUE THEN 1 END)
      comment: "Number of controls with significant deficiencies"
    - name: "total_deficiencies"
      expr: SUM(CAST(deficiency_count AS BIGINT))
      comment: "Total count of deficiencies across all controls"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`compliance_control_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Control assessment metrics tracking testing effectiveness and remediation"
  source: "`pharmaceuticals_ecm`.`compliance`.`control_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of control assessment"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment"
    - name: "control_effectiveness_rating"
      expr: control_effectiveness_rating
      comment: "Effectiveness rating from the assessment"
    - name: "test_result"
      expr: test_result
      comment: "Result of the control test"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned"
    - name: "remediation_required_flag"
      expr: remediation_required_flag
      comment: "Whether remediation is required"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation efforts"
    - name: "sox_scoping_flag"
      expr: sox_scoping_flag
      comment: "Whether in SOX scope"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the assessment"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the assessment"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of control assessments"
    - name: "assessments_requiring_remediation"
      expr: COUNT(CASE WHEN remediation_required_flag = TRUE THEN 1 END)
      comment: "Number of assessments requiring remediation"
    - name: "sox_scoped_assessments"
      expr: COUNT(CASE WHEN sox_scoping_flag = TRUE THEN 1 END)
      comment: "Number of assessments in SOX scope"
    - name: "total_exceptions_identified"
      expr: SUM(CAST(exceptions_identified_count AS BIGINT))
      comment: "Total count of exceptions identified across assessments"
    - name: "avg_time_to_remediation_days"
      expr: AVG(DATEDIFF(remediation_completion_date, assessment_execution_date))
      comment: "Average days from assessment to remediation completion"
    - name: "avg_remediation_vs_due_days"
      expr: AVG(DATEDIFF(remediation_completion_date, remediation_due_date))
      comment: "Average days between remediation due date and completion (negative means early)"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`compliance_attestation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Attestation metrics tracking compliance certifications and policy acknowledgments"
  source: "`pharmaceuticals_ecm`.`compliance`.`attestation`"
  dimensions:
    - name: "attestation_type"
      expr: attestation_type
      comment: "Type of attestation"
    - name: "attestation_status"
      expr: attestation_status
      comment: "Current status of the attestation"
    - name: "gxp_category"
      expr: gxp_category
      comment: "GxP category applicable to the attestation"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the attestation"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the attestation"
    - name: "exceptions_disclosed_flag"
      expr: exceptions_disclosed_flag
      comment: "Whether exceptions were disclosed"
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Whether follow-up is required"
    - name: "training_completion_flag"
      expr: training_completion_flag
      comment: "Whether required training was completed"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the attestation"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the attestation"
  measures:
    - name: "total_attestations"
      expr: COUNT(1)
      comment: "Total number of attestations"
    - name: "attestations_with_exceptions"
      expr: COUNT(CASE WHEN exceptions_disclosed_flag = TRUE THEN 1 END)
      comment: "Number of attestations with disclosed exceptions"
    - name: "attestations_requiring_followup"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Number of attestations requiring follow-up"
    - name: "attestations_with_training_complete"
      expr: COUNT(CASE WHEN training_completion_flag = TRUE THEN 1 END)
      comment: "Number of attestations with completed training"
    - name: "avg_time_to_approval_days"
      expr: AVG(DATEDIFF(approval_timestamp, submission_timestamp))
      comment: "Average days from submission to approval"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`compliance_third_party_due_diligence`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Third-party due diligence metrics tracking vendor risk and screening effectiveness"
  source: "`pharmaceuticals_ecm`.`compliance`.`third_party_due_diligence`"
  dimensions:
    - name: "third_party_type"
      expr: third_party_type
      comment: "Type of third party being assessed"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the due diligence assessment"
    - name: "overall_risk_rating"
      expr: overall_risk_rating
      comment: "Overall risk rating assigned"
    - name: "due_diligence_tier"
      expr: due_diligence_tier
      comment: "Tier of due diligence required"
    - name: "approval_decision"
      expr: approval_decision
      comment: "Final approval decision"
    - name: "debarment_match_found_flag"
      expr: debarment_match_found_flag
      comment: "Whether debarment screening found a match"
    - name: "sanctions_match_found_flag"
      expr: sanctions_match_found_flag
      comment: "Whether sanctions screening found a match"
    - name: "gxp_compliance_verified_flag"
      expr: gxp_compliance_verified_flag
      comment: "Whether GxP compliance was verified"
    - name: "data_integrity_verified_flag"
      expr: data_integrity_verified_flag
      comment: "Whether data integrity was verified"
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of engagement with the third party"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of third-party due diligence assessments"
    - name: "assessments_with_debarment_match"
      expr: COUNT(CASE WHEN debarment_match_found_flag = TRUE THEN 1 END)
      comment: "Number of assessments with debarment matches found"
    - name: "assessments_with_sanctions_match"
      expr: COUNT(CASE WHEN sanctions_match_found_flag = TRUE THEN 1 END)
      comment: "Number of assessments with sanctions matches found"
    - name: "assessments_gxp_verified"
      expr: COUNT(CASE WHEN gxp_compliance_verified_flag = TRUE THEN 1 END)
      comment: "Number of assessments with verified GxP compliance"
    - name: "assessments_data_integrity_verified"
      expr: COUNT(CASE WHEN data_integrity_verified_flag = TRUE THEN 1 END)
      comment: "Number of assessments with verified data integrity"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all assessments"
    - name: "avg_assessment_duration_days"
      expr: AVG(DATEDIFF(assessment_completed_date, assessment_initiated_date))
      comment: "Average days from assessment initiation to completion"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`compliance_audit_trail`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit trail metrics for data integrity and regulatory compliance monitoring"
  source: "`pharmaceuticals_ecm`.`compliance`.`audit_trail`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of audit event"
    - name: "event_category"
      expr: event_category
      comment: "Category of the audit event"
    - name: "entity_type"
      expr: entity_type
      comment: "Type of entity being audited"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the audit trail"
    - name: "gxp_critical"
      expr: gxp_critical
      comment: "Whether the event is GxP critical"
    - name: "electronic_signature_applied"
      expr: electronic_signature_applied
      comment: "Whether electronic signature was applied"
    - name: "exception_flag"
      expr: exception_flag
      comment: "Whether an exception was flagged"
    - name: "investigation_required"
      expr: investigation_required
      comment: "Whether investigation is required"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the audit event"
    - name: "event_year"
      expr: YEAR(event_timestamp)
      comment: "Year the event occurred"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month the event occurred"
  measures:
    - name: "total_audit_events"
      expr: COUNT(1)
      comment: "Total number of audit trail events"
    - name: "gxp_critical_events"
      expr: COUNT(CASE WHEN gxp_critical = TRUE THEN 1 END)
      comment: "Number of GxP critical audit events"
    - name: "events_with_esignature"
      expr: COUNT(CASE WHEN electronic_signature_applied = TRUE THEN 1 END)
      comment: "Number of events with electronic signature applied"
    - name: "exception_events"
      expr: COUNT(CASE WHEN exception_flag = TRUE THEN 1 END)
      comment: "Number of audit events flagged as exceptions"
    - name: "events_requiring_investigation"
      expr: COUNT(CASE WHEN investigation_required = TRUE THEN 1 END)
      comment: "Number of events requiring investigation"
    - name: "unique_users"
      expr: COUNT(DISTINCT user_id)
      comment: "Number of unique users generating audit events"
    - name: "unique_entities"
      expr: COUNT(DISTINCT entity_id)
      comment: "Number of unique entities with audit events"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`compliance_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk register metrics tracking inherent and residual risk across compliance domains"
  source: "`pharmaceuticals_ecm`.`compliance`.`risk_register`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of the risk"
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Subcategory of the risk"
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk"
    - name: "inherent_risk_rating"
      expr: inherent_risk_rating
      comment: "Inherent risk rating before controls"
    - name: "residual_risk_rating"
      expr: residual_risk_rating
      comment: "Residual risk rating after controls"
    - name: "control_effectiveness"
      expr: control_effectiveness
      comment: "Effectiveness of controls in place"
    - name: "risk_treatment_decision"
      expr: risk_treatment_decision
      comment: "Decision on how to treat the risk"
    - name: "treatment_status"
      expr: treatment_status
      comment: "Status of risk treatment"
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether escalation is required"
    - name: "board_reporting_flag"
      expr: board_reporting_flag
      comment: "Whether risk requires board reporting"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework applicable to the risk"
  measures:
    - name: "total_risks"
      expr: COUNT(1)
      comment: "Total number of risks in the register"
    - name: "risks_requiring_escalation"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END)
      comment: "Number of risks requiring escalation"
    - name: "risks_requiring_board_reporting"
      expr: COUNT(CASE WHEN board_reporting_flag = TRUE THEN 1 END)
      comment: "Number of risks requiring board reporting"
    - name: "avg_inherent_risk_score"
      expr: AVG(CAST(inherent_risk_score AS DOUBLE))
      comment: "Average inherent risk score across all risks"
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(residual_risk_score AS DOUBLE))
      comment: "Average residual risk score across all risks"
    - name: "avg_treatment_duration_days"
      expr: AVG(DATEDIFF(treatment_completion_date, identification_date))
      comment: "Average days from risk identification to treatment completion"
$$;