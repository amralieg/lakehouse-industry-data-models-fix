-- Metric views for domain: customer | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 13:07:02

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial health metrics at the account level"
  source: "`chemical_mfg_ecm`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account (e.g., Active, Inactive)"
    - name: "account_tier"
      expr: account_tier
      comment: "Tier classification of the account"
    - name: "account_type"
      expr: account_type
      comment: "Type of account (e.g., Corporate, Individual)"
    - name: "segment_id"
      expr: segment_id
      comment: "Segment identifier for the account"
    - name: "territory_id"
      expr: territory_id
      comment: "Sales territory linked to the account"
    - name: "account_created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the account was created"
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of customer accounts"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Sum of credit limits across all accounts"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account"
    - name: "blocked_accounts"
      expr: SUM(CASE WHEN blocked THEN 1 ELSE 0 END)
      comment: "Count of accounts that are blocked"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer engagement and issue flag metrics"
  source: "`chemical_mfg_ecm`.`customer`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of interaction (e.g., Call, Email, Meeting)"
    - name: "channel"
      expr: channel
      comment: "Channel used for the interaction"
    - name: "interaction_date"
      expr: DATE_TRUNC('day', interaction_date)
      comment: "Date of the interaction"
    - name: "account_id"
      expr: account_id
      comment: "Account linked to the interaction"
    - name: "contact_id"
      expr: contact_id
      comment: "Contact involved in the interaction"
    - name: "product_line"
      expr: product_line
      comment: "Product line discussed"
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total number of customer interactions"
    - name: "complaint_interactions"
      expr: SUM(CASE WHEN complaint_flag THEN 1 ELSE 0 END)
      comment: "Count of interactions flagged as complaints"
    - name: "sds_requested_interactions"
      expr: SUM(CASE WHEN sds_request_flag THEN 1 ELSE 0 END)
      comment: "Count of interactions where SDS was requested"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and exposure metrics per account"
  source: "`chemical_mfg_ecm`.`customer`.`credit_profile`"
  dimensions:
    - name: "credit_risk_category"
      expr: credit_risk_category
      comment: "Risk category assigned to the credit profile"
    - name: "credit_profile_status"
      expr: credit_profile_status
      comment: "Current status of the credit profile"
    - name: "credit_limit_currency"
      expr: credit_limit_currency
      comment: "Currency of the credit limit"
    - name: "profile_created_month"
      expr: DATE_TRUNC('month', profile_created_timestamp)
      comment: "Month the credit profile was created"
  measures:
    - name: "total_credit_profiles"
      expr: COUNT(1)
      comment: "Total number of credit profiles"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Aggregate credit limit amount"
    - name: "avg_credit_utilization_pct"
      expr: AVG(CAST(credit_utilization_pct AS DOUBLE))
      comment: "Average credit utilization percentage"
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Sum of overdue amounts"
    - name: "credit_blocked_profiles"
      expr: SUM(CASE WHEN credit_block_flag THEN 1 ELSE 0 END)
      comment: "Count of credit profiles that are blocked"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`customer_supply_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and volume metrics for supply contracts"
  source: "`chemical_mfg_ecm`.`customer`.`supply_contract`"
  dimensions:
    - name: "contract_start_month"
      expr: DATE_TRUNC('month', contract_start_date)
      comment: "Month contract starts"
    - name: "contract_end_month"
      expr: DATE_TRUNC('month', contract_end_date)
      comment: "Month contract ends"
    - name: "account_id"
      expr: account_id
      comment: "Account linked to the contract"
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material master identifier for the contracted product"
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of supply contracts"
    - name: "total_volume_kg"
      expr: SUM(CAST(volume_kg AS DOUBLE))
      comment: "Aggregate contracted volume in kilograms"
    - name: "avg_agreed_price"
      expr: AVG(CAST(agreed_price AS DOUBLE))
      comment: "Average agreed price across contracts"
    - name: "total_contract_value"
      expr: SUM(agreed_price * volume_kg)
      comment: "Total monetary value of contracts (price multiplied by volume)"
$$;