-- Metric views for domain: fraud | Business: Banking | Version: 1 | Generated on: 2026-05-03 02:23:20

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`fraud_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key alert‑level KPIs for fraud monitoring"
  source: "`banking_ecm`.`fraud`.`alert`"
  dimensions:
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the fraud alert"
    - name: "severity"
      expr: severity
      comment: "Severity level assigned to the alert"
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the alert"
    - name: "alert_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the alert was created (day granularity)"
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total number of alerts"
    - name: "total_fraud_loss"
      expr: SUM(CAST(loss_amount AS DOUBLE))
      comment: "Sum of loss amounts associated with alerts"
    - name: "avg_alert_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average risk score of alerts"
    - name: "false_positive_count"
      expr: COUNT(CASE WHEN false_positive_reason IS NOT NULL THEN 1 END)
      comment: "Number of alerts marked as false positives"
    - name: "sar_filed_count"
      expr: COUNT(CASE WHEN sar_filed_flag THEN 1 END)
      comment: "Number of alerts where SAR was filed"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`fraud_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Case‑level performance and loss metrics"
  source: "`banking_ecm`.`fraud`.`case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the fraud case"
    - name: "severity"
      expr: severity
      comment: "Severity level of the case"
    - name: "priority"
      expr: priority
      comment: "Priority assigned to the case"
    - name: "case_created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the case was created (day granularity)"
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of fraud cases"
    - name: "open_cases"
      expr: COUNT(CASE WHEN case_status = 'Open' THEN 1 END)
      comment: "Number of cases currently open"
    - name: "closed_cases"
      expr: COUNT(CASE WHEN case_status = 'Closed' THEN 1 END)
      comment: "Number of cases that have been closed"
    - name: "total_estimated_loss"
      expr: SUM(CAST(estimated_loss_amount AS DOUBLE))
      comment: "Sum of estimated loss amounts across cases"
    - name: "total_confirmed_loss"
      expr: SUM(CAST(confirmed_loss_amount AS DOUBLE))
      comment: "Sum of confirmed loss amounts across cases"
    - name: "avg_estimated_loss"
      expr: AVG(CAST(estimated_loss_amount AS DOUBLE))
      comment: "Average estimated loss per case"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`fraud_chargeback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chargeback financial impact and fraud flag metrics"
  source: "`banking_ecm`.`fraud`.`chargeback`"
  dimensions:
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Current status of the chargeback"
    - name: "fraud_indicator"
      expr: fraud_indicator
      comment: "Indicates if the chargeback is identified as fraud"
    - name: "chargeback_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the chargeback record was created (day granularity)"
  measures:
    - name: "total_chargebacks"
      expr: COUNT(1)
      comment: "Total number of chargeback records"
    - name: "total_loss_amount"
      expr: SUM(CAST(loss_amount AS DOUBLE))
      comment: "Sum of loss amounts associated with chargebacks"
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Sum of recovery amounts for chargebacks"
    - name: "avg_loss_amount"
      expr: AVG(CAST(loss_amount AS DOUBLE))
      comment: "Average loss amount per chargeback"
    - name: "fraud_chargeback_count"
      expr: COUNT(CASE WHEN fraud_indicator THEN 1 END)
      comment: "Number of chargebacks flagged as fraud"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`fraud_detection_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and activity metrics for fraud detection rules"
  source: "`banking_ecm`.`fraud`.`detection_rule`"
  dimensions:
    - name: "rule_status"
      expr: rule_status
      comment: "Operational status of the detection rule"
    - name: "rule_severity"
      expr: rule_severity
      comment: "Severity classification of the rule"
    - name: "model_type"
      expr: model_type
      comment: "Model type used (e.g., ML, rule‑based)"
    - name: "rule_created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the rule was created (day granularity)"
  measures:
    - name: "total_rules"
      expr: COUNT(1)
      comment: "Total number of detection rules defined"
    - name: "avg_effectiveness_score"
      expr: AVG(CAST(detection_effectiveness_score AS DOUBLE))
      comment: "Average effectiveness score across rules"
    - name: "avg_false_positive_rate"
      expr: AVG(CAST(false_positive_rate AS DOUBLE))
      comment: "Average false‑positive rate across rules"
    - name: "avg_true_positive_rate"
      expr: AVG(CAST(true_positive_rate AS DOUBLE))
      comment: "Average true‑positive rate across rules"
    - name: "total_alert_volume"
      expr: SUM(CAST(alert_volume AS DOUBLE))
      comment: "Total alert volume generated by all rules"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`fraud_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incident‑level loss and SAR filing metrics"
  source: "`banking_ecm`.`fraud`.`incident`"
  dimensions:
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident"
    - name: "detection_method"
      expr: detection_method
      comment: "Method that detected the incident"
    - name: "incident_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the incident was created (day granularity)"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of fraud incidents recorded"
    - name: "total_loss_amount"
      expr: SUM(CAST(loss_amount AS DOUBLE))
      comment: "Sum of loss amounts across incidents"
    - name: "total_recovered_amount"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Sum of amounts recovered for incidents"
    - name: "avg_loss_amount"
      expr: AVG(CAST(loss_amount AS DOUBLE))
      comment: "Average loss per incident"
    - name: "sar_filed_count"
      expr: COUNT(CASE WHEN sar_filed_flag THEN 1 END)
      comment: "Number of incidents where a SAR was filed"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`fraud_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investigation performance and loss impact metrics"
  source: "`banking_ecm`.`fraud`.`investigation`"
  dimensions:
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the investigation"
    - name: "investigation_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the investigation was created (day granularity)"
  measures:
    - name: "total_investigations"
      expr: COUNT(1)
      comment: "Total number of investigations initiated"
    - name: "total_fraud_loss_amount"
      expr: SUM(CAST(fraud_loss_amount AS DOUBLE))
      comment: "Sum of fraud loss amounts identified in investigations"
    - name: "avg_fraud_loss_amount"
      expr: AVG(CAST(fraud_loss_amount AS DOUBLE))
      comment: "Average fraud loss per investigation"
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag THEN 1 END)
      comment: "Number of investigations that breached SLA targets"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`fraud_loss_recovery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial outcomes of loss recovery processes"
  source: "`banking_ecm`.`fraud`.`loss_recovery`"
  dimensions:
    - name: "loss_category"
      expr: loss_category
      comment: "Category of the loss (e.g., operational, fraud)"
    - name: "loss_status"
      expr: loss_status
      comment: "Current status of the loss recovery process"
    - name: "loss_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the loss recovery record was created (day granularity)"
  measures:
    - name: "total_loss_recoveries"
      expr: COUNT(1)
      comment: "Total number of loss recovery records"
    - name: "total_gross_loss"
      expr: SUM(CAST(gross_loss_amount AS DOUBLE))
      comment: "Sum of gross loss amounts before recoveries"
    - name: "total_net_loss"
      expr: SUM(CAST(net_loss_amount AS DOUBLE))
      comment: "Sum of net loss amounts after recoveries"
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered across all loss events"
    - name: "avg_recovery_amount"
      expr: AVG(CAST(recovery_amount AS DOUBLE))
      comment: "Average recovery amount per loss event"
$$;