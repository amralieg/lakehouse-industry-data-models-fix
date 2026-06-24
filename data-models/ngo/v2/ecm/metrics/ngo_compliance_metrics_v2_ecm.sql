-- Metric views for domain: compliance | Business: Ngo | Version: 2 | Generated on: 2026-06-23 01:23:48

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over audit findings from Single Audits and internal reviews. Tracks questioned costs, repeat findings, material weaknesses, and resolution performance. Relevant to US OMB Uniform Guidance (2 CFR 200), IPSAS-compliant audit cycles, and donor audit requirements. Source systems include SAP audit modules, Federal Audit Clearinghouse (FAC), and internal GRC platforms. PII note: responsible_person_name is pii_staff — apply column masking policy."
  source: "`vibe_ngo_v1`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Classification of the audit finding (e.g., material weakness, significant deficiency, compliance finding) — primary grouping for risk triage."
    - name: "finding_status"
      expr: finding_status
      comment: "Current lifecycle status of the finding (open, in-remediation, closed) — used to filter active vs. resolved findings."
    - name: "severity_level"
      expr: severity_level
      comment: "Risk severity tier assigned to the finding — drives escalation and board reporting."
    - name: "compliance_requirement_type"
      expr: compliance_requirement_type
      comment: "Federal or donor compliance requirement category the finding relates to (e.g., procurement, financial reporting, subrecipient monitoring)."
    - name: "federal_agency_name"
      expr: federal_agency_name
      comment: "US federal agency or donor body associated with the award under audit — supports agency-level compliance tracking."
    - name: "risk_category"
      expr: risk_category
      comment: "Broad risk domain of the finding (financial, operational, programmatic) — used for portfolio-level risk dashboards."
    - name: "is_repeat_finding"
      expr: is_repeat_finding
      comment: "Flag indicating whether this finding recurred from a prior audit period — repeat findings signal systemic control failures."
    - name: "is_material_weakness"
      expr: is_material_weakness
      comment: "Flag for material weakness classification — material weaknesses trigger mandatory donor and board notification."
    - name: "finding_identified_year"
      expr: DATE_TRUNC('YEAR', finding_identified_date)
      comment: "Year the finding was identified — enables year-over-year trend analysis of audit quality."
    - name: "audit_period_year"
      expr: DATE_TRUNC('YEAR', audit_period_start_date)
      comment: "Fiscal year of the audit period — aligns findings to the correct reporting cycle."
  measures:
    - name: "total_questioned_costs_usd"
      expr: SUM(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Total dollar value of costs questioned by auditors. A key financial risk indicator — high questioned costs signal procurement or financial management weaknesses and may trigger donor clawbacks."
    - name: "avg_questioned_cost_per_finding_usd"
      expr: AVG(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Average questioned cost per audit finding. Tracks whether individual findings are growing in financial materiality over time."
    - name: "total_open_findings"
      expr: COUNT(CASE WHEN finding_status = 'open' THEN 1 END)
      comment: "Count of unresolved audit findings. A primary compliance health KPI — high open counts indicate remediation backlogs that risk donor sanctions."
    - name: "repeat_finding_count"
      expr: COUNT(CASE WHEN is_repeat_finding = TRUE THEN 1 END)
      comment: "Number of findings that recurred from prior audit periods. Repeat findings are a leading indicator of systemic control failure and attract heightened scrutiny from cognizant agencies."
    - name: "material_weakness_count"
      expr: COUNT(CASE WHEN is_material_weakness = TRUE THEN 1 END)
      comment: "Count of material weaknesses identified. Material weaknesses require immediate board and donor notification and can jeopardize award renewals."
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(actual_resolution_date, finding_identified_date))
      comment: "Average calendar days from finding identification to resolution. Measures remediation velocity — slow resolution increases regulatory and reputational risk."
    - name: "overdue_finding_count"
      expr: COUNT(CASE WHEN finding_status != 'closed' AND expected_resolution_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of findings past their expected resolution date. Overdue findings are a direct compliance risk metric reported to audit committees and donors."
    - name: "fraud_indicator_finding_count"
      expr: COUNT(CASE WHEN is_fraud_indicator = TRUE THEN 1 END)
      comment: "Count of findings flagged as potential fraud indicators. Fraud-flagged findings require mandatory escalation and may trigger law enforcement referrals."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_corrective_action_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPI layer tracking corrective action plan (CAP) execution, cost, and timeliness. CAPs are the primary remediation mechanism for audit findings, CHS self-assessments, and safeguarding incidents. Relevant to OMB Uniform Guidance, IPSAS governance standards, and CHS accountability frameworks. Source systems include SAP GRC, internal case management tools, and eTools."
  source: "`vibe_ngo_v1`.`compliance`.`corrective_action_plan`"
  dimensions:
    - name: "cap_status"
      expr: cap_status
      comment: "Current lifecycle status of the corrective action plan (draft, in-progress, completed, overdue) — primary operational filter."
    - name: "finding_type"
      expr: finding_type
      comment: "Type of finding that triggered the CAP — enables analysis of which finding categories generate the most remediation effort."
    - name: "finding_severity"
      expr: finding_severity
      comment: "Severity level of the triggering finding — high-severity CAPs require accelerated tracking."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Organizational unit responsible for executing the CAP — enables departmental accountability reporting."
    - name: "recurrence_risk"
      expr: recurrence_risk
      comment: "Assessed risk that the underlying issue will recur — high recurrence risk CAPs warrant additional monitoring."
    - name: "donor_notification_required"
      expr: donor_notification_required
      comment: "Flag indicating whether the donor must be notified of this CAP — donor-notifiable CAPs have stricter timeline requirements."
    - name: "target_completion_year"
      expr: DATE_TRUNC('YEAR', target_completion_date)
      comment: "Year the CAP is targeted for completion — supports annual compliance planning."
  measures:
    - name: "total_estimated_remediation_cost_usd"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost to execute all corrective action plans. A key budget planning metric — large remediation cost pools signal systemic compliance investment needs."
    - name: "total_actual_remediation_cost_usd"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred on corrective action plans. Compared against estimated cost to assess remediation budget accuracy and cost overruns."
    - name: "avg_actual_remediation_cost_usd"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action plan. Benchmarks remediation cost efficiency across departments and finding types."
    - name: "cost_overrun_amount_usd"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Aggregate cost overrun across all CAPs (actual minus estimated). Persistent overruns indicate poor remediation scoping and budget risk."
    - name: "overdue_cap_count"
      expr: COUNT(CASE WHEN cap_status != 'completed' AND target_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of CAPs past their target completion date. Overdue CAPs are a primary compliance risk indicator reported to audit committees."
    - name: "avg_days_to_cap_completion"
      expr: AVG(DATEDIFF(actual_completion_date, created_timestamp))
      comment: "Average calendar days from CAP creation to actual completion. Measures remediation velocity — a key operational efficiency KPI for compliance leadership."
    - name: "donor_notifiable_cap_count"
      expr: COUNT(CASE WHEN donor_notification_required = TRUE THEN 1 END)
      comment: "Count of CAPs requiring donor notification. Donor-notifiable CAPs carry reputational and contractual risk if not resolved within donor-stipulated timelines."
    - name: "escalated_cap_count"
      expr: COUNT(CASE WHEN escalation_required = TRUE THEN 1 END)
      comment: "Number of CAPs that required escalation. High escalation rates signal that front-line remediation processes are insufficient and leadership intervention is needed."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over compliance incidents including fraud, misuse of funds, regulatory breaches, and safeguarding-adjacent compliance failures. Critical for donor reporting, board risk oversight, and regulatory notification tracking. Relevant to IPSAS governance, OMB Uniform Guidance, and FCPA/anti-corruption frameworks. Source systems include SAP GRC, Salesforce case management, and internal incident tracking tools. PII note: reporter_contact_info is pii_staff/pii_beneficiary_protected — apply dynamic masking."
  source: "`vibe_ngo_v1`.`compliance`.`compliance_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Category of compliance incident (fraud, conflict of interest, procurement irregularity, data breach) — primary classification for risk reporting."
    - name: "incident_status"
      expr: incident_status
      comment: "Current lifecycle status of the incident (reported, under investigation, resolved, closed) — operational filter for active case management."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity tier of the incident — high-severity incidents trigger mandatory donor and board notification."
    - name: "allegation_category"
      expr: allegation_category
      comment: "Specific allegation type within the incident category — enables granular trend analysis for prevention programs."
    - name: "donor_notification_required_flag"
      expr: donor_notification_required_flag
      comment: "Whether the incident requires donor notification — donor-notifiable incidents have contractual disclosure timelines."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether the incident requires regulatory reporting — triggers mandatory filing deadlines."
    - name: "reporting_channel"
      expr: reporting_channel
      comment: "Channel through which the incident was reported (hotline, manager, audit) — informs effectiveness of reporting mechanisms."
    - name: "incident_reported_year"
      expr: DATE_TRUNC('YEAR', reported_date)
      comment: "Year the incident was reported — enables year-over-year trend analysis."
    - name: "incident_reported_month"
      expr: DATE_TRUNC('MONTH', reported_date)
      comment: "Month the incident was reported — supports monthly compliance dashboard reporting."
  measures:
    - name: "total_estimated_financial_impact_usd"
      expr: SUM(CAST(estimated_financial_impact_usd AS DOUBLE))
      comment: "Total estimated financial impact of all compliance incidents. A primary board-level risk metric — large aggregate impacts signal systemic control failures requiring immediate investment."
    - name: "avg_financial_impact_per_incident_usd"
      expr: AVG(CAST(estimated_financial_impact_usd AS DOUBLE))
      comment: "Average financial impact per compliance incident. Tracks whether incident severity is increasing over time — rising averages indicate worsening risk exposure."
    - name: "open_incident_count"
      expr: COUNT(CASE WHEN incident_status NOT IN ('resolved', 'closed') THEN 1 END)
      comment: "Number of unresolved compliance incidents. A primary operational risk KPI — high open counts indicate investigation capacity constraints."
    - name: "donor_notifiable_incident_count"
      expr: COUNT(CASE WHEN donor_notification_required_flag = TRUE THEN 1 END)
      comment: "Count of incidents requiring donor notification. Donor-notifiable incidents carry contractual disclosure obligations — tracking ensures no notification deadlines are missed."
    - name: "avg_days_to_investigation_completion"
      expr: AVG(DATEDIFF(investigation_completion_date, investigation_start_date))
      comment: "Average days from investigation start to completion. Measures investigation efficiency — slow investigations increase legal exposure and donor confidence risk."
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(resolution_date, reported_date))
      comment: "Average days from incident report to full resolution. A key accountability metric — long resolution cycles signal inadequate compliance response capacity."
    - name: "anonymous_report_count"
      expr: COUNT(CASE WHEN reporter_anonymity_flag = TRUE THEN 1 END)
      comment: "Number of incidents reported anonymously. High anonymous reporting rates indicate a healthy speak-up culture; very low rates may signal fear of retaliation."
    - name: "regulatory_reporting_required_count"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 END)
      comment: "Count of incidents requiring regulatory reporting. Tracks mandatory disclosure obligations — missed regulatory filings carry significant legal and reputational risk."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_obligation_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPI layer tracking compliance obligation schedule execution, timeliness, and penalty exposure. Obligations span regulatory filings, donor reporting, IATI publication, and statutory renewals. Relevant to OMB Uniform Guidance, IPSAS governance, and multi-donor compliance calendars. Source systems include SAP compliance modules, eTools, and internal obligation tracking systems."
  source: "`vibe_ngo_v1`.`compliance`.`obligation_schedule`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Current completion status of the scheduled obligation (pending, completed, overdue, waived) — primary operational filter."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory or donor framework governing the obligation (OMB, IPSAS, IATI, CHS) — enables framework-level compliance tracking."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the obligation — supports country-level compliance portfolio management."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority tier of the obligation — high-priority obligations require accelerated monitoring."
    - name: "extension_granted_flag"
      expr: extension_granted_flag
      comment: "Whether a deadline extension was granted — high extension rates signal systemic capacity issues."
    - name: "escalation_triggered_flag"
      expr: escalation_triggered_flag
      comment: "Whether the obligation triggered an escalation — escalated obligations require leadership attention."
    - name: "planned_due_month"
      expr: DATE_TRUNC('MONTH', planned_due_date)
      comment: "Month the obligation was originally due — enables compliance calendar load analysis."
    - name: "planned_due_year"
      expr: DATE_TRUNC('YEAR', planned_due_date)
      comment: "Year the obligation was originally due — supports annual compliance planning."
  measures:
    - name: "total_penalty_exposure_usd"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount across all obligation schedules. A critical financial risk metric — large penalty exposure signals compliance failures with direct financial consequences."
    - name: "avg_penalty_amount_usd"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per obligation schedule. Benchmarks penalty severity — rising averages indicate worsening compliance performance."
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total staff hours actually expended on compliance obligations. A workforce capacity metric — high actual hours vs. estimates signal under-resourced compliance functions."
    - name: "total_estimated_effort_hours"
      expr: SUM(CAST(estimated_effort_hours AS DOUBLE))
      comment: "Total estimated staff hours for compliance obligations. Used with actual hours to compute effort variance and plan compliance staffing."
    - name: "effort_variance_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE) - CAST(estimated_effort_hours AS DOUBLE))
      comment: "Aggregate effort variance (actual minus estimated hours). Persistent positive variance indicates compliance obligations are systematically under-estimated, risking staff burnout and missed deadlines."
    - name: "overdue_obligation_count"
      expr: COUNT(CASE WHEN completion_status != 'completed' AND effective_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of obligation schedules past their effective due date. A primary compliance health KPI — overdue obligations carry penalty and reputational risk."
    - name: "escalated_obligation_count"
      expr: COUNT(CASE WHEN escalation_triggered_flag = TRUE THEN 1 END)
      comment: "Count of obligations that triggered escalation. High escalation rates indicate the compliance function lacks capacity to meet obligations without leadership intervention."
    - name: "extension_granted_count"
      expr: COUNT(CASE WHEN extension_granted_flag = TRUE THEN 1 END)
      comment: "Number of obligations where a deadline extension was granted. Frequent extensions signal systemic capacity or process issues in the compliance function."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_single_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over Single Audit (OMB 2 CFR 200 Subpart F) engagements. Tracks federal expenditure thresholds, audit opinions, questioned costs, and material weakness rates. Critical for US federal award compliance and cognizant agency oversight. Also relevant to IPSAS-aligned external audit processes for UN agencies. Source systems include the Federal Audit Clearinghouse (FAC), SAP, and audit firm portals."
  source: "`vibe_ngo_v1`.`compliance`.`single_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the single audit engagement (planned, fieldwork, report-issued, submitted) — primary operational filter."
    - name: "audit_year"
      expr: audit_year
      comment: "Fiscal year of the single audit — primary time dimension for year-over-year compliance trend analysis."
    - name: "compliance_opinion_type"
      expr: compliance_opinion_type
      comment: "Auditor's compliance opinion (unmodified, qualified, adverse, disclaimer) — a critical quality indicator for donor and federal agency confidence."
    - name: "financial_statement_opinion_type"
      expr: financial_statement_opinion_type
      comment: "Auditor's financial statement opinion — adverse or qualified opinions trigger donor escalation and may jeopardize award renewals."
    - name: "material_weakness_identified_flag"
      expr: material_weakness_identified_flag
      comment: "Whether a material weakness was identified in the audit — material weaknesses require mandatory board and donor notification."
    - name: "low_risk_auditee_flag"
      expr: low_risk_auditee_flag
      comment: "Whether the organization qualifies as a low-risk auditee — low-risk status reduces audit scope and cost."
    - name: "going_concern_issue_flag"
      expr: going_concern_issue_flag
      comment: "Whether a going concern issue was identified — going concern flags are existential risk indicators requiring immediate board action."
    - name: "audit_period_year"
      expr: DATE_TRUNC('YEAR', audit_period_start_date)
      comment: "Year of the audit period — aligns audit results to the correct fiscal cycle."
  measures:
    - name: "total_federal_expenditure_usd"
      expr: SUM(CAST(federal_expenditure_amount AS DOUBLE))
      comment: "Total federal expenditure subject to single audit. The primary threshold metric — organizations exceeding $750K must undergo single audit, making this a key compliance trigger."
    - name: "total_questioned_costs_usd"
      expr: SUM(CAST(questioned_cost_amount AS DOUBLE))
      comment: "Total questioned costs identified across single audits. Questioned costs may be disallowed by federal agencies, creating direct financial liability."
    - name: "total_audit_cost_usd"
      expr: SUM(CAST(audit_cost_amount AS DOUBLE))
      comment: "Total cost of single audit engagements. A compliance overhead metric — high audit costs relative to federal expenditure signal inefficient audit management."
    - name: "avg_audit_cost_usd"
      expr: AVG(CAST(audit_cost_amount AS DOUBLE))
      comment: "Average cost per single audit engagement. Benchmarks audit procurement efficiency and identifies outlier engagements."
    - name: "material_weakness_audit_count"
      expr: COUNT(CASE WHEN material_weakness_identified_flag = TRUE THEN 1 END)
      comment: "Number of single audits that identified material weaknesses. A board-level risk KPI — material weaknesses in consecutive years signal persistent control failures."
    - name: "avg_days_fieldwork_duration"
      expr: AVG(DATEDIFF(fieldwork_end_date, fieldwork_start_date))
      comment: "Average duration of audit fieldwork in days. Long fieldwork periods increase audit cost and organizational disruption — a key audit management efficiency metric."
    - name: "avg_days_report_to_submission"
      expr: AVG(DATEDIFF(audit_report_date, fieldwork_end_date))
      comment: "Average days from fieldwork completion to audit report issuance. Measures audit firm responsiveness — delays risk missing FAC submission deadlines."
    - name: "corrective_action_plan_submission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_plan_submitted_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN material_weakness_identified_flag = TRUE OR significant_deficiency_identified_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of audits with findings where a corrective action plan was submitted. A compliance accountability metric — low rates indicate inadequate response to audit findings."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_sanctions_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk and compliance KPI layer over sanctions screening activities. Tracks screening coverage, match rates, false positive rates, and resolution timeliness. Critical for OFAC, EU, UN sanctions compliance and donor due diligence requirements. Relevant to all NGOs receiving US federal funding or operating in conflict-affected contexts. Source systems include World-Check, Dow Jones Risk & Compliance, and integrated SAP GRC screening modules. PII note: subject_name, subject_date_of_birth, subject_address, subject_nationality are pii_beneficiary_protected — apply dynamic masking and RLS."
  source: "`vibe_ngo_v1`.`compliance`.`sanctions_screening`"
  dimensions:
    - name: "screening_status"
      expr: screening_status
      comment: "Current status of the screening record (pending, cleared, flagged, escalated) — primary operational filter."
    - name: "match_result"
      expr: match_result
      comment: "Outcome of the sanctions list match (no match, potential match, confirmed match) — drives escalation and resolution workflows."
    - name: "subject_type"
      expr: subject_type
      comment: "Type of entity screened (individual, organization, vendor, partner) — enables screening coverage analysis by entity category."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the screened subject — high-risk subjects require enhanced due diligence."
    - name: "screening_method"
      expr: screening_method
      comment: "Method used for screening (automated, manual, batch) — informs screening process efficiency analysis."
    - name: "false_positive_flag"
      expr: false_positive_flag
      comment: "Whether the match was determined to be a false positive — high false positive rates indicate screening tool calibration issues."
    - name: "rescreening_required_flag"
      expr: rescreening_required_flag
      comment: "Whether periodic rescreening is required — tracks ongoing monitoring obligations."
    - name: "screening_year"
      expr: DATE_TRUNC('YEAR', screening_date)
      comment: "Year of the screening — enables annual screening volume and match rate trend analysis."
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_date)
      comment: "Month of the screening — supports monthly compliance dashboard reporting."
  measures:
    - name: "total_screenings_conducted"
      expr: COUNT(1)
      comment: "Total number of sanctions screenings conducted. A compliance coverage metric — organizations must demonstrate comprehensive screening of all partners, vendors, and beneficiaries."
    - name: "confirmed_match_count"
      expr: COUNT(CASE WHEN match_result = 'confirmed match' THEN 1 END)
      comment: "Number of screenings resulting in confirmed sanctions matches. A critical risk metric — confirmed matches require immediate transaction blocking and regulatory notification."
    - name: "false_positive_count"
      expr: COUNT(CASE WHEN false_positive_flag = TRUE THEN 1 END)
      comment: "Number of screenings determined to be false positives. High false positive rates waste investigation resources and indicate screening tool over-sensitivity."
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match score across all screening records. Tracks screening tool sensitivity calibration — very high averages may indicate over-matching."
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(resolution_date, screening_date))
      comment: "Average days from screening to resolution of flagged records. Slow resolution of potential matches creates operational delays and compliance risk."
    - name: "overdue_rescreening_count"
      expr: COUNT(CASE WHEN rescreening_required_flag = TRUE AND next_screening_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of subjects with overdue rescreening. Overdue rescreenings represent gaps in ongoing monitoring obligations required by donors and regulators."
    - name: "potential_match_pending_review_count"
      expr: COUNT(CASE WHEN match_result = 'potential match' AND screening_status NOT IN ('cleared', 'escalated') THEN 1 END)
      comment: "Number of potential matches awaiting review. A real-time risk queue metric — unreviewed potential matches represent unresolved compliance exposure."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPI layer tracking regulatory filing timeliness, rejection rates, and fee management. Covers Form 990, IATI, statutory registrations, and donor-required filings. Relevant to IRS, state charity regulators, IPSAS-aligned statutory reporting, and multi-donor compliance calendars. Source systems include SAP, e-filing portals, and internal document management systems."
  source: "`vibe_ngo_v1`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the regulatory filing (draft, submitted, accepted, rejected, amended) — primary operational filter."
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel used for filing submission (electronic, paper, portal) — informs process modernization decisions."
    - name: "amendment_flag"
      expr: amendment_flag
      comment: "Whether this is an amended filing — high amendment rates signal data quality issues in original submissions."
    - name: "extension_granted_flag"
      expr: extension_granted_flag
      comment: "Whether a filing deadline extension was granted — frequent extensions signal capacity constraints."
    - name: "public_disclosure_flag"
      expr: public_disclosure_flag
      comment: "Whether the filing is publicly disclosed — relevant for Form 990 and IATI transparency obligations."
    - name: "filing_period_year"
      expr: DATE_TRUNC('YEAR', filing_period_start_date)
      comment: "Fiscal year of the filing period — primary time dimension for annual compliance reporting."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of filing submission — enables compliance calendar load analysis."
  measures:
    - name: "total_filing_fees_usd"
      expr: SUM(CAST(filing_fee_amount AS DOUBLE))
      comment: "Total regulatory filing fees paid. A compliance overhead cost metric — tracks the direct financial cost of regulatory compliance across all jurisdictions."
    - name: "avg_filing_fee_usd"
      expr: AVG(CAST(filing_fee_amount AS DOUBLE))
      comment: "Average filing fee per regulatory submission. Benchmarks filing cost efficiency and identifies high-cost jurisdictions."
    - name: "rejected_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'rejected' THEN 1 END)
      comment: "Number of regulatory filings rejected by the receiving authority. Rejections require resubmission and risk missing statutory deadlines — a key data quality indicator."
    - name: "avg_days_to_submission"
      expr: AVG(DATEDIFF(submission_date, due_date))
      comment: "Average days between due date and actual submission (negative = early, positive = late). Measures filing timeliness — late submissions carry penalty risk and reputational damage."
    - name: "avg_days_to_acceptance"
      expr: AVG(DATEDIFF(acceptance_date, submission_date))
      comment: "Average days from submission to regulatory acceptance. Long acceptance cycles may indicate submission quality issues or regulatory processing backlogs."
    - name: "amendment_filing_count"
      expr: COUNT(CASE WHEN amendment_flag = TRUE THEN 1 END)
      comment: "Number of amended filings. High amendment rates signal data quality or process failures in original filing preparation."
    - name: "extension_requested_count"
      expr: COUNT(CASE WHEN extension_requested_flag = TRUE THEN 1 END)
      comment: "Number of filings for which an extension was requested. Tracks compliance capacity — frequent extension requests indicate the compliance function is under-resourced."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_iati_publication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transparency and accountability KPI layer over IATI (International Aid Transparency Initiative) publications. Tracks data quality, timeliness, completeness, and budget/disbursement reporting. IATI compliance is mandatory for many institutional donors (USAID, FCDO, EU) and is a key transparency benchmark for the humanitarian sector. Source systems include the IATI Registry, d-portal, and publishing tools such as Aidstream and OIPA."
  source: "`vibe_ngo_v1`.`compliance`.`iati_publication`"
  dimensions:
    - name: "publication_status"
      expr: publication_status
      comment: "Current status of the IATI publication (draft, published, superseded, withdrawn) — primary filter for active publications."
    - name: "publication_type"
      expr: publication_type
      comment: "Type of IATI publication (activity, organisation) — activity files are the primary transparency deliverable."
    - name: "iati_version"
      expr: iati_version
      comment: "IATI standard version used — older versions may not meet current donor requirements."
    - name: "timeliness_category"
      expr: timeliness_category
      comment: "IATI timeliness category (good, fair, poor) — timeliness is a scored dimension in donor transparency assessments."
    - name: "reporting_currency"
      expr: reporting_currency
      comment: "Currency used in the IATI publication — multi-currency publications require exchange rate management."
    - name: "reporting_period_year"
      expr: DATE_TRUNC('YEAR', reporting_period_start_date)
      comment: "Year of the IATI reporting period — primary time dimension for annual transparency trend analysis."
  measures:
    - name: "total_published_budget_value_usd"
      expr: SUM(CAST(total_budget_value AS DOUBLE))
      comment: "Total budget value published in IATI. A transparency coverage metric — donors assess whether published budgets match award values."
    - name: "total_published_disbursement_value_usd"
      expr: SUM(CAST(total_disbursement_value AS DOUBLE))
      comment: "Total disbursement value published in IATI. Tracks financial transparency — donors compare published disbursements against reported expenditures."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average IATI data quality score across publications. A key transparency KPI — low scores risk donor sanctions and public reputational damage."
    - name: "avg_completeness_percentage"
      expr: AVG(CAST(completeness_percentage AS DOUBLE))
      comment: "Average data completeness percentage across IATI publications. Incomplete publications fail donor transparency requirements and reduce IATI index scores."
    - name: "avg_timeliness_score"
      expr: AVG(CAST(timeliness_score AS DOUBLE))
      comment: "Average timeliness score across IATI publications. Timeliness is a scored dimension in the IATI transparency index — low scores affect donor confidence."
    - name: "total_file_size_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total file size of all IATI publications in bytes. Large file sizes may indicate data quality issues or overly granular reporting — a technical health metric."
    - name: "avg_file_size_bytes"
      expr: AVG(CAST(file_size_bytes AS DOUBLE))
      comment: "Average file size per IATI publication. Benchmarks publication complexity and identifies outlier publications requiring review."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_chs_self_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accountability and quality KPI layer over Core Humanitarian Standard (CHS) self-assessments. The CHS is the primary accountability framework for humanitarian NGOs, covering 9 commitments to affected populations. Tracks conformity scores, commitment-level performance, and assessment cycle compliance. Relevant to CHS Alliance certification, Sphere standards, and donor accountability requirements. Source systems include KoboToolbox, ODK, and dedicated CHS assessment platforms. PII note: lead_assessor_email, lead_assessor_name are pii_staff — apply masking."
  source: "`vibe_ngo_v1`.`compliance`.`chs_self_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the CHS self-assessment (in-progress, submitted, verified, certified) — primary lifecycle filter."
    - name: "overall_conformity_rating"
      expr: overall_conformity_rating
      comment: "Overall CHS conformity rating (strong, adequate, weak, non-conforming) — the primary accountability outcome metric."
    - name: "certification_target_flag"
      expr: certification_target_flag
      comment: "Whether the assessment is targeting CHS certification — certification-track assessments have stricter verification requirements."
    - name: "verification_body"
      expr: verification_body
      comment: "External body conducting verification — enables comparison of assessment outcomes across verification bodies."
    - name: "assessment_period_year"
      expr: DATE_TRUNC('YEAR', assessment_period_start_date)
      comment: "Year of the assessment period — primary time dimension for annual CHS performance trend analysis."
  measures:
    - name: "avg_overall_conformity_score"
      expr: AVG(CAST(overall_conformity_score AS DOUBLE))
      comment: "Average overall CHS conformity score across all assessments. The primary CHS accountability KPI — tracks organizational improvement in humanitarian quality standards over time."
    - name: "avg_commitment_1_rating"
      expr: AVG(CAST(commitment_1_rating AS DOUBLE))
      comment: "Average score for CHS Commitment 1 (Humanitarian response is appropriate and relevant). Commitment-level scores identify specific accountability gaps requiring targeted improvement."
    - name: "avg_commitment_2_rating"
      expr: AVG(CAST(commitment_2_rating AS DOUBLE))
      comment: "Average score for CHS Commitment 2 (Humanitarian response is effective and timely). Low scores indicate delivery performance gaps."
    - name: "avg_commitment_3_rating"
      expr: AVG(CAST(commitment_3_rating AS DOUBLE))
      comment: "Average score for CHS Commitment 3 (Humanitarian response strengthens local capacities). Tracks localization performance — a strategic priority for the sector."
    - name: "avg_commitment_9_rating"
      expr: AVG(CAST(commitment_9_rating AS DOUBLE))
      comment: "Average score for CHS Commitment 9 (Resources are managed and used responsibly). Directly linked to financial accountability and donor confidence."
    - name: "assessments_overdue_for_renewal"
      expr: COUNT(CASE WHEN next_assessment_due_date < CURRENT_DATE() AND assessment_status != 'submitted' THEN 1 END)
      comment: "Number of country offices or programs overdue for their next CHS assessment. Overdue assessments represent gaps in accountability cycle compliance."
    - name: "avg_days_to_submission"
      expr: AVG(DATEDIFF(submission_date, assessment_period_end_date))
      comment: "Average days from assessment period end to submission. Long submission delays indicate assessment process inefficiency and risk missing donor reporting windows."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_nicra_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial compliance KPI layer over Negotiated Indirect Cost Rate Agreements (NICRAs). NICRAs govern indirect cost recovery on US federal awards and are a critical financial management tool for NGOs. Tracks indirect cost rates, fringe benefit rates, and agreement lifecycle. Relevant to OMB 2 CFR 200, USAID, and other US federal agency requirements. Also relevant to IPSAS cost allocation standards for UN agencies. Source systems include SAP cost accounting modules and cognizant agency portals."
  source: "`vibe_ngo_v1`.`compliance`.`nicra_agreement`"
  dimensions:
    - name: "nicra_agreement_status"
      expr: nicra_agreement_status
      comment: "Current status of the NICRA (active, expired, under negotiation, superseded) — primary filter for applicable rates."
    - name: "fiscal_year_basis"
      expr: fiscal_year_basis
      comment: "Fiscal year basis of the NICRA — aligns rate applicability to the correct financial reporting period."
    - name: "de_minimis_rate_elected"
      expr: de_minimis_rate_elected
      comment: "Whether the organization elected the de minimis 10% indirect cost rate — de minimis election indicates the organization lacks a negotiated rate."
    - name: "effective_start_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the NICRA became effective — primary time dimension for rate trend analysis."
  measures:
    - name: "avg_indirect_cost_rate_pct"
      expr: AVG(CAST(indirect_cost_rate_percentage AS DOUBLE))
      comment: "Average negotiated indirect cost rate percentage. A critical financial planning metric — the indirect rate directly determines how much overhead can be recovered on federal awards."
    - name: "max_indirect_cost_rate_pct"
      expr: MAX(indirect_cost_rate_percentage)
      comment: "Maximum indirect cost rate across all NICRAs. Identifies the highest rate in the portfolio — useful for benchmarking and donor negotiation strategy."
    - name: "avg_fringe_benefit_rate_pct"
      expr: AVG(CAST(fringe_benefit_rate_percentage AS DOUBLE))
      comment: "Average fringe benefit rate percentage. Fringe rates directly affect staff cost budgeting on federal awards — a key financial planning input."
    - name: "active_nicra_count"
      expr: COUNT(CASE WHEN nicra_agreement_status = 'active' THEN 1 END)
      comment: "Number of currently active NICRAs. Organizations should maintain at least one active NICRA to recover indirect costs on federal awards."
    - name: "expired_nicra_count"
      expr: COUNT(CASE WHEN nicra_agreement_status = 'expired' THEN 1 END)
      comment: "Number of expired NICRAs. Expired NICRAs without successors mean the organization cannot recover indirect costs — a direct financial risk."
    - name: "avg_days_to_negotiation"
      expr: AVG(DATEDIFF(negotiation_date, effective_start_date))
      comment: "Average days between NICRA effective start and negotiation completion. Long negotiation cycles create gaps in indirect cost recovery — a financial management efficiency metric."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_governance_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance and accountability KPI layer over organizational policies, board resolutions, and conflict-of-interest disclosures. Tracks policy currency, review cycle compliance, and public disclosure obligations. Relevant to IRS Form 990 governance disclosures, IPSAS governance standards, and donor accountability requirements. Also supports VREQ-055 board governance gap coverage for 501(c)(3) profiles. Source systems include document management platforms, board portals, and SAP GRC."
  source: "`vibe_ngo_v1`.`compliance`.`governance_policy`"
  dimensions:
    - name: "governance_policy_status"
      expr: governance_policy_status
      comment: "Current status of the policy (draft, active, under review, superseded, retired) — primary lifecycle filter."
    - name: "governance_policy_category"
      expr: governance_policy_category
      comment: "Category of the governance policy (financial, HR, safeguarding, procurement, board) — enables portfolio-level policy coverage analysis."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Compliance framework the policy supports (IPSAS, US GAAP/ASC 958, OMB, CHS, IATI) — dual-framework reference per VREQ-021."
    - name: "document_type"
      expr: document_type
      comment: "Type of governance document (policy, procedure, resolution, disclosure) — enables document type-level coverage analysis."
    - name: "irs_990_disclosure_required"
      expr: irs_990_disclosure_required
      comment: "Whether the policy requires IRS Form 990 disclosure — tracks US GAAP/IRS compliance obligations."
    - name: "public_disclosure_flag"
      expr: public_disclosure_flag
      comment: "Whether the policy is publicly disclosed — public disclosure is a transparency and accountability indicator."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the policy became effective — enables policy age and review cycle analysis."
  measures:
    - name: "overdue_for_review_count"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE() AND governance_policy_status = 'active' THEN 1 END)
      comment: "Number of active policies overdue for their scheduled review. Overdue policy reviews are a governance gap — donors and auditors expect policies to be current and regularly reviewed."
    - name: "active_policy_count"
      expr: COUNT(CASE WHEN governance_policy_status = 'active' THEN 1 END)
      comment: "Total number of active governance policies. A baseline governance coverage metric — organizations must maintain a minimum policy set to meet donor and regulatory requirements."
    - name: "avg_days_since_last_review"
      expr: AVG(DATEDIFF(CURRENT_DATE(), last_review_date))
      comment: "Average days since policies were last reviewed. A governance health metric — high averages indicate the policy framework is becoming stale and may not reflect current regulatory requirements."
    - name: "irs_990_disclosure_required_count"
      expr: COUNT(CASE WHEN irs_990_disclosure_required = TRUE THEN 1 END)
      comment: "Number of policies requiring IRS Form 990 disclosure. Tracks US GAAP compliance obligations — missing disclosures on Form 990 can trigger IRS scrutiny."
    - name: "publicly_disclosed_policy_count"
      expr: COUNT(CASE WHEN public_disclosure_flag = TRUE THEN 1 END)
      comment: "Number of policies publicly disclosed. Tracks organizational transparency — public disclosure of key policies is a CHS and donor accountability requirement."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_statutory_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Legal entity compliance KPI layer over statutory registrations, tax-exempt status, and operating authority across jurisdictions. Tracks registration currency, renewal obligations, and donor eligibility. Critical for multi-country NGO operations — lapsed registrations can halt program delivery and jeopardize award compliance. Relevant to national NGO laws, IRS 501(c)(3) status, and IPSAS entity recognition standards. Source systems include national charity registries, SAP legal entity management, and internal compliance trackers."
  source: "`vibe_ngo_v1`.`compliance`.`statutory_registration`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the statutory registration (compliant, at-risk, lapsed, under review) — primary risk filter."
    - name: "tax_exempt_status"
      expr: tax_exempt_status
      comment: "Tax-exempt status classification (501(c)(3), 501(c)(4), equivalent foreign status) — determines donor deductibility and regulatory obligations."
    - name: "foundation_status"
      expr: foundation_status
      comment: "IRS foundation status classification (public charity, private foundation, supporting organization) — affects regulatory requirements and donor eligibility."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Whether the registration requires periodic renewal — renewal-required registrations need active monitoring."
    - name: "donor_eligibility_verified_flag"
      expr: donor_eligibility_verified_flag
      comment: "Whether donor eligibility has been verified for this registration — unverified eligibility blocks donor funding."
    - name: "foreign_operations_permitted_flag"
      expr: foreign_operations_permitted_flag
      comment: "Whether the registration permits foreign operations — critical for INGOs operating across multiple jurisdictions."
    - name: "registration_year"
      expr: DATE_TRUNC('YEAR', registration_date)
      comment: "Year of initial registration — enables registration age and renewal cycle analysis."
  measures:
    - name: "lapsed_registration_count"
      expr: COUNT(CASE WHEN compliance_status = 'lapsed' OR expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of lapsed or expired statutory registrations. A critical operational risk metric — lapsed registrations can halt program delivery and trigger award suspension."
    - name: "renewals_due_within_90_days"
      expr: COUNT(CASE WHEN renewal_required_flag = TRUE AND next_renewal_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of registrations due for renewal within 90 days. A forward-looking risk metric — enables proactive renewal management before lapse."
    - name: "donor_eligible_registration_count"
      expr: COUNT(CASE WHEN donor_eligibility_verified_flag = TRUE THEN 1 END)
      comment: "Number of registrations with verified donor eligibility. Tracks the organization's capacity to receive donor funding across jurisdictions."
    - name: "avg_days_to_next_renewal"
      expr: AVG(DATEDIFF(next_renewal_date, CURRENT_DATE()))
      comment: "Average days until next registration renewal across all active registrations. A portfolio-level renewal urgency metric — low averages signal an imminent renewal workload spike."
    - name: "compliant_registration_count"
      expr: COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END)
      comment: "Number of registrations in full compliance. The baseline legal entity health metric — organizations must maintain compliant registrations in all operating jurisdictions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_donor_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor compliance KPI layer tracking fulfillment of donor-specific requirements across awards. Covers reporting deliverables, prior approvals, branding requirements, and waiver management. Critical for award compliance and donor relationship management. Relevant to USAID, FCDO, EU, UN agency donor requirements and IPSAS disclosure standards. Source systems include SAP grants management, eTools, and donor portals. PII note: donor_contact_email, donor_contact_name are pii_donor — apply masking policy."
  source: "`vibe_ngo_v1`.`compliance`.`donor_requirement`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current fulfillment status of the donor requirement (pending, in-progress, fulfilled, overdue, waived) — primary operational filter."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority tier of the requirement — high-priority requirements have the greatest impact on award compliance."
    - name: "non_compliance_risk_level"
      expr: non_compliance_risk_level
      comment: "Risk level if the requirement is not met (low, medium, high, critical) — drives escalation and resource allocation."
    - name: "submission_method"
      expr: submission_method
      comment: "Method for fulfilling the requirement (portal, email, in-person) — informs process efficiency analysis."
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Whether a waiver was granted for this requirement — high waiver rates may indicate requirements are systematically unachievable."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for fulfilling the requirement — enables departmental accountability reporting."
    - name: "due_year"
      expr: DATE_TRUNC('YEAR', due_date)
      comment: "Year the requirement is due — primary time dimension for annual compliance planning."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the requirement is due — supports monthly compliance calendar management."
  measures:
    - name: "total_associated_cost_usd"
      expr: SUM(CAST(associated_cost_amount AS DOUBLE))
      comment: "Total cost associated with fulfilling donor requirements. A compliance overhead metric — high costs relative to award value signal disproportionate compliance burden."
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total staff hours expended on donor requirement fulfillment. A workforce capacity metric — tracks the true cost of donor compliance obligations."
    - name: "effort_variance_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE) - CAST(estimated_effort_hours AS DOUBLE))
      comment: "Aggregate effort variance (actual minus estimated hours) for donor requirements. Persistent overruns indicate requirements are systematically under-estimated."
    - name: "overdue_requirement_count"
      expr: COUNT(CASE WHEN compliance_status NOT IN ('fulfilled', 'waived') AND due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of donor requirements past their due date. Overdue requirements risk award non-compliance, financial penalties, and donor relationship damage."
    - name: "high_risk_non_compliance_count"
      expr: COUNT(CASE WHEN non_compliance_risk_level IN ('high', 'critical') AND compliance_status NOT IN ('fulfilled', 'waived') THEN 1 END)
      comment: "Number of unfulfilled requirements with high or critical non-compliance risk. A priority escalation metric — these requirements require immediate leadership attention."
    - name: "waiver_granted_count"
      expr: COUNT(CASE WHEN waiver_granted_flag = TRUE THEN 1 END)
      comment: "Number of requirements for which a waiver was granted. Tracks the organization's ability to negotiate relief from onerous requirements — a donor relationship management metric."
    - name: "avg_days_to_submission"
      expr: AVG(DATEDIFF(submission_date, due_date))
      comment: "Average days between due date and actual submission (negative = early, positive = late). Measures donor requirement fulfillment timeliness — a key award compliance health metric."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`compliance_internal_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk and assurance KPI layer over internal compliance reviews, audits, and assessments. Tracks review findings, risk scores, and corrective action follow-through. Supports the second line of defense in the three-lines model. Relevant to IPSAS internal control standards, OMB Uniform Guidance, and donor assurance requirements. Source systems include SAP GRC, internal audit management tools, and eTools."
  source: "`vibe_ngo_v1`.`compliance`.`internal_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of internal review (financial audit, programmatic review, procurement audit, IT audit) — primary classification for assurance portfolio analysis."
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review (planned, in-progress, report-issued, closed) — primary operational filter."
    - name: "overall_compliance_rating"
      expr: overall_compliance_rating
      comment: "Overall compliance rating assigned by the review (satisfactory, partially satisfactory, unsatisfactory) — the primary assurance outcome metric."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether the review identified issues requiring corrective action — drives CAP creation and tracking."
    - name: "donor_notification_required_flag"
      expr: donor_notification_required_flag
      comment: "Whether the review findings require donor notification — donor-notifiable findings have contractual disclosure timelines."
    - name: "follow_up_review_required_flag"
      expr: follow_up_review_required_flag
      comment: "Whether a follow-up review is required — indicates unresolved issues from the primary review."
    - name: "review_start_year"
      expr: DATE_TRUNC('YEAR', review_start_date)
      comment: "Year the review commenced — primary time dimension for annual assurance activity analysis."
  measures:
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across internal reviews. A portfolio-level risk health metric — rising average risk scores signal deteriorating compliance across the organization."
    - name: "max_risk_score"
      expr: MAX(risk_score)
      comment: "Maximum risk score across all reviews. Identifies the highest-risk area in the assurance portfolio — a key escalation trigger for leadership."
    - name: "avg_days_review_duration"
      expr: AVG(DATEDIFF(review_end_date, review_start_date))
      comment: "Average duration of internal reviews in days. Measures review efficiency — excessively long reviews consume resources and delay corrective action."
    - name: "avg_days_to_report_issuance"
      expr: AVG(DATEDIFF(report_issued_date, review_end_date))
      comment: "Average days from review completion to report issuance. Slow report issuance delays corrective action and reduces the value of the assurance function."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of reviews that identified issues requiring corrective action. Tracks the volume of remediation work generated by the assurance function."
    - name: "donor_notifiable_review_count"
      expr: COUNT(CASE WHEN donor_notification_required_flag = TRUE THEN 1 END)
      comment: "Count of reviews with findings requiring donor notification. Donor-notifiable findings carry contractual disclosure obligations — tracking ensures no deadlines are missed."
    - name: "unsatisfactory_rating_count"
      expr: COUNT(CASE WHEN overall_compliance_rating = 'unsatisfactory' THEN 1 END)
      comment: "Number of reviews rated unsatisfactory. Unsatisfactory ratings are the most severe assurance outcome — high counts signal systemic compliance failures requiring board-level attention."
$$;