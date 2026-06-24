-- Metric views for domain: ecommerce | Business: Retail | Version: 2 | Generated on: 2026-06-23 23:42:36

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_web_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Session-level engagement and conversion metrics for the ecommerce storefront. Drives decisions on traffic quality, bounce reduction, and checkout funnel optimization."
  source: "`vibe_retail_v1`.`ecommerce`.`web_session`"
  dimensions:
    - name: "device_type"
      expr: device_type
      comment: "Device category (desktop, mobile, tablet) used to segment session behavior and optimize device-specific experiences."
    - name: "visitor_type"
      expr: visitor_type
      comment: "New vs returning visitor classification to measure loyalty and acquisition effectiveness."
    - name: "referral_source"
      expr: referral_source
      comment: "Traffic origin (organic, paid, email, social) for channel attribution and marketing ROI analysis."
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "UTM campaign tag for paid and owned media attribution."
    - name: "utm_medium"
      expr: utm_medium
      comment: "UTM medium (cpc, email, social) for channel-level performance analysis."
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Country of the session for geographic performance segmentation."
    - name: "session_status"
      expr: session_status
      comment: "Current state of the session (active, expired, completed) for funnel health monitoring."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment preference selected during session (ship-to-home, BOPIS, etc.) for operational planning."
    - name: "session_date"
      expr: DATE_TRUNC('day', session_start_timestamp)
      comment: "Calendar day of session start for daily trend analysis."
    - name: "session_week"
      expr: DATE_TRUNC('week', session_start_timestamp)
      comment: "ISO week of session start for weekly trend analysis."
    - name: "session_month"
      expr: DATE_TRUNC('month', session_start_timestamp)
      comment: "Calendar month of session start for monthly trend analysis."
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of web sessions. Baseline traffic volume metric used to assess site reach and campaign-driven traffic spikes."
    - name: "unique_visitors"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct authenticated visitors. Measures unique customer reach, excluding bots and guest sessions without profiles."
    - name: "bounce_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_bounce = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions that ended without meaningful engagement. High bounce rate signals landing page or targeting issues requiring immediate action."
    - name: "cart_creation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_cart_created = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions that resulted in a cart being created. Key top-of-funnel conversion indicator."
    - name: "checkout_initiation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_checkout_initiated = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions that initiated checkout. Measures mid-funnel conversion health."
    - name: "session_order_conversion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_order_placed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions that resulted in a placed order. Primary ecommerce conversion KPI used in executive dashboards and steering meetings."
    - name: "bot_session_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_bot = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions identified as bot traffic. Elevated bot rate inflates traffic metrics and distorts conversion analysis; triggers infrastructure and security review."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_cart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cart-level metrics covering abandonment, discount usage, and cart value. Central to understanding checkout funnel leakage and promotional effectiveness."
  source: "`vibe_retail_v1`.`ecommerce`.`cart`"
  dimensions:
    - name: "cart_status"
      expr: cart_status
      comment: "Current state of the cart (active, abandoned, converted, expired) for funnel stage analysis."
    - name: "channel"
      expr: channel
      comment: "Sales channel (web, mobile app, in-store kiosk) for cross-channel cart behavior comparison."
    - name: "device_type"
      expr: device_type
      comment: "Device used to create the cart for device-specific abandonment analysis."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment method selected (ship-to-home, BOPIS, etc.) for operational demand planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency revenue normalization."
    - name: "is_guest_cart"
      expr: is_guest_cart
      comment: "Whether the cart belongs to a guest (unauthenticated) user. Guest vs authenticated cart behavior differs significantly in conversion rates."
    - name: "cart_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Day the cart was created for daily trend analysis."
    - name: "cart_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the cart was created for monthly trend analysis."
  measures:
    - name: "total_carts"
      expr: COUNT(1)
      comment: "Total number of carts created. Baseline demand signal for the checkout funnel."
    - name: "abandoned_carts"
      expr: SUM(CASE WHEN is_abandoned = TRUE THEN 1 ELSE 0 END)
      comment: "Number of carts that were abandoned without conversion. Directly quantifies revenue at risk from checkout funnel leakage."
    - name: "cart_abandonment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_abandoned = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carts abandoned. A primary ecommerce health KPI; increases trigger UX, pricing, and checkout flow investigations."
    - name: "total_cart_subtotal"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of all cart subtotals. Represents gross merchandise value at the cart stage, including abandoned carts."
    - name: "avg_cart_value"
      expr: AVG(CAST(subtotal_amount AS DOUBLE))
      comment: "Average cart subtotal value. Tracks basket size trends and informs upsell and cross-sell strategy."
    - name: "total_cart_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied across all carts. Measures promotional cost at the cart stage."
    - name: "avg_cart_discount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per cart. Elevated averages may indicate over-reliance on promotions to drive cart creation."
    - name: "total_estimated_shipping"
      expr: SUM(CAST(estimated_shipping_amount AS DOUBLE))
      comment: "Total estimated shipping charges across all carts. Informs free-shipping threshold calibration and logistics cost forecasting."
    - name: "total_cart_tax"
      expr: SUM(CAST(estimated_tax_amount AS DOUBLE))
      comment: "Total estimated tax across all carts. Used for tax liability forecasting and compliance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_cart_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-item level cart metrics for product-level demand signals, discount analysis, and fulfillment type mix. Drives merchandising and pricing decisions."
  source: "`vibe_retail_v1`.`ecommerce`.`cart_item`"
  dimensions:
    - name: "item_status"
      expr: item_status
      comment: "Status of the cart line item (active, removed, purchased, saved-for-later) for funnel stage analysis."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment method for the line item (ship-to-home, BOPIS, etc.) for operational demand planning."
    - name: "device_type"
      expr: device_type
      comment: "Device used when the item was added to cart for device-specific behavior analysis."
    - name: "product_department"
      expr: product_department
      comment: "Merchandise department of the item for category-level demand analysis."
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of promotion applied to the line item for promotional effectiveness analysis."
    - name: "is_gift"
      expr: is_gift
      comment: "Whether the item is marked as a gift. Gift items have different fulfillment and packaging requirements."
    - name: "is_private_label"
      expr: is_private_label
      comment: "Whether the item is a private-label product. Private label mix is a key margin driver."
    - name: "is_in_stock"
      expr: is_in_stock
      comment: "Whether the item was in stock when added to cart. Out-of-stock items in carts signal lost revenue opportunities."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency revenue normalization."
    - name: "add_date"
      expr: DATE_TRUNC('day', add_to_cart_timestamp)
      comment: "Day the item was added to cart for daily demand trend analysis."
    - name: "add_month"
      expr: DATE_TRUNC('month', add_to_cart_timestamp)
      comment: "Month the item was added to cart for monthly demand trend analysis."
  measures:
    - name: "total_cart_lines"
      expr: COUNT(1)
      comment: "Total number of cart line items. Baseline demand signal at the SKU level."
    - name: "total_line_subtotal"
      expr: SUM(CAST(line_subtotal AS DOUBLE))
      comment: "Sum of all cart line subtotals. Represents gross merchandise value at the item level, including abandoned items."
    - name: "avg_line_subtotal"
      expr: AVG(CAST(line_subtotal AS DOUBLE))
      comment: "Average line item value. Tracks per-item basket contribution and informs pricing strategy."
    - name: "total_item_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount applied at the line item level. Measures promotional cost at the SKU level."
    - name: "total_item_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged at the line item level. Used for tax liability reporting."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average effective tax rate across cart line items. Monitors tax jurisdiction mix and compliance."
    - name: "out_of_stock_line_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_in_stock = FALSE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cart lines where the item was out of stock. High rate signals inventory gaps causing lost sales."
    - name: "private_label_line_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_private_label = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cart lines that are private-label products. Private label penetration is a key margin and brand strategy KPI."
    - name: "gift_line_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_gift = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cart lines marked as gifts. Informs gift packaging capacity planning and seasonal demand forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_checkout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Checkout funnel metrics covering step completion rates, payment method mix, and order value. Critical for identifying friction points that reduce conversion."
  source: "`vibe_retail_v1`.`ecommerce`.`checkout`"
  dimensions:
    - name: "checkout_status"
      expr: checkout_status
      comment: "Current state of the checkout (initiated, completed, abandoned) for funnel stage analysis."
    - name: "channel"
      expr: channel
      comment: "Sales channel for cross-channel checkout performance comparison."
    - name: "device_type"
      expr: device_type
      comment: "Device used during checkout for device-specific friction analysis."
    - name: "fulfillment_mode"
      expr: fulfillment_mode
      comment: "Fulfillment method selected at checkout for operational demand planning."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used at checkout for payment mix analysis and fraud risk segmentation."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment authorization outcome for payment success rate monitoring."
    - name: "is_guest_checkout"
      expr: is_guest_checkout
      comment: "Whether the checkout was completed as a guest. Guest checkout rates affect loyalty program enrollment and customer data capture."
    - name: "is_gift_order"
      expr: is_gift_order
      comment: "Whether the order is a gift for seasonal demand and packaging planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency revenue normalization."
    - name: "checkout_date"
      expr: DATE_TRUNC('day', initiated_timestamp)
      comment: "Day checkout was initiated for daily trend analysis."
    - name: "checkout_month"
      expr: DATE_TRUNC('month', initiated_timestamp)
      comment: "Month checkout was initiated for monthly trend analysis."
  measures:
    - name: "total_checkouts"
      expr: COUNT(1)
      comment: "Total number of checkout sessions initiated. Baseline mid-funnel volume metric."
    - name: "completed_checkouts"
      expr: SUM(CASE WHEN checkout_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Number of checkouts that resulted in a placed order. Primary checkout funnel success metric."
    - name: "checkout_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN checkout_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of initiated checkouts that completed successfully. A primary ecommerce conversion KPI; declines trigger UX and payment flow investigations."
    - name: "total_order_value"
      expr: SUM(CAST(order_total_amount AS DOUBLE))
      comment: "Sum of all completed checkout order totals. Represents gross revenue at the checkout stage."
    - name: "avg_order_value"
      expr: AVG(CAST(order_total_amount AS DOUBLE))
      comment: "Average order value at checkout. Key revenue-per-transaction metric used in executive dashboards and pricing strategy."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total promotional discount applied at checkout. Measures promotional cost and margin impact."
    - name: "total_shipping_revenue"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping charges collected at checkout. Informs shipping strategy and free-shipping threshold decisions."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at checkout. Used for tax remittance and compliance reporting."
    - name: "total_gift_card_redemption"
      expr: SUM(CAST(gift_card_amount AS DOUBLE))
      comment: "Total gift card value redeemed at checkout. Tracks gift card liability drawdown and promotional effectiveness."
    - name: "total_store_credit_redemption"
      expr: SUM(CAST(store_credit_amount AS DOUBLE))
      comment: "Total store credit redeemed at checkout. Monitors store credit liability and customer retention program effectiveness."
    - name: "payment_step_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_payment_entry_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checkouts where payment entry was completed. Drop-off at this step signals payment UX or gateway issues."
    - name: "shipping_step_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_shipping_selection_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checkouts where shipping selection was completed. Drop-off here signals shipping option or cost friction."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_digital_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital payment transaction metrics covering authorization rates, fraud, refunds, and payment method mix. Drives payment operations, fraud management, and finance reconciliation."
  source: "`vibe_retail_v1`.`ecommerce`.`digital_payment`"
  dimensions:
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Abstract payment method category (credit_card, debit_card, wallet, gift_card, bnpl) for payment mix analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Transaction outcome (authorized, captured, declined, refunded) for payment health monitoring."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was processed for cross-channel payment analysis."
    - name: "payment_gateway"
      expr: payment_gateway
      comment: "Payment gateway used for gateway performance and cost comparison."
    - name: "card_network"
      expr: card_network
      comment: "Card network (Visa, Mastercard, Amex) for interchange cost analysis."
    - name: "wallet_provider"
      expr: wallet_provider
      comment: "Digital wallet provider for wallet adoption trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency revenue normalization."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Whether the payment is part of a recurring subscription for subscription revenue tracking."
    - name: "three_ds_status"
      expr: three_ds_status
      comment: "3D Secure authentication outcome for fraud prevention effectiveness analysis."
    - name: "payment_date"
      expr: DATE_TRUNC('day', initiated_timestamp)
      comment: "Day payment was initiated for daily transaction volume trend analysis."
    - name: "payment_month"
      expr: DATE_TRUNC('month', initiated_timestamp)
      comment: "Month payment was initiated for monthly revenue reconciliation."
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of payment transactions. Baseline payment volume metric for capacity and gateway planning."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount processed. Primary revenue collection metric used in finance reconciliation and executive reporting."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment transaction value. Tracks per-transaction revenue and informs fraud threshold calibration."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after refunds and adjustments. Represents actual revenue collected."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total amount refunded to customers. High refund volumes signal product quality, fulfillment, or fraud issues requiring investigation."
    - name: "refund_rate"
      expr: ROUND(100.0 * SUM(CAST(refund_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Refund amount as a percentage of gross payment amount. A key payment health and customer satisfaction KPI."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across transactions. Rising averages trigger fraud rule tightening and gateway configuration reviews."
    - name: "total_tax_on_payments"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component of digital payments. Used for tax liability reporting and compliance."
    - name: "authorization_success_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN payment_status = 'authorized' OR payment_status = 'captured' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payment attempts that were successfully authorized. Declines indicate gateway issues or fraud rule over-triggering, directly impacting revenue."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_product_page_view`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product discovery and engagement metrics at the page-view level. Drives merchandising, SEO, personalization, and inventory decisions."
  source: "`vibe_retail_v1`.`ecommerce`.`product_page_view`"
  dimensions:
    - name: "device_type"
      expr: device_type
      comment: "Device used for the page view for device-specific optimization."
    - name: "visitor_type"
      expr: visitor_type
      comment: "New vs returning visitor for audience quality analysis."
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Country of the visitor for geographic demand analysis."
    - name: "referral_source"
      expr: referral_source
      comment: "Traffic source driving product page views for channel attribution."
    - name: "inventory_status"
      expr: inventory_status
      comment: "Stock status at time of page view (in-stock, out-of-stock, low-stock) for lost-sales analysis."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment option displayed on the product page for demand planning."
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of interaction on the page (view, zoom, video-play) for engagement depth analysis."
    - name: "is_recommendation_served"
      expr: is_recommendation_served
      comment: "Whether a recommendation was served on the page for personalization effectiveness analysis."
    - name: "is_markdown_price"
      expr: is_markdown_price
      comment: "Whether the displayed price was a markdown for promotional demand analysis."
    - name: "view_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Day of the page view for daily traffic trend analysis."
    - name: "view_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the page view for monthly trend analysis."
  measures:
    - name: "total_page_views"
      expr: COUNT(1)
      comment: "Total product page views. Baseline demand signal for product discovery and SEO performance."
    - name: "unique_product_viewers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct authenticated customers who viewed product pages. Measures product reach among known customers."
    - name: "add_to_cart_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_add_to_cart = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of product page views that resulted in an add-to-cart action. Key product-level conversion metric; low rates trigger content, pricing, or availability reviews."
    - name: "wishlist_add_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_wishlist_add = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of product page views that resulted in a wishlist add. Indicates purchase intent and informs demand forecasting."
    - name: "recommendation_click_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_recommendation_clicked = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN is_recommendation_served = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of recommendation impressions that were clicked. Measures personalization engine effectiveness and drives algorithm tuning decisions."
    - name: "out_of_stock_view_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN inventory_status = 'out_of_stock' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of product page views where the item was out of stock. High rate quantifies lost revenue opportunity and triggers inventory replenishment escalation."
    - name: "avg_displayed_price"
      expr: AVG(CAST(displayed_price AS DOUBLE))
      comment: "Average price displayed on product pages. Tracks effective price point trends and informs pricing strategy."
    - name: "bot_view_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_bot = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of page views identified as bot traffic. Inflated bot traffic distorts demand signals and SEO metrics."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_search_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site search performance metrics covering zero-result rates, click-through, and purchase conversion. Drives search relevance tuning, catalog gap identification, and demand forecasting."
  source: "`vibe_retail_v1`.`ecommerce`.`search_query`"
  dimensions:
    - name: "device_type"
      expr: device_type
      comment: "Device used for the search for device-specific search behavior analysis."
    - name: "query_type"
      expr: query_type
      comment: "Type of search query (keyword, category, brand, barcode) for search intent analysis."
    - name: "query_source"
      expr: query_source
      comment: "Where the search was initiated (search bar, voice, navigation) for UX optimization."
    - name: "query_language_code"
      expr: query_language_code
      comment: "Language of the search query for localization and internationalization planning."
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Country of the searcher for geographic demand analysis."
    - name: "is_zero_results"
      expr: is_zero_results
      comment: "Whether the search returned no results. Zero-result queries directly indicate catalog gaps."
    - name: "is_spell_corrected"
      expr: is_spell_corrected
      comment: "Whether the query was spell-corrected by the search engine for search quality analysis."
    - name: "is_synonym_expanded"
      expr: is_synonym_expanded
      comment: "Whether synonym expansion was applied for search relevance analysis."
    - name: "query_date"
      expr: DATE_TRUNC('day', query_timestamp)
      comment: "Day the search was performed for daily search volume trend analysis."
    - name: "query_month"
      expr: DATE_TRUNC('month', query_timestamp)
      comment: "Month the search was performed for monthly trend analysis."
  measures:
    - name: "total_searches"
      expr: COUNT(1)
      comment: "Total number of search queries. Baseline search volume metric for capacity and relevance planning."
    - name: "zero_result_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_zero_results = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of searches returning no results. A critical catalog gap indicator; high rates directly cause lost sales and require immediate merchandising action."
    - name: "search_click_through_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_click_through = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of searches where the customer clicked a result. Measures search relevance quality; low CTR triggers algorithm and ranking reviews."
    - name: "search_add_to_cart_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_add_to_cart = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of searches that led to an add-to-cart action. Measures search-to-demand conversion and informs search merchandising strategy."
    - name: "search_purchase_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_purchase = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of searches that resulted in a purchase. Highest-value search conversion metric used in executive reporting."
    - name: "redirect_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_redirected = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of searches that triggered a redirect rule. High redirect rates may indicate over-reliance on manual merchandising rules."
    - name: "bot_search_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_bot = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of searches identified as bot traffic. Bot searches inflate query volumes and distort demand signals."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_product_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product review quality and moderation metrics. Drives product quality decisions, content moderation efficiency, and customer trust management."
  source: "`vibe_retail_v1`.`ecommerce`.`product_review`"
  dimensions:
    - name: "moderation_status"
      expr: moderation_status
      comment: "Review moderation outcome (approved, rejected, pending) for content quality monitoring."
    - name: "sentiment_label"
      expr: sentiment_label
      comment: "NLP-derived sentiment classification (positive, neutral, negative) for product quality signaling."
    - name: "purchase_channel"
      expr: purchase_channel
      comment: "Channel through which the reviewed product was purchased for cross-channel quality analysis."
    - name: "review_language_code"
      expr: review_language_code
      comment: "Language of the review for localization and moderation capacity planning."
    - name: "is_verified_purchase"
      expr: is_verified_purchase
      comment: "Whether the reviewer made a verified purchase. Verified reviews carry higher trust weight in product quality decisions."
    - name: "is_incentivized"
      expr: is_incentivized
      comment: "Whether the review was incentivized. Incentivized review rates affect regulatory compliance and trust."
    - name: "syndication_source"
      expr: syndication_source
      comment: "Source of syndicated reviews for content partnership management."
    - name: "review_date"
      expr: DATE_TRUNC('day', submission_timestamp)
      comment: "Day the review was submitted for daily review volume trend analysis."
    - name: "review_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month the review was submitted for monthly trend analysis."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of reviews submitted. Baseline review volume metric for content strategy and moderation capacity planning."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average NLP sentiment score across reviews. Tracks product and brand perception trends; significant declines trigger product quality investigations."
    - name: "verified_purchase_review_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_verified_purchase = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews from verified purchasers. Higher rates indicate more trustworthy review content and better SEO signals."
    - name: "moderation_rejection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN moderation_status = 'rejected' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews rejected by moderation. High rejection rates signal content quality issues or abuse patterns requiring policy review."
    - name: "incentivized_review_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_incentivized = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews that were incentivized. Regulatory bodies scrutinize incentivized review rates; exceeding thresholds triggers compliance risk."
    - name: "reviews_with_media_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN has_media = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews that include media (photos/videos). Media-rich reviews drive higher conversion rates and are a content quality KPI."
    - name: "negative_sentiment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sentiment_label = 'negative' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews with negative sentiment. Rising negative sentiment rates are an early warning signal for product quality or fulfillment issues."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_abandoned_cart_recovery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Abandoned cart recovery campaign metrics covering recovery rates, incentive effectiveness, and recovered revenue. Drives CRM and retention investment decisions."
  source: "`vibe_retail_v1`.`ecommerce`.`abandoned_cart_recovery`"
  dimensions:
    - name: "recovery_status"
      expr: recovery_status
      comment: "Outcome of the recovery attempt (recovered, expired, opted-out, pending) for campaign effectiveness analysis."
    - name: "recovery_channel"
      expr: recovery_channel
      comment: "Channel used for recovery outreach (email, SMS, push) for channel effectiveness comparison."
    - name: "incentive_type"
      expr: incentive_type
      comment: "Type of incentive offered (discount, free-shipping, loyalty-points) for incentive ROI analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type of the abandoned cart for device-specific recovery strategy."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency revenue normalization."
    - name: "is_first_recovery_attempt"
      expr: is_first_recovery_attempt
      comment: "Whether this is the first recovery attempt for sequence effectiveness analysis."
    - name: "is_incentive_redeemed"
      expr: is_incentive_redeemed
      comment: "Whether the recovery incentive was redeemed for incentive cost tracking."
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "UTM campaign tag for marketing attribution of recovery campaigns."
    - name: "recovery_date"
      expr: DATE_TRUNC('day', message_sent_timestamp)
      comment: "Day the recovery message was sent for daily campaign performance analysis."
    - name: "recovery_month"
      expr: DATE_TRUNC('month', message_sent_timestamp)
      comment: "Month the recovery message was sent for monthly campaign performance analysis."
  measures:
    - name: "total_recovery_attempts"
      expr: COUNT(1)
      comment: "Total number of abandoned cart recovery attempts. Baseline volume metric for recovery program scale."
    - name: "total_abandoned_gmv"
      expr: SUM(CAST(abandoned_cart_gmv AS DOUBLE))
      comment: "Total gross merchandise value of abandoned carts targeted for recovery. Quantifies the revenue opportunity being pursued."
    - name: "total_recovered_gmv"
      expr: SUM(CAST(recovered_gmv AS DOUBLE))
      comment: "Total gross merchandise value successfully recovered. Primary recovery program revenue impact metric."
    - name: "recovery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN recovery_status = 'recovered' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recovery attempts that resulted in a completed order. Primary recovery campaign effectiveness KPI."
    - name: "gmv_recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(recovered_gmv AS DOUBLE)) / NULLIF(SUM(CAST(abandoned_cart_gmv AS DOUBLE)), 0), 2)
      comment: "Percentage of abandoned GMV that was successfully recovered. Measures the financial effectiveness of the recovery program."
    - name: "avg_incentive_value"
      expr: AVG(CAST(incentive_value AS DOUBLE))
      comment: "Average incentive value offered in recovery campaigns. Tracks promotional cost per recovery attempt."
    - name: "total_recovered_net_amount"
      expr: SUM(CAST(recovered_order_net_amount AS DOUBLE))
      comment: "Total net order amount from recovered carts after discounts. Represents actual net revenue contribution of the recovery program."
    - name: "total_recovery_discount_cost"
      expr: SUM(CAST(recovered_order_discount_amount AS DOUBLE))
      comment: "Total discount cost incurred to recover abandoned carts. Used to calculate net ROI of the recovery program."
    - name: "incentive_redemption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_incentive_redeemed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recovery attempts where the incentive was redeemed. High redemption with low recovery rate indicates incentive cost without conversion benefit."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_recommendation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Personalization and recommendation engine performance metrics. Drives algorithm selection, placement optimization, and revenue attribution for the recommendation program."
  source: "`vibe_retail_v1`.`ecommerce`.`recommendation`"
  dimensions:
    - name: "algorithm"
      expr: algorithm
      comment: "Recommendation algorithm used (collaborative filtering, content-based, hybrid) for algorithm performance comparison."
    - name: "strategy"
      expr: strategy
      comment: "Recommendation strategy (cross-sell, upsell, trending, recently-viewed) for strategy effectiveness analysis."
    - name: "placement"
      expr: placement
      comment: "Page placement of the recommendation (PDP, cart, homepage, email) for placement ROI analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type for device-specific recommendation performance analysis."
    - name: "visitor_type"
      expr: visitor_type
      comment: "New vs returning visitor for audience-specific recommendation effectiveness."
    - name: "inventory_status"
      expr: inventory_status
      comment: "Stock status of recommended items for availability quality monitoring."
    - name: "is_private_label"
      expr: is_private_label
      comment: "Whether the recommended item is private-label for margin mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency revenue normalization."
    - name: "recommendation_date"
      expr: DATE_TRUNC('day', served_timestamp)
      comment: "Day the recommendation was served for daily performance trend analysis."
    - name: "recommendation_month"
      expr: DATE_TRUNC('month', served_timestamp)
      comment: "Month the recommendation was served for monthly trend analysis."
  measures:
    - name: "total_recommendations_served"
      expr: COUNT(1)
      comment: "Total number of recommendations served. Baseline volume metric for recommendation engine scale."
    - name: "recommendation_click_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_clicked = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of served recommendations that were clicked. Primary recommendation relevance KPI; low CTR triggers algorithm and placement reviews."
    - name: "recommendation_add_to_cart_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_added_to_cart = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of served recommendations that resulted in an add-to-cart. Measures recommendation-to-demand conversion."
    - name: "recommendation_purchase_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_purchased = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of served recommendations that resulted in a purchase. Highest-value recommendation conversion metric used in executive reporting."
    - name: "total_attributed_revenue"
      expr: SUM(CAST(displayed_price AS DOUBLE))
      comment: "Sum of displayed prices for purchased recommendations as a proxy for attributed revenue. Measures the direct revenue contribution of the recommendation engine."
    - name: "avg_recommendation_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average model confidence score for served recommendations. Tracks recommendation quality and model drift over time."
    - name: "out_of_stock_recommendation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN inventory_status = 'out_of_stock' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recommendations served for out-of-stock items. High rate degrades customer experience and wastes recommendation impressions."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_ab_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "A/B test program metrics covering test velocity, statistical confidence, and conversion lift. Drives experimentation investment and product development prioritization."
  source: "`vibe_retail_v1`.`ecommerce`.`ab_test`"
  dimensions:
    - name: "test_status"
      expr: test_status
      comment: "Current state of the test (running, concluded, paused, draft) for test portfolio management."
    - name: "test_type"
      expr: test_type
      comment: "Type of experiment (A/B, multivariate, split-URL) for test methodology analysis."
    - name: "page_type_target"
      expr: page_type_target
      comment: "Page type being tested (PDP, homepage, checkout, search) for test coverage analysis."
    - name: "device_targeting"
      expr: device_targeting
      comment: "Device segment targeted by the test for device-specific experimentation analysis."
    - name: "primary_metric"
      expr: primary_metric
      comment: "Primary success metric of the test for test objective categorization."
    - name: "is_personalized"
      expr: is_personalized
      comment: "Whether the test involves personalization for personalization program analysis."
    - name: "is_multivariate"
      expr: is_multivariate
      comment: "Whether the test is multivariate for test complexity analysis."
    - name: "winning_variant"
      expr: winning_variant
      comment: "The winning variant of concluded tests for learning documentation."
    - name: "test_start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the test started for test velocity trend analysis."
  measures:
    - name: "total_tests"
      expr: COUNT(1)
      comment: "Total number of A/B tests. Measures experimentation program velocity; low counts indicate under-investment in data-driven optimization."
    - name: "active_tests"
      expr: SUM(CASE WHEN test_status = 'running' THEN 1 ELSE 0 END)
      comment: "Number of currently running tests. Tracks experimentation program scale and resource utilization."
    - name: "concluded_tests"
      expr: SUM(CASE WHEN test_status = 'concluded' THEN 1 ELSE 0 END)
      comment: "Number of concluded tests. Measures experimentation throughput and learning velocity."
    - name: "test_conversion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_converted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of test assignments that resulted in a conversion event. Measures overall test program impact on conversion."
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level AS DOUBLE))
      comment: "Average statistical confidence level across tests. Low averages indicate tests are being concluded prematurely without sufficient statistical power."
    - name: "total_conversion_value"
      expr: SUM(CAST(conversion_value AS DOUBLE))
      comment: "Total conversion value attributed to A/B test assignments. Quantifies the revenue impact of the experimentation program."
    - name: "avg_traffic_allocation"
      expr: AVG(CAST(total_traffic_allocation_pct AS DOUBLE))
      comment: "Average percentage of traffic allocated to tests. Low allocation limits test velocity; high allocation increases risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_promotion_banner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional banner performance metrics covering impressions, click-through rates, and attributed revenue. Drives creative investment, placement strategy, and campaign ROI decisions."
  source: "`vibe_retail_v1`.`ecommerce`.`promotion_banner`"
  dimensions:
    - name: "banner_status"
      expr: banner_status
      comment: "Current state of the banner (active, scheduled, expired, paused) for campaign portfolio management."
    - name: "banner_type"
      expr: banner_type
      comment: "Type of banner (hero, carousel, interstitial, sidebar) for format effectiveness comparison."
    - name: "placement_zone"
      expr: placement_zone
      comment: "Page zone where the banner is displayed for placement ROI analysis."
    - name: "device_targeting"
      expr: device_targeting
      comment: "Device segment targeted by the banner for device-specific creative performance."
    - name: "geo_targeting_country_code"
      expr: geo_targeting_country_code
      comment: "Country targeted by the banner for geographic campaign analysis."
    - name: "locale_code"
      expr: locale_code
      comment: "Locale of the banner for localization effectiveness analysis."
    - name: "is_personalized"
      expr: is_personalized
      comment: "Whether the banner is personalized for personalization lift analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for revenue normalization."
    - name: "banner_start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the banner campaign started for monthly performance trend analysis."
  measures:
    - name: "total_banners"
      expr: COUNT(1)
      comment: "Total number of promotion banners. Baseline creative inventory metric."
    - name: "total_impressions"
      expr: SUM(CAST(impression_count AS DOUBLE))
      comment: "Total banner impressions served. Measures promotional reach and campaign scale."
    - name: "total_clicks"
      expr: SUM(CAST(click_count AS DOUBLE))
      comment: "Total banner clicks. Measures promotional engagement volume."
    - name: "banner_click_through_rate"
      expr: ROUND(100.0 * SUM(CAST(click_count AS DOUBLE)) / NULLIF(SUM(CAST(impression_count AS DOUBLE)), 0), 2)
      comment: "Clicks as a percentage of impressions. Primary creative effectiveness KPI; low CTR triggers creative refresh or placement change decisions."
    - name: "total_conversions"
      expr: SUM(CAST(conversion_count AS DOUBLE))
      comment: "Total conversions attributed to banner clicks. Measures banner-to-purchase effectiveness."
    - name: "banner_conversion_rate"
      expr: ROUND(100.0 * SUM(CAST(conversion_count AS DOUBLE)) / NULLIF(SUM(CAST(click_count AS DOUBLE)), 0), 2)
      comment: "Conversions as a percentage of clicks. Measures post-click landing page and offer effectiveness."
    - name: "total_attributed_revenue"
      expr: SUM(CAST(attributed_revenue AS DOUBLE))
      comment: "Total revenue attributed to banner interactions. Primary banner ROI metric used in marketing budget allocation decisions."
    - name: "revenue_per_impression"
      expr: ROUND(SUM(CAST(attributed_revenue AS DOUBLE)) / NULLIF(SUM(CAST(impression_count AS DOUBLE)), 0), 4)
      comment: "Attributed revenue per banner impression. Normalizes banner performance across different traffic volumes for fair comparison."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_marketplace_listing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketplace channel performance metrics covering listing quality, buy-box ownership, and competitive pricing. Drives marketplace strategy and channel investment decisions."
  source: "`vibe_retail_v1`.`ecommerce`.`marketplace_listing`"
  dimensions:
    - name: "marketplace_platform"
      expr: marketplace_platform
      comment: "Marketplace platform (Amazon, eBay, Walmart Marketplace, etc.) for platform-level performance comparison."
    - name: "listing_status"
      expr: listing_status
      comment: "Current state of the listing (active, suppressed, inactive, pending) for listing health monitoring."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Fulfillment method for the listing (FBA, FBM, dropship) for fulfillment cost and performance analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the marketplace listing for geographic channel analysis."
    - name: "is_private_label"
      expr: is_private_label
      comment: "Whether the listed item is private-label for margin mix analysis."
    - name: "is_buy_box_owner"
      expr: is_buy_box_owner
      comment: "Whether the retailer currently owns the buy box. Buy box ownership is the primary driver of marketplace sales volume."
    - name: "prime_eligible_flag"
      expr: prime_eligible_flag
      comment: "Whether the listing is eligible for premium shipping programs for conversion rate analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Listing currency for multi-currency price comparison."
    - name: "listing_month"
      expr: DATE_TRUNC('month', listed_timestamp)
      comment: "Month the listing went live for listing velocity trend analysis."
  measures:
    - name: "total_listings"
      expr: COUNT(1)
      comment: "Total number of marketplace listings. Baseline marketplace presence metric."
    - name: "active_listings"
      expr: SUM(CASE WHEN listing_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of currently active marketplace listings. Measures effective marketplace catalog breadth."
    - name: "buy_box_ownership_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_buy_box_owner = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of listings where the retailer owns the buy box. Primary marketplace competitiveness KPI; declines trigger pricing and fulfillment strategy reviews."
    - name: "avg_listing_quality_score"
      expr: AVG(CAST(listing_quality_score AS DOUBLE))
      comment: "Average listing quality score across all listings. Low scores reduce search visibility and conversion on marketplace platforms."
    - name: "avg_marketplace_price"
      expr: AVG(CAST(marketplace_price AS DOUBLE))
      comment: "Average listed price across marketplace listings. Tracks price positioning and informs competitive pricing strategy."
    - name: "avg_competitor_price"
      expr: AVG(CAST(competitor_price AS DOUBLE))
      comment: "Average competitor price for the same SKUs. Used to measure price competitiveness and inform repricing decisions."
    - name: "price_competitiveness_gap"
      expr: ROUND(AVG(CAST(marketplace_price AS DOUBLE)) - AVG(CAST(competitor_price AS DOUBLE)), 2)
      comment: "Average difference between own price and competitor price. Positive values indicate price disadvantage; negative values indicate price leadership."
    - name: "avg_sell_through_rate"
      expr: AVG(CAST(sell_through_rate AS DOUBLE))
      comment: "Average sell-through rate across marketplace listings. Low sell-through triggers markdown or listing optimization actions."
    - name: "avg_marketplace_rating"
      expr: AVG(CAST(marketplace_rating AS DOUBLE))
      comment: "Average seller/product rating on marketplace platforms. Ratings below platform thresholds risk listing suppression."
    - name: "suppressed_listing_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN listing_status = 'suppressed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of listings that are suppressed by the marketplace. Suppressed listings generate zero revenue and require immediate remediation."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_storefront_assortment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storefront assortment performance metrics covering SKU coverage, conversion, and revenue against targets. Drives merchandising and assortment planning decisions for digital channels."
  source: "`vibe_retail_v1`.`ecommerce`.`storefront_assortment`"
  dimensions:
    - name: "assortment_status"
      expr: assortment_status
      comment: "Current state of the assortment (active, draft, archived) for assortment portfolio management."
    - name: "assortment_type"
      expr: assortment_type
      comment: "Type of assortment (core, seasonal, promotional, exclusive) for assortment strategy analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for governance and compliance monitoring."
    - name: "geo_market_code"
      expr: geo_market_code
      comment: "Geographic market for the assortment for regional performance comparison."
    - name: "region_code"
      expr: region_code
      comment: "Regional code for geographic assortment analysis."
    - name: "locale_code"
      expr: locale_code
      comment: "Locale for localized assortment performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for revenue normalization."
    - name: "personalization_enabled_flag"
      expr: personalization_enabled_flag
      comment: "Whether personalization is enabled for the assortment for personalization lift analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the assortment became effective for seasonal trend analysis."
  measures:
    - name: "total_assortments"
      expr: COUNT(1)
      comment: "Total number of storefront assortment configurations. Baseline assortment portfolio metric."
    - name: "total_revenue"
      expr: SUM(CAST(total_revenue_amount AS DOUBLE))
      comment: "Total revenue generated by storefront assortments. Primary assortment financial performance metric."
    - name: "avg_selling_price"
      expr: AVG(CAST(average_selling_price AS DOUBLE))
      comment: "Average selling price across assortment items. Tracks price mix and informs pricing strategy."
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate across assortments. Measures assortment relevance and demand alignment."
    - name: "avg_add_to_cart_rate"
      expr: AVG(CAST(add_to_cart_rate AS DOUBLE))
      comment: "Average add-to-cart rate across assortments. Measures product appeal and assortment quality."
    - name: "avg_return_rate"
      expr: AVG(CAST(return_rate AS DOUBLE))
      comment: "Average return rate across assortments. High return rates signal product-market fit issues or quality problems."
    - name: "revenue_vs_target"
      expr: ROUND(100.0 * SUM(CAST(total_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(revenue_target_amount AS DOUBLE)), 0), 2)
      comment: "Actual revenue as a percentage of revenue target. Measures assortment performance against plan; below 100% triggers merchandising review."
    - name: "total_otb_budget"
      expr: SUM(CAST(localized_otb_budget_amount AS DOUBLE))
      comment: "Total open-to-buy budget allocated to storefront assortments. Tracks buying budget utilization for financial planning."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_personalization_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Personalization rule performance metrics covering conversion lift, click-through rates, and revenue attribution. Drives personalization strategy and algorithm investment decisions."
  source: "`vibe_retail_v1`.`ecommerce`.`personalization_rule`"
  dimensions:
    - name: "rule_status"
      expr: rule_status
      comment: "Current state of the personalization rule (active, inactive, testing) for rule portfolio management."
    - name: "rule_type"
      expr: rule_type
      comment: "Type of personalization rule (segment-based, behavioral, contextual) for strategy analysis."
    - name: "algorithm_type"
      expr: algorithm_type
      comment: "Algorithm powering the rule for algorithm performance comparison."
    - name: "placement_zone"
      expr: placement_zone
      comment: "Page zone where the rule is applied for placement effectiveness analysis."
    - name: "placement_location"
      expr: placement_location
      comment: "Specific placement location for granular placement analysis."
    - name: "device_type_filter"
      expr: device_type_filter
      comment: "Device type targeted by the rule for device-specific personalization analysis."
    - name: "is_geo_targeted"
      expr: is_geo_targeted
      comment: "Whether the rule applies geographic targeting for geo-personalization analysis."
    - name: "is_device_specific"
      expr: is_device_specific
      comment: "Whether the rule is device-specific for device strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for revenue normalization."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the rule became effective for trend analysis."
  measures:
    - name: "total_rules"
      expr: COUNT(1)
      comment: "Total number of personalization rules. Measures personalization program complexity and coverage."
    - name: "active_rules"
      expr: SUM(CASE WHEN rule_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of currently active personalization rules. Tracks live personalization coverage."
    - name: "total_impressions"
      expr: SUM(CAST(impression_count AS DOUBLE))
      comment: "Total impressions served by personalization rules. Measures personalization reach."
    - name: "total_clicks"
      expr: SUM(CAST(click_count AS DOUBLE))
      comment: "Total clicks generated by personalization rules. Measures personalization engagement."
    - name: "avg_click_through_rate"
      expr: AVG(CAST(ctr AS DOUBLE))
      comment: "Average click-through rate across personalization rules. Primary personalization relevance KPI."
    - name: "total_conversions"
      expr: SUM(CAST(conversion_count AS DOUBLE))
      comment: "Total conversions attributed to personalization rules. Measures personalization-to-purchase effectiveness."
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate across personalization rules. Measures overall personalization program conversion effectiveness."
    - name: "total_attributed_revenue"
      expr: SUM(CAST(attributed_revenue_amount AS DOUBLE))
      comment: "Total revenue attributed to personalization rules. Primary personalization ROI metric used in investment decisions."
    - name: "avg_confidence_threshold"
      expr: AVG(CAST(confidence_threshold AS DOUBLE))
      comment: "Average confidence threshold set across rules. Low thresholds may serve low-quality personalization; high thresholds may reduce coverage."
$$;