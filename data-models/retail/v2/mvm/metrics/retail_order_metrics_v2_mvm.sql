-- Metric views for domain: order | Business: Retail | Version: 2 | Generated on: 2026-06-24 00:42:49

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order-level KPIs derived from the order header. Covers revenue, order value, shipping economics, discount impact, and tax burden — the primary steering metrics for the order domain."
  source: "`vibe_retail_v1`.`order`.`header`"
  dimensions:
    - name: "order_channel"
      expr: channel
      comment: "Sales channel through which the order was placed (e.g., web, mobile, in-store, marketplace). Key segmentation dimension for omnichannel performance analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order (e.g., pending, confirmed, shipped, delivered, cancelled). Used to filter and segment order pipeline health."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g., standard, subscription, marketplace, B2B). Enables revenue mix analysis by order type."
    - name: "payment_method"
      expr: payment_method
      comment: "Primary payment method used for the order (e.g., credit card, PayPal, gift card). Informs payment mix and fraud risk segmentation."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the order (e.g., authorized, captured, refunded, failed). Critical for cash flow and revenue recognition monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the order. Required for multi-currency revenue reporting and FX normalization."
    - name: "shipping_country_code"
      expr: shipping_country_code
      comment: "Destination country for the order shipment. Enables geographic revenue and logistics analysis."
    - name: "shipping_state_province"
      expr: shipping_state_province
      comment: "Destination state or province for the order. Supports regional performance and tax jurisdiction analysis."
    - name: "order_date_day"
      expr: DATE_TRUNC('DAY', order_date)
      comment: "Order placement date truncated to day. Primary time dimension for daily order volume and revenue trending."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Order placement date truncated to month. Used for monthly revenue and order volume reporting."
    - name: "carrier_code"
      expr: carrier_code
      comment: "Carrier assigned to fulfill the order. Enables shipping cost and delivery performance analysis by carrier."
    - name: "promised_delivery_date"
      expr: promised_delivery_date
      comment: "Date the order was promised to be delivered. Used to measure on-time delivery performance against actuals."
    - name: "actual_delivery_date"
      expr: actual_delivery_date
      comment: "Actual date the order was delivered. Used alongside promised_delivery_date to compute delivery variance."
  measures:
    - name: "total_orders"
      expr: COUNT(DISTINCT header_id)
      comment: "Total number of distinct orders placed. The primary volume KPI for order throughput and demand measurement."
    - name: "total_gross_revenue"
      expr: SUM(CAST(grand_total_amount AS DOUBLE))
      comment: "Sum of grand total amounts across all orders. Represents gross revenue before any post-order adjustments. Core top-line revenue metric."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of order subtotals (pre-tax, pre-shipping). Used to isolate product revenue from shipping and tax components."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied across all orders. Measures promotional spend and markdown impact on revenue."
    - name: "total_shipping_revenue"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping charges collected from customers. Informs shipping monetization strategy and carrier cost coverage."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected across all orders. Required for tax compliance reporting and remittance calculations."
    - name: "avg_order_value"
      expr: AVG(CAST(grand_total_amount AS DOUBLE))
      comment: "Average grand total per order. A primary retail KPI used to track basket size trends and the impact of upsell and cross-sell strategies."
    - name: "avg_discount_per_order"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount applied per order. Measures promotional generosity and its relationship to order volume and margin."
    - name: "avg_shipping_per_order"
      expr: AVG(CAST(shipping_amount AS DOUBLE))
      comment: "Average shipping charge per order. Used to evaluate shipping pricing strategy and free-shipping threshold effectiveness."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of subtotal revenue. Measures promotional intensity and its drag on net revenue. A key margin management metric."
    - name: "shipping_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(shipping_amount AS DOUBLE)) / NULLIF(SUM(CAST(grand_total_amount AS DOUBLE)), 0), 2)
      comment: "Shipping revenue as a percentage of gross revenue. Indicates how much of total revenue is attributable to shipping charges — useful for free-shipping policy decisions."
    - name: "tax_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate as a percentage of subtotal. Used for tax burden analysis and jurisdiction-level compliance monitoring."
    - name: "late_delivery_orders"
      expr: COUNT(DISTINCT CASE WHEN actual_delivery_date > promised_delivery_date THEN header_id END)
      comment: "Number of orders delivered after the promised delivery date. A direct measure of fulfillment SLA compliance and customer experience risk."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actual_delivery_date <= promised_delivery_date THEN header_id END) / NULLIF(COUNT(DISTINCT CASE WHEN actual_delivery_date IS NOT NULL AND promised_delivery_date IS NOT NULL THEN header_id END), 0), 2)
      comment: "Percentage of orders delivered on or before the promised date. A critical customer satisfaction and logistics performance KPI tracked at executive level."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-item level KPIs for order fulfillment, product revenue, margin, and returns. Provides the granular product-level view needed for merchandising, supply chain, and profitability decisions."
  source: "`vibe_retail_v1`.`order`.`order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line (e.g., open, shipped, cancelled, returned). Used to segment active vs. closed line items for pipeline and fulfillment analysis."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Method used to fulfill the line item (e.g., ship-to-home, BOPIS, dropship). Key dimension for omnichannel fulfillment cost and performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the line item. Required for multi-currency revenue and margin reporting."
    - name: "carrier_code"
      expr: carrier_code
      comment: "Carrier assigned to ship the line item. Enables carrier-level performance and cost analysis."
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Indicates whether the line item is on backorder. Used to quantify backorder exposure and its revenue impact."
    - name: "gift_flag"
      expr: gift_flag
      comment: "Indicates whether the line item is a gift. Supports gift order segmentation for packaging and messaging decisions."
    - name: "substitution_flag"
      expr: substitution_flag
      comment: "Indicates whether the original SKU was substituted. Measures substitution frequency and its impact on customer satisfaction."
    - name: "cancellation_reason_code"
      expr: cancellation_reason_code
      comment: "Reason code for line-level cancellation. Enables root cause analysis of cancellations by reason category."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for line-level returns. Critical for product quality, sizing, and customer expectation management."
    - name: "actual_ship_date_month"
      expr: DATE_TRUNC('MONTH', actual_ship_date)
      comment: "Actual ship date truncated to month. Used for monthly shipment volume and revenue recognition trending."
    - name: "expected_ship_date_month"
      expr: DATE_TRUNC('MONTH', expected_ship_date)
      comment: "Expected ship date truncated to month. Used to compare planned vs. actual shipment timing for SLA analysis."
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction for the line item. Enables jurisdiction-level tax liability and compliance reporting."
  measures:
    - name: "total_order_lines"
      expr: COUNT(DISTINCT order_line_id)
      comment: "Total number of distinct order lines. Measures order line volume and product demand breadth."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total units ordered across all lines. Core demand volume metric used for inventory planning and sales forecasting."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total units shipped. Measures actual fulfillment output and is compared against ordered quantity to compute fill rate."
    - name: "total_returned_quantity"
      expr: SUM(CAST(returned_quantity AS DOUBLE))
      comment: "Total units returned. A key product quality and customer satisfaction metric that directly impacts net revenue."
    - name: "total_cancelled_quantity"
      expr: SUM(CAST(cancelled_quantity AS DOUBLE))
      comment: "Total units cancelled at the line level. Measures demand leakage and inventory planning accuracy."
    - name: "total_line_revenue"
      expr: SUM(CAST(total AS DOUBLE))
      comment: "Sum of line-level totals. Represents gross product revenue at the line level before order-level adjustments."
    - name: "total_extended_price"
      expr: SUM(CAST(extended_price AS DOUBLE))
      comment: "Sum of extended prices (unit price × quantity) across all lines. Used as the pre-discount revenue baseline for margin analysis."
    - name: "total_cost_of_goods_sold"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total cost of goods sold across all order lines. Core input for gross margin calculation and product profitability analysis."
    - name: "total_gross_margin"
      expr: SUM(CAST(margin_amount AS DOUBLE))
      comment: "Sum of margin amounts across all order lines. Direct measure of product-level profitability and a primary merchandising KPI."
    - name: "total_line_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount applied at the line level. Measures promotional and markdown spend at the product level."
    - name: "total_line_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at the line level. Used for jurisdiction-level tax compliance and remittance reporting."
    - name: "avg_unit_retail_price"
      expr: AVG(CAST(unit_retail_price AS DOUBLE))
      comment: "Average unit retail price across order lines. Tracks pricing trends and the impact of promotions on realized selling price."
    - name: "gross_margin_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(margin_amount AS DOUBLE)) / NULLIF(SUM(CAST(total AS DOUBLE)), 0), 2)
      comment: "Gross margin as a percentage of line revenue. The primary product profitability ratio used by merchandising and finance to evaluate category and SKU performance."
    - name: "return_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(returned_quantity AS DOUBLE)) / NULLIF(SUM(CAST(shipped_quantity AS DOUBLE)), 0), 2)
      comment: "Returned units as a percentage of shipped units. A critical product quality and customer satisfaction KPI. High return rates signal product-market fit issues or fulfillment errors."
    - name: "fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Shipped quantity as a percentage of ordered quantity. Measures fulfillment completeness and inventory availability. A key supply chain and customer experience KPI."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(cancelled_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Cancelled quantity as a percentage of ordered quantity. Measures demand leakage and is used to identify inventory, pricing, or operational issues driving cancellations."
    - name: "line_discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(extended_price AS DOUBLE)), 0), 2)
      comment: "Line-level discount as a percentage of extended price. Measures promotional intensity at the product level and its impact on realized margin."
    - name: "backorder_line_count"
      expr: COUNT(DISTINCT CASE WHEN backorder_flag = TRUE THEN order_line_id END)
      comment: "Number of order lines currently on backorder. Quantifies inventory availability gaps and their potential revenue and customer satisfaction impact."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_cancellation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cancellation-level KPIs measuring the volume, financial impact, and operational characteristics of order cancellations. Supports revenue leakage analysis, fraud detection, and refund management."
  source: "`vibe_retail_v1`.`order`.`cancellation`"
  dimensions:
    - name: "cancellation_status"
      expr: cancellation_status
      comment: "Current status of the cancellation request (e.g., pending, approved, rejected, completed). Used to track cancellation pipeline and approval bottlenecks."
    - name: "cancellation_channel"
      expr: channel
      comment: "Channel through which the cancellation was initiated (e.g., web, call center, store). Identifies which channels generate the most cancellation volume."
    - name: "initiator_type"
      expr: initiator_type
      comment: "Who initiated the cancellation (e.g., customer, merchant, system, fraud). Critical for root cause analysis and policy decisions."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the cancellation. Enables structured root cause analysis and trend monitoring by cancellation driver."
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to issue the refund (e.g., original payment, store credit, gift card). Informs refund policy and cash flow impact analysis."
    - name: "refund_currency_code"
      expr: refund_currency_code
      comment: "Currency in which the refund was issued. Required for multi-currency refund liability reporting."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Indicates whether the cancellation was flagged as potentially fraudulent. Used to segment fraud-driven cancellations for loss prevention analysis."
    - name: "refund_eligible_flag"
      expr: refund_eligible_flag
      comment: "Indicates whether the cancellation qualifies for a refund. Used to segment refundable vs. non-refundable cancellations for liability estimation."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Indicates whether the cancellation required manager or system approval. Used to measure approval workflow volume and bottlenecks."
    - name: "cancellation_timestamp_month"
      expr: DATE_TRUNC('MONTH', cancellation_timestamp)
      comment: "Cancellation timestamp truncated to month. Primary time dimension for monthly cancellation volume and refund liability trending."
    - name: "stage"
      expr: stage
      comment: "Order fulfillment stage at which the cancellation occurred (e.g., pre-shipment, in-transit, post-delivery). Determines operational complexity and cost of the cancellation."
  measures:
    - name: "total_cancellations"
      expr: COUNT(DISTINCT cancellation_id)
      comment: "Total number of distinct cancellation events. The primary volume KPI for cancellation rate monitoring and trend analysis."
    - name: "total_cancelled_amount"
      expr: SUM(CAST(cancelled_amount AS DOUBLE))
      comment: "Total monetary value of cancelled orders. Measures gross revenue leakage from cancellations — a critical top-line risk metric."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund value issued for cancellations. Measures cash outflow from cancellation refunds and its impact on net revenue."
    - name: "total_restocking_fee_revenue"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected on cancellations. Measures revenue recovery from cancellation fees and the effectiveness of restocking fee policies."
    - name: "total_cancellation_fee_revenue"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total cancellation fees charged. Measures fee revenue generated from cancellations and its offset against refund costs."
    - name: "avg_cancelled_amount"
      expr: AVG(CAST(cancelled_amount AS DOUBLE))
      comment: "Average cancelled order value. Used to understand the typical financial impact of a single cancellation event."
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount per cancellation. Tracks refund generosity and its relationship to cancellation policy settings."
    - name: "fraud_cancellation_count"
      expr: COUNT(DISTINCT CASE WHEN fraud_flag = TRUE THEN cancellation_id END)
      comment: "Number of cancellations flagged as fraudulent. A key loss prevention metric used to quantify fraud-driven revenue leakage."
    - name: "fraud_cancellation_amount"
      expr: SUM(CAST(CASE WHEN fraud_flag = TRUE THEN cancelled_amount ELSE 0 END AS DOUBLE))
      comment: "Total cancelled amount attributed to fraud-flagged cancellations. Measures the financial exposure from fraudulent cancellation activity."
    - name: "refund_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(restocking_fee_amount AS DOUBLE) + CAST(fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(refund_amount AS DOUBLE)), 0), 2)
      comment: "Fees collected as a percentage of refunds issued. Measures how effectively cancellation fees offset refund costs — a key policy effectiveness metric."
    - name: "fraud_cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN fraud_flag = TRUE THEN cancellation_id END) / NULLIF(COUNT(DISTINCT cancellation_id), 0), 2)
      comment: "Percentage of cancellations flagged as fraudulent. Tracks fraud exposure within the cancellation channel and triggers loss prevention escalation."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment-level KPIs covering authorization rates, fraud exposure, refund liability, and payment method mix. Supports finance, fraud operations, and payment strategy decisions."
  source: "`vibe_retail_v1`.`order`.`payment`"
  dimensions:
    - name: "payment_method_type"
      expr: method_type
      comment: "Type of payment method used (e.g., credit card, debit card, PayPal, BNPL, gift card). Primary dimension for payment mix analysis and acceptance cost benchmarking."
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., authorized, captured, settled, refunded, failed, voided). Used to monitor payment pipeline health and identify failure patterns."
    - name: "payment_channel"
      expr: channel
      comment: "Channel through which the payment was processed (e.g., web, mobile, in-store). Enables channel-level payment performance and fraud analysis."
    - name: "card_brand"
      expr: card_brand
      comment: "Card network brand (e.g., Visa, Mastercard, Amex, Discover). Used for interchange cost analysis and card brand performance benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the payment was processed. Required for multi-currency payment volume and settlement reporting."
    - name: "fraud_decision"
      expr: fraud_decision
      comment: "Fraud screening decision for the payment (e.g., approve, review, decline). Used to monitor fraud screening effectiveness and false positive rates."
    - name: "digital_wallet_type"
      expr: digital_wallet_type
      comment: "Digital wallet used for payment (e.g., Apple Pay, Google Pay, PayPal). Tracks digital wallet adoption and its impact on conversion and fraud rates."
    - name: "bnpl_provider"
      expr: bnpl_provider
      comment: "Buy Now Pay Later provider (e.g., Afterpay, Klarna, Affirm). Enables BNPL adoption tracking and provider-level performance comparison."
    - name: "authorization_timestamp_month"
      expr: DATE_TRUNC('MONTH', authorization_timestamp)
      comment: "Payment authorization timestamp truncated to month. Primary time dimension for monthly payment volume and authorization rate trending."
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country of the billing address. Used for geographic payment analysis and cross-border transaction monitoring."
  measures:
    - name: "total_payments"
      expr: COUNT(DISTINCT payment_id)
      comment: "Total number of distinct payment transactions. Measures payment processing volume and is the denominator for authorization and fraud rate calculations."
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total payment amount processed. Represents gross payment volume — a core financial operations and treasury metric."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued across all payments. Measures refund liability and its impact on net collected revenue."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction. Tracks transaction size trends and is used alongside order value metrics to assess payment completeness."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across payment transactions. Monitors overall fraud risk exposure and the effectiveness of fraud model calibration."
    - name: "high_fraud_risk_payments"
      expr: COUNT(DISTINCT CASE WHEN fraud_score >= 75 THEN payment_id END)
      comment: "Number of payments with a fraud score of 75 or above. Quantifies high-risk payment volume requiring manual review or automated intervention."
    - name: "refund_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(refund_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Refund amount as a percentage of total payment amount. Measures refund intensity and its drag on net revenue. A key financial health and customer satisfaction indicator."
    - name: "high_fraud_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN fraud_score >= 75 THEN payment_id END) / NULLIF(COUNT(DISTINCT payment_id), 0), 2)
      comment: "Percentage of payments flagged as high fraud risk. A critical loss prevention KPI used to calibrate fraud thresholds and assess exposure by channel and payment method."
    - name: "net_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE) - CAST(refund_amount AS DOUBLE))
      comment: "Net payment amount after deducting refunds. Represents actual cash collected and is the primary metric for net revenue reconciliation."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_pos_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-of-sale transaction KPIs covering in-store revenue, basket size, discount impact, loyalty engagement, and operational throughput. Primary metrics for store operations and in-store performance management."
  source: "`vibe_retail_v1`.`order`.`pos_transaction`"
  filter: transaction_status != 'VOIDED' OR transaction_status IS NULL
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of POS transaction (e.g., sale, return, exchange, void). Used to segment revenue-generating vs. reversal transactions."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the POS transaction (e.g., completed, voided, suspended). Used to filter valid transactions for revenue reporting."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment method for the POS transaction (e.g., take-away, ship-to-home, BOPIS). Enables omnichannel fulfillment mix analysis at the store level."
    - name: "primary_payment_method"
      expr: primary_payment_method
      comment: "Primary payment method used in the transaction. Tracks in-store payment method mix and cash vs. card trends."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used in the transaction. Required for multi-currency store revenue reporting."
    - name: "business_date_month"
      expr: DATE_TRUNC('MONTH', business_date)
      comment: "Business date of the transaction truncated to month. Primary time dimension for monthly store revenue and transaction volume reporting."
    - name: "business_date_day"
      expr: business_date
      comment: "Business date of the transaction. Used for daily store performance monitoring and same-store sales analysis."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for in-store returns. Enables structured analysis of return drivers at the store level."
    - name: "manager_override_flag"
      expr: manager_override_flag
      comment: "Indicates whether a manager override was applied to the transaction. Used to monitor exception handling frequency and potential policy compliance issues."
  measures:
    - name: "total_transactions"
      expr: COUNT(DISTINCT pos_transaction_id)
      comment: "Total number of distinct POS transactions. The primary in-store throughput metric used to measure store traffic conversion and operational capacity."
    - name: "total_pos_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total revenue from POS transactions. The primary in-store top-line revenue metric used for store performance ranking and comp-store analysis."
    - name: "total_pos_subtotal"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total pre-tax, pre-discount subtotal from POS transactions. Used to isolate product revenue from tax and discount components."
    - name: "total_pos_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount applied across POS transactions. Measures in-store promotional spend and markdown impact on store revenue."
    - name: "total_pos_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at POS. Required for store-level tax compliance and remittance reporting."
    - name: "total_units_sold"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total units sold across POS transactions. Measures in-store unit volume and is used for sell-through rate and inventory turn calculations."
    - name: "avg_transaction_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average transaction value at POS. The in-store equivalent of average order value — a primary basket size KPI for store performance management."
    - name: "avg_units_per_transaction"
      expr: AVG(CAST(total_quantity AS DOUBLE))
      comment: "Average number of units per POS transaction. Measures basket depth and the effectiveness of in-store upsell and cross-sell strategies."
    - name: "pos_discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "In-store discount as a percentage of subtotal. Measures promotional intensity at the store level and its impact on realized margin."
    - name: "manager_override_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN manager_override_flag = TRUE THEN pos_transaction_id END) / NULLIF(COUNT(DISTINCT pos_transaction_id), 0), 2)
      comment: "Percentage of transactions requiring a manager override. A store operations compliance metric — high rates may indicate policy gaps, training issues, or fraud risk."
    - name: "total_tender_amount"
      expr: SUM(CAST(tender_amount AS DOUBLE))
      comment: "Total tender amount collected at POS. Represents actual cash and payment collected, used for end-of-day reconciliation and cash management."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_pos_transaction_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "POS line-item KPIs for in-store product performance, markdown impact, return analysis, and category-level profitability. Supports merchandising, category management, and store operations decisions."
  source: "`vibe_retail_v1`.`order`.`pos_transaction_line`"
  filter: voided_flag = FALSE OR voided_flag IS NULL
  dimensions:
    - name: "category_code"
      expr: category_code
      comment: "Product category code for the line item. Primary dimension for category-level sales and margin analysis."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment method for the line item (e.g., take-away, ship-to-home). Enables omnichannel mix analysis at the product level."
    - name: "return_flag"
      expr: return_flag
      comment: "Indicates whether the line item is a return. Used to separate sales from returns for net revenue and return rate calculations."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return. Enables structured return root cause analysis at the product and category level."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Indicates whether the item is a private label product. Enables private label vs. national brand performance comparison — a key merchandising strategy metric."
    - name: "voided_flag"
      expr: voided_flag
      comment: "Indicates whether the line item was voided. Used to exclude voided lines from revenue calculations."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the line item. Used for tax category analysis and compliance reporting."
    - name: "scanned_timestamp_month"
      expr: DATE_TRUNC('MONTH', scanned_timestamp)
      comment: "Month the item was scanned at POS. Used for monthly product sales volume and revenue trending."
  measures:
    - name: "total_quantity_sold"
      expr: SUM(CAST(quantity_sold AS DOUBLE))
      comment: "Total units sold at POS. The primary in-store unit volume metric used for sell-through analysis and inventory replenishment decisions."
    - name: "total_net_line_revenue"
      expr: SUM(CAST(net_line_amount AS DOUBLE))
      comment: "Total net line revenue after discounts and markdowns. Represents actual realized revenue at the product level — the key metric for category profitability."
    - name: "total_line_revenue"
      expr: SUM(CAST(total_line_amount AS DOUBLE))
      comment: "Total gross line revenue before adjustments. Used as the pre-discount revenue baseline for markdown impact analysis."
    - name: "total_pos_line_cogs"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total cost of goods sold at the POS line level. Core input for in-store gross margin calculation by category and SKU."
    - name: "total_markdown_amount"
      expr: SUM(CAST(markdown_amount AS DOUBLE))
      comment: "Total markdown value applied at the POS line level. Measures markdown spend by category and its impact on realized margin."
    - name: "total_pos_line_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at the POS line level. Used for product-level tax liability and compliance reporting."
    - name: "avg_unit_retail_price"
      expr: AVG(CAST(unit_retail_price AS DOUBLE))
      comment: "Average unit retail price at POS. Tracks realized selling price trends and the impact of markdowns on average selling price."
    - name: "gross_margin_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(net_line_amount AS DOUBLE)) - SUM(CAST(cost_of_goods_sold AS DOUBLE))) / NULLIF(SUM(CAST(net_line_amount AS DOUBLE)), 0), 2)
      comment: "Gross margin as a percentage of net line revenue. The primary in-store product profitability ratio used by category managers and merchandising teams."
    - name: "markdown_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(markdown_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_line_amount AS DOUBLE)), 0), 2)
      comment: "Markdown amount as a percentage of gross line revenue. Measures markdown intensity by category and is a key input for pricing and clearance strategy decisions."
    - name: "return_line_count"
      expr: COUNT(DISTINCT CASE WHEN return_flag = TRUE THEN pos_transaction_line_id END)
      comment: "Number of POS line items that are returns. Used to quantify in-store return volume and its impact on net revenue."
    - name: "private_label_revenue"
      expr: SUM(CAST(CASE WHEN private_label_flag = TRUE THEN net_line_amount ELSE 0 END AS DOUBLE))
      comment: "Net revenue from private label products. Tracks private label penetration and its contribution to overall category revenue — a strategic merchandising KPI."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_discount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discount event KPIs measuring promotional effectiveness, discount type mix, approval workflow performance, and tax impact of discounts. Supports pricing, promotions, and finance decisions."
  source: "`vibe_retail_v1`.`order`.`discount`"
  dimensions:
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied (e.g., percentage, fixed amount, BOGO, loyalty). Primary dimension for promotional mix analysis."
    - name: "discount_channel"
      expr: channel
      comment: "Channel through which the discount was applied. Enables channel-level promotional spend analysis."
    - name: "applied_at_level"
      expr: applied_at_level
      comment: "Level at which the discount was applied (e.g., order, line, category). Used to understand discount architecture and its impact at different granularities."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the discount (e.g., auto-approved, pending, rejected). Used to monitor discount governance and exception rates."
    - name: "discount_method"
      expr: method
      comment: "Method by which the discount was applied (e.g., coupon, automatic, loyalty redemption). Tracks discount delivery mechanism mix."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the discount. Required for multi-currency promotional spend reporting."
    - name: "stackable_flag"
      expr: stackable_flag
      comment: "Indicates whether the discount can be stacked with other discounts. Used to analyze stacking behavior and its impact on total discount depth."
    - name: "tax_treatment_flag"
      expr: tax_treatment_flag
      comment: "Indicates whether the discount affects taxable amount. Used for tax compliance analysis of promotional discounts."
    - name: "applied_timestamp_month"
      expr: DATE_TRUNC('MONTH', applied_timestamp)
      comment: "Month the discount was applied. Primary time dimension for monthly promotional spend trending."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the discount. Enables structured analysis of discount drivers and policy compliance."
  measures:
    - name: "total_discount_events"
      expr: COUNT(DISTINCT discount_id)
      comment: "Total number of distinct discount events applied. Measures promotional activity volume and is the denominator for average discount calculations."
    - name: "total_discount_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total discount value applied across all discount events. The primary promotional spend metric used by finance and marketing to measure investment in promotions."
    - name: "total_taxable_amount_adjustment"
      expr: SUM(CAST(taxable_amount_adjustment AS DOUBLE))
      comment: "Total adjustment to taxable amount from discounts. Measures the tax liability impact of promotional discounts — critical for tax compliance reporting."
    - name: "avg_discount_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average discount value per discount event. Tracks typical discount depth and is used to benchmark promotional generosity across campaigns and channels."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average discount percentage applied. Measures typical promotional depth and is used to evaluate whether discount levels are driving incremental revenue."
    - name: "total_final_price"
      expr: SUM(CAST(final_price AS DOUBLE))
      comment: "Total final price after discounts. Represents net realized revenue after all promotional adjustments — used for net revenue reporting."
    - name: "total_original_price"
      expr: SUM(CAST(original_price AS DOUBLE))
      comment: "Total original price before discounts. Used as the full-price revenue baseline for calculating effective discount rates."
    - name: "effective_discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount AS DOUBLE)) / NULLIF(SUM(CAST(original_price AS DOUBLE)), 0), 2)
      comment: "Total discount as a percentage of original price. The primary promotional effectiveness metric — measures how deeply products are being discounted relative to full price."
    - name: "stackable_discount_amount"
      expr: SUM(CAST(CASE WHEN stackable_flag = TRUE THEN amount ELSE 0 END AS DOUBLE))
      comment: "Total discount value from stackable promotions. Measures the financial exposure from discount stacking — a key risk metric for margin management."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription KPIs covering recurring revenue, subscriber lifecycle, churn, and delivery performance. Supports subscription business strategy, retention management, and recurring revenue forecasting."
  source: "`vibe_retail_v1`.`order`.`subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current status of the subscription (e.g., active, paused, cancelled, expired). Primary dimension for subscriber lifecycle and churn analysis."
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type of subscription (e.g., replenishment, curated box, service). Enables revenue mix analysis by subscription model."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing frequency of the subscription (e.g., monthly, quarterly, annual). Used to segment recurring revenue by billing cadence."
    - name: "subscription_channel"
      expr: channel
      comment: "Channel through which the subscription was acquired. Enables channel-level subscriber acquisition and retention analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the subscription. Required for multi-currency recurring revenue reporting."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the subscription auto-renews. Used to segment auto-renewing vs. manual-renewal subscribers for churn risk analysis."
    - name: "gift_subscription_flag"
      expr: gift_subscription_flag
      comment: "Indicates whether the subscription is a gift. Enables gift subscription performance tracking and conversion-to-paid analysis."
    - name: "cancellation_reason_code"
      expr: cancellation_reason_code
      comment: "Reason code for subscription cancellation. Enables structured churn root cause analysis and retention intervention targeting."
    - name: "delivery_frequency"
      expr: delivery_frequency
      comment: "Frequency of subscription deliveries (e.g., weekly, bi-weekly, monthly). Used to segment subscribers by delivery cadence for logistics planning."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Subscription start date truncated to month. Used for cohort-based subscriber acquisition and retention analysis."
    - name: "cancellation_date_month"
      expr: DATE_TRUNC('MONTH', cancellation_date)
      comment: "Subscription cancellation date truncated to month. Used for monthly churn volume and revenue impact trending."
  measures:
    - name: "total_subscriptions"
      expr: COUNT(DISTINCT subscription_id)
      comment: "Total number of distinct subscriptions. The primary subscriber volume metric used to track subscription business scale and growth."
    - name: "active_subscriptions"
      expr: COUNT(DISTINCT CASE WHEN subscription_status = 'ACTIVE' THEN subscription_id END)
      comment: "Number of currently active subscriptions. The primary recurring revenue base metric — directly tied to MRR and ARR calculations."
    - name: "cancelled_subscriptions"
      expr: COUNT(DISTINCT CASE WHEN subscription_status = 'CANCELLED' THEN subscription_id END)
      comment: "Number of cancelled subscriptions. Measures churn volume and is the primary input for churn rate calculations."
    - name: "total_subscription_revenue"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total subscription revenue across all subscriptions. Represents gross recurring revenue — the top-line metric for subscription business performance."
    - name: "total_subscription_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount applied to subscriptions. Measures promotional investment in subscriber acquisition and retention."
    - name: "avg_subscription_value"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average subscription value. Tracks average revenue per subscriber and is used to evaluate pricing strategy and upsell effectiveness."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN subscription_status = 'CANCELLED' THEN subscription_id END) / NULLIF(COUNT(DISTINCT subscription_id), 0), 2)
      comment: "Percentage of subscriptions that have been cancelled. The primary churn rate metric for subscription business health monitoring — a critical executive KPI."
    - name: "auto_renewal_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN auto_renewal_flag = TRUE THEN subscription_id END) / NULLIF(COUNT(DISTINCT subscription_id), 0), 2)
      comment: "Percentage of subscriptions enrolled in auto-renewal. Measures subscriber commitment level and is a leading indicator of future retention and revenue predictability."
    - name: "paused_subscriptions"
      expr: COUNT(DISTINCT CASE WHEN subscription_status = 'PAUSED' THEN subscription_id END)
      comment: "Number of currently paused subscriptions. Measures at-risk subscribers who have not yet churned — a key retention intervention target."
    - name: "net_subscription_revenue"
      expr: SUM(CAST(amount AS DOUBLE) - CAST(discount_amount AS DOUBLE))
      comment: "Net subscription revenue after deducting subscription-level discounts. Represents actual recurring revenue collected and is the basis for MRR/ARR reporting."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_promise`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery promise KPIs measuring SLA compliance, promise accuracy, revision frequency, and fulfillment method performance. Supports customer experience, logistics, and operations decisions."
  source: "`vibe_retail_v1`.`order`.`promise`"
  dimensions:
    - name: "promise_status"
      expr: promise_status
      comment: "Current status of the delivery promise (e.g., active, fulfilled, breached, revised). Used to segment promises by lifecycle stage for SLA monitoring."
    - name: "promise_type"
      expr: promise_type
      comment: "Type of delivery promise (e.g., standard, expedited, same-day). Enables SLA performance analysis by promise tier."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Fulfillment method associated with the promise (e.g., ship-to-home, BOPIS, dropship). Key dimension for fulfillment method SLA benchmarking."
    - name: "order_channel"
      expr: order_channel
      comment: "Channel through which the order was placed. Enables channel-level promise accuracy and SLA compliance analysis."
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Carrier service level used for the promise (e.g., ground, 2-day, overnight). Used to benchmark SLA performance by carrier service tier."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the delivery promise SLA was breached. Primary flag for SLA compliance monitoring and breach root cause analysis."
    - name: "accuracy_flag"
      expr: accuracy_flag
      comment: "Indicates whether the delivery promise was accurate (delivered within promised window). Used to measure promise accuracy rate and model performance."
    - name: "peak_season_flag"
      expr: peak_season_flag
      comment: "Indicates whether the promise was made during peak season. Used to compare SLA performance during peak vs. non-peak periods."
    - name: "weather_impact_flag"
      expr: weather_impact_flag
      comment: "Indicates whether weather impacted the delivery promise. Used to isolate weather-driven SLA breaches from operational failures."
    - name: "promised_delivery_date_start_month"
      expr: DATE_TRUNC('MONTH', promised_delivery_date_start)
      comment: "Promised delivery start date truncated to month. Primary time dimension for monthly promise volume and SLA compliance trending."
    - name: "customer_notification_channel"
      expr: customer_notification_channel
      comment: "Channel used to notify the customer of the delivery promise (e.g., email, SMS, push). Used to analyze notification effectiveness and customer communication strategy."
  measures:
    - name: "total_promises"
      expr: COUNT(DISTINCT promise_id)
      comment: "Total number of delivery promises made. The primary volume metric for promise management and is the denominator for SLA compliance rate calculations."
    - name: "sla_breach_count"
      expr: COUNT(DISTINCT CASE WHEN sla_breach_flag = TRUE THEN promise_id END)
      comment: "Number of delivery promises that breached SLA. A critical customer experience and logistics performance metric — directly tied to customer satisfaction and NPS."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sla_breach_flag = FALSE OR sla_breach_flag IS NULL THEN promise_id END) / NULLIF(COUNT(DISTINCT promise_id), 0), 2)
      comment: "Percentage of delivery promises fulfilled within SLA. The primary logistics KPI for on-time delivery performance — tracked at executive and operational levels."
    - name: "promise_accuracy_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN accuracy_flag = TRUE THEN promise_id END) / NULLIF(COUNT(DISTINCT promise_id), 0), 2)
      comment: "Percentage of delivery promises that were accurate. Measures the reliability of the promise engine and its impact on customer trust and conversion."
    - name: "avg_delivery_variance_hours"
      expr: AVG(CAST(variance_hours AS DOUBLE))
      comment: "Average variance in hours between promised and actual delivery. Quantifies the typical delivery timing gap — a key logistics precision metric."
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average confidence score of delivery promises. Measures the promise engine's self-assessed reliability — used to calibrate model thresholds and identify low-confidence promise segments."
    - name: "revised_promise_count"
      expr: COUNT(DISTINCT CASE WHEN last_revision_timestamp IS NOT NULL THEN promise_id END)
      comment: "Number of promises that were revised after initial commitment. Measures promise instability and its potential impact on customer experience."
    - name: "peak_season_sla_breach_count"
      expr: COUNT(DISTINCT CASE WHEN sla_breach_flag = TRUE AND peak_season_flag = TRUE THEN promise_id END)
      comment: "Number of SLA breaches occurring during peak season. Isolates peak-season fulfillment stress and informs capacity planning and carrier contract negotiations."
    - name: "customer_notification_sent_count"
      expr: COUNT(DISTINCT CASE WHEN customer_notification_sent_flag = TRUE THEN promise_id END)
      comment: "Number of promises for which customer notifications were sent. Measures proactive communication coverage and its relationship to customer satisfaction outcomes."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_gift_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gift card program KPIs covering issuance, redemption, balance management, fraud exposure, and escheatment liability. Supports gift card program management, finance, and compliance decisions."
  source: "`vibe_retail_v1`.`order`.`gift_card`"
  dimensions:
    - name: "card_status"
      expr: card_status
      comment: "Current status of the gift card (e.g., active, redeemed, expired, blocked). Primary dimension for gift card lifecycle and liability analysis."
    - name: "card_type"
      expr: card_type
      comment: "Type of gift card (e.g., physical, digital, corporate). Enables gift card program mix analysis and channel-specific performance tracking."
    - name: "issuing_channel"
      expr: issuing_channel
      comment: "Channel through which the gift card was issued (e.g., in-store, online, corporate). Used to analyze gift card acquisition by channel."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the gift card. Required for multi-currency gift card liability reporting."
    - name: "reloadable_flag"
      expr: reloadable_flag
      comment: "Indicates whether the gift card can be reloaded. Used to segment reloadable vs. single-use cards for program design and revenue forecasting."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Indicates whether the gift card has been flagged for fraud. Used to quantify fraud exposure within the gift card program."
    - name: "escheatment_eligible_flag"
      expr: escheatment_eligible_flag
      comment: "Indicates whether the gift card balance is subject to escheatment. Used to estimate unclaimed property liability for regulatory compliance."
    - name: "program_code"
      expr: program_code
      comment: "Gift card program identifier. Enables program-level performance comparison and ROI analysis."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the gift card was issued. Primary time dimension for monthly gift card issuance volume and initial balance trending."
  measures:
    - name: "total_gift_cards_issued"
      expr: COUNT(DISTINCT gift_card_id)
      comment: "Total number of gift cards issued. The primary gift card program volume metric used to track program scale and growth."
    - name: "total_initial_balance"
      expr: SUM(CAST(initial_balance AS DOUBLE))
      comment: "Total initial balance loaded onto gift cards at issuance. Represents gross gift card revenue and deferred revenue liability at the time of sale."
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding balance across all active gift cards. Represents current deferred revenue liability — a critical balance sheet metric for finance."
    - name: "total_redeemed_amount"
      expr: SUM(CAST(total_redeemed_amount AS DOUBLE))
      comment: "Total amount redeemed across all gift cards. Measures gift card revenue recognition as redemptions occur."
    - name: "total_reloaded_amount"
      expr: SUM(CAST(total_reloaded_amount AS DOUBLE))
      comment: "Total amount reloaded onto reloadable gift cards. Measures reload program engagement and incremental gift card revenue."
    - name: "total_fees_charged"
      expr: SUM(CAST(total_fees_charged AS DOUBLE))
      comment: "Total fees charged on gift cards (e.g., inactivity fees, activation fees). Measures fee revenue from the gift card program."
    - name: "avg_initial_balance"
      expr: AVG(CAST(initial_balance AS DOUBLE))
      comment: "Average initial balance per gift card. Tracks typical gift card denomination and is used to forecast deferred revenue from new issuances."
    - name: "redemption_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_redeemed_amount AS DOUBLE)) / NULLIF(SUM(CAST(initial_balance AS DOUBLE)), 0), 2)
      comment: "Total redeemed amount as a percentage of total initial balance. Measures gift card utilization and breakage estimation — a key revenue recognition and liability management metric."
    - name: "breakage_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total unredeemed balance remaining on gift cards. Represents potential breakage revenue (unredeemed balances recognized as revenue per accounting policy) and escheatment liability."
    - name: "fraud_flagged_card_count"
      expr: COUNT(DISTINCT CASE WHEN fraud_flag = TRUE THEN gift_card_id END)
      comment: "Number of gift cards flagged for fraud. Measures fraud exposure within the gift card program and triggers loss prevention review."
    - name: "escheatment_eligible_balance"
      expr: SUM(CAST(CASE WHEN escheatment_eligible_flag = TRUE THEN current_balance ELSE 0 END AS DOUBLE))
      comment: "Total current balance on escheatment-eligible gift cards. Measures unclaimed property liability subject to state escheatment laws — a critical regulatory compliance metric."
$$;