-- Metric views for domain: fraud | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 21:26:52

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`fraud_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key fraud alert KPIs to monitor alert volume, fraud incidence, and monetary impact"
  source: "`payments_fintech_ecm`.`fraud`.`alert`"
  dimensions:
    - name: "alert_type"
      expr: alert_type
      comment: "Type/category of the fraud alert"
    - name: "channel"
      expr: channel
      comment: "Channel through which the transaction occurred (e.g., online, POS)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the alert"
    - name: "fraud_alert_status"
      expr: fraud_alert_status
      comment: "Current processing status of the alert"
    - name: "geo_country"
      expr: geo_country
      comment: "Country where the transaction originated"
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Date of the underlying transaction"
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total number of fraud alerts generated"
    - name: "fraudulent_alerts"
      expr: SUM(CAST(is_fraudulent AS INT))
      comment: "Count of alerts flagged as fraudulent"
    - name: "total_fraud_amount"
      expr: SUM(CASE WHEN is_fraudulent THEN transaction_amount ELSE 0 END)
      comment: "Sum of transaction amounts for fraudulent alerts"
    - name: "average_fraud_amount"
      expr: AVG(CASE WHEN is_fraudulent THEN transaction_amount END)
      comment: "Average transaction amount for fraudulent alerts"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`fraud_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated view of fraud case performance and financial impact"
  source: "`payments_fintech_ecm`.`fraud`.`fraud_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the fraud case"
    - name: "case_type"
      expr: case_type
      comment: "Business type of the case (e.g., chargeback, investigation)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the case"
    - name: "channel"
      expr: channel
      comment: "Channel associated with the case"
    - name: "fraud_category"
      expr: fraud_category
      comment: "High‑level fraud category"
    - name: "case_created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the case was created"
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of fraud cases opened"
    - name: "fraudulent_cases"
      expr: SUM(CAST(is_fraudulent AS INT))
      comment: "Count of cases confirmed as fraudulent"
    - name: "total_exposure_amount"
      expr: SUM(CAST(exposure_amount AS DOUBLE))
      comment: "Total monetary exposure across all cases"
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered from fraudulent cases"
    - name: "net_exposure_amount"
      expr: SUM(CAST(exposure_amount - recovery_amount AS DOUBLE))
      comment: "Net exposure after recoveries"
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score assigned to cases"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`fraud_score_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Score event metrics to assess model performance and fraud monetary impact"
  source: "`payments_fintech_ecm`.`fraud`.`score_event`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Channel of the transaction"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g., card, wallet)"
    - name: "fraud_score_band"
      expr: CASE WHEN fraud_score >= 80 THEN 'high' WHEN fraud_score >= 50 THEN 'medium' ELSE 'low' END
      comment: "Categorized fraud score band"
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the score event"
  measures:
    - name: "total_score_events"
      expr: COUNT(1)
      comment: "Total number of fraud score events recorded"
    - name: "total_fraud_score"
      expr: SUM(CAST(fraud_score AS DOUBLE))
      comment: "Sum of fraud scores across all events"
    - name: "average_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score per event"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`fraud_auth_3ds_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "3‑DS authentication performance and associated fraud risk metrics"
  source: "`payments_fintech_ecm`.`fraud`.`auth_3ds_result`"
  dimensions:
    - name: "authentication_status"
      expr: authentication_status
      comment: "Result status of the 3‑DS authentication"
    - name: "is_successful"
      expr: is_successful
      comment: "Boolean flag indicating if authentication succeeded"
    - name: "liability_shift"
      expr: liability_shift
      comment: "Boolean flag indicating liability shift"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the 3‑DS result was recorded"
  measures:
    - name: "total_3ds_attempts"
      expr: COUNT(1)
      comment: "Total number of 3‑DS authentication attempts"
    - name: "successful_authentications"
      expr: SUM(CAST(is_successful AS INT))
      comment: "Count of successful 3‑DS authentications"
    - name: "liability_shifted"
      expr: SUM(CAST(liability_shift AS INT))
      comment: "Count of authentications where liability shift occurred"
    - name: "average_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score from 3‑DS results"
    - name: "total_auth_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total transaction amount processed through 3‑DS"
$$;