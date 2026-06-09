-- Metric views for domain: compliance | Business: Construction | Version: 1 | Generated on: 2026-05-07 07:27:43

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`compliance_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core compliance assessment KPIs that drive executive oversight of assessment volume, criticality, quality and financial exposure"
  source: "`construction_ecm`.`compliance`.`assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (e.g., Completed, In Progress)"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of compliance assessments"
    - name: "critical_assessments"
      expr: SUM(CASE WHEN is_critical THEN 1 ELSE 0 END)
      comment: "Count of assessments flagged as critical"
    - name: "avg_rating_score"
      expr: AVG(CAST(rating_score AS DOUBLE))
      comment: "Average rating score across assessments"
    - name: "sum_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount associated with assessments"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`compliance_assessment_by_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assessment counts broken out by type, status and jurisdiction for operational monitoring"
  source: "`construction_ecm`.`compliance`.`assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Category of assessment (e.g., Safety, Environmental)"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Number of assessments"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`compliance_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory obligation metrics that inform compliance budgeting and risk exposure"
  source: "`construction_ecm`.`compliance`.`regulatory_obligation`"
  dimensions:
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Geographic jurisdiction of the obligation"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority imposing the obligation"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the obligation"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total regulatory obligations recorded"
    - name: "active_obligations"
      expr: SUM(CASE WHEN is_active THEN 1 ELSE 0 END)
      comment: "Count of obligations currently active"
    - name: "mandatory_obligations"
      expr: SUM(CASE WHEN is_mandatory THEN 1 ELSE 0 END)
      comment: "Count of obligations marked as mandatory"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Aggregate potential penalty amount for all obligations"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`compliance_privacy_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy incident KPIs that drive executive oversight of data breach impact and regulatory exposure"
  source: "`construction_ecm`.`compliance`.`privacy_incident`"
  dimensions:
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity classification of the breach"
    - name: "breach_type"
      expr: breach_type
      comment: "Type of data breach (e.g., Unauthorized Access, Loss)"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total privacy incidents recorded"
    - name: "total_estimated_fine"
      expr: SUM(CAST(estimated_fine_amount AS DOUBLE))
      comment: "Sum of estimated fines across incidents"
    - name: "avg_data_volume_bytes"
      expr: AVG(CAST(data_volume_bytes AS DOUBLE))
      comment: "Average data volume affected per incident"
    - name: "notified_incidents"
      expr: SUM(CASE WHEN individuals_notified_flag THEN 1 ELSE 0 END)
      comment: "Count of incidents where affected individuals were notified"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`compliance_env_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental monitoring metrics used to track compliance with environmental thresholds and operational impact"
  source: "`construction_ecm`.`compliance`.`env_monitoring`"
  dimensions:
    - name: "parameter"
      expr: parameter
      comment: "Monitored environmental parameter (e.g., CO2, Noise)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the monitoring record"
  measures:
    - name: "total_records"
      expr: COUNT(1)
      comment: "Total environmental monitoring records captured"
    - name: "exceedance_count"
      expr: SUM(CASE WHEN exceedance_flag THEN 1 ELSE 0 END)
      comment: "Number of records where measured value exceeded threshold"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured environmental value"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`compliance_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance action KPIs that enable leadership to monitor remediation progress and cost efficiency"
  source: "`construction_ecm`.`compliance`.`compliance_action`"
  dimensions:
    - name: "compliance_action_status"
      expr: compliance_action_status
      comment: "Current status of the compliance action"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the action"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the action"
  measures:
    - name: "total_actions"
      expr: COUNT(1)
      comment: "Total compliance actions recorded"
    - name: "completed_actions"
      expr: SUM(CASE WHEN compliance_action_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Count of actions marked as completed"
    - name: "total_cost_actual"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Sum of actual costs incurred for compliance actions"
    - name: "avg_cost_estimate"
      expr: AVG(CAST(cost_estimate AS DOUBLE))
      comment: "Average estimated cost for compliance actions"
$$;