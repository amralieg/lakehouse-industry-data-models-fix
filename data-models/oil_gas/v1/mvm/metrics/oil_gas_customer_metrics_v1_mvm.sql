-- Metric views for domain: customer | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 09:27:20

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core credit capacity and account health metrics for the customer domain"
  source: "`oil_gas_ecm`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account (e.g., Active, Inactive)"
  measures:
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit allocated across all customer accounts"
    - name: "average_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account"
    - name: "count_accounts"
      expr: COUNT(1)
      comment: "Number of customer accounts"
    - name: "blocked_accounts"
      expr: SUM(CASE WHEN credit_block_indicator THEN 1 ELSE 0 END)
      comment: "Count of accounts with credit block indicator set"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`customer_credit_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit event risk and activity overview"
  source: "`oil_gas_ecm`.`customer`.`credit_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of credit event (e.g., Limit Increase, Write‑off)"
  measures:
    - name: "total_exposure_amount"
      expr: SUM(CAST(exposure_amount AS DOUBLE))
      comment: "Total exposure amount from credit events"
    - name: "total_collateral_amount"
      expr: SUM(CAST(collateral_amount AS DOUBLE))
      comment: "Total collateral amount posted for credit events"
    - name: "count_credit_events"
      expr: COUNT(1)
      comment: "Number of credit events recorded"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`customer_offtake_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Entitlement and production performance metrics"
  source: "`oil_gas_ecm`.`customer`.`offtake_entitlement`"
  dimensions:
    - name: "entitlement_status"
      expr: entitlement_status
      comment: "Current status of the entitlement (e.g., Active, Expired)"
  measures:
    - name: "total_entitled_volume"
      expr: SUM(CAST(entitled_volume AS DOUBLE))
      comment: "Total volume entitled to customers"
    - name: "total_lifted_volume"
      expr: SUM(CAST(cumulative_lifted_volume AS DOUBLE))
      comment: "Cumulative lifted volume against entitlements"
    - name: "average_net_revenue_interest_pct"
      expr: AVG(CAST(net_revenue_interest_pct AS DOUBLE))
      comment: "Average net revenue interest percentage across entitlements"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`customer_lifting_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational lifting performance and quality metrics"
  source: "`oil_gas_ecm`.`customer`.`customer_lifting_schedule`"
  dimensions:
    - name: "lifting_status"
      expr: lifting_status
      comment: "Current status of the lifting operation"
  measures:
    - name: "total_actual_lifted_volume"
      expr: SUM(CAST(actual_lifted_volume AS DOUBLE))
      comment: "Total actual lifted volume recorded"
    - name: "total_entitlement_volume"
      expr: SUM(CAST(entitlement_volume AS DOUBLE))
      comment: "Total volume entitled in lifting schedules"
    - name: "average_api_gravity"
      expr: AVG(CAST(api_gravity AS DOUBLE))
      comment: "Average API gravity of lifted crude"
    - name: "total_price_differential"
      expr: SUM(CAST(price_differential AS DOUBLE))
      comment: "Sum of price differentials applied to lifted volumes"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`customer_nomination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nomination planning and execution effectiveness"
  source: "`oil_gas_ecm`.`customer`.`nomination`"
  dimensions:
    - name: "nomination_status"
      expr: nomination_status
      comment: "Status of the nomination (e.g., Pending, Confirmed)"
  measures:
    - name: "total_nominated_volume"
      expr: SUM(CAST(nominated_volume AS DOUBLE))
      comment: "Total volume nominated by customers"
    - name: "total_actual_lifted_volume"
      expr: SUM(CAST(actual_volume_lifted AS DOUBLE))
      comment: "Total volume actually lifted against nominations"
    - name: "count_nominations"
      expr: COUNT(1)
      comment: "Number of nomination records"
$$;