-- Metric views for domain: compliance | Business: Retail | Version: 1 | Generated on: 2026-05-04 11:04:04

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`compliance_audit_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit event performance and outcome metrics for compliance monitoring and audit effectiveness analysis"
  source: "`retail_ecm`.`compliance`.`audit_event`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted (internal, external, regulatory, etc.)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit event"
    - name: "audit_result"
      expr: audit_result
      comment: "Overall result or outcome of the audit"
    - name: "audit_method"
      expr: audit_method
      comment: "Method used to conduct the audit"
    - name: "audit_scope"
      expr: audit_scope
      comment: "Scope of the audit engagement"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework under which the audit was conducted"
    - name: "audit_year"
      expr: YEAR(audit_date)
      comment: "Year the audit was conducted"
    - name: "audit_quarter"
      expr: CONCAT('Q', QUARTER(audit_date))
      comment: "Quarter the audit was conducted"
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month the audit was conducted"
    - name: "corrective_action_required"
      expr: corrective_action_plan_required_flag
      comment: "Whether corrective action plan is required"
    - name: "follow_up_required"
      expr: follow_up_required_flag
      comment: "Whether follow-up audit is required"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audit events conducted"
    - name: "total_audit_hours"
      expr: SUM(CAST(audit_duration_hours AS DOUBLE))
      comment: "Total hours spent on audits"
    - name: "avg_audit_duration_hours"
      expr: AVG(CAST(audit_duration_hours AS DOUBLE))
      comment: "Average duration of audits in hours"
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score across all audits"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS BIGINT))
      comment: "Total number of critical findings identified across all audits"
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS BIGINT))
      comment: "Total number of major findings identified across all audits"
    - name: "total_minor_findings"
      expr: SUM(CAST(minor_findings_count AS BIGINT))
      comment: "Total number of minor findings identified across all audits"
    - name: "total_findings"
      expr: SUM(CAST(total_findings_count AS BIGINT))
      comment: "Total number of all findings identified across all audits"
    - name: "audits_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_plan_required_flag = TRUE THEN 1 END)
      comment: "Number of audits requiring corrective action plans"
    - name: "audits_requiring_follow_up"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Number of audits requiring follow-up"
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_plan_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring corrective action plans"
    - name: "follow_up_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring follow-up"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding severity, resolution, and financial impact metrics for compliance risk management"
  source: "`retail_ecm`.`compliance`.`audit_finding`"
  dimensions:
    - name: "audit_finding_category"
      expr: audit_finding_category
      comment: "Category of the audit finding"
    - name: "audit_finding_status"
      expr: audit_finding_status
      comment: "Current status of the audit finding"
    - name: "affected_area"
      expr: affected_area
      comment: "Business area affected by the finding"
    - name: "regulatory_standard"
      expr: regulatory_standard
      comment: "Regulatory standard violated or referenced"
    - name: "corrective_action_required"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a recurring finding"
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required_flag
      comment: "Whether regulatory reporting is required"
    - name: "identified_year"
      expr: YEAR(identified_date)
      comment: "Year the finding was identified"
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the finding was identified"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for financial impact"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of all findings"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per finding"
    - name: "findings_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of findings requiring corrective action"
    - name: "recurring_findings"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of recurring findings"
    - name: "findings_requiring_regulatory_report"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 END)
      comment: "Number of findings requiring regulatory reporting"
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings requiring corrective action"
    - name: "recurrence_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are recurring"
    - name: "closed_findings"
      expr: COUNT(CASE WHEN closed_date IS NOT NULL THEN 1 END)
      comment: "Number of findings that have been closed"
    - name: "closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN closed_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that have been closed"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`compliance_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action effectiveness, completion, and cost metrics for compliance remediation tracking"
  source: "`retail_ecm`.`compliance`.`corrective_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Current status of the corrective action"
    - name: "priority"
      expr: priority
      comment: "Priority level of the corrective action"
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category of the corrective action"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the corrective action"
    - name: "escalation_required"
      expr: escalation_required
      comment: "Whether escalation is required"
    - name: "external_reporting_required"
      expr: external_reporting_required
      comment: "Whether external reporting is required"
    - name: "effectiveness_rating"
      expr: effectiveness_rating
      comment: "Effectiveness rating of the corrective action"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for cost tracking"
    - name: "target_completion_year"
      expr: YEAR(target_completion_date)
      comment: "Year of target completion date"
    - name: "target_completion_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Month of target completion date"
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of corrective actions"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all corrective actions"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of all corrective actions"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per corrective action"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per corrective action"
    - name: "completed_actions"
      expr: COUNT(CASE WHEN actual_completion_date IS NOT NULL THEN 1 END)
      comment: "Number of corrective actions completed"
    - name: "completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_completion_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions completed"
    - name: "actions_requiring_escalation"
      expr: COUNT(CASE WHEN escalation_required = TRUE THEN 1 END)
      comment: "Number of corrective actions requiring escalation"
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions requiring escalation"
    - name: "verified_actions"
      expr: COUNT(CASE WHEN verification_date IS NOT NULL THEN 1 END)
      comment: "Number of corrective actions that have been verified"
    - name: "verification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions that have been verified"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`compliance_violation_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory violation severity, penalty, and resolution metrics for compliance risk and cost management"
  source: "`retail_ecm`.`compliance`.`violation_notice`"
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Type of violation"
    - name: "violation_status"
      expr: violation_status
      comment: "Current status of the violation notice"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the violation"
    - name: "regulatory_standard_violated"
      expr: regulatory_standard_violated
      comment: "Regulatory standard that was violated"
    - name: "corrective_action_required"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required"
    - name: "appeal_filed"
      expr: appeal_filed_flag
      comment: "Whether an appeal has been filed"
    - name: "settlement_negotiated"
      expr: settlement_negotiated_flag
      comment: "Whether a settlement has been negotiated"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a recurring violation"
    - name: "public_disclosure_required"
      expr: public_disclosure_required_flag
      comment: "Whether public disclosure is required"
    - name: "violation_year"
      expr: YEAR(violation_date)
      comment: "Year the violation occurred"
    - name: "violation_month"
      expr: DATE_TRUNC('MONTH', violation_date)
      comment: "Month the violation occurred"
    - name: "penalty_currency_code"
      expr: penalty_currency_code
      comment: "Currency code for penalty amounts"
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of violation notices"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount across all violations"
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amount across all violations"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per violation"
    - name: "avg_settlement_amount"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement amount per violation"
    - name: "violations_with_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of violations requiring corrective action"
    - name: "violations_with_appeal"
      expr: COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END)
      comment: "Number of violations with appeals filed"
    - name: "violations_with_settlement"
      expr: COUNT(CASE WHEN settlement_negotiated_flag = TRUE THEN 1 END)
      comment: "Number of violations with negotiated settlements"
    - name: "recurring_violations"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of recurring violations"
    - name: "appeal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN appeal_filed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations with appeals filed"
    - name: "settlement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN settlement_negotiated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations with negotiated settlements"
    - name: "recurrence_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of violations that are recurring"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`compliance_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training completion, pass rate, and cost metrics for compliance training effectiveness and ROI analysis"
  source: "`retail_ecm`.`compliance`.`training_completion`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the training completion"
    - name: "pass_fail_result"
      expr: pass_fail_result
      comment: "Pass or fail result of the training"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the training"
    - name: "job_role_category"
      expr: job_role_category
      comment: "Job role category of the trainee"
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Whether the training is mandatory"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the training"
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required_flag
      comment: "Whether regulatory reporting is required"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year the training was completed"
    - name: "completion_quarter"
      expr: CONCAT('Q', QUARTER(completion_date))
      comment: "Quarter the training was completed"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month the training was completed"
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency code for training costs"
  measures:
    - name: "total_training_completions"
      expr: COUNT(1)
      comment: "Total number of training completions"
    - name: "unique_associates_trained"
      expr: COUNT(DISTINCT associate_id)
      comment: "Number of unique associates who completed training"
    - name: "total_training_hours"
      expr: SUM(CAST(training_duration_hours AS DOUBLE))
      comment: "Total hours of training delivered"
    - name: "avg_training_hours"
      expr: AVG(CAST(training_duration_hours AS DOUBLE))
      comment: "Average training duration in hours"
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of all training completions"
    - name: "avg_training_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per training completion"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all completions"
    - name: "passed_trainings"
      expr: COUNT(CASE WHEN pass_fail_result = 'Pass' THEN 1 END)
      comment: "Number of training completions with pass result"
    - name: "pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_result = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training completions with pass result"
    - name: "certificates_issued"
      expr: COUNT(CASE WHEN certificate_issued_date IS NOT NULL THEN 1 END)
      comment: "Number of certificates issued"
    - name: "mandatory_trainings"
      expr: COUNT(CASE WHEN mandatory_flag = TRUE THEN 1 END)
      comment: "Number of mandatory training completions"
    - name: "mandatory_training_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN mandatory_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training completions that are mandatory"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`compliance_osha_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OSHA incident severity, recordability, and cost metrics for workplace safety performance and regulatory compliance"
  source: "`retail_ecm`.`compliance`.`osha_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of OSHA incident"
    - name: "osha_incident_status"
      expr: osha_incident_status
      comment: "Current status of the OSHA incident"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the incident"
    - name: "injury_type"
      expr: injury_type
      comment: "Type of injury sustained"
    - name: "body_part_affected"
      expr: body_part_affected
      comment: "Body part affected by the incident"
    - name: "osha_recordable"
      expr: osha_recordable_flag
      comment: "Whether the incident is OSHA recordable"
    - name: "osha_300_log_entry"
      expr: osha_300_log_entry_flag
      comment: "Whether the incident requires OSHA 300 log entry"
    - name: "osha_301_reportable"
      expr: osha_301_reportable_flag
      comment: "Whether the incident is OSHA 301 reportable"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a recurring incident"
    - name: "incident_year"
      expr: YEAR(incident_date)
      comment: "Year the incident occurred"
    - name: "incident_quarter"
      expr: CONCAT('Q', QUARTER(incident_date))
      comment: "Quarter the incident occurred"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month the incident occurred"
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency code for incident costs"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of OSHA incidents"
    - name: "recordable_incidents"
      expr: COUNT(CASE WHEN osha_recordable_flag = TRUE THEN 1 END)
      comment: "Number of OSHA recordable incidents"
    - name: "recordable_incident_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN osha_recordable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that are OSHA recordable"
    - name: "total_days_away_from_work"
      expr: SUM(CAST(days_away_from_work AS BIGINT))
      comment: "Total days away from work due to incidents"
    - name: "total_days_restricted_duty"
      expr: SUM(CAST(days_restricted_duty AS BIGINT))
      comment: "Total days on restricted duty due to incidents"
    - name: "avg_days_away_from_work"
      expr: AVG(CAST(days_away_from_work AS BIGINT))
      comment: "Average days away from work per incident"
    - name: "avg_days_restricted_duty"
      expr: AVG(CAST(days_restricted_duty AS BIGINT))
      comment: "Average days on restricted duty per incident"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated cost of all incidents"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Average estimated cost per incident"
    - name: "recurring_incidents"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of recurring incidents"
    - name: "recurrence_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that are recurring"
    - name: "investigations_completed"
      expr: COUNT(CASE WHEN investigation_completed_date IS NOT NULL THEN 1 END)
      comment: "Number of incidents with completed investigations"
    - name: "investigation_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN investigation_completed_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents with completed investigations"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`compliance_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certification status, cost, and renewal metrics for compliance program effectiveness and investment tracking"
  source: "`retail_ecm`.`compliance`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification"
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification"
    - name: "certifying_body"
      expr: certifying_body
      comment: "Body that issued the certification"
    - name: "accreditation_body"
      expr: accreditation_body
      comment: "Accreditation body for the certification"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the certification"
    - name: "coverage_level"
      expr: coverage_level
      comment: "Coverage level of the certification"
    - name: "public_disclosure"
      expr: public_disclosure_flag
      comment: "Whether public disclosure is required"
    - name: "renewal_workflow_status"
      expr: renewal_workflow_status
      comment: "Status of the renewal workflow"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the certification was issued"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the certification expires"
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency code for certification costs"
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of certifications"
    - name: "active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN 1 END)
      comment: "Number of active certifications"
    - name: "expired_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Expired' THEN 1 END)
      comment: "Number of expired certifications"
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of all certifications"
    - name: "avg_certification_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per certification"
    - name: "certifications_with_last_audit"
      expr: COUNT(CASE WHEN last_audit_date IS NOT NULL THEN 1 END)
      comment: "Number of certifications with completed audits"
    - name: "certifications_requiring_public_disclosure"
      expr: COUNT(CASE WHEN public_disclosure_flag = TRUE THEN 1 END)
      comment: "Number of certifications requiring public disclosure"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`compliance_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance risk severity, mitigation effectiveness, and financial impact metrics for enterprise risk management"
  source: "`retail_ecm`.`compliance`.`risk_register`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of the compliance risk"
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Subcategory of the compliance risk"
    - name: "risk_register_status"
      expr: risk_register_status
      comment: "Current status of the risk"
    - name: "impact_rating"
      expr: impact_rating
      comment: "Impact rating of the risk"
    - name: "likelihood_rating"
      expr: likelihood_rating
      comment: "Likelihood rating of the risk"
    - name: "inherent_risk_score"
      expr: inherent_risk_score
      comment: "Inherent risk score before controls"
    - name: "residual_risk_score"
      expr: residual_risk_score
      comment: "Residual risk score after controls"
    - name: "risk_response_type"
      expr: risk_response_type
      comment: "Type of risk response strategy"
    - name: "control_effectiveness_rating"
      expr: control_effectiveness_rating
      comment: "Effectiveness rating of risk controls"
    - name: "escalation_required"
      expr: escalation_required
      comment: "Whether escalation is required"
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Whether regulatory reporting is required"
    - name: "identified_year"
      expr: YEAR(identified_date)
      comment: "Year the risk was identified"
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the risk was identified"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for financial impact"
  measures:
    - name: "total_risks"
      expr: COUNT(1)
      comment: "Total number of risks in the register"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Total estimated financial impact of all risks"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Average estimated financial impact per risk"
    - name: "risks_requiring_escalation"
      expr: COUNT(CASE WHEN escalation_required = TRUE THEN 1 END)
      comment: "Number of risks requiring escalation"
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risks requiring escalation"
    - name: "closed_risks"
      expr: COUNT(CASE WHEN actual_closure_date IS NOT NULL THEN 1 END)
      comment: "Number of risks that have been closed"
    - name: "risk_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_closure_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risks that have been closed"
$$;