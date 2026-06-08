-- Metric views for domain: product | Business: Automotive | Version: 1 | Generated on: 2026-05-07 00:10:14

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`product_bom_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and weight KPIs for Bill of Materials (BOM) headers"
  source: "`automotive_ecm`.`product`.`bom_header`"
  dimensions:
    - name: "adas_level"
      expr: adas_level
      comment: "ADAS capability level of the vehicle"
    - name: "market_region"
      expr: market_region
      comment: "Geographic market region"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain classification (e.g., ICE, Hybrid, EV)"
    - name: "bom_status"
      expr: bom_status
      comment: "Current status of the BOM (e.g., Draft, Approved)"
    - name: "is_configurable"
      expr: is_configurable
      comment: "Indicates if the BOM is configurable"
  measures:
    - name: "total_msrp_base_amount"
      expr: SUM(CAST(msrp_base_amount AS DOUBLE))
      comment: "Total MSRP base amount across all BOM headers"
    - name: "total_standard_cost_amount"
      expr: SUM(CAST(standard_cost_amount AS DOUBLE))
      comment: "Total standard cost amount across all BOM headers"
    - name: "average_total_assembly_weight_kg"
      expr: AVG(CAST(total_assembly_weight_kg AS DOUBLE))
      comment: "Average total assembly weight (kg) per BOM header"
    - name: "bom_header_count"
      expr: COUNT(1)
      comment: "Number of BOM header records"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`product_pricing_condition_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing condition impact metrics for product catalog versions"
  source: "`automotive_ecm`.`product`.`pricing_condition_assignment`"
  dimensions:
    - name: "condition_type"
      expr: condition_type
      comment: "Type of pricing condition (e.g., Discount, Surcharge)"
    - name: "condition_status"
      expr: condition_status
      comment: "Current status of the condition"
    - name: "effective_start_year"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year when the condition became effective"
    - name: "effective_end_year"
      expr: DATE_TRUNC('year', effective_end_date)
      comment: "Year when the condition ended"
  measures:
    - name: "total_condition_value"
      expr: SUM(CAST(condition_value AS DOUBLE))
      comment: "Sum of pricing condition values"
    - name: "average_condition_value"
      expr: AVG(CAST(condition_value AS DOUBLE))
      comment: "Average pricing condition value"
    - name: "pricing_condition_assignment_count"
      expr: COUNT(1)
      comment: "Number of pricing condition assignments"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`product_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic segment performance and pricing metrics"
  source: "`automotive_ecm`.`product`.`product_segment`"
  dimensions:
    - name: "segment_name"
      expr: segment_name
      comment: "Human‑readable name of the product segment"
    - name: "segment_code"
      expr: segment_code
      comment: "Internal code identifying the segment"
    - name: "powertrain_category"
      expr: powertrain_category
      comment: "Powertrain category associated with the segment"
    - name: "is_active"
      expr: is_active
      comment: "Indicates if the segment is currently active"
    - name: "ota_update_capability"
      expr: ota_update_capability
      comment: "Indicates OTA update capability for the segment"
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchy level of the segment within product taxonomy"
    - name: "market_positioning_tier"
      expr: market_positioning_tier
      comment: "Strategic market positioning tier"
  measures:
    - name: "average_market_share_target_pct"
      expr: AVG(CAST(market_share_target_pct AS DOUBLE))
      comment: "Average target market share percentage for segments"
    - name: "average_price_range_max_usd"
      expr: AVG(CAST(price_range_max_usd AS DOUBLE))
      comment: "Average maximum price range (USD) across segments"
    - name: "average_price_range_min_usd"
      expr: AVG(CAST(price_range_min_usd AS DOUBLE))
      comment: "Average minimum price range (USD) across segments"
    - name: "product_segment_count"
      expr: COUNT(1)
      comment: "Number of product segment records"
$$;