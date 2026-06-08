-- Metric views for domain: compliance | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance audit performance metrics tracking audit outcomes, costs, timeliness, and corrective action requirements across the organization"
  source: "`healthcare_ecm_v1`.`compliance`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted (internal, external, regulatory, financial)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (planned, in-progress, completed, closed)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification assigned to the audit scope"
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final outcome determination of the audit (pass, conditional, fail)"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the audit (HIPAA, CMS CoP, Joint Commission, OIG)"
    - name: "auditing_body"
      expr: auditing_body
      comment: "Organization conducting the audit"
    - name: "department_audited"
      expr: department_audited
      comment: "Department subject to the audit"
    - name: "audit_year"
      expr: YEAR(actual_start_date)
      comment: "Year the audit was actually started"
    - name: "corrective_action_plan_required"
      expr: corrective_action_plan_required
      comment: "Whether a corrective action plan was required as a result of the audit"
    - name: "is_unannounced"
      expr: is_unannounced
      comment: "Whether the audit was unannounced (surprise inspection)"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits conducted"
    - name: "total_audit_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost incurred across all audits"
    - name: "avg_audit_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per audit engagement"
    - name: "total_monetary_penalties"
      expr: SUM(CAST(monetary_penalty_amount AS DOUBLE))
      comment: "Total monetary penalties assessed from audit findings"
    - name: "cap_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_plan_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring corrective action plans - indicates systemic compliance gaps"
    - name: "avg_days_to_complete"
      expr: AVG(DATEDIFF(actual_completion_date, actual_start_date))
      comment: "Average number of days from audit start to completion"
    - name: "unannounced_audit_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_unannounced = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits that were unannounced - regulatory readiness indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding severity, resolution, and recurrence metrics for compliance risk management"
  source: "`healthcare_ecm_v1`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Classification of the finding (deficiency, observation, recommendation, non-conformance)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the finding (critical, major, minor, observation)"
    - name: "finding_status"
      expr: finding_status
      comment: "Current resolution status of the finding"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification for trending systemic issues"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework the finding relates to"
    - name: "affected_department"
      expr: affected_department
      comment: "Department where the finding was identified"
    - name: "scope_of_impact"
      expr: scope_of_impact
      comment: "Breadth of impact (single unit, department, facility, enterprise)"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this finding is a recurrence of a previously identified issue"
    - name: "identified_year"
      expr: YEAR(identified_date)
      comment: "Year the finding was identified"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings"
    - name: "critical_finding_count"
      expr: SUM(CASE WHEN severity_level = 'critical' THEN 1 ELSE 0 END)
      comment: "Count of critical-severity findings requiring immediate remediation"
    - name: "recurrence_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN recurrence_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are recurrences - indicates ineffective corrective actions"
    - name: "patient_safety_impact_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN patient_safety_impact_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings with patient safety implications"
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(actual_resolution_date, identified_date))
      comment: "Average days from finding identification to resolution"
    - name: "overdue_finding_count"
      expr: SUM(CASE WHEN finding_status != 'closed' AND target_resolution_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of findings past their target resolution date - compliance risk indicator"
    - name: "corrective_action_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings requiring formal corrective action plans"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`compliance_hipaa_privacy_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HIPAA privacy incident and breach metrics for regulatory compliance monitoring and OCR reporting readiness"
  source: "`healthcare_ecm_v1`.`compliance`.`hipaa_privacy_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of privacy incident (unauthorized access, improper disclosure, lost device, etc.)"
    - name: "incident_category"
      expr: incident_category
      comment: "Category classification of the incident"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident investigation and resolution"
    - name: "breach_determination_outcome"
      expr: breach_determination_outcome
      comment: "Whether the incident was determined to be a reportable breach"
    - name: "phi_type"
      expr: phi_type
      comment: "Type of PHI involved in the incident"
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause of the incident for trending"
    - name: "ocr_reporting_status"
      expr: ocr_reporting_status
      comment: "Status of OCR (Office for Civil Rights) reporting"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year the incident occurred"
    - name: "location_of_incident"
      expr: location_of_incident
      comment: "Physical or system location where the incident occurred"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of HIPAA privacy incidents reported"
    - name: "confirmed_breach_count"
      expr: SUM(CASE WHEN breach_determination_outcome = 'breach' THEN 1 ELSE 0 END)
      comment: "Count of incidents confirmed as reportable breaches - triggers OCR notification requirements"
    - name: "breach_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN breach_determination_outcome = 'breach' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents determined to be reportable breaches"
    - name: "avg_days_discovery_to_determination"
      expr: AVG(DATEDIFF(breach_determination_date, discovery_date))
      comment: "Average days from discovery to breach determination - must be within 60 days per HIPAA"
    - name: "ocr_reportable_count"
      expr: SUM(CASE WHEN ocr_reporting_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents requiring OCR reporting (500+ individuals affected)"
    - name: "phi_involved_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN phi_involved_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents involving protected health information"
    - name: "policy_violation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN policy_violation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents resulting from policy violations - indicates training gaps"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`compliance_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance training completion, timeliness, and effectiveness metrics for workforce readiness"
  source: "`healthcare_ecm_v1`.`compliance`.`training_completion`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Status of the training completion (completed, in-progress, overdue, waived)"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Whether the employee passed or failed the training assessment"
    - name: "training_method"
      expr: training_method
      comment: "Method of training delivery (online, classroom, simulation, on-the-job)"
    - name: "employee_department"
      expr: employee_department
      comment: "Department of the employee completing training"
    - name: "employee_role"
      expr: employee_role
      comment: "Role of the employee for role-based training analysis"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year of training completion"
    - name: "waiver_flag"
      expr: waiver_flag
      comment: "Whether a waiver was granted for this training requirement"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether non-completion was escalated to management"
  measures:
    - name: "total_completions"
      expr: COUNT(1)
      comment: "Total number of training completion records"
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_status = 'pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training attempts resulting in a passing score"
    - name: "avg_score_achieved"
      expr: AVG(CAST(score_achieved AS DOUBLE))
      comment: "Average assessment score achieved across all completions"
    - name: "overdue_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN completion_date > due_date THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of completions that occurred after the due date - indicates compliance risk"
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN waiver_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training requirements waived - high rates indicate process issues"
    - name: "total_ce_credits"
      expr: SUM(CAST(continuing_education_credits AS DOUBLE))
      comment: "Total continuing education credits earned across all completions"
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training records escalated for non-compliance"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`compliance_hipaa_security_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HIPAA security risk assessment metrics for ePHI system vulnerability management and risk posture monitoring"
  source: "`healthcare_ecm_v1`.`compliance`.`hipaa_security_risk`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of security risk (technical, administrative, physical)"
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Subcategory for detailed risk classification"
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (identified, mitigating, accepted, closed)"
    - name: "inherent_risk_level"
      expr: inherent_risk_level
      comment: "Inherent risk level before controls (critical, high, medium, low)"
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual risk level after controls applied"
    - name: "risk_treatment_decision"
      expr: risk_treatment_decision
      comment: "Treatment decision (mitigate, accept, transfer, avoid)"
    - name: "control_effectiveness"
      expr: control_effectiveness
      comment: "Effectiveness rating of existing controls"
    - name: "risk_owner_department"
      expr: risk_owner_department
      comment: "Department responsible for managing the risk"
    - name: "identified_year"
      expr: YEAR(identified_date)
      comment: "Year the risk was identified"
  measures:
    - name: "total_risks"
      expr: COUNT(1)
      comment: "Total number of identified HIPAA security risks"
    - name: "critical_high_risk_count"
      expr: SUM(CASE WHEN inherent_risk_level IN ('critical', 'high') THEN 1 ELSE 0 END)
      comment: "Count of critical and high inherent risks requiring priority mitigation"
    - name: "open_risk_count"
      expr: SUM(CASE WHEN risk_status NOT IN ('closed', 'accepted') THEN 1 ELSE 0 END)
      comment: "Count of risks still requiring active management"
    - name: "risk_acceptance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN risk_treatment_decision = 'accept' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risks accepted without mitigation - governance oversight indicator"
    - name: "avg_days_to_mitigate"
      expr: AVG(DATEDIFF(mitigation_actual_completion_date, identified_date))
      comment: "Average days from risk identification to mitigation completion"
    - name: "overdue_mitigation_count"
      expr: SUM(CASE WHEN risk_status NOT IN ('closed', 'accepted') AND mitigation_target_completion_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of risks past their mitigation target date - regulatory exposure indicator"
    - name: "residual_risk_reduction_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN residual_risk_level IN ('low', 'minimal') AND inherent_risk_level IN ('critical', 'high', 'medium') THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN inherent_risk_level IN ('critical', 'high', 'medium') THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of medium+ inherent risks reduced to low/minimal residual - control effectiveness indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`compliance_corrective_action_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action plan execution metrics tracking timeliness, closure rates, and regulatory compliance"
  source: "`healthcare_ecm_v1`.`compliance`.`corrective_action_plan`"
  dimensions:
    - name: "cap_status"
      expr: cap_status
      comment: "Current status of the corrective action plan (open, in-progress, completed, overdue)"
    - name: "cap_type"
      expr: cap_type
      comment: "Type of corrective action plan (regulatory, internal, accreditation)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the CAP"
    - name: "patient_safety_impact_flag"
      expr: patient_safety_impact_flag
      comment: "Whether the CAP addresses a patient safety concern"
    - name: "training_required_flag"
      expr: training_required_flag
      comment: "Whether training is required as part of the corrective action"
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether the CAP required escalation to senior leadership"
    - name: "responsible_owner_department"
      expr: responsible_owner_department
      comment: "Department responsible for executing the CAP"
  measures:
    - name: "total_caps"
      expr: COUNT(1)
      comment: "Total number of corrective action plans"
    - name: "open_cap_count"
      expr: SUM(CASE WHEN cap_status NOT IN ('completed', 'closed') THEN 1 ELSE 0 END)
      comment: "Count of CAPs still open - compliance backlog indicator"
    - name: "overdue_cap_count"
      expr: SUM(CASE WHEN cap_status NOT IN ('completed', 'closed') AND target_completion_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of CAPs past their target completion date - regulatory risk indicator"
    - name: "on_time_closure_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_completion_date <= target_completion_date THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN actual_completion_date IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of completed CAPs closed on or before target date"
    - name: "avg_days_to_close"
      expr: AVG(DATEDIFF(actual_completion_date, target_completion_date))
      comment: "Average days variance from target completion (negative = early, positive = late)"
    - name: "patient_safety_cap_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN patient_safety_impact_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPs with patient safety implications - quality priority indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`compliance_exclusion_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OIG/GSA exclusion screening metrics for workforce and vendor compliance monitoring"
  source: "`healthcare_ecm_v1`.`compliance`.`exclusion_screening`"
  dimensions:
    - name: "screening_result"
      expr: screening_result
      comment: "Result of the exclusion screening (clear, match found, pending review)"
    - name: "screened_entity_type"
      expr: screened_entity_type
      comment: "Type of entity screened (employee, provider, vendor, contractor)"
    - name: "screening_source"
      expr: screening_source
      comment: "Database source checked (OIG LEIE, GSA SAM, state Medicaid)"
    - name: "match_found_flag"
      expr: match_found_flag
      comment: "Whether a potential exclusion match was identified"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of identified matches"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the screening result"
    - name: "screening_year"
      expr: YEAR(screening_date)
      comment: "Year the screening was performed"
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of exclusion screenings performed"
    - name: "match_found_count"
      expr: SUM(CASE WHEN match_found_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of screenings with potential exclusion matches identified"
    - name: "match_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN match_found_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings resulting in potential matches - compliance exposure indicator"
    - name: "unresolved_match_count"
      expr: SUM(CASE WHEN match_found_flag = TRUE AND resolution_status NOT IN ('resolved', 'cleared') THEN 1 ELSE 0 END)
      comment: "Count of unresolved exclusion matches requiring immediate action"
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(resolution_date, screening_date))
      comment: "Average days from screening to match resolution"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`compliance_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance investigation metrics tracking case volume, outcomes, financial impact, and timeliness"
  source: "`healthcare_ecm_v1`.`compliance`.`investigation`"
  dimensions:
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation (fraud, waste, abuse, privacy, billing, clinical)"
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the investigation"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the investigation"
    - name: "trigger_source"
      expr: trigger_source
      comment: "Source that triggered the investigation (hotline, audit, monitoring, external)"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the investigation"
    - name: "violation_confirmed_flag"
      expr: violation_confirmed_flag
      comment: "Whether a violation was confirmed"
    - name: "self_disclosure_required_flag"
      expr: self_disclosure_required_flag
      comment: "Whether self-disclosure to OIG/CMS is required"
  measures:
    - name: "total_investigations"
      expr: COUNT(1)
      comment: "Total number of compliance investigations"
    - name: "confirmed_violation_count"
      expr: SUM(CASE WHEN violation_confirmed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of investigations with confirmed violations"
    - name: "violation_confirmation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN violation_confirmed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations resulting in confirmed violations"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact identified across all investigations"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per investigation"
    - name: "self_disclosure_required_count"
      expr: SUM(CASE WHEN self_disclosure_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of investigations requiring self-disclosure to regulators - highest risk category"
    - name: "avg_days_to_close"
      expr: AVG(DATEDIFF(close_date, start_date))
      comment: "Average days from investigation start to closure"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`compliance_phi_access_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PHI access monitoring metrics for detecting unauthorized access patterns and ensuring HIPAA minimum necessary compliance"
  source: "`healthcare_ecm_v1`.`compliance`.`phi_access_log`"
  dimensions:
    - name: "access_type"
      expr: access_type
      comment: "Type of PHI access (view, print, export, modify, delete)"
    - name: "access_reason_code"
      expr: access_reason_code
      comment: "Coded reason for accessing PHI (treatment, payment, operations, research)"
    - name: "data_classification"
      expr: data_classification
      comment: "Classification level of data accessed"
    - name: "user_role"
      expr: user_role
      comment: "Role of the user accessing PHI"
    - name: "user_department"
      expr: user_department
      comment: "Department of the user accessing PHI"
    - name: "emergency_access_flag"
      expr: emergency_access_flag
      comment: "Whether emergency/break-the-glass access was used"
    - name: "flagged_for_review"
      expr: flagged_for_review
      comment: "Whether the access was flagged for compliance review"
    - name: "review_status"
      expr: review_status
      comment: "Status of the compliance review if flagged"
    - name: "access_month"
      expr: DATE_TRUNC('month', access_timestamp)
      comment: "Month of PHI access for trend analysis"
  measures:
    - name: "total_access_events"
      expr: COUNT(1)
      comment: "Total number of PHI access events logged"
    - name: "flagged_access_count"
      expr: SUM(CASE WHEN flagged_for_review = TRUE THEN 1 ELSE 0 END)
      comment: "Count of access events flagged for compliance review"
    - name: "flagged_access_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN flagged_for_review = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of access events flagged - anomaly detection indicator"
    - name: "emergency_access_count"
      expr: SUM(CASE WHEN emergency_access_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of emergency/break-the-glass access events requiring post-hoc review"
    - name: "emergency_access_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN emergency_access_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of access events using emergency override - high rates indicate potential abuse"
    - name: "distinct_patients_accessed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients whose PHI was accessed"
    - name: "corrective_action_required_count"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of access events requiring corrective action - confirmed violations"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`compliance_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance program health and effectiveness metrics for enterprise governance oversight"
  source: "`healthcare_ecm_v1`.`compliance`.`compliance_program`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Type of compliance program (corporate, clinical, billing, privacy, research)"
    - name: "program_status"
      expr: program_status
      comment: "Current operational status of the program"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the program scope"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Primary regulatory framework governing the program"
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Current accreditation status of the program"
    - name: "last_audit_result"
      expr: last_audit_result
      comment: "Result of the most recent audit of this program"
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Whether the program is mandatory for the organization"
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total number of compliance programs"
    - name: "active_program_count"
      expr: SUM(CASE WHEN program_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active compliance programs"
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_exposure_amount AS DOUBLE))
      comment: "Total potential penalty exposure across all programs - enterprise risk quantification"
    - name: "avg_penalty_exposure"
      expr: AVG(CAST(penalty_exposure_amount AS DOUBLE))
      comment: "Average penalty exposure per program"
    - name: "programs_requiring_audit_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reporting_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of programs with mandatory reporting requirements"
    - name: "overdue_audit_count"
      expr: SUM(CASE WHEN next_audit_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of programs past their next scheduled audit date"
$$;