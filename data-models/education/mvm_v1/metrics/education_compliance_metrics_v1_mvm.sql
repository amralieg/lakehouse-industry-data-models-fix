-- Metric views for domain: compliance | Business: Education | Version: 1 | Generated on: 2026-05-06 15:08:33

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`compliance_accreditation_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs tracking the health, timeliness, and financial exposure of institutional accreditation reviews. Executives use these metrics to monitor accreditation risk, appeal activity, and compliance posture across programs and campuses."
  source: "`education_ecm`.`compliance`.`accreditation_review`"
  dimensions:
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Current accreditation decision status (e.g., Accredited, Probation, Denied) — primary grouping for risk dashboards."
    - name: "accreditation_type"
      expr: accreditation_type
      comment: "Type of accreditation (e.g., Institutional, Programmatic, Specialized) — used to segment reviews by scope."
    - name: "review_cycle_type"
      expr: review_cycle_type
      comment: "Cycle classification of the review (e.g., Comprehensive, Focused, Interim) — helps distinguish routine from elevated scrutiny."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Boolean indicating whether an appeal was filed against the accreditation decision — key risk signal."
    - name: "conditions_issued_flag"
      expr: conditions_issued_flag
      comment: "Boolean indicating whether the accrediting body issued conditions — signals partial compliance concerns."
    - name: "interim_report_required_flag"
      expr: interim_report_required_flag
      comment: "Boolean indicating whether an interim progress report is required — drives follow-up workload planning."
    - name: "cip_code"
      expr: cip_code
      comment: "Classification of Instructional Programs code — enables analysis by academic discipline."
    - name: "accreditation_decision_year"
      expr: DATE_TRUNC('YEAR', accreditation_decision_date)
      comment: "Year of the accreditation decision — supports trend analysis over annual review cycles."
    - name: "review_period_start_year"
      expr: DATE_TRUNC('YEAR', review_period_start_date)
      comment: "Year the review period began — used to cohort reviews by academic year."
  measures:
    - name: "total_accreditation_reviews"
      expr: COUNT(1)
      comment: "Total number of accreditation reviews conducted — baseline volume metric for capacity and trend analysis."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact (costs, penalties, remediation) associated with accreditation reviews — directly informs budget risk exposure."
    - name: "avg_financial_impact_per_review"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per accreditation review — benchmarks cost of compliance activity and flags outlier reviews."
    - name: "appeal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_filed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accreditation reviews where an appeal was filed — high rates signal systemic accreditor disagreements requiring executive attention."
    - name: "conditions_issued_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN conditions_issued_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews resulting in conditions being issued — a leading indicator of accreditation risk and remediation burden."
    - name: "self_study_on_time_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN self_study_submitted_date <= self_study_due_date THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN self_study_submitted_date IS NOT NULL AND self_study_due_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of self-study reports submitted on or before the due date — measures institutional preparedness and process discipline."
    - name: "interim_report_on_time_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN interim_report_required_flag = TRUE AND interim_report_submitted_date <= interim_report_due_date THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN interim_report_required_flag = TRUE AND interim_report_due_date IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of required interim reports submitted on time — non-compliance here can trigger escalated accreditor scrutiny."
    - name: "reviews_with_conditions_count"
      expr: SUM(CASE WHEN conditions_issued_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reviews where conditions were issued — absolute volume used alongside rate for capacity planning of remediation teams."
    - name: "reviews_with_appeal_count"
      expr: SUM(CASE WHEN appeal_filed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reviews with an active or resolved appeal — used to track legal and administrative workload from contested decisions."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and strategic KPIs for the institutional audit program. Tracks audit volume, cost efficiency, finding severity, and remediation timeliness — core inputs for the Chief Audit Executive and Board Audit Committee reporting."
  source: "`education_ecm`.`compliance`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Classification of the audit (e.g., Financial, Operational, IT, Compliance) — primary segmentation for audit portfolio analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current lifecycle status of the audit (e.g., Planned, In Progress, Completed, Closed) — used to monitor pipeline and backlog."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance outcome of the audit (e.g., Compliant, Non-Compliant, Partially Compliant) — key risk signal for leadership."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Overall risk rating assigned to the audit (e.g., High, Medium, Low) — drives prioritization of remediation resources."
    - name: "overall_opinion"
      expr: overall_opinion
      comment: "Auditor's overall opinion on the audited entity (e.g., Satisfactory, Needs Improvement, Unsatisfactory) — board-level summary indicator."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Boolean indicating whether a follow-up audit is required — signals unresolved findings needing continued oversight."
    - name: "auditor_organization"
      expr: auditor_organization
      comment: "Name of the auditing organization (internal or external firm) — enables cost and quality benchmarking by auditor."
    - name: "actual_start_year"
      expr: DATE_TRUNC('YEAR', actual_start_date)
      comment: "Year the audit actually started — used to trend audit activity and compare planned vs. actual execution by year."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits conducted — baseline volume for audit program capacity and trend reporting."
    - name: "total_audit_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost of all audits — primary financial metric for audit program budget management and ROI analysis."
    - name: "total_external_auditor_fees"
      expr: SUM(CAST(external_auditor_fee AS DOUBLE))
      comment: "Total fees paid to external auditors — tracks outsourced audit spend and informs make-vs-buy decisions."
    - name: "avg_audit_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per audit — benchmarks efficiency and identifies high-cost outlier audits for review."
    - name: "total_audit_hours"
      expr: SUM(CAST(hours AS DOUBLE))
      comment: "Total staff hours consumed by audits — measures internal resource burden and supports capacity planning."
    - name: "avg_audit_hours"
      expr: AVG(CAST(hours AS DOUBLE))
      comment: "Average hours per audit — used to benchmark audit complexity and efficiency across types and periods."
    - name: "non_compliant_audit_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits resulting in a non-compliant finding — headline risk metric for the Board Audit Committee."
    - name: "follow_up_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring follow-up — high rates indicate systemic unresolved issues and elevated institutional risk."
    - name: "remediation_on_time_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_remediation_date IS NOT NULL AND estimated_remediation_date IS NOT NULL AND actual_remediation_date <= estimated_remediation_date THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN estimated_remediation_date IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of audits where remediation was completed on or before the estimated date — measures execution discipline on corrective actions."
    - name: "cost_per_audit_hour"
      expr: ROUND(SUM(CAST(cost AS DOUBLE)) / NULLIF(SUM(CAST(hours AS DOUBLE)), 0), 2)
      comment: "Average cost per audit hour — efficiency ratio used to benchmark internal vs. external audit productivity."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs governing the timeliness, accuracy, and volume of regulatory filings submitted to external bodies. Late or rejected filings carry significant penalty and reputational risk — these metrics are core to the Chief Compliance Officer's dashboard."
  source: "`education_ecm`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (e.g., IPEDS, Title IV, Clery ASR) — primary segmentation for compliance portfolio analysis."
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing (e.g., Draft, Submitted, Accepted, Rejected) — used to monitor pipeline and identify at-risk filings."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Name of the regulatory body receiving the filing (e.g., ED, SACSCOC, State Board) — enables analysis by regulator."
    - name: "is_late_filing"
      expr: is_late_filing
      comment: "Boolean indicating whether the filing was submitted after the due date — primary compliance risk flag."
    - name: "is_amended_filing"
      expr: is_amended_filing
      comment: "Boolean indicating whether this is an amended/corrected filing — high amendment rates signal data quality issues."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the filing (e.g., Online Portal, Mail, EDI) — used to assess process modernization and risk."
    - name: "academic_year"
      expr: academic_year
      comment: "Academic year associated with the filing — enables year-over-year compliance trend analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year associated with the filing — aligns regulatory reporting with financial planning cycles."
    - name: "filing_period_start_year"
      expr: DATE_TRUNC('YEAR', filing_period_start_date)
      comment: "Year the filing period began — used to cohort filings for longitudinal compliance trend analysis."
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total number of regulatory filings — baseline volume metric for compliance program workload and capacity planning."
    - name: "late_filing_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_late_filing = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings submitted after the due date — headline compliance risk metric; high rates trigger regulatory scrutiny and potential penalties."
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN filing_status = 'Rejected' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings rejected by the regulatory body — signals data quality or process failures requiring immediate remediation."
    - name: "amendment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_amended_filing = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of filings that required amendment — high rates indicate upstream data quality or process control weaknesses."
    - name: "on_time_filing_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_late_filing = FALSE AND submission_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN submission_date IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of submitted filings that were on time — positive framing of compliance timeliness for executive scorecards."
    - name: "avg_days_to_submission"
      expr: AVG(DATEDIFF(submission_date, filing_period_start_date))
      comment: "Average number of days from filing period start to submission — measures process efficiency and early-warning lead time."
    - name: "late_filings_count"
      expr: SUM(CASE WHEN is_late_filing = TRUE THEN 1 ELSE 0 END)
      comment: "Absolute count of late filings — used alongside rate to assess absolute regulatory exposure volume."
    - name: "rejected_filings_count"
      expr: SUM(CASE WHEN filing_status = 'Rejected' THEN 1 ELSE 0 END)
      comment: "Absolute count of rejected filings — used to size remediation workload and track improvement over time."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs measuring the institution's compliance obligation portfolio — tracking completion rates, cost efficiency, training adherence, and overdue obligations. Core to the Chief Compliance Officer's risk register and board reporting."
  source: "`education_ecm`.`compliance`.`obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of compliance obligation (e.g., Regulatory, Policy, Contractual) — primary segmentation for obligation portfolio analysis."
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the obligation (e.g., Active, Completed, Overdue, Waived) — used to identify at-risk obligations."
    - name: "completion_status"
      expr: completion_status
      comment: "Completion state of the obligation (e.g., Complete, Incomplete, In Progress) — drives remediation prioritization."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the obligation (e.g., Critical, High, Medium, Low) — used to focus executive attention on highest-risk items."
    - name: "frequency"
      expr: frequency
      comment: "Reporting or fulfillment frequency of the obligation (e.g., Annual, Quarterly, Monthly) — used to plan compliance calendar."
    - name: "is_active"
      expr: is_active
      comment: "Boolean indicating whether the obligation is currently active — used to filter active vs. historical obligation portfolios."
    - name: "training_required"
      expr: training_required
      comment: "Boolean indicating whether training is required to fulfill the obligation — used to size training program demand."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean indicating whether a corrective action plan is required — flags obligations with elevated remediation burden."
    - name: "governing_body"
      expr: governing_body
      comment: "External governing body associated with the obligation (e.g., DOE, HHS, State) — enables analysis by regulatory authority."
    - name: "effective_start_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the obligation became effective — used to trend obligation portfolio growth over time."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of compliance obligations in the portfolio — baseline volume for compliance program scope and resource planning."
    - name: "obligation_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN completion_status = 'Complete' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations marked complete — headline compliance performance metric for executive and board reporting."
    - name: "overdue_obligation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN due_date < CURRENT_DATE AND completion_status != 'Complete' THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active obligations that are past due — critical risk metric; high rates signal systemic compliance failures."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred to fulfill compliance obligations — primary financial metric for compliance program budget management."
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of compliance obligations — used for budget forecasting and variance analysis against actual costs."
    - name: "cost_variance"
      expr: ROUND(SUM(CAST(actual_cost AS DOUBLE)) - SUM(CAST(cost_estimate AS DOUBLE)), 2)
      comment: "Difference between actual and estimated compliance costs — positive values indicate cost overruns requiring budget reallocation."
    - name: "avg_training_completion_rate"
      expr: AVG(CAST(training_completion_rate AS DOUBLE))
      comment: "Average training completion rate across obligations requiring training — measures workforce readiness for compliance requirements."
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total actual staff hours spent fulfilling compliance obligations — measures internal resource consumption for capacity planning."
    - name: "effort_variance_hours"
      expr: ROUND(SUM(CAST(actual_effort_hours AS DOUBLE)) - SUM(CAST(estimated_effort_hours AS DOUBLE)), 2)
      comment: "Difference between actual and estimated effort hours — identifies obligations that consistently exceed effort estimates, signaling process inefficiency."
    - name: "corrective_action_obligation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of obligations requiring a corrective action plan — elevated rates indicate systemic non-compliance patterns requiring structural intervention."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`compliance_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enterprise risk KPIs derived from the compliance risk register. Tracks financial exposure, risk distribution by category and rating, and mitigation effectiveness — essential inputs for the Chief Risk Officer and Board Risk Committee."
  source: "`education_ecm`.`compliance`.`risk_assessment`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "High-level risk category (e.g., Financial, Operational, Regulatory, Reputational) — primary segmentation for enterprise risk portfolio analysis."
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Granular risk subcategory — enables drill-down analysis within major risk categories."
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (e.g., Open, Mitigated, Accepted, Closed) — used to track active vs. resolved risk items."
    - name: "inherent_risk_score"
      expr: inherent_risk_score
      comment: "Inherent risk score before controls are applied — used to assess gross risk exposure across the portfolio."
    - name: "residual_risk_score"
      expr: residual_risk_score
      comment: "Residual risk score after controls are applied — measures net risk exposure and control effectiveness."
    - name: "control_effectiveness"
      expr: control_effectiveness
      comment: "Rating of how effective existing controls are (e.g., Strong, Adequate, Weak) — key input for risk mitigation investment decisions."
    - name: "risk_trend"
      expr: risk_trend
      comment: "Direction of risk movement (e.g., Increasing, Stable, Decreasing) — leading indicator for proactive risk management."
    - name: "accreditation_impact_flag"
      expr: accreditation_impact_flag
      comment: "Boolean indicating whether the risk has potential accreditation impact — critical filter for academic leadership."
    - name: "board_reporting_required_flag"
      expr: board_reporting_required_flag
      comment: "Boolean indicating whether the risk must be reported to the Board — used to generate board-level risk registers."
    - name: "active_flag"
      expr: active_flag
      comment: "Boolean indicating whether the risk assessment is currently active — used to filter current vs. historical risk inventory."
    - name: "assessment_year"
      expr: DATE_TRUNC('YEAR', assessment_date)
      comment: "Year the risk was assessed — enables year-over-year risk portfolio trend analysis."
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total number of risk assessments in the register — baseline volume for enterprise risk program scope."
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial exposure across all risk assessments — headline dollar figure for Board Risk Committee and CFO reporting."
    - name: "avg_estimated_financial_impact"
      expr: AVG(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Average estimated financial impact per risk — used to benchmark risk severity and prioritize mitigation investment."
    - name: "max_estimated_financial_impact"
      expr: MAX(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Maximum single-risk financial exposure — identifies tail risks requiring immediate executive attention and contingency planning."
    - name: "high_risk_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN inherent_risk_score IN ('High', 'Critical') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risks rated High or Critical on inherent risk score — measures gross risk concentration in the portfolio."
    - name: "accreditation_impact_risk_count"
      expr: SUM(CASE WHEN accreditation_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of risks with potential accreditation impact — directly informs accreditation readiness and risk mitigation prioritization."
    - name: "board_reportable_risk_count"
      expr: SUM(CASE WHEN board_reporting_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of risks requiring board-level reporting — drives board agenda preparation and governance compliance."
    - name: "open_risk_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN risk_status = 'Open' AND active_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN active_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of active risks that remain open (unmitigated) — measures the unresolved risk backlog as a proportion of the active portfolio."
    - name: "increasing_risk_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN risk_trend = 'Increasing' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risks trending upward — leading indicator of deteriorating risk environment requiring proactive intervention."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`compliance_title_ix_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Title IX case management — tracking case volume, investigation timeliness, appeal rates, and outcome patterns. Mandatory for OCR compliance reporting and institutional equity program evaluation by the Title IX Coordinator and General Counsel."
  source: "`education_ecm`.`compliance`.`title_ix_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the Title IX case (e.g., Open, Under Investigation, Closed) — primary filter for active caseload management."
    - name: "case_type"
      expr: case_type
      comment: "Type of Title IX case (e.g., Sexual Harassment, Sexual Assault, Stalking) — used to analyze incident patterns and resource allocation."
    - name: "determination_outcome"
      expr: determination_outcome
      comment: "Final determination of the case (e.g., Responsible, Not Responsible, Dismissed) — key metric for equity program evaluation."
    - name: "complainant_type"
      expr: complainant_type
      comment: "Type of complainant (e.g., Student, Employee, Third Party) — used to segment cases by affected population."
    - name: "respondent_type"
      expr: respondent_type
      comment: "Type of respondent (e.g., Student, Faculty, Staff) — used to identify patterns by respondent population."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Boolean indicating whether an appeal was filed — high appeal rates may signal procedural fairness concerns."
    - name: "interim_measures_flag"
      expr: interim_measures_flag
      comment: "Boolean indicating whether interim protective measures were implemented — measures institutional responsiveness to complainants."
    - name: "clery_reportable_flag"
      expr: clery_reportable_flag
      comment: "Boolean indicating whether the case is also reportable under Clery Act — used to ensure cross-regulatory compliance."
    - name: "ocr_complaint_filed_flag"
      expr: ocr_complaint_filed_flag
      comment: "Boolean indicating whether an OCR complaint was filed — flags cases with federal regulatory escalation risk."
    - name: "grievance_process_type"
      expr: grievance_process_type
      comment: "Type of grievance process used (e.g., Formal, Informal, Mediation) — used to evaluate process utilization and outcomes."
    - name: "incident_year"
      expr: DATE_TRUNC('YEAR', incident_date)
      comment: "Year the incident occurred — used for annual trend analysis and OCR reporting period alignment."
    - name: "report_year"
      expr: DATE_TRUNC('YEAR', report_date)
      comment: "Year the case was reported — used to measure reporting lag and annual case intake volume."
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of Title IX cases — baseline volume metric for program capacity planning and OCR reporting."
    - name: "appeal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_filed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases where an appeal was filed — elevated rates may indicate procedural concerns or outcome dissatisfaction requiring process review."
    - name: "ocr_escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ocr_complaint_filed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that escalated to an OCR complaint — direct measure of federal regulatory exposure and institutional compliance risk."
    - name: "avg_investigation_duration_days"
      expr: AVG(DATEDIFF(investigation_completion_date, investigation_start_date))
      comment: "Average number of days from investigation start to completion — Title IX regulations require timely resolution; this metric flags systemic delays."
    - name: "avg_case_closure_duration_days"
      expr: AVG(DATEDIFF(case_closure_date, formal_complaint_filed_date))
      comment: "Average days from formal complaint filing to case closure — end-to-end process efficiency metric for Title IX program management."
    - name: "interim_measures_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN interim_measures_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases where interim protective measures were implemented — measures institutional responsiveness and duty-of-care compliance."
    - name: "retaliation_reported_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN retaliation_reported_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases where retaliation was reported — a critical compliance and culture indicator; high rates signal a hostile environment requiring immediate intervention."
    - name: "clery_reportable_case_count"
      expr: SUM(CASE WHEN clery_reportable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of Title IX cases that are also Clery-reportable — used to ensure accurate Annual Security Report (ASR) data and cross-regulatory compliance."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`compliance_clery_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Clery Act compliance — tracking campus crime incident volume, timely warning issuance, hate crime rates, and Annual Security Report (ASR) inclusion. Mandatory for federal Title IV eligibility and campus safety transparency reporting."
  source: "`education_ecm`.`compliance`.`clery_incident`"
  dimensions:
    - name: "clery_crime_category"
      expr: clery_crime_category
      comment: "Clery Act crime category (e.g., Burglary, Sexual Assault, Robbery) — primary segmentation for ASR crime statistics reporting."
    - name: "clery_geography_classification"
      expr: clery_geography_classification
      comment: "Clery geographic classification of the incident location (e.g., On-Campus, Non-Campus, Public Property) — required for ASR geographic breakdown."
    - name: "is_hate_crime"
      expr: is_hate_crime
      comment: "Boolean indicating whether the incident is classified as a hate crime — hate crimes require separate ASR reporting and heightened institutional response."
    - name: "is_vawa_offense"
      expr: is_vawa_offense
      comment: "Boolean indicating whether the incident is a VAWA-defined offense (domestic violence, dating violence, stalking) — required for VAWA ASR statistics."
    - name: "is_residential_facility"
      expr: is_residential_facility
      comment: "Boolean indicating whether the incident occurred in a residential facility — used for on-campus housing crime statistics."
    - name: "timely_warning_issued"
      expr: timely_warning_issued
      comment: "Boolean indicating whether a timely warning was issued — Clery Act requires timely warnings for certain crimes; non-issuance is a compliance violation."
    - name: "included_in_asr"
      expr: included_in_asr
      comment: "Boolean indicating whether the incident is included in the Annual Security Report — used to audit ASR completeness."
    - name: "reporting_source"
      expr: reporting_source
      comment: "Source of the incident report (e.g., Campus Security Authority, Law Enforcement, Self-Report) — used to evaluate CSA reporting compliance."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Calendar year for which the incident is reported in the ASR — primary time dimension for Clery annual statistics."
    - name: "incident_year"
      expr: DATE_TRUNC('YEAR', incident_date)
      comment: "Year the incident occurred — used for trend analysis and comparison against reporting year."
  measures:
    - name: "total_clery_incidents"
      expr: COUNT(1)
      comment: "Total number of Clery-reportable incidents — headline campus safety metric for ASR publication and federal compliance."
    - name: "hate_crime_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_hate_crime = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of Clery incidents classified as hate crimes — elevated rates trigger enhanced federal reporting requirements and institutional response protocols."
    - name: "vawa_offense_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_vawa_offense = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents classified as VAWA offenses — measures the proportion of gender-based violence incidents requiring specialized response and reporting."
    - name: "timely_warning_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN timely_warning_issued = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN clery_crime_category IN ('Murder', 'Sexual Assault', 'Robbery', 'Aggravated Assault', 'Burglary', 'Motor Vehicle Theft', 'Arson') THEN 1 END), 0), 2)
      comment: "Percentage of qualifying Clery crimes for which a timely warning was issued — direct measure of Clery Act procedural compliance; failures carry significant federal penalty risk."
    - name: "asr_inclusion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN included_in_asr = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of Clery incidents included in the Annual Security Report — measures ASR completeness; under-reporting is a federal compliance violation."
    - name: "arrest_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN arrest_made = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of Clery incidents resulting in an arrest — used to assess law enforcement response effectiveness and campus safety outcomes."
    - name: "disciplinary_referral_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN disciplinary_referral_made = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents resulting in a disciplinary referral — measures institutional accountability response to campus safety incidents."
    - name: "residential_incident_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_residential_facility = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents occurring in residential facilities — used to assess on-campus housing safety and target security resource allocation."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`compliance_ferpa_disclosure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for FERPA compliance — tracking disclosure volume, consent rates, unauthorized disclosure risk, and student notification compliance. Essential for the Registrar, Privacy Officer, and legal counsel to manage student privacy obligations."
  source: "`education_ecm`.`compliance`.`ferpa_disclosure`"
  dimensions:
    - name: "disclosure_purpose"
      expr: disclosure_purpose
      comment: "Purpose of the FERPA disclosure (e.g., Legitimate Educational Interest, Court Order, Emergency) — primary segmentation for disclosure pattern analysis."
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis authorizing the disclosure (e.g., Consent, FERPA Exception, Court Order) — used to audit disclosure authorization compliance."
    - name: "recipient_type"
      expr: recipient_type
      comment: "Type of recipient receiving the disclosed records (e.g., Parent, Employer, Government Agency) — used to analyze disclosure patterns by recipient category."
    - name: "record_type"
      expr: record_type
      comment: "Type of student record disclosed (e.g., Academic, Financial, Disciplinary) — used to assess sensitivity and risk of disclosure activity."
    - name: "disclosure_status"
      expr: disclosure_status
      comment: "Current status of the disclosure (e.g., Approved, Pending, Denied) — used to monitor disclosure pipeline and identify bottlenecks."
    - name: "consent_obtained_flag"
      expr: consent_obtained_flag
      comment: "Boolean indicating whether student consent was obtained prior to disclosure — non-consent disclosures require valid FERPA exception documentation."
    - name: "redisclosure_restriction_flag"
      expr: redisclosure_restriction_flag
      comment: "Boolean indicating whether redisclosure restrictions were communicated to the recipient — required for certain FERPA disclosures."
    - name: "student_notification_flag"
      expr: student_notification_flag
      comment: "Boolean indicating whether the student was notified of the disclosure — tracks compliance with student notification requirements."
    - name: "disclosure_year"
      expr: DATE_TRUNC('YEAR', disclosure_date)
      comment: "Year of the disclosure — used for annual FERPA compliance trend analysis and audit period reporting."
  measures:
    - name: "total_disclosures"
      expr: COUNT(1)
      comment: "Total number of FERPA disclosures — baseline volume metric for privacy program workload and audit scope."
    - name: "consent_obtained_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_obtained_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disclosures where student consent was obtained — measures the proportion of disclosures with explicit authorization vs. exception-based."
    - name: "non_consent_disclosure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_obtained_flag = FALSE OR consent_obtained_flag IS NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disclosures made without student consent — high rates require verification that valid FERPA exceptions were applied; a key audit risk indicator."
    - name: "student_notification_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN student_notification_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN student_notification_flag IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of disclosures where the student was notified — measures compliance with student notification obligations under FERPA."
    - name: "redisclosure_restriction_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN redisclosure_restriction_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disclosures where redisclosure restrictions were communicated — measures compliance with FERPA redisclosure notification requirements."
    - name: "audit_flagged_disclosure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN audit_review_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disclosures flagged for audit review — measures the proportion of disclosures requiring additional scrutiny, indicating potential compliance risk."
    - name: "unique_students_with_disclosures"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct students whose records were disclosed — measures the breadth of privacy exposure across the student population."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`compliance_accreditation_standard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for managing the institution's accreditation standards portfolio — tracking compliance status, core requirement coverage, and standard weight distribution. Used by accreditation coordinators and academic leadership to prioritize remediation and self-study preparation."
  source: "`education_ecm`.`compliance`.`accreditation_standard`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status against the standard (e.g., Compliant, Non-Compliant, Partially Compliant) — primary risk segmentation for standards portfolio."
    - name: "standard_category"
      expr: standard_category
      comment: "Category of the accreditation standard (e.g., Faculty, Curriculum, Governance, Finance) — used to analyze compliance gaps by institutional domain."
    - name: "applicability_level"
      expr: applicability_level
      comment: "Level at which the standard applies (e.g., Institutional, Program, Department) — used to scope compliance analysis."
    - name: "is_core_requirement"
      expr: is_core_requirement
      comment: "Boolean indicating whether the standard is a core/mandatory requirement — non-compliance with core requirements carries the highest accreditation risk."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the standard (e.g., Critical, High, Medium, Low) — used to focus remediation resources on highest-impact standards."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the standard became effective — used to track standards portfolio evolution and identify recently added requirements."
  measures:
    - name: "total_standards"
      expr: COUNT(1)
      comment: "Total number of accreditation standards in the portfolio — baseline for compliance coverage analysis."
    - name: "non_compliant_standard_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accreditation standards currently out of compliance — headline metric for accreditation readiness and risk exposure."
    - name: "core_requirement_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_core_requirement = TRUE AND compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN is_core_requirement = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of core/mandatory accreditation standards that are compliant — non-compliance with core requirements directly threatens accreditation status."
    - name: "total_standard_weight"
      expr: SUM(CAST(standard_weight AS DOUBLE))
      comment: "Sum of standard weights across the portfolio — used as denominator for weighted compliance scoring."
    - name: "compliant_standard_weight"
      expr: SUM(CASE WHEN compliance_status = 'Compliant' THEN CAST(standard_weight AS DOUBLE) ELSE 0 END)
      comment: "Sum of standard weights for compliant standards — numerator for weighted compliance score; reflects compliance quality adjusted for standard importance."
    - name: "avg_standard_weight"
      expr: AVG(CAST(standard_weight AS DOUBLE))
      comment: "Average weight of accreditation standards — used to identify disproportionately high-weight standards requiring focused compliance attention."
    - name: "non_compliant_core_standard_count"
      expr: SUM(CASE WHEN is_core_requirement = TRUE AND compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END)
      comment: "Absolute count of non-compliant core requirements — any non-zero value is a critical accreditation risk requiring immediate executive escalation."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`compliance_training_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for the compliance training program portfolio — tracking program cost efficiency, accessibility, certification coverage, and delivery modality mix. Used by the Chief Compliance Officer and HR leadership to optimize training investment and ensure regulatory training obligations are met."
  source: "`education_ecm`.`compliance`.`training_program`"
  dimensions:
    - name: "training_type"
      expr: training_type
      comment: "Type of training program (e.g., Mandatory Compliance, Title IX, FERPA, Safety) — primary segmentation for training portfolio analysis."
    - name: "training_program_status"
      expr: training_program_status
      comment: "Current status of the training program (e.g., Active, Inactive, Under Review) — used to filter active vs. retired programs."
    - name: "delivery_modality"
      expr: delivery_modality
      comment: "Delivery method of the training (e.g., Online, In-Person, Blended) — used to analyze modality mix and cost efficiency."
    - name: "certificate_issued_flag"
      expr: certificate_issued_flag
      comment: "Boolean indicating whether a certificate is issued upon completion — used to identify programs with formal completion documentation."
    - name: "accessibility_compliant_flag"
      expr: accessibility_compliant_flag
      comment: "Boolean indicating whether the training is ADA/Section 508 accessibility compliant — non-compliant programs create legal exposure."
    - name: "ipeds_reporting_flag"
      expr: ipeds_reporting_flag
      comment: "Boolean indicating whether the program is included in IPEDS reporting — used to ensure federal reporting completeness."
    - name: "target_audience"
      expr: target_audience
      comment: "Intended audience for the training (e.g., All Staff, Faculty, Students, Administrators) — used to analyze training coverage by population."
    - name: "vendor_name"
      expr: vendor_name
      comment: "Name of the training vendor or provider — used for vendor performance and cost benchmarking."
    - name: "effective_start_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the training program became effective — used to track program portfolio evolution over time."
  measures:
    - name: "total_training_programs"
      expr: COUNT(1)
      comment: "Total number of compliance training programs — baseline for training portfolio scope and coverage analysis."
    - name: "total_training_cost"
      expr: SUM(CAST(cost_per_learner AS DOUBLE))
      comment: "Sum of per-learner costs across all training programs — used as a proxy for total training investment when combined with enrollment data."
    - name: "avg_cost_per_learner"
      expr: AVG(CAST(cost_per_learner AS DOUBLE))
      comment: "Average cost per learner across training programs — key efficiency metric for training budget optimization and vendor benchmarking."
    - name: "avg_passing_score_threshold"
      expr: AVG(CAST(passing_score_percentage AS DOUBLE))
      comment: "Average passing score threshold across training programs — used to assess rigor consistency across the compliance training portfolio."
    - name: "total_accreditation_credit_hours"
      expr: SUM(CAST(accreditation_credit_hours AS DOUBLE))
      comment: "Total accreditation credit hours offered across training programs — measures the institution's contribution to professional development and accreditation requirements."
    - name: "accessibility_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN accessibility_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training programs that are ADA/Section 508 accessibility compliant — non-compliance creates legal exposure and limits training reach."
    - name: "certificate_program_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN certificate_issued_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training programs that issue a completion certificate — measures the proportion of programs with formal completion documentation for audit trails."
    - name: "avg_accreditation_credit_hours"
      expr: AVG(CAST(accreditation_credit_hours AS DOUBLE))
      comment: "Average accreditation credit hours per training program — used to benchmark program depth and value for professional development planning."
$$;