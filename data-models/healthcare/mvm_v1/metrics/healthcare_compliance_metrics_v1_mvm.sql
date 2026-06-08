-- Metric views for domain: compliance | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 18:58:55

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for compliance audits — tracks audit volume, cost exposure, monetary penalties, corrective-action burden, and outcome quality to steer the compliance programme."
  source: "`healthcare_ecm`.`compliance`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g. internal, external, regulatory) — primary segmentation for audit portfolio analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current lifecycle status of the audit (e.g. planned, in-progress, closed) — used to filter active vs. completed audits."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final outcome of the audit (e.g. pass, fail, conditional) — key quality dimension for outcome trending."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification assigned to the audit — enables risk-stratified performance views."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the audit (e.g. HIPAA, CMS, Joint Commission) — essential for regulatory reporting segmentation."
    - name: "auditing_body"
      expr: auditing_body
      comment: "Organisation or body conducting the audit — supports vendor/body performance benchmarking."
    - name: "corrective_action_plan_required"
      expr: corrective_action_plan_required
      comment: "Flag indicating whether a corrective action plan was mandated — used to segment high-burden audits."
    - name: "audit_period_year"
      expr: YEAR(period_start_date)
      comment: "Calendar year of the audit period start — supports year-over-year trend analysis."
    - name: "audit_period_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month bucket of the audit period start — supports monthly trend dashboards."
    - name: "is_unannounced"
      expr: is_unannounced
      comment: "Whether the audit was unannounced — unannounced audits typically surface higher-severity findings."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audit records — baseline volume KPI for audit programme throughput."
    - name: "total_audit_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total direct cost incurred across all audits — drives budget planning and cost-of-compliance analysis."
    - name: "avg_audit_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per audit — benchmarks efficiency and identifies outlier-cost engagements."
    - name: "total_monetary_penalties"
      expr: SUM(CAST(monetary_penalty_amount AS DOUBLE))
      comment: "Total monetary penalties levied across audits — direct financial risk KPI reported to CFO and Board."
    - name: "avg_monetary_penalty"
      expr: AVG(CAST(monetary_penalty_amount AS DOUBLE))
      comment: "Average monetary penalty per audit — indicates severity of regulatory enforcement actions."
    - name: "audits_requiring_cap"
      expr: COUNT(CASE WHEN corrective_action_plan_required = TRUE THEN 1 END)
      comment: "Number of audits that triggered a corrective action plan — measures remediation burden on the compliance team."
    - name: "cap_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_plan_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring a corrective action plan — key quality indicator; rising rate signals systemic compliance gaps."
    - name: "audits_with_penalty"
      expr: COUNT(CASE WHEN monetary_penalty_amount > 0 THEN 1 END)
      comment: "Count of audits that resulted in a monetary penalty — tracks enforcement frequency for executive risk reporting."
    - name: "penalty_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN monetary_penalty_amount > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits resulting in a monetary penalty — headline risk metric for compliance steering committees."
    - name: "unannounced_audit_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_unannounced = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Proportion of audits that were unannounced — higher rates indicate elevated regulatory scrutiny."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and risk KPIs derived from individual audit findings — tracks finding severity, recurrence, patient-safety impact, financial penalty risk, and resolution timeliness to drive corrective-action prioritisation."
  source: "`healthcare_ecm`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Classification of the finding (e.g. documentation, billing, clinical) — primary segmentation for root-cause analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity assigned to the finding — critical for risk-stratified remediation prioritisation."
    - name: "finding_status"
      expr: finding_status
      comment: "Current resolution status of the finding (e.g. open, resolved, disputed) — tracks remediation pipeline."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework under which the finding was raised — supports framework-level compliance gap analysis."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the finding — enables systemic issue identification and prevention investment."
    - name: "scope_of_impact"
      expr: scope_of_impact
      comment: "Breadth of impact of the finding (e.g. department, facility, enterprise) — informs escalation decisions."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether the finding is a recurrence of a prior finding — recurrent findings signal failed corrective actions."
    - name: "patient_safety_impact_flag"
      expr: patient_safety_impact_flag
      comment: "Whether the finding has a patient safety dimension — highest-priority filter for clinical risk management."
    - name: "financial_penalty_risk_flag"
      expr: financial_penalty_risk_flag
      comment: "Whether the finding carries financial penalty risk — used to prioritise legal and compliance resources."
    - name: "identified_year"
      expr: YEAR(identified_date)
      comment: "Year the finding was identified — supports year-over-year finding trend analysis."
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the finding was identified — supports monthly finding volume dashboards."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether a corrective action is required for this finding — used to size remediation workload."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings — baseline volume KPI for compliance quality monitoring."
    - name: "open_findings"
      expr: COUNT(CASE WHEN finding_status = 'Open' THEN 1 END)
      comment: "Number of currently open findings — measures unresolved compliance exposure at any point in time."
    - name: "open_finding_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN finding_status = 'Open' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings still open — rising rate signals deteriorating remediation capacity."
    - name: "recurrent_findings"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of findings that are recurrences — measures effectiveness of prior corrective actions."
    - name: "recurrence_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are recurrences — key quality metric; high recurrence rate indicates systemic failure of corrective actions."
    - name: "patient_safety_findings"
      expr: COUNT(CASE WHEN patient_safety_impact_flag = TRUE THEN 1 END)
      comment: "Number of findings with patient safety impact — highest-priority KPI for clinical governance and board reporting."
    - name: "patient_safety_finding_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_safety_impact_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings with patient safety impact — executive safety quality indicator."
    - name: "financial_penalty_risk_findings"
      expr: COUNT(CASE WHEN financial_penalty_risk_flag = TRUE THEN 1 END)
      comment: "Number of findings carrying financial penalty risk — direct input to financial risk quantification."
    - name: "findings_requiring_cap"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of findings that require a corrective action — sizes the remediation workload pipeline."
    - name: "mandatory_reporting_findings"
      expr: COUNT(CASE WHEN mandatory_reporting_required_flag = TRUE THEN 1 END)
      comment: "Number of findings requiring mandatory regulatory reporting — tracks regulatory notification obligations."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`compliance_corrective_action_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Remediation effectiveness KPIs for corrective action plans — tracks CAP volume, completion timeliness, escalation rates, and patient-safety-linked remediation to measure how effectively the organisation closes compliance gaps."
  source: "`healthcare_ecm`.`compliance`.`corrective_action_plan`"
  dimensions:
    - name: "cap_status"
      expr: cap_status
      comment: "Current status of the corrective action plan (e.g. open, in-progress, closed, overdue) — primary lifecycle dimension."
    - name: "cap_type"
      expr: cap_type
      comment: "Type of corrective action plan — supports categorisation of remediation strategies."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the CAP — enables risk-stratified remediation tracking."
    - name: "responsible_owner_department"
      expr: responsible_owner_department
      comment: "Department accountable for executing the CAP — supports departmental accountability reporting."
    - name: "patient_safety_impact_flag"
      expr: patient_safety_impact_flag
      comment: "Whether the CAP addresses a patient safety issue — highest-priority filter for clinical governance."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether the CAP required escalation — indicates remediation complexity and management attention needed."
    - name: "training_required_flag"
      expr: training_required_flag
      comment: "Whether training is required as part of the CAP — links remediation to workforce development investment."
    - name: "verification_outcome"
      expr: verification_outcome
      comment: "Outcome of the CAP verification review (e.g. effective, ineffective, partial) — measures remediation quality."
    - name: "target_completion_year"
      expr: YEAR(target_completion_date)
      comment: "Year the CAP is targeted for completion — supports annual remediation pipeline planning."
    - name: "target_completion_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Month the CAP is targeted for completion — supports monthly remediation throughput dashboards."
  measures:
    - name: "total_caps"
      expr: COUNT(1)
      comment: "Total number of corrective action plans — baseline volume KPI for remediation programme sizing."
    - name: "open_caps"
      expr: COUNT(CASE WHEN cap_status NOT IN ('Closed', 'Completed') THEN 1 END)
      comment: "Number of CAPs not yet closed — measures outstanding remediation backlog."
    - name: "closed_caps"
      expr: COUNT(CASE WHEN cap_status IN ('Closed', 'Completed') THEN 1 END)
      comment: "Number of CAPs successfully closed — measures remediation throughput."
    - name: "cap_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cap_status IN ('Closed', 'Completed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPs that have been closed — headline remediation effectiveness KPI for compliance steering committees."
    - name: "escalated_caps"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END)
      comment: "Number of CAPs that required escalation — signals high-complexity or high-risk remediation items."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPs escalated — rising rate indicates systemic remediation challenges requiring executive intervention."
    - name: "patient_safety_caps"
      expr: COUNT(CASE WHEN patient_safety_impact_flag = TRUE THEN 1 END)
      comment: "Number of CAPs linked to patient safety issues — highest-priority remediation KPI for clinical governance boards."
    - name: "caps_verified_effective"
      expr: COUNT(CASE WHEN verification_outcome = 'Effective' THEN 1 END)
      comment: "Number of CAPs verified as effective after closure — measures true remediation quality, not just administrative closure."
    - name: "cap_effectiveness_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_outcome = 'Effective' THEN 1 END) / NULLIF(COUNT(CASE WHEN cap_status IN ('Closed', 'Completed') THEN 1 END), 0), 2)
      comment: "Percentage of closed CAPs verified as effective — the gold-standard remediation quality metric; low rate signals superficial fixes."
    - name: "overdue_caps"
      expr: COUNT(CASE WHEN cap_status NOT IN ('Closed', 'Completed') AND target_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of CAPs past their target completion date and still open — measures remediation timeliness failure and regulatory exposure."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`compliance_hipaa_privacy_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HIPAA privacy breach and incident KPIs — tracks incident volume, PHI exposure, OCR reporting obligations, breach determination outcomes, and notification compliance to manage regulatory risk and patient trust."
  source: "`healthcare_ecm`.`compliance`.`hipaa_privacy_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of privacy incident (e.g. unauthorised access, improper disclosure) — primary segmentation for root-cause analysis."
    - name: "incident_category"
      expr: incident_category
      comment: "Category of the incident — supports portfolio-level incident classification."
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (e.g. open, under investigation, closed) — tracks investigation pipeline."
    - name: "breach_determination_outcome"
      expr: breach_determination_outcome
      comment: "Outcome of the breach risk assessment (e.g. breach, not a breach, low probability) — determines regulatory notification obligations."
    - name: "phi_involved_flag"
      expr: phi_involved_flag
      comment: "Whether protected health information was involved — highest-severity filter for HIPAA compliance reporting."
    - name: "ocr_reporting_required_flag"
      expr: ocr_reporting_required_flag
      comment: "Whether OCR reporting is required — directly determines federal regulatory notification obligations."
    - name: "ocr_reporting_status"
      expr: ocr_reporting_status
      comment: "Status of OCR submission (e.g. submitted, pending, overdue) — tracks regulatory filing compliance."
    - name: "reported_by_department"
      expr: reported_by_department
      comment: "Department that reported the incident — supports departmental risk profiling."
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year the incident occurred — supports year-over-year HIPAA incident trend analysis."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month the incident occurred — supports monthly incident volume dashboards."
    - name: "individual_notification_required_flag"
      expr: individual_notification_required_flag
      comment: "Whether individual patient notification is required — tracks patient notification obligations."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of HIPAA privacy incidents — baseline volume KPI for privacy programme monitoring."
    - name: "confirmed_breaches"
      expr: COUNT(CASE WHEN breach_determination_outcome = 'Breach' THEN 1 END)
      comment: "Number of incidents confirmed as reportable breaches — primary regulatory exposure KPI reported to the Board and OCR."
    - name: "breach_confirmation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN breach_determination_outcome = 'Breach' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents confirmed as breaches — rising rate signals deteriorating privacy controls."
    - name: "phi_incidents"
      expr: COUNT(CASE WHEN phi_involved_flag = TRUE THEN 1 END)
      comment: "Number of incidents involving PHI — highest-severity subset; directly drives OCR reporting and patient notification obligations."
    - name: "phi_incident_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN phi_involved_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents involving PHI — key privacy risk indicator for the Chief Privacy Officer."
    - name: "ocr_reportable_incidents"
      expr: COUNT(CASE WHEN ocr_reporting_required_flag = TRUE THEN 1 END)
      comment: "Number of incidents requiring OCR reporting — measures federal regulatory notification burden."
    - name: "ocr_submission_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ocr_reporting_required_flag = TRUE AND ocr_reporting_status = 'Submitted' THEN 1 END) / NULLIF(COUNT(CASE WHEN ocr_reporting_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of OCR-required incidents where submission has been completed — measures regulatory filing compliance; below 100% is a direct regulatory violation."
    - name: "open_incidents"
      expr: COUNT(CASE WHEN incident_status NOT IN ('Closed') THEN 1 END)
      comment: "Number of incidents not yet closed — measures active investigation backlog and unresolved privacy exposure."
    - name: "incidents_with_disciplinary_action"
      expr: COUNT(CASE WHEN disciplinary_action_taken_flag = TRUE THEN 1 END)
      comment: "Number of incidents that resulted in disciplinary action — measures accountability enforcement and deterrence effectiveness."
    - name: "risk_assessment_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_assessment_completed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents for which a risk assessment was completed — HIPAA requires a risk assessment for every incident; below 100% is a compliance gap."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`compliance_exclusion_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OIG/SAM exclusion screening KPIs — tracks screening volume, match rates, risk levels, and resolution effectiveness to ensure the organisation does not employ or contract with excluded individuals or entities, avoiding federal programme exclusion."
  source: "`healthcare_ecm`.`compliance`.`exclusion_screening`"
  dimensions:
    - name: "screened_entity_type"
      expr: screened_entity_type
      comment: "Type of entity screened (e.g. employee, vendor, clinician) — primary segmentation for screening programme coverage analysis."
    - name: "screening_result"
      expr: screening_result
      comment: "Result of the screening (e.g. clear, match found, inconclusive) — primary outcome dimension."
    - name: "exclusion_type"
      expr: exclusion_type
      comment: "Type of exclusion identified (e.g. OIG, SAM, state) — supports authority-level risk analysis."
    - name: "exclusion_authority"
      expr: exclusion_authority
      comment: "Authority that issued the exclusion — identifies which regulatory body's list triggered the match."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the screening record — enables risk-stratified follow-up prioritisation."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Status of resolution for matched records (e.g. resolved, pending, escalated) — tracks remediation of exclusion matches."
    - name: "match_found_flag"
      expr: match_found_flag
      comment: "Whether a potential exclusion match was found — primary binary outcome for screening effectiveness."
    - name: "screening_source"
      expr: screening_source
      comment: "Source database used for screening (e.g. OIG LEIE, SAM.gov) — supports multi-source coverage analysis."
    - name: "screening_year"
      expr: YEAR(screening_date)
      comment: "Year the screening was performed — supports year-over-year screening volume and match-rate trending."
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_date)
      comment: "Month the screening was performed — supports monthly screening throughput dashboards."
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of exclusion screenings performed — baseline volume KPI for screening programme coverage."
    - name: "match_found_count"
      expr: COUNT(CASE WHEN match_found_flag = TRUE THEN 1 END)
      comment: "Number of screenings where a potential exclusion match was found — primary risk detection KPI."
    - name: "match_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN match_found_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings resulting in a match — rising rate signals increased workforce or vendor exclusion risk."
    - name: "unresolved_matches"
      expr: COUNT(CASE WHEN match_found_flag = TRUE AND resolution_status NOT IN ('Resolved', 'Cleared') THEN 1 END)
      comment: "Number of exclusion matches not yet resolved — measures active regulatory exposure; any unresolved match is a potential federal programme violation."
    - name: "match_resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN match_found_flag = TRUE AND resolution_status IN ('Resolved', 'Cleared') THEN 1 END) / NULLIF(COUNT(CASE WHEN match_found_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of exclusion matches that have been resolved — measures remediation effectiveness; below 100% represents ongoing regulatory exposure."
    - name: "notification_sent_count"
      expr: COUNT(CASE WHEN notification_sent_flag = TRUE THEN 1 END)
      comment: "Number of screenings where a notification was sent — tracks compliance with notification obligations following a match."
    - name: "notification_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN notification_sent_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN match_found_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of matches for which a notification was sent — measures adherence to notification protocols; gaps create regulatory liability."
    - name: "distinct_screened_entities"
      expr: COUNT(DISTINCT COALESCE(clinician_id, org_provider_id, vendor_id))
      comment: "Approximate count of distinct entities screened — measures breadth of screening programme coverage across workforce and vendors."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`compliance_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance training completion and effectiveness KPIs — tracks completion rates, pass/fail outcomes, continuing education credits, escalation rates, and waiver usage to ensure workforce regulatory training obligations are met."
  source: "`healthcare_ecm`.`compliance`.`training_completion`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Status of the training completion record (e.g. completed, in-progress, overdue, waived) — primary lifecycle dimension."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail outcome of the training assessment — measures training effectiveness at the individual level."
    - name: "training_method"
      expr: training_method
      comment: "Delivery method of the training (e.g. online, instructor-led, blended) — supports channel effectiveness analysis."
    - name: "credit_type"
      expr: credit_type
      comment: "Type of continuing education credit awarded — supports CE credit portfolio management."
    - name: "waiver_flag"
      expr: waiver_flag
      comment: "Whether the training requirement was waived — high waiver rates may indicate compliance gaps."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the training record was escalated due to non-completion — measures enforcement of training mandates."
    - name: "regulatory_requirement_satisfied"
      expr: regulatory_requirement_satisfied
      comment: "Regulatory requirement satisfied by this training completion — links training to specific compliance obligations."
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year of training completion — supports year-over-year completion rate trending."
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month of training completion — supports monthly completion throughput dashboards."
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year the training was due — supports on-time completion analysis by cohort."
  measures:
    - name: "total_training_assignments"
      expr: COUNT(1)
      comment: "Total number of training assignment records — baseline volume KPI for training programme scale."
    - name: "completed_trainings"
      expr: COUNT(CASE WHEN completion_status = 'Completed' THEN 1 END)
      comment: "Number of training assignments completed — measures training throughput."
    - name: "training_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN completion_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training assignments completed — headline compliance training KPI; regulators expect near-100% for mandatory training."
    - name: "on_time_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN completion_status = 'Completed' AND completion_date <= due_date THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training assignments completed on or before the due date — measures training timeliness compliance; late completions may constitute regulatory violations."
    - name: "pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END) / NULLIF(COUNT(CASE WHEN pass_fail_status IN ('Pass', 'Fail') THEN 1 END), 0), 2)
      comment: "Percentage of assessed training completions that resulted in a pass — measures training effectiveness and workforce competency."
    - name: "avg_score_achieved"
      expr: AVG(CAST(score_achieved AS DOUBLE))
      comment: "Average assessment score achieved across training completions — benchmarks workforce knowledge levels against passing thresholds."
    - name: "total_continuing_education_credits"
      expr: SUM(CAST(continuing_education_credits AS DOUBLE))
      comment: "Total continuing education credits earned — tracks CE credit accumulation for licensure and accreditation compliance."
    - name: "escalated_non_completions"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of training records escalated due to non-completion — measures enforcement activity and identifies at-risk staff."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training assignments escalated — rising rate signals systemic non-compliance with training mandates."
    - name: "waiver_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training assignments waived — high waiver rates may indicate circumvention of mandatory training requirements and should be reviewed by compliance leadership."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory obligation management KPIs — tracks obligation compliance percentages, overdue obligations, escalation rates, and risk ratings to ensure the organisation meets all regulatory and contractual compliance requirements."
  source: "`healthcare_ecm`.`compliance`.`obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of obligation (e.g. regulatory, contractual, policy) — primary segmentation for obligation portfolio analysis."
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the obligation (e.g. active, overdue, completed, waived) — tracks obligation lifecycle."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the obligation — enables risk-stratified compliance monitoring."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the obligation — high-risk obligations require more frequent monitoring and executive visibility."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority that mandates the obligation (e.g. CMS, OCR, Joint Commission) — supports authority-level compliance reporting."
    - name: "assigned_department"
      expr: assigned_department
      comment: "Department responsible for fulfilling the obligation — supports departmental accountability reporting."
    - name: "is_active"
      expr: is_active
      comment: "Whether the obligation is currently active — filters to in-scope obligations for compliance monitoring."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether a corrective action is required for this obligation — identifies obligations with open remediation needs."
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year the obligation is due — supports annual compliance calendar planning."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the obligation is due — supports monthly compliance deadline management."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of compliance obligations — baseline volume KPI for obligation portfolio sizing."
    - name: "active_obligations"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active obligations — measures the live compliance obligation burden."
    - name: "avg_compliance_percentage"
      expr: AVG(CAST(compliance_percentage AS DOUBLE))
      comment: "Average compliance percentage across all obligations — headline compliance attainment KPI for executive dashboards and regulatory reporting."
    - name: "fully_compliant_obligations"
      expr: COUNT(CASE WHEN compliance_percentage = 100 THEN 1 END)
      comment: "Number of obligations at 100% compliance — measures the proportion of obligations fully satisfied."
    - name: "full_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_percentage = 100 THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active obligations at full compliance — strategic KPI for compliance programme maturity assessment."
    - name: "overdue_obligations"
      expr: COUNT(CASE WHEN obligation_status = 'Overdue' OR (due_date < CURRENT_DATE() AND obligation_status NOT IN ('Completed', 'Closed')) THEN 1 END)
      comment: "Number of obligations past their due date and not completed — measures regulatory exposure from missed compliance deadlines."
    - name: "obligations_requiring_cap"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of obligations requiring corrective action — sizes the remediation workload driven by obligation non-compliance."
    - name: "escalated_obligations"
      expr: COUNT(CASE WHEN escalation_required = TRUE THEN 1 END)
      comment: "Number of obligations that have been escalated — measures high-severity compliance issues requiring management intervention."
    - name: "high_risk_obligations"
      expr: COUNT(CASE WHEN risk_rating IN ('High', 'Critical') THEN 1 END)
      comment: "Number of obligations rated high or critical risk — prioritisation KPI for compliance resource allocation."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`compliance_accreditation_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accreditation portfolio KPIs — tracks accreditation status, expiration risk, cost of accreditation, follow-up obligations, and deemed status to manage the organisation's accreditation standing with regulatory and accrediting bodies."
  source: "`healthcare_ecm`.`compliance`.`accreditation_status`"
  dimensions:
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Current accreditation status (e.g. accredited, conditional, denied, expired) — primary outcome dimension for accreditation portfolio management."
    - name: "accrediting_body_name"
      expr: accrediting_body_name
      comment: "Name of the accrediting body (e.g. Joint Commission, DNV, AAAHC) — supports body-level accreditation performance analysis."
    - name: "accreditation_level"
      expr: accreditation_level
      comment: "Level of accreditation awarded — supports tiered accreditation portfolio analysis."
    - name: "program_type"
      expr: program_type
      comment: "Type of accreditation programme — supports programme-level portfolio segmentation."
    - name: "deemed_status_flag"
      expr: deemed_status_flag
      comment: "Whether the accreditation confers CMS deemed status — deemed status eliminates the need for separate CMS surveys, making this a high-value dimension."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Whether an appeal was filed against the accreditation decision — tracks contested accreditation outcomes."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Whether a follow-up survey or action is required — identifies accreditations with outstanding obligations."
    - name: "survey_type"
      expr: survey_type
      comment: "Type of accreditation survey conducted — supports survey-type performance benchmarking."
    - name: "accreditation_award_year"
      expr: YEAR(accreditation_award_date)
      comment: "Year the accreditation was awarded — supports year-over-year accreditation attainment trending."
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the accreditation expires — supports expiration risk management and renewal planning."
  measures:
    - name: "total_accreditations"
      expr: COUNT(1)
      comment: "Total number of accreditation records — baseline volume KPI for accreditation portfolio size."
    - name: "active_accreditations"
      expr: COUNT(CASE WHEN accreditation_status = 'Accredited' AND expiration_date >= CURRENT_DATE() THEN 1 END)
      comment: "Number of currently active and valid accreditations — measures the organisation's live accreditation standing."
    - name: "accreditation_attainment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN accreditation_status = 'Accredited' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accreditation applications or renewals resulting in accredited status — headline accreditation quality KPI."
    - name: "expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of accreditations expiring within the next 90 days — critical operational KPI for renewal pipeline management; lapsed accreditations can trigger CMS decertification."
    - name: "total_accreditation_cost"
      expr: SUM(CAST(accreditation_cost_amount AS DOUBLE))
      comment: "Total cost incurred for accreditation activities — drives accreditation budget planning and cost-of-compliance analysis."
    - name: "avg_accreditation_cost"
      expr: AVG(CAST(accreditation_cost_amount AS DOUBLE))
      comment: "Average cost per accreditation — benchmarks accreditation cost efficiency across programmes and bodies."
    - name: "total_annual_maintenance_fees"
      expr: SUM(CAST(annual_maintenance_fee_amount AS DOUBLE))
      comment: "Total annual maintenance fees across all accreditations — recurring cost KPI for compliance budget forecasting."
    - name: "deemed_status_accreditations"
      expr: COUNT(CASE WHEN deemed_status_flag = TRUE THEN 1 END)
      comment: "Number of accreditations conferring CMS deemed status — deemed status accreditations are the highest-value accreditations as they substitute for CMS surveys."
    - name: "accreditations_with_follow_up"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Number of accreditations with outstanding follow-up requirements — measures post-survey remediation burden."
    - name: "appeal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accreditation decisions that were appealed — rising appeal rate signals dissatisfaction with accrediting body decisions or systemic survey preparation gaps."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`compliance_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance programme portfolio KPIs — tracks programme status, penalty exposure, audit frequency, risk levels, and training obligations to provide executive visibility into the organisation's compliance programme governance."
  source: "`healthcare_ecm`.`compliance`.`program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the compliance programme (e.g. active, inactive, under review) — primary lifecycle dimension."
    - name: "program_type"
      expr: program_type
      comment: "Type of compliance programme (e.g. HIPAA, billing, safety) — supports programme-type portfolio analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the programme — enables risk-stratified programme monitoring."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the programme — supports framework-level compliance portfolio analysis."
    - name: "governing_body"
      expr: governing_body
      comment: "Governing body overseeing the programme — supports authority-level programme accountability."
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Whether the programme is mandatory — mandatory programmes require guaranteed resource allocation."
    - name: "reporting_required_flag"
      expr: reporting_required_flag
      comment: "Whether the programme requires regulatory reporting — identifies programmes with external reporting obligations."
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Accreditation status of the programme — tracks programme-level accreditation standing."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the programme became effective — supports programme vintage analysis."
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total number of compliance programmes — baseline volume KPI for compliance programme portfolio sizing."
    - name: "active_programs"
      expr: COUNT(CASE WHEN program_status = 'Active' THEN 1 END)
      comment: "Number of currently active compliance programmes — measures the live compliance programme footprint."
    - name: "mandatory_programs"
      expr: COUNT(CASE WHEN mandatory_flag = TRUE THEN 1 END)
      comment: "Number of mandatory compliance programmes — mandatory programmes represent non-negotiable compliance obligations."
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_exposure_amount AS DOUBLE))
      comment: "Total potential penalty exposure across all compliance programmes — headline financial risk KPI for CFO and Board risk reporting."
    - name: "avg_penalty_exposure"
      expr: AVG(CAST(penalty_exposure_amount AS DOUBLE))
      comment: "Average penalty exposure per compliance programme — benchmarks risk concentration across the programme portfolio."
    - name: "high_risk_programs"
      expr: COUNT(CASE WHEN risk_level IN ('High', 'Critical') THEN 1 END)
      comment: "Number of programmes rated high or critical risk — prioritisation KPI for compliance investment and executive attention."
    - name: "programs_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of compliance programmes expiring within 90 days — operational KPI for programme renewal pipeline management."
    - name: "programs_requiring_reporting"
      expr: COUNT(CASE WHEN reporting_required_flag = TRUE THEN 1 END)
      comment: "Number of programmes with external regulatory reporting obligations — measures the regulatory reporting burden on the compliance function."
$$;