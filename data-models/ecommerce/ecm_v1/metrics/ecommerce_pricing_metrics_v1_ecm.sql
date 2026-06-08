-- Metric views for domain: pricing | Business: Ecommerce | Version: 1 | Generated on: 2026-05-04 23:19:28

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`pricing_price_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core pricing list health and pricing strategy metrics"
  source: "`ecommerce_ecm`.`pricing`.`price_list`"
  dimensions:
    - name: "price_list_status"
      expr: price_list_status
      comment: "Current status of the price list (e.g., active, retired)"
    - name: "price_type"
      expr: price_type
      comment: "Classification of price list (e.g., retail, wholesale)"
    - name: "region"
      expr: region
      comment: "Geographic region the price list applies to"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price list"
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Date when the price list becomes effective"
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "Date when the price list expires"
  measures:
    - name: "total_base_price"
      expr: SUM(CAST(base_price AS DOUBLE))
      comment: "Total base price across all price lists"
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price per price list"
    - name: "max_base_price"
      expr: MAX(CAST(base_price AS DOUBLE))
      comment: "Maximum base price among price lists"
    - name: "min_base_price"
      expr: MIN(CAST(base_price AS DOUBLE))
      comment: "Minimum base price among price lists"
    - name: "price_list_count"
      expr: COUNT(1)
      comment: "Number of price list records"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`pricing_price_list_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item‑level pricing details for analysis of price distribution and elasticity"
  source: "`ecommerce_ecm`.`pricing`.`price_list_item`"
  dimensions:
    - name: "price_type"
      expr: price_type
      comment: "Type of price (e.g., list, sale, promotional)"
    - name: "price_source"
      expr: price_source
      comment: "Source system or policy that generated the price"
    - name: "is_promotional"
      expr: is_promotional
      comment: "Flag indicating if the price is promotional"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price"
    - name: "effective_from"
      expr: effective_from
      comment: "Start date of the price validity"
    - name: "effective_until"
      expr: effective_until
      comment: "End date of the price validity"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the SKU"
  measures:
    - name: "total_base_price"
      expr: SUM(CAST(base_price AS DOUBLE))
      comment: "Sum of base prices for all price list items"
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price per item"
    - name: "total_tier_price"
      expr: SUM(CAST(tier_price AS DOUBLE))
      comment: "Total tier price across items"
    - name: "avg_tier_price"
      expr: AVG(CAST(tier_price AS DOUBLE))
      comment: "Average tier price per item"
    - name: "avg_price_elasticity_score"
      expr: AVG(CAST(price_elasticity_score AS DOUBLE))
      comment: "Average price elasticity score for items"
    - name: "price_list_item_count"
      expr: COUNT(1)
      comment: "Number of price list item records"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`pricing_price_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Historical price movement tracking for SKU‑level analysis"
  source: "`ecommerce_ecm`.`pricing`.`price_history`"
  dimensions:
    - name: "change_reason"
      expr: change_reason
      comment: "Reason for the price change (e.g., promotion, cost update)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price change"
    - name: "price_change_type"
      expr: price_change_type
      comment: "Classification of change (e.g., increase, decrease)"
    - name: "is_manual_override"
      expr: is_manual_override
      comment: "Flag indicating if the change was manually overridden"
    - name: "effective_timestamp"
      expr: effective_timestamp
      comment: "Timestamp when the price change took effect"
  measures:
    - name: "price_change_count"
      expr: COUNT(1)
      comment: "Number of price change events recorded"
    - name: "avg_price_change_amount"
      expr: AVG(CAST(price_change_amount AS DOUBLE))
      comment: "Average absolute price change amount"
    - name: "total_price_change_amount"
      expr: SUM(CAST(price_change_amount AS DOUBLE))
      comment: "Total sum of price change amounts"
    - name: "avg_price_before"
      expr: AVG(CAST(price_before AS DOUBLE))
      comment: "Average price before change"
    - name: "avg_price_after"
      expr: AVG(CAST(price_after AS DOUBLE))
      comment: "Average price after change"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`pricing_competitor_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitive pricing intelligence to benchmark against market"
  source: "`ecommerce_ecm`.`pricing`.`competitor_price`"
  dimensions:
    - name: "competitor_price_status"
      expr: competitor_price_status
      comment: "Status of the competitor price record"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the observed price"
    - name: "price_type"
      expr: price_type
      comment: "Type of price observed (e.g., list, sale)"
    - name: "region"
      expr: region
      comment: "Geographic region of the competitor price"
    - name: "price_change_flag"
      expr: price_change_flag
      comment: "Indicates if the competitor price changed since last capture"
  measures:
    - name: "avg_observed_price"
      expr: AVG(CAST(observed_price AS DOUBLE))
      comment: "Average observed competitor price"
    - name: "avg_match_confidence"
      expr: AVG(CAST(match_confidence AS DOUBLE))
      comment: "Average confidence score of price match"
    - name: "competitor_price_record_count"
      expr: COUNT(1)
      comment: "Number of competitor price observations"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`pricing_dynamic_price_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on dynamic pricing rules to assess aggressiveness and coverage"
  source: "`ecommerce_ecm`.`pricing`.`dynamic_price_rule`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Category of rule (e.g., discount, surcharge)"
    - name: "is_active"
      expr: is_active
      comment: "Whether the rule is currently active"
    - name: "is_global"
      expr: is_global
      comment: "Flag indicating if rule applies globally"
    - name: "brand_code"
      expr: brand_code
      comment: "Brand code the rule targets"
    - name: "category_code"
      expr: category_code
      comment: "Product category code the rule targets"
    - name: "priority"
      expr: priority
      comment: "Priority ordering of rule execution"
    - name: "rule_status"
      expr: rule_status
      comment: "Current status of the rule (e.g., draft, deployed)"
    - name: "effective_from"
      expr: effective_from
      comment: "Start date when rule becomes effective"
    - name: "effective_until"
      expr: effective_until
      comment: "End date when rule expires"
  measures:
    - name: "dynamic_price_rule_count"
      expr: COUNT(1)
      comment: "Total number of dynamic price rules defined"
    - name: "avg_adjustment_value"
      expr: AVG(CAST(adjustment_value AS DOUBLE))
      comment: "Average numeric adjustment applied by rules"
    - name: "avg_ceiling_price"
      expr: AVG(CAST(ceiling_price AS DOUBLE))
      comment: "Average ceiling price across rules"
    - name: "avg_floor_price"
      expr: AVG(CAST(floor_price AS DOUBLE))
      comment: "Average floor price across rules"
    - name: "avg_price_elasticity_score"
      expr: AVG(CAST(price_elasticity_score AS DOUBLE))
      comment: "Average elasticity score for dynamic pricing"
$$;