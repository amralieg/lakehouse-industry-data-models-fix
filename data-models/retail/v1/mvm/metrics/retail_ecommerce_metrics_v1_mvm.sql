-- Metric views for domain: ecommerce | Business: Retail | Version: 1 | Generated on: 2026-05-04 13:23:00

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`ecommerce_cart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cart-level metrics tracking shopping cart value, abandonment behavior, discount effectiveness, and fulfillment channel mix. Supports conversion funnel analysis, promotional ROI, and revenue-at-risk from abandoned carts."
  source: "`retail_ecm`.`ecommerce`.`cart`"
  dimensions:
    - name: "cart_status"
      expr: cart_status
      comment: "Current status of the cart (e.g., active, abandoned, converted) — primary funnel stage dimension."
    - name: "channel"
      expr: channel
      comment: "Sales channel through which the cart was created (e.g., web, mobile, app) — enables channel-level performance analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device used to create the cart (e.g., desktop, mobile, tablet) — supports device-mix and UX optimization analysis."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment method selected (e.g., ship-to-home, BOPIS, ROPIS) — drives fulfillment capacity planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the cart is denominated — required for multi-currency revenue normalization."
    - name: "is_abandoned"
      expr: is_abandoned
      comment: "Boolean flag indicating whether the cart was abandoned — primary dimension for abandonment funnel segmentation."
    - name: "is_guest_cart"
      expr: is_guest_cart
      comment: "Boolean flag indicating whether the cart belongs to a guest (unauthenticated) user — supports guest vs. member conversion analysis."
    - name: "abandonment_reason"
      expr: abandonment_reason
      comment: "Reason recorded for cart abandonment — enables root-cause analysis of lost revenue."
    - name: "utm_source"
      expr: utm_source
      comment: "UTM source parameter from the originating marketing campaign — supports marketing attribution analysis."
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "UTM campaign identifier — enables campaign-level cart and revenue attribution."
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the cart was created, truncated to day — primary time dimension for trend analysis."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the cart was created — supports monthly cohort and seasonality analysis."
  measures:
    - name: "total_carts"
      expr: COUNT(1)
      comment: "Total number of carts created. Baseline volume metric for funnel entry rate and capacity planning."
    - name: "abandoned_carts"
      expr: COUNT(CASE WHEN is_abandoned = TRUE THEN 1 END)
      comment: "Number of carts that were abandoned. Numerator for cart abandonment rate — directly tied to lost revenue risk."
    - name: "converted_carts"
      expr: COUNT(CASE WHEN cart_status = 'converted' THEN 1 END)
      comment: "Number of carts that successfully converted to an order. Numerator for cart conversion rate — core e-commerce health KPI."
    - name: "total_cart_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of all cart subtotal amounts (pre-tax, pre-shipping). Represents gross merchandise value at cart stage — revenue pipeline indicator."
    - name: "total_cart_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied across all carts. Measures promotional cost and discount depth — critical for margin management."
    - name: "total_cart_total_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Sum of all cart total amounts (including tax and shipping estimates). Represents total revenue pipeline value in carts."
    - name: "avg_cart_total_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average cart total value. Key indicator of average order value potential — used to benchmark upsell and cross-sell effectiveness."
    - name: "avg_cart_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount applied per cart. Measures average promotional depth — informs pricing and promotion strategy."
    - name: "total_estimated_shipping_amount"
      expr: SUM(CAST(estimated_shipping_amount AS DOUBLE))
      comment: "Total estimated shipping revenue across all carts. Supports shipping cost recovery and free-shipping threshold optimization."
    - name: "recovery_email_sent_carts"
      expr: COUNT(CASE WHEN recovery_email_sent = TRUE THEN 1 END)
      comment: "Number of abandoned carts for which a recovery email was sent. Measures reach of cart recovery campaigns — input to recovery ROI calculation."
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customer accounts with carts. Measures unique shopper engagement — supports customer acquisition and retention analysis."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`ecommerce_cart_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cart item-level metrics covering product-level demand signals, discount depth, tax exposure, and fulfillment mix within shopping carts. Enables SKU-level merchandising decisions, promotional effectiveness, and inventory demand forecasting."
  source: "`retail_ecm`.`ecommerce`.`cart_item`"
  dimensions:
    - name: "item_status"
      expr: item_status
      comment: "Status of the cart line item (e.g., active, removed, purchased, saved-for-later) — primary item lifecycle dimension."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment method for the item (e.g., ship-to-home, BOPIS) — drives fulfillment channel mix analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type used when the item was added to cart — supports device-level merchandising and UX analysis."
    - name: "add_to_cart_source"
      expr: add_to_cart_source
      comment: "Source or placement from which the item was added (e.g., search, PDP, recommendation) — enables product discovery attribution."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the item is priced — required for multi-currency revenue normalization."
    - name: "is_gift"
      expr: is_gift
      comment: "Boolean flag indicating whether the item is marked as a gift — supports gifting behavior analysis."
    - name: "is_in_stock"
      expr: is_in_stock
      comment: "Boolean flag indicating whether the item was in stock when added — measures lost sales due to stockouts."
    - name: "is_private_label"
      expr: is_private_label
      comment: "Boolean flag indicating whether the item is a private-label product — supports private-label penetration analysis."
    - name: "add_to_cart_date"
      expr: DATE_TRUNC('day', add_to_cart_timestamp)
      comment: "Date the item was added to cart, truncated to day — primary time dimension for demand trend analysis."
    - name: "add_to_cart_month"
      expr: DATE_TRUNC('month', add_to_cart_timestamp)
      comment: "Month the item was added to cart — supports monthly demand and seasonality analysis."
  measures:
    - name: "total_cart_items"
      expr: COUNT(1)
      comment: "Total number of cart line items. Baseline demand volume metric — used to measure product interest and cart depth."
    - name: "purchased_items"
      expr: COUNT(CASE WHEN item_status = 'purchased' THEN 1 END)
      comment: "Number of cart items that were ultimately purchased. Numerator for item-level conversion rate — measures product demand fulfillment."
    - name: "removed_items"
      expr: COUNT(CASE WHEN item_status = 'removed' THEN 1 END)
      comment: "Number of cart items that were removed before purchase. Indicates friction or price sensitivity at the item level — informs merchandising and pricing decisions."
    - name: "total_line_subtotal_amount"
      expr: SUM(CAST(line_subtotal AS DOUBLE))
      comment: "Sum of all cart item line subtotals. Represents gross merchandise value at the item level — core revenue pipeline metric."
    - name: "total_item_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied at the item level. Measures promotional cost at SKU granularity — critical for item-level margin management."
    - name: "total_item_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all cart items. Supports tax liability estimation and compliance reporting."
    - name: "avg_line_subtotal_amount"
      expr: AVG(CAST(line_subtotal AS DOUBLE))
      comment: "Average line subtotal per cart item. Measures average item value — used to benchmark upsell effectiveness and price point analysis."
    - name: "avg_item_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per cart item. Measures average promotional depth at item level — informs SKU-level pricing strategy."
    - name: "distinct_skus_in_cart"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs added to carts. Measures product breadth of demand — supports assortment planning and inventory prioritization."
    - name: "out_of_stock_items"
      expr: COUNT(CASE WHEN is_in_stock = FALSE THEN 1 END)
      comment: "Number of cart items that were out of stock. Directly measures lost sales opportunity — drives inventory replenishment urgency."
    - name: "private_label_items"
      expr: COUNT(CASE WHEN is_private_label = TRUE THEN 1 END)
      comment: "Number of private-label items added to carts. Measures private-label demand penetration — supports brand strategy decisions."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`ecommerce_checkout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Checkout funnel metrics covering step completion rates, order value composition, payment behavior, and abandonment patterns. Enables conversion optimization, payment strategy, and fulfillment mode analysis at the checkout stage."
  source: "`retail_ecm`.`ecommerce`.`checkout`"
  dimensions:
    - name: "checkout_status"
      expr: checkout_status
      comment: "Current status of the checkout session (e.g., initiated, completed, abandoned) — primary funnel stage dimension."
    - name: "channel"
      expr: channel
      comment: "Sales channel for the checkout (e.g., web, mobile, app) — enables channel-level conversion analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type used during checkout — supports device-level UX and conversion optimization."
    - name: "fulfillment_mode"
      expr: fulfillment_mode
      comment: "Fulfillment mode selected at checkout (e.g., ship-to-home, BOPIS, ROPIS) — drives fulfillment capacity and cost planning."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment processing status (e.g., authorized, declined, pending) — critical for payment success rate analysis."
    - name: "shipping_method_name"
      expr: shipping_method_name
      comment: "Shipping method selected by the customer — supports shipping cost and preference analysis."
    - name: "is_guest_checkout"
      expr: is_guest_checkout
      comment: "Boolean flag indicating guest vs. authenticated checkout — supports guest conversion and account creation strategy."
    - name: "is_gift_order"
      expr: is_gift_order
      comment: "Boolean flag indicating whether the order is a gift — supports gifting season demand planning."
    - name: "abandonment_step"
      expr: abandonment_step
      comment: "Checkout step at which the session was abandoned — enables step-level funnel drop-off analysis for UX optimization."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the checkout transaction — required for multi-currency revenue normalization."
    - name: "initiated_date"
      expr: DATE_TRUNC('day', initiated_timestamp)
      comment: "Date the checkout was initiated, truncated to day — primary time dimension for checkout volume trends."
    - name: "initiated_month"
      expr: DATE_TRUNC('month', initiated_timestamp)
      comment: "Month the checkout was initiated — supports monthly conversion and revenue trend analysis."
  measures:
    - name: "total_checkouts_initiated"
      expr: COUNT(1)
      comment: "Total number of checkout sessions initiated. Baseline funnel entry metric — measures demand reaching the payment stage."
    - name: "completed_checkouts"
      expr: COUNT(CASE WHEN checkout_status = 'completed' THEN 1 END)
      comment: "Number of checkout sessions that completed successfully. Numerator for checkout completion rate — core conversion KPI."
    - name: "abandoned_checkouts"
      expr: COUNT(CASE WHEN checkout_status = 'abandoned' THEN 1 END)
      comment: "Number of checkout sessions abandoned before completion. Measures late-funnel revenue loss — drives UX and payment optimization investment."
    - name: "total_order_total_amount"
      expr: SUM(CAST(order_total_amount AS DOUBLE))
      comment: "Sum of all checkout order totals. Represents total revenue committed at checkout — primary revenue pipeline metric."
    - name: "avg_order_total_amount"
      expr: AVG(CAST(order_total_amount AS DOUBLE))
      comment: "Average order total at checkout. Core AOV (Average Order Value) metric — used to benchmark upsell, bundling, and promotional effectiveness."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied at checkout. Measures promotional cost at the order level — critical for gross margin management."
    - name: "total_shipping_amount"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping revenue collected at checkout. Supports shipping cost recovery analysis and free-shipping threshold optimization."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at checkout. Supports tax liability reporting and compliance obligations."
    - name: "total_gift_card_amount"
      expr: SUM(CAST(gift_card_amount AS DOUBLE))
      comment: "Total gift card redemption value at checkout. Measures gift card liability drawdown — supports gift card program financial management."
    - name: "total_store_credit_amount"
      expr: SUM(CAST(store_credit_amount AS DOUBLE))
      comment: "Total store credit applied at checkout. Measures store credit liability utilization — supports customer retention and returns program analysis."
    - name: "payment_completed_checkouts"
      expr: COUNT(CASE WHEN is_payment_entry_completed = TRUE THEN 1 END)
      comment: "Number of checkouts where payment entry was completed. Measures payment step completion rate — identifies payment friction in the funnel."
    - name: "distinct_accounts_at_checkout"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customer accounts initiating checkout. Measures unique buyer engagement — supports customer lifetime value and retention analysis."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`ecommerce_digital_catalog`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital catalog metrics covering product content quality, online availability, searchability, and catalog health. Enables merchandising decisions on assortment completeness, SEO readiness, and product discoverability."
  source: "`retail_ecm`.`ecommerce`.`digital_catalog`"
  dimensions:
    - name: "publication_status"
      expr: publication_status
      comment: "Publication status of the catalog item (e.g., published, draft, archived) — primary catalog health dimension."
    - name: "is_online_available"
      expr: is_online_available
      comment: "Boolean flag indicating whether the product is available online — measures active sellable assortment."
    - name: "is_searchable"
      expr: is_searchable
      comment: "Boolean flag indicating whether the product is indexed for search — measures search discoverability coverage."
    - name: "is_featured"
      expr: is_featured
      comment: "Boolean flag indicating whether the product is featured/promoted — supports featured assortment analysis."
    - name: "is_private_label"
      expr: is_private_label
      comment: "Boolean flag indicating private-label products — supports private-label catalog penetration analysis."
    - name: "is_drop_ship_eligible"
      expr: is_drop_ship_eligible
      comment: "Boolean flag indicating drop-ship eligibility — supports fulfillment model mix analysis."
    - name: "has_video"
      expr: has_video
      comment: "Boolean flag indicating whether the product listing includes video content — supports rich media content strategy analysis."
    - name: "locale_code"
      expr: locale_code
      comment: "Locale for the catalog entry — enables localization coverage and international assortment analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for the catalog item pricing — required for multi-currency assortment analysis."
    - name: "last_published_month"
      expr: DATE_TRUNC('month', last_published_timestamp)
      comment: "Month the catalog item was last published — supports catalog freshness and content refresh cadence analysis."
    - name: "publish_start_month"
      expr: DATE_TRUNC('month', CAST(publish_start_date AS TIMESTAMP))
      comment: "Month the catalog item became active — supports seasonal assortment launch analysis."
  measures:
    - name: "total_catalog_items"
      expr: COUNT(1)
      comment: "Total number of digital catalog items. Baseline assortment breadth metric — measures catalog size and coverage."
    - name: "online_available_items"
      expr: COUNT(CASE WHEN is_online_available = TRUE THEN 1 END)
      comment: "Number of catalog items currently available online. Measures active sellable assortment size — directly tied to revenue opportunity."
    - name: "searchable_items"
      expr: COUNT(CASE WHEN is_searchable = TRUE THEN 1 END)
      comment: "Number of catalog items indexed for search. Measures search discoverability coverage — impacts organic traffic and conversion."
    - name: "avg_content_completeness_score"
      expr: AVG(CAST(content_completeness_score AS DOUBLE))
      comment: "Average content completeness score across catalog items. Measures overall catalog content quality — low scores correlate with reduced conversion and SEO performance."
    - name: "avg_rating"
      expr: AVG(CAST(rating_average AS DOUBLE))
      comment: "Average customer rating across catalog items. Measures overall product satisfaction signal — used to prioritize assortment curation and supplier performance."
    - name: "items_with_video"
      expr: COUNT(CASE WHEN has_video = TRUE THEN 1 END)
      comment: "Number of catalog items with video content. Measures rich media coverage — video content is correlated with higher conversion rates."
    - name: "featured_items"
      expr: COUNT(CASE WHEN is_featured = TRUE THEN 1 END)
      comment: "Number of featured catalog items. Measures promotional assortment size — supports merchandising and campaign planning."
    - name: "drop_ship_eligible_items"
      expr: COUNT(CASE WHEN is_drop_ship_eligible = TRUE THEN 1 END)
      comment: "Number of drop-ship eligible catalog items. Measures drop-ship assortment coverage — supports fulfillment model diversification strategy."
    - name: "distinct_skus_in_catalog"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs in the digital catalog. Measures unique product depth — supports assortment planning and gap analysis."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`ecommerce_digital_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital payment metrics covering transaction volume, payment success rates, fraud exposure, refund activity, and payment method mix. Enables payment operations, fraud risk management, and financial reconciliation decisions."
  source: "`retail_ecm`.`ecommerce`.`digital_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment transaction (e.g., authorized, captured, declined, refunded) — primary payment health dimension."
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Type of payment method used (e.g., credit card, debit card, digital wallet) — supports payment mix and acceptance strategy analysis."
    - name: "payment_gateway"
      expr: payment_gateway
      comment: "Payment gateway used to process the transaction — enables gateway performance and cost comparison."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which the payment was made (e.g., web, mobile, in-store) — supports omnichannel payment analysis."
    - name: "card_network"
      expr: card_network
      comment: "Card network (e.g., Visa, Mastercard, Amex) — supports interchange cost and acceptance rate analysis."
    - name: "wallet_provider"
      expr: wallet_provider
      comment: "Digital wallet provider (e.g., Apple Pay, Google Pay, PayPal) — measures digital wallet adoption and preference."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment transaction — required for multi-currency financial reconciliation."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Boolean flag indicating recurring/subscription payments — supports subscription revenue analysis."
    - name: "fraud_screening_result"
      expr: fraud_screening_result
      comment: "Result of fraud screening (e.g., pass, review, reject) — primary fraud risk dimension."
    - name: "three_ds_status"
      expr: three_ds_status
      comment: "3D Secure authentication status — measures strong customer authentication compliance and friction impact."
    - name: "authorization_date"
      expr: DATE_TRUNC('day', authorization_timestamp)
      comment: "Date of payment authorization, truncated to day — primary time dimension for payment volume trends."
    - name: "authorization_month"
      expr: DATE_TRUNC('month', authorization_timestamp)
      comment: "Month of payment authorization — supports monthly payment volume and revenue trend analysis."
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of payment transactions. Baseline payment volume metric — measures transaction throughput and payment operations scale."
    - name: "authorized_transactions"
      expr: COUNT(CASE WHEN payment_status = 'authorized' OR payment_status = 'captured' THEN 1 END)
      comment: "Number of successfully authorized or captured transactions. Numerator for payment authorization rate — core payment health KPI."
    - name: "declined_transactions"
      expr: COUNT(CASE WHEN payment_status = 'declined' THEN 1 END)
      comment: "Number of declined payment transactions. Measures payment failure rate — high decline rates indicate gateway issues or fraud friction impacting revenue."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount processed. Primary revenue collection metric — used for financial reconciliation and revenue reporting."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after fees and adjustments. Measures actual revenue retained — used for net revenue reporting and profitability analysis."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued. Measures refund liability and return cost — directly impacts net revenue and customer satisfaction."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment transaction amount. Measures average transaction value — used to benchmark payment size trends and detect anomalies."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across transactions. Measures overall fraud exposure level — rising scores trigger fraud rule tightening and investigation."
    - name: "high_fraud_risk_transactions"
      expr: COUNT(CASE WHEN fraud_screening_result = 'reject' THEN 1 END)
      comment: "Number of transactions flagged as high fraud risk and rejected. Measures fraud prevention effectiveness — supports fraud loss avoidance quantification."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected in payments. Supports tax remittance reporting and compliance obligations."
    - name: "distinct_paying_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customer accounts making payments. Measures unique paying customer base — supports revenue concentration and customer value analysis."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`ecommerce_storefront`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storefront configuration and capability metrics covering channel mix, fulfillment enablement, loyalty integration, and compliance posture. Enables strategic decisions on storefront expansion, capability rollout, and regulatory compliance."
  source: "`retail_ecm`.`ecommerce`.`storefront`"
  dimensions:
    - name: "storefront_status"
      expr: storefront_status
      comment: "Operational status of the storefront (e.g., active, inactive, decommissioned) — primary storefront health dimension."
    - name: "channel_type"
      expr: channel_type
      comment: "Type of sales channel (e.g., web, mobile, marketplace) — supports channel strategy and investment analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country in which the storefront operates — enables geographic market performance analysis."
    - name: "locale_code"
      expr: locale_code
      comment: "Locale configuration of the storefront — supports localization coverage and international expansion analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used by the storefront — required for multi-currency revenue normalization."
    - name: "is_bopis_enabled"
      expr: is_bopis_enabled
      comment: "Boolean flag indicating BOPIS (Buy Online, Pick Up In Store) capability — measures omnichannel fulfillment readiness."
    - name: "is_loyalty_enabled"
      expr: is_loyalty_enabled
      comment: "Boolean flag indicating loyalty program integration — measures loyalty program reach across storefronts."
    - name: "is_drop_ship_enabled"
      expr: is_drop_ship_enabled
      comment: "Boolean flag indicating drop-ship fulfillment capability — supports assortment expansion strategy analysis."
    - name: "is_ship_from_store_enabled"
      expr: is_ship_from_store_enabled
      comment: "Boolean flag indicating ship-from-store capability — measures distributed fulfillment network readiness."
    - name: "gdpr_consent_required"
      expr: gdpr_consent_required
      comment: "Boolean flag indicating GDPR consent requirement — measures regulatory compliance posture across storefronts."
    - name: "launch_month"
      expr: DATE_TRUNC('month', CAST(launch_date AS TIMESTAMP))
      comment: "Month the storefront was launched — supports storefront growth and expansion timeline analysis."
  measures:
    - name: "total_storefronts"
      expr: COUNT(1)
      comment: "Total number of storefronts. Baseline metric for digital channel footprint — measures e-commerce presence scale."
    - name: "active_storefronts"
      expr: COUNT(CASE WHEN storefront_status = 'active' THEN 1 END)
      comment: "Number of currently active storefronts. Measures live revenue-generating digital channels — core operational health metric."
    - name: "bopis_enabled_storefronts"
      expr: COUNT(CASE WHEN is_bopis_enabled = TRUE THEN 1 END)
      comment: "Number of storefronts with BOPIS enabled. Measures omnichannel fulfillment capability coverage — BOPIS drives incremental in-store traffic and conversion."
    - name: "loyalty_enabled_storefronts"
      expr: COUNT(CASE WHEN is_loyalty_enabled = TRUE THEN 1 END)
      comment: "Number of storefronts with loyalty program integration. Measures loyalty program reach — loyalty-enabled storefronts drive higher repeat purchase rates."
    - name: "drop_ship_enabled_storefronts"
      expr: COUNT(CASE WHEN is_drop_ship_enabled = TRUE THEN 1 END)
      comment: "Number of storefronts with drop-ship capability. Measures extended assortment reach — drop-ship enables catalog expansion without inventory investment."
    - name: "ship_from_store_enabled_storefronts"
      expr: COUNT(CASE WHEN is_ship_from_store_enabled = TRUE THEN 1 END)
      comment: "Number of storefronts with ship-from-store capability. Measures distributed fulfillment network coverage — reduces last-mile delivery cost and improves delivery speed."
    - name: "avg_free_shipping_threshold"
      expr: AVG(CAST(free_shipping_threshold AS DOUBLE))
      comment: "Average free shipping threshold across storefronts. Measures AOV incentive level — threshold calibration directly impacts cart value and shipping cost recovery."
    - name: "avg_min_order_amount"
      expr: AVG(CAST(min_order_amount AS DOUBLE))
      comment: "Average minimum order amount across storefronts. Measures order floor policy — impacts conversion rate and basket size strategy."
    - name: "gdpr_compliant_storefronts"
      expr: COUNT(CASE WHEN gdpr_consent_required = TRUE THEN 1 END)
      comment: "Number of storefronts with GDPR consent enforcement enabled. Measures regulatory compliance coverage — non-compliance carries significant financial and reputational risk."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`ecommerce_web_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Web session metrics covering traffic quality, engagement depth, conversion funnel progression, and marketing attribution. Enables digital marketing investment decisions, UX optimization, and customer acquisition strategy."
  source: "`retail_ecm`.`ecommerce`.`web_session`"
  filter: is_bot = FALSE
  dimensions:
    - name: "device_type"
      expr: device_type
      comment: "Device type used during the session (e.g., desktop, mobile, tablet) — primary device mix dimension for UX and conversion analysis."
    - name: "referral_source"
      expr: referral_source
      comment: "Source that referred the session (e.g., organic, paid, email, social) — primary marketing attribution dimension."
    - name: "utm_source"
      expr: utm_source
      comment: "UTM source parameter — enables granular paid and owned media attribution."
    - name: "utm_medium"
      expr: utm_medium
      comment: "UTM medium parameter (e.g., cpc, email, social) — supports channel-level marketing ROI analysis."
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "UTM campaign identifier — enables campaign-level traffic and conversion attribution."
    - name: "visitor_type"
      expr: visitor_type
      comment: "Visitor type (e.g., new, returning) — supports new vs. returning visitor conversion and retention analysis."
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Geographic country of the session — enables geographic traffic and conversion analysis."
    - name: "operating_system"
      expr: operating_system
      comment: "Operating system of the visitor's device — supports technical compatibility and UX optimization analysis."
    - name: "is_bounce"
      expr: is_bounce
      comment: "Boolean flag indicating single-page sessions with no engagement — primary engagement quality dimension."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment type associated with the session — supports fulfillment preference analysis at the traffic level."
    - name: "session_start_date"
      expr: DATE_TRUNC('day', session_start_timestamp)
      comment: "Date the session started, truncated to day — primary time dimension for traffic trend analysis."
    - name: "session_start_month"
      expr: DATE_TRUNC('month', session_start_timestamp)
      comment: "Month the session started — supports monthly traffic, engagement, and conversion trend analysis."
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of web sessions (bots excluded). Baseline traffic volume metric — measures digital channel reach and marketing effectiveness."
    - name: "bounce_sessions"
      expr: COUNT(CASE WHEN is_bounce = TRUE THEN 1 END)
      comment: "Number of sessions that bounced (single-page, no engagement). Numerator for bounce rate — high bounce rates indicate landing page or targeting quality issues."
    - name: "cart_created_sessions"
      expr: COUNT(CASE WHEN is_cart_created = TRUE THEN 1 END)
      comment: "Number of sessions in which a cart was created. Measures top-of-funnel conversion from browse to intent — key e-commerce engagement KPI."
    - name: "checkout_initiated_sessions"
      expr: COUNT(CASE WHEN is_checkout_initiated = TRUE THEN 1 END)
      comment: "Number of sessions in which checkout was initiated. Measures mid-funnel conversion from cart to checkout — identifies checkout funnel entry rate."
    - name: "order_placed_sessions"
      expr: COUNT(CASE WHEN is_order_placed = TRUE THEN 1 END)
      comment: "Number of sessions resulting in a placed order. Measures end-to-end session conversion rate — the most critical e-commerce conversion KPI."
    - name: "distinct_visitors"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct visitor profiles. Measures unique audience reach — supports customer acquisition and audience sizing analysis."
    - name: "data_consent_sessions"
      expr: COUNT(CASE WHEN data_consent_flag = TRUE THEN 1 END)
      comment: "Number of sessions where data consent was granted. Measures consent coverage — impacts personalization capability and regulatory compliance posture."
$$;