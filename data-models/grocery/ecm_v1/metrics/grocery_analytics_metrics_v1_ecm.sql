-- Metric views for domain: analytics | Business: Grocery | Version: 1 | Generated on: 2026-05-04 18:32:13

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`analytics_store_sales`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core sales performance metrics at store level"
  source: "`grocery_ecm`.`analytics`.`store_sales_fact`"
  dimensions:
    - name: "store_location_id"
      expr: store_location_id
      comment: "Identifier of the store location"
    - name: "sales_month"
      expr: DATE_TRUNC('month', sales_date)
      comment: "Month of the sales transaction"
    - name: "store_type"
      expr: store_type
      comment: "Store type (e.g., Supermarket, Pharmacy)"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Channel through which the sale occurred"
  measures:
    - name: "total_gross_sales_amount"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales amount across all transactions"
    - name: "total_net_sales_amount"
      expr: SUM(CAST(net_sales_amount AS DOUBLE))
      comment: "Total net sales amount after discounts and returns"
    - name: "average_gross_margin_percent"
      expr: AVG(CAST(gross_margin_percent AS DOUBLE))
      comment: "Average gross margin percent per transaction"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Baseline count of sales fact rows"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`analytics_basket_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Basket level performance and promotion impact"
  source: "`grocery_ecm`.`analytics`.`basket_summary`"
  dimensions:
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location identifier"
    - name: "basket_date"
      expr: basket_date
      comment: "Date of the basket"
    - name: "store_region"
      expr: store_region
      comment: "Geographic region of the store"
    - name: "store_format"
      expr: store_format
      comment: "Store format (e.g., Urban, Suburban)"
    - name: "basket_size_tier"
      expr: basket_size_tier
      comment: "Tier classification of basket size"
  measures:
    - name: "total_basket_count"
      expr: SUM(CAST(basket_count AS DOUBLE))
      comment: "Total number of baskets"
    - name: "total_net_sales_amount"
      expr: SUM(CAST(net_sales_amount AS DOUBLE))
      comment: "Total net sales amount from baskets"
    - name: "average_basket_value"
      expr: AVG(CAST(average_basket_value AS DOUBLE))
      comment: "Average monetary value per basket"
    - name: "average_items_per_basket"
      expr: AVG(CAST(average_items_per_basket AS DOUBLE))
      comment: "Average number of items per basket"
    - name: "promotional_basket_count"
      expr: SUM(CASE WHEN promotional_basket_flag THEN 1 ELSE 0 END)
      comment: "Count of baskets that included promotional items"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`analytics_inventory_analytics`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key inventory health indicators"
  source: "`grocery_ecm`.`analytics`.`inventory_analytics_fact`"
  dimensions:
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location identifier"
    - name: "category_id"
      expr: category_id
      comment: "Product category identifier"
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Date of the inventory snapshot"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier"
  measures:
    - name: "total_on_hand_dollars"
      expr: SUM(CAST(on_hand_dollars AS DOUBLE))
      comment: "Total dollar value of inventory on hand"
    - name: "average_inventory_turns"
      expr: AVG(CAST(inventory_turns AS DOUBLE))
      comment: "Average inventory turns indicating replenishment speed"
    - name: "average_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average fill rate across SKUs"
    - name: "average_days_of_supply"
      expr: AVG(CAST(days_of_supply AS DOUBLE))
      comment: "Average days of supply on hand"
    - name: "inventory_record_count"
      expr: COUNT(1)
      comment: "Baseline count of inventory fact rows"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`analytics_loyalty_analytics`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty program performance metrics"
  source: "`grocery_ecm`.`analytics`.`loyalty_analytics_fact`"
  dimensions:
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location identifier"
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the reporting period"
    - name: "program_status"
      expr: program_status
      comment: "Current status of the loyalty program"
  measures:
    - name: "total_loyalty_sales_amount"
      expr: SUM(CAST(loyalty_sales_amount AS DOUBLE))
      comment: "Total sales amount attributed to loyalty members"
    - name: "new_member_count"
      expr: SUM(CAST(new_enrollments AS DOUBLE))
      comment: "Number of new loyalty members enrolled"
    - name: "active_member_count"
      expr: SUM(CAST(active_member_count AS DOUBLE))
      comment: "Count of active loyalty members"
    - name: "average_redemption_rate"
      expr: AVG(CAST(redemption_rate AS DOUBLE))
      comment: "Average redemption rate of loyalty offers"
    - name: "loyalty_record_count"
      expr: COUNT(1)
      comment: "Baseline count of loyalty analytics rows"
$$;