-- Metric views for domain: compliance | Business: Ngo | Version: 1 | Generated on: 2026-05-07 03:19:07

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over audit findings to track financial exposure from questioned costs, repeat findings, material weaknesses, and resolution timeliness — enabling leadership to assess audit risk posture and corrective action effectiveness."
  source: "`ngo_ecm`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Category of audit finding (e.g., internal control, compliance, financial) used to segment risk exposure by type."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the finding (e.g., critical, high, medium, low) for risk prioritization."
    - name: "finding_status"
      expr: finding_status
      comment: "Current resolution status of the finding (e.g., open, resolved, in-progress) to track remediation pipeline."
    - name: "compliance_requirement_type"
      expr: compliance_requirement_type
      comment: "Type of compliance requirement the finding relates to, enabling analysis by regulatory or donor obligation category."
    - name: "federal_agency_name"
      expr: federal_agency_name
      comment: "Federal agency associated with the award under audit, supporting agency-level risk reporting."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category assigned to the finding for portfolio-level risk aggregation."
    - name: "is_repeat_finding"
      expr: is_repeat_finding
      comment: "Flag indicating whether the finding recurred from a prior audit period, a key indicator of systemic control failure."
    - name: "is_material_weakness"
      expr: is_material_weakness
      comment: "Flag indicating a material weakness in internal controls, a critical governance signal."
    - name: "audit_period_year"
      expr: YEAR(audit_period_start_date)
      comment: "Year of the audit period start date for trend analysis across fiscal years."
    - name: "auditor_name"
      expr: auditor_name
      comment: "Name of the auditing firm or individual, enabling auditor-level performance and finding pattern analysis."
  measures:
    - name: "total_questioned_cost_usd"
      expr: SUM(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Total dollar value of costs questioned by auditors. A primary financial risk indicator — high values signal potential clawback exposure and donor trust risk."
    - name: "avg_questioned_cost_per_finding"
      expr: AVG(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Average questioned cost per audit finding. Helps leadership assess whether financial exposure is concentrated in a few large findings or broadly distributed."
    - name: "total_open_findings"
      expr: COUNT(CASE WHEN finding_status = 'Open' THEN audit_finding_id END)
      comment: "Count of unresolved audit findings. A direct measure of outstanding compliance risk requiring corrective action."
    - name: "repeat_finding_count"
      expr: COUNT(CASE WHEN is_repeat_finding = TRUE THEN audit_finding_id END)
      comment: "Number of findings that recurred from prior audit periods. Repeat findings indicate systemic control failures and are a red flag for donors and regulators."
    - name: "material_weakness_count"
      expr: COUNT(CASE WHEN is_material_weakness = TRUE THEN audit_finding_id END)
      comment: "Count of findings classified as material weaknesses. Material weaknesses can jeopardize federal funding eligibility and trigger mandatory donor notifications."
    - name: "fraud_indicator_count"
      expr: COUNT(CASE WHEN is_fraud_indicator = TRUE THEN audit_finding_id END)
      comment: "Number of findings with a fraud indicator flag. Fraud-related findings carry the highest reputational and legal risk for the organization."
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(actual_resolution_date, finding_identified_date))
      comment: "Average number of days from finding identification to actual resolution. Measures corrective action speed — a key operational efficiency and donor accountability KPI."
    - name: "overdue_finding_count"
      expr: COUNT(CASE WHEN finding_status != 'Resolved' AND expected_resolution_date < CURRENT_DATE() THEN audit_finding_id END)
      comment: "Count of findings past their expected resolution date that remain unresolved. Directly signals compliance program execution risk."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`compliance_corrective_action_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs tracking corrective action plan (CAP) execution, cost efficiency, and timeliness — enabling leadership to assess whether the organization is effectively remediating compliance deficiencies identified through audits and reviews."
  source: "`ngo_ecm`.`compliance`.`corrective_action_plan`"
  dimensions:
    - name: "cap_status"
      expr: cap_status
      comment: "Current status of the corrective action plan (e.g., open, in-progress, completed, overdue) for pipeline management."
    - name: "finding_type"
      expr: finding_type
      comment: "Type of finding that triggered the CAP, enabling analysis of remediation effort by finding category."
    - name: "finding_severity"
      expr: finding_severity
      comment: "Severity of the underlying finding driving the CAP, used to prioritize high-risk remediation efforts."
    - name: "recurrence_risk"
      expr: recurrence_risk
      comment: "Assessed risk that the finding will recur after CAP completion — a forward-looking risk indicator."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for executing the CAP, enabling accountability and workload analysis by unit."
    - name: "donor_notification_required"
      expr: donor_notification_required
      comment: "Flag indicating whether the donor must be notified of the corrective action, relevant for donor relationship management."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Flag indicating whether the CAP requires escalation to senior leadership or external parties."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of CAP cost figures, required for multi-currency cost analysis."
    - name: "target_completion_year"
      expr: YEAR(target_completion_date)
      comment: "Year of the CAP target completion date for annual remediation planning and tracking."
  measures:
    - name: "total_actual_cap_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred to execute corrective action plans. Tracks the financial burden of compliance remediation across the portfolio."
    - name: "total_estimated_cap_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of corrective action plans. Used alongside actual cost to assess budget accuracy and remediation planning quality."
    - name: "avg_actual_cap_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action plan. Benchmarks remediation cost efficiency across departments and finding types."
    - name: "open_cap_count"
      expr: COUNT(CASE WHEN cap_status NOT IN ('Completed', 'Closed') THEN corrective_action_plan_id END)
      comment: "Number of corrective action plans currently open or in-progress. Represents the active remediation backlog and outstanding compliance risk."
    - name: "overdue_cap_count"
      expr: COUNT(CASE WHEN cap_status NOT IN ('Completed', 'Closed') AND target_completion_date < CURRENT_DATE() THEN corrective_action_plan_id END)
      comment: "Count of CAPs that have passed their target completion date without being closed. Overdue CAPs signal execution risk and potential donor/regulator escalation."
    - name: "avg_days_to_cap_completion"
      expr: AVG(DATEDIFF(actual_completion_date, created_timestamp))
      comment: "Average number of days from CAP creation to actual completion. Measures the speed of the organization's compliance remediation cycle."
    - name: "escalation_required_count"
      expr: COUNT(CASE WHEN escalation_required = TRUE THEN corrective_action_plan_id END)
      comment: "Number of CAPs requiring escalation. High escalation counts indicate systemic issues that cannot be resolved at the operational level."
    - name: "donor_notification_required_count"
      expr: COUNT(CASE WHEN donor_notification_required = TRUE THEN corrective_action_plan_id END)
      comment: "Count of CAPs requiring donor notification. Tracks donor relationship risk exposure from compliance failures."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`compliance_donor_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring compliance with donor-imposed requirements — tracking adherence rates, effort investment, overdue obligations, and waiver activity to protect grant funding and donor relationships."
  source: "`ngo_ecm`.`compliance`.`donor_requirement`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the donor requirement (e.g., compliant, non-compliant, pending) for portfolio health assessment."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the requirement, enabling focus on high-priority donor obligations."
    - name: "non_compliance_risk_level"
      expr: non_compliance_risk_level
      comment: "Risk level associated with non-compliance, used to triage and escalate high-risk gaps."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit deliverables to the donor (e.g., email, portal, mail) for process efficiency analysis."
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Indicates whether a waiver was granted for the requirement, tracking donor flexibility and exception management."
    - name: "waiver_requested_flag"
      expr: waiver_requested_flag
      comment: "Indicates whether a waiver was requested, signaling capacity or feasibility constraints in meeting donor requirements."
    - name: "due_date_year"
      expr: YEAR(due_date)
      comment: "Year of the requirement due date for annual compliance planning and trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month of the requirement due date for monthly compliance calendar management."
  measures:
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total staff hours actually invested in fulfilling donor requirements. Measures the true operational cost of donor compliance across the portfolio."
    - name: "total_estimated_effort_hours"
      expr: SUM(CAST(estimated_effort_hours AS DOUBLE))
      comment: "Total estimated staff hours for donor requirements. Used with actual hours to assess planning accuracy and resource allocation."
    - name: "avg_actual_effort_hours"
      expr: AVG(CAST(actual_effort_hours AS DOUBLE))
      comment: "Average actual effort hours per donor requirement. Benchmarks compliance workload per obligation for staffing decisions."
    - name: "non_compliant_requirement_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN donor_requirement_id END)
      comment: "Count of donor requirements currently in non-compliant status. Non-compliance can trigger grant suspension or clawback — a critical funding risk indicator."
    - name: "overdue_requirement_count"
      expr: COUNT(CASE WHEN compliance_status != 'Compliant' AND due_date < CURRENT_DATE() THEN donor_requirement_id END)
      comment: "Count of requirements past their due date without achieving compliant status. Directly measures donor obligation execution risk."
    - name: "waiver_grant_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_granted_flag = TRUE THEN donor_requirement_id END) / NULLIF(COUNT(CASE WHEN waiver_requested_flag = TRUE THEN donor_requirement_id END), 0), 2)
      comment: "Percentage of waiver requests that were granted by donors. Indicates donor flexibility and the organization's ability to negotiate compliance exceptions."
    - name: "high_risk_non_compliance_count"
      expr: COUNT(CASE WHEN non_compliance_risk_level IN ('High', 'Critical') AND compliance_status != 'Compliant' THEN donor_requirement_id END)
      comment: "Count of non-compliant requirements with high or critical risk ratings. These represent the most urgent funding and relationship risks requiring immediate leadership attention."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`compliance_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over compliance incidents — tracking financial impact, investigation throughput, severity distribution, and resolution timeliness to enable leadership to manage organizational risk, donor trust, and regulatory exposure."
  source: "`ngo_ecm`.`compliance`.`incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of compliance incident (e.g., fraud, safeguarding, financial mismanagement) for risk categorization and trend analysis."
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (e.g., open, under investigation, resolved) for pipeline and backlog management."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the incident, used to prioritize response resources and escalation decisions."
    - name: "allegation_category"
      expr: allegation_category
      comment: "Category of allegation (e.g., corruption, abuse, misuse of funds) for thematic risk analysis."
    - name: "reporting_channel"
      expr: reporting_channel
      comment: "Channel through which the incident was reported (e.g., hotline, manager, external) to assess reporting culture effectiveness."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Flag indicating whether the incident requires regulatory reporting, tracking mandatory disclosure obligations."
    - name: "donor_notification_required_flag"
      expr: donor_notification_required_flag
      comment: "Flag indicating whether the donor must be notified of the incident, relevant for grant compliance and relationship management."
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year the incident occurred for annual trend analysis and year-over-year comparison."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month the incident occurred for monthly incident volume and trend monitoring."
    - name: "triage_outcome"
      expr: triage_outcome
      comment: "Outcome of the initial triage assessment, indicating whether the incident was substantiated, unsubstantiated, or referred."
  measures:
    - name: "total_estimated_financial_impact_usd"
      expr: SUM(CAST(estimated_financial_impact_usd AS DOUBLE))
      comment: "Total estimated financial impact of all compliance incidents in USD. The primary financial risk KPI for the incident portfolio — directly informs reserve and recovery planning."
    - name: "avg_estimated_financial_impact_usd"
      expr: AVG(CAST(estimated_financial_impact_usd AS DOUBLE))
      comment: "Average estimated financial impact per incident. Benchmarks incident severity and helps calibrate risk reserves and insurance coverage."
    - name: "open_incident_count"
      expr: COUNT(CASE WHEN incident_status NOT IN ('Resolved', 'Closed') THEN incident_id END)
      comment: "Number of incidents currently open or under investigation. Represents the active risk backlog requiring management attention and resources."
    - name: "high_severity_incident_count"
      expr: COUNT(CASE WHEN severity_level IN ('High', 'Critical') THEN incident_id END)
      comment: "Count of high or critical severity incidents. These carry the greatest reputational, legal, and financial risk and require board-level visibility."
    - name: "avg_days_to_investigation_completion"
      expr: AVG(DATEDIFF(investigation_completion_date, investigation_start_date))
      comment: "Average number of days to complete an investigation from start to finish. Measures investigation efficiency — slow investigations increase legal exposure and donor concern."
    - name: "avg_days_to_incident_resolution"
      expr: AVG(DATEDIFF(resolution_date, reported_date))
      comment: "Average days from incident report to full resolution. A key accountability metric — donors and regulators expect timely resolution of compliance incidents."
    - name: "regulatory_reporting_required_count"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN incident_id END)
      comment: "Count of incidents requiring mandatory regulatory reporting. Tracks the organization's regulatory disclosure obligation volume and associated compliance risk."
    - name: "donor_notification_required_count"
      expr: COUNT(CASE WHEN donor_notification_required_flag = TRUE THEN incident_id END)
      comment: "Count of incidents requiring donor notification. High counts signal elevated donor relationship risk and potential grant compliance consequences."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`compliance_internal_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring the effectiveness and outcomes of internal compliance reviews — tracking risk scores, finding severity distribution, corrective action triggers, and review cycle timeliness to steer the internal audit program."
  source: "`ngo_ecm`.`compliance`.`internal_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of internal review (e.g., financial, programmatic, safeguarding) for analysis by review category."
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review (e.g., planned, in-progress, completed) for pipeline management."
    - name: "overall_compliance_rating"
      expr: overall_compliance_rating
      comment: "Overall compliance rating assigned at review conclusion (e.g., satisfactory, needs improvement, unsatisfactory) — the primary quality signal from each review."
    - name: "review_methodology"
      expr: review_methodology
      comment: "Methodology used in the review (e.g., sampling, full population, risk-based) for quality and comparability analysis."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Flag indicating whether the review resulted in a mandatory corrective action plan, a key outcome indicator."
    - name: "follow_up_review_required_flag"
      expr: follow_up_review_required_flag
      comment: "Flag indicating whether a follow-up review was required, signaling unresolved compliance concerns."
    - name: "donor_notification_required_flag"
      expr: donor_notification_required_flag
      comment: "Flag indicating whether the review findings require donor notification."
    - name: "review_start_year"
      expr: YEAR(review_start_date)
      comment: "Year the review commenced for annual review program planning and trend analysis."
    - name: "review_period_year"
      expr: YEAR(review_period_start_date)
      comment: "Year of the review period being assessed, enabling analysis of compliance posture by program year."
  measures:
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across internal reviews. The primary portfolio-level risk indicator from the internal review program — drives resource allocation for follow-up reviews."
    - name: "max_risk_score"
      expr: MAX(CAST(risk_score AS DOUBLE))
      comment: "Maximum risk score observed across reviews. Identifies the highest-risk entities or programs requiring immediate leadership attention."
    - name: "total_risk_score"
      expr: SUM(CAST(risk_score AS DOUBLE))
      comment: "Aggregate risk score across all reviews. Used to track overall compliance risk exposure trend over time."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN internal_review_id END)
      comment: "Number of reviews that resulted in a mandatory corrective action plan. Measures the rate at which reviews identify actionable compliance deficiencies."
    - name: "unsatisfactory_rating_count"
      expr: COUNT(CASE WHEN overall_compliance_rating IN ('Unsatisfactory', 'Needs Improvement') THEN internal_review_id END)
      comment: "Count of reviews with unsatisfactory or needs-improvement ratings. A direct measure of compliance program health — high counts signal systemic weaknesses."
    - name: "avg_days_review_cycle"
      expr: AVG(DATEDIFF(review_end_date, review_start_date))
      comment: "Average number of days to complete an internal review from start to finish. Measures review program efficiency and capacity utilization."
    - name: "follow_up_review_required_count"
      expr: COUNT(CASE WHEN follow_up_review_required_flag = TRUE THEN internal_review_id END)
      comment: "Count of reviews requiring a follow-up review. Indicates the volume of unresolved compliance issues that need re-examination, driving future review program workload."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs tracking regulatory filing compliance — measuring on-time submission rates, filing fee expenditure, rejection rates, and extension usage to ensure the organization meets its statutory reporting obligations and avoids penalties."
  source: "`ngo_ecm`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the regulatory filing (e.g., submitted, accepted, rejected, pending) for compliance pipeline management."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel used to submit the filing (e.g., online portal, mail, in-person) for process efficiency analysis."
    - name: "amendment_flag"
      expr: amendment_flag
      comment: "Indicates whether the filing is an amendment to a prior submission, tracking correction activity."
    - name: "extension_granted_flag"
      expr: extension_granted_flag
      comment: "Indicates whether a filing extension was granted, tracking the organization's use of deadline extensions."
    - name: "extension_requested_flag"
      expr: extension_requested_flag
      comment: "Indicates whether an extension was requested, signaling capacity constraints in meeting filing deadlines."
    - name: "public_disclosure_flag"
      expr: public_disclosure_flag
      comment: "Indicates whether the filing is subject to public disclosure requirements."
    - name: "filing_fee_currency_code"
      expr: filing_fee_currency_code
      comment: "Currency of the filing fee for multi-currency cost analysis."
    - name: "filing_period_year"
      expr: YEAR(filing_period_start_date)
      comment: "Year of the filing period for annual regulatory compliance trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month of the filing due date for monthly compliance calendar management and deadline clustering analysis."
  measures:
    - name: "total_filing_fee_amount"
      expr: SUM(CAST(filing_fee_amount AS DOUBLE))
      comment: "Total filing fees paid across all regulatory filings. Tracks the direct financial cost of regulatory compliance obligations."
    - name: "avg_filing_fee_amount"
      expr: AVG(CAST(filing_fee_amount AS DOUBLE))
      comment: "Average filing fee per regulatory submission. Benchmarks per-filing compliance cost for budget planning."
    - name: "on_time_filing_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_date <= due_date AND filing_status IN ('Submitted', 'Accepted') THEN regulatory_filing_id END) / NULLIF(COUNT(regulatory_filing_id), 0), 2)
      comment: "Percentage of regulatory filings submitted on or before the due date. The primary timeliness KPI for regulatory compliance — late filings trigger penalties and reputational risk."
    - name: "rejection_count"
      expr: COUNT(CASE WHEN filing_status = 'Rejected' THEN regulatory_filing_id END)
      comment: "Number of regulatory filings rejected by the regulatory authority. Rejections require resubmission and signal quality control issues in the filing process."
    - name: "extension_grant_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN extension_granted_flag = TRUE THEN regulatory_filing_id END) / NULLIF(COUNT(CASE WHEN extension_requested_flag = TRUE THEN regulatory_filing_id END), 0), 2)
      comment: "Percentage of extension requests that were granted. Indicates regulatory authority flexibility and the organization's track record in obtaining deadline relief."
    - name: "avg_days_submission_to_acceptance"
      expr: AVG(DATEDIFF(acceptance_date, submission_date))
      comment: "Average days from filing submission to regulatory acceptance. Measures regulatory processing efficiency and helps forecast compliance closure timelines."
    - name: "overdue_filing_count"
      expr: COUNT(CASE WHEN filing_status NOT IN ('Accepted', 'Closed') AND due_date < CURRENT_DATE() THEN regulatory_filing_id END)
      comment: "Count of filings past their due date (or extended due date) that have not been accepted. Directly measures outstanding regulatory penalty risk."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`compliance_sanctions_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring the effectiveness and coverage of the sanctions screening program — tracking match rates, false positive rates, risk ratings, and rescreening compliance to protect the organization from prohibited party transactions."
  source: "`ngo_ecm`.`compliance`.`sanctions_screening`"
  dimensions:
    - name: "screening_status"
      expr: screening_status
      comment: "Current status of the screening record (e.g., clear, match, pending review) for compliance pipeline management."
    - name: "match_result"
      expr: match_result
      comment: "Result of the sanctions screening match (e.g., no match, potential match, confirmed match) — the primary outcome dimension."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the screened subject, used to prioritize enhanced due diligence and monitoring."
    - name: "subject_type"
      expr: subject_type
      comment: "Type of entity screened (e.g., individual, organization, vendor, partner) for screening coverage analysis."
    - name: "subject_nationality"
      expr: subject_nationality
      comment: "Nationality of the screened subject for geographic risk analysis and sanctions list relevance."
    - name: "screening_method"
      expr: screening_method
      comment: "Method used for screening (e.g., automated, manual) for process quality and efficiency analysis."
    - name: "screening_tool"
      expr: screening_tool
      comment: "Tool or system used to conduct the screening, enabling vendor performance and coverage comparison."
    - name: "rescreening_required_flag"
      expr: rescreening_required_flag
      comment: "Flag indicating whether periodic rescreening is required for the subject, tracking ongoing monitoring obligations."
    - name: "false_positive_flag"
      expr: false_positive_flag
      comment: "Flag indicating the match was determined to be a false positive, used to assess screening tool precision."
    - name: "screening_year"
      expr: YEAR(screening_date)
      comment: "Year of the screening event for annual screening volume and trend analysis."
  measures:
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match score across all screening records. Higher average scores indicate more frequent high-confidence potential matches requiring review resources."
    - name: "max_match_score"
      expr: MAX(CAST(match_score AS DOUBLE))
      comment: "Maximum match score observed. Identifies the highest-risk screening result in the portfolio for immediate escalation."
    - name: "confirmed_match_count"
      expr: COUNT(CASE WHEN match_result = 'Confirmed Match' THEN sanctions_screening_id END)
      comment: "Number of screenings resulting in a confirmed sanctions match. Each confirmed match represents a potential prohibited party transaction requiring immediate action and regulatory reporting."
    - name: "false_positive_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN false_positive_flag = TRUE THEN sanctions_screening_id END) / NULLIF(COUNT(CASE WHEN match_result != 'No Match' THEN sanctions_screening_id END), 0), 2)
      comment: "Percentage of non-clear screening results that were determined to be false positives. High false positive rates indicate screening tool calibration issues that waste review resources."
    - name: "overdue_rescreening_count"
      expr: COUNT(CASE WHEN rescreening_required_flag = TRUE AND next_screening_due_date < CURRENT_DATE() THEN sanctions_screening_id END)
      comment: "Count of subjects due for rescreening whose next screening date has passed. Overdue rescreenings represent gaps in ongoing monitoring obligations and donor compliance requirements."
    - name: "high_risk_subject_count"
      expr: COUNT(CASE WHEN risk_rating IN ('High', 'Critical') THEN sanctions_screening_id END)
      comment: "Count of screened subjects classified as high or critical risk. Drives enhanced due diligence workload and informs partner/vendor risk management decisions."
    - name: "pending_resolution_count"
      expr: COUNT(CASE WHEN screening_status NOT IN ('Clear', 'Resolved', 'Closed') THEN sanctions_screening_id END)
      comment: "Count of screening records with unresolved match results. Represents the active sanctions review backlog requiring compliance team attention."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`compliance_single_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for the Single Audit program — tracking federal expenditure under audit, questioned costs, material weakness rates, and audit opinion quality to ensure compliance with Uniform Guidance (2 CFR Part 200) and protect federal funding eligibility."
  source: "`ngo_ecm`.`compliance`.`single_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the single audit (e.g., in-progress, completed, submitted to FAC) for program management."
    - name: "compliance_opinion_type"
      expr: compliance_opinion_type
      comment: "Type of compliance opinion issued by the auditor (e.g., unmodified, qualified, adverse) — the primary quality signal from each single audit."
    - name: "financial_statement_opinion_type"
      expr: financial_statement_opinion_type
      comment: "Type of financial statement opinion issued, indicating the reliability of the organization's financial reporting."
    - name: "internal_control_opinion_type"
      expr: internal_control_opinion_type
      comment: "Type of internal control opinion, indicating the strength of the organization's control environment."
    - name: "material_weakness_identified_flag"
      expr: material_weakness_identified_flag
      comment: "Flag indicating whether a material weakness was identified in the audit, a critical federal funding risk signal."
    - name: "going_concern_issue_flag"
      expr: going_concern_issue_flag
      comment: "Flag indicating a going concern issue was raised, the most severe organizational risk signal from an audit."
    - name: "low_risk_auditee_flag"
      expr: low_risk_auditee_flag
      comment: "Flag indicating the organization qualifies as a low-risk auditee under Uniform Guidance, enabling reduced audit scope."
    - name: "corrective_action_plan_submitted_flag"
      expr: corrective_action_plan_submitted_flag
      comment: "Flag indicating whether a corrective action plan was submitted with the audit, required when findings are identified."
    - name: "audit_year"
      expr: audit_year
      comment: "Fiscal year of the single audit for year-over-year trend analysis of federal compliance posture."
    - name: "auditor_firm_name"
      expr: auditor_firm_name
      comment: "Name of the auditing firm for auditor performance and independence analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of financial amounts in the audit for multi-currency reporting."
  measures:
    - name: "total_federal_expenditure_amount"
      expr: SUM(CAST(federal_expenditure_amount AS DOUBLE))
      comment: "Total federal expenditure subject to single audit requirements. The primary scale indicator for the federal compliance program — determines audit scope and Uniform Guidance applicability."
    - name: "avg_federal_expenditure_amount"
      expr: AVG(CAST(federal_expenditure_amount AS DOUBLE))
      comment: "Average federal expenditure per single audit entity. Benchmarks the scale of federal program activity across audited entities."
    - name: "total_questioned_cost_amount"
      expr: SUM(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Total questioned costs identified across all single audits. Represents the maximum potential federal fund recovery exposure — a critical financial risk KPI."
    - name: "total_audit_cost_amount"
      expr: SUM(CAST(audit_cost_amount AS DOUBLE))
      comment: "Total cost incurred to conduct single audits. Tracks the administrative cost of federal compliance and informs audit procurement decisions."
    - name: "avg_audit_cost_amount"
      expr: AVG(CAST(audit_cost_amount AS DOUBLE))
      comment: "Average cost per single audit engagement. Used to benchmark audit procurement efficiency and negotiate auditor fees."
    - name: "material_weakness_audit_count"
      expr: COUNT(CASE WHEN material_weakness_identified_flag = TRUE THEN single_audit_id END)
      comment: "Number of single audits in which a material weakness was identified. Material weaknesses can result in loss of low-risk auditee status and increased federal oversight."
    - name: "adverse_opinion_count"
      expr: COUNT(CASE WHEN compliance_opinion_type IN ('Adverse', 'Disclaimer') OR financial_statement_opinion_type IN ('Adverse', 'Disclaimer') THEN single_audit_id END)
      comment: "Count of audits receiving an adverse or disclaimer opinion on compliance or financial statements. These are the most severe audit outcomes and can jeopardize federal award eligibility."
    - name: "questioned_cost_to_expenditure_ratio"
      expr: ROUND(100.0 * SUM(CAST(questioned_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(federal_expenditure_amount AS DOUBLE)), 0), 4)
      comment: "Questioned costs as a percentage of total federal expenditure. A compound efficiency ratio measuring the proportion of federal funds at risk — a key metric for federal program officers and board oversight."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`compliance_statutory_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs tracking the organization's statutory registration and tax-exempt status portfolio — monitoring compliance status, renewal timeliness, and operating authority across jurisdictions to protect the legal right to operate and fundraise."
  source: "`ngo_ecm`.`compliance`.`statutory_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the statutory registration (e.g., active, expired, pending renewal) — the primary legal operating authority indicator."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the registration with applicable regulatory requirements."
    - name: "registration_type"
      expr: registration_type
      comment: "Type of registration (e.g., nonprofit, charity, foreign NGO) for portfolio segmentation by legal entity type."
    - name: "tax_exempt_status"
      expr: tax_exempt_status
      comment: "Tax-exempt status classification (e.g., 501(c)(3), 501(c)(4)) for donor eligibility and tax reporting analysis."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction in which the registration is held for geographic compliance coverage analysis."
    - name: "registered_country_code"
      expr: registered_country_code
      comment: "Country of registration for international operations compliance mapping."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Flag indicating whether the registration requires periodic renewal, tracking active renewal obligations."
    - name: "operating_authority_granted_flag"
      expr: operating_authority_granted_flag
      comment: "Flag indicating whether operating authority has been granted in the jurisdiction — a prerequisite for program delivery."
    - name: "donor_eligibility_verified_flag"
      expr: donor_eligibility_verified_flag
      comment: "Flag indicating whether donor eligibility (e.g., tax deductibility) has been verified for this registration."
    - name: "foundation_status"
      expr: foundation_status
      comment: "Foundation status classification (e.g., public charity, private foundation) affecting regulatory requirements and donor deductibility."
    - name: "renewal_frequency"
      expr: renewal_frequency
      comment: "Frequency of required renewal (e.g., annual, biennial) for renewal calendar planning."
  measures:
    - name: "active_registration_count"
      expr: COUNT(CASE WHEN registration_status = 'Active' THEN statutory_registration_id END)
      comment: "Count of currently active statutory registrations. Measures the breadth of the organization's legal operating footprint across jurisdictions."
    - name: "expired_registration_count"
      expr: COUNT(CASE WHEN registration_status = 'Expired' THEN statutory_registration_id END)
      comment: "Count of expired registrations. Expired registrations can halt program operations and fundraising in affected jurisdictions — a critical operational risk."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN registration_status = 'Active' AND expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN statutory_registration_id END)
      comment: "Count of active registrations expiring within the next 90 days. A forward-looking risk indicator enabling proactive renewal management before operational disruption."
    - name: "non_compliant_registration_count"
      expr: COUNT(CASE WHEN compliance_status NOT IN ('Compliant', 'Active') THEN statutory_registration_id END)
      comment: "Count of registrations in non-compliant status. Non-compliant registrations risk revocation of operating authority and donor eligibility."
    - name: "jurisdictions_with_operating_authority"
      expr: COUNT(CASE WHEN operating_authority_granted_flag = TRUE THEN statutory_registration_id END)
      comment: "Count of registrations where operating authority has been granted. Measures the geographic scope of authorized program delivery capacity."
    - name: "donor_eligibility_verified_count"
      expr: COUNT(CASE WHEN donor_eligibility_verified_flag = TRUE THEN statutory_registration_id END)
      comment: "Count of registrations with verified donor eligibility. Directly impacts fundraising capacity — unverified eligibility can deter major donors and institutional funders."
    - name: "avg_days_since_last_filing"
      expr: AVG(DATEDIFF(CURRENT_DATE(), last_filing_date))
      comment: "Average number of days since the last regulatory filing across all registrations. Identifies registrations at risk of lapsing due to inactivity or missed filing deadlines."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs tracking the organization's compliance obligation portfolio — monitoring obligation status, overdue obligations, single audit requirements, and IATI publication compliance to ensure all regulatory and donor commitments are met."
  source: "`ngo_ecm`.`compliance`.`obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of compliance obligation (e.g., regulatory filing, donor report, audit) for portfolio segmentation."
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the obligation (e.g., active, completed, overdue) for compliance pipeline management."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the obligation, used to prioritize high-risk compliance activities."
    - name: "frequency"
      expr: frequency
      comment: "Recurrence frequency of the obligation (e.g., annual, quarterly, monthly) for compliance calendar planning."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction to which the obligation applies for geographic compliance coverage analysis."
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory or governing body that mandates the obligation for stakeholder-level compliance reporting."
    - name: "single_audit_required"
      expr: single_audit_required
      comment: "Flag indicating whether the obligation requires a single audit under Uniform Guidance."
    - name: "iati_publication_required"
      expr: iati_publication_required
      comment: "Flag indicating whether IATI (International Aid Transparency Initiative) publication is required, tracking aid transparency obligations."
    - name: "chs_self_assessment_required"
      expr: chs_self_assessment_required
      comment: "Flag indicating whether a Core Humanitarian Standard self-assessment is required, tracking humanitarian accountability obligations."
    - name: "fiscal_year_applicable"
      expr: fiscal_year_applicable
      comment: "Fiscal year to which the obligation applies for annual compliance planning."
  measures:
    - name: "active_obligation_count"
      expr: COUNT(CASE WHEN obligation_status = 'Active' THEN obligation_id END)
      comment: "Count of currently active compliance obligations. Measures the total compliance workload the organization must manage."
    - name: "overdue_obligation_count"
      expr: COUNT(CASE WHEN obligation_status NOT IN ('Completed', 'Closed') AND next_due_date < CURRENT_DATE() THEN obligation_id END)
      comment: "Count of obligations past their next due date without completion. Directly measures outstanding regulatory and donor penalty risk."
    - name: "high_risk_obligation_count"
      expr: COUNT(CASE WHEN risk_rating IN ('High', 'Critical') THEN obligation_id END)
      comment: "Count of obligations rated high or critical risk. These obligations carry the greatest penalty, funding, and reputational consequences if missed."
    - name: "single_audit_required_count"
      expr: COUNT(CASE WHEN single_audit_required = TRUE THEN obligation_id END)
      comment: "Count of obligations requiring a single audit. Tracks the scope of federal audit obligations under Uniform Guidance."
    - name: "iati_publication_required_count"
      expr: COUNT(CASE WHEN iati_publication_required = TRUE THEN obligation_id END)
      comment: "Count of obligations requiring IATI publication. Measures the organization's aid transparency reporting burden and commitment to international accountability standards."
    - name: "obligation_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN obligation_status IN ('Completed', 'Closed') THEN obligation_id END) / NULLIF(COUNT(obligation_id), 0), 2)
      comment: "Percentage of obligations that have been completed or closed. The primary compliance program effectiveness KPI — measures the organization's overall obligation fulfillment rate."
$$;