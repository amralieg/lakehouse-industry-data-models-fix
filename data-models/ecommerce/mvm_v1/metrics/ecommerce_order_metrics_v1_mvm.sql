-- Metric views for domain: order | Business: Ecommerce | Version: 1 | Generated on: 2026-05-05 00:54:17

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`order_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order-level KPIs derived from the order header fact table. Covers revenue, discount efficiency, tax burden, order volume, and SLA performance — the primary steering metrics for the e-commerce order domain."
  source: "`ecommerce_ecm`.`order`.`header`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order (e.g. pending, confirmed, shipped, delivered, cancelled). Primary operational grouping for order health dashboards."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g. standard, marketplace, B2B, subscription). Enables revenue mix analysis by order type."
    - name: "order_priority"
      expr: order_priority
      comment: "Priority tier assigned to the order (e.g. standard, expedited, same-day). Used to analyse SLA compliance by priority segment."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the order. Enables multi-currency revenue reporting and FX exposure analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the order (e.g. paid, pending, failed, refunded). Critical for cash-flow and collections monitoring."
    - name: "is_expedited"
      expr: is_expedited
      comment: "Flag indicating whether the order was placed with expedited fulfilment. Used to measure premium service adoption and associated cost."
    - name: "is_gift"
      expr: is_gift
      comment: "Flag indicating whether the order is a gift. Supports gifting season analysis and packaging cost attribution."
    - name: "is_split_shipment"
      expr: is_split_shipment
      comment: "Flag indicating whether the order was fulfilled via multiple shipments. Drives split-shipment cost and customer experience analysis."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier assigned to the order (e.g. gold, silver, standard). Enables SLA compliance reporting by tier."
    - name: "order_placed_date"
      expr: DATE_TRUNC('day', order_placed_timestamp)
      comment: "Date the order was placed, truncated to day. Primary time dimension for daily order volume and revenue trending."
    - name: "order_placed_month"
      expr: DATE_TRUNC('month', order_placed_timestamp)
      comment: "Month the order was placed. Used for monthly revenue and volume trend analysis."
    - name: "device_code"
      expr: device_code
      comment: "Device type used to place the order (e.g. mobile, desktop, tablet). Enables channel-device mix and conversion analysis."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates whether the order is tax-exempt. Used for tax liability and compliance reporting."
    - name: "is_backorder"
      expr: is_backorder
      comment: "Indicates whether the order contains backordered items. Used to monitor backorder rate and its impact on fulfilment SLA."
  measures:
    - name: "total_order_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross revenue across all orders (sum of order total_amount). The primary top-line revenue KPI for the order domain, used in every executive and board-level revenue review."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue after discounts and adjustments (sum of net_amount). Used alongside gross revenue to measure discount erosion and true revenue performance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total monetary value of discounts applied across all orders. Directly informs promotional spend efficiency and margin management decisions."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected across all orders. Required for tax compliance reporting and remittance forecasting."
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average order value (AOV) — the mean total_amount per order. A core e-commerce KPI used to benchmark pricing strategy, upsell effectiveness, and customer segment value."
    - name: "avg_net_order_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net order value after discounts. Compared against AOV to quantify the per-order discount impact and guide promotional strategy."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Discount rate as a percentage of gross order revenue. Measures promotional intensity; a rising discount rate signals margin pressure and triggers pricing review."
    - name: "tax_rate_effective_pct"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate as a percentage of net revenue. Used by finance to validate tax engine accuracy and monitor jurisdiction-level tax exposure."
    - name: "total_order_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of all orders in kilograms. Used by logistics and fulfilment teams to forecast carrier capacity and shipping cost."
    - name: "avg_order_weight_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average order weight in kilograms. Informs carrier rate negotiation and packaging optimisation decisions."
    - name: "expedited_order_count"
      expr: COUNT(CASE WHEN is_expedited = TRUE THEN header_id END)
      comment: "Number of orders placed with expedited fulfilment. Tracks premium service demand and associated fulfilment cost exposure."
    - name: "split_shipment_order_count"
      expr: COUNT(CASE WHEN is_split_shipment = TRUE THEN header_id END)
      comment: "Number of orders fulfilled via split shipments. High split-shipment rates increase logistics cost and degrade customer experience — a key operational efficiency KPI."
    - name: "split_shipment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_split_shipment = TRUE THEN header_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders that required split shipments. Directly tied to fulfilment cost and customer satisfaction; monitored to drive inventory positioning improvements."
    - name: "backorder_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_backorder = TRUE THEN header_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders containing backordered items. A leading indicator of inventory health and demand-supply imbalance; triggers replenishment and safety-stock reviews."
    - name: "distinct_customers_ordering"
      expr: COUNT(DISTINCT customer_profile_id)
      comment: "Number of unique customers who placed orders. Measures active buyer base size; used to track customer acquisition, retention, and repeat-purchase trends."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order line-level KPIs covering product revenue, margin, discount, tax, and fulfilment performance. Enables SKU-level and seller-level profitability analysis — the most granular revenue steering layer in the order domain."
  source: "`ecommerce_ecm`.`order`.`line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line (e.g. confirmed, shipped, delivered, cancelled, returned). Primary grouping for line-level fulfilment health."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfilment status of the order line (e.g. allocated, picked, packed, shipped). Used to monitor fulfilment pipeline throughput."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfilment method for the line (e.g. warehouse, drop-ship, in-store). Enables cost and speed comparison across fulfilment channels."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the order line. Supports multi-currency revenue and margin analysis."
    - name: "is_backordered"
      expr: is_backordered
      comment: "Flag indicating whether the line item is backordered. Used to quantify backorder exposure at the SKU level."
    - name: "is_returnable"
      expr: is_returnable
      comment: "Flag indicating whether the line item is eligible for return. Used in return rate and return liability analysis."
    - name: "is_gift"
      expr: is_gift
      comment: "Flag indicating whether the line item is a gift. Supports gifting mix and packaging cost analysis."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates whether the line item is tax-exempt. Used for tax compliance and jurisdiction-level reporting."
    - name: "tax_jurisdiction"
      expr: tax_jurisdiction
      comment: "Tax jurisdiction applicable to the order line. Enables jurisdiction-level tax liability and compliance analysis."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates whether the line item contains hazardous materials. Used for regulatory compliance and carrier restriction monitoring."
    - name: "actual_delivery_date"
      expr: DATE_TRUNC('day', actual_delivery_date)
      comment: "Actual delivery date of the order line, truncated to day. Used for on-time delivery analysis and SLA compliance reporting."
    - name: "promised_delivery_date"
      expr: DATE_TRUNC('day', promised_delivery_date)
      comment: "Promised delivery date for the order line. Compared against actual delivery date to compute on-time delivery rate."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the order line was created. Used for monthly revenue and volume trend analysis at the line level."
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(total_gross AS DOUBLE))
      comment: "Total gross revenue across all order lines (sum of total_gross). The primary line-level revenue KPI used in product and seller performance reviews."
    - name: "total_net_revenue"
      expr: SUM(CAST(total_net AS DOUBLE))
      comment: "Total net revenue after discounts across all order lines. Used alongside gross revenue to measure per-line discount erosion and true product-level profitability."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied at the order line level. Informs SKU-level promotional spend and margin management."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at the order line level. Required for jurisdiction-level tax compliance and remittance reporting."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit selling price across order lines. Used to monitor price realisation, detect markdown drift, and benchmark against list price."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage applied at the line level. A key pricing health metric; rising averages signal uncontrolled promotional activity."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average effective tax rate across order lines. Used by finance to validate tax engine accuracy and monitor blended tax exposure."
    - name: "gross_to_net_ratio"
      expr: ROUND(SUM(CAST(total_net AS DOUBLE)) / NULLIF(SUM(CAST(total_gross AS DOUBLE)), 0), 4)
      comment: "Ratio of net revenue to gross revenue at the line level. Values below 1.0 indicate discount/adjustment leakage; used to set promotional guardrails and protect margin."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_gross AS DOUBLE)), 0), 2)
      comment: "Discount rate as a percentage of gross line revenue. Measures promotional intensity at the product level; triggers pricing review when thresholds are breached."
    - name: "total_line_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of all order lines in kilograms. Used by logistics to forecast carrier capacity requirements and negotiate weight-based shipping rates."
    - name: "backordered_line_count"
      expr: COUNT(CASE WHEN is_backordered = TRUE THEN line_id END)
      comment: "Number of order lines in backorder status. A direct measure of inventory shortfall impact on order fulfilment; triggers replenishment escalation."
    - name: "backordered_line_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_backordered = TRUE THEN line_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of order lines that are backordered. Monitors inventory health at the line level; a rising rate signals systemic supply chain issues."
    - name: "distinct_skus_ordered"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs ordered. Measures product breadth in demand; used in assortment planning and inventory prioritisation decisions."
    - name: "distinct_sellers_on_lines"
      expr: COUNT(DISTINCT seller_profile_id)
      comment: "Number of unique sellers contributing order lines. Tracks marketplace seller participation and concentration risk in the order mix."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`order_cancellation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order cancellation KPIs measuring cancellation volume, refund liability, and financial impact. Cancellation metrics are critical for revenue protection, customer experience, and operational efficiency steering."
  source: "`ecommerce_ecm`.`order`.`cancellation`"
  dimensions:
    - name: "cancellation_status"
      expr: cancellation_status
      comment: "Current status of the cancellation request (e.g. pending, approved, rejected, completed). Primary grouping for cancellation pipeline monitoring."
    - name: "cancellation_type"
      expr: cancellation_type
      comment: "Type of cancellation (e.g. customer-initiated, seller-initiated, system). Used to attribute cancellation root causes and drive targeted interventions."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardised reason code for the cancellation. Enables root-cause analysis and prioritisation of cancellation reduction initiatives."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the cancellation was initiated (e.g. web, mobile, CS agent). Used to identify channel-specific cancellation patterns."
    - name: "scope"
      expr: scope
      comment: "Scope of the cancellation (e.g. full order, partial). Used to distinguish full-order revenue loss from partial cancellation impact."
    - name: "is_partial"
      expr: is_partial
      comment: "Flag indicating whether the cancellation is partial. Enables separate tracking of partial vs. full cancellation financial impact."
    - name: "refund_eligibility_flag"
      expr: refund_eligibility_flag
      comment: "Indicates whether the cancellation is eligible for a refund. Used to forecast refund liability and manage cash-flow exposure."
    - name: "refund_currency"
      expr: refund_currency
      comment: "Currency in which the refund is to be issued. Supports multi-currency refund liability reporting."
    - name: "approved_date"
      expr: DATE_TRUNC('day', approved_timestamp)
      comment: "Date the cancellation was approved, truncated to day. Used for daily cancellation approval volume trending."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the cancellation was created. Used for monthly cancellation trend and refund liability forecasting."
  measures:
    - name: "total_cancelled_amount"
      expr: SUM(CAST(cancelled_amount AS DOUBLE))
      comment: "Total monetary value of cancelled orders. Directly measures revenue at risk from cancellations; a primary KPI for revenue protection and demand forecasting."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued or pending across all cancellations. Measures cash outflow from cancellations; critical for finance and cash-flow management."
    - name: "avg_cancelled_amount"
      expr: AVG(CAST(cancelled_amount AS DOUBLE))
      comment: "Average cancelled order value. Used to assess whether high-value or low-value orders are disproportionately cancelled, informing targeted retention interventions."
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount per cancellation. Benchmarks refund generosity and identifies anomalies in refund processing."
    - name: "refund_to_cancellation_ratio"
      expr: ROUND(SUM(CAST(refund_amount AS DOUBLE)) / NULLIF(SUM(CAST(cancelled_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of total refund amount to total cancelled amount. Values near 1.0 indicate full refund policy; lower values indicate partial refund or non-refund outcomes. Used in customer satisfaction and policy compliance reviews."
    - name: "partial_cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_partial = TRUE THEN cancellation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cancellations that are partial. Distinguishes partial fulfilment failures from full order losses; informs inventory and fulfilment strategy."
    - name: "refund_eligible_cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN refund_eligibility_flag = TRUE THEN cancellation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cancellations eligible for refund. Measures refund liability exposure; used by finance to provision for outstanding refund obligations."
    - name: "approved_cancellation_count"
      expr: COUNT(CASE WHEN cancellation_status = 'approved' THEN cancellation_id END)
      comment: "Number of cancellations that have been approved. Tracks approved cancellation volume as a leading indicator of revenue loss and refund processing workload."
    - name: "rejected_cancellation_count"
      expr: COUNT(CASE WHEN cancellation_status = 'rejected' THEN cancellation_id END)
      comment: "Number of cancellations that were rejected. A high rejection rate may signal policy friction and customer dissatisfaction; monitored in CX steering reviews."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`order_cart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shopping cart KPIs covering cart value, abandonment, discount usage, and conversion signals. Cart metrics are foundational for e-commerce revenue optimisation, funnel analysis, and promotional effectiveness measurement."
  source: "`ecommerce_ecm`.`order`.`cart`"
  dimensions:
    - name: "cart_status"
      expr: cart_status
      comment: "Current status of the cart (e.g. active, abandoned, converted, expired). Primary dimension for funnel stage analysis and abandonment rate calculation."
    - name: "cart_source"
      expr: cart_source
      comment: "Source that originated the cart (e.g. organic, paid search, email, social). Used to attribute cart creation and conversion to acquisition channels."
    - name: "device_type"
      expr: device_type
      comment: "Device type used to create the cart (e.g. mobile, desktop, tablet). Enables device-level conversion and AOV analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the cart. Supports multi-currency cart value and conversion analysis."
    - name: "is_gift"
      expr: is_gift
      comment: "Flag indicating whether the cart contains gift items. Used to analyse gifting behaviour and seasonal demand patterns."
    - name: "saved_for_later_flag"
      expr: saved_for_later_flag
      comment: "Indicates whether the cart was saved for later. Tracks deferred purchase intent; used in re-engagement campaign targeting."
    - name: "abandonment_email_sent_flag"
      expr: abandonment_email_sent_flag
      comment: "Indicates whether an abandonment recovery email was sent. Used to measure abandonment recovery campaign reach and effectiveness."
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the cart was created, truncated to day. Primary time dimension for daily cart creation volume and value trending."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the cart was created. Used for monthly cart volume, value, and abandonment trend analysis."
  measures:
    - name: "total_cart_estimated_value"
      expr: SUM(CAST(total_estimated_amount AS DOUBLE))
      comment: "Total estimated value across all carts. Measures the gross revenue pipeline in the cart funnel; a leading indicator of near-term order revenue."
    - name: "total_abandoned_cart_value"
      expr: SUM(CASE WHEN cart_status = 'abandoned' THEN CAST(total_estimated_amount AS DOUBLE) ELSE 0 END)
      comment: "Total estimated value of abandoned carts. Quantifies recoverable revenue opportunity from cart abandonment; directly informs re-engagement campaign investment decisions."
    - name: "avg_cart_value"
      expr: AVG(CAST(total_estimated_amount AS DOUBLE))
      comment: "Average estimated cart value. Benchmarks cart size and tracks the impact of upsell, cross-sell, and promotional strategies on basket size."
    - name: "total_cart_discount_amount"
      expr: SUM(CAST(discount_total_amount AS DOUBLE))
      comment: "Total discount value applied across all carts. Measures promotional spend at the cart level; used to assess coupon and discount programme ROI."
    - name: "total_coupon_discount_amount"
      expr: SUM(CAST(coupon_discount_amount AS DOUBLE))
      comment: "Total coupon discount value applied across all carts. Isolates coupon-specific promotional spend for campaign cost analysis."
    - name: "avg_cart_discount_amount"
      expr: AVG(CAST(discount_total_amount AS DOUBLE))
      comment: "Average discount applied per cart. Used to monitor per-cart promotional intensity and set discount guardrails."
    - name: "cart_discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_total_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Cart discount as a percentage of cart subtotal. Measures promotional intensity in the pre-order funnel; a rising rate signals margin pressure before orders are even placed."
    - name: "cart_abandonment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cart_status = 'abandoned' THEN cart_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carts that were abandoned. The primary cart funnel health KPI; directly tied to conversion rate and revenue realisation. A key metric in every e-commerce executive review."
    - name: "total_estimated_shipping_fee"
      expr: SUM(CAST(shipping_fee_estimated_amount AS DOUBLE))
      comment: "Total estimated shipping fees across all carts. Used to forecast shipping revenue and assess the impact of free-shipping threshold strategies on cart conversion."
    - name: "total_estimated_tax"
      expr: SUM(CAST(tax_estimated_amount AS DOUBLE))
      comment: "Total estimated tax across all carts. Used by finance to forecast tax liability from the pre-order pipeline."
    - name: "total_cart_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of items across all carts in kilograms. Used by logistics to forecast carrier demand from the cart pipeline."
    - name: "distinct_customers_with_carts"
      expr: COUNT(DISTINCT customer_profile_id)
      comment: "Number of unique customers with active or recent carts. Measures shopping intent breadth; used to size re-engagement audiences and forecast conversion volume."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`order_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order payment KPIs covering payment volume, fee burden, refund exposure, fraud signals, and split-payment patterns. Payment metrics are essential for financial reconciliation, fraud management, and payment operations steering."
  source: "`ecommerce_ecm`.`order`.`order_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment transaction (e.g. authorised, captured, failed, refunded). Primary dimension for payment health and collections monitoring."
    - name: "channel"
      expr: channel
      comment: "Payment channel (e.g. web, mobile, in-store, API). Used to analyse payment success rates and fee structures by channel."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the payment. Supports multi-currency payment volume and FX exposure analysis."
    - name: "fraud_check_status"
      expr: fraud_check_status
      comment: "Result of the fraud check for the payment (e.g. passed, flagged, blocked). Used to monitor fraud detection effectiveness and false-positive rates."
    - name: "is_refund"
      expr: is_refund
      comment: "Flag indicating whether the payment record represents a refund. Enables separation of payment inflows from refund outflows in financial reporting."
    - name: "is_split_payment"
      expr: is_split_payment
      comment: "Flag indicating whether the payment was split across multiple methods. Used to analyse split-payment adoption and associated processing complexity."
    - name: "is_gift_card"
      expr: is_gift_card
      comment: "Flag indicating whether the payment used a gift card. Tracks gift card redemption volume and liability burn-down."
    - name: "is_store_credit"
      expr: is_store_credit
      comment: "Flag indicating whether the payment used store credit. Monitors store credit redemption and its impact on cash revenue."
    - name: "capture_date"
      expr: DATE_TRUNC('day', capture_timestamp)
      comment: "Date the payment was captured, truncated to day. Primary time dimension for daily payment volume and revenue recognition reporting."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the payment record was created. Used for monthly payment volume and refund trend analysis."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross payment amount processed. The primary payment volume KPI; used in daily financial reconciliation and revenue recognition reporting."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after fees. Measures actual cash received net of payment processing costs; used in profitability and margin analysis."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total payment processing fees incurred. Directly informs payment gateway cost management and vendor negotiation decisions."
    - name: "total_refunded_amount"
      expr: SUM(CAST(refunded_amount AS DOUBLE))
      comment: "Total amount refunded across all payment records. Measures cash outflow from refunds; a critical KPI for finance, fraud, and customer satisfaction management."
    - name: "total_tax_on_payments"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on payment records. Used for tax reconciliation and compliance reporting at the payment level."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment transaction amount. Benchmarks transaction size; used to detect anomalies and monitor payment mix shifts."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied across payment transactions. Used by finance to monitor FX exposure and validate currency conversion accuracy."
    - name: "fee_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Payment processing fee as a percentage of gross payment amount. Measures payment cost efficiency; used to benchmark gateway performance and negotiate fee reductions."
    - name: "refund_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(refunded_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Refunded amount as a percentage of total payment amount. A key financial health KPI; a rising refund rate signals product quality, fraud, or fulfilment issues requiring executive attention."
    - name: "split_payment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_split_payment = TRUE THEN order_payment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payment records involving split payments. Tracks multi-tender adoption and associated processing complexity and cost."
    - name: "gift_card_payment_count"
      expr: COUNT(CASE WHEN is_gift_card = TRUE THEN order_payment_id END)
      comment: "Number of payments made using gift cards. Tracks gift card redemption volume; used to manage gift card liability and forecast redemption cash impact."
    - name: "distinct_payment_orders"
      expr: COUNT(DISTINCT header_id)
      comment: "Number of distinct orders with payment records. Used to reconcile payment records against order volume and identify payment coverage gaps."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`order_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order promotion KPIs measuring promotional discount value, campaign effectiveness, compliance, and refund exposure. Promotion metrics are essential for marketing ROI, margin management, and promotional governance."
  source: "`ecommerce_ecm`.`order`.`order_promotion`"
  dimensions:
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of promotion applied (e.g. percentage discount, fixed amount, BOGO, free shipping). Used to analyse promotion mix and effectiveness by type."
    - name: "promotion_category"
      expr: promotion_category
      comment: "Category of the promotion (e.g. seasonal, loyalty, clearance). Enables promotion ROI analysis by strategic category."
    - name: "promotion_source"
      expr: promotion_source
      comment: "Source of the promotion (e.g. campaign, seller, platform). Used to attribute promotional spend to originating programmes."
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Eligibility status of the promotion application (e.g. eligible, ineligible, pending). Used to monitor promotion eligibility compliance."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance check result for the promotion (e.g. compliant, flagged, rejected). Used to monitor regulatory and policy compliance of promotional activity."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the promotion is currently active. Used to filter active vs. expired promotions in performance analysis."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Flag indicating whether the promotion is exclusive (cannot be combined). Used to analyse exclusive vs. stackable promotion usage patterns."
    - name: "is_combination_allowed"
      expr: is_combination_allowed
      comment: "Flag indicating whether the promotion can be combined with others. Used to monitor stacking behaviour and associated margin risk."
    - name: "is_refunded"
      expr: is_refunded
      comment: "Flag indicating whether the promotion discount was refunded. Used to track promotional refund exposure and its impact on net discount cost."
    - name: "tax_exempt"
      expr: tax_exempt
      comment: "Flag indicating whether the promotion is tax-exempt. Used for tax compliance and promotional tax liability analysis."
    - name: "applied_month"
      expr: DATE_TRUNC('month', applied_timestamp)
      comment: "Month the promotion was applied. Primary time dimension for monthly promotional spend and campaign performance trending."
    - name: "start_date"
      expr: DATE_TRUNC('day', start_date)
      comment: "Start date of the promotion. Used to align promotional spend analysis with campaign launch timelines."
  measures:
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total gross discount value applied across all order promotions. The primary promotional spend KPI; used in marketing ROI and margin management reviews."
    - name: "total_net_discount_amount"
      expr: SUM(CAST(net_discount_amount AS DOUBLE))
      comment: "Total net discount value after refunds and adjustments. Measures the true cost of promotions to the business; used in campaign profitability analysis."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued on promotional discounts. Tracks promotional refund liability; used to assess the financial risk of refundable promotions."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per promotion application. Used to benchmark per-order promotional generosity and detect outlier discount events."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied across promotions. A key pricing health metric; used to monitor promotional depth and set discount guardrails."
    - name: "gross_to_net_discount_ratio"
      expr: ROUND(SUM(CAST(net_discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(discount_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of net discount to gross discount. Values below 1.0 indicate refund recovery on promotional spend; used to assess the net cost of promotional programmes."
    - name: "promotion_refund_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_refunded = TRUE THEN order_promotion_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of promotion applications that resulted in a refund. Measures promotional refund exposure; a high rate signals abuse or policy gaps requiring intervention."
    - name: "compliance_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'flagged' OR compliance_status = 'rejected' THEN order_promotion_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of promotion applications that failed compliance checks. Monitors promotional governance health; a rising rate triggers policy and system review."
    - name: "exclusive_promotion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_exclusive = TRUE THEN order_promotion_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of promotions that are exclusive (non-combinable). Used to monitor the mix of exclusive vs. stackable promotions and associated margin risk."
    - name: "distinct_promotion_codes_used"
      expr: COUNT(DISTINCT promotion_code)
      comment: "Number of unique promotion codes applied across orders. Measures promotional programme breadth and code proliferation; used in promotional governance reviews."
    - name: "distinct_orders_with_promotions"
      expr: COUNT(DISTINCT header_id)
      comment: "Number of distinct orders that had at least one promotion applied. Used to calculate order-level promotion penetration rate and assess promotional programme reach."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`order_fulfillment_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fulfilment allocation KPIs covering cost efficiency, SLA compliance, shipping cost, and allocation quality. These metrics steer fulfilment network optimisation, carrier selection, and SLA governance decisions."
  source: "`ecommerce_ecm`.`order`.`fulfillment_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the fulfilment allocation (e.g. pending, allocated, shipped, cancelled). Primary dimension for allocation pipeline health monitoring."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate the order to a fulfilment centre (e.g. nearest, cheapest, fastest). Used to analyse allocation strategy effectiveness and cost impact."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfilment type for the allocation (e.g. warehouse, drop-ship, cross-dock). Enables cost and speed comparison across fulfilment models."
    - name: "allocation_source"
      expr: allocation_source
      comment: "Source system or process that generated the allocation. Used to audit allocation origin and identify automation vs. manual allocation patterns."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for cost estimates. Supports multi-currency fulfilment cost analysis."
    - name: "is_expedited"
      expr: is_expedited
      comment: "Flag indicating whether the allocation is for an expedited order. Used to measure expedited fulfilment volume and associated cost premium."
    - name: "is_drop_ship"
      expr: is_drop_ship
      comment: "Flag indicating whether the allocation is a drop-ship. Tracks drop-ship volume and its cost and lead-time implications."
    - name: "is_eligible_for_fast_ship"
      expr: is_eligible_for_fast_ship
      comment: "Flag indicating whether the allocation is eligible for fast shipping. Used to measure fast-ship programme coverage and capacity."
    - name: "is_eligible_for_free_shipping"
      expr: is_eligible_for_free_shipping
      comment: "Flag indicating whether the allocation qualifies for free shipping. Tracks free-shipping programme exposure and associated cost."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Flag indicating whether the allocation breached its SLA. Primary dimension for SLA compliance analysis and breach root-cause investigation."
    - name: "is_backorder"
      expr: is_backorder
      comment: "Flag indicating whether the allocation involves a backordered item. Used to quantify backorder impact on fulfilment cost and lead time."
    - name: "priority_flag"
      expr: priority_flag
      comment: "Flag indicating whether the allocation has been marked as priority. Used to monitor priority allocation volume and associated resource consumption."
    - name: "estimated_ship_date"
      expr: DATE_TRUNC('day', estimated_ship_date)
      comment: "Estimated ship date for the allocation, truncated to day. Used for daily shipment volume forecasting and capacity planning."
    - name: "allocation_month"
      expr: DATE_TRUNC('month', allocation_timestamp)
      comment: "Month the allocation was created. Used for monthly fulfilment cost and SLA trend analysis."
  measures:
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Total estimated fulfilment cost across all allocations. The primary fulfilment cost KPI; used in cost-per-order analysis and fulfilment network optimisation decisions."
    - name: "total_shipping_cost_estimate"
      expr: SUM(CAST(shipping_cost_estimate AS DOUBLE))
      comment: "Total estimated shipping cost across all allocations. Measures carrier spend exposure; used in carrier rate negotiation and free-shipping programme cost modelling."
    - name: "total_tax_estimate"
      expr: SUM(CAST(tax_estimate AS DOUBLE))
      comment: "Total estimated tax on fulfilment allocations. Used for tax liability forecasting at the fulfilment level."
    - name: "avg_cost_per_allocation"
      expr: AVG(CAST(cost_estimate AS DOUBLE))
      comment: "Average estimated cost per fulfilment allocation. Benchmarks per-allocation fulfilment efficiency; used to track cost improvement over time and across fulfilment methods."
    - name: "avg_shipping_cost_per_allocation"
      expr: AVG(CAST(shipping_cost_estimate AS DOUBLE))
      comment: "Average estimated shipping cost per allocation. Used to monitor per-shipment carrier cost trends and evaluate shipping cost reduction initiatives."
    - name: "total_allocation_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of all fulfilment allocations in kilograms. Used by logistics to forecast carrier capacity requirements and negotiate weight-based rates."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN fulfillment_allocation_id END)
      comment: "Number of fulfilment allocations that breached their SLA. A critical operational KPI; directly tied to customer satisfaction and contractual SLA penalties."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN fulfillment_allocation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fulfilment allocations that breached SLA. The primary fulfilment SLA health KPI; a rising rate triggers network, carrier, and process reviews at the executive level."
    - name: "expedited_allocation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_expedited = TRUE THEN fulfillment_allocation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations that are expedited. Tracks premium fulfilment demand and associated cost premium; used in capacity and cost planning."
    - name: "drop_ship_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_drop_ship = TRUE THEN fulfillment_allocation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations fulfilled via drop-ship. Monitors drop-ship programme scale and its implications for lead time, cost, and quality control."
    - name: "free_shipping_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_eligible_for_free_shipping = TRUE THEN fulfillment_allocation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations eligible for free shipping. Measures free-shipping programme exposure; used to model the cost impact of free-shipping threshold changes."
    - name: "shipping_cost_as_pct_of_total_cost"
      expr: ROUND(100.0 * SUM(CAST(shipping_cost_estimate AS DOUBLE)) / NULLIF(SUM(CAST(total_estimated_cost AS DOUBLE)), 0), 2)
      comment: "Shipping cost as a percentage of total estimated fulfilment cost. Measures shipping cost intensity within the fulfilment cost structure; used to prioritise carrier optimisation efforts."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`order_tax`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order tax KPIs covering tax liability, effective tax rates, exemption patterns, and jurisdiction-level exposure. Tax metrics are essential for regulatory compliance, finance reporting, and tax engine accuracy validation."
  source: "`ecommerce_ecm`.`order`.`tax`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax applied (e.g. VAT, GST, sales tax, excise). Primary dimension for tax liability analysis by tax type."
    - name: "tax_status"
      expr: tax_status
      comment: "Current status of the tax record (e.g. calculated, applied, voided, refunded). Used to monitor tax record lifecycle and identify anomalies."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Tax jurisdiction code for the order tax record. Enables jurisdiction-level tax liability and compliance analysis."
    - name: "nexus_country"
      expr: nexus_country
      comment: "Country of tax nexus for the order. Used for country-level tax exposure and cross-border compliance reporting."
    - name: "nexus_state"
      expr: nexus_state
      comment: "State/province of tax nexus. Enables state-level tax liability analysis and nexus compliance monitoring."
    - name: "exempt_flag"
      expr: exempt_flag
      comment: "Flag indicating whether the tax record is exempt. Used to quantify tax exemption volume and validate exemption eligibility."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the tax record. Supports multi-currency tax liability reporting."
    - name: "calculation_date"
      expr: DATE_TRUNC('day', calculation_timestamp)
      comment: "Date the tax was calculated, truncated to day. Used for daily tax accrual and remittance timing analysis."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the tax record was created. Used for monthly tax liability trend and remittance forecasting."
  measures:
    - name: "total_tax_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total tax amount across all order tax records. The primary tax liability KPI; used in tax remittance forecasting and regulatory compliance reporting."
    - name: "total_taxable_amount"
      expr: SUM(CAST(taxable_amount AS DOUBLE))
      comment: "Total taxable base amount across all order tax records. Used to validate tax engine accuracy and compute effective tax rates."
    - name: "avg_tax_rate"
      expr: AVG(CAST(rate AS DOUBLE))
      comment: "Average tax rate applied across all order tax records. Used to monitor blended tax rate trends and validate tax engine configuration."
    - name: "effective_tax_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount AS DOUBLE)) / NULLIF(SUM(CAST(taxable_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate as a percentage of taxable amount. The primary tax accuracy KPI; deviations from expected rates trigger tax engine audits and jurisdiction reviews."
    - name: "tax_exempt_amount"
      expr: SUM(CASE WHEN exempt_flag = TRUE THEN CAST(taxable_amount AS DOUBLE) ELSE 0 END)
      comment: "Total taxable amount that was exempted from tax. Measures tax exemption exposure; used to validate exemption eligibility and quantify foregone tax revenue."
    - name: "tax_exemption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exempt_flag = TRUE THEN tax_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tax records that are exempt. Monitors exemption programme scale; a rising rate may signal eligibility abuse or misconfiguration requiring compliance review."
    - name: "distinct_jurisdictions"
      expr: COUNT(DISTINCT jurisdiction_code)
      comment: "Number of distinct tax jurisdictions with active tax records. Measures tax nexus breadth; used in compliance planning and tax registration obligation monitoring."
    - name: "distinct_taxed_orders"
      expr: COUNT(DISTINCT header_id)
      comment: "Number of distinct orders with tax records. Used to reconcile tax coverage against total order volume and identify orders missing tax calculations."
$$;