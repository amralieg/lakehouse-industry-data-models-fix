-- Metric views for domain: channel | Business: Banking | Version: 1 | Generated on: 2026-05-02 22:51:12

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`channel_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key alert performance metrics for monitoring delivery effectiveness and cost"
  source: "`banking_ecm`.`channel`.`channel_alert`"
  dimensions:
    - name: "alert_category"
      expr: alert_category
      comment: "Category of the alert (e.g., fraud, compliance)"
    - name: "alert_type"
      expr: alert_type
      comment: "Specific type of alert within the category"
    - name: "priority"
      expr: priority
      comment: "Business priority assigned to the alert"
    - name: "language_code"
      expr: language_code
      comment: "Language of the alert content"
    - name: "alert_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the alert was created"
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total number of alerts generated"
    - name: "delivered_alerts"
      expr: SUM(CASE WHEN delivery_status = 'Delivered' THEN 1 ELSE 0 END)
      comment: "Count of alerts that were successfully delivered"
    - name: "total_delivery_cost"
      expr: SUM(CAST(delivery_cost_amount AS DOUBLE))
      comment: "Sum of delivery cost amounts across all alerts"
    - name: "avg_delivery_latency_seconds"
      expr: AVG(CAST((UNIX_TIMESTAMP(delivered_timestamp) - UNIX_TIMESTAMP(created_timestamp)) AS DOUBLE))
      comment: "Average time in seconds between alert creation and delivery"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`channel_atm_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and risk metrics for ATM transactions"
  source: "`banking_ecm`.`channel`.`atm_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of ATM transaction (e.g., withdrawal, deposit)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the transaction"
    - name: "atm_id"
      expr: atm_id
      comment: "Identifier of the ATM where the transaction occurred"
    - name: "card_entry_mode"
      expr: card_entry_mode
      comment: "Method used to enter card information"
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Date of the ATM transaction"
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of ATM transactions"
    - name: "total_cash_dispensed"
      expr: SUM(CAST(cash_dispensed_amount AS DOUBLE))
      comment: "Total cash dispensed across all ATM transactions"
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Sum of transaction amounts for all ATM transactions"
    - name: "fraud_transactions"
      expr: SUM(CASE WHEN fraud_flag THEN 1 ELSE 0 END)
      comment: "Count of ATM transactions flagged as fraud"
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction amount per ATM transaction"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`channel_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incident management KPIs for channel reliability and risk"
  source: "`banking_ecm`.`channel`.`channel_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of the incident (e.g., outage, security)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity rating of the incident"
    - name: "priority"
      expr: priority
      comment: "Business priority assigned to the incident"
    - name: "channel_id"
      expr: channel_id
      comment: "Identifier of the affected channel"
    - name: "incident_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the incident was created"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of channel incidents recorded"
    - name: "resolved_incidents"
      expr: SUM(CASE WHEN channel_incident_status = 'Resolved' THEN 1 ELSE 0 END)
      comment: "Count of incidents that have been resolved"
    - name: "avg_time_to_resolve_seconds"
      expr: AVG(CAST((UNIX_TIMESTAMP(resolved_timestamp) - UNIX_TIMESTAMP(created_timestamp)) AS DOUBLE))
      comment: "Average time in seconds to resolve incidents"
    - name: "rpo_met_incidents"
      expr: SUM(CASE WHEN rpo_met_flag THEN 1 ELSE 0 END)
      comment: "Count of incidents where the Recovery Point Objective was met"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`channel_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and performance metrics for marketing campaigns across channels"
  source: "`banking_ecm`.`channel`.`campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g., promotional, informational)"
    - name: "channel_type"
      expr: channel_type
      comment: "Channel through which the campaign was delivered"
    - name: "region"
      expr: region
      comment: "Geographic region targeted by the campaign"
    - name: "campaign_start_date"
      expr: DATE_TRUNC('day', start_date)
      comment: "Start date of the campaign"
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated to campaigns"
    - name: "actual_spend_amount"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Actual spend incurred by campaigns"
    - name: "conversion_count"
      expr: SUM(CAST(conversion_count AS DOUBLE))
      comment: "Total number of conversions generated by campaigns"
    - name: "reached_count"
      expr: SUM(CAST(reached_count AS DOUBLE))
      comment: "Total number of customers reached by campaigns"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`channel_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Session activity and risk metrics for digital channels"
  source: "`banking_ecm`.`channel`.`session`"
  dimensions:
    - name: "channel_id"
      expr: channel_id
      comment: "Identifier of the channel associated with the session"
    - name: "session_status"
      expr: session_status
      comment: "Current status of the session"
    - name: "session_type"
      expr: session_type
      comment: "Type of session (e.g., interactive, batch)"
    - name: "session_date"
      expr: DATE_TRUNC('day', start_timestamp)
      comment: "Date the session started"
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of user sessions"
    - name: "avg_session_duration_seconds"
      expr: AVG(CAST((UNIX_TIMESTAMP(end_timestamp) - UNIX_TIMESTAMP(start_timestamp)) AS DOUBLE))
      comment: "Average session duration in seconds"
    - name: "high_fraud_sessions"
      expr: SUM(CASE WHEN fraud_risk_score > 80 THEN 1 ELSE 0 END)
      comment: "Count of sessions with high fraud risk score (>80)"
$$;