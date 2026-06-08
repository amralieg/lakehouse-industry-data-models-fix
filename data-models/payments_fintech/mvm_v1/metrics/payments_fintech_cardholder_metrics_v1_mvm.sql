-- Metric views for domain: cardholder | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 21:26:52

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`cardholder_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and status metrics for cardholder accounts."
  source: "`payments_fintech_ecm`.`cardholder`.`cardholder_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account"
    - name: "account_type"
      expr: account_type
      comment: "Type of the account (e.g., personal, business)"
    - name: "account_tier"
      expr: account_tier
      comment: "Tier level of the account"
    - name: "is_overlimit"
      expr: is_overlimit
      comment: "Flag indicating if account is over its credit limit"
    - name: "is_suspended"
      expr: is_suspended
      comment: "Flag indicating if account is suspended"
    - name: "sca_compliance_flag"
      expr: sca_compliance_flag
      comment: "Strong Customer Authentication compliance flag"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Regulatory reporting requirement flag"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the account was created"
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of accounts"
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Sum of current balances across accounts"
    - name: "average_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average current balance per account"
    - name: "total_payment_due_amount"
      expr: SUM(CAST(payment_due_amount AS DOUBLE))
      comment: "Total payment due amount across accounts"
    - name: "average_payment_due_amount"
      expr: AVG(CAST(payment_due_amount AS DOUBLE))
      comment: "Average payment due amount per account"
    - name: "overlimit_accounts"
      expr: SUM(CASE WHEN is_overlimit THEN 1 ELSE 0 END)
      comment: "Number of accounts that are over their credit limit"
    - name: "suspended_accounts"
      expr: SUM(CASE WHEN is_suspended THEN 1 ELSE 0 END)
      comment: "Number of suspended accounts"
    - name: "sca_compliant_accounts"
      expr: SUM(CASE WHEN sca_compliance_flag THEN 1 ELSE 0 END)
      comment: "Number of accounts compliant with SCA"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`cardholder_authentication_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Authentication event performance and risk metrics."
  source: "`payments_fintech_ecm`.`cardholder`.`authentication_event`"
  dimensions:
    - name: "authentication_outcome"
      expr: authentication_outcome
      comment: "Result of the authentication attempt"
    - name: "authentication_factor"
      expr: authentication_factor
      comment: "Factor used for authentication (e.g., password, biometrics)"
    - name: "authentication_method"
      expr: authentication_method
      comment: "Method of authentication"
    - name: "authentication_channel"
      expr: authentication_channel
      comment: "Channel through which authentication occurred"
    - name: "device_type"
      expr: device_type
      comment: "Type of device used"
    - name: "scheme_id"
      expr: scheme_id
      comment: "Payment scheme identifier"
    - name: "event_day"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Day of the authentication event"
  measures:
    - name: "total_auth_events"
      expr: COUNT(1)
      comment: "Total number of authentication events"
    - name: "successful_auth_events"
      expr: SUM(CASE WHEN authentication_outcome = 'Success' THEN 1 ELSE 0 END)
      comment: "Number of successful authentication events"
    - name: "failed_auth_events"
      expr: SUM(CASE WHEN authentication_outcome <> 'Success' THEN 1 ELSE 0 END)
      comment: "Number of failed authentication events"
    - name: "lockout_events"
      expr: SUM(CASE WHEN lockout_flag THEN 1 ELSE 0 END)
      comment: "Number of events that triggered a lockout"
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across authentication events"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`cardholder_velocity_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Velocity control limits and utilization metrics for cardholders."
  source: "`payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control`"
  dimensions:
    - name: "control_type"
      expr: control_type
      comment: "Type of velocity control (e.g., spend, transaction count)"
    - name: "control_source"
      expr: control_source
      comment: "Source of the control rule"
    - name: "scheme_id"
      expr: scheme_id
      comment: "Payment scheme identifier"
    - name: "is_exempted"
      expr: is_exempted
      comment: "Whether the control is exempted for the cardholder"
    - name: "effective_from_date"
      expr: effective_from
      comment: "Start date of control effectiveness"
    - name: "effective_until_date"
      expr: effective_until
      comment: "End date of control effectiveness"
  measures:
    - name: "total_controls"
      expr: COUNT(1)
      comment: "Total number of velocity control records"
    - name: "sum_daily_spent_amount"
      expr: SUM(CAST(daily_spent_amount AS DOUBLE))
      comment: "Total daily spent amount across controls"
    - name: "average_daily_spent_amount"
      expr: AVG(CAST(daily_spent_amount AS DOUBLE))
      comment: "Average daily spent amount per control"
    - name: "exempted_controls"
      expr: SUM(CASE WHEN is_exempted THEN 1 ELSE 0 END)
      comment: "Number of controls that are exempted"
    - name: "sum_limit_amount"
      expr: SUM(CAST(limit_amount AS DOUBLE))
      comment: "Sum of limit amounts across controls"
    - name: "average_limit_utilization_pct"
      expr: AVG(100.0 * CAST(daily_spent_amount AS DOUBLE) / NULLIF(CAST(limit_amount AS DOUBLE),0))
      comment: "Average percentage of limit utilization (daily spent vs limit)"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`cardholder_account_holder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core cardholder demographic and compliance metrics."
  source: "`payments_fintech_ecm`.`cardholder`.`account_holder`"
  dimensions:
    - name: "account_holder_status"
      expr: account_holder_status
      comment: "Current status of the account holder"
    - name: "account_holder_type"
      expr: account_holder_type
      comment: "Type of account holder (e.g., individual, business)"
    - name: "nationality"
      expr: nationality
      comment: "Nationality of the account holder"
    - name: "state_province"
      expr: state_province
      comment: "State or province of the account holder"
    - name: "city"
      expr: city
      comment: "City of the account holder"
    - name: "avs_verified"
      expr: avs_verified
      comment: "AVS verification flag"
    - name: "sca_compliance"
      expr: sca_compliance
      comment: "SCA compliance flag"
    - name: "tax_exempt"
      expr: tax_exempt
      comment: "Tax exemption flag"
  measures:
    - name: "total_account_holders"
      expr: COUNT(1)
      comment: "Total number of account holders"
    - name: "avs_verified_holders"
      expr: SUM(CASE WHEN avs_verified THEN 1 ELSE 0 END)
      comment: "Number of holders with AVS verified"
    - name: "sca_compliant_holders"
      expr: SUM(CASE WHEN sca_compliance THEN 1 ELSE 0 END)
      comment: "Number of holders compliant with SCA"
    - name: "tax_exempt_holders"
      expr: SUM(CASE WHEN tax_exempt THEN 1 ELSE 0 END)
      comment: "Number of tax‑exempt holders"
$$;