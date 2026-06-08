-- Metric views for domain: fraud | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 18:22:09

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`fraud_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key fraud alert performance indicators"
  source: "`payments_fintech_ecm`.`fraud`.`fraud_alert`"
  dimensions:
    - name: "alert_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of alert creation"
    - name: "alert_channel"
      expr: channel
      comment: "Channel through which the alert originated"
    - name: "alert_status"
      expr: fraud_alert_status
      comment: "Current status of the alert"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the alert"
    - name: "country_id"
      expr: country_id
      comment: "Country identifier linked to the alert"
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total number of fraud alerts generated"
    - name: "fraudulent_alerts"
      expr: SUM(CASE WHEN is_fraudulent THEN 1 ELSE 0 END)
      comment: "Count of alerts flagged as fraudulent"
    - name: "total_alert_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Sum of transaction amounts associated with alerts"
    - name: "avg_triggered_score"
      expr: AVG(CAST(triggered_score AS DOUBLE))
      comment: "Average triggered score for alerts"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`fraud_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic view of fraud case outcomes and financial impact"
  source: "`payments_fintech_ecm`.`fraud`.`fraud_case`"
  dimensions:
    - name: "case_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when the case was created"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case"
    - name: "case_type"
      expr: case_type
      comment: "Categorization of the case (e.g., chargeback, account takeover)"
    - name: "case_channel"
      expr: channel
      comment: "Channel where the fraud originated"
    - name: "case_priority"
      expr: priority
      comment: "Priority level assigned to the case"
    - name: "merchant_id"
      expr: merchant_id
      comment: "Merchant associated with the case"
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of fraud cases opened"
    - name: "fraudulent_cases"
      expr: SUM(CASE WHEN is_fraudulent THEN 1 ELSE 0 END)
      comment: "Count of cases confirmed as fraudulent"
    - name: "high_risk_cases"
      expr: SUM(CASE WHEN is_high_risk THEN 1 ELSE 0 END)
      comment: "Count of cases marked high risk"
    - name: "total_exposure_amount"
      expr: SUM(CAST(exposure_amount AS DOUBLE))
      comment: "Total monetary exposure across cases"
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Sum of chargeback amounts associated with cases"
    - name: "avg_case_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across cases"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`fraud_device_fingerprint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Device fingerprint risk monitoring"
  source: "`payments_fintech_ecm`.`fraud`.`device_fingerprint`"
  dimensions:
    - name: "device_type"
      expr: device_type
      comment: "Type of device (e.g., mobile, desktop)"
    - name: "os_name"
      expr: os_name
      comment: "Operating system name"
    - name: "first_seen_month"
      expr: DATE_TRUNC('month', first_seen_timestamp)
      comment: "Month when device was first seen"
    - name: "country_id"
      expr: country_id
      comment: "Country identifier for the device"
  measures:
    - name: "total_devices"
      expr: COUNT(1)
      comment: "Total distinct device fingerprints observed"
    - name: "blocked_devices"
      expr: SUM(CASE WHEN blocklist_flag THEN 1 ELSE 0 END)
      comment: "Count of devices flagged on blocklist"
    - name: "avg_device_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across device fingerprints"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`fraud_auth_3ds_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "3‑DS authentication effectiveness and fraud signal metrics"
  source: "`payments_fintech_ecm`.`fraud`.`auth_3ds_result`"
  dimensions:
    - name: "auth_method"
      expr: authentication_method
      comment: "Authentication method used (e.g., biometric, OTP)"
    - name: "auth_status"
      expr: authentication_status
      comment: "Result status of the authentication attempt"
    - name: "card_scheme"
      expr: card_scheme
      comment: "Card scheme involved in the transaction"
    - name: "auth_month"
      expr: DATE_TRUNC('month', authentication_timestamp)
      comment: "Month of the authentication attempt"
    - name: "merchant_id"
      expr: merchant_id
      comment: "Merchant linked to the authentication"
  measures:
    - name: "total_3ds_transactions"
      expr: COUNT(1)
      comment: "Total 3‑DS authentication attempts"
    - name: "successful_3ds_transactions"
      expr: SUM(CASE WHEN is_successful THEN 1 ELSE 0 END)
      comment: "Count of successful 3‑DS authentications"
    - name: "total_3ds_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Sum of transaction amounts processed through 3‑DS"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score from 3‑DS results"
    - name: "avg_authentication_value"
      expr: AVG(CAST(authentication_value AS DOUBLE))
      comment: "Average authentication value metric"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`fraud_score_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated view of model‑driven fraud scoring events"
  source: "`payments_fintech_ecm`.`fraud`.`score_event`"
  dimensions:
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month when the score event occurred"
    - name: "event_channel"
      expr: channel
      comment: "Channel associated with the event"
    - name: "decision"
      expr: decision
      comment: "Model decision (e.g., approve, decline)"
    - name: "rule_set_id"
      expr: rule_set_id
      comment: "Identifier of the rule set that generated the event"
    - name: "merchant_id"
      expr: merchant_id
      comment: "Merchant tied to the event"
  measures:
    - name: "total_score_events"
      expr: COUNT(1)
      comment: "Total number of fraud score events generated"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score across events"
    - name: "total_event_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Sum of transaction amounts associated with score events"
$$;