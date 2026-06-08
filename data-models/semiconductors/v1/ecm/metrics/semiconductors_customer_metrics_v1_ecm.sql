-- Metric views for domain: customer | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 18:21:54

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer account health and risk metrics"
  source: "`semiconductors_ecm`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account (e.g., Active, Inactive)"
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of customer accounts"
    - name: "total_risk_score"
      expr: SUM(CAST(risk_score AS DOUBLE))
      comment: "Sum of risk scores across all accounts (higher indicates greater overall risk exposure)"
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score per account, useful for monitoring risk trends"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial exposure and credit health metrics"
  source: "`semiconductors_ecm`.`customer`.`credit_profile`"
  dimensions:
    - name: "credit_profile_status"
      expr: credit_profile_status
      comment: "Status of the credit profile (e.g., Active, Closed)"
  measures:
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance across all credit profiles, indicating cash at risk"
    - name: "average_credit_utilization_pct"
      expr: AVG(CAST(credit_utilization_pct AS DOUBLE))
      comment: "Average credit utilization percentage, a key indicator of credit health"
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Aggregate credit limit amount granted to customers"
    - name: "credit_hold_count"
      expr: SUM(CASE WHEN credit_hold THEN 1 ELSE 0 END)
      comment: "Number of credit profiles currently on hold"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`customer_design_win`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic revenue pipeline from customer design wins"
  source: "`semiconductors_ecm`.`customer`.`customer_design_win`"
  dimensions:
    - name: "platform_generation"
      expr: platform_generation
      comment: "Technology generation (e.g., 7nm, 5nm)"
  measures:
    - name: "design_win_count"
      expr: COUNT(1)
      comment: "Number of design wins recorded"
    - name: "total_estimated_annual_revenue_usd"
      expr: SUM(CAST(estimated_annual_revenue_usd AS DOUBLE))
      comment: "Projected annual revenue from design wins in USD"
    - name: "average_estimated_annual_unit_volume"
      expr: AVG(CAST(estimated_annual_unit_volume AS DOUBLE))
      comment: "Average projected unit volume per design win"
    - name: "total_nre_amount_usd"
      expr: SUM(CAST(nre_amount_usd AS DOUBLE))
      comment: "Total non‑recurring engineering (NRE) spend associated with design wins"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`customer_engagement_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer engagement activity and investment metrics"
  source: "`semiconductors_ecm`.`customer`.`engagement_activity`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of engagement activity (e.g., Meeting, Webinar)"
  measures:
    - name: "activity_count"
      expr: COUNT(1)
      comment: "Total number of engagement activities recorded"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Sum of budget amounts allocated to activities"
    - name: "distinct_contacts"
      expr: COUNT(DISTINCT contact_id)
      comment: "Number of unique contacts involved in activities"
$$;