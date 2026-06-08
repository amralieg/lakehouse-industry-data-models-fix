-- Metric views for domain: cardholder | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 18:22:09

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`cardholder_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial health metrics for cardholder accounts"
  source: "`payments_fintech_ecm`.`cardholder`.`cardholder_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account (e.g., active, closed)"
    - name: "account_type"
      expr: account_type
      comment: "Type of account (e.g., consumer, corporate)"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency identifier for the account balances"
    - name: "account_created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the account was created"
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across all cardholder accounts"
    - name: "average_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account"
    - name: "total_available_credit"
      expr: SUM(CAST(available_credit AS DOUBLE))
      comment: "Sum of available credit across accounts"
    - name: "active_account_count"
      expr: SUM(CASE WHEN account_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of accounts with active status"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`cardholder_authentication_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Security and risk metrics derived from authentication events"
  source: "`payments_fintech_ecm`.`cardholder`.`authentication_event`"
  dimensions:
    - name: "authentication_channel"
      expr: authentication_channel
      comment: "Channel used for authentication (e.g., mobile, web)"
    - name: "authentication_factor"
      expr: authentication_factor
      comment: "Factor used (e.g., password, biometric)"
    - name: "device_type"
      expr: device_type
      comment: "Type of device used for authentication"
    - name: "country_id"
      expr: country_id
      comment: "Country where authentication originated"
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the authentication event"
  measures:
    - name: "total_authentication_events"
      expr: COUNT(1)
      comment: "Total number of authentication events recorded"
    - name: "failed_authentication_events"
      expr: SUM(CASE WHEN authentication_outcome = 'failure' THEN 1 ELSE 0 END)
      comment: "Count of authentication events that resulted in failure"
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across authentication events"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`cardholder_profile_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk assessment aggregates for cardholder profiles"
  source: "`payments_fintech_ecm`.`cardholder`.`cardholder_profile`"
  dimensions:
    - name: "cardholder_type"
      expr: cardholder_type
      comment: "Classification of the cardholder (e.g., consumer, corporate)"
    - name: "kyc_verification_status"
      expr: kyc_verification_status
      comment: "KYC verification status of the profile"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the profile (e.g., active, dormant)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the profile"
  measures:
    - name: "profile_count"
      expr: COUNT(1)
      comment: "Total number of cardholder profiles"
    - name: "average_fraud_risk_score"
      expr: AVG(CAST(fraud_risk_score AS DOUBLE))
      comment: "Average fraud risk score across profiles"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`cardholder_velocity_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational limits and controls applied to cardholder transactions"
  source: "`payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control`"
  dimensions:
    - name: "control_type"
      expr: control_type
      comment: "Type of control (e.g., spend, transaction count)"
    - name: "channel_type"
      expr: channel_type
      comment: "Channel the control applies to (e.g., online, POS)"
    - name: "control_status"
      expr: cardholder_velocity_control_status
      comment: "Current status of the control rule"
    - name: "country_id"
      expr: country_id
      comment: "Country where the control is enforced"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the control became effective"
  measures:
    - name: "control_count"
      expr: COUNT(1)
      comment: "Total number of velocity control rules defined"
    - name: "total_daily_spent_limit"
      expr: SUM(CAST(daily_spent_amount AS DOUBLE))
      comment: "Aggregate daily spent amount limits across controls"
    - name: "average_limit_amount"
      expr: AVG(CAST(limit_amount AS DOUBLE))
      comment: "Average monetary limit amount across controls"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`cardholder_aml_screening_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance and AML screening effectiveness metrics"
  source: "`payments_fintech_ecm`.`cardholder`.`cardholder_aml_screening_result`"
  dimensions:
    - name: "screening_type"
      expr: screening_type
      comment: "Type of AML screening performed"
    - name: "screening_provider"
      expr: screening_provider
      comment: "Provider of the AML screening service"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier assigned by the screening"
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Whether regulatory reporting is required for the screening"
    - name: "screening_date"
      expr: DATE_TRUNC('day', screening_timestamp)
      comment: "Date the screening was executed"
  measures:
    - name: "screening_count"
      expr: COUNT(1)
      comment: "Total AML screening results processed"
    - name: "adverse_media_count"
      expr: SUM(CASE WHEN is_adverse_media THEN 1 ELSE 0 END)
      comment: "Number of screenings flagged with adverse media"
    - name: "pep_count"
      expr: SUM(CASE WHEN is_pep THEN 1 ELSE 0 END)
      comment: "Number of screenings where the individual is a politically exposed person"
    - name: "average_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match score across AML screenings"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`cardholder_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer consent capture and status metrics"
  source: "`payments_fintech_ecm`.`cardholder`.`consent`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (e.g., marketing, data sharing)"
    - name: "collection_channel"
      expr: collection_channel
      comment: "Channel through which consent was collected"
    - name: "regulatory_jurisdiction_id"
      expr: regulatory_jurisdiction_id
      comment: "Regulatory jurisdiction associated with the consent"
    - name: "consent_month"
      expr: DATE_TRUNC('month', consent_timestamp)
      comment: "Month the consent was given"
  measures:
    - name: "consent_count"
      expr: COUNT(1)
      comment: "Total number of consent records captured"
    - name: "active_consent_count"
      expr: SUM(CASE WHEN consent_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of consents currently active"
$$;