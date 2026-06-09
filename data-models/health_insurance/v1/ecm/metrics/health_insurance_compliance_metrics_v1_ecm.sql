-- Metric views for domain: compliance | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 18:36:19

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`compliance_audit_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit engagement metrics tracking audit activity, cost efficiency, findings severity, and remediation status across the compliance audit lifecycle."
  source: "`health_insurance_ecm`.`compliance`.`audit_engagement`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (internal, external, regulatory, etc.)"
    - name: "audit_category"
      expr: audit_category
      comment: "Category of audit engagement (financial, operational, compliance, etc.)"
    - name: "audit_engagement_status"
      expr: audit_engagement_status
      comment: "Current status of the audit engagement"
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Overall outcome/result of the audit engagement"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the audit engagement"
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Compliance framework under which the audit is conducted"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation actions following audit findings"
    - name: "audit_priority"
      expr: audit_priority
      comment: "Priority level of the audit engagement"
    - name: "audit_followup_required"
      expr: CAST(audit_followup_required AS STRING)
      comment: "Whether follow-up is required after the audit"
    - name: "audit_period_start_year"
      expr: YEAR(audit_period_start)
      comment: "Year of audit period start for trending"
    - name: "audit_period_start_quarter"
      expr: DATE_TRUNC('quarter', audit_period_start)
      comment: "Quarter of audit period start for trending"
    - name: "engagement_start_month"
      expr: DATE_TRUNC('month', engagement_start_date)
      comment: "Month of engagement start for trending"
  measures:
    - name: "total_audit_engagements"
      expr: COUNT(1)
      comment: "Total number of audit engagements — baseline volume measure for audit workload tracking"
    - name: "total_actual_audit_cost"
      expr: SUM(CAST(audit_cost_actual AS DOUBLE))
      comment: "Total actual cost incurred across all audit engagements in the period"
    - name: "total_estimated_audit_cost"
      expr: SUM(CAST(audit_cost_estimate AS DOUBLE))
      comment: "Total estimated/budgeted cost for audit engagements — used with actual cost to compute variance"
    - name: "avg_actual_audit_cost"
      expr: AVG(CAST(audit_cost_actual AS DOUBLE))
      comment: "Average actual cost per audit engagement — efficiency benchmark"
    - name: "audits_requiring_followup"
      expr: COUNT(CASE WHEN audit_followup_required = TRUE THEN 1 END)
      comment: "Number of audit engagements requiring follow-up — indicator of unresolved compliance risk"
    - name: "high_risk_audit_count"
      expr: COUNT(CASE WHEN risk_rating = 'High' OR risk_rating = 'Critical' THEN 1 END)
      comment: "Count of audits rated high or critical risk — executive escalation trigger"
    - name: "audits_with_critical_findings"
      expr: COUNT(CASE WHEN critical_findings IS NOT NULL AND critical_findings != '' THEN 1 END)
      comment: "Number of audits that surfaced critical findings requiring immediate remediation"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding metrics tracking finding volume, severity distribution, financial impact, remediation timeliness, and repeat finding rates."
  source: "`health_insurance_ecm`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type/classification of the audit finding"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the finding (critical, major, minor, observation)"
    - name: "audit_finding_status"
      expr: audit_finding_status
      comment: "Current status of the audit finding"
    - name: "compliance_area"
      expr: compliance_area
      comment: "Compliance area impacted by the finding"
    - name: "priority"
      expr: priority
      comment: "Priority assigned to the finding for remediation"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action taken for the finding"
    - name: "is_critical"
      expr: CAST(is_critical AS STRING)
      comment: "Whether the finding is classified as critical"
    - name: "is_repeat_finding"
      expr: CAST(is_repeat_finding AS STRING)
      comment: "Whether this is a repeat/recurring finding — key quality indicator"
    - name: "affected_business_area"
      expr: affected_business_area
      comment: "Business area affected by the finding"
    - name: "audit_category"
      expr: audit_category
      comment: "Category of the audit that produced this finding"
    - name: "identified_month"
      expr: DATE_TRUNC('month', identified_timestamp)
      comment: "Month when the finding was identified for trending"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings — baseline volume for compliance health assessment"
    - name: "critical_finding_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical findings — high-priority executive escalation metric"
    - name: "repeat_finding_count"
      expr: COUNT(CASE WHEN is_repeat_finding = TRUE THEN 1 END)
      comment: "Number of repeat findings — indicates systemic compliance failures requiring root cause analysis"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact amount across all findings — quantifies compliance risk exposure"
    - name: "avg_financial_impact_per_finding"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per finding — severity benchmark"
    - name: "open_findings_count"
      expr: COUNT(CASE WHEN audit_finding_status IN ('Open', 'In Progress', 'Pending') THEN 1 END)
      comment: "Count of findings still open or in progress — operational backlog indicator"
    - name: "overdue_findings_count"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE() AND audit_finding_status NOT IN ('Closed', 'Resolved', 'Completed') THEN 1 END)
      comment: "Count of findings past their due date and not yet resolved — compliance risk escalation trigger"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`compliance_breach_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HIPAA breach incident metrics tracking breach volume, severity, notification compliance, resolution timeliness, and regulatory reporting status."
  source: "`health_insurance_ecm`.`compliance`.`breach_incident`"
  dimensions:
    - name: "breach_type"
      expr: breach_type
      comment: "Type of breach (unauthorized access, theft, loss, improper disposal, etc.)"
    - name: "breach_status"
      expr: breach_status
      comment: "Current status of the breach incident"
    - name: "breach_source"
      expr: breach_source
      comment: "Source/origin of the breach (employee, vendor, system, etc.)"
    - name: "notification_type"
      expr: notification_type
      comment: "Type of notification issued for the breach"
    - name: "notification_method"
      expr: notification_method
      comment: "Method used to deliver breach notifications"
    - name: "regulatory_filing_status"
      expr: regulatory_filing_status
      comment: "Status of regulatory filing for the breach"
    - name: "business_associate_involved"
      expr: CAST(business_associate_involved AS STRING)
      comment: "Whether a business associate was involved in the breach"
    - name: "hhs_notified"
      expr: CAST(hhs_notified AS STRING)
      comment: "Whether HHS has been notified of the breach"
    - name: "state_notified"
      expr: CAST(state_notified AS STRING)
      comment: "Whether state authorities have been notified"
    - name: "breach_discovery_month"
      expr: DATE_TRUNC('month', breach_discovery_date)
      comment: "Month of breach discovery for trending"
    - name: "breach_occurrence_year"
      expr: YEAR(breach_occurrence_date)
      comment: "Year of breach occurrence for annual reporting"
  measures:
    - name: "total_breach_incidents"
      expr: COUNT(1)
      comment: "Total number of breach incidents — critical HIPAA compliance volume metric"
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score across breach incidents — overall breach severity indicator"
    - name: "breaches_with_ba_involvement"
      expr: COUNT(CASE WHEN business_associate_involved = TRUE THEN 1 END)
      comment: "Number of breaches involving business associates — BAA oversight effectiveness indicator"
    - name: "hhs_notified_breach_count"
      expr: COUNT(CASE WHEN hhs_notified = TRUE THEN 1 END)
      comment: "Number of breaches reported to HHS — regulatory reporting compliance metric"
    - name: "unresolved_breach_count"
      expr: COUNT(CASE WHEN breach_status NOT IN ('Closed', 'Resolved', 'Completed') THEN 1 END)
      comment: "Number of breaches not yet resolved — open risk exposure metric"
    - name: "breaches_pending_regulatory_filing"
      expr: COUNT(CASE WHEN regulatory_filing_status IN ('Pending', 'In Progress', 'Not Filed') THEN 1 END)
      comment: "Breaches with incomplete regulatory filings — compliance deadline risk indicator"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`compliance_corrective_action_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action plan metrics tracking CAP volume, cost, timeliness, severity distribution, and completion effectiveness."
  source: "`health_insurance_ecm`.`compliance`.`corrective_action_plan`"
  dimensions:
    - name: "corrective_action_plan_status"
      expr: corrective_action_plan_status
      comment: "Current status of the corrective action plan"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of corrective action plan"
    - name: "priority"
      expr: priority
      comment: "Priority level of the CAP"
    - name: "severity"
      expr: severity
      comment: "Severity classification of the issue being remediated"
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category the CAP addresses"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body requiring the corrective action"
    - name: "is_external_audit"
      expr: CAST(is_external_audit AS STRING)
      comment: "Whether the CAP originated from an external audit"
    - name: "is_fwa_monitoring"
      expr: CAST(is_fwa_monitoring AS STRING)
      comment: "Whether the CAP is related to fraud, waste, and abuse monitoring"
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause category of the issue"
    - name: "target_completion_month"
      expr: DATE_TRUNC('month', target_completion_date)
      comment: "Target completion month for CAP timeline tracking"
  measures:
    - name: "total_corrective_action_plans"
      expr: COUNT(1)
      comment: "Total number of corrective action plans — compliance remediation workload"
    - name: "total_actual_cap_cost"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual cost of corrective action plans — compliance remediation spend"
    - name: "total_estimated_cap_cost"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated cost of corrective action plans — budget planning baseline"
    - name: "avg_actual_cap_cost"
      expr: AVG(CAST(actual_cost_usd AS DOUBLE))
      comment: "Average actual cost per CAP — cost efficiency benchmark"
    - name: "overdue_cap_count"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE() AND corrective_action_plan_status NOT IN ('Closed', 'Completed') THEN 1 END)
      comment: "Number of CAPs past their target completion date — compliance deadline risk"
    - name: "open_cap_count"
      expr: COUNT(CASE WHEN corrective_action_plan_status IN ('Open', 'In Progress', 'Pending') THEN 1 END)
      comment: "Number of open/active corrective action plans — current remediation backlog"
    - name: "fwa_related_cap_count"
      expr: COUNT(CASE WHEN is_fwa_monitoring = TRUE THEN 1 END)
      comment: "Number of CAPs related to fraud, waste, and abuse — FWA program effectiveness indicator"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`compliance_mlr_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical Loss Ratio calculation metrics tracking MLR percentages, premium and claims volumes, rebate obligations, and ACA compliance status by market segment and line of business."
  source: "`health_insurance_ecm`.`compliance`.`mlr_calculation`"
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (individual, small group, large group)"
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment code for MLR reporting"
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for the MLR calculation"
    - name: "mlr_calculation_status"
      expr: mlr_calculation_status
      comment: "Status of the MLR calculation (draft, final, submitted, etc.)"
    - name: "rebate_disbursement_status"
      expr: rebate_disbursement_status
      comment: "Status of rebate disbursement to enrollees"
    - name: "rebate_eligibility_flag"
      expr: CAST(rebate_eligibility_flag AS STRING)
      comment: "Whether the calculation triggers a rebate obligation"
    - name: "calculation_month"
      expr: DATE_TRUNC('month', calculation_date)
      comment: "Month of MLR calculation for processing timeline tracking"
  measures:
    - name: "total_mlr_calculations"
      expr: COUNT(1)
      comment: "Total number of MLR calculations performed"
    - name: "avg_mlr_percentage"
      expr: AVG(CAST(mlr_percentage AS DOUBLE))
      comment: "Average Medical Loss Ratio percentage — core ACA compliance metric (must meet 80%/85% thresholds)"
    - name: "total_earned_premium"
      expr: SUM(CAST(earned_premium_amount AS DOUBLE))
      comment: "Total earned premium amount — revenue base for MLR calculation"
    - name: "total_incurred_claims"
      expr: SUM(CAST(incurred_claims_amount AS DOUBLE))
      comment: "Total incurred claims amount — numerator component of MLR"
    - name: "total_quality_improvement_expenses"
      expr: SUM(CAST(quality_improvement_expenses_amount AS DOUBLE))
      comment: "Total quality improvement expenses — included in MLR numerator per ACA rules"
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate amount owed to enrollees when MLR falls below threshold — direct financial liability"
    - name: "rebate_eligible_calculation_count"
      expr: COUNT(CASE WHEN rebate_eligibility_flag = TRUE THEN 1 END)
      comment: "Number of calculations triggering rebate obligations — compliance risk indicator"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`compliance_fwa_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fraud, Waste, and Abuse case metrics tracking case volume, financial exposure, recovery amounts, risk scoring, and disposition outcomes."
  source: "`health_insurance_ecm`.`compliance`.`fwa_case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of FWA case (fraud, waste, abuse)"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the FWA case"
    - name: "case_disposition"
      expr: case_disposition
      comment: "Final disposition/outcome of the FWA case"
    - name: "subject_type"
      expr: subject_type
      comment: "Type of subject under investigation (provider, member, vendor, etc.)"
    - name: "referral_source"
      expr: referral_source
      comment: "Source of the FWA referral (hotline, data analytics, audit, etc.)"
    - name: "triage_outcome"
      expr: triage_outcome
      comment: "Outcome of initial triage assessment"
    - name: "is_high_risk"
      expr: CAST(is_high_risk AS STRING)
      comment: "Whether the case is classified as high risk"
    - name: "regulatory_reporting_flag"
      expr: CAST(regulatory_reporting_flag AS STRING)
      comment: "Whether the case requires regulatory reporting"
    - name: "case_open_month"
      expr: DATE_TRUNC('month', case_open_timestamp)
      comment: "Month when the case was opened for trending"
    - name: "disposition_month"
      expr: DATE_TRUNC('month', disposition_date)
      comment: "Month of case disposition for resolution trending"
  measures:
    - name: "total_fwa_cases"
      expr: COUNT(1)
      comment: "Total number of FWA cases — program activity volume"
    - name: "total_estimated_exposure"
      expr: SUM(CAST(estimated_exposure_amount AS DOUBLE))
      comment: "Total estimated financial exposure from FWA cases — quantifies organizational risk"
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered from FWA cases — program ROI and effectiveness measure"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across FWA cases — overall risk severity indicator"
    - name: "high_risk_case_count"
      expr: COUNT(CASE WHEN is_high_risk = TRUE THEN 1 END)
      comment: "Number of high-risk FWA cases — escalation and resource allocation trigger"
    - name: "cases_requiring_regulatory_reporting"
      expr: COUNT(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 END)
      comment: "Number of cases requiring regulatory reporting — external compliance obligation tracker"
    - name: "open_case_count"
      expr: COUNT(CASE WHEN case_status IN ('Open', 'In Progress', 'Under Investigation') THEN 1 END)
      comment: "Number of currently open/active FWA cases — investigation workload indicator"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`compliance_regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission metrics tracking submission volume, timeliness, fee costs, and acceptance rates across regulatory bodies and submission types."
  source: "`health_insurance_ecm`.`compliance`.`regulatory_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission"
    - name: "regulatory_submission_status"
      expr: regulatory_submission_status
      comment: "Current status of the regulatory submission"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body receiving the submission"
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit (electronic, paper, portal, etc.)"
    - name: "is_critical"
      expr: CAST(is_critical AS STRING)
      comment: "Whether the submission is classified as critical"
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of submission for trending"
    - name: "filing_period_start_quarter"
      expr: DATE_TRUNC('quarter', filing_period_start)
      comment: "Quarter of filing period start for period-based analysis"
  measures:
    - name: "total_regulatory_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions — compliance workload volume"
    - name: "total_filing_fees"
      expr: SUM(CAST(filing_fee_amount AS DOUBLE))
      comment: "Total filing fees paid across all submissions — compliance cost tracking"
    - name: "total_net_fees"
      expr: SUM(CAST(net_fee_amount AS DOUBLE))
      comment: "Total net fee amounts after adjustments"
    - name: "rejected_submission_count"
      expr: COUNT(CASE WHEN regulatory_submission_status IN ('Rejected', 'Returned') THEN 1 END)
      comment: "Number of rejected/returned submissions — submission quality indicator"
    - name: "overdue_submission_count"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE() AND regulatory_submission_status NOT IN ('Accepted', 'Completed', 'Submitted') THEN 1 END)
      comment: "Number of submissions past their due date — regulatory deadline compliance risk"
    - name: "critical_submission_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical regulatory submissions — prioritization metric"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`compliance_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance training completion metrics tracking completion rates, assessment performance, cost, and hours invested in mandatory compliance training programs."
  source: "`health_insurance_ecm`.`compliance`.`training_completion`"
  dimensions:
    - name: "training_completion_status"
      expr: training_completion_status
      comment: "Status of the training completion record"
    - name: "training_type"
      expr: training_type
      comment: "Type of compliance training (HIPAA, FWA, ethics, etc.)"
    - name: "training_category"
      expr: training_category
      comment: "Category of training for grouping"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Whether the employee passed or failed the training assessment"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of training delivery (online, classroom, hybrid)"
    - name: "compliance_requirements_met_flag"
      expr: CAST(compliance_requirements_met_flag AS STRING)
      comment: "Whether compliance requirements were met through this training"
    - name: "is_external_training"
      expr: CAST(is_external_training AS STRING)
      comment: "Whether the training was provided by an external vendor"
    - name: "renewal_required_flag"
      expr: CAST(renewal_required_flag AS STRING)
      comment: "Whether renewal/recertification is required"
    - name: "completion_month"
      expr: DATE_TRUNC('month', completion_timestamp)
      comment: "Month of training completion for trending"
  measures:
    - name: "total_training_completions"
      expr: COUNT(1)
      comment: "Total number of training completion records — compliance training volume"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across training completions — workforce competency indicator"
    - name: "total_training_cost"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total cost of compliance training — training budget utilization"
    - name: "total_hours_completed"
      expr: SUM(CAST(hours_completed AS DOUBLE))
      comment: "Total training hours completed — workforce investment in compliance education"
    - name: "pass_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END)
      comment: "Number of training completions with passing status — used to compute pass rate"
    - name: "fail_count"
      expr: COUNT(CASE WHEN pass_fail_status = 'Fail' THEN 1 END)
      comment: "Number of training completions with failing status — identifies knowledge gaps"
    - name: "compliance_met_count"
      expr: COUNT(CASE WHEN compliance_requirements_met_flag = TRUE THEN 1 END)
      comment: "Number of completions meeting compliance requirements — regulatory readiness metric"
    - name: "distinct_employees_trained"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of distinct employees who completed training — workforce coverage metric"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`compliance_regulatory_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory change tracking metrics monitoring the volume, criticality, implementation status, and risk of regulatory changes impacting the health insurance organization."
  source: "`health_insurance_ecm`.`compliance`.`regulatory_change`"
  dimensions:
    - name: "change_category"
      expr: change_category
      comment: "Category of regulatory change"
    - name: "regulation_type"
      expr: regulation_type
      comment: "Type of regulation (federal, state, local, etc.)"
    - name: "regulatory_change_status"
      expr: regulatory_change_status
      comment: "Current status of the regulatory change tracking"
    - name: "implementation_status"
      expr: implementation_status
      comment: "Status of implementation of the regulatory change"
    - name: "compliance_area"
      expr: compliance_area
      comment: "Compliance area impacted by the regulatory change"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the regulatory change (federal, specific state, etc.)"
    - name: "governing_body"
      expr: governing_body
      comment: "Governing body issuing the regulatory change"
    - name: "is_critical"
      expr: CAST(is_critical AS STRING)
      comment: "Whether the regulatory change is classified as critical"
    - name: "effective_date_quarter"
      expr: DATE_TRUNC('quarter', effective_date)
      comment: "Quarter when the regulatory change becomes effective"
  measures:
    - name: "total_regulatory_changes"
      expr: COUNT(1)
      comment: "Total number of regulatory changes tracked — regulatory landscape complexity indicator"
    - name: "critical_change_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical regulatory changes — high-priority compliance action items"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of regulatory changes — overall regulatory risk posture"
    - name: "pending_implementation_count"
      expr: COUNT(CASE WHEN implementation_status IN ('Pending', 'In Progress', 'Not Started') THEN 1 END)
      comment: "Number of regulatory changes pending implementation — compliance readiness gap"
    - name: "overdue_implementation_count"
      expr: COUNT(CASE WHEN implementation_target_date < CURRENT_DATE() AND implementation_status NOT IN ('Completed', 'Implemented') THEN 1 END)
      comment: "Number of regulatory changes past their implementation target date — compliance deadline risk"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`compliance_hipaa_privacy_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HIPAA privacy request metrics tracking request volume, response timeliness, disposition outcomes, and appeal rates for member privacy rights compliance."
  source: "`health_insurance_ecm`.`compliance`.`hipaa_privacy_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of HIPAA privacy request (access, amendment, restriction, accounting of disclosures, etc.)"
    - name: "request_status"
      expr: request_status
      comment: "Current status of the privacy request"
    - name: "disposition"
      expr: disposition
      comment: "Disposition/outcome of the privacy request"
    - name: "request_channel"
      expr: request_channel
      comment: "Channel through which the request was received"
    - name: "request_source"
      expr: request_source
      comment: "Source of the privacy request"
    - name: "is_appealed"
      expr: CAST(is_appealed AS STRING)
      comment: "Whether the request decision was appealed"
    - name: "disclosure_recipient_type"
      expr: disclosure_recipient_type
      comment: "Type of recipient for disclosure requests"
    - name: "disclosure_purpose"
      expr: disclosure_purpose
      comment: "Purpose of the PHI disclosure"
    - name: "request_received_month"
      expr: DATE_TRUNC('month', request_received_timestamp)
      comment: "Month when the request was received for trending"
  measures:
    - name: "total_privacy_requests"
      expr: COUNT(1)
      comment: "Total number of HIPAA privacy requests — member rights compliance volume"
    - name: "appealed_request_count"
      expr: COUNT(CASE WHEN is_appealed = TRUE THEN 1 END)
      comment: "Number of privacy requests that were appealed — quality of initial decision-making indicator"
    - name: "overdue_response_count"
      expr: COUNT(CASE WHEN response_due_date < CURRENT_DATE() AND request_status NOT IN ('Completed', 'Closed', 'Responded') THEN 1 END)
      comment: "Number of privacy requests past their response due date — HIPAA compliance deadline risk"
    - name: "denied_request_count"
      expr: COUNT(CASE WHEN disposition = 'Denied' THEN 1 END)
      comment: "Number of denied privacy requests — potential member satisfaction and compliance review trigger"
    - name: "distinct_members_requesting"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Number of distinct members submitting privacy requests — member engagement with privacy rights"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`compliance_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory obligation metrics tracking obligation volume, compliance status, risk exposure, penalty amounts, and filing timeliness across the regulatory landscape."
  source: "`health_insurance_ecm`.`compliance`.`compliance_regulatory_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation"
    - name: "compliance_regulatory_obligation_status"
      expr: compliance_regulatory_obligation_status
      comment: "Current status of the regulatory obligation"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status (compliant, non-compliant, partially compliant)"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework (ACA, HIPAA, ERISA, state-specific, etc.)"
    - name: "governing_body"
      expr: governing_body
      comment: "Governing body overseeing the obligation"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the obligation"
    - name: "is_federal"
      expr: CAST(is_federal AS STRING)
      comment: "Whether the obligation is federal-level"
    - name: "is_state_specific"
      expr: CAST(is_state_specific AS STRING)
      comment: "Whether the obligation is state-specific"
    - name: "filing_status"
      expr: filing_status
      comment: "Filing status of the obligation"
    - name: "risk_impact"
      expr: risk_impact
      comment: "Risk impact level of non-compliance"
    - name: "frequency"
      expr: frequency
      comment: "Reporting/compliance frequency"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of regulatory obligations — regulatory burden measure"
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total potential penalty amount across all obligations — maximum financial risk exposure"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across obligations — overall compliance risk posture"
    - name: "non_compliant_obligation_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of obligations in non-compliant status — critical executive escalation metric"
    - name: "overdue_obligation_count"
      expr: COUNT(CASE WHEN next_due_date < CURRENT_DATE() AND compliance_status != 'Compliant' THEN 1 END)
      comment: "Number of obligations past their next due date — regulatory deadline risk"
    - name: "federal_obligation_count"
      expr: COUNT(CASE WHEN is_federal = TRUE THEN 1 END)
      comment: "Number of federal-level obligations — federal compliance scope indicator"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`compliance_policy_document`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy document lifecycle metrics tracking policy volume, review currency, expiration risk, and approval status to ensure governance documentation remains current and compliant."
  source: "`health_insurance_ecm`.`compliance`.`policy_document`"
  dimensions:
    - name: "policy_document_category"
      expr: policy_document_category
      comment: "Category of the policy document"
    - name: "policy_document_status"
      expr: policy_document_status
      comment: "Current status of the policy document"
    - name: "compliance_area"
      expr: compliance_area
      comment: "Compliance area the policy covers"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the policy document"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the policy"
    - name: "is_active"
      expr: CAST(is_active AS STRING)
      comment: "Whether the policy is currently active"
    - name: "policy_owner_department"
      expr: policy_owner_department
      comment: "Department owning the policy"
    - name: "review_type"
      expr: review_type
      comment: "Type of review conducted on the policy"
  measures:
    - name: "total_policy_documents"
      expr: COUNT(1)
      comment: "Total number of policy documents — governance documentation scope"
    - name: "active_policy_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active policies — operational governance coverage"
    - name: "expired_policy_count"
      expr: COUNT(CASE WHEN expiration_date < CURRENT_DATE() AND is_active = TRUE THEN 1 END)
      comment: "Number of active policies past their expiration date — governance gap risk"
    - name: "policies_due_for_review"
      expr: COUNT(CASE WHEN next_review_date <= CURRENT_DATE() THEN 1 END)
      comment: "Number of policies due for review — governance currency indicator"
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status IN ('Pending', 'In Review', 'Draft') THEN 1 END)
      comment: "Number of policies pending approval — governance pipeline backlog"
$$;