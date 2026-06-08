-- Metric views for domain: ecommerce | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 15:42:09

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`ecommerce_digital_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core e-commerce order performance metrics including revenue, conversion, and order economics"
  source: "`apparel_fashion_ecm`.`ecommerce`.`digital_order`"
  dimensions:
    - name: "order_date"
      expr: DATE_TRUNC('day', placed_timestamp)
      comment: "Date the order was placed, truncated to day for daily aggregation"
    - name: "order_month"
      expr: DATE_TRUNC('month', placed_timestamp)
      comment: "Month the order was placed for monthly trend analysis"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order (e.g., pending, confirmed, shipped, delivered, cancelled)"
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel through which the order was placed (e.g., web, mobile app, marketplace)"
    - name: "device_type"
      expr: device_type
      comment: "Device type used to place the order (e.g., desktop, mobile, tablet)"
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Payment method used for the order (e.g., credit card, PayPal, digital wallet)"
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Method of order fulfillment (e.g., ship to home, store pickup, same-day delivery)"
    - name: "is_guest_checkout"
      expr: is_guest_checkout
      comment: "Whether the order was placed via guest checkout (True) or authenticated account (False)"
    - name: "fraud_review_status"
      expr: fraud_review_status
      comment: "Fraud review status of the order (e.g., approved, flagged, under review)"
    - name: "utm_source"
      expr: utm_source
      comment: "Marketing attribution source from UTM parameters"
    - name: "utm_medium"
      expr: utm_medium
      comment: "Marketing attribution medium from UTM parameters"
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "Marketing attribution campaign from UTM parameters"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the order was placed"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of digital orders placed"
    - name: "total_revenue"
      expr: SUM(CAST(grand_total_amount AS DOUBLE))
      comment: "Total gross merchandise value (GMV) from all orders"
    - name: "total_subtotal"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total product subtotal before shipping, tax, and discounts"
    - name: "total_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied across all orders"
    - name: "total_shipping"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping charges collected"
    - name: "total_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on orders"
    - name: "avg_order_value"
      expr: AVG(CAST(grand_total_amount AS DOUBLE))
      comment: "Average order value (AOV) - mean revenue per order"
    - name: "avg_discount_per_order"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per order"
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Discount rate as percentage of subtotal - measures promotional intensity"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across orders"
    - name: "unique_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique customers who placed orders"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`ecommerce_digital_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product-level order line metrics for SKU performance, margin analysis, and merchandising insights"
  source: "`apparel_fashion_ecm`.`ecommerce`.`digital_order_line`"
  dimensions:
    - name: "order_date"
      expr: DATE_TRUNC('day', revenue_recognition_date)
      comment: "Revenue recognition date truncated to day for daily revenue reporting"
    - name: "order_month"
      expr: DATE_TRUNC('month', revenue_recognition_date)
      comment: "Revenue recognition month for monthly financial reporting"
    - name: "product_category"
      expr: product_category
      comment: "Product category of the ordered item"
    - name: "brand_code"
      expr: brand_code
      comment: "Brand identifier for the product"
    - name: "colorway"
      expr: colorway
      comment: "Color variant of the product"
    - name: "size"
      expr: size
      comment: "Size of the product ordered"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of the line item (e.g., pending, shipped, delivered, cancelled)"
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Method used to fulfill the line item (e.g., warehouse, store, drop-ship)"
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Whether the line item is on backorder"
    - name: "gift_wrap_flag"
      expr: gift_wrap_flag
      comment: "Whether gift wrapping was requested for this line item"
    - name: "return_eligible_flag"
      expr: return_eligible_flag
      comment: "Whether the line item is eligible for return"
  measures:
    - name: "total_line_items"
      expr: COUNT(1)
      comment: "Total number of order line items"
    - name: "total_units_ordered"
      expr: SUM(CAST(quantity_ordered AS BIGINT))
      comment: "Total quantity of units ordered across all line items"
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total AS DOUBLE))
      comment: "Total revenue from all order lines including discounts and taxes"
    - name: "total_line_subtotal"
      expr: SUM(CAST(line_subtotal AS DOUBLE))
      comment: "Total line subtotal before discounts and taxes"
    - name: "total_line_discount"
      expr: SUM(CAST(line_discount_amount AS DOUBLE))
      comment: "Total discount amount applied at line level"
    - name: "total_cogs"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold for all line items"
    - name: "gross_profit"
      expr: SUM((CAST(line_total AS DOUBLE)) - (CAST(cogs_amount AS DOUBLE)))
      comment: "Gross profit (revenue minus COGS) - key profitability metric"
    - name: "gross_margin_pct"
      expr: ROUND(100.0 * (SUM(CAST(line_total AS DOUBLE)) - SUM(CAST(cogs_amount AS DOUBLE))) / NULLIF(SUM(CAST(line_total AS DOUBLE)), 0), 2)
      comment: "Gross margin percentage - profitability rate after COGS"
    - name: "avg_unit_selling_price"
      expr: AVG(CAST(unit_selling_price AS DOUBLE))
      comment: "Average selling price per unit across line items"
    - name: "avg_unit_msrp"
      expr: AVG(CAST(unit_msrp AS DOUBLE))
      comment: "Average manufacturer suggested retail price per unit"
    - name: "markdown_rate"
      expr: ROUND(100.0 * (SUM(CAST(unit_msrp AS DOUBLE)) - SUM(CAST(unit_selling_price AS DOUBLE))) / NULLIF(SUM(CAST(unit_msrp AS DOUBLE)), 0), 2)
      comment: "Markdown rate as percentage of MSRP - measures pricing pressure"
    - name: "total_gift_wrap_revenue"
      expr: SUM(CAST(gift_wrap_charge AS DOUBLE))
      comment: "Total revenue from gift wrapping services"
    - name: "total_personalization_revenue"
      expr: SUM(CAST(personalization_charge AS DOUBLE))
      comment: "Total revenue from product personalization services"
    - name: "unique_skus_sold"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of unique SKUs sold"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`ecommerce_cart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shopping cart behavior and abandonment metrics for conversion optimization"
  source: "`apparel_fashion_ecm`.`ecommerce`.`cart`"
  dimensions:
    - name: "cart_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the cart was created"
    - name: "cart_status"
      expr: cart_status
      comment: "Current status of the cart (e.g., active, abandoned, converted, merged)"
    - name: "cart_type"
      expr: cart_type
      comment: "Type of cart (e.g., standard, wishlist, saved for later)"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for cart creation"
    - name: "channel_source"
      expr: channel_source
      comment: "Channel through which the cart was created"
    - name: "guest_checkout_flag"
      expr: guest_checkout_flag
      comment: "Whether the cart is for guest checkout"
    - name: "ab_test_variant"
      expr: ab_test_variant
      comment: "A/B test variant assigned to the cart session"
    - name: "utm_source"
      expr: utm_source
      comment: "Marketing attribution source"
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "Marketing attribution campaign"
  measures:
    - name: "total_carts"
      expr: COUNT(1)
      comment: "Total number of shopping carts created"
    - name: "total_cart_value"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total value of all carts including tax and shipping"
    - name: "total_cart_subtotal"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total product subtotal across all carts"
    - name: "total_cart_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to carts"
    - name: "avg_cart_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average cart value - key metric for cart optimization"
    - name: "avg_items_per_cart"
      expr: AVG(CAST(item_count AS BIGINT))
      comment: "Average number of items per cart"
    - name: "avg_units_per_cart"
      expr: AVG(CAST(unit_count AS BIGINT))
      comment: "Average number of units per cart"
    - name: "unique_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique customers who created carts"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`ecommerce_checkout_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Checkout funnel performance metrics for conversion rate optimization and abandonment analysis"
  source: "`apparel_fashion_ecm`.`ecommerce`.`checkout_session`"
  dimensions:
    - name: "checkout_date"
      expr: DATE_TRUNC('day', checkout_start_timestamp)
      comment: "Date the checkout session started"
    - name: "checkout_status"
      expr: checkout_status
      comment: "Final status of the checkout session (e.g., completed, abandoned, failed)"
    - name: "abandonment_step"
      expr: abandonment_step
      comment: "Step at which checkout was abandoned (e.g., shipping, payment, review)"
    - name: "device_type"
      expr: device_type
      comment: "Device type used during checkout"
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Payment method selected during checkout"
    - name: "payment_gateway"
      expr: payment_gateway
      comment: "Payment gateway used for transaction processing"
    - name: "guest_checkout_flag"
      expr: guest_checkout_flag
      comment: "Whether checkout was completed as guest"
    - name: "error_code"
      expr: error_code
      comment: "Error code if checkout failed"
    - name: "payment_failure_reason"
      expr: payment_failure_reason
      comment: "Reason for payment failure if applicable"
  measures:
    - name: "total_checkout_sessions"
      expr: COUNT(1)
      comment: "Total number of checkout sessions initiated"
    - name: "total_checkout_value"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total value of all checkout sessions"
    - name: "avg_checkout_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average value per checkout session"
    - name: "avg_checkout_duration_seconds"
      expr: AVG(CAST(checkout_duration_seconds AS BIGINT))
      comment: "Average time spent in checkout process - key UX metric"
    - name: "total_discount_at_checkout"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied during checkout"
    - name: "unique_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique customers who initiated checkout"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`ecommerce_digital_return`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product return metrics for quality analysis, customer satisfaction, and reverse logistics optimization"
  source: "`apparel_fashion_ecm`.`ecommerce`.`digital_return`"
  dimensions:
    - name: "return_request_date"
      expr: DATE_TRUNC('day', return_request_date)
      comment: "Date the return was requested by customer"
    - name: "return_month"
      expr: DATE_TRUNC('month', return_request_date)
      comment: "Month of return request for trend analysis"
    - name: "return_status"
      expr: return_status
      comment: "Current status of the return (e.g., requested, approved, received, refunded)"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Coded reason for return (e.g., wrong size, defective, not as described)"
    - name: "return_channel"
      expr: return_channel
      comment: "Channel through which return was initiated"
    - name: "return_method"
      expr: return_method
      comment: "Method of return (e.g., mail, in-store, pickup)"
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition of returned product (e.g., restock, liquidate, destroy)"
    - name: "product_condition"
      expr: product_condition
      comment: "Condition of returned product upon inspection"
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Outcome of quality inspection on returned item"
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to refund customer (e.g., original payment, store credit)"
    - name: "restocking_flag"
      expr: restocking_flag
      comment: "Whether item was restocked to inventory"
  measures:
    - name: "total_returns"
      expr: COUNT(1)
      comment: "Total number of return requests"
    - name: "total_return_quantity"
      expr: SUM(CAST(return_quantity AS BIGINT))
      comment: "Total quantity of units returned"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued to customers"
    - name: "total_restocking_fees"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected"
    - name: "total_return_shipping_cost"
      expr: SUM(CAST(return_shipping_cost AS DOUBLE))
      comment: "Total cost of return shipping borne by company"
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount per return"
    - name: "net_return_cost"
      expr: SUM((CAST(refund_amount AS DOUBLE)) + (CAST(return_shipping_cost AS DOUBLE)) - (CAST(restocking_fee_amount AS DOUBLE)))
      comment: "Net cost of returns after restocking fees - key reverse logistics metric"
    - name: "unique_customers_returning"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique customers who initiated returns"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`ecommerce_web_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Web session engagement and conversion funnel metrics for digital experience optimization"
  source: "`apparel_fashion_ecm`.`ecommerce`.`web_session`"
  dimensions:
    - name: "session_date"
      expr: DATE_TRUNC('day', session_start_timestamp)
      comment: "Date the web session started"
    - name: "session_month"
      expr: DATE_TRUNC('month', session_start_timestamp)
      comment: "Month of session start for trend analysis"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for the session"
    - name: "browser"
      expr: browser
      comment: "Browser used during the session"
    - name: "operating_system"
      expr: operating_system
      comment: "Operating system of the device"
    - name: "channel"
      expr: channel
      comment: "Traffic channel (e.g., organic, paid, direct, referral)"
    - name: "referral_source"
      expr: referral_source
      comment: "Source that referred the session"
    - name: "utm_source"
      expr: utm_source
      comment: "Marketing attribution source"
    - name: "utm_medium"
      expr: utm_medium
      comment: "Marketing attribution medium"
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "Marketing attribution campaign"
    - name: "geographic_country_code"
      expr: geographic_country_code
      comment: "Country from which session originated"
    - name: "bounce_flag"
      expr: bounce_flag
      comment: "Whether the session was a bounce (single page view)"
    - name: "conversion_flag"
      expr: conversion_flag
      comment: "Whether the session resulted in a conversion"
    - name: "checkout_initiated_flag"
      expr: checkout_initiated_flag
      comment: "Whether checkout was initiated during the session"
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of web sessions"
    - name: "avg_session_duration_seconds"
      expr: AVG(CAST(session_duration_seconds AS BIGINT))
      comment: "Average session duration in seconds - key engagement metric"
    - name: "avg_page_views_per_session"
      expr: AVG(CAST(page_views AS BIGINT))
      comment: "Average number of page views per session"
    - name: "avg_product_page_views"
      expr: AVG(CAST(product_page_views AS BIGINT))
      comment: "Average product page views per session"
    - name: "avg_add_to_cart_count"
      expr: AVG(CAST(add_to_cart_count AS BIGINT))
      comment: "Average number of add-to-cart actions per session"
    - name: "avg_search_query_count"
      expr: AVG(CAST(search_query_count AS BIGINT))
      comment: "Average number of search queries per session"
    - name: "unique_visitors"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique visitors (profiles) across sessions"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`ecommerce_product_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product review and rating metrics for quality monitoring and customer sentiment analysis"
  source: "`apparel_fashion_ecm`.`ecommerce`.`product_review`"
  dimensions:
    - name: "review_date"
      expr: DATE_TRUNC('day', submission_timestamp)
      comment: "Date the review was submitted"
    - name: "review_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month of review submission"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall star rating given by reviewer"
    - name: "fit_rating"
      expr: fit_rating
      comment: "Rating for product fit"
    - name: "quality_rating"
      expr: quality_rating
      comment: "Rating for product quality"
    - name: "comfort_rating"
      expr: comfort_rating
      comment: "Rating for product comfort"
    - name: "value_rating"
      expr: value_rating
      comment: "Rating for product value"
    - name: "moderation_status"
      expr: moderation_status
      comment: "Moderation status of the review (e.g., approved, pending, rejected)"
    - name: "verified_purchase_flag"
      expr: verified_purchase_flag
      comment: "Whether the review is from a verified purchase"
    - name: "recommend_flag"
      expr: recommend_flag
      comment: "Whether the reviewer recommends the product"
    - name: "incentivized_review_flag"
      expr: incentivized_review_flag
      comment: "Whether the review was incentivized"
    - name: "review_source_channel"
      expr: review_source_channel
      comment: "Channel through which review was submitted"
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of product reviews submitted"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across reviews - key customer satisfaction metric"
    - name: "avg_helpful_votes"
      expr: AVG(CAST(helpful_votes_count AS BIGINT))
      comment: "Average number of helpful votes per review"
    - name: "avg_unhelpful_votes"
      expr: AVG(CAST(unhelpful_votes_count AS BIGINT))
      comment: "Average number of unhelpful votes per review"
    - name: "unique_reviewers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique customers who submitted reviews"
    - name: "unique_products_reviewed"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of unique SKUs that received reviews"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`ecommerce_search_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site search performance metrics for search relevance optimization and merchandising insights"
  source: "`apparel_fashion_ecm`.`ecommerce`.`search_query`"
  dimensions:
    - name: "search_date"
      expr: DATE_TRUNC('day', search_timestamp)
      comment: "Date the search was performed"
    - name: "search_month"
      expr: DATE_TRUNC('month', search_timestamp)
      comment: "Month of search for trend analysis"
    - name: "search_type"
      expr: search_type
      comment: "Type of search (e.g., keyword, category, filter)"
    - name: "search_method"
      expr: search_method
      comment: "Method used for search (e.g., text input, voice, autocomplete)"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for search"
    - name: "null_result_flag"
      expr: null_result_flag
      comment: "Whether the search returned zero results - key search quality metric"
    - name: "click_through_flag"
      expr: click_through_flag
      comment: "Whether user clicked on a search result"
    - name: "conversion_flag"
      expr: conversion_flag
      comment: "Whether the search led to a conversion"
    - name: "add_to_cart_flag"
      expr: add_to_cart_flag
      comment: "Whether user added item to cart from search results"
    - name: "spell_correction_applied_flag"
      expr: spell_correction_applied_flag
      comment: "Whether spell correction was applied to the search term"
    - name: "personalization_applied_flag"
      expr: personalization_applied_flag
      comment: "Whether personalization was applied to search results"
    - name: "merchandising_rule_applied_flag"
      expr: merchandising_rule_applied_flag
      comment: "Whether merchandising rules influenced search results"
  measures:
    - name: "total_searches"
      expr: COUNT(1)
      comment: "Total number of search queries performed"
    - name: "avg_results_count"
      expr: AVG(CAST(results_count AS BIGINT))
      comment: "Average number of results returned per search"
    - name: "avg_results_viewed"
      expr: AVG(CAST(results_viewed_count AS BIGINT))
      comment: "Average number of results viewed by users"
    - name: "avg_search_duration_seconds"
      expr: AVG(CAST(search_duration_seconds AS BIGINT))
      comment: "Average time spent on search results page"
    - name: "total_search_revenue"
      expr: SUM(CAST(search_revenue_amount AS DOUBLE))
      comment: "Total revenue attributed to search - key search ROI metric"
    - name: "avg_search_revenue"
      expr: AVG(CAST(search_revenue_amount AS DOUBLE))
      comment: "Average revenue per search query"
    - name: "unique_searchers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique users who performed searches"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`ecommerce_ab_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "A/B test performance metrics for experimentation program measurement and optimization decision-making"
  source: "`apparel_fashion_ecm`.`ecommerce`.`ab_test`"
  dimensions:
    - name: "test_start_date"
      expr: DATE_TRUNC('day', start_date)
      comment: "Date the A/B test started"
    - name: "test_status"
      expr: test_status
      comment: "Current status of the test (e.g., draft, running, completed, cancelled)"
    - name: "test_type"
      expr: test_type
      comment: "Type of A/B test (e.g., UI, pricing, merchandising, algorithm)"
    - name: "test_category"
      expr: test_category
      comment: "Category of the test for organizational grouping"
    - name: "primary_success_metric"
      expr: primary_success_metric
      comment: "Primary metric being optimized in the test"
    - name: "rollout_decision"
      expr: rollout_decision
      comment: "Decision on whether to roll out the winning variant"
    - name: "winner_variant"
      expr: winner_variant
      comment: "Variant declared as winner based on test results"
  measures:
    - name: "total_tests"
      expr: COUNT(1)
      comment: "Total number of A/B tests conducted"
    - name: "avg_lift_percent"
      expr: AVG(CAST(lift_percent AS DOUBLE))
      comment: "Average lift percentage achieved across tests - key experimentation ROI metric"
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level_percent AS DOUBLE))
      comment: "Average statistical confidence level across tests"
    - name: "avg_p_value"
      expr: AVG(CAST(p_value AS DOUBLE))
      comment: "Average p-value across tests for statistical significance assessment"
    - name: "total_control_impressions"
      expr: SUM(CAST(control_impressions AS BIGINT))
      comment: "Total impressions in control variants"
    - name: "total_treatment_impressions"
      expr: SUM(CAST(treatment_impressions AS BIGINT))
      comment: "Total impressions in treatment variants"
    - name: "total_control_conversions"
      expr: SUM(CAST(control_conversions AS BIGINT))
      comment: "Total conversions in control variants"
    - name: "total_treatment_conversions"
      expr: SUM(CAST(treatment_conversions AS BIGINT))
      comment: "Total conversions in treatment variants"
    - name: "avg_control_conversion_rate"
      expr: AVG(CAST(control_conversion_rate_percent AS DOUBLE))
      comment: "Average conversion rate in control variants"
    - name: "avg_treatment_conversion_rate"
      expr: AVG(CAST(treatment_conversion_rate_percent AS DOUBLE))
      comment: "Average conversion rate in treatment variants"
    - name: "avg_control_aov"
      expr: AVG(CAST(control_aov AS DOUBLE))
      comment: "Average order value in control variants"
    - name: "avg_treatment_aov"
      expr: AVG(CAST(treatment_aov AS DOUBLE))
      comment: "Average order value in treatment variants"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`ecommerce_site_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional campaign performance metrics for marketing ROI and discount strategy optimization"
  source: "`apparel_fashion_ecm`.`ecommerce`.`site_promotion`"
  dimensions:
    - name: "promotion_start_date"
      expr: DATE_TRUNC('day', start_date)
      comment: "Date the promotion started"
    - name: "promotion_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the promotion started"
    - name: "promotion_status"
      expr: promotion_status
      comment: "Current status of the promotion (e.g., active, scheduled, expired, cancelled)"
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of promotion (e.g., percentage off, fixed amount, BOGO, free shipping)"
    - name: "customer_segment_code"
      expr: customer_segment_code
      comment: "Target customer segment for the promotion"
    - name: "channel_restriction"
      expr: channel_restriction
      comment: "Channel restrictions for promotion applicability"
    - name: "auto_apply_flag"
      expr: auto_apply_flag
      comment: "Whether the promotion is automatically applied at checkout"
    - name: "stackable_flag"
      expr: stackable_flag
      comment: "Whether the promotion can be stacked with other offers"
  measures:
    - name: "total_promotions"
      expr: COUNT(1)
      comment: "Total number of promotional campaigns"
    - name: "total_redemptions"
      expr: SUM(CAST(redemption_count AS BIGINT))
      comment: "Total number of promotion redemptions"
    - name: "total_orders_with_promotion"
      expr: SUM(CAST(order_count AS BIGINT))
      comment: "Total number of orders that used promotions"
    - name: "total_revenue_impact"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact (discount cost) of promotions - key promotional cost metric"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount given through promotions"
    - name: "avg_discount_per_promotion"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per promotion"
    - name: "avg_redemptions_per_promotion"
      expr: AVG(CAST(redemption_count AS BIGINT))
      comment: "Average number of redemptions per promotion"
    - name: "avg_minimum_order_value"
      expr: AVG(CAST(minimum_order_value AS DOUBLE))
      comment: "Average minimum order value threshold across promotions"
    - name: "avg_maximum_discount"
      expr: AVG(CAST(maximum_discount_amount AS DOUBLE))
      comment: "Average maximum discount cap across promotions"
$$;