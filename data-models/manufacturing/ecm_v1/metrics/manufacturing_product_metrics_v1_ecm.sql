-- Metric views for domain: product | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 08:25:38

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`product_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core revenue and volume KPIs derived from order line transactions"
  source: "`manufacturing_ecm`.`product`.`order_line`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the order line"
    - name: "order_header_id"
      expr: order_header_id
      comment: "Identifier of the order header (order grouping)"
    - name: "sku_master_id"
      expr: sku_master_id
      comment: "SKU identifier for the product sold"
    - name: "bundle_id"
      expr: bundle_id
      comment: "Bundle identifier if the line is part of a bundle"
  measures:
    - name: "total_net_revenue"
      expr: SUM(CAST(net_price AS DOUBLE))
      comment: "Total net revenue (post‑discount) across order lines"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount granted across order lines"
    - name: "total_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity of items requested across order lines"
    - name: "avg_discount_rate_pct"
      expr: ROUND(100.0 * AVG(CASE WHEN (net_price + discount_amount) > 0 THEN discount_amount / (net_price + discount_amount) ELSE 0 END), 2)
      comment: "Average discount rate as a percentage of list price per line"
    - name: "avg_line_price"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net price per order line"
    - name: "avg_quantity_per_line"
      expr: AVG(CAST(requested_quantity AS DOUBLE))
      comment: "Average quantity per order line"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`product_bundle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing, weight, and volume KPIs for product bundles"
  source: "`manufacturing_ecm`.`product`.`bundle`"
  dimensions:
    - name: "bundle_status"
      expr: bundle_status
      comment: "Current status of the bundle"
    - name: "bundle_type"
      expr: bundle_type
      comment: "Classification of the bundle (e.g., standard, custom)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the bundle is manufactured"
    - name: "availability_month"
      expr: DATE_TRUNC('month', availability_start_date)
      comment: "Month when the bundle became available"
  measures:
    - name: "total_list_price"
      expr: SUM(CAST(list_price AS DOUBLE))
      comment: "Total list price of all bundles"
    - name: "avg_list_price"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average list price per bundle"
    - name: "total_weight"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight (kg) of all bundles"
    - name: "avg_weight"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average weight (kg) per bundle"
    - name: "total_volume"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volume (m³) of all bundles"
    - name: "avg_volume"
      expr: AVG(CAST(volume_m3 AS DOUBLE))
      comment: "Average volume (m³) per bundle"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied to bundles"
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`product_sku_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and physical attribute KPIs for master SKUs"
  source: "`manufacturing_ecm`.`product`.`sku_master`"
  dimensions:
    - name: "product_family_code"
      expr: product_family_code
      comment: "Family code grouping SKUs"
    - name: "product_type"
      expr: product_type
      comment: "Type/category of the product"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the SKU is sourced/manufactured"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the SKU"
  measures:
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across all SKUs"
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per SKU"
    - name: "total_gross_weight"
      expr: SUM(CAST(gross_weight AS DOUBLE))
      comment: "Total gross weight (kg) of all SKUs"
    - name: "avg_gross_weight"
      expr: AVG(CAST(gross_weight AS DOUBLE))
      comment: "Average gross weight (kg) per SKU"
    - name: "total_volume"
      expr: SUM(CAST(volume AS DOUBLE))
      comment: "Total volume (m³) of all SKUs"
    - name: "avg_volume"
      expr: AVG(CAST(volume AS DOUBLE))
      comment: "Average volume (m³) per SKU"
$$;