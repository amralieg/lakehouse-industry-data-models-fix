-- Metric views for domain: compliance | Business: Construction | Version: 1 | Generated on: 2026-05-07 09:21:54

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`compliance_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for permit portfolio management — tracks permit health, financial exposure from fees, expiry risk, and suspension/revocation rates to support regulatory compliance governance."
  source: "`construction_ecm`.`compliance`.`permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Classification of the permit (e.g. environmental, building, excavation) for portfolio segmentation."
    - name: "permit_category"
      expr: permit_category
      comment: "Broader category grouping permits for executive-level compliance reporting."
    - name: "compliance_permit_status"
      expr: compliance_permit_status
      comment: "Current lifecycle status of the permit (e.g. active, expired, revoked) for operational triage."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification assigned to the permit, enabling prioritisation of high-risk permit renewals."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the permit is currently active, used to filter live portfolio views."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Flags permits requiring renewal action, driving proactive compliance calendar management."
    - name: "suspension_flag"
      expr: suspension_flag
      comment: "Indicates permits currently suspended, a leading indicator of regulatory enforcement risk."
    - name: "fee_currency"
      expr: fee_currency
      comment: "Currency of permit fees for multi-currency financial reporting."
    - name: "expiry_year_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month-level bucketing of permit expiry dates to identify renewal concentration and workload peaks."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the permit was issued, supporting trend analysis of permit acquisition activity."
  measures:
    - name: "total_active_permits"
      expr: COUNT(CASE WHEN is_active = TRUE THEN permit_id END)
      comment: "Total number of currently active permits. Executives use this to gauge regulatory coverage and exposure across the project portfolio."
    - name: "total_permits"
      expr: COUNT(permit_id)
      comment: "Total permit count across all statuses, providing the denominator for compliance rate calculations."
    - name: "expiring_permits_90_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND is_active = TRUE THEN permit_id END)
      comment: "Number of active permits expiring within 90 days. A critical operational trigger for renewal workflows to avoid project stoppages."
    - name: "suspended_permit_count"
      expr: COUNT(CASE WHEN suspension_flag = TRUE THEN permit_id END)
      comment: "Count of permits currently suspended. Elevated values signal active regulatory enforcement risk requiring executive escalation."
    - name: "total_permit_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total permit fee expenditure. Directly informs compliance budget planning and cost-of-regulatory-compliance reporting."
    - name: "avg_permit_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average permit fee per permit, used to benchmark regulatory cost efficiency across project types and jurisdictions."
    - name: "permits_pending_renewal"
      expr: COUNT(CASE WHEN renewal_required_flag = TRUE AND is_active = TRUE THEN permit_id END)
      comment: "Number of active permits flagged for renewal. Drives proactive compliance calendar prioritisation to prevent lapses."
    - name: "fee_paid_permit_count"
      expr: COUNT(CASE WHEN fee_paid_flag = TRUE THEN permit_id END)
      comment: "Count of permits where fees have been paid, used to track financial compliance obligations fulfilment."
    - name: "unpaid_fee_permit_count"
      expr: COUNT(CASE WHEN fee_paid_flag = FALSE OR fee_paid_flag IS NULL THEN permit_id END)
      comment: "Count of permits with outstanding fee payments. Unpaid fees risk permit suspension and project delays."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`compliance_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance assessment performance KPIs — measures assessment outcomes, penalty exposure, rating scores, and gap identification rates to steer the organisation's compliance posture."
  source: "`construction_ecm`.`compliance`.`assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of compliance assessment (e.g. internal audit, regulatory inspection) for segmented performance analysis."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Regulatory or operational category of the assessment, enabling domain-specific compliance tracking."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (e.g. open, closed, in-review) for workload and backlog management."
    - name: "compliance_status_overall"
      expr: compliance_status_overall
      comment: "Overall compliance determination from the assessment, the primary executive-level compliance health indicator."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification of the assessment finding, used to prioritise remediation resources."
    - name: "is_critical"
      expr: is_critical
      comment: "Flags assessments with critical findings requiring immediate executive attention and escalation."
    - name: "is_external_audit"
      expr: is_external_audit
      comment: "Distinguishes external regulatory audits from internal assessments for separate performance benchmarking."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the assessment, enabling geographic compliance risk analysis."
    - name: "compliance_rating"
      expr: compliance_rating
      comment: "Qualitative compliance rating assigned (e.g. satisfactory, unsatisfactory) for executive dashboard roll-ups."
    - name: "assessment_year_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month-level bucketing of assessment dates for trend analysis of compliance activity volume."
  measures:
    - name: "total_assessments"
      expr: COUNT(assessment_id)
      comment: "Total number of compliance assessments conducted. Baseline measure for compliance programme activity volume."
    - name: "critical_assessment_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN assessment_id END)
      comment: "Number of assessments flagged as critical. A key risk indicator that triggers executive escalation and resource reallocation."
    - name: "external_audit_count"
      expr: COUNT(CASE WHEN is_external_audit = TRUE THEN assessment_id END)
      comment: "Count of external regulatory audits. Elevated counts signal heightened regulatory scrutiny requiring strategic response."
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalty exposure identified across all assessments. Directly informs risk provisioning and compliance investment decisions."
    - name: "avg_penalty_per_assessment"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per assessment, used to benchmark regulatory risk severity and prioritise high-exposure areas."
    - name: "avg_compliance_rating_score"
      expr: AVG(CAST(rating_score AS DOUBLE))
      comment: "Average compliance rating score across assessments. The primary quantitative KPI for overall compliance programme health, tracked at board level."
    - name: "assessments_with_gaps"
      expr: COUNT(CASE WHEN gaps_identified IS NOT NULL AND gaps_identified <> '' THEN assessment_id END)
      comment: "Number of assessments where compliance gaps were identified. Drives remediation planning and resource allocation decisions."
    - name: "assessments_with_mitigation_plan"
      expr: COUNT(CASE WHEN mitigation_plan IS NOT NULL AND mitigation_plan <> '' THEN assessment_id END)
      comment: "Count of assessments that have an associated mitigation plan, measuring the organisation's remediation response rate."
    - name: "overdue_next_assessment_count"
      expr: COUNT(CASE WHEN next_assessment_due_date < CURRENT_DATE AND assessment_status <> 'Closed' THEN assessment_id END)
      comment: "Number of assessments where the next scheduled assessment is overdue. A compliance calendar health indicator that signals programme gaps."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`compliance_authority_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory enforcement KPIs tracking authority notices, penalty exposure, response compliance, and resolution outcomes — critical for managing regulatory relationships and enforcement risk."
  source: "`construction_ecm`.`compliance`.`authority_notice`"
  dimensions:
    - name: "notice_type"
      expr: notice_type
      comment: "Type of regulatory notice issued (e.g. infringement, stop-work, improvement) for enforcement category analysis."
    - name: "authority_type"
      expr: authority_type
      comment: "Classification of the issuing authority (e.g. environmental, safety, planning) for jurisdictional risk segmentation."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the notice, used to prioritise response resources and escalation paths."
    - name: "authority_notice_status"
      expr: authority_notice_status
      comment: "Current status of the notice (e.g. open, resolved, appealed) for operational triage and reporting."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Regulatory category of the breach, enabling domain-specific enforcement trend analysis."
    - name: "appeal_lodged_flag"
      expr: appeal_lodged_flag
      comment: "Indicates whether an appeal has been lodged, informing legal strategy and dispute resolution resource planning."
    - name: "response_submitted_flag"
      expr: response_submitted_flag
      comment: "Flags whether a formal response has been submitted, tracking regulatory response compliance."
    - name: "penalty_currency"
      expr: penalty_currency
      comment: "Currency of the penalty for multi-currency financial exposure reporting."
    - name: "notice_year_month"
      expr: DATE_TRUNC('MONTH', notice_date)
      comment: "Month-level bucketing of notice dates for enforcement trend analysis and seasonal pattern detection."
  measures:
    - name: "total_authority_notices"
      expr: COUNT(authority_notice_id)
      comment: "Total number of regulatory authority notices received. A primary indicator of regulatory enforcement exposure across the project portfolio."
    - name: "open_notice_count"
      expr: COUNT(CASE WHEN authority_notice_status NOT IN ('Resolved', 'Closed') THEN authority_notice_id END)
      comment: "Number of unresolved authority notices. Elevated open counts signal active regulatory risk requiring executive intervention."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties levied by regulatory authorities. A direct measure of regulatory non-compliance cost, reported at board level."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per notice, used to benchmark enforcement severity and assess whether compliance investment is proportionate."
    - name: "response_compliance_count"
      expr: COUNT(CASE WHEN response_submitted_flag = TRUE THEN authority_notice_id END)
      comment: "Count of notices where a formal response was submitted on time. Measures the organisation's regulatory responsiveness."
    - name: "overdue_response_count"
      expr: COUNT(CASE WHEN response_submitted_flag = FALSE AND response_deadline < CURRENT_DATE THEN authority_notice_id END)
      comment: "Number of notices where the response deadline has passed without submission. A critical compliance failure indicator triggering immediate escalation."
    - name: "appeal_count"
      expr: COUNT(CASE WHEN appeal_lodged_flag = TRUE THEN authority_notice_id END)
      comment: "Number of notices where an appeal has been lodged. Informs legal resource planning and regulatory relationship management strategy."
    - name: "notices_with_remediation_required"
      expr: COUNT(CASE WHEN remediation_required IS NOT NULL AND remediation_required <> '' THEN authority_notice_id END)
      comment: "Count of notices requiring active remediation. Drives corrective action planning and resource allocation for compliance recovery."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`compliance_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance action execution KPIs — tracks corrective action completion rates, cost performance, overdue actions, and repeat violations to measure the effectiveness of the compliance response programme."
  source: "`construction_ecm`.`compliance`.`action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of compliance action (e.g. corrective, preventive, monitoring) for categorised performance tracking."
    - name: "compliance_action_status"
      expr: compliance_action_status
      comment: "Current status of the action (e.g. open, in-progress, closed) for workload and backlog management."
    - name: "compliance_area"
      expr: compliance_area
      comment: "Regulatory or operational area the action addresses, enabling domain-specific remediation performance analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the action, used to ensure high-priority compliance actions receive adequate resource focus."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification of the action, supporting risk-weighted compliance performance reporting."
    - name: "is_external"
      expr: is_external
      comment: "Distinguishes externally mandated actions (regulatory) from internal actions for separate performance benchmarking."
    - name: "is_repeat_action"
      expr: is_repeat_action
      comment: "Flags repeat compliance actions, a leading indicator of systemic compliance failures requiring root-cause intervention."
    - name: "monitoring_required"
      expr: monitoring_required
      comment: "Indicates whether ongoing monitoring is required post-action, informing long-term compliance oversight resource planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of action costs for multi-currency financial reporting."
    - name: "due_year_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month-level bucketing of action due dates for workload forecasting and compliance calendar management."
  measures:
    - name: "total_actions"
      expr: COUNT(action_id)
      comment: "Total compliance actions raised. Baseline measure for compliance programme workload and activity volume."
    - name: "open_action_count"
      expr: COUNT(CASE WHEN compliance_action_status NOT IN ('Closed', 'Completed') THEN action_id END)
      comment: "Number of open compliance actions. A primary operational KPI for compliance backlog management and resource allocation."
    - name: "overdue_action_count"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE AND compliance_action_status NOT IN ('Closed', 'Completed') THEN action_id END)
      comment: "Number of compliance actions past their due date without closure. A critical risk indicator that triggers executive escalation."
    - name: "repeat_action_count"
      expr: COUNT(CASE WHEN is_repeat_action = TRUE THEN action_id END)
      comment: "Count of repeat compliance actions, indicating systemic non-compliance. Elevated counts signal root-cause failures requiring strategic intervention."
    - name: "total_actual_cost"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual cost incurred for compliance actions. Directly informs compliance programme budget performance and cost-of-non-compliance reporting."
    - name: "total_estimated_cost"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of compliance actions, used as the budget baseline for cost variance analysis."
    - name: "avg_actual_cost_per_action"
      expr: AVG(CAST(cost_actual AS DOUBLE))
      comment: "Average actual cost per compliance action, benchmarking remediation efficiency and informing future cost provisioning."
    - name: "external_action_count"
      expr: COUNT(CASE WHEN is_external = TRUE THEN action_id END)
      comment: "Count of externally mandated compliance actions. Tracks regulatory enforcement burden and informs external authority relationship management."
    - name: "actions_requiring_monitoring"
      expr: COUNT(CASE WHEN monitoring_required = TRUE THEN action_id END)
      comment: "Number of actions requiring ongoing monitoring. Drives long-term compliance oversight resource planning and monitoring programme sizing."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`compliance_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory obligation portfolio KPIs — tracks obligation compliance status, penalty exposure, review currency, and mandatory obligation coverage to ensure the organisation meets all legal and regulatory requirements."
  source: "`construction_ecm`.`compliance`.`regulatory_obligation`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the obligation (e.g. compliant, non-compliant, under-review) for portfolio health reporting."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification of the obligation, enabling risk-weighted compliance portfolio management."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the obligation for geographic compliance risk analysis and multi-jurisdiction reporting."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Distinguishes mandatory legal obligations from discretionary ones, ensuring mandatory obligations receive priority compliance focus."
    - name: "is_active"
      expr: is_active
      comment: "Filters to currently active obligations, ensuring compliance monitoring focuses on live regulatory requirements."
    - name: "penalty_type"
      expr: penalty_type
      comment: "Type of penalty applicable for non-compliance (e.g. financial, operational, criminal) for risk severity segmentation."
    - name: "compliance_evidence_status"
      expr: compliance_evidence_status
      comment: "Status of compliance evidence collection, tracking whether obligations have documented proof of compliance."
    - name: "data_classification"
      expr: data_classification
      comment: "Data sensitivity classification of the obligation for information governance and audit trail management."
    - name: "penalty_currency"
      expr: penalty_currency
      comment: "Currency of the penalty for multi-currency financial exposure reporting."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the obligation became effective, supporting trend analysis of regulatory burden growth over time."
  measures:
    - name: "total_active_obligations"
      expr: COUNT(CASE WHEN is_active = TRUE THEN regulatory_obligation_id END)
      comment: "Total number of active regulatory obligations. The baseline measure for understanding the organisation's full regulatory compliance burden."
    - name: "non_compliant_obligation_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' AND is_active = TRUE THEN regulatory_obligation_id END)
      comment: "Number of active obligations currently in non-compliant status. A primary risk KPI that directly triggers executive escalation and remediation investment."
    - name: "mandatory_obligation_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE AND is_active = TRUE THEN regulatory_obligation_id END)
      comment: "Count of active mandatory obligations. Ensures the compliance programme is sized to cover all legally required obligations."
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalty exposure across all regulatory obligations. A critical board-level risk metric informing compliance investment and risk provisioning decisions."
    - name: "avg_penalty_per_obligation"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty per obligation, used to benchmark regulatory risk severity and prioritise high-exposure obligation areas."
    - name: "obligations_overdue_review"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE AND is_active = TRUE THEN regulatory_obligation_id END)
      comment: "Number of active obligations where the scheduled review is overdue. Signals compliance programme gaps and regulatory currency risk."
    - name: "obligations_expiring_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND is_active = TRUE THEN regulatory_obligation_id END)
      comment: "Active obligations expiring within 90 days. Drives proactive renewal and re-registration workflows to prevent compliance lapses."
    - name: "obligations_without_evidence"
      expr: COUNT(CASE WHEN (compliance_evidence_status IS NULL OR compliance_evidence_status = '') AND is_active = TRUE THEN regulatory_obligation_id END)
      comment: "Count of active obligations lacking compliance evidence. Directly measures audit readiness and evidence management programme effectiveness."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`compliance_env_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental monitoring KPIs — tracks exceedance rates, measured values against thresholds, corrective action status, and monitoring coverage to manage environmental compliance and regulatory reporting obligations."
  source: "`construction_ecm`.`compliance`.`env_monitoring`"
  dimensions:
    - name: "monitoring_type"
      expr: monitoring_type
      comment: "Type of environmental monitoring (e.g. air quality, noise, water, soil) for domain-specific compliance analysis."
    - name: "parameter"
      expr: parameter
      comment: "Specific environmental parameter being monitored (e.g. PM2.5, NOx, pH) for granular exceedance analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance determination for the monitoring record (e.g. compliant, non-compliant) for regulatory reporting."
    - name: "exceedance_flag"
      expr: exceedance_flag
      comment: "Flags monitoring records where measured values exceeded regulatory thresholds, the primary environmental risk indicator."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions taken in response to exceedances, tracking environmental remediation effectiveness."
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of measurement for the monitored parameter, ensuring correct interpretation of measured values."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority governing the monitoring requirement, enabling authority-specific compliance reporting."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality classification of the monitoring record, ensuring only validated data is used in regulatory submissions."
    - name: "monitoring_year_month"
      expr: DATE_TRUNC('MONTH', monitoring_timestamp)
      comment: "Month-level bucketing of monitoring timestamps for trend analysis of environmental parameter performance over time."
  measures:
    - name: "total_monitoring_records"
      expr: COUNT(env_monitoring_id)
      comment: "Total environmental monitoring readings recorded. Baseline measure for monitoring programme coverage and data collection activity."
    - name: "exceedance_count"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE THEN env_monitoring_id END)
      comment: "Number of monitoring records where regulatory thresholds were exceeded. The primary environmental compliance risk KPI reported to regulators and executives."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across monitoring records. Tracks environmental parameter trends against regulatory thresholds to anticipate future exceedances."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average regulatory threshold value across monitoring records, providing the benchmark context for measured value analysis."
    - name: "max_measured_value"
      expr: MAX(CAST(measured_value AS DOUBLE))
      comment: "Maximum measured value recorded, identifying peak environmental impact events that may trigger regulatory reporting obligations."
    - name: "exceedances_without_corrective_action"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE AND (corrective_action IS NULL OR corrective_action = '') THEN env_monitoring_id END)
      comment: "Exceedances with no corrective action recorded. A critical compliance gap indicator — unaddressed exceedances risk regulatory enforcement action."
    - name: "distinct_parameters_monitored"
      expr: COUNT(DISTINCT parameter)
      comment: "Number of distinct environmental parameters being monitored, measuring the breadth of the environmental monitoring programme."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`compliance_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission KPIs — tracks submission volumes, on-time submission rates, fee expenditure, and acknowledgement receipt to manage regulatory reporting obligations and avoid enforcement penalties."
  source: "`construction_ecm`.`compliance`.`regulatory_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (e.g. environmental report, permit renewal, safety notification) for category-level performance tracking."
    - name: "regulatory_submission_status"
      expr: regulatory_submission_status
      comment: "Current status of the submission (e.g. submitted, acknowledged, rejected) for operational pipeline management."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Regulatory compliance category of the submission for domain-specific reporting performance analysis."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit (e.g. online portal, paper, email) for process efficiency benchmarking."
    - name: "acknowledgement_received"
      expr: acknowledgement_received
      comment: "Flags whether the regulatory authority has acknowledged receipt, confirming submission was successfully lodged."
    - name: "is_confidential"
      expr: is_confidential
      comment: "Indicates confidential submissions requiring restricted access controls for information governance compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of submission fees for multi-currency financial reporting."
    - name: "submission_year_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month-level bucketing of submission dates for regulatory reporting workload trend analysis."
    - name: "submitter_role"
      expr: submitter_role
      comment: "Role of the person who submitted the report, used for accountability tracking and workload distribution analysis."
  measures:
    - name: "total_submissions"
      expr: COUNT(regulatory_submission_id)
      comment: "Total regulatory submissions made. Baseline measure for regulatory reporting programme activity and compliance obligation fulfilment."
    - name: "acknowledged_submission_count"
      expr: COUNT(CASE WHEN acknowledgement_received = TRUE THEN regulatory_submission_id END)
      comment: "Number of submissions formally acknowledged by the regulatory authority. Confirms successful lodgement and reduces enforcement risk."
    - name: "unacknowledged_submission_count"
      expr: COUNT(CASE WHEN acknowledgement_received = FALSE OR acknowledgement_received IS NULL THEN regulatory_submission_id END)
      comment: "Submissions not yet acknowledged by the regulator. Unacknowledged submissions carry enforcement risk and require active follow-up."
    - name: "total_submission_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees paid for regulatory submissions. Informs compliance programme cost management and regulatory fee budget planning."
    - name: "avg_submission_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average fee per regulatory submission, used to benchmark regulatory cost efficiency and forecast future submission budgets."
    - name: "submissions_with_attachments"
      expr: COUNT(CASE WHEN attachment_flag = TRUE THEN regulatory_submission_id END)
      comment: "Count of submissions with supporting documentation attached. Measures evidence completeness in regulatory submissions, reducing rejection risk."
    - name: "distinct_projects_with_submissions"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct construction projects with regulatory submissions, measuring the breadth of regulatory reporting coverage across the project portfolio."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`compliance_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance calendar KPIs — tracks deadline adherence, overdue obligations, escalation rates, and reminder effectiveness to ensure the organisation meets all scheduled regulatory and compliance commitments."
  source: "`construction_ecm`.`compliance`.`compliance_calendar`"
  dimensions:
    - name: "compliance_calendar_status"
      expr: compliance_calendar_status
      comment: "Current status of the calendar entry (e.g. pending, completed, overdue) for operational compliance schedule management."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Regulatory or operational category of the calendar entry for domain-specific deadline tracking."
    - name: "deadline_type"
      expr: deadline_type
      comment: "Type of deadline (e.g. submission, renewal, inspection) for workload categorisation and resource planning."
    - name: "priority"
      expr: priority
      comment: "Priority level of the calendar entry, ensuring high-priority compliance deadlines receive adequate attention."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification of the calendar entry, enabling risk-weighted compliance schedule management."
    - name: "overdue_flag"
      expr: overdue_flag
      comment: "Flags calendar entries that are past their deadline without completion, the primary compliance schedule health indicator."
    - name: "escalation_triggered_flag"
      expr: escalation_triggered_flag
      comment: "Indicates whether an escalation has been triggered for the entry, tracking compliance escalation programme effectiveness."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the compliance obligation for geographic deadline management and multi-jurisdiction reporting."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority associated with the deadline for authority-specific compliance calendar reporting."
    - name: "deadline_year_month"
      expr: DATE_TRUNC('MONTH', deadline_date)
      comment: "Month-level bucketing of deadlines for workload forecasting and compliance calendar capacity planning."
  measures:
    - name: "total_calendar_entries"
      expr: COUNT(compliance_calendar_id)
      comment: "Total compliance calendar entries. Baseline measure for the volume of scheduled compliance obligations across the organisation."
    - name: "overdue_entry_count"
      expr: COUNT(CASE WHEN overdue_flag = TRUE THEN compliance_calendar_id END)
      comment: "Number of overdue compliance calendar entries. A primary compliance health KPI — elevated overdue counts signal systemic schedule management failures."
    - name: "escalated_entry_count"
      expr: COUNT(CASE WHEN escalation_triggered_flag = TRUE THEN compliance_calendar_id END)
      comment: "Count of calendar entries where escalation has been triggered. Measures the severity of compliance schedule failures requiring management intervention."
    - name: "completed_entry_count"
      expr: COUNT(CASE WHEN compliance_calendar_status = 'Completed' THEN compliance_calendar_id END)
      comment: "Number of compliance calendar entries successfully completed. The primary measure of compliance schedule adherence and programme effectiveness."
    - name: "upcoming_deadlines_30_days"
      expr: COUNT(CASE WHEN deadline_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) AND compliance_calendar_status <> 'Completed' THEN compliance_calendar_id END)
      comment: "Pending compliance deadlines due within 30 days. A forward-looking operational KPI driving proactive compliance workload management."
    - name: "reminder_sent_count"
      expr: COUNT(CASE WHEN reminder_sent_flag = TRUE THEN compliance_calendar_id END)
      comment: "Count of entries where reminders have been sent, measuring the effectiveness of the proactive compliance notification programme."
    - name: "distinct_projects_in_calendar"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct construction projects with active compliance calendar entries, measuring the breadth of compliance schedule coverage across the portfolio."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`compliance_permit_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Permit condition compliance KPIs — tracks condition fulfilment rates, financial penalties from condition breaches, inspection currency, and mandatory condition coverage to manage permit compliance obligations."
  source: "`construction_ecm`.`compliance`.`permit_condition`"
  dimensions:
    - name: "condition_type"
      expr: condition_type
      comment: "Type of permit condition (e.g. environmental, operational, reporting) for category-level compliance performance analysis."
    - name: "condition_category"
      expr: condition_category
      comment: "Broader category grouping of permit conditions for executive-level compliance reporting."
    - name: "permit_condition_status"
      expr: permit_condition_status
      comment: "Current status of the permit condition (e.g. compliant, non-compliant, pending) for operational triage."
    - name: "condition_priority"
      expr: condition_priority
      comment: "Priority level of the condition, ensuring high-priority permit conditions receive adequate compliance focus."
    - name: "condition_is_mandatory"
      expr: condition_is_mandatory
      comment: "Distinguishes mandatory permit conditions from discretionary ones, ensuring mandatory conditions are tracked with highest priority."
    - name: "inspection_required"
      expr: inspection_required
      comment: "Flags conditions requiring physical inspection, driving inspection scheduling and resource planning."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of compliance reporting required for the condition (e.g. monthly, quarterly, annual) for reporting workload planning."
    - name: "source_agency"
      expr: source_agency
      comment: "Regulatory agency that imposed the condition, enabling agency-specific compliance performance reporting."
    - name: "compliance_deadline_year_month"
      expr: DATE_TRUNC('MONTH', compliance_deadline)
      comment: "Month-level bucketing of condition compliance deadlines for workload forecasting and deadline management."
  measures:
    - name: "total_permit_conditions"
      expr: COUNT(permit_condition_id)
      comment: "Total number of permit conditions across the portfolio. Baseline measure for the scope of permit compliance obligations."
    - name: "non_compliant_condition_count"
      expr: COUNT(CASE WHEN permit_condition_status = 'Non-Compliant' THEN permit_condition_id END)
      comment: "Number of permit conditions currently in non-compliant status. A primary permit compliance risk KPI that can trigger permit suspension or revocation."
    - name: "mandatory_non_compliant_count"
      expr: COUNT(CASE WHEN condition_is_mandatory = TRUE AND permit_condition_status = 'Non-Compliant' THEN permit_condition_id END)
      comment: "Non-compliant mandatory permit conditions — the highest-severity compliance failure indicator, directly risking permit revocation and project stoppage."
    - name: "total_condition_penalties"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties associated with permit condition breaches. Directly measures the cost of permit non-compliance for financial risk reporting."
    - name: "total_condition_fines"
      expr: SUM(CAST(condition_fine_amount AS DOUBLE))
      comment: "Total fines levied for permit condition violations. Complements penalty_amount to provide full financial exposure from permit condition non-compliance."
    - name: "overdue_inspection_count"
      expr: COUNT(CASE WHEN inspection_required = TRUE AND inspection_next_date < CURRENT_DATE THEN permit_condition_id END)
      comment: "Permit conditions where the next required inspection is overdue. Overdue inspections risk permit suspension and regulatory enforcement action."
    - name: "conditions_with_evidence"
      expr: COUNT(CASE WHEN compliance_evidence_url IS NOT NULL AND compliance_evidence_url <> '' THEN permit_condition_id END)
      comment: "Count of permit conditions with documented compliance evidence. Measures audit readiness and evidence management programme effectiveness."
$$;