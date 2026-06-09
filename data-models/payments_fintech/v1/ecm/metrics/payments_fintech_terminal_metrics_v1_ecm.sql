-- Metric views for domain: terminal | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 18:22:09

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`terminal_pos_terminal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core terminal inventory and status KPIs"
  source: "`payments_fintech_ecm`.`terminal`.`pos_terminal`"
  dimensions:
    - name: "terminal_city"
      expr: terminal_city
      comment: "City where the terminal is installed"
    - name: "terminal_region"
      expr: terminal_region
      comment: "Geographic region of the terminal"
    - name: "pos_terminal_status"
      expr: pos_terminal_status
      comment: "Operational status of the terminal (e.g., ACTIVE, INACTIVE)"
    - name: "connectivity_type"
      expr: connectivity_type
      comment: "Type of network connectivity (e.g., WIFI, LTE)"
    - name: "country_id"
      expr: country_id
      comment: "Reference to the country where the terminal resides"
  measures:
    - name: "total_terminals"
      expr: COUNT(1)
      comment: "Total number of POS terminals in the fleet"
    - name: "active_terminals"
      expr: SUM(CASE WHEN pos_terminal_status = 'ACTIVE' THEN 1 ELSE 0 END)
      comment: "Count of terminals that are currently active"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`terminal_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Alert volume and severity monitoring for terminals"
  source: "`payments_fintech_ecm`.`terminal`.`terminal_alert`"
  dimensions:
    - name: "alert_category"
      expr: alert_category
      comment: "High‑level category of the alert (e.g., HARDWARE, SOFTWARE)"
    - name: "alert_type"
      expr: alert_type
      comment: "Specific type of alert within the category"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the alert (e.g., INFO, WARNING, CRITICAL)"
    - name: "alert_source"
      expr: alert_source
      comment: "Origin of the alert (e.g., DEVICE, NETWORK)"
    - name: "alert_date"
      expr: DATE_TRUNC('day', alert_timestamp)
      comment: "Date of the alert (day granularity)"
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total number of terminal alerts generated"
    - name: "critical_alerts"
      expr: SUM(CASE WHEN severity_level = 'CRITICAL' THEN 1 ELSE 0 END)
      comment: "Count of alerts flagged as critical"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`terminal_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial reconciliation performance and variance KPIs"
  source: "`payments_fintech_ecm`.`terminal`.`terminal_reconciliation`"
  dimensions:
    - name: "currency_id"
      expr: currency_id
      comment: "Currency used for the reconciliation amounts"
    - name: "merchant_id"
      expr: merchant_id
      comment: "Merchant associated with the reconciliation"
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the reconciliation period"
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the reconciliation period"
  measures:
    - name: "reconciliation_count"
      expr: COUNT(1)
      comment: "Number of reconciliation records processed"
    - name: "successful_reconciliations"
      expr: SUM(CASE WHEN reconciliation_status = 'SUCCESS' THEN 1 ELSE 0 END)
      comment: "Count of reconciliations that completed successfully"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Sum of variance amounts between terminal and host reports"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`terminal_wallet_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core wallet transaction volume and fraud monitoring"
  source: "`payments_fintech_ecm`.`terminal`.`wallet_transaction`"
  dimensions:
    - name: "transaction_type_id"
      expr: transaction_type_id
      comment: "Reference to the type of transaction"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the transaction"
    - name: "channel"
      expr: channel
      comment: "Channel through which the transaction was initiated"
    - name: "is_fraud_flagged"
      expr: is_fraud_flagged
      comment: "Whether the transaction was flagged as fraud"
    - name: "is_successful"
      expr: is_successful
      comment: "Whether the transaction was successful"
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Date of the transaction (day granularity)"
  measures:
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of wallet transactions"
    - name: "total_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Sum of transaction amounts"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Sum of fees charged on transactions"
    - name: "fraud_transaction_count"
      expr: SUM(CASE WHEN is_fraud_flagged = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transactions flagged as fraud"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`terminal_payment_instrument`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment instrument inventory and balance KPIs"
  source: "`payments_fintech_ecm`.`terminal`.`payment_instrument`"
  dimensions:
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of payment instrument (e.g., CARD, ACH)"
    - name: "payment_instrument_status"
      expr: payment_instrument_status
      comment: "Current status of the instrument"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency associated with the instrument"
    - name: "is_contactless"
      expr: is_contactless
      comment: "Whether the instrument supports contactless payments"
    - name: "is_virtual"
      expr: is_virtual
      comment: "Whether the instrument is a virtual token"
  measures:
    - name: "instrument_count"
      expr: COUNT(1)
      comment: "Total number of payment instruments"
    - name: "active_instruments"
      expr: SUM(CASE WHEN payment_instrument_status = 'ACTIVE' THEN 1 ELSE 0 END)
      comment: "Count of instruments currently active"
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Aggregate available balance across all instruments"
    - name: "avg_daily_transaction_limit"
      expr: AVG(CAST(daily_transaction_limit AS DOUBLE))
      comment: "Average daily transaction limit per instrument"
$$;