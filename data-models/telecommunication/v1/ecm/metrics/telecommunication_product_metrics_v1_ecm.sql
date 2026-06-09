-- Metric views for domain: product | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 05:01:11

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`product_offering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and capacity metrics for product offerings"
  source: "`telecommunication_ecm`.`product`.`offering`"
  dimensions:
    - name: "offering_name"
      expr: offering_name
      comment: "Descriptive name of the offering"
    - name: "offering_type"
      expr: offering_type
      comment: "Type/category of the offering"
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model applied to the offering"
    - name: "geographic_availability"
      expr: geographic_availability
      comment: "Geographic regions where the offering is available"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month of offering effectiveness"
  measures:
    - name: "total_base_monthly_price"
      expr: SUM(CAST(base_monthly_price AS DOUBLE))
      comment: "Total base monthly price across offerings"
    - name: "average_base_monthly_price"
      expr: AVG(CAST(base_monthly_price AS DOUBLE))
      comment: "Average base monthly price per offering"
    - name: "total_data_allowance_gb"
      expr: SUM(CAST(data_allowance_gb AS DOUBLE))
      comment: "Sum of data allowance (GB) across offerings"
    - name: "offering_count"
      expr: COUNT(1)
      comment: "Number of offering records"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`product_bundle_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and discount performance of bundle subscriptions"
  source: "`telecommunication_ecm`.`product`.`bundle_subscription`"
  dimensions:
    - name: "bundle_id"
      expr: bundle_id
      comment: "Identifier of the bundle"
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current status of the subscription"
    - name: "effective_month"
      expr: DATE_TRUNC('month', subscription_start_date)
      comment: "Month when subscription started"
  measures:
    - name: "total_monthly_recurring_revenue"
      expr: SUM(CAST(monthly_recurring_revenue AS DOUBLE))
      comment: "Total monthly recurring revenue from bundle subscriptions"
    - name: "total_discount_applied"
      expr: SUM(CAST(discount_applied AS DOUBLE))
      comment: "Total discount amount applied across subscriptions"
    - name: "subscription_count"
      expr: COUNT(1)
      comment: "Number of bundle subscription records"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`product_catalog_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core pricing and data metrics for catalog items, including promotional count"
  source: "`telecommunication_ecm`.`product`.`catalog_item`"
  dimensions:
    - name: "product_code"
      expr: product_code
      comment: "Unique product code"
    - name: "product_name"
      expr: product_name
      comment: "Descriptive product name"
    - name: "product_family"
      expr: product_family
      comment: "Family/category of the product"
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model applied to the product"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency for the product"
    - name: "geographic_availability"
      expr: geographic_availability
      comment: "Geographic scope where product is offered"
  measures:
    - name: "total_base_price"
      expr: SUM(CAST(base_price AS DOUBLE))
      comment: "Sum of base price for catalog items"
    - name: "average_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price per catalog item"
    - name: "total_data_allowance_gb"
      expr: SUM(CAST(data_allowance_gb AS DOUBLE))
      comment: "Total data allowance (GB) across catalog items"
    - name: "catalog_item_count"
      expr: COUNT(1)
      comment: "Number of catalog item records"
    - name: "promotional_item_count"
      expr: SUM(CASE WHEN promotional_flag THEN 1 ELSE 0 END)
      comment: "Count of catalog items flagged as promotional"
$$;