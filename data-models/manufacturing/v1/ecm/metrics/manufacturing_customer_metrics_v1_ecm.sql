-- Metric views for domain: customer | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 08:25:38

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and strategic KPIs at the customer account level"
  source: "`manufacturing_ecm`.`customer`.`customer_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account (e.g., Active, Inactive)"
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (e.g., Direct, Indirect)"
    - name: "segment_id"
      expr: segment_id
      comment: "Segment identifier linking to customer.segment"
    - name: "month_created"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the account record was created"
  measures:
    - name: "total_customers"
      expr: COUNT(1)
      comment: "Total number of customer accounts"
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Sum of annual revenue across all customer accounts"
    - name: "avg_annual_revenue"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per customer account"
    - name: "strategic_account_count"
      expr: SUM(CASE WHEN is_strategic_account THEN 1 ELSE 0 END)
      comment: "Count of accounts flagged as strategic"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`customer_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and utilization metrics for customer entitlements"
  source: "`manufacturing_ecm`.`customer`.`customer_entitlement`"
  dimensions:
    - name: "entitlement_type"
      expr: entitlement_type
      comment: "Type/category of the entitlement"
    - name: "country_code"
      expr: country_code
      comment: "Country associated with the entitlement"
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level agreement tier for the entitlement"
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating if the entitlement is currently active"
    - name: "is_perpetual"
      expr: is_perpetual
      comment: "Flag indicating if the entitlement is perpetual"
    - name: "month_created"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the entitlement record was created"
  measures:
    - name: "total_entitlement_value"
      expr: SUM(CAST(contracted_value AS DOUBLE))
      comment: "Total contracted value of all entitlements"
    - name: "avg_entitlement_value"
      expr: AVG(CAST(contracted_value AS DOUBLE))
      comment: "Average contracted value per entitlement"
    - name: "active_entitlement_count"
      expr: SUM(CASE WHEN is_active THEN 1 ELSE 0 END)
      comment: "Number of currently active entitlements"
    - name: "perpetual_entitlement_count"
      expr: SUM(CASE WHEN is_perpetual THEN 1 ELSE 0 END)
      comment: "Number of entitlements that are perpetual"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and capacity metrics for customers"
  source: "`manufacturing_ecm`.`customer`.`credit_profile`"
  dimensions:
    - name: "credit_status"
      expr: credit_status
      comment: "Overall credit status (e.g., Approved, Pending)"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned by rating agency"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit limit"
    - name: "month_effective"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the credit profile became effective"
  measures:
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Aggregate credit limit across all customers"
    - name: "avg_credit_utilization_pct"
      expr: AVG(CAST(credit_utilization_pct AS DOUBLE))
      comment: "Average credit utilization percentage"
    - name: "credit_hold_count"
      expr: SUM(CASE WHEN credit_hold_flag THEN 1 ELSE 0 END)
      comment: "Number of customers currently on credit hold"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`customer_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead generation and conversion performance metrics"
  source: "`manufacturing_ecm`.`customer`.`customer_lead`"
  dimensions:
    - name: "lead_status"
      expr: lead_status
      comment: "Current status of the lead (e.g., New, Qualified)"
    - name: "lead_source"
      expr: lead_source
      comment: "Origin channel of the lead"
    - name: "sales_region"
      expr: sales_region
      comment: "Geographic sales region associated with the lead"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the lead"
    - name: "month_created"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the lead record was created"
  measures:
    - name: "total_leads"
      expr: COUNT(1)
      comment: "Total number of leads captured"
    - name: "converted_lead_count"
      expr: SUM(CASE WHEN is_converted THEN 1 ELSE 0 END)
      comment: "Number of leads that converted to opportunities or customers"
    - name: "total_estimated_deal_value"
      expr: SUM(CAST(estimated_deal_value AS DOUBLE))
      comment: "Sum of estimated deal values for all leads"
    - name: "avg_estimated_deal_value"
      expr: AVG(CAST(estimated_deal_value AS DOUBLE))
      comment: "Average estimated deal value per lead"
$$;