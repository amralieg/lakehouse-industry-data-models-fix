-- Metric views for domain: customer | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 05:05:28

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core account health and credit capacity metrics"
  source: "`oil_gas_ecm`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account (e.g., Active, Inactive)"
    - name: "account_tier"
      expr: account_tier
      comment: "Tier classification of the account"
    - name: "country_code"
      expr: country_code
      comment: "ISO country code of the account"
    - name: "billing_currency"
      expr: billing_currency
      comment: "Currency used for billing"
    - name: "region_code"
      expr: region_code
      comment: "Regional code for reporting"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel through which the account was acquired"
    - name: "is_intercompany"
      expr: is_intercompany
      comment: "Flag indicating inter‑company relationship"
    - name: "is_jv_partner"
      expr: is_jv_partner
      comment: "Flag indicating joint‑venture partner status"
    - name: "sanctions_screened"
      expr: sanctions_screened
      comment: "Whether the account has passed sanctions screening"
    - name: "account_created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the account was created"
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of customer accounts"
    - name: "total_credit_limit_usd"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Sum of credit limits across all accounts (USD)"
    - name: "avg_credit_limit_usd"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account (USD)"
    - name: "blocked_accounts"
      expr: SUM(CASE WHEN credit_block_indicator THEN 1 ELSE 0 END)
      comment: "Number of accounts with credit block indicator set"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`customer_credit_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and limit change monitoring"
  source: "`oil_gas_ecm`.`customer`.`credit_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of credit event (e.g., LimitIncrease, WriteOff)"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the credit event"
    - name: "country_code"
      expr: country_code
      comment: "Country associated with the credit event"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit event amounts"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the credit event"
    - name: "automated_flag"
      expr: automated_flag
      comment: "Whether the event was generated automatically"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether the event is a reversal"
  measures:
    - name: "total_credit_events"
      expr: COUNT(1)
      comment: "Total number of credit events recorded"
    - name: "total_exposure_amount_usd"
      expr: SUM(CAST(exposure_amount AS DOUBLE))
      comment: "Sum of exposure amounts across all credit events (USD)"
    - name: "avg_exposure_amount_usd"
      expr: AVG(CAST(exposure_amount AS DOUBLE))
      comment: "Average exposure amount per credit event (USD)"
    - name: "net_credit_limit_change_usd"
      expr: SUM(credit_limit_new - credit_limit_previous)
      comment: "Net change in credit limits resulting from events (USD)"
    - name: "automated_event_count"
      expr: SUM(CASE WHEN automated_flag THEN 1 ELSE 0 END)
      comment: "Number of credit events generated automatically"
    - name: "reversal_event_count"
      expr: SUM(CASE WHEN reversal_flag THEN 1 ELSE 0 END)
      comment: "Number of credit events that are reversals"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer complaint financial impact and severity tracking"
  source: "`oil_gas_ecm`.`customer`.`complaint`"
  dimensions:
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint (e.g., Open, Closed)"
    - name: "severity"
      expr: severity
      comment: "Severity classification of the complaint"
    - name: "complaint_category"
      expr: complaint_category
      comment: "Business category of the complaint"
    - name: "complaint_month"
      expr: DATE_TRUNC('month', complaint_date)
      comment: "Month the complaint was recorded"
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of complaints logged"
    - name: "total_claimed_amount_usd"
      expr: SUM(CAST(claimed_amount_usd AS DOUBLE))
      comment: "Sum of claimed monetary amounts across complaints (USD)"
    - name: "avg_claimed_amount_usd"
      expr: AVG(CAST(claimed_amount_usd AS DOUBLE))
      comment: "Average claimed amount per complaint (USD)"
    - name: "high_severity_complaints"
      expr: SUM(CASE WHEN severity = 'High' THEN 1 ELSE 0 END)
      comment: "Count of complaints flagged as high severity"
    - name: "total_claimed_volume_bbl"
      expr: SUM(CAST(claimed_volume_bbl AS DOUBLE))
      comment: "Total claimed volume in barrels"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`customer_volume_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitoring of contractual volume commitments and delivery performance"
  source: "`oil_gas_ecm`.`customer`.`customer_volume_commitment`"
  dimensions:
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current status of the volume commitment"
    - name: "contract_year"
      expr: contract_year
      comment: "Fiscal year of the contract"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for the commitment"
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the commitment became effective"
    - name: "effective_until_month"
      expr: DATE_TRUNC('month', effective_until)
      comment: "Month the commitment expires"
  measures:
    - name: "commitment_count"
      expr: COUNT(1)
      comment: "Number of volume commitment records"
    - name: "total_delivered_volume_boe"
      expr: SUM(CAST(delivered_volume_to_date AS DOUBLE))
      comment: "Sum of volume delivered to date (Barrels of Oil Equivalent)"
    - name: "total_max_contracted_volume_boe"
      expr: SUM(CAST(max_contracted_volume AS DOUBLE))
      comment: "Sum of maximum contracted volumes (BOE)"
    - name: "avg_take_or_pay_pct"
      expr: AVG(CAST(take_or_pay_pct AS DOUBLE))
      comment: "Average take‑or‑pay percentage across commitments"
$$;