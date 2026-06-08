-- Metric views for domain: compliance | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 18:21:54

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`compliance_audit_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key audit activity metrics for compliance monitoring"
  source: "`semiconductors_ecm`.`compliance`.`audit_event`"
  dimensions:
    - name: "audit_category"
      expr: audit_category
      comment: "Category of the audit (e.g., safety, quality)"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audit events recorded"
    - name: "pass_audit_count"
      expr: SUM(CASE WHEN overall_result = 'Pass' THEN 1 ELSE 0 END)
      comment: "Count of audits with a passing overall result"
    - name: "average_audit_duration_days"
      expr: AVG(DATEDIFF(audit_end_date, audit_start_date))
      comment: "Average duration of audits in days"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`compliance_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certification health and renewal risk metrics"
  source: "`semiconductors_ecm`.`compliance`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g., ISO, UL)"
  measures:
    - name: "active_certification_count"
      expr: SUM(CASE WHEN certification_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of certifications currently active"
    - name: "certifications_expiring_soon_count"
      expr: SUM(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE, 30) THEN 1 ELSE 0 END)
      comment: "Certifications that will expire within the next 30 days"
    - name: "average_time_to_expiry_days"
      expr: AVG(DATEDIFF(expiry_date, issue_date))
      comment: "Average number of days from issue to expiry across certifications"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`compliance_chips_act_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and performance tracking for CHIPS Act obligations"
  source: "`semiconductors_ecm`.`compliance`.`chips_act_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Classification of the obligation (e.g., funding, reporting)"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of CHIPS Act obligations recorded"
    - name: "total_funding_amount_usd"
      expr: SUM(CAST(funding_amount AS DOUBLE))
      comment: "Sum of funding amounts associated with obligations"
    - name: "compliance_actual_sum"
      expr: SUM(CAST(compliance_actual AS DOUBLE))
      comment: "Aggregate of actual compliance values reported"
    - name: "target_value_sum"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Aggregate of target compliance values"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding volume and severity metrics for risk management"
  source: "`semiconductors_ecm`.`compliance`.`compliance_audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of finding (e.g., procedural, technical)"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings recorded"
    - name: "high_severity_findings_count"
      expr: SUM(CASE WHEN severity_score = 'High' THEN 1 ELSE 0 END)
      comment: "Count of findings flagged as high severity"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`compliance_export_license_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utilization and value metrics for export license usage"
  source: "`semiconductors_ecm`.`compliance`.`export_license_usage`"
  dimensions:
    - name: "export_control_regulation"
      expr: export_control_regulation
      comment: "Regulation governing the export (e.g., EAR, ITAR)"
  measures:
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity exported under licenses"
    - name: "total_declared_value_usd"
      expr: SUM(CAST(declared_value AS DOUBLE))
      comment: "Sum of declared monetary value of exported items"
    - name: "average_utilization_percent"
      expr: AVG(CAST(cumulative_license_utilization_percent AS DOUBLE))
      comment: "Average utilization percentage of export licenses"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`compliance_trade_compliance_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact of trade compliance holds"
  source: "`semiconductors_ecm`.`compliance`.`trade_compliance_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the hold (e.g., Active, Released)"
  measures:
    - name: "total_hold_amount_usd"
      expr: SUM(CAST(adjustment_amount_usd AS DOUBLE))
      comment: "Total monetary amount of trade compliance holds"
    - name: "total_net_amount_usd"
      expr: SUM(CAST(net_amount_usd AS DOUBLE))
      comment: "Net amount after adjustments for holds"
$$;