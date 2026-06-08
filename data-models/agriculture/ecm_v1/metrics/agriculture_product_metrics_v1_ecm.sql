-- Metric views for domain: product | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 16:21:15

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`product_agrochemical_product`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for agrochemical product portfolio management"
  source: "`agriculture_ecm`.`product`.`agrochemical_product`"
  dimensions:
    - name: "product_type"
      expr: product_type
      comment: "Type of agrochemical product (e.g., herbicide, insecticide)"
    - name: "formulation_type"
      expr: formulation_type
      comment: "Formulation format of the product"
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Manufacturer of the agrochemical"
    - name: "registration_expiry_year"
      expr: YEAR(registration_expiry_date)
      comment: "Year when product registration expires"
    - name: "active_ingredient_name"
      expr: active_ingredient_name
      comment: "Name of the active ingredient"
    - name: "organic_approved_flag"
      expr: organic_approved_flag
      comment: "Flag indicating organic approval"
  measures:
    - name: "total_products"
      expr: COUNT(1)
      comment: "Total number of agrochemical products"
    - name: "total_active_ingredient_concentration"
      expr: SUM(CAST(active_ingredient_concentration AS DOUBLE))
      comment: "Sum of active ingredient concentration across all products"
    - name: "avg_max_application_rate"
      expr: AVG(CAST(max_application_rate AS DOUBLE))
      comment: "Average maximum application rate"
    - name: "organic_approved_count"
      expr: SUM(CASE WHEN organic_approved_flag THEN 1 ELSE 0 END)
      comment: "Count of products with organic approval"
    - name: "omri_listed_count"
      expr: SUM(CASE WHEN omri_listed_flag THEN 1 ELSE 0 END)
      comment: "Count of products listed in OMRI"
    - name: "avg_package_size"
      expr: AVG(CAST(package_size AS DOUBLE))
      comment: "Average package size"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`product_commodity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic commodity performance metrics for pricing and yield decisions"
  source: "`agriculture_ecm`.`product`.`commodity`"
  dimensions:
    - name: "commodity_type"
      expr: commodity_type
      comment: "Broad type of commodity (e.g., grain, oilseed)"
    - name: "commodity_class"
      expr: commodity_class
      comment: "Classification within commodity type"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin code"
    - name: "crop_year"
      expr: crop_year
      comment: "Crop year associated with the commodity"
    - name: "commodity_status"
      expr: commodity_status
      comment: "Current status of the commodity"
  measures:
    - name: "total_commodities"
      expr: COUNT(1)
      comment: "Total number of commodity records"
    - name: "avg_benchmark_price"
      expr: AVG(CAST(benchmark_price AS DOUBLE))
      comment: "Average benchmark price for commodities"
    - name: "avg_typical_yield_per_acre"
      expr: AVG(CAST(typical_yield_per_acre AS DOUBLE))
      comment: "Average typical yield per acre"
    - name: "avg_moisture_content_max_pct"
      expr: AVG(CAST(moisture_content_max_pct AS DOUBLE))
      comment: "Average maximum moisture content percentage"
    - name: "perishable_flag_count"
      expr: SUM(CASE WHEN perishable_flag THEN 1 ELSE 0 END)
      comment: "Count of perishable commodities"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`product_bundle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bundle-level financial and logistics KPIs for portfolio optimization"
  source: "`agriculture_ecm`.`product`.`bundle`"
  dimensions:
    - name: "bundle_category"
      expr: bundle_category
      comment: "Category of the bundle"
    - name: "bundle_status"
      expr: bundle_status
      comment: "Current status of the bundle"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for pricing"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year the bundle record was created"
    - name: "financing_eligible_flag"
      expr: financing_eligible_flag
      comment: "Flag indicating financing eligibility"
  measures:
    - name: "total_bundles"
      expr: COUNT(1)
      comment: "Total number of bundles"
    - name: "total_list_price"
      expr: SUM(CAST(list_price AS DOUBLE))
      comment: "Sum of list prices across all bundles"
    - name: "avg_discount_pct"
      expr: AVG(CAST(discount_pct AS DOUBLE))
      comment: "Average discount percentage applied to bundles"
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight of bundles in kilograms"
    - name: "financing_eligible_count"
      expr: SUM(CASE WHEN financing_eligible_flag THEN 1 ELSE 0 END)
      comment: "Count of bundles eligible for financing"
$$;