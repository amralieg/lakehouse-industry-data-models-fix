-- Metric views for domain: compliance | Business: Grocery | Version: 1 | Generated on: 2026-05-04 18:32:13

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`compliance_audit_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key audit engagement performance metrics"
  source: "`grocery_ecm`.`compliance`.`audit_engagement`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., internal, external)"
    - name: "audit_methodology"
      expr: audit_methodology
      comment: "Methodology used for the audit"
    - name: "audit_month"
      expr: DATE_TRUNC('month', audit_date)
      comment: "Month of the audit date"
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location where audit took place"
    - name: "program_id"
      expr: program_id
      comment: "Compliance program identifier"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audit engagements"
    - name: "avg_rating_score"
      expr: AVG(CAST(rating_score AS DOUBLE))
      comment: "Average rating score across audits"
    - name: "critical_audit_count"
      expr: SUM(CASE WHEN is_critical THEN 1 ELSE 0 END)
      comment: "Count of audits flagged as critical"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding severity and risk overview"
  source: "`grocery_ecm`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_status"
      expr: audit_finding_status
      comment: "Current status of the finding"
    - name: "finding_category"
      expr: audit_finding_category
      comment: "Category of the finding"
    - name: "severity"
      expr: severity
      comment: "Severity level of the finding"
    - name: "finding_type"
      expr: finding_type
      comment: "Type of finding (e.g., procedural, documentation)"
    - name: "program_id"
      expr: program_id
      comment: "Compliance program identifier"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of findings"
    - name: "high_severity_findings"
      expr: SUM(CASE WHEN severity = 'High' THEN 1 ELSE 0 END)
      comment: "Count of findings with high severity"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`compliance_food_safety_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food safety inspection performance metrics"
  source: "`grocery_ecm`.`compliance`.`food_safety_inspection`"
  dimensions:
    - name: "inspection_status"
      expr: food_safety_inspection_status
      comment: "Current status of the inspection"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g., routine, follow‑up)"
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_timestamp)
      comment: "Month of the inspection"
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location inspected"
    - name: "program_id"
      expr: program_id
      comment: "Compliance program identifier"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of food safety inspections"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall score across inspections"
    - name: "inspections_with_critical_violations"
      expr: SUM(CASE WHEN critical_violations_count != '0' THEN 1 ELSE 0 END)
      comment: "Count of inspections that reported any critical violations"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`compliance_privacy_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy incident impact and volume metrics"
  source: "`grocery_ecm`.`compliance`.`privacy_incident`"
  dimensions:
    - name: "incident_severity"
      expr: incident_severity
      comment: "Severity classification of the incident"
    - name: "incident_type"
      expr: incident_type
      comment: "Type/category of the privacy incident"
    - name: "incident_status"
      expr: privacy_incident_status
      comment: "Current status of the incident"
    - name: "incident_month"
      expr: DATE_TRUNC('month', discovery_timestamp)
      comment: "Month when the incident was discovered"
    - name: "program_id"
      expr: program_id
      comment: "Compliance program identifier"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of privacy incidents reported"
    - name: "avg_estimated_affected_individuals"
      expr: AVG(CAST(estimated_affected_individuals AS DOUBLE))
      comment: "Average number of individuals estimated to be affected per incident"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Cumulative financial impact estimate of all incidents"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`compliance_policy_acknowledgment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy acknowledgment compliance tracking"
  source: "`grocery_ecm`.`compliance`.`policy_acknowledgment`"
  dimensions:
    - name: "acknowledgment_status"
      expr: policy_acknowledgment_status
      comment: "Current status of the acknowledgment"
    - name: "policy_id"
      expr: policy_id
      comment: "Identifier of the policy being acknowledged"
    - name: "associate_id"
      expr: associate_id
      comment: "Associate who performed the acknowledgment"
    - name: "acknowledgment_month"
      expr: DATE_TRUNC('month', acknowledgment_timestamp)
      comment: "Month of the acknowledgment"
  measures:
    - name: "total_acknowledgments"
      expr: COUNT(1)
      comment: "Total number of policy acknowledgments recorded"
    - name: "pending_acknowledgments"
      expr: SUM(CASE WHEN policy_acknowledgment_status = 'Pending' THEN 1 ELSE 0 END)
      comment: "Count of acknowledgments that are still pending"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`compliance_environmental_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental compliance cost and EPA flag metrics"
  source: "`grocery_ecm`.`compliance`.`environmental_compliance`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status"
    - name: "regulation_type"
      expr: regulation_type
      comment: "Type of regulation (e.g., air, water)"
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location associated with the record"
    - name: "compliance_period_month"
      expr: DATE_TRUNC('month', compliance_period_start)
      comment: "Month of the compliance period start"
  measures:
    - name: "total_records"
      expr: COUNT(1)
      comment: "Total environmental compliance records"
    - name: "total_compliance_cost_usd"
      expr: SUM(CAST(compliance_cost_usd AS DOUBLE))
      comment: "Aggregate estimated compliance cost in USD"
    - name: "epa_compliance_flag_count"
      expr: SUM(CASE WHEN epa_compliance_flag THEN 1 ELSE 0 END)
      comment: "Count of records flagged as EPA compliant"
$$;