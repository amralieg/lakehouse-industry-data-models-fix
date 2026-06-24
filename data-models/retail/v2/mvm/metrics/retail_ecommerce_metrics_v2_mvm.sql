-- Metric views for domain: ecommerce | Business: Retail | Version: 2 | Generated on: 2026-06-24 00:42:49

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_cart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cart-level metrics tracking shopping cart health, abandonment, discount effectiveness, and revenue potential. Core KPIs for conversion funnel analysis and promotional effectiveness."
  source: "`vibe_retail_v1`.`ecommerce`.`cart`"
  dimensions:
    - name: "cart_status"
      expr: cart_status
      comment: "Current status of the cart (e.g., active, abandoned, converted) — used to segment funnel stages."
    - name: "channel"
      expr: channel
      comment: "Sales channel through which the cart was created (e.g., web, mobile, app) — enables channel-level performance analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type used by the shopper (e.g., desktop, mobile, tablet) — critical for UX and conversion optimization."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment method selected (e.g., ship-to-home, BOPIS) — informs fulfillment capacity planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cart transaction — supports multi-currency revenue reporting."
    - name: "is_abandoned"
      expr: is_abandoned
      comment: "Boolean flag indicating whether the cart was abandoned — primary dimension for abandonment analysis."
    - name: "is_guest_cart"
      expr: is_guest_cart
      comment: "Indicates whether the cart belongs to a guest (unauthenticated) shopper — used to measure guest vs. registered conversion rates."
    - name: "coupon_redemption_status"
      expr: coupon_redemption_status
      comment: "Status of coupon redemption on the cart — used to evaluate promotional uptake and discount effectiveness."
    - name: "abandonment_reason"
      expr: abandonment_reason
      comment: "Reason recorded for cart abandonment — actionable dimension for reducing abandonment rates."
    - name: "utm_source"
      expr: utm_source
      comment: "UTM source parameter — identifies the marketing source driving cart creation for attribution analysis."
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "UTM campaign parameter — links cart activity to specific marketing campaigns."
    - name: "created_date"
      expr: DATE_TRUNC('DAY', created_timestamp)
      comment: "Date the cart was created — used for daily trend analysis of cart volume and value."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the cart was created — used for monthly trend and seasonality analysis."
  measures:
    - name: "total_carts"
      expr: COUNT(1)
      comment: "Total number of carts created. Baseline volume metric for funnel entry measurement."
    - name: "abandoned_carts"
      expr: COUNT(CASE WHEN is_abandoned = TRUE THEN 1 END)
      comment: "Number of carts that were abandoned. Directly measures lost conversion opportunities — a key lever for revenue recovery campaigns."
    - name: "converted_carts"
      expr: COUNT(CASE WHEN cart_status = 'converted' THEN 1 END)
      comment: "Number of carts that successfully converted to an order. Core conversion funnel metric used in executive dashboards."
    - name: "total_cart_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of all cart subtotal amounts. Represents gross merchandise value in the cart pipeline — used to size revenue at risk from abandonment."
    - name: "total_cart_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied across all carts. Measures promotional cost and discount depth — critical for margin management."
    - name: "avg_cart_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total cart value. A key indicator of shopper intent and basket size — used to benchmark upsell and cross-sell effectiveness."
    - name: "total_cart_value"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total value of all carts including tax and shipping. Represents the full revenue pipeline in the cart stage."
    - name: "total_estimated_tax_amount"
      expr: SUM(CAST(estimated_tax_amount AS DOUBLE))
      comment: "Total estimated tax across all carts. Used for tax liability forecasting and compliance reporting."
    - name: "recovery_email_sent_count"
      expr: COUNT(CASE WHEN recovery_email_sent = TRUE THEN 1 END)
      comment: "Number of abandoned carts for which a recovery email was sent. Measures reach of cart recovery programs — used to evaluate re-engagement campaign coverage."
    - name: "guest_cart_count"
      expr: COUNT(CASE WHEN is_guest_cart = TRUE THEN 1 END)
      comment: "Number of carts created by guest (unauthenticated) shoppers. High guest cart volume signals registration friction — actionable for account creation optimization."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_cart_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cart item-level metrics capturing product-level demand signals, discount patterns, and fulfillment preferences within the shopping cart. Enables SKU-level and category-level merchandising decisions."
  source: "`vibe_retail_v1`.`ecommerce`.`cart_item`"
  dimensions:
    - name: "item_status"
      expr: item_status
      comment: "Status of the cart line item (e.g., active, removed, purchased) — used to filter active demand vs. removed items."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment method for the line item (e.g., ship-to-home, BOPIS) — informs fulfillment mix and capacity planning."
    - name: "device_type"
      expr: device_type
      comment: "Device type used when the item was added to cart — supports device-level conversion analysis."
    - name: "add_to_cart_source"
      expr: add_to_cart_source
      comment: "Source or placement from which the item was added (e.g., search, PDP, recommendation) — used to evaluate merchandising and recommendation engine effectiveness."
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of promotion applied to the line item — used to measure promotional mix and discount strategy effectiveness."
    - name: "is_gift"
      expr: is_gift
      comment: "Indicates whether the item is marked as a gift — used to size gift commerce volume and seasonal gifting trends."
    - name: "is_private_label"
      expr: is_private_label
      comment: "Indicates whether the item is a private label product — used to track private label penetration in the cart."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line item — supports multi-currency revenue reporting."
    - name: "add_to_cart_date"
      expr: DATE_TRUNC('DAY', add_to_cart_timestamp)
      comment: "Date the item was added to cart — used for daily demand trend analysis."
    - name: "add_to_cart_month"
      expr: DATE_TRUNC('MONTH', add_to_cart_timestamp)
      comment: "Month the item was added to cart — used for monthly demand and seasonality analysis."
  measures:
    - name: "total_cart_items"
      expr: COUNT(1)
      comment: "Total number of cart line items. Baseline demand volume metric — used to measure product-level interest before purchase."
    - name: "total_line_subtotal_amount"
      expr: SUM(CAST(line_subtotal AS DOUBLE))
      comment: "Sum of all cart item line subtotals. Represents gross merchandise value at the item level — core revenue pipeline metric."
    - name: "total_item_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied at the line item level. Measures promotional cost at SKU granularity — used for margin and promotion ROI analysis."
    - name: "total_item_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all cart line items. Used for tax liability estimation and compliance reporting."
    - name: "avg_item_line_subtotal"
      expr: AVG(CAST(line_subtotal AS DOUBLE))
      comment: "Average line subtotal per cart item. Indicates average unit selling price in the cart — used to benchmark pricing and promotional effectiveness."
    - name: "distinct_skus_in_cart"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs added to carts. Measures product breadth of demand — used by merchandising to identify high-demand SKUs."
    - name: "gift_item_count"
      expr: COUNT(CASE WHEN is_gift = TRUE THEN 1 END)
      comment: "Number of cart items flagged as gifts. Measures gift commerce volume — used for seasonal gifting strategy and gift packaging capacity planning."
    - name: "private_label_item_count"
      expr: COUNT(CASE WHEN is_private_label = TRUE THEN 1 END)
      comment: "Number of private label items in carts. Tracks private label penetration — a strategic KPI for margin improvement initiatives."
    - name: "out_of_stock_item_count"
      expr: COUNT(CASE WHEN is_in_stock = FALSE THEN 1 END)
      comment: "Number of cart items that are out of stock. Measures lost demand due to stockouts — directly actionable for inventory replenishment decisions."
    - name: "price_override_item_count"
      expr: COUNT(CASE WHEN price_override_flag = TRUE THEN 1 END)
      comment: "Number of line items with a price override applied. Monitors manual pricing exceptions — used for pricing governance and audit compliance."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_checkout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Checkout funnel metrics measuring conversion efficiency, payment success, abandonment patterns, and order value at the checkout stage. Essential for optimizing the purchase completion experience."
  source: "`vibe_retail_v1`.`ecommerce`.`checkout`"
  dimensions:
    - name: "checkout_status"
      expr: checkout_status
      comment: "Current status of the checkout session (e.g., initiated, completed, abandoned) — primary dimension for funnel stage analysis."
    - name: "channel"
      expr: channel
      comment: "Sales channel of the checkout (e.g., web, mobile) — used for channel-level conversion rate benchmarking."
    - name: "device_type"
      expr: device_type
      comment: "Device type used during checkout — used to identify device-specific friction points in the checkout flow."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method selected at checkout (e.g., credit card, PayPal, gift card) — used to analyze payment method mix and authorization rates."
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment at checkout (e.g., authorized, declined, pending) — critical for payment success rate monitoring."
    - name: "fulfillment_mode"
      expr: fulfillment_mode
      comment: "Fulfillment mode selected at checkout (e.g., ship-to-home, BOPIS, SFS) — used for fulfillment capacity and cost analysis."
    - name: "is_guest_checkout"
      expr: is_guest_checkout
      comment: "Indicates whether the checkout was completed as a guest — used to measure guest vs. registered checkout conversion rates."
    - name: "is_gift_order"
      expr: is_gift_order
      comment: "Indicates whether the order is a gift — used to size gift commerce volume and plan gift services capacity."
    - name: "abandonment_step"
      expr: abandonment_step
      comment: "The checkout step at which the session was abandoned — pinpoints friction points in the checkout funnel for UX optimization."
    - name: "shipping_method_name"
      expr: shipping_method_name
      comment: "Shipping method selected by the customer — used to analyze shipping method mix and associated cost/revenue trade-offs."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the checkout transaction — supports multi-currency revenue reporting."
    - name: "initiated_date"
      expr: DATE_TRUNC('DAY', initiated_timestamp)
      comment: "Date the checkout was initiated — used for daily checkout volume and conversion trend analysis."
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_timestamp)
      comment: "Month the checkout was initiated — used for monthly funnel performance and seasonality analysis."
  measures:
    - name: "total_checkouts_initiated"
      expr: COUNT(1)
      comment: "Total number of checkout sessions initiated. Baseline funnel entry metric for the checkout stage — used to measure checkout volume trends."
    - name: "completed_checkouts"
      expr: COUNT(CASE WHEN checkout_status = 'completed' THEN 1 END)
      comment: "Number of checkout sessions that were successfully completed. Core conversion metric — directly tied to order placement and revenue realization."
    - name: "abandoned_checkouts"
      expr: COUNT(CASE WHEN checkout_status = 'abandoned' THEN 1 END)
      comment: "Number of checkout sessions abandoned before completion. Measures revenue leakage at the final purchase stage — high-priority metric for checkout optimization."
    - name: "total_order_value"
      expr: SUM(CAST(order_total_amount AS DOUBLE))
      comment: "Sum of all checkout order totals. Represents total revenue value flowing through the checkout funnel — core GMV metric."
    - name: "avg_order_value"
      expr: AVG(CAST(order_total_amount AS DOUBLE))
      comment: "Average order total at checkout. A primary e-commerce KPI used to benchmark upsell effectiveness and pricing strategy."
    - name: "total_checkout_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied at checkout. Measures promotional cost at the order level — used for margin and promotion ROI analysis."
    - name: "total_shipping_revenue"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping charges collected at checkout. Measures shipping revenue contribution and informs free shipping threshold strategy."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected at checkout. Used for tax liability reporting and regulatory compliance."
    - name: "total_gift_card_redemption"
      expr: SUM(CAST(gift_card_amount AS DOUBLE))
      comment: "Total gift card value redeemed at checkout. Measures gift card liability drawdown and informs gift card program performance."
    - name: "total_store_credit_applied"
      expr: SUM(CAST(store_credit_amount AS DOUBLE))
      comment: "Total store credit applied at checkout. Tracks store credit utilization — used to manage store credit liability and customer retention program effectiveness."
    - name: "guest_checkout_count"
      expr: COUNT(CASE WHEN is_guest_checkout = TRUE THEN 1 END)
      comment: "Number of checkouts completed as guest. High guest checkout rates signal account creation friction — actionable for loyalty program enrollment strategy."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_digital_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital payment transaction metrics covering authorization rates, fraud risk, refund volumes, and payment method performance. Critical for payment operations, fraud management, and financial reconciliation."
  source: "`vibe_retail_v1`.`ecommerce`.`digital_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment transaction (e.g., authorized, captured, declined, refunded) — primary dimension for payment health monitoring."
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Type of payment method used (e.g., credit card, debit card, digital wallet) — used to analyze payment method mix and associated authorization rates."
    - name: "payment_gateway"
      expr: payment_gateway
      comment: "Payment gateway used to process the transaction — used to benchmark gateway performance and authorization rates."
    - name: "card_network"
      expr: card_network
      comment: "Card network (e.g., Visa, Mastercard, Amex) — used to analyze network-level authorization rates and processing costs."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which the payment was made (e.g., web, mobile, in-app) — used for channel-level payment performance analysis."
    - name: "wallet_provider"
      expr: wallet_provider
      comment: "Digital wallet provider (e.g., Apple Pay, Google Pay, PayPal) — used to track digital wallet adoption and conversion rates."
    - name: "fraud_screening_result"
      expr: fraud_screening_result
      comment: "Result of fraud screening (e.g., approved, flagged, declined) — used to monitor fraud detection effectiveness and false positive rates."
    - name: "three_ds_status"
      expr: three_ds_status
      comment: "3D Secure authentication status — used to measure strong customer authentication compliance and its impact on authorization rates."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment transaction — supports multi-currency financial reporting."
    - name: "authorization_date"
      expr: DATE_TRUNC('DAY', authorization_timestamp)
      comment: "Date of payment authorization — used for daily payment volume and authorization rate trend analysis."
    - name: "authorization_month"
      expr: DATE_TRUNC('MONTH', authorization_timestamp)
      comment: "Month of payment authorization — used for monthly financial reconciliation and trend analysis."
  measures:
    - name: "total_payment_transactions"
      expr: COUNT(1)
      comment: "Total number of digital payment transactions. Baseline volume metric for payment operations monitoring."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount processed. Core financial metric representing total payment volume — used for revenue reconciliation and financial reporting."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after refunds and adjustments. Represents actual net revenue collected — used for financial close and P&L reporting."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued. Measures refund liability and return rate impact on revenue — a key metric for customer satisfaction and fraud management."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment transaction amount. Used to benchmark average transaction size and detect anomalies indicative of fraud or pricing issues."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across payment transactions. Monitors overall fraud risk exposure — used by fraud operations to calibrate screening thresholds."
    - name: "high_fraud_risk_transactions"
      expr: COUNT(CASE WHEN fraud_screening_result = 'flagged' THEN 1 END)
      comment: "Number of transactions flagged as high fraud risk. Measures fraud exposure volume — directly actionable for fraud operations and chargeback management."
    - name: "declined_transactions"
      expr: COUNT(CASE WHEN payment_status = 'declined' THEN 1 END)
      comment: "Number of declined payment transactions. High decline rates signal payment friction or fraud screening over-sensitivity — actionable for payment optimization."
    - name: "authorized_transactions"
      expr: COUNT(CASE WHEN payment_status = 'authorized' THEN 1 END)
      comment: "Number of successfully authorized payment transactions. Used to calculate authorization rates — a primary KPI for payment gateway performance."
    - name: "refunded_transactions"
      expr: COUNT(CASE WHEN payment_status = 'refunded' THEN 1 END)
      comment: "Number of refunded transactions. Measures refund frequency — used to monitor return policy impact and customer satisfaction trends."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_web_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Web session engagement and conversion metrics measuring traffic quality, bounce rates, cart creation, checkout initiation, and order placement rates. Foundation for digital marketing ROI and UX optimization decisions."
  source: "`vibe_retail_v1`.`ecommerce`.`web_session`"
  dimensions:
    - name: "device_type"
      expr: device_type
      comment: "Device type used during the session (e.g., desktop, mobile, tablet) — used to analyze device-level engagement and conversion rates."
    - name: "referral_source"
      expr: referral_source
      comment: "Source that referred the session (e.g., organic, paid, email, social) — used for marketing channel attribution and ROI analysis."
    - name: "utm_source"
      expr: utm_source
      comment: "UTM source parameter — identifies the marketing source driving sessions for campaign attribution."
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "UTM campaign parameter — links session activity to specific marketing campaigns for ROI measurement."
    - name: "utm_medium"
      expr: utm_medium
      comment: "UTM medium parameter (e.g., cpc, email, social) — used to analyze traffic quality by marketing medium."
    - name: "visitor_type"
      expr: visitor_type
      comment: "Type of visitor (e.g., new, returning) — used to segment acquisition vs. retention traffic and measure loyalty."
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Country of the session based on geo-IP — used for geographic traffic and conversion analysis."
    - name: "operating_system"
      expr: operating_system
      comment: "Operating system of the visitor's device — used to identify OS-level performance or compatibility issues."
    - name: "browser_name"
      expr: browser_name
      comment: "Browser used during the session — used to detect browser-specific conversion or performance issues."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment type associated with the session — used to analyze fulfillment preference by traffic source."
    - name: "session_date"
      expr: DATE_TRUNC('DAY', session_start_timestamp)
      comment: "Date the session started — used for daily traffic volume and conversion trend analysis."
    - name: "session_month"
      expr: DATE_TRUNC('MONTH', session_start_timestamp)
      comment: "Month the session started — used for monthly traffic and conversion trend analysis."
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of web sessions. Baseline traffic volume metric — used to measure site reach and marketing campaign effectiveness."
    - name: "unique_visitors"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct visitor profiles. Measures unique audience reach — used to differentiate traffic volume from unique user engagement."
    - name: "bounce_sessions"
      expr: COUNT(CASE WHEN is_bounce = TRUE THEN 1 END)
      comment: "Number of sessions where the visitor left after viewing only one page. High bounce rates indicate landing page or traffic quality issues — directly actionable for marketing and UX teams."
    - name: "cart_created_sessions"
      expr: COUNT(CASE WHEN is_cart_created = TRUE THEN 1 END)
      comment: "Number of sessions in which a cart was created. Measures top-of-funnel conversion from browsing to shopping intent — a key e-commerce engagement KPI."
    - name: "checkout_initiated_sessions"
      expr: COUNT(CASE WHEN is_checkout_initiated = TRUE THEN 1 END)
      comment: "Number of sessions in which checkout was initiated. Measures mid-funnel conversion — used to evaluate checkout funnel entry rates."
    - name: "order_placed_sessions"
      expr: COUNT(CASE WHEN is_order_placed = TRUE THEN 1 END)
      comment: "Number of sessions that resulted in a placed order. Measures end-to-end session conversion — the most critical session-level KPI for revenue attribution."
    - name: "bot_sessions"
      expr: COUNT(CASE WHEN is_bot = TRUE THEN 1 END)
      comment: "Number of sessions identified as bot traffic. Used to filter non-human traffic from conversion metrics and assess bot mitigation effectiveness."
    - name: "human_sessions"
      expr: COUNT(CASE WHEN is_bot = FALSE THEN 1 END)
      comment: "Number of sessions identified as human (non-bot) traffic. Provides the clean denominator for accurate conversion rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_product_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product review quality and sentiment metrics measuring customer satisfaction, review moderation health, and content trustworthiness. Used to steer product quality, merchandising, and customer experience strategy."
  source: "`vibe_retail_v1`.`ecommerce`.`product_review`"
  dimensions:
    - name: "moderation_status"
      expr: moderation_status
      comment: "Moderation status of the review (e.g., approved, rejected, pending) — used to monitor content quality and moderation throughput."
    - name: "sentiment_label"
      expr: sentiment_label
      comment: "Sentiment classification of the review (e.g., positive, neutral, negative) — used to track product sentiment trends and identify quality issues."
    - name: "is_verified_purchase"
      expr: is_verified_purchase
      comment: "Indicates whether the reviewer made a verified purchase — used to weight review credibility and measure verified review coverage."
    - name: "is_incentivized"
      expr: is_incentivized
      comment: "Indicates whether the review was incentivized — used for regulatory compliance and review authenticity monitoring."
    - name: "purchase_channel"
      expr: purchase_channel
      comment: "Channel through which the reviewed product was purchased — used to analyze review patterns by purchase channel."
    - name: "review_language_code"
      expr: review_language_code
      comment: "Language of the review — used for localization analysis and to ensure review coverage across key markets."
    - name: "reviewer_expertise_level"
      expr: reviewer_expertise_level
      comment: "Self-reported expertise level of the reviewer — used to segment review quality and credibility."
    - name: "syndication_source"
      expr: syndication_source
      comment: "Source from which the review was syndicated — used to measure syndication program reach and content diversity."
    - name: "submission_date"
      expr: DATE_TRUNC('DAY', submission_timestamp)
      comment: "Date the review was submitted — used for daily review volume trend analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month the review was submitted — used for monthly review volume and sentiment trend analysis."
  measures:
    - name: "total_reviews_submitted"
      expr: COUNT(1)
      comment: "Total number of reviews submitted. Baseline metric for review program health — used to measure customer engagement with the review platform."
    - name: "approved_reviews"
      expr: COUNT(CASE WHEN moderation_status = 'approved' THEN 1 END)
      comment: "Number of reviews approved by moderation. Measures publishable review volume — used to assess content pipeline health and moderation efficiency."
    - name: "rejected_reviews"
      expr: COUNT(CASE WHEN moderation_status = 'rejected' THEN 1 END)
      comment: "Number of reviews rejected by moderation. High rejection rates may indicate content quality issues or policy violations — actionable for seller and content governance."
    - name: "verified_purchase_reviews"
      expr: COUNT(CASE WHEN is_verified_purchase = TRUE THEN 1 END)
      comment: "Number of reviews from verified purchasers. Measures review authenticity and credibility — a key trust signal for shoppers and a regulatory compliance metric."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across all reviews. Tracks overall product and brand sentiment — a leading indicator of customer satisfaction and potential churn."
    - name: "distinct_skus_reviewed"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with at least one review. Measures review coverage breadth across the product catalog — used to identify products lacking social proof."
    - name: "incentivized_review_count"
      expr: COUNT(CASE WHEN is_incentivized = TRUE THEN 1 END)
      comment: "Number of incentivized reviews. Monitors compliance with FTC and platform guidelines on incentivized review disclosure — a regulatory risk metric."
    - name: "reviews_with_media"
      expr: COUNT(CASE WHEN has_media = TRUE THEN 1 END)
      comment: "Number of reviews that include media (images or video). Rich media reviews drive higher conversion rates — used to measure content quality and guide review incentive programs."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_promotion_banner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion banner performance metrics measuring impressions, click-through rates, conversion effectiveness, and attributed revenue. Core KPIs for digital merchandising and marketing campaign optimization."
  source: "`vibe_retail_v1`.`ecommerce`.`promotion_banner`"
  dimensions:
    - name: "banner_status"
      expr: banner_status
      comment: "Current status of the promotion banner (e.g., active, expired, draft) — used to filter live vs. historical banner performance."
    - name: "banner_type"
      expr: banner_type
      comment: "Type of promotion banner (e.g., hero, carousel, interstitial) — used to compare performance across banner formats."
    - name: "placement_zone"
      expr: placement_zone
      comment: "Placement zone on the site where the banner is displayed (e.g., homepage, category page, checkout) — used to evaluate placement effectiveness."
    - name: "device_targeting"
      expr: device_targeting
      comment: "Device targeting configuration for the banner (e.g., desktop, mobile, all) — used to analyze device-specific banner performance."
    - name: "ab_test_variant"
      expr: ab_test_variant
      comment: "A/B test variant identifier — used to compare creative and messaging variants for data-driven optimization."
    - name: "is_personalized"
      expr: is_personalized
      comment: "Indicates whether the banner is personalized for a specific customer segment — used to measure personalization lift in engagement and conversion."
    - name: "geo_targeting_country_code"
      expr: geo_targeting_country_code
      comment: "Country targeted by the banner — used for geographic campaign performance analysis."
    - name: "locale_code"
      expr: locale_code
      comment: "Locale of the banner — used to analyze performance across different regional and language markets."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of attributed revenue — supports multi-currency campaign revenue reporting."
    - name: "start_date"
      expr: DATE_TRUNC('DAY', start_timestamp)
      comment: "Date the banner campaign started — used for campaign timeline and performance trend analysis."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month the banner campaign started — used for monthly campaign performance and spend analysis."
  measures:
    - name: "total_banners"
      expr: COUNT(1)
      comment: "Total number of promotion banners. Baseline metric for promotional content volume — used to track campaign scale and creative inventory."
    - name: "total_impressions"
      expr: SUM(CAST(impression_count AS DOUBLE))
      comment: "Total banner impressions served. Measures promotional reach — a primary metric for campaign visibility and media planning."
    - name: "total_clicks"
      expr: SUM(CAST(click_count AS DOUBLE))
      comment: "Total clicks on promotion banners. Measures shopper engagement with promotional content — used to evaluate creative effectiveness."
    - name: "total_conversions"
      expr: SUM(CAST(conversion_count AS DOUBLE))
      comment: "Total conversions attributed to promotion banners. Measures direct promotional impact on purchase behavior — a core campaign ROI metric."
    - name: "total_attributed_revenue"
      expr: SUM(CAST(attributed_revenue AS DOUBLE))
      comment: "Total revenue attributed to promotion banners. Measures the direct revenue contribution of promotional content — used to calculate campaign ROI and justify marketing spend."
    - name: "avg_attributed_revenue_per_banner"
      expr: AVG(CAST(attributed_revenue AS DOUBLE))
      comment: "Average attributed revenue per promotion banner. Used to benchmark banner effectiveness and prioritize high-performing placements and creative formats."
    - name: "personalized_banner_count"
      expr: COUNT(CASE WHEN is_personalized = TRUE THEN 1 END)
      comment: "Number of personalized promotion banners. Measures personalization program scale — used to track progress toward personalization strategy goals."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_marketplace_listing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketplace listing performance metrics covering pricing competitiveness, listing quality, buy box ownership, and sell-through rates. Enables marketplace channel strategy and competitive positioning decisions."
  source: "`vibe_retail_v1`.`ecommerce`.`marketplace_listing`"
  dimensions:
    - name: "listing_status"
      expr: listing_status
      comment: "Current status of the marketplace listing (e.g., active, suppressed, inactive) — used to monitor listing health and suppression rates."
    - name: "marketplace_platform"
      expr: marketplace_platform
      comment: "Marketplace platform (e.g., Amazon, eBay, Walmart Marketplace) — used to compare performance across marketplace channels."
    - name: "is_buy_box_owner"
      expr: is_buy_box_owner
      comment: "Indicates whether the listing currently owns the buy box — buy box ownership is the primary driver of marketplace sales volume."
    - name: "is_private_label"
      expr: is_private_label
      comment: "Indicates whether the listed item is a private label product — used to track private label marketplace penetration."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Fulfillment method for the marketplace listing (e.g., FBA, FBM, drop-ship) — used to analyze fulfillment mix and associated cost/performance trade-offs."
    - name: "country_code"
      expr: country_code
      comment: "Country of the marketplace listing — used for geographic marketplace performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the marketplace listing — supports multi-currency marketplace revenue reporting."
    - name: "prime_eligible_flag"
      expr: prime_eligible_flag
      comment: "Indicates whether the listing is eligible for Prime (or equivalent fast-shipping program) — Prime eligibility is a key driver of buy box ownership and conversion."
    - name: "suppression_reason"
      expr: suppression_reason
      comment: "Reason for listing suppression — used to diagnose and remediate listing quality issues that reduce marketplace visibility."
    - name: "listed_date"
      expr: DATE_TRUNC('DAY', listed_timestamp)
      comment: "Date the listing went live — used for listing launch trend analysis."
    - name: "listed_month"
      expr: DATE_TRUNC('MONTH', listed_timestamp)
      comment: "Month the listing went live — used for monthly marketplace expansion and catalog growth analysis."
  measures:
    - name: "total_listings"
      expr: COUNT(1)
      comment: "Total number of marketplace listings. Baseline metric for marketplace catalog breadth — used to track marketplace expansion strategy."
    - name: "active_listings"
      expr: COUNT(CASE WHEN listing_status = 'active' THEN 1 END)
      comment: "Number of active marketplace listings. Measures live catalog size — used to monitor listing health and marketplace presence."
    - name: "suppressed_listings"
      expr: COUNT(CASE WHEN listing_status = 'suppressed' THEN 1 END)
      comment: "Number of suppressed marketplace listings. Suppressed listings generate zero revenue — directly actionable for marketplace operations to recover lost sales."
    - name: "buy_box_owned_listings"
      expr: COUNT(CASE WHEN is_buy_box_owner = TRUE THEN 1 END)
      comment: "Number of listings where the retailer owns the buy box. Buy box ownership is the primary determinant of marketplace sales — a strategic KPI for marketplace competitiveness."
    - name: "avg_marketplace_price"
      expr: AVG(CAST(marketplace_price AS DOUBLE))
      comment: "Average listed price across marketplace listings. Used to benchmark pricing strategy and monitor price positioning relative to MSRP."
    - name: "avg_competitor_price"
      expr: AVG(CAST(competitor_price AS DOUBLE))
      comment: "Average competitor price for the same SKUs. Used to assess price competitiveness — a key input for dynamic pricing and buy box strategy."
    - name: "avg_listing_quality_score"
      expr: AVG(CAST(listing_quality_score AS DOUBLE))
      comment: "Average listing quality score. Listing quality directly impacts search ranking and conversion on marketplaces — used to prioritize content improvement efforts."
    - name: "avg_sell_through_rate"
      expr: AVG(CAST(sell_through_rate AS DOUBLE))
      comment: "Average sell-through rate across marketplace listings. Measures inventory velocity on the marketplace channel — used for inventory allocation and replenishment decisions."
    - name: "avg_marketplace_rating"
      expr: AVG(CAST(marketplace_rating AS DOUBLE))
      comment: "Average marketplace rating across listings. Marketplace ratings directly influence buy box eligibility and conversion — a key customer satisfaction and competitive KPI."
    - name: "distinct_skus_listed"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs listed on marketplaces. Measures marketplace catalog coverage — used to identify catalog gaps and expansion opportunities."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_digital_catalog`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital catalog content quality and availability metrics measuring product content completeness, online availability, and SEO readiness. Drives merchandising, content operations, and organic search performance decisions."
  source: "`vibe_retail_v1`.`ecommerce`.`digital_catalog`"
  dimensions:
    - name: "publication_status"
      expr: publication_status
      comment: "Publication status of the catalog entry (e.g., published, draft, unpublished) — used to monitor catalog availability and content pipeline health."
    - name: "is_online_available"
      expr: is_online_available
      comment: "Indicates whether the product is available for online purchase — used to measure online catalog availability rate."
    - name: "is_featured"
      expr: is_featured
      comment: "Indicates whether the product is featured in the digital catalog — used to analyze featured product performance and merchandising strategy."
    - name: "is_private_label"
      expr: is_private_label
      comment: "Indicates whether the product is a private label item — used to track private label catalog penetration and content quality."
    - name: "is_searchable"
      expr: is_searchable
      comment: "Indicates whether the product is indexed for site search — used to monitor search discoverability of the catalog."
    - name: "is_drop_ship_eligible"
      expr: is_drop_ship_eligible
      comment: "Indicates whether the product is eligible for drop-ship fulfillment — used to analyze drop-ship catalog coverage."
    - name: "has_video"
      expr: has_video
      comment: "Indicates whether the product listing includes a video — used to measure rich media content coverage and its impact on conversion."
    - name: "locale_code"
      expr: locale_code
      comment: "Locale of the catalog entry — used to analyze content coverage and quality across regional markets."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the catalog pricing — supports multi-currency catalog analysis."
    - name: "last_published_month"
      expr: DATE_TRUNC('MONTH', last_published_timestamp)
      comment: "Month the catalog entry was last published — used to identify stale content and measure content refresh cadence."
    - name: "publish_start_month"
      expr: DATE_TRUNC('MONTH', publish_start_date)
      comment: "Month the catalog entry became active — used for catalog growth and new product launch trend analysis."
  measures:
    - name: "total_catalog_entries"
      expr: COUNT(1)
      comment: "Total number of digital catalog entries. Baseline metric for catalog size — used to track catalog growth and coverage."
    - name: "online_available_products"
      expr: COUNT(CASE WHEN is_online_available = TRUE THEN 1 END)
      comment: "Number of products available for online purchase. Measures shoppable catalog size — a key metric for online revenue potential and catalog health."
    - name: "published_products"
      expr: COUNT(CASE WHEN publication_status = 'published' THEN 1 END)
      comment: "Number of published catalog entries. Measures live catalog size — used to track content operations throughput and catalog availability."
    - name: "avg_content_completeness_score"
      expr: AVG(CAST(content_completeness_score AS DOUBLE))
      comment: "Average content completeness score across catalog entries. Incomplete product content reduces conversion and SEO performance — a key content operations KPI."
    - name: "avg_catalog_rating"
      expr: AVG(CAST(rating_average AS DOUBLE))
      comment: "Average customer rating across digital catalog entries. Measures overall product quality perception — used to identify low-rated products requiring quality intervention."
    - name: "products_with_video"
      expr: COUNT(CASE WHEN has_video = TRUE THEN 1 END)
      comment: "Number of catalog entries with video content. Video content significantly improves conversion rates — used to measure rich media coverage and prioritize video production investment."
    - name: "searchable_products"
      expr: COUNT(CASE WHEN is_searchable = TRUE THEN 1 END)
      comment: "Number of products indexed for site search. Measures search discoverability of the catalog — products not indexed are invisible to search-driven shoppers."
    - name: "featured_products"
      expr: COUNT(CASE WHEN is_featured = TRUE THEN 1 END)
      comment: "Number of featured products in the digital catalog. Measures merchandising spotlight coverage — used to evaluate featured product strategy and rotation."
    - name: "drop_ship_eligible_products"
      expr: COUNT(CASE WHEN is_drop_ship_eligible = TRUE THEN 1 END)
      comment: "Number of products eligible for drop-ship fulfillment. Measures drop-ship catalog coverage — used to evaluate drop-ship program scale and supplier onboarding progress."
$$;