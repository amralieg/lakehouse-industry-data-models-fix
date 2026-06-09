-- Metric views for domain: ecommerce | Business: Retail | Version: 1 | Generated on: 2026-05-04 11:04:04

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`ecommerce_cart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shopping cart performance metrics tracking cart value, abandonment, conversion, and discount effectiveness"
  source: "`retail_ecm`.`ecommerce`.`cart`"
  dimensions:
    - name: "cart_status"
      expr: cart_status
      comment: "Current status of the shopping cart (active, abandoned, converted)"
    - name: "channel"
      expr: channel
      comment: "Sales channel where cart was created (web, mobile, app)"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for cart creation (desktop, mobile, tablet)"
    - name: "is_abandoned"
      expr: is_abandoned
      comment: "Flag indicating whether cart was abandoned"
    - name: "is_guest_cart"
      expr: is_guest_cart
      comment: "Flag indicating guest checkout vs registered user"
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment method selected (ship to home, BOPIS, etc.)"
    - name: "cart_created_date"
      expr: DATE(created_timestamp)
      comment: "Date when cart was created"
    - name: "cart_created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when cart was created for trend analysis"
  measures:
    - name: "total_carts"
      expr: COUNT(1)
      comment: "Total number of shopping carts created"
    - name: "total_cart_value"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross merchandise value across all carts"
    - name: "avg_cart_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average cart value - key metric for pricing and promotion strategy"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied across all carts"
    - name: "discount_penetration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN CAST(discount_amount AS DOUBLE) > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carts with discounts applied - measures promotion effectiveness"
    - name: "abandoned_carts"
      expr: COUNT(CASE WHEN is_abandoned = TRUE THEN 1 END)
      comment: "Number of abandoned carts - critical for recovery campaigns"
    - name: "cart_abandonment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_abandoned = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Cart abandonment rate - key conversion funnel metric"
    - name: "converted_carts"
      expr: COUNT(CASE WHEN cart_status = 'converted' THEN 1 END)
      comment: "Number of carts that converted to orders"
    - name: "cart_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cart_status = 'converted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Cart to order conversion rate - primary ecommerce funnel KPI"
    - name: "avg_items_per_cart"
      expr: AVG(CAST(item_count AS DOUBLE))
      comment: "Average number of items per cart - basket size indicator"
    - name: "guest_checkout_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_guest_cart = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guest checkouts vs registered - impacts customer acquisition strategy"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`ecommerce_checkout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Checkout funnel performance metrics tracking completion rates, abandonment points, and payment success"
  source: "`retail_ecm`.`ecommerce`.`checkout`"
  dimensions:
    - name: "checkout_status"
      expr: checkout_status
      comment: "Current checkout status (initiated, completed, abandoned)"
    - name: "channel"
      expr: channel
      comment: "Sales channel for checkout (web, mobile, app)"
    - name: "device_type"
      expr: device_type
      comment: "Device type used during checkout"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method selected (credit card, PayPal, etc.)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment processing status"
    - name: "abandonment_step"
      expr: abandonment_step
      comment: "Step where checkout was abandoned - critical for funnel optimization"
    - name: "is_guest_checkout"
      expr: is_guest_checkout
      comment: "Guest vs registered user checkout"
    - name: "fulfillment_mode"
      expr: fulfillment_mode
      comment: "Fulfillment method selected"
    - name: "checkout_initiated_date"
      expr: DATE(initiated_timestamp)
      comment: "Date when checkout was initiated"
    - name: "checkout_initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_timestamp)
      comment: "Month when checkout was initiated"
  measures:
    - name: "total_checkouts"
      expr: COUNT(1)
      comment: "Total number of checkout sessions initiated"
    - name: "completed_checkouts"
      expr: COUNT(CASE WHEN checkout_status = 'completed' THEN 1 END)
      comment: "Number of successfully completed checkouts"
    - name: "checkout_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN checkout_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Checkout completion rate - critical conversion metric"
    - name: "abandoned_checkouts"
      expr: COUNT(CASE WHEN checkout_status = 'abandoned' THEN 1 END)
      comment: "Number of abandoned checkout sessions"
    - name: "checkout_abandonment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN checkout_status = 'abandoned' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Checkout abandonment rate - key friction indicator"
    - name: "total_order_value"
      expr: SUM(CAST(order_total_amount AS DOUBLE))
      comment: "Total order value from all checkouts"
    - name: "avg_order_value"
      expr: AVG(CAST(order_total_amount AS DOUBLE))
      comment: "Average order value - key revenue per transaction metric"
    - name: "total_shipping_revenue"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping revenue collected"
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected"
    - name: "payment_entry_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_payment_entry_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage completing payment entry step - funnel drop-off indicator"
    - name: "address_entry_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_address_entry_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage completing address entry - friction point metric"
    - name: "guest_checkout_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_guest_checkout = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Guest checkout rate - impacts registration strategy"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`ecommerce_digital_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment processing performance metrics tracking authorization rates, fraud, and payment method effectiveness"
  source: "`retail_ecm`.`ecommerce`.`digital_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Payment processing status (authorized, captured, failed, refunded)"
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Type of payment method used"
    - name: "payment_gateway"
      expr: payment_gateway
      comment: "Payment gateway provider"
    - name: "card_network"
      expr: card_network
      comment: "Card network (Visa, Mastercard, Amex, etc.)"
    - name: "fraud_screening_result"
      expr: fraud_screening_result
      comment: "Fraud screening outcome"
    - name: "three_ds_status"
      expr: three_ds_status
      comment: "3D Secure authentication status"
    - name: "wallet_provider"
      expr: wallet_provider
      comment: "Digital wallet provider (Apple Pay, Google Pay, etc.)"
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel where payment was processed"
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Billing country for geographic analysis"
    - name: "payment_initiated_date"
      expr: DATE(initiated_timestamp)
      comment: "Date when payment was initiated"
    - name: "payment_initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_timestamp)
      comment: "Month when payment was initiated"
  measures:
    - name: "total_payment_transactions"
      expr: COUNT(1)
      comment: "Total number of payment transactions attempted"
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment amount processed"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after fees"
    - name: "avg_transaction_value"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment transaction value"
    - name: "authorized_payments"
      expr: COUNT(CASE WHEN payment_status = 'authorized' OR payment_status = 'captured' THEN 1 END)
      comment: "Number of successfully authorized payments"
    - name: "authorization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN payment_status = 'authorized' OR payment_status = 'captured' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Payment authorization success rate - critical payment performance KPI"
    - name: "failed_payments"
      expr: COUNT(CASE WHEN payment_status = 'failed' THEN 1 END)
      comment: "Number of failed payment attempts"
    - name: "payment_failure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN payment_status = 'failed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Payment failure rate - indicates payment friction and lost revenue"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount processed"
    - name: "refund_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN CAST(refund_amount AS DOUBLE) > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions with refunds - quality and satisfaction indicator"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across transactions"
    - name: "high_fraud_risk_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN CAST(fraud_score AS DOUBLE) > 50 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of high fraud risk transactions - security monitoring metric"
    - name: "three_ds_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN three_ds_status IS NOT NULL AND three_ds_status != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "3D Secure adoption rate - security compliance metric"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`ecommerce_abandoned_cart_recovery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cart recovery campaign performance metrics tracking recovery rates, revenue recapture, and channel effectiveness"
  source: "`retail_ecm`.`ecommerce`.`abandoned_cart_recovery`"
  dimensions:
    - name: "recovery_status"
      expr: recovery_status
      comment: "Status of recovery attempt (sent, opened, clicked, converted, expired)"
    - name: "recovery_channel"
      expr: recovery_channel
      comment: "Channel used for recovery (email, SMS, push notification)"
    - name: "incentive_type"
      expr: incentive_type
      comment: "Type of incentive offered (discount, free shipping, etc.)"
    - name: "is_incentive_redeemed"
      expr: is_incentive_redeemed
      comment: "Whether incentive was redeemed"
    - name: "device_type"
      expr: device_type
      comment: "Device type for recovery interaction"
    - name: "is_first_recovery_attempt"
      expr: is_first_recovery_attempt
      comment: "Whether this is the first recovery attempt for the cart"
    - name: "recovery_sent_date"
      expr: DATE(message_sent_timestamp)
      comment: "Date when recovery message was sent"
    - name: "recovery_sent_month"
      expr: DATE_TRUNC('MONTH', message_sent_timestamp)
      comment: "Month when recovery message was sent"
  measures:
    - name: "total_recovery_attempts"
      expr: COUNT(1)
      comment: "Total number of cart recovery attempts"
    - name: "total_abandoned_gmv"
      expr: SUM(CAST(abandoned_cart_gmv AS DOUBLE))
      comment: "Total GMV of abandoned carts targeted for recovery"
    - name: "total_recovered_gmv"
      expr: SUM(CAST(recovered_gmv AS DOUBLE))
      comment: "Total GMV recovered from abandoned carts"
    - name: "recovery_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN CAST(recovered_gmv AS DOUBLE) > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Cart recovery success rate - primary recovery campaign KPI"
    - name: "gmv_recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(recovered_gmv AS DOUBLE)) / NULLIF(SUM(CAST(abandoned_cart_gmv AS DOUBLE)), 0), 2)
      comment: "Percentage of abandoned GMV recovered - revenue recapture metric"
    - name: "avg_recovered_order_value"
      expr: AVG(CAST(recovered_gmv AS DOUBLE))
      comment: "Average value of recovered orders"
    - name: "message_open_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN message_opened_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Recovery message open rate - campaign engagement metric"
    - name: "message_click_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN message_clicked_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Recovery message click-through rate"
    - name: "click_to_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN conversion_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN message_clicked_timestamp IS NOT NULL THEN 1 END), 0), 2)
      comment: "Conversion rate from click to purchase - funnel effectiveness"
    - name: "incentive_redemption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_incentive_redeemed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Incentive redemption rate - promotion effectiveness metric"
    - name: "total_incentive_cost"
      expr: SUM(CAST(incentive_value AS DOUBLE))
      comment: "Total cost of incentives offered"
    - name: "avg_time_to_conversion_minutes"
      expr: AVG(CAST(time_to_conversion_minutes AS DOUBLE))
      comment: "Average time from recovery message to conversion"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`ecommerce_web_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Web session engagement and conversion metrics tracking visitor behavior, funnel progression, and channel performance"
  source: "`retail_ecm`.`ecommerce`.`web_session`"
  dimensions:
    - name: "session_status"
      expr: session_status
      comment: "Session status (active, completed, abandoned)"
    - name: "device_type"
      expr: device_type
      comment: "Device type used during session"
    - name: "visitor_type"
      expr: visitor_type
      comment: "Visitor type (new, returning, loyal)"
    - name: "referral_source"
      expr: referral_source
      comment: "Traffic source (organic, paid, direct, referral)"
    - name: "utm_source"
      expr: utm_source
      comment: "UTM source for campaign attribution"
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "UTM campaign for marketing attribution"
    - name: "utm_medium"
      expr: utm_medium
      comment: "UTM medium for channel attribution"
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Geographic country of visitor"
    - name: "is_bot"
      expr: is_bot
      comment: "Bot traffic flag for filtering"
    - name: "is_bounce"
      expr: is_bounce
      comment: "Bounce session flag"
    - name: "session_start_date"
      expr: DATE(session_start_timestamp)
      comment: "Date when session started"
    - name: "session_start_month"
      expr: DATE_TRUNC('MONTH', session_start_timestamp)
      comment: "Month when session started"
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of web sessions"
    - name: "sessions_with_cart"
      expr: COUNT(CASE WHEN is_cart_created = TRUE THEN 1 END)
      comment: "Number of sessions where cart was created"
    - name: "cart_creation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cart_created = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions creating a cart - top-of-funnel conversion"
    - name: "sessions_with_checkout"
      expr: COUNT(CASE WHEN is_checkout_initiated = TRUE THEN 1 END)
      comment: "Number of sessions initiating checkout"
    - name: "checkout_initiation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_checkout_initiated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions reaching checkout - mid-funnel conversion"
    - name: "sessions_with_order"
      expr: COUNT(CASE WHEN is_order_placed = TRUE THEN 1 END)
      comment: "Number of sessions resulting in order"
    - name: "session_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_order_placed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Session to order conversion rate - primary ecommerce KPI"
    - name: "bounce_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_bounce = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Session bounce rate - engagement quality metric"
    - name: "avg_session_duration_seconds"
      expr: AVG(CAST(session_duration_seconds AS DOUBLE))
      comment: "Average session duration - engagement depth indicator"
    - name: "avg_page_views_per_session"
      expr: AVG(CAST(page_view_count AS DOUBLE))
      comment: "Average page views per session - engagement metric"
    - name: "avg_searches_per_session"
      expr: AVG(CAST(search_query_count AS DOUBLE))
      comment: "Average searches per session - intent indicator"
    - name: "new_visitor_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN visitor_type = 'new' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of new visitors - acquisition vs retention balance"
    - name: "bot_traffic_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_bot = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Bot traffic percentage - data quality metric"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`ecommerce_product_page_view`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product page engagement and conversion metrics tracking view-to-cart conversion, merchandising effectiveness, and product performance"
  source: "`retail_ecm`.`ecommerce`.`product_page_view`"
  dimensions:
    - name: "device_type"
      expr: device_type
      comment: "Device type used for product viewing"
    - name: "visitor_type"
      expr: visitor_type
      comment: "Visitor type (new, returning)"
    - name: "brand_name"
      expr: brand_name
      comment: "Product brand for brand performance analysis"
    - name: "category_path"
      expr: category_path
      comment: "Product category hierarchy"
    - name: "inventory_status"
      expr: inventory_status
      comment: "Inventory availability status"
    - name: "is_markdown_price"
      expr: is_markdown_price
      comment: "Whether product is on markdown"
    - name: "referral_source"
      expr: referral_source
      comment: "Traffic source to product page"
    - name: "recommendation_algorithm"
      expr: recommendation_algorithm
      comment: "Recommendation algorithm that served the product"
    - name: "is_recommendation_served"
      expr: is_recommendation_served
      comment: "Whether product was shown via recommendation"
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment method displayed"
    - name: "view_date"
      expr: DATE(event_timestamp)
      comment: "Date of product page view"
    - name: "view_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of product page view"
  measures:
    - name: "total_product_views"
      expr: COUNT(1)
      comment: "Total number of product page views"
    - name: "unique_products_viewed"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique products viewed"
    - name: "add_to_cart_events"
      expr: COUNT(CASE WHEN is_add_to_cart = TRUE THEN 1 END)
      comment: "Number of add-to-cart actions from product pages"
    - name: "view_to_cart_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_add_to_cart = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Product page to cart conversion rate - key merchandising KPI"
    - name: "wishlist_add_events"
      expr: COUNT(CASE WHEN is_wishlist_add = TRUE THEN 1 END)
      comment: "Number of wishlist additions"
    - name: "wishlist_add_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_wishlist_add = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Wishlist addition rate - purchase intent indicator"
    - name: "avg_time_on_page_seconds"
      expr: AVG(CAST(time_on_page_seconds AS DOUBLE))
      comment: "Average time spent on product pages - engagement metric"
    - name: "avg_displayed_price"
      expr: AVG(CAST(displayed_price AS DOUBLE))
      comment: "Average product price displayed"
    - name: "recommendation_click_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_recommendation_clicked = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_recommendation_served = TRUE THEN 1 END), 0), 2)
      comment: "Recommendation click-through rate - personalization effectiveness"
    - name: "out_of_stock_view_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN inventory_status = 'out_of_stock' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of views on out-of-stock products - lost opportunity metric"
    - name: "markdown_view_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_markdown_price = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of views on markdown products - clearance effectiveness"
    - name: "bot_view_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_bot = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Bot traffic rate - data quality filter"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`ecommerce_search_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Search performance and merchandising metrics tracking search effectiveness, zero-result rates, and search-to-purchase conversion"
  source: "`retail_ecm`.`ecommerce`.`search_query`"
  dimensions:
    - name: "query_status"
      expr: query_status
      comment: "Search query status (success, zero results, error)"
    - name: "query_type"
      expr: query_type
      comment: "Type of search query (keyword, category, filter)"
    - name: "query_source"
      expr: query_source
      comment: "Source of search query (search bar, autocomplete, etc.)"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for search"
    - name: "is_zero_results"
      expr: is_zero_results
      comment: "Whether search returned zero results"
    - name: "is_spell_corrected"
      expr: is_spell_corrected
      comment: "Whether search query was spell-corrected"
    - name: "is_synonym_expanded"
      expr: is_synonym_expanded
      comment: "Whether synonyms were applied"
    - name: "is_redirected"
      expr: is_redirected
      comment: "Whether search was redirected to specific page"
    - name: "query_language_code"
      expr: query_language_code
      comment: "Language of search query"
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Geographic country of searcher"
    - name: "search_date"
      expr: DATE(query_timestamp)
      comment: "Date of search query"
    - name: "search_month"
      expr: DATE_TRUNC('MONTH', query_timestamp)
      comment: "Month of search query"
  measures:
    - name: "total_searches"
      expr: COUNT(1)
      comment: "Total number of search queries"
    - name: "unique_searchers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique users performing searches"
    - name: "searches_with_click"
      expr: COUNT(CASE WHEN is_click_through = TRUE THEN 1 END)
      comment: "Number of searches resulting in click"
    - name: "search_click_through_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_click_through = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Search click-through rate - search relevance KPI"
    - name: "searches_with_add_to_cart"
      expr: COUNT(CASE WHEN is_add_to_cart = TRUE THEN 1 END)
      comment: "Number of searches resulting in add-to-cart"
    - name: "search_to_cart_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_add_to_cart = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Search to cart conversion rate - search effectiveness metric"
    - name: "searches_with_purchase"
      expr: COUNT(CASE WHEN is_purchase = TRUE THEN 1 END)
      comment: "Number of searches resulting in purchase"
    - name: "search_to_purchase_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_purchase = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Search to purchase conversion rate - primary search KPI"
    - name: "zero_result_searches"
      expr: COUNT(CASE WHEN is_zero_results = TRUE THEN 1 END)
      comment: "Number of searches with zero results"
    - name: "zero_result_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_zero_results = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Zero result rate - catalog coverage and search quality metric"
    - name: "avg_response_time_ms"
      expr: AVG(CAST(response_time_ms AS DOUBLE))
      comment: "Average search response time - performance metric"
    - name: "avg_result_count"
      expr: AVG(CAST(result_count AS DOUBLE))
      comment: "Average number of search results returned"
    - name: "spell_correction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_spell_corrected = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Spell correction application rate - search intelligence metric"
    - name: "bot_search_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_bot = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Bot search traffic rate - data quality filter"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`ecommerce_recommendation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product recommendation performance metrics tracking click-through, conversion, and algorithm effectiveness"
  source: "`retail_ecm`.`ecommerce`.`recommendation`"
  dimensions:
    - name: "algorithm"
      expr: algorithm
      comment: "Recommendation algorithm used"
    - name: "strategy"
      expr: strategy
      comment: "Recommendation strategy (collaborative filtering, content-based, etc.)"
    - name: "placement"
      expr: placement
      comment: "Placement location of recommendation (homepage, PDP, cart, etc.)"
    - name: "context"
      expr: context
      comment: "Context in which recommendation was served"
    - name: "recommendation_source"
      expr: recommendation_source
      comment: "Source system generating recommendation"
    - name: "device_type"
      expr: device_type
      comment: "Device type where recommendation was shown"
    - name: "visitor_type"
      expr: visitor_type
      comment: "Visitor type (new, returning)"
    - name: "personalization_segment"
      expr: personalization_segment
      comment: "Personalization segment of user"
    - name: "brand_name"
      expr: brand_name
      comment: "Brand of recommended product"
    - name: "inventory_status"
      expr: inventory_status
      comment: "Inventory status of recommended product"
    - name: "served_date"
      expr: DATE(served_timestamp)
      comment: "Date when recommendation was served"
    - name: "served_month"
      expr: DATE_TRUNC('MONTH', served_timestamp)
      comment: "Month when recommendation was served"
  measures:
    - name: "total_recommendations_served"
      expr: COUNT(1)
      comment: "Total number of recommendations served"
    - name: "unique_products_recommended"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique products recommended"
    - name: "recommendations_clicked"
      expr: COUNT(CASE WHEN is_clicked = TRUE THEN 1 END)
      comment: "Number of recommendations clicked"
    - name: "recommendation_click_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_clicked = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Recommendation click-through rate - engagement metric"
    - name: "recommendations_added_to_cart"
      expr: COUNT(CASE WHEN is_added_to_cart = TRUE THEN 1 END)
      comment: "Number of recommendations added to cart"
    - name: "recommendation_to_cart_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_added_to_cart = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Recommendation to cart conversion rate - mid-funnel effectiveness"
    - name: "recommendations_purchased"
      expr: COUNT(CASE WHEN is_purchased = TRUE THEN 1 END)
      comment: "Number of recommendations resulting in purchase"
    - name: "recommendation_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_purchased = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Recommendation to purchase conversion rate - primary recommendation KPI"
    - name: "avg_recommendation_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average recommendation confidence score"
    - name: "avg_displayed_price"
      expr: AVG(CAST(displayed_price AS DOUBLE))
      comment: "Average price of recommended products"
    - name: "avg_time_to_click_seconds"
      expr: AVG(CAST(time_to_click_seconds AS DOUBLE))
      comment: "Average time from serve to click - engagement speed"
    - name: "avg_time_to_purchase_seconds"
      expr: AVG(CAST(time_to_purchase_seconds AS DOUBLE))
      comment: "Average time from serve to purchase - conversion velocity"
    - name: "click_to_purchase_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_purchased = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_clicked = TRUE THEN 1 END), 0), 2)
      comment: "Conversion rate from click to purchase - post-click effectiveness"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`ecommerce_product_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product review and rating metrics tracking review volume, sentiment, verification, and moderation effectiveness"
  source: "`retail_ecm`.`ecommerce`.`product_review`"
  dimensions:
    - name: "moderation_status"
      expr: moderation_status
      comment: "Review moderation status (pending, approved, rejected)"
    - name: "is_verified_purchase"
      expr: is_verified_purchase
      comment: "Whether review is from verified purchase"
    - name: "is_incentivized"
      expr: is_incentivized
      comment: "Whether review was incentivized"
    - name: "incentive_type"
      expr: incentive_type
      comment: "Type of incentive offered for review"
    - name: "sentiment_label"
      expr: sentiment_label
      comment: "Sentiment classification (positive, neutral, negative)"
    - name: "review_language_code"
      expr: review_language_code
      comment: "Language of review"
    - name: "has_media"
      expr: has_media
      comment: "Whether review includes photos/videos"
    - name: "syndication_source"
      expr: syndication_source
      comment: "Source of syndicated review"
    - name: "reviewer_expertise_level"
      expr: reviewer_expertise_level
      comment: "Reviewer expertise level"
    - name: "submission_date"
      expr: DATE(submission_timestamp)
      comment: "Date when review was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month when review was submitted"
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of product reviews submitted"
    - name: "unique_products_reviewed"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique products with reviews"
    - name: "unique_reviewers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers submitting reviews"
    - name: "verified_purchase_reviews"
      expr: COUNT(CASE WHEN is_verified_purchase = TRUE THEN 1 END)
      comment: "Number of verified purchase reviews"
    - name: "verified_purchase_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_verified_purchase = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Verified purchase rate - review authenticity metric"
    - name: "avg_star_rating"
      expr: AVG(CASE WHEN star_rating = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Average star rating across reviews"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score - product satisfaction indicator"
    - name: "positive_sentiment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sentiment_label = 'positive' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of positive reviews - customer satisfaction KPI"
    - name: "reviews_with_media"
      expr: COUNT(CASE WHEN has_media = TRUE THEN 1 END)
      comment: "Number of reviews with photos/videos"
    - name: "media_attachment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN has_media = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Review media attachment rate - engagement quality metric"
    - name: "avg_helpful_votes"
      expr: AVG(CAST(helpful_vote_count AS DOUBLE))
      comment: "Average helpful votes per review - review quality indicator"
    - name: "moderation_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN moderation_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Review approval rate - content quality metric"
    - name: "incentivized_review_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_incentivized = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Incentivized review rate - review program effectiveness"
    - name: "abuse_report_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN CAST(abuse_report_count AS DOUBLE) > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Review abuse report rate - content moderation metric"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`ecommerce_ab_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "A/B test performance metrics tracking test effectiveness, conversion lift, and statistical significance"
  source: "`retail_ecm`.`ecommerce`.`ab_test`"
  dimensions:
    - name: "test_status"
      expr: test_status
      comment: "A/B test status (running, completed, paused)"
    - name: "test_type"
      expr: test_type
      comment: "Type of A/B test (pricing, layout, copy, etc.)"
    - name: "assigned_variant"
      expr: assigned_variant
      comment: "Variant assigned to visitor (control, variant A, variant B, etc.)"
    - name: "winning_variant"
      expr: winning_variant
      comment: "Winning variant of completed test"
    - name: "is_converted"
      expr: is_converted
      comment: "Whether visitor converted"
    - name: "is_multivariate"
      expr: is_multivariate
      comment: "Whether test is multivariate"
    - name: "is_personalized"
      expr: is_personalized
      comment: "Whether test uses personalization"
    - name: "device_targeting"
      expr: device_targeting
      comment: "Device targeting for test"
    - name: "target_audience_segment"
      expr: target_audience_segment
      comment: "Audience segment targeted by test"
    - name: "page_type_target"
      expr: page_type_target
      comment: "Page type where test is running"
    - name: "test_start_date"
      expr: start_date
      comment: "Date when test started"
    - name: "test_start_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month when test started"
  measures:
    - name: "total_test_participants"
      expr: COUNT(1)
      comment: "Total number of test participants"
    - name: "unique_tests"
      expr: COUNT(DISTINCT test_code)
      comment: "Number of unique A/B tests"
    - name: "conversions"
      expr: COUNT(CASE WHEN is_converted = TRUE THEN 1 END)
      comment: "Number of conversions in test"
    - name: "conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_converted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Overall test conversion rate"
    - name: "total_conversion_value"
      expr: SUM(CAST(conversion_value AS DOUBLE))
      comment: "Total conversion value from test"
    - name: "avg_conversion_value"
      expr: AVG(CAST(conversion_value AS DOUBLE))
      comment: "Average conversion value per participant"
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level AS DOUBLE))
      comment: "Average statistical confidence level of tests"
    - name: "avg_significance_threshold"
      expr: AVG(CAST(significance_threshold AS DOUBLE))
      comment: "Average significance threshold set for tests"
    - name: "avg_minimum_detectable_effect"
      expr: AVG(CAST(minimum_detectable_effect AS DOUBLE))
      comment: "Average minimum detectable effect size"
    - name: "tests_with_winner"
      expr: COUNT(CASE WHEN winning_variant IS NOT NULL AND winning_variant != '' THEN 1 END)
      comment: "Number of tests with declared winner"
    - name: "test_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN test_status = 'completed' THEN 1 END) / NULLIF(COUNT(DISTINCT test_code), 0), 2)
      comment: "Percentage of tests completed - experimentation velocity metric"
    - name: "personalized_test_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_personalized = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of personalized tests - advanced testing adoption"
    - name: "avg_traffic_allocation_pct"
      expr: AVG(CAST(total_traffic_allocation_pct AS DOUBLE))
      comment: "Average traffic allocation percentage across tests"
$$;