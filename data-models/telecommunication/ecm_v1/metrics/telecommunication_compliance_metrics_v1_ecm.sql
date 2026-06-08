-- Metric views for domain: compliance | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 05:01:11

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key audit performance and cost metrics for compliance governance"
  source: "`telecommunication_ecm`.`compliance`.`audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (e.g., Completed, In Progress)"
    - name: "audit_type"
      expr: audit_type
      comment: "Type/category of the audit"
    - name: "audit_start_month"
      expr: DATE_TRUNC('month', actual_start_date)
      comment: "Month when the audit started"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with the audit"
  measures:
    - name: "total_audit_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of audits in monetary units"
    - name: "average_audit_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per audit"
    - name: "audit_count"
      expr: COUNT(1)
      comment: "Number of audit records"
    - name: "average_audit_duration_days"
      expr: AVG(DATEDIFF(actual_end_date, actual_start_date))
      comment: "Average duration of audits in days"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`compliance_data_breach_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics to monitor data breach frequency, impact, and detection speed"
  source: "`telecommunication_ecm`.`compliance`.`data_breach_incident`"
  dimensions:
    - name: "breach_severity_level"
      expr: breach_severity_level
      comment: "Severity classification of the breach"
    - name: "breach_status"
      expr: breach_status
      comment: "Current status of the breach (e.g., Open, Closed)"
    - name: "detection_month"
      expr: DATE_TRUNC('month', detection_timestamp)
      comment: "Month when the breach was detected"
    - name: "regulatory_obligation_id"
      expr: regulatory_obligation_id
      comment: "Regulatory obligation linked to the breach"
  measures:
    - name: "incident_count"
      expr: COUNT(1)
      comment: "Total number of data breach incidents"
    - name: "total_estimated_affected_individuals"
      expr: SUM(CAST(estimated_affected_individuals_count AS DOUBLE))
      comment: "Sum of estimated individuals affected across incidents"
    - name: "average_financial_impact"
      expr: AVG(CAST(estimated_financial_impact_amount AS DOUBLE))
      comment: "Average estimated financial impact per breach"
    - name: "average_time_to_detection_days"
      expr: AVG(DATEDIFF(DATE(detection_timestamp), DATE(created_timestamp)))
      comment: "Average days between creation and detection of a breach"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`compliance_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic view of regulatory obligations, costs, and upcoming deadlines"
  source: "`telecommunication_ecm`.`compliance`.`regulatory_obligation`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status of the obligation"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction code governing the obligation"
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating if the obligation is currently active"
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month when the obligation became effective"
  measures:
    - name: "active_obligation_count"
      expr: SUM(CASE WHEN is_active THEN 1 ELSE 0 END)
      comment: "Count of currently active regulatory obligations"
    - name: "total_annual_compliance_cost"
      expr: SUM(CAST(annual_compliance_cost_estimate AS DOUBLE))
      comment: "Aggregate estimated annual compliance cost"
    - name: "average_maximum_penalty_amount"
      expr: AVG(CAST(maximum_penalty_amount AS DOUBLE))
      comment: "Average maximum possible penalty across obligations"
    - name: "upcoming_due_obligations_count"
      expr: SUM(CASE WHEN next_compliance_due_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN 1 ELSE 0 END)
      comment: "Obligations due within the next 30 days"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`compliance_privacy_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy consent health metrics to track coverage and audit rights"
  source: "`telecommunication_ecm`.`compliance`.`privacy_consent`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent (e.g., Granted, Revoked)"
    - name: "consent_type"
      expr: consent_type
      comment: "Type/category of consent"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction governing the consent"
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when the consent became effective"
  measures:
    - name: "consent_count"
      expr: COUNT(1)
      comment: "Total number of privacy consent records"
    - name: "active_consent_count"
      expr: SUM(CASE WHEN effective_start_date <= CURRENT_DATE() AND (effective_end_date IS NULL OR effective_end_date >= CURRENT_DATE()) THEN 1 ELSE 0 END)
      comment: "Count of consents currently in effect"
    - name: "audit_rights_granted_count"
      expr: SUM(CASE WHEN audit_rights_granted THEN 1 ELSE 0 END)
      comment: "Number of consents where audit rights have been granted"
$$;