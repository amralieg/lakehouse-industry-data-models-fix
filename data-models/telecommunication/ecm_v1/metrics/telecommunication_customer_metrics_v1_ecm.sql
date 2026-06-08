-- Metric views for domain: customer | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 05:01:11

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`customer_account_dealer_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for dealer transactions, focusing on commission revenue and transaction volume."
  source: "`telecommunication_ecm`.`customer`.`account_dealer_transaction`"
  dimensions:
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_date)
      comment: "Month of the transaction"
    - name: "dealer_id"
      expr: dealer_id
      comment: "Identifier of the dealer involved in the transaction"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of the dealer transaction"
  measures:
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission earned from dealer transactions"
    - name: "average_commission_amount"
      expr: AVG(CAST(commission_amount AS DOUBLE))
      comment: "Average commission per dealer transaction"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of dealer transactions"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`customer_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational metrics for customer support cases, highlighting resolution efficiency and escalation."
  source: "`telecommunication_ecm`.`customer`.`case`"
  dimensions:
    - name: "case_month"
      expr: DATE_TRUNC('month', created_date)
      comment: "Month when the case was created"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case"
    - name: "case_type"
      expr: case_type
      comment: "Business type/category of the case"
    - name: "channel"
      expr: channel
      comment: "Channel through which the case was received"
  measures:
    - name: "average_time_to_resolution_hours"
      expr: AVG(CAST(time_to_resolution_hours AS DOUBLE))
      comment: "Average time (in hours) to resolve a case"
    - name: "escalated_case_count"
      expr: SUM(CAST(escalation_flag AS INT))
      comment: "Number of cases that were escalated"
    - name: "first_contact_resolution_count"
      expr: SUM(CAST(fcr_flag AS INT))
      comment: "Number of cases resolved on first contact"
    - name: "case_count"
      expr: COUNT(1)
      comment: "Total number of cases"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`customer_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and renewal health metrics for customer subscriptions."
  source: "`telecommunication_ecm`.`customer`.`customer_subscription`"
  dimensions:
    - name: "activation_month"
      expr: DATE_TRUNC('month', activation_date)
      comment: "Month when the subscription was activated"
    - name: "channel"
      expr: channel
      comment: "Sales or acquisition channel for the subscription"
    - name: "addon_status"
      expr: addon_status
      comment: "Current status of any attached add‑on"
  measures:
    - name: "total_recurring_revenue"
      expr: SUM(CAST(recurring_charge AS DOUBLE))
      comment: "Total recurring revenue from active subscriptions"
    - name: "average_recurring_charge"
      expr: AVG(CAST(recurring_charge AS DOUBLE))
      comment: "Average recurring charge per subscription"
    - name: "total_proration_amount"
      expr: SUM(CAST(proration_amount AS DOUBLE))
      comment: "Total proration adjustments applied"
    - name: "subscription_count"
      expr: COUNT(1)
      comment: "Number of subscription records"
    - name: "auto_renewal_subscription_count"
      expr: SUM(CAST(auto_renewal_flag AS INT))
      comment: "Count of subscriptions with auto‑renewal enabled"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial health and risk indicators for customer accounts."
  source: "`telecommunication_ecm`.`customer`.`customer_account`"
  dimensions:
    - name: "account_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when the account record was created"
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account"
    - name: "account_tier"
      expr: account_tier
      comment: "Tier classification of the account"
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Organizational hierarchy level of the account"
  measures:
    - name: "average_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average revenue per user across accounts"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance owed by all accounts"
    - name: "average_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Mean churn risk score for accounts"
    - name: "account_count"
      expr: COUNT(1)
      comment: "Number of customer accounts"
    - name: "average_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit assigned to accounts"
$$;