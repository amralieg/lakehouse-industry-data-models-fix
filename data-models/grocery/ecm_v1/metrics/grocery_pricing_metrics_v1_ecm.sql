-- Metric views for domain: pricing | Business: Grocery | Version: 1 | Generated on: 2026-05-04 18:32:13

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pricing_channel_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel price performance and overrides across channels and time."
  source: "`grocery_ecm`.`pricing`.`channel_price`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Channel type (e.g., online, in-store)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price"
    - name: "price_source_system"
      expr: price_source_system
      comment: "Source system of the price"
    - name: "is_price_override"
      expr: is_price_override
      comment: "Flag indicating if price is an override"
    - name: "price_status"
      expr: price_status
      comment: "Current status of the price"
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of price effectiveness"
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "End date of price effectiveness"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
  measures:
    - name: "total_channel_price"
      expr: SUM(CAST(channel_price AS DOUBLE))
      comment: "Total channel price amount"
    - name: "avg_channel_price"
      expr: AVG(CAST(channel_price AS DOUBLE))
      comment: "Average channel price"
    - name: "price_record_count"
      expr: COUNT(1)
      comment: "Number of channel price records"
    - name: "price_override_count"
      expr: SUM(CASE WHEN is_price_override THEN 1 ELSE 0 END)
      comment: "Count of price overrides"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pricing_price_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key price change KPIs to monitor impact on margin and optimization."
  source: "`grocery_ecm`.`pricing`.`price_change`"
  dimensions:
    - name: "price_zone_id"
      expr: price_zone_id
      comment: "Price zone identifier"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location identifier"
    - name: "change_type"
      expr: change_type
      comment: "Type of price change (e.g., increase, decrease)"
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the price change"
  measures:
    - name: "total_price_change_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary amount of price changes"
    - name: "avg_price_change_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average price change amount"
    - name: "price_change_record_count"
      expr: COUNT(1)
      comment: "Number of price change events"
    - name: "margin_impact_percent_avg"
      expr: AVG(CAST(margin_impact_percent AS DOUBLE))
      comment: "Average margin impact percent of price changes"
    - name: "price_optimization_flag_count"
      expr: SUM(CASE WHEN price_optimization_flag THEN 1 ELSE 0 END)
      comment: "Count of price changes flagged for optimization"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pricing_retail_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retail price health and margin monitoring."
  source: "`grocery_ecm`.`pricing`.`retail_price`"
  dimensions:
    - name: "price_zone_id"
      expr: price_zone_id
      comment: "Price zone identifier"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price"
    - name: "price_type_code"
      expr: price_type_code
      comment: "Price type code (e.g., regular, promotional)"
    - name: "price_status"
      expr: price_status
      comment: "Current status of the price"
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the retail price"
  measures:
    - name: "retail_price_record_count"
      expr: COUNT(1)
      comment: "Number of retail price records"
    - name: "margin_percentage_avg"
      expr: AVG(CAST(margin_percentage AS DOUBLE))
      comment: "Average margin percentage across retail prices"
    - name: "price_lock_flag_count"
      expr: SUM(CASE WHEN price_lock_flag THEN 1 ELSE 0 END)
      comment: "Count of prices that are locked"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pricing_cost_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost price analysis for profitability and margin impact."
  source: "`grocery_ecm`.`pricing`.`cost_price`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier"
    - name: "cost_type"
      expr: cost_type
      comment: "Cost type (e.g., freight, tax)"
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost"
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of cost validity"
  measures:
    - name: "total_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost amount"
    - name: "avg_cost"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per record"
    - name: "landed_cost_total"
      expr: SUM(CAST(landed_cost AS DOUBLE))
      comment: "Total landed cost"
    - name: "cost_record_count"
      expr: COUNT(1)
      comment: "Number of cost price records"
    - name: "margin_impact_flag_count"
      expr: SUM(CASE WHEN margin_impact_flag THEN 1 ELSE 0 END)
      comment: "Count of cost records flagged for margin impact"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pricing_recommendation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs to evaluate pricing recommendation engine effectiveness."
  source: "`grocery_ecm`.`pricing`.`pricing_recommendation`"
  dimensions:
    - name: "price_zone_id"
      expr: price_zone_id
      comment: "Price zone identifier"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location identifier"
    - name: "recommendation_status"
      expr: recommendation_status
      comment: "Status of the recommendation (e.g., accepted, rejected)"
    - name: "algorithm_version"
      expr: algorithm_version
      comment: "Version of the recommendation algorithm"
  measures:
    - name: "recommendation_count"
      expr: COUNT(1)
      comment: "Number of pricing recommendations generated"
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average confidence score of recommendations"
    - name: "avg_expected_margin_impact"
      expr: AVG(CAST(expected_margin_impact AS DOUBLE))
      comment: "Average expected margin impact"
    - name: "avg_expected_unit_velocity_change"
      expr: AVG(CAST(expected_unit_velocity_change AS DOUBLE))
      comment: "Average expected unit velocity change"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`pricing_optimization_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic view of pricing optimization runs and their projected impact."
  source: "`grocery_ecm`.`pricing`.`optimization_run`"
  dimensions:
    - name: "fiscal_period_id"
      expr: fiscal_period_id
      comment: "Fiscal period identifier"
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy applied in the run"
    - name: "run_status"
      expr: run_status
      comment: "Current status of the optimization run"
  measures:
    - name: "run_count"
      expr: COUNT(1)
      comment: "Number of optimization runs"
    - name: "total_estimated_margin_impact"
      expr: SUM(CAST(estimated_margin_impact AS DOUBLE))
      comment: "Total estimated margin impact across runs"
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average confidence score of runs"
    - name: "avg_acceptance_rate"
      expr: AVG(CAST(acceptance_rate AS DOUBLE))
      comment: "Average acceptance rate of recommendations"
$$;