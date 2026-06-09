-- Metric views for domain: fraud | Business: Banking | Version: 1 | Generated on: 2026-05-02 22:51:12

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`fraud_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key fraud case performance metrics"
  source: "`banking_ecm`.`fraud`.`case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case (e.g., open, closed)"
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Count of fraud cases"
    - name: "total_estimated_loss"
      expr: SUM(CAST(estimated_loss_amount AS DOUBLE))
      comment: "Sum of estimated loss amount across cases"
    - name: "total_confirmed_loss"
      expr: SUM(CAST(confirmed_loss_amount AS DOUBLE))
      comment: "Sum of confirmed loss amount across cases"
    - name: "average_estimated_loss"
      expr: AVG(CAST(estimated_loss_amount AS DOUBLE))
      comment: "Average estimated loss per case"
    - name: "average_confirmed_loss"
      expr: AVG(CAST(confirmed_loss_amount AS DOUBLE))
      comment: "Average confirmed loss per case"
    - name: "total_recovered"
      expr: SUM(CAST(recovered_amount AS DOUBLE))
      comment: "Total amount recovered for cases"
    - name: "net_loss"
      expr: SUM(estimated_loss_amount - recovered_amount)
      comment: "Net loss after recoveries (estimated loss minus recovered)"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`fraud_case_by_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Case counts broken out by type and severity"
  source: "`banking_ecm`.`fraud`.`case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of fraud case (e.g., card, account)"
  measures:
    - name: "case_count"
      expr: COUNT(1)
      comment: "Number of cases"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`fraud_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated fraud alert metrics"
  source: "`banking_ecm`.`fraud`.`fraud_alert`"
  dimensions:
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the alert"
    - name: "severity"
      expr: severity
      comment: "Severity level of the alert"
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the alert"
    - name: "alert_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the alert was created"
  measures:
    - name: "alert_count"
      expr: COUNT(1)
      comment: "Count of fraud alerts generated"
    - name: "total_loss"
      expr: SUM(CAST(loss_amount AS DOUBLE))
      comment: "Total loss amount associated with alerts"
    - name: "total_recovery"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered from alerts"
    - name: "net_loss"
      expr: SUM(loss_amount - recovery_amount)
      comment: "Net loss after recoveries for alerts"
    - name: "average_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average fraud score across alerts"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`fraud_chargeback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chargeback performance indicators"
  source: "`banking_ecm`.`fraud`.`chargeback`"
  dimensions:
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Current status of the chargeback"
    - name: "card_type"
      expr: card_type
      comment: "Type of card involved in the chargeback"
    - name: "card_network"
      expr: card_network
      comment: "Card network (e.g., Visa, MC)"
    - name: "initiated_month"
      expr: DATE_TRUNC('month', initiated_date)
      comment: "Month the chargeback was initiated"
  measures:
    - name: "chargeback_count"
      expr: COUNT(1)
      comment: "Number of chargebacks filed"
    - name: "total_dispute_amount"
      expr: SUM(CAST(dispute_amount AS DOUBLE))
      comment: "Total disputed amount across chargebacks"
    - name: "total_loss"
      expr: SUM(CAST(loss_amount AS DOUBLE))
      comment: "Total loss amount from chargebacks"
    - name: "total_recovery"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered from chargebacks"
    - name: "average_dispute_amount"
      expr: AVG(CAST(dispute_amount AS DOUBLE))
      comment: "Average disputed amount per chargeback"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`fraud_loss`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overall loss accounting metrics"
  source: "`banking_ecm`.`fraud`.`loss`"
  dimensions:
    - name: "loss_category"
      expr: loss_category
      comment: "Category of the loss (e.g., operational, fraud)"
    - name: "loss_status"
      expr: loss_status
      comment: "Current status of the loss record"
    - name: "loss_month"
      expr: DATE_TRUNC('month', loss_date)
      comment: "Month the loss was recorded"
  measures:
    - name: "loss_event_count"
      expr: COUNT(1)
      comment: "Number of loss events recorded"
    - name: "total_gross_loss"
      expr: SUM(CAST(gross_loss_amount AS DOUBLE))
      comment: "Sum of gross loss amounts"
    - name: "total_net_loss"
      expr: SUM(CAST(net_loss_amount AS DOUBLE))
      comment: "Sum of net loss amounts after adjustments"
    - name: "total_recovery"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total recovery amount for loss events"
    - name: "average_gross_loss"
      expr: AVG(CAST(gross_loss_amount AS DOUBLE))
      comment: "Average gross loss per event"
$$;