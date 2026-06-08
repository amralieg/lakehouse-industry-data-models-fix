-- Metric views for domain: customer | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 12:58:41

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key account-level financial and status metrics for executive oversight"
  source: "`genomics_biotech_ecm`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account (e.g., Active, Inactive)"
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (e.g., Corporate, Academic)"
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical the account belongs to"
    - name: "primary_country_code"
      expr: primary_country_code
      comment: "Country code of the primary address"
    - name: "account_created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the account was created"
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of customer accounts"
    - name: "active_accounts"
      expr: SUM(CASE WHEN account_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of accounts with status Active"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Sum of credit limits across all accounts"
    - name: "average_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per account"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`customer_service_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial health and coverage of service agreements"
  source: "`genomics_biotech_ecm`.`customer`.`service_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of agreement (e.g., Subscription, One‑off)"
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level tier associated with the agreement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract values"
    - name: "agreement_start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the agreement started"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(annual_contract_value AS DOUBLE))
      comment: "Total annual contract value of all service agreements"
    - name: "average_contract_value"
      expr: AVG(CAST(annual_contract_value AS DOUBLE))
      comment: "Average annual contract value per agreement"
    - name: "active_agreements"
      expr: SUM(CASE WHEN end_date >= CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of service agreements that are currently active"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`customer_support_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Support operations performance indicators"
  source: "`genomics_biotech_ecm`.`customer`.`support_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the support case"
    - name: "severity"
      expr: severity
      comment: "Severity level of the case"
    - name: "priority"
      expr: priority
      comment: "Priority assigned to the case"
    - name: "region"
      expr: region
      comment: "Geographic region of the case origin"
    - name: "case_created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the case was created"
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of support cases logged"
    - name: "average_tat_hours"
      expr: AVG(CAST(tat_hours AS DOUBLE))
      comment: "Average turnaround time (hours) to resolve cases"
    - name: "sla_met_rate"
      expr: AVG(CASE WHEN sla_met_flag THEN 1 ELSE 0 END)
      comment: "Proportion of cases that met SLA targets"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing and engagement activity metrics"
  source: "`genomics_biotech_ecm`.`customer`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of interaction (e.g., Call, Email, Webinar)"
    - name: "channel"
      expr: channel
      comment: "Channel through which the interaction occurred"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Segment classification of the customer"
    - name: "interaction_month"
      expr: DATE_TRUNC('month', interaction_timestamp)
      comment: "Month of the interaction"
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total number of customer interactions recorded"
    - name: "total_engagement_score"
      expr: SUM(CAST(engagement_score AS DOUBLE))
      comment: "Cumulative engagement score across interactions"
    - name: "average_engagement_score"
      expr: AVG(CAST(engagement_score AS DOUBLE))
      comment: "Average engagement score per interaction"
    - name: "distinct_contacts"
      expr: COUNT(DISTINCT contact_id)
      comment: "Number of unique contacts involved in interactions"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and exposure metrics for finance leadership"
  source: "`genomics_biotech_ecm`.`customer`.`credit_profile`"
  dimensions:
    - name: "credit_status"
      expr: credit_status
      comment: "Current credit status of the customer"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category assigned to the customer"
    - name: "currency_code"
      expr: credit_limit_currency_code
      comment: "Currency of the credit amounts"
  measures:
    - name: "total_available_credit"
      expr: SUM(CAST(available_credit_amount AS DOUBLE))
      comment: "Total available credit across all customers"
    - name: "average_days_sales_outstanding"
      expr: AVG(CAST(days_sales_outstanding AS DOUBLE))
      comment: "Average days sales outstanding (DSO) for customers"
    - name: "credit_hold_count"
      expr: SUM(CASE WHEN credit_hold_flag THEN 1 ELSE 0 END)
      comment: "Number of customers currently on credit hold"
$$;