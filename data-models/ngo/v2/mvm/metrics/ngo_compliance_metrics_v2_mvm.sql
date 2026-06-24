-- Metric views for domain: compliance | Business: Ngo | Version: 2 | Generated on: 2026-06-20 07:31:45

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over audit findings from single audits and subawards. Tracks questioned costs, material weaknesses, repeat findings, and severity distribution to steer audit remediation priorities and risk posture."
  source: "`vibe_ngo_v1`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Category of audit finding (e.g., internal control, compliance, financial) used to segment risk exposure by type."
    - name: "finding_status"
      expr: finding_status
      comment: "Current resolution status of the finding (e.g., open, resolved, in-progress) for pipeline and aging analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the finding (e.g., critical, high, medium, low) to prioritize remediation effort."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk domain associated with the finding for cross-cutting risk management reporting."
    - name: "compliance_requirement_type"
      expr: compliance_requirement_type
      comment: "Federal or donor compliance requirement type the finding relates to, enabling regulatory exposure analysis."
    - name: "federal_agency_name"
      expr: federal_agency_name
      comment: "Federal agency associated with the award under audit, enabling agency-level compliance performance tracking."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Organizational department accountable for the finding, enabling departmental accountability reporting."
    - name: "is_repeat_finding"
      expr: is_repeat_finding
      comment: "Flag indicating whether the finding recurred from a prior audit period, a key indicator of systemic control failure."
    - name: "is_material_weakness"
      expr: is_material_weakness
      comment: "Flag indicating a material weakness in internal controls, a critical governance signal for leadership."
    - name: "is_significant_deficiency"
      expr: is_significant_deficiency
      comment: "Flag indicating a significant deficiency in internal controls, used alongside material weakness for control quality analysis."
    - name: "is_fraud_indicator"
      expr: is_fraud_indicator
      comment: "Flag indicating the finding has a fraud indicator, critical for risk and legal escalation tracking."
    - name: "audit_period_year"
      expr: YEAR(audit_period_start_date)
      comment: "Audit period year derived from start date, enabling year-over-year trend analysis of findings."
    - name: "finding_identified_month"
      expr: DATE_TRUNC('MONTH', finding_identified_date)
      comment: "Month the finding was identified, used for temporal trend analysis of audit discovery rates."
  measures:
    - name: "total_audit_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings. Baseline volume metric used to assess audit burden and control environment health."
    - name: "total_questioned_cost_usd"
      expr: SUM(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Total dollar value of costs questioned by auditors. A direct financial risk indicator used by CFOs and grant managers to assess potential fund recovery exposure."
    - name: "avg_questioned_cost_per_finding"
      expr: AVG(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Average questioned cost per audit finding. Indicates the typical financial magnitude of findings, informing risk-weighted remediation prioritization."
    - name: "open_findings_count"
      expr: COUNT(CASE WHEN finding_status = 'Open' THEN 1 END)
      comment: "Number of currently open audit findings. A key operational metric for tracking remediation backlog and compliance exposure."
    - name: "repeat_findings_count"
      expr: COUNT(CASE WHEN is_repeat_finding = TRUE THEN 1 END)
      comment: "Number of findings that recurred from prior audit periods. High repeat counts signal systemic control failures requiring structural intervention."
    - name: "material_weakness_count"
      expr: COUNT(CASE WHEN is_material_weakness = TRUE THEN 1 END)
      comment: "Number of findings classified as material weaknesses. A board-level governance metric directly tied to audit opinion risk and donor confidence."
    - name: "fraud_indicator_findings_count"
      expr: COUNT(CASE WHEN is_fraud_indicator = TRUE THEN 1 END)
      comment: "Number of findings with a fraud indicator. Triggers legal and executive escalation; directly linked to organizational integrity risk."
    - name: "questioned_cost_on_open_findings"
      expr: SUM(CASE WHEN finding_status = 'Open' THEN CAST(questioned_cost_amount AS DOUBLE) ELSE 0 END)
      comment: "Total questioned cost on unresolved findings. Represents the current financial exposure from outstanding audit issues, critical for CFO risk reporting."
    - name: "distinct_auditors_count"
      expr: COUNT(DISTINCT auditor_name)
      comment: "Number of distinct auditors involved in findings. Used to assess auditor concentration risk and coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_corrective_action_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs tracking the execution and cost efficiency of corrective action plans (CAPs) raised against audit findings. Enables leadership to monitor remediation velocity, cost overruns, and recurrence risk."
  source: "`vibe_ngo_v1`.`compliance`.`corrective_action_plan`"
  dimensions:
    - name: "cap_status"
      expr: cap_status
      comment: "Current status of the corrective action plan (e.g., open, in-progress, completed, overdue) for pipeline tracking."
    - name: "finding_type"
      expr: finding_type
      comment: "Type of audit finding the CAP addresses, enabling analysis of remediation effort by finding category."
    - name: "finding_severity"
      expr: finding_severity
      comment: "Severity of the underlying finding, used to prioritize and track high-severity CAP completion rates."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for executing the CAP, enabling departmental accountability and workload analysis."
    - name: "recurrence_risk"
      expr: recurrence_risk
      comment: "Assessed risk that the underlying issue will recur, a forward-looking quality indicator for CAP effectiveness."
    - name: "donor_notification_required"
      expr: donor_notification_required
      comment: "Flag indicating whether the donor must be notified of the finding and CAP, relevant for donor relationship management."
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Flag indicating whether regulatory reporting is required for this CAP, used to track regulatory obligation fulfillment."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify CAP completion (e.g., document review, site visit), enabling quality assurance analysis."
    - name: "target_completion_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Month the CAP is targeted for completion, used for forward-looking remediation pipeline planning."
  measures:
    - name: "total_corrective_action_plans"
      expr: COUNT(1)
      comment: "Total number of corrective action plans. Baseline volume metric for remediation workload assessment."
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred executing corrective action plans. A direct operational cost metric for budget management and donor reporting."
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of corrective action plans. Used alongside actual cost to compute budget variance and forecast remediation spend."
    - name: "avg_actual_cost_per_cap"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action plan. Benchmarks remediation efficiency and informs future CAP budgeting."
    - name: "cost_overrun_amount_usd"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Total cost overrun across all CAPs (actual minus estimated). Negative values indicate under-spend; positive values signal budget pressure and planning gaps."
    - name: "overdue_caps_count"
      expr: COUNT(CASE WHEN cap_status = 'Overdue' THEN 1 END)
      comment: "Number of corrective action plans past their target completion date. A critical operational risk metric for compliance leadership."
    - name: "completed_caps_count"
      expr: COUNT(CASE WHEN cap_status = 'Completed' THEN 1 END)
      comment: "Number of successfully completed corrective action plans. Tracks remediation throughput and closure rate."
    - name: "high_recurrence_risk_caps_count"
      expr: COUNT(CASE WHEN recurrence_risk = 'High' THEN 1 END)
      comment: "Number of CAPs with high recurrence risk. Flags systemic issues requiring deeper structural intervention beyond the immediate CAP."
    - name: "donor_notification_required_count"
      expr: COUNT(CASE WHEN donor_notification_required = TRUE THEN 1 END)
      comment: "Number of CAPs requiring donor notification. Tracks donor relationship obligations arising from audit findings."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_donor_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring compliance performance against donor-imposed requirements. Tracks fulfillment rates, effort variance, waiver activity, and non-compliance risk to protect donor relationships and funding continuity."
  source: "`vibe_ngo_v1`.`compliance`.`donor_requirement`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the donor requirement (e.g., compliant, non-compliant, pending) for pipeline and risk analysis."
    - name: "non_compliance_risk_level"
      expr: non_compliance_risk_level
      comment: "Assessed risk level of non-compliance (e.g., high, medium, low), used to prioritize remediation and escalation."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the requirement, enabling triage and resource allocation decisions."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for fulfilling the requirement, enabling departmental compliance performance tracking."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the deliverable (e.g., email, portal, hard copy), used for process efficiency analysis."
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Flag indicating a waiver was granted for this requirement, used to track donor flexibility and exception management."
    - name: "waiver_requested_flag"
      expr: waiver_requested_flag
      comment: "Flag indicating a waiver was requested, used to measure compliance strain and donor negotiation activity."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the requirement is due, used for forward-looking compliance calendar and workload planning."
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the requirement became effective, enabling cohort analysis of compliance performance over time."
  measures:
    - name: "total_donor_requirements"
      expr: COUNT(1)
      comment: "Total number of donor requirements. Baseline volume metric for compliance workload and obligation coverage."
    - name: "non_compliant_requirements_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of requirements currently in non-compliant status. A critical donor relationship risk metric that directly threatens funding continuity."
    - name: "high_risk_non_compliance_count"
      expr: COUNT(CASE WHEN non_compliance_risk_level = 'High' THEN 1 END)
      comment: "Number of requirements with high non-compliance risk. Prioritizes executive attention on requirements most likely to trigger donor sanctions."
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total actual staff hours spent fulfilling donor requirements. A key operational cost driver for capacity planning and grant budgeting."
    - name: "total_estimated_effort_hours"
      expr: SUM(CAST(estimated_effort_hours AS DOUBLE))
      comment: "Total estimated staff hours for donor requirements. Used alongside actual hours to compute effort variance and improve future estimates."
    - name: "effort_variance_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE) - CAST(estimated_effort_hours AS DOUBLE))
      comment: "Total effort variance (actual minus estimated hours) across all requirements. Positive values indicate underestimation; used to improve planning accuracy."
    - name: "waivers_granted_count"
      expr: COUNT(CASE WHEN waiver_granted_flag = TRUE THEN 1 END)
      comment: "Number of requirements for which a waiver was granted. Tracks exception volume and donor flexibility utilization."
    - name: "waivers_requested_count"
      expr: COUNT(CASE WHEN waiver_requested_flag = TRUE THEN 1 END)
      comment: "Number of waiver requests submitted. A leading indicator of compliance strain and capacity constraints relative to donor obligations."
    - name: "distinct_donors_engaged"
      expr: COUNT(DISTINCT donor_contact_email)
      comment: "Number of distinct donor contacts with active requirements. Measures donor relationship breadth and compliance management scope."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over compliance and safeguarding incidents. Tracks financial impact, investigation velocity, severity distribution, and regulatory reporting obligations to steer organizational risk management and accountability."
  source: "`vibe_ngo_v1`.`compliance`.`incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of incident (e.g., fraud, safeguarding, financial misconduct) for risk categorization and trend analysis."
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (e.g., open, under investigation, closed) for pipeline and aging analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the incident, used to prioritize response resources and escalation decisions."
    - name: "allegation_category"
      expr: allegation_category
      comment: "Category of allegation (e.g., corruption, abuse, misappropriation) for thematic risk analysis and policy response."
    - name: "reporting_channel"
      expr: reporting_channel
      comment: "Channel through which the incident was reported (e.g., hotline, manager, external), used to evaluate reporting culture effectiveness."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Flag indicating regulatory reporting is required, used to track regulatory obligation fulfillment for incidents."
    - name: "donor_notification_required_flag"
      expr: donor_notification_required_flag
      comment: "Flag indicating donor notification is required, critical for donor relationship and grant compliance management."
    - name: "public_disclosure_flag"
      expr: public_disclosure_flag
      comment: "Flag indicating the incident was publicly disclosed, relevant for reputational risk and communications tracking."
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year the incident occurred, enabling year-over-year trend analysis of incident frequency and financial impact."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month the incident occurred, used for monthly trend and seasonality analysis."
    - name: "triage_outcome"
      expr: triage_outcome
      comment: "Outcome of initial triage (e.g., substantiated, unsubstantiated, referred), used to measure investigation quality and intake efficiency."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of compliance and safeguarding incidents. Baseline volume metric for organizational risk exposure assessment."
    - name: "total_estimated_financial_impact_usd"
      expr: SUM(CAST(estimated_financial_impact_usd AS DOUBLE))
      comment: "Total estimated financial impact of all incidents in USD. A direct financial risk metric used by CFOs and boards to quantify organizational exposure."
    - name: "avg_financial_impact_per_incident_usd"
      expr: AVG(CAST(estimated_financial_impact_usd AS DOUBLE))
      comment: "Average estimated financial impact per incident. Benchmarks incident severity and informs risk reserve and insurance decisions."
    - name: "open_incidents_count"
      expr: COUNT(CASE WHEN incident_status = 'Open' THEN 1 END)
      comment: "Number of currently open incidents. Tracks active investigation backlog and organizational risk exposure at any point in time."
    - name: "high_severity_incidents_count"
      expr: COUNT(CASE WHEN severity_level = 'High' THEN 1 END)
      comment: "Number of high-severity incidents. A board-level risk metric that triggers executive review and potential donor escalation."
    - name: "regulatory_reporting_required_count"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 END)
      comment: "Number of incidents requiring regulatory reporting. Tracks regulatory obligation volume arising from incidents, critical for compliance officer oversight."
    - name: "donor_notification_required_count"
      expr: COUNT(CASE WHEN donor_notification_required_flag = TRUE THEN 1 END)
      comment: "Number of incidents requiring donor notification. Directly impacts donor relationships and grant continuity; a key accountability metric."
    - name: "financial_impact_on_open_incidents_usd"
      expr: SUM(CASE WHEN incident_status = 'Open' THEN CAST(estimated_financial_impact_usd AS DOUBLE) ELSE 0 END)
      comment: "Total estimated financial impact of unresolved incidents. Represents current unmitigated financial exposure for risk management reporting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over regulatory and donor compliance obligations. Tracks obligation status, overdue rates, single audit requirements, and IATI publication compliance to ensure the organization meets its legal and donor-mandated commitments."
  source: "`vibe_ngo_v1`.`compliance`.`obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of compliance obligation (e.g., regulatory filing, donor report, audit) for obligation portfolio analysis."
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the obligation (e.g., active, overdue, completed) for pipeline and risk tracking."
    - name: "frequency"
      expr: frequency
      comment: "Recurrence frequency of the obligation (e.g., annual, quarterly, monthly) for workload planning."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction governing the obligation, enabling country- and region-level compliance risk analysis."
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory or donor body that imposed the obligation, used for stakeholder-level compliance performance reporting."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the obligation (e.g., high, medium, low), used to prioritize compliance resources and escalation."
    - name: "responsible_unit"
      expr: responsible_unit
      comment: "Organizational unit accountable for fulfilling the obligation, enabling unit-level compliance accountability."
    - name: "single_audit_required"
      expr: single_audit_required
      comment: "Flag indicating a single audit is required for this obligation, used to track federal audit compliance obligations."
    - name: "iati_publication_required"
      expr: iati_publication_required
      comment: "Flag indicating IATI transparency publication is required, used to track international aid transparency compliance."
    - name: "fiscal_year_applicable"
      expr: fiscal_year_applicable
      comment: "Fiscal year to which the obligation applies, enabling year-over-year obligation volume and compliance rate analysis."
    - name: "next_due_month"
      expr: DATE_TRUNC('MONTH', next_due_date)
      comment: "Month the obligation is next due, used for forward-looking compliance calendar and capacity planning."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of active compliance obligations. Baseline metric for obligation portfolio size and compliance management scope."
    - name: "overdue_obligations_count"
      expr: COUNT(CASE WHEN obligation_status = 'Overdue' THEN 1 END)
      comment: "Number of obligations past their due date. A critical compliance risk metric that directly signals regulatory and donor penalty exposure."
    - name: "high_risk_obligations_count"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN 1 END)
      comment: "Number of obligations rated high risk. Prioritizes executive attention on obligations with the greatest potential penalty or reputational impact."
    - name: "single_audit_required_count"
      expr: COUNT(CASE WHEN single_audit_required = TRUE THEN 1 END)
      comment: "Number of obligations requiring a single audit. Tracks federal audit compliance scope and associated resource requirements."
    - name: "iati_publication_required_count"
      expr: COUNT(CASE WHEN iati_publication_required = TRUE THEN 1 END)
      comment: "Number of obligations requiring IATI publication. Tracks international transparency compliance obligations critical for donor trust and sector reputation."
    - name: "distinct_jurisdictions_count"
      expr: COUNT(DISTINCT jurisdiction)
      comment: "Number of distinct jurisdictions with active obligations. Measures regulatory complexity and geographic compliance footprint."
    - name: "distinct_governing_bodies_count"
      expr: COUNT(DISTINCT governing_body)
      comment: "Number of distinct governing bodies imposing obligations. Indicates stakeholder complexity and the breadth of regulatory relationships to manage."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_obligation_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over scheduled compliance obligation instances. Tracks on-time completion rates, escalation triggers, extension activity, penalty exposure, and effort efficiency to operationalize compliance calendar management."
  source: "`vibe_ngo_v1`.`compliance`.`obligation_schedule`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Completion status of the scheduled obligation instance (e.g., completed, overdue, in-progress) for pipeline tracking."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the scheduled obligation, used to triage and allocate compliance resources."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the scheduled obligation, enabling geographic compliance performance analysis."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the obligation schedule, used for framework-level compliance performance reporting."
    - name: "workflow_stage"
      expr: workflow_stage
      comment: "Current workflow stage of the obligation schedule (e.g., drafting, review, submitted), used for process bottleneck analysis."
    - name: "escalation_triggered_flag"
      expr: escalation_triggered_flag
      comment: "Flag indicating an escalation was triggered for this schedule instance, used to track escalation frequency and root causes."
    - name: "extension_granted_flag"
      expr: extension_granted_flag
      comment: "Flag indicating a deadline extension was granted, used to measure compliance flexibility utilization and planning quality."
    - name: "extension_requested_flag"
      expr: extension_requested_flag
      comment: "Flag indicating a deadline extension was requested, a leading indicator of capacity constraints and planning gaps."
    - name: "recurrence_pattern"
      expr: recurrence_pattern
      comment: "Recurrence pattern of the obligation (e.g., monthly, quarterly, annual), used for workload forecasting."
    - name: "planned_due_month"
      expr: DATE_TRUNC('MONTH', planned_due_date)
      comment: "Month the obligation was originally planned to be due, used for compliance calendar and capacity planning."
  measures:
    - name: "total_scheduled_obligations"
      expr: COUNT(1)
      comment: "Total number of scheduled obligation instances. Baseline metric for compliance calendar volume and operational workload."
    - name: "escalated_obligations_count"
      expr: COUNT(CASE WHEN escalation_triggered_flag = TRUE THEN 1 END)
      comment: "Number of obligation schedule instances that triggered an escalation. Tracks compliance stress points and systemic capacity issues."
    - name: "extensions_granted_count"
      expr: COUNT(CASE WHEN extension_granted_flag = TRUE THEN 1 END)
      comment: "Number of schedule instances where a deadline extension was granted. Measures compliance flexibility utilization and planning quality."
    - name: "total_penalty_amount_usd"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount accrued across obligation schedule instances. A direct financial risk metric for compliance cost management and regulatory relationship health."
    - name: "avg_penalty_per_instance"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per obligation schedule instance. Benchmarks the financial cost of non-compliance and informs risk-based prioritization."
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total actual staff hours spent on scheduled compliance obligations. Key input for capacity planning and compliance cost allocation."
    - name: "effort_variance_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE) - CAST(estimated_effort_hours AS DOUBLE))
      comment: "Total effort variance (actual minus estimated hours) across scheduled obligations. Positive values indicate systematic underestimation, informing future planning accuracy."
    - name: "overdue_instances_count"
      expr: COUNT(CASE WHEN completion_status = 'Overdue' THEN 1 END)
      comment: "Number of obligation schedule instances that are overdue. A real-time compliance risk indicator for operational dashboards and leadership escalation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over regulatory filings submitted by the organization. Tracks filing timeliness, rejection rates, fee expenditure, extension activity, and resubmission burden to manage regulatory relationships and compliance costs."
  source: "`vibe_ngo_v1`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the regulatory filing (e.g., submitted, accepted, rejected, pending) for pipeline and quality analysis."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel used to submit the filing (e.g., online portal, mail, in-person), used for process efficiency and channel optimization."
    - name: "amendment_flag"
      expr: amendment_flag
      comment: "Flag indicating the filing is an amendment to a prior submission, used to track amendment frequency and data quality issues."
    - name: "extension_granted_flag"
      expr: extension_granted_flag
      comment: "Flag indicating a filing deadline extension was granted, used to measure regulatory flexibility utilization."
    - name: "extension_requested_flag"
      expr: extension_requested_flag
      comment: "Flag indicating a filing deadline extension was requested, a leading indicator of capacity constraints."
    - name: "public_disclosure_flag"
      expr: public_disclosure_flag
      comment: "Flag indicating the filing is publicly disclosed, relevant for transparency and reputational risk tracking."
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Reason code for filing rejection, used to identify systemic data quality or process issues driving rejections."
    - name: "preparer_organization"
      expr: preparer_organization
      comment: "Organization that prepared the filing (internal team or external firm), used for vendor performance and cost analysis."
    - name: "filing_period_year"
      expr: YEAR(filing_period_start_date)
      comment: "Year of the filing period, enabling year-over-year regulatory filing volume and compliance rate analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the filing was submitted, used for temporal trend analysis of filing activity and deadline clustering."
  measures:
    - name: "total_regulatory_filings"
      expr: COUNT(1)
      comment: "Total number of regulatory filings. Baseline metric for regulatory compliance workload and filing portfolio size."
    - name: "rejected_filings_count"
      expr: COUNT(CASE WHEN filing_status = 'Rejected' THEN 1 END)
      comment: "Number of filings rejected by the regulatory authority. A quality metric that signals data accuracy issues and risks regulatory relationship damage."
    - name: "accepted_filings_count"
      expr: COUNT(CASE WHEN filing_status = 'Accepted' THEN 1 END)
      comment: "Number of filings accepted by the regulatory authority. Tracks successful compliance fulfillment rate."
    - name: "total_filing_fee_usd"
      expr: SUM(CAST(filing_fee_amount AS DOUBLE))
      comment: "Total filing fees paid across all regulatory filings. A direct compliance cost metric for budget management and cost reduction initiatives."
    - name: "avg_filing_fee_usd"
      expr: AVG(CAST(filing_fee_amount AS DOUBLE))
      comment: "Average filing fee per regulatory filing. Benchmarks compliance cost efficiency and informs fee negotiation or process optimization."
    - name: "extensions_granted_count"
      expr: COUNT(CASE WHEN extension_granted_flag = TRUE THEN 1 END)
      comment: "Number of filings for which a deadline extension was granted. Tracks regulatory flexibility utilization and planning quality."
    - name: "amendment_filings_count"
      expr: COUNT(CASE WHEN amendment_flag = TRUE THEN 1 END)
      comment: "Number of amendment filings submitted. High amendment rates signal data quality or process issues in the original filing workflow."
    - name: "total_filing_fee_on_rejected"
      expr: SUM(CASE WHEN filing_status = 'Rejected' THEN CAST(filing_fee_amount AS DOUBLE) ELSE 0 END)
      comment: "Total filing fees paid on subsequently rejected filings. Quantifies the direct financial waste from filing quality failures."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_sanctions_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over sanctions screening activities. Tracks match rates, false positive rates, risk ratings, and rescreening obligations to ensure the organization meets counter-terrorism financing and anti-money laundering compliance requirements."
  source: "`vibe_ngo_v1`.`compliance`.`sanctions_screening`"
  dimensions:
    - name: "screening_status"
      expr: screening_status
      comment: "Current status of the screening (e.g., clear, match, pending review) for pipeline and risk analysis."
    - name: "match_result"
      expr: match_result
      comment: "Result of the sanctions match check (e.g., no match, potential match, confirmed match), the primary risk signal from screening."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the screened subject (e.g., high, medium, low), used for risk-based due diligence prioritization."
    - name: "subject_type"
      expr: subject_type
      comment: "Type of entity screened (e.g., individual, organization, vendor), used to analyze screening coverage by counterparty type."
    - name: "subject_nationality"
      expr: subject_nationality
      comment: "Nationality of the screened subject, used for geographic risk concentration analysis."
    - name: "screening_method"
      expr: screening_method
      comment: "Method used for screening (e.g., automated, manual), used to assess screening process quality and efficiency."
    - name: "screening_tool"
      expr: screening_tool
      comment: "Tool or system used for screening, used for vendor performance and tool effectiveness analysis."
    - name: "false_positive_flag"
      expr: false_positive_flag
      comment: "Flag indicating the match was a false positive, used to measure screening precision and tool calibration quality."
    - name: "rescreening_required_flag"
      expr: rescreening_required_flag
      comment: "Flag indicating rescreening is required, used to track ongoing due diligence obligations."
    - name: "sanctions_list_checked"
      expr: sanctions_list_checked
      comment: "Sanctions list(s) checked during screening (e.g., OFAC, UN, EU), used to verify screening coverage and regulatory completeness."
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_date)
      comment: "Month the screening was conducted, used for temporal trend analysis of screening volume and match rates."
  measures:
    - name: "total_screenings"
      expr: COUNT(1)
      comment: "Total number of sanctions screenings conducted. Baseline metric for due diligence coverage and compliance program activity."
    - name: "potential_match_count"
      expr: COUNT(CASE WHEN match_result = 'Potential Match' THEN 1 END)
      comment: "Number of screenings resulting in a potential sanctions match. A critical risk metric requiring immediate investigation and possible transaction blocking."
    - name: "confirmed_match_count"
      expr: COUNT(CASE WHEN match_result = 'Confirmed Match' THEN 1 END)
      comment: "Number of screenings with a confirmed sanctions match. The highest-severity compliance risk signal, triggering mandatory regulatory reporting and relationship termination."
    - name: "false_positive_count"
      expr: COUNT(CASE WHEN false_positive_flag = TRUE THEN 1 END)
      comment: "Number of false positive matches identified. High false positive rates indicate poor tool calibration, wasting investigator time and delaying legitimate transactions."
    - name: "high_risk_subjects_count"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN 1 END)
      comment: "Number of screened subjects rated high risk. Drives enhanced due diligence requirements and senior management review obligations."
    - name: "rescreening_required_count"
      expr: COUNT(CASE WHEN rescreening_required_flag = TRUE THEN 1 END)
      comment: "Number of subjects requiring periodic rescreening. Tracks ongoing due diligence obligations and forward-looking compliance workload."
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match score across all screenings. Indicates the overall quality and precision of the screening tool; lower average scores on non-matches suggest good calibration."
    - name: "distinct_subjects_screened"
      expr: COUNT(DISTINCT subject_identifier)
      comment: "Number of distinct subjects screened. Measures the breadth of due diligence coverage across the organization's counterparty universe."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_single_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over single audits (OMB Uniform Guidance A-133 equivalent). Tracks federal expenditure under audit, questioned costs, material weakness identification, audit opinion quality, and corrective action plan submission rates to manage federal compliance risk."
  source: "`vibe_ngo_v1`.`compliance`.`single_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the single audit (e.g., in-progress, completed, submitted to FAC) for pipeline tracking."
    - name: "compliance_opinion_type"
      expr: compliance_opinion_type
      comment: "Type of compliance opinion issued by the auditor (e.g., unmodified, qualified, adverse), a key governance quality signal."
    - name: "financial_statement_opinion_type"
      expr: financial_statement_opinion_type
      comment: "Type of financial statement opinion (e.g., unmodified, qualified, adverse, disclaimer), critical for donor and regulatory confidence."
    - name: "internal_control_opinion_type"
      expr: internal_control_opinion_type
      comment: "Type of internal control opinion issued, used to assess the strength of the organization's control environment."
    - name: "auditor_firm_name"
      expr: auditor_firm_name
      comment: "Name of the audit firm, used for auditor performance benchmarking and independence monitoring."
    - name: "material_weakness_identified_flag"
      expr: material_weakness_identified_flag
      comment: "Flag indicating a material weakness was identified in the audit, a board-level governance risk signal."
    - name: "significant_deficiency_identified_flag"
      expr: significant_deficiency_identified_flag
      comment: "Flag indicating a significant deficiency was identified, used alongside material weakness for control quality analysis."
    - name: "going_concern_issue_flag"
      expr: going_concern_issue_flag
      comment: "Flag indicating a going concern issue was raised, the most severe financial health signal in an audit."
    - name: "low_risk_auditee_flag"
      expr: low_risk_auditee_flag
      comment: "Flag indicating the organization qualifies as a low-risk auditee, enabling reduced audit scope and cost."
    - name: "corrective_action_plan_submitted_flag"
      expr: corrective_action_plan_submitted_flag
      comment: "Flag indicating a corrective action plan was submitted with the audit, used to track remediation responsiveness."
    - name: "audit_year"
      expr: audit_year
      comment: "Fiscal year of the single audit, enabling year-over-year audit quality and cost trend analysis."
    - name: "audit_period_year"
      expr: YEAR(audit_period_start_date)
      comment: "Year derived from audit period start date for temporal cohort analysis."
  measures:
    - name: "total_single_audits"
      expr: COUNT(1)
      comment: "Total number of single audits. Baseline metric for federal audit compliance scope and program coverage."
    - name: "total_federal_expenditure_usd"
      expr: SUM(CAST(federal_expenditure_amount AS DOUBLE))
      comment: "Total federal expenditure covered by single audits. The primary financial scope metric for federal compliance reporting and threshold monitoring."
    - name: "total_questioned_cost_usd"
      expr: SUM(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Total questioned costs identified across single audits. Represents potential fund recovery exposure and is a key federal compliance risk metric."
    - name: "avg_questioned_cost_per_audit"
      expr: AVG(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Average questioned cost per single audit. Benchmarks audit quality and the typical financial risk per audit engagement."
    - name: "total_audit_cost_usd"
      expr: SUM(CAST(audit_cost_amount AS DOUBLE))
      comment: "Total cost incurred for single audit engagements. A direct compliance cost metric for budget management and auditor fee benchmarking."
    - name: "avg_audit_cost_usd"
      expr: AVG(CAST(audit_cost_amount AS DOUBLE))
      comment: "Average cost per single audit engagement. Used to benchmark auditor fees and identify cost optimization opportunities."
    - name: "material_weakness_audits_count"
      expr: COUNT(CASE WHEN material_weakness_identified_flag = TRUE THEN 1 END)
      comment: "Number of audits where a material weakness was identified. A board-level governance metric directly tied to federal funding risk and donor confidence."
    - name: "going_concern_audits_count"
      expr: COUNT(CASE WHEN going_concern_issue_flag = TRUE THEN 1 END)
      comment: "Number of audits with a going concern issue raised. The most severe financial health signal; triggers immediate executive and board action."
    - name: "cap_submitted_audits_count"
      expr: COUNT(CASE WHEN corrective_action_plan_submitted_flag = TRUE THEN 1 END)
      comment: "Number of audits for which a corrective action plan was submitted. Tracks remediation responsiveness and federal reporting compliance."
    - name: "low_risk_auditee_count"
      expr: COUNT(CASE WHEN low_risk_auditee_flag = TRUE THEN 1 END)
      comment: "Number of audits where the organization qualified as a low-risk auditee. Tracks the organization's track record of clean audits, which reduces future audit scope and cost."
$$;