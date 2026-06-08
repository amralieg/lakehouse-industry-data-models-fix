-- Metric views for domain: product | Business: Ecommerce | Version: 1 | Generated on: 2026-05-04 23:19:28

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`product_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key brand performance indicators"
  source: "`ecommerce_ecm`.`product`.`brand`"
  dimensions:
    - name: "brand_name"
      expr: brand_name
      comment: "Human readable brand name"
    - name: "brand_status"
      expr: brand_status
      comment: "Current status of the brand (e.g., active, discontinued)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the brand originates"
    - name: "tier"
      expr: tier
      comment: "Brand tier classification"
  measures:
    - name: "total_brands"
      expr: COUNT(1)
      comment: "Count of brand records"
    - name: "average_brand_rating"
      expr: AVG(CAST(average_rating AS DOUBLE))
      comment: "Average rating across all brands"
    - name: "average_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score for brands"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`product_listing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and quality metrics for product listings"
  source: "`ecommerce_ecm`.`product`.`product_listing`"
  dimensions:
    - name: "brand_name"
      expr: brand_name
      comment: "Brand associated with the listing"
    - name: "category_path"
      expr: category_path
      comment: "Hierarchical category path"
    - name: "channel_code"
      expr: channel_code
      comment: "Sales channel identifier"
    - name: "listing_status"
      expr: listing_status
      comment: "Current status of the listing (e.g., active, paused)"
  measures:
    - name: "total_listings"
      expr: COUNT(1)
      comment: "Number of product listings"
    - name: "average_price"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average listed price"
    - name: "average_compare_at_price"
      expr: AVG(CAST(compare_at_price AS DOUBLE))
      comment: "Average compare‑at price (original price before discount)"
    - name: "average_shipping_weight_kg"
      expr: AVG(CAST(shipping_weight_kg AS DOUBLE))
      comment: "Average shipping weight in kilograms"
    - name: "average_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score assigned to listings"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical and compliance characteristics of SKUs"
  source: "`ecommerce_ecm`.`product`.`sku`"
  dimensions:
    - name: "sku_status"
      expr: sku_status
      comment: "Current status of the SKU"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the SKU is manufactured"
    - name: "manufacturer_part_number"
      expr: manufacturer_part_number
      comment: "Manufacturer part number for the SKU"
    - name: "is_hazmat"
      expr: hazmat_flag
      comment: "Hazardous material flag"
  measures:
    - name: "total_skus"
      expr: COUNT(1)
      comment: "Count of SKU records"
    - name: "average_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average weight of SKUs in kilograms"
    - name: "average_height_cm"
      expr: AVG(CAST(height_cm AS DOUBLE))
      comment: "Average height of SKUs in centimeters"
    - name: "average_length_cm"
      expr: AVG(CAST(length_cm AS DOUBLE))
      comment: "Average length of SKUs in centimeters"
    - name: "average_width_cm"
      expr: AVG(CAST(width_cm AS DOUBLE))
      comment: "Average width of SKUs in centimeters"
    - name: "hazmat_sku_ratio"
      expr: AVG(CASE WHEN hazmat_flag THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of SKUs flagged as hazardous material"
$$;