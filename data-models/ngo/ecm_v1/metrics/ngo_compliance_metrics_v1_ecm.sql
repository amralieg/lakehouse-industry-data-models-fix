-- Metric views for domain: compliance | Business: Ngo | Version: 1 | Generated on: 2026-05-07 01:23:35

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit findings metrics tracking questioned costs, material weaknesses, repeat findings, and resolution performance across federal awards and compliance requirements"
  source: "`ngo_ecm`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of audit finding (e.g., compliance, internal control, financial statement)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the finding (e.g., critical, high, medium, low)"
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding (e.g., open, in progress, resolved, closed)"
    - name: "is_material_weakness"
      expr: is_material_weakness
      comment: "Flag indicating whether the finding represents a material weakness in internal controls"
    - name: "is_significant_deficiency"
      expr: is_significant_deficiency
      comment: "Flag indicating whether the finding represents a significant deficiency"
    - name: "is_repeat_finding"
      expr: is_repeat_finding
      comment: "Flag indicating whether this is a repeat finding from prior audits"
    - name: "is_fraud_indicator"
      expr: is_fraud_indicator
      comment: "Flag indicating potential fraud indicators associated with the finding"
    - name: "federal_agency_name"
      expr: federal_agency_name
      comment: "Name of the federal agency associated with the award under audit"
    - name: "compliance_requirement_type"
      expr: compliance_requirement_type
      comment: "Type of compliance requirement violated (e.g., allowable costs, eligibility, reporting)"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category classification of the finding"
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for addressing the finding"
    - name: "finding_year"
      expr: YEAR(finding_identified_date)
      comment: "Year the finding was identified"
    - name: "finding_quarter"
      expr: CONCAT('Q', QUARTER(finding_identified_date))
      comment: "Quarter the finding was identified"
    - name: "audit_period_year"
      expr: YEAR(audit_period_start_date)
      comment: "Year of the audit period under review"
  measures:
    - name: "total_findings_count"
      expr: COUNT(1)
      comment: "Total number of audit findings"
    - name: "total_questioned_costs"
      expr: SUM(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Total dollar amount of questioned costs across all findings"
    - name: "avg_questioned_cost_per_finding"
      expr: AVG(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Average questioned cost amount per finding"
    - name: "material_weakness_count"
      expr: COUNT(CASE WHEN is_material_weakness = TRUE THEN 1 END)
      comment: "Count of findings classified as material weaknesses"
    - name: "significant_deficiency_count"
      expr: COUNT(CASE WHEN is_significant_deficiency = TRUE THEN 1 END)
      comment: "Count of findings classified as significant deficiencies"
    - name: "repeat_finding_count"
      expr: COUNT(CASE WHEN is_repeat_finding = TRUE THEN 1 END)
      comment: "Count of repeat findings from prior audit periods"
    - name: "fraud_indicator_count"
      expr: COUNT(CASE WHEN is_fraud_indicator = TRUE THEN 1 END)
      comment: "Count of findings with potential fraud indicators"
    - name: "open_findings_count"
      expr: COUNT(CASE WHEN finding_status IN ('Open', 'In Progress') THEN 1 END)
      comment: "Count of findings that are currently open or in progress"
    - name: "resolved_findings_count"
      expr: COUNT(CASE WHEN finding_status IN ('Resolved', 'Closed') THEN 1 END)
      comment: "Count of findings that have been resolved or closed"
    - name: "overdue_findings_count"
      expr: COUNT(CASE WHEN expected_resolution_date < CURRENT_DATE() AND finding_status NOT IN ('Resolved', 'Closed') THEN 1 END)
      comment: "Count of findings past their expected resolution date and still open"
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(actual_resolution_date, finding_identified_date))
      comment: "Average number of days from finding identification to actual resolution"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`compliance_corrective_action_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action plan metrics tracking remediation effectiveness, cost, timeliness, and escalation patterns for audit findings and compliance incidents"
  source: "`ngo_ecm`.`compliance`.`corrective_action_plan`"
  dimensions:
    - name: "cap_status"
      expr: cap_status
      comment: "Current status of the corrective action plan (e.g., draft, approved, in progress, completed)"
    - name: "finding_type"
      expr: finding_type
      comment: "Type of finding being addressed by the corrective action plan"
    - name: "finding_severity"
      expr: finding_severity
      comment: "Severity level of the underlying finding"
    - name: "recurrence_risk"
      expr: recurrence_risk
      comment: "Assessed risk of finding recurrence (e.g., high, medium, low)"
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for implementing the corrective action plan"
    - name: "escalation_required"
      expr: escalation_required
      comment: "Flag indicating whether escalation to senior management is required"
    - name: "donor_notification_required"
      expr: donor_notification_required
      comment: "Flag indicating whether donor notification is required"
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Flag indicating whether regulatory reporting is required"
    - name: "cap_year"
      expr: YEAR(target_completion_date)
      comment: "Year of the target completion date"
    - name: "cap_quarter"
      expr: CONCAT('Q', QUARTER(target_completion_date))
      comment: "Quarter of the target completion date"
  measures:
    - name: "total_caps_count"
      expr: COUNT(1)
      comment: "Total number of corrective action plans"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all corrective action plans"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for completed corrective action plans"
    - name: "avg_estimated_cost_per_cap"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per corrective action plan"
    - name: "avg_actual_cost_per_cap"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per completed corrective action plan"
    - name: "completed_caps_count"
      expr: COUNT(CASE WHEN cap_status = 'Completed' THEN 1 END)
      comment: "Count of corrective action plans that have been completed"
    - name: "in_progress_caps_count"
      expr: COUNT(CASE WHEN cap_status = 'In Progress' THEN 1 END)
      comment: "Count of corrective action plans currently in progress"
    - name: "overdue_caps_count"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE() AND cap_status NOT IN ('Completed', 'Closed') THEN 1 END)
      comment: "Count of corrective action plans past their target completion date and not yet completed"
    - name: "escalated_caps_count"
      expr: COUNT(CASE WHEN escalation_required = TRUE THEN 1 END)
      comment: "Count of corrective action plans requiring escalation to senior management"
    - name: "donor_notification_caps_count"
      expr: COUNT(CASE WHEN donor_notification_required = TRUE THEN 1 END)
      comment: "Count of corrective action plans requiring donor notification"
    - name: "regulatory_reporting_caps_count"
      expr: COUNT(CASE WHEN regulatory_reporting_required = TRUE THEN 1 END)
      comment: "Count of corrective action plans requiring regulatory reporting"
    - name: "avg_days_to_completion"
      expr: AVG(DATEDIFF(actual_completion_date, created_timestamp))
      comment: "Average number of days from CAP creation to actual completion"
    - name: "high_recurrence_risk_count"
      expr: COUNT(CASE WHEN recurrence_risk = 'High' THEN 1 END)
      comment: "Count of corrective action plans addressing findings with high recurrence risk"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`compliance_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance incident metrics tracking incident volume, severity, financial impact, investigation timeliness, and regulatory reporting obligations"
  source: "`ngo_ecm`.`compliance`.`compliance_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of compliance incident (e.g., fraud, conflict of interest, policy violation)"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (e.g., reported, under investigation, resolved, closed)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the incident (e.g., critical, high, medium, low)"
    - name: "allegation_category"
      expr: allegation_category
      comment: "Category of the allegation (e.g., financial misconduct, ethical violation, regulatory breach)"
    - name: "reporting_channel"
      expr: reporting_channel
      comment: "Channel through which the incident was reported (e.g., hotline, email, in-person)"
    - name: "donor_notification_required_flag"
      expr: donor_notification_required_flag
      comment: "Flag indicating whether donor notification is required for this incident"
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Flag indicating whether regulatory reporting is required for this incident"
    - name: "public_disclosure_flag"
      expr: public_disclosure_flag
      comment: "Flag indicating whether public disclosure is required or has occurred"
    - name: "reporter_anonymity_flag"
      expr: reporter_anonymity_flag
      comment: "Flag indicating whether the reporter requested anonymity"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year the incident occurred"
    - name: "incident_quarter"
      expr: CONCAT('Q', QUARTER(incident_date))
      comment: "Quarter the incident occurred"
    - name: "reported_year"
      expr: YEAR(reported_date)
      comment: "Year the incident was reported"
  measures:
    - name: "total_incidents_count"
      expr: COUNT(1)
      comment: "Total number of compliance incidents"
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact_usd AS DOUBLE))
      comment: "Total estimated financial impact across all incidents in USD"
    - name: "avg_financial_impact_per_incident"
      expr: AVG(CAST(estimated_financial_impact_usd AS DOUBLE))
      comment: "Average estimated financial impact per incident in USD"
    - name: "critical_incidents_count"
      expr: COUNT(CASE WHEN severity_level = 'Critical' THEN 1 END)
      comment: "Count of incidents classified as critical severity"
    - name: "high_severity_incidents_count"
      expr: COUNT(CASE WHEN severity_level = 'High' THEN 1 END)
      comment: "Count of incidents classified as high severity"
    - name: "open_incidents_count"
      expr: COUNT(CASE WHEN incident_status IN ('Reported', 'Under Investigation', 'In Progress') THEN 1 END)
      comment: "Count of incidents currently open or under investigation"
    - name: "resolved_incidents_count"
      expr: COUNT(CASE WHEN incident_status IN ('Resolved', 'Closed') THEN 1 END)
      comment: "Count of incidents that have been resolved or closed"
    - name: "donor_notification_required_count"
      expr: COUNT(CASE WHEN donor_notification_required_flag = TRUE THEN 1 END)
      comment: "Count of incidents requiring donor notification"
    - name: "regulatory_reporting_required_count"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 END)
      comment: "Count of incidents requiring regulatory reporting"
    - name: "public_disclosure_count"
      expr: COUNT(CASE WHEN public_disclosure_flag = TRUE THEN 1 END)
      comment: "Count of incidents requiring or having public disclosure"
    - name: "anonymous_reports_count"
      expr: COUNT(CASE WHEN reporter_anonymity_flag = TRUE THEN 1 END)
      comment: "Count of incidents reported anonymously"
    - name: "avg_days_to_investigation_start"
      expr: AVG(DATEDIFF(investigation_start_date, reported_date))
      comment: "Average number of days from incident report to investigation start"
    - name: "avg_investigation_duration_days"
      expr: AVG(DATEDIFF(investigation_completion_date, investigation_start_date))
      comment: "Average duration of investigations in days from start to completion"
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(resolution_date, reported_date))
      comment: "Average number of days from incident report to resolution"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`compliance_single_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Single audit (A-133/Uniform Guidance) metrics tracking federal expenditures, audit findings, questioned costs, and compliance opinion outcomes"
  source: "`ngo_ecm`.`compliance`.`single_audit`"
  dimensions:
    - name: "audit_year"
      expr: audit_year
      comment: "Fiscal year of the single audit"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the single audit (e.g., planning, fieldwork, reporting, completed)"
    - name: "financial_statement_opinion_type"
      expr: financial_statement_opinion_type
      comment: "Type of opinion issued on financial statements (e.g., unmodified, qualified, adverse, disclaimer)"
    - name: "compliance_opinion_type"
      expr: compliance_opinion_type
      comment: "Type of opinion issued on compliance with federal award requirements"
    - name: "internal_control_opinion_type"
      expr: internal_control_opinion_type
      comment: "Type of opinion issued on internal controls over compliance"
    - name: "low_risk_auditee_flag"
      expr: low_risk_auditee_flag
      comment: "Flag indicating whether the organization qualifies as a low-risk auditee"
    - name: "material_weakness_identified_flag"
      expr: material_weakness_identified_flag
      comment: "Flag indicating whether material weaknesses were identified in the audit"
    - name: "significant_deficiency_identified_flag"
      expr: significant_deficiency_identified_flag
      comment: "Flag indicating whether significant deficiencies were identified"
    - name: "going_concern_issue_flag"
      expr: going_concern_issue_flag
      comment: "Flag indicating whether going concern issues were identified"
    - name: "corrective_action_plan_submitted_flag"
      expr: corrective_action_plan_submitted_flag
      comment: "Flag indicating whether a corrective action plan was submitted"
    - name: "auditor_firm_name"
      expr: auditor_firm_name
      comment: "Name of the auditing firm conducting the single audit"
    - name: "audit_period_year"
      expr: YEAR(audit_period_start_date)
      comment: "Year of the audit period start date"
  measures:
    - name: "total_audits_count"
      expr: COUNT(1)
      comment: "Total number of single audits"
    - name: "total_federal_expenditure"
      expr: SUM(CAST(federal_expenditure_amount AS DOUBLE))
      comment: "Total federal expenditures subject to single audit across all audits"
    - name: "avg_federal_expenditure_per_audit"
      expr: AVG(CAST(federal_expenditure_amount AS DOUBLE))
      comment: "Average federal expenditure amount per single audit"
    - name: "total_questioned_costs"
      expr: SUM(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Total questioned costs identified across all single audits"
    - name: "avg_questioned_cost_per_audit"
      expr: AVG(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Average questioned cost amount per single audit"
    - name: "total_audit_cost"
      expr: SUM(CAST(audit_cost_amount AS DOUBLE))
      comment: "Total cost of conducting single audits"
    - name: "avg_audit_cost"
      expr: AVG(CAST(audit_cost_amount AS DOUBLE))
      comment: "Average cost per single audit"
    - name: "total_audit_findings"
      expr: SUM(CAST(audit_finding_count AS BIGINT))
      comment: "Total number of audit findings across all single audits"
    - name: "avg_findings_per_audit"
      expr: AVG(CAST(audit_finding_count AS BIGINT))
      comment: "Average number of findings per single audit"
    - name: "total_major_programs"
      expr: SUM(CAST(major_program_count AS BIGINT))
      comment: "Total number of major programs tested across all single audits"
    - name: "avg_major_programs_per_audit"
      expr: AVG(CAST(major_program_count AS BIGINT))
      comment: "Average number of major programs tested per single audit"
    - name: "low_risk_auditee_count"
      expr: COUNT(CASE WHEN low_risk_auditee_flag = TRUE THEN 1 END)
      comment: "Count of audits where the organization qualified as a low-risk auditee"
    - name: "material_weakness_count"
      expr: COUNT(CASE WHEN material_weakness_identified_flag = TRUE THEN 1 END)
      comment: "Count of audits with material weaknesses identified"
    - name: "significant_deficiency_count"
      expr: COUNT(CASE WHEN significant_deficiency_identified_flag = TRUE THEN 1 END)
      comment: "Count of audits with significant deficiencies identified"
    - name: "going_concern_count"
      expr: COUNT(CASE WHEN going_concern_issue_flag = TRUE THEN 1 END)
      comment: "Count of audits with going concern issues identified"
    - name: "unmodified_opinion_count"
      expr: COUNT(CASE WHEN financial_statement_opinion_type = 'Unmodified' THEN 1 END)
      comment: "Count of audits receiving an unmodified (clean) financial statement opinion"
    - name: "avg_fieldwork_duration_days"
      expr: AVG(DATEDIFF(fieldwork_end_date, fieldwork_start_date))
      comment: "Average duration of audit fieldwork in days"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`compliance_obligation_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance obligation schedule metrics tracking on-time completion rates, effort variance, escalations, and penalty exposure across regulatory and donor requirements"
  source: "`ngo_ecm`.`compliance`.`obligation_schedule`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Current completion status of the scheduled obligation (e.g., not started, in progress, completed, overdue)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the obligation (e.g., critical, high, medium, low)"
    - name: "workflow_stage"
      expr: workflow_stage
      comment: "Current workflow stage of the obligation fulfillment process"
    - name: "non_compliance_risk"
      expr: non_compliance_risk
      comment: "Assessed risk level of non-compliance (e.g., high, medium, low)"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the obligation (e.g., OMB Uniform Guidance, IATI, CHS)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the obligation"
    - name: "extension_granted_flag"
      expr: extension_granted_flag
      comment: "Flag indicating whether an extension was granted for the obligation"
    - name: "extension_requested_flag"
      expr: extension_requested_flag
      comment: "Flag indicating whether an extension was requested"
    - name: "escalation_triggered_flag"
      expr: escalation_triggered_flag
      comment: "Flag indicating whether escalation was triggered due to delays or issues"
    - name: "due_year"
      expr: YEAR(planned_due_date)
      comment: "Year of the planned due date"
    - name: "due_quarter"
      expr: CONCAT('Q', QUARTER(planned_due_date))
      comment: "Quarter of the planned due date"
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', planned_due_date)
      comment: "Month of the planned due date"
  measures:
    - name: "total_obligations_count"
      expr: COUNT(1)
      comment: "Total number of scheduled compliance obligations"
    - name: "completed_obligations_count"
      expr: COUNT(CASE WHEN completion_status = 'Completed' THEN 1 END)
      comment: "Count of obligations completed on or before the due date"
    - name: "overdue_obligations_count"
      expr: COUNT(CASE WHEN completion_status = 'Overdue' OR (effective_due_date < CURRENT_DATE() AND completion_status NOT IN ('Completed', 'Closed')) THEN 1 END)
      comment: "Count of obligations past their effective due date and not yet completed"
    - name: "in_progress_obligations_count"
      expr: COUNT(CASE WHEN completion_status = 'In Progress' THEN 1 END)
      comment: "Count of obligations currently in progress"
    - name: "critical_priority_count"
      expr: COUNT(CASE WHEN priority_level = 'Critical' THEN 1 END)
      comment: "Count of obligations classified as critical priority"
    - name: "high_risk_non_compliance_count"
      expr: COUNT(CASE WHEN non_compliance_risk = 'High' THEN 1 END)
      comment: "Count of obligations with high non-compliance risk"
    - name: "extension_requested_count"
      expr: COUNT(CASE WHEN extension_requested_flag = TRUE THEN 1 END)
      comment: "Count of obligations for which an extension was requested"
    - name: "extension_granted_count"
      expr: COUNT(CASE WHEN extension_granted_flag = TRUE THEN 1 END)
      comment: "Count of obligations for which an extension was granted"
    - name: "escalation_triggered_count"
      expr: COUNT(CASE WHEN escalation_triggered_flag = TRUE THEN 1 END)
      comment: "Count of obligations where escalation was triggered"
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total potential penalty amount across all obligations at risk"
    - name: "avg_penalty_per_obligation"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average potential penalty amount per obligation"
    - name: "total_estimated_effort_hours"
      expr: SUM(CAST(estimated_effort_hours AS DOUBLE))
      comment: "Total estimated effort hours across all scheduled obligations"
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total actual effort hours spent on completed obligations"
    - name: "avg_estimated_effort_per_obligation"
      expr: AVG(CAST(estimated_effort_hours AS DOUBLE))
      comment: "Average estimated effort hours per obligation"
    - name: "avg_actual_effort_per_obligation"
      expr: AVG(CAST(actual_effort_hours AS DOUBLE))
      comment: "Average actual effort hours per completed obligation"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`compliance_internal_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Internal review and audit metrics tracking control effectiveness, finding severity distribution, risk scores, and management response timeliness"
  source: "`ngo_ecm`.`compliance`.`internal_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of internal review (e.g., compliance, financial, operational, IT security)"
    - name: "review_status"
      expr: review_status
      comment: "Current status of the internal review (e.g., planning, fieldwork, reporting, completed)"
    - name: "overall_compliance_rating"
      expr: overall_compliance_rating
      comment: "Overall compliance rating assigned by the review (e.g., satisfactory, needs improvement, unsatisfactory)"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Flag indicating whether corrective action is required based on review findings"
    - name: "donor_notification_required_flag"
      expr: donor_notification_required_flag
      comment: "Flag indicating whether donor notification is required based on review findings"
    - name: "follow_up_review_required_flag"
      expr: follow_up_review_required_flag
      comment: "Flag indicating whether a follow-up review is required"
    - name: "external_auditor_coordination_flag"
      expr: external_auditor_coordination_flag
      comment: "Flag indicating whether coordination with external auditors is required"
    - name: "review_methodology"
      expr: review_methodology
      comment: "Methodology used for the internal review (e.g., risk-based, comprehensive, targeted)"
    - name: "compliance_framework_reference"
      expr: compliance_framework_reference
      comment: "Compliance framework or standard referenced in the review"
    - name: "review_year"
      expr: YEAR(review_start_date)
      comment: "Year the internal review started"
    - name: "review_quarter"
      expr: CONCAT('Q', QUARTER(review_start_date))
      comment: "Quarter the internal review started"
  measures:
    - name: "total_reviews_count"
      expr: COUNT(1)
      comment: "Total number of internal reviews conducted"
    - name: "completed_reviews_count"
      expr: COUNT(CASE WHEN review_status = 'Completed' THEN 1 END)
      comment: "Count of internal reviews that have been completed"
    - name: "in_progress_reviews_count"
      expr: COUNT(CASE WHEN review_status IN ('Planning', 'Fieldwork', 'Reporting') THEN 1 END)
      comment: "Count of internal reviews currently in progress"
    - name: "total_findings_count"
      expr: SUM(CAST(total_findings_count AS BIGINT))
      comment: "Total number of findings identified across all internal reviews"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS BIGINT))
      comment: "Total number of critical findings across all reviews"
    - name: "total_high_findings"
      expr: SUM(CAST(high_findings_count AS BIGINT))
      comment: "Total number of high-severity findings across all reviews"
    - name: "total_medium_findings"
      expr: SUM(CAST(medium_findings_count AS BIGINT))
      comment: "Total number of medium-severity findings across all reviews"
    - name: "total_low_findings"
      expr: SUM(CAST(low_findings_count AS BIGINT))
      comment: "Total number of low-severity findings across all reviews"
    - name: "avg_findings_per_review"
      expr: AVG(CAST(total_findings_count AS BIGINT))
      comment: "Average number of findings per internal review"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all internal reviews"
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Count of reviews requiring corrective action"
    - name: "donor_notification_required_count"
      expr: COUNT(CASE WHEN donor_notification_required_flag = TRUE THEN 1 END)
      comment: "Count of reviews requiring donor notification"
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_review_required_flag = TRUE THEN 1 END)
      comment: "Count of reviews requiring follow-up review"
    - name: "satisfactory_rating_count"
      expr: COUNT(CASE WHEN overall_compliance_rating = 'Satisfactory' THEN 1 END)
      comment: "Count of reviews receiving a satisfactory overall compliance rating"
    - name: "avg_review_duration_days"
      expr: AVG(DATEDIFF(review_end_date, review_start_date))
      comment: "Average duration of internal reviews in days from start to end"
    - name: "avg_days_to_management_response"
      expr: AVG(DATEDIFF(management_response_received_date, report_issued_date))
      comment: "Average number of days from report issuance to management response receipt"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`compliance_sanctions_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sanctions and watchlist screening metrics tracking match rates, false positives, resolution timeliness, and high-risk subject identification"
  source: "`ngo_ecm`.`compliance`.`sanctions_screening`"
  dimensions:
    - name: "screening_status"
      expr: screening_status
      comment: "Current status of the sanctions screening (e.g., pending, cleared, flagged, under review)"
    - name: "match_result"
      expr: match_result
      comment: "Result of the screening match (e.g., no match, potential match, confirmed match)"
    - name: "subject_type"
      expr: subject_type
      comment: "Type of subject being screened (e.g., individual, organization, vendor, beneficiary)"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned based on screening results (e.g., high, medium, low)"
    - name: "false_positive_flag"
      expr: false_positive_flag
      comment: "Flag indicating whether the match was determined to be a false positive"
    - name: "rescreening_required_flag"
      expr: rescreening_required_flag
      comment: "Flag indicating whether periodic rescreening is required"
    - name: "screening_method"
      expr: screening_method
      comment: "Method used for screening (e.g., automated, manual, hybrid)"
    - name: "screening_tool"
      expr: screening_tool
      comment: "Tool or system used to perform the sanctions screening"
    - name: "sanctions_list_checked"
      expr: sanctions_list_checked
      comment: "Sanctions lists checked during screening (e.g., OFAC, UN, EU, UK)"
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis or regulation requiring the sanctions screening"
    - name: "screening_year"
      expr: YEAR(screening_date)
      comment: "Year the screening was performed"
    - name: "screening_quarter"
      expr: CONCAT('Q', QUARTER(screening_date))
      comment: "Quarter the screening was performed"
  measures:
    - name: "total_screenings_count"
      expr: COUNT(1)
      comment: "Total number of sanctions screenings performed"
    - name: "cleared_screenings_count"
      expr: COUNT(CASE WHEN screening_status = 'Cleared' AND match_result = 'No Match' THEN 1 END)
      comment: "Count of screenings that cleared with no matches"
    - name: "flagged_screenings_count"
      expr: COUNT(CASE WHEN screening_status = 'Flagged' OR match_result IN ('Potential Match', 'Confirmed Match') THEN 1 END)
      comment: "Count of screenings that were flagged for potential or confirmed matches"
    - name: "confirmed_match_count"
      expr: COUNT(CASE WHEN match_result = 'Confirmed Match' THEN 1 END)
      comment: "Count of screenings with confirmed sanctions matches"
    - name: "potential_match_count"
      expr: COUNT(CASE WHEN match_result = 'Potential Match' THEN 1 END)
      comment: "Count of screenings with potential matches requiring review"
    - name: "false_positive_count"
      expr: COUNT(CASE WHEN false_positive_flag = TRUE THEN 1 END)
      comment: "Count of screenings determined to be false positives after review"
    - name: "high_risk_count"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN 1 END)
      comment: "Count of screenings resulting in high-risk ratings"
    - name: "rescreening_required_count"
      expr: COUNT(CASE WHEN rescreening_required_flag = TRUE THEN 1 END)
      comment: "Count of subjects requiring periodic rescreening"
    - name: "under_review_count"
      expr: COUNT(CASE WHEN screening_status = 'Under Review' THEN 1 END)
      comment: "Count of screenings currently under review"
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match score across all screenings with potential or confirmed matches"
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(resolution_date, screening_date))
      comment: "Average number of days from screening to resolution for flagged cases"
    - name: "individual_screenings_count"
      expr: COUNT(CASE WHEN subject_type = 'Individual' THEN 1 END)
      comment: "Count of screenings performed on individual subjects"
    - name: "organization_screenings_count"
      expr: COUNT(CASE WHEN subject_type = 'Organization' THEN 1 END)
      comment: "Count of screenings performed on organizational subjects"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing metrics tracking submission timeliness, rejection rates, amendment frequency, filing fees, and public disclosure obligations"
  source: "`ngo_ecm`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the regulatory filing (e.g., draft, submitted, accepted, rejected)"
    - name: "amendment_flag"
      expr: amendment_flag
      comment: "Flag indicating whether this filing is an amendment to a previous filing"
    - name: "extension_requested_flag"
      expr: extension_requested_flag
      comment: "Flag indicating whether an extension was requested for the filing"
    - name: "extension_granted_flag"
      expr: extension_granted_flag
      comment: "Flag indicating whether an extension was granted"
    - name: "public_disclosure_flag"
      expr: public_disclosure_flag
      comment: "Flag indicating whether the filing is subject to public disclosure"
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel used for filing submission (e.g., electronic portal, mail, in-person)"
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Code indicating the reason for filing rejection if applicable"
    - name: "filing_year"
      expr: YEAR(due_date)
      comment: "Year of the filing due date"
    - name: "filing_quarter"
      expr: CONCAT('Q', QUARTER(due_date))
      comment: "Quarter of the filing due date"
    - name: "filing_period_year"
      expr: YEAR(filing_period_start_date)
      comment: "Year of the filing period start date"
  measures:
    - name: "total_filings_count"
      expr: COUNT(1)
      comment: "Total number of regulatory filings"
    - name: "submitted_filings_count"
      expr: COUNT(CASE WHEN filing_status IN ('Submitted', 'Accepted') THEN 1 END)
      comment: "Count of filings that have been submitted or accepted"
    - name: "accepted_filings_count"
      expr: COUNT(CASE WHEN filing_status = 'Accepted' THEN 1 END)
      comment: "Count of filings that have been accepted by the regulatory authority"
    - name: "rejected_filings_count"
      expr: COUNT(CASE WHEN filing_status = 'Rejected' THEN 1 END)
      comment: "Count of filings that were rejected"
    - name: "amendment_filings_count"
      expr: COUNT(CASE WHEN amendment_flag = TRUE THEN 1 END)
      comment: "Count of filings that are amendments to previous filings"
    - name: "extension_requested_count"
      expr: COUNT(CASE WHEN extension_requested_flag = TRUE THEN 1 END)
      comment: "Count of filings for which an extension was requested"
    - name: "extension_granted_count"
      expr: COUNT(CASE WHEN extension_granted_flag = TRUE THEN 1 END)
      comment: "Count of filings for which an extension was granted"
    - name: "public_disclosure_count"
      expr: COUNT(CASE WHEN public_disclosure_flag = TRUE THEN 1 END)
      comment: "Count of filings subject to public disclosure"
    - name: "late_filings_count"
      expr: COUNT(CASE WHEN submission_date > due_date THEN 1 END)
      comment: "Count of filings submitted after the original due date"
    - name: "on_time_filings_count"
      expr: COUNT(CASE WHEN submission_date <= due_date THEN 1 END)
      comment: "Count of filings submitted on or before the due date"
    - name: "total_filing_fees"
      expr: SUM(CAST(filing_fee_amount AS DOUBLE))
      comment: "Total filing fees paid across all regulatory filings"
    - name: "avg_filing_fee"
      expr: AVG(CAST(filing_fee_amount AS DOUBLE))
      comment: "Average filing fee per regulatory filing"
    - name: "avg_resubmission_count"
      expr: AVG(CAST(resubmission_count AS BIGINT))
      comment: "Average number of resubmissions per filing"
    - name: "avg_days_early_submission"
      expr: AVG(DATEDIFF(due_date, submission_date))
      comment: "Average number of days filings were submitted before the due date (positive = early)"
    - name: "avg_days_to_acceptance"
      expr: AVG(DATEDIFF(acceptance_date, submission_date))
      comment: "Average number of days from submission to acceptance by regulatory authority"
$$;