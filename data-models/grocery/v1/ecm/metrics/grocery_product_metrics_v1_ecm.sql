-- Metric views for domain: product | Business: Grocery | Version: 1 | Generated on: 2026-05-04 18:32:13

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`product_order_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order revenue and order count metrics at the order header level"
  source: "`grocery_ecm`.`product`.`order_header`"
  dimensions:
    - name: "order_date"
      expr: order_date
      comment: "Date the order was placed"
  measures:
    - name: "total_order_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Sum of all order total amounts (gross revenue)"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`product_order_header_additional`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplemental order header KPIs for margin and discount analysis"
  source: "`grocery_ecm`.`product`.`order_header`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order"
    - name: "order_channel_id"
      expr: order_channel_id
      comment: "Identifier of the sales channel used"
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location where the order originated"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction"
  measures:
    - name: "total_order_count"
      expr: COUNT(1)
      comment: "Number of orders placed"
    - name: "average_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average order value (AOV) per order"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied across all orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across all orders"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`product_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and quantity metrics at the order line level"
  source: "`grocery_ecm`.`product`.`product_order_line`"
  dimensions:
    - name: "brand_id"
      expr: brand_id
      comment: "Brand identifier for the product"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "line_status"
      expr: line_status
      comment: "Current status of the line item"
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Method used to fulfill the line item"
    - name: "perishable_flag"
      expr: perishable_flag
      comment: "Indicates if the product is perishable"
  measures:
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity of items ordered across all lines"
    - name: "average_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across line items"
    - name: "total_line_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied at line level"
    - name: "total_line_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount at line level"
    - name: "total_line_net"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Net amount after discounts and taxes per line"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`product_cart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cart-level activity and abandonment metrics"
  source: "`grocery_ecm`.`product`.`cart`"
  dimensions:
    - name: "shopper_id"
      expr: shopper_id
      comment: "Identifier of the shopper owning the cart"
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location associated with the cart"
    - name: "cart_status"
      expr: cart_status
      comment: "Current status of the cart"
    - name: "cart_type"
      expr: cart_type
      comment: "Type of cart (e.g., online, in‑store)"
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Method intended for fulfillment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cart"
  measures:
    - name: "total_estimated_total_amount"
      expr: SUM(CAST(estimated_total_amount AS DOUBLE))
      comment: "Sum of estimated total amount for all carts (forecasted revenue)"
    - name: "total_cart_count"
      expr: COUNT(1)
      comment: "Number of carts created"
    - name: "average_estimated_total"
      expr: AVG(CAST(estimated_total_amount AS DOUBLE))
      comment: "Average estimated total per cart"
    - name: "abandoned_cart_count"
      expr: SUM(CASE WHEN abandonment_notification_sent_flag THEN 1 ELSE 0 END)
      comment: "Count of carts where abandonment notification was sent"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`product_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master product item catalog KPIs for pricing, cost and private‑label analysis"
  source: "`grocery_ecm`.`product`.`product_item`"
  dimensions:
    - name: "brand_id"
      expr: brand_id
      comment: "Brand identifier"
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Flag indicating private‑label product"
    - name: "organic_certified_flag"
      expr: organic_certified_flag
      comment: "Flag indicating organic certification"
    - name: "snap_eligible_flag"
      expr: snap_eligible_flag
      comment: "SNAP eligibility flag"
    - name: "created_date"
      expr: created_timestamp
      comment: "Timestamp when the product item record was created"
  measures:
    - name: "total_product_items"
      expr: COUNT(1)
      comment: "Count of distinct product items"
    - name: "average_retail_price"
      expr: AVG(CAST(suggested_retail_price AS DOUBLE))
      comment: "Average suggested retail price across product items"
    - name: "total_cost_of_goods_sold"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total COGS for all product items"
    - name: "average_weight_pounds"
      expr: AVG(CAST(weight_pounds AS DOUBLE))
      comment: "Average weight in pounds of product items"
    - name: "private_label_item_count"
      expr: SUM(CASE WHEN private_label_flag THEN 1 ELSE 0 END)
      comment: "Number of private‑label items"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`product_inventory_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory allocation and availability metrics"
  source: "`grocery_ecm`.`product`.`inventory_allocation`"
  dimensions:
    - name: "storage_location_id"
      expr: storage_location_id
      comment: "Warehouse or storage location identifier"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "expiration_date"
      expr: expiration_date
      comment: "Expiration date of the inventory batch"
    - name: "temperature_celsius"
      expr: temperature_celsius
      comment: "Temperature setting of the storage location"
  measures:
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total quantity available for allocation"
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total on‑hand quantity across locations"
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for pending orders"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs in inventory"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`product_item_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost composition metrics for items"
  source: "`grocery_ecm`.`product`.`item_cost`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
    - name: "cost_type"
      expr: cost_type
      comment: "Classification of cost (e.g., standard, promotional)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost values"
  measures:
    - name: "total_base_unit_cost"
      expr: SUM(CAST(base_unit_cost AS DOUBLE))
      comment: "Sum of base unit cost for all items"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Sum of freight cost incurred"
    - name: "total_handling_cost"
      expr: SUM(CAST(handling_cost AS DOUBLE))
      comment: "Sum of handling cost incurred"
    - name: "average_base_cost"
      expr: AVG(CAST(base_unit_cost AS DOUBLE))
      comment: "Average base unit cost per item"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`product_recommendation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recommendation engine performance metrics"
  source: "`grocery_ecm`.`product`.`product_recommendation`"
  dimensions:
    - name: "recommendation_source"
      expr: recommendation_source
      comment: "Source system or algorithm that generated the recommendation"
    - name: "channel"
      expr: channel
      comment: "Channel where recommendation was shown (e.g., web, app)"
    - name: "device_type"
      expr: device_type
      comment: "Device type of the shopper"
    - name: "recommendation_type"
      expr: recommendation_type
      comment: "Type of recommendation (e.g., upsell, cross‑sell)"
    - name: "created_date"
      expr: created_timestamp
      comment: "Timestamp when the recommendation was created"
  measures:
    - name: "total_recommendations"
      expr: COUNT(1)
      comment: "Total number of product recommendations generated"
    - name: "click_count"
      expr: SUM(CASE WHEN click_flag THEN 1 ELSE 0 END)
      comment: "Number of recommendation clicks"
    - name: "conversion_count"
      expr: SUM(CASE WHEN conversion_flag THEN 1 ELSE 0 END)
      comment: "Number of recommendation conversions (e.g., add‑to‑cart)"
    - name: "average_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average recommendation relevance score"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`product_search_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Search behavior and effectiveness metrics"
  source: "`grocery_ecm`.`product`.`search_query`"
  dimensions:
    - name: "device_type"
      expr: device_type
      comment: "Device type used for the search"
    - name: "locale_code"
      expr: locale_code
      comment: "Locale of the shopper"
    - name: "search_channel"
      expr: search_channel
      comment: "Channel through which the search was performed"
    - name: "created_date"
      expr: created_timestamp
      comment: "Timestamp of the search query"
  measures:
    - name: "total_search_queries"
      expr: COUNT(1)
      comment: "Total number of search queries executed"
    - name: "zero_results_count"
      expr: SUM(CASE WHEN zero_results_flag THEN 1 ELSE 0 END)
      comment: "Number of queries that returned zero results"
    - name: "result_click_count"
      expr: SUM(CASE WHEN result_clicked_flag THEN 1 ELSE 0 END)
      comment: "Number of queries where a result was clicked"
    - name: "average_price_range"
      expr: AVG(filter_price_max - filter_price_min)
      comment: "Average price range filter applied by shoppers"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`product_ab_test_experiment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "A/B testing performance and outcome metrics"
  source: "`grocery_ecm`.`product`.`ab_test_experiment`"
  dimensions:
    - name: "experiment_type"
      expr: experiment_type
      comment: "Type of experiment (e.g., pricing, layout)"
    - name: "channel_scope"
      expr: channel_scope
      comment: "Channel scope of the experiment"
    - name: "target_metric"
      expr: target_metric
      comment: "Primary metric the experiment aims to improve"
    - name: "is_statistically_significant"
      expr: is_statistically_significant
      comment: "Flag indicating statistical significance"
    - name: "start_date"
      expr: start_date
      comment: "Experiment start date"
    - name: "end_date"
      expr: end_date
      comment: "Experiment end date"
  measures:
    - name: "total_experiments"
      expr: COUNT(1)
      comment: "Total number of A/B experiments run"
    - name: "average_confidence_threshold"
      expr: AVG(CAST(confidence_threshold AS DOUBLE))
      comment: "Average confidence threshold across experiments"
    - name: "average_result_metric_value"
      expr: AVG(CAST(result_metric_value AS DOUBLE))
      comment: "Average result metric value across experiments"
    - name: "significant_experiment_count"
      expr: SUM(CASE WHEN is_statistically_significant THEN 1 ELSE 0 END)
      comment: "Count of experiments that achieved statistical significance"
$$;