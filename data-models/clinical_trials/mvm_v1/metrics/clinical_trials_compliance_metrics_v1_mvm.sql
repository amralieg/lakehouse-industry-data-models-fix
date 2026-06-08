-- Metric views for domain: compliance | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-07 02:29:00

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit execution and outcome metrics for GCP compliance oversight. Tracks audit pipeline health, finding severity distribution, CAPA obligation rates, and regulatory authority exposure — enabling QA leadership to prioritize inspection readiness and resource allocation."
  source: "`clinical_trials_ecm`.`compliance`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., internal, vendor, regulatory) used to segment audit workload and risk exposure."
    - name: "audit_category"
      expr: audit_category
      comment: "Functional category of the audit (e.g., site, lab, sponsor) for portfolio-level compliance analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current lifecycle status of the audit (e.g., planned, in-progress, closed) for pipeline tracking."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier assigned to the audit (e.g., high, medium, low) for prioritization and escalation decisions."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority associated with the audit (e.g., FDA, EMA) for jurisdiction-level compliance reporting."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection linked to the audit, distinguishing routine from for-cause inspections."
    - name: "gcp_standard_version"
      expr: gcp_standard_version
      comment: "GCP standard version applied during the audit, relevant for regulatory alignment tracking."
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of the audit (e.g., satisfactory, unsatisfactory) used to assess site and vendor quality."
    - name: "planned_start_year_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month of planned audit start date for trend analysis of audit scheduling cadence."
    - name: "actual_start_year_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month of actual audit start date for comparing planned vs. executed audit timelines."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits conducted. Baseline volume metric for audit program throughput and capacity planning."
    - name: "capa_required_audit_count"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Number of audits that triggered a CAPA obligation. High rates signal systemic quality gaps requiring executive intervention."
    - name: "capa_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN capa_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring CAPA. A rising rate is a leading indicator of deteriorating site or vendor quality."
    - name: "follow_up_required_audit_count"
      expr: COUNT(CASE WHEN follow_up_required = TRUE THEN 1 END)
      comment: "Number of audits requiring follow-up action. Tracks unresolved compliance obligations in the audit pipeline."
    - name: "sponsor_notified_audit_count"
      expr: COUNT(CASE WHEN sponsor_notified = TRUE THEN 1 END)
      comment: "Number of audits where the sponsor was formally notified. Measures regulatory transparency and sponsor communication compliance."
    - name: "avg_audit_duration_days"
      expr: ROUND(AVG(DATEDIFF(actual_end_date, actual_start_date)), 1)
      comment: "Average number of days between audit start and end. Tracks audit execution efficiency and resource utilization."
    - name: "avg_planned_to_actual_start_lag_days"
      expr: ROUND(AVG(DATEDIFF(actual_start_date, planned_start_date)), 1)
      comment: "Average lag in days between planned and actual audit start. Measures audit scheduling adherence and operational discipline."
    - name: "overdue_capa_audit_count"
      expr: COUNT(CASE WHEN capa_required = TRUE AND capa_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of audits with a CAPA due date that has passed without closure. A critical risk indicator for regulatory non-compliance."
    - name: "high_risk_audit_count"
      expr: COUNT(CASE WHEN risk_tier = 'High' THEN 1 END)
      comment: "Number of audits classified as high risk. Drives prioritization of QA resources and escalation to senior leadership."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding severity, resolution, and recurrence metrics. Enables QA leadership to track finding closure rates, escalation patterns, repeat deficiencies, and regulatory citation exposure across the audit program."
  source: "`clinical_trials_ecm`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the audit finding (e.g., data integrity, GCP, documentation) for thematic quality analysis."
    - name: "finding_status"
      expr: finding_status
      comment: "Current resolution status of the finding (e.g., open, closed, in-progress) for pipeline management."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the finding for systemic issue identification and preventive action targeting."
    - name: "process_area"
      expr: process_area
      comment: "Business process area implicated by the finding, enabling cross-functional quality improvement prioritization."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority associated with the finding for jurisdiction-level compliance risk tracking."
    - name: "auditee_role"
      expr: auditee_role
      comment: "Role of the auditee (e.g., PI, CRA, lab technician) to identify staff segments with highest finding rates."
    - name: "data_integrity_impact"
      expr: data_integrity_impact
      comment: "Assessment of data integrity impact from the finding, critical for regulatory submission risk evaluation."
    - name: "patient_safety_impact"
      expr: patient_safety_impact
      comment: "Assessment of patient safety impact, the highest-priority dimension for executive escalation decisions."
    - name: "identified_year_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the finding was identified, used for trend analysis of finding discovery rates over time."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings. Baseline volume metric for audit quality program performance."
    - name: "open_finding_count"
      expr: COUNT(CASE WHEN finding_status = 'Open' THEN 1 END)
      comment: "Number of currently open audit findings. A high open count signals unresolved compliance risk requiring management attention."
    - name: "repeat_finding_count"
      expr: COUNT(CASE WHEN repeat_finding_flag = TRUE THEN 1 END)
      comment: "Number of findings that are recurrences of prior findings. Repeat findings indicate ineffective corrective actions and systemic quality failures."
    - name: "repeat_finding_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN repeat_finding_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are repeat occurrences. A key quality effectiveness KPI — high rates trigger CAPA program reviews."
    - name: "escalated_finding_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of findings that were escalated. Tracks severity of compliance issues requiring senior management or sponsor involvement."
    - name: "capa_required_finding_count"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Number of findings requiring a CAPA. Measures the volume of compliance obligations generated by the audit program."
    - name: "avg_finding_closure_days"
      expr: ROUND(AVG(DATEDIFF(closure_date, identified_date)), 1)
      comment: "Average days from finding identification to closure. Measures responsiveness of the quality system to audit findings."
    - name: "overdue_response_finding_count"
      expr: COUNT(CASE WHEN response_due_date < CURRENT_DATE() AND finding_status != 'Closed' THEN 1 END)
      comment: "Number of findings where the response due date has passed without closure. A direct regulatory risk indicator."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`compliance_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) effectiveness, timeliness, and risk metrics. Tracks CAPA closure rates, overdue obligations, recurrence, regulatory reportability, and subject safety impact — core KPIs for QA governance and sponsor oversight."
  source: "`clinical_trials_ecm`.`compliance`.`capa`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (corrective vs. preventive) for distinguishing reactive from proactive quality actions."
    - name: "compliance_capa_status"
      expr: compliance_capa_status
      comment: "Current lifecycle status of the CAPA (e.g., open, closed, overdue) for pipeline and governance reporting."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the CAPA (e.g., critical, high, medium, low) for resource allocation decisions."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category driving the CAPA, used to identify systemic quality issues across the program."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for CAPA execution, enabling departmental quality performance benchmarking."
    - name: "source_type"
      expr: source_type
      comment: "Source that triggered the CAPA (e.g., audit, inspection, deviation) for origin-based quality trend analysis."
    - name: "effectiveness_check_result"
      expr: effectiveness_check_result
      comment: "Result of the CAPA effectiveness check (e.g., effective, not effective) — the ultimate measure of CAPA program quality."
    - name: "initiation_year_month"
      expr: DATE_TRUNC('MONTH', initiation_date)
      comment: "Month CAPA was initiated, used for trend analysis of quality event volume over time."
  measures:
    - name: "total_capas"
      expr: COUNT(1)
      comment: "Total number of CAPAs initiated. Baseline volume metric for quality system workload and compliance obligation tracking."
    - name: "open_capa_count"
      expr: COUNT(CASE WHEN compliance_capa_status = 'Open' THEN 1 END)
      comment: "Number of currently open CAPAs. High open counts signal unresolved compliance risk and resource constraints."
    - name: "overdue_capa_count"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE() AND compliance_capa_status != 'Closed' THEN 1 END)
      comment: "Number of CAPAs past their target completion date without closure. A critical regulatory risk KPI monitored by sponsors and regulators."
    - name: "overdue_capa_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN target_completion_date < CURRENT_DATE() AND compliance_capa_status != 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPAs that are overdue. A rising rate is a leading indicator of quality system breakdown requiring executive intervention."
    - name: "recurrent_capa_count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of CAPAs addressing recurring issues. Recurrence signals ineffective prior corrective actions and systemic root cause failures."
    - name: "regulatory_reportable_capa_count"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Number of CAPAs with regulatory reporting obligations. Tracks the volume of compliance events with direct regulatory authority exposure."
    - name: "subject_safety_impacting_capa_count"
      expr: COUNT(CASE WHEN subject_safety_impact_flag = TRUE THEN 1 END)
      comment: "Number of CAPAs with confirmed subject safety impact. The highest-priority metric for sponsor and regulatory escalation decisions."
    - name: "avg_capa_closure_days"
      expr: ROUND(AVG(DATEDIFF(actual_completion_date, initiation_date)), 1)
      comment: "Average days from CAPA initiation to actual completion. Measures quality system responsiveness and operational efficiency."
    - name: "effective_capa_count"
      expr: COUNT(CASE WHEN effectiveness_check_result = 'Effective' THEN 1 END)
      comment: "Number of CAPAs verified as effective. The primary outcome metric for CAPA program quality — low rates trigger program-level reviews."
    - name: "capa_effectiveness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN effectiveness_check_result = 'Effective' THEN 1 END) / NULLIF(COUNT(CASE WHEN effectiveness_check_result IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of evaluated CAPAs verified as effective. A strategic KPI for QA governance — benchmarked against industry standards."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`compliance_protocol_deviation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protocol deviation frequency, severity, regulatory impact, and resolution metrics. Enables clinical operations and QA leadership to monitor protocol compliance, subject safety exposure, and regulatory reporting obligations across studies and sites."
  source: "`clinical_trials_ecm`.`compliance`.`protocol_deviation`"
  dimensions:
    - name: "deviation_category"
      expr: deviation_category
      comment: "Category of the protocol deviation (e.g., eligibility, dosing, visit window) for thematic compliance analysis."
    - name: "deviation_type"
      expr: deviation_type
      comment: "Type classification of the deviation for severity-based prioritization and regulatory reporting decisions."
    - name: "deviation_status"
      expr: deviation_status
      comment: "Current resolution status of the deviation (e.g., open, resolved, closed) for pipeline management."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the deviation for systemic issue identification and preventive action targeting."
    - name: "detected_by"
      expr: detected_by
      comment: "Source or role that detected the deviation (e.g., monitor, site staff, sponsor) for detection effectiveness analysis."
    - name: "data_integrity_impact"
      expr: data_integrity_impact
      comment: "Assessment of data integrity impact, critical for evaluating risk to regulatory submission integrity."
    - name: "audit_readiness_status"
      expr: audit_readiness_status
      comment: "Audit readiness classification of the deviation record for inspection preparedness tracking."
    - name: "occurrence_year_month"
      expr: DATE_TRUNC('MONTH', occurrence_date)
      comment: "Month of deviation occurrence for trend analysis of protocol compliance over the study timeline."
  measures:
    - name: "total_deviations"
      expr: COUNT(1)
      comment: "Total number of protocol deviations recorded. Baseline volume metric for protocol compliance monitoring."
    - name: "open_deviation_count"
      expr: COUNT(CASE WHEN deviation_status = 'Open' THEN 1 END)
      comment: "Number of currently open protocol deviations. High open counts signal unresolved compliance risk at sites."
    - name: "repeat_deviation_count"
      expr: COUNT(CASE WHEN repeat_deviation_flag = TRUE THEN 1 END)
      comment: "Number of repeat protocol deviations. Recurrence indicates ineffective site training or systemic process failures."
    - name: "repeat_deviation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN repeat_deviation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deviations that are repeat occurrences. A key site quality KPI — high rates trigger enhanced monitoring or site escalation."
    - name: "regulatory_reporting_required_count"
      expr: COUNT(CASE WHEN regulatory_reporting_required = TRUE THEN 1 END)
      comment: "Number of deviations requiring regulatory authority reporting. Tracks the volume of compliance events with direct regulatory exposure."
    - name: "irb_iec_reporting_required_count"
      expr: COUNT(CASE WHEN irb_iec_reporting_required = TRUE THEN 1 END)
      comment: "Number of deviations requiring IRB/IEC notification. Measures ethics committee reporting obligations and institutional compliance burden."
    - name: "per_protocol_exclusion_count"
      expr: COUNT(CASE WHEN subject_excluded_from_pp_flag = TRUE THEN 1 END)
      comment: "Number of deviations resulting in per-protocol population exclusion. Directly impacts statistical analysis integrity and regulatory submission quality."
    - name: "csr_inclusion_count"
      expr: COUNT(CASE WHEN include_in_csr_flag = TRUE THEN 1 END)
      comment: "Number of deviations flagged for inclusion in the Clinical Study Report. Measures the regulatory disclosure burden from protocol non-compliance."
    - name: "avg_deviation_resolution_days"
      expr: ROUND(AVG(DATEDIFF(resolution_date, occurrence_date)), 1)
      comment: "Average days from deviation occurrence to resolution. Measures site responsiveness and quality system efficiency."
    - name: "unique_studies_with_deviations"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with at least one protocol deviation. Measures breadth of protocol compliance risk across the portfolio."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`compliance_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory inspection outcomes, finding severity, and response timeliness metrics. Enables QA and regulatory affairs leadership to track inspection readiness, warning letter risk, and CAPA obligations arising from regulatory authority inspections."
  source: "`clinical_trials_ecm`.`compliance`.`compliance_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of regulatory inspection (e.g., routine, for-cause, pre-approval) for risk-stratified inspection analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g., scheduled, in-progress, closed) for pipeline management."
    - name: "inspecting_agency"
      expr: inspecting_agency
      comment: "Regulatory agency conducting the inspection (e.g., FDA, EMA, MHRA) for jurisdiction-level compliance tracking."
    - name: "classification"
      expr: classification
      comment: "Regulatory classification of the inspection outcome (e.g., NAI, VAI, OAI) — the primary outcome metric for regulatory inspections."
    - name: "inspection_mode"
      expr: inspection_mode
      comment: "Mode of inspection (e.g., on-site, remote/hybrid) for operational planning and resource allocation."
    - name: "inspected_entity_type"
      expr: inspected_entity_type
      comment: "Type of entity inspected (e.g., sponsor, site, CRO, lab) for entity-level compliance performance benchmarking."
    - name: "repeat_inspection"
      expr: repeat_inspection
      comment: "Flag indicating whether this is a repeat inspection of the same entity. Repeat inspections signal unresolved prior compliance issues."
    - name: "scheduled_start_year_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Month of scheduled inspection start for inspection calendar planning and trend analysis."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of regulatory inspections. Baseline volume metric for regulatory engagement tracking."
    - name: "warning_letter_issued_count"
      expr: COUNT(CASE WHEN warning_letter_issued = TRUE THEN 1 END)
      comment: "Number of inspections resulting in a warning letter. The most severe regulatory outcome — directly impacts study continuation and sponsor reputation."
    - name: "form_483_issued_count"
      expr: COUNT(CASE WHEN form_483_issued = TRUE THEN 1 END)
      comment: "Number of inspections resulting in an FDA Form 483 (observations). A leading indicator of potential warning letter risk."
    - name: "capa_required_inspection_count"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Number of inspections generating CAPA obligations. Tracks the compliance remediation burden from regulatory inspections."
    - name: "repeat_inspection_count"
      expr: COUNT(CASE WHEN repeat_inspection = TRUE THEN 1 END)
      comment: "Number of repeat inspections. Repeat inspections signal persistent compliance failures and elevated regulatory scrutiny."
    - name: "repeat_inspection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN repeat_inspection = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that are repeat visits. A strategic KPI for regulatory relationship management — high rates trigger executive escalation."
    - name: "avg_inspection_duration_days"
      expr: ROUND(AVG(DATEDIFF(actual_end_date, actual_start_date)), 1)
      comment: "Average duration of regulatory inspections in days. Longer inspections often correlate with more extensive findings."
    - name: "avg_response_turnaround_days"
      expr: ROUND(AVG(DATEDIFF(response_submission_date, report_date)), 1)
      comment: "Average days from inspection report issuance to sponsor response submission. Measures regulatory responsiveness and compliance with response deadlines."
    - name: "overdue_response_count"
      expr: COUNT(CASE WHEN response_due_date < CURRENT_DATE() AND response_submission_date IS NULL THEN 1 END)
      comment: "Number of inspections with overdue regulatory responses. A critical compliance risk indicator requiring immediate management action."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`compliance_ethics_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ethics committee submission pipeline, approval rates, and response timeliness metrics. Enables regulatory affairs and clinical operations leadership to monitor IRB/IEC submission health, enrollment authorization status, and approval cycle times across studies."
  source: "`clinical_trials_ecm`.`compliance`.`ethics_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of ethics submission (e.g., initial, amendment, continuing review) for submission pipeline categorization."
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission (e.g., submitted, approved, pending) for pipeline management and bottleneck identification."
    - name: "submission_category"
      expr: submission_category
      comment: "Category of the submission for thematic analysis of ethics review workload."
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Outcome of the ethics committee decision (e.g., approved, rejected, deferred) — the primary outcome metric for submission quality."
    - name: "review_type"
      expr: review_type
      comment: "Type of ethics review (e.g., full board, expedited) for review pathway analysis and timeline benchmarking."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority associated with the submission for jurisdiction-level compliance tracking."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit (e.g., electronic, paper) for process efficiency analysis."
    - name: "submission_year_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission for trend analysis of ethics submission volume and approval cycle times."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of ethics submissions. Baseline volume metric for regulatory affairs workload tracking."
    - name: "approved_submission_count"
      expr: COUNT(CASE WHEN decision_outcome = 'Approved' THEN 1 END)
      comment: "Number of submissions receiving ethics committee approval. Measures regulatory affairs effectiveness in securing study authorization."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision_outcome = 'Approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN decision_outcome IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of decided submissions that received approval. A strategic KPI for submission quality and regulatory relationship health."
    - name: "enrollment_authorized_count"
      expr: COUNT(CASE WHEN subject_enrollment_authorized = TRUE THEN 1 END)
      comment: "Number of submissions authorizing subject enrollment. Directly tracks the pipeline of sites cleared to enroll patients."
    - name: "waiver_granted_count"
      expr: COUNT(CASE WHEN waiver_granted = TRUE THEN 1 END)
      comment: "Number of submissions where a consent waiver was granted. Tracks use of waiver provisions for regulatory and ethics oversight."
    - name: "avg_submission_to_decision_days"
      expr: ROUND(AVG(DATEDIFF(decision_date, submission_date)), 1)
      comment: "Average days from submission to ethics committee decision. A key cycle time KPI for study startup speed and site activation planning."
    - name: "overdue_continuing_review_count"
      expr: COUNT(CASE WHEN continuing_review_due_date < CURRENT_DATE() AND submission_status != 'Approved' THEN 1 END)
      comment: "Number of submissions with overdue continuing review. Overdue reviews risk study suspension and are a critical compliance alert."
    - name: "overdue_response_submission_count"
      expr: COUNT(CASE WHEN response_due_date < CURRENT_DATE() AND response_submitted_date IS NULL THEN 1 END)
      comment: "Number of submissions with overdue responses to ethics committee queries. Tracks regulatory responsiveness and submission pipeline health."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`compliance_quality_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality event frequency, severity, error rates, and resolution metrics. Enables QA and operations leadership to monitor quality system performance, data integrity exposure, subject safety events, and regulatory reportability across the clinical trial portfolio."
  source: "`clinical_trials_ecm`.`compliance`.`quality_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of quality event (e.g., data entry error, process failure, system issue) for thematic quality analysis."
    - name: "event_status"
      expr: event_status
      comment: "Current resolution status of the quality event for pipeline management and overdue tracking."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the quality event (e.g., critical, major, minor) for risk-stratified quality management."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the quality event for systemic issue identification and preventive action targeting."
    - name: "affected_process"
      expr: affected_process
      comment: "Business process affected by the quality event for cross-functional quality improvement prioritization."
    - name: "affected_data_domain"
      expr: affected_data_domain
      comment: "Data domain impacted by the quality event (e.g., eCRF, lab, randomization) for data quality risk assessment."
    - name: "identification_source"
      expr: identification_source
      comment: "Source that identified the quality event (e.g., QC review, audit, monitoring) for detection effectiveness analysis."
    - name: "regulatory_reportability"
      expr: regulatory_reportability
      comment: "Regulatory reportability classification of the event for compliance obligation tracking."
    - name: "identified_year_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the quality event was identified for trend analysis of quality event rates over time."
  measures:
    - name: "total_quality_events"
      expr: COUNT(1)
      comment: "Total number of quality events recorded. Baseline volume metric for quality system performance monitoring."
    - name: "data_integrity_impacting_event_count"
      expr: COUNT(CASE WHEN data_integrity_impact = TRUE THEN 1 END)
      comment: "Number of quality events with confirmed data integrity impact. Directly affects regulatory submission integrity and is a critical executive KPI."
    - name: "subject_safety_impacting_event_count"
      expr: COUNT(CASE WHEN subject_safety_impact = TRUE THEN 1 END)
      comment: "Number of quality events with confirmed subject safety impact. The highest-priority metric for sponsor and regulatory escalation."
    - name: "irb_iec_reportable_event_count"
      expr: COUNT(CASE WHEN irb_iec_reportable = TRUE THEN 1 END)
      comment: "Number of quality events requiring IRB/IEC reporting. Tracks ethics committee notification obligations from quality failures."
    - name: "recurrent_event_count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of recurring quality events. Recurrence signals ineffective prior corrective actions and systemic process failures."
    - name: "recurrence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quality events that are recurrences. A strategic quality effectiveness KPI — high rates trigger CAPA program reviews."
    - name: "avg_error_rate"
      expr: ROUND(AVG(CAST(error_rate AS DOUBLE)), 4)
      comment: "Average error rate across quality events. Measures the magnitude of quality failures, not just their count — a key data quality KPI."
    - name: "avg_event_resolution_days"
      expr: ROUND(AVG(DATEDIFF(resolution_date, identified_date)), 1)
      comment: "Average days from quality event identification to resolution. Measures quality system responsiveness and operational efficiency."
    - name: "capa_required_event_count"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Number of quality events requiring a CAPA. Tracks the compliance remediation burden generated by quality failures."
    - name: "sponsor_notified_event_count"
      expr: COUNT(CASE WHEN sponsor_notified = TRUE THEN 1 END)
      comment: "Number of quality events where the sponsor was formally notified. Measures transparency and sponsor communication compliance."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`compliance_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk assessment scoring, residual risk distribution, and remediation status metrics. Enables QA and clinical operations leadership to monitor the risk landscape across studies, track risk reduction effectiveness, and prioritize inspection readiness activities."
  source: "`clinical_trials_ecm`.`compliance`.`risk_assessment`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of the risk being assessed (e.g., data integrity, patient safety, regulatory) for portfolio-level risk analysis."
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Subcategory of the risk for granular risk management and targeted mitigation planning."
    - name: "inherent_risk_rating"
      expr: inherent_risk_rating
      comment: "Inherent risk rating before controls (e.g., high, medium, low) for baseline risk exposure analysis."
    - name: "residual_risk_rating"
      expr: residual_risk_rating
      comment: "Residual risk rating after controls (e.g., high, medium, low) — the primary risk outcome metric for governance reporting."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the risk assessment (e.g., active, closed, under review) for assessment pipeline management."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of risk remediation activities for tracking mitigation progress and overdue actions."
    - name: "risk_owner_department"
      expr: risk_owner_department
      comment: "Department owning the risk for accountability assignment and departmental risk performance benchmarking."
    - name: "risk_acceptance_decision"
      expr: risk_acceptance_decision
      comment: "Decision on risk acceptance (e.g., accept, mitigate, transfer) for governance and audit trail purposes."
    - name: "assessment_year_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of risk assessment for trend analysis of risk profile changes over time."
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total number of risk assessments conducted. Baseline metric for risk management program coverage."
    - name: "high_residual_risk_count"
      expr: COUNT(CASE WHEN residual_risk_rating = 'High' THEN 1 END)
      comment: "Number of assessments with high residual risk after controls. The primary risk governance KPI — high counts require executive escalation and resource reallocation."
    - name: "high_residual_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN residual_risk_rating = 'High' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risk assessments with high residual risk. Measures the effectiveness of the risk control framework across the portfolio."
    - name: "avg_inherent_risk_score"
      expr: ROUND(AVG(CAST(inherent_risk_score AS DOUBLE)), 2)
      comment: "Average inherent risk score before controls. Establishes the baseline risk exposure level for the portfolio."
    - name: "avg_residual_risk_score"
      expr: ROUND(AVG(CAST(residual_risk_score AS DOUBLE)), 2)
      comment: "Average residual risk score after controls. The primary outcome metric for risk mitigation effectiveness."
    - name: "risk_reduction_score"
      expr: ROUND(AVG(CAST(inherent_risk_score AS DOUBLE)) - AVG(CAST(residual_risk_score AS DOUBLE)), 2)
      comment: "Average reduction in risk score from inherent to residual. Measures the aggregate effectiveness of risk controls across the portfolio."
    - name: "subject_safety_impacting_risk_count"
      expr: COUNT(CASE WHEN subject_safety_impact_flag = TRUE THEN 1 END)
      comment: "Number of risk assessments with subject safety impact. The highest-priority risk dimension for sponsor and regulatory oversight."
    - name: "gcp_impacting_risk_count"
      expr: COUNT(CASE WHEN gcp_impact_flag = TRUE THEN 1 END)
      comment: "Number of risk assessments with GCP compliance impact. Tracks the volume of risks with direct regulatory compliance implications."
    - name: "overdue_remediation_count"
      expr: COUNT(CASE WHEN remediation_target_date < CURRENT_DATE() AND remediation_status != 'Completed' THEN 1 END)
      comment: "Number of risk assessments with overdue remediation actions. A critical operational KPI — overdue remediations increase regulatory inspection risk."
    - name: "capa_required_risk_count"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Number of risk assessments requiring a CAPA. Tracks the compliance remediation burden generated by the risk management program."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`compliance_sop_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SOP training compliance, completion rates, assessment performance, and overdue training metrics. Enables QA and HR leadership to monitor staff training compliance, identify at-risk roles and departments, and ensure GCP training obligations are met before study participation."
  source: "`clinical_trials_ecm`.`compliance`.`sop_training_record`"
  dimensions:
    - name: "training_status"
      expr: training_status
      comment: "Current status of the training record (e.g., completed, overdue, waived) for compliance pipeline management."
    - name: "training_type"
      expr: training_type
      comment: "Type of training (e.g., initial, refresher, remedial) for training program design and compliance analysis."
    - name: "training_method"
      expr: training_method
      comment: "Delivery method of training (e.g., eLearning, classroom, OJT) for training effectiveness and cost analysis."
    - name: "sop_category"
      expr: sop_category
      comment: "Category of the SOP being trained on for thematic training compliance analysis."
    - name: "staff_role"
      expr: staff_role
      comment: "Role of the staff member being trained for role-based compliance gap identification."
    - name: "department"
      expr: department
      comment: "Department of the staff member for departmental training compliance benchmarking."
    - name: "is_current_version_training"
      expr: is_current_version_training
      comment: "Flag indicating whether training was completed on the current SOP version — critical for regulatory compliance."
    - name: "completion_year_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month of training completion for trend analysis of training throughput and compliance rates over time."
  measures:
    - name: "total_training_records"
      expr: COUNT(1)
      comment: "Total number of SOP training records. Baseline metric for training program volume and staff coverage."
    - name: "completed_training_count"
      expr: COUNT(CASE WHEN training_status = 'Completed' THEN 1 END)
      comment: "Number of completed training records. Measures training program throughput and staff compliance with SOP training obligations."
    - name: "training_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN training_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training records with completed status. A core compliance KPI — low rates trigger regulatory risk and study participation restrictions."
    - name: "overdue_training_count"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE() AND training_status != 'Completed' THEN 1 END)
      comment: "Number of training records past their due date without completion. A critical compliance risk indicator — overdue training can block site activation."
    - name: "overdue_training_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN due_date < CURRENT_DATE() AND training_status != 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training records that are overdue. A strategic workforce compliance KPI monitored by QA and regulatory affairs leadership."
    - name: "assessment_pass_count"
      expr: COUNT(CASE WHEN assessment_passed = TRUE THEN 1 END)
      comment: "Number of training assessments passed. Measures training effectiveness and staff competency achievement."
    - name: "assessment_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN assessment_passed = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN assessment_passed IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of assessed training records where the assessment was passed. Measures training program quality and staff competency levels."
    - name: "avg_assessment_score"
      expr: ROUND(AVG(CAST(assessment_score AS DOUBLE)), 2)
      comment: "Average assessment score across training records. Measures overall staff competency levels and training program effectiveness."
    - name: "waived_training_count"
      expr: COUNT(CASE WHEN waiver_date IS NOT NULL THEN 1 END)
      comment: "Number of training records where a waiver was granted. Tracks use of training waivers for compliance audit and regulatory review purposes."
    - name: "current_version_training_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_current_version_training = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training completed on the current SOP version. Ensures staff are trained on the most current procedures — a key GCP compliance requirement."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`compliance_regulatory_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory commitment fulfillment, timeliness, and effectiveness metrics. Enables regulatory affairs and QA leadership to track commitments made to regulatory authorities, monitor closure rates, and manage overdue obligations that carry direct regulatory risk."
  source: "`clinical_trials_ecm`.`compliance`.`regulatory_commitment`"
  dimensions:
    - name: "commitment_type"
      expr: commitment_type
      comment: "Type of regulatory commitment (e.g., CAPA, process improvement, labeling update) for obligation categorization."
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current status of the commitment (e.g., open, closed, overdue) for pipeline management and escalation."
    - name: "priority"
      expr: priority
      comment: "Priority level of the commitment for resource allocation and escalation decisions."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority to whom the commitment was made (e.g., FDA, EMA) for jurisdiction-level obligation tracking."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for fulfilling the commitment for departmental performance benchmarking."
    - name: "originating_action_type"
      expr: originating_action_type
      comment: "Type of action that originated the commitment (e.g., inspection finding, audit finding) for root cause analysis."
    - name: "authority_closure_status"
      expr: authority_closure_status
      comment: "Regulatory authority's assessment of commitment closure — the definitive outcome metric for regulatory commitment management."
    - name: "effectiveness_check_result"
      expr: effectiveness_check_result
      comment: "Result of the effectiveness check for the commitment, measuring whether the committed action achieved its intended outcome."
    - name: "initiation_year_month"
      expr: DATE_TRUNC('MONTH', initiation_date)
      comment: "Month commitment was initiated for trend analysis of regulatory obligation volume over time."
  measures:
    - name: "total_commitments"
      expr: COUNT(1)
      comment: "Total number of regulatory commitments. Baseline metric for regulatory obligation portfolio size."
    - name: "open_commitment_count"
      expr: COUNT(CASE WHEN commitment_status = 'Open' THEN 1 END)
      comment: "Number of currently open regulatory commitments. High open counts signal unresolved regulatory obligations and escalating risk."
    - name: "overdue_commitment_count"
      expr: COUNT(CASE WHEN committed_completion_date < CURRENT_DATE() AND commitment_status != 'Closed' THEN 1 END)
      comment: "Number of regulatory commitments past their committed completion date. Overdue commitments carry direct regulatory enforcement risk."
    - name: "overdue_commitment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN committed_completion_date < CURRENT_DATE() AND commitment_status != 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of regulatory commitments that are overdue. A critical regulatory affairs KPI — high rates risk enforcement action and loss of regulatory trust."
    - name: "subject_safety_impacting_commitment_count"
      expr: COUNT(CASE WHEN subject_safety_impact_flag = TRUE THEN 1 END)
      comment: "Number of commitments with subject safety impact. The highest-priority commitment category for sponsor and regulatory oversight."
    - name: "recurrent_commitment_count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of commitments addressing recurring issues. Recurrence signals ineffective prior regulatory responses and systemic quality failures."
    - name: "avg_commitment_closure_days"
      expr: ROUND(AVG(DATEDIFF(actual_completion_date, initiation_date)), 1)
      comment: "Average days from commitment initiation to actual completion. Measures regulatory affairs execution speed and operational efficiency."
    - name: "sponsor_notified_commitment_count"
      expr: COUNT(CASE WHEN sponsor_notified_flag = TRUE THEN 1 END)
      comment: "Number of commitments where the sponsor was formally notified. Tracks sponsor transparency and communication compliance obligations."
$$;