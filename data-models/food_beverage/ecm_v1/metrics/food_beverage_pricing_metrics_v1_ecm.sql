-- Metric views for domain: pricing | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 21:55:54

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`pricing_channel_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core pricing KPIs from channel_price fact table"
  source: "`food_beverage_ecm`.`pricing`.`channel_price`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "channel_code"
      expr: channel_code
      comment: "Channel where price is applied"
    - name: "price_type"
      expr: price_type
      comment: "Type of price (e.g., list, net)"
    - name: "price_tier"
      expr: price_tier
      comment: "Price tier classification"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month of price effectiveness"
  measures:
    - name: "total_net_price"
      expr: SUM(CAST(net_price AS DOUBLE))
      comment: "Total net price across all channel price records"
    - name: "average_net_price"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net price per channel price record"
    - name: "price_record_count"
      expr: COUNT(1)
      comment: "Number of channel price records"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`pricing_competitor_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitive pricing insights"
  source: "`food_beverage_ecm`.`pricing`.`competitor_price`"
  dimensions:
    - name: "store_id"
      expr: store_id
      comment: "Store identifier"
    - name: "geography_region"
      expr: geography_region
      comment: "Geographic region of the store"
    - name: "retailer_channel"
      expr: retailer_channel
      comment: "Retailer channel"
    - name: "is_promotion"
      expr: is_promotion
      comment: "Flag indicating if price is promotional"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month of price observation"
  measures:
    - name: "average_observed_price"
      expr: AVG(CAST(observed_price AS DOUBLE))
      comment: "Average observed competitor price"
    - name: "average_promotional_price"
      expr: AVG(CAST(promotional_price AS DOUBLE))
      comment: "Average promotional competitor price"
    - name: "competitor_price_record_count"
      expr: COUNT(1)
      comment: "Number of competitor price observations"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`pricing_price_change_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price change request performance metrics"
  source: "`food_beverage_ecm`.`pricing`.`price_change_request`"
  dimensions:
    - name: "account_id"
      expr: account_id
      comment: "Customer account identifier"
    - name: "channel"
      expr: channel
      comment: "Channel where request originated"
    - name: "request_type"
      expr: request_type
      comment: "Type of price change request"
    - name: "request_status"
      expr: price_change_request_status
      comment: "Current status of the request"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of the effective date"
  measures:
    - name: "total_price_change_amount"
      expr: SUM(CAST(price_change_amount AS DOUBLE))
      comment: "Sum of requested price change amounts"
    - name: "price_change_request_count"
      expr: COUNT(1)
      comment: "Number of price change requests"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`pricing_revenue_realization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue realization KPIs by SKU and price zone"
  source: "`food_beverage_ecm`.`pricing`.`revenue_realization`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "price_zone_id"
      expr: price_zone_id
      comment: "Price zone identifier"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of revenue amounts"
    - name: "period_month"
      expr: DATE_TRUNC('month', period_date)
      comment: "Month of the revenue period"
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Total gross revenue realized"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue realized"
    - name: "average_net_revenue_per_unit"
      expr: AVG(CAST(net_revenue_per_unit AS DOUBLE))
      comment: "Average net revenue per unit sold"
    - name: "revenue_record_count"
      expr: COUNT(1)
      comment: "Number of revenue realization records"
$$;