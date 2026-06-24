-- Metric views for domain: compliance | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for compliance audits: penalty exposure, audit costs, findings volume, and corrective action plan tracking to steer compliance risk management."
  source: "`vibe_healthcare_v1`.`compliance`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (internal, external, regulatory) for risk segmentation."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit lifecycle."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the audit (e.g., HIPAA, CMS)."
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level of the audit for prioritization."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final outcome of the audit (pass, fail, conditional)."
    - name: "auditing_body"
      expr: auditing_body
      comment: "Body conducting the audit for external vs internal analysis."
    - name: "audit_scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Month the audit was scheduled, for trend analysis."
  measures:
    - name: "audit_count"
      expr: COUNT(1)
      comment: "Total number of audits, baseline volume for compliance workload."
    - name: "total_monetary_penalty"
      expr: SUM(CAST(monetary_penalty_amount AS DOUBLE))
      comment: "Total monetary penalties assessed — direct financial risk exposure for leadership."
    - name: "avg_monetary_penalty"
      expr: AVG(CAST(monetary_penalty_amount AS DOUBLE))
      comment: "Average penalty per audit, indicating severity trend."
    - name: "total_audit_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost of conducting audits — compliance program spend."
    - name: "cap_required_count"
      expr: SUM(CASE WHEN corrective_action_plan_required = true THEN 1 ELSE 0 END)
      comment: "Number of audits requiring corrective action plans — workload and risk indicator."
    - name: "cap_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_plan_required = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring corrective action — process maturity signal."
    - name: "unannounced_audit_count"
      expr: SUM(CASE WHEN is_unannounced = true THEN 1 ELSE 0 END)
      comment: "Number of unannounced audits, indicating regulatory scrutiny intensity."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on audit findings: severity, resolution timeliness, recurrence, and patient-safety/financial-penalty risk to drive remediation prioritization."
  source: "`vibe_healthcare_v1`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type/category of finding for trend segmentation."
    - name: "finding_status"
      expr: finding_status
      comment: "Resolution status of the finding."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification for prioritization."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause grouping to target systemic fixes."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework the finding relates to."
    - name: "affected_department"
      expr: affected_department
      comment: "Department impacted, for accountability analysis."
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the finding was identified, for trending."
  measures:
    - name: "finding_count"
      expr: COUNT(1)
      comment: "Total findings — overall compliance exposure volume."
    - name: "patient_safety_impact_count"
      expr: SUM(CASE WHEN patient_safety_impact_flag = true THEN 1 ELSE 0 END)
      comment: "Findings with patient-safety impact — critical risk indicator for leadership."
    - name: "financial_penalty_risk_count"
      expr: SUM(CASE WHEN financial_penalty_risk_flag = true THEN 1 ELSE 0 END)
      comment: "Findings posing financial penalty risk — quantifies regulatory financial exposure."
    - name: "recurrence_count"
      expr: SUM(CASE WHEN recurrence_flag = true THEN 1 ELSE 0 END)
      comment: "Recurring findings — signals ineffective prior remediation."
    - name: "recurrence_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN recurrence_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that recurred — remediation effectiveness KPI."
    - name: "corrective_action_required_count"
      expr: SUM(CASE WHEN corrective_action_required_flag = true THEN 1 ELSE 0 END)
      comment: "Findings requiring corrective action — remediation workload."
    - name: "mandatory_reporting_count"
      expr: SUM(CASE WHEN mandatory_reporting_required_flag = true THEN 1 ELSE 0 END)
      comment: "Findings triggering mandatory external reporting — regulatory disclosure exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_hipaa_privacy_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on HIPAA privacy incidents: breach determinations, affected individuals, OCR reporting, and notification obligations — core HIPAA risk steering metrics."
  source: "`vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of privacy incident for categorization."
    - name: "incident_status"
      expr: incident_status
      comment: "Lifecycle status of the incident."
    - name: "incident_category"
      expr: incident_category
      comment: "Category grouping of the incident."
    - name: "breach_determination_outcome"
      expr: breach_determination_outcome
      comment: "Outcome of breach determination analysis."
    - name: "phi_type"
      expr: phi_type
      comment: "Type of PHI involved for sensitivity analysis."
    - name: "ocr_reporting_status"
      expr: ocr_reporting_status
      comment: "Status of OCR reporting obligation."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of incident occurrence for trending."
  measures:
    - name: "incident_count"
      expr: COUNT(1)
      comment: "Total privacy incidents — baseline HIPAA exposure volume."
    - name: "breach_count"
      expr: SUM(CASE WHEN phi_involved_flag = true THEN 1 ELSE 0 END)
      comment: "Incidents involving PHI — direct breach risk count."
    - name: "ocr_reportable_count"
      expr: SUM(CASE WHEN ocr_reporting_required_flag = true THEN 1 ELSE 0 END)
      comment: "Incidents requiring OCR reporting — regulatory disclosure exposure."
    - name: "ocr_reportable_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ocr_reporting_required_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents requiring OCR reporting — severity escalation KPI."
    - name: "individual_notification_required_count"
      expr: SUM(CASE WHEN individual_notification_required_flag = true THEN 1 ELSE 0 END)
      comment: "Incidents requiring individual notification — breach notification workload."
    - name: "disciplinary_action_count"
      expr: SUM(CASE WHEN disciplinary_action_taken_flag = true THEN 1 ELSE 0 END)
      comment: "Incidents resulting in disciplinary action — accountability indicator."
    - name: "policy_violation_count"
      expr: SUM(CASE WHEN policy_violation_flag = true THEN 1 ELSE 0 END)
      comment: "Incidents involving policy violation — internal control failure signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_hipaa_security_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on HIPAA security risk register: inherent vs residual risk, mitigation status, and risk acceptance to steer ePHI security investment."
  source: "`vibe_healthcare_v1`.`compliance`.`hipaa_security_risk`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of security risk for portfolio analysis."
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk in the register."
    - name: "inherent_risk_level"
      expr: inherent_risk_level
      comment: "Inherent (pre-control) risk level."
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual (post-control) risk level for prioritization."
    - name: "risk_treatment_decision"
      expr: risk_treatment_decision
      comment: "Treatment decision (mitigate, accept, transfer)."
    - name: "risk_owner_department"
      expr: risk_owner_department
      comment: "Department owning the risk for accountability."
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the risk was identified for trend analysis."
  measures:
    - name: "risk_count"
      expr: COUNT(1)
      comment: "Total security risks in register — baseline risk inventory."
    - name: "open_risk_count"
      expr: SUM(CASE WHEN risk_status = 'Open' THEN 1 ELSE 0 END)
      comment: "Open security risks — unmitigated exposure requiring attention."
    - name: "accepted_risk_count"
      expr: SUM(CASE WHEN risk_acceptance_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Risks formally accepted — leadership risk tolerance indicator."
    - name: "high_residual_risk_count"
      expr: SUM(CASE WHEN residual_risk_level IN ('High','Critical') THEN 1 ELSE 0 END)
      comment: "Risks with high residual risk after controls — top remediation priority."
    - name: "high_residual_risk_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN residual_risk_level IN ('High','Critical') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risks still high after mitigation — control effectiveness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_corrective_action_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on corrective action plans: completion timeliness, escalation, and patient-safety linkage to track remediation execution."
  source: "`vibe_healthcare_v1`.`compliance`.`corrective_action_plan`"
  dimensions:
    - name: "cap_type"
      expr: cap_type
      comment: "Type of corrective action plan."
    - name: "cap_status"
      expr: cap_status
      comment: "Status of the corrective action plan."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for triage."
    - name: "responsible_owner_department"
      expr: responsible_owner_department
      comment: "Department responsible for execution."
    - name: "target_completion_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Target completion month for SLA tracking."
  measures:
    - name: "cap_count"
      expr: COUNT(1)
      comment: "Total corrective action plans — remediation pipeline volume."
    - name: "escalation_required_count"
      expr: SUM(CASE WHEN escalation_required_flag = true THEN 1 ELSE 0 END)
      comment: "CAPs needing escalation — at-risk remediation indicator."
    - name: "patient_safety_cap_count"
      expr: SUM(CASE WHEN patient_safety_impact_flag = true THEN 1 ELSE 0 END)
      comment: "CAPs tied to patient safety — highest priority remediation."
    - name: "external_consultant_count"
      expr: SUM(CASE WHEN external_consultant_engaged_flag = true THEN 1 ELSE 0 END)
      comment: "CAPs requiring external consultants — cost/complexity signal."
    - name: "completed_cap_count"
      expr: SUM(CASE WHEN actual_completion_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Completed CAPs — remediation throughput."
    - name: "completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_completion_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPs completed — remediation execution KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on mandatory compliance training completion: pass rates, CE credits, waivers, and escalations to track workforce compliance readiness."
  source: "`vibe_healthcare_v1`.`compliance`.`training_completion`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Status of training completion record."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome for proficiency tracking."
    - name: "employee_department"
      expr: employee_department
      comment: "Department of the employee for compliance coverage analysis."
    - name: "training_method"
      expr: training_method
      comment: "Delivery method of the training."
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month of completion for trending."
  measures:
    - name: "completion_record_count"
      expr: COUNT(1)
      comment: "Total training assignment records — workforce training volume."
    - name: "completed_count"
      expr: SUM(CASE WHEN completion_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Number completed — training throughput."
    - name: "completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN completion_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assigned trainings completed — workforce compliance readiness KPI."
    - name: "passed_count"
      expr: SUM(CASE WHEN pass_fail_status = 'Pass' THEN 1 ELSE 0 END)
      comment: "Number passing assessment — proficiency throughput."
    - name: "avg_score_achieved"
      expr: AVG(CAST(score_achieved AS DOUBLE))
      comment: "Average assessment score — training effectiveness measure."
    - name: "total_ce_credits"
      expr: SUM(CAST(continuing_education_credits AS DOUBLE))
      comment: "Total continuing education credits earned — workforce development output."
    - name: "waiver_count"
      expr: SUM(CASE WHEN waiver_flag = true THEN 1 ELSE 0 END)
      comment: "Trainings waived — exception monitoring for compliance gaps."
    - name: "escalation_count"
      expr: SUM(CASE WHEN escalation_flag = true THEN 1 ELSE 0 END)
      comment: "Overdue trainings escalated — non-compliance risk signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on compliance obligations: compliance percentage, overdue obligations, findings, and corrective actions to monitor obligation fulfillment."
  source: "`vibe_healthcare_v1`.`compliance`.`obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of obligation for portfolio segmentation."
    - name: "obligation_status"
      expr: obligation_status
      comment: "Status of the obligation."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority of the obligation."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating for prioritization."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Governing regulatory authority."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the obligation is due for SLA tracking."
  measures:
    - name: "obligation_count"
      expr: COUNT(1)
      comment: "Total obligations tracked — compliance portfolio size."
    - name: "active_obligation_count"
      expr: SUM(CASE WHEN is_active = true THEN 1 ELSE 0 END)
      comment: "Active obligations requiring monitoring."
    - name: "avg_compliance_percentage"
      expr: AVG(CAST(compliance_percentage AS DOUBLE))
      comment: "Average obligation compliance percentage — overall fulfillment KPI."
    - name: "corrective_action_required_count"
      expr: SUM(CASE WHEN corrective_action_required = true THEN 1 ELSE 0 END)
      comment: "Obligations requiring corrective action — remediation workload."
    - name: "escalation_required_count"
      expr: SUM(CASE WHEN escalation_required = true THEN 1 ELSE 0 END)
      comment: "Obligations flagged for escalation — at-risk compliance signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on compliance investigations: confirmed violations, financial impact, external referrals, and self-disclosures to steer enforcement and risk response."
  source: "`vibe_healthcare_v1`.`compliance`.`investigation`"
  dimensions:
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of investigation for categorization."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of the investigation."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority for triage."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the investigation."
    - name: "trigger_source"
      expr: trigger_source
      comment: "Source that triggered the investigation."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month investigation started for trending."
  measures:
    - name: "investigation_count"
      expr: COUNT(1)
      comment: "Total investigations — enforcement workload volume."
    - name: "violation_confirmed_count"
      expr: SUM(CASE WHEN violation_confirmed_flag = true THEN 1 ELSE 0 END)
      comment: "Investigations confirming a violation — substantiated risk count."
    - name: "violation_confirmation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN violation_confirmed_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of investigations confirming violations — substantiation KPI."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of investigations — quantified compliance loss exposure."
    - name: "self_disclosure_required_count"
      expr: SUM(CASE WHEN self_disclosure_required_flag = true THEN 1 ELSE 0 END)
      comment: "Investigations requiring self-disclosure — regulatory exposure indicator."
    - name: "external_referral_count"
      expr: SUM(CASE WHEN external_referral_agency IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Investigations referred externally — escalation severity signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_hotline_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on compliance hotline reports: anonymity, retaliation concerns, corrective actions, and regulatory reporting to monitor ethics program health."
  source: "`vibe_healthcare_v1`.`compliance`.`hotline_report`"
  dimensions:
    - name: "allegation_category"
      expr: allegation_category
      comment: "Category of allegation for trend analysis."
    - name: "investigation_status"
      expr: investigation_status
      comment: "Status of investigation following the report."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the allegation."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority for triage."
    - name: "report_channel"
      expr: report_channel
      comment: "Channel through which the report was received."
    - name: "report_month"
      expr: DATE_TRUNC('MONTH', report_date)
      comment: "Month of report for trending."
  measures:
    - name: "report_count"
      expr: COUNT(1)
      comment: "Total hotline reports — ethics program engagement volume."
    - name: "anonymous_report_count"
      expr: SUM(CASE WHEN reporter_anonymity_flag = true THEN 1 ELSE 0 END)
      comment: "Anonymous reports — culture/trust indicator for the hotline program."
    - name: "retaliation_concern_count"
      expr: SUM(CASE WHEN retaliation_concern_flag = true THEN 1 ELSE 0 END)
      comment: "Reports flagging retaliation concern — culture risk signal."
    - name: "corrective_action_required_count"
      expr: SUM(CASE WHEN corrective_action_required_flag = true THEN 1 ELSE 0 END)
      comment: "Reports requiring corrective action — substantiated issue volume."
    - name: "regulatory_reporting_count"
      expr: SUM(CASE WHEN regulatory_reporting_required_flag = true THEN 1 ELSE 0 END)
      comment: "Reports triggering regulatory reporting — disclosure exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_phi_access_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on PHI access auditing: emergency access, flagged-for-review, breach determinations, and consent presence to monitor access governance."
  source: "`vibe_healthcare_v1`.`compliance`.`phi_access_log`"
  dimensions:
    - name: "access_type"
      expr: access_type
      comment: "Type of PHI access for pattern analysis."
    - name: "user_role"
      expr: user_role
      comment: "Role of the accessing user for access governance."
    - name: "user_department"
      expr: user_department
      comment: "Department of the accessing user."
    - name: "data_classification"
      expr: data_classification
      comment: "Classification of accessed data for sensitivity analysis."
    - name: "review_status"
      expr: review_status
      comment: "Review status of the access event."
    - name: "access_month"
      expr: DATE_TRUNC('MONTH', access_timestamp)
      comment: "Month of access event for trending."
  measures:
    - name: "access_event_count"
      expr: COUNT(1)
      comment: "Total PHI access events — access volume baseline."
    - name: "emergency_access_count"
      expr: SUM(CASE WHEN emergency_access_flag = true THEN 1 ELSE 0 END)
      comment: "Break-glass emergency accesses — high-scrutiny access events."
    - name: "flagged_for_review_count"
      expr: SUM(CASE WHEN flagged_for_review = true THEN 1 ELSE 0 END)
      comment: "Access events flagged for review — potential inappropriate access signal."
    - name: "flagged_review_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN flagged_for_review = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accesses flagged for review — access governance KPI."
    - name: "corrective_action_count"
      expr: SUM(CASE WHEN corrective_action_required = true THEN 1 ELSE 0 END)
      comment: "Access events requiring corrective action — confirmed access issue volume."
    - name: "no_consent_count"
      expr: SUM(CASE WHEN patient_consent_on_file = false THEN 1 ELSE 0 END)
      comment: "Access events without consent on file — consent compliance gap."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_exclusion_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on OIG/SAM exclusion screening: match rates, resolution status, and reinstatements to manage sanctioned-party employment/contracting risk."
  source: "`vibe_healthcare_v1`.`compliance`.`exclusion_screening`"
  dimensions:
    - name: "screened_entity_type"
      expr: screened_entity_type
      comment: "Type of entity screened (employee, vendor, provider)."
    - name: "screening_result"
      expr: screening_result
      comment: "Result of the screening event."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Status of match resolution."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the screening match."
    - name: "screening_source"
      expr: screening_source
      comment: "Source list screened against (OIG LEIE, SAM)."
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_date)
      comment: "Month of screening for trending."
  measures:
    - name: "screening_count"
      expr: COUNT(1)
      comment: "Total screenings performed — exclusion screening coverage volume."
    - name: "match_found_count"
      expr: SUM(CASE WHEN match_found_flag = true THEN 1 ELSE 0 END)
      comment: "Screenings with a match — potential sanctioned-party exposure."
    - name: "match_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN match_found_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screenings returning a match — exclusion risk KPI."
    - name: "resolved_count"
      expr: SUM(CASE WHEN resolution_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Screenings with resolved matches — remediation throughput."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_regulatory_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on regulatory change management: implementation status, penalty exposure, and cost of compliance change to steer regulatory readiness."
  source: "`vibe_healthcare_v1`.`compliance`.`regulatory_change`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of regulatory change."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Implementation status of the change."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the change for prioritization."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Issuing regulatory body."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Governing framework."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month change becomes effective for readiness planning."
  measures:
    - name: "change_count"
      expr: COUNT(1)
      comment: "Total regulatory changes tracked — change management workload."
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_exposure_amount AS DOUBLE))
      comment: "Total penalty exposure from regulatory changes — financial risk if non-compliant."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated cost to implement changes — compliance investment planning."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost of implementing changes — budget variance input."
    - name: "policy_update_required_count"
      expr: SUM(CASE WHEN policy_updates_required_flag = true THEN 1 ELSE 0 END)
      comment: "Changes requiring policy updates — downstream remediation workload."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_stark_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on Stark Law physician arrangements: FMV compliance, disclosure obligations, and compensation exposure to manage referral-relationship risk."
  source: "`vibe_healthcare_v1`.`compliance`.`stark_arrangement`"
  dimensions:
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Type of physician arrangement."
    - name: "arrangement_status"
      expr: arrangement_status
      comment: "Status of the arrangement."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the arrangement."
    - name: "legal_approval_status"
      expr: legal_approval_status
      comment: "Legal review approval status."
    - name: "stark_exception_applied"
      expr: stark_exception_applied
      comment: "Stark Law exception applied to the arrangement."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month arrangement became effective."
  measures:
    - name: "arrangement_count"
      expr: COUNT(1)
      comment: "Total Stark arrangements — compliance portfolio size."
    - name: "total_compensation"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total compensation across arrangements — aggregate financial exposure."
    - name: "avg_compensation"
      expr: AVG(CAST(compensation_amount AS DOUBLE))
      comment: "Average compensation per arrangement — FMV benchmarking input."
    - name: "fmv_compliant_count"
      expr: SUM(CASE WHEN fmv_compliant_flag = true THEN 1 ELSE 0 END)
      comment: "Arrangements deemed FMV-compliant — Stark compliance count."
    - name: "fmv_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fmv_compliant_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of arrangements FMV-compliant — Stark risk KPI."
    - name: "disclosure_required_count"
      expr: SUM(CASE WHEN disclosure_required_flag = true THEN 1 ELSE 0 END)
      comment: "Arrangements requiring disclosure — regulatory exposure indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_osha_exposure_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on OSHA exposure incidents (sharps/bloodborne): recordability, lost workdays, PEP initiation, and workers comp to manage occupational safety."
  source: "`vibe_healthcare_v1`.`compliance`.`osha_exposure_incident`"
  dimensions:
    - name: "exposure_type"
      expr: exposure_type
      comment: "Type of occupational exposure."
    - name: "exposure_route"
      expr: exposure_route
      comment: "Route of exposure for prevention analysis."
    - name: "incident_status"
      expr: incident_status
      comment: "Status of the exposure incident."
    - name: "exposed_employee_department"
      expr: exposed_employee_department
      comment: "Department of exposed employee for hotspot analysis."
    - name: "sharps_device_type"
      expr: sharps_device_type
      comment: "Sharps device type involved for safety-device targeting."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of incident for trending."
  measures:
    - name: "incident_count"
      expr: COUNT(1)
      comment: "Total exposure incidents — occupational safety volume baseline."
    - name: "osha_recordable_count"
      expr: SUM(CASE WHEN osha_recordable_flag = true THEN 1 ELSE 0 END)
      comment: "OSHA-recordable incidents — regulatory reporting metric (OSHA 300 log)."
    - name: "pep_initiated_count"
      expr: SUM(CASE WHEN pep_initiated_flag = true THEN 1 ELSE 0 END)
      comment: "Incidents with post-exposure prophylaxis initiated — clinical response indicator."
    - name: "workers_comp_filed_count"
      expr: SUM(CASE WHEN workers_comp_claim_filed_flag = true THEN 1 ELSE 0 END)
      comment: "Incidents with workers comp claims — cost and severity indicator."
    - name: "safety_device_count"
      expr: SUM(CASE WHEN safety_engineered_device_flag = true THEN 1 ELSE 0 END)
      comment: "Incidents involving safety-engineered devices — device effectiveness signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_business_associate_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on Business Associate Agreements: active status, breach-notification clauses, insurance coverage, and review currency for HIPAA vendor governance."
  source: "`vibe_healthcare_v1`.`compliance`.`business_associate_agreement`"
  dimensions:
    - name: "business_associate_agreement_status"
      expr: business_associate_agreement_status
      comment: "Status of the BAA."
    - name: "phi_types_shared"
      expr: phi_types_shared
      comment: "Types of PHI shared under the agreement."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month BAA became effective."
    - name: "next_review_month"
      expr: DATE_TRUNC('MONTH', next_review_date)
      comment: "Month next review is due for governance scheduling."
  measures:
    - name: "baa_count"
      expr: COUNT(1)
      comment: "Total BAAs — vendor PHI-sharing portfolio size."
    - name: "breach_notification_required_count"
      expr: SUM(CASE WHEN breach_notification_required_flag = true THEN 1 ELSE 0 END)
      comment: "BAAs with breach-notification clauses — compliance coverage indicator."
    - name: "insurance_required_count"
      expr: SUM(CASE WHEN insurance_required_flag = true THEN 1 ELSE 0 END)
      comment: "BAAs requiring insurance — risk-transfer coverage."
    - name: "total_insurance_coverage"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage across BAAs — aggregate risk-transfer capacity."
    - name: "subcontractor_baa_required_count"
      expr: SUM(CASE WHEN subcontractor_baa_required_flag = true THEN 1 ELSE 0 END)
      comment: "BAAs requiring subcontractor BAAs — chain-of-compliance exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_cms_condition_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on CMS Conditions of Participation: open deficiencies, enforcement actions, civil monetary penalties, and plan-of-correction status for accreditation risk."
  source: "`vibe_healthcare_v1`.`compliance`.`cms_condition_status`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "CMS certification status."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status against the condition."
    - name: "condition_category"
      expr: condition_category
      comment: "Category of CMS condition."
    - name: "scope_and_severity_level"
      expr: scope_and_severity_level
      comment: "CMS scope and severity grid level."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level for prioritization."
    - name: "last_survey_month"
      expr: DATE_TRUNC('MONTH', last_survey_date)
      comment: "Month of last CMS survey for trending."
  measures:
    - name: "condition_status_count"
      expr: COUNT(1)
      comment: "Total CMS condition status records — CoP monitoring portfolio."
    - name: "enforcement_action_count"
      expr: SUM(CASE WHEN enforcement_action_flag = true THEN 1 ELSE 0 END)
      comment: "Conditions with enforcement actions — serious regulatory risk count."
    - name: "total_civil_monetary_penalty"
      expr: SUM(CAST(civil_monetary_penalty_amount AS DOUBLE))
      comment: "Total civil monetary penalties — direct CMS financial exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_conflict_of_interest`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs on conflict-of-interest disclosures: mitigation requirements, disclosed value, and recertification to govern financial-relationship risk."
  source: "`vibe_healthcare_v1`.`compliance`.`conflict_of_interest`"
  dimensions:
    - name: "disclosure_type"
      expr: disclosure_type
      comment: "Type of COI disclosure."
    - name: "disclosure_status"
      expr: disclosure_status
      comment: "Status of the disclosure."
    - name: "relationship_type"
      expr: relationship_type
      comment: "Type of relationship disclosed."
    - name: "disclosed_entity_type"
      expr: disclosed_entity_type
      comment: "Type of entity disclosed."
    - name: "disclosure_month"
      expr: DATE_TRUNC('MONTH', disclosure_date)
      comment: "Month of disclosure for trending."
  measures:
    - name: "disclosure_count"
      expr: COUNT(1)
      comment: "Total COI disclosures — governance program engagement volume."
    - name: "mitigation_required_count"
      expr: SUM(CASE WHEN mitigation_required_flag = true THEN 1 ELSE 0 END)
      comment: "Disclosures requiring mitigation — active conflict risk count."
    - name: "mitigation_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN mitigation_required_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disclosures requiring mitigation — conflict severity KPI."
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value_amount AS DOUBLE))
      comment: "Total estimated value of disclosed relationships — financial-exposure magnitude."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic view of policy inventory and attestation obligations"
  source: "`vibe_healthcare_v1`.`compliance`.`compliance_policy`"
  dimensions:
    - name: "policy_category"
      expr: policy_category
      comment: "High‑level category of the policy (e.g., Data Privacy, Security)"
  measures:
    - name: "total_policies"
      expr: COUNT(1)
      comment: "Total number of compliance policies in the catalog"
    - name: "active_policy_count"
      expr: SUM(CASE WHEN policy_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of policies currently active"
    - name: "policies_requiring_attestation"
      expr: SUM(CASE WHEN attestation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of policies that require employee attestation"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`compliance_privacy_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy incident volume and resolution speed for compliance leadership"
  source: "`vibe_healthcare_v1`.`compliance`.`hipaa_privacy_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Category of privacy incident"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of HIPAA privacy incidents reported"
    - name: "average_days_to_close"
      expr: AVG(CAST(DATEDIFF(closed_date, incident_date) AS DOUBLE))
      comment: "Average days from incident occurrence to closure"
$$;