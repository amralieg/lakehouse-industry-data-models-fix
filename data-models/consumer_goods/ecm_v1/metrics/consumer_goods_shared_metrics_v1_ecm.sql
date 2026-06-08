-- Metric views for domain: shared | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 09:03:30

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`shared_region`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key economic and demographic aggregates for geographic regions"
  source: "`consumer_goods_ecm`.`shared`.`region`"
  dimensions:
    - name: "climate_zone"
      expr: climate_zone
      comment: "Climate zone classification of the region"
    - name: "iso_country_code"
      expr: iso_country_code
      comment: "ISO country code for the region"
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchical level of the region within the geographic structure"
    - name: "is_cross_border"
      expr: is_cross_border
      comment: "Indicates whether the region spans multiple countries"
  measures:
    - name: "region_count"
      expr: COUNT(1)
      comment: "Total number of region records"
    - name: "total_population"
      expr: SUM(CAST(population AS DOUBLE))
      comment: "Sum of population across all regions"
    - name: "total_area_sq_km"
      expr: SUM(CAST(area_sq_km AS DOUBLE))
      comment: "Total land area in square kilometers across all regions"
    - name: "total_gdp_usd"
      expr: SUM(CAST(gdp_usd AS DOUBLE))
      comment: "Aggregate GDP in USD for all regions"
    - name: "average_median_income_usd"
      expr: AVG(CAST(median_income_usd AS DOUBLE))
      comment: "Average of median household income (USD) across regions"
    - name: "average_urbanization_rate"
      expr: AVG(CAST(urbanization_rate AS DOUBLE))
      comment: "Average urbanization rate (%) across regions"
$$;